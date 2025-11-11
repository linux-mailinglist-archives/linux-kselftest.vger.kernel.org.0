Return-Path: <linux-kselftest+bounces-45344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE8CC4F73E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC77189B742
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AF280A56;
	Tue, 11 Nov 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emk1aIgn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4527EFEF
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886156; cv=none; b=Xl5SloVEdtxDAXzNAxiNNW4999/Mlri77jk0j1BvV6Va8RXfk0OUpSIj0TeUtOdB8sn51uL2sVWdMDguyXV+Jua4wBqqtcq6oW15kguJYZIibiwIGIE9CwqH7EMXJdqbfplJZN0ufKM49n2CL/AjyYzNWpmh336SEswrS/2vbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886156; c=relaxed/simple;
	bh=oiW+96lMPGbksmm+8Ne/yv29cjNp/Y+B/l3wSqF5fv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciTCCwsDU4xcwPGRg5xlbUyASkCTeGy088NDvA2HtXWcFhAelsfXeGTxVe6Nb886c8wbfJprkmHBoppcEEPEfRKwi8pAET9M6L/1uDPrayHrPajRdN4aI6SbfIomx1sYP8evPCBd/C+hDisaOWyWDFxQP2HvlkH0uCCsErY2EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emk1aIgn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b31507ed8so2815242f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762886153; x=1763490953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R2qMufgLCOrAchjb40CxU794Xzs2ku3JcW+CtQ3zLU=;
        b=Emk1aIgnE+o+xS6ecQLTUWoJ8IDJh4A2k0EK8Ad5QVZOlU42wx61ZgRE0RQRu7LgmU
         tGRRydpHr6dv3nhePGC3P4pXpn+KMjd8VvCQyq+kbAgZ1ZbW+OVA4/g3f+2J3VNO1nEs
         tEVJiylo90npaCRuP13jOcBa8jDhvGp7DEBsOk5PlxZEdLoa1NnWr/Vyt7xNFndKQriY
         1afpT8+5mZQwBMXZptTQRBR91TEuTexjLK1WZ9JJMJX5H61LgJnjciVrpnPQ+LZY9YMq
         pBZYK8BfDyfgqtKdEUaGfZj39Vg6xUGSm/hYOUTZO4fEq8RZ4leUlNmCuwjOAiB4Guni
         OwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886153; x=1763490953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R2qMufgLCOrAchjb40CxU794Xzs2ku3JcW+CtQ3zLU=;
        b=N+mUT3Eh5vOgtE1cNpfWUBLapGhC7BwarHEK0ongvaXKIUBgG+oym5KGkmL5xoh6Ro
         m4yQijv7vyl19CgDR4qEsC6S5NCq5UjSugAMkVxCKx9UGLRIL157E9wID6x7gYMZ3N/y
         1h8QRFVWvL7Q80EPgL9jG8m4Uy8bAlWzu0jsTtcXMgXUlUHqazqpSY8+EzOQN725DGVC
         xp2ZkUmbY7pTFRl5L/+YXrV7SB7c99H/Ozty0R7LgfUlWH6/LA0lLfiPB2DkQ1eCSOz4
         LTuciNKsUsfFXs5cUjEkCPiTBWUXtpwLVS8Sjx3feFMozzB0TV7gY6rKzlTijRxzJUM6
         hqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTIqWezZEmyf+XDA/HAGHkpkbW86M6Lv7oSrbjqZTNioWPb882aLJBgzHiD88+QYFZGcbvDuvL55VkC+fjJO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTGYYQ1sTOpWOhnN9vDaIbx0FbCCAH7qJwukm/h/8jwltahCY
	Knqh4lueBtPJl0hZdV0s+U35GOGMHkfgifVNSFi8IcMfig/WAtSm4tgFTE7Mj3xFP2P5NOPjK44
	UsdSMjHhG9EeiqbRMtyGLF3Q0jb3IQic=
X-Gm-Gg: ASbGncsTPVE1WKiWoYbJqNNAiIM5n2sjGRaQixMmkZX7/Y35LnKagXpO/HUJEguGfKf
	dc3kxiv23eLrM7IHUr+KdTV+I4ZyMzT145JtmUtYPIRvhllREQajqoVtWxg/Uqu9dw3VT2lwo8a
	T2n8ZkurkzRHJc5BCqy/gvaAPX0G3XlAYawCo4QVSqCvNJ6CCx0gZZkRqU853ax1nmpNcuTAMFb
	kQgGFum8UPvFkfcgpOrNKjeN9n1C5t/bx/jk1hrsE6ZTbHLX8AIsXXRjfZJyGF9tRt4a0u54Z9M
	2EnnpuLp1EI=
X-Google-Smtp-Source: AGHT+IEGQ85XhZEhKH5h5Lfi8UP2rxKI9DL75Cd87eZEEXwX3fis/UXrcV0y9f0bDUJzlJhMrSLfyBqXOYYDoYp9AR8=
X-Received: by 2002:a05:6000:430e:b0:427:813:6a52 with SMTP id
 ffacd0b85a97d-42b4bdaeeeemr171423f8f.41.1762886153125; Tue, 11 Nov 2025
 10:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106052628.349117-1-skb99@linux.ibm.com> <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
 <aRNJE5GRUxdlJbZB@linux.ibm.com>
In-Reply-To: <aRNJE5GRUxdlJbZB@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Nov 2025 10:35:39 -0800
X-Gm-Features: AWmQ_blGfD4ejxDR3wU_DBvkCzWL8lZb2tvYxWR8OAf4rdjOl-Xg9GCng8SORHQ
Message-ID: <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:33=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 9:26=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux=
.ibm.com> wrote:
> > >
> > > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and re=
covery")
> > > the updated path on re-entrancy now reports deadlock via
> > > -EDEADLK instead of the previous -EBUSY.
> > >
> > > The selftest is updated to align with expected errno
> > > with the kernel=E2=80=99s current behavior.
> > >
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/t=
ools/testing/selftests/bpf/prog_tests/htab_update.c
> > > index 2bc85f4814f4..98d52bb1446f 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> > >         if (!ASSERT_OK(err, "add element"))
> > >                 goto out;
> > >
> > > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> > > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> >
> > Makes sense, but looks like the test was broken for quite some time.
> > It fails with
> >         /* lookup_elem_raw() may be inlined and find_kernel_btf_id()
> > will return -ESRCH */
> >         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> >         err =3D htab_update__load(skel);
> >         if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__load"=
) || err)
> >
> > before reaching deadlk check.
> > Pls make it more robust.
> > __pcpu_freelist_pop() might be better alternative then lookup_elem_raw(=
).
> >
> > pw-bot: cr
>
> Hi Alexei,
>
> I tried for __pcpu_freelist_pop, looks like it is not good candidate to
> attach fentry for, as it is non traceable:
>
> trace_kprobe: Could not probe notrace function __pcpu_freelist_pop
>
> I wasn't able to find any other function for this.

alloc_htab_elem() is not inlined for me.
bpf_obj_free_fields() would be another option.

