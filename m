Return-Path: <linux-kselftest+bounces-35065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE83CADB01D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB1A3A29CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84261E492;
	Mon, 16 Jun 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAzaJ5tC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E532E424B
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076674; cv=none; b=cHWs4A9HNm3ApXyRO3lQhJNzMl2qB3MphStjNs/UrCRqGkD8qAiKatOOvHJ2tXwiEleoBCw8uZKV43tjoS8wp5WiQa35NjX1HkvMsvmEHcDhz+o3u0gybqb1EQeSxGNxJf5dpw+szcxHjHPKgEANtZgvDP7sZOAPSFYWRRuX9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076674; c=relaxed/simple;
	bh=7iFX5KerbBprFSGLcmg8agRZLFdKTCkR3XILIADsnZ0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GzMvSIP8HGMdSvJQ/2gKoRy0O6Q/qqLKbW/k3GVW529mZX7Ib/z0eeV4q7dgoHSIL6t5trMFkp7oSAfhpFkqAKmTbmxxFHi/CIH5hwYOs4xOHMqqoWb911hv4dL0PkDCxG6BCeVkY6T73XsBK+WDPTowKwxmi3o/on8I+m2uBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAzaJ5tC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adf3b33f968so496593666b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750076671; x=1750681471; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTQEb7uK3WcaHfcWFCKJGK3q7anuDTj3KZgqymdOh9s=;
        b=kAzaJ5tCKC7w40ZJ3XCnJ2YsX/Vd0C10XHjKGETcocGuwdy0kxSwYFU78n7ADOvvzA
         fu8b5Dd6FaayVsWWMoqpbrexwGo9dtSLvIcL+b1pGIfCZRz8Zu2DZb+92T40FLLBtjRs
         12EssqdaiM51yxWnvPg33GaNkuY6ZEcRmad3beT/p42JVFyGapT/IG61R7hy61S/eiKd
         oaajx334tuw6dIGP7evEs0L2jK2fTZGusrge0fOWocJaNO9i72kWl9cPgkZIpnXc1HXW
         qdBQgzQObpg+pfOxohWGJuInntFslFPz9k4JHcezdPLDBoBpCKOlmNEOllginhaoIlOB
         Bemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750076671; x=1750681471;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTQEb7uK3WcaHfcWFCKJGK3q7anuDTj3KZgqymdOh9s=;
        b=gA11ZfKNsyQAJyTgjsSum0cINfG+Tin+AMlxV1mKwL6dmu98kBqlZpXMYvGnQdxIm5
         n8Jw/oaQkwztNj4BM9WmzCE1+Am1FBSptQu0pzBkNNp2TjEMNf3EyORVHpqMYl3U1hcr
         siiuWrQ7s7FKDFM2vg9PdNK/dzWWZVPfE51SMDLP68jqpbWuzAA8csx5kw0ZFbLbqSsC
         U1rDpzSFQr48eJGbV5Mk9dfjZ9zfkAHeMb8wM1NY1ONolslpPnR5/7hsaZfM9uCx/6UU
         GvFfoxc167tGx+tUnqWfwcyvBvnJb1VifnyHDfVlknqg8WxFUq/2SKoW9LMk4yjuDgZL
         DFWQ==
X-Gm-Message-State: AOJu0YwIUhFFNYsm4xqQEXnnsDnnfpXw/oMKuNidqW/aw8mVQB2uZr2L
	vqd9dbcAp3cggg9dWpTY93gFp3cpwzgAXcMlhta3jTNXMa0ItM8rJCqw6G3Z7g==
X-Gm-Gg: ASbGncu3ie3sAeStDGh8yMEchpr8qfocrWqNfQeFncS3hhPf7oRf7y42Ke/vgZXgZC+
	tfRFRBkZrQVeKGcHq8lw9iYsDobNVb8L5q3j+ttBcy/wRxftR50490XZkm+WnCOW4WWY/kZn5Hr
	xSptCKtATRJyCbbvxfXOYBxgk6MeSrx9wxbwR2kSUgv/rP7yoH8hbPbk/QSOuG6jxhHefrAchXg
	cc+fsh9cz8AVhFe290SnJsyKL71qPMJWMFnfbd5DYkMXumWQpdm74AE0v+iaObHfkFVxYMJ7RYz
	PhWfF916pv4VJMrBy4QxgD7sVvLIG2AM8LoTf+TIkfkV67JYVL3OBTfqO/+N9w==
X-Google-Smtp-Source: AGHT+IEMWas/BTp91Q4+pb6aCcF5Wm2LKAL2RVuaTuRDQJhX+SPVb0aQBntgdrXtHCE/DlWyb24G2w==
X-Received: by 2002:a17:907:7f05:b0:ad8:5740:9932 with SMTP id a640c23a62f3a-adf4fa8a045mr919843266b.26.1750076671183;
        Mon, 16 Jun 2025 05:24:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48cd687sm6067208a12.18.2025.06.16.05.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jun 2025 05:24:30 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	usama.anjum@collabora.com,
	skhan@linuxfoundation.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 0/3] Add kselftest harness selftest with variant
Date: Mon, 16 Jun 2025 12:23:35 +0000
Message-Id: <20250616122338.32678-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

We already have a selftest for harness, while there is not usage of
FIXTURE_VARIANT.

Patch 3 add FIXTURE_VARIANT usage in the selftest.

Patch 1/2 are trivial fix.

Wei Yang (3):
  selftests: correct one typo in comment
  selftests: print 0 if no test is chosen
  selftests: harness: Add kselftest harness selftest with variant

 tools/testing/selftests/kselftest.h           |  2 +-
 tools/testing/selftests/kselftest_harness.h   |  2 +-
 .../kselftest_harness/harness-selftest.c      | 34 +++++++++++++++++++
 .../harness-selftest.expected                 | 22 +++++++++---
 4 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.34.1


