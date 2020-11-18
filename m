Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98DF2B8302
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgKRRTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 12:19:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgKRRTH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 12:19:07 -0500
Received: from zn.tnic (p200300ec2f0caf000d6b904974eb4436.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:d6b:9049:74eb:4436])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2982F1EC043F;
        Wed, 18 Nov 2020 18:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605719946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i0gWrz5IPeQ3BVJ7uGNVkvqrsGQF5t90eEcSwZTrGOc=;
        b=X0vDhShHUffzercvHvcGuHBLTDRaVJD1lNmCwIKQH7eBtm0mbaJS3Z837awbWI7Mipz3cM
        w2/OdnnU08vJGLjML6zWrxstTQfTRU47reTnddV4ahYixhCqMpyuIkp3v9/qBFlEd19LrF
        KiVoxrBo7C2cYe+vSfE+taZcs6OmWiA=
Date:   Wed, 18 Nov 2020 18:19:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <20201118171900.GJ7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117223630.17355-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 12:36:30AM +0200, Jarkko Sakkinen wrote:
> Assign src_offset just to the p_offset, when first initialized.
> This has been probably copy-pasting accident (at least looks like
> it).
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  tools/testing/selftests/sgx/load.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 07988de6b767..64976f266bae 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -185,7 +185,7 @@ bool encl_load(const char *path, struct encl *encl)
>  		}
>  
>  		if (j == 0) {
> -			src_offset = (phdr->p_offset & PAGE_MASK) - src_offset;
> +			src_offset = (phdr->p_offset & PAGE_MASK);
>  
>  			seg->prot = PROT_READ | PROT_WRITE;
>  			seg->flags = SGX_PAGE_TYPE_TCS << 8;
> -- 

Folded in after removing the brackets and pushed the whole thing out.
Phew, finally!

From now on, only fixes ontop pls and testing tip:x86/sgx would be of
great help.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
