Return-Path: <linux-kselftest+bounces-29341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B81A6701A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6CB1720E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED978205AC1;
	Tue, 18 Mar 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRJ+VON8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF47202C2B;
	Tue, 18 Mar 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291093; cv=none; b=Q62zZWjORwF3wUyw//O7iAadYL43XEDQZhtqFY1fVr9C4PjjVdDB+TdSgo/sTeVK0MmEL+Dq0IlxKtQv94P8Fhl4chGZEws/dGPCZM5d1GXV3SJPXVqLgSF9nM6QAxJevc3R3Fog3yD08MeiTR4ZwKUa/iirA2gegtyN3FUAi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291093; c=relaxed/simple;
	bh=9dseCUgfawFHDhoNUQBKZC9vwAGc9hCxkFUNPU0iZpg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDgu6RcwcaKQPVAsl8K4x4W92IFEiENAUkn9aYlA2BdWwDoquvjz63yo4ENCJUe3y6hSz6xga17lACMOSo2PfRI5gGGAelWcljsMZ7COU/K1qcBK+K8MilRRONqQNHCW4CCCWvBMVjbdHhkxWpzCjCCjmFdtoJwBXk9HL/QVSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRJ+VON8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac34257295dso142731966b.2;
        Tue, 18 Mar 2025 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742291090; x=1742895890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s04vWbS/+IELd1isfxtGM2wXxsUsxWYm6LzkaytObnU=;
        b=nRJ+VON8lZNs5yFAAWd+pWzT6b5WFj9XU6tdQ3WVlSPPSb1ap027ojzWoXvACtJpgg
         O5C55mzEbzFPY+HlqMNppFNHQ1ymGtRsiAHXD0GSJ+7+IC7EVYrIu5Kfnq8sxtvPJA5q
         Moe4XNA+BUGMWYUgzNiLxRnsPOPWGTJwbFx+mKqQA5G5x/8b+Z8E6fOa/fFyCX9j4PP9
         QH0nV8uKtdZZG7dnzsLiApfnJUdbFeG1x7ZNdXoKKhqIU4a+2KB2seF090YK5Y8Qorgy
         rJUj9yb12TryfrF+f8cS2FoaamBZIuIdkVyGLcG4oNZx6WVzd54paToybK6FXrad1k/3
         Rw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291090; x=1742895890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s04vWbS/+IELd1isfxtGM2wXxsUsxWYm6LzkaytObnU=;
        b=wKNwnftCKB6lHf805pcHS1gxEU2/+P7JF/YoVMQnyLyFMLJIXLOPrZFwPRhFdYLfhV
         rZiVUxqpJdAqPSDXtIkL3EKgK8malpUNfeS1FUhmcpM5zajibzIYwh6esiQebH9oURPZ
         yqcjDQOV+DtWu4i/2fdI4/s1+GmOFbavGfTaeA4agNv40N+Tt4NpgQX0QuByWgJ4+FoB
         8vtaMYJho0vkAav6wPpwD6KeaIOpTAvyE5TFlKHA3PvJb1sG9BcZjEtJOA7Rxu/gERCs
         vEEAYNX/Bj4W3LimTEQBzdPmlEu5s809bzIfw7XhAjKSWpoKju0vCk6xlsnUqhZ5E6/4
         xzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4y4mDURpl4cvxxQljRx3H10GK1RISZ8obCViSzlapXe5XYmeIcKxtbRUwrkHZz7AjJe4PTO3H7Mr40Glv@vger.kernel.org, AJvYcCWWLZ+tLgtl+XKuYiXOACtbqXIQHPZXQQW0o89A7KEjo2NsB+jtdzgMouwG5vG/zotaJRk=@vger.kernel.org, AJvYcCX8bNe8dXNqQojNt+zfWOc0skp2og6lWYJT+rgUsRSf5w7QSqAsyI72jfO3ZuflHirzu/i8iRuHt8VYV6gxKE61@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ceGVqlJoSK/XnHL1PPE+72Bm901r5sihPXZQACxYXb/mDb+b
	Lu8ZkknvuPjeBYPeAqomqrtqgNRiJstiZAef+7lgrFwlhcwHXXvf
X-Gm-Gg: ASbGncui8Ymzw6PAjp2YhYIJOdA0V7Dv5fGzJ78xys9KNjMZRo6mmbRLm/1p8Urye8a
	H7LWxZpKDwi7RNIQzBLp7mmwgtMq9+043l+lDfLH83UIomK0KnJjo4z4CLAMETqJksJ02PR4b2J
	AiYyKxBeMsTFjSwIc2pzV0Gq5IEc9hHU0U2mYzz9YCcJfjzBP4bGdMl4P9sZWJJ4bjZlXCDdBZa
	w0FzgCBv4XyGG0msb+Zi5OLb+9IpNbLQ6gyzjbAFazOsZcZJRhY5doWecY2HGcs1qCK1zVKsNLA
	Z5xW5mOa3eiKDeakEiOPIaeGnjDQ0gs=
X-Google-Smtp-Source: AGHT+IFepVwFcfXs2vuS35E7cRvymbh0mZHbilkMAE6IL4hvEQz4oLQRWeCIgwZ3GbrhCKcxaRLFHg==
X-Received: by 2002:a17:907:c27:b0:ac3:4370:f6d2 with SMTP id a640c23a62f3a-ac34370f77bmr1085273166b.4.1742291089794;
        Tue, 18 Mar 2025 02:44:49 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cdec8sm816734266b.112.2025.03.18.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:44:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Mar 2025 10:44:47 +0100
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Sanitize pointer prior fclose()
Message-ID: <Z9lAj-1COhR82P_O@krava>
References: <20250318081648.122523-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318081648.122523-1-bjorn@kernel.org>

On Tue, Mar 18, 2025 at 09:16:47AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are scenarios where env.{sub,}test_state->stdout_saved, can be
> NULL, e.g. sometimes when the watchdog timeout kicks in, or if the
> open_memstream syscall is not available.
> 
> Avoid crashing test_progs by adding an explicit NULL check prior the
> fclose() call.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/test_progs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index d4ec9586b98c..309d9d4a8ace 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -103,12 +103,14 @@ static void stdio_restore(void)
>  	pthread_mutex_lock(&stdout_lock);
>  
>  	if (env.subtest_state) {
> -		fclose(env.subtest_state->stdout_saved);
> +		if (env.subtest_state->stdout_saved)
> +			fclose(env.subtest_state->stdout_saved);
>  		env.subtest_state->stdout_saved = NULL;

nit, setting to NULL could be inside the condition

>  		stdout = env.test_state->stdout_saved;
>  		stderr = env.test_state->stdout_saved;
>  	} else {
> -		fclose(env.test_state->stdout_saved);
> +		if (env.test_state->stdout_saved)
> +			fclose(env.test_state->stdout_saved);
>  		env.test_state->stdout_saved = NULL;
>  		stdout = env.stdout_saved;
>  		stderr = env.stderr_saved;
> 
> base-commit: f3f8649585a445414521a6d5b76f41b51205086d
> -- 
> 2.45.2
> 
> 

