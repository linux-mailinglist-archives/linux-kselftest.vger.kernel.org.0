Return-Path: <linux-kselftest+bounces-17499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477689710A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CF41F22DA8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA71B3722;
	Mon,  9 Sep 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+5s6I+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A151B2ECC;
	Mon,  9 Sep 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868619; cv=none; b=JGOYsAcFOq8HKhh4w7MbxLsxYb0gU/XvJbEJPjGsTuHDPQkINclHIibD8RMNGn+OKDUxvDvt0TGyvWSxdZiw3JgDpIUne0mMIMScsyMzavpZlzpsfbq90eHEtWs/CuB3uwHfTbBo65seeUSHGmGU8WDi/d+Q5th2bBTYRMZW14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868619; c=relaxed/simple;
	bh=wpddSH8CgrrnijZ+uLcfTgyYpsCBrMIkPpRqRwmdod8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEKZHlqxvlZtkzsrsmHFjl5bLwzDBnNYKrlcFsTnq9eYMlxzvKbymbPQFgkrsk0yfEIHoWNsV5n1Ug8P2T6HdIQXuAQBrdYinqJjFBABjPyf3Ra2jlhtTtn/x+Sic/77bk+p5/r8UR90+KFoRbgYomlgdLza6RHHAruqHq0Kgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+5s6I+Y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbe908380so35748185e9.2;
        Mon, 09 Sep 2024 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868615; x=1726473415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShjJx/ObaG+8g3GTS0ZEXmep/OHlf8GgKk/3WiVwkKM=;
        b=i+5s6I+YezMIjWnbUGZgtRyTsGoxLNSxqkXJtFayqDPaA237ihaTM80z+xv515Zi1z
         TG3I4AB9Hg9+cQdlsxg1pL4fe6hBZb7XR4NicBlsSzd0RiwevGcwAU+wbjUshQMEF0xx
         AVk3MS8uadtonfDm6VeqmmuyfTEyDDgP7f9o8UhNUd/0WYPv/vnRtQVDQ2FmQIZSkZCl
         jrV6BDXQ4yt7RKZOI9SU/xuSCWVINsFMaaFFwAtoEO5dCFnz6rP9s/ia0rmho7J8i1HN
         2ssHCaqgHZSAXtCJmGwrrNXFMuRUvLFYUJdHRtWAbrDmxY6TlCuil8Yd/bIulNWC8/XO
         7oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868615; x=1726473415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShjJx/ObaG+8g3GTS0ZEXmep/OHlf8GgKk/3WiVwkKM=;
        b=Ef5jCSYCPQ4lHTkzBttu4GlIOcognGPVhV1JOFWHlUfFICLFSlT1cN1LLGXYpb6DyE
         NkRNUKajsOZDnG0u0q6GAM78RUqEkW/Qco/WcF5zXw0Iti5+NeIH2kQCKZUqjEDwI/oz
         BeASvbOIcyZkVlw5jJqcHeftPn63VUKJQTE0I4km6R2PNhzTdRMIpZQJqZUEAHk5LcAi
         AGb0PfHmXL8p+9YGEEGTki+CDu4fOrBAisLNrRTlkbngDcO+1yILkFKJBKkWQOgnd3vh
         ustvO4c2Okd0pzC9VQf2+NQXIoHePMVN98bvfvRsZhNd3PjOATAKw/58/9ZIVKUmmlKX
         4P8g==
X-Forwarded-Encrypted: i=1; AJvYcCUN7yIGRpaGcB7hRR6sc30LtCnx5C5oOGERlGt5ASXK1XOwjNJ4ueio5MNvz6UlXL+1/m4kK7GM4lKWYaI=@vger.kernel.org, AJvYcCVOcpXb7ZY1NK4Qcrx9h6foBAC2eaItB7dw17Qh0sVU631HMRTtZzIKgKYWJBKLGOqCAJjvEFp/L55sPeRi@vger.kernel.org, AJvYcCVQSyaOhC3vt9ycOaE7Q0uNCsRliCh2ca1q8g4rLDfpR8e7UJSzjSO3KleIaX8kYR/MpYG8GhvRlzqur+Ns5Fd0@vger.kernel.org, AJvYcCVWKWd+KKObSg4yyFAA+Ir4YbhA/ZLIS9vR1tYVBpyzewpohNo2VQMwB5Y5hPqUi/AjfHVBAGCCLUHdhK+X@vger.kernel.org, AJvYcCXP+q2szuEbl7CZ0H9Pm3jpYEIWY3SBU7NVHCVIl0OaHFywbWs9n9zAVg7KKdIO/lYKn+E=@vger.kernel.org, AJvYcCXTnx46TdcAAnDBgMerJPy7NNKssaXwC3TjENmCLl3I7dvbNdufHZnErxuVexjLEAcoEzGcwQzH06Ljiw==@vger.kernel.org, AJvYcCXrGAcHBFpRs6AXJ7k4T1cwtuUTHWLU4xRe7KMAyDsktVEjCWq7jmuecMvDXUFzSN1E2KY3+pJEYC7kCyfjjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpuwLcLBf2aW/iAU0I1QoxQIY3ISV1EJdcOVdxpzfRt7Wzx3I
	N+H86zIPs0cmWWoXR8VLQwgU9aGVQoFwL6dwXY1mpvu4HXjF0xn+
X-Google-Smtp-Source: AGHT+IHjtALJXHfeHvlFfFIGF/Jv7NubOC1i9OVehC29v/06Ma4HBUto2Yd3NbJZOwnM97uKL0s69Q==
X-Received: by 2002:a05:600c:511f:b0:42c:bb41:a077 with SMTP id 5b1f17b1804b1-42cbb41a1b2mr1246555e9.23.1725868614984;
        Mon, 09 Sep 2024 00:56:54 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:53 -0700 (PDT)
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
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH RESEND v2 05/19] media: vivid: Include <linux/prandom.h> in vivid-vid-cap.c
Date: Mon,  9 Sep 2024 09:53:48 +0200
Message-ID: <20240909075641.258968-6-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 69620e0a35a0..184460eb356e 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/videodev2.h>
+#include <linux/prandom.h>
 #include <linux/v4l2-dv-timings.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-event.h>
-- 
2.46.0


