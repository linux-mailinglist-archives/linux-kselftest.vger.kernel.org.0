Return-Path: <linux-kselftest+bounces-12574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFEE915912
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3517A286AD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF81A01CE;
	Mon, 24 Jun 2024 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc319C1o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEB3219F;
	Mon, 24 Jun 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264736; cv=none; b=WfjVX1AChSz+jCVz+f/5ycRPnKm6gtIUeFe6PSOJg/5SP6CITaYZ5NjV/PmA3f4Wli1NAqxY32twwsyzjrhREaGsC4qZI42/PoAW8yc1wSw4lXh6GDQygeQ6pkEh6KyVTbZag/liJJcy1m9QjxdB0z9kG1PlkPkSvQQfaW4kt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264736; c=relaxed/simple;
	bh=7YkI3p0+97YEEMVo9b4yAPsaNw82EOsoaFWOHWmtzXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2DVyIo7Bn+x6il7GwQwooPCBBZq2U0WXOxXESIUu2xLaNIpRLLG7/5Rw5ADtUeUrZHZn2uyxCh7qjcf6nfnQJs32eqARUFdOTcziL+cFPgkt/J7PH8edCbqsGpzU4sV++L6QjTyinDniCI0cUx4XyVIacRUiIAmBgSuF8bbSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc319C1o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa2782a8ccso12688735ad.2;
        Mon, 24 Jun 2024 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719264734; x=1719869534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7YkI3p0+97YEEMVo9b4yAPsaNw82EOsoaFWOHWmtzXg=;
        b=Sc319C1on3HdtNYRquwmWeki+O/tRzM2FFeOtAivEidM0j/bod/6XPBvOEUsa+JBt7
         C2i5jfFSpSOKrvjdG9+hjoHr62aKA8IGLdnHiLfDFP53Uesc7EOCAW0iwod0X17ls+Ol
         jcINimlkGPlRShQ8FiQfwN7+TR/3nEHdO1oNBBaBR0K4KiiFHRqyQEyXzreX364d1/yy
         7wbBbis+v//fhpN8RxkFhv/d8jEUDOMSeQcR73Soz33q7cmN7paqwAnzqP8RvP3j1rvc
         1ew94FSeCMnhAB1dFrvshh43BsjzxhB6QqDbMXMA6mxA3V/yrYgdreNTIJUxK3GBkG6A
         K+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264734; x=1719869534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YkI3p0+97YEEMVo9b4yAPsaNw82EOsoaFWOHWmtzXg=;
        b=qphus8O6+8MnnF3ivwzNUXaHvi+UJaDrHc6xdIJDU3X5H1Y+e8j46TvLxxXknq27zc
         ImHlFY0Uw4M8YBER7Rd/2tqWAfoJH4jqjj7MpNzi/bSU1pA/W/fdW8y9cg0rrmWq2GVB
         OLExGU0GvU37Cdu7QgFwXARcvhevm8ktIlS13a30SwZaDeGuLkJYtLoi14V9tZXJrTnb
         QI1cIHmoZ10oy2dUqfdJmahj7TOXrshOGTpNhFiNvII0lHLZtV8yV9f+s0/53jLjYplT
         KH3LbAw7TuyCGXo6Gr5nF0PDBjD0Q/Q0r0zVIvQzVST1OR7iZEPE5A/Mvg+yIfuLo/pG
         5jXw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZSMlV71eGovikiXY1rFKzabpBiLbYzR9OyNbYcUT7PzunQ8yVcraHsbhGkDIGjMy0Gus+hcPJDrPr6VeBlZEtUbz6eq8oB2YkvuT8Y075cPNn54xbd7SxOchKb0VR6RA2sdJ
X-Gm-Message-State: AOJu0YxIWSpLrvfjKAceFm93f3K5aANRkkH/xZ58Cwt37ULZLM63qzsl
	j7nDMFKGKDV+cgpQdmFq3NNgaYJF64bbZB/XVVNjNMKoIV4reevA
X-Google-Smtp-Source: AGHT+IErw7zyQsHRjOWMJgtz+BZbB5qcnVfot+hhI5SXrzsuhrbDUewaqvbHRzdxW8M8er+JxYoYcg==
X-Received: by 2002:a17:902:c406:b0:1f9:fe4c:9d9b with SMTP id d9443c01a7336-1fa23f1f2f4mr69116155ad.56.1719264734261;
        Mon, 24 Jun 2024 14:32:14 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb320bc1sm67832345ad.89.2024.06.24.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:32:13 -0700 (PDT)
Message-ID: <431f77525a059d57106b1f2b06ac7af3d14519b7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/9] selftests/bpf: Close fd in error path
 in drop_on_reuseport
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
Date: Mon, 24 Jun 2024 14:32:08 -0700
In-Reply-To: <956fc734ac44a0b458b8819960cce2ee5a03dea1.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
	 <956fc734ac44a0b458b8819960cce2ee5a03dea1.1719203293.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 12:33 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> Server 1 fd should be closed in the error path when update_lookup_map()
> fails. This patch fixes it by goto "close_srv1" instead of "detach"
> lable in that case.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

