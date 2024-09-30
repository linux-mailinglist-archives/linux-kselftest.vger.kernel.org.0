Return-Path: <linux-kselftest+bounces-18635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F498A30D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF94281A93
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17134198E71;
	Mon, 30 Sep 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ14KJ8t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95A191F6B;
	Mon, 30 Sep 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699848; cv=none; b=GQCcfEODJK6NrriJ/h6Nt9UXmp2rktJsxGf3wU/8Lc3LDleTwTA/nj7cXTmzTWemdMkC8fMx80L4LKNj3v7nNAQsmaYRkbn8YyLJib/UHCR3ZpCryuYLi+yb+K7azuvDx2Fhzvx2lalcFyiKbWXt4QW0VzYEYTfQivKsgzFuLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699848; c=relaxed/simple;
	bh=TnxJ7456fb/crPWa44UwwdFF4YB0raIJxHu5KO+ICGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7m6F4dQOs+hDwBZiwjZ/g2/SvOY/Nll1KTjK/1Inb1t/1fAXlz/PQY/AgTWjkIwhSMpLjYuzBbYvCdVdCaY7zZ5JhXqd0BkYV3zTHLnfCcJaD2xZcUFCXkN1z0JBlFYot2fo8PtInQ2IIc6dj1pLomz0nXNcE6/iVzR0ISUPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ14KJ8t; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so31427465e9.1;
        Mon, 30 Sep 2024 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699845; x=1728304645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrMbRs6ImQWe+o4vD+CgIqmMsoPFPKHQYE/g1FviBLg=;
        b=MJ14KJ8thz/At+LrUIyMwALVmMGgXF+mLjVpZee2lakCO7sPfIJlY0lj31gMP3Hb2B
         gYFSJFdBlRoq/g/MKb7u3j57HDy2BgItcN/oqdQlp5XvMmSD2qLyGppjcowJISOXzHUi
         SNQdnsbSjTa0SZMcoLsadJ2XB/PhMxHVv1sbPqKX4264vYuv7RrcuWSqkZSbhmwDb4G2
         0M9+sTCL7qwiAY8yxa300SGAu3egkRujI8+jijpZG4lIfeJZFlO21ZPTBztxrNZbm7of
         PmBFyjPBIPBiHmuoajJ61/QdUON18Zh6cPAeFxIRhLr7XxXRjwtv7+MWPMQuAwc2MFZj
         GNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699845; x=1728304645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrMbRs6ImQWe+o4vD+CgIqmMsoPFPKHQYE/g1FviBLg=;
        b=UlLoU7vtSEa/Y4a4LzBKGj/MAYirXlcRqBF9snIK+pRrnCPp0vvNrU1ubF2Tn/ahUf
         SNUkJdqVa1MdJ/vDAOYPST8BXBEDgNm9+hp1BdwvvwP9t/Y0VffU4AXK5nX0bPdH9DC2
         xema54rMYvKy3jFnE9ROxBmjG5HBMIJZ6+1SiVohnUiP9aUAV5HvuuTxf6A0I1HOq4gz
         RjhG0U5Sx3NKQeDCZXrxFdTvxaSdcIiasf7VjShGtPwen/kawuVLzfDAy+mm/DkdYaI0
         dZae1VDtTV6/KslwN7KkqBaFP75TTixTTf/aDPjd6KYJ3/Q63JjFMdcSJEuHCnv+aqL7
         wqyg==
X-Forwarded-Encrypted: i=1; AJvYcCUHCmx0I9frUIKLzbozleIuGT6I/aNKFXbTc/hNlcdxH2vIO1XMwssi1+9/qvxLW23dLp2qeJqkPwQzUsSW@vger.kernel.org, AJvYcCUVyg/aw2M6FtEu9kaGCeoU/DSA97VY/0a6/Uu5ks+E9W8FydNu7SubSIE2Z55nV+2JUkrH59bZ7gFk3vZHiw==@vger.kernel.org, AJvYcCUlIor7K7ALbuH1CedLSF8qpK4SJpO8/4vX8oFWukA76jx89GDnnJ2gVaDy02pFj1Em2kQ=@vger.kernel.org, AJvYcCUoXppyhipatxa+mFzAzhF0dSoc7r9e1sGPLYD8P1NjJV036xIvNIgLqaSIm7yd2Yit9mbeY1lnIO5aLps=@vger.kernel.org, AJvYcCVI/7ZLol7fqtjuE+2f7TviLztafaSUPbLjf6GpTqydLiN+NWtxL6D0qJ5HCtPx0jO762ZhsVTLJBlfAQ==@vger.kernel.org, AJvYcCX7pOpujqcEQanagqs4aDR36+p58/O0+ouVkEpunIbHfN52gCrhZmT4YC1bq8fW9fb2D4suuRPITPEk8jBBkwAz@vger.kernel.org, AJvYcCXa/u7Csk1ns7jYjSqqhzu2Hnuzr2l4/ysDJGSrexwkAlCSRsoSqthBUnbKPyBkjxwu9uPtstG97UhoSEZj@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjdc8x6WdfOfmsgwSw0Ho9w8AxFAdr45O30p5hyNyIKDL6Edx
	y+4WMUQSkZzZxKcY8Y5yayEtJPvjcntX3E6ky6yh17KmlwbSkAqI
X-Google-Smtp-Source: AGHT+IGTpcbHJYLBsw4P9dpJsKy6t/gAtufuejfRIApDiA0V+yz1rvy5JdCXyTqQXYKOI2mgKeAbTw==
X-Received: by 2002:a05:600c:4f96:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42f6ded6a45mr9817345e9.15.1727699844581;
        Mon, 30 Sep 2024 05:37:24 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:24 -0700 (PDT)
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
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 12/19] random32: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:23 +0200
Message-ID: <20240930123702.803617-13-ubizjak@gmail.com>
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
2.46.2


