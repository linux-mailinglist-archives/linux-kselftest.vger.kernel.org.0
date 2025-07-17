Return-Path: <linux-kselftest+bounces-37497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE147B08C83
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 14:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F95883F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0792BDC2F;
	Thu, 17 Jul 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSA6NzXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE929E0F3;
	Thu, 17 Jul 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754019; cv=none; b=PTf1nW11mMgo8Cwg2kfpdLmUrt8YeCWdrrdD6hsWlEPfW4uEApjuu2Km6oPf+uvHpZzV6RBa3mLCW/fmIKDzf4Hx0dAlYvT5kWD/TXxEVwkvmWHY+aHrKhouwmRdHTqB8IVrbXG5EJlPf153UtJkYZU5eQSOOpBVdNQVksbS+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754019; c=relaxed/simple;
	bh=GxfW4clTrYdWDgt2B0ob0S/y/KzST9qHo75GgYMee8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CrbAUvVpjBeBJecqogPwGTw+y0YGfhbbAxiANX0kEvvuF9qSemnerzJgVl4SCYnzNttBxwuoTGosiBd0NgkFwzSCUPBtTuLrJAbq/3hvrbr9AVcapKErbnLx70eMdJSE9D8NOqKBwgbcPk+fhwTLXvdAuTSHV98hX74AzPco9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSA6NzXp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236470b2dceso6674995ad.0;
        Thu, 17 Jul 2025 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752754018; x=1753358818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+nJTi9+q4kpfv+a+czXe7cETLVFWBjiMNVoEDBKpJo=;
        b=RSA6NzXp6S+Fgm8J/c3B43tRGb/WCk/U+rltGCtUyqM/TRQO/xFEuTsR5WSn+apuvy
         6h5GpYsHfhXtUzE/yku0zro/OBGiV5Ci9Ou1vfAJyCJqWhFxX5m8o12TZhJLUKZBrXSw
         +DrYs2N8q+H7492+y1R9oOknUe696hWVc6b2fA5SL1znsS3PhUuzs0CKIO6m0fBU6iF+
         3/8mYrDtHyiIM/9LZ9quMU2dYEn1HxgaP8RJ3hk7SjaNXSD5WHX98cj7/+FKogg3cQ3Y
         yw7Bly4iIgNvL350jRlrvcC2UpUmmj0KhsFr5z1ItPa8nED7VU4dYz/nxsO9q0DaLEEm
         MhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754018; x=1753358818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+nJTi9+q4kpfv+a+czXe7cETLVFWBjiMNVoEDBKpJo=;
        b=Pt5dbqCwEXhfqkd4deHdVhLGG9KqOkiLxMd5iL3qVCm6IG5ZltYuuBD3FiznkVR48f
         Vn1atVzi+xqMr3TUWIVxu9gYVOdkF7BfcBU/T6oQ9G95qSEL5Txiweis43FpKKh0Pz6C
         C8JcYet46YyF0o+bTm8WPFRNfdUcsZbb44i/v0Pebm4GINEDBmVjqBOW4dX1r9360SF+
         3T9w/7mZaCV5OgkTYulz0EDLqiai1ggzVNHh846dZsqJA4XQ6fwFLYWFGNeFpNZek6Ox
         nbTnU6uLp6fXXWhrkSDv7z3ZedrFlqKR5X30jdtkykY7H8rkWDjEAoZDPYyl/qMhVjyF
         1F8g==
X-Forwarded-Encrypted: i=1; AJvYcCVHTIqmnoAlJGyK6TshrC0K+Ufh9U4WlR4xPC+MbIVBXM75RAEBpLuqDeMrQt0brsUBcB55MqKxixT3bVJ4GPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8JlLYxJMyAlNnUVKXM78/RxfgLG3T0+5X4D95iRUnLSdooJ1
	TuURp/fVAPir+tZsnST/e+W51me1ES8LAeoA4JOkMVAbqWyUIXuMl7Uz
X-Gm-Gg: ASbGncstbgbpIzhvevmMTyQuX/H5T2kFmDgEwTgcZxtZIu7j0+aO1UNC9kENrabrkcp
	Lexryg+chfEaoErTeYo6OjOhy/RB+i7wKUAguQuOTiNfS4l42FQAc0R3FGqWRyAefHS6Rx2yvDo
	uxZEjcPd1xwhHyqV2NSBzUKBfbP2rAoewLqPhoZUhSKS+mnN0C0Hxz8uBrg3zmI5i7HYwV38EQL
	UaNdNpErBqQyraGgttNqZSuShv5Pjt0ecKRITxF1DiSSOZJnUbYFShrWESNkvJeqA01+VJ8XCMA
	uS5xSgtgMB61nOiRKqqGg9knGnf49YYePR4TBUBNEDAmDYW5PdpRsq73dF8ytcOod3JGhowH6Gv
	24UpAOkVM8hl9g1jmChtXJYLvkwATdExJpuEjGnmfNgL2/cCjPhk=
X-Google-Smtp-Source: AGHT+IF4BBm7A1/lXjfX+5CFJckI70cd0JZq9N90Ne5ZdWVr/P6MXSKpPUknHKivgiR7OUlOkmQlow==
X-Received: by 2002:a17:903:15ce:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-23e256d7899mr89095575ad.22.1752754017576;
        Thu, 17 Jul 2025 05:06:57 -0700 (PDT)
Received: from localhost (61-221-35-49.hinet-ip.hinet.net. [61.221.35.49])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4285fcasm139991255ad.5.2025.07.17.05.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:06:56 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	bigeasy@linutronix.de,
	andrealmeid@igalia.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Nai-Chen Cheng <bleach1827@gmail.com>
Subject: [PATCH] selftest/futex: fix format-security warnings in futex_priv_hash
Date: Thu, 17 Jul 2025 20:06:06 +0800
Message-ID: <20250717120606.45115-1-bleach1827@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix format-security warnings by using proper format strings when
passing message variables to ksft_exit_fail_msg(),
ksft_test_result_pass(), and ksft_test_result_skip() function.

This prevents potential security issues and eliminates compiler warnings
when building with -Wformat-security.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 .../selftests/futex/functional/futex_priv_hash.c       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 24a92dc94eb8..19651087c4de 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -184,10 +184,10 @@ int main(int argc, char *argv[])
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
@@ -212,11 +212,11 @@ int main(int argc, char *argv[])
 		if (futex_slotsn < 0 || futex_slots1 == futex_slotsn) {
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


