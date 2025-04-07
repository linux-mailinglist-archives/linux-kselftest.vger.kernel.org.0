Return-Path: <linux-kselftest+bounces-30279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27440A7ED93
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9170D3A3E63
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5891EE032;
	Mon,  7 Apr 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1+kC6bb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199F15F330;
	Mon,  7 Apr 2025 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054501; cv=none; b=UhJpHHGsUu2tBwQTmYbPdVEmbF3B12UemxzBppZ3v1JpKUwvS2xqby7+x4OmPnPCMJKWxNj2K0200c01mW9dDp+TtSMy7DxSfif03ZWfcQxSf/X/ssffRl3QU36sWiMFi/pceJMUwp2JwxLGv78ExQDEvPzs7q9NLl2Rqmkkscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054501; c=relaxed/simple;
	bh=P8VUB2KyahUUrwltU4LsvlUOVVJQ1HvGvvkiqS4Oqf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Akf8B2HHrqDpgb4hkxI7jdfXK7/88BFqnyL/wH18PjYX76K1BXvl7jlppj+ma1QGDa9h3tdKeuxzImaR/wIUX5cDJq7XSPSsCIfzIyit3WwePlwrvTWh1q7k7qjqXs7vhEsv/QfLFqRZvU6CZF/asJdkZHbYzWRfff6gNZ6q5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1+kC6bb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c277331eso4330202b3a.1;
        Mon, 07 Apr 2025 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744054500; x=1744659300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myxz0Sw/NehL2v/GSQHw7C+PaEk1uWCC3FckzFHhG/g=;
        b=K1+kC6bbX4K8aLn3tP5CM505ZZOjiehYfKlrgcFuvzwRSa2ApF26FRG6LGjFwGU58g
         59t5mjxhZuv7++1JZ13y6cW936Aw3Q+iRPlyFDk20K94raZrm6M1BgVPu4GZOdj+0jYK
         mijamzanKpVpqdwkvtNi+LIbwjUq2U7yqjlCy04ko27Ex9nR6SeIOC0OHJpTLVZwTfm8
         OjEXuHo+j4byp7zIEIRuHiu3AfryAOj85peTyEf7+8wjef5sEED+/WTIDlZhr9juddkh
         /YM9VmEmXFRgfzYjm6uBZKQbqovhEgJaOBlLjm8Oi6yRRaxoE647Dwv7sO7Xq8Qcfsd4
         kK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744054500; x=1744659300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Myxz0Sw/NehL2v/GSQHw7C+PaEk1uWCC3FckzFHhG/g=;
        b=n9Mw35LcgHVflb+LjgmJrXf5LKdgSNV+sPR4Aw9DLKYIT5KuQC961w0i3qBE6JiuGM
         7RTCecmSTqBMmuuOwvmWTI1Wk3glCmQH3FIBSqUFjjU17LiWGr5H0p6b4bh/nt7vAu/Y
         o3XJvy1P6orY62B/YRSc+J28il6+8pB3DAVvCopOtsIZfXmYQLU1TxmfZhG3xr+0Zqc7
         o9aLroAXLuKhCPMDaB1TtZdJznCbBvn896dAjDWXhcFQhFWjmedJcmMx+wVG5NzIX+1f
         2POXKISefc/jeOvw4zJ7UGNHCMgnftvODGM9hZ9GMhti/w7v7wL7RvHquuQ3f7kGgcwl
         eiZA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMx6mIRDt/XKMOgv/AqhH1y0zcO8UdNsSR9KolZkUpmozTx2iF4bMxqE9eJLnBS5YDv6TLxGQTBnU3vE=@vger.kernel.org, AJvYcCXWKwwEkEQFzqgDp1tzP2z8yzYjup+MIHEU/6rfQAbD20DlzA/T2LT2SQxXedt68cyhTIl2p9m38f8QgCNAxEUf@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbSh9zbDbA2WKrx3/eJmd+zOnHkJqa5tkPclSQZFr40zCPNbL
	lPaMQdTCqQTCmlvJy/7VtAwZUiHUQSWELCKCIWmSzl/fWq7FrpF7
X-Gm-Gg: ASbGncv8FV4SGpAQqSEGloPae/P+gsKG/VfKWyaK5JY5NPXB6sWREMDMm1Ev8OPEReR
	PfyL1MOYEGT9litdlA0LniUy3IWncfpySX+EtT2B6RsbYiX0nyxstUkcaJ4+pdE+bwncWb0h0Du
	vn45mBk18JSf1B2+UJvsOVhaUdl70rfS4TgTIa47oiMIqATL8dhzvo/z2YXV370vpuX63iOooZQ
	YmrX5D8PE5m4zXehjGpQFJwUfFE3yJx8JJEfUsdEOMYU7ZtElvivp8FruVLOMqcwJKfTwrwGFgr
	wVniBQM9D//tHHm3DNUv+Cs1VYv+QZVwTcsFa5CSfq0qcIBpfRuhfslU+e/59Bmc78wGlRcxu6S
	HWiOV5/skEAxG9V/b
X-Google-Smtp-Source: AGHT+IEj30NTIqd366ZgZjl1/kg/dbAv2Mc1+SO+m2w5sSHp/pH6mkCNNQfyYjnhT687qNXgmJi3Uw==
X-Received: by 2002:a05:6a21:9009:b0:1f5:8cf7:de4b with SMTP id adf61e73a8af0-20143a2a43cmr786345637.16.1744054499568;
        Mon, 07 Apr 2025 12:34:59 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2d04e5sm7697610a12.4.2025.04.07.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:34:59 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: mingo@kernel.org
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3] selftests/x86/lam: fix resource leak in do_uring() and allocate_dsa_pasid()
Date: Tue,  8 Apr 2025 01:04:48 +0530
Message-ID: <20250407193449.461948-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_QXURMplbCtx-YB@gmail.com>
References: <Z_QXURMplbCtx-YB@gmail.com>
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
 tools/testing/selftests/x86/lam.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 18d736640ece..88482d8112de 100644
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
@@ -729,6 +729,8 @@ int do_uring(unsigned long lam)
 	}
 
 	free(fi);
+cleanup:
+	close(file_fd);
 
 	return ret;
 }
@@ -1192,6 +1194,7 @@ void *allocate_dsa_pasid(void)
 	if (wq == MAP_FAILED)
 		perror("mmap");
 
+	close(fd);
 	return wq;
 }
 
-- 
2.43.0


