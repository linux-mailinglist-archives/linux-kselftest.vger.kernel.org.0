Return-Path: <linux-kselftest+bounces-39350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57EB2D376
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 07:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8EE189D1D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 05:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA2283CBD;
	Wed, 20 Aug 2025 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsHeSpfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950542A8C;
	Wed, 20 Aug 2025 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667251; cv=none; b=msAkqMqWs3xbXUHl6RSSGsdar5ptaTYqf2Li4q1mEm//en8r8btXDmRvVBVYHO5YbIjanskFnV7o2kI6SrPm9Lkrlwol6AdbAUg6+Wumez1ROXLqm7D8jE+U/PqWNb0pwyYSWunk3jT6ZRoMyEuFGNLQFXWsKwUKqoQ6UgYfbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667251; c=relaxed/simple;
	bh=e7sGOYXv4pBHEJEh84R+NEKRrUcl59Rnj2qZC5guILs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZ60hGHoYxCkPIT3I0sO9R2VyWvol13SDN7CUrJsrdOqqqgRg+/IAQzoq9P5M3gms/+08dgqzIjfLjp2thWBcICvK6ITsN0juvfl677soKNklhxPHRF7T50Sv3E5tjpO1Ol/+VTrVcII/Mexf+iLTCcvipRYLmnw+pInbhTZwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsHeSpfi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61a94bd82a5so1410673a12.1;
        Tue, 19 Aug 2025 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755667248; x=1756272048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o323kJRY5rGGcUtY2fkwlyKrvR96I0AXwLWEB+2JTS4=;
        b=jsHeSpfi/vAuEQBwQbrM6oNMNXwJGQ2jl/NTCxTBdFDiyNKiSXVXayb98CJ5SqEe73
         DESTo5BK8HD5lGV4LaRGAAZVvfKMbbTwAnX2+BG39z63K5sz/o3tIKdARYP303tz6mST
         IEXL/9R0r/a8gDt1l/cG3+SPtOYggjpxx3xTdqjV51I/zrlRpjyugy96DdDgzH00Ff1x
         7iqSusxLMh70L6mXS8HGC655xc//nUjILUCg8EV5WSY9TqDHkRBYL+LhUMa8O58uCycK
         9ZNeHN0JceW18uE73fb5iFb62FLwobcOlHgPL4MQNdOIyoXq3R/uwQP6HBTQZCzTVd9G
         KnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755667248; x=1756272048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o323kJRY5rGGcUtY2fkwlyKrvR96I0AXwLWEB+2JTS4=;
        b=t7NbAhOObe6OCIiM6DLbOd9UUu3l5vkftT4WjKE/28b7/mSLMEQ3ZZ6rDrde0k4P0P
         p0PioaNzi8POOnv4ohD/8BVFh5GdDzFkYeYY7wnMxg0MM9odatD3sdi1UMwqRkTN1Phr
         IlkoGaayJba/tBO6c33IPNABmbaya82fisHc5wxTIJYGt8YRAViZ4kZO8iFMm8E5vGCE
         JRmBzDV3laQHyF28jJR8fWsw8HVPGT3XRS2iZaLIFaX0bD0s7lI3HX1qtZ+mdGGGp8yp
         3TE1/nlMh+n5nUN/n7Ya1yS+SdV88YYCX/fFNWgGLOEn/P4XFGxrXzwhMQ7dkYJz6MCk
         D5gg==
X-Forwarded-Encrypted: i=1; AJvYcCUEkFMjcp5EiftuwfPRigmjV7szPGPnBVUJovT/E2Ljfk65ADN9GTTudVeQ7umVAmJAcC/kSz8ckLWge79E2RRh@vger.kernel.org, AJvYcCWnw4WSJhu0k8IZ431iUtCQs53ddwmYElWXxKjgR6tTgiZfTpzb7Mmwx72QaeNNOzLSXM126cmunoy18OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetOP+w+y82Wpaudrg6JLV/9h5vbRBg4C1nwTpotuNAl0z9W4P
	0bC+RF/kcmn7BvGTCDlTyCN3Zftg6XgXn2IbNFRgo1mttvqJd87xqd6cz0xjiTx2L5I=
X-Gm-Gg: ASbGnctV1vCuOSLUo/BWnpoFJghnvsrbcAy1r5lqbJuTSGJUEvwXbctv9NA183RXmK+
	szhmS4i3GTeaDwUJBfiAZoH1fgs5FXGvX/nLzLwLYIcHJuCk6ht3vqWcUF2OQt/dFtGcTIdoi1i
	ya+TKKhGVKgrp/TLMa2efzOqryHIbc6p4ZfLPPr5xbKWRk0DYgpIbbd+SyurewvtSckFQnYfq4O
	BrcUxg9PUZvgHouI0jSzNj5flLwA+SueH6Tj8biyBHV9rDhtLCshl1PsNzYaLvf4aVXOyyBxZnE
	nAQBI1cLSR1Q34Mxe8qTPkMfp2c7YZIVMArtRmQYktFnVd1GOd8rPTHNsbbTBc5RESdJYIYWH5u
	kJZ7rCBcXa0BnBoLcC8+E4MUzAe9vaT0miQyaJ7uZCeC9mAI4VJ/uSOpYM7dAFuE5PQ==
X-Google-Smtp-Source: AGHT+IE8hW86398A6QfrTbp+PmyKyKF50B5zls28U5WgglVUukHsdsOBPXPzXd5fnCYPaY9NQg9tvg==
X-Received: by 2002:a05:6402:5247:b0:615:6482:7498 with SMTP id 4fb4d7f45d1cf-61a9786a5cbmr1403779a12.31.1755667247727;
        Tue, 19 Aug 2025 22:20:47 -0700 (PDT)
Received: from linuxlab.zamel.local ([178.216.139.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758c0e6fsm2927655a12.57.2025.08.19.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:20:47 -0700 (PDT)
From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
To: skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
Subject: [PATCH] selftests/ftrace: Split worlds in return string
Date: Wed, 20 Aug 2025 07:20:44 +0200
Message-Id: <20250820052044.130115-1-kubik.bartlomiej@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split concatenated words in return string.

Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
---
 tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index 9933ed24f901..47fd615a4542 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -110,7 +110,7 @@ fi
 
 cnt=`count_pid $child`
 if [ $cnt -ne 0 ]; then
-    fail "Child of filtered out taskhas events"
+    fail "Child of filtered out task has events"
 fi
 
 cnt=`count_no_pid $mypid`
-- 
2.39.5


