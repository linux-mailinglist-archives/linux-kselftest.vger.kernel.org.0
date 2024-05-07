Return-Path: <linux-kselftest+bounces-9601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086A8BE64E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FB31C228A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769215FD0D;
	Tue,  7 May 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QytjDPrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC815EFDE;
	Tue,  7 May 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093062; cv=none; b=YUtx1KeEiAyV+dvc6fPZU5kNygnthfAkcN6g7EZ9Fr7wivYwl3ou1FapV/RO/K6FCzFYpliyQlVKjSNIj77HPd+EK3AFV6PK/YcinJFisJLloUcSeUA1nz46AgPD58HxOdM06a5qZOMaCzhIeQ8LxkHPwVO6fywzOVri52S7od4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093062; c=relaxed/simple;
	bh=MJcYisYTisx12c9+k/4ROq+EmyGFozWAglzPDCQ8LYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvDrCVKw5OiASv/ait0lD1I2k7XZ8Tb1HZ2Bu6QlgPBiKEWIq4AiR9TQGaGJWFHhaOlwQeHeikxZCnHer8CViicrD/Hr9PFcbApR/6POWnzFTpqSZmFWV5sLtVNXEqbx8j3QQthrUEI0X3uHNiOOT1QusQrtxBSA8EtG4ttD9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QytjDPrh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so2285810f8f.0;
        Tue, 07 May 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093059; x=1715697859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMp6G35qfDMIFLx3yZQGEQxUo7Vd7yGH6r3sL6jUUss=;
        b=QytjDPrhT7y5jZAkXuC+OpR7m0JlHYuMH4Al3MOrVfKUnvmgnBR9tYwliZpO/w6KxF
         fwt3epGKp74nXjRajzpRqVKXXiH8bpzqqNdKawRdlxU86yM0/4NQrU9achAfdyf0UcTb
         pcwDbDl9Ooqwm8OTywn4z9XGG3p4JUHJJWQAMopnd2R0fZKgc0CcnEzGLtVt/8NrB2Oq
         ka/fRPAv3nDNUAlrkw9p6lWxdZxCJKZi9wRIGNV8hNIP4XRQMBi0LQ16/pcQWgVhhh7j
         J8KJvRBdV6uaAq3sXcYv/rZ2EwFgQwQlIsVydckTdqlZTWqH7UJQywsxyWHVs7scQZsF
         9pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093059; x=1715697859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMp6G35qfDMIFLx3yZQGEQxUo7Vd7yGH6r3sL6jUUss=;
        b=QJi/v048EGBz9ISProq7SiRHC5+xs/ko59HIyr9x04vFD2pwdIxKuARlbJNtYw2WXV
         SZUV2DVICAa3NQ5b79KJ1Vk2qJUP/pRelpnZHewJYG/FX7NjlE3lHiWORmjGxmNmyCzt
         mwCIVBUNq6q+zcPLuslVlScnqmzBJ556KynyxJ9dc/f79nk1FB2QhIuboYAybl0oV1yK
         kJcSFyBxQTRRmNTdZ8czhTm5j6H8DX5u+uiv57cxKKNjzVzyrsonk036u8K1YOy5quay
         0wNl4dwvl9Fi9vIz2LUwdho4z9eIlnpyQCGT+xSFCzaxYGq0baCTXGI52uINSvX7lpP0
         xZkw==
X-Forwarded-Encrypted: i=1; AJvYcCXc7Rl+YllET3tiyhMm1JzfhnXvf75wrc3XvxZwwFUkLxasc/SlBxtop2aVsAaMA21uO6eW0XvvJ4X3KbiiaJfasfSh5v3S1y6mh8pAuLnifwZlA/jKY0kHpGK1yu/U98RxRGkeE2XkcsjMtFePrXtNvaoXa3ml4KJwP3wUDoDMAvrCUVj1zC3i7l4C7lxPlAv83WvKzX61Ckik
X-Gm-Message-State: AOJu0Yyi5PSbj2qo/EHIa97mk0fmCBu2ycZ1KXbo2NP0qHuxllcNBLPP
	wrCOjgVAmyc6wov9y+7MvNI0Y8I/DiBUcAMsfVMfq3ezRHNi1He6oF78DuJQkc4LclRTumpFhcf
	JkxE+EFMEhZFPnaFBOPTADQPAjl4=
X-Google-Smtp-Source: AGHT+IGk49uH7ZoboBcvIRsYhD4hszb/KCw/BsklZO7vFWGZC10XurT1JgKe8yLt1pp+x1aSe9iYc42YpisLFYU8qk0=
X-Received: by 2002:a5d:434a:0:b0:34c:8cbb:d6e9 with SMTP id
 ffacd0b85a97d-34fca8116a0mr14105f8f.71.1715093059114; Tue, 07 May 2024
 07:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:44:07 -0700
Message-ID: <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
> simpolify the code.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index baf976a7a1dd..9d1b255bb654 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -347,10 +347,14 @@ static void test_mptcpify(void)
>         close(cgroup_fd);
>  }
>
> +#define RUN_MPTCP_TEST(suffix)                                 \
> +do {                                                           \
> +       if (test__start_subtest(#suffix))                       \
> +               test_##suffix();                                \
> +} while (0)

Please no.
Don't hide it behind macros.

>  void test_mptcp(void)
>  {
> -       if (test__start_subtest("base"))
> -               test_base();
> -       if (test__start_subtest("mptcpify"))
> -               test_mptcpify();
> +       RUN_MPTCP_TEST(base);
> +       RUN_MPTCP_TEST(mptcpify);
>  }
>
> --
> 2.43.0
>

