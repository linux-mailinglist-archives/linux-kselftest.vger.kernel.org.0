Return-Path: <linux-kselftest+bounces-27803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3DA48B1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA7E3B6F1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D4E27128E;
	Thu, 27 Feb 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPc9c/iY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782D1DE2A7;
	Thu, 27 Feb 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694114; cv=none; b=sILYZ5Oksr3AHzpZvVBz04yAQvz3xAwx5FE/mgl4p8su/mCVSBTRrhdz54LGXXrfUWKi323h1ZKLMqc3sLdyza3x+bELg8YyJp2um+U3pY1kdeAa+LCAZzBVgaVP0xA7XYSWjOfBRbX0NXAABQWUcvOb4cF2uk938ID2H/ftM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694114; c=relaxed/simple;
	bh=Ya4qVCIKkvKe+lGvSytM2sqLi8oWybmjEa4BYB0T1gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d52gp/lsVSglnSypZrZTJQAQCerTKsNcLRqR6TCDxVxP281kyxG96VsEDAykX6WZM6pfmh/91wKe7CyUlVjLrR4RCLnpFzyvhhTjiyO5Z97CvVuWDz1vMFs7Ppw2lNCLn7q7jQHPBMshGzt0Qs9K1/GOECow0ZqH667qW22APkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPc9c/iY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so828616a91.1;
        Thu, 27 Feb 2025 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694113; x=1741298913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGZUrwXESnrYSl+z0YVCe/i4oeHpds0PraptN6sp7Ks=;
        b=PPc9c/iYVZaGAgCDN++vacJqrz8gk4/6FQ+XLgCQlStstDsR59/+Enzb3YCA/7aGX1
         LJpNWrLah9g3v6+sYKXglLOZd0FpthO1t1nFqtKFoP/zcUD+Hr4ZL8riO89xqgFwTyqY
         Ey7X/7T3sAF0iM+53NTHKDM1B7oP8nERzRQ+WdQQp12XSSZ9m6EcKRkZS2y6mGKrwnMU
         lcHkFPYM3PD9l5SPCxHoR2k8xZ7Z19SyEzBoVYd1OEjDt3b7h+HqW5GIPmGRE/5Iiz7f
         ngM+XY6dgOpXS9GVVeJZAvF4sVAcWwRY3fyZhJHyI78rOuhVnxJB4airMXLoKuvyVvEi
         dDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694113; x=1741298913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGZUrwXESnrYSl+z0YVCe/i4oeHpds0PraptN6sp7Ks=;
        b=p55NOoNiB5SB0ZwgKVLbcffgSmBc2o8xkvHueitmgzL2JpEzqpXX0qSA1yIjxLuGnm
         M5LGuxQa2OnFuEY5IcEovdkLqSrYN+r8jQkZvQggKKctC3fgD/SmOBTpiwUlVHQXoaQ2
         OQ53E8E43v+33XEJ1Ky+sKqqZ8MAFle9JpEr1Z4Bw84xcQpIMigCJe0M7y69sCxqI8yf
         K3uE9GGSw2HGCJz+rs4ZNxBntFE/AT0L3E9kfNL0Ul2IgL/FYwoledsaS8svCJPMUn63
         68uLqCx4z5SAMWCMoNHpqvo0Ff/Lf0rdkYAejlevqZHgUwkX3nYoSoYNTaZWcq4xjxYD
         074Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTXP03y7ppfgdzhT6nc1d9ZEYaR5SF5mRu5T0q0yUyf1KRZ3Wp1QP26ia8LaNqAisD8/c=@vger.kernel.org, AJvYcCXdDuHpdjECS5T8nWUDcJm+9dZRC+Kpjg19MkYN8f/OP8F+iklgbyhslL/nnJ9vHnrv/qI4WScP0Q5HFOWI@vger.kernel.org, AJvYcCXpMcqQ0Ri19M1AUbL0R7t+l92l/we+naT43dZizrCX34HHAEY+t3Ge7jFmvOEF9vjh0BNXMgOwO39R/irmZ1Qf@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRv4GlBVQvHV/Jt6xqYt2zx2/H8aIOZcm4F7tT/33DU1kdKsC
	GUmy3mK6szpvOBJ1MUZcyhlrjaemg8EdHVvTZQy6XbQQqfD+SuM=
X-Gm-Gg: ASbGncuiJRfcySMwUyvZ7ZUE4q72u4s5Hbqwm04vYmF1aMzAxBwhTKXT//HLj0S+5b8
	7OiY8EatXq7p58+5E3UsSDbPv0+X5hrcHbUNnXP7Yw08UuUebU1CyBK3/FQ+/SBIxCcZncGVUKi
	ekaLaZAWr1d8L7TNv7oChCBKzcb0VA5CeZxTWfLU1Q/y2TWcUMr5jPknS78VNJoXuv+Mj+DhYro
	O4kJFavBWvYhOvnp0ktpE+Mx/OVz1Wm4N1tUFuP/TfpoTFaIfMiShtRdjaZGJBbTjxIXsXvQGYo
	B2PLxM8lxGNbSQq8UZeFTqPAhg==
X-Google-Smtp-Source: AGHT+IEJ7aycePp+9lT7H+/P2NL5K2dM8OD/iNM4WQdvVrwZ2TnKe7E8R2qFUh+mps4pjwEZ6qM+gw==
X-Received: by 2002:a17:90b:4b:b0:2fe:a515:4a98 with SMTP id 98e67ed59e1d1-2febac05a46mr1358858a91.31.1740694112740;
        Thu, 27 Feb 2025 14:08:32 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825d2b18sm4439851a91.24.2025.02.27.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:08:32 -0800 (PST)
Date: Thu, 27 Feb 2025 14:08:31 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 01/10] selftests/bpf: test_tunnel: Add
 generic_attach* helpers
Message-ID: <Z8DiX8MmJWvO5Ws2@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-1-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-1-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> A fair amount of code duplication is present among tests to attach BPF
> programs.
> 
> Create generic_attach* helpers that attach BPF programs to a given
> interface.
> Use ASSERT_OK_FD() instead of ASSERT_GE() to check fd's validity.
> Use these helpers in all the available tests.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  .../testing/selftests/bpf/prog_tests/test_tunnel.c | 128 ++++++++++-----------
>  1 file changed, 62 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> index cec746e77cd3abdf561cfc2422fa0a934fc481cd..27a8c8caa87e4c6b39b2b26c2aa9860b131a70a9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> @@ -397,6 +397,56 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
>  	return 0;
>  }
>  
> +static int generic_attach(const char *dev, int igr_fd, int egr_fd)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);

nit: .attach_point = BPF_TC_INGRESS is a bit confusing to me here
(because we later attach both ingress and egress progs); mostly
because the way attach_tc_prog is written I think. Can we move
tc_hook definition to attach_tc_prog and make it
.attach_point=BPF_TC_INGRESS|BPF_TC_EGRESS? And then we can make
attach_tc_prog accept ifindex instead of tc_hook.

int attach_tc_prog(int ifindex, igr_fd, egr_fd)
{
	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS|BPF_TC_EGRESS);

	bpf_tc_hook_create(&tc_hook);
	if (igr_fd >= 0) {
		tc_hook.attach_point = BPF_TC_INGRESS;
		...
	}
	if (egr_fd >= 0) {
		tc_hook.attach_point = BPF_TC_EGRESS;
		...
	}
}

Or is it just me?

