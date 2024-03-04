Return-Path: <linux-kselftest+bounces-5844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C087092F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1A21C24773
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9786214B;
	Mon,  4 Mar 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwHs/4WY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39261694
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575912; cv=none; b=r+eBMEgZV/qheXjlFudexY5I1loV6jCAlVM/HUYxXNC2665K58IVwn7a6/wHSJLVDPTBL0hNgZIsSJQxn5FpaYGagsTMMiklBXLQZ9QDBE87N6dkdBx0CJ2llknqRbwXmYqu5nkmys8/gH4kmm0WjRUFV/MZOApbbW8HAOjuHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575912; c=relaxed/simple;
	bh=tcDiqbccYHi4AinqQLgnM+VghsYJV2IrozkELxqhwLE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GjwLJdYxxvyGnVAmcmw7+oWrHvqhlhZA2eCBY11SXHdfhd8ztq2bhadAgECRWh9A4lbZf8nk5r2rDR9RoLQBZorD7Xoq+xMdIHe0T3BC11pZirD6ZCqS6ESBs6eBHFVaLj9aOgFiffeNoA2exi6OdaLl/h0b1DWkML4IHILsyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwHs/4WY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso7556147276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709575909; x=1710180709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4kLD90+hXSvFb0+fALtfseiTDbKyQ30y8gjmVqCojkg=;
        b=AwHs/4WYyrFxMxsEbGAjIgm7Ytckw8FRNV4rYs5mSaIhmHu3U2REf6DxZ7MsoufDvM
         cUPWlT4uLX5njt90uz27iB5Aqmr5dZ9OU5oyuLgkk1uprLEvCzz95JosQmdZuIEzgZxA
         1wCrkI2Nq42FCbD35LcUGEZtzAYjF6ncGSGLLUUOctQ+Go5nSk0X8uKHxdm8wJtvS2IE
         G3zlWyq9Misi0MaoCBFlELV/PGRQnNsYlRuA4K5AK9LVcbCfd9Cg5epyjOpYu524Po+M
         5eO0CHN32nWblYHYSzfABZcNqgR5xOiX/d5Zn9VplKEBjQYp1SG7Ya27VwviYw1f89Qa
         JKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575909; x=1710180709;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kLD90+hXSvFb0+fALtfseiTDbKyQ30y8gjmVqCojkg=;
        b=Y2vf8DIIWjVK4pTS7/5VGsNqb7uQpDI7zAuSBe+2ESfNHs/bp32I2kvfry0edT67TQ
         jpWhTF4KNfMUVBH8BovGD60RFlXr6nt9RB3Zs2t7IiIreo3PgtNEFCoFxJ0a60gkO2xb
         csAuFWLi0SZpWaqH7FzGBNjE03Hv74XnAR0UYaEWKql/DweNbESc6F2RfZ5UkNkJZn+E
         dTSaXScZk8Vp6p5Ox80CllIBUYsrkXz5GT3+Vhe9dC/vxQcXR7ZWWmuPemWRZ3eRC5YS
         jHceIrBm9tVFGwzD1G9ZgRdimE0C02e6CGYWT1Wc/pB4jBuegl7jDWCbNcRZLQsAd4Sg
         w6Aw==
X-Gm-Message-State: AOJu0YwdB/V/hQR9zdNcvO72HR/EJe70k3eONxBXW0jSUosKX4BAc3x1
	VOoPDe7r26WizQS4aOVke4If/IQErG3CWBpluz5sIkuYowjgI4xp+2nmLgt/lQxLOICM+KTc4oZ
	WBg==
X-Google-Smtp-Source: AGHT+IHxwF/zU5cb5Vfvw5bR+wuloHPq0SidEq3LQN1W2vemc6jjWhYsFXPGqLxGNUu4w4mRsgdxwWFh/pQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:c786:0:b0:dc2:466a:23c4 with SMTP id
 w128-20020a25c786000000b00dc2466a23c4mr2575853ybe.4.1709575908874; Mon, 04
 Mar 2024 10:11:48 -0800 (PST)
Date: Mon,  4 Mar 2024 18:11:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304181140.644212-1-edliaw@google.com>
Subject: [PATCH v1 0/3] selftests/timers/posix_timers: various cleanups
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I'm sending some patches that were orignally in
https://lore.kernel.org/lkml/20230606132949.068951363@linutronix.de/
to prevent the timer_distribution test from hanging and also fix some
format inconsistencies.

Edward Liaw (3):
  selftests/timers/posix_timers: Make signal distribution test less
    fragile
  selftests/timers/posix_timers: Use TAP reporting format
  selftests/timers/posix_timers: Use llabs for long long

 tools/testing/selftests/timers/posix_timers.c | 196 ++++++++----------
 1 file changed, 89 insertions(+), 107 deletions(-)

--
2.44.0.rc1.240.g4c46232300-goog


