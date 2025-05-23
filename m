Return-Path: <linux-kselftest+bounces-33609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE41AC1DB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AD71BC28B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA071E501C;
	Fri, 23 May 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="RLZ0F8Em"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15851DD0C7
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985596; cv=none; b=jyxv+PHZy3TGFvDpou65EIX35B2EBPOfcNFEyllJOdDUdxyefnB40JEpiCZIlRA8vBZO8s4L6/P80w2pN8nauXpVv09K95R/7Eg8/E00AfiNyK3BWYYUdqCJ7Kg5KrKxulzEOQSWKNYgC9SnZsUvdwr28j6mr1LgFHTZQMovnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985596; c=relaxed/simple;
	bh=qAY6EeFJTZG28TvoJgL9U5bXPgvj6ZZgzASuq00yAbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csJH5o+SojpQneJCuhSpZoAgQs24XrN9qdaMwx/41gy9ve8GYoBHEJSQlsSNOklpeSKa398dcObAFxBLAXoC4406lweg4xFCugoXQAupC+4ZRVUgLTaxk+ACLCCvE0eTQcBJFgv3L3SYdB9VPbQ5TamisOYD+H+N5obGSqH8d8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=fail (0-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=RLZ0F8Em reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dc82baf4eeso11854005ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1747985593; x=1748590393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhDC8DXcjYenT+PN1rPVu6Md6wucoYZjvtH8KVhEPDM=;
        b=RLZ0F8EmpKF9ZzJeaC0it7Lgr9JFnBgyRUh3XBbY5SWav0fK/mcPKZVRJyuy/fEuqo
         id7wkfSegzL5hQkdSAL9gvqZAHL0MVBdz08QY+na1Nc/QbyLg1ASGIgezM+0wd0AE7Bd
         wrLm/JoOOsriYl88em+4IgWn/9ZsLwhHSrWXj77vXnzAwb7lhK0HR2kOZ9TCxSz3Vdic
         ueWEx5AU0IfYtr3azoT4NJWa2bO4C1G+1ixGlEyTBSUSdA7ZSt/1yR9+emIVq42hdbb4
         AwDslKoZz6tMEHWVR0Vwg+J8vbjg/CQnVRg/LO5vHuso2+GHOyXmahqjQMJh6UqoCwJY
         RKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747985593; x=1748590393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhDC8DXcjYenT+PN1rPVu6Md6wucoYZjvtH8KVhEPDM=;
        b=dmbEvFRoPqw0yHy8PaZM+cMRv+MPEz54kjBuORTPvIdLZ6OytIu2fLnSlZUQkwWtMg
         EdGVla+lIMHZ1onitT/3DRVO36Q6T+J4T2DabYiehl/HyYtZn53seN8pZ2f9DI0K6HYR
         Z6H0Eu8srav0bQ56qh22blVOb0rVXEa3XCCOQf5AXAz/F5hG9lMjGFfVA2YvtuOoCE6R
         2ZDLBRxFAupEamedV60pmaJmfJt4R8AoVfFbLyhTTPmAZ43aUSnl8GeFgz0eEnAJyoZY
         2nqdheLkeGE8f2uc6ySgcYRbzi982fMRYngmfcFJe3NKMWuQYjlORaB2rW+SN2FxirQ8
         yceQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNKLRqb6CJikH2gQiypdj3Jnv/6vBPDFUdfUvUyQvG1Ofxp+OaHNATJxTE8QCWapUOpeS/j6SVOFE2BnqE1PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADvtPdAiw1rNcR1UlEetalGRLpDA6RP2LLVOxcYLt1Boh1jx3
	QEEpWjcyiJI0knaXP5Z5EbUySVvcZA1OCgHnByjfTdQEubRuACFDetFQWLkLyfdyUVY=
X-Gm-Gg: ASbGncspxRCk8ZJnVhBbBgc6K2lwAktFo/yYF1tbNkUZZ/ZRP4xUEPhQVQ0VyM+cj91
	ZSzeqs33JDLkjdThTF2QMcnbI9RbJ7H8PaNqcXjzoUFfS1yvnh7mfYHVxzgasVxo+rvwuB29Sw3
	vthZCFrXP7lZN6x7iUAEamkVjZX+7ainTaEIz87R/IRLeUbznse/Mv7kN004RhjOmM23YV15DRj
	GXAQjVM4XEifQHoNQTp5VZqaMLh4QOrxvSrXKKIKLPf6yUarWU4OeOrfBJf8PRS2y+TYcgLIJPz
	8DU9I2vd3xBiPAggTbLzRXYmw88ruMPFixVnRMwnrfCVW117YcCMd5feEKxN9oFOP1+L+Y+oyPd
	8eZBtHIg=
X-Google-Smtp-Source: AGHT+IG79dWbaOnWh6fbDdUHStp0frh1mqNr2bxuilmex7AQRbHU72XCruvtgyU30RqIruk4/I1vVA==
X-Received: by 2002:a05:6e02:3b05:b0:3dc:7a9a:4529 with SMTP id e9e14a558f8ab-3dc7a9a4999mr104600585ab.16.1747985592940;
        Fri, 23 May 2025 00:33:12 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3ae5b9sm3460807173.32.2025.05.23.00.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 00:33:12 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2] kselftest: x86: Improve MOV SS test result message
Date: Fri, 23 May 2025 01:32:21 -0600
Message-ID: <20250523073220.112238-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently, this test completes successfully when it completes execution
without either causing a kernel panic or being killed by the kernel.
This new test result message is more descriptive and grammatically
correct.

There are no changes in v2. I'm resending this patch because I addressed
it to the wrong email for Shuah.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 tools/testing/selftests/x86/mov_ss_trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index f22cb6b382f9..d80033c0d7eb 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -269,6 +269,6 @@ int main()
 			);
 	}
 
-	printf("[OK]\tI aten't dead\n");
+	printf("[OK]\tkernel handled MOV SS without crashing test\n");
 	return 0;
 }
-- 
2.49.0


