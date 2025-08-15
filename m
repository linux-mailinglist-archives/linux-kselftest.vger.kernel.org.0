Return-Path: <linux-kselftest+bounces-39017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D91B27356
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20E4685250
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78E1114;
	Fri, 15 Aug 2025 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlvCDJJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2419A;
	Fri, 15 Aug 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216576; cv=none; b=o4bv2I3xedml9Ei8Uv18jjQ/T1wOR2x20P7MF4uRgyUF1VudZ2KyNR/qlp2ucA7xhqYlOstpcOsuS2tM/rrGCZWKE8Rvc/7SCFcFM/oNGlEmb5mrfISzkLQnGS0e2hC6f2ReXZkNcUxcPzLZETFLTCC5wydeggNQvVrmalYncg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216576; c=relaxed/simple;
	bh=SXhJb46D02XyYpPG0ZR+hLtc2VGrkDqQzQtP4rIForg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MFwKZQiFTbFqG5xfNLzJ6ax66qaZPRxyvwpxaewwMIPL44fPtQTLvr9gE/HurEPchUitLYuxLDnsz1ht5eS3jM8j2rp031p1BeqyMQ+i9LKrLzwAna4HwQUlrwfOvf8RmyQigQ9YJqUhC6NXk3LTvBFKzLdT1EdAy9Q6RvR7A/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlvCDJJ5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e44537dccso5703b3a.1;
        Thu, 14 Aug 2025 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755216574; x=1755821374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxoW0PVifSF+JymiPBLwjWMtoyAZGxm4WlnOuM8c4Dk=;
        b=MlvCDJJ5vibasVe4gc4fvBVzr/oPa5GVXTIFh0IixSHUHbUHdbncvXL4wR+Akzf7KO
         /2nfBe7X1YWjqI9roxPEvW1Qx19llAR6dL75fZgbW0u3smQZOXtF1Lbdc2EHDEQLluPx
         EyyWwNGeAl9MEU1Ao9AJH9Q4JDInsJ1V9oIL0m70GqbuV6P0i6AUNr75/BquUUkfRzrt
         /yCOCOUQfHiFoXYm98Ln1RRlpzFv5SNbczPadq/5eO2zTrf1Q/xgXjdMHkcGNDk7T3Xf
         XM6O0z7PDD6FEljIMDSn/K9R/wgFRSgv+ugXVW1rm9nu6z6Spv8/rgJDzHjQ6gSfpnjW
         zQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216574; x=1755821374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxoW0PVifSF+JymiPBLwjWMtoyAZGxm4WlnOuM8c4Dk=;
        b=chIK5d7Kjp9IyNeELZ3ar1RnUsC69dYTFLGS3xqz9P18+8Wgo/U6rG9aAQ89WroYcJ
         y+foDLwo+AfKx9r3AW1CkUdhvX/T45bSZeaeUfRoi5EvtwWTt3m8mvfzXKaX8vYlqGrI
         Yhi7yrj9CB9tllcJON/gWXVgB6gCRUs88xUcgLgR4uEZruCemGhXUyyi3urNDX7QHe7L
         vFkzIlVAOmJhUX0OaYm7iccXWl5x8umxkSP7qMw1l555Qez7pExKPaKgGNU+x/ftR8H6
         iuRKHiyMkAmu9H0k+XnEOVjHbYZwX8jrxgA/Y7ewISCxx6qgU3pGke4NY/f1Fl2LzVBq
         sJWA==
X-Forwarded-Encrypted: i=1; AJvYcCU6gf3Ai7vGdWS6cEtrrsbgXz4cFTOw9g6GhLSlL/lQMG7NZELcgjlnsDFj18qPzT0OV55zspjGZh+EyZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLM0tdTWztJYj70GGvDRSAusPgRviqiOq2HKz+Qxvrt3A1F31
	SC+RcZqrY6pmjUQtLItg+HjGJxWFX+NITF6YKHXQGpZz9KdVtn2WYSs5/hvIXf9X
X-Gm-Gg: ASbGncvAsDzz0+VZDlNXjfGvEQWxqYHCfVJFyDrQBsNA9eqQTjt2Nr3znVgXRqwkfMb
	WkrAMOtbMfXgb4Qw0GzhA1IWNg39UxjP3XeTT4l6a0Dp44qmoUo1Nia3NznlHLFcvcKIaVywGS4
	Jo0TZbhubb84afyjxSmRzoqc8fJvuiV38FUUSH5XpPhGkTNcCReUGfTv90Quz0UJsw/G87RkGeQ
	ktQRVkzkhWcfTiy11NsoPvYvWRgC2VsplT+EIL7Aig5Jvk3bW5noquDJm/R9WRI/425csl7Q7/J
	rZ1zF9neWYLHicyHdR5IqDF3Oaop6qH6lWtWEL7xvo8D2Y3P0PZuqJX+OJ4jx+FbSrYBHdLWbu/
	Pn94Hy7Sxtdc6Owf5PL4o0a9aEQC/zXs=
X-Google-Smtp-Source: AGHT+IFDMdF6+yivvCvqSJWE4UQ35aadp0nC/z5tzMjZ2sph8Sp3/GEi6/LsTjvgkkBK2V+ed8hFgg==
X-Received: by 2002:a05:6a00:b42:b0:736:3979:369e with SMTP id d2e1a72fcca58-76e446ffb04mr30874b3a.9.1755216574174;
        Thu, 14 Aug 2025 17:09:34 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2efd89aesm21367854b3a.106.2025.08.14.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:09:33 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>
Subject: [PATCH 0/6] Kselftests: fix spelling mistakes
Date: Fri, 15 Aug 2025 05:38:58 +0530
Message-Id: <20250815000859.112169-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Used codespell to detect spelling mistakes across multiple tests
and fixed various simple typos found.

---

found/fixed the following typos:

> didnt't -> didn't

in `tools/testing/selftests/filesystems/statmount/statmount_test.c`

> add add -> add
> cannnot -> cannot
> fowarded -> forwarded

in `tools/testing/selftests/net/netfilter/nft_nat.sh`

> faile -> failed

in `tools/testing/selftests/ublk/test_common.sh`

> indicies -> indices
> requrired -> required
> guranteed -> guaranteed

in `tools/testing/selftests/kvm/riscv/sbi_pmu_test.c`

> avaialable -> available

in `tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c`

> requries -> requires

in `tools/testing/selftests/safesetid/safesetid-test.c`

Soham Metha (6):
  selftests: filesystems: statmout: fix spelling mistake in output
  setftests: net: netfilter: fix spelling mistakes in output
  selftests: ublk: fixed spelling mistake in output
  selftests: kvm: riscv: fix spelling mistakes in comments
  selftests: kvm: s390: fixed spelling mistake in output
  selftests: net: tcp_ao: fix spelling mistake in comments

 .../filesystems/statmount/statmount_test.c     |  2 +-
 .../testing/selftests/kvm/riscv/sbi_pmu_test.c | 10 +++++-----
 .../kvm/s390/cpumodel_subfuncs_test.c          |  2 +-
 .../testing/selftests/net/netfilter/nft_nat.sh | 18 +++++++++---------
 .../selftests/safesetid/safesetid-test.c       |  2 +-
 tools/testing/selftests/ublk/test_common.sh    |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.34.1


