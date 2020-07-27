Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B222ED1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgG0NXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 09:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0NXh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 09:23:37 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206C62070A;
        Mon, 27 Jul 2020 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595856216;
        bh=p0/aR+7F/EhpgGtHoA2xxlJN+6ONhfFeG/VGIi12Y5k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vA3nhi2BjSC/lOBa5bRxZN6N7q6pt4FXD1yAUpm1nJWeVNeZVPZTszWkmyi4VUDMq
         kFOEenShmFSmH0HzDtGB8TrJ11XnsZxDCqiN1pnXo7w0Ww0XWPLeUNf0UEiZXwI+sL
         qTB0u37h/x/7Uh4mqPeVQNojXpxoXTNoCUSKv/KI=
Message-ID: <1595856214.4841.86.camel@kernel.org>
Subject: Re: [PATCH v3 15/19] IMA: Add support for file reads without
 contents
From:   Mimi Zohar <zohar@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 09:23:34 -0400
In-Reply-To: <20200724213640.389191-16-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-16-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> From: Scott Branden <scott.branden@broadcom.com>
> 
> When the kernel_read_file LSM hook is called with contents=false, IMA
> can appraise the file directly, without requiring a filled buffer. When
> such a buffer is available, though, IMA can continue to use it instead
> of forcing a double read here.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Link: https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broadcom.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

After adjusting the comment below.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/ima/ima_main.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index dc4f90660aa6..459e50526a12 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -613,11 +613,8 @@ void ima_post_path_mknod(struct dentry *dentry)
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  		  bool contents)
>  {
> -	/* Reject all partial reads during appraisal. */
> -	if (!contents) {
> -		if (ima_appraise & IMA_APPRAISE_ENFORCE)
> -			return -EACCES;
> -	}
> +	enum ima_hooks func;
> +	u32 secid;
>  
>  	/*
>  	 * Do devices using pre-allocated memory run the risk of the
> @@ -626,7 +623,20 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  	 * buffers? It may be desirable to include the buffer address
>  	 * in this API and walk all the dma_map_single() mappings to check.
>  	 */
> -	return 0;
> +
> +	/*
> +	 * There will be a call made to ima_post_read_file() with
> +	 * a filled buffer, so we don't need to perform an extra
> +	 * read early here.
> +	 */
> +	if (contents)
> +		return 0;
> +
> +	/* Read entire file for all partial reads during appraisal. */

In addition to verifying the file signature, the file might be
included in the IMA measurement list or the file hash may be used to
augment the audit record.  Please remove "during appraisal" from the
comment.

> +	func = read_idmap[read_id] ?: FILE_CHECK;
> +	security_task_getsecid(current, &secid);
> +	return process_measurement(file, current_cred(), secid, NULL,
> +				   0, MAY_READ, func);
>  }
>  
>  const int read_idmap[READING_MAX_ID] = {

