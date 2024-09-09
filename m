Return-Path: <linux-kselftest+bounces-17477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54583970F00
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC0F280FB3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F21AED55;
	Mon,  9 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdFmwU4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB61AE020;
	Mon,  9 Sep 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865708; cv=none; b=Ff3bBltGaCj9e0PeKGxYmPz94uTMNSwcKqOCMtFVE53lXuXYd8FXyo/Iqq3KuMOiQmHmVT/7P5v7y86+wIBiEYLSXrfM3CfHImJugtZQKqAzF1olLitGUH753XudKkm5OHhgDumXBGEPEcfSq8sK+/2WJ8qPaPR5n93vZ+JvWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865708; c=relaxed/simple;
	bh=wpddSH8CgrrnijZ+uLcfTgyYpsCBrMIkPpRqRwmdod8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu1VDyFYIeoJkWtpZfhVjW4D2gARiF7b+chwGxmiIuSGH6C1q3hOj8uMwRCeGcdqtZ08efdlOqeflf6Y9okA/Whanq7FCOeLUdnT1PKuG3zWEa+sR77eQwehbhygR1DDN0HjNpR0vCiGb1ZhaC8bK1aKuzbfdkY54luzgQEdka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdFmwU4i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2573559f8f.1;
        Mon, 09 Sep 2024 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865705; x=1726470505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShjJx/ObaG+8g3GTS0ZEXmep/OHlf8GgKk/3WiVwkKM=;
        b=ZdFmwU4iWnkmcCTkFH47hDoWKHElU4B55/Lw0KBjJVcJpXqHxJnsxzFWi6lpYa0ZNJ
         /UzPjKoBI6J8upXYOr+hVRgqzev3XQUMTthmR19agACcuFjYrGgWqbiaY7Xs+iYvAOXV
         IHhp1wWev/zAeTKV6jzq8SxO1tIlNq1qpNlr9RsnWs+8cU2xeIo/YFLJAVNtOP4XJi8C
         UdOqDG6F2tIP5dxgfnTpzR2/y9Jb2LM1hLRq2BHM9Ij7OH/zO2SD2KpMv/TDU6RQalxU
         wbAn7so/QzTVxS3WoU8NtfP7qar7TqVp7QEoXoUfa3KicmW15k+dqszR/GjX0RtcQS9Y
         8JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865705; x=1726470505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShjJx/ObaG+8g3GTS0ZEXmep/OHlf8GgKk/3WiVwkKM=;
        b=HWIE+9nL8y35bgNCZ+h7Yk67XlcZYP9Rw3ZsZCNESgnKY2kQTihiGP9xOduJZv5q2V
         lFAFg9kl2lYRCTzcy8LhKIpHLer0ciOyRjMeBiWvpJ7E6ewL+KsYoYfysudqTLi9d+9o
         mRdxLay0W/vAVswx9PRn/Ph7Bh8I0MQin39F5aRNCp2ou+znlU4tClMcSgg3I2ui1/W0
         h90vvK5hDBrYfTTcltqp9gP65mtbPQ66qt9vsJQrOgXB7094BXwYRaOf5E2vnt/NDk2l
         n2i9dh0vfbSqqniw46x+1GzWokfAKW9OxShy1nAapM20JflKdX63fiQ9XC/XtniwsRL5
         bnZw==
X-Forwarded-Encrypted: i=1; AJvYcCV30QPOhYVj/yb7VPAzWIZ3NxNQ0fF1s1l1PVh3WLVD7//8J9qBnRGxzNIRFUx66VkRKdc=@vger.kernel.org, AJvYcCV5eJOyswZzN96fgixyk87PvRr69f58WuMubmneTknw1ujdRQyQ4VPpIDcgPIMlkf8Z3mXP3XTQy8q8Sg==@vger.kernel.org, AJvYcCWNWKuSmkWTojyX6VB0KEYjM2yQkPuBwh6keXr3xSIWc+CZMZxLLy68OhX6sHD1gKqBa4WJ/xnZpg9NF0pDJw==@vger.kernel.org, AJvYcCWlJlQbKdGwJ7fKHSHKsNWfERCqslGkW/K7g25cawKA53ki0gXJHU56ql9Zhxq5Eunl6ZSJAS1XazSGtIqF@vger.kernel.org, AJvYcCX5nkjnpHvdyX56GqNopHz5YdIYMLtkd8IhTeStmsl+WPBz5CLKeSyy0swpqpsuGOdZW0Hf/+GVYZum8WY=@vger.kernel.org, AJvYcCXqk0h0pTbsgSJqbpStUz1Lwl4bRdYNNt7Wijt4WXv8I+wYLT9oF2QUNVfPhIzNgFqVG7jCu9jCNnp2LVlwQcmy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17+qEbgb/2eZY7qJ9kW0C5t7PUmw8NxUU0BAW/kw/T3y5bOYH
	wpongAgcDx0gdeP2U4n4FkDUIGMy6eA08KmgYicD7ncRh4FwGz9V
X-Google-Smtp-Source: AGHT+IENAg1lx4hzfxdNZ9tmKUR4RCTP87aohUUWb/KE3Nn7ukR11EcqHzf0iJoeJH4fmxJ9dQt47A==
X-Received: by 2002:a5d:5c87:0:b0:378:89d8:822e with SMTP id ffacd0b85a97d-37889d883e2mr5832530f8f.27.1725865704068;
        Mon, 09 Sep 2024 00:08:24 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:22 -0700 (PDT)
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
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 05/19] media: vivid: Include <linux/prandom.h> in vivid-vid-cap.c
Date: Mon,  9 Sep 2024 09:05:19 +0200
Message-ID: <20240909070742.75425-6-ubizjak@gmail.com>
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


