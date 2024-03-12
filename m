Return-Path: <linux-kselftest+bounces-6242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD7878CA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12561C21117
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83F1C2E;
	Tue, 12 Mar 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXVVShMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E161FA2;
	Tue, 12 Mar 2024 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208593; cv=none; b=cdQ1/Fz7yyNp48XsqL1fe0nRigIC/fHO1IzYFxmX1qs4/u9jvX4mG1rCf8VpIhYUdeA6xerTc6N9Vq5UOfQZuviZ6txWWckZesKAvOI55JfTBamFcegUI1zExAQgpR9oaUkTj2c/T00qmosnFnDSF5lM1nvMnohnABo2k1n18Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208593; c=relaxed/simple;
	bh=X06sIfahkl0wkXTl8R2MTqcktnQ6B3pisg8O20vrD7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fkn3STBDcdeQxyQKY1UGE8ew/k5JOQGT1FehYkkd2rRMqJVWwUJpdz0P1uHBOTg22/S4TiqLSvRfIV5J/MOKgcwQlROwrfsSfgMXakhyYwGJlhz8w8W1zVzY0kDf7nFWKKm8GRq8ryHONb/zDlkD1zID50976q7/ufgYy/QzjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXVVShMt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4133847e47bso586615e9.2;
        Mon, 11 Mar 2024 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710208590; x=1710813390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfRRhmqpYXn/+hf3x4Zj15gOPBE5rQPEx7SCKgl1o/o=;
        b=FXVVShMth2WyccQHmQ0aRv2rDa9HQLtzWVa+dzowzm5kDF63uQ0GZ306q5gThxl0LY
         76KnKVy8cvWSxZmLjTsp+C2tUTSxTPu6KSbwdBhRxwnuQBhYQBMZB9PprDci7tta8VV3
         egzPcg9VfKMeNpst6w90zKau70G4wue8SyznXJSXLeAF1igpf8F7Kzk3zjV20RML1VtM
         JeyL2Df894uOJK1lpXFoFYn7kQcV+GQK/NXBeIGDp+4aOfZmREC7RUvFAzIk39TAsiQl
         DcQDxahqvEwLKJ1ec/276aRLWEmzBaeyuwvCNMa8MevGRT4c+mWaTXoUkJZ6tjIx9iIP
         4VQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208590; x=1710813390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfRRhmqpYXn/+hf3x4Zj15gOPBE5rQPEx7SCKgl1o/o=;
        b=UDXejCg6olcMoiBOHteO3jT79t48rRvi9Qrwbv+49+0E+o6dBWvJhnoPRw/z5wa7Px
         ES7Mcd7OMFS+qy7reVOP7SMWnwOB+pFyfLofJoK9LuvPTMz3bbYGuXbMpRBrf+6s4Rep
         1LEln1acdDpT4dAQFwy+PX5eo0VPROEjSRxYerfRLJPjofkdPV1TuBcZVXtb7gp2HPWA
         CxNaMYsLNfCCgSlPIBDCPaJIUcrHaOVdElMBubhzlisY2RFf+olAidHGR1eLcBWomRfm
         A/QkYPL58kU9argHuN1YgR33oK1dkUKQeAZZGn+3k6C/GySXojRG/sXVMf5crH7zZaEh
         uKQw==
X-Forwarded-Encrypted: i=1; AJvYcCUvM9EbUJpUzol70DXF3RiRzR5j/LGC86BbYZdpwnYZmgl9gurcEK0/oqvcngS+pCeJ5B5KUp/MgiPx4A3t+oecnw19/jTW+VqYIe6Vng2Cm6CxyLbKPze/5/yLBV8TKF3ICAudDSp7hpwxg82vsTkOJ6p9hLNxE3LMohQrOol0+UdSj5p6ypzkfkmL5ORD/TMEtfWeL4aG4WakaDM8+POIyIKvdBYu83wj8OF22o59Mwjz03IiPekQeHk3I8PodZiNA+4gNrub2crk87Wt0iOfiDZDIocsORASgQ==
X-Gm-Message-State: AOJu0Yxt+J268npnQGLUxpQYx1n3D/lJx0UaM1NZ0PBvK8ZHQDVPTdTi
	WphTER1Rt+/znW9OQkg3BCMbXf87jvaTH19h89fnm04//3T72UhqmUeRxf92ne+0YgbZvZ2liYH
	wpc5yXkro1jWf5AQmMDQgZsvW6Jg=
X-Google-Smtp-Source: AGHT+IG7xsAdm+wS5oFq5b1jjL8oBRBQgSVipKjCrWRkHMT37wKqdMMIKRlqjVh9M9fPohkxT6A/kQN+ZA/9RtegLYA=
X-Received: by 2002:a5d:498f:0:b0:33e:fd3:8f4e with SMTP id
 r15-20020a5d498f000000b0033e0fd38f4emr5186878wrq.14.1710208589943; Mon, 11
 Mar 2024 18:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com> <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
In-Reply-To: <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 18:56:18 -0700
Message-ID: <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/9] libbpf: add support for the multi-link of tracing
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
<dongmenglong.8@bytedance.com> wrote:
>
>
> -               err =3D libbpf_find_attach_btf_id(prog, attach_name, &btf=
_obj_fd, &btf_type_id);
> +               name_end =3D strchr(attach_name, ',');
> +               /* for multi-link tracing, use the first target symbol du=
ring
> +                * loading.
> +                */
> +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> +                       int len =3D name_end - attach_name + 1;
> +                       char *first_tgt;
> +
> +                       first_tgt =3D malloc(len);
> +                       if (!first_tgt)
> +                               return -ENOMEM;
> +                       strncpy(first_tgt, attach_name, len);
> +                       first_tgt[len - 1] =3D '\0';
> +                       err =3D libbpf_find_attach_btf_id(prog, first_tgt=
, &btf_obj_fd,
> +                                                       &btf_type_id);
> +                       free(first_tgt);
> +               } else {
> +                       err =3D libbpf_find_attach_btf_id(prog, attach_na=
me, &btf_obj_fd,
> +                                                       &btf_type_id);
> +               }

Pls use glob_match the way [ku]probe multi are doing
instead of exact match.

