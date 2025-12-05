Return-Path: <linux-kselftest+bounces-47112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B70CA87DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69E72302772D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666F32E738;
	Fri,  5 Dec 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWSqwp06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7D33B979
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954738; cv=none; b=VC54YN/C22Bhyk5sFvPCKssWFp6exi0NGedf26yaA04ZyPjSSC00AMJm06uQL47l5sWpDDA39XWjigIS3Fz9djPb7uctLtfinEAeLU2cskA0PQoCVs7QxZtnHCeO8rzXydTM9Z7TJehfMvnEAlVhuL8vPhXA9h0nh7IKAF3HMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954738; c=relaxed/simple;
	bh=3D8Jia7maxjOED0qB92SCnhCwD5om9jZB2vyXsShxiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwVxlByIthtSvzVhW4E3XHx3XpCtvPU37TC7NnDiWAP8fgL6C0IKpjVYNg+/uVeRE87Ans4lJnfDMZpipArrj9D69DWPKms9j9ruE8yYPOEN1pHJBAv75o6CHzBb82Zjg8UlIHzCv9Jfdt/mVLi7VAxO2TALJ15ejnhn9eg/g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWSqwp06; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29ba9249e9dso33026975ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954731; x=1765559531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKtvRnZXXEkJadMcjlPO6UUmkCEVjlrlMZ1C1H0q9gg=;
        b=YWSqwp065wKnTjm7HpRnT2LAKeyuYHkp/dbEYH5qZZ2npmBtm8avAHLL64BZ/BlXnA
         kwKDJKwzntNGiGaiMVUWvaIxzFZboyFrm4jRvSRzgL5lWza83orLX+OX+N4RCNTiEat1
         14SHyYKQHJxOYqpIbfRMGiUFgWIh4blNZwhfDjWEMSUHPVd7n4EkgdaDrQT5uz7QqSZN
         pDVcv5kmWG24GPvoaFUgg1pokpZaY0mcaIhgdfbqg0ZCbZB3iThpW9bLqoXFUx4pAvzO
         SRWbSUGjgW5OuXB8libbn2jwx1903F6KcSFW7BSJBPjkcrYro6FO8negxTW69RMrX/cS
         q9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954731; x=1765559531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKtvRnZXXEkJadMcjlPO6UUmkCEVjlrlMZ1C1H0q9gg=;
        b=PnpLLvgwexE9i5MDAD6BAStor/tPKSGwQ/CDD55nEIJxbeEd9NAuoR5WwCZaL91uNr
         FV72PQ6gJgV7fGY6TVAOi9UclWUl8WObFB74xg756rXUfU/n/sxkc3Evh1Z20tcefq2q
         p6Rak+HGafkMzFI0HyuPM7UFe5qX4VcQ0hPx/6tM+Brjp9lBJadO/+7FMKkkcCzggsuo
         S3W1EAN+bry+qJG983yenRHclFIIZyGKO5k9jVWwibV3Z4DIV8dwOHJZCZvSYZGNFpMA
         /t/05FlT8KHoveCvvS2wo7k4dWOI3omIBTLqpIzjfciWdLZtRzafziTJTuBl5vGfkUxZ
         UAEw==
X-Forwarded-Encrypted: i=1; AJvYcCWhZ+wYJQZTzBseoWTUFoV9h3ZJiEroqt9/aCNrLq/ErAZcic7+Lj4UPX98RMc0947WkVRgjt9imcYrT2+R6Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59hfrIKgx+Hwzy7Zq8tc8NBfD5GqSgzSBUBtP6U7adq38cJmw
	CyZ/m+2CB3QPrfIEU2KBGartrygYqGwzWb5dLQMW8DJnvINi3Ssob52X
X-Gm-Gg: ASbGncvece03n/1X3u4syq6LRH5VUhkSwRL7rJNx560pO45SzIJW9Bn7WyomI1RESGw
	yZV9y3LxdM6cKwwDvuK621Ydp6J03ccjVVPMb8QVAgpZsisCk3bqMjaPa75zE9JIojGmvoHCktE
	n8sQChXn6ZLuF2kO78x4ZTIJntMkTaP2SdhCmo+p0U/EQSYn2ngrXQLTmGuZ4GY0hcT8JkQOPip
	HkOT5xnGAKZHx+vgouHZWoCk/5+zLc5IEjKf8HwYYhySd13LcvXvWhr9XeGR96guBOGZN53A43s
	gYw8mJDO/3727yEdkjuxptwmhadOk6kbbOiaIkINhDdX+inxv2U5kVTHw0M7AB4dTfT+ZIxysGk
	pKM9IR3Y1G5Nd9aE1THwcUTOVC3U7rLftbDP5/l0wBZ6Eh9MvKZ9ygwwfKnjc11uDvtTp6NhwSN
	mfOAv4u+m7Xkn9+QFcpopS1AQ=
X-Google-Smtp-Source: AGHT+IEr1nY1dhYbPFblTm+sfB+BT05pWYr0So+DnBf2OW6AgkQWCY6GZ40JgzwGeLxSF5IGH5l44w==
X-Received: by 2002:a05:7022:2218:b0:11b:9386:a3c0 with SMTP id a92af1059eb24-11df0c505admr7292285c88.43.1764954730772;
        Fri, 05 Dec 2025 09:12:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm19408192c88.6.2025.12.05.09.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Adrian Reber <areber@redhat.com>
Subject: [PATCH v2 01/13] clone3: clone3_cap_checkpoint_restore: Fix build warnings
Date: Fri,  5 Dec 2025 09:09:55 -0800
Message-ID: <20251205171010.515236-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix:

clone3_cap_checkpoint_restore.c:56:7: warning: unused variable 'ret'
   56 |                 int ret;
      |                     ^~~
clone3_cap_checkpoint_restore.c:57:8: warning: unused variable 'tmp'
   57 |                 char tmp = 0;
      |                      ^~~
clone3_cap_checkpoint_restore.c:138:6: warning: unused variable 'ret'
  138 |         int ret = 0;

by removing the unused variables.

Fixes: 1d27a0be16d6 ("selftests: add clone3() CAP_CHECKPOINT_RESTORE test")
Cc: Adrian Reber <areber@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings 

 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..976e92c259fc 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -53,9 +53,6 @@ static int call_clone3_set_tid(struct __test_metadata *_metadata,
 	}
 
 	if (pid == 0) {
-		int ret;
-		char tmp = 0;
-
 		TH_LOG("I am the child, my PID is %d (expected %d)", getpid(), set_tid[0]);
 
 		if (set_tid[0] != getpid())
@@ -135,7 +132,6 @@ TEST(clone3_cap_checkpoint_restore)
 {
 	pid_t pid;
 	int status;
-	int ret = 0;
 	pid_t set_tid[1];
 
 	test_clone3_supported();
-- 
2.45.2


