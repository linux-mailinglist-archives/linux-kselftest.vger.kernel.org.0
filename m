Return-Path: <linux-kselftest+bounces-46583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84569C8C520
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D74E3303
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE84345CD9;
	Wed, 26 Nov 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGDLe4fU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96558345CA4
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199075; cv=none; b=fkH9WotthZ8E8O7IqLzjOxpgDg6Ktjj68Ogs+AaxgaUlPXuVxKIXraDmqnuP+7GibDZkqcMdKNLSyXUvQv3evz8cSSm94/Z0uJd25c3r5l8B9sMdqDB19N6i/3u88/4OM45zzEBbTfRIpUp9ZNGqORGxUgj894nhEkAyWJJFKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199075; c=relaxed/simple;
	bh=JHnO3koR6MtcgW1mrjyeErLO/KQbfdQegGSHdKrkPgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4BxRI3xEhJO0IQK96YTkKImFfFFkUs2Ug9Zov34Zwvtt7F9Igxc2UU6nMD1mHnHoSe3BNy9CUmcNa140KHRxKWTa5e09cG5lzgkPAqqKkZ/tlRkUaHd1exIRfaD1AGoBgIhOqmT5kzxrucxU9U1ZxRMmoCirVI8lnU5cKC2kVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGDLe4fU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so500472b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199073; x=1764803873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwUBc9dRFUqPZdHB+UIvPAI/agdY5EOkuuJxwmzSkeA=;
        b=MGDLe4fU3pVUUEhuxBKHp7DCs2zdVkOt2mUGTgxJGEuI+K1Dxz2pA7UVmtyC4ZG+03
         YgvdLQZY7I6+7kiOmBrHBPyKPFqwtwDBOXMllHrTojy+w7BapfXLA6Hl9DEfPUbr1QOc
         W6EtXcbc/ScOP5R4yqFlrKZn5kFJuB1rCZuISihoJh7jQv9KqByK62PL9KLUUCGWTGh1
         VX56rtsL27MVglgx974TDbXXIypn5QfUjEeOC8mn1lAw5hFtsR94KeOhiw5Q6+yl8wXm
         VAVRQFZEtVZaTr+MxOAKw0vJ8wT26vcsTKB5yEE0oBk/z8M/UTuhZ9RJBhtH+1j6HtbZ
         i0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199073; x=1764803873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwUBc9dRFUqPZdHB+UIvPAI/agdY5EOkuuJxwmzSkeA=;
        b=jPmnXRuAg6HegmgwjJfQxBQtAUiBeoc3afzcCYZxsMs8Gw5qHVB8fUckl0e2rZ8Esa
         x4F6yNy86DhcVh0wKZ/fMxuTUYPrq7yC+eDSAHWIYXH6UV26Uz8deaJhTGpOAjnUe3/o
         Xi9NmE7ngSfofbZVfKgZ/hewRvq2mhPsmdU+PjQW4DLuN40u3EEbsW045wJjlLW31oxq
         JvU1ODSeFmanNY4I+vcrvLMfdcbYlFML+xxTilXJcGcmrAeb9CnFg4aCpyfoJwY2WTzI
         EeP2Ns9JcKkdVldUs/KcRfB9jD/WrowEkxbieBqkCpe45fbkXHka4svKCFItMSQIvdYE
         /4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXTww2th1reQt+7B3L0GjoEzsVGN8QPL4lPeci5HrwJM8zSKTaFyI8wO0JJr9bYgvt+1nhofjC7U1S8cP9emNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZnKtkhbFYp4ktpJRuzyGKT9iVplUJCCYnuXjFaVD6JS9SSdF
	7wCjaMh4fep7hkrL6pd0RW0KnyMlAKlqQj5mkB9LOUSoXGEnhCbFhxs7gqAK8M/qCNy7xaoZqWU
	HwUVLC6cljQEFVw==
X-Google-Smtp-Source: AGHT+IFm4sH1ZXQuEmtE0xbNl954CjkawYuUdXUg10ZoaftL/Uqduh+oNqyjicfbmxei5yPTlHJJwCBMW+B2Yg==
X-Received: from pfie24.prod.google.com ([2002:a62:ee18:0:b0:77f:61e8:fabd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:914a:b0:35d:8881:e6bb with SMTP id adf61e73a8af0-3637db7a71dmr9590225637.22.1764199072920;
 Wed, 26 Nov 2025 15:17:52 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:22 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-8-dmatlack@google.com>
Subject: [PATCH v4 07/18] vfio: selftests: Eliminate overly chatty logging
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Eliminate overly chatty logs that are printed during almost every test.
These logs are adding more noise than value. If a test cares about this
information it can log it itself. This is especially true as the VFIO
selftests gains support for multiple devices in a single test (which
multiplies all these logs).

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index e5e8723ecb41..abb7a62a03ea 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <stdio.h>
-
 #include "../../../kselftest.h"
 #include <vfio_util.h>
 
@@ -29,7 +27,6 @@ void vfio_pci_driver_probe(struct vfio_pci_device *device)
 		if (ops->probe(device))
 			continue;
 
-		printf("Driver found: %s\n", ops->name);
 		device->driver.ops = ops;
 	}
 }
@@ -58,17 +55,6 @@ void vfio_pci_driver_init(struct vfio_pci_device *device)
 	driver->ops->init(device);
 
 	driver->initialized = true;
-
-	printf("%s: region: vaddr %p, iova 0x%lx, size 0x%lx\n",
-	       driver->ops->name,
-	       driver->region.vaddr,
-	       driver->region.iova,
-	       driver->region.size);
-
-	printf("%s: max_memcpy_size 0x%lx, max_memcpy_count 0x%lx\n",
-	       driver->ops->name,
-	       driver->max_memcpy_size,
-	       driver->max_memcpy_count);
 }
 
 void vfio_pci_driver_remove(struct vfio_pci_device *device)
-- 
2.52.0.487.g5c8c507ade-goog


