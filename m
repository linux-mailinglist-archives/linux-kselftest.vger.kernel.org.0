Return-Path: <linux-kselftest+bounces-18628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785998A2DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A05B1C22A7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC55191F77;
	Mon, 30 Sep 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO7OQX/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB0191461;
	Mon, 30 Sep 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699839; cv=none; b=f09SoUhJsjIApT7fng/tDAxIbZ4NVF/+9yTcPw8lMRay0+4lcwkBtzraTzLUBBHLBa2bjjvzCqNJZ7lDW7rOHdAQDJ1AAgdzk1PaJSzDgoTCV0Z36nuooIU+memE2+Lz09y+WXfusMFqVsKlBYvA2xQ0EK+9MxDQrduL+JG87lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699839; c=relaxed/simple;
	bh=eyqLoQ6tOjYdsem/GmZ7tIXtJ+3/koGZ4orrV5NEPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbujs5AfWdkrOPNZUy5iq6d4RidWrqA6ui4/u3YNpL693v+vJ2F4SuNihnqSxkeaEBAgRfWXHVrJ5ZBYGw4Q2USL2FNs/XeeP+EgDx07YdG6nejY84nr5iME704Ng7VaAwj2GxSqEyjw8zyuSq8fAutO1b6rTwaTM1dA75WQ7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO7OQX/0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so38166385e9.1;
        Mon, 30 Sep 2024 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699836; x=1728304636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOB1xBCChyVodl1AKBCRn0/gjY8Cy4B28eaNVB3ngoA=;
        b=IO7OQX/0SsdDZ1ZuwiJll2oosoI4/usH/okcapDpOfjGqScRZSTjTVEcahrP6o9bty
         YEQBOjLId7NQmqFlxkti0hzvfCuz6V5q/HhDeREpV3S6fGeIQ0+xFyG/Ij4KySoqrmvM
         lfemPxWSkSMu1C6uiXkIvZSpQtTHLB7vjZDjDJ7lFsT3SRa7WfdPq2gRcm096MJCx8GB
         Kl7eaFGvef/3aRub7G8RWdxZLH0LgwALUySz/AJquDEa9yR8V+MnIThI/1Fb9HLZ9IU3
         aa6UR+SLiTpF/NGu7XGmuTuYFYB2YKtqumu0zNQZ0GbZfk6nuGoWkINposNCpEjdi5G3
         0Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699836; x=1728304636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOB1xBCChyVodl1AKBCRn0/gjY8Cy4B28eaNVB3ngoA=;
        b=LtvUADDuzMoJqxy4KDpX9WpUVo4+VqtCVSq8kB9DQgoxHNC7gJ4/VyeuqAAA5iAAZ5
         3pyOLZsHXy6aDHkn1tRRPMd995VQdXWgsUgc3Dw7XgNpHzmwUgSDu0vuGq+T5wd+Hing
         tSejwDrk5kWpSOWrkr+1W4gm/+1u2V/FgDgDqJ5+ZWBbJd14fAiVRun1jLlenKvGMtlG
         RM7qnbclhcdLgSJIkQnSS5Zr4fr3nSOa0bJw6j4X1NFg8Tt7dDXWMyMl3eZsV2rfhrRQ
         IS8BeO3t9rd68N1EBSi2j7ewQMIN9MszEVq99ML2d43ULs0eCEXSYRQv6VVkqPSp+oBy
         Bjxw==
X-Forwarded-Encrypted: i=1; AJvYcCUV8FI7PB0S0whRRUW/ccfkM+oi5MQyKhuNHa6pm9yOwFy19cLwQqXfpHktqwaGWBhT6xF6l6TK9kP8Y1ztog==@vger.kernel.org, AJvYcCUw9aebcf+UjlcrBwUC6ubai1ZethUi7KA+kjTr4w4EbQkedwxBo3wKYK4XUCsNX2/BB34=@vger.kernel.org, AJvYcCV4UnBu+nezVh+QZSU0tnnVK4MH8/QhdwcmSCfN26qp9g5a/yjt2fRNF3Cf/lPKCc16kB0Sb0tfXAFYc8lM@vger.kernel.org, AJvYcCWmAinVtDgo/HbCJw6sKnT7VKHYF5TExYgaui+VO1WPlmUNacAxJDHbJwycihvWef1IGWzPyrAbCaGqI4X7Bz6/@vger.kernel.org, AJvYcCX2df2puRwKM/jnPWx1apNOgQE9JdXCXgdrg1HBj//NpWVbGzIkDUNzy9Fnxvg/RBSomtWALZrB1sASk/o=@vger.kernel.org, AJvYcCXDRdYdrbXxHpmqekNXLckvhY95rSyNuEoVl69LjEmsaz26poWJ4QfxLmSJItiAdEFGEq6iTiWwT7DzzSPc@vger.kernel.org, AJvYcCXTHuQmcoKd6w8Kd3mFP7B+DkpL97qghoXX71ff+ezhhkOeci/yXWeHUffS5M9kNy5AZCbIm94Rfc/IlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPUoezsheRACyfyyx5HvuHzi5SA7P0ph/FqrqW5zWRXEmOf1p
	dDVMwNjxTB6P1ChwtcNt+xC0APUNPyt2ha+RcV6kV64G20ZIZB1z
X-Google-Smtp-Source: AGHT+IFX7UFFJ9mFBZg+bn1buBc9cHhJrMVxmqzrsXfLIQStfn4WgdL6i0BO6HCbDChBmeLhRHv16g==
X-Received: by 2002:a05:600c:1c85:b0:42c:c073:412b with SMTP id 5b1f17b1804b1-42f58490786mr95354705e9.30.1727699835819;
        Mon, 30 Sep 2024 05:37:15 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:15 -0700 (PDT)
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
Subject: [PATCH v3 05/19] media: vivid: Include <linux/prandom.h> in vivid-vid-cap.c
Date: Mon, 30 Sep 2024 14:33:16 +0200
Message-ID: <20240930123702.803617-6-ubizjak@gmail.com>
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

Include <linux/prandom.h> to allow the removal of legacy
inclusion of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Hans Verkuil <hverkuil@xs4all.nl>
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
2.46.2


