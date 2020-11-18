Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE562B837A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 18:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKRR7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 12:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgKRR7A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 12:59:00 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F172463B;
        Wed, 18 Nov 2020 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605722339;
        bh=EH6POTFnKVGhKjHjh6s9J52foKX30yqbTuIswhOV8Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zq6KUMi86Y30xDS6xeoyRWjv0en+pTL1G3vuT72UPorEfbcK3miI+mQ23I6bNQ6T/
         /+rhSGxewqGHiJeW0vqCq6KsZ3RDlY4dKCS9ngpn6lMlezVmUffIUq+BYSkG0P/KHw
         3uNZHr7n8mAbhiy0L3PqgqI5nBUUAo+J1gNyUrww=
Date:   Wed, 18 Nov 2020 19:58:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-sgx@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
Message-ID: <20201118175850.GA42022@kernel.org>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118171900.GJ7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118171900.GJ7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 06:19:00PM +0100, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 12:36:30AM +0200, Jarkko Sakkinen wrote:
> > Assign src_offset just to the p_offset, when first initialized.
> > This has been probably copy-pasting accident (at least looks like
> > it).
> > 
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  tools/testing/selftests/sgx/load.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> > index 07988de6b767..64976f266bae 100644
> > --- a/tools/testing/selftests/sgx/load.c
> > +++ b/tools/testing/selftests/sgx/load.c
> > @@ -185,7 +185,7 @@ bool encl_load(const char *path, struct encl *encl)
> >  		}
> >  
> >  		if (j == 0) {
> > -			src_offset = (phdr->p_offset & PAGE_MASK) - src_offset;
> > +			src_offset = (phdr->p_offset & PAGE_MASK);
> >  
> >  			seg->prot = PROT_READ | PROT_WRITE;
> >  			seg->flags = SGX_PAGE_TYPE_TCS << 8;
> > -- 
> 
> Folded in after removing the brackets and pushed the whole thing out.
> Phew, finally!
> 
> From now on, only fixes ontop pls and testing tip:x86/sgx would be of
> great help.
> 
> Thx.

Duh, I sent the fix for the selftest before seeing this.

Thank you, I'll separately clone tip and test it.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
