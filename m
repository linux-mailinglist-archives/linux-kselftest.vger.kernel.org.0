Return-Path: <linux-kselftest+bounces-3939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B8845D29
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764401F21926
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F960915;
	Thu,  1 Feb 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuiAFuv7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721C6091C;
	Thu,  1 Feb 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804502; cv=none; b=pSQCJ+N7kyzdDk+GLzrcoMWNwped3UCLK2fMiQ87sk1vwtW5vn9TbJ2ErwRpAXi4Fnq+XoiNecJsCK5/W/NCA6opAxvf4ZPlK9z77EVs52xiHuEY/oLERa9e2vZa1MgAWKwyxHk45tUedfsX+4QvftRR2PxLpDUTAlSx7Lx/uMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804502; c=relaxed/simple;
	bh=9UbuRwgbtCvmHDShOTkBSh2+DVCtj5gZEsK722r5l5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElAC7zUjaocIKsxgLr3Xlyi2eHvApMEeLYZ5JKU8tYqMmsvK3PdCmx728u1KmXOeRqcX+ws/AWHDKxX5Ldrh3bE+Jh0kHdGgctRLfeW7O+x68fOQFZYnf3maU5bUi3uWTY+pKy4yaog4++mbt9APjRr9KBmgWqFUuCtza6xxnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuiAFuv7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7838af983c1so83559585a.3;
        Thu, 01 Feb 2024 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706804497; x=1707409297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdgaKTDP/3/TUMGAJiIyIQPY369yjzqcYKhzDNfmkUQ=;
        b=IuiAFuv7sJIHcLwAbCYM8f9xLUOM6G2ma8+cplx7eqD1lAivy2zCsBBa8N9GuobXxq
         q3O+dzTY5JvYahF3g6+SAGgZtuUZ4HTnPJHVSC5Xj2Oan/WEP3dLlBx3WOBF7TbElYAA
         m5FlEszfpoHy1uSvdHogn/wmFHCQ9OSpR4Q9rtkLl+wF27Uovvonx+qIaMyWDq8EWQau
         178VygYu5yB3OSXR3axzUOjt7OD+LyZsFtSUeeZ0ETxFmrqWKyMYdabe4h8+tlkN5+Pe
         yVGt3sXSNbKC3GiqNiC5Hb2DdejE8dFmRCtYIA9mk4qgpDaLQJulMn2L7D06ocfrVOBG
         Ex7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804497; x=1707409297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdgaKTDP/3/TUMGAJiIyIQPY369yjzqcYKhzDNfmkUQ=;
        b=gaMGUmSePo8v40bFYw4fMFUde1qSJTb/NJK94isKVsRGQ04IywfOtycsJUjzQdV199
         G2+aY4mPgfjbEdu4vQzZWgkHBt19VXIg93kIZQMTBMZJuHTq9eV4VTE58QR07PlXMPEw
         27eWev6Lsl0IXr0G4myRVa2+6F5UNGvqfXes9tJ8dSLPGm3430TsYmypK14EN76fTW1Q
         AYpBe9U/M6eUHvLBnflm+Z+GiLq3PTi8NoHjOkR2zHTP/6SoUSgoj8bOva+Qj6fWbNez
         to8lwRBUw9A/Qq/oO4K9/14jm5A092h4OG7LuB+bo3IDbym4iP1hqZ9r4suCY8ZyKlDU
         bNpQ==
X-Gm-Message-State: AOJu0YyXzOUtpxIuFdS7kbyh0dxhN2WbrOnlsiyjqpWi3G+lndwGyyJq
	RdGV31ED4ifULtvT6g8gTx5yFfrnMFMa01Em6HSaUE4X/AxnmKDpMfCDkaFZ
X-Google-Smtp-Source: AGHT+IHsvsKpB+Kz2504YpRMsZ0KeYAkuqUT2RuzVh0M+OUh16QNO1MZT9nExQSZfjsEDnKrmst6BQ==
X-Received: by 2002:a05:620a:1a89:b0:785:51f6:8b6d with SMTP id bl9-20020a05620a1a8900b0078551f68b6dmr93386qkb.41.1706804497306;
        Thu, 01 Feb 2024 08:21:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQKUu0jty7y9WFocKR1SjjvZjuJYjyFJmkuhHjqfEqdC1DkPAyMfZf0DDbSuSP6o/hVksiluM5eF2zqfcw7DhWFa/9fQuLETaHiyqh2qrXyg0AWfuf4W5iam+zvcjLpSSrYtcqUblGS4IV0Ft6FucjN3cRYewsbw69/eWpPI+4LGxCENlSot1TgJDyf8sRzKU/9HRSmLpDcn/+NvM=
Received: from willemb.c.googlers.com.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id g9-20020a37e209000000b0078400fab7c6sm3213900qki.132.2024.02.01.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:21:36 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: ignore timing errors in so_txtime if KSFT_MACHINE_SLOW
Date: Thu,  1 Feb 2024 11:21:19 -0500
Message-ID: <20240201162130.2278240-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This test is time sensitive. It may fail on virtual machines and for
debug builds.

Continue to run in these environments to get code coverage. But
optionally suppress failure for timing errors (only). This is
controlled with environment variable KSFT_MACHINE_SLOW.

The test continues to return 0 (KSFT_PASS), rather than KSFT_XFAIL
as previously discussed. Because making so_txtime.c return that and
then making so_txtime.sh capture runs that pass that vs KSFT_FAIL
and pass it on added a bunch of (fragile bash) boilerplate, while the
result is interpreted the same as KSFT_PASS anyway.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/so_txtime.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 2672ac0b6d1f..8457b7ccbc09 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -134,8 +134,11 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 	if (rbuf[0] != ts->data)
 		error(1, 0, "payload mismatch. expected %c", ts->data);
 
-	if (llabs(tstop - texpect) > cfg_variance_us)
-		error(1, 0, "exceeds variance (%d us)", cfg_variance_us);
+	if (llabs(tstop - texpect) > cfg_variance_us) {
+		fprintf(stderr, "exceeds variance (%d us)\n", cfg_variance_us);
+		if (!getenv("KSFT_MACHINE_SLOW"))
+			exit(1);
+	}
 }
 
 static void do_recv_verify_empty(int fdr)
-- 
2.43.0.429.g432eaa2c6b-goog


