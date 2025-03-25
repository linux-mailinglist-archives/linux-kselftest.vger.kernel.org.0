Return-Path: <linux-kselftest+bounces-29746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C790AA70261
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE14519A0ED2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BCF25F978;
	Tue, 25 Mar 2025 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C58oSnDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158925E812;
	Tue, 25 Mar 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909190; cv=none; b=mu3dGuR/XHbQFS/CfkIymP9ETh1a1qaTYmEJFqHqevBSMhQaWgi4YmqUmMXpw7DW3J5b+5i0ohGXJ5usIMzDsrLbcBT0dvB3tKpZjF3vYatyFMphdSNK/aNqElbKlS0dbgl4CUfGfpuJ6G7SmCm4A77kaTAEWF/ybNn995Dxe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909190; c=relaxed/simple;
	bh=iUg6P/TqqtETbhidVxOSK0TI1+y+OTQyMRT6s+ZmIbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T45kYtjHfdZX6P/0ipIogZMUYFNPKLfNtqtfuO47Q9rOrJDuMv3k8wF6BbbM5a4yLkEVIpDyAhVKPi9tPDTwvCzBEaP21uVTuFwRtU10HI36MgopsziPLOZRRy7kdWFYGCw4ULPM4IsybVXNurEWos7VQDjsqPZXsG5xeK8hiuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C58oSnDm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403cbb47fso107229985ad.0;
        Tue, 25 Mar 2025 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742909188; x=1743513988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab6PpOwe2kPxwEEnYbmnpRkst1cOo0s43ySwaMSzdfE=;
        b=C58oSnDmyjaiSpKAtkzaaPn6TacAd1fMb6oQACTgXDDgCEVdwcSGy9SOc6srqcCT3T
         VKZ7imOMadIhv2y6R8TUVd0Q2Yj+Kx2Hq5Jd2CBkH8/jO3JcJ/6M50WPN/EqcRRfqdGO
         0i/l025pnd604Bh50ICuAnYLfK4enG02i3Clw9/dFHZOy+NTpRyn1r0C/Q9Fiuie94GK
         8GxcR2E8KnXRr7wDF/EB+beGcQ4x71Jsm39BsA7YXMSwmwUy6WbhjhZLQ8ohMtISGPbN
         3Mv+idXv4KpRTLdd/my69hMSTroQwWqqvaU6fX4fparjSViKjFgph3P4k6eNPpcgQwBE
         6J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909188; x=1743513988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab6PpOwe2kPxwEEnYbmnpRkst1cOo0s43ySwaMSzdfE=;
        b=ccTycmCoiCDQgRA182DPy9eDn2Rv0M9DVDTEdMXWHcaT+1QAS8Lpy4JtALCERsT3Fn
         8GrALsrlSVlocBf63UfA0WVBom8/6t7FopQ+YnoMTuDd9qldkxLVK+E6QxbZDtP26huG
         K73cETlWGElcv15ulJg+MKiV+X/U9sqSvxew31nkFxPGdxwTDNhskK2TjqxVd2Mg3DHs
         BU7dOa2zE9zSLbhytS0LgzkVEDgbEUN/BwNiPBHQYP7hqFKxSE5jwurvDkDlHuq/g2u1
         53WYaJnfed98YEboJN7DfW1R5gM/RVc4/mRNTEZqlP3/jW3hy2VKy5K8yzVE4Sgn82ku
         0U+g==
X-Forwarded-Encrypted: i=1; AJvYcCUEZBdcdcnNSYWrqB8If5tT8YvRkQWkVRTKGKGsuysRJvSbJPqaK7mUzHKBKVx/pfdraI6e+EGeUUvliWs=@vger.kernel.org, AJvYcCUcZ8QVENzCzoD4zZ5ENXKjCDYk99OKgdn3yr0NvWVLS9uEsLF5MIYkPLSz4qRQTuHjt29VypdQnt/X05FMwGnx@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfGtGlWKXQs6zXUb9idLt5yfOGSDwBkf7Vm52dHQRuq/BNGq3
	9TNjNh6VeLwH1OdOtJ3NhXIiO8MhVKYl0TbTJjCE50FtkqHqMUUZm2cxoZ8ykUk=
X-Gm-Gg: ASbGnctHF9gUuxjR4ECKksl1ck2y7kyWzcM5WHq/za3gHAbo4mj8BjcMEN3q2oVORBJ
	eRhXmArZMn0sqyyUfOLJZH9AAb7nCHA3InqnFBPy54b0V+pHMr59lxMBv+WTjlP1dJVGVxx6chu
	WwbmJ8OUYrx06bmreXcptkpLIJxZfBVFv7G/3NkYwWX8FSigRTFhdbfZRJhIuKkz9AVOY8auAUN
	vw+XBNt6whSNTUxIG7kLx6LYRfq0t2kBbUY5GMF7L9owYtpFwbnhib5GD3fVnCU0vxSQAJhsfgT
	ZQHZy2gHGKP/hHv3YXlvf1xaDjHwZONnu3ZpTq0RfURWRdRBwbBbJMZEpE/4Yxulr9jhf+Ds0Rm
	XjEnzPFbWFcZhSN39qJczLhZLLh8=
X-Google-Smtp-Source: AGHT+IHaKWMAJywuqpiu/ZTgxI4HUPATRBE9RZK/2F2hNLdtPn6H5jQSklYdYhW4Yfdj572f1yIbdA==
X-Received: by 2002:a17:902:ccca:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-22780c7b68amr325047355ad.14.1742909187891;
        Tue, 25 Mar 2025 06:26:27 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811e3127sm89299625ad.197.2025.03.25.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:26:27 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: peterz@infradead.org
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
Subject:  
Date: Tue, 25 Mar 2025 18:55:51 +0530
Message-ID: <20250325132617.13045-1-malayarout91@gmail.com>
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







From 92c5ac2ffa37f6e4fe0cfa49a20857432bc67718 Mon Sep 17 00:00:00 2001
From: Malaya Kumar Rout <malayarout91@gmail.com>
Date: Tue, 25 Mar 2025 18:42:33 +0530
Subject: [PATCH v2] selftests/x86/lam: fix resource leak in do_uring() and allocate_dsa_pasid()

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


