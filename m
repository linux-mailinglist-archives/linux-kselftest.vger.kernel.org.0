Return-Path: <linux-kselftest+bounces-44893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E200C39FEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 745BD4FE847
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4754530CDBF;
	Thu,  6 Nov 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeHZwXIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F730C345
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422950; cv=none; b=B6bDmCPbDZzAsVO31hLOlxforBquiWyLBQk7huPPD2HPESD4bZ+4GDI5ig+wQoOHReVo00z1tAzre1Y1/ZbcnAYAcdFTxMP2v95Z+42mUbImmxZaU6pNJL6bInwv+RGVKvb6PiaKAfLeEH2s3T8VJRgOa5Rk28eCPs2AZ2PVdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422950; c=relaxed/simple;
	bh=lGb+rCNSnJ/Re9I074l78vjpp6/yu6/7U6mL2e+8rjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsGfbnZ1nJHX88ko1Zxp7EqSLuwl94leqTXDlk+zUdel/ykSpKCOEXOeA6KClUefE7m0MOYKeE2qpEi62E+xGo+BntpNWju1q7i/IYEzus77sKNGy1QZnsg1aD5cTiNHzazQQGgE417L4a+I+tHLAkPa78QYAgTwjjhkACsB+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeHZwXIl; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-290aaff555eso7881875ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422948; x=1763027748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx3MpVj7PiHTaRtB2+AQXnkYRvNzs0/kE3anQ6IOaeM=;
        b=DeHZwXIlOAQIZ4IYN0+ls86e4UlJ0pQ/AJlt+cSbeVJ7vEAtxKCq7cKJ7GjTgJD9h5
         HKK08f04i+iB8Yj3X58iYIiAnKwOoiS1cWccJlln6STUByWjrmIfYUBMxMbI0rTRHEIS
         BH9P2R/6EePvfMC0AKE1F0saP/KAEkG43owBXowWkLgV/KiqysTUUk926Fg0LUZVmytO
         VWayLjKTxISmBgBjxtajeI62BBHnYXFNETGwv473Nz2wt4cPYPEX/cI/bI0yN936IoCg
         deX5AdMpe5qCDxhl1P+ITLp8FQFh8Epf0c/zcxOEDiTpmeV+uRBzSOd/qbClOtoCE26d
         lMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422948; x=1763027748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx3MpVj7PiHTaRtB2+AQXnkYRvNzs0/kE3anQ6IOaeM=;
        b=DCOIm61QuuBG/4N+96U26ANTtKYizO9LhHAZGPHhAqbWRV/CjpEmmMVhFlvMnlUQ0V
         cMfflrigyMvbICzoYNesvPn6zLFPz46aKr9afrTWDuTvLQITD3cxKKsc/I5JDVTFhxTb
         IuKPGlD1/6HZHGcQvPSUZrS4o5HCS/ZRjXSLWV0Ed+cJngt1Jts8gWkAYNhfJMODwzQf
         se9QytZ9VhQCo/j7d2Em4J5d51sVnE6TYdw++hOTAGVNjxxP6xl42b1v13QqqTOHzB+L
         dXlHkI/OoSnFuuhpFCNrDHAXQgRMUx4Ss4bzNxzG+7EDbKzni8hteGhYJdq+FcVV+sXp
         CiZg==
X-Gm-Message-State: AOJu0YxSlGGciJIMASc7HVB8XpcD/utDTnB3c9kRDtB4DyShEqxHssZh
	YFg/r3IwiiVgqd7lOSFNCxjqotZgSgrn6s51AvU+XzZ6cDOPpjcUt4+92QmDjKbr
X-Gm-Gg: ASbGncuAq0o4iEOkW8+LwHCEHoN4D8UMgnbP7f20iHK4aW+92ZVfE0zFsYTf3cdSmmC
	uldxI2rsOTDxKA5k1u4R4A9ICEx6Z78N22FaG0dKSDW5o6chFg6FoMxGn0tRcAY3Tj/ypRd5BrN
	WA0NxRZwLmJYhjy43l8wk/W1FgdXMC7vp4IGRn9/8LBPBNk2zgKnfXTX1SOebf9rwApQ6o94A9j
	jmU02eLYtnKiJEyIz3HasMxLY+hIK3tcY3RrLhaLuvUyKp8Djvhr5T94rhkORES2m+BJN2C1HoH
	YBkCxYCAIezRV6SMjsF3uR7QddgHX1rkQk+5k4w8+D+B61tmf2xvKzNTZZ6WNfdteWF1ov+vcer
	gj2ZeTbSFrQrXVdriYdNPOogFG8vF/0wqeVcDTY+6dVZkqiDqh1DuQegXgW+dRg+TGPcfB5m60A
	kwhgMlq9nEabaWGW+PNcg=
X-Google-Smtp-Source: AGHT+IGLWpaeqUyOqwgdTGI+r36lnGa7tydw0O2a7A+GFy9ENF5YsdFbKzmv4BnmJ82XJw5jO5gf6w==
X-Received: by 2002:a17:902:d48c:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-2962ad1bdffmr91436475ad.24.1762422947738;
        Thu, 06 Nov 2025 01:55:47 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1eb7sm23046285ad.89.2025.11.06.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:55:46 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftests/user_events: Fix type cast for write_index packed member in perf_test
Date: Thu,  6 Nov 2025 15:25:32 +0530
Message-ID: <20251106095532.15185-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
warning due to potential unaligned pointer access:

perf_test.c:239:38: warning: taking address of packed member 'write_index'
of class or structure 'user_reg' may result in an unaligned pointer value
[-Waddress-of-packed-member]
  239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
      |                                             ^~~~~~~~~~~~~~~

Since write(2) works with any alignment. Casting '&reg.write_index'
explicitly to 'void *' to suppress this warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
Changelog:
v2:
- typecast '&reg.write_index' to 'void *' & remove use of memcpy as
 suggested by Andrew.

v1: https://lore.kernel.org/linux-kselftest/20251027113439.36059-1-ankitkhushwaha.linux@gmail.com/

---
 tools/testing/selftests/user_events/perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 201459d8094d..cafec0e52eb3 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -236,7 +236,7 @@ TEST_F(user, perf_empty_events) {
 	ASSERT_EQ(1 << reg.enable_bit, self->check);

 	/* Ensure write shows up at correct offset */
-	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+	ASSERT_NE(-1, write(self->data_fd, (void *)&reg.write_index,
 						sizeof(reg.write_index)));
 	val = (void *)(((char *)perf_page) + perf_page->data_offset);
 	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
--
2.51.0


