Return-Path: <linux-kselftest+bounces-29634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B3A6DA3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9823B189357D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5D25D54D;
	Mon, 24 Mar 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRteMB+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38060199FA8;
	Mon, 24 Mar 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820502; cv=none; b=VH6AnT0t4v0a+HhYheQzyPszzpTjZIOcb/8ebFp+ZqfP7Fz+8CmEP9GgMPoaFbus5vYS8Mhq8n/ooXSQ/SeFz9jcrn+xUcWefIjaMmtbopZdJMUTyOzUGIe5K7Yv0bOtiicrayoUf+kp2zlicVizB4ezIl2eCPMqVPBdjgSqtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820502; c=relaxed/simple;
	bh=3YbDOdA9DXtwFIK6X+k3nSeQQIvVJmSvP44iJ1mFIqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol4WTeK/pJyutOy0c7tVQEXAon2hROHBRlv9hlWrcNmOauG/E1aYisPKxLUQ2kLEOPV7/Cjx+Ddpzht53y9rTP5g7b2VlXARzRDeKxXwJvKp02zJ5E0z1mauwSyYMycWHED7FPqi7Bzm07jQqsOt+9qBm+T4GtTH+3lI9lfWCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRteMB+z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22580c9ee0aso81507335ad.2;
        Mon, 24 Mar 2025 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742820500; x=1743425300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8dAuAWPh1pY0fNb9u8ovOqLuwtKwUlRHchVkyM+mvM=;
        b=hRteMB+zCq3ElQeF+7lSVPogdPyoVXyRwrZjhOYpMyIZFTUqIGp0d96NiVrSGV/JrC
         +JWmS90BpdSNYz/K6ffbFpU9e5/pC+WuaaplSF321heax5BwNOrMjn7YDuAEFa3X5nkr
         EQqIHNCo4zahduACADNot5lko8NnsR8na9fJJj9oYWfZhWHNV7M9LcQr12hz9D2MgwT9
         5bWl0T5eVqmkNub8a5RH12WUP44SqlIPs9oghpnYRgDm1hXSvi8mBdNVPLb0UdSJm4ih
         RleST1bYS3peWYLbNKY7BlZGU/SZQxpxFpargmcD3aWlkGkqVtM0j9dgOUEwS0W+By5O
         y6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820500; x=1743425300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8dAuAWPh1pY0fNb9u8ovOqLuwtKwUlRHchVkyM+mvM=;
        b=aITF+wpfQXzwkDbSbShsy5jtZlough1ONw3Xwbwv87KCJayPLXZ8iGHfrlXf2MvQP2
         rMOqkEJttJAYRTCZaAZHgjHkLn8ZHBBlGSeM0mb43Y3hPrMez3V/602p2IsIc1pZ2fTI
         mAnHAN/9gFfz2A6iH8TQx92VQoDlWF6IPvY4bGi4btELzyHacwiSozNgM8fYPKBrPp8Y
         vAX0OFURfSAMir4oJhixVSRkIU9bFK22nRo4O2C+csQOGbSUePF16+lkSc09T247ckXu
         FRdzY2fcpdpj5Y3SwxnLwgQDhYH1p7s6JnR5i/tLhtM5pwWKnPs73g+ycLCaQP8bulik
         xo6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZnqBUwZSmFc1Sku7r3CQsfKVaEo27+uLYhiX4zs10ee1Oxn1MJ7BASeXZcy0MFRgS+TLTfGvL7+K0t1uyZLqZ@vger.kernel.org, AJvYcCWpa1TfP4ttakyVSFGUMgrWUGTAK+SjIkyAG2QB7z/buDYs0JRR+FkBE+Vo6rzXfRewjH9/W0+b3jyDinI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbun60CPEkuE3YKEMPW/6ibd302y6kahLOd+HQ/B4NjQxkfXM
	QKoRR+ezxEgJic9LrXiDPdedZbadQuL8tyUoZJ56KUCIov5tqLnt
X-Gm-Gg: ASbGncu/gPEvhIBsWmW/0MBxMPJMZIQIq6jlD5EP9pyhxeRO4tgaspIAEeu9HKFYmOg
	fVL6V8UuRxZPe71juBAryC+sjMyq0p6Je14ZmoCsbVmhkjcWUUzjlBhKtMB1r1tVzeCc4DVEQzo
	nYa2/aL1yHSoqGzOJQC9zoaLx/H7pokr2+Z1vfSa/KVRXvVvBK7y9Mo6DxM9PaElRJrpmW6+lMb
	TDQKFADcb+TILW2uexo1EviappOWVNc+bvwSdAQL/W24r9v1kh5Ixm5rQkpB1eizihaOdm6Q4m4
	OAzvGxS9y36Plui8UjLVv8QKiiVjngr/2al7boNG8eMUMfgEyuFl9n2cmfYIj7FP6ZOGRxEGe0K
	UUSJASw/Id59WhvxD
X-Google-Smtp-Source: AGHT+IEBO1ebLzwmFuTxfyLOPYS8ZG5canaN7CGq3JXFy5MqsKpm+YWNP5MNe7sAaagqbcWd7V7tcA==
X-Received: by 2002:a05:6a00:b96:b0:736:4a5b:7f08 with SMTP id d2e1a72fcca58-73905a27818mr19268831b3a.22.1742820500118;
        Mon, 24 Mar 2025 05:48:20 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a5f6sm7796114b3a.82.2025.03.24.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:48:19 -0700 (PDT)
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
Subject: [PATCH] selftests/x86/lam: fix memory leak and resource leak in lam.c
Date: Mon, 24 Mar 2025 18:17:50 +0530
Message-ID: <20250324124810.883767-1-malayarout91@gmail.com>
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

Static Analyis for bench_htab_mem.c with cppcheck:error
tools/testing/selftests/x86/lam.c:585:3:
error: Resource leak: file_fd [resourceLeak]
tools/testing/selftests/x86/lam.c:593:3:
error: Resource leak: file_fd [resourceLeak]
tools/testing/selftests/x86/lam.c:600:3:
error: Memory leak: fi [memleak]
tools/testing/selftests/x86/lam.c:1066:2:
error: Resource leak: fd [resourceLeak]

fix the issue by closing the file descriptors and 
releasing the allocated memory.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/x86/lam.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 4d4a76532dc9..0b43b83ad142 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -581,24 +581,28 @@ int do_uring(unsigned long lam)
 	if (file_fd < 0)
 		return 1;
 
-	if (fstat(file_fd, &st) < 0)
+	if (fstat(file_fd, &st) < 0) {
+		close(file_fd);
 		return 1;
-
+		}
 	off_t file_sz = st.st_size;
 
 	int blocks = (int)(file_sz + URING_BLOCK_SZ - 1) / URING_BLOCK_SZ;
 
 	fi = malloc(sizeof(*fi) + sizeof(struct iovec) * blocks);
-	if (!fi)
+	if (!fi) {
+		close(file_fd);
 		return 1;
-
+		}
 	fi->file_sz = file_sz;
 	fi->file_fd = file_fd;
 
 	ring = malloc(sizeof(*ring));
-	if (!ring)
+	if (!ring) {
+		close(file_fd);
+		free(fi);
 		return 1;
-
+		}
 	memset(ring, 0, sizeof(struct io_ring));
 
 	if (setup_io_uring(ring))
@@ -1060,8 +1064,10 @@ void *allocate_dsa_pasid(void)
 
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


