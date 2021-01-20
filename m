Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949B32FDD93
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jan 2021 01:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbhAUACY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 19:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390817AbhATW5T (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 17:57:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5B7D23440;
        Wed, 20 Jan 2021 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611182258;
        bh=oSG+9JCEDtoH01WuM1ed6gw+x9TEFGlrSLZLk8N5Ybk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIByYIeIuKNAFtQlyHLFL/UwxXXgBLrsA0lxr4nxA9/xUtV2fvg7qupq2S1zsyX6d
         xRgnRAEGfUIT3Q9A7xiluSiVhU5s/uLn4AcyCoLjVa161/VwzYx9j0cuPZr5+khX4v
         kpgSoMHZExxf4Wr0n9WH3v58G0WCR5ehd72f0bKbwCrCWqF6xGGLASnMF42+h4EKpf
         IjzpAh0hJKBkKBEJDb7qYIjUyObEK9Zgq1lEiBdVoZjC7940CBJVZezP83Dp6zU6Ok
         BflbD1LvOZcB2/tGPlRGTzfb3Q+nqrC7czIn/hO9Qr3biRBIOIj2HY9wt9ulHC58en
         fCMvn9aLkfTYA==
Date:   Thu, 21 Jan 2021 00:37:32 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, haitao.huang@intel.com,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] x86/sgx: Allows ioctl PROVISION to execute before CREATE
Message-ID: <YAiwrDrAsxHVowhV@kernel.org>
References: <20210118133335.98907-1-tianjia.zhang@linux.alibaba.com>
 <YAc7h3zQR06eWPhZ@google.com>
 <5037ee56-0211-f16c-3ea0-86cf8146b7f8@linux.alibaba.com>
 <YAiwA/oQkOVuTO+7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAiwA/oQkOVuTO+7@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 21, 2021 at 12:34:49AM +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 20, 2021 at 11:57:18AM +0800, Tianjia Zhang wrote:
> > Hi,
> > 
> > On 1/20/21 4:05 AM, Sean Christopherson wrote:
> > > On Mon, Jan 18, 2021, Tianjia Zhang wrote:
> > > > In function sgx_encl_create(), the logic of directly assigning
> > > > value to attributes_mask determines that the call to
> > > > SGX_IOC_ENCLAVE_PROVISION must be after the command of
> > > > SGX_IOC_ENCLAVE_CREATE. If change this assignment statement to
> > > > or operation, the PROVISION command can be executed earlier and
> > > > more flexibly.
> > > > 
> > > > Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > > ---
> > > >   arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> > > > index f45957c05f69..0ca3fc238bc2 100644
> > > > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > > > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > > > @@ -108,7 +108,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
> > > >   	encl->base = secs->base;
> > > >   	encl->size = secs->size;
> > > >   	encl->attributes = secs->attributes;
> > > > -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
> > > > +	encl->attributes_mask |= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
> > > 
> > > Alternatively, move the existing code to sgx_open()?  Initializing the field
> > > when the encl object is allocated feels more correct.
> > > 
> > 
> > 
> > This seems like a good idea. Thanks for your suggestion. I have sent v2
> > patch, include the next two patches.
> 
> Did you ask from Sean about suggested-by's? Now it looks like
> that doing these patches were originally proposed by Sean.

Please do not add tags from people *unauthentically*. I do not
see anything from Sean to any of the patches that would suggest
adding those tags. You are basically just stamping that to all
patches, which he has given a code review. Can you stop doing
this?

/Jarkko
