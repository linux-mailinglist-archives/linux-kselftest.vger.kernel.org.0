Return-Path: <linux-kselftest+bounces-33317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47173ABB7B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9363BA99C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E65A26E15A;
	Mon, 19 May 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgrA1TEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4326D4FC;
	Mon, 19 May 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643977; cv=none; b=ECnS3sLnwhB6Sgn6umOEaxBedOBrvuAdxb8UiU3stDHQjRVPmTJw+DmnO1BD+5Ab25fhyhZFL2QE9+KjOnjahENXQVewo9fpncZ4MCCqhXIRTmdTLT2ngY5pHhyVDEtoNywxYuOUbfCktSMQ0DPehxDJEEs5iqGtDdqUf+/S6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643977; c=relaxed/simple;
	bh=gkL4c0N8EQCQ/TM+Xgmyl4Xxmq9xWn4IgHVEm5KSkQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1IVt3yxXnzBdFetWhJBpH/cUibXKpm0VQmDzTrG61+5h5HoPIpekYVw78g9bFmA649cxngaGy8tVx/fvCVkay3PmGEOrRDRqL0KffUn4nv/oQp9eF5m2l5bqQKPcaQ5+tq8TXO9Z+owYCIe+DbymI7cMEWefOdnQt3LqcNWeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgrA1TEq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3588658b3a.2;
        Mon, 19 May 2025 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747643975; x=1748248775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kENFOvYuWcx0UUtOBeD2O9KLGAkfolJVCKtEv6YXZCE=;
        b=dgrA1TEq6Jny9s4ElzNcqfZusxqesrfd2cACSeLxmMF6R3nWw6KDgx+7DYFhHntJUq
         gGs7lCkCr3TY3uJrWyCPtcAniXpDaCMFoP+Q11NsXYAJQLrzKWjqQH3NJ0si44NhNZdE
         FvOSLS8vBRJDzhI1OA1lWLpQCn6LGKEJbz0CgAStZrqsXXnkUerwHcNSRt9dB/m4/9CG
         YKyBTW+r7OvcLIqQ5UAP0+orfkk9eQTQpFAL+6bMPp1SghEbK+eR/C42zENeZsBvgZ3w
         AOKUw+B198CbjxlFN8v7fjOUHBEOA03dnG7FytsI1e2hQHoLF09mVf9Hvy95BWfydofM
         PX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747643975; x=1748248775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kENFOvYuWcx0UUtOBeD2O9KLGAkfolJVCKtEv6YXZCE=;
        b=EHUw6FEPM/j4dVM9FwKHTakfxPc1HeBfPMbW7dfSDd5c7V+HUr8gj9+2pC9pv055Jk
         Vn5rx18B5eVhZanz/+7mhldujQvvUsGcRpV0IsOfrJIMuw9zxo8wrRvJeY0bqq0VGbQ0
         A+ePW6Rx3Kk1kXrhs+BKUrviCYrEbj7ND+Z2zHpNeoDpNGLYKs+491vj8gQHdXFEzzMo
         JG4WcDODJ94LqHBa6e7nHF7+3woqlUTUie+LcYLuxONFYEk+Y3mARGIhD7pJjmf0KsNG
         qhOt46DGSYyYDYHDjqiUy3JVOCTJTdLCxAXg+i6bSRQ8LAuKv+E+zYX9SJf7bLRacNzo
         0hxw==
X-Forwarded-Encrypted: i=1; AJvYcCW43LgrjQJbDhNdi2JbpVIEwO87Pj2fSg6PWkYUa4JOe+gtVO79UPd07W5+MexmeDDdWTlvOqj8q7REUmPX3InU@vger.kernel.org, AJvYcCX7NVtmt4mIvg64dgsqzruMXd/B4ze6/FHSt8RZ6mHWvTtyHv+cr5PYymYhOJppgTFnDaZMRFJdIGWVmbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcT2l8xWrhKUmuhtorFVZWCFbblcxIyO9BylNbWXlT4QqVDKL
	ayBV3ZQePCJ7EFTcyP51KnA9h3Wov1zBjvAT9shIQ1blCxSnW77NESY8
X-Gm-Gg: ASbGncvOnSrMBa1TZga7iX/sieKQjNjexHPcRlr3LHH0Gytyp/yiuqoweHCul1SAR+4
	BhIQam4E0f/ZsuJaY7e15zG10ajz+a+PCWMXAXFzF6bRulAg4SCSIKTcf5fVUU5gFfWxf17uSb6
	zeOw3lx+QY5H7xzvZMFwfrX7PTwEkxe3xtkAIHeAQrMYiKxOr3jA67CLqdNcyGme/b1ylGAh1p+
	PlIr+lk1n+CIvxznxd4dDtmCOBN24R6SZ1P0J6Xe9b1m+0VPbSTN30puPUxIX1HltcPqDjZUc0i
	anfw0vEKszp3DyWTY/Iq8RR0ogcES8OB6BMkugTp9kTiOioA+O6e/yDm1Vlzav1Ust8WNQ==
X-Google-Smtp-Source: AGHT+IHnMFyK4wPedXmqlwx7Uy3jvXCrtJ1LuMTdzsfxvdbOvP3q5VhbVHgZkkiVl/c3T1W5ka8SXA==
X-Received: by 2002:a05:6a21:3511:b0:1f5:9961:c44 with SMTP id adf61e73a8af0-21621882725mr20142425637.3.1747643974720;
        Mon, 19 May 2025 01:39:34 -0700 (PDT)
Received: from localhost.localdomain ([45.252.73.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084428sm5705950a12.57.2025.05.19.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:39:34 -0700 (PDT)
From: Anish Dabhane <anishdabhane71@gmail.com>
To: skhan@linuxfoundation.org
Cc: Anish Dabhane <anishdabhane71@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: cachestat: fix typo in error message
Date: Mon, 19 May 2025 14:08:38 +0530
Message-ID: <20250519083840.57099-1-anishdabhane71@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a grammatical error in the output where the word 'to' was missing.

Signed-off-by: Anish Dabhane <anishdabhane71@gmail.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 632ab44737ec..1406bc9f2b87 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -76,7 +76,7 @@ bool write_exactly(int fd, size_t filesize)
 		ssize_t write_len = write(fd, cursor, remained);
 
 		if (write_len <= 0) {
-			ksft_print_msg("Unable write random data to file.\n");
+			ksft_print_msg("Unable to write random data to file.\n");
 			ret = false;
 			goto out_free_data;
 		}
-- 
2.49.0


