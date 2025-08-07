Return-Path: <linux-kselftest+bounces-38530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7248B1DF4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 00:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7077417E1E9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021F2512D7;
	Thu,  7 Aug 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbDPXeed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85F190498;
	Thu,  7 Aug 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754605318; cv=none; b=DpDvlSViCMApob7w6MSbUhAR5z9ZGB7yn1NKAEHbq+kzTPl2I8BLuzME/3YFxHa73PMziH/aYCYAiBnJSjHiIn4z1x/b7RozuEOfa+c+HwlVpMhMkp6ATCkQS1WoBym2QKrXierWA5EBOuIDoE042fWhGxlEb8WuLFx0x6zE8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754605318; c=relaxed/simple;
	bh=NyX6x2ERfb4Es/w+n6vrR7rgkBsq4JA2kRv5oyeYA+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/Pcrh/fwPW75CbRkqvOx9SpqzGKq3GyKPlbPBk79z1GLDOdQTsFkrpneyRgqq+AUzZrW0TqMFEsGVLKzDEnj+RIwvBVaYQdUtw9cn2CvBMGCRRBj3t21+gzGuRf+uDjeuvJgHA4gC19fYF9+wI1otLObd8T7A7rizaKd1dQyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbDPXeed; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso1059124f8f.3;
        Thu, 07 Aug 2025 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754605315; x=1755210115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+v1685pW9f8pk9h8mH3lG3VKN/7ObemHtRwYuDpHZk=;
        b=JbDPXeedogp/oJecgCNCBQKMxVKNeqOoTbbygyouRX0Y/tvpJqvNJmz0xpSxW9lSjb
         FiJsqpDQUI+MN1Mk+lIrs1jZb+jJzHnco83s1C+hMTmPceWe9hjQt16R6AJo31Gw8oth
         8z29umOahK4vZKM/cxrvSMNBqwpd9QSOWCZhafSYj0BUphE3Tg75s+zbiesqVyK2YUSY
         7Ibp28GNceuRd2GpVeBPNbuddWYpxsZpINP9qEgsbxo4jsW8eqAVT7k3fcttf7fNDI5g
         HnR6QpSCRNcs9cVIfThbOh3/UCGVt/fLw2AVBDwljl7RXMWuMlGNUDvQ64tB+to8wwvC
         G4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754605315; x=1755210115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+v1685pW9f8pk9h8mH3lG3VKN/7ObemHtRwYuDpHZk=;
        b=YwUJrX9TBB0leek/I6KuojlDk0/AoXFW+h62KJc85JJnBwZUkeXm7N3xCYxsfB0oPY
         iLlZc874M7h4JRxklAll6aRBI+11S/T4frKySg3WyjrF6MrPMStG7UuuRddMiVBiIDJz
         q+N3mSmUVnNd1REhJE6wsM/IKymbVh1bR+iHxF2QM7sOQn6CmcgFjmmp8MOn7OpDt1ij
         7eTYD3ePPOyikaF3Oies7k3Or0J1m2cCuU9WjniqTiER4WQc+oSuFnrZ0rS+uQm28eOs
         8uZzdmxpY/FpbKSgxdKmktEZXfLfz7zURNik8cwsiANy4fWrmFfpusRu2O6cIK51P+3y
         +KfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlzc7SzzjKWsjsoz8ETPcmF+XDzW8F26Bbrolsy3BVmxpseosio1mahrY53qjbodSzcS8hDMOI3y5wgG1wP2a6@vger.kernel.org, AJvYcCXLdf11UeefOQsvizIePwfgSvn0SyHVWK0LUvkAPCqShivUpOb1wdKpcw7nW8QHsYPRKbu9Nsz2u3W1jyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqZdAD+XhCK/bBpkuPYyHdsoPojm1ckks8hEqmGjxXAu6L7+O
	vWxNQ4uU4t1p9Lia7TF3yPoD5s1nU1BWCDb2Rw50w46bRZKsKYyBco2Lw54SIuLiun+MKSpgnch
	p/KOXnXNM6vPiYrfJXo7nzcFx2jtNEnDONg==
X-Gm-Gg: ASbGncs4suwEY4sAV9ZI22GyuNOVJPUQYidqNI1pz7XzkfDYW2eWgwmBBhH3EsorN3k
	T0h80FuhRMFuPk1cobpDLnl2ef/ZMwrvyaxVWIONDRGEo2lxI4a1BY9f3WhW5HW0u2PzG9zYuSo
	Gi2NZ0DLtuy7c0WLsgEo4hwH4OX+lRwD+Zwj4m2SBxY7UXZHK6RtTuyTdXL6/qajj/uj34zFZW5
	jrT9JFBv+BUMQ+lhqISieXZFvM2Ml0Eb+dh
X-Google-Smtp-Source: AGHT+IEUMHq7iW9MQ3cUOdQooyT7Txw/L00E2hEjDh9Gsvi8bdp6Bx2NyxY2bVc2+H/vdUoj0T9e6lrqJ8yqH6vT9m4=
X-Received: by 2002:a05:6000:1785:b0:3b8:d16a:a4a5 with SMTP id
 ffacd0b85a97d-3b900905a8amr671383f8f.0.1754605314929; Thu, 07 Aug 2025
 15:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805062747.3479221-1-skb99@linux.ibm.com> <20250805062747.3479221-7-skb99@linux.ibm.com>
In-Reply-To: <20250805062747.3479221-7-skb99@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 15:21:42 -0700
X-Gm-Features: Ac12FXz4ijaJwj8PQscV-ujyMkfM3WbQzkOj7RycHgVLmD9z3oTypfADROiDZ3s
Message-ID: <CAADnVQ+BoEMQ3i01YpzdNPAaL_mdNogkvHp0Ef73TBG8w726Zw@mail.gmail.com>
Subject: Re: [bpf-next 6/6] selftests/bpf: Fix arena_spin_lock selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 11:29=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> @@ -60,9 +65,16 @@ static void test_arena_spin_lock_size(int size)
>                 return;
>         }
>
> -       skel =3D arena_spin_lock__open_and_load();
> -       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> +       skel =3D arena_spin_lock__open();
> +       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open"))
>                 return;
> +
> +       skel->rodata->nr_cpus =3D get_nprocs();

...

> --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> @@ -20,8 +20,6 @@
>  #define __arena __attribute__((address_space(1)))
>  #endif
>
> -extern unsigned long CONFIG_NR_CPUS __kconfig;
> -
>  /*
>   * Typically, we'd just rely on the definition in vmlinux.h for qspinloc=
k, but
>   * PowerPC overrides the definition to define lock->val as u32 instead o=
f
> @@ -494,7 +492,7 @@ static __always_inline int arena_spin_lock(arena_spin=
lock_t __arena *lock)
>  {
>         int val =3D 0;
>
> -       if (CONFIG_NR_CPUS > 1024)
> +       if (nr_cpus > 1024)
>                 return -EOPNOTSUPP;

We cannot do this. It will make arena_spin_lock much harder to use.
BPF CI doesn't run on powerpc anyway, but you can document that this
test is disable by creating selftests/bpf/DENYLIST.powerpc.

