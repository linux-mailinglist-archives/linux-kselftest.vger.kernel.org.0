Return-Path: <linux-kselftest+bounces-11513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB0901762
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EC91F21266
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453DC4D599;
	Sun,  9 Jun 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Or7xWhT1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052181E526
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Jun 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957083; cv=none; b=Qp2W0l4UeYXsTrme6OGeW8XKnjnpkCDmQyJa6lQ7VuEXOyKx/6sf3Zguu/I1TA5l1hBkUProf8MZ8VS/Waw7Sbma+nixagKW0szMpqQ4s69s2HP48qbFiNVS0sLil5r4uvo4TvLB61ItxP09nZ3lTKi+4FF3oiGxP0PxJ1JGbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957083; c=relaxed/simple;
	bh=X55LatrF7lvine1wfeeIWb35njHKNztVnss/n9y+HT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESGOZqvpMXviM6ht6IthRPCh1Saf8qCF7h2XkylUmYnbmA2d6HjMRHQW125KfjsUGU9kmLNw4wq8CTloWvri/xEN/GvfDUydUK0yKZZSQ9yVSs2EZcxDN/xzriAas55JEKcuPeoKCPcKYlJbWjs6LtSa/HTgBn41cRQin8yTJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Or7xWhT1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a08b250a2so34698537b3.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717957079; x=1718561879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRnjcHDnfUUWSedC6UPSlPmw0hXWeHjZ2LgT3kdmxEs=;
        b=Or7xWhT1L5obHvBFqPVxOmKkXHmVgJKKXUwj1ewxNUD9i74PoOmdaTl+sKLIjv549m
         PqE4U0Bm57innElfkDVhxTT5Ta+J1A9d9ttpWbtJ514RT9GuxdlWHGf8UD1j5gaDPs5w
         FNp4v0GTKxsYXye9zFFSEESUe8wy9e3ofwv2xpVK/FHYc/a/EySmGCmZ3nZaDLQJDHdR
         NGeAu1ZX26Ma1cmb6I53dkFyXjJV/LYuRDIAewE4BfubsCX2ozemf7aXRKepX86kepPp
         gxYjvm3Ul+Aw04sA5aamucwrl1fVVUHMiFeBPWIlskw1aNdXD9C0IL+kah6+JJX5V+39
         MiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957079; x=1718561879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRnjcHDnfUUWSedC6UPSlPmw0hXWeHjZ2LgT3kdmxEs=;
        b=mQ8zw5WS+w4Llw4lHZ5a/s6cpwYVdM70v3Kgk5utorvggzaR09T/rzNEXMssCVsqQK
         RJw8j+427xLg2LL2VWeBbhJxsYeMjgysSi87i1gzLo4tsn518WFimqAsx8JMEC2CaOyF
         HtLoLk5sbKha2bFH3+3CrxSV+psyqGOw2r3YcivMDc6BfoDT+ryPmbYIuq64FUnsZYZT
         5uIy6BXYTgRfowTxqKDCP6KfPvLjhWBNIGgQLlCvMkoq2I4fbp6uJeizhoTqhFZjip72
         h7QBGp08KWKPNO3jjPQ3ym7Ww6djREGKzfNSsyN23r692RTCQ17xYq0RySEYJbaj+3MN
         DSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpprz9bKp0XdTO7deFDpG1B/+sHsexFFl3b/c+92xryH9oDCTNrFBmFImgcFUvng3wAcLJZOo1Dz9e4qwgDOpFI3/qfSX5IMRbCjJHgCav
X-Gm-Message-State: AOJu0Yxq7hGnNm/09L7Bi1D4O51OldjK+g1OSuPD+EvFOehzFAzNDEHB
	ecpnBMhsR3C3Kf9hdzLf/q+JRc5HfSgKHIRKPfpghVDenbqD2lwGxfcMsTGMsiV9FBGD2segziu
	F7ZmpXjBX+kxe8spYzZzBIzqENENiem8rkAhl
