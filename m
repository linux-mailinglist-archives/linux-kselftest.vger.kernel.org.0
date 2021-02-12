Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17A319E44
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Feb 2021 13:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhBLMW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Feb 2021 07:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhBLMU0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Feb 2021 07:20:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3E4064E2D;
        Fri, 12 Feb 2021 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613132382;
        bh=W5sUFSHz2G1CpMp3u/PNpRMKInmYA9DHy9F0Xh4Qi/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uliQ7ITQ7khrFMrul5UWtGReCQztr6YzMZSFQPlwFV556xDyZpjNOKf6PdKmcYGio
         t2Wesl1HZq8fwM818L2OIxiqAHNMFJKewdV/amZshENuuWwrch2jdc6SlRUba6D3tt
         TSsIW7NtrJkg2AmIuKd/nA7OwhzYiQD8kFmHqHxarVXLwUf4RGq/TDZiH6FXd4nY7h
         d5R+5BwaOLnxqN9um+/AFNvMN/ph3gOU5MXr1/sw2QPUgiXwRltVCGrb0hP7NOBm25
         RYLd5XK9XxpCfu7CvWaeEaVX29DvY5oZU1w+Cn6iujpo8Eel+JaQR00lpkgIDXGeuX
         QG+ZtAqZ02UgA==
Date:   Fri, 12 Feb 2021 14:19:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v3 3/5] x86/sgx: Optimize the free_cnt count in
 sgx_epc_section
Message-ID: <YCZyVXIeeYqNK+sy@kernel.org>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
 <20210124062907.88229-4-tianjia.zhang@linux.alibaba.com>
 <YBGlodsOaX4cWAtl@kernel.org>
 <abd77ee8-0311-1664-f3ee-6d4a9fe512b1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd77ee8-0311-1664-f3ee-6d4a9fe512b1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 11, 2021 at 02:04:12PM +0800, Tianjia Zhang wrote:
> Hi,
> 
> Sorry for the late reply.
> 
> On 1/28/21 1:40 AM, Jarkko Sakkinen wrote:
> > I could bet some money that this does not bring any significant
> > performance gain.
> > 
> 
> Yes, this does not bring performance gains. This is not a change for
> performance, mainly to make the value of free_cnt look more accurate.
> 
> > On Sun, Jan 24, 2021 at 02:29:05PM +0800, Tianjia Zhang wrote:
> > > `section->free_cnt` represents the free page in sgx_epc_section,
> > > which is assigned once after initialization. In fact, just after the
> > > initialization is completed, the pages are in the `init_laundry_list`
> > > list and cannot be allocated. This needs to be recovered by EREMOVE
> > > of function sgx_sanitize_section() before it can be used as a page
> > > that can be allocated. The sgx_sanitize_section() will be called in
> > > the kernel thread ksgxd.
> > > 
> > > This patch moves the initialization of `section->free_cnt` from the
> > > initialization function `sgx_setup_epc_section()` to the function
> > > `sgx_sanitize_section()`, and then accumulates the count after the
> > 
> > Use single quotes instead of hyphens.
> > >> successful execution of EREMOVE. This seems to be more reasonable,
> > > free_cnt will also truly reflect the allocatable free pages in EPC.
> > > 
> > > Sined-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >   arch/x86/kernel/cpu/sgx/main.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > > index 4465912174fd..e455ec7b3449 100644
> > > --- a/arch/x86/kernel/cpu/sgx/main.c
> > > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > > @@ -48,6 +48,7 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
> > >   		if (!ret) {
> > >   			spin_lock(&section->lock);
> > >   			list_move(&page->list, &section->page_list);
> > > +			section->free_cnt++;
> > >   			spin_unlock(&section->lock);
> > 
> > Someone can try to allocate a page while sanitize process is in progress.
> > 
> > I think it is better to keep critical sections in the form that when you
> > leave from one, the global state is legit.
> > 
> 
> Do you mean to move the critical section to protect the entire while loop?
> Of course, this is also possible, sanitize is a process only needed for
> initialization, and the possibility of conflict is very small.
> 
> Best regards,
> Tianjia

The big picture of this change to me, to be frank is that it's completely
useless.

Please start with the picture.

/Jarkko
