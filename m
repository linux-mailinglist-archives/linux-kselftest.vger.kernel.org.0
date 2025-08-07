Return-Path: <linux-kselftest+bounces-38481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34436B1DB04
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F875584449
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0C263F52;
	Thu,  7 Aug 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K89rIgAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238325A352;
	Thu,  7 Aug 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581801; cv=none; b=sav85xu0peg04UcVT98ZVBBLLBEYaymPL4ZDPTw03eOzmhLXrPvlAZjYH8t46ADGN056tJHtIB/fl8YTjurbfUm4iZ2IdJiEZ6TogeoQjBpzRumy1+fVpFOlTzZPxdrHUQk838L5bCekX/fYRrwEqwaEw4SS5TiTq+V2MjLuZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581801; c=relaxed/simple;
	bh=g1Z9vnuEvfB0Ol+v/vwya8CA1aQEqabWnHA43TWxiiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4kiGlAAwcmmJnvfpRB2dv4Xv/JHTXfXu64Y+GOKG1IfranW5iXKnSJc1JiZ61J6epL5iUo+q/0Iw0qXPLI4GkfELjSu1WwfJ50ZIqI0VyfAqX8K5RGdaKVbdw86sUIGiHnc233lAtkTPNGlmK3pmBYIs6VnywO717zCubmsNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K89rIgAr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2401b855635so8744715ad.2;
        Thu, 07 Aug 2025 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754581799; x=1755186599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tb2sXr7iZMxtDZGeGysd/W5Iy0nEDu8fCyzmsqY0v14=;
        b=K89rIgArE4QQ4dJYSLJ+fHsy3N6oArewk62SJlx/y5TSzk6vyMmyN2J3xHmB6Sg0Gu
         CxSsMOqQzOgPT44fmVJRNOkvTyCLZyl7zvAG6rmsLnFIpfTCznISXwEWfT8Dv9bBE/SK
         lKhWV1aOGBVYndHjGLy6o5Th6cO9bDatpl7b08APuzW7IAFgY6njw7oXZkLKWZX4PYI8
         mVcXseLALq2c6t6i3WyKrCIgZm0+mq363cXou5MP96SmvSssmunvrm5fsSHRXoOSAcbt
         ZkEfsheHKI/8yKBKhwLjg5doYzIAtDVg61UfV1sv2ToUiSpcSzIxDTNPOTzZDphrWS5y
         DM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754581799; x=1755186599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tb2sXr7iZMxtDZGeGysd/W5Iy0nEDu8fCyzmsqY0v14=;
        b=KkshF6cM9K1IitxdUzam6EXvsNJFStcohYCFBl07YY8lmd4YwRtq1iFPOkhAfkTAdP
         nc0VQ8JgG8Kfy22JIJU0H+q8aFNtvPGrFEbQYB7Wa3iw+6XMkKy+ttUKmHr4KBMBOd65
         DsQuUfOvyi9u/IQO4wkhVLmvj8RRQkcfbsBo6YnL6729Y3W02nUYEf6dJJQO1Xxh/+yz
         l4xU9qYXBGcCD+/+GiEtmikY7zzvRV5mmCvEp1Lqx9Ej4d/3h/0IBpOBat1LEh+Fd1Z4
         NZNXqUuYRAo+ETw+/6x4mD6djh78JFgF7e1U14y0nTLgF5IW+Z6jZAhNqumb7D9XIlQk
         2tRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJWSjR16SLDGkIcEfuJM3lVp1P+4xKE0jZN1s4zeny+BvUK8rLZBgJpmPDc3xH8Gzf/otArAnTVxBk990=@vger.kernel.org, AJvYcCXl1MpE6m16rYZa8ztgHMvIIalo7p1b/FQY6AedX+5nsrCiZYRmAqpFNt1FlFZgKZn3IperZHMlQs0Qe0Up3Dsd@vger.kernel.org
X-Gm-Message-State: AOJu0YzCG+BnA+/9ldurhMLVB6UyW2WlcNCLUqEHF9iuTaTLn0YQbXrG
	LmPcnJ71gDX89CE48bEphMe8bUOB8bfUqLAsWkKy8Fd4ytXWbuZJDUaV
X-Gm-Gg: ASbGnctwWmkqGqsVACrf6MrZYcbMF9sDHGxOaPl0/0QijUE3bBmDBciQ2DhIWLg6/7g
	Wnm4U5cBG20UdguOAnojJ+Rhdv2OhuBRmjtOgls84MtD4Zqw52RsxL3mQKSGRZ4Nb4b87C2yxp5
	K5QIn4z2Y51xlN9XLFjjCdCjPEPNy9084B/oMEdxX2RTtwG5QtAx1j8/S6HcvwNl7YJKNg5Ak1K
	+NLkYJte/ZWG4Ak1yEaZmXY/MXGNQo+eyh4WxClJ+JGDbp++FxqwSdc9UBg92Dcs08/Nh2BJdsg
	paPdhVTihCHbriMKdahiptnJHemzFliVqZTUggpFZjMML5Iqq0q0PPMTkdXWBM8I4OkDdurquth
	GWWKvvUeD4yVSJzIKNME5mfXImWRQV1l1ZA==
X-Google-Smtp-Source: AGHT+IGtBI9mRz+JUlweCAYDzHjTxQ+R6ODQboeLUripcDbFR1smhvfREX+e7Demyuc5DLZ15yPraQ==
X-Received: by 2002:a17:902:ebc1:b0:242:9bc5:31a0 with SMTP id d9443c01a7336-2429f5bcd01mr110369575ad.56.1754581799169;
        Thu, 07 Aug 2025 08:49:59 -0700 (PDT)
Received: from server.. ([103.250.145.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5f2sm187873315ad.125.2025.08.07.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:49:58 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	broonie@kernel.org
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: arm64: Check fread return value in exec_target
Date: Thu,  7 Aug 2025 21:19:47 +0530
Message-ID: <20250807154950.24105-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 tools/testing/selftests/arm64/pauth/exec_target.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
index 4435600ca400..c22db59194eb 100644
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
+		return -1;
+	}
 
 	/* don't try to execute illegal (unimplemented) instructions) caller
 	 * should have checked this and keep worker simple
-- 
2.43.0


