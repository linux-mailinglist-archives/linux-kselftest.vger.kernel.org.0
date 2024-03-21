Return-Path: <linux-kselftest+bounces-6467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3247885CC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C8B1C20810
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1F12BF15;
	Thu, 21 Mar 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSgdNimu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0D12BF18
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036735; cv=none; b=rLCiM0i9RAzqQGowNk2lDBOKYKOboNxONDRDqKBEZIT11/FSLpyyDujRnv2QV0ODwZCuXYTdKYHe53i4Bh+HcJn1a2Vu86Wb2kIFe3EVwZDvzAfVnavZaIEic47VUW+M7Pb634XupLi+YuCbyVp/ngdnJ4UDzczBLfaQ/pkTqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036735; c=relaxed/simple;
	bh=Iad1tyKhiFMIDC8Xt0/zXsbE/rY3pkbp2kXvv1eL2yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NflY9eINC1B7fc+9ex2BEgCm38SzxiddZ65aG+zjYA6PZuk0bQfUU9JjTJIP95rk3tTYJavO86EKwamukVa2gq1v9QREgZ7Gep8Z9iJZQbnFNsOvHHPjY+J9ZGhax1exSwtd5NrY1eYjGJ/4wl/LmKnmeryHWP9nCtFV+emiyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSgdNimu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711036732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/BIMjBq7uK/tVcgzATJ/EBrygqAy5kphRG6l+IH21c=;
	b=aSgdNimuDtp43Ddp3j/PBEGyXJj4aXlnffoi9EIImL3UpJzYbxrkqhW8mribUW8lI/pikN
	agIq1t6FDsn+rQsLMHuISuUrJsEl9su56qNQhWkeV9zMaAtmA3PFvIHfUerTgjc1go8BXU
	N1Nk16qCY0kd7UCkEeuR6mpfV5tqcQw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-gXrSGiirMraDRz5B7hWbfA-1; Thu, 21 Mar 2024 11:58:51 -0400
X-MC-Unique: gXrSGiirMraDRz5B7hWbfA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46f6c1104eso131899666b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 08:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036730; x=1711641530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/BIMjBq7uK/tVcgzATJ/EBrygqAy5kphRG6l+IH21c=;
        b=KuVz1dh+8Ajtvu8EbzfPCHJX4jvGtdaw2m3S9zM4IHt06yQ3ndfebsY7ElNhn15TWV
         s0bUFC95Y4WaMjygnwS3EuK5tMPHwvkC+4bH5TSNWOIBOoOGvuZIZsKIP+y8IGB6TKTH
         SawPnV6rSoocuUfii1Sww54JWMzQKKMhzr7fbyk4RcEY3vmWj84wFAbRtyOnYVZ8yavf
         cl8cfXweHJEKOSmayNpuxEt1fhzrTfbyWd4a9qVC4GZpoy53FciqWv66DhLC4FazWh11
         p5QLfr7pR2pUxPtzV1O5PSnkuECDmaPmuEGqttq9fsYQzS7ABaOWEVAHbHnWsdj7j1OW
         x6cg==
X-Forwarded-Encrypted: i=1; AJvYcCXfOR2/B406jesyucqAhgVeixY8NEQ5c5ArHexdZPzc+RfuBO6zYJp7N8Ckv9YT8K40KByBu3e3Y9hApQE4Eq7WfzsF9ZYv+ZU6V4zeHytc
X-Gm-Message-State: AOJu0YwYeb60P5DNNvj7/IdHnaesoRg+hBxmmV8u65SERkGa8UKWEVCs
	+nqYxJuol3ZABqSbmQKkQ9YwjZyUvn6iTyENmoWTm9v5w6qqwC7aQ/6yzwUNlkpID/d9Jj96JTo
	ZcY8nMYclrP5g5r1IFNTftG97VzFOK10xiMfRzI9WWkMpiqXrHli3+kv8kAa4lg/ElmGLJEN/XZ
	94YiExgjj/I29GYQV4YcrnVshQmpFRU4wSyvpmnHh2
X-Received: by 2002:a17:906:c149:b0:a45:bde1:a334 with SMTP id dp9-20020a170906c14900b00a45bde1a334mr3108504ejc.27.1711036730312;
        Thu, 21 Mar 2024 08:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAjPwlWHH+uhpm++Xyte28ALX+FmmBQ1UMFwPp+aVKCO/tWvAIb4yfOYkcRBNFi+4fGQDhXBDoSX46ViEtiI=
X-Received: by 2002:a17:906:c149:b0:a45:bde1:a334 with SMTP id
 dp9-20020a170906c14900b00a45bde1a334mr3108485ejc.27.1711036730019; Thu, 21
 Mar 2024 08:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-2-5658f2540564@kernel.org> <88fde9a0bb55c74fe34667e891572d8af9eec21d.camel@gmail.com>
In-Reply-To: <88fde9a0bb55c74fe34667e891572d8af9eec21d.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 16:58:38 +0100
Message-ID: <CAO-hwJ+bTHfraJkpDDchP4k+JDZKChbv8pb+9Wwc7E45P9X-jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> [...]
>
> > @@ -12021,6 +12034,12 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >                       if (ret)
> >                               return ret;
> >                       break;
> > +             case KF_ARG_PTR_TO_TIMER:
> > +                     if (reg->type !=3D PTR_TO_MAP_VALUE) {
> > +                             verbose(env, "arg#%d doesn't point to a m=
ap value\n", i);
> > +                             return -EINVAL;
> > +                     }
> > +                     break;
>
> I think that pointer offset has to be checked as well,
> otherwise the following program verifies w/o error:

I initially thought it would be harder than it actually was.

Fixed (with the new test below) in v5.

Cheers,
Benjamin

>
> --- 8< ----------------------------
>
> #include <linux/bpf.h>
> #include <time.h>
> #include <errno.h>
> #include <bpf/bpf_helpers.h>
> #include "bpf_tcp_helpers.h"
>
> extern int bpf_timer_set_sleepable_cb_impl(struct bpf_timer *timer,
>                 int (callback_fn)(void *map, int *key, struct bpf_timer *=
timer), void *aux__ign) __ksym;
>
> #define bpf_timer_set_sleepable_cb(timer, cb) \
>         bpf_timer_set_sleepable_cb_impl(timer, cb, NULL)
>
> struct elem {
>         struct bpf_timer t;
> };
>
> struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
>         __uint(max_entries, 2);
>         __type(key, int);
>         __type(value, struct elem);
> } array SEC(".maps");
>
> static int cb_sleepable(void *map, int *key, struct bpf_timer *timer)
> {
>         return 0;
> }
>
> SEC("fentry/bpf_fentry_test5")
> int BPF_PROG2(test_sleepable, int, a)
> {
>         struct bpf_timer *arr_timer;
>         int array_key =3D 1;
>
>         arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
>         if (!arr_timer)
>                 return 0;
>         bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
>         bpf_timer_set_sleepable_cb((void *)arr_timer + 1, // <-- note inc=
orrect offset
>                                    cb_sleepable);
>         bpf_timer_start(arr_timer, 0, 0);
>         return 0;
> }
>
> char _license[] SEC("license") =3D "GPL";
>
> ---------------------------- >8 ---
>


