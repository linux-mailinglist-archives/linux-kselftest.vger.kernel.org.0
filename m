Return-Path: <linux-kselftest+bounces-45442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB755C54210
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE43A6FB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87E34D90D;
	Wed, 12 Nov 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmxOdRNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE86340287
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975368; cv=none; b=DA4nqKz0QaXOr/DpFHatT0YPz7IjKhCzbxrspy7N8IITSnA6XFOU6qqPtgfgP7r/YjAzHwzoMBxehxxpEtqczoL56fsYvLXIRp37sNM3FF6FdpA6IL2AZoNXAq5P0QTn4rVwdSYWKgFC6NiOu7GPwySQV2+noAy7+wDPyxxR8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975368; c=relaxed/simple;
	bh=kHKKv2ke2cj+MGan48Gu3BEFyapAdjSg49umcHRC9vA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGxxCjCJl7S8U7hKLqcL7m/O+6CvCq5zBUqVl36fEkNR64lbIQxr2Y6unG5JFPxxPnzFRpfgWjK8arWpHhcxyOvGVnzI+axwAXg0PZN+5T8pa7wju1wq1Ml8gSMQJaPahfmR77GVsM2Fr5kgFzpGu02qCuDPH37wZ45QvYRL5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmxOdRNa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so7968a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975365; x=1763580165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TielaAcMwqrNYs1v2uchxf5jnX6Kggt/DIe0BV32lMw=;
        b=nmxOdRNawpQbUv7aXmbriQsb2yxbwRd9tMzWxc6ck+Kl3oKeMn7Z0IMrbFcfrv2B0C
         H4EZDH/w93/Q2yTZXQ6/v4gR3Jw/NKd++obJv+LbDMWmeP2yaoqfQ18mukwySKsZljvT
         bLw3QQU1UxNcX8ltlLagMD18fCBHuoWodnHK/FiEP0gXxW16tDR7Pc16u4k0+6dhOdN5
         nyHmIaQi7NV8I90GbWMHWHCrKDr29e2LHEm9r1NklTCqaxtHsuJxdn6kBYb7AmLJDA2K
         Z1m+IcEa1od3FBTpsDZ706Qga9HE5USBzcHCkb1o86xK+pnKkjCeHASYwY7+uEE2Do9+
         bFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975365; x=1763580165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TielaAcMwqrNYs1v2uchxf5jnX6Kggt/DIe0BV32lMw=;
        b=Df+NhAawCI23OYaxEw53HOffFYNaRixKOTgefX1K810KWSuHwyY499IapFxZu9WUAs
         xN0jMbqRJgWSxsE2e7toMPzkr2hX0eHBE/erxQvxYJWuQ3KXH/NDcAwlxEb+m/G7RJxb
         IkbQJMjma9M4M2l0ipwrU+nYwGEATnObvR9/JOUUPJ/vBwZ+RPQYFvJ5vfehDJh/HuUU
         eVTz6natDJr8VLmDgEb7hafg3+Ar4RRL5p8hdRwcTzVYMgWIgGAQGghsNlAuYt/0akDV
         fP5q2ZBD41tjhrktcT5gvYt9znJt4Xduak2bKel6B8j/W4L5gLlQGzUy0Cca809xaoj8
         ea8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoc7LnUNFXPiHpLaILq8vRQcqC/raA5ofM7aqXeyT0mE3/2e5bHXm7vh/YODk1M1ponpWGRYQgQe4mmiRLlrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV74xVPNYzxKBOg2BPXKH3ygfACIYrhXB6nbRZNA66NpJs34Ho
	k2qRx7/zsMpSU3PY4GKqwpBkS6Yrzx3E44ewSImxyrN6MzITinARxDbugdpDUqdTZY5wH1MXibh
	tOCkqMIm1ylSLlw==
X-Google-Smtp-Source: AGHT+IHuFbrloR0m5blvPVZxF8h+Pqt2VSx6nAyL8MWcwWU6Pe/6lCA8dytMd0H7li6ZJ6bRtnj5aFgRaaAlPQ==
X-Received: from pfbbx6.prod.google.com ([2002:a05:6a00:4286:b0:793:b157:af49])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a109:b0:350:8dd9:7a90 with SMTP id adf61e73a8af0-3590ba1908cmr5304730637.43.1762975365575;
 Wed, 12 Nov 2025 11:22:45 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:15 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-2-dmatlack@google.com>
Subject: [PATCH v2 01/18] vfio: selftests: Move run.sh into scripts directory
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move run.sh in a new sub-directory scripts/. This directory will be used
to house various helper scripts to be used by humans and automation for
running VFIO selftests.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile             | 2 +-
 tools/testing/selftests/vfio/{ => scripts}/run.sh | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/vfio/{ => scripts}/run.sh (100%)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 324ba0175a33..155b5ecca6a9 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,7 +3,7 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
-TEST_PROGS_EXTENDED := run.sh
+TEST_PROGS_EXTENDED := scripts/run.sh
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/scripts/run.sh
similarity index 100%
rename from tools/testing/selftests/vfio/run.sh
rename to tools/testing/selftests/vfio/scripts/run.sh
-- 
2.52.0.rc1.455.g30608eb744-goog


