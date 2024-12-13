Return-Path: <linux-kselftest+bounces-23335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04949F14B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9A016293C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADB1E47DD;
	Fri, 13 Dec 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMcjDWjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FC2E62B
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113357; cv=none; b=luQD3uwX8wzLJysUQl5jzv0ilNnJJ+zhtLUTNkD/mzcsrsqMsGVyF+gltmpW0mezcQdt770bw1MgUcf4RNEyf1JMJAbaYyzZMOQo5TaKFCbHxcD9mD290itjc8LAY+JAc6c8lQMm/On3TZll8tCVcyXDTKnn2+1BSA42rkEAp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113357; c=relaxed/simple;
	bh=2FkUQMX1Wz7gCMohsC4is4/F6UOzBSxDPYQwoMWH53A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nT1nQMmyBMyYMgkMEVHvhZAdGUz1rF6KVdXrgBC8EOYgYXNpzFXT0r5b0Lpg0kRE5P+YHxLYQgZI6NG88RBq/wWkc5nWIKSmlDfaZe0IDpIFAJSHh9JRZ5N16xNVS88Xzhr1+Qt780HQ6i0QOeL5Gzfn8i31dTqqLbAlASKUDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WMcjDWjC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso1376801a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 10:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734113354; x=1734718154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHvnRBAgWIA4Hg5hzc9AixQBc9yGg8x7tmWobIWOu2Y=;
        b=WMcjDWjCn3c9amKhFuko+wJEhS9p8mBaBcqfjbwIjyXHalGRrygjW8C150TGI1/W2R
         psFz+/9bzl8acM/XM+EK5c+pS91SxBJ4zs/8LlA96UhNfnTtl9jMfOEA/X0j94pPwXvQ
         /bjsfZhMmrxL+SBzKcFZHXNavbvvNTN9P2P9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113354; x=1734718154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHvnRBAgWIA4Hg5hzc9AixQBc9yGg8x7tmWobIWOu2Y=;
        b=kL4GRZa4EiKnecKaksrRJg08p1eLTMTtxGrSAoo8bJy2eyi0H4D+OmqR/mo1YWUUVt
         EgBzW+HaRn0xz/D4SILrg/iTm9MVAWAzojxrEb2+vMyDCEqYAFwcmJ9XIrhTe7i2AS4g
         b0cfrTC9Rmaz3lwvcrGuH8Aa/rNtw6sjb5jOhI5Vz4p+zxYRZr24zPIoezVbVuqOtOWe
         WYr2sLyRUZ/d7ajFCiYNAC3GZ4ckkcqeOSZ0BBS9OwJSGFGieLx+ldDUQmAfsd9HUbys
         CoS5qQxmwT1d0Us6lu/7u2f5gaJ0hybVmazFktvqUl0KMZiwEvyYdNjcDfjs+/tRSrGo
         MNgg==
X-Forwarded-Encrypted: i=1; AJvYcCWWgeGbtPJ8GZ4Zgw5ZInaq0oVeuhsLTHxzNj5A0u2qh9CiMzF6o0nc9GJL1yDnm+kDAzPQW/80IIc8HCK9oJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm1xF9YjJS7JQ3gYM96yPaEq9dGj8YLwMNQ3XU9fgoovMnruS
	l36Uee5XmFI7Qf9wcTqi/P9ks2fJHebsG8dRiUiMbw3iNAH3LbfONOURtRBluA==
X-Gm-Gg: ASbGncvztNTurShk5ROCwectEuztpek8TVco1YCrtpPkOP01iqn/VNZEDmVWJkaGyz7
	49iWNwdbsLAVUEAoGTYDnjoMsT1/wVGDYW++02glfUpgBmGAIKmoRCSqW0OoJy5NINQsq09Xdwj
	0C9o67UDPobXzJDIXgL0Pgp5YmqBJwRQMVJVN2YgXDKZJVm65XiHXG6foInTQfDGwpx5IsmIZfm
	nNZODjidL/Gb9bsEZgeMJtuSMmZSaAsQz0F6igUT2jEf98JEmaoLmzmh38IL7g33YQRwduuCdOB
	vtDVuuOAyZf+7b8vTw==
X-Google-Smtp-Source: AGHT+IG1HsmkzaKGdsmHNaYqVpdfLznabnEnuLB97sA8uGNrKH90vnL20KSruZDKaLUaHNEBxjTn9A==
X-Received: by 2002:a17:90b:3d4e:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2f28ffa7efamr5275060a91.27.1734113354488;
        Fri, 13 Dec 2024 10:09:14 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:356a:489a:83c:f7d9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1db8676sm646005ad.12.2024.12.13.10.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 10:09:14 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Rae Moar <rmoar@google.com>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] kunit: platform: Resolve 'struct completion' warning
Date: Fri, 13 Dec 2024 10:08:23 -0800
Message-ID: <20241213180841.3023843-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the <kunit/platform_device.h> header is included in a test without
certain other headers, it produces compiler warnings like:

In file included from [...]
../include/kunit/platform_device.h:15:57: warning: ‘struct completion’
declared inside parameter list will not be visible outside of this
definition or declaration
   15 |                                                  struct completion *x);
      |                                                         ^~~~~~~~~~

Add a 'struct completion' forward declaration to resolve this.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'm not bothering with a Fixes tag, since this only shows up with new
tests I'm writing.

 include/kunit/platform_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
index 0fc0999d2420..f8236a8536f7 100644
--- a/include/kunit/platform_device.h
+++ b/include/kunit/platform_device.h
@@ -2,6 +2,7 @@
 #ifndef _KUNIT_PLATFORM_DRIVER_H
 #define _KUNIT_PLATFORM_DRIVER_H
 
+struct completion;
 struct kunit;
 struct platform_device;
 struct platform_driver;
-- 
2.47.1.613.gc27f4b7a9f-goog


