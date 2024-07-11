Return-Path: <linux-kselftest+bounces-13585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7B92E9FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C55A1C21F5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DC16078E;
	Thu, 11 Jul 2024 13:55:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AC4CE09;
	Thu, 11 Jul 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706118; cv=none; b=qKBX1IHyT4Mw5AJsWDEtZBrYKFGsr2n1G9NU5tBEPn7QdlLDupirI3gyhfgoaDJeXMaRcCx/hFoijmPqVuhtcebLyJpYZ9Vjv3fhcidFCP9BgTa7SBdlMfUESpnejaLlzcXAuUgOxLRDmTahFvlT9k2QsiVtP+F30K1P0cpDyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706118; c=relaxed/simple;
	bh=hUHD0gbLGOhQX2HghklicrHN2TvDU+Ja8sova+yDbZg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=O9YFzfT5TgOygXjm1PGewmFm8KslzWogZzSCGJ1bK8lgEZLSJznqvDBcFEApbJ9+Hqcw4lUNRp1SgbUX9JilhN5Z70zfCAOjeQNKRDRNd5JimVNAmdBu7hxU4t1xSES7iU91+Uc24dJUK+R5ZF1mS2j2yvdqeezbMKoMPrnNvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from dummy.faircode.eu (unknown [172.56.89.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id D174B99B;
	Thu, 11 Jul 2024 08:47:04 -0500 (CDT)
Date: Thu, 11 Jul 2024 08:46:51 -0500 (CDT)
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
Message-ID: <d1a7de68-1e36-42e6-bdc8-4046ea52338a@hallyn.com>
In-Reply-To: <20240711111908.3817636-2-xukuohai@huaweicloud.com>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com> <20240711111908.3817636-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 01/20] lsm: Refactor return value of LSM
 hook vm_enough_memory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d1a7de68-1e36-42e6-bdc8-4046ea52338a@hallyn.com>

Jul 11, 2024 06:14:08 Xu Kuohai <xukuohai@huaweicloud.com>:

> From: Xu Kuohai <xukuohai@huawei.com>
>
> To be consistent with most LSM hooks, convert the return value of
> hook vm_enough_memory to 0 or a negative error code.
>
> Before:
> - Hook vm_enough_memory returns 1 if permission is granted, 0 if not.
> - LSM_RET_DEFAULT(vm_enough_memory_mm) is 1.
>
> After:
> - Hook vm_enough_memory reutrns 0 if permission is granted, negative
> =C2=A0 error code if not.
> - LSM_RET_DEFAULT(vm_enough_memory_mm) is 0.

I haven't done a detailed review yet, but based on the description this is =
definitely a good change.=C2=A0 Thank you.

> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
> include/linux/lsm_hook_defs.h |=C2=A0 2 +-
> include/linux/security.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> security/commoncap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 +++--------
> security/security.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 11 +++++------
> security/selinux/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++---------=
--
> 5 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 44488b1ab9a9..e6e6f8473955 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
> LSM_HOOK(int, 0, syslog, int type)
> LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
> =C2=A0=C2=A0=C2=A0=C2=A0 const struct timezone *tz)
> -LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
> +LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
> LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
> LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const s=
truct file *file)
> LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index de3af33e6ff5..454f96307cb9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -634,7 +634,7 @@ static inline int security_settime64(const struct tim=
espec64 *ts,
>
> static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long=
 pages)
> {
> -=C2=A0=C2=A0 return __vm_enough_memory(mm, pages, cap_vm_enough_memory(m=
m, pages));
> +=C2=A0=C2=A0 return __vm_enough_memory(mm, pages, !cap_vm_enough_memory(=
mm, pages));
> }
>
> static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..cefad323a0b1 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1396,17 +1396,12 @@ int cap_task_prctl(int option, unsigned long arg2=
, unsigned long arg3,
> =C2=A0 * Determine whether the allocation of a new virtual mapping by the=
 current
> =C2=A0 * task is permitted.
> =C2=A0 *
> - * Return: 1 if permission is granted, 0 if not.
> + * Return: 0 if permission granted, negative error code if not.
> =C2=A0 */
> int cap_vm_enough_memory(struct mm_struct *mm, long pages)
> {
> -=C2=A0=C2=A0 int cap_sys_admin =3D 0;
> -
> -=C2=A0=C2=A0 if (cap_capable(current_cred(), &init_user_ns,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) =3D=3D 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_sys_admin =3D 1;
> -
> -=C2=A0=C2=A0 return cap_sys_admin;
> +=C2=A0=C2=A0 return cap_capable(current_cred(), &init_user_ns, CAP_SYS_A=
DMIN,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 CAP_OPT_NOAUDIT);
> }
>
> /**
> diff --git a/security/security.c b/security/security.c
> index e5ca08789f74..3475f0cab3da 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1115,15 +1115,14 @@ int security_vm_enough_memory_mm(struct mm_struct=
 *mm, long pages)
> =C2=A0=C2=A0=C2=A0 int rc;
>
> =C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0 * The module will respond with a positive value if
> -=C2=A0=C2=A0=C2=A0 * it thinks the __vm_enough_memory() call should be
> -=C2=A0=C2=A0=C2=A0 * made with the cap_sys_admin set. If all of the modu=
les
> -=C2=A0=C2=A0=C2=A0 * agree that it should be set it will. If any module
> -=C2=A0=C2=A0=C2=A0 * thinks it should not be set it won't.
> +=C2=A0=C2=A0=C2=A0 * The module will respond with 0 if it thinks the __v=
m_enough_memory()
> +=C2=A0=C2=A0=C2=A0 * call should be made with the cap_sys_admin set. If =
all of the modules
> +=C2=A0=C2=A0=C2=A0 * agree that it should be set it will. If any module =
thinks it should
> +=C2=A0=C2=A0=C2=A0 * not be set it won't.
> =C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0 hlist_for_each_entry(hp, &security_hook_heads.vm_enoug=
h_memory, list) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D hp->hook.vm_enough_memo=
ry(mm, pages);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc <=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_sy=
s_admin =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7eed331e90f0..9cd5a8f1f6a3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2202,23 +2202,16 @@ static int selinux_syslog(int type)
> }
>
> /*
> - * Check that a process has enough memory to allocate a new virtual
> - * mapping. 0 means there is enough memory for the allocation to
> - * succeed and -ENOMEM implies there is not.
> + * Check permission for allocating a new virtual mapping. Returns
> + * 0 if permission is granted, negative error code if not.
> =C2=A0 *
> =C2=A0 * Do not audit the selinux permission check, as this is applied to=
 all
> =C2=A0 * processes that allocate mappings.
> =C2=A0 */
> static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
> {
> -=C2=A0=C2=A0 int rc, cap_sys_admin =3D 0;
> -
> -=C2=A0=C2=A0 rc =3D cred_has_capability(current_cred(), CAP_SYS_ADMIN,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CAP_OPT_NOAUDIT, true);
> -=C2=A0=C2=A0 if (rc =3D=3D 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_sys_admin =3D 1;
> -
> -=C2=A0=C2=A0 return cap_sys_admin;
> +=C2=A0=C2=A0 return cred_has_capability(current_cred(), CAP_SYS_ADMIN,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CAP_OPT_NOAUDIT, true);
> }
>
> /* binprm security operations */
> --
> 2.30.2


