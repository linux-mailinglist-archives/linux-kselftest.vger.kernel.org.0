Return-Path: <linux-kselftest+bounces-46721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6EC93AEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A363346C9D
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C3199252;
	Sat, 29 Nov 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTZRvdLq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40712741B5
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407721; cv=none; b=Y4fVNhdI4Fv6vkxnYS9I6/rPcrd2fFNb0a5PwDJQdmtab8gw0X5lkPIwTdfKI30MX8g/Sle96o+YgEYPrB8KehS6CHj5G29JjVlQhaYkBNxvhw6RZGLtVDQXXdWGOdqnMxqnp5owkuwDqcdS4mzV65V1AFhszmQqrhVj5hZk790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407721; c=relaxed/simple;
	bh=1H3tSySb8RYZ9Xz952vACbtvWTupkLqx1w90JROwSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCHc8zzoYa7SRlhzIFCt63OAeQt4Owi7ptI4Kyk3KwA4N6E7YWYGChAOG5u6MlJCsCFB49A+lJonNUqOwIIUdVt+rfeAbe4u0VB6g8EQhm8TZEidFSaDBa1TrNTq02Uo5NjnGDIBmHyI1TuNyU7KpJn/1zb9/7jIYPpJZkl724Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTZRvdLq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aad4823079so2265691b3a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764407719; x=1765012519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTLbYX7bNTCm4TW5N/uHN1/H0O/wwjH+DS42MIfV7UI=;
        b=gTZRvdLqFAb/4YHMcqeFdjmsrcmNzl0o75pRwHqejAnlAtjEBSfJ3rdcmE0KCoAMxz
         8aDfS28qehGIKRHuYCr+Q7HBiW6uRw4SaB4o+IGn7jh0DTlvLKWaE2UfjMhnaKzy8Mun
         5z3I4e4j9lk1e7lpLgHEKzGTP6NOXg+6Y6D4GIS1CFY5bzTXvbnITAxX6q3Grs/VMpWI
         kDJaW5B1yWNj9PTLfthJUcvgWKyhSqlSiaguH4zcsOZZCknt4wJo0p1boB5w12ainCgF
         riPiv0yOm+1gxtUeHLxYnocVqVtzWJV/Iv5vkicp94K6cP0Fs3gJQVKHsFLk8KwBDuPU
         3mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764407719; x=1765012519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTLbYX7bNTCm4TW5N/uHN1/H0O/wwjH+DS42MIfV7UI=;
        b=b2fRxZd9Twot+gYo34QUD/ZwdYz7Nij6DBWan3cjl8vjemEQFuq6dEtXEN718XaVPN
         bQuVYzNT8u4xUl6ns1Dhraa7FXNqcYdT+fbto8SaVbEPVRYY2yHArXWoayafVSUtpTP4
         xf994aGC4MKJrS65hPXacMz4x8wA19iVk2ELsVfj3Gy3gOirMtBEpNs2cFAUYFrHWIbR
         pTeGSC71E7Hh9rewTiRLYeW2ixiYGM/wDGbIUX3AQmQlavLv4W94gCkv8KcehJxqnKFp
         GMpKEoM0QCR5aC07L2amtmErJCXOX0cOz5ondpgPa5IR5Nei69KUOsLtAnX/Wu6Vy0fc
         k83g==
X-Forwarded-Encrypted: i=1; AJvYcCVHyQEeY9VPqqAM68UQ8emd6WFo0gtKAcbEzz3ZFIIEY5L1Ka+ONUV9ehzoa9YSSPRoUsrOWNDbw3zQ/XpgBJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGzJ2NHf5FkO5sKifWt4wH7rgLZhJl+K+0yZT+PbFM97wzaz7
	X4ldr9tZ+x1o4GxTJZl0MC+1yZfPVpruRCbq7Gtfq4kNSsuON4EEpuS2
X-Gm-Gg: ASbGnctxDxQXW9VNlSNWzTRsuDi4W+/K1JSlWftuohYDLJE+5zMes1f4NYiDDDp1HYf
	gNbm2DICJXPtazqxBeLWLA3er6k1DjZSTmqtH+VbbULUHRvnesEbdJA0gWKvO3q6gS3T/U2WC1S
	JKwakJWor59PJLjYxx7MoQgRj6NMkzHITUA7f4V5KEKbTXbQ8LJyYtgAob7vaRcKgGWWDH6RIxD
	aaVAI/U/VT2y0CEGIQ+a6A6oR+uj25XUKky2t1MrBiVZcIfskMB/ftK04mM7vgUOgBp3H6d5Rwl
	2D9PsVw0VfYLaWKMHDFO0SvCq3Z2/+pgAyCqt4GJT6dQ1h0VHQwdZ7drS0zT7S2q8Wf4hf6/lyv
	hdXJ1hRkBPtpL59kUTIX/Zie5k/MmJCZVhE+jCZxglgO5TD7Ev4XJNoRtC2VKg0V/ScomT+Ooas
	xGQ7LFLbRxFQc=
X-Google-Smtp-Source: AGHT+IFKJjzpV9EYUo0mUxqBF81hGWIOAODYyB9YBLMIQiF1odGWwtu4fNZsuEorPfh62DeARpYtCA==
X-Received: by 2002:a05:6a00:2293:b0:7ab:995a:46b0 with SMTP id d2e1a72fcca58-7c58e110869mr34201519b3a.15.1764407719096;
        Sat, 29 Nov 2025 01:15:19 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db416sm7300563b3a.41.2025.11.29.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:15:18 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	criu@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH v7 1/3] statmount: permission check should return EPERM
Date: Sat, 29 Nov 2025 14:41:20 +0530
Message-ID: <20251129091455.757724-2-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251129091455.757724-1-b.sachdev1904@gmail.com>
References: <20251129091455.757724-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, statmount() returns ENOENT when caller is not CAP_SYS_ADMIN
in the user namespace owner of target mount namespace. This should be
EPERM instead.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2bad25709b2c..ee36d67f1ac2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5795,7 +5795,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 
 	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
-		return -ENOENT;
+		return -EPERM;
 
 	ks = kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
 	if (!ks)
-- 
2.52.0


