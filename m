Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4D3BDF46
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFWLP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 18:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhGFWLP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 18:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D321161C3B;
        Tue,  6 Jul 2021 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625609316;
        bh=2L3Ocp8KQ9SS2sryL+eJl3QieYb1cDeo5ApMXvhPHXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sz6M7IIYPsbwSuPTSIJLMXmvvzbOc9NS1uFdD8ngAKjtR9A/gzmEsQH8etjMCZudz
         DzqMFZtKg0mnrg0Gz9XkFrS8ABQibuYXe/pRQSB4tO0NLRJXNUGzZMRl+puoZA+/qh
         D7V/k4pQ4XhKL4TXBykHmpLvARYulEkG2IWvxTRR8WDbUAHd2UGzYeJK3tIuIFIvco
         obMZq0betmBlWhkDZD5akVqC3ADile3LQqjHmYe4HiUMVMvB0nmjTwPuD1dhcVQubA
         sT9En35yZp0w7bok/yzxN4O3MwvwVEwRTADKOPrOazlMpZx0SjHopJULnwf40AL0fc
         1xcSYaDTj26PQ==
Date:   Wed, 7 Jul 2021 01:08:33 +0300
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
Subject: Re: [PATCH 1/4] x86/sgx: Add sgx_nr_all_pages to the debugfs
Message-ID: <20210706220833.d2o7ncbxs3sztaws@kernel.org>
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

My thinking is that it is better to use "kernel synthesized" value for the
EPC size, because kernel controls the EPC.

> I'd really appreciate if we could draw parallels between these additions
> to the "SGX VM" and their analogs in the "core VM".  In this case, I
> think the closest analog is probably "MemTotal" in /proc/meminfo.

Would make sense.

> Second, how is this going to be used?

SGX kselftest creates a heap, of which size is the same as the total size
of the EPC reported by the kernel.

> Third, is this going to be the ABI forever?

AFAIK, debugfs is not part of the ABI.

/Jarkko
