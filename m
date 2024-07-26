Return-Path: <linux-kselftest+bounces-14257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A893CF02
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9521C21D49
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F0176ADC;
	Fri, 26 Jul 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evXtY9a8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8F176ABF;
	Fri, 26 Jul 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980117; cv=none; b=KiKdkw1IkPyPXIjyo1lbAauYb1UXEwvVmqNtcrOTUatFCdiFSR5yNKXQe1GFsgKqqVzU51d/8zQJNByWDE1FCxJ8mNt80zHxbLwJsRXbBojSGTrQI91nu6YsPUEwEC+qGQJBKzUQmSQzvBYZx0UB+rvkWeLaNQA7Sy+HNk1doV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980117; c=relaxed/simple;
	bh=RyXYZ5QuAAFOvEq/qhzksJVX3wL6uAk3n/km9KCSwmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZxFlJCfq8KXJHuxh1yU7cJrZHqxoCAf+GMtXWI490LPHxfUpNwllhUzLZqSb44s2jKqXb+fASWLyfNY90a321uK27tkYKM6K8t4RJIg72rD1giWbCSmDggx2wcO0kz8ywj4cwJMJEr0wB5277P1rrs96YhGEHd67pDrm4uuN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evXtY9a8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427bc3877d0so247785e9.2;
        Fri, 26 Jul 2024 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721980114; x=1722584914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3ZPDmVWLjWhKhKsVrc4fZVrBDNXbTw5ln4Ps2hRYao=;
        b=evXtY9a8cDn9uthbon/OyZ8jbcIjWjt9D4DaIy2d9aFUipFzPEGnnJ5Jck00A1p8qV
         LpuhoGSirnHMS5VO4az8WTvy6ofWBjersMwWjFTzRHLg7FysuWo1d/FnPPUAByn1JCc/
         sODInzdUFsb42hcy9LHNgg8qm+sIyZ4jUig7Z5t40EwDIDOkLRKa/HrBgZx3R/6k0ha0
         98VfHWKeZ8GJXIo/q7zkXf8JjZIkWDrYOwiBtXVtoDkDH9Emdp4TVOmKzF3rpfXhbKA3
         rmsWNt5K1/iJyIRzE7G8EdpKWf4FjvRzg6LF6ePYolq90CMDnRBA1AvE+Y9aGvRpaRGm
         VC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980114; x=1722584914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3ZPDmVWLjWhKhKsVrc4fZVrBDNXbTw5ln4Ps2hRYao=;
        b=KUC+hsZ006NnSZe6Ojk/twpPdKUDQlKRCFXWppgIqFOC9JpwPIdUyMClF533Y9R0Xw
         zUmo33MthjfNqS/J6DKJG0dvEgkXLHXIRFtakgXu4cCX0o19wBLkZ+lfQnjKRTHNs6h1
         KGviL0WW3/mhLk7ZhnNVzShF7n7pCh6oK8/HTWp3GS9wlnA5scaqlaUCI0/MZ/XAEYPV
         dmCM8i6KiaW56dDyALMdb2usq5SI710KbHy9ZAMlkhGozDSGJJeL2iId19ZEUAhlIziq
         5jICjPXeH70Q3DT5Rz2wX5EftZIu+TtCiyYRwHsGLG1ICG70ktMe17JYYdy0FZig+Jgn
         ETWA==
X-Forwarded-Encrypted: i=1; AJvYcCUoFruWmbvW1U+cda/L9fj81lDghHfiy8h9qY1wqUbCdnEDo0Yd3HUGg+AZpRIJ5BIDiw1XqUhIrXURujS2Zgtz@vger.kernel.org, AJvYcCWLnsBLvyDyNWXKWByNt71h2lWeHpEar3+VVTLlHxFMZz+mdjBDjpv3N6Ajc5mc1PwLX2mdPbta3+WutOE=@vger.kernel.org, AJvYcCX2FKIha+xd+6hzMMjAQwv2tX/5x9o9ccCcYJ2h5/+/GcF+LojLs6KoZqXoU9R/5UJCOAAZ46HlAzkZd0Af@vger.kernel.org, AJvYcCXvrw01I+0/YLa9RlsUhAPZZffCmpk82fR/Quxy8s/CS218N+nF02sk9O4KZ+3DrOm32ydoKObxDNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1V2rp1b+xJNW5d31Nr9lam4HImwDoeCVINS7U7nAIKeaz0rqO
	AxrKT5/Hhx+QO2h6fpggeZDo4tbIzi5eN3C1nyNBv8ssd2WXL/Ou
X-Google-Smtp-Source: AGHT+IEqatwM1w3KZcvzLDclV5shF2fYkW0yLzRNU0E6Jw9gEip3iIGT/6cKrCfn7amfB6FoSO520A==
X-Received: by 2002:a05:600c:1c2a:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-428053c9004mr20537075e9.0.1721980114113;
        Fri, 26 Jul 2024 00:48:34 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:68e5:11ce:4d88:9958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm66045565e9.38.2024.07.26.00.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:48:33 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aholzinger@gmx.de
Subject: [PATCH 1/4] ALSA: aloop: Allow using global timers
Date: Fri, 26 Jul 2024 08:47:46 +0100
Message-Id: <20240726074750.626671-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
References: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using global timers as a timer source when card id is equal to -1
in the timer_source parameter.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/aloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index d6dd4b8c750a..a1e5e7fe9c72 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1130,6 +1130,8 @@ static int loopback_parse_timer_id(const char *str,
 			}
 		}
 	}
+	if (card_idx == -1)
+		tid->dev_class = SNDRV_TIMER_CLASS_GLOBAL;
 	if (!err && tid) {
 		tid->card = card_idx;
 		tid->device = dev;
-- 
2.34.1


