Return-Path: <linux-kselftest+bounces-25338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5786A20F5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 18:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00F83A545E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5231D79B3;
	Tue, 28 Jan 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBpY+mbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EB199E94;
	Tue, 28 Jan 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083903; cv=none; b=YAV/xlPMx/lLrzMH68e/3CnPgM4YEKogsoA5hX8+nS01qenwjnsFRXbr5G/sbSrAjgmNZ3Oi3wpGy4THNQiazfvMUrVwFzraNgCfvwA3lEeMbH01iMTYRQKiTT7+bhd3sKgrW3JN5qk4aiJz4N4f6SxssxZMp6/E5854hJ/50g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083903; c=relaxed/simple;
	bh=Wr/1I+G898/ah27+A07VtLsk62kB2MLzTXyksQFb72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MUdSyxhcdOge3dAhhmbPEW41PjYCjiyGvR3iU3XBjkKcpS7VCYejT7Ufx7VWA6vR/32FF7umsbnQDAIotpQxqpdmcy23vlRHlN37VYfwdzYFL7A6QRFcaWgUUk9ciDQ6uB67fIkTpA17bzQENfUAtpA9WfpYQn1F0GtkG66Jdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBpY+mbu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab34a170526so972316166b.0;
        Tue, 28 Jan 2025 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738083900; x=1738688700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQEw6px2lCQ5X1Kh9g3VLttS27Rym9Ujzc+OwxmYg=;
        b=bBpY+mbugz29vHc0zW5AuS+3WW42LpYWi/sn5wAu8TvZ7cdjTTuMNuFXcPttP0vEeO
         88BuHb1uc0ICRdg0l/cAtTKP2l7ODDQmboGOBYz2CQZ2y4vFn47/3fuaeNgGof6My3ew
         wMiiN0uVf7GQuxqTmudi6ieFI2RsiYux71wLAIXOLwnMIY/zYNobKQ9sVNFec/eKNnh3
         T8JJqV/5jaBE8kCdaZxcql38XW7ceoYtf/Oq1CeYJVgQ9sddJWeoApVWWiebE1sD3wkQ
         x2f6ufM/QMrdqXQrZb143aWieuBVj6qwgfo+knIQKThbv2HKQNg2KOsoXa/JpDylUye0
         Mr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083900; x=1738688700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpaQEw6px2lCQ5X1Kh9g3VLttS27Rym9Ujzc+OwxmYg=;
        b=j616DBL5K25R1Jd7C1XamyaeNpak6XPGlqK+z8KPy5hmg94im6C06hF2wr1Bb44HwT
         tYLk7USlD3fjIpmLD9xGUP71dwcX5sh5MVrnk0Cl5L4Ron18qfDYnWQ5ZBWaeCZtx/GM
         nHMwi64OKRBE0JCHVfqczm9BxpdvJJDLmcOPOL6R50vJ0ETiSl8Xr6wJF5Z4oeH3IgF/
         SrHq8TrUk3LzMkKzjjqQgRUXtHW9vPIkkTCf3JXvYTK26zpQznP9rA8iCdT9oxBd/Wc7
         pN+sLvsXtbjIJXJIzX92gfc8aJIEZAg95C9cYsZQZIcpXMVgbKG7VgAcPqmUcL4vTLjo
         4bFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTlP9sO4HZwT2QYoyguGqoAEUUf018YSSlQ/3vv4dMgg2QYYNyDPsjIzkRNW2GHRYpy5aVg8L1iJitAw4=@vger.kernel.org, AJvYcCUYXNiUUgtb6/ULwaFqd/wU+S6HMgACa83pHYnSb+QHTau19tC4Nws+5O+5dZxFjI4BWNEwwaZZ+yhC+VJ+BLC0@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOI+cEfc9XUaxkhn/AA7m5EbvGhThxh8fWQgC3uWeHOnYzWF5
	dhPv5BQJdhiGuD0wM7NQMMr+Dk/U0p4kLTOc2EkTyncQBmnYHA/h
X-Gm-Gg: ASbGncvAF+3yA/hx9CHM5BPOvvgfnZLhDVWdmecbFpNmokfrKXHpjYRQZVAAnIbSe2c
	WnbQguiNIlduqsHH/x/O56vJEz+VLWXYFKcuWAqt2c3R16iwVk8emF2jlAwpib+JMqSNyAO+gLk
	QnjEUvP7gUoKEFIN6ys84Biun98hIf8AtT7fHwXtoTAJIYQNxKN8OmMCbMmcLADUE0/Cv7hoC7V
	HY1/X5QG6dAATEYc//hyBBrI87lI8v7PVhrcSQm49oqjYpBZfD4o+DQwAnIrRhMYEyLhdmukCeF
	9kbihdHS0eylB/Gc/vcdykgKcYHhEzfRVMI0u1EmS62gdzyctzn5/eiMUcsawXXh8zlL5U+Pw+U
	=
X-Google-Smtp-Source: AGHT+IE9/sfw7NX6MhRG0HT99TLmwcw8zjfeAUOoJ8NsXXfFwMAHIr70no8jYSq81WmEDHydU0/OEA==
X-Received: by 2002:a17:907:2da8:b0:ab2:ea8d:83f4 with SMTP id a640c23a62f3a-ab38b0b9c4bmr609408666b.12.1738083899459;
        Tue, 28 Jan 2025 09:04:59 -0800 (PST)
Received: from alessandro-pc.station (net-93-70-85-39.cust.vodafonedsl.it. [93.70.85.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e631a2sm804426766b.48.2025.01.28.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 09:04:59 -0800 (PST)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: pid_namespace and pidfd missing include
Date: Tue, 28 Jan 2025 18:04:45 +0100
Message-ID: <20250128170447.12918-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Running "make kselftest" results in several errors like these:

pidfd_fdinfo_test.c:231:36: error: ‘MS_REC’ undeclared (first use in
this function)
  231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);

pidfd_fdinfo_test.c:231:45: error: ‘MS_PRIVATE’ undeclared (first use
in this function); did you mean ‘MAP_PRIVATE’?
  231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);

pid_max.c:48:9: warning: implicit declaration of function ‘umount2’;
did you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
   48 |         umount2("/proc", MNT_DETACH);

This patch adds the <sys/mount.h> include in pidfd_fdinfo_test.c and
pid_max.c files to find the variables MS_REC, MS_PRIVATE, MNT_DETACH.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/pid_namespace/pid_max.c   | 1 +
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..972bedc475f1 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <syscall.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
-- 
2.43.0


