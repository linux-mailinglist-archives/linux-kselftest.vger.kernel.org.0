Return-Path: <linux-kselftest+bounces-39164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2584B291A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 07:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1647B1CA3
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E1201269;
	Sun, 17 Aug 2025 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Y+kqct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5221507F;
	Sun, 17 Aug 2025 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408379; cv=none; b=sT06zVvy7gKDl2yklciApUOv+KZxy6cr7hcQ0kLu0ilE++vRhjE/TE5IcfW5y0Hs65WMHf98FeJLbIs+u5XtBXMhDIgV7nFIOWuUA6V1iPOIm6sQco4xHvxHcj2FoWOEtMzC1PjEQo/9KmJKQEzU4Mhv2OnhbI9/kpFsS30F9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408379; c=relaxed/simple;
	bh=dEFjZ0irkD8kkz4VLaw3rsm64cw0sBJqoMvvNXPG+uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7VeQLjS7ws5pdgxah68bm9ELT7QTq/0rBnG4tQ7kZZz6+hSQFIWvYPvvtODgrKBhaUDdInBBiRuh2Kqg9Id+fif3Zc/kt+qzUSRLp7tTLkWyynUlKjDJShP3/vNpf1O2fiZlGjn6DXg99nl+awXOaSEE+nB201alnFwaWd8NVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8Y+kqct; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-244581caca6so23266235ad.2;
        Sat, 16 Aug 2025 22:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755408377; x=1756013177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfzDzbQEvI2nMK5aWsczii03Df0gZy+c2/ZhXQWQ8fE=;
        b=U8Y+kqctJ6ZgPPtzX/q2Lw9+elPSEZ8H3Sum+eS6j/IuDoWj6WISsBxhyM3Yca/ce2
         FUFhSEpQs2NPhmi563RSgNKkI+nUi4vS+p5D1lFACdSq869poj/X508qlDX/bH30R3gY
         rUs7cDI9toGpzmleEprynLeXaIVBsEOLFM2N98fCLUWzgjcGuGIoRm44eiiqORyB1OPT
         Uugg9Z6TEKGVZMeennv2ARA5hc5Lotc+gHPF2TQkfv+6fzt5HlP+Tao+MRFKz3S1nAK5
         3QQ3DZNHTdexgtE7cbCxaxOL2ZLWGNXn4nl1SYzCf9F3s8S4NMvh3rNHntM8kVI9zoUG
         opwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408377; x=1756013177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfzDzbQEvI2nMK5aWsczii03Df0gZy+c2/ZhXQWQ8fE=;
        b=e0mSkhLT/FsmmlNI6AAXHaj5EOrWSsZORAGma10F5lsPkWNLV0+Jt0DGZLoFl6Ydya
         kiYW032CHKmE3GxhwstAEJgVl7pOnb4OEoOyGVc9rLkI/rjoIMqrcjqUDy7X4fQc2l68
         nFy/x2OqsaZR+VVWW0yaNuC/UWfj1WtseRXPmMpVoJTnw6t3qPRRx0gz5FErT8zW/K0m
         5hBYH6H/Y8QBqx5goVLJEeacNDXWpJoZevfedzeZQ9iXiDO483/WzSQjLYCKuoBOnx41
         Ww2vLckUCLCqn3RbMd3HyLO84jBbTbyGi16jAxeiSu+LZ9bg0Wplor9CE3l9TROOXSla
         8vjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwFRuEDwOuh3KJgSUnxlLjhFck+xHleUUnllmPAilr4SmjTTLm5LVN0SRRmFES5/6095cBCaQsJ84KEJA=@vger.kernel.org, AJvYcCXCFZNf8oQk1CGypsWENafpm8lq/LlEia4dHcuW2fcZH+DT+5ItgW82OQvT/uR9wnpQBMvtRfsu1fBl5wEd6c7e@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzQMGGB1ouVtB4qOnAq4l1ihrO/cKlnjb2r15+cynMTVjJusN
	L60H0Vyo/J6PBhInLI1yjpXruP6MdK6tvXsEKvYyFD6x0SvW7LBaQf1ZfPrLVw==
X-Gm-Gg: ASbGncuSukvE09zqrqI0aTOQemwh60eXnbjca7JFj15nV4wG0ssOjp7qGQjMPJxnsts
	OFlyHKDI0u+fmOLvgLZlPmiMStCjC6TS70xE9mqCyDqy3IOWqKPSJWnR2CEwVQwqyS70z4nXKas
	klyOsdkkzFueXIUXTg1fpRFWxyAOj4hDHoqn00p9e9n+BnJpbuXCgbNSBBUtgumGk2SXgjNAvLn
	9B7riB3+JTda2Gi+hHNe6nTGo74X9yUzTtog2KTNB1+VkYH4VbR78ulBKGxnPBO4GGRcPOhcrey
	C0PgtW3F+haQ+XjskJbd5hI3fn3k0i/wqE7eY05KXr78Hlrq89Vv/uNKmLX2OTWT/wpC+NdU1A6
	UwPeMnZw1OkyglshkMGjqaa8OU57+kp2E9L1s7+p0uhtOsFxH1qmm
X-Google-Smtp-Source: AGHT+IGWIBenOHMDT/65eAOHKbmsBAK8zZg1qh3FS9nY9K/gdBwYB+48FUufYjOD/dFQdCa8+Imhag==
X-Received: by 2002:a17:903:2986:b0:240:7c39:9e25 with SMTP id d9443c01a7336-2446d889e8amr97866635ad.27.1755408377039;
        Sat, 16 Aug 2025 22:26:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d592448sm47417625ad.161.2025.08.16.22.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:26:16 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 3/3] kselftest/arm64: Add parentheses around sizeof for clarity
Date: Sat, 16 Aug 2025 22:25:52 -0700
Message-Id: <20250817052552.8953-4-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250817052552.8953-1-vivekyadav1207731111@gmail.com>
References: <20250817052552.8953-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Added parentheses around sizeof to make the expression clearer
and improve readability. This change has no functional impact.

```
[command]
	./scripts/checkpatch.pl tools/testing/selftests/arm64/fp/sve-ptrace.c

[output]
	WARNING: sizeof *sve should be sizeof(*sve)
```

Fixes: 0dca276ac4d20 : selftests: arm64: Add test for the SVE ptrace interface

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index b22303778fb0..90c56b38dabf 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -115,7 +115,7 @@ static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
 {
 	struct user_sve_header *sve;
 	void *p;
-	size_t sz = sizeof *sve;
+	size_t sz = sizeof(*sve);
 	struct iovec iov;
 
 	while (1) {
-- 
2.25.1


