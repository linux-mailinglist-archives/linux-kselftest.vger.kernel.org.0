Return-Path: <linux-kselftest+bounces-48976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77911D21492
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73CC03023D21
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4735EDA0;
	Wed, 14 Jan 2026 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdsF1d6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934835E55D
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425220; cv=none; b=FLXhGx1tW1aN45WmpNvlzHQCWECDtigEBaQ6ZQ9y0DNESzLEt+okIhnZJsfao/FjT8iD+OYQPQTFaK5wiLd5dgIouMdJLQp9CeBs9qvAAMW3tvzY5Mk4HTpTAkKYILcORwAsRMP7vL/oeQroUWr/VAxg7NnjPF3Cn6/gQbpZVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425220; c=relaxed/simple;
	bh=9jpWqsc8jBpbfaxxgNOKWHgIWX7+eHnVyX9ZaqegDoo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EHV/oSJTS29UtlINFXVJt4+MuR9ylXzywCGRgpIgmgSVfCnn28q5qTwO/s2sxXozwXhi+ZzgkwuhMwxpOC0FoMXz/OIuG8z5mmseEIN+J5vjOXc5oaPxzgDZOei1PSnGfwuYRRuIFL+GrnawrD6+am2zi6AIom8cJFuhkfZbxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdsF1d6k; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81efa628efbso163094b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768425219; x=1769030019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kRN9XFSrat55IClnp903+wyZKW1cV4xVvxk5Dw/CtqI=;
        b=sdsF1d6kRuaqJEEPkxI/TMVc+Z1+L1INjkrPLKBULvtUlVaXxB6C2+msS+NrBWCV7f
         puCYcyx2uwA3l75Xey9Pzvl3Wsh/hCzzQYYkUVM6oSPW8L/QkZ9o5R+GH7wCxkjyaeJ4
         rjG+H0rQav+BFEpbwyhhy4EHoIUWYe4GwtglaFACVlFJdpVtVnolPpeBE+KpqEuRK42H
         lwx2Y+SnQhmQFu1niydUqp+QfbYbUG1Xxe6iFdWx6uISyq5hRItTLiEyge9kDGESdjvV
         5zolocUmaV1Sj7xGfPnL18eQVCSGq3f3/Xh0dk/Sazww3y5BmsCcCCjixtfchkaIU3W+
         GfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425219; x=1769030019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRN9XFSrat55IClnp903+wyZKW1cV4xVvxk5Dw/CtqI=;
        b=NRF8OXb5sCMOwp059ikSAaAKwka6d/VBsIHlEt9Sh9KLBvFs6lblxHmc7TX6BKE8rY
         tKq9ZOPHrWF6sc2PwvGdCFMrwWAFrZqSkghu+rxeS3BF5ownHyQUlk0EJneJ7TXWZf3r
         abKpYdeWiPN4WBTTnFI1YPCVdJH4J04J7PblI/T/3iSC+IOH+6nhtjRXrViqpC8KXScB
         N6z5KekMELBtPc25V6lBxrwPhh6LTCE7w7V9eJMgXAyM4HZ9zkn2uR3VI0jwQRidbb9d
         kPOfcqtwwFhkjZO5Kw9KFxCHu3fv8rdf19B2pGtGwpT60mPhhavec/3qsJ1GX+pMmcJJ
         3liA==
X-Forwarded-Encrypted: i=1; AJvYcCUKwMFCUZUPHd+gs8p6OJYKtg7s6noE89YRTOy6ydxeJj3nZ23pruiFgnq0sXn4QZq/QWRJjMKwFsemAYmjk3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jYf5aTmDosAOBZ06iAQMVVsSvUWdgKEeGrYF8g0VgJd8p6kh
	inAABY4WmBwkxilWt4nSA78B50YstldZPOvVU0O3vSoRVkSH448kGTx/CxPqqHeVYetbC3cy1Qe
	SehuSwAfRIR7+qQ==
X-Received: from pfhp36.prod.google.com ([2002:a05:6a00:a24:b0:7e5:3f05:3f6c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3695:b0:81d:a1b1:731b with SMTP id d2e1a72fcca58-81f81cee287mr3558018b3a.19.1768425218597;
 Wed, 14 Jan 2026 13:13:38 -0800 (PST)
Date: Wed, 14 Jan 2026 21:12:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114211252.2581145-1-dmatlack@google.com>
Subject: [PATCH] vfio: selftests: Drop IOMMU mapping size assertions for VFIO_TYPE1_IOMMU
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Drop the assertions about IOMMU mappings sizes for VFIO_TYPE1_IOMMU
modes (both the VFIO mode and the iommufd compatibility mode). These
assertions fail when CONFIG_IOMMUFD_VFIO_CONTAINER is enabled, since
iommufd compatibility mode provides different huge page behavior than
VFIO for VFIO_TYPE1_IOMMU. VFIO_TYPE1_IOMMU is an old enough interface
that it's not worth changing the behavior of VFIO and iommufd to match
nor care about the IOMMU mapping sizes.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Link: https://lore.kernel.org/kvm/20260109143830.176dc279@shazbot.org/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 5397822c3dd4..ecadd0e6b61b 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -162,12 +162,8 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	if (rc == -EOPNOTSUPP)
 		goto unmap;
 
-	/*
-	 * IOMMUFD compatibility-mode does not support huge mappings when
-	 * using VFIO_TYPE1_IOMMU.
-	 */
-	if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
-		mapping_size = SZ_4K;
+	if (self->iommu->mode->iommu_type == VFIO_TYPE1_IOMMU)
+		goto unmap;
 
 	ASSERT_EQ(0, rc);
 	printf("Found IOMMU mappings for IOVA 0x%lx:\n", region.iova);

base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
-- 
2.52.0.457.g6b5491de43-goog


