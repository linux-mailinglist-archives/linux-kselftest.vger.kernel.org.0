Return-Path: <linux-kselftest+bounces-47605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD1CC38D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD1C13067D10
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD7343D90;
	Tue, 16 Dec 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khCGlvlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BF344033
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894904; cv=none; b=kixocU/kab4YpYVPUGgr4Ca7w0B4FpiV7Q+B5dDeEXb2auBVZJuP4hzIRt/repUdjJcoG+urYd9rHaxtxpoO3EQHMIAvNemqvlRlPyDm89Dja9CsHqVq8PHahueJ56ABs7H3q4dRumb3NrrlOJlf9tz2m+XPYitRMr+NfscczRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894904; c=relaxed/simple;
	bh=pXIiO6haHR0Tf/mUYKzHz3v/EFqAm+QdyNO3oE4TwoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGRIsNYf3YpcTN8d8rX80WpgDxuOEujciSbvdhQbboRz+hke49yfAoDMUXeNZGjSbbqf9o658ju/hBKfx67d/DlaHWHVZ05uYZw4FpaXn7yfu86Zw1nXzidTANs0hcFc70/BCsvjNPLwohHfZ7GgCDIxMyBEV7/MtxTT40WYiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khCGlvlx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78ab039ddb4so46422597b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894901; x=1766499701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IVCcg/qre5aOV+b23PhiTRxysVG2ifmatqXUBtcww0=;
        b=khCGlvlx8cfTmjoRQwgilR06+xVk9rhRq0Iocx2OPdSG7JFCGgH30fH0lTJHhUtj5x
         RTB+1gCHhn99+ZffIjq0zFw3J4ywB8NhbHoJiFVoOhyV6MZmeiDMyBzVsX+h81BqkFM4
         kDVtOvPtJ8g7ggnoo/sqxKilTOekGC+ShS3QegmlLZolLL95PVnLU0922crYEamMOqZ+
         OIa2xZ0H8nIOAy11NvHHECVum3cHGsyUx3WtKq0zazsATUFTMeTb1rzala3CYzB6IACk
         7Z4y5PEca/3E5yClsX2SS23ZSIwMMAbmiM9c9adgM14VoDbE2Udny55hIzYwkwQu+jRT
         gQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894901; x=1766499701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8IVCcg/qre5aOV+b23PhiTRxysVG2ifmatqXUBtcww0=;
        b=NLa9lnsnGzWTku5uLvaDGRz9dSit8mm+SDblnQcnwy6RPqbwYKF32rtSp9v9HTp4WR
         PJs3TQuRh692lTOh5pVHn6a/2Psbe/5DHMoRFgFrAmg7SDuECBXrdCnxigllBKA0xPgA
         0D4yz0JmVdPRfsP8LuNo6V85pyYB1geAX8lNbaug6xizeMMLQ7dS6+hEQwGBoYvfFSe6
         mjYhSo16+BVprYYUjshgGYpL9vx3ddhOZ5UmlBDUzyOQywbL8gLMIBJ434SrrkSJfnjB
         Z2qVaEV8Lj3/IDFVzn8v4xrNmbiefrowzHKS5pwLHmeEPwhwvbOAkR8Larbw0emCERUK
         k0hg==
X-Forwarded-Encrypted: i=1; AJvYcCUlPNLeAjaVjHJNZCoy+2XbfkDWCGfWDYfrLvz00TVmOH6DDohBW8vmOvH+ZHqQqFLh2btdIVi/LvwW4Okc+xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzaYfJJjE2EXxZFMXVVmce4elc9DFoFGkyYOnhkHLt/x9xdEC
	SsOqSyfDiRBrhJN+23r/wmBM69mxcxcqWYzssaKCL/5s1Q3HGVufVCo3
X-Gm-Gg: AY/fxX5v8VBfmrBibwIAqgmBKVxzrX0q+FPT9EGuQuI1vOLXgin5kjPuN3pw/5pJKhJ
	E7+dhIy85WtlNUQHgvCZanGehuxF9CKw3eN4Inq2W5iWnz04WYAoJTKaz1xB9Hm6jy98nlpq1Kw
	wV9sZuMA8HqhtOQLYC8tMTXSd8LOratna9BwR35anGlv33M1d1DlGnvi88kcIEw/dhnI+OID/hh
	Vo2v38wrwle3YaC78V+I376hBCpjy5IkfIrlsOnO4rBQvhxAyySfvQrk0mLutoIae25NKn3w4MS
	gG97Lzc/QyUpSwyovO+4yd3DcgxZGZv6dwHpIG4XnhSeFht8toUGp+XIP056yIBjx6mgHOJskBT
	hN5xmB/37NvVupe10fvn34jHZwfoZH1VHHZBozibSXsSVrwao1UEg2sdTuXfZIKVgbSHlGfgVoQ
	3X0YGc/IadSUqJ6hgz
X-Google-Smtp-Source: AGHT+IFTtA6pkA0ey4PSA7sZYRNCSAgJx2il0bzaLO5i3/tN2rwaLMUoW2im+2O55ONV3Dj0O+NhjA==
X-Received: by 2002:a05:690c:48c9:b0:78c:5bb4:1d43 with SMTP id 00721157ae682-78e66e5219fmr116639627b3.45.1765894901104;
        Tue, 16 Dec 2025 06:21:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748ef7b5sm39226127b3.14.2025.12.16.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:21:40 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 16 Dec 2025 06:21:36 -0800
Subject: [PATCH net 2/2] selftests: drv-net: psp: fix test names in
 ipver_test_builder()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-psp-test-fix-v1-2-3b5a6dde186f@gmail.com>
References: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
In-Reply-To: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

test_case will only take on the formatted name after being
called. This does not work with the way ksft_run() currently
works. Assign the name after the test_case is created.

Fixes: 81236c74dba6 ("selftests: drv-net: psp: add test for auto-adjusting TCP MSS")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 56dee824bb4c..52523bdad240 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -583,8 +583,9 @@ def ipver_test_builder(name, test_func, ipver):
     """Build test cases for each IP version"""
     def test_case(cfg):
         cfg.require_ipver(ipver)
-        test_case.__name__ = f"{name}_ip{ipver}"
         test_func(cfg, ipver)
+
+    test_case.__name__ = f"{name}_ip{ipver}"
     return test_case
 
 

-- 
2.47.3


