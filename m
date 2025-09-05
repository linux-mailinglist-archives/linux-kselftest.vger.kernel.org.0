Return-Path: <linux-kselftest+bounces-40848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB6B45C53
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2721897C87
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88E31B833;
	Fri,  5 Sep 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWeRVTxo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6C72633;
	Fri,  5 Sep 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085527; cv=none; b=rT6JFjsIwAv9qUJpYV9oGqDkwGQYvkuFyNXgft+sfFlhDBb9whdBYqJkJsO2RSfFhJt5jtF/s688H4GvjjrT/5ZnpVn7iqToXQlRJ2bZCxeIBNyrgh2c7mO/xWDhierEMY6LLX9Qgh+SUJHTCLyVBCYi2prP/jKI0j+MBQpxcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085527; c=relaxed/simple;
	bh=PFtfISKCGLgCCpPFMJdUVWc7+BucDIQgwm+dDXgg3Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljzj4XQLejhaQU0s7Cm2IzGxVehhaDFdZAF72T1BFBwdJVEfIqQf75sOTo+3NBfpEVmuEIA0U1LT10uqLd3+wSJr3/si3gaq7TyP1mHu005KLo3Z94Nez+O8TYUB1294f4WZlAXhGsnOpBfWzT10HC977bPYlA1BLju2YFEUXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWeRVTxo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e5190bca95so146711f8f.0;
        Fri, 05 Sep 2025 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085524; x=1757690324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqWX29cADd8oXR3a+jsb0bx8Bb4o78EwXOGQnNUO1IA=;
        b=TWeRVTxoN9vNlzQdtZyhvUh7E2l0iS7kAe4uHGFMpsELzS/fQjCwpLlGCfZXEj7NB8
         uuC02p8pe0mpy3QxFwqN75uQ1FjjyYEXhy4oUvaR3/iHAbghHlR28HdyZOQeU83s+z0I
         KHb0WsimgJAzm3JmAL54nnPx+ZDxqkBnHoTDEXqkUXh4r1+Hz+tNu3GOxqZutKoc/3zR
         RDpJnBRjVQ0rIoxPv9Ryt8ZDp/kGPYH7aCLShDMn1RW2up2HYy75nPtiwea9h2YUZM11
         9zIPIStUaTMfmEjP4uUbkxlCFlWM0v7mklupWmBRGfUvFATotFLON/rE1ybebuQtQ6nr
         6fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085524; x=1757690324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqWX29cADd8oXR3a+jsb0bx8Bb4o78EwXOGQnNUO1IA=;
        b=F/DwgSJEscBZaY+AuSTTChhY8lr1bnECkXdRxBBL1H224rKkD5+5+FLxj1KXtD60Vc
         J8Gi5FruDD1x1ZA9N4VUS43nVjyE9A+HtDSCuzlvTDiYBpzRChuKpB1m1vxl5lRG/c7c
         jKeq1nnTMp41oj1gAp5VbVbtaOtKx1fZGq0fRbV3974uicdoXnNEy/zFFIeGOmC5C1aJ
         gWZnixTASIN30632AsdtnTDNd5mtB3I6Yhp6j+vXINZWw6i97VCOU1Ne3HQ1uzhL0578
         ztu3sse+X/XSWLj5ujZomPjlIN8pffyjzMZCi5IA0/0zGsnZ11ypX1a0r5VtsRh0hQPY
         V1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWifOIpx7kBeckMF1imvK0zc4Y0yMyq1vWh/JxyuUiIv/At9Jtux83K/rB+ArktdirEwMgDCnkBTo11MujbZlKy@vger.kernel.org, AJvYcCXQo8ctDaU6l++RCGbpuUPwgsGD/25rv121FdbRUYOKhguELTzcVqmVsm22DnrHk/LMOSHI4E/PNswQILA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC579Ah3Y1r0Y8JWnRwSExGANVUBRQGsrS8YCxpuhdWHSNOHRq
	pKLRCWt6OyqDrHI2t2QflUv90pGsxngVfm65W0fFoK4iYH9J+5gfQsw3
X-Gm-Gg: ASbGncurXQkQ4GCdZ3GhSbjaJ1nlS0qMRjJOlNlB7g4s+8y00yMjp0HIEC9p5Od52y1
	veSdfydhKH0C2kOdPP29JZ/RaQFR4TDctrzF5/FQvDGw2opwb09BAe/lkSYaE/d1ozE/UXscbnf
	oCuZae5MuNpLNXwZdzbkyYt6m4+3y0DHV9yhD7KbjySrIuaKhcuhpoewpeBwH6k8shaCYVlehE1
	tEskxAfGR/amZrv4JrctemQsDXw2huCm66qeWYQdtT9gDldPBJUf0UQ2+BBdebc3/jl3hO9vnrx
	3jVvxTDn6GP7RFO3p9L8UuzWSJcfiN7iNFtLQiBs+W5u2jSooAMlmN2Moqwrp6wx6TIgFojIt3j
	8FAYCdtOxVki4yNhb78GCwp9zlg==
X-Google-Smtp-Source: AGHT+IFdOL1aDtvRrBK5e/DIroOdpfGm54NZLFIv+6Ap9Edo0Xnobb4lqpDJUHwLo1ezj3u2vY4yKA==
X-Received: by 2002:a05:6000:26cb:b0:3ca:99ad:519e with SMTP id ffacd0b85a97d-3d1dca7bed7mr15075926f8f.4.1757085523698;
        Fri, 05 Sep 2025 08:18:43 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm356411555e9.22.2025.09.05.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:18:43 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	linux-kernel@vger.kernel.org (open list:FUTEX SUBSYSTEM),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] selftests/futex: Fix -Wformat-security warnings in futex_priv_hash
Date: Fri,  5 Sep 2025 17:17:20 +0200
Message-ID: <20250905151734.12729-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several -Wformat-security warnings in futex_priv_hash by passing
the test message strings as arguments to %s format specifiers in
ksft_*() logging functions.

This silences the warnings without changing the functional behavior
of the test.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 .../selftests/futex/functional/futex_priv_hash.c       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index aea001ac4946..2627eeb1625f 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -193,10 +193,10 @@ int main(int argc, char *argv[])
 	futex_slots1 = futex_hash_slots_get();
 	if (futex_slots1 <= 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
-		ksft_exit_fail_msg(test_msg_auto_create);
+		ksft_exit_fail_msg("%s", test_msg_auto_create);
 	}
 
-	ksft_test_result_pass(test_msg_auto_create);
+	ksft_test_result_pass("%s", test_msg_auto_create);
 
 	online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
@@ -237,11 +237,11 @@ int main(int argc, char *argv[])
 			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
-			ksft_exit_fail_msg(test_msg_auto_inc);
+			ksft_exit_fail_msg("%s", test_msg_auto_inc);
 		}
-		ksft_test_result_pass(test_msg_auto_inc);
+		ksft_test_result_pass("%s", test_msg_auto_inc);
 	} else {
-		ksft_test_result_skip(test_msg_auto_inc);
+		ksft_test_result_skip("%s", test_msg_auto_inc);
 	}
 	ret = pthread_mutex_unlock(&global_lock);
 
-- 
2.43.0


