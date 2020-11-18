Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E821A2B7C21
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 12:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgKRLLb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 06:11:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgKRLLb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 06:11:31 -0500
Received: from zn.tnic (p200300ec2f0caf00530924e6be7c3eae.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:5309:24e6:be7c:3eae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0EADA1EC04B9;
        Wed, 18 Nov 2020 12:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605697890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=omui3Oucf/hagjkVPItdZEk4pcrzH2BfdDFrKFcZPtU=;
        b=qj0lHy5pG5ZKjPJL28lEk2fpYShd2ZJoJbbUSv7anf37/OLJ0/648v3SocJxFpQh1l98gQ
        jJ6iCDOWNVaBk/7QFNRYKyclpVeYneYQ8BRXWxsDmZlcDyUcsIvDFhpwRo5CgFzlPLRcDr
        ANXIfmC/HHADZLFzezz69wKl9Uz4+3c=
Date:   Wed, 18 Nov 2020 12:11:23 +0100
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
Message-ID: <20201118111123.GA7472@zn.tnic>
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

Still no joy:

0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
encl_load: encl->nr_segments: 3
encl_load: seg2 offset: 0x3000, seg2 size: 12288
encl_load: encl_size: 32768, src_size: 24576
encl_map_area: encl_size: 32768
encl_map_area: area: 0x0x7f7ec8dd8000
encl_map_area: encl_base: 0x7f7ec8dd8000
mapping segment 0, seg->prot: (read write )
base: 0x7f7ec8dd8000, offset 0x0, size: 8192
mapping segment 1, seg->prot: (read  exec)
base: 0x7f7ec8dd8000, offset 0x2000, size: 4096
mmap() failed, errno=1.
mmap: Operation not permitted

That second segment is PROT_EXEC and mmap(2) manpage says:

       EPERM  The prot argument asks for PROT_EXEC but the mapped  area  belongs  to  a
              file on a filesystem that was mounted no-exec.

       EPERM  The operation was prevented by a file seal; see fcntl(2).

I don't see fcntl() calls in the test and the fs I'm running it from is
not mapped "no-exec":

/dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)

so something else is missing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
