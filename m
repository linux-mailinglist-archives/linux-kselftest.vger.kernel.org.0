Return-Path: <linux-kselftest+bounces-12473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADC912EB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1241C212B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957E17B431;
	Fri, 21 Jun 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er+k4xo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050017B424;
	Fri, 21 Jun 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002681; cv=none; b=RLz20//BDCIBQ80qbbO6xrAHOye9m/dYPL2Fvji4WJK5WkHqDtWWyT0SNJ7EWxmlql6Gnk8Hjfvz0GtsHoAZzNp2vFln/m18jgBiYEUDYVUTAjmH4bISw27Kq0yW8hfJBa/ig/swD6hHUzvTX30bRw4Gd3Tff3QuwHpqwUiIjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002681; c=relaxed/simple;
	bh=mWNviTAARWcipCA1rYtsF696M0LfAlKi98YsQ9vpuD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLt2bFySsaLdTb16iVVALmnHBwjeeDqpGDL95DBFjqw2wrJDlkrGbaEmWHSafLGwxXiCG7OH9l0DHEEiqpHtmAGaYg/5tkegzGDES0ov0jfOxgzUCI9tW2fnwYMIPL9qTTq1l1TzX2ZjSUCV+TDKMDqxNLzLjAuHHPGtZ+sO2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er+k4xo1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70623ec42c2so1843125b3a.0;
        Fri, 21 Jun 2024 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719002679; x=1719607479; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mWNviTAARWcipCA1rYtsF696M0LfAlKi98YsQ9vpuD4=;
        b=er+k4xo1bsMkGyOceCk4NeWPGsFVefqnyPDQ9c/R0+HeRnisIt2svfUv/4wlhJB+Mt
         I6d/smjeh98Gok3MRnd3TjcmIsMK1nYS2IbqsRLyeKGtMWNZP26FHFMhlBjsbG48VnKp
         T4SwWYFYn5EjdyDBhBi0kRiCRqW/uX7w+SqZ2nBqxC/MNi1kd0ivwFTxign6yxMCQVMk
         pp0TPi2mPfruB8nzemRCnjz/QAjY8FUsWKmjGW3kpLgGYhNnohcxWUVrTKKj+ks4Be/f
         dmD0KocSzvUQdfzdD26zOQU/LbKofIEO1uu+cULGASdozL2avpJo9lXqu38ixosvlYM1
         PKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002679; x=1719607479;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWNviTAARWcipCA1rYtsF696M0LfAlKi98YsQ9vpuD4=;
        b=klvhQG1Vxfd6BBbUu92fR9MiDghI26hjtX/KO9MMb5hIawyzlshh5E4X7H/k23mYHp
         KoJSztEUaN44hebpdrrzmvFkxrkHt+aNoCtUTtHokxpoqK2QgI4qPA0X1zU+Fa6osEGr
         80fidVDu7esxKFlcJDeZxxVzYfbOveWzZucdGO1Cb7aw7UCG35ZGh94q8nn7Jo4sOrar
         69QjUp77zYb3FzqsGdbfgr3kDdfqtUe5kfNXc6qfBCdlkM6jeQg7jo7pSoBze9YHwuNA
         HcLmAM1F2GJDeN5F90XYGPU3JGP9Fbo6u6G7gdpVsRUtbFfWUNw2ow0f8UboadpdGYLD
         91Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXeDsMgP2f7TiV5W1mFQRcUmm50Gr8QTR4N6SMfwvpUtqPIm2QkB6N1pbY7eEiEpg9uL+IgNZamQj57EMJ526aIEJdvJtMZlmwMAqm7cRwfXU+2Fn5a963v/s/mMYktA4UjMhsH
X-Gm-Message-State: AOJu0Yyw3FbCf3e7CVLHG/x+xsTKTc/Bwf/Vgh6gtf2IUL20lP0NyuDk
	+qZjcPq7M2v1mn2Ls/whCGEz8eFfZd0VnzGd6slRX7IOO0/Da8Yk
X-Google-Smtp-Source: AGHT+IGtewsHPjIMUaDugOQh6f7Ddntr696d4P5OArzXNyX4kpQXPXhkha2G5X2VeIHHRqM8Zzn3Yg==
X-Received: by 2002:a05:6a20:6a27:b0:1b4:4ed4:91e9 with SMTP id adf61e73a8af0-1bce6411203mr1287632637.3.1719002679000;
        Fri, 21 Jun 2024 13:44:39 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f4dsm1525973a12.58.2024.06.21.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:44:38 -0700 (PDT)
Message-ID: <0390d6171bef0f62b2fc45fbb48ad7ecd1315c76.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Use start_server_str in
 sk_lookup
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
Date: Fri, 21 Jun 2024 13:44:33 -0700
In-Reply-To: <519199c91c2b6adf52c5cc35ddb81c7be45c85df.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
	 <519199c91c2b6adf52c5cc35ddb81c7be45c85df.1718965270.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 18:35 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> This patch uses public helper start_server_addr() in make_server() in
> prog_tests/sk_lookup.c to avoid duplicate code.
>=20
> Add a helper setsockopts() to set SOL_CUSTOM sockopt looply, set
> it to setsockopt pointer of struct network_helper_opts, and pass it to
> start_server_addr().
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


