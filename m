Return-Path: <linux-kselftest+bounces-13911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C1937230
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 04:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304921C20C19
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 02:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73EEDF5C;
	Fri, 19 Jul 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cEbdi4nK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B858BE7
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354884; cv=none; b=gZ/d5H9N7MMRd+5O6jy+p+wb81xoQmA8BforytnzQ0oc1Rk5NlsWw2KQDjqX2YdZUhCGMpoR+YbBTZ5kK/gmlUdFKd6PkSl33/Xgq7idHti1NmVRydXJ6NE3s3mNykt6mGy47jnbSjtx3KrKMA96kpeBuqQtryQEcU9jOeUhbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354884; c=relaxed/simple;
	bh=TIiCRfwsESdbLtKgeaQrmG3fq3E7OOPlwiNVagskwcM=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=STKvJjppXXb1e6Vjz2d+flizxDGd9xNUp+DBzQNqb9XMqKZEQeolH39UyAT5+2e0lagHiuLRmhulrAsJPbWuwVIRkeni/DFDjRTc/gqBY84myOwPowvK3RV/kurQNr8tLaNG5EglBOoEfNxSyecwHW9joLwB4es+SApeBW2QLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cEbdi4nK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so1496310276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 19:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354881; x=1721959681; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QKuyM+4kk8m0EihN3f+xyfQVB73TFF9bKWS4LxZBLS0=;
        b=cEbdi4nKTdqf+e9wDjKGw0OKJBfI3a7o5TcpIRwkAetMvuGGg3Tpf7n3WjnUUqBSWv
         1tHQUCT9iz72cTMKAlLnCy7YtW+I6DPUsG3FEGwPwUk3AHQsP+xV7QLuwxRzVq7199gx
         8w8fgV/BGv3RMz8Fa8fifdZOULrboM3/CVcjNT3JI8a/NmrWx5f3gn7/svQjIO6uDztV
         1Tmg1DnFG4+8D0GTdHBUsKJvyt0ppIaRRjYCXAIbEOk3/1uZqVe3NDD6/pmF/w3IOY5i
         gRPyf7vGhIjWKOF04J0kCgMP8dmrrIf/IS8jNA6MdvyxzSgHRDkyPgjbx6ACPM9gAQf2
         YIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354881; x=1721959681;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKuyM+4kk8m0EihN3f+xyfQVB73TFF9bKWS4LxZBLS0=;
        b=HP48Oxxt7ACAmVZ5YUqv9oJIgzk0gmAT4G1NEf6u2yIOhHJLVja0H8fJfDOD1NJx03
         vsnV8af3R/n6HJ9TojAnRJwlXsu0X3Ts2R3tgzLNqg5f0N7pN6TNjmg56xwOEH0oc5DD
         VYXNSTrWRx6Ph2PjfPNZ0e9beeTJ86aSWmk7xVqPErpsZqYy6MXKIVeK82T9cDEd0i2t
         UagTtt0yQTfu8Os/QvLU/eRFzf6oCK6nN4602n8ugZDYHf1O2nv6cYHONSS1kZ1yWV31
         YFfnCCQ4xDCA+A0UCIrLx8amCQh5JnqDTfJzd4+zUb6HuHTS/HnaWIQs+qhsegezP94C
         i49g==
X-Forwarded-Encrypted: i=1; AJvYcCXNNuL4cfn9lDKM+LWz+wkuRWesgYwPZK4AWb4nj7vWGPzjZXDTDhcd2cyOqarkrHZaG+vxuzga3uYIP3SpenohrQdYnY0ntTCfDCp7Vas2
X-Gm-Message-State: AOJu0Yz94TjH92ye9wRRG/R/XDUN3wkubK9tFPV3QZly+ZQr8cEn/VaU
	L9RI8+bNvlgt4XMXrgBis8SJIxUCAl1gtbBLd/Rm9UCe5QkQw/xRBLQluFFJjQ==
X-Google-Smtp-Source: AGHT+IFhEnM0FFuvbGMDBqr4RfedhNiC4rUoTP3U8yQRjvYSpvaZNyWktchidi14cnppVOezDB7uag==
X-Received: by 2002:a05:6902:2082:b0:e03:a2d0:3387 with SMTP id 3f1490d57ef6-e05feb0e4f2mr5413750276.23.1721354881403;
        Thu, 18 Jul 2024 19:08:01 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905a8f3sm21057585a.80.2024.07.18.19.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:01 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:00 -0400
Message-ID: <1cc57fedd0b012874a031dc3d3d4a0fd@paul-moore.com>
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
Subject: Re: [PATCH v4 2/20] lsm: Refactor return value of LSM hook  inode_need_killpriv
References: <20240711111908.3817636-3-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-3-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook inode_need_killpriv to 0 or a negative error code.
> 
> Before:
> - Both hook inode_need_killpriv and func security_inode_need_killpriv
>   return > 0 if security_inode_killpriv is required, 0 if not, and < 0
>   to abort the operation.
> 
> After:
> - Both hook inode_need_killpriv and func security_inode_need_killpriv
>   return 0 on success and a negative error code on failure.
>   On success, hook inode_need_killpriv sets output param @need to true
>   if security_inode_killpriv is required, and false if not. When @need
>   is true, func security_inode_need_killpriv sets ATTR_KILL_PRIV flag
>   in @attr; when false, it clears the flag.
>   On failure, @need and @attr remains unchanged.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/attr.c                     |  5 ++---
>  fs/inode.c                    |  4 +---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      | 20 ++++++++++++++++----
>  security/commoncap.c          | 12 ++++++++----
>  security/security.c           | 29 ++++++++++++++++++++++++-----
>  6 files changed, 52 insertions(+), 20 deletions(-)

