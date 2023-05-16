Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A110705854
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 22:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEPUHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEPUHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 16:07:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C46EB1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 13:07:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so8587471b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267620; x=1686859620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QuCuVjhhcOO3Zea8Ojz72a0aDME+xDMZBjsMgaOVPM=;
        b=Xnhb742HBOFC+of4j29jqaBDFsMcnI2bBWd2I/rn2BPnPk+DXMds2VZTMFH3h+70b7
         qJlfias3tguctur3g0m0oImJ3aVRiO8XaNedAn6a5mMRBF2q+hwKHlNrmoz+tnv32Cxr
         tIShdQ3TA1x3sxS+Hq0LsMhE8Wa49Mq+bwx5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267620; x=1686859620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QuCuVjhhcOO3Zea8Ojz72a0aDME+xDMZBjsMgaOVPM=;
        b=V0CfayxvCOFMrdfd8RSBemH/EN/qkM+8WqmypLD3Sk38GdPy9ARkO1m/+YXgADnYl0
         x5QPXY66lxX6W6q2zzXKbPKjp4CehHbb+iMIvCp1dhHXZa8GFH0q477IYz1mBKJlFGGA
         kStSQ0A6aUrFQgi0+PCq622RH3MWqQqUrdyC72/Q8ZoZPg9JSUdxnzAX9DwCTjz9OTWq
         J3HxiXQ4oniJGUDpkz4B8W2rexH/zNVHzUukk/ZOaxfuk3OQRF/2+EobmOVclM0AmM4b
         WcagModyD+aMV6h23amXysw0uAFGpK4Ztw3rBsHxmZfb46N3YVcw1eP0k9+hKIHiH/0p
         Z9cA==
X-Gm-Message-State: AC+VfDy0EVewoH48GSQ/Bb0da0J+k4P08s0VEgn6f1QpDzTCoFjc4PJJ
        5HRjdk+VnsioQ865YuLWUHDWZg==
X-Google-Smtp-Source: ACHHUZ61o74nD4V5qCSGwRh6aCfStbDhEb2FBGoOYWddCCvlaJZ07qYwJhvr1vAOJVXOZ4rnCA8s2g==
X-Received: by 2002:a05:6a00:98a:b0:643:85a0:57fe with SMTP id u10-20020a056a00098a00b0064385a057femr59504516pfg.2.1684267620306;
        Tue, 16 May 2023 13:07:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fe25-20020a056a002f1900b0062dfe944c61sm13654396pfb.218.2023.05.16.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:06:59 -0700 (PDT)
Date:   Tue, 16 May 2023 13:06:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, jannh@google.com, sroettger@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/6] KEY: Apply PKEY_ENFORCE_API to munmap
Message-ID: <202305161302.16BF756DEA@keescook>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-6-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515130553.2311248-6-jeffxu@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 15, 2023 at 01:05:51PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> This patch enables PKEY_ENFORCE_API for the munmap
> syscall.
> 
> Signed-off-by: Jeff Xu<jeffxu@google.com>
> ---
>  include/linux/mm.h |  2 +-
>  mm/mmap.c          | 34 ++++++++++++++++++++++++++--------
>  mm/mremap.c        |  6 ++++--
>  3 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..48076e845d53 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3136,7 +3136,7 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
>  extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  			 unsigned long start, size_t len, struct list_head *uf,
> -			 bool downgrade);
> +			 bool downgrade, bool syscall);

For type checking and readability, I suggest using an enum instead of
"bool". Perhaps something like:

enum caller_origin {
	ON_BEHALF_OF_KERNEL = 0,
	ON_BEHALF_OF_USERSPACE,
};

 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
-			 bool downgrade);
+			 bool downgrade, enum caller_origin called);

>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
>  		     struct list_head *uf);
>  extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 13678edaa22c..29329aa794a6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2498,6 +2498,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   * @uf: The userfaultfd list_head
>   * @downgrade: set to true if the user wants to attempt to write_downgrade the
>   * mmap_lock
> + * @syscall: set to true if this is called from syscall entry
>   *
>   * This function takes a @mas that is either pointing to the previous VMA or set
>   * to MA_START and sets it up to remove the mapping(s).  The @len will be
> @@ -2507,7 +2508,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   */
>  int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  		  unsigned long start, size_t len, struct list_head *uf,
> -		  bool downgrade)
> +		  bool downgrade, bool syscall)
>  {
>  	unsigned long end;
>  	struct vm_area_struct *vma;
> @@ -2519,6 +2520,19 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (end == start)
>  		return -EINVAL;
>  
> +	/*
> +	 * When called by syscall from userspace, check if the calling
> +	 * thread has the PKEY permission to modify the memory mapping.
> +	 */
> +	if (syscall && arch_check_pkey_enforce_api(mm, start, end) < 0) {

	if (called == ON_BEHALF_OF_USERSPACE &&
	    arch_check_pkey_enforce_api(mm, start, end) < 0) {

> +		char comm[TASK_COMM_LEN];
> +
> +		pr_warn_ratelimited(
> +			"munmap was denied on PKEY_ENFORCE_API memory, pid=%d '%s'\n",
> +			task_pid_nr(current), get_task_comm(comm, current));
> +		return -EACCES;
> +	}
> +
>  	 /* arch_unmap() might do unmaps itself.  */
>  	arch_unmap(mm, start, end);
>  
> @@ -2541,7 +2555,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  {
>  	VMA_ITERATOR(vmi, mm, start);
>  
> -	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
> +	return do_vmi_munmap(&vmi, mm, start, len, uf, false, false);

+	return do_vmi_munmap(&vmi, mm, start, len, uf, false, ON_BEHALF_OF_KERNEL);

> [...]
>  SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
>  {
>  	addr = untagged_addr(addr);
> -	return __vm_munmap(addr, len, true);
> +	return __vm_munmap(addr, len, true, true);

+	return __vm_munmap(addr, len, true, ON_BEHALF_OF_USERSPACE);

etc.

-- 
Kees Cook
