Return-Path: <linux-kselftest+bounces-5510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A886A624
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 02:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5455E1F2E13E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650F219F6;
	Wed, 28 Feb 2024 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfwjlPFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBA219E9;
	Wed, 28 Feb 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084966; cv=none; b=kd19/VysG4/uHgcq6F1Lyhpu174KcNwQKJfVp+cLBa4f2m66/66tFdfpAG9d8n5Nj+rsnde4fWDmcg0LXINhRoFVmqr6Gi5Z/TVcEKrXkBsISAT/UjTatAPb5FN01Gm7m93ixsQ5fjBxZXP9jonmLm/nLmMKKAa9rc7hX6kNgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084966; c=relaxed/simple;
	bh=+FQUdTrkE2zK55NQ+Cu+x7TSgIAYifAQCWyaS9T97NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPPVVM6ka4pjTrwd3bygPKzKKoF3G+kPwluk1+YcQ1Ke6I68+8nzMfBor2Q5IvqBwWlopSO7uHq5QqAqqNJgGhakf6/TNiB/VPgONi6zkwTfHNtk+5vEn0Clvpt0GPpOBwRMlPYQF1+iibmC9dB+PP/bTrlZEShNVgko31092x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfwjlPFc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412aec2505dso8369395e9.2;
        Tue, 27 Feb 2024 17:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709084962; x=1709689762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui4sJq/l8+cxeUyr+OFsebM3T707k8kNS1YD3vIJ/Xw=;
        b=cfwjlPFcToyuEd4MZtKyKCayQiLVbydRBOAnFL3ubSNu/J8m6ZLNarZF1TrFOYPZVG
         ayx+iEMPleTNKvNyz9hxB1KVRlKztJKE4ZLsQn4NPUX/yfzwrPC9cM0M80EjfEDI/PxN
         iBZCz/3Ry12G7ZUeR3Qye5GToj1xZytgSxuiIcdmSx0dYCdKC4RUB0OlIQGHQ3tK35g9
         /XZ9QDaOkTumNPB3ibF7zHGtqgCn1wE8SfsowkD8xwo5mtIANDJU7+btg5039SQefjUE
         ULCFSiRfL5i3dFRrrN6ksx0XEc9Te9K4S8PVvxBOEipgqJh18sF1uHjE8naH6m+enswt
         nbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709084962; x=1709689762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui4sJq/l8+cxeUyr+OFsebM3T707k8kNS1YD3vIJ/Xw=;
        b=H7DTIa04x3rTG1bnwKUWUMvfkvvtaFBnVcIxvQFa3QMHr8jXrPhRpF8U7OKjhCRh2T
         +6EXBrsRORRjl1i6cA/v7wSv6uedj62JBjqmICG+uVjO+IROZKWrXfjntv7YU8E64QG4
         CFZRlGAzKQOZ3+G5581LoAVHkLd7NkgtpS8F47nsl6STUjsMBOvy8zhFQhn2HzgbXzbm
         Unszin7Eav8sC9SRz+eDHS29E0T9SWI03qOg4sDFDniMtEPeL6kVIXmjlCVxIGrR1GC/
         GanEza4zAj6Fo5OfIjc3yzBmz0fQdvPLNYRU6poNsOZnxqAA9TwSskhuKwFEA48SCxmL
         yKPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ye+7L13OYHCQZBwci4C93XD6qvYkPZAsIxv6c7eHPvMh95lngCOJXasNBIoWCfxRwfvrgEECgYlQblk4gc48r3QFN8IMzL1HfEv57T4I4iB8QCs6XsEA3dtP0vDPM9+4K2zk+1/zL4xvTwrkPrgmssgaDWUSL5FMZAtiBbEP2Mrr7HJXijNQ7f4u7pJDNBD8pAXuHlH3wi6wWhe5ag0r49f8zBiRJ1VQXTSmxh7zIMpbcslzDzaFnoc=
