Return-Path: <linux-kselftest+bounces-30378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C70A81515
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B75169634
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F0230BF9;
	Tue,  8 Apr 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIfVKk6g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E012356CC;
	Tue,  8 Apr 2025 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138389; cv=none; b=BjyyrpqMMbyLVKqNRMJ61IEXgJW6xla9PYg3BsPoHj6wtZw0Y2o4NJfzOGV9dX7lTkZQEu3YvQbYJcZZahKuH6MRlVrI+fqkFBriCWPg3LjFsNsrNBnKboxlqpj7f6X54E7EgZAjE9fKX10aUuJIMVsaq2MyLagKKTM0qlMrEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138389; c=relaxed/simple;
	bh=t4ntxsD59AauSomOOTSJBPia12h5IlpOu402MCxtBk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM2OCFTdZsaGOTYLcxw94yoTkR3Y5vdHg6uI1hiO76zlI1cx1F28+FRlhPmKumRj7Pz9wTvrNuF8luHM2BpJGlISia1mJeuHfjSFt+0xjKZcHLHrDj/6bt+77QyyeUEVjhXb3ua7SsX4B7vunrkyqPOERvuJP7F5frtIUOvf1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIfVKk6g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso53122405ad.3;
        Tue, 08 Apr 2025 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744138387; x=1744743187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlTNyadWIt0Y/k7BO39BMe8cnK8/su0vGORgpd0j3a0=;
        b=SIfVKk6gE3kuAbb/y88FJsWjEaWoN4/Fuiz+9WhLeFaJMPt61fHF9/fAwvRPUpfrLd
         BnOs3ouprW3z8Nbof4/nQxDStyIrV+nJzdHhTnmRuZROQYRdm25Xm6hKsW7HDTEpcK5X
         BcSp1i1y6T1YnORpYdv4dSkXKwWlNd7OrN7TmMQjGURzr7J1bdXfa8igdr9vM7UezYfv
         cy8U9vxX5t4qYNPNKtCCPIBH5wtj4q8yMO5tH5yKqLCkNUZBnOfxyP9EofncND4gVzfb
         52uU/cYzAPoeP1o02g3dSR+maAoqOW02PmDRtMQfFpGlRjDRr3zMCG79SsvLQ8nL02x7
         VDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138387; x=1744743187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlTNyadWIt0Y/k7BO39BMe8cnK8/su0vGORgpd0j3a0=;
        b=wFXb5PtpR2/GvM7TVrhKiELzyPeIK3rtMVpGiGpV96J3Q1S+n6QIA3tlnXNbbRY7PV
         XUIwplzVGr9wEXd8RF85Y55uoIuAPZokYRYfLgfVBwGluxNV8BJyPUqbOEIgN47yuJ7F
         TLedSlCEfLX2TA4qk8HWqS6DfFJf/ko4MPrEbM6pgDHf1jim/GqzKoHK1lCO4UGbNi04
         A1ScA0FkB99dC9HwSSfterz8E3UGrElsQlwlAD/Jh7XPyeUd6HtHXMuecGD8yt8lLQ83
         pUyAXy3l8BlcyvGOzfhzS07xv2naPUMeB3i/mYbO2CsH2m5E39oq+fu9OQ75paeaC6za
         ng2w==
X-Forwarded-Encrypted: i=1; AJvYcCVcMCVQak61Fv4A2FBAEKl7y/2YldT/Ghv6NMyG70/5epqsM82/UBeJfhlB56wiiJgjfFdJ9ohUoGWzfFvVGFcZ@vger.kernel.org, AJvYcCWZs3mVarDHzWgefLpNuvey15lbltwohcy5wJtroGZUsCLzj+6GnGYmCr7Y+Qn3kq4+GYuLHnlA0qTwEhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbMyKii/CTAV/IUVsvQ5Okx8pMa6gAKqNd+8P2rCJJ4uti3O9
	sSwVAgVOTjAH+kyUcfbqzupYmS7gCWygiJo3x5Tgsl++jpoXn6Gg
X-Gm-Gg: ASbGncvstUGKZKlht1soXGBN7F7MSdIdNKmIm6szv9ouROj8N3vAvCNri5lfpwoWwp7
	RKaYaNbxtOQneFknk5SytH+wEL5oiE2JOfYh6QUC2NG9jAfLIO7TkdH0N25vNQNtIvU6bS+W8g1
	SMOJDX8WHBqfxzU7e/9pIaF3KORRhMDXipw/bsNUZGy0Uo7X+1/q12S+KmECwZbu4Pldc/h6Hwy
	Yc5a6X0/QJPlyXn3tMcmJimQELuBwUW3VRygsIH5Vi4EHZ+7kgMu6rI/Pddl1YyxOM5D+EXPEd0
	itElBeoilYL8BhBea/DnkPxqwZXWTOMAORiD1q8UPSvnUbNsIyV/cvvwrHxg2w85BiAwuEyaMUO
	rBJUZg+94pwVldyk8+i/IQLk4nu0=
X-Google-Smtp-Source: AGHT+IFm+gcLss+dKyd4t6lqJ37o2rU8f2lNWS+cne/WUF3ng/HI2286W9C3sdmE686OBfpVpUSqQQ==
X-Received: by 2002:a17:903:904:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22ac297fe6emr4250915ad.9.1744138387049;
        Tue, 08 Apr 2025 11:53:07 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978772746sm104284585ad.223.2025.04.08.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:53:06 -0700 (PDT)
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
Subject: RE:[PATCH RESEND x86-next v4] selftests/x86/lam: fix resource leak in do_uring() and allocate_dsa_pasid()
Date: Wed,  9 Apr 2025 00:22:45 +0530
Message-ID: <20250408185248.7722-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_TZ138UxQ_uZzys@gmail.com>
References: <Z_TZ138UxQ_uZzys@gmail.com>
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
index 18d736640ece..0873b0e5f48b 100644
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
@@ -1189,6 +1191,7 @@ void *allocate_dsa_pasid(void)
 
 	wq = mmap(NULL, 0x1000, PROT_WRITE,
 			   MAP_SHARED | MAP_POPULATE, fd, 0);
+	close(fd);
 	if (wq == MAP_FAILED)
 		perror("mmap");
 
-- 
2.43.0


