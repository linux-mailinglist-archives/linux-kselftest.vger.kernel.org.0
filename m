Return-Path: <linux-kselftest+bounces-11493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77809011BF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E102829C1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B5167DB2;
	Sat,  8 Jun 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThAyAc7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AF6125;
	Sat,  8 Jun 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717854865; cv=none; b=k/z+w+PHSOOjE4nQaNxk1nPS8T2v+ev9pnSZy/QPZERC9vnnyl0utwZlFGUC6oPTjOxPu5rgPLLQsoiBHIkKAFsczc/ILKj7jCz7fMRnWhhfFQd1YVDHBHVhEtjIAjxHacmHJoHDhrLvGIF3tMtyq0eQJEBrj4aSonact/fBOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717854865; c=relaxed/simple;
	bh=B99socHB9zdzCJa3kEH1MFl0m62MpMiOJpPKvQFpIzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usYibhDI3w3KYbdKL6rednmoApvKRD15rGk3v7MDKs3wq4e19t4xRavlgduc1FVfWnexkKaHAx514uwPyXoxtZxJKW+xjuGEi1hB9trUS+5R5xXgdBHYLQ4JWLa2xm26I5RA2lPMSd5ZaAtcjm33sgAX7xob2FWNyE50KxfRS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThAyAc7I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35e1fcd0c0fso2707423f8f.0;
        Sat, 08 Jun 2024 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717854862; x=1718459662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xw+j3Vz5ntAMdhWfgifnXjX+0bNUVajQ5j4AlV8FGQ=;
        b=ThAyAc7IepsLVDeIZ6tMxl+DM86V5QF1H9ss/h7Uhdz5Gfv+HXiCl/xBYOnLHuJwOi
         B2yWU1Ac7+HnrWb8+mbiij0B6PbhgBrzrAJBZPNhMNby+R6oFPi8BD3rtu0nFzB8uats
         qc+mh35GVM/VFnOnD+QSqwJJz/I9vkz4U+monOGvZgDAFexzRM/CKh4GmrYIsRk6p1K/
         p6KO0nYAcu/hJizDpOxQfk7xKp+ZgmbdykuW5OxeMv/hDFIi4V/asXR/TO6t8U6K5PCO
         cDiBY+Pr3mF4ZIabapKTuqVevqouafAzx9oQzTCL08E1QWe73vFE6vMz+tV9lTkTBBFd
         3/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717854862; x=1718459662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xw+j3Vz5ntAMdhWfgifnXjX+0bNUVajQ5j4AlV8FGQ=;
        b=JPQXaYL953FrD3HinB0m4nhGza8wevW77IWYRwTlU7uG8OcZ+2KCXbXqEiydSHUWTy
         UO8INLoLFDIAPIx5hAtBYVBI7yHB/jt4wPsmLwaeydBBUmswZgjQxTChzM/3fYOreQkN
         gKrrXxQw78KM4FSrZtKQPEig1Q+GMEUTVHNTLCGG/RFjNdaLmUoNT/iMc/CCdEtx74/e
         /6nd7sKWR9vwe2gzWdCBYyxxwGio96pGV7YMib+ybNFrU6NpNXFdTWlC2WPNxNYeHMAn
         RbQifLi2Et6Fw4JH3NHr5UyNEH4XmJQvoWsoewhS+0dt3tcOkrXbuNyrom7r86KdKJcJ
         6wzw==
X-Forwarded-Encrypted: i=1; AJvYcCXVlwZ0h3Yuslw5Eyh45tYPwtG7CTCQY9jDh81bBUOqXXY93xSKoIhwnBsO+hQXeqqmZKtdxah3dBOsBLpmbvmmZU1sjX++Gow7Uzyohfh5o+UXi7oBFa5p/ojQ5gGV2Ux8pptOJIa1+hQkpmqRUM6Z8sv5zZt2+LFD3hdpHl015WKk28jyJXvpGKcvLrIhELAVNY67i0Ep3uzmZb87gxBk6kXF
X-Gm-Message-State: AOJu0Yz3R9k/23iuW2DSooEtQksjjScDmRe89OnZ2S/dcVlD0Xc0cIRP
	H6UWwzOh2uNS1XwEmHMz8aKopmvyO0wbHLYonzp6sx9aLU6d61fw//q/F5/MttWjUb460gbVWJK
	bEGeAvarm02lrnYUwN+K6SCo47Pg=