X-Gm-Message-State: AOJu0YwCzgQhQX8aZl/uBOcEO/xHgeE+GqmmIOI1C74tETFjT3k1FLc2
	iEhijztTCgS8h8Sz84rbZNeMl2zmGRJc0JpkR2cLDyDfZiIngwt3AeQniVNL3p2EfyM+eR/OzsZ
	rVUKcfaD6WT4l+MmWsnBtK3Bk5bo=
X-Google-Smtp-Source: AGHT+IGZnDSmoeFl4CZIz+6vAS7IGmyc6HIgJYxbGn7bvr4zS6MIaN7+NdCrCxGiklkpE+8wP8mR8Pv+ITnHeccQpk0=
X-Received: by 2002:a5d:64cb:0:b0:33d:f89b:147b with SMTP id
 f11-20020a5d64cb000000b0033df89b147bmr781105wri.26.1709084962552; Tue, 27 Feb
 2024 17:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org> <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>
 <pocfd5n6lxriqg7r6usyhrlprgslclxs44jqoq63lw734fjl2g@5kv4hjaux2fp>
 <9a35a53a1887fb664fd540ec7e272cb3ea63f799.camel@gmail.com> <CAO-hwJ+TGiLrc4De7htvKaSsMfQnZahK-zONAMNgUMYHEQb-7g@mail.gmail.com>
In-Reply-To: <CAO-hwJ+TGiLrc4De7htvKaSsMfQnZahK-zONAMNgUMYHEQb-7g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Feb 2024 17:49:11 -0800
Message-ID: <CAADnVQKrKzrvzu9NmcaDYGFYicqN--R5J6r--_J58gB0jic_NA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for is_bpf_timer_set_sleepable_cb_kfunc
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:51=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Feb 27, 2024 at 5:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Tue, 2024-02-27 at 17:18 +0100, Benjamin Tissoires wrote:
> > [...]
> >
> > > Hmm, I must still be missing a piece of the puzzle:
> > > if I declare bpf_timer_set_sleepable_cb() to take a third "aux"
> > > argument, given that it is declared as kfunc, I also must declare it =
in
> > > my bpf program, or I get the following:
> > >
> > > # libbpf: extern (func ksym) 'bpf_timer_set_sleepable_cb': func_proto=
 [264] incompatible with vmlinux [18151]
> > >
> > > And if I declare it, then I don't know what to pass, given that this =
is
> > > purely added by the verifier:
> > >
> > > 43: (85) call bpf_timer_set_sleepable_cb#18152
> > > arg#2 pointer type STRUCT bpf_prog_aux must point to scalar, or struc=
t with scalar
> >
> > Right, something has to be done about number of arguments and we don't
> > have a convenient mechanism for this afaik.
> >
> > The simplest way would be to have two kfuncs:
> > - one with 2 arguments, used form bpf program;
> > - another with 3 arguments, used at runtime;
> > - replace former by latter during rewrite.
>
> It's hacky but seems interesting enough to be tested :)

Too hacky imo :)

Let's follow the existing pattern.
See:
__bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)

__ign suffix tells the verifier to ignore it.

Then we do:
#define bpf_obj_new(type) \
  ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))

and later the verifier replaces arg2 with the correct pointer.

> We also could use the suffix (like __uninit, __k, etc...), but it
> might introduce more headaches than the 2 kfuncs you are proposing.

Only one kfunc pls. Let's not make it more complex than necessary.

We cannot easily add a suffix to tell libbpf to ignore that arg,
since bpf_core_types_are_compat() compares types and there are
no argument names in the types.
So it will be a significant surgery for libbpf to find the arg name
in vmlinux BTF and strcmp the suffix.

>
> >
> > Could you please provide more details on what exactly it complains abou=
t?
> >
>
> Well, there is a simple reason: that code is never reached because, in
> that function, there is a `if (insn->src_reg =3D=3D
> BPF_PSEUDO_KFUNC_CALL)` above that unconditionally terminates with a
> `continue`. So basically this part of the code is never hit.
>
> I'll include that new third argument and the dual kfunc call in
> fixup_kfunc_call() and report if it works from here.

Something is wrong. fixup_kfunc_call() can rewrite args with whatever
it wants.
Are you sure you've added bpf_timer_set_sleepable_cb to special_kfunc_list =
?

