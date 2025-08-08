Return-Path: <linux-kselftest+bounces-38543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DC1B1E435
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 10:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A1A3A676C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211D2566D3;
	Fri,  8 Aug 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of8aOPtf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B90254845;
	Fri,  8 Aug 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640620; cv=none; b=gt5RpWGQwLZhCfnOt+4JVoEVk9hdG7rwfMkhu3Ri50Kd9x+viPA9qs7BQREiRVIBgK0+B+TkwV1/ajTv336yjt9+OLr6ZHgLvYt1bUtFtNoTyUKfw2bPqHHHTMvIUvfKN59hoTMJCJeoMCzoQ1dfnDMlXGIwrT2r1Bd4mrATTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640620; c=relaxed/simple;
	bh=k4Jnibd7i7jRx0hnPmHI1NyJepumY63rXsTCMGpzRJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW49EllF3fPp4VMGZoVGcJ/xR6Br9PNiEHc33SZl5lDYyXoaCGitGvHzJwIXWXuIPsVQgV4QeORI3kw3njrmWde7wu5fuHxyTxh1/WcboqMCzrwEtASRv5y866FYDd7cZlrazAyemFgL0XEXEu9y0/8Q/s4g8uoMQSgiA/Cca+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of8aOPtf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bd041c431so1814251b3a.2;
        Fri, 08 Aug 2025 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754640617; x=1755245417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLal7wiw2OJhWbaAgh4E8K5No6pZGJ87RB4Sd7Jh6w=;
        b=Of8aOPtfSMC/b4xp2rcm+mM+n/qJJJWidwPzrhEIFDRKSEzX5zKQSUFLljf35M2rTS
         B6xiGfWzPd2mh743j9LLzAXyPUnhRnrzJnr+0xQX4/mgcHAHWrRdRAGkvsVl17KQ6prK
         O64TkW/B94PftbOOXNg2HzXcXjbH5usjGo1tKCxl93rFlng7OcC7rkMh2z5GaAYlIQ6T
         GEji2qnDHxCDa9sPVTNORlphQfY6UoEfzT7JnNCXcGGFBDJZqpwAGYlEw79ksApL6urA
         ZuGa27jhO8g5ZsMc7PtXAcROZFeKPB8nrDAClnMJXkIm6dhAiD7c+DFR3SpIhWMJ8yMk
         un2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754640617; x=1755245417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zLal7wiw2OJhWbaAgh4E8K5No6pZGJ87RB4Sd7Jh6w=;
        b=kTeFInX+JbrlMXUAwyaIijBg/7J8MsHuRD3NIMyPV57sFMyL7iqls179qfaN9A76md
         j316Tf3HDZTLtgwy6PKryF4B+zmcJnaxtyZzzlqgOYmk0uK2X2EdH22pP49vshP4O9WF
         igVpmhVC76n1FLEyeScUhRwMLNk2+Axgd1VdNKbd5od/eaLWNUTUxXQAdyveR+TSG7ag
         u9zZJfPKpIr4hz5+0vaVUTVtU59lSkI/wdYwNlegzrj0ZudX3ez5nYhjjfwy3TbYs7XK
         YgTF0c4T0knaqv7TJTu+G7PM1q4SVeobmeR6Dyt1f/4bhxbuwpjbbcgGkDiPPDGVVLeG
         w9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVrXteJvrxUkoM+h9rCwjoURReosJo1V4NVBwmLPTmKFmODIQjcwBICBkBpM2A8U2KpcF11TxTuyNAvQyjcFQlM@vger.kernel.org, AJvYcCXE3X6FSsR52yoRWtezlxe+Hz8j2VnfcXlj6Sy3RDxLWF7P/zB3PdwVDJhsXn28YJL2QzKP66yYF0To2AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITZlfvbZ7ffDvdCp3hsGqTthYXXCX3c+Ie4D1+H/HoqQM6XPg
	x+5Lb93oO6t97gcberRGIBlHYmK/cDp+HjXTAmTMBdFOVzAGxwWabIbC
X-Gm-Gg: ASbGnctISaWrekOuSKytSYUqr2WYC6A9FYho4nNd/QaCyJk97yeEn/+9BYtQ7qVr+i3
	O9Bmeqhnsyx/FMw00MbQGJAZHkkiw6KvryNdMSeW4ZqB2uJjvae9XO81h+3abPL8OqB2fPFXbig
	Av3Nwp0ev8j2t9iQOV7bLrOqqnjZUIYxEExaQ5tZuIgeaprJpRfdzV9JD+UUiYOnYIGVMlZ4cx/
	m3eoSCX8sjpNEy6sdIQx740d00HSf9xDJvYHCBa/ceyPCjWMrxS2rl6MdYlVPj5ihneBLFrmuEI
	nw5NBEIawnBtCcLgEdbbBR656kmpjLw/EAR4qIzQmUwaoRNiHjuYicj+jtKTcN8r8y6HF6hS7uV
	AMpDXJfXcJ/YIN+bauQEVlW/4/fS28pnE
X-Google-Smtp-Source: AGHT+IEOBRK8OBS17/ZG9lflsFPSXZq5vwtk1VfOQq6lWhyfYgDsLGdHv2GGhogZHbcQ7nTJUkbVhQ==
X-Received: by 2002:a05:6a20:12c8:b0:23f:f712:411c with SMTP id adf61e73a8af0-240551f864bmr3260992637.36.1754640616761;
        Fri, 08 Aug 2025 01:10:16 -0700 (PDT)
Received: from server.. ([103.251.57.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0b57sm17098358a12.31.2025.08.08.01.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:10:15 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH v2] selftests: arm64: Check fread return value in exec_target
Date: Fri,  8 Aug 2025 13:38:30 +0530
Message-ID: <20250808080955.41735-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a72e8741-a63a-487e-838e-daeed3458c0f@sirena.org.uk>
References: <a72e8741-a63a-487e-838e-daeed3458c0f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix -Wunused-result warning generated when compiled with gcc 13.3.0,
by checking fread's return value and handling errors, preventing
potential failures when reading from stdin.

Fixes compiler warning:
warning: ignoring return value of 'fread' declared with attribute
'warn_unused_result' [-Wunused-result]

Fixes: 806a15b2545e ("kselftests/arm64: add PAuth test for whether exec() changes keys")

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
Changes in v2:
	Use EXIT_FAILURE instead of -1.
---
 tools/testing/selftests/arm64/pauth/exec_target.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
index 4435600ca400..e597861b26d6 100644
--- a/tools/testing/selftests/arm64/pauth/exec_target.c
+++ b/tools/testing/selftests/arm64/pauth/exec_target.c
@@ -13,7 +13,12 @@ int main(void)
 	unsigned long hwcaps;
 	size_t val;
 
-	fread(&val, sizeof(size_t), 1, stdin);
+	size_t size = fread(&val, sizeof(size_t), 1, stdin);
+
+	if (size != 1) {
+		fprintf(stderr, "Could not read input from stdin\n");
+		return EXIT_FAILURE;
+	}
 
 	/* don't try to execute illegal (unimplemented) instructions) caller
 	 * should have checked this and keep worker simple
-- 
2.43.0