X-Google-Smtp-Source: AGHT+IF9ICMFieUVMwVWXMt+wkq9GuFcvWm4Prv9S2lLb1vp0KtGzCVURWX4IxANk7qjquk7WPVVtBTf9XIUa7tOqR4=
X-Received: by 2002:a05:6000:154b:b0:355:75f:2862 with SMTP id
 ffacd0b85a97d-35efedcb66fmr4657270f8f.48.1717854861385; Sat, 08 Jun 2024
 06:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-2-xukuohai@huaweicloud.com> <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
 <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com>
In-Reply-To: <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 8 Jun 2024 06:54:09 -0700
Message-ID: <CAADnVQJfU-qMYHGSggfPwmpSy+QrCvQHPrxmei=UU6zzR2R+Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:04=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> On 6/7/2024 5:53 AM, Paul Moore wrote:
> > On Thu, Apr 11, 2024 at 8:24=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >>
> >> From: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
> >> default return value, and the expected return range.
> >>
> >> The LSM_RET_INT is declared as:
> >>
> >> LSM_RET_INT(defval, min, max)
> >>
> >> where
> >>
> >> - defval is the default return value
> >>
> >> - min and max indicate the expected return range is [min, max]
> >>
> >> The return value range for each lsm hook is taken from the description
> >> in security/security.c.
> >>
> >> The expanded result of LSM_RET_INT is not changed, and the compiled
> >> product is not changed.
> >>
> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> ---
> >>   include/linux/lsm_hook_defs.h | 591 +++++++++++++++++---------------=
--
> >>   include/linux/lsm_hooks.h     |   6 -
> >>   kernel/bpf/bpf_lsm.c          |  10 +
> >>   security/security.c           |   1 +
> >>   4 files changed, 313 insertions(+), 295 deletions(-)
> >
> > ...
> >
> >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_de=
fs.h
> >> index 334e00efbde4..708f515ffbf3 100644
> >> --- a/include/linux/lsm_hook_defs.h
> >> +++ b/include/linux/lsm_hook_defs.h
> >> @@ -18,435 +18,448 @@
> >>    * The macro LSM_HOOK is used to define the data structures required=
 by
> >>    * the LSM framework using the pattern:
> >>    *
> >> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> >> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, arg=
s...)
> >>    *
> >>    * struct security_hook_heads {
> >> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME=
;
> >> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head =
NAME;
> >>    *   #include <linux/lsm_hook_defs.h>
> >>    *   #undef LSM_HOOK
> >>    * };
> >>    */
> >> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> >> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> >> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, =
const struct cred *mgr)
> >> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, cons=
t struct cred *from,
> >>           const struct cred *to)
> >> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
> >> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, =
const struct cred *from,
> >>           const struct cred *to)
> >> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> >> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, co=
nst struct cred *from,
> >>           const struct cred *to, const struct file *file)
> >
> > I'm not overly excited about injecting these additional return value
> > range annotations into the LSM hook definitions, especially since the
> > vast majority of the hooks "returns 0 on success, negative values on
> > error".  I'd rather see some effort put into looking at the
> > feasibility of converting some (all?) of the LSM hook return value
> > exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
> > I haven't had the time to look into that myself, but if you wanted to
> > do that I think it would be a good thing.
> >
>
> I agree that keeping all hooks return a consistent range of 0/-ERRNO
> is more elegant than adding return value range annotations. However, ther=
e
> are two issues that might need to be addressed first:
>
> 1. Compatibility
>
> For instance, security_vm_enough_memory_mm() determines whether to
> set cap_sys_admin by checking if the hook vm_enough_memory returns
> a positive number. If we were to change the hook vm_enough_memory
> to return 0 to indicate the need for cap_sys_admin, then for the
> LSM BPF program currently returning 0, the interpretation of its
> return value would be reversed after the modification.

This is not an issue. bpf lsm progs are no different from other lsm-s.
If the meaning of return value or arguments to lsm hook change
all lsm-s need to adjust as well. Regardless of whether they are
written as in-kernel lsm-s, bpf-lsm, or out-of-tree lsm-s.

> 2. Expressing multiple non-error states using 0/-ERRNO
>
> IIUC, although 0/-ERRNO can be used to express different errors,
> only 0 can be used for non-error state. If there are multiple
> non-error states, they cannot be distinguished. For example,
> security_inode_need_killpriv() returns < 0 on error, 0 if
> security_inode_killpriv() doesn't need to be called, and > 0
> if security_inode_killpriv() does need to be called.

This looks like a problem indeed. Converting all hooks to 0/-errno
doesn't look practical.

