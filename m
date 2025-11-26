Return-Path: <linux-kselftest+bounces-46554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D4C8BA37
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3B4EC895
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18ED347FFB;
	Wed, 26 Nov 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4xIFy1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C4346E6D
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185792; cv=none; b=d2VyXY3GC9CME+w891oHbZLo/TA+nsEaLLiVLuIFkoq8OdXUJ1U6wS3TodGhkiJOSHJUp5b8KUhqMmiZGI9/cR6T2Hx59WbXVwzXTdKSAaCXQVtC/rZ0jHTCBUeCvG9K+QL9EiZi2SBW1p0mxtjZXJLGdXmm+x9wqdYRnQT1QR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185792; c=relaxed/simple;
	bh=AYgj+wirCLMCRR/8ot0I5xWDdqgGP4Qyh8BZEo8RH9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bh5H/94CgTSKlWctZXFhEuk8lg2Pny+sJVvNhVtgnZqh+LH2Gen23h+KZno81X2vMYDQPE64vjYWycwGzhAfe6cvwwEWJa5pXcFmkipS4CXb/wgJboyETiHz6/1XpJMEHJGax5mtdgOSQxL+RUUxpuH5tzG9+hlQ6vHElnqlQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4xIFy1Z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340c261fb38so145911a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185790; x=1764790590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLCqoeSsQabfDeNa/xBdJZvFpiy30zTE4mNpE8T41QE=;
        b=F4xIFy1ZBSz9JKv+L6mOsKTCEVlxIOSesTCOjpH7sntxuFhsx7YANBgoHpAp4aI30g
         0tTPgmJ5B7wp8f4GljZejz766K2u8Fb5vckdtbIrYYYCSuAsQMwySlxtuGw6kXNTc69S
         bYYRUutNbdGAio16YM4Ehv9UXcpeSOGbIK8sg4+WBT5Ap/etNwDG54soqW/xHdGTKNvT
         a2MhtYjCRcy189Bd+HGhGCAepLgcmVo3gOQ+Y4qrjJDcTs7r77GJcrrWLlzqcqKi+dcj
         HJEW9kf8aMpR4KDDuZkBhDMFQV1zFpks3I4/rHRMbXeflBUewbTM08i9ZeRoX4E4eWK/
         ypow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185790; x=1764790590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLCqoeSsQabfDeNa/xBdJZvFpiy30zTE4mNpE8T41QE=;
        b=fNw4vS3kmrpdV1LbIo/Zag4wteKBEuJzhV7StTSiOGDNo9UOKO3kaQ5IaQSsmkdAIV
         HZbCJM50xHboEbtvym6ZF9dKgJHTG/KHpc2mj3FWwOokZZ49sNCrMPNpxnuYfZISVWjO
         0telU57hUhKq2QXcKVc580uiJkJ5eJaU9nTwvn20o8ZD06mVy2S14fX3dUaR/JlDgPF/
         UngZ7b2NrnRedjU54wDqXNrgQwxywwC+eTjj4BmaQih2F3LvyfihBBuOga2ZE4VbxgAe
         jPzxZum5rV6g1lumLUfQgkVhia/g98pMXcECOx5Xh3z41wZvBShZTuoEkNpS5CEwXC6i
         Xs8w==
X-Forwarded-Encrypted: i=1; AJvYcCWsxvKebxCO3svNszOx+Q9dCeZUqL4NU+Y4f4p1ti1+UEZ4KbKA+gRnKmLAcrfU8H7mOMC8t2Hwo/RPhUQWeDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIpMKoQDFc9US3y9zQUPUb01O6JMnT0g5oGNV/yXVNwjYOPUCJ
	8ekPp2jhI87YdwfM2ggOn9KR8tHit//e4kvTfIzzmsOFHRmpJz4NwABlbTxQo3CcyxqYFJ9ckOj
	ipYqKX7npxQgg/w==
X-Google-Smtp-Source: AGHT+IGR5imVc4Gm8Q9WhaafA0U0GgE9yqjy//tdxegzmSxDm6Br74h7sG3/6ABHdOqP7Rab5/mVHLJp6Z1KeA==
X-Received: from pjbsw4.prod.google.com ([2002:a17:90b:2c84:b0:32b:58d1:a610])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17d1:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-34733f2d167mr18887345a91.22.1764185789612;
 Wed, 26 Nov 2025 11:36:29 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:59 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-13-dmatlack@google.com>
Subject: [PATCH 12/21] selftests/liveupdate: Add helpers to preserve/retrieve FDs
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Add helper functions to preserve and retrieve file descriptors from an
LUO session. These will be used be used in subsequent commits to
preserve FDs other than memfd.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-Developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  3 ++
 .../selftests/liveupdate/lib/liveupdate.c     | 41 +++++++++++++++----
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 4390a2737930..4c93d043d2b3 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -26,6 +26,9 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
+int luo_session_preserve_fd(int session_fd, int fd, int token);
+int luo_session_retrieve_fd(int session_fd, int token);
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
index 60121873f685..9bf4f16ca0a4 100644
--- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
@@ -54,9 +54,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
+int luo_session_preserve_fd(int session_fd, int fd, int token)
+{
+	struct liveupdate_session_preserve_fd arg = {
+		.size = sizeof(arg),
+		.fd = fd,
+		.token = token,
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg))
+		return -errno;
+
+	return 0;
+}
+
+int luo_session_retrieve_fd(int session_fd, int token)
+{
+	struct liveupdate_session_retrieve_fd arg = {
+		.size = sizeof(arg),
+		.token = token,
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg))
+		return -errno;
+
+	return arg.fd;
+}
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data)
 {
-	struct liveupdate_session_preserve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
@@ -75,9 +101,8 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 	snprintf(map, page_size, "%s", data);
 	munmap(map, page_size);
 
-	arg.fd = mfd;
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+	ret = luo_session_preserve_fd(session_fd, mfd, token);
+	if (ret)
 		goto out;
 
 	ret = 0;
@@ -92,15 +117,13 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 int restore_and_verify_memfd(int session_fd, int token,
 			     const char *expected_data)
 {
-	struct liveupdate_session_retrieve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
 
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg) < 0)
-		return -errno;
-	mfd = arg.fd;
+	mfd = luo_session_retrieve_fd(session_fd, token);
+	if (mfd < 0)
+		return mfd;
 
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
 	if (map == MAP_FAILED)
-- 
2.52.0.487.g5c8c507ade-goog


