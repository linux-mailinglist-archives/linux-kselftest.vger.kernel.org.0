Return-Path: <linux-kselftest+bounces-13672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FC92FB6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0C71C22371
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDC16DEC3;
	Fri, 12 Jul 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e32V4pQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0815B13D;
	Fri, 12 Jul 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791110; cv=none; b=QjrWLcTauD03MiOItYBNH+ajSVi3JI6hEKFN0leI6Hd1nkBY8bfgKlM0O9iO0HScLPBFUXg9ih0zlo4coH7Uyi400EhyqwrXyOJllfY99GlNd88o6/hAou1U6uqNYSzI9L0GY15XQxZOmbXOez5+X54+X9YssYMxpeyXPJJyEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791110; c=relaxed/simple;
	bh=D90FayrMuFi+Snmtl8k2Ar9LAGpxPsM22fxKDhzoZTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYmLJEylpQYCOjg+fTsg5f7SzSlAtTXKGD1oj7N1rAw8MsdsU1u/JIgK/KGE/nGviUqB90fVbEXpKZqIsSg+MpPd7QvbFU/NFVADphCq/ypSkoNVRIR1AzG3CjthNey3E8IXbKGoHjHG/MBdYu1TKahOEu6xHFfxj8M5aCOvbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e32V4pQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D23C32786;
	Fri, 12 Jul 2024 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720791110;
	bh=D90FayrMuFi+Snmtl8k2Ar9LAGpxPsM22fxKDhzoZTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e32V4pQ2ih0Q0X18A50u8zXTdfXWPYCAqTYgi4ddBi7UnDNW9o+MM/qa/KsgMrnkz
	 vUYknoxNmihdjQa2IfK0rIzb1FJ3iV/XS/++9ZpG0D/zcBqH2nZXSbARpg3PBCbb56
	 xl2GDHpqvzS/qJ6cMrhhqEhkRa/SLW3hLK9g4EpWdbSTXq6hAalDLo01KmED/v0LH7
	 GPy+AUtXKtPrV+fTgbyhV9KB2XIrCwg71ZQiyHIuS25MlWZUtNDPB2NP7igK3EYHxz
	 HacvcYblqG8FYsJxRy1Ng4YZz4BaESZHql7Y0tvrDjklmAt4LfVYGQRyqjMKT1gG39
	 FhVR0Rt0IB+1g==
Date: Fri, 12 Jul 2024 14:31:41 +0100
From: Simon Horman <horms@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/20] lsm: Refactor return value of LSM hook
 inode_getsecurity
Message-ID: <20240712133141.GB120802@kernel.org>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
 <20240711111908.3817636-4-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711111908.3817636-4-xukuohai@huaweicloud.com>

On Thu, Jul 11, 2024 at 07:18:51PM +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> To be consistent with most LSM hooks, convert the return value of
> hook inode_getsecurity to 0 or a negative error code.
> 
> Before:
> - Hook inode_getsecurity returns size of buffer on success or a
>   negative error code on failure.
> 
> After:
> - Hook inode_getsecurity returns 0 on success or a negative error
>   code on failure. An output parameter @len is introduced to hold
>   the buffer size on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/xattr.c                    | 19 ++++++++++---------
>  include/linux/lsm_hook_defs.h |  3 ++-
>  include/linux/security.h      | 12 ++++++------
>  security/commoncap.c          |  9 ++++++---
>  security/security.c           | 11 ++++++-----
>  security/selinux/hooks.c      | 16 ++++++----------
>  security/smack/smack_lsm.c    | 14 +++++++-------
>  7 files changed, 43 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index f8b643f91a98..f4e3bedf7272 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -339,27 +339,28 @@ xattr_getsecurity(struct mnt_idmap *idmap, struct inode *inode,
>  		  const char *name, void *value, size_t size)
>  {
>  	void *buffer = NULL;
> -	ssize_t len;
> +	int error;
> +	u32 len;
>  
>  	if (!value || !size) {
> -		len = security_inode_getsecurity(idmap, inode, name,
> -						 &buffer, false);
> +		error = security_inode_getsecurity(idmap, inode, name,
> +						   false, &buffer, &len);
>  		goto out_noalloc;
>  	}
>  
> -	len = security_inode_getsecurity(idmap, inode, name, &buffer,
> -					 true);
> -	if (len < 0)
> -		return len;
> +	error = security_inode_getsecurity(idmap, inode, name, true,
> +					   &buffer, &len);
> +	if (error)
> +		return error;
>  	if (size < len) {
> -		len = -ERANGE;
> +		error = -ERANGE;
>  		goto out;
>  	}
>  	memcpy(value, buffer, len);
>  out:
>  	kfree(buffer);
>  out_noalloc:
> -	return len;
> +	return error < 0 ? error : len;

Hi Xu Kuohai,

len is an unsigned 32-bit entity, but the return type of this function
is an unsigned value (ssize_t). So in theory, if len is very large,
a negative error value error will be returned.

>  }

Similarly for the handling of nattr in lsm_get_self_attr in
lsm_syscalls.c in a subsequent patch.

Flagged by Smatch.

...

