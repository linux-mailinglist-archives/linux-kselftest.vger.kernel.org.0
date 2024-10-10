Return-Path: <linux-kselftest+bounces-19481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090C9994DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7F28541A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF551E284A;
	Thu, 10 Oct 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfRIo8xV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E07188CAE;
	Thu, 10 Oct 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597674; cv=none; b=B2vZ0H2bCQ801bqzerC63G+BJezt+2phfQIiC0Y+oGPSAounms/dx5BzniI7+OnJU3G1HBCuiRnHBgzr81KFYP/ikPlQfbx1mX16Ob0PPgebeQu/wTz0qTpihftIBU4jEk7Ni8RIkYMjmTBuYwvycWGMinYIAeXtInC7PKtHWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597674; c=relaxed/simple;
	bh=IqrqVRAGWmUTngX9JyJMpYS2/1LzBtHqam0T8qPIgNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW4xIOJHhnv340atmvUSRna1t4RMAFH79vxFQKG0WtzYkuV1KtbaJhv7Wq9JFpIbJCLCdelx37jAjlCkd74Z+gTAPrcqeGLu+Q9DlUSgUtvtlfuYHhxRmg0xEpxms9HX+Lqur7A/CmoBrnfJrcTDgYg6w3EXzbbnBIhiECO4F04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfRIo8xV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1166331a12.0;
        Thu, 10 Oct 2024 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728597672; x=1729202472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLcwOUla2fi4WryQZC9pITLT3xq49m68i6L5ryo+y5s=;
        b=NfRIo8xViwuO3JUVi7JjR9HDghFI8DjV6w7O5j6u0TzQwT7YikUD58F0A8rDhbnRqX
         r1D1rR0FY+JLS7q3rzRJ1uo8Y7OQ3vQycnuscZ+AhtQfN13O5T6GgAPEugkja5KTFQdG
         CNxs4qV2ffOWnVQ913ljVUdgfR8/P137uPIz6OfT4GMs/+wt1veg0O+17tMzLNemjxV/
         +TigNCm6pAJ42ULcP1097oT6kY7LnReLbE6LIE3msbU4/2klZTrqghtmYWarqsT/QoQp
         Gq6boDb8bl4cTvIZc6e2oW4gFcHII2bQcMDqo1/J+ercvCWjmQrP1n7umezbnCwGBrv7
         K27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728597672; x=1729202472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLcwOUla2fi4WryQZC9pITLT3xq49m68i6L5ryo+y5s=;
        b=vCGZz2rlbdqdBEKxX+LKiQMCoewnpfRHj5i63VIkWKFdLIeEZ0KHOWaQnX7P42y0s+
         9d6tUTn/Uag7kOm19bTMR4gQ3zQH4MuMpv3kz3a0NsiF/rySaWpQPi5jkiE/HjKzz1gZ
         OjzImM+rLcN2QUmt6oC62HrnLCDWggm00xc7rRdXfZVhI5P3e/8uAe7XzWpb/ASsDuEN
         pJsdyBl8a/jE/yXbZjrvJMu6XPE+NFzvbFLBYWqnKlnplbyAEyiotrGblK3FQgoktbCK
         1LG3qnAeeC8FJewYOSX0nsegnThMyaJAgByybF1cpYDCfmBpn7xJxQMRoTyZcQ8x3rgJ
         FQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVsdjBdQD5nkSzlXDhQlFz4rHKTGfuJGJNJrWi5hJ1PwPNbfFO6/fQO9bVJWRRlcnwUhVStAlIn5s/dTX++6XKs@vger.kernel.org, AJvYcCW2NyGSCtSXvwGFA0r6mRldoYyygod6h6vhIpzOoliQNbKyF85ChDnsxg2yuvIJxqpXudihQBjg6CRAV9k/eHLgXUWJ@vger.kernel.org, AJvYcCXd6cpMrRWL2QciEEf3m5nNn4HGHSTx9OmMGWbpLCYHK1H+ILTCX0+SbXlpWPD40w2cXjac4pvbvshXdVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0uTEQLzyn2ySlR/KaEeOVFZS0aeUZyCrJKULWv5XhQwBraVf
	EUvy10LlX37eR7vU5XHl0L4B7/9pwmm8294VJFEBQXuForA06f3dKTNO5dLOVtwqyt8bbHKwIzm
	pKtbxsvKS2ObbTS+T6il0vSSqmwBS9QjP
X-Google-Smtp-Source: AGHT+IHWqBnwD9Qz9bUKjePD4Lcw9JynVMvCGdfFK2afXtJlMLe+UYYEUJ2v1N1JhWUHdofyf/tHHrKSHl0k8vTVypk=
X-Received: by 2002:a17:90a:bc97:b0:2e2:cd22:b092 with SMTP id
 98e67ed59e1d1-2e2f0a6e9cdmr866900a91.16.1728597672490; Thu, 10 Oct 2024
 15:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009220638.333429-1-wudevelops@gmail.com> <20241009220638.333429-2-wudevelops@gmail.com>
In-Reply-To: <20241009220638.333429-2-wudevelops@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 15:01:00 -0700
Message-ID: <CAEf4BzYo12vao0GPYPC=3SMTzc5c8kZSFCE+D63ACgtjs7QhVw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: assert link info uprobe_multi
 count & path_size if unset
To: Tyrone Wu <wudevelops@gmail.com>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, mykolal@fb.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:07=E2=80=AFPM Tyrone Wu <wudevelops@gmail.com> wro=
te:
>
> Add assertions in `bpf_link_info.uprobe_multi` test to verify that
> `count` and `path_size` fields are correctly populated when the fields
> are unset.
>
> This tests a previous bug where the `path_size` field was not populated
> when `path` and `path_size` were unset.
>
> Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f3932941bbaa..a38cf2a999fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -417,6 +417,13 @@ verify_umulti_link_info(int fd, bool retprobe, __u64=
 *offsets,
>         if (!ASSERT_NEQ(err, -1, "readlink"))
>                 return -1;
>
> +       memset(&info, 0, sizeof(info));
> +       err =3D bpf_link_get_info_by_fd(fd, &info, &len);

if (!ASSERT_OK(err, "link_get_info"))
    return -1;

?

Other than this, LGTM.

pw-bot: cr

> +
> +       ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
> +       ASSERT_EQ(info.uprobe_multi.path_size, strlen(path) + 1,
> +                 "info.uprobe_multi.path_size");
> +
>         for (bit =3D 0; bit < 8; bit++) {
>                 memset(&info, 0, sizeof(info));
>                 info.uprobe_multi.path =3D ptr_to_u64(path_buf);
> --
> 2.43.0
>