X-Google-Smtp-Source: AGHT+IEyzvmGOs9XjT3k7MrlvW/EocTlySBeSBNcxienTHGSNtoBSEmGziQiL7XZU5YCYB4GYQhXjHwIyTCyMd7fvp4=
X-Received: by 2002:a0d:d5c4:0:b0:62c:f772:2af4 with SMTP id
 00721157ae682-62cf7722bafmr21708217b3.8.1717957078225; Sun, 09 Jun 2024
 11:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-2-xukuohai@huaweicloud.com> <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
 <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com> <CAADnVQJfU-qMYHGSggfPwmpSy+QrCvQHPrxmei=UU6zzR2R+Sw@mail.gmail.com>
 <571e5244-367e-45a0-8147-1acbd5a1de6f@schaufler-ca.com>
In-Reply-To: <571e5244-367e-45a0-8147-1acbd5a1de6f@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 9 Jun 2024 14:17:47 -0400
Message-ID: <CAHC9VhQ_sTmoXwQ_AVfjTYQe4KR-uTnksPVfsei5JZ+VDJBQkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 1:39=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 6/8/2024 6:54 AM, Alexei Starovoitov wrote:
> > On Sat, Jun 8, 2024 at 1:04=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.=
com> wrote:
> >> On 6/7/2024 5:53 AM, Paul Moore wrote:
> >>> On Thu, Apr 11, 2024 at 8:24=E2=80=AFAM Xu Kuohai <xukuohai@huaweiclo=
ud.com> wrote:
> >>>> From: Xu Kuohai <xukuohai@huawei.com>
> >>>>
> >>>> Add macro LSM_RET_INT to annotate lsm hook return integer type and t=
he
> >>>> default return value, and the expected return range.
> >>>>
> >>>> The LSM_RET_INT is declared as:
> >>>>
> >>>> LSM_RET_INT(defval, min, max)
> >>>>
> >>>> where
> >>>>
> >>>> - defval is the default return value
> >>>>
> >>>> - min and max indicate the expected return range is [min, max]
> >>>>
> >>>> The return value range for each lsm hook is taken from the descripti=
on
> >>>> in security/security.c.
> >>>>
> >>>> The expanded result of LSM_RET_INT is not changed, and the compiled
> >>>> product is not changed.
> >>>>
> >>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >>>> ---
> >>>>   include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-------------=
----
> >>>>   include/linux/lsm_hooks.h     |   6 -
> >>>>   kernel/bpf/bpf_lsm.c          |  10 +
> >>>>   security/security.c           |   1 +
> >>>>   4 files changed, 313 insertions(+), 295 deletions(-)
> >>> ...
> >>>
> >>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_=
defs.h
> >>>> index 334e00efbde4..708f515ffbf3 100644
> >>>> --- a/include/linux/lsm_hook_defs.h
> >>>> +++ b/include/linux/lsm_hook_defs.h
> >>>> @@ -18,435 +18,448 @@
> >>>>    * The macro LSM_HOOK is used to define the data structures requir=
ed by
> >>>>    * the LSM framework using the pattern:
> >>>>    *
> >>>> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args..=
.)
> >>>> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, a=
rgs...)
> >>>>    *
> >>>>    * struct security_hook_heads {
> >>>> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NA=
ME;
> >>>> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_hea=
d NAME;
> >>>>    *   #include <linux/lsm_hook_defs.h>
> >>>>    *   #undef LSM_HOOK
> >>>>    * };
> >>>>    */
> >>>> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> >>>> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> >>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr=
, const struct cred *mgr)
> >>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, co=
nst struct cred *from,
> >>>>           const struct cred *to)
> >>>> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
> >>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder=
, const struct cred *from,
> >>>>           const struct cred *to)
> >>>> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> >>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, =
const struct cred *from,
> >>>>           const struct cred *to, const struct file *file)
> >>> I'm not overly excited about injecting these additional return value
> >>> range annotations into the LSM hook definitions, especially since the
> >>> vast majority of the hooks "returns 0 on success, negative values on
> >>> error".  I'd rather see some effort put into looking at the
> >>> feasibility of converting some (all?) of the LSM hook return value
> >>> exceptions into the more conventional 0/-ERRNO format.  Unfortunately=
,
> >>> I haven't had the time to look into that myself, but if you wanted to
> >>> do that I think it would be a good thing.
> >>>
> >> I agree that keeping all hooks return a consistent range of 0/-ERRNO
> >> is more elegant than adding return value range annotations. However, t=
here
> >> are two issues that might need to be addressed first:
> >>
> >> 1. Compatibility
> >>
> >> For instance, security_vm_enough_memory_mm() determines whether to
> >> set cap_sys_admin by checking if the hook vm_enough_memory returns
> >> a positive number. If we were to change the hook vm_enough_memory
> >> to return 0 to indicate the need for cap_sys_admin, then for the
> >> LSM BPF program currently returning 0, the interpretation of its
> >> return value would be reversed after the modification.
> >
> > This is not an issue. bpf lsm progs are no different from other lsm-s.
> > If the meaning of return value or arguments to lsm hook change
> > all lsm-s need to adjust as well. Regardless of whether they are
> > written as in-kernel lsm-s, bpf-lsm, or out-of-tree lsm-s.

