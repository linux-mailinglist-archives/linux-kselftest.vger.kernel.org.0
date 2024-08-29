Return-Path: <linux-kselftest+bounces-16694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC8964A32
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1299B22B7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA91B29BC;
	Thu, 29 Aug 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1K5VNa6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1111ABED0;
	Thu, 29 Aug 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945857; cv=none; b=NSKdDNAPVGtE4Bs1OCsutaXXR+CgzHQxfK60Z05nSiCysJMA9pxz6+fEyBpjaYFvgEHeSn5oRgb77Gf141wR2SIxRIsGVTO4BJuJNq610agPSFYyDuAPhCMirSVGKCpdwY7+gR+hemNz5LRxJ3LmE0RempCP6APqW7B1atQpYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945857; c=relaxed/simple;
	bh=T0u5+oR/BpqoaGspu/4xBJLdpo5Xvxd6/fCGzCIEfwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbGP06QhfOtSeXSoTjkl/YZ8Bs4tqFMYrh6SwFYTCBLh3ViSjU3rRN7M1HfzYWheC+5Ltv9vfjhJ+WdHKxhwNIkyAnev9ZWKjL4nZ4rYg7sVmZqpnKiIGrJ85/HilxLElgVTdCatG5fHrFnFgJvJ8Bva3zzp6SwkCwQGeno+hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1K5VNa6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533521cd1c3so961948e87.1;
        Thu, 29 Aug 2024 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724945854; x=1725550654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UbF4CUGTXslSbec+s5bw0o6sUxeMU4qs2GP41PtKuc=;
        b=l1K5VNa6jrUqaB6gEr7knNvGXAtMiFjGplVB/frRgzSgm0a4ZhvU7dBdUEUEaW0LpV
         0EOuH0NTbIyXJ0/MD4Y36bskQG42Uhym3hVL7YT43aT79QGcHK//GNuPzwPxLGXeA/+o
         QDxYWLhsgX2UGp8Yh4KWnARPa/gbmle5m4Ui4Hrrtbs2N2braZx8gBmvCYpGvHAahFjb
         xefpKa8XtsjNbhsbAMppuyEF5Tkq/dboFVn4HQo3wxJmNUrrdWukpoRQnJ7Tmvf0d7Hw
         iyIgG2wjjgVw8VAsIVfyEieExVIpwoTfOuIQmm4ZvuTWEXM4zR6w03LhMRjGN0e7VfGP
         7VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945854; x=1725550654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UbF4CUGTXslSbec+s5bw0o6sUxeMU4qs2GP41PtKuc=;
        b=H2gyBQowCFthZ8KfylbhHLLBaiDZFcvbz8AyblNTTv0y/YovKP1hDbBQen83cCmMiG
         +Lq87WD6cb6JsZuEAibafYHDKq95YAo4gHmdjCRAh2lsGy3U04WBJMQvl2yeuclR+rsA
         TLm5DrHVlx/6RK7ba/DdryFNH8/TBXOhlS0bU4ZY3pUkXr6zE3KUf/vTMUv65SLYxI6h
         SXYNd9s+mydx8nxF8UzuZwKTwIcW+4RjheGx89VLWJaTLo21gJxrTG/iZsbrTZgEoSAj
         DIciXDkD9xpoUvCZrVlO7rXAJP3VTeH9fYwBI5FR27ikfOfGXt7vRHHLHfTPmDa2e3pH
         f3ag==
X-Forwarded-Encrypted: i=1; AJvYcCXv47mlvrLSPXAgmXNzAw1MIGvVAvig2gPjEGZaWVImag2v433+/sYvQWgy2APPUDiyhWOLo9EYhSjfxvNhIyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PSP9bfLSVltPt6yEhrtrs4U9ZoRBkfjBq89Y32VR/YnpBVbe
	Q6ln9IXEKq9e3U/63GkdhTO3R9Amakz3htBd+EYRXDyORmhRfG4M
X-Google-Smtp-Source: AGHT+IGaNerhPoYE5abob8UCa6hgrud+3rhaakBcnovvAjz4HkFzVnOojhwyh51XiVolDC5OTVsAEA==
X-Received: by 2002:a05:6512:1581:b0:52e:976a:b34b with SMTP id 2adb3069b0e04-5353e54d7fcmr3385587e87.15.1724945853671;
        Thu, 29 Aug 2024 08:37:33 -0700 (PDT)
Received: from gi4n.. (nat241-51.uni-goettingen.de. [134.76.51.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891966f2sm92191866b.101.2024.08.29.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:37:33 -0700 (PDT)
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
Subject: [PATCH] selftests: timers: improve timer_create failure message
Date: Thu, 29 Aug 2024 17:37:25 +0200
Message-ID: <20240829153725.4437-1-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <877cbz9x8t.ffs@tglx>
References: <877cbz9x8t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

improve timer_create failure message with strerror() function
to give more information to the user.

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


