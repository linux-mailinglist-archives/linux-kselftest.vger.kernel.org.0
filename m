Return-Path: <linux-kselftest+bounces-38363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0855B1C33A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 11:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2CA18476B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BD28A406;
	Wed,  6 Aug 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2VAy91S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955B289375;
	Wed,  6 Aug 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472212; cv=none; b=dDmjqO5bLRbxan3VI2w/D6cMPbyHHTFGGrT6vriEmLcnZ6h19xWnj3C7yP/05GTlIfJYtw9fe1qlUWaLO3PkppLoecX3WNjEjhmb+V/pSr4XRN+BcU54FBqopcgsGHERMNNjQ0w+CXJCpNY6mvvKbfXcamYUzfOFW0aK1qNzGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472212; c=relaxed/simple;
	bh=Ti+S8H4iibQEtSi03TyOntCoD3rVLVhIDywWJ5k2hN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5wEvD7+PJC1bsewfBo+GLcOiF1P5GgF2zaUVdAh1RTPqDZEeMr+Z2xFuM8w0rQHHQPDjzfPzU2ukJLLaw2jRcWxXzcnhnSNZQhzDOkVXmZTPwk6v+0/LQNkbV/3mKxiLhdUs00VjiUMEYqPVa/0uTM6XzLauq3MpshYkHDUFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2VAy91S; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so3964975a12.0;
        Wed, 06 Aug 2025 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754472210; x=1755077010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8Z6UwM41h5NiICvVTC04LVNDedMghhwc5qhkKPNiEU=;
        b=U2VAy91SWV19+nYDEuzgAdNirmAoyD9XuplFN1ubiyP0Eq48JAdw/hZt1i7jex8WeR
         GET2AOKKcwLsEH974OlXsHCll1AHpzhx2Oec2NkyXneuNdLVR5Ue5BwNIh4CAuIHn1Rr
         67NWLaQ5xOmzj+rzoz6Pjjx+RAFO0NdERNYxCtZs3IRj/OtDlAZAN7pp+lS+uSIOJ/wI
         9KwPPOykiFj0iUxDhOy11NewfbAPMSzSf2my/7RnpKWGu9cgLWGCetEIWMQhcxoVLtCp
         PCsZSQcJNm1WZLfcThFLpF6LCpm2u5GLWY6EKpUL+SS+pQNpxvHzn6YK/PfF5FJsTuz/
         ZWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472210; x=1755077010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8Z6UwM41h5NiICvVTC04LVNDedMghhwc5qhkKPNiEU=;
        b=iL38nCo4EzFYE2LZkUV6umNFIWlCl4mA5sgIuHtuu83CVTGnj0NV+GkXp1EhNV0DeT
         m55BgmqW87IKn2OIlVjzLKs8SM8buvcekdIJkV9Kg99c4VYdMBndjzhfsrNu9FM69+Ed
         OGa0wlboysB85zMpOeokesLRHguEhJpNjJ3izZ150Ix3vYDxCcx5ljfTostFU8mIW5BU
         7Z9y5yureXp1oiNVie3ZiPIuxlVzKmz8S6PEYOkNNMBMF/3g4BWeFKoqUPmwvAubK0o+
         5aXxtFBtOK/oSpfq/+KKw7DWfZyn5ScfBaGdk98mFeNniZDnoYI7+IDPznOT0mMSzI90
         0L7w==
X-Forwarded-Encrypted: i=1; AJvYcCVBB2b4GHPpIYnnDdOO328MoEYNj7mQ7vDUiuUhCu68exAa1ipxLFz9S2NqKm2GZFfbhvI=@vger.kernel.org, AJvYcCVkhjJ3J8sWZr6C+htvRFLiKVIey4pNouFNDSKRbjiVw+SzvuhncO7L4bliXo4pP5uJ7tvST4PtWpAwKoPv@vger.kernel.org, AJvYcCXm2PioVtA0wegm1nnuSHRRzwYs9f6uGeL3Bvw3+gCX9NBiiUMahiazr9/nBBOBj8jqwkt4wq3ql/g6Qc1YrCnc@vger.kernel.org
X-Gm-Message-State: AOJu0YybSIR+czYVd6hq0OrPJ6JNi9cEhEkUFwbGON4t1c/HalK1nxGp
	w/gZ5S0AFATnrN+0kLNA0rs/1bWynaFoDHJSXYukZKpdeC1YAe0ZJg+a
X-Gm-Gg: ASbGncuCiysLFNWyeK6+8XUaM0qmUzHW5UGA6CQ23RHxxCoLfg7faSRk9r+3Ip/beHM
	Iru+J1eGjIHQZTAxJ/Gg8PyjvYdu99+hdqggtTQkXQhyHpb4kTru+CKiOwdYmXAp2C4VfRYxU24
	te54SCXSQxnIp9UFG9p8qFQB2r7Q1LwcvRx9rI8mUSzEz9bmaz8TNoVgjlmoh7txoF4R779RIJR
	ypg3aqEvZ1mj60PZM8G/KoEtjsUFX/JD0Ge8OYiAdvIRbUzCn0CrzB+BlwTI+zRsyGxMr+vwLV3
	FqhYuXShmIg82XkSJT6jFqy8pV0AVUuf/69zjewcft2F8JJXIVRBxo0hDjfKUHWt8esSzLLzvFe
	jkHe7N7RPTfLQj8TMbp0y/L348UIPCLm0Jpwnm/lMwAg=
X-Google-Smtp-Source: AGHT+IGFX5j5TbK6+REGB7qpAdkI35mGyzu2adIblYzRFaNPFutxs11NcuUBdGHRwwHLVgd7NS8hWQ==
X-Received: by 2002:a17:903:4b30:b0:235:779:edf0 with SMTP id d9443c01a7336-242a0be49b5mr22875205ad.50.1754472210416;
        Wed, 06 Aug 2025 02:23:30 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c30:7b0d:6527:282d:9edd:5f40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a8cdsm152807015ad.121.2025.08.06.02.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:23:30 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests/bpf/progs: replace typeof() with __auto_type
Date: Wed,  6 Aug 2025 14:53:11 +0530
Message-ID: <20250806092311.17719-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace typeof() with __auto_type in bpf_dctcp.c.
__auto_type was introduced in GCC 4.9 and reduces the compile time for
all compilers. No functional changes intended.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 7cd73e75f52a..0bab6cec6bbc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -16,8 +16,8 @@
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
-	typeof(x) __x = (x);			\
-	typeof(y) __y = (y);			\
+	__auto_type __x = (x);			\
+	__auto_type __y = (y);			\
 	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
 static bool before(__u32 seq1, __u32 seq2)
 {
-- 
2.49.0


