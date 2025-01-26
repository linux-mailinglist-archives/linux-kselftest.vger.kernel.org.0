Return-Path: <linux-kselftest+bounces-25208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC19A1CE39
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56651887C3F
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9E1607B4;
	Sun, 26 Jan 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fal54PEL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14038156C74;
	Sun, 26 Jan 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921132; cv=none; b=qK7mgUL9E+b/T45lNh81T6S1wt9oj78ahqimXWZdUloDKwNzZ9PQLOImBpapfS68ovNTroAVLzLAw9rvq0Lhn9xZy5sW5r8D2jwLcz1NcloldVqD3i245wXP40+mwfEdqmsCfqbxJflGBZMXs1ol0exSeoOqUfy5SR8UXWxCGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921132; c=relaxed/simple;
	bh=3HzwZglMqoti/zMMv84hxD4QKfPrftdxWgglMb426eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3INoyxIYiHhbSGRPNdIA0fKVoaFRu8beKjzpiPXlPhwhVlFYu1nmWgUXwC51JPzZIACveXIK4yax5bgxS4JBgRJ1ex8nzZPgL/zks2L/myseUn1l1NpC38SVatuMypCUAeJGU46dKUW7JX34T9UDXv176nK9Qq6Jcp0nV4HB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fal54PEL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so39869295e9.1;
        Sun, 26 Jan 2025 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737921129; x=1738525929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eIBgM+ncEtkY579L38d55O6kYtKm0G7OUDJvTGzAIQ=;
        b=fal54PELtoNOLFYsD4dNTBMXHrVnxHIWdlNNQOS1i4fBv7ZS/7LCSRT3wWwR/eggQS
         CC2hkeLw0ZC8IOVwNLh1r9OAhhfDiX4d97BZnSgsUVKnA72bOHbrOznA7PjNXfcnOsSW
         XUJ7WI7A1TnYxXJEuEa30iNzM3+poiL37veV9MH/8dLUuvohW/6eOgoebybBx44LNnRu
         2L5e9+ljs1RD8KHkGvUpZ3EA5S+ZNdypNs7KOLIsVwOsBxnwNrte6N7/ekgwlSjzbEnD
         prEMhPTnGgwCacJCPbSxtHNsjNlzNm8Vio/gcNBq/WUDUI0jReG7uAz0SMP4wEJxr+9L
         eMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737921129; x=1738525929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eIBgM+ncEtkY579L38d55O6kYtKm0G7OUDJvTGzAIQ=;
        b=asi+f+FI0EcVn6/YNTPSJT5xZHltSlEdtuEVJqHoTvI8TNiDYO0aqEvqY6QoBOWLrs
         Nf7STwls6NAQ/I83yjYzL3EwUTQheKVGNcNDByTNaRYbRhXLbVjP+rWnUaVp3tmiQxww
         MYcZGk1YQ+KcVY+zMJUexYlk2c+wRdXt0A5FSZ2wEPt8dWPmp82seeQJu3FwEBU/oAV5
         jQiIrU9uPvuFC7zqMEQ1ZmNjO/XV10my3q65rvRfwb3dzS4JaKAuyH7kz7Y94PIK8B/c
         NZ5OYFVv5tnVfkvzr5frOBE54V1qohZTtxPDs09JLjYaJMvupfDwMRD4v1crT5cKNE9O
         /KwA==
X-Forwarded-Encrypted: i=1; AJvYcCUnjjCJVQdlJiuk2lkqSa82dFGpifMcyektNwf26Gpxl+sX5zJixYUyndK8XEqzIBN6D0/st5dQU0k2JAbm@vger.kernel.org, AJvYcCUuY6fDHzIjHOzh6NYA4TdvWSB5p8YtCOU1z3rdk9RMWXCgepHmsuVMgVzycWux8t5XRY9qe68nQbGQc03E5c8=@vger.kernel.org, AJvYcCXNzoMfN7rwlHYpZiICHCnBXQURXWBsL2Nt+TD/HsCoHv5u72WY4KCSJwJE9Iz8a3lQbvPgWgKJe7KKMQjCTXNa@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUERyB5ofw4pSjSBIx0kP3YNxHKYZQlAAp7mDfWhG8zTkK4xP
	AGtMLFftnFE9zkwFD5D9cZgs3RMptKmMLB63pZrSvW1qXypbjQPO
