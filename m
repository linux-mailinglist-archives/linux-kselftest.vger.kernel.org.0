Return-Path: <linux-kselftest+bounces-39225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689BEB29F27
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F3A17ED6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE9258EE3;
	Mon, 18 Aug 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="H8UUTFuj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AD258EDB
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512954; cv=none; b=W9Z8Z+4gMtN3Ql8khPF6Shn4tTKADRELRUFXkNWjrQbCQcL4CejIiXYwvR1I4Y9xymfdIHFgYmCksh7J2f8AmBjLdrWkJHENF1VHjc/qJWlUj8V3U1gM2o+f8sNjQiBKHmsaIK1DLi7jhGOKb8jAG+UGxELAThFdTzMKu9Pcf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512954; c=relaxed/simple;
	bh=BhbysUcbAKjEA8/11kFRzX2E12IzlBavWPgZPsKEmYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=haEAuIVLcjs0+EqX19Ps+zNRc7Hjm0oJ4eI78UXUF3dHz+igkG/13jM6BxT2Z2MXAin+N7bcIPNYRuZbFImcvKzPgeLCMcldngNmOQ4CI1zPflmF8CGRk4FCcOXtGd2v4NEYf36hjbZnNJez4XFwevrTEoB87IxiuALlGAh+Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=H8UUTFuj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0b4d13so4694775e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755512951; x=1756117751; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhbysUcbAKjEA8/11kFRzX2E12IzlBavWPgZPsKEmYQ=;
        b=H8UUTFujZ5bOLN6tfCzFgID6wonxXrPF9cK8Z+ZS9fyfn7aGURLVqHXgqUfi0r1/vT
         Sn5ORcibCb9aNtRsE/3btDwWwqXJZGMUURJjuWMjBC4l7T9zXMjCDo1M57XWLJlakU+l
         i2xjswyTWWLeLqPI7PT19ZhfG/PayiG1TGLWAI9BpBnIVjtqe8FmsjaE4txXpr5y6qRM
         kBWo98qzE6NncAWo39DOGtkOl77CnZymx9LV6pX2e0hE0mXXBX6HaP2BTNIo18pCZ6r3
         bWRWDQzCLZj6P8Nz4Dyj/0QiMOQ0SPrY+hnQXZVGLZR3tXU6mpsrcrBxprzPFe2GmO2b
         aSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755512951; x=1756117751;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhbysUcbAKjEA8/11kFRzX2E12IzlBavWPgZPsKEmYQ=;
        b=se5Ts4IHbIWSW7D/1TlucSOcRHdo402LN9ZFDw3u6w5KkLcoDkC0myJ9szxQXM6Lv8
         B6Y0JUOVzNRfRck/iLEJETxsN/88gugnxBjJ6D7+6KyJr2fQFX2uaDSv/guM3qKSWGmA
         WdlCoFJoypawN2WeRGvelbdebjcMp/N4k0zrbMrtrMVWA85VlrTXRa9eoGEZZC/MRtaO
         +0Y7SIMvXNs1dwmBwWX6I3F3TxBpjrGDoCzcsH6CF4lwQ7IbL5luT4pMWMFlTsbo0reD
         C+1P9QqZcF5FbDXr3XIH5g1r29NzdUrixaF01SWSzqSweLRgcr9YQZKiVph05TN5b/WH
         tOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQZ64naq6Nf6SlPZEBbwEG+mMAHaJKw8VFYgXRbAPCn/CvQcNwjW4uakDXK0cw7dHS75GBJoMpcZbpcdiPoU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9vqrln66FLC1QB8YaxN9rrMDeb0gGvGpKFjVzApRW5RIYGy7
	yxfE54bb3rtleZtPx8AdTE112AOZ1ZkmTplNd3uMJeCB5f7ZoJdgqlKtA063+PLLBKs=
X-Gm-Gg: ASbGncvUOFXM5odr+zq52y13T9vjhsXJROBwu9D3nN8syY+K/vjF5oKU4K2e1ole0yw
	JYkbkKl5c1dki6f4Jr7Rpl5tjpsOhTW/GnX4H52EaUPPSGj/Sw1U5tPzVVOKTTYtGfD5Tj369XF
	1y/KHYi4TW//eOphs5/+dDHon2m/wwuihndDjL/rs/dezYs7wYFN6SN8WP0OfB/ASolxnilr7NT
	jtLrRuJtx22zg8qB5HpwyY6JhqyKA8sbHTgesvZYNQIL3LYpGGXu/5qNmbQK5WJ2MriVhCZKkpv
	CMRhuWfIPNzjzONi9xP+GAQkf1fpK1vMi9eUravHtLdId7Om7lse1v5tlX4dM0r7yG+0J8FNT3j
	eqSytCNS8JCdKIu/i1HOl7N2aFWS9FA==
X-Google-Smtp-Source: AGHT+IFey14ol9S6TtNaCL77HGtEmBhLvnjzcHSJ5a+JMC7yNb3b8k4bUmeKUn0yZJ7mbxDU1Gpejg==
X-Received: by 2002:a05:600c:46cf:b0:459:ddd6:1cbf with SMTP id 5b1f17b1804b1-45a21781fb3mr36116495e9.0.1755512950889;
        Mon, 18 Aug 2025 03:29:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:faeb:f88c:9e29:5aa1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a2232de40sm125126805e9.26.2025.08.18.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 03:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 12:29:10 +0200
Message-Id: <DC5HEJRMZ84K.34OPU922A7XBE@ventanamicro.com>
Subject: Re: [PATCH 0/6] ONE_REG interface for SBI FWFT extension
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Alexandre Ghiti" <alex@ghiti.fr>, "Andrew
 Jones" <ajones@ventanamicro.com>, "Anup Patel" <anup@brainfault.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Shuah Khan" <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Anup Patel" <apatel@ventanamicro.com>, "Atish Patra"
 <atish.patra@linux.dev>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
In-Reply-To: <20250814155548.457172-1-apatel@ventanamicro.com>

2025-08-14T21:25:42+05:30, Anup Patel <apatel@ventanamicro.com>:
> This series adds ONE_REG interface for SBI FWFT extension implemented
> by KVM RISC-V.

I think it would be better to ONE_REG the CSRs (medeleg/menvcfg), or at
least expose their CSR fields (each sensible medeleg bit, PMM, ...)
through kvm_riscv_config, than to couple this with SBI/FWFT.

The controlled behavior is defined by the ISA, and userspace might want
to configure the S-mode execution environment even when SBI/FWFT is not
present, which is not possible with the current design.

Is there a benefit in expressing the ISA model through SBI/FWFT?

Thanks.

