Return-Path: <linux-kselftest+bounces-26188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EDA2F263
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065AB164374
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554F822068D;
	Mon, 10 Feb 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB9ddyo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4F24BCED;
	Mon, 10 Feb 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203314; cv=none; b=iS45xCL4QGu3zUjV3qGE33i5+axdwdT0pQTik1ngnSOcMrPT4Sn5mIHzVmuRpW+GPwCkLwrwY11kVHjSgamH/1AcGZr069Btc2TBJFeLgXFmCSiGoXsxkA5rReEqjxL+kPoTzc6XI0HK+doYCrt4RDAqXl6JkebSroNWj5SJ524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203314; c=relaxed/simple;
	bh=d04mA6lPd0CGIRyghuiCWsFhyE+RnY8D1tZKu88Lkr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qU1qjJo/ggcwyfPCJtOBfpm1K7Q478GD932ujU2ZMEDgNKdQ01vKlV97kIpUbO2b4zUv3aJ2xWXDMEkoBjKotT7yNBQHz5SMvX9U9cDh7volomG4IChP09RjgiVrqkOPVzTGOsK0n3U5k7XhZZRPWx5+OSExj6/ndhc6I1diIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB9ddyo1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f53ad05a0so51076465ad.3;
        Mon, 10 Feb 2025 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739203312; x=1739808112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mAb94V99Y9qFdn7g0fbo+3BKlPjASY28rXSeC7/ya+k=;
        b=EB9ddyo17JdFboNzvAE7c9ROcNuxmDJeV0syb/qeNRFWPxfmdio4rpm4KFr8DLbfHA
         A79mWobo9A6/UX3RY95P1i01vgbnD6fBAoOprkUlRnfxuPelbeSrBXSBcTpO2cz9alhI
         y7GBfpOuqC4XZec4rragGdIJWEwWex3S+rqq+vHUBp31W9DUNlNbEWWi3bTYHtbXJjH/
         iVYyMRxqD9GQWiIjQptA9/K+w47UfeiYAbr3H1Kl8xZnLIdkW7tplYnU/rQNJAhVp+qS
         d9faHKNA8DKq3QzXaYxjBqjDwkgvSLFOThQAKot/3GQtDk63hoGmT5EptLR8iwHReUPC
         Nohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203312; x=1739808112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAb94V99Y9qFdn7g0fbo+3BKlPjASY28rXSeC7/ya+k=;
        b=N2GgPwCBTM/o+v0WGvxVvztKgaAxQIAG2rdH32FkHI7R6CHH1fMTnwXZgZSLedBuek
         UfmJpX4odfxSmgK53f2Z1tfQichDMgWsVGz63tNl6uwcoztv7NIESxNwp+WfWuTjeUXZ
         xYTHdHOG0aBofFDUuw+VXGz2PGyIUWfWGpYSexGV0gYukvgvNKCO+c8TgNOylKgy6vrE
         3GQuOPtZbb4AgmVv9zX3inqoLjEHIRhAUMK2FBELShpSp4fhoPTScZDkCO8FYbzNA16M
         SRdw5dCbpSA8kfw2J/uz4e1tWGNUFkmsZwaztOOLfb1BrJ75yGBUIpNXxGVnzNxdq/rE
         dotg==
X-Forwarded-Encrypted: i=1; AJvYcCV/+aKx81Xn93IP3ThngEAaghnryi/3olIq633IYuveocKGrHAk+rqj8tyMqSKDNC1ELMJp20kJpFC1HY4=@vger.kernel.org, AJvYcCWcg9/dLkajJC7zTFC95tKx5RdwRcYkrL1kMvHaTEbm5BIpWXSWVCd5OSR9PMGS5BBwJwx4tRnGae2ghuX6EQtd@vger.kernel.org, AJvYcCXqlf+V4vJe/mDFz9vazzT57KG2CslyF1GVG5N+Q62qm0cJgQVNAtJPE3hRoYMD/dz7L42DOxb6J5BN52WgLiW8flf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9x/qHRngKociOoNgugBErDzMHRXGzhRBRw88zAu5F++iMXYMR
	T3I+2eYzHbK68ME0HD3IMlDEWOOZ6w7CzCywUD4OYy5dnNhhir63W5ahVOspSbw=
X-Gm-Gg: ASbGncsB1kAXXgwrvTgSAAueFN0CWv+Y0wGyUdwPxZcljF34IclujLFMs3fNiZLphjK
	syAaEQ6r8WAtAOu63IdDSixw75lWVNhssnQeA0aCfrsUZ79z1FWxrW5EN7S7R1VlZTeojybMX8/
	e3p2v7QjRj0oQJFMRaqEoDyCd42h1za7mgMtLxKx09MaEmZZJ9kjqzuwH7kr8QS+fPQ/9CWGCc/
	9nV+EdoC6+Umy4Y2C8wyL9xPh72W2P+nxCYNeR7uLFwl7VmFKZ9aytQPUj/lR/bazL1XGIvmCoY
	dCKYaKZnQ4y9mF+/oDuVQpQ=
X-Google-Smtp-Source: AGHT+IHNkp+rEp9mHSOGY+8yQobNqm11WwyMA64Pwjfj9ER+mP9o2/g6xc0Ppw8iqqadRsvrdcMKnQ==
X-Received: by 2002:a05:6a00:f8f:b0:730:7d3f:8c70 with SMTP id d2e1a72fcca58-73217f951e2mr204190b3a.21.1739203311941;
        Mon, 10 Feb 2025 08:01:51 -0800 (PST)
Received: from linuxmint.. ([14.139.69.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730962210f3sm1464566b3a.179.2025.02.10.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:01:51 -0800 (PST)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
To: rostedt@goodmis.org
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests/ftrace: add 'poll' binary to gitignore
Date: Mon, 10 Feb 2025 21:31:34 +0530
Message-ID: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building this test, a binary file 'poll' is
generated and should be gitignore'd.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 tools/testing/selftests/ftrace/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/.gitignore b/tools/testing/selftests/ftrace/.gitignore
index 2659417cb2c7..4d7fcb828850 100644
--- a/tools/testing/selftests/ftrace/.gitignore
+++ b/tools/testing/selftests/ftrace/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
+poll
-- 
2.43.0


