Return-Path: <linux-kselftest+bounces-32812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F9AB2227
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79644A1769
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BA1EB18D;
	Sat, 10 May 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW0pFkH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0C1EEF9
	for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746865773; cv=none; b=TEK8Dfcz5JYzsguVELoszRu5XK0zyJaX2x0a6jv3dw0/n/HIBP8oCfNBjhl5ikCfgwf2ceurbbr/7F/BsWiQMK2VO24fGW9Ui0M1ZUdY1+FZHnRIsbY8yqqlOsm9pybYGwASUCEMuaBvrVUq3vi7hHBts9Hn3pB/oGPteqdBPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746865773; c=relaxed/simple;
	bh=85aeWvGHYn1zIsu9+OFri/mb7w1lJfukxFJmc7FhSHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2pL4Xdgg29uq2923RAIQkEhiFMVBHEgm8yis63rpcUVtFjUHwQs0S9r85yz4YTmadTjGhkaCz7nPIg0QBJ/zvCyX37+claWgfas8nJ3ThBcnA94kCCafGa20y/f/OJNERv5IBy1js7ZUvldLJgJoe1BqwNdBEJcMQ1dzM59uuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW0pFkH0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c277331eso3534058b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746865771; x=1747470571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Omze9eZ0wweiRNyLLmo3kWygwTaHyOme3BTZcVIyvyw=;
        b=kW0pFkH0x3CP5KZeEe6J7vfAbodIsTs/EDCsVc7vxXpycP8DacFaRJhqlumd3fWikU
         Uv8cfti385YirD2KWgczJRgr5Q09HUwLLXckHQ4/UIsEsVWybvlKLqs9X4GdTiRDql62
         t5VPLkfXwsBkVjMqNGLZHRhcbiRbji6l2nlmBNQuLAMjjUB6ZxCJcwq0uMFPc0+wlvSR
         PR95m4BUUTiMy++pUli6lZpSMlnAXwJ4wkiNEelZxNWz/kTHeKONoktlc3VusJiwkbls
         JSso619l8554W48TvrGj2eO6G+GYyowokbP1aqbVxCmQThvXWvRVftyJin9S31Y1LwK0
         QQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746865771; x=1747470571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Omze9eZ0wweiRNyLLmo3kWygwTaHyOme3BTZcVIyvyw=;
        b=o0cx9jZIzD9p7sIVSawH62mWtQZOKMxucGZdZKZrbTDf5M5nYTI9JX8e6hG0XHiC3B
         RM0RPAfvZdAKsJIrh0ckriKpcQxvN1jCUlv55tl6COeDcgFrkO2TPJX0gmeqTRfYGO1O
         E6qFcGmMH9A1tvPS6/I+XoKjtZ8NTA0MkwYIqsDcmUdvefipojbfjQeHH6KzZzMoDYLr
         05FMOKE0EYVddJt3Jmd54+YaToNruYQoSfaM8yVTw3rSjAuhrGsIqQ+WC1fEybyF6TfD
         R9c3LbJWicHxcdZUWZizJsTq6pnDi41gcyi17aYjm9yW756Jrim+Q8Ip88kFDLfPN8cJ
         z/fQ==
X-Gm-Message-State: AOJu0YyUoluxyaPB97zP4eD6YKzpmxgBynjPIYaHKYbeeg5NjfGxw/C9
	Y5/Zu/5RYgTo3rYffoRnru63D0m2RGGRqAkRJyEHIoRaFxZuPcgVtMy1Rw==
X-Gm-Gg: ASbGncuhhLM4WSxYW4SqlStiDsc0Iae1LfztBxEHWdMd8oXN5ngGB4VK+eciVQrov5+
	/2CooVS7molBj/UVP0cLdbha2H6VxlmaPR1xV0lEGnSsxjqgVgylkqTg5JXXtwBwk5+VqRRgU85
	RT+TNmku9J+2YgzWvHMijnrysGa76/VFrVh0e81vQYJKWyY4uKUZNQH1nG2kBpLYC1etCsNEqvV
	qfzZ0wEkctT57q+/lgBs45bTy9ubyMV7SGrb7XblbuzFmyWHfFn2FLqNCRzRljNXQzTPDb0lJNL
	XUpzAUgArKd+VuVJGF7XJo56RZFBByGrnuJBhnmElr21yBHfx1aU49ofPZfsFGvaADXq8IfeJ+T
	J/mvuIrBcaDfM
X-Google-Smtp-Source: AGHT+IG53BG8The3579NGVP25IhIf9cRKyZYNdksp3mEtHmcalQ+uXAP0E10wv7XdZn6k9Ejt2u/bg==
X-Received: by 2002:a05:6a20:734f:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-215ab677443mr9703908637.18.1746865771086;
        Sat, 10 May 2025 01:29:31 -0700 (PDT)
Received: from skc-Latitude-3420.. ([2401:4900:1f27:5baa:e94f:47cd:52b0:4597])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704486sm2911383b3a.17.2025.05.10.01.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 01:29:30 -0700 (PDT)
From: Suresh <suresh.k.chandrappa@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Suresh <suresh.k.chandrappa@gmail.com>
Subject: [PATCH] selftests/mincore: Added comment for minicore test
Date: Sat, 10 May 2025 13:59:25 +0530
Message-ID: <20250510082925.11663-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suresh <suresh.k.chandrappa@gmail.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 17ed3e9917ca..c4f0d21f7678 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -146,6 +146,11 @@ TEST(check_huge_pages)
 	page_size = sysconf(_SC_PAGESIZE);
 
 	errno = 0;
+	/*
+         * Attempt to map a huge page
+         * MAP_HUGETLB flag requests a huge page allocation
+         * Size is normal page_size, but kernel uses huge page backing
+         */
 	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 		-1, 0);
-- 
2.45.2