Yes, the are no guarantees around compatibility in kernel/LSM
interface from one kernel release to the next.  If we need to change a
LSM hook, we can change a LSM hook; the important part is that when we
change the LSM hook we must make sure to update all of the in-tree
LSMs which make use of that hook.

> >> 2. Expressing multiple non-error states using 0/-ERRNO
> >>
> >> IIUC, although 0/-ERRNO can be used to express different errors,
> >> only 0 can be used for non-error state. If there are multiple
> >> non-error states, they cannot be distinguished. For example,
> >> security_inode_need_killpriv() returns < 0 on error, 0 if
> >> security_inode_killpriv() doesn't need to be called, and > 0
> >> if security_inode_killpriv() does need to be called.
> > This looks like a problem indeed.
>
> Hang on. There aren't really three states here. security_inode_killpriv()
> is called only on the security_inode_need_killpriv() > 0 case. I'm not
> looking at the code this instant, but adjusting the return to something
> like -ENOSYS (OK, maybe not a great choice, but you get the idea) instead
> of 0 in the don't call case and switching the positive value to 0 should
> work just fine.
>
> We're working on getting the LSM interfaces to be more consistent. This
> particular pair of hooks is an example of why we need to do that.

Yes, exactly.  Aside from the issues with BPF verification, we've seen
problems in the past with LSM hooks that differ from the usual "0 on
success, negative values on failure" pattern.  I'm not saying it is
possible to convert all of the hooks to fit this model, but even if we
can only adjust one or two I think that is still a win.

As far as security_inode_need_killpriv()/security_inode_killpriv() is
concerned, one possibility would be to shift the ATTR_KILL_PRIV
set/mask operation into the LSM hook, something like this:

[WARNING: completely untested, likely broken, yadda yadda]

/**
 * ...
 * Returns: Return 0 on success, negative values on failure.  @attrs
may be updated
 *          on success.
 */
int security_inode_need_killpriv(*dentry, attrs)
{
  int rc;
  rc =3D call_int_hook(inode_killpriv, dentry);
  if (rc < 0)
    return rc;
  if (rc > 0)
    attrs |=3D ATTR_KILL_PRIV;
  else if (rc =3D=3D 0)
    attrs &=3D ~ATTR_KILL_PRIV;
  return 0;
}

Yes, that doesn't fix the problem for the individual LSMs, but it does
make the hook a bit more consistent from the rest of the kernel.

--=20
paul-moore.com

