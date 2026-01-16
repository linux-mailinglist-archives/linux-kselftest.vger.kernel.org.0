Return-Path: <linux-kselftest+bounces-49212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254CD38934
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE0A300C282
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B22311940;
	Fri, 16 Jan 2026 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnGZbEP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01429E0E6
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602487; cv=pass; b=QcVZMONZaWw4R+ER37m2TWdo8Po2Rk5lJa+i37fu/92jqpN/MQG4bQffkWBdk6qf7rRLfgBDAXoaqxxBySxy3BvLONOZV5bQAOfgfOTakQ9AMWWfwXe7jPv+pi/mY697D8TRjei8AxgnR9k0TJDjkzDH9fT2VbTPRmeh7sET1Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602487; c=relaxed/simple;
	bh=e5O3aFYeIvcKbfg0/jZu7gJTJoVVq8BY3YqjjOKcV04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFf2az50I5pQ1qcp8qD4SrBfgBjKzq8oWL9BSSaJ4l/yNuC7oHJMo92nxS2qug2uWwVW5zIzTo0O0/knUr76v6Uxup+BfAOl+3kpUmDf2npUFqkEraziSCH7IKOuNbmKPn9Wj+mVaz4ZL7nZP6p4lh24N3cpPxsQcnI5irKdBio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnGZbEP2; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so1770875a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602485; cv=none;
        d=google.com; s=arc-20240605;
        b=WBeznVl/Gn9265qwm3EGC8Awm/YiyNi/s90MD8OgLg9ZGqI8QZo2couCiBLxrIHtRa
         GXLJOeDJZ1X2LGdNBbJyOVEpk6Qvotw/5zVERcIiPwBJakgmxUoeAJm1o+8gNnBqqtCz
         QRcEbWhu1r9XN/SbrOLDcPwBOESCO6vBjSRpn1Bx44y/umkbpGbRlzsv1FLWKicc4op5
         vwl9eLv5xSW6qv8O+QJ5qSK5/nkDkvLElBKCtTVS5+kRBuErK5gvOkCp760n4PizHc3n
         bHy7S6ZxGv28lb8tD9RIR2D3BI/MV7nMZHWuDFcDP60XdoEgmrCfaHBs32BiLn0GE90w
         E97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhIrDxLvEVi4Sv2JLQc+7wy2/rTmaDaiC7LdgHxYqR0=;
        fh=MpQNKF2iqqT6BgEA9bgBGPdhxK6J629PfCLlRyQngMc=;
        b=XFmKq8JW+yjs/8L+YPJlN3uMupNbcfpORmKGDStdolcR5h8eQM63XHqrsDFwkYaDDM
         B/ZgXqQCWuKvEzJs/E4loBwU8WO90q6RT2LTe+a4XM1AtJXJ9evowBGQrbQQ8DSghdw0
         zHDIVhtkVy/Jp8XEBaShsvfpDSViTh1Czu5CIBwlXDcda7fMUwO1vt11cc1UrRjDxN9B
         3+veX9EQLwLcbJxbp4E8ts66CP61yftdUr3cNBjzbv8GT7RoQqTyCOPdf/VcCH0VVObi
         21mPpE8GO0N3ppFSy4goWU08Gsqzuje/lvcDigTF+sgcAursAszNAqj9JekIydySwuUb
         S5Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602485; x=1769207285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhIrDxLvEVi4Sv2JLQc+7wy2/rTmaDaiC7LdgHxYqR0=;
        b=fnGZbEP2krZR1mRqomojCpv8Yth1Dn/wRHLNNiTicWzmKaC07xWWXh6xAUJfdzK6yx
         sglAtpEw8+CQ90x3RXACz9OsOSJBmiY9bJr8sXnATUZ/n3i0AZZ4nZyd2Ae1LOcJeNuT
         d8v8bduZqTERy5oPEU1IatabyHD/YbRqn5sX8ixtyCM0PWq3tYA4xXxorczeO4cVdL9K
         BkUT493Xj3C5yokH0YpXn07V40fanlJs7jnp6+fpsY9N5Gp8Q5gyiXYbkIVE91/uklyt
         Y5rR7RecrvDRhhOFB4E8j8egChyoERbEtJAK0p8kdokyN0lYvTZxowWdf+O4PWcHCP8u
         XBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602485; x=1769207285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhIrDxLvEVi4Sv2JLQc+7wy2/rTmaDaiC7LdgHxYqR0=;
        b=TaUtzgrVkjyw6TIW/5YL3yGBf8zoblCX7rcZlwqcb/oHpNQwZaZH3mOWxFkdpndPWO
         sKeK2S9ZkaLqDDphWvcmBSjoh06BJvLDH7GEXK7jvtMv1PdNDTlqSu+VHm6JRko0feGR
         QgjmvGoNqaxp1ANf2lF3vH7vihCzGrQ9r+iKMqF/9wv8pgY0gRjLYoiITFVh3lBpQku9
         sblNNpOoj3mcEDSiEhB0B2M/PV618Al5kfgxaOIxxBOV7bCts62LEUGo5iY8fd00xPNc
         tKM/if1f4S8d3TlGPn9GUcAnB0NcFI7Vq7yUrMbLyEEHZM7au596TgQezGIKIV2K1Bmy
         wghg==
