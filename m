Return-Path: <linux-kselftest+bounces-38420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EEB1CDDF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BFE188EF00
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D82D4B74;
	Wed,  6 Aug 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/iLSn55"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E672D46D8;
	Wed,  6 Aug 2025 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512779; cv=none; b=KP2JeAR/WofUPPeP4XTmNNnUOWgyV1Jt0/MayaNbQLMkUb8G8O5zCqXeMU0AwBMpcl2tUqwyazOJv47/skPWxrcWlSDLCnGrPXJhZExHnvExUfvOEZZl6NqFgsj4GLDivT6c8SOP+1uLdOal/tPnQ5G6NkWY9ad6C86zvgfF6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512779; c=relaxed/simple;
	bh=qXIy2TDe6wtUv8kXF4txJya0a+nOnVVUmiqcNtgwnMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3uxqJh9KD0U/TiWiFdQxUDZuPO2DCrZs4t6Ro5Nlbfpi/nA0IVbwSs7u+t+lvwpLH85vagmZqhpC056ElqWMP26xL0kcmjAfkQjDgVvAAzzcYHxo/O3x6EcRBKk4GXFUUpFEQVGY0T++wzZnUE1y+5Alk9f3IyQntXKyrK9t68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/iLSn55; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso227873a12.2;
        Wed, 06 Aug 2025 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754512776; x=1755117576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLwQExKUfK4JzXgNc/MSuz/ip/toJprM4tvNXBkEa0c=;
        b=U/iLSn55PZVMFJnPW8ATt7rkDkirlZkDzXsk4XxyG+Ubuwz1j43gjyvsxj4cfbO0ZM
         DeAXCvwXR/y6cYnm0X/6MiltgxnbvSfy2KoTCym2Urux+SqpKRr+/fTsOgttUhAdjZCt
         cr5xCgsZoSC0oYnUND5UDMo81fFm+0eSoJ9KUIrLwboaNfx02JdwQeURkb7k5+k4JGfn
         TnG1uno7jrlEHx18ei9509cfe+rCb5ZOZtbiAHTbEArb9ZkChDkr38tQYVPJExJA/I6x
         5loyvp2g3lG3EsWqXBGPkrqaFhy4ZO86YXzKt4vfkMKjRKhv5P7ImP/sVxMotYq1U0Fz
         u2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754512776; x=1755117576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLwQExKUfK4JzXgNc/MSuz/ip/toJprM4tvNXBkEa0c=;
        b=mMNyNaVYyTx6l7MqbGTisnlOeovn1LizFfoWT/cFmtwUFz1A4+x58z5h3eVGWFgEW8
         epRzqWqGhIsezGsEUjmdWriw1MPhDJmzEdMNPl+8hV/0ijq9PdjqF5zFEep2hDSJfuD5
         iKwygkUasnwc+VPIdMYaHZzqahp7/WV+Bl4Y9NGvk4p4OHLOg8wAo4jeNpSrJTAR47na
         kBnEUSEH7XKFAG6QwRMmui7oQwwxDUryvKoN6Fyk1Y9NUuUeOSkmUAec/31t6eQTNfeU
         /bIJ3uvA2c5VZeuZj0KxkBiYykNzNi/0ql0rtBNCQYLzVYNbr7fZYxmQN3342OjagHEA
         ev3A==
X-Forwarded-Encrypted: i=1; AJvYcCUSzjsuLMLYvqcleoos9cbZc9bCPvNRyppIcBby4VYqYuCN0bPtkw2phsBtLzVB0Izfi8mNwzdWh3itGstuo3J6@vger.kernel.org, AJvYcCVusuHeBFsxZYt9YA8jiL7ac4Yde1g10OHQCGMylB9h9zJAq/yrYKVrSuRXioa/yOJ3NlFnjrQL3ehCmPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcOvsBSEABZ3PRcmKhmhG8vx2rMjZbZZT1ImxeoAGgOnkOyLp
	e8Ba7Zt6QYFL0rLpGXtQHbCz2qi0c0Ebo4fwLzewaOKwRD47zN79fHMO
X-Gm-Gg: ASbGncu8fkjCvM5CsGRKTgGjUY/SGzKl45XH0dROorbC/wqEnEeyaPi2Q2cyqCi3INI
	mtEXA8v1gAdBW7wx1L7Xc/YCakCXzan8do5D4xibOndLzcttK/LAgGu4RYyxf91K4OsaF2JuZlc
	HvUm/j2AFP6Fp2gINBQDV1y2p2XR+OwFi3bHarFFVN8BFbfc4cqn0F5BuxRntSaTOVyKImFep9N
	EX74trGxrCAZNjoCJsKenXQK6PMUX+i4gr7XuHvcl17J5olS6GmwRzhvk2F1zy+AmTXNGk6gI8X
	NZFS6ReCF9uO/JKwHVDepJ1HynLP3Iy6TO/SYWYA3IC87UMAUtta2rUItp/qilP7KpPBYLWVYJN
	mrt7WLNIviCLB5AT9KZsiavIFSOaXKw+W
X-Google-Smtp-Source: AGHT+IF8wHNHuQVZKKSQQIRqVPww/m8v+NrnrInpYnTghu2nm8e4+4Nb4DI4QQXkDMw2EhctprCEdg==
X-Received: by 2002:a17:903:19f0:b0:242:9bbc:c773 with SMTP id d9443c01a7336-242a0bc9f41mr56677965ad.54.1754512776231;
        Wed, 06 Aug 2025 13:39:36 -0700 (PDT)
Received: from server.. ([103.251.57.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67a3sm166407345ad.15.2025.08.06.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:39:35 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] selftests: arm64: Fix -Waddress warning in tpidr2 test
Date: Thu,  7 Aug 2025 02:09:26 +0530
Message-ID: <20250806203928.168365-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve compiler warning about always true condition in ksft_test_result
in tpidr2, passing actual function.

This silences -Waddress warning while maintaining test functionality.

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/arm64/abi/tpidr2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index f58a9f89b952..4c89ab0f1010 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -227,10 +227,10 @@ int main(int argc, char **argv)
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
 		ksft_test_result(default_value(), "default_value\n");
-		ksft_test_result(write_read, "write_read\n");
-		ksft_test_result(write_sleep_read, "write_sleep_read\n");
-		ksft_test_result(write_fork_read, "write_fork_read\n");
-		ksft_test_result(write_clone_read, "write_clone_read\n");
+		ksft_test_result(write_read(), "write_read\n");
+		ksft_test_result(write_sleep_read(), "write_sleep_read\n");
+		ksft_test_result(write_fork_read(), "write_fork_read\n");
+		ksft_test_result(write_clone_read(), "write_clone_read\n");
 
 	} else {
 		ksft_print_msg("SME support not present\n");
-- 
2.43.0


