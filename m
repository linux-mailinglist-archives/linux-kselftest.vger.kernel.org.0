Return-Path: <linux-kselftest+bounces-13332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC6C92AA01
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B499B225CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EEA14F12D;
	Mon,  8 Jul 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrY56Z/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24214F110;
	Mon,  8 Jul 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467748; cv=none; b=kplrkqy68RfYnH4RhB/fu5hpYYJ9/JEODxe5nPYueBjWW6y5+W0mO1qs+MmhTqVacQu0IqgBzMMfi/ZREYNh4Ddgkb439lCIusoygPVPRwgRFXZf7IC27ME4FaiV+yd9KRt2oL1JvvoWNxCbPpOb7y8x8CdtQmkuTDVI2Q1623M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467748; c=relaxed/simple;
	bh=EjCnInZrUpakJizqV/Wa7Wd14mr+dpBelApMqdIJ7h0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CabawbZeFY94w1PSEm0ki2P9VF1vp/Ap1ut1ai6tpz8tz87ve8V3Y7T5NC2/HxoDlGcOsYrANvyOdOcDyKzj9f5H1yGUKAQmKd8QGsVKn7tEwJSkSO9tADBayCb0JzFghxJFl63h8NIw4+2Mul+NYIuOZVWduf4qP44VThwDAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrY56Z/9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c97aceb6e4so2999016a91.2;
        Mon, 08 Jul 2024 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720467747; x=1721072547; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=soKm400aczGjfHq5MLevYckHwVYDrk5bFcWeV9IvIgA=;
        b=lrY56Z/9n/RIGwfQdUN91kZ72r8UNLKAhVSp7YGxCEwTW9aJJR8YngyobfCqRZ8GOM
         6uZSsWLAASEFnBDnHIZEIDjZnygxTn5Yna4HniKG61KHhrCfigxG7b0vMpUdWdHjEVKz
         Hkl8iBR9X3cZ0h7wVfTiiuI2yGcDSsAjfU/UEgNP5e6qoiE2kVKTsLs5NU1S8kguZhO0
         oOzQe4CShIpMiS4bfUmP7+bvlsSQcD9gBEjFtzd2vzpw7yU8c6U5IK/oUudssnG0k+qL
         AYUhDRZmPVX/KMwWx5uOInMrOn5GD7sWZukHZIAKTqXHEII/7OApIEZnzUQQ08Dv8Dhx
         8I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467747; x=1721072547;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soKm400aczGjfHq5MLevYckHwVYDrk5bFcWeV9IvIgA=;
        b=YCsDBxRyFgi4ipFc7A2Jdvg3TROY1j4WRccZK/xXj5+zZZLvnJUDpjwvBgni9vx4zL
         Fzp3vZCMiAoi9cPz+LhAOErRWZ7dhob5l92Olp6NfpnjiUHOB6CJeQKi715Gt0DaRGgP
         32b/wVTXwSDi5DUPc0Xx/rmJ4WixfM/5yr786rUKum015RoNcPIuFLhzENXYpUcQacUJ
         0Kfdd5hy6rTW/Hkz7Yq8vDuZakShx8a1SQB0KecdH4KUIZUOQu761EWNDi3km0BsKR28
         UAHztdDuLtK/GsLj0FLWGquE9W1m4re5QVzTdyteORmd9ZdQ48YNKZXdkenoZczzRQSL
         eaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/BRuoojXpb/7gf1Cm25J2DduTl3eFjorAh8C/V56V2nfxJFb7oERH/Q4vTzu5Q4pxH6UOyo6lUcAnaf5wK3d+FY9dIuApjysAFyp7sgKc7JgIopMqG5m1K6TNopvaS6AblyKX
X-Gm-Message-State: AOJu0YwwKm7xaHi6ek2lUH39YepxNLp+alwIjDFhpuJgVizkPxq2VkrS
	vmAatpiAaveRo39x9m7oPnuonSbvBW7z66DdNeAN2N0IdOhu2yZy
X-Google-Smtp-Source: AGHT+IFJokzXZilA0Vj6E3OlKMEidIC4GtwBNipdwdOFGfsEacTt2C8Hdf7xyGM4YFyTTsFQMdGP2Q==
X-Received: by 2002:a17:90a:ba98:b0:2c9:7fba:d895 with SMTP id 98e67ed59e1d1-2ca35d3a632mr559423a91.38.1720467746954;
        Mon, 08 Jul 2024 12:42:26 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352c1b31sm396192a91.45.2024.07.08.12.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:42:26 -0700 (PDT)
Message-ID: <ef98da9d2a4865e6254e1ec9ab57636dfd326f10.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] selftests/bpf: Null checks for link in
 bpf_tcp_ca
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 08 Jul 2024 12:42:21 -0700
In-Reply-To: <06755f462ddb7bc9f734f105e18c1d77c03811cb.1720146231.git.tanggeliang@kylinos.cn>
References: <cover.1720146231.git.tanggeliang@kylinos.cn>
	 <06755f462ddb7bc9f734f105e18c1d77c03811cb.1720146231.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 10:38 +0800, Geliang Tang wrote:

[...]

I think that this patch is an improvement independent of the patch-set.
Please submit it separately.

>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----

[...]

> @@ -489,6 +494,7 @@ static void test_mixed_links(void)
>  	ASSERT_ERR(err, "update_map");
> =20
>  	bpf_link__destroy(link);
> +err:

Nit: there are two links in this test, but ASSERT_OK_PTR is added only
     for a single one. Also note that bpf_link__destroy(NULL) works
     just fine, so it is possible to initialize links as NULL and make
     a jump to cleanup block w/o peeking exact position within that block.

>  	bpf_link__destroy(link_nl);
>  	tcp_ca_update__destroy(skel);
>  }

[...]

