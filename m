Return-Path: <linux-kselftest+bounces-13587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A192EA73
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B616281C68
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9915FD01;
	Thu, 11 Jul 2024 14:16:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDD80BF8;
	Thu, 11 Jul 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707386; cv=none; b=S1Ol4vtW4U5CNKtAHZcrnQ9j9704KLuuMa0pT3SFPiNRjkouXFde9TdFtjNHdEC0YHhnqyDdNWvyjOPYWB1CBHEtvwIKw+NgisEMd6U9sVHUSVxHmSJ7mBU2rVC5SPt3PBLxpBrXINdauIoNG1uWb+tGZCPdbWeLe9J+h5GhL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707386; c=relaxed/simple;
	bh=u9ZPGa/Rq/UUrmz2WagOFmzqjUL+DHKleZd8UGjFxGw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Hzfd8yI2TmJvtYhTws3z+Cg1xQUMonTU+nVTlbFoCsWk4nyaynGNL66HSdeJUYjsGPyVFU3xMrk00Hts8EUEhdsIq54hLldZw3DTWF8BWBgG63c4G1Cz5Reb7PM144gWngtxxud7d3BGKcx5arYTrKSeeIFOCeyOBQQ3q0iNEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from dummy.faircode.eu (unknown [172.56.89.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id DD57227C;
	Thu, 11 Jul 2024 09:16:13 -0500 (CDT)
Date: Thu, 11 Jul 2024 09:15:59 -0500 (CDT)
From: Serge Hallyn <serge@hallyn.com>
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
	Anna Schumaker <anna@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <3b4cc9c0-2645-4654-aa48-7944d91ee3f4@hallyn.com>
In-Reply-To: <20240711111908.3817636-3-xukuohai@huaweicloud.com>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com> <20240711111908.3817636-3-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 02/20] lsm: Refactor return value of LSM
 hook inode_need_killpriv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3b4cc9c0-2645-4654-aa48-7944d91ee3f4@hallyn.com>

Jul 11, 2024 06:14:09 Xu Kuohai <xukuohai@huaweicloud.com>:

> From: Xu Kuohai <xukuohai@huawei.com>
>
> To be consistent with most LSM hooks, convert the return value of
> hook inode_need_killpriv to 0 or a negative error code.
>
> Before:
> - Both hook inode_need_killpriv and func security_inode_need_killpriv
> =C2=A0 return > 0 if security_inode_killpriv is required, 0 if not, and <=
 0
> =C2=A0 to abort the operation.
>
> After:
> - Both hook inode_need_killpriv and func security_inode_need_killpriv
> =C2=A0 return 0 on success and a negative error code on failure.
> =C2=A0 On success, hook inode_need_killpriv sets output param @need to tr=
ue
> =C2=A0 if security_inode_killpriv is required, and false if not. When @ne=
ed
> =C2=A0 is true, func security_inode_need_killpriv sets ATTR_KILL_PRIV fla=
g
> =C2=A0 in @attr; when false, it clears the flag.
> =C2=A0 On failure, @need and @attr remains unchanged.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

It looks ok - though unnecessary (I'm assuming a later patch works better w=
ith this) - , but I'd be more comfortable if it was documented that any cal=
lers of the need_killpriv hook must set need to false before calling. Or if=
 the hooks set need to false at start.


> ---
> fs/attr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++---
> fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +---
> include/linux/lsm_hook_defs.h |=C2=A0 2 +-
> include/linux/security.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++++++++++++=
+++----
> security/commoncap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 12 ++++++++----
> security/security.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 29 ++++++++++++++++++++++++-----
> 6 files changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 960a310581eb..aaadc721c982 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -427,11 +427,10 @@ int notify_change(struct mnt_idmap *idmap, struct d=
entry *dentry,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->ia_mtime =3D timestamp_t=
runcate(attr->ia_mtime, inode);
>
> =C2=A0=C2=A0=C2=A0 if (ia_valid & ATTR_KILL_PRIV) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D security_inode_need_killp=
riv(dentry);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D security_inode_need_killp=
riv(dentry, &ia_valid);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 error;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error =3D=3D 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ia_valid =
=3D attr->ia_valid &=3D ~ATTR_KILL_PRIV;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->ia_valid =3D ia_valid;
> =C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0 /*
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..cd335dc3a3bc 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2012,11 +2012,9 @@ int dentry_needs_remove_privs(struct mnt_idmap *id=
map,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>
> =C2=A0=C2=A0=C2=A0 mask =3D setattr_should_drop_suidgid(idmap, inode);
> -=C2=A0=C2=A0 ret =3D security_inode_need_killpriv(dentry);
> +=C2=A0=C2=A0 ret =3D security_inode_need_killpriv(dentry, &mask);
> =C2=A0=C2=A0=C2=A0 if (ret < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> -=C2=A0=C2=A0 if (ret)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D ATTR_KILL_PRIV;
> =C2=A0=C2=A0=C2=A0 return mask;
> }
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index e6e6f8473955..964849de424b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -165,7 +165,7 @@ LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *=
idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *acl_name)
> LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idm=
ap,
> =C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *acl_name)
> -LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
> +LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry, bool *need)
> LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry)
> LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 454f96307cb9..1614ef5b2dd2 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -161,7 +161,7 @@ int cap_inode_setxattr(struct dentry *dentry, const c=
har *name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const void *value, size_t size, int flags);
> int cap_inode_removexattr(struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct dentry *dentry, const char *name);
> -int cap_inode_need_killpriv(struct dentry *dentry);
> +int cap_inode_need_killpriv(struct dentry *dentry, bool *need);
> int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
> int cap_inode_getsecurity(struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct inode *inode, const char *name, void **buffer,
> @@ -389,7 +389,7 @@ int security_inode_listxattr(struct dentry *dentry);
> int security_inode_removexattr(struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *dentry, const char *nam=
e);
> void security_inode_post_removexattr(struct dentry *dentry, const char *n=
ame);
> -int security_inode_need_killpriv(struct dentry *dentry);
> +int security_inode_need_killpriv(struct dentry *dentry, int *attr);
> int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentr=
y);
> int security_inode_getsecurity(struct mnt_idmap *idmap,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode, const char *name,
> @@ -971,9 +971,21 @@ static inline void security_inode_post_removexattr(s=
truct dentry *dentry,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const char *name)
> { }
>
> -static inline int security_inode_need_killpriv(struct dentry *dentry)
> +static inline int security_inode_need_killpriv(struct dentry *dentry, in=
t *attr)
> {
> -=C2=A0=C2=A0 return cap_inode_need_killpriv(dentry);
> +=C2=A0=C2=A0 int rc;
> +=C2=A0=C2=A0 bool need =3D false;
> +
> +=C2=A0=C2=A0 rc =3D cap_inode_need_killpriv(dentry, &need);
> +=C2=A0=C2=A0 if (rc < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
> +
> +=C2=A0=C2=A0 if (need)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *attr |=3D ATTR_KILL_PRIV;
> +=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *attr &=3D ~ATTR_KILL_PRIV;
> +
> +=C2=A0=C2=A0 return 0;
> }
>
> static inline int security_inode_killpriv(struct mnt_idmap *idmap,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cefad323a0b1..17d6188d22cf 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -286,21 +286,25 @@ int cap_capset(struct cred *new,
> /**
> =C2=A0 * cap_inode_need_killpriv - Determine if inode change affects priv=
ileges
> =C2=A0 * @dentry: The inode/dentry in being changed with change marked AT=
TR_KILL_PRIV
> + * @need: If inode_killpriv() is needed
> =C2=A0 *
> =C2=A0 * Determine if an inode having a change applied that's marked ATTR=
_KILL_PRIV
> =C2=A0 * affects the security markings on that inode, and if it is, shoul=
d
> =C2=A0 * inode_killpriv() be invoked or the change rejected.
> =C2=A0 *
> - * Return: 1 if security.capability has a value, meaning inode_killpriv(=
)
> - * is required, 0 otherwise, meaning inode_killpriv() is not required.
> + * Return: Always returns 0. If security.capability has a value, meaning
> + * inode_killpriv() is required, @need is set to true.
> =C2=A0 */
> -int cap_inode_need_killpriv(struct dentry *dentry)
> +int cap_inode_need_killpriv(struct dentry *dentry, bool *need)
> {
> =C2=A0=C2=A0=C2=A0 struct inode *inode =3D d_backing_inode(dentry);
> =C2=A0=C2=A0=C2=A0 int error;
>
> =C2=A0=C2=A0=C2=A0 error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAP=
S, NULL, 0);
> -=C2=A0=C2=A0 return error > 0;
> +=C2=A0=C2=A0 if (error > 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *need =3D true;
> +
> +=C2=A0=C2=A0 return 0;
> }
>
> /**
> diff --git a/security/security.c b/security/security.c
> index 3475f0cab3da..a4abcd86eb36 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2490,17 +2490,36 @@ void security_inode_post_removexattr(struct dentr=
y *dentry, const char *name)
> /**
> =C2=A0 * security_inode_need_killpriv() - Check if security_inode_killpri=
v() required
> =C2=A0 * @dentry: associated dentry
> + * @attr: attribute flags
> =C2=A0 *
> =C2=A0 * Called when an inode has been changed to determine if
> =C2=A0 * security_inode_killpriv() should be called.
> =C2=A0 *
> - * Return: Return <0 on error to abort the inode change operation, retur=
n 0 if
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 security_inode_killpr=
iv() does not need to be called, return >0 if
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 security_inode_killpr=
iv() does need to be called.
> + * Return: Return 0 on success, negative error code on failure.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On success, set ATTR_=
KILL_PRIV flag in @attr when @need is true,
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clears it when false.
> =C2=A0 */
> -int security_inode_need_killpriv(struct dentry *dentry)
> +int security_inode_need_killpriv(struct dentry *dentry, int *attr)
> {
> -=C2=A0=C2=A0 return call_int_hook(inode_need_killpriv, dentry);
> +=C2=A0=C2=A0 int rc;
> +=C2=A0=C2=A0 bool need =3D false;
> +=C2=A0=C2=A0 struct security_hook_list *hp;
> +
> +=C2=A0=C2=A0 hlist_for_each_entry(hp, &security_hook_heads.inode_need_ki=
llpriv,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D hp->hook.inode_need_killpriv=
(dentry, &need);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (need)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 if (need)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *attr |=3D ATTR_KILL_PRIV;
> +=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *attr &=3D ~ATTR_KILL_PRIV;
> +
> +=C2=A0=C2=A0 return 0;
> }
>
> /**
> --
> 2.30.2


