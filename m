Return-Path: <linux-kselftest+bounces-18634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CF98A305
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664982816DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE214197A87;
	Mon, 30 Sep 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwsvyZLl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B6194ACB;
	Mon, 30 Sep 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699846; cv=none; b=nwVslxtNaSYBB+mNLbGgNCkraGhhvmuIxJ9Tmvi2OpKtM5MR2ne4WQbTDFjB/Bt0v6J81leEFx7pzGWjEh9Uh/suYBNPTEjBDo4QjZA59ifZsINGo2UsQXRtuf1gx5zdNP4TOVFbfoVzVi/ygi6Fea1eXDRqt1tcJGl36aobiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699846; c=relaxed/simple;
	bh=JJu+OF7nvH556mNrn6dxRrj4224B+N/1bzyZE9wGUE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQoguGie9sNxhFelwJvgqNBY+WI+wtNSrB0Sw2uW8IUOClcihbCN8HUEu2ZfO9r2SKGBHAo29rz9wPgq3NeqdbzzcQktUmsMP57gUE+OYOGj68XKN85BzjJB2cr8CH5f6xneowaLz8+fAIgwv0JxqhCkd11DsEYqOBXnaNaUksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwsvyZLl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so34225115e9.2;
        Mon, 30 Sep 2024 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699843; x=1728304643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfE03GoB2dUE0X7JHaqSm0tKtFoPw6ruHh5YI8xKL2k=;
        b=KwsvyZLl53N4wyMgkKbc0hnRVxuUfYL8hxQfBKwSKM+aX/vvSz/cg+GUHW7B7yZk7N
         l75ZYFiIo94jt9KR3Y9LxmOgvZWzgkx3c6F7uopEpgj/NVvKN8Uwj7v2sl5Xuuw4/ESw
         unGuXCkz/Yty2mz4mKdrunLW19v0ZVR14nKIKqMxNvRQRiwAoHfAGjL23doPR80bC8LW
         aPx1hUYdy0eFPcRZsMwSxlAN2/JULNwichRuux3vuAw6mx8lmVXgM3EDPXSJkeXc7TTZ
         AqQBEFDIKqo4jT3GSZYTKx4GUeQL12Rhi7KqS1XBINqKGbWZWdKdnG3Lxiwx9lytdd2V
         LInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699843; x=1728304643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfE03GoB2dUE0X7JHaqSm0tKtFoPw6ruHh5YI8xKL2k=;
        b=c2lcdXuz/Cte8jsGQrVBB/ObvXBeGPvKGq0TfA+5ohc0JE/uX0Nqlxjv1z7UZavnx8
         KuRyAF3MXDv8lVf+xGuoA+DZ8G34tV8lf1j5GSTDjClttsJG2Giwk3rPNIJKvqOx75GU
         3+IgKyD8VwfNQy22YZpHV+EwuxY47puaEPolhYqW1QfIVQiTOZ+Bus++s232h5s6HKjr
         yYTEzECTG1YD0w4muN3+mZ9cwGZd06X8sAnEJe9/04rZ/BrmyVNTduaptmpM7NXacMLn
         U/2bGBlNOvR8Eze0CI60pJcf6VUksK3hNO8g5Uu5WqjHV6w75fU31JvuzgGdWWj/onEC
         sZKg==
X-Forwarded-Encrypted: i=1; AJvYcCU8BfTSIaIFEAOwHgrLaTPXXezBqaacaeEutNvXVgakMJQ/98cUmGtvbaYM+L2JTb6qP/cNUQ5WBoHoUUjftkOd@vger.kernel.org, AJvYcCVw9o/GzV2GwZaliT+k1DQEzdYbyIejedkSUzWZJ9XoHfuaEtkj3vzOCJ60o+zRhOM2vAGwzbhAO5K48g==@vger.kernel.org, AJvYcCVwRWuZrzQLFxEkRU9pCtbLvHcdSPBv+ltremiMgqfn/U6M02a1U9BM7bKCc+OsbHHhasOixcXx5wHd0loAWA==@vger.kernel.org, AJvYcCW5kw0+VQZncexQhBeBP1cIKp3ZxMb+mvp0Cf2VdrvnSzKs2OQ84tu1XX0J9nYI2U2QOCT4606W7tXCLZc=@vger.kernel.org, AJvYcCWfOByzrGOb/HYU5riUvzAu8jbrTamitXtjZoyw3YY4ekT2iGQ2yZMh81caZOzDqUgzevcxwZAu2JjJUYAY@vger.kernel.org, AJvYcCXC+hIEc4JMzjsKn8edP6sckXsRv3sfV4GgjhrZL3s8oG8JTSteSEQlwJhoWrB0I1Rsj10=@vger.kernel.org, AJvYcCXpLPL5qM7xP1z0pnKxz6Ly7ELwJZ/JypK72NPMvE/Aq+FOT08VcDqMsksnzFRGXNW7bFcYoVs/rZLsatNj@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVLwI8BMckJ+lBp3Wrk3QRPxlAStoTzTQAvy2soZKfPz6Vd4j
	85dfS4vRVmBdI1vzakyANjQRfldN7Z4GfUzF7eTwDugu7/ygCXrQ
X-Google-Smtp-Source: AGHT+IHyexJvOjpRbo21AjAs38QcS8a1X8lQ/VRW02l+0t4b6bl/r6U8twtDvjQga2qNTvuV88EQdA==
X-Received: by 2002:a05:600c:4454:b0:42c:b58d:98ad with SMTP id 5b1f17b1804b1-42f5843312amr86700225e9.14.1727699843491;
        Mon, 30 Sep 2024 05:37:23 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:22 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH v3 11/19] kunit: string-stream-test: Include <linux/prandom.h>
Date: Mon, 30 Sep 2024 14:33:22 +0200
Message-ID: <20240930123702.803617-12-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <linux/random.h> header to allow the removal of legacy
inclusion of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/string-stream-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 7511442ea98f..7734e33156f9 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -9,6 +9,7 @@
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/ktime.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-- 
2.46.2


