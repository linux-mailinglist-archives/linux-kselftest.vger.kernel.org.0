Return-Path: <linux-kselftest+bounces-34113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17BAC9EDD
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2439A1728C0
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383901C861A;
	Sun,  1 Jun 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlIR5aDJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934D13B5AE;
	Sun,  1 Jun 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748788169; cv=none; b=Jq0lsd2m7V9EqhTb9KXiODMKmJUPFCXXyCwr3OsoXwRnci/hMAr17UtLiCHyOdpTsPlpN8aCGCaZ9m+i5QeS6a0tU3s8IJB2EG5od06IA8EIzGzmJyloBKv+N61QdFPfi6a/uP7wUrZkrbLYntxO6gDLwI90tCYla/cU0bkbj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748788169; c=relaxed/simple;
	bh=76nduKoGenQwf6yttGqWGpKqhgPjKoD75Jyot5BrlDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Est9Ywu/KrrShitk4I7XmwLyg153jxUfDBRjCO1OuUjBN7S5c6si7f0yPqptwUPIy7atDD/fqISR2hy7VWmEzhEidb0WZ+cMkwVSTtSBl7yxMt0Pl3nLz849JDnaplzuU9uYe3qq+3UXX46yspqvWKvPjyDNCpBy7Z/DdyU8Org=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlIR5aDJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2352e3db62cso19175235ad.2;
        Sun, 01 Jun 2025 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748788166; x=1749392966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lYlMxFzcOzqXUwvjEnm6Hgdy5hPN9bp/GKsEzjoZb4=;
        b=GlIR5aDJWH7pzRW+GBydbYluS0rkdEBuW5yk0cG2Iv5QlEmiuJ4ws/nvlwS2cxYYTe
         Pml0LeIrQxZEzOg5S+Y5h8f50upwDiVwXklm3oiCzHzHTfFt0g/4k1flIIVdxdLJg2pm
         dTkEijr9L4bRtrJ9Qjs2+I5TdZjPvj2JAoTArnU6O+ifLJLoRE2uloMv8mtePeRRFUHG
         MOdvoU6xQe/7WN060BANP8JA611PIIPQW+5CZCmtMqCVuQiAAd9cE75SGng329m12Y6r
         z4fiP3HdXHA9P7HMIH8t0vrVknZlfaqK8l/7wakuCqY9cFUFyc6/lTWWZnB3fCyKZe0T
         zUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748788166; x=1749392966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lYlMxFzcOzqXUwvjEnm6Hgdy5hPN9bp/GKsEzjoZb4=;
        b=W7D1WTft6PoBserFW7zMfB1gwUHmHFuVhR+bhjd7hWvUg1ABg3jPaRmlWjcAl4MibD
         4CkkobevuqCylLJQoWAl1x0lFFIew+JkL9BikBV3Grk3WVafW6xy5XMqw+bsP6ZSCDyB
         U/m2pl/wh3S2EZO+JeibG6aelOmCx9w4dnbyOoy+JgCT+drRQwCNfMgn7hdwTUN6nitZ
         rhjuge8nhCHjqp8Fpl6pZzt30qaP+EYDQbBH2Betjp3kLioR4McrXlkKdzlIWWNwzhTc
         pgMols2pvVslykIrQwqjo0nyLmq7IagOiItqS/DcDO/NCpUgBiVHRei9bukec6MR7Kxx
         2PMg==
X-Forwarded-Encrypted: i=1; AJvYcCU7R4itnL5MJCf+1bbogqhi30BNBn8TTqc2qfcqHwspe1wFqS4rdxQqmmuGvrqrK0HTcIFqVDkB6iGp8w6mZxG4@vger.kernel.org, AJvYcCVtpAIOh+0/jko1C1t2R3B3x3Wm4RH431Qag6cAu1fRcKsVWmTu75TMzKT5cLKZMCd4/gr+jKsWiVWBUsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKYrr89CA2GVw6UVhF15eQz8L0yUAhh3PaFNsAFsSHFkjpmtY
	WCWso3J8eFAPTIuHj0Aveu7QakNDXqAzALSFaWEGrqQrkNYfdKQK//5NvoT+DU/i
X-Gm-Gg: ASbGncuCTTWjz7KI7ApUDsdWc10FWFergtDnqP0zlUtAKjIBzicp8WORwaXW6HlAC5a
	1Ohca8vrMaXfFidSif8PGzAJIAl3a1y3geQsE6/XQ5/+JDivxDgEAcmAN2iCyUnWd4qzQIPkgrF
	1MWLmALgYrrxczdoBxwxxrIHxCtop1j9MpprseDuTOyp0PhatES86kdZ1McRC3n84seXKF5gGhY
	bTO4YnTQxVoxL+jmZ84reeRYTwEZHyOxOEjJh7gx1UuBaMCjmMWSjVhtWrWGh5/QJD/eV7RPS7F
	IdGSpnlRjtx1wzfvvB+jeUxdyCoCOL+n2lnR60pKjc3xs0YHR54sNeIzxPJaGLpZY0I=
X-Google-Smtp-Source: AGHT+IEhB8tDCOzGCdRpcC5zQv1vYxYbpB2qEe0O1pupO0ZsFpqdczhFHwGUNmYESdQoKCCMaUXaRg==
X-Received: by 2002:a17:903:2285:b0:220:ea90:191e with SMTP id d9443c01a7336-235289c8335mr156205745ad.4.1748788166274;
        Sun, 01 Jun 2025 07:29:26 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:758b:1594:3f21:feff])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23506bc8863sm55827285ad.19.2025.06.01.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 07:29:25 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philip Li <philip.li@intel.com>,
	oliver.sang@intel.com,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v3] selftests: net: build net/lib dependency in all target
Date: Sun,  1 Jun 2025 21:29:13 +0700
Message-ID: <20250601142914.13379-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have the logic to include net/lib automatically for net related
selftests. However, currently, this logic is only in install target
which means only `make install` will have net/lib included. This commit
adds the logic to all target so that all `make`, `make run_tests` and
`make install` will have net/lib included in net related selftests.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v3:
- Don't remove INSTALL_DEP_TARGETS in install target so that net/lib is
copied to INSTALL_PATH

Changes in v2:
- Make the commit message clearer.

 tools/testing/selftests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6aa11cd3db42..339b31e6a6b5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -205,7 +205,7 @@ export KHDR_INCLUDES
 
 all:
 	@ret=1;							\
-	for TARGET in $(TARGETS); do				\
+	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do	\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
-- 
2.43.0


