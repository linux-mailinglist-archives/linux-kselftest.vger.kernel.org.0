Return-Path: <linux-kselftest+bounces-40331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01EB3C2A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505D05A1812
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9415E5D4;
	Fri, 29 Aug 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdAj69Cq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF917BEBF;
	Fri, 29 Aug 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493235; cv=none; b=rSQ8DZ3SeNPgqKWvzZpPC7dOA53TVEPccpRYIV316GrKcZ+2r1nwecKR4OIjfXdLKA+X5FGNdoM8W69KgSkBZbjCnZ1Vs/J5bUJMlGPoDWli69un1mjw7rH6RHoeVGnV6xKQgUurcelTaxj7ludu5fkpJF4c0YUxbR3T1E1SaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493235; c=relaxed/simple;
	bh=Jf5xdeLi9X3HHuafvcLjhSs5xeo9GEy9j0/o8Ji1qGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC7uKvfFNYu/y/zOfbtqLqXQwEXqaEoseNSeGUWhCuuhEMUAhz3QmvlbBn4EVpvYlXn0zN/MP9Sg68r5ZsuwIxVkH6VDiwwJsyedXe/N3roGw1xpn7i3gcVWSpNd6roLHRH8L8HhpmcGcZ+yL5WmI9eJBsYzoe1flRDeOM7vETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdAj69Cq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4d223d7ddaso820935a12.1;
        Fri, 29 Aug 2025 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756493232; x=1757098032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeCwmU4xOG3C3Tl0VehuOumH20NJc9mb2FfHUNIfDFY=;
        b=TdAj69CqbwWMrT0Wi3G24BHFvhCFZRyPM+moOCpBn527TifH9B9usNkFwRr/b9fkRt
         m41vJQpmPoDOOPPLZ3HuUaEO/jDXQRLz04vvXUMHpgFJHOT+tsbUTLP31rhso9dgFJIM
         6VrpvDNyKNoc9kXCRrn68DCNtpro1gHCUckvAGOJIBYBEyvos7Q8sjhIK/2kqUYfAiZF
         P4fzNip910UJ3H3whzDrq4Ehn/Z+hIAh3aC4cfOBn4VcF27zwSsF5JyJsLB6gXoLpCU6
         Nu3QLZ+M+EB+iVGCNq6upMLqCKc27Q/6mbpg/oQU+/XJ7Ttnt3EDB91bimpNUOJAN0SY
         XXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756493232; x=1757098032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeCwmU4xOG3C3Tl0VehuOumH20NJc9mb2FfHUNIfDFY=;
        b=eAb95Sbjwn53eSl1vFB7ny/Ushl6XPRcEX6DUpZMGVx8MErQ7GLpJkl8qe1AZxWSo3
         ew/LR19Pn1zJF33QsCFBx943Ozh+gW6V97cqLUzlFIND56eneytpB+HPdktJxn/gihlb
         wnmijp9RhHwyqaF6Dt6yj/KuecdHf+0nVSGzhMiQ4F5y3JlE0gmkCNEojbSz9M9O9LXu
         3Ednrpoceh0rc+Vo201t32gjQqUBqOlzzf3Ab0WgVwEDcZJmwE09ZTmVNXQTAPQaD6Tq
         9pjVD65S+oXmLpqQ4SKVI7rOdQvamyKZl1ot9ZSA0g954GJ/EagQnuQdbo21E6dYr/Z7
         dkpA==
