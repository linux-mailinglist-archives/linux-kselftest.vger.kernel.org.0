Return-Path: <linux-kselftest+bounces-16683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9D964834
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655DE2878CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9C1917C6;
	Thu, 29 Aug 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVs5bQmA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D431AD9E0;
	Thu, 29 Aug 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941528; cv=none; b=cEgWH2H83ARH9vShpNQXSmrEtkVHpsZVbSpmI21v4nGRaZiQhlUi62GLNfREY2o+iXD52aBUqyiXXd2QYbhm+FOSX8zHOz+A6eCl4Iyg3S0Qmc+IvU5Yv39lAI8FTLOyjsb+Ym9tZb4peSwpKW/I5DZGdAyyBKVyQOGgZNXAmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941528; c=relaxed/simple;
	bh=pmpXx4w9dxou5IsStm5ec7v78pKORIo2DWzAXHY4A5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXdbnYkm6snCJwh9zR00B4cOD8+jLDZGz6/OMV1IspkIkhOv9PR8FYgYli0L2vOHGDlDvskvhj8qNwQCOmbIukl5Iy0ZgqULArPO8EaUBv/kb3/e9g5G36gizB0GPMfzR8dSCL9hUkaGtYC582Yoqa4O64LZuEV2saY4PjQZGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVs5bQmA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a867a564911so84898866b.2;
        Thu, 29 Aug 2024 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724941524; x=1725546324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHIamUgRteSKTv9SPXNPrLb0bteIcDQ+F/Vqmsjb9r0=;
        b=AVs5bQmAwlR/3Dce6kFmBfZt0t8b1GRmDjH0Cdt0PCzJ6987U3zFFwRNM640Fk5ISM
         UEiMGtUt3Amy3P7u1mEJedJxKDYu+qgQWzTecc3R09gh8lICkdNCyUbuFCRTCliXEBjC
         +lby00l1pw2QqvzpvcYJJmYFKthQCNQF/mLk7IUQxKgFkCJVNDPWZaNZe2UHfy9Ztqid
         5Gp1PxbdDseB72LmpGYD+ubKNRKWr0a0UyKaoDZ7yUorgNjzwpeFmsJ77ZGO8J7pgyfy
         5c4zzGmE/AYdpAGfqU55POgkytPYw7TbJMwhyL83gQRmchyqJ7GxK3I3bjHM32SAvu76
         MDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941524; x=1725546324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHIamUgRteSKTv9SPXNPrLb0bteIcDQ+F/Vqmsjb9r0=;
        b=IIMVW66jqU6fiBP2Whlr0uMwH3IdeIFsPKiDimGUTrMpWvCCvFE8hT7zdy2g/wzCfF
         h818XX96rJ7diBM/JE10C95mkcOLTF+5HC5kZWWl+ixsTNIzMrOONKhCznwqbFznDw/l
         JGFx1kVbPyuuu/TrBP+VodyqAvK5e/H6c5lOm2jeoLZJC4AYVogroT+W5RF0xBQrPZfB
         EOqoCbLLpzppxsHv1Krupy8XWf/CAbam49/BdbGqfjOT1RF0Ls+ipTuFjo5VU0qeWpc3
         MUXVdUQnpFUfYi+pDYPWKfNGHyJEm/HjJqAbiKDYmAF/DxUu/Us+nncN7WXedOrF71S5
         HlKg==
X-Forwarded-Encrypted: i=1; AJvYcCVFMTZNa4gOGQAd5XrM414t62owelTLJn7zKIpZkFWLOpu//TVAFmcSInUMM7p6W7QF8G+WkNM2TtKruGHyReA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyronOSvzYNTp2Szswev051riC/Ong5Wu1syj/rvGZAlHdbwZUE
	vTzFSWJg1W7/gSI+7wxJDhtjz97t0yVKbtIdiaKjieicphJRBO3W
X-Google-Smtp-Source: AGHT+IEso7NR7+70OF2jSG2lmed0gLupdrNT7UPyH4N8sCFANVEgU1M5xJwyO1HHGwLAfyS2m7BgAg==
X-Received: by 2002:a05:6402:50ca:b0:5a1:c43:82ca with SMTP id 4fb4d7f45d1cf-5c21ed8c755mr2655750a12.26.1724941524265;
        Thu, 29 Aug 2024 07:25:24 -0700 (PDT)
Received: from gi4n.. (nat241-51.uni-goettingen.de. [134.76.51.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0cfsm85710066b.8.2024.08.29.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:25:23 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH] Improve timer_create failure message
Date: Thu, 29 Aug 2024 16:25:15 +0200
Message-ID: <20240829142515.29773-1-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve timer_create failure message to give more information to the user.

Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
 tools/testing/selftests/timers/alarmtimer-suspend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index ad52e608b88e..74acdb87d4f4 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <errno.h>
 #include "../kselftest.h"
 
 #define CLOCK_REALTIME			0
@@ -142,8 +143,8 @@ int main(void)
 
 		alarmcount = 0;
 		if (timer_create(alarm_clock_id, &se, &tm1) == -1) {
-			printf("timer_create failed, %s unsupported?\n",
-					clockstring(alarm_clock_id));
+			printf("timer_create failed, %s unsupported?: %s\n",
+					clockstring(alarm_clock_id), strerror(errno));
 			break;
 		}
 
-- 
2.43.0


