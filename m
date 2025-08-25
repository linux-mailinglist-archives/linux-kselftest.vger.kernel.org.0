Return-Path: <linux-kselftest+bounces-39844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A2B344DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B546717AE52
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639313009DF;
	Mon, 25 Aug 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fDqzC7VD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13952FFDED
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133890; cv=none; b=nnOpuwu6c48BNSqVpChdFlJCPu9Ny3dPp9I0VIqrLMxfYQq8jq2Zc3qfca1c44pWX7vKibRyelMTRHGX3UrPhzD0zOATVb3EOAcNgIWa1XYT/97yLZCuIOZQg2zHNQJzii+hdkgkQpYPOELfMMZ40AE+D9xIXTttvhGch9bwUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133890; c=relaxed/simple;
	bh=I1KnJytDI98uzyU9VR0CMYknvs4wi7QfemM11ZziiWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgm0C36SsLJT8Lg/jMof2tqYAGeUhUL6B9IeTPpuQ19akceqBQfhn/KUvgfTaEK0s4Rqo9ijsr407f3vwPIWUarxF/Beemlbc7JHKxX32yAEGJDmIbXXOG1FM4Xq2dP75w2zoMroz4r4evnterclve5Ur7nDXFXVFcnsLYLeL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fDqzC7VD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771f3f89952so120590b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133888; x=1756738688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=fDqzC7VDzSzJoucuPfUfalYyuBmv1F0hBzk1vBwhsdPTjfH3zgh3uPp5VWBY3NiFDS
         PIIyWuFi0rZGeNfP3CD+K1sKhCv4B+g3ruGwpyKnXJ5Vybaoe5oduwqjd8DoDWO6RpLO
         EWQ2POtI14bmm0Zncb9hcWlI5SDDDbxbLMHOiaEihF9fadnGLQwEoulGfUX5CFEYMbby
         EzDIHZvJglyBKrWz+Bk1VX5WiVEyQc4bmKDZgYrP1axQswQ6mhbgIaeyyOJblzgCKsx7
         n0udJvHnuXGJ/ht0YIr4/ipioggvBrWOXV5wGlNE/PL9O5nTeOA3ExWq0nUMG4NEs38y
         tvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133888; x=1756738688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=konFl/wLlNiJPTm4uJLr3P6OZYkiet1HQWTVmC6VFXJLoH9Twuyug65osFj6G+bk5e
         xnuB0epo5FSr+5pN2Px/mWuX5yVWkNhVgkXYNu322PRcPofze2cfXkFEK1xuej1xM811
         etfZfDPq2chtTcjNWZycZ5fiqVwKMEf+Dk/0AihO/oz+Bko1OwcEIuh6WdDhO//xH6Z+
         dku3TaAdmzq+N3ZHUDpmfsEZmVmPuWvDmA03ekqGGnzOCRDDPX7G1dU7I/SdqT/ab59l
         ypa5zPEoO+7D7D4SHXCG+xJXlplsR9LRthXKjbz75n6/dLb/nOKS388LZM3Mwh8L3afl
         GJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUotXqlbdpj0EngDvBrW2/n/BCR4ZHeVO1AaHDtKQoP+SncY3PKlkxEQ/ZN+z+wLoP/3MMBDDdYk85ucve3+ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDV6rVcovZ0vVqTPvs2EKwf3njb5UA8bkVS3b1uDDo9nNjCpPl
	HNXf3AruMV60H9/nQiRHch7WMa5Fdxk/pqiCPROdecEs2QHjxyG4J8gJIW/v1wFKX00=
X-Gm-Gg: ASbGncv9VoK2rgtRhGy1tUF2HP1G1/C/K1Db5XAMtkN9+c8TV/B8pvI5qDsfjOQm4Mh
	aISVmfnVLwk25XCOzQueJ1QQKAwR1GZAORM5RKfRjB+qc3N+Pa7Ry9Rh2x9SHcYIiRyoeuVk7OL
	yZDzOADdZmWqpgIuZNWIPWTVgRmRK0yVDMc6AzdE1HSad1yWZnvU5Dbrb7HaYDOW5qJgKS0eHb3
	kfAa9SgQKj04dOfA8Dq2o6ytW9nwMzoy5Xb3hBCQcxdEvE7jeotOpBkKsLg5H62uiN03+qkKOEF
	RGt07moUXmOI8IL9qwAJafckTAj6wSAkBSzywSqp1VA6Dw31CZIv0kSOFX2ekAcCA85pT7Rgnma
	A3Zypr99sgjXnXK+yXJy7SIHFYvJAaVeZRw4abeLySwF5V+cM1WT6e7E0IPnULW1WnYfJ7SU=
X-Google-Smtp-Source: AGHT+IGrjnb45Fa7DHzuc6Ch7rwJg1bCnvoGJ7/OuXRvlJDXrJ/ha9DOEb+cFlOakG8+pSYCIswgXw==
X-Received: by 2002:a05:6a20:a106:b0:220:1843:3b7b with SMTP id adf61e73a8af0-24340b58322mr18480454637.4.1756133888059;
        Mon, 25 Aug 2025 07:58:08 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:07 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mshare: selftests: Adding config fragment
Date: Mon, 25 Aug 2025 22:57:13 +0800
Message-Id: <20250825145719.29455-11-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshare test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mshare/config

diff --git a/tools/testing/selftests/mshare/config b/tools/testing/selftests/mshare/config
new file mode 100644
index 000000000000..16fd9a3ca12a
--- /dev/null
+++ b/tools/testing/selftests/mshare/config
@@ -0,0 +1 @@
+CONFIG_MSHARE=y
-- 
2.20.1


