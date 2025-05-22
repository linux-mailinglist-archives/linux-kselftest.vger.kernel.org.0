Return-Path: <linux-kselftest+bounces-33505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B1AC0A1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFA1BA10F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62F2882C3;
	Thu, 22 May 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEU4Razo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9833DB;
	Thu, 22 May 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911176; cv=none; b=VC/jLB22NrHZyBfWmK0+SScjOKvrjTIOfBSZRrgyoPLzCJBJm7tGl0YFUJyXE5CNBcJRsadNgEEXXsbQqiS2bffYDZyyuUfFEd8mlpolTCNrB9qLWBCnqvl4sl5PZap0mVghNxTK0XnQnxrGyHxGuuobuzoF8TUQZC9VE/qapoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911176; c=relaxed/simple;
	bh=zKB0CIeVdSCddRrlGjAiKbibALkSxqSv1mysxrdExQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8sp2NoyFw6o9Oun0f4GD62W4LzRdxk4pj0tppioGx1gU+PQIzMGLnYBeM+4Fm1jJSgh5nDRqAO2pNu9WvGFzlBKLKaXj3C9eG7Wkyh1hUQfzCndKlvb+SeVWZfDNedE3XwO9DMTjF9rS8Dgw2Kjyf/VevivgGF0tJUTQAVT+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEU4Razo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-440685d6afcso83542145e9.0;
        Thu, 22 May 2025 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747911173; x=1748515973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POZn5cMRur2JoIRBO8c/Z65zsHmAuO3h0XzsNYJfMMo=;
        b=CEU4RazoRDJJxloc6A25RcMctxC8glKVCZG39JxC2ZRkUz0Uf4ukloDzsQoV2ZkBUp
         q+QlOmIhY8jTi0Yq9bFO0tRtuNpBg7aBLGKgvKlfAitM5xjRZAd5getTwy9H6IAPUPLY
         PwhXPVGZd4G1dVO/UmPMaYXUvL/+aQL9uch3lBSB7g2g/NxS7dOwUAaE0PQMCDpscNHb
         3DoSCSXzJa/MwkDnYVMgMRfggRbVge/uQa9zvkLqXYtuKb0KGX+Bv3JgO/mWeCyla/4s
         kcdten0v3RP04CP/LqE7V1qjoAYLzTQSy58S9qSEvJjVQsdmWjAnYj/pLUV/NbGaKfZK
         sjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747911173; x=1748515973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POZn5cMRur2JoIRBO8c/Z65zsHmAuO3h0XzsNYJfMMo=;
        b=gguqoYJCBNmwE21mhA1CVWvXQ1t+f/46ZC2dn6V1waBf4zmMtQjOtOnc43Xdn0881a
         NG20WF94t33fPczIldQn/IWy6iYejuIEHaOOJxrBq9YUXx6kCG4SYgcw1MTnPjTVrt/Q
         SVeYo4ZAcxSuWRa5m73RASwdc5V45mtcNyQUagE/WE9wcBX3Rij/zYveWhl7kaKLpf+X
         VwXcgN3mVF3prIzOf8f/VslY7p5+xQe5jMFvv+O3/LdCyyKWq5GUZksy3ir+uDyhb8ih
         zbvs68/vi9FXUywCjPQsxrHNavaMK21sKFniP50Zr4OS9vVwJfeDarTk++XQVMSc5Umj
         IN4A==
X-Forwarded-Encrypted: i=1; AJvYcCVggDNi5p62wted2A15vxPvm3Rn/nREpuBdGqMsPIw2KAsUI3llrcqA9huVBPi360ublhKEvsPcDvvLIDiOTQjA@vger.kernel.org, AJvYcCW05+QsXjAVWe26/C3+KxBEOksSzL/mueeK45Fg9yW2ijalZj9uP0iSune2joj4gZv2C2eN0gFhu/LuOq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF4CNfUNzl5muocOMF5nNvUjzLe4QDaOjZ2gYDIdXiRm6XJj2
	kwgYFtgtqdwH9cFiM8h7/vFKVCQ/BskEhVmmaKIaGJbuJlDYYrr0V714
X-Gm-Gg: ASbGncs/iQSbO3VCc5bt8kalXE81JRNYKZOHzu9gvYzPPpNehfRERIPAMzOwbjloC4O
	D1lWSzw6KEMOY+3VCJEt9TFuNljRiWZUJL8KQIvj0O2B97fF9yHIysob5X1tMPKcHKuhfi40D0A
	EjlBEUJGNABaE4WG6DjekELmyCdIi5/SQXR3EeSYOMT4dJpTTJwiAm3Ds6+/4WyLqXL3RXU6ox1
	OOYkCtJ7YrTZBf59/fcyJl3D0Ae3YVwPj/49z9a2R9LQDfOqrmTkRu2v72RlozsaKgx8L7JDEIc
	znHn9on7mPbZRFlDxseOnpth4cZZYVZa8+5bY2kGHJgfkHx5ng==
X-Google-Smtp-Source: AGHT+IFoe3Jp7nsZr5IfKAHYwg+2QD1lpVGTPmThnKvRQ85d6HzvTmpaS3TjqdHESQRPlvAIpYV7qg==
X-Received: by 2002:a05:600c:4e4b:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-442fefd77f8mr235249915e9.4.1747911172532;
        Thu, 22 May 2025 03:52:52 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-447f6b29633sm107682075e9.8.2025.05.22.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 03:52:52 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/futex: Fix spelling mistake "manaul" -> "manual"
Date: Thu, 22 May 2025 11:52:41 +0100
Message-ID: <20250522105241.2761774-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksft_test_result message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 2dca18fefedc..0213eb0bb4af 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -242,7 +242,7 @@ int main(int argc, char *argv[])
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
-	ksft_test_result(ret == 2, "No more auto-resize after manaul setting, got %d\n",
+	ksft_test_result(ret == 2, "No more auto-resize after manual setting, got %d\n",
 			 ret);
 
 	futex_hash_slots_set_must_fail(1 << 29, 0);
-- 
2.49.0