X-Forwarded-Encrypted: i=1; AJvYcCWVe3RQ7gaksw9aF38lGkt9yBknvqBjxbn94vmL2CiqL/a9c5tgcfHDSMGkeHSlH9FNYzvqUP1JT7HQWRS7Lfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcKNkPuygS2Gtv7/XR07PR7bjeCRPZfKQaKTKlchn9SYfH4/t
	jQvRqtp+6dlHFq6TeI3iFF9CNI0uYtuzuAtXYmVZJL7WLvrjyvQydnP/OvYA0C0AX9wak5RiXtg
	AckMeu6eXFlaR9VZ7b24c93D+Vq3pa/Y=
X-Gm-Gg: AY/fxX5nKUn1j2J4TmxT4PNrQfkhaBmuw7qXGdh6XRcXCiBPnixXRlT6Ul3zPTAcBWv
	9Ib3ISWh8gJMFvlZvTATGGMJ/p91w2+KVKcoEobp4VnzhO+LTlfuWJoeE4UvvzwIem/32j0ewcV
	l2m2zxYJVeMSX0zReCcuHEnUERSK38Chxv8CrMar3rh6pAniGUcDYNXEupd39aOSgGdPNom1Ny1
	XedQk110Znldy9tYlu0J4bOgoix1URcwPucCipvNKDnJPhdtcUxoEjtqbWrAelOxjf55rzHlSni
	N5EByBiDbNw=
X-Received: by 2002:a17:90b:3c85:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-3527317db23mr3752920a91.11.1768602484921; Fri, 16 Jan 2026
 14:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-3-leon.hwang@linux.dev>
 <CAEf4BzYRC+=J05C6QDwgzbJ7gO7gZD4xcEcj9ixCaJ=xaRuSsQ@mail.gmail.com> <3b0fa14d-a11d-4ed7-8f28-2e99d74f6b46@linux.dev>
In-Reply-To: <3b0fa14d-a11d-4ed7-8f28-2e99d74f6b46@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:27:38 -0800
X-Gm-Features: AZwV_QiRj9jk-5uJ87ReS5F4IFipAEUi6jE4X1Cajov5CAwqsqjl7f0Fw_saIUU
Message-ID: <CAEf4Bzbig7bZoaOgOWvcv1W46iUe6m77NpToghu+vZCvQYsMpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/1/16 08:42, Andrii Nakryiko wrote:
> > On Mon, Jan 12, 2026 at 6:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> To support the extended BPF syscall introduced in the previous commit,
> >> introduce the following internal APIs:
> >>
> >> * 'sys_bpf_ext()'
> >> * 'sys_bpf_ext_fd()'
> >>   They wrap the raw 'syscall()' interface to support passing extended
> >>   attributes.
> >> * 'probe_sys_bpf_ext()'
> >>   Check whether current kernel supports the extended attributes.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c             | 34 ++++++++++++++++++++++++++++++++=
+
> >>  tools/lib/bpf/features.c        |  8 ++++++++
> >>  tools/lib/bpf/libbpf_internal.h |  3 +++
> >>  3 files changed, 45 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index 21b57a629916..d44e667aaf02 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -69,6 +69,40 @@ static inline __u64 ptr_to_u64(const void *ptr)
> >>         return (__u64) (unsigned long) ptr;
> >>  }
> >>
> >> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> >> +                             unsigned int size,
> >> +                             struct bpf_common_attr *common_attr,
> >
> > nit: kernel uses consistent attr_common/size_common pattern, but here
> > you are inverting attr_common -> common_attr, let's not?
> >
>
> Ack.
>
> I'll keep the same pattern.
>
> >> +                             unsigned int size_common)
> >> +{
> >> +       cmd =3D common_attr ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_C=
OMMON_ATTRS);
> >> +       return syscall(__NR_bpf, cmd, attr, size, common_attr, size_co=
mmon);
> >> +}
> >> +
> >> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *at=
tr,
> >> +                                unsigned int size,
> >> +                                struct bpf_common_attr *common_attr,
> >> +                                unsigned int size_common)
> >> +{
> >> +       int fd;
> >> +
> >> +       fd =3D sys_bpf_ext(cmd, attr, size, common_attr, size_common);
> >> +       return ensure_good_fd(fd);
> >> +}
> >> +
> >> +int probe_sys_bpf_ext(void)
> >> +{
> >> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_toke=
n_fd);
> >> +       union bpf_attr attr;
> >> +       int fd;
> >> +
> >> +       memset(&attr, 0, attr_sz);
> >> +       fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &at=
tr, attr_sz, NULL,
> >> +                    sizeof(struct bpf_common_attr));
> >> +       if (fd >=3D 0)
> >> +               close(fd);
> >
> > hm... close can change errno, this is fragile. If fd >=3D 0, something
> > is wrong with our detection, just return error right away?
> >
>
> How about capture errno before closing?
>
> err =3D errno;
> if (fd >=3D 0)
>         close(fd);
> return err =3D EFAULT;

not sure what this code is trying to do, but yes, preserving errno is
one way to fix an immediate problem.

But fd should really not be >=3D 0, and if it is -- it's some problem,
so I'd return an error in that case to keep us aware, which is why I'm
saying I'd just return inside if (fd >=3D 0) { }

>
> Then, we can wrap all details in probe_sys_bpf_ext().
>
> >> +       return errno =3D=3D EFAULT;
> >> +}
> >> +

[...]

