Return-Path: <linux-kselftest+bounces-39163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5DB291A3
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 07:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E49A7B187D
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 05:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05E20E032;
	Sun, 17 Aug 2025 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDuk9WCd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA51F4C90;
	Sun, 17 Aug 2025 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408374; cv=none; b=IT/NgqbyX29jkJ+5xTGTkBIKu5F4F60XI2sw6Wpil1CLhQQVlfokdjYetsq37ILD9BXd7S/u+ZYK4kNLJjFaj+fVmcvJliFut94uc0fpBYB96VgV5wLD2dKuXjzl8kcNz69n0fsjsbSRdYiKV/exdIrS8X1QRrVRV0T0ed4QPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408374; c=relaxed/simple;
	bh=iXytLOLYAKvzIwUQtsY54Ja3wuEAECemSWFhG4fC/+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2ztbfYTh1WYc092BPOXfKISIoUa+HeYFiQpsXi3zhnKpTB+vi9tgOnJm5ilkBiN4nolQCy2FUbZUZz0AwuJZ6pFHFtFDqoht+o1446tKdZN/6HtKcoUD7RZWjgFd1rBcd60+z58/Th6j2Se5a7K2ZCPOSrY5QuSbiZZAAsHoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDuk9WCd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458242b33so28184815ad.3;
        Sat, 16 Aug 2025 22:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755408373; x=1756013173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+csAhnTSq9nTMN0IXXONt982/kXLZfoGgBRxeDy+8ek=;
        b=GDuk9WCd/g71zDRUoIPIjO85FWtI/u8EkUE2ClNwP0k8aQ8bRs7PCsvh/x8gubhZg+
         SgZ0euwwgalnVVeMSd7twLh6TrYL/r6GTOMjtVzjeGAcj+V+4pw1Yz9DfUvK+wU72L+V
         Sp3qtnMi334bzOP1FOob9/z3X9XuHe2qaExxoe1vogj+UDdztRjVU0OWobqzf1WaCRXb
         EXVlpQP0Kyr/VLwHZb1pTJ659KEdgfzY41+N1ufBP0XXSgOHJl4NEHSW5Sm65uVOethq
         MZjKsffL3YEVP0Ef4gjASXf0dHc/JQ4zkGRRj6r04orAHcFKd59QXVlb0rqVmpnyEI6i
         R3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408373; x=1756013173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+csAhnTSq9nTMN0IXXONt982/kXLZfoGgBRxeDy+8ek=;
        b=qzKL+7rVwfmmQOwAXc5M8XvCcW2u7KlHfi1XULjeEtauC0sY1ABXAzGjKz0u9iuUfl
         cd7OsLMCVXowRmJfprAsKjSkIGpNEe5CeVGRN6ko6ofg0G9JKlbB/ded6AKk1EqP8Kbg
         gxW7B+7rUEXnP248G9wcWT4dfFMrpv/Nw9kG9jJLyKfhSeoiZARDvxqaG/4EARSTvEZc
         7lteFlyNlRN0wVKglno5zIXkZvYgiy8V4IBTVOaEYwpmWgrtWySFwzxPKrtaAls/WOE9
         qkOaN/igXKuRB1YIXciUzWIdluhY2SZPKg2lYO2utKnhujT675w1rmo4cXO4sUB+MbMO
         iTww==
X-Forwarded-Encrypted: i=1; AJvYcCWYi637Nue/Pv74ts9PizPAHHZJDJSGuJCrNQkwf0bbHwSaz1HQutagQQkYf0m4yUt4qFy74tEuOHHk9IcuzJOP@vger.kernel.org, AJvYcCWo5V/DHwfI8NqlCNoGzNlghP6E005ivoVOx+QCXYYJ0pcrpl863cioGyFO1yqJT9Pos27IuaQ7jNvN42M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRngzF2F0T8Mrym3VZUMUuE/YSFx/hD9sxMMYSJCEv0X1aK093
	Ys2DzUEvEgZnINq7f47WuyfwbmTa5OF0SjGZ00WuzXtvN6gafmssuzEC
X-Gm-Gg: ASbGncu0YzxbffItv5nwg3RZETsU1ZTkfc0aJoh7O5s27r52EuQ2g6hLQEuQb31Tw5L
	GRUshxpsE8NhJWUon36y2j8kXepZkbMHJ+qxmpJI72/hxPdTfY1ep+H7in+w0Q58lHCbcvAtXP9
	LNZS2AFG/JBL6BPe3QvqnKMXyIqKaquG3DLQY93BYwBQV+Dzteirso+MeSWq07ghOEq1mHoLJSx
	JXtlQFbXiDBkXWeZ7sA0uP7nz+3RpdNXUOUNaecq/oBufykbyUidBRPSbguWgdOw4ULXMP9UX3f
	HkIVoCOR8p6FyJgeks19o2iYbnHJq0pdA4ZTrX0HZNUfP5oGkScn1UlRjS9WUatm+ddbSRkoiCv
	L5ydup6vjVVG7qSZCmD6xobKh3wg+whcht+MJN5pjG0DYi/NSOn/o
X-Google-Smtp-Source: AGHT+IHdjmdWMdhWhx9c/Dnojz/XQXDrYT7Ob/K203nbXSW0BK9VyArE/pQuc2DTFfK490Vyj7q1Qw==
X-Received: by 2002:a17:902:cf03:b0:23f:fde7:efef with SMTP id d9443c01a7336-2446d8c5ae8mr112386625ad.30.1755408372801;
        Sat, 16 Aug 2025 22:26:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d592448sm47417625ad.161.2025.08.16.22.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:26:12 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 2/3] kselftest/arm64: Supress warning and improve readability
Date: Sat, 16 Aug 2025 22:25:51 -0700
Message-Id: <20250817052552.8953-3-vivekyadav1207731111@gmail.com>
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


