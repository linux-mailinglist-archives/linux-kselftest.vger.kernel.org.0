Return-Path: <linux-kselftest+bounces-39312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41840B2C8DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A67B62A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09CF28C011;
	Tue, 19 Aug 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej6jGt64"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476E279DC0;
	Tue, 19 Aug 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619100; cv=none; b=PPhUDCRMWMzvC8eUzYKpLqyISvFCtNNpoMsBY5JLRApsefo6ECUAqNSB1yG/pahMkxkO8JO0IG9qJG0ZoJRr8hBUv1C0IgPFidpZddLSftM02DnaDFjxrb74Yhb3/3q3SsT5VBpAePw9Dah5uGuJvFfxhCQBBcaiiEj86X/m0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619100; c=relaxed/simple;
	bh=m9dSNoor5c3jxuIbjHd9hSq6RwgNDQDjHqmYeR5iK7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7TwSl4vYQhsXiUYW4TRekHNOdZresbZClZ1BAegw7QSW+ksYHs309pf3fQQP/W/i0lU6N0NFitzBZrYod7DS5UdoBTLhGCostUtio65dX9H5CSINVdOq1/GgXmN7d/g0Tc9OitL5JOfJUj4ddOLR0ld7MWNnQRJ15Eonpv/TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej6jGt64; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so4079424b3a.2;
        Tue, 19 Aug 2025 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755619099; x=1756223899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAC9ZIG21u1yEagYiw0bsnH1lXES/tFXaANXtN9HVbc=;
        b=Ej6jGt64DWlJwpjEhyJWCEQTieYUyXeT4AeR3F0qOEkHBgDFvZ4fSnsbqU3BIqqlZP
         DFGshMYHHEkcQU4RakCQnsYYUOYtPOZugL5ockVy3hM1zIPlo1mwn8fJqa+kZ5XtdbaS
         zxRaO0xbDh3xcvJ/fFHqSM55IppcyLQzuFBfx+mv6UyFur7ZP2P+ATMCfx6i7n6Lnhjc
         5KHrF7BUIJez+vYX2usyK+ek2m1NBFuPNHUG9jT+QdZFJoHr5MuQ3ZzktgZoHfE44eri
         y55gw4IblmCxBpeFxfcQGLRQNPej1PKzKk8nDAK7hPqX6Ft3JHxpfTg2iy/KdkYrz+q4
         3Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755619099; x=1756223899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAC9ZIG21u1yEagYiw0bsnH1lXES/tFXaANXtN9HVbc=;
        b=XGpDvPQefIUNLOEqUZ77MsRJQSq4y1Zk8kUOq/jjyZwZyWKeiQl1Q4c7rjzsw3UBy1
         D1Amzg2ki9h8oaUNvzNtVQ9mincwYgWFBXvTxkPZRF4cPu4wwNViWEJ3lReKfjYyGvCG
         ohGkXwE6ylSlPtE4K7Eiv0DB1o+BTXbajxHBr9EQAQxdreJX1nMl8BrMaO8MvGFWcwEm
         jgsJaYbNq1OuVAgB07UavzHCiA5GUU42ZHmENYInLvGxyEgJdWCts+eOozN6CPO6VlXE
         ND7FhZOpSUdNPCiTrtDwAVzjwqoxCio7e5PhoGaqhz+izs2faBcRv7bGEJ8mngse/+XV
         WlMg==
X-Forwarded-Encrypted: i=1; AJvYcCVSloPkdHqXipx/YfRys5kTrpJs2Q8ar0i5ATVx96nvm67U8EWtM4plUQDJXD0BAOIFdS95jp3ssJYNgewDzJR7@vger.kernel.org, AJvYcCWHTeR9gvGK6418H1wfSxk5GzOizEjSdGsuAOUNTlIlgPvWI1EXE5UsX5vjdHLStTyxfUQiDtad20sP+Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8SOru/jMwtYOPahcQQusJ78FNTrxD9RWvL5ir2a4adXH5rN7o
	tLxDX5Ga1BodRZeAeeu9kS8mf2DMs7NaFbDNgreRxPvf0fVyc/XlrDgp
X-Gm-Gg: ASbGncvzEXZk8Vq6fidPOMBJLcI5HRI+hkMjLY6IQg216wR2gMo8TuuqGevimwxfIvf
	Xpr6IDr+UPc6Nq3jwIEy7jIOBB8LJesQQPGqqMCiDP6+YobXKCes6OX7Lsv8IKunk7tc51GalKX
	RDusZ88HhM2Q1pTLHORbmKwKnlgEOaObulD7gh9MYckhCkFLC+Bp0vFUCQdxGvlDPlEzkW9qOFc
	stEO+ThdOciaTHlQQUiiIW+RPfLfZO3lNT0UP87ghax/cV7fz4JkelGqyk/7xCslO4Ks1m9nVL1
	VwzEGGhYgVZh+EsLYNtTqjNTPVi/QFbKqdsxefkYuyCSbfq1pOESU+OiglLpppBhUrS2W0ulCMa
	UMPeR9ncaDw92nW96zLXkX2LCp/db1P6OyBxD1a2eetE=
X-Google-Smtp-Source: AGHT+IEZIUicpIBsSqReeGItn8Ta0qk2ND7WkfQv4jrxRViSC5kLH4Rhy0axgGq2EVDXnuOiqOUZuw==
X-Received: by 2002:a05:6a00:14d3:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76e80ecc347mr3176011b3a.5.1755619098531;
        Tue, 19 Aug 2025 08:58:18 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d16adsm2870331b3a.14.2025.08.19.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:58:18 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: tglx@linutronix.de
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	mingo@redhat.com,
	peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] selftests/futex: fix typos and grammar in futex_priv_hash
Date: Tue, 19 Aug 2025 21:27:53 +0530
Message-ID: <20250819155755.4665-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819075511.6mHXEwdt@linutronix.de>
References: <20250819075511.6mHXEwdt@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple typos and small grammar issues in help text,
comments and test messages in futex_priv_hash test.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog :

Changes since v1:
  - Dropped hunk which is already addressed by 
    https://lore.kernel.org/all/20250808112458.831212-1-colin.i.king@gmail.com/

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

 .../testing/selftests/futex/functional/futex_priv_hash.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 2dca18fefedc..67be60a8238d 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 	if (ret != 0)
 		ksft_exit_fail_msg("pthread_join() failed: %d, %m\n", ret);
 
-	/* First thread, has to initialiaze private hash */
+	/* First thread, has to initialize private hash */
 	futex_slots1 = futex_hash_slots_get();
 	if (futex_slots1 <= 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
@@ -232,17 +232,17 @@ int main(int argc, char *argv[])
 
 	futex_hash_slots_set_verify(2);
 	join_max_threads();
-	ksft_test_result(counter == MAX_THREADS, "Created of waited for %d of %d threads\n",
+	ksft_test_result(counter == MAX_THREADS, "Created and waited for %d of %d threads\n",
 			 counter, MAX_THREADS);
 	counter = 0;
-	/* Once the user set something, auto reisze must be disabled */
+	/* Once the user set something, auto resize must be disabled */
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
-	ksft_test_result(ret == 2, "No more auto-resize after manaul setting, got %d\n",
+	ksft_test_result(ret == 2, "No more auto-resize after manual setting, got %d\n",
 			 ret);
 
 	futex_hash_slots_set_must_fail(1 << 29, 0);
-- 
2.43.0


