Return-Path: <linux-kselftest+bounces-48381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11661CFC2CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 07:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8569C3008C8B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E50240604;
	Wed,  7 Jan 2026 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k22iDgLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC1227E82
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766837; cv=none; b=iQ+gVTzg5EVz+eUCTG2pQCnlBdDa9nqNouxR6kDUQwSxKi4AV9GDZyqIoJ6VbU0gc32aFhtQqYz433ONIxO7ceH8EeoWZI7S4iJnSV4L79uMm2pahFZ7a7vIW8wtpClv1okTMnVSR5MRvxk2LlM0to2aSF39oudtxlZmVNDKB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766837; c=relaxed/simple;
	bh=um8m+LhJ/XySx/W3cljkMVrC03SFTG9VrcE2RdgTnIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaX4kuZezc5+XhFW4Y3GjaYhQxCbxBQjUxBXY0Vdl66Qo1am5iG7pwCX3aBdV5oEw6rzJQsIOAQ4E8cSNwP4aZLHx/9wHOm7FawKMGy9Oe33Zvia8SpATcWQo8JQlxx6XAS/bN2d56jlDuLxRYVGMo/nrAZGpTHAT01ZwHILMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k22iDgLI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so14030045e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767766834; x=1768371634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWHu83Rjq/t7nypMI0K/irCatIvbUqeKZDo8XoCwAbM=;
        b=k22iDgLIZKgyUN+YkwPoawizcUMqgrXnaxGh0CHhIUgXRs5ZDfLeBYgxdkZg1H6Ut+
         9kKzuU66ZblEGcXV/uPBgSIpAKkHTsu4iqSNs8zz4T/aoFKB1UI4dW7BXvuNO3mHXiNR
         MNXY4WUpkWisawFYcU5YHz69+TxjeP4HAMPKodBwelCrbq1J8KF52VXdCFcCeta/gl7s
         /vJQintNB13Js+jqDDoaodNAPOF3bsW/bNBYuU4ePMHFGuiR7zdRyhjHCog1QAsLy3o1
         0G2NkGq7Ki1KZssSsAzJyaXw6b+J/fEjtG/W00xWFxlI7G3Uqm2wCAYhHXUWFeLL7zIW
         UlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767766834; x=1768371634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWHu83Rjq/t7nypMI0K/irCatIvbUqeKZDo8XoCwAbM=;
        b=CK4L9JWYCTe6eekf/h6iyFtD7A0MK2achfRCic3RLpvNXdVm9wvxMjfRmMhGlWAnQz
         eCn5sA2g5NvJy9DLURgLDzSTR2HFtGLp0mPUIgR11L9S+8XXixqEbdztRA4BZRd6DxyA
         1NTUtWjantbBRbfeJ8h17kby26BRCZuuAaddlXmMaNRwK2Nsx8GVMcWQu99IOmpNwCsu
         FUMbLVNoX5+f2fqp5sCgnWS5oDzY719ZRNsCCIQdwBEBy4jIhKt5+Ohtad8aV22Qwv4+
         wgK3MiE0hb8Uz7m9zSiQC/xmSeFhL+KGpW25LZwUNStnhBWweiuJWpDed1oEC60kbTJx
         j7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbzdYhuP7HqO6+gbqYQWpenyasCndGONcx5FDldj2tEi/Gt6Ti64BA5uJNYqDiUAv5QgH4XHO81AnNNSSwXoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQG7264DhXW4RIp2AyTihVdHJj2CJ7YvGxzPiYO2QPrzSHHqO
	IWTJiPYPV/0kOsOdrLiX19UC8y1AAM30meA+SnZQbeI9VfZZ5HfFac77iSAfr3LLTHFjBJG2C+g
	Ls7W1+s4owch11A1IzBuHLeZ1SU04ZJ0=
X-Gm-Gg: AY/fxX6a7v1VOk5bKCG9ETYxYlO/R1bCepIxGBWSrveiPZVcup8//Jw9KqyixDrNpIZ
	2U9/rlECaqTvhZRT04dPNACQsy5zRaOtCUCEqkN+BAKuwW3hikmEqh/q0dYQMSho0sfRa1U1iZr
	tM+Gfj4gXYTRZrOcJcBeQPp/wIAVKVej17m3693i/eyvo2zsYkyNamek9bycpusWshNghaAkp7z
	dTJtsXWo4o8Y6aeqLksXlAmctp+MY8XroTgszHtnjUNkfy/PvuDySth+1xEKWRgqE3Kcv8lieg9
	fNzgvJWQYRMdm5wZVKS0HRVx1yC5
X-Google-Smtp-Source: AGHT+IGzcWbjpFl8GHd/ugDyA2yPKFkcWyQC2ErPWaQGQburW1DXHrBAjkewP3Pay8BE6FqgUD/6VOtgPMUay58ljis=
X-Received: by 2002:a05:600c:19c9:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d84b18215mr13271845e9.16.1767766834354; Tue, 06 Jan 2026
 22:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106172018.57757-8-leon.hwang@linux.dev> <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
 <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev>
In-Reply-To: <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 22:20:23 -0800
X-Gm-Features: AQt7F2pXvdZyGhsn-fNpXT8YU4CZ_7YB1R_2v3jGs3CmgaaHbblL31_h4_a6TNU
Message-ID: <CAADnVQJLifBhcpe5ci7FBB2uzTR5OXPji5RPq2NLSoVXpTfScg@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	sforshee@kernel.org, yuichtsu@amazon.com, aalbersh@redhat.com, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>, 
	LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:57=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 7/1/26 01:44, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 14fc5738f2b9..e64cc7504731 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >
> > [ ... ]
> >
> >> @@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t=
 uattr, unsigned int size,
> >>
> >>      switch (cmd) {
> >>      case BPF_MAP_CREATE:
> >> -            err =3D map_create(&attr, uattr);
> >> +            common_attrs.log_true_size =3D 0;
> >> +            err =3D map_create(&attr, uattr, &common_attrs);
> >> +            ret =3D copy_common_attr_log_true_size(uattr_common, size=
_common,
> >> +                                                 &common_attrs.log_tr=
ue_size);
> >> +            err =3D ret ? ret : err;
> >
> > When map_create() succeeds, it returns a file descriptor that is alread=
y
> > installed in the caller's fd table via bpf_map_new_fd(). If
> > copy_common_attr_log_true_size() then fails (e.g., user provided a
> > read-only buffer for uattr_common), the syscall returns -EFAULT but the
> > fd remains installed.
> >
> > Could this leak the file descriptor? The user gets an error and has no
> > way to know what fd number was allocated, so they cannot close it.
> >
>
> Good catch =E2=80=94 you=E2=80=99re right.
>
> If 'map_create()' succeeds and 'copy_common_attr_log_true_size()' later
> fails (e.g. returning -EFAULT), the newly created file descriptor would
> remain installed and could be leaked.
>
> I=E2=80=99ll fix this in the next revision by explicitly closing the fd w=
hen
> ret is non-zero.

No. The refactoring was wrong. Don't make the kernel do extra work.
Patch 3 introduced a bug and closing fd is not a solution.
Such a pattern can be exploited for DoS.

