Return-Path: <linux-kselftest+bounces-17484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B52970F2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756B51C21C24
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45911B14F1;
	Mon,  9 Sep 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So3ZDNwv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98E1B1422;
	Mon,  9 Sep 2024 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865718; cv=none; b=pLx6epcioWezOqRe9jH38kbBkz0ec4cfmoUdFNVMi0qvW6GefdVdDsulBcIoL0WomqZskzDskQmQC8eDDLXr/K5Mryy2ZQvX9xK3uwAxvQ9TvFsYOcv0qBUpKhnmiMj23hE4vHG3uXvH/oHcumxTESn//QkJ6nq0n+L5V4XREPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865718; c=relaxed/simple;
	bh=gb0OfLUDlHD7TLliPPBr132d4LP07Ahm/gQRxup40Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipvevaN+zLletl/Rn9ZoPf9CvylPD0B25+xSykSIf04BOdC3Mum3gbVYG33j41oiKq2kqmqhlJiBsEvYwZi+OYkWsK1UbKWZwZ9HLUVcwxybsmFSs274mPOnR0I2riZfIjYRAMSEUxgD87ASW7XDSd1m0LxMe+6NppS4F4K8kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So3ZDNwv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so483445e9.3;
        Mon, 09 Sep 2024 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865715; x=1726470515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT+qqbFYGAtbtTrUYL5Ww6m96yHmU9B4q+0V5LkESPY=;
        b=So3ZDNwvsEF3qFC1Ek2A3+lBLq/yexDQWj/qu8yDvnAYOCarIzgpkQ3VTQE9JZYh8o
         PGm9RwtEDLCOI8/+15ZJn4c8yDMouix1GULlbg+sfBO7a5TFiJGLnwSMNV9+8R3NeCA8
         zcu/Q3KixcTfLnFp8XHGR6iY0b3h7By/1p1LbQBz90oRdb+sy4CO1eX0zI4sLDESGpzJ
         mOez+E68vwALGfOTSr4Ro9WTDCM229gTmL6nGDwEBdNqevz408Qyx91fzAycy+vjeFLx
         zbfK3p+PaFw3hQUdNCmavyKhxOqIyf3MONYDMKxDDnlYJvycIU9ko1FR2j2xeNT7cZDN
         VSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865715; x=1726470515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KT+qqbFYGAtbtTrUYL5Ww6m96yHmU9B4q+0V5LkESPY=;
        b=UhgomY/S+6GXhVUSRA3CA3HiCGPWFsEEtjjnaCtF5PII4oH7i9i2BqiRFN6r5h0oDH
         F2y+WriYwk1AqisNXQPqjU7o0FukRGcEtQnAre7KK3h6nYYVOZqsmgty+sixI2msBrGo
         jFXdfOMI87HBN3UM8RK1E+1ntzcaDKiPPpmZKvKURnezvVXSN8WXvF0DGZorc/JMd8IB
         NcQzHiXQ3pV7gON47B+MkSWVwiV4MjEO4m4q+/G9x59sQRVGjfjQsafq3H6ylk92h38y
         2W7xLyB8QuB6b9zxk7RPyg2NfiAvc4LUhwjl/zN3bhC5k+o1fVfz2vINK9HBoK24SQm0
         ue/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEWIUj4PDgx69e8rsgZcEQuG3BUvCvkJoHTh63txXii9FuZQHIfyOyKmmzUuDZ9YoeiLnpR9SzrIDujSfV3A==@vger.kernel.org, AJvYcCV4aReEStdG0gJKKH67papENW6S8DPh5rCXzlj6DlEOwVD3HowCzDxfvYBvSnEURsUcr+eAp58tcwMT0cD7@vger.kernel.org, AJvYcCVFs+vuLpu7kXxI02vHoZQ6SUvemU6kw4v084BzqMvJ97VU5/kE5N5vjZ4dnX3F0mCFC41g2PPNaZyS7HI=@vger.kernel.org, AJvYcCVupNsRLqBh5oqJQvbracgoc3HOUuuvpOAjXLGjiCjn9tX5dib1Jvv5aLAd4PdTYGighdgGgNRGsa/nZg==@vger.kernel.org, AJvYcCWVA879i27Xeus9peP77ZXqnH25lKRbS35MGuuNrONy6tqfHlZxBoj1mSa17OGrsWXXgv6CM9rKvWKaxEWJwQyL@vger.kernel.org, AJvYcCXCUJAaftrTFkD8AnYp/t5O8t5b05EgB7xSLPfJBolnIiqEw9LMcJb0gRo21u/EPLpUxEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjwirl7u87hMaZg9LSSfvMfudAkCje/FUHYXirCYl5lXLQiE9P
	7v6Zlpuq5SKRJg91GGJLt5HTgPUU5r9L1zv/yznKw7T/eRfxX1HF
X-Google-Smtp-Source: AGHT+IHM6W5yPkPlE3JV0r3wTbIThg1ONa11NIP8C20CX17/Y0zQWpFJHw7ZEl2cY8rMzCAWatYYQw==
X-Received: by 2002:a5d:6b91:0:b0:367:9d2c:95ea with SMTP id ffacd0b85a97d-378896a9992mr5949005f8f.56.1725865715399;
        Mon, 09 Sep 2024 00:08:35 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:34 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 12/19] random32: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:26 +0200
Message-ID: <20240909070742.75425-13-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 lib/random32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/random32.c b/lib/random32.c
index 32060b852668..31fc2ca68856 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -36,7 +36,7 @@
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
-- 
2.46.0


