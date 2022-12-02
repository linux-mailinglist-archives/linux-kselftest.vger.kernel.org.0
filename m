Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA966410C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 23:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiLBWn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 17:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiLBWn5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 17:43:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAACF464A
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 14:43:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o12so6207293pjo.4
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 14:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIw6cuSEK90NH31AzQ1v2T7W5ZiOXTSu4ULwnQfkqVc=;
        b=kC0gZVYq27yEx2sH78OZLOAGSqTIlyl6SpBEpf5LadG6OUZ3p70QkSTVWxApijdSN6
         15qLeNAyjFSnWyaV+diHTC3IQSgx0Uyz++2QI69mkac4a0QCqQREgIr5EwhrobwoLoAv
         TAsCaWwd8wpZize+t/vesLq/JwhZRDvxyiX18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIw6cuSEK90NH31AzQ1v2T7W5ZiOXTSu4ULwnQfkqVc=;
        b=EVvcAlbti2nrevJcvr5CngCfQgG10DHySs3for8VqIRIjMiOvCqoQk/q9uepXzRlLp
         oFe3sa+sbVgEalYVyxN1eiqoRdl+c9Tx2MrglCvjxpQOudfpOwhZ2U6AD7cPIKEnbQWS
         KuR/GiuwkmTfr+cDQpfplX7eKBDodaN3Y1FEjhs5dK2xulKRUXAApIe/ltodyA8+shVC
         ecxLtBGUhP3lRIrOL2SAaDOPuhbltrtVKKl6Z39ya/3PTW4WOpNgThDNxDmP/RHgRFC7
         L8kbZk2PnFqpKxE7oM9WtUvQ5Ff/ThSZP2sEL9A77nmqM2Iz/2XaZ7JOV6OhYKQwYIqN
         kJ2Q==
X-Gm-Message-State: ANoB5pl3ZMTgBIPzTdj1N4cELo+zBs4HbD/dDRk78f6NiOpOnGmslAit
        U2dNSiLoJxQPPJctKAstvjthVg==
X-Google-Smtp-Source: AA0mqf4FHPfC3Xt/4K5UqFq2Exw5EJP5fAZMMa/RYHDJDthNxZmYvkMhAGg56BEB5/1STGolgNzlNw==
X-Received: by 2002:a17:903:3052:b0:189:63f2:d58b with SMTP id u18-20020a170903305200b0018963f2d58bmr40883166pla.158.1670021035890;
        Fri, 02 Dec 2022 14:43:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a2a8400b002137d3da760sm7050969pjd.39.2022.12.02.14.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:43:55 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:43:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: add F_SEAL_EXEC
Message-ID: <202212021443.0F684E33@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
 <20221202013404.163143-2-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-2-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:59AM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> The new F_SEAL_EXEC flag will prevent modification of the exec bits:
> written as traditional octal mask, 0111, or as named flags, S_IXUSR |
> S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
> any of these bits after the seal is applied will fail with errno EPERM.
> 
> This will preserve the execute bits as they are at the time of sealing,
> so the memfd will become either permanently executable or permanently
> un-executable.
> 
> Co-developed-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
>  include/uapi/linux/fcntl.h | 1 +
>  mm/memfd.c                 | 2 ++
>  mm/shmem.c                 | 6 ++++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 2f86b2ad6d7e..e8c07da58c9f 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -43,6 +43,7 @@
>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
> +#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
>  /* (1U << 31) is reserved for signed error codes */
>  
>  /*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 08f5f8304746..4ebeab94aa74 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -147,6 +147,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
>  }
>  
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
> +		     F_SEAL_EXEC | \
>  		     F_SEAL_SHRINK | \
>  		     F_SEAL_GROW | \
>  		     F_SEAL_WRITE | \
> @@ -175,6 +176,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>  	 *   SEAL_SHRINK: Prevent the file from shrinking
>  	 *   SEAL_GROW: Prevent the file from growing
>  	 *   SEAL_WRITE: Prevent write access to the file
> +	 *   SEAL_EXEC: Prevent modification of the exec bits in the file mode
>  	 *
>  	 * As we don't require any trust relationship between two parties, we
>  	 * must prevent seals from being removed. Therefore, sealing a file
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c1d8b8a1aa3b..e18a9cf9d937 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1085,6 +1085,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
>  	if (error)
>  		return error;
>  
> +	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
> +		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
> +			return -EPERM;
> +		}
> +	}
> +
>  	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
>  		loff_t oldsize = inode->i_size;
>  		loff_t newsize = attr->ia_size;
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

This looks sensible to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
