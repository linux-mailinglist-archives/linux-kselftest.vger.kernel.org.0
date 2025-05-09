Return-Path: <linux-kselftest+bounces-32745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50131AB12C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC69B247D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A4290D9B;
	Fri,  9 May 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYTcJouf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A128F930
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791843; cv=none; b=glq3dCJBEoVZ36XMMKFf/jgazbuDRrlJYBlPmTu6fexoWdtp8KvLSCMeKR9OTOXjUeP3HTgC9Y+9l8ZxpNHW5qBPvTNlPSKHp5maAhyrRgkY0EZeWhrzD0iFVSiltXJ5EGYnh1rCdJVm5W3FwmTmzzZjCPE2MW/cs0wTXz+jxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791843; c=relaxed/simple;
	bh=Q5IK9HN+g/ZwX1gC4emIwTwcU9muoYR6ijy3AT09hzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9domZmUWMkUE+2J8K5ingx2jqGTkqvwsg3wnyKXNAWJItAWIgdQCxLuKJ2Plj4YFip2OymE7AIqoH+vRLjxlvv9pnhsFErYuhavswLBgCmiG54gUSltCD4ms2b8LmooFcjNb4mwXo/czWyxK9iJcsp88Vgyl1ylRhNrQnwTSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYTcJouf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso16444585e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 04:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746791839; x=1747396639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=th1/bFaPGJFRCo8JO8Rwr3mcmgSJq8KTF5FpG5MwqQU=;
        b=PYTcJoufQeQNTiDL5uL+1fe/GzGTGyxOM7Ez6cVsgYGGECsVLPctTKZ43NH2IgSFkO
         sKn7x63931pdlwIjCjKQWdOSf+opdjXmtL7cvtvFIeplx9YIk3gdpWRnvBjsWjFTC/ql
         wrsYYtG1hPN3MUXn4i7Bx++ZkGMG1j0UHW6lLaSYz47QYS4sJZPhFmWpBWFPbcOJ0GYa
         V8P7u8ToiGrD+VgawNhP4qtJ8MnxUx9gUk34juMidQOkcvE16eicjqWh0AjGYDi+5Xni
         yDDNv5PFvI7NfBlO4oCiKdD54Ubpd9gnV2t5qdztYcS2Cw16gAVO54oc41z4Q7HaBcRy
         wSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746791839; x=1747396639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th1/bFaPGJFRCo8JO8Rwr3mcmgSJq8KTF5FpG5MwqQU=;
        b=tviRFX/tkATZu9RLcHETjrcCMsVndH5KEYLmWNm+t7RKkHeN+EQxuRYqU7PGNrhRUy
         ElU1MBXo4qpRR3hMRr7rCpg0BLaNpkH17o0Mo4MwkfGa1SdRl97PgSNDdJhSw3gax+dJ
         2APqlMOPBK7as28iRPOSM9fMTwdRdPO3PWOysWDbqmbg2PhdUtwoWUFkl/1Iirdr0Rbw
         mov8L3PbM70qfbrFDsmBFa+99rgIvD2uTHokRHVW7txzMdSwqDoE9F+MMVYF2vH2U3zg
         irYB+MVLILmLbzV2TsrbfKVoawwQEhBz+pN+Gxqda9Bh9Y6Ag4WDFex16NTq5IwUet/Y
         Vmvw==
X-Gm-Message-State: AOJu0YxOocCdegIe5S85NmwzkG+moFNN5weUvbpWrATEC9XBlxflGbqy
	ZTrNI1BSs3dBfnCDuDryb+zkvuaolNmTWrv4ebFbfZklJNmPRTc4UirLKHFRt8k=
X-Gm-Gg: ASbGncv4DL9V/SVuFM/KhLM+v4nNEOZYXAitH9F0oVrOLuFRt1ZyNpYT5joCXm+aAnU
	EdGFHdsliB1t3PC+kBat/rPm3rY9GNpDAJBjtuTNyQZVY/ZgcmPmXwlSIaqD0jE3pMFz7IeVVUl
	HeeAIIlwdW7VfH6CyUzRq7wlqjWJIdqFLztMtdNUkr59LtcVLpMYFpiJYZMRsiiBOinKe2KcU8x
	/d8In0NH0uSKPFX1KUjOCY+oBf6rJbaTrJ3oDeCoVJRwTzfxhACPWmCEymSxATk4axWOFhaEa5q
	z6EMZGpOqHsLzH96LNgqKVXvNg1K2BOjlq5/fD/TTpegpwOOMQPBZ7tmERTXHmOJ1yHnaiPeMt5
	GNJAEhob2ptV0/W+Gy4iLZy2Xv4HHLgSaHKu134qSSKdS2GzkDw==
X-Google-Smtp-Source: AGHT+IGMhurb9PArmXo9wi/bzeveBgpvfyiPoLnFXyt7C3rq/dYKOcqicf2Ep0ffCf8DbUss6X3Ofg==
X-Received: by 2002:a05:600c:a409:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-442d780033fmr15039445e9.26.1746791838633;
        Fri, 09 May 2025 04:57:18 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ed1bcsm27032945e9.18.2025.05.09.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:57:18 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH] selftests/seccomp: fix negative_ENOSYS tracer tests on arm32
Date: Fri,  9 May 2025 12:56:22 +0100
Message-Id: <20250509115622.64775-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TRACE_syscall.ptrace.negative_ENOSYS and TRACE_syscall.seccomp.negative_ENOSYS
on arm32 are being reported as failures instead of skipping.

The teardown_trace_fixture function sets the test to KSFT_FAIL in case of a
non 0 return value from the tracer process.
Due to _metadata now being shared between the forked processes the tracer is
returning the KSFT_SKIP value set by the tracee which is non 0.

Remove the setting of the _metadata.exit_code in teardown_trace_fixture.

Fixes: 24cf65a62266 ("selftests/harness: Share _metadata between forked processes")
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b2f76a52215a..c43a6f8f8cd5 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1629,14 +1629,8 @@ void teardown_trace_fixture(struct __test_metadata *_metadata,
 {
 	if (tracer) {
 		int status;
-		/*
-		 * Extract the exit code from the other process and
-		 * adopt it for ourselves in case its asserts failed.
-		 */
 		ASSERT_EQ(0, kill(tracer, SIGUSR1));
 		ASSERT_EQ(tracer, waitpid(tracer, &status, 0));
-		if (WEXITSTATUS(status))
-			_metadata->exit_code = KSFT_FAIL;
 	}
 }
 
-- 
2.39.5


