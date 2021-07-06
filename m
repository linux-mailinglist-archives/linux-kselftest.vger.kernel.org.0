Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B133BDA57
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhGFPl4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 11:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhGFPl4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 11:41:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D213A61A46;
        Tue,  6 Jul 2021 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625585956;
        bh=C5TxgHCUYQtTJww8peg9FcreqZqhtW6SRaHn8e3V6C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgRXkAjuhq1sIVlATFBGyh4eVjNQp3T6DS7kumrou9plECr7EY38lMfhS8MQXeAHH
         Vuh2+69g5Id8P4HBnB+K5eTMb9Ef3wSr6W++W2J2OzdWdTIw6hekSIlYWsYKDrz/9A
         bfenmJkU0frmxzIyk0Ybbf/dCNgnVwiJohbU30+4=
Date:   Tue, 6 Jul 2021 17:39:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/sgx: Add sgx_nr_all_pages to the debugfs
Message-ID: <YOR5Ia4XnZhiDNQX@kroah.com>
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-2-jarkko@kernel.org>
 <b8a31e6e-90e8-f93f-e6b2-e72801fb31e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a31e6e-90e8-f93f-e6b2-e72801fb31e4@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 06, 2021 at 07:56:40AM -0700, Dave Hansen wrote:
> On 7/5/21 7:36 AM, Jarkko Sakkinen wrote:
> > Create /sys/kernel/debug/x86/sgx_nr_all_pages, which reports total
> > number of EPC pages available in the system.
> Could we flesh this out a bit, please?
> 
> What's the value here when userspace could just re-enumerate the EPC
> size from CPUID?
> 
> I'd really appreciate if we could draw parallels between these additions
> to the "SGX VM" and their analogs in the "core VM".  In this case, I
> think the closest analog is probably "MemTotal" in /proc/meminfo.
> 
> Second, how is this going to be used?
> 
> Third, is this going to be the ABI forever?

debugfs is never a stable abi.  If it is being used as such, then the
kernel code is wrong.  This better just be debugging stuff only.

thanks,

greg k-h