In general I think a lot of these changes are a good improvement, thank
you very much for the time and effort you've spent on this.  However,
I'm not in favor of passing the new hook parameter as a way of reducing
the number of states represented by the security_inode_killpriv() return
value.  This particular hook may need to remain as one of the odd special
cases.

> diff --git a/fs/attr.c b/fs/attr.c
> index 960a310581eb..aaadc721c982 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -427,11 +427,10 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
>  
>  	if (ia_valid & ATTR_KILL_PRIV) {
> -		error = security_inode_need_killpriv(dentry);
> +		error = security_inode_need_killpriv(dentry, &ia_valid);
>  		if (error < 0)
>  			return error;
> -		if (error == 0)
> -			ia_valid = attr->ia_valid &= ~ATTR_KILL_PRIV;
> +		attr->ia_valid = ia_valid;
>  	}
>  
>  	/*
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..cd335dc3a3bc 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2012,11 +2012,9 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
>  		return 0;
>  
>  	mask = setattr_should_drop_suidgid(idmap, inode);
> -	ret = security_inode_need_killpriv(dentry);
> +	ret = security_inode_need_killpriv(dentry, &mask);
>  	if (ret < 0)
>  		return ret;
> -	if (ret)
> -		mask |= ATTR_KILL_PRIV;
>  	return mask;
>  }
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index e6e6f8473955..964849de424b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -165,7 +165,7 @@ LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
> -LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
> +LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry, bool *need)
>  LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
>  	 struct dentry *dentry)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 454f96307cb9..1614ef5b2dd2 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -161,7 +161,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
>  		       const void *value, size_t size, int flags);
>  int cap_inode_removexattr(struct mnt_idmap *idmap,
>  			  struct dentry *dentry, const char *name);
> -int cap_inode_need_killpriv(struct dentry *dentry);
> +int cap_inode_need_killpriv(struct dentry *dentry, bool *need);
>  int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>  int cap_inode_getsecurity(struct mnt_idmap *idmap,
>  			  struct inode *inode, const char *name, void **buffer,
> @@ -389,7 +389,7 @@ int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
>  void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> -int security_inode_need_killpriv(struct dentry *dentry);
> +int security_inode_need_killpriv(struct dentry *dentry, int *attr);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
>  			       struct inode *inode, const char *name,
> @@ -971,9 +971,21 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
>  						   const char *name)
>  { }
>  
> -static inline int security_inode_need_killpriv(struct dentry *dentry)
> +static inline int security_inode_need_killpriv(struct dentry *dentry, int *attr)
>  {
> -	return cap_inode_need_killpriv(dentry);
> +	int rc;
> +	bool need = false;
> +
> +	rc = cap_inode_need_killpriv(dentry, &need);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (need)
> +		*attr |= ATTR_KILL_PRIV;
> +	else
> +		*attr &= ~ATTR_KILL_PRIV;
> +
> +	return 0;
>  }
>  
>  static inline int security_inode_killpriv(struct mnt_idmap *idmap,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cefad323a0b1..17d6188d22cf 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -286,21 +286,25 @@ int cap_capset(struct cred *new,
>  /**
>   * cap_inode_need_killpriv - Determine if inode change affects privileges
>   * @dentry: The inode/dentry in being changed with change marked ATTR_KILL_PRIV
> + * @need: If inode_killpriv() is needed
>   *
>   * Determine if an inode having a change applied that's marked ATTR_KILL_PRIV
>   * affects the security markings on that inode, and if it is, should
>   * inode_killpriv() be invoked or the change rejected.
>   *
> - * Return: 1 if security.capability has a value, meaning inode_killpriv()
> - * is required, 0 otherwise, meaning inode_killpriv() is not required.
> + * Return: Always returns 0. If security.capability has a value, meaning
> + * inode_killpriv() is required, @need is set to true.
>   */
> -int cap_inode_need_killpriv(struct dentry *dentry)
> +int cap_inode_need_killpriv(struct dentry *dentry, bool *need)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	int error;
>  
>  	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> -	return error > 0;
> +	if (error > 0)
> +		*need = true;
> +
> +	return 0;
>  }
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index 3475f0cab3da..a4abcd86eb36 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2490,17 +2490,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry
> + * @attr: attribute flags
>   *
>   * Called when an inode has been changed to determine if
>   * security_inode_killpriv() should be called.
>   *
> - * Return: Return <0 on error to abort the inode change operation, return 0 if
> - *         security_inode_killpriv() does not need to be called, return >0 if
> - *         security_inode_killpriv() does need to be called.
> + * Return: Return 0 on success, negative error code on failure.
> + *         On success, set ATTR_KILL_PRIV flag in @attr when @need is true,
> + *         clears it when false.
>   */
> -int security_inode_need_killpriv(struct dentry *dentry)
> +int security_inode_need_killpriv(struct dentry *dentry, int *attr)
>  {
> -	return call_int_hook(inode_need_killpriv, dentry);
> +	int rc;
> +	bool need = false;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_need_killpriv,
> +			     list) {
> +		rc = hp->hook.inode_need_killpriv(dentry, &need);
> +		if (rc < 0)
> +			return rc;
> +		if (need)
> +			break;
> +	}
> +
> +	if (need)
> +		*attr |= ATTR_KILL_PRIV;
> +	else
> +		*attr &= ~ATTR_KILL_PRIV;
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.30.2

--
paul-moore.com

