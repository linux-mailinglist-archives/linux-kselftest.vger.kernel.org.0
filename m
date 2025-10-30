Return-Path: <linux-kselftest+bounces-44375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B0C1E2C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C58C34B118
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C41514F7;
	Thu, 30 Oct 2025 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGKITDbR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF481E86E
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793220; cv=none; b=bIgJz617atdcbkOf+K8OVP50zxKhlQHvY0ilNNxkBZGFJgQq/yVu6aoLn8Jmr8Ger7cRp9+4T4bSiesNZDvy+Kw99hcD/W9MyGVGrBhwQIa7M7+JJHhj0smo243zUHcffVE+/IcWZZEZabqiqrIJ9KkGTfSBuXUEkFqEuQbZx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793220; c=relaxed/simple;
	bh=K0f1o1VbpszWwR/fKC4DOMxwlCsFKCVrRuZo1Za1t8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcC8DTxUdj/TkPreh6zmK6kW7KZxaG14KO4hecOpFQo/Xp7bM8VWJTS4K2Dqe8cppafhU7YBOPkDVV0B6dk44Rn26fmZDpIRI3YsBf/kbnMoCiitmffqSxn/u/buTc114Awc/ESa4CAFDCaKkmQDSj0oxF/DVS0l/ivhGyGVN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGKITDbR; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7810289cd4bso662494b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793218; x=1762398018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvVaTZoHjzFOfTaOS9c6wuXAkDCXJtnG/9Vx8Zjx4vo=;
        b=fGKITDbR9pKJ4Q0JngUR2VfKXwjLW4FxC2IyKLMkUe6yoEdekfSsxbfgSXFoQ63Nfe
         Dp4Stx53BttSIvUGuvSWaZuqJD7XbiWGfdkf+eOjZsS8TByT3bTforlejuejc/DWNNZw
         yefvi4N8t9Gi/zc3WeItaQ4Vy9J3A0C9DQi1HM9CDINQxHf9l0ctU8Ll2fhSshmKr0lJ
         rrGzwmVjrtKjlbG8JsGfJMAO4ft2LTlocfdSOcQvEYeEjnl9HQPiW3g8kEnIl4BGviNv
         a/nqLQRbQ5g7TGFoc/zFubLAv2xmrtrfDQHJF3gN/55u24BiMWFQAvI15HZDvwlz5TzD
         kRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793218; x=1762398018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvVaTZoHjzFOfTaOS9c6wuXAkDCXJtnG/9Vx8Zjx4vo=;
        b=YbJBlwDCu95ZExK/rHzsiaO5izdFN1JxbmN076uaxzuHv4UetpesljR7ts8OTK0yzd
         yHGoqR9AiNCG4d11Enmf5td9HY5Vzc8P/OjKSUB3GkOOFKI32T7EkNo5ZkKocZSI/1oe
         K8MOJWlWY+A3bh6hrT6lKopiUcLIMyLgJPW9ApazwJ1qQXn7ceALrlKZ+K+SivQnyQYR
         h6us9yOZzUWd9x2St/MpYt0FJ+1GM29XlZqCD/v+eFkAN4UcxGDadR39lt341c4q24MM
         5MNj4a+F0rklHSLaU/6QQOrg6RoBhO96+2hfelsEqsRjBFrJm4HYjB53M7BLmGs8ufIF
         EktQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIHVatCxfsjjpXb9otRst3/HBefsLzkbObw8NqLvjHc4+6PHAy5rlU5qZ/cVLUOlCmmNxNLVbljCQ6UZw+mis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUK1Bk7IEe6ecyEesMkBj2JoPkwQsOdki4iNTaeKE7r0LzGKqI
	bVFpMSU+WnERdYEKlqn9lWcDRoR6HLOA6SuUU2ZhS3oEXTRpRZKDc8hH
X-Gm-Gg: ASbGnctK4sLeKkwzo4/9kfE7b+JSr6giuiiRVzvOE0yH+BwgYJlbVJ1VBW77WQ65k1v
	W/VbBmHuNYAinue+dQnFN5jnTwiBp0M63t6R8k2MNe/qPKN0XwQr1cmC6C7gDIt3zQUF48rIyht
	rCceNBh0ib1W8MEozFrefzNY7/GgTcDr6pBugUFXKiYsGtp9TA50yQOfn47jj/9iuCVQDBAcZRL
	KtR6QOyCmZAKzsMcskPBWCDnE/jDf3w5HN9T+rUml7CxLdQrw74n99Gn9umkCkyArjC7lHrDe06
	UvqvA/qRoneFKtM+vv6exk1IOveGexdxg18+ynJ9ak4GPWeCHRaQqIPNaBb0d/LLlz/Bny2vN5F
	5if/EbWCjuCV+JdnX+VPIwBO0vHBsvXzpV9lgS0LwOY8M1j1ToaT9PRGXCvPpbqT4UpVrRHQCdA
	X+NOnBB26jmBU=
X-Google-Smtp-Source: AGHT+IHFjScuupRcBVVx/y0EmSBi/aHgLpKdYf+L8LdTc0k0O/fP4xz2JXMfSv3sb6YF0O7c0uIYZw==
X-Received: by 2002:a05:6a21:3288:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-34786f61014mr2257534637.46.1761793218462;
        Wed, 29 Oct 2025 20:00:18 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm16663311b3a.12.2025.10.29.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:00:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: martin.lau@linux.dev,
	leon.hwang@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] use rqspinlock for bpf lru map
Date: Thu, 30 Oct 2025 11:00:08 +0800
Message-ID: <20251030030010.95352-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the raw_spinlock to rqspinlock to fix the possible deadlock in
[1] for bpf lru map. Meanwhile, add the testcase for the deadlock.

Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/[1]
Menglong Dong (2):
  bpf: use rqspinlock for lru map
  selftests/bpf: test map deadlock caused by NMI

 kernel/bpf/bpf_lru_list.c                     |  47 +++---
 kernel/bpf/bpf_lru_list.h                     |   5 +-
 .../selftests/bpf/prog_tests/map_deadlock.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/map_deadlock.c        |  52 +++++++
 4 files changed, 217 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_deadlock.c

-- 
2.51.2


