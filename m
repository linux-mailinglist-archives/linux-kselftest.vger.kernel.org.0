Return-Path: <linux-kselftest+bounces-13914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015D937241
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 04:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F292826A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 02:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097508F77;
	Fri, 19 Jul 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OlSs+VuE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239015E97
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354887; cv=none; b=Uf7kXAcMyiThabVAXNsX1iLIWYLqxBj1gPhzgiOubx9XUN+nIktxrkOVf2PbZe81cutCCn73BNH0M8TEtUN+uXIC9GUhuf361cjj4jtEly+3WVBZeIJFEKEO1sufUXeNWMSqX+pgXkzCK1ORZ5CWxb0IXPBvnae1vf3aHAXnpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354887; c=relaxed/simple;
	bh=tHah9heVhcAhz3UTqXvZmb4fO7IFjY752sIYX/h1Or8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=fPSf2TwROPnlliI900hqgmYPzedSKWftG7y1Y5+7B+7VTSjSOpXI6Y94R3/zMoCjh/d4Td8t924pxvTqfe4sxWhwA6XRrfz2w4MJKkNc7fEm5QYfZcLonGUTtd1Zl8XDsr6aIPTAVQZQs/zzkskH9WR/5ucBGSOFCTolqI9vpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OlSs+VuE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso10846226d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 19:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354884; x=1721959684; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHtJ6Mijr7Q+PTF9Q3B9HJtIQ/9fQHnqWj4Ntxohcz8=;
        b=OlSs+VuEMjRTKWZLa/6UqxDVnqTsune2S2XG05UD1d74p2asqlO+SVPEEtXnCesLAt
         xmEpyXQqTMo8ScZy0YY7l4cPg/fbaBj0skzB70kNku95YPGAfNzwv3UHcnhbGPoHsbc6
         NdO8MeNzIrH0tPONW5XyOfAIqc+ObIsgzEkQr3Hlqxdl/3x8VhaDavHfFxU2mvl4PmJg
         tZ2RM3R2CV/p/JkUz2o6w3HHZbq5A7by4tOdC+Pzuhxn/mcG3XFWUwb9v7PSUz3Venzk
         BMUfnomKr0bcIyOnJbOBEOXkuRHHQkzOTc6wvtTFfMcdQW5Zsydl2nbcOitQDWhkz+sF
         UiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354884; x=1721959684;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHtJ6Mijr7Q+PTF9Q3B9HJtIQ/9fQHnqWj4Ntxohcz8=;
        b=vqrikMNKJwAASo6OGFeSBGC0Pt90e5M/dYdE64d9VZT4W+IYEpNgvF0o9iw6EC1xy5
         g7zZqs7rJCd71BJ9wedC7jLj7oklbHtlVG8jdk3ypLbOMJ/VrDUuGp0TBSVDSpVNAezL
         9FvNkiAbERkBfQTXo/xXziOcADIhOX2XYglTqGTnBAD92UTrODFbXF/s+8Tii5CSYqnV
         yC/uE+sFP+9EKlwAChgBtRyJdkRGwg4KouuMf6g6jPidJEJDvRc7cjB/8jDrElqrC6Kj
         VJduaDuW0omo022NSEwQ4sPUzk+gMwEhc7o+YKG+Uk2zxU+TePxI7cLxvNaBhRlvtolz
         +Ofg==
X-Forwarded-Encrypted: i=1; AJvYcCVgOZNp9DP8lG/EYmH9vJwldKf/Q1ezWhuulpuCrq39Pa6jFrfbXv7F712Kyas5XJ2dVMgt2gHW/gDifFakym0gQmn0dwfW+e+KFgKZWlrJ
X-Gm-Message-State: AOJu0YwotSQ2IurkGotrbU79mFCoYBQMm/6P5hr7OLQI5HX7FRhX96Js
	G+/eJtSTIq+SVoCD0iDBT5vCfvzlaIDeiQdFovvsoUrtdlAnR7Zq/ldqo3wmpA==
X-Google-Smtp-Source: AGHT+IGaItPFvcgZZljCxKU0xByJbljxF1V3Ov2p9/nUOtgmOgXw/0Lj7cx8IF4ITmQkyVm1prBhSw==
X-Received: by 2002:a05:6214:4106:b0:6b0:90d8:b698 with SMTP id 6a1803df08f44-6b7ac9e8866mr6421386d6.45.1721354884374;
        Thu, 18 Jul 2024 19:08:04 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7bd5cbsm1786276d6.24.2024.07.18.19.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:03 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:03 -0400
Message-ID: <3a8d55e0d41a35a1a3c5d3590240d16b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 5/20] lsm: Refactor return value of LSM hook  inode_copy_up_xattr
References: <20240711111908.3817636-6-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-6-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook inode_copy_up_xattr to 0 or a negative error code.
> 
> Before:
> - Hook inode_copy_up_xattr returns 0 when accepting xattr, 1 when
>   discarding xattr, -EOPNOTSUPP if it does not know xattr, or any
>   other negative error code otherwise.
> 
> After:
> - Hook inode_copy_up_xattr returns 0 when accepting xattr, *-ECANCELED*
>   when discarding xattr, -EOPNOTSUPP if it does not know xattr, or
>   any other negative error code otherwise.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/overlayfs/copy_up.c            |  6 +++---
>  security/integrity/evm/evm_main.c |  2 +-
>  security/security.c               | 12 ++++++------
>  security/selinux/hooks.c          |  4 ++--
>  security/smack/smack_lsm.c        |  6 +++---
>  5 files changed, 15 insertions(+), 15 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 26eea8f4cd74..12215ca286af 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2675,18 +2675,18 @@ EXPORT_SYMBOL(security_inode_copy_up);
>   * lower layer to the union/overlay layer.   The caller is responsible for
>   * reading and writing the xattrs, this hook is merely a filter.
>   *
> - * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
> - *         if the security module does not know about attribute, or a negative
> - *         error code to abort the copy up.
> + * Return: Returns 0 to accept the xattr, -ECANCELED to discard the xattr,
> + *         -EOPNOTSUPP if the security module does not know about attribute,
> + *         or a negative error code to abort the copy up.
>   */
>  int security_inode_copy_up_xattr(struct dentry *src, const char *name)
>  {
>  	int rc;
>  
>  	/*
> -	 * The implementation can return 0 (accept the xattr), 1 (discard the
> -	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
> -	 * any other error code in case of an error.
> +	 * The implementation can return 0 (accept the xattr), -ECANCELED
> +	 * (discard the xattr), -EOPNOTSUPP if it does not know anything
> +	 *  about the xattr or any other error code in case of an error.
>  	 */

Updating the comment here is good, but considering that we also discuss
the return value in the function header comment, I think it might be
better to just remove this comment entirely and leave the function header
comment as the single source.  Duplicated comments/docs tend to fall out
of sync and create confusion.

>  	rc = call_int_hook(inode_copy_up_xattr, src, name);
>  	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))


--
paul-moore.com

