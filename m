Return-Path: <linux-kselftest+bounces-23016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B99E90FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA671882123
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC339216E37;
	Mon,  9 Dec 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo4XxFok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A7216E02;
	Mon,  9 Dec 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741567; cv=none; b=AR/YjYNPwjNzN7ErNwP54iADvNjT5F6GMxrCIU9BKv+qfW+2xcZgLpmhiayQPpWiN7T0wfp5ORPcnsHOUZiFXZ/9pOBFOsMBgtil7EFMTyqfe0kL9wrZBSxOMvSvc/wbpDp/gs2OueTWrYgmayjd9q7FrdXWCe4awtlYKge/Afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741567; c=relaxed/simple;
	bh=/eKFjQIO9amwjhOrWEdzQ+seL2Clk9SAni/pbzaDf/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrnPYDTC3VL116/dDcJ6SB4zqTe81k8dkcZI7YHiYCkPbbFIKEv7tpGsYSMVSjIM8Mv5cKI1JtQI1hn6h6FuBRB3YcQ2mJuPjKuGD1AcWM3cqyDJc6SFGf7LtdhETWj3Q5zMc6aPMM9Pp0TTTtZscQ1cAcPBn2VF8ADuQ1XPbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo4XxFok; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21661be2c2dso2768925ad.1;
        Mon, 09 Dec 2024 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733741565; x=1734346365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38xYmCBd/yHxA60HebMv1KUqXIVUks1klr7bSBDZuX8=;
        b=Uo4XxFokHn3Jb1pbUcMlpIQdJs8qxqeFOMiMErM/SUkgZA+pLBuNimFLfp8SAhGCbf
         9PNde6CKj515XpBIPqfkV1fhocEdhK4SvICLdCJs9rgTf+VuQhY+DgKUafyA8NNn9MXA
         07748Aaa3vKdW898WPUlNi6A2mQrWk6T+Srkn+RYWdBRwQQIwvG9CCpMPHAsyCCbycp1
         Bm55lzR4kveq6Ezyodt0J+MQ7Qq/mqpVX24ZsAeNTpXAyscLHVGhO613IrHXGL/hrr3S
         pnVBDssjzhV60UEyhjupgY5Y7eWlleSxwbBm9thTcNpSWsgsh4SDNUBztcjxtLyKzSxU
         Zlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741565; x=1734346365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38xYmCBd/yHxA60HebMv1KUqXIVUks1klr7bSBDZuX8=;
        b=dobkBOir6OMXes8FTfgmTk6PFcMdVw5LleepZ2G8l1qDCUkmL/TDfph+WjS9gRI94+
         0TjDlFA+VeUbgSVhpw4ohWomQMNqdAQh7/XsARYmDFyQPYuEribON7UfdZpQ0T5+l4iN
         RRJbpdCYXmbwHv4khhDCCC1kK82oRvCT0IKPfyLwSMDu6htPFsmh+N8D//4aCESDipCr
         lx4v1KijitCrh1jY4fKRw9Isrn6iop1jtVbO8vxsU8Z8TE9deqK2+iyFm3mBrsDAJXET
         tvBeqRSALoqlvhXxQlZ5AZqJF7iaRqBG9VkMbi0NxcuPGrn2zSOwuAMz05lUw4RMC8Bs
         1oRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVET73nDN2k3XV9Z67TkZdsFAuQ4LgjwIQCPaw3Gx4LlbwCZSxy34i5fEAPc4UbsXe48MtKReufS7p+IbM1dUXM@vger.kernel.org, AJvYcCX3CCZoiE2XohHeYjJPi1aAKdeQksEBqKcZRNGu7prWNcx/Iy8JIA9h6okV3WYu47sRRS28wAG6x7sbVEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd2aedjB4LNjAh9lsXEQyRFsRkXBt5CNDGGPldHiX439mqQXU
	QuqpSgG2UNd/7uu0Cqk+ea9Xckqy+elYENko3XAX9M1/XUChO0ox
X-Gm-Gg: ASbGnctuN4HgABxXNtGQ/11JdlQJ56fP2C0DHKnDQZZSR0atm036jVjbvkEiIsSDVUG
	JEyDMg0wTLkAZsE6Ul2TlIDrco0MtkAJ/LCB2adDvIcTy/xYgoIAJlaePz4S48HlRyUuPOG6+E4
	8XSDawqHnWB3udLOuMKKkiIddjAPCT2QErFnPokVQ33Ubl/vz6KZ0UD6dmJGDZGawxWNvxxJ5V8
	sq5Bj+u0WeC4rDmZda1vRn1G+gMGqoYCwvagGm8QWHLZNc02HaquAy6
X-Google-Smtp-Source: AGHT+IEreUug5wTKCz/c7KcglP+tWMz1wYrXf0knBCV2E6EAZCfQHAEP6KSMVBU1yeGylgbEmynL9g==
X-Received: by 2002:a17:903:1ca:b0:215:6489:cfb8 with SMTP id d9443c01a7336-21669fd0edamr442795ad.10.1733741565013;
        Mon, 09 Dec 2024 02:52:45 -0800 (PST)
Received: from ownia.localdomain ([45.8.186.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9f5bsm69928815ad.132.2024.12.09.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:52:44 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Weizhao Ouyang <o451686892@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/arm64: abi: fix SVCR detection
Date: Mon,  9 Dec 2024 18:52:37 +0800
Message-ID: <20241209105237.10498-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using svcr_in to check ZA and Streaming Mode, we should make sure
that the value in x2 is correct, otherwise it may trigger an Illegal
instruction if FEAT_SVE and !FEAT_SME.

Fixes: 43e3f85523e4 ("kselftest/arm64: Add SME support to syscall ABI test")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 tools/testing/selftests/arm64/abi/syscall-abi-asm.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
index df3230fdac39..98cde4f37abf 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -81,9 +81,9 @@ do_syscall:
 	stp	x27, x28, [sp, #96]
 
 	// Set SVCR if we're doing SME
-	cbz	x1, 1f
 	adrp	x2, svcr_in
 	ldr	x2, [x2, :lo12:svcr_in]
+	cbz	x1, 1f
 	msr	S3_3_C4_C2_2, x2
 1:
 
-- 
2.45.2


