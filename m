Return-Path: <linux-kselftest+bounces-47216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F861CA9A6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 00:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40927300AC4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 23:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FB2C159C;
	Fri,  5 Dec 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnYfcE+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317A296BDE
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764977698; cv=none; b=OfxYNz57PBRZoSsyJHvzxUuHISBAii7lxhNZ0zT/0sdGABQ2RITIWBJj4mj8dSLQ39Cht07bGq0qrMQNdYS7eUfH4frIv+JaXEbNO95gh+vLH2wF6fMnrnp40TJ/sUmeiQA6+qZY05q3mjcn7VAJzXgFkjTOg+IHVBrAb+dBcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764977698; c=relaxed/simple;
	bh=LegUog4riieq5PJR7R21q9XuidaxQ598BdrezPIJ8dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKfz3VEvyqepPrpa1fQzv3iBulyg/UueX8T8hG0dsPFYq06gWluu3nOMzfJ/AaXqEd/szvGqaZnRcZTuNpWb7WSDXsv1Th2ITsYigj6LY5Yq/8RtZ9mAbllUUUCjcsWUklSpriEHRJ3ZZfODEknFi8nMuU1YfpMJDTwbrJd/1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnYfcE+1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-297e239baecso26773185ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764977695; x=1765582495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YtOthTcpxsgOunObs0b6492MTrh7TVbwyYd8tMWCKXs=;
        b=hnYfcE+1IArhhr1IL0Y7LfFEzRdMASUe+q2pp1DKdYilDzSlxbjpSgR3Q0s386UZU/
         OhuUO+oVaUBfXLnNl7VQvwWglN1YT8mdWViKD0v5E/1lxjww8xSD40p9Ith/dhqRNydH
         9sGZtUeR22pqvX5LZoElEm1d1yU1925lc6qQ6aCLia20AagaTzAdXWBjPsCues10ZHgL
         /KuM3l0zVUl70l+4sbH+qBHkkd63yXMHuLAgfyUrmOAF3zd134H1CD0Idi4XGzeTr2qA
         01yBmNUYJ98cQrfF17TTo8IyrlSieSLrxcPcTIO/FKxbJUOPXR2gEy/77hsfM4xbsqGy
         8PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764977695; x=1765582495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtOthTcpxsgOunObs0b6492MTrh7TVbwyYd8tMWCKXs=;
        b=I/0wl9D+0JJj3F9Sie1itnRotXe8ChLfTqhg+HCmDahuHuZdsWK+5OUGpV4p8UE8Ym
         jbCXTpwFLvut0KV85QqPwnz1TkxADFlNX3NO3l7eoBTzn5GSgoLWZzsTCoMlOjFIkqep
         OI0dNtVJlYXBwgL96fY4kuWayM6KjxFPTpxKhHwZqXmFYc8XJTnN5uXEzbLzZ6h45Nm7
         5XCLmUrFe19e+ShgBx4BoAZUI3L0bokKTdjpgvKPe3qGGkVa53//2kON4ICfoAOXjy8Z
         wjO5ILDE9H5PPcZTQf9nSZZIJOwG1QYvgILQ7I6y+v922ePJg/L8d4w5pAJvX7ai038C
         18QA==
X-Forwarded-Encrypted: i=1; AJvYcCUXcyRROuoMSJayO5yl6SBxgHAL7ovO5exRgfAbmjUX3BFrPoxLa/i1Lk+A5BAZ3lwvh1XqDu/K7Nf1WVywNqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCo1UxZToeENq/XZYSVg+HqpvTWa5OMNJMp55HeQxm6IQ1Sbq
	DJrt10ZTYNGQP99Xk9eEfXwhmV2uFinqBuXbEWvCQBk7/4NEnG3JHUtX
X-Gm-Gg: ASbGncs15erjjcx5KIK2HIe/MjutiPDGElNn4p8bn5H1wEMUJ9k4FeTeYIByXYO10Eq
	lWcBxCuTluaj69tST5M3GTQfW2OKk/0Q7VkALg1xg9Ha2IcGVJdm8cgn6lamF8My4dmpEV0gIz2
	UL+49DPKJPBNyJXUIBVdozv6VwEGFENL54MzgM0zIDacutF5ITxIH8m5jpwmhIuw+llEj3AhA4t
	owsrpCXD5fJYDFs8KSbQznjfJbxmBD/vmZJs5I1QmdkqTXTIB7xwNzAP8SJre0B5e/jDeGcC/vO
	B0724Ntvo7ZGbcEGh52tSKCmcEh6PRN/41ubrIUmYoWjUdH4LjFXnBojFMKwTqeiB7b8MDh1HqI
	IPiWpIpd9M9iiLOpp6UACOasB7E441q/qR6jFAjQv3cnumrVvmhPcmzdNDa42dk+GJabqjcSni2
	+piwhv6nFsbfh3LlbOTRZ0l2W6YrdiYSFZgQ/j2gmwuQ==
X-Google-Smtp-Source: AGHT+IHXNRsf3kgiQgCBIx3JMSjH0BWAqlMFSj7gjWJeyX9CQlqiuOJmBQylDBmRwFO4TMTA/+QkQQ==
X-Received: by 2002:a17:903:2f86:b0:24b:1585:6350 with SMTP id d9443c01a7336-29df372bffdmr9061835ad.11.1764977695327;
        Fri, 05 Dec 2025 15:34:55 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8839:f626:f539:b6d1:1913:1426])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99ea20sm57597995ad.49.2025.12.05.15.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:34:54 -0800 (PST)
Received: (nullmailer pid 792713 invoked by uid 1000);
	Fri, 05 Dec 2025 23:32:18 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: shuah@kernel.org
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, katharasasikumar007@gmail.com
Subject: [PATCH] selftests: zram: use bash as script uses bash syntax
Date: Fri,  5 Dec 2025 23:32:16 +0000
Message-ID: <20251205233216.792698-1-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zram_lib.sh script uses bash-specific syntax,
so the shebang must be /bin/bash instead of /bin/sh.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 tools/testing/selftests/zram/zram_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 21ec1966de76..16b108db450b 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 #
-- 
2.51.0


