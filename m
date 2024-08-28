Return-Path: <linux-kselftest+bounces-16595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00B963517
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 00:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0559CB25692
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E11AD408;
	Wed, 28 Aug 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4C/YIZu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35791AB528
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885749; cv=none; b=tZZWrMjwTJAWcl8Ni8UbDWPdG7tiyQ+bAbfy+HHO9sGWmvLSHhvuF8ZBuWyGok0catuTlX76Szqzb4wXuGZd3yz88AxbpXSXv/2SYMBwaX5oBgP7/T2+Avky/5cZx5BFV1kl/s2t+wN0T11TblJb1gkrIVRfRioxY/8Ke0TggRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885749; c=relaxed/simple;
	bh=+hf4ohtkAh5myzhnK9W6NcP+zJsdKnkZdTta6rNYdTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxeQbh0Ro6ZU3BplJf2HOIgekusqamj8DFAlKdYwJoZU6K4wu8T9B3XU4zxe5/Z56H04LS7SRJH4va2GjPSeMwyAig/eDaJEFcDV+jRYCid6K+BmcPN7CCkbxOC/KDBt4v6L+p3HKbYauGwYRfSIpm2ExMMNLtzQ0wQPq3S6Uok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A4C/YIZu; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d3408449aso3188025ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724885747; x=1725490547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Z5eLbpis7e7vvah9IbIM7PmbksM6DKcbwvEGDpiWE=;
        b=A4C/YIZupzMAmEXTmU+NuOX5B8Zsh6kv/Vo97hZqhWg056Li0bFyvw0cTeUDKmUC8m
         OJkpM8zqK0eHrCZfeWCOI8s2q4zNKpweEP5N+TL4LmGTFBr83yQbJ9yd49Ef9Tgct++J
         qqOh4NdTrNtNWqX8oE0hP8BoCs3TnCkzPGCCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885747; x=1725490547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8Z5eLbpis7e7vvah9IbIM7PmbksM6DKcbwvEGDpiWE=;
        b=Vjf0/Cqd4Zl/MbA/Hwdv6cPftG9IHhlrj3yOOl7m7jX+n8efBizGAwiKaBioG4wfOe
         2CPMPHjmRQgMUZ9RX8G4rul+ZMkxQ+uRCvF5f/M92Zlt7L9hgM1TrsuzikM4wQqmWbjN
         O/2xGTorW1CwS9U1C00x+Q7BfgkQRJvEpR5toNX2ScLpY9IYDNy4tUWfODhfCsH+YuP6
         x4+L5CwKDLkOskDioWYP0uBZkwkL0cbUK/PwrE4cyEGU2vKKiTjXyo5LJXncmQitzP39
         0xUWCYKjRiQlN4OCV/BdeEO8PNqwKRYWx9KzelljXuXwSD6WXoVVeri0y29zjJPVK6vg
         YVNg==
X-Gm-Message-State: AOJu0YxbS3ID1WAjdDHJftGq7n2eOGm+0WCCOC81+MAesRf3iN6hbkEB
	ZEPQsPkEiOjwQ0rSyfRZyji7kBmmfUZZ3S0Oc84rvJAsnT1cQjnT3Myz5S7QsA==
X-Google-Smtp-Source: AGHT+IHyK6DcyWgUYRaw70EC9IGthnky5HvMQ2dXz+d303B4Lbji+yOFjXtPk96YXoJ4u+Ta5Vb8YQ==
X-Received: by 2002:a05:6e02:1524:b0:39d:1234:9433 with SMTP id e9e14a558f8ab-39f37710be2mr9394955ab.0.1724885746519;
        Wed, 28 Aug 2024 15:55:46 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7d22e77438dsm20314a12.27.2024.08.28.15.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 15:55:46 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	pedro.falcato@gmail.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
Date: Wed, 28 Aug 2024 22:55:21 +0000
Message-ID: <20240828225522.684774-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

mmap(MAP_FIXED) should return EPERM when memory is sealed.

Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_vma")
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 80d70ed099cf..0cd0c0ef03c7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1386,7 +1386,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
-		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		if (error == -EPERM)
+			return -EPERM;
+		if (error)
 			return -ENOMEM;
 
 		vmg.next = vms.next;
-- 
2.46.0.295.g3b9ea8a38a-goog