X-Gm-Gg: ASbGncsULR/8TppkJYG+1JKSr3GViAPnCwM/s4L/DC9nXxrac4PZ5SBnkfdCw6iowC8
	GbAxpLb4efernNICR7o2OejFv2reu2IKMOHW06+eYk2uAXs7XIvmoAUmV/ZKFmayI3gahvEzoyv
	Mql0Gj/iQ+qxkH6cgyNKkIr5V0bBjVOzWs55ugV4NVuu5DzPaZOWxFMKVvBVfGwenXd47alN7m0
	1kh1275P/0/A9ghYQFJKz6AcsizIUq3YK8K8tA2YoAvm5Gu0BiYgVuVzlGPGK855A4cOkn4O4Kf
	7vpe33JKCcsh1qtPCyoFx1EHNAm8StSbJjUZ973GAg==
X-Google-Smtp-Source: AGHT+IFLSXWXQVRvtOO89HEkjuNZR0gdo04cYrG4f1W6qdK4z9NtGbeuik3tgyxkJJY5Y2u/rPYxUw==
X-Received: by 2002:a05:6000:1864:b0:386:3e0f:944b with SMTP id ffacd0b85a97d-38bf57b75d7mr30613963f8f.37.1737921129007;
        Sun, 26 Jan 2025 11:52:09 -0800 (PST)
Received: from localhost.localdomain ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7bfsm8982919f8f.35.2025.01.26.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 11:52:08 -0800 (PST)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: shuah@kernel.org,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH v4] selftests: tpm2: create a dedicated .gitignore
Date: Sun, 26 Jan 2025 21:51:33 +0200
Message-ID: <20250126195147.902608-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250126142250.839019-1-khaledelnaggarlinux@gmail.com>
References: <20250126142250.839019-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tpm2 selftests produce two logs: SpaceTest.log and
AsyncTest.log. Only SpaceTest.log was listed in selftests/.gitignore,
while AsyncTest.log remained untracked.

This change creates a dedicated .gitignore in the tpm2/ directory to
manage these entries, keeping tpm2-specific patterns isolated from
parent .gitignore.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
Oh no, I realized there was a mistake in v3. I wrote tpm2/*.log in the
tpm2/.gitignore file, which is unnecessary since tpm2/.gitignore is
already scoped to the tpm2 directory.
All entries are automatically relative to the tpm2 directory.

I’ve fixed it by removing the redundant tpm2/ prefix from the entries
in tpm2/.gitignore.

Apologies for not catching this earlier, I tested it after submitting
the patch because I was confident v2 was correct, but the issue was
introduced in v3.

Thanks,
Khaled

Changes:
v4: Correct the mistake in v3
v3: Improve commit message (and introduce a mistake)
v2: Created a dedicated .gitignore
v1: https://lore.kernel.org/linux-kselftest/20250116085929.313677-1-eng.khaled.elnaggar@gmail.com
---
 tools/testing/selftests/.gitignore      | 1 -
 tools/testing/selftests/tpm2/.gitignore | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/tpm2/.gitignore

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index cb24124ac5b9..674aaa02e396 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -4,7 +4,6 @@ gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
 kselftest_install/
-tpm2/SpaceTest.log

 # Python bytecode and cache
 __pycache__/
diff --git a/tools/testing/selftests/tpm2/.gitignore b/tools/testing/selftests/tpm2/.gitignore
new file mode 100644
index 000000000000..910bbdbb336a
--- /dev/null
+++ b/tools/testing/selftests/tpm2/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+AsyncTest.log
+SpaceTest.log
+
--
2.45.2


