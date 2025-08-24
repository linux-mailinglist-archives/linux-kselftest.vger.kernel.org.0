Return-Path: <linux-kselftest+bounces-39800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC38B32DB9
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 08:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C0F205342
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D123ABBE;
	Sun, 24 Aug 2025 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5otFe5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7F23AB8B;
	Sun, 24 Aug 2025 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016081; cv=none; b=RbqrI5gi36UiQMoYryKo7zJ2RPBUuDhvMYLlL2bS8yVMbTTgp5Q7XULZ3loZaa7OBaLPpa5sKe14det5k4w/KIvgZNFcadHEraksJDhT0ReKXDQ29oubxHcXT4p2dZ4/q3fQS32XGRP3mXoERq1JELawtHU73+emZyiO+NApSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016081; c=relaxed/simple;
	bh=iXytLOLYAKvzIwUQtsY54Ja3wuEAECemSWFhG4fC/+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzNtEYjJvcLChyWyF1KB1D/MDYbCpnmFvQ1FB5uUY7c9JTO8yDxloKYxdP6NEdPke/Rl3SG4LKtNzcrdg8uMVf0L/kAs9DFyq1OKpfPW13xE1//TNQeKKJFJPx5k4TuQAx3YXQNEBsBwdgg17dKUk8zCQyhMGgY4xONPwfcjMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5otFe5+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so2604918b3a.2;
        Sat, 23 Aug 2025 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756016080; x=1756620880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+csAhnTSq9nTMN0IXXONt982/kXLZfoGgBRxeDy+8ek=;
        b=I5otFe5+/7pGb+LyVwAypIRdDTDh3GxQVSCiThjb/YqK8sK9YXY0skjA29en+9+2GR
         U/v+ItVDMfavsEK3MtQWEqTHc05IEFMTUOj/0LAt7pyhE0gxuRiVwli6P98NCDLav6z9
         W5KtAxEtJaPid8mzUBKDyRU6zpq7Y+Syja6jqHueHEITki3Z7Uj1EikjlRx+96vZXEwP
         4yTcmhTP4rtvOYuyuRR+qGFljmKbSj+4BjPuG5lG1DpkcXY7kenHBvGq9qlyG9HNwpu/
         rActP6lFQ7mTrSUT09GBPuGR84sODOBUDeWvXDPSlRv+6ngcmDHJjNuTphINYfZB2ipc
         y1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756016080; x=1756620880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+csAhnTSq9nTMN0IXXONt982/kXLZfoGgBRxeDy+8ek=;
        b=Y2gghe7/1y+A+POZpRPrmaZmjN4wIU/Ufqgsw13tIJaz+IaBSClb6IMGjltszZVWhC
         dO07OLIRlHCq2uperYBvpmuxn8q95v4RI7jqXSBJ6KJRwQ0W+E9ltJI6Bws5bKd+Dyqu
         OfwkbtVUndgDoswpWaJ8AZNbjWlKmKHnBaT+RWQaunMyYGzjO1Acv7Y9uQinFJucQSAM
         kVk+PCelsMbtmsbiVl5hb7os9LQnXiAe/PrFKpVjnVYzq4i3mfisYVwYKIml/qb8i+qe
         RsJMmRKlwySJaE7OHl24KR5dkAXBv8fudxk1tyFKL5fUQyWNcaI0bjHxFz+JmdSfwnBy
         viaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUseMWj+Un34ZNTYMbEwiMjp0U2Kq0/hlYgZOXyalUbMsF88OPWn+IlFyzm+yye4VQfYhub7d8yiVlRVzJZgPbV@vger.kernel.org, AJvYcCVb97MWNayMtFFvFmvafTAbX3pd70bKmg1Qvl9lKkHI9rwJmrYLtCyC4w8p1bUTZSg+seoQ2kSX5W5L4hrK@vger.kernel.org, AJvYcCWEVV1Q2wIwlHW44qRtTNhZ4KqKmadCAl2Y7CjHNH7OVl4HFbiVP9r4mzwqRUQADPbVO6myFxJ/vyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySh/ECIPdXDSmvMCLmXWXVgxflBpyIqGsIxtJba/gIAM9vTlU1
	fck0hwfTBAojkIXRz27nVuutgcWCBy5jwgmlYCmAaTwa8tJtQqZGSra4
X-Gm-Gg: ASbGncucUxLQE6ymJZ3HcBGsVPlTprZJickt99nOP1gNUIsPh38fS+kYgvMI45QiK9p
	xW1TFFVew0kj3iTdZUwubp+3NQN63QIJ3n6ZHrDTb68XjuHQggs7pmsGBmP6sho7lzwFC/BbZ0S
	W136jwMIy1/6XDYaHFiietC48xSc6/Qv2/jbO58mqsNq+bcVjZjVXn5ICaVW88zSR68kiG74Mbj
	BkKl1L5V4DK40rGyoXMHi60gSlWOlCrVZEYya9dk3pgpVH4FBmkmH5vcr9VckSOA3jGcXFViYH/
	Zq2VkaZuFb7fObilhuPzAIVjbvg/yowoM7w5nFQ09pmQOc63bgeeiggEvtch+fdAZDVuZ6zc0cE
	cUXuex5UZJf/FPEYAyiRHj+nzn/b0bnPP3YgAte6mE6XVwuszxetc
X-Google-Smtp-Source: AGHT+IFXF+ulYVYq6/WZYX4Wzz8c1l4qYzHfwG1UXARA/MN4QDWkAkOJ6QImUbM8o+W/8FDk4xQakQ==
X-Received: by 2002:a05:6a20:7494:b0:240:30c:276a with SMTP id adf61e73a8af0-24340d02389mr11990976637.39.1756016079641;
        Sat, 23 Aug 2025 23:14:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770529149bdsm1654943b3a.98.2025.08.23.23.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 23:14:39 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 2/3] kselftest/arm64: Supress warning and improve readability
Date: Sat, 23 Aug 2025 23:14:01 -0700
Message-Id: <20250824061402.13432-3-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
References: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

The comment was correct, but `checkpatch` script flagged it with a warning
as shown in the output section. The comment is slightly modified
to improve readability, which also suppresses the warning.

```
[command]
	./script/checkpatch.pl --strict -f tools/testing/selftests/arm64/fp/fp-stress.c

[output]
	WARNING: Possible repeated word: 'on'
```

Fixes: 98102a2cb7860 : kselftest/arm64: Hold fp-stress children until they're all spawned.

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 74e23208b94c..3a0ae96cf909 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -105,8 +105,8 @@ static void child_start(struct child_data *child, const char *program)
 
 		/*
 		 * Read from the startup pipe, there should be no data
-		 * and we should block until it is closed.  We just
-		 * carry on on error since this isn't super critical.
+		 * and we should block until it is closed. We just
+		 * carry-on on error since this isn't super critical.
 		 */
 		ret = read(3, &i, sizeof(i));
 		if (ret < 0)
-- 
2.25.1


