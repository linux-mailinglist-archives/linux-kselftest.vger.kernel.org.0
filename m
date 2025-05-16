Return-Path: <linux-kselftest+bounces-33223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A479EABA3B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926D716A460
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660C220F5C;
	Fri, 16 May 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9rqnDzs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F3282F1;
	Fri, 16 May 2025 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423314; cv=none; b=oEODQ4Q4lu2HK3e6mQrfLW58u8xp274Gxv5vAoTXGv74+T/d/RbBNGI+ttelfFvU24wawhVbBAsmQh8yibDeEU1DbSreAE5sWkwb20WA53wwHFZ5XM9n01G/EE62EBcjAgnB1XSE1TttRO6wGgVut/2kuYKBAI3Y0OmCqOO4JPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423314; c=relaxed/simple;
	bh=OP4hsnjwvFMc5R+4zqPVObrlRrmYfaiIymJE6TygPqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrKC3jKObgo+FBpU05Y3Hrbp8bKpC5uRWs2zI77Y63CmGRwKVwm8Y6hjyXvPoaXe9vVfJYxPxwyREShc5hW3raxH7VjBiyaM0MOJB0/YNGVSYzGofu2h7QxDWp5gdhjO+NHEJnoeEBaNyQq2PSRm5gat5jw3E1QIEE2nCXzMkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9rqnDzs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a108684f90so1667040f8f.1;
        Fri, 16 May 2025 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747423310; x=1748028110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9aRkyuDuT/3p9eGyLP1G9TZQy7mO15Cpxt92EvCYxBQ=;
        b=F9rqnDzsKCUh2I/Dur6zhzxrdNnoeGF1GwiacITw5wWeGLdX0Re/p89gjPUKkTW24l
         V6EbcFI9YSyScwjsxeQmYICLqLddhe56h+ymo3Hs1xiSXVtu/hpuXQWDS82y97wLegkb
         8esE9Ua9louRc0hzTHNcxmX565GJCu5Wb1pIygi+wcSGMjmucU2KlMAqJF+Bywvb0S5U
         GqAVZsxbELQuS0Hp4qJZRyahLCVkmQ+ykufXTVLBJyWdfMJNS6Zhy89UKmGOtQGNeUT0
         uN+S6dX8zo97CJFtqT+Ae2ELXK+YqZvh34qE5M2l5ip+gE30jmli4TO5uR99EIIVgIOS
         +GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423310; x=1748028110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aRkyuDuT/3p9eGyLP1G9TZQy7mO15Cpxt92EvCYxBQ=;
        b=XXzEHwqY/5JjXgeBNEF3g6agct5XzaBtT71U4YhrWCKyqasB8mlcNsM9QFlqXj/s7v
         o7OPI0MJQelNCY82f2ttlK2+p+lbv7A8lMXKkS82AhmP0qEf9ZjdBH8jghuY1HmlbIoF
         pUhmk6XM5ukt4i4w18YLwauiuTgvkPuPdTCrKAzz1d8/A1cVI5zKBJrjiJRQSMnqjX1d
         r2JJpBN1hfpmEKhBqVjPyaYRxE4NgzZYBTOt+KCK39uFyx5J/qzhgS44alKpXrf46yLy
         aM91P1a+HW8POlYPwaqKnOgvtQ7yF+BJqhDEFByXYyKXnydXhd9zZQu732zdrJva/qhH
         7sZg==
X-Gm-Message-State: AOJu0YzP+Muqw47THRSd7bJq/akGrEfGQHQ1gAcC6SQDCRDsA0xTzI3a
	TcYl1Da5SZWxaD3f0wQr91XFXH/LbXwa6TMhLKkVPQjaTkp8CqKBDHTjWo27Op2CbG5RNQ==
X-Gm-Gg: ASbGncuPeDWw4+7X5iRvdTT7E4dcXmGx3LX2ney8oQHnDKbcc26ECuhYVDGAkt9BC2y
	ect38hfhs8pAfaBCgUdxJbnoVb7/NjxqeVRDAgts4BA+Di4V+WMkXyHizP7s2CRrHPZ19LB6ED2
	6T6j8LMkn5JQatqztcpduv52X+DL7tqpxgejOiZlMIRuKxyK9VpnhHs2+6/egFsHnYagTKbeksM
	MXeoL8cesjzNg45Nw8nCKCsubzUEvSig2ODY9mWYq7j2UcIjDHK9g3+N8ws9yOTHV9ILrSnSRV0
	6ITZWnevUZ5wJH5hO7Y2MEgpA01u3DciSyUx2nJBbVlE
X-Google-Smtp-Source: AGHT+IGpRkDxWYcJBs906SQCf+lwJMdvtpwWlSP//M2Fuh241SwrXyozB3+tC4NEEEkdytHhXAeOpA==
X-Received: by 2002:a05:6000:1aca:b0:3a3:4b8a:9752 with SMTP id ffacd0b85a97d-3a35c83e8d6mr4707146f8f.21.1747423309932;
        Fri, 16 May 2025 12:21:49 -0700 (PDT)
Received: from hsukr3.. ([141.70.82.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8c7sm113410295e9.38.2025.05.16.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:21:49 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] kselftests/x86: Correct grammer in VMX pairing message
Date: Fri, 16 May 2025 21:20:57 +0200
Message-ID: <20250516192057.7518-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a small grammatical error in the print message.

signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 tools/testing/selftests/x86/ioperm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
index 69d5fb7050c2..a5099e526912 100644
--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -107,7 +107,7 @@ int main(void)
 		err(1, "fork");
 
 	if (child == 0) {
-		printf("[RUN]\tchild: check that we inherited permissions\n");
+		printf("[RUN]\tchild: check that if we inherited permissions\n");
 		expect_ok(0x80);
 		expect_gp(0xed);
 		printf("[RUN]\tchild: Extend permissions to 0x81\n");
-- 
2.43.0


