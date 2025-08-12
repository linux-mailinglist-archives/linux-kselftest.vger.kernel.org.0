Return-Path: <linux-kselftest+bounces-38794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B207B22E70
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD613B105F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F6E2FA0DC;
	Tue, 12 Aug 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLGGXrE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAD23D7E3
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017807; cv=none; b=B6mzu0k6XORJ30kMcXJ/+iap7mwTHzsRO8JS6TGsuqLXA3P5NYN63zrgfoSCuT/+VDHYpiNFrk1WrjEqNrTVQcpk7OYe2R9Ir0OjbrBxjXFnRpIgRneXdf5FBoRAtC6YWz08gGql8+mX8MtyUcaXn0TPmpmdJDsrxIYA6XkXqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017807; c=relaxed/simple;
	bh=vrtEVYCZGAtmjgD47j/50MwVzOUCeaFElaKBka8omMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4vWTopvgt2z0tJUu85XIHrPSTn8rj6CTCfDiNlVpuqcCeaXKoMESyTuROYgrh0HJHNuM9luLPbvhVfdstcrOG6SCoL3sjDAwWe+KZj+Li8uWdlm+wCGLKwzdgbRaqM55+FIHNfoc69z3LpzQnl4B8MC1nhVX2Ey7Du9rl/JOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLGGXrE2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55cdfd57585so266e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755017804; x=1755622604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrtEVYCZGAtmjgD47j/50MwVzOUCeaFElaKBka8omMc=;
        b=LLGGXrE2dmnFHuRrBVp2yNHoMP1Qs3xsLcyfAnglmaI3o14SVte2bmF6skD2cxhyNS
         gzwwbUMjz0Aj9LDULxZHXvBXsXz/xxfyjhoiSZcWTwkCv+SC92FDePYX5C7N+24wzci6
         IGTi0OKNbfPyxUL4zqBBGi39Kdx1mfH9f2LDTdkcRwXrHRZBc7PFEQX4UKQnHYrhegbi
         r1WWowsYOTtBMx5iV4YgwgIwGfxHiOolN54MfkgY0VaY1gaL8a5Yyq/KnGBOyrah8OAH
         zIDx8VcnrVHFGcHYLBmSijbIsv5I0ZRJoPirmkma4b6cSLj7GDnoEspcJqOa1t7perwf
         TPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017804; x=1755622604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrtEVYCZGAtmjgD47j/50MwVzOUCeaFElaKBka8omMc=;
        b=RWhqkKRVHbs6BZ1DDn0GIFCTatzA9NY8u/CxVxFexYdyUehWB1Q6qfjaG6s1jd0M3z
         SyUiBt5fecKOAxAVGC6bz8DYJ02xG7d9kVT17t/FmIns7veb6e2f87pFryk15mn1hFWE
         iwqD5ad/8NEBCZfVC98hlB6bu5fR1sk5CslLJGQpnQ+3fKuQv7SmEa0pRDxfjB9VyqlM
         nOg0md02S1gfWkibz1eZWEsNZr3lrdXgJJmkRFGsAFauGI852nsotA+owoy/80AnBL+L
         y2Vkr7HgcgerFOASN4sffIq/hBov6q73HYSTmkVMqZkTrtI4mVwDs86Z21fcr2OBKl3H
         kt9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5DwJN5/+IqaNQmHgH4gOOOMFd8POl+RaFw43hESkE0V1zGOwTUEPUydliXGKNDHRCVXLMR6nkQow3b4pvSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfOhlKsc9H7neYefek21LJQg2oCp6u+vQ0QW9dtCSn3fFtULr
	q5ZYeIedjl4egJK8r6xF4X69cQFCM1F89k3PztFa/T21QKlDcguLRzcRYxZf7gJi+Azt3hZOfpK
	wldMsgCKEz9/aQAproLfNKSJtIqnnIb3R7AnJvPrH
X-Gm-Gg: ASbGncuVI6wfHc5O3l/gsYq69+OqruowxxrMDC8/ljIE7MUPLQoKyZu6o9iZvsusp6x
	h5E++1X1QTZhYsWGgmhAvxS5/zxiyAMOX6+r2Q4Ly9up7Bqs55Ao/fb1i8+Q8E4JEWyalj8AoSP
	ShtvaUQukH0tF+yfCVTS4J1W6aBOqzVbMrLno1TEll2Iei0zjk88i5M1D5l08x8QRccICEiYrdZ
	4V8RvXz9A6Qy4VHJ83wt76MjvSS8/C6bmNzhw==
X-Google-Smtp-Source: AGHT+IGj+MwSBW0GzCwXET59eHZbSfHtBy1ydi+MWfWetQEamtgZZW3pt2fbjVYXAeK1EjsRNf8pd42QYOtscw2aA2k=
X-Received: by 2002:ac2:4f16:0:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55cd92926c4mr444025e87.0.1755017804016; Tue, 12 Aug 2025
 09:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-2-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 09:56:32 -0700
X-Gm-Features: Ac12FXzolmObLNOQUK7kzAVoLhGNGPgjYQpI2KT_HDG4CcgWFHzfkWXvkHfrYiY
Message-ID: <CAHS8izPcZzyxxVtszv26JOJBOaZhBt-VN0ut8VT=4o8xogDPjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: add configs for zerocopy Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Looks like neither IO_URING nor UDMABUF are enabled even tho
> iou-zcrx.py and devmem.py (respectively) need those.
> IO_URING gets enabled by default but UDMABUF is missing.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

At first glance I thought CONFIG_NET_DEVMEM=3Dy could also be added, but
that is def_bool y, so it's very unnecessary to add it.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