X-Forwarded-Encrypted: i=1; AJvYcCUydZSFZLkb641xLF5p7biSWoNjHE4XM1fze9tmyjLIAnXTH5Z3f183/TUAPygcp19l03k=@vger.kernel.org, AJvYcCVu6TcyY4gCQmlpzZnQE8GWkWYaodIC83zCIx23Q9CbbFot/DnKEEqDTR6RnaIKRsTyX1oep6Rx0Ze0PNmdPgww@vger.kernel.org, AJvYcCWnUiRJhTOLY8GkSaF5vGp44frRVQu4Yl4XDt7scrYxZKrhSaRggpTsqwwtwH8Dz1x9dyCK2nar370QjeDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbxbHQVobA9eafYo6zGoQm5mfg90biJBbLSJPFEVMJyae+EVU
	htshYr4hklBWxEKeCPPxJYVLiZNxbxvFUC5ihDc7nAojNzsDe9OAgtXZDH62QOAjljiItlqNM5d
	U9m1avq5vFwNKbw9juZ+l3SJKfxev+1Y=
X-Gm-Gg: ASbGncuAT0zQKMX96kjVEg2ZJ1B8LwtnWMukgw5JO9/MUWV+bwKQPk1FPlk/2cYo755
	vpVFBYH2EHgvZtgYoQmKScgrb40t/1bcs0uA7dztrAx+lv4GHkcTeR5jYAZ7U1a4x49oYa5UKFg
	dMxc83YSOn0QcD7ZztjnoEhLa46eHo9T9mzHcYdaAcoeFEY6m3BKstlTkU3klKmhmr6HkmzbcsH
	MnuR7qBtA6lyezuKCw2ehE=
X-Google-Smtp-Source: AGHT+IHf/znaf+lBJ/veFcj0Gvn2/7bHY9QNTgc0yJs+fcmYEwCAWxwdshLq6iKmVxML0GtcpDVzn5+jHYESeE/92Xg=
X-Received: by 2002:a17:90b:3504:b0:327:cee4:b730 with SMTP id
 98e67ed59e1d1-327cee4bef7mr9778191a91.15.1756493232203; Fri, 29 Aug 2025
 11:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756484762.git.rongtao@cestc.cn> <tencent_17DC57B9D16BC443837021BEACE84B7C1507@qq.com>
In-Reply-To: <tencent_17DC57B9D16BC443837021BEACE84B7C1507@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Aug 2025 11:46:57 -0700
X-Gm-Features: Ac12FXwrU28gK6SIVA99CPuI4bRo0QxhUM16_M_cWvktQ_dGZmUdsLReV-etm6A
Message-ID: <CAEf4BzYNGXxCJhsj+xQL0ANxFDOPFQ5=k9Y23GUg83+HLK4ARg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf/helpers: bpf_strnstr: Exact match length
To: Rong Tao <rtoax@foxmail.com>
Cc: vmalik@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	Rong Tao <rongtao@cestc.cn>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:32=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>

I reworded patch subject a bit, please check the final version

> strnstr should not treat the ending '\0' of s2 as a matching character
> if the parameter 'len' equal to s2 string length, for example:
>
>     1. bpf_strnstr("openat", "open", 4) =3D -ENOENT
>     2. bpf_strnstr("openat", "open", 5) =3D 0
>
> This patch makes (1) return 0, fix just the `len =3D=3D strlen(s2)` case.
>
> And fix a more general case when s2 is a suffix of the first len
> characters of s1.
>
> Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..91ad124844ae 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3672,10 +3672,17 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, =
const char *s2__ign, size_t len
>
>         guard(pagefault)();
>         for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> -               for (j =3D 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
> +               for (j =3D 0; i + j <=3D len && j < XATTR_SIZE_MAX; j++) =
{
>                         __get_kernel_nofault(&c2, s2__ign + j, char, err_=
out);
>                         if (c2 =3D=3D '\0')
>                                 return i;
> +                       /**

fixed up comment style (extra *) when applying to bpf tree, thanks.


> +                        * We allow reading an extra byte from s2 (note t=
he
> +                        * `i + j <=3D len` above) to cover the case when=
 s2 is
> +                        * a suffix of the first len chars of s1.
> +                        */
> +                       if (i + j =3D=3D len)
> +                               break;
>                         __get_kernel_nofault(&c1, s1__ign + j, char, err_=
out);
>                         if (c1 =3D=3D '\0')
>                                 return -ENOENT;
> --
> 2.51.0
>

