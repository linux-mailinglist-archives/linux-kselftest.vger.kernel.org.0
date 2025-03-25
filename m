Return-Path: <linux-kselftest+bounces-29748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028CAA702E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DB3A7527
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A0258CE3;
	Tue, 25 Mar 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe0EfCN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446D2580FF;
	Tue, 25 Mar 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909679; cv=none; b=Ux/zrdYmmJvWXq7+W7rLETjp2F9sXE4goNOrdNmBWZoLUkzadninZxCmZ8iCluuHd0sU/wyfuAY3qPfzjsv6Csxc6suSFdYq5q5/L9/0HQf3mA9T72n7KPxczJTViZalx0sySo2kX8snobIiQQiRAmkOhcb47uTJG8y03bymXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909679; c=relaxed/simple;
	bh=8NhHztqbui136koCHcM1Tn+Btm+vHRGgxH9/0cKV5mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCKsx/6yM9xTV5xsq4QIGGOcEka+h39zbdfYdWykTnj8FMtTXEU5NOWbEMPTDO66xQFeej6QiIKVtnDDxJgWTPrFo+Llp3VIWBJlh+E1rwJfOh0Sddd8BOBrCphaF+ZWgGMookx0zETXMKE62WhUSG9R37gIODnwk60c901WzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe0EfCN8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fd89d036so112354385ad.1;
        Tue, 25 Mar 2025 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742909677; x=1743514477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lDb71nuOirwehOfrtxsxapTn2DVXFjs+EProLsrn5I=;
        b=fe0EfCN8k8nyQ2zW+XzGe9YwP9RWTIMYVWVVjGePFfjhIdUKwL+F9XwdmHaJzoO97/
         Kk+lAA7MHVfP9gTKG6epj4aQy+iYCXzofQOsL2e9PjyPPg1WBoCGOUp+ZhO8dXeRG0tn
         ma+m7Tc3TotQESBh8h8yDsID8InYSesJz4TvNSjcXh5NAe9szKomcK2xh83pZuNY4k/M
         0t9AhhHVJzrK2fimf2+uFealhITtmue2De52Jy5RC9K2D3XGSFDD+hgDO5yOvX0UM7xt
         QyE9f2fbPyPy3nyz/mgu+yhGFKVGvS9lvxHQ7Zp+knrTWPPXBMu7GJOUCdcuXOXRDKhS
         yaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909677; x=1743514477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lDb71nuOirwehOfrtxsxapTn2DVXFjs+EProLsrn5I=;
        b=tAmPFp8AbAaXAT1odI6hNy7ULCLSjQK20M+h6OYDuyhPJx/7jIMrI2rCYZCZeExN51
         WxWcKCuOvUIC2VXCTx/dw/RSzfuK+emPlYWd2EBy6ZlVBnKEPLJhkaorerSyLVzIufF9
         7O0Vg2QXUqXZYvWNlZ37ygeHzzmY2aQ/94bcZSmGWM0RKORqCUKdh0zp0THghDeMD/6b
         a6prfcQN5ho1Jm+5UbHw+qkF3ndNZ0+WsiQHlKxUQL/wJNzszqa+K2rMmqNFrMZZa7wp
         Q/xBZQI6/izTLR0tJowIJwmLBLwzyeE2OCInyl4EA1VZ5StAzxFoU8DDQcq8C/nR4FJq
         iQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMqi/AjbV0GQ1EJLoFwG34+lusL3esb2zU5wBcNWznLFtZYrVDfJ72irCm44AOcbWdvGfT11g6hQ7H1BQ=@vger.kernel.org, AJvYcCWsOTDYdZB+leq/UhpctYA0J+waUdGExvxDPiylRnCbKGlrhW/9ViOEqH236hyl9WBa27TNjc2RAi9i8WNHNlIf@vger.kernel.org
X-Gm-Message-State: AOJu0YwXkzaUvSnG0m+uYbTl+/oTZy/jh8jjVRbXR+2jwelSw4/WYd0W
	PtEAZvlYtSAQ6C0aj1sL8aYBQqzJDoJg5jPVFv4QG89UknRBEIAR
X-Gm-Gg: ASbGncuVis1oEqgDf6vF7r8eTIgUpsQ+KwMFzzBAA0M+3OGWy/HRjL60sWGwzIj9Gfi
	d1CY23o/WTwfaLlTftCZvGjmtOi9RSKGDun1mriCN5BYfdHd36Y5odoh7qpv5ZETS8KU8eIrps9
	pD0x4TyCiofBHnKlPqcBMHI/I66ykv08H5Y03cflBvMRUNraHoN/XZr6Ahd6ILOh/pSofqDyo1y
	gi15MPPPz1WvhTQB/1JxaFoD7mhwtKw//N1a/pRm6QDhxp6oPREB99BHfXID1ptZGZEXBo4aj+j
	Q6LtSBliWzrZp/M+jIr2JA80GKbAiwvvfYS2i02sAT0ocj2bHAlH8YLsPxOPqjujK9D8i2RZU62
	Pre9iu/QGTrhqVw6z
X-Google-Smtp-Source: AGHT+IE1S9OMVu5RWHUF4Bez/J9y9+A/s+hTIvZTOtcr0b80Ew/3RYmNUmC0vHgJmEX+H+3RL9bLDQ==
X-Received: by 2002:a17:902:f705:b0:224:1c95:451e with SMTP id d9443c01a7336-22780e41efamr246061775ad.33.1742909676735;
        Tue, 25 Mar 2025 06:34:36 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b3f2sm89766215ad.29.2025.03.25.06.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:34:36 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: malayarout91@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/x86/lam: fix resource leak in do_uring() and allocate_dsa_pasid()
Date: Tue, 25 Mar 2025 19:04:09 +0530
Message-ID: <20250325133423.13665-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <malayarout91@gmail.com>
References: <malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exception branch returns without closing
the file descriptors 'file_fd' and 'fd'

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/x86/lam.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 18d736640ece..eaba0a921322 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -682,7 +682,7 @@ int do_uring(unsigned long lam)
 		return 1;
 
 	if (fstat(file_fd, &st) < 0)
-		return 1;
+		goto cleanup;
 
 	off_t file_sz = st.st_size;
 
@@ -690,7 +690,7 @@ int do_uring(unsigned long lam)
 
 	fi = malloc(sizeof(*fi) + sizeof(struct iovec) * blocks);
 	if (!fi)
-		return 1;
+		goto cleanup;
 
 	fi->file_sz = file_sz;
 	fi->file_fd = file_fd;
@@ -698,7 +698,7 @@ int do_uring(unsigned long lam)
 	ring = malloc(sizeof(*ring));
 	if (!ring) {
 		free(fi);
-		return 1;
+		goto cleanup;
 	}
 
 	memset(ring, 0, sizeof(struct io_ring));
@@ -730,6 +730,9 @@ int do_uring(unsigned long lam)
 
 	free(fi);
 
+cleanup:
+	close(file_fd);
+
 	return ret;
 }
 
@@ -1189,8 +1192,10 @@ void *allocate_dsa_pasid(void)
 
 	wq = mmap(NULL, 0x1000, PROT_WRITE,
 			   MAP_SHARED | MAP_POPULATE, fd, 0);
-	if (wq == MAP_FAILED)
+	if (wq == MAP_FAILED) {
+		close(fd);
 		perror("mmap");
+	}
 
 	return wq;
 }
-- 
2.43.0


