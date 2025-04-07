Return-Path: <linux-kselftest+bounces-30242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DC6A7DB6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 12:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89241890A0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0623496B;
	Mon,  7 Apr 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSmCmpr7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27794235BEB;
	Mon,  7 Apr 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744022712; cv=none; b=XRUYsewnxwcZ3wfnFf64H+El1cdruyIXIW6FfTJedTs20z2c+MI5TSYy+CyBSrt5aLZs+Ukz0/Jem+soWjHVZBaCYtZi+d3t6k/bpf7/8CZZ3vDKqFG/TGFdJULHE6QQC7JAmzufRuRYI0OiH05+PFt0zRFv6dUuTOKUyH8oFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744022712; c=relaxed/simple;
	bh=Hk4uGRgFkM/9RTZxf002J0KJyA6Vd9XbtU0RYsEdWQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByhlKp4Cffb73D/FPrAgs55GMm7t4OM618A8y4CyUrVNC7eQMQNciVXvF1vCR1ZzF9ozzxu5Mwyv2sP/hV59tmEtV9YLbpWPRKOO2cv0xLmYGgLCtW032Y1UUbhSi0+V4/4M9dqC6pZodqVh9g9k6iadwmxyW8fawblCZDNIq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSmCmpr7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736a7e126c7so3652487b3a.3;
        Mon, 07 Apr 2025 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744022710; x=1744627510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7aPvlp6tp7+XGN925jTEd3RzRRNETSiKDYReSoir5Q=;
        b=OSmCmpr7BjeuQOSFl8mKc83COj4eYneIftb355o+TRXoyUeDHXveu75G4+vlPEP9Oc
         1Z9u9cMmbKadAMNkzXgZHDGUcLTdbGMhelsrtVm/fW3I7Mx2xK/D2ismkwH3c2zKxYms
         OGLKnDFKNuCmODz4Rzaj3N4urGGxo6ExLezxuPhi3+2B26PSqhBNJfd3Zci69XKD6oIX
         bo9isdH3CxXpAq1okfELe36diIXvGksOdvloTJ/54pbxHcXFB9cBU4Dfrj8j8vTQCnic
         Jb2XbTtIHszPGr/+51o/BNMLxWCqncc8zLqlMXVzYCxL7E7SD9CqaVaKjzOl0wIoYzH4
         4H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744022710; x=1744627510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7aPvlp6tp7+XGN925jTEd3RzRRNETSiKDYReSoir5Q=;
        b=lIC0E48jl0bSdQDbMO9oasiWRForWocZMRNZYxZWbx8qxJE+e9/h3PkhtoSwNjM+7y
         9wqxBIevwv5H4y2bz0KbDt+2z5f7zN1Fu9hl4rO60n/jw1mHP31uwWQo4sceAcipvTQU
         HtX/ymTo6o9XNzeRTC2FzDUc6ZrP3brwRDkSWch4OSp+JjLOToGOOuDFo9dNxH857ozR
         bx+pZoU+stBB3k285ll1x+Ma8HJmn+E03xZdkILiBOYlSXDGq4YMOKKivgQC+BSna85e
         lYV6duCFZZ3WGlBE8DOb6O5CoWEBCaeoy/thq9eMKCsaCi8iYlPBzuCEuJYL935J+azL
         0sWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGOhivh10QmwY9A51RrUd9NlTUa8Bau822kN9aI/AfdramQ9ZOI9nzDH5jTb9Xc3UqG/9qKRPZJwbHuBJn9im4@vger.kernel.org, AJvYcCVNSBELJ9StxTnv5xl2H/RobBsdj8EcCl4HvmBYtfYk0wB3JrefExuHysnNFCmXzkhQO/4EZhLHgqqhEHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxwgMP9ZGuZTgwPeD0KH8wZD++wuau6vVlOJHfzZiMrRjIuUB
	heMLdse0p9/kRY+6w5UDGpmjTU541qcWfq+cr2ryx4V0I00G30uc
X-Gm-Gg: ASbGnctFf5ovadgqJ2+4oaXgf1F5O5TDyFNz+L5cz7VBaQV/xJIJDhzwHmiyvulzXA9
	1eTJqaiROEPydKrOnVkajLSO1bzsvZZnz/2xalapp0mhzpnj82FyW5vPrqPmnVUrz2+pzMLMdyF
	KtHb9DvZnLMJlzF9LPJeC87/zy2lDM80MXdc7N7zS86tahJVUaUck/19YfK7XciDxI0jYNGPpwP
	BNDSBcCLnETSI5Oyh2rRiXklsl6xKmrcQ0zMIgdU+XKfm8/TUXBznyyyOsIVHNphgq0dN//eE+U
	c3sHiEcuVuXC/ucDZrezCp2q4FqrmPAnHs7v92/nzQFjnE8LXDSjZKI0gUT7x7iu43nxBwnLoOs
	lrb67QfbZqRuGfr8N
X-Google-Smtp-Source: AGHT+IGHn1IUThgt7QFbQCA7efZEDVKbPOd4Icc6xwQNrgcaJvHqQJosUwZg8GQpMAPVStdU4IR13A==
X-Received: by 2002:a05:6a21:1643:b0:1ee:d06c:cddc with SMTP id adf61e73a8af0-20104735fc8mr20474708637.30.1744022710365;
        Mon, 07 Apr 2025 03:45:10 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b46fasm8418597b3a.145.2025.04.07.03.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:45:09 -0700 (PDT)
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
Subject: [PATCH v2] selftests/x86/lam: fix resource leak in do_uring() and allocate_dsa_pasid()
Date: Mon,  7 Apr 2025 16:14:44 +0530
Message-ID: <20250407104445.442876-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAE2+fR_kG1SpE3DZ6cbZL+J8HT25RcaGxYrZP-H+rDFSJG6sdQ@mail.gmail.com>
References: <CAE2+fR_kG1SpE3DZ6cbZL+J8HT25RcaGxYrZP-H+rDFSJG6sdQ@mail.gmail.com>
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
:wq
---
 tools/testing/selftests/x86/lam.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 18d736640ece..1d3631ce4b69 100644
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
@@ -1189,9 +1191,10 @@ void *allocate_dsa_pasid(void)
 
 	wq = mmap(NULL, 0x1000, PROT_WRITE,
 			   MAP_SHARED | MAP_POPULATE, fd, 0);
-	if (wq == MAP_FAILED)
+	if (wq == MAP_FAILED){
+		close(fd);
 		perror("mmap");
-
+	}
 	return wq;
 }
 
-- 
2.43.0


