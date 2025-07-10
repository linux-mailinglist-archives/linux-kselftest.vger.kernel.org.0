Return-Path: <linux-kselftest+bounces-37029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271BB009D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852211891ED7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07616267B6B;
	Thu, 10 Jul 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHGRQ1Qk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6AD1D7E54;
	Thu, 10 Jul 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167997; cv=none; b=PjMIXA7FSM2J2vWSu72waGgKSDgT9ya0+rUYiIzCO+skF8uDB3jJteq7+7vbRrVsuEJgEddt5wsG4OY4C/0eU//oAslB2xti8Bq/N1BmQqiYYX6Pf9fga7Yqve85qcQoHa4rDFV5dqkaBjRZIZfWkDuAfTGMoZv9Juf/njMhtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167997; c=relaxed/simple;
	bh=aJ1R+ThPl6yWYasI4dM29057RnOusK9AB4v0zjmXaRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKqvkGb/U1qekWFXms5Qn977qpDkSR6iDGr8RyqN4TUz9AYpPGLy4QyXXgepBMbG1sgUmbzgDrkjiKfYdKFgRrqOJe+3J5e8O1187Hmujdc3dqm8Fm3jZFzYcRZc2INkGIFYVCZ4EIEXp1RsoNHgbHql3G3F0vX4kDGX1aXtcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHGRQ1Qk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso10413995e9.2;
        Thu, 10 Jul 2025 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752167993; x=1752772793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRPJLDoWBhiLb7llPs80OjmH1aS+eqHUURkjeZ7jDRE=;
        b=bHGRQ1Qk2arMoPiU5q58fs3rhQMeCU+58qAiE64w+V3Q8aBPioW5usvfL+v9tDEuOB
         yd5Fqp+zfJI9U4TDn6MKYH43uLGH6Gk/OC4BeZDcRkBMyLvz28lRpKgXIcjl6vpjL+7W
         iAvIzKczU0aASvjPhhHCmrALknjoOrLr5FrfrcYTJNyvMfDxvYpCAiyqBIXPXY58J2Qx
         X4mq4T64ZokLC2GaUFnxB+QJgzF8rH5o032utgd0Yt/JAsfQr7+SYmwWQU4ofPjMYfOr
         d1lthwAj/fcaoEqgv/MPSfS43frCEgU9ZDDyLLRrWr6N+XOldNz1qy9OSf8L3dkTnYI7
         uVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752167993; x=1752772793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRPJLDoWBhiLb7llPs80OjmH1aS+eqHUURkjeZ7jDRE=;
        b=edSDlGI/O2R/DWUPrSDd5woKRYsExIclFP7a5Wjn9FiwxShJW7ZDhPps1GaSR9oA4E
         phL/G1gFWajgbv8h9+XNqkbBTBYzwOk4Ffo3ytly78PS6mAIRjz5KWLNzG776HoxmXuV
         YvVldfa+jnjcduu9M9NoI3Q6r+Q2B6jrjNvpxBjsYN6XinrmuNV+D/2UEsDjdrh9EJnF
         7Tr9ypdLKcmfTVTmht+c4JY3T97pXK2Pj9HKTaFFBkCIiovQlyO31iCJzYiUihFqsQ82
         HZsPFKmpdZWl+JgRYXF4sqMf7BnyOTPXqU0T+0TJEfsTrzkqWMd2fLpwjovLXQo3zenz
         5MMw==
X-Forwarded-Encrypted: i=1; AJvYcCUh3LG/n6nIMY0oCxnmfbjJNKZ0hwBnqEWrTvXVA+LotAHf343A6JBboZp3UVnZUrwUYW0SfixqESq75lEp@vger.kernel.org, AJvYcCV82AeeqvmzNrHQokCeze7BQ00Q48J2WF0/R79SCT8IKyoClxWX4yOaAKsQsU59blYEvq08DbiImxNRdnXs3/zT@vger.kernel.org, AJvYcCVALiIWEeX2FNeZJr3c9a4G6DKCUzxuBF04qPcGnt4kDUpToqKSMrinPWst1tWcLwX5Gt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzog2Yh1qxKGn0xuJitRaYT7MLH486h9502mr9dxQA1ZfhsKWMV
	yTP4G9xQxnnW8rKCSH4qFTq7iO6LG/9tN2+bhHA2BkbEg7BksQzWoAZ4jiFKvumdg4lIJa2Sdsr
	eoVLznLJng9vAW08G1cq0pxUuDdmBCuM=
X-Gm-Gg: ASbGnct9f5Kt4yTgzBU44KOjNIfKfO70BWHGW47joBzsiTeBiunVWD4KD/fPiaYXfbx
	alQ93saBNz2abaoXZcQGSLA6gYNVA7+BOYKhsMwoviw31CcEuJE8YORSsTTzTwQYpkLnMF03cYc
	YzHHEY+Rz9WQAjzVkb+S/kgEOtrTFYRMC+onipzF3cbNVrvIvXAtmSC6m5u+KGrUL7OhEfGKEv
X-Google-Smtp-Source: AGHT+IHicCdhXSND842PNCSKst0w0I40xbbdg59cM4x5MFHHe4BGrN1DFhU1upnqg2ahkDIeFC/slIKTlYCdX1KiTK4=
X-Received: by 2002:a05:600c:35c9:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-454db7eaf93mr50058415e9.11.1752167993179; Thu, 10 Jul 2025
 10:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710162717.3808020-1-mannkafai@gmail.com> <20250710162717.3808020-3-mannkafai@gmail.com>
In-Reply-To: <20250710162717.3808020-3-mannkafai@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Jul 2025 10:19:41 -0700
X-Gm-Features: Ac12FXx7talNdm6Q2bYZAmnib7hzklBF3riC9ofaJVZRMxb0Bb8KpD_ZSPAySOw
Message-ID: <CAADnVQ+Ca43c757zaT80B+4RJesRozx39mLoz3hOdKXEaXLBLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Show precise rejected function when
 attaching to __btf_id functions
To: KaFai Wan <mannkafai@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 9:27=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> Show the precise rejected function name when attaching tracing to
> __btf_id functions.
>
> $ ./fentry
> libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> Attaching tracing to __btf_id function 'migrate_disable' is rejected.
>
> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 275d82fb1a1a..2779d63e1f8b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23938,6 +23938,8 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>                         return ret;
>         } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
>                    btf_id_set_contains(&btf_id_deny, btf_id)) {
> +               verbose(env, "Attaching tracing to __btf_id function '%s'=
 is rejected.\n",
> +                       tgt_info.tgt_name);

"Attaching tracing to __btf_id" ?! What does it mean?
Drop "__btf_id" and "tracing" bits.

--
pw-bot: cr

