Return-Path: <linux-kselftest+bounces-38075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE70B15745
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 03:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69727AB60F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4CC1F4C89;
	Wed, 30 Jul 2025 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svg6MmGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256391F4262
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Jul 2025 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840436; cv=none; b=IM1H3I58BGG9mDAnxCutPa46VST3ApIrIDVZrLWABdJxnTc7f5meHv2G8acuh4U6tyq9UX1jAbqL9wWnDDzF1iTepCQ5TgvM0eTour1zcF+9QLog9xvsFBjMVdvQ5zpnjCedUIK7wCfRROJcvH+EeWcMdwvQ1VQOLWHWDtaP9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840436; c=relaxed/simple;
	bh=9mfsWfmUsxiv7jb5H3bplGyE+CRlpRWvLjb17tNh4ZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vGrFXSUjMvkwEye7FSWwj6R1zVh+K8SECuNDy4P1BQVLkEoro+s0JevvSCZ26VDg2bD/KPWzsA/4Ebl5Hx+JjFh/z8uGmgjNM1f2plAXt4X/fPCTnVU9XMuXhlN968Hqq6YoTxg4ikUtJso4o5KLCNmLrL8pZbMqWdqw32OuKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svg6MmGy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b537e8d05so6318887b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840434; x=1754445234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=svg6MmGyfOKx08O0A3abaM+xLLcqsEcALD/Q7I3yRozU6pxAkk3ekTg2HZevrtaQZ+
         FpYnQ5quEVAZSXk3jUkZ0+ukL6mp7/QEMUoEkJUE+BRPUiGg2uXH9zLs87ilup/jjWwU
         Tz6NP0PsFblDjcxJ9rHy/2g1BWvA4raTpmLee88ehQFXV8LPYL0wk5syIwMQp0ZYMzNS
         eIrnC8gGiP4sf7fFm6hd5ZkQja8ieJMOJcrwJDtx/A9G83UqOamfHM3T+3II2Mry1O6p
         apyZakltT7N8BEySZQ24/iuTTsKFudx4niFFI92WJvIZWjsUrtDFJ+FD5bjc9qUtS0Iz
         f5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840434; x=1754445234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=CrAyFqwqj5kSwXQxP7BZXY+3CKrj7Vok+vL3JxT2EPuK5YSDOAqPWjGVESaOrmh58w
         0Dgh/9rjqyjDFYfadhom+MKBUtbiaiWoakP6vJgYTtZnU6VRmZseoTV5/91lRyGTi9PF
         PXButupQ2AlIGUoHHRxrTQmrUW4AWnDudzngeYfnXU+l8vr3nDY5Ss0/sEhV9BTp7LMs
         V4kcfw6+j4BVdHN28idzN4txNJIcspUcNh/UnNwhBLGvbk4nIKblgIzO55A5L8mtc4Fj
         z1G1xWJXsaV5VAk0o5KiP/NnS0rj2Cxfc/1iJ8fe8PAxh94mN5c3OvnZ3npuFK3a0nAG
         o+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmpUzoKBEP5NseeFIP8lOYMpEL30Fu0p2soA6DU4Gu+ub0p9d7gPaOVvzgTBchaZrd8OCnzX251arUYZITMgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepYRL3MuQPrfmCesd+xCP6cwtKCIDmRVEIUXdYrHLh2HZ3yhE
	AWNrelbXoAmC3kAnKuVzNwMK8vLHCcFXI7mIi0WxvxrLLXRxRC7GTvb2KlPzVOWQsARk2hd/dYh
	4oshxO80eLFT5G3+xmHh3ZsoL0leSnm7mSvC6zw==
X-Google-Smtp-Source: AGHT+IH1AvyPnDW93f3cl3PVqwaolEhEGQVuwzCzNqoa+5pNrn3QdavhvOcgjwdA1mw0vjYabUuMNZ2mYEiEpRLgtzeFsw==
X-Received: from pfgt1.prod.google.com ([2002:a05:6a00:1381:b0:747:a8ac:ca05])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d12:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-76ab306ce78mr2455485b3a.18.1753840434349;
 Tue, 29 Jul 2025 18:53:54 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:53:33 -0700
In-Reply-To: <20250730015337.31730-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015337.31730-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015337.31730-5-isaacmanjarres@google.com>
Subject: [PATCH 5.15.y 4/4] selftests/memfd: add test for mapping write-sealed
 memfd read-only
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Shuah Khan <shuah@kernel.org>
Cc: aliceryhl@google.com, surenb@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]

Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
assert that we are able to do this in a test to ensure that we do not
regress this again.

Link: https://lkml.kernel.org/r/a6377ec470b14c0539b4600cf8fa24bf2e4858ae.1732804776.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..15a90db80836 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -186,6 +186,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_assert_mmap_read_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -802,6 +820,30 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+static void test_seal_write_map_read_shared(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-WRITE-MAP-READ\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_write_map_read",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_add_seals(fd, F_SEAL_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_WRITE);
+
+	p = mfd_assert_mmap_read_shared(fd);
+
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -1056,6 +1098,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.50.1.552.g942d659e1b-goog


