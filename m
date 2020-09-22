Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37A274945
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 21:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIVThE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIVThE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 15:37:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F1C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:37:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so1942639pji.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VoNsN4gNoyVIa9dngp5daYP4L9xdQNJFl/CtG0+h+Ss=;
        b=fEKFgp4I7N40Nzy6tgs8G5ZG/FVMRNy9LK/zAR9yCffVDCzwFkpclAKN7CrCo6SnuB
         Mhwrh3TYxcXCS86vuzMWkG/ZoaLgqPC1SYRA26QUSKPHIKKdhBrPaAHOqiC7zeUOIGtN
         6iW/8+otolDASDMvHpUoLjZbgqkXBbxL5oPHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VoNsN4gNoyVIa9dngp5daYP4L9xdQNJFl/CtG0+h+Ss=;
        b=JvxmugP/PDx/ngEHDcOlD4PF6Fnv1qMFuwqXBBT0bsi1qq8XYiwxkgXuq60v0iEsK7
         HnPsxtLNX2yF/F6uSr4r0rPqXaMrBh2jNPaBp19BIeOM8O7zTunuo0Oazp1mM5d+OOgf
         mVdMuV4MeLQlxR5uBLW6rdj/0heAW2EMZ7x1FitZXAOynFLbNiXW6b2Y8hpBgDLbjBD4
         WWF57nteiJLuOKbRCVqUvnBzHhhM2XiYmwE3yzXZn+0NhbTNAFStGARyKsQ+YQEv9Fwx
         TYH4a36slEbzyJRH1/lHLAJx2Ems/tsEL+wdgZoQcRZvdyGGdjX+8y1uLb2bKuSg8tnu
         vCvA==
X-Gm-Message-State: AOAM532/Edb9xtfuzNReWlliMN4MrT2rny8Ga5IrOFm6ivztgubLp/gz
        xUqrFzS309dTcgp5gsaInrmx4Q==
X-Google-Smtp-Source: ABdhPJwEqJBLbphcxoGt9HBYC6vR4ITJyo7LLBwP2ueoi8PvC6MRmbBII6r/yQBmxozFJ3zpnA7KNA==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr202994pjb.210.1600803423915;
        Tue, 22 Sep 2020 12:37:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6sm3319328pjw.0.2020.09.22.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:37:03 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:37:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 7/9] x86: Enable Syscall User Dispatch
Message-ID: <202009221236.04AA334C2@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-8-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:45PM -0400, Gabriel Krisman Bertazi wrote:
> Syscall User Dispatch requirements are fully supported in x86. This
> patch flips the switch, marking it as supported.  This was tested
> against Syscall User Dispatch selftest.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7101ac64bb20..56ac8de99021 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -150,6 +150,7 @@ config X86
>  	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_SYSCALL_USER_DISPATCH

Is this needed at all? I think simply "the architecture uses the generic
entry code" is sufficient to enable it. (Especially since there's a top
level config for SYSCALL_USER_DISPATCH, it feels like overkill).

-- 
Kees Cook
