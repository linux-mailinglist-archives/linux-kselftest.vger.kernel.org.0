Return-Path: <linux-kselftest+bounces-28245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2BA4EEBF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961B93AB19A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B256525290A;
	Tue,  4 Mar 2025 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I23iwB+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF70156C76;
	Tue,  4 Mar 2025 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121342; cv=none; b=m8uXFvjymt7h0g0oQFv/H1Fukv4e2QRRmSBupAXhQtEk1I4SIRzkcwiYrwpGXeG4qcQ8lhKXFeTjga856XW99GxAHdrKkjvq6eVNQgKOaA9kKUGITqQoALN7pQ45468cgAzUg6Cjula/t9wG7D4z846xoBZWYVdNQ5ohID59XTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121342; c=relaxed/simple;
	bh=CUppMgeXCcbvhjP4sIZRp8yG7EIGuQhXET7WZdvw2UM=;
	h=From:Message-ID:Subject:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWiP0USw1ocw2HE+mAhHW5mTe38gO9+3Wx2nCtVOlv0KRGmcz1pYMFQuqqB9HZon14laeSsGSfKSgYfCJBobQXbEcMSL8a0rvj/cijunDovXxvBs8gy6m5dKK1Zb7bThUE0sFi4Og8SjVN6CklZTwhMunHaw3sylCDU7MQw4M00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I23iwB+X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso9984108a12.3;
        Tue, 04 Mar 2025 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741121339; x=1741726139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUppMgeXCcbvhjP4sIZRp8yG7EIGuQhXET7WZdvw2UM=;
        b=I23iwB+XP4KKL+LKVeqHM2MliAsplaR8vjpJuw+N936jzezFEqkTQpjubWrG1EU+Ai
         cQyk1546ZpuNXybaPLdkVs8DLpj0qlmA8lVS+f5AQrnJY1Mg/e0oFQ6oZQDjL/ib/vpo
         n/jdzDs0wN5bqcwR8fRfA+aV3wR9Z8y/uCBaffjvDpjzb/8MQjW9SGHsJCR5ocCMFWwe
         mSSwmDzm/8HPYB5E7wuqLaK2tBVcxaGp4a+J3vR15I6BAo6/HwkEG/M2gV9W+z6sZ69G
         j48mNxSrXRV9zb5sZn7cV+B9O2EXf51yJ9ANz+4QhHo3N6f/IBz7ewx2zoDVfivpITbb
         Uv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121339; x=1741726139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUppMgeXCcbvhjP4sIZRp8yG7EIGuQhXET7WZdvw2UM=;
        b=jzSM0qrlO/+UyD0Uia4ZTGcP5rn4Pq5f+AY0FUk4yJ0129HFPUgm0agNEaUZDYdCrv
         VjMO/oWLl0wUokCb8yPyaDGBYQrVO0FDodnc5Zd/Ae/G6sEn2XbD1ltchEkwijYOQGlr
         x2XT2/nDwSZ+y177KirSnMn3/lb0kC6CuDyZKzxJmRwYC2JYIZmXHCQ5QnlOZZaOZQzn
         Jx0U41oOtzROmwlaofonb7dqKHK23biR8VPTrem+4SDJdCWH6ndUuIwqkigLr4h1LWU+
         Yvs1Va33fwaZmwx0Xy5BqnjAQrTDDZInjz4jN8zUtqGMuBejaJ5xui+qginZXKiRP2or
         Tw/A==
X-Forwarded-Encrypted: i=1; AJvYcCVo+YFsJTzxNURRrVHoTm9FSEtaihsOHF6ykKzcmhfzdmu0ln1DhvIkcT+lSHpNdi9FkvyfF9ENb0N4M4M=@vger.kernel.org, AJvYcCXvX8rkDaPElDmJjkda1/Gef6ywl27eIZbyNizInMvWF6ZrdmLZxrl0B2p6+IwjzKuKhH+ScL94RSMxdJzpQvol@vger.kernel.org
X-Gm-Message-State: AOJu0Yyck9a8heMr1P84JeCUlsbrzMX1e9NXLEhnqPMgY10lbaiGy5fy
	/JGzcxe7eFi/4bNX5se1rX4WpG0O7YNwAqboGciM2fqVrBXa2dZ9
X-Gm-Gg: ASbGncvS1SQgCrETGNY8/hTAKqtrGbvrXwCGTtpj7L0gzUpPOzO01fptimtfSdYuSNP
	Qyez8xlY+ZoUQHS5ciyIHLVVIu3Yzqiu83doFgQcEGgOCF6RrUN+1jfMGW22Lwcvjxn4mCUkT7Y
	fQj8nJTYwpI+4DCM2PoT99ITOb6Vh9Yz9+b5pdOjob4DCn7zcLJFlzDVAknuT7wXdP+ugCosao9
	o37dtz1u5FRq3PBm3LYU/cY2C1hNyggBJjbHKn7bHGFO0+QVYpCYHcBCbHhcdbtIaLrGPz/lNFn
	tzzUpj4cYK2L/GWAXaWB4m6rLP3qP16ljZmDgkxXJHWXxydney57YjUPrAC5V2LfTm2ecQz2Il/
	KAVFD
X-Google-Smtp-Source: AGHT+IEji5cWLEG6+WPz4fVMoGqVE2U2DolxQZ2CJG7SEYeTQhuxwpLYPullgKwW2yLV1aczXXbTGA==
X-Received: by 2002:a05:6402:90a:b0:5de:ecbe:5b9e with SMTP id 4fb4d7f45d1cf-5e59f38a962mr477306a12.11.1741121338795;
        Tue, 04 Mar 2025 12:48:58 -0800 (PST)
Received: from [192.168.178.193] (g171115.upc-g.chello.nl. [80.57.171.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm8543988a12.53.2025.03.04.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:48:57 -0800 (PST)
Sender: Armin M <arminmahdilou@gmail.com>
From: Armin Mahdilou <armin.mahdilou@gmail.com>
X-Google-Original-From: Armin Mahdilou <Armin.Mahdilou@gmail.com>
Message-ID: <17b1db9bbc54fbb36e7e4c75e13d0087f038d6dd.camel@gmail.com>
Subject: Re: [PATCH] selftests: proofreading bpf module
To: shuah@kernel.org
Cc: armin.mahdilou@gmail.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 21:48:56 +0100
In-Reply-To: <20250210030455.284568-1-Armin.Mahdilou@gmail.com>
References: <20250210030455.284568-1-Armin.Mahdilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 04:04 +0100, Armin wrote:
> Fixed multiple spelling issues in the kselftests bpf modules.
>=20
> Signed-off-by: Armin <Armin.Mahdilou@gmail.com>
> ---

Hi,

Just a kind reminder about this patch.
Thanks in advance.

Regards,
Armin

