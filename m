Return-Path: <linux-kselftest+bounces-25732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33729A27B4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A141D3A0796
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83F2046BA;
	Tue,  4 Feb 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyapDHwZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56E20468D;
	Tue,  4 Feb 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697448; cv=none; b=HiclbeTeKN36e4iGIrnrj8L8EBzf6G0mmufY8/wrgd+VanGFpu5BByRvkFEqLrAtdEEGhG/ZW/SjXYxlrRrj+GeqsVEQM9yjTpnntmICUfYmDa4ZvFMzZM08FHc6KwAQ/Qhi1ucCUJigZsJpnqBiFclBOhjI6LA03VOB55tHJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697448; c=relaxed/simple;
	bh=QRi/T5xfMEOZk3oIGOMAugQt4TWXy+5skoF80xv/d+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1pOHSfjREJe+W65TKXCh6aOgpNH3sCTU4oQgkpH+VzTp8swti4YOzfiRYelZuUgEI11X9WuvcdijVFn5NQ36zgC4GYtJUHD/vKmKq//m+NwK2iTaJx7qvTqfVpYtqXzXTIESUYJhtm+C8IKeMgDCJ8JklWt2gTBhgkrXX7VukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyapDHwZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21619108a6bso101414205ad.3;
        Tue, 04 Feb 2025 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697446; x=1739302246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9p7f/7S8Mq/vOCUyI7c0pQCu7LoiHChjA9JxK06JEGU=;
        b=TyapDHwZIrEEsynsRcm5IRZNwIKOoee0xsV0aI/UboNhlPEgBWyDK/LCZAAxSHuR0/
         s4aixfmjCkwPbK5zaqTrDsdU6JdMoKUk84l8QQvdSuVB2e2x1aCitYlzH15a+SbaIgpa
         a4JDbKsx/ybQjy3X6UqKPDMDI1keh57+tPcsqDeF6DkIee8EMlTuRMYmTepFw4Tkykan
         hyZ6GsspHAR3bknuNNNjcP9miCdWGKrUNIxttzAQHfMxtlnvv05k1hm5DwGb10Oh9dRb
         NHYA3Q9J9h24UWJ8e4CiNQbNW+qRFiFGlzdgSZojIpadqo8J2OJz3CHuJcatN0bhIutg
         W4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697446; x=1739302246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p7f/7S8Mq/vOCUyI7c0pQCu7LoiHChjA9JxK06JEGU=;
        b=S+muev3fMd6mMOQPhWcbM12iMUlja/0iPILwsCjl44olObfM4jHDZJFaMy0xa1Enk8
         vbmBwc+FFCAypEBTrMdNcPBzQUtJeSfmLpdv5YxtBjHwcb1vqCInRHUT6MJ1lGizeDCo
         6HB2v7S3Ow41EQWA3YTDK/W+o4f6VWYQ9qjmKUHRmKS3tzkBp9GY6RXhyZnW9OVskTQT
         biaP0w4ZVDs7mJSEdN/eo99JT/0CDQhBf5IAd8F7bk9YrFnRZCgKm9uq7XJKHumRiX8c
         8nvRMwIuDdOAI4jumC4i/+9qn9tPIJ/1555EnXwejwoncjVAp2vIBMuWIxax6FpakJlI
         yy0g==
X-Forwarded-Encrypted: i=1; AJvYcCUHCJ3AVTPjtIA0uAA2qwt1ldGFHiqG7E1ihaYzIo9mteno1f9qD5pSJss7yKz7V8opCC9iANDn@vger.kernel.org, AJvYcCUXK90/9FKoQ68eeKaJ1lnqEKBVjujAPmveA+0qKu3i9XHRthzR2BUb8IJnu80PXCta3JuaoxnOuc3HqaCB@vger.kernel.org, AJvYcCWcC6oZH8zlbgcl9rBmepqbpmqL/WAHbLY0piJ1EgiUI8RzYI8g7iqiWgTB3/dFpBSh3KtStCCGHqXRqoT+RTQz@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7sQJMil4ylMbti+V8kERrFhbtxiJvUmVGPToMngjFfGPYzyc
	uUlfyYgUt4oXgmEFJ1Uy0i/f9z/U2PKhHsZWgtzvAJvQ72QNEDJd
X-Gm-Gg: ASbGncvntJA3zRWOskahB+8ofdeDT0SWeqpITbdMr3/3Wy+Hvar4ifVhMBx9w/Y5Gmc
	1szUCkbJZ7bwiojD5uufhfpUFIM6A0Nik1fKMRXx5GReG2r+eqA+29zWp5wwD7NcQ1FhLMCuHVY
	+VicAKrVzeVN3PKime8STpAkHJNpyx0jU59UAwLtBQVZYs0c/ZazY5UkSxz1bixMy0aMq6KFyL4
	qEFHU25Y/Hs8GyDZ/a8IhWBKAD4287/Enh9wTS+j3TQ+Yrr/MlbhvCE+wTGOn9PedfXKlAFNMev
	mye/NztmWdSUZuZ+nb2r3Kg=
X-Google-Smtp-Source: AGHT+IFss3YQDvyBHuUGLZCmsbSK26AFc7G2J2uzLww7fhdhbsF/F7HDhh5qLRL5YNkla4HR2XlTTQ==
X-Received: by 2002:a17:902:f78b:b0:215:a97a:c6bb with SMTP id d9443c01a7336-21f17e27225mr737675ad.12.1738697446330;
        Tue, 04 Feb 2025 11:30:46 -0800 (PST)
Received: from linuxmint.. ([14.139.69.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f5c72sm100994395ad.66.2025.02.04.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:30:45 -0800 (PST)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
To: tj@kernel.org
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests/cgroup: use bash in test_cpuset_v1_hp.sh
Date: Wed,  5 Feb 2025 00:59:53 +0530
Message-ID: <20250204192956.50589-1-bharadwaj.raju777@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script uses non-POSIX features like `[[` for conditionals and hence
does not work when run with a POSIX /bin/sh.

Change the shebang to /bin/bash instead, like the other tests in cgroup.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
index 3f45512fb512..7406c24be1ac 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Test the special cpuset v1 hotplug case where a cpuset become empty of
-- 
2.43.0


