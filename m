Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722153DB076
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 02:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhG3A7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 20:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhG3A7h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 20:59:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AB6760E09;
        Fri, 30 Jul 2021 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627606774;
        bh=8+euTn4InaeqMDkhh0bXAuD1Ybic5Zy4DtDSP99f8AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxFkZnL7XfdJg3BOkcIrvMx2qYOyoAttpNUrb96OgkH3vo0QBI3C4Ap/HykUcxRIv
         7SQXHUu+4/svVmiWoWI3ngWSN9SFgvlICFyIFhBVyucLuX4zGbjVO58jJcCCSsrFEu
         3bj2rd31NoCxwxLe+TWw+fkFtEfKoWC9SpB1rrAMqeYXi2HZFDyaXD4SDwKXbzSpnj
         P8nK+9+OHyDuvcSnk0bXQeAnqb78x8UjgvS5h7UNZH33+hvyUyKrNqhe+8DsUDjjgf
         rAAOftspQtou6gOxyT3sdrzxDHpo7LQPnVH9sSP4k4coyKTzfiI70sv97SL5F9+Wv2
         H5XXqlT4TllPw==
Date:   Fri, 30 Jul 2021 03:59:30 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
Message-ID: <20210730005930.ew3evpnnlqcjtf26@kernel.org>
References: <20210728225140.248408-1-jarkko@kernel.org>
 <20210728225140.248408-2-jarkko@kernel.org>
 <5d3614af-2393-6744-9d85-7001241ca76e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3614af-2393-6744-9d85-7001241ca76e@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 09:27:41AM -0700, Dave Hansen wrote:
> On 7/28/21 3:51 PM, Jarkko Sakkinen wrote:
> > Create /sys/kernel/debug/x86/sgx_total_mem, after the driver is
> > initialized, describing the total amount of SGX reserved memory (also known
> > as Enclave Page Cache (EPC)) available in the system.
> > 
> > This can be used to implement stress that trigger the page reclaimer, and
> > it is probably useful information when admistering a system running
> > enclaves anyhow.
> 
> How about this as a rewrite?
> 
> Just like normal memory, SGX memory can be overcommitted.  SGX has its
> own reclaim mechanism which kicks in when physical SGX memory (Enclave
> Page Cache / EPC) is exhausted.  That reclaim mechanism is relatively
> rarely exercised and needs selftests to poke at it.
> 
> The amount of EPC on the system is determined by the BIOS and it varies
> wildly between systems.  It can be dozens of MB on desktops, or many GB
> on servers.
> 
> To run in a reasonable amount of time, the selftest needs to know how
> much EPC there is in the system.
> 
> Introduce a new debugfs file to export that information.
> 
> > diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> > index dd0ac96ff9ef..15bb8f4e42af 100644
> > --- a/Documentation/x86/sgx.rst
> > +++ b/Documentation/x86/sgx.rst
> > @@ -250,3 +250,9 @@ user wants to deploy SGX applications both on the host and in guests
> >  on the same machine, the user should reserve enough EPC (by taking out
> >  total virtual EPC size of all SGX VMs from the physical EPC size) for
> >  host SGX applications so they can run with acceptable performance.
> > +
> > +SGX debugging
> > +=============
> > +
> > +*/sys/kernel/debug/x86/sgx_total_mem* describes the total available
> > +SGX mwemory available in the system.
> 
> 	^ memory
> 
> It would also be nice to say what the units are here, even if they are
> bytes.
> 
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > index 63d3de02bbcc..b65da19a53ee 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*  Copyright(c) 2016-20 Intel Corporation. */
> >  
> > +#include <linux/debugfs.h>
> >  #include <linux/file.h>
> >  #include <linux/freezer.h>
> >  #include <linux/highmem.h>
> > @@ -28,7 +29,10 @@ static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
> >  static LIST_HEAD(sgx_active_page_list);
> >  static DEFINE_SPINLOCK(sgx_reclaimer_lock);
> >  
> > -/* The free page list lock protected variables prepend the lock. */
> > +/* Total EPC memory available in bytes. */
> > +static unsigned long sgx_total_mem;
> > +
> > +/* The number of free EPC pages in all nodes. */
> >  static unsigned long sgx_nr_free_pages;
> >  
> >  /* Nodes with one or more EPC sections. */
> > @@ -656,6 +660,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
> >  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
> >  	}
> >  
> > +	sgx_total_mem += nr_pages * PAGE_SIZE;
> > +
> >  	return true;
> >  }
> >  
> > @@ -823,6 +829,8 @@ static int __init sgx_init(void)
> >  	if (sgx_vepc_init() && ret)
> >  		goto err_provision;
> >  
> > +	debugfs_create_ulong("sgx_total_mem", 0444, arch_debugfs_dir, &sgx_total_mem);
> > +
> >  	return 0;
> >  
> >  err_provision:
> > 
> 
> Assuming the new changelog is adopted and typos fixed:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks, I'll commit these changes and include to the next version.

/Jarkko
