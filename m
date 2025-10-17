Return-Path: <linux-kselftest+bounces-43373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66EBE7E02
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3B3506D18
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D932D0634;
	Fri, 17 Oct 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCOAuiz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC232D5412
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694199; cv=none; b=tX1rpyI7t4Uxh+id6L0+JbZGn0Y2rvwb2yu0RbvF2LJqZ1bpW0vGNifGwE4fD08HEt24B08GCrSybTm85W0CC9DgnulaHFWIG3LRWBuRzbsowGiAeG7gPxjJeSpX5x0yjElImcBSdVpDfhOrm3Xuor89KEMrXJcX6KwnYO3s090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694199; c=relaxed/simple;
	bh=/M7Bnm3gjioI+Av04wQGAmQfU91Qw7IuTFIH55BhMAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpq8n2YAyn9NkPb1V22hSEud4abtslimUJSa5mhwW1yUhtbpo3NPKNbjKE1yKiNEruF75bgSFzx7ckd8wCN9YElFSzWqtM5NpawfYXJIyJ0I4Uhjp80zNjY6VDFBaAPSdof7iZ/AlyemYV6LayWM+uRtOH7IVNe8nmxWLUd2a+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCOAuiz7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7835321bc98so1665486b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694197; x=1761298997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK/268SDlKo91KyuWt/Uk0juTRvqRZCB2PBwlunHbIo=;
        b=WCOAuiz7eBnx9liP4aTDwjkG2Mbof5u+glrDE8WoccMy24LBTe2MOqc/TYIpUI/RJp
         SfMaGMcSsaXofJKnCxrzJO/QUw4uNBETGUZIbi2kPXCPadVbC9Qh2pEspOcfqJLJYMuA
         GGcR9tR6M9ORr6My8TjWU0yWH/WqgRQK4D4efcMKPGA8g1a8tm56wM2yT65ZTCJDgJdH
         SUfdpb+yNE6psxjM0+DzXa34Ytqw/4Qpffs9csqS2T9j5e0TwmxFl4rTu4gAZQjHQxKr
         PXCqAGlpNPSr8KjfY2m1laiLRj0QfpoavaJgjD6w4x2g6b8h5aXcV+bhXKLyd88YQx8O
         YzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694197; x=1761298997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK/268SDlKo91KyuWt/Uk0juTRvqRZCB2PBwlunHbIo=;
        b=NoDqkEMYGsv1xEqCBAPd/pHnvH/3XHqinWl2G4JnYWWi5O22kHGKwr++WKjkxIJGfT
         T+8vkGy7pvtZUWHqjUWWUDgJc/zgKewTxsgEA7vtZx8SsDMcFmpwD/jeTBIgphP3E7g8
         ZzRJG1Lbuh99Yr1do2YFuIoTO+KvkDuOb4+xehgI2Bq/kVMZxQjrTsfn2tzfDZ4pvLYd
         4krGbGfq3c03HpYzsg+VL0jdghnZWrOX2xdW2RbiYXDwrM24RCZHKjTkp3Capb0ebtub
         kQyUF8o90qt5QENhu+NKqCIjJRJLtrHdQ73/z1VQidk7yah8MsK1zZjz8GqdFWbKK+k9
         iBSA==
X-Gm-Message-State: AOJu0YwOF3Fg0dRaigtKMdXWkwmFRV3CMi9php9jkRATkMtb/IVW2Sp1
	Dk+k/DPkElhCww+sKZEqmm0nsu2UXJVUS7negHBHlphJGXtXKHwY6npq
X-Gm-Gg: ASbGnctS0yyWxY1fGU7blUxOdzaqI/ZCJ+CyaBLb4sPABFuujmpZcpa0wFJsBtYR8SJ
	oqxmQC/TcAdEoPPv/PWp7s1Y21VxuUPA2rbTSW4GG9k3HumXoZn0TAUDJ0hW0/ViNFeDx17jnS5
	+FunOZFxLLyafDK/0Zi/gmL69wphC7zVWmT3W5trAtzd+VuylAc+SoyfPWeSGttyGXAaKlH3+fl
	4XzAfBV3WcQICWjJWEcpdxlPG7qfaOrgcqv7bRllEUitq+e7WRThCi0gQxj38OGziH9+TU/UxwZ
	kpzrtcFA6vyBXay7x1zvbz4/p7NmvkwbnY9C5v8X25mjkQg6q6jWrig+U24tl3EdZ7/ro42/hmc
	+Hdapc414P8giLfdJ4WQduj7gdVMMB+GCbg4EaTq5UDucp4ETH3ge2rKmbdbm2pE2qJBoQbF7h+
	nhEu/AD8nghA==
X-Google-Smtp-Source: AGHT+IHVk1UlLvUv11fCrAvl7GZkv39UL14NzeVw04C1QLEJi71IrKA1z/tBFl1eYTam3trbIvNwag==
X-Received: by 2002:a05:6a20:3d84:b0:2b3:4f2a:d2e9 with SMTP id adf61e73a8af0-334a8515183mr3683681637.9.1760694197461;
        Fri, 17 Oct 2025 02:43:17 -0700 (PDT)
Received: from server.. ([103.251.57.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a1394139c8sm9963789b3a.18.2025.10.17.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:43:17 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	richard.weiyang@gmail.com,
	lkp@intel.com,
	reddybalavignesh9979@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] samples/vfs: add selftests include path for kselftest.h
Date: Fri, 17 Oct 2025 14:32:01 +0530
Message-ID: <20251017090201.317521-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
References: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test-list-all-mounts sample includes pidfd.h from selftests,
which now uses the centralized kselftest.h include after the
previous change. Add the selftests directory to the include path
so the build can find kselftest.h

This fixes a build error reported by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510171513.6IWk005g-lkp@intel.com/

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 samples/vfs/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 6554b73a75c8..9256ca5d762b 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 userprogs-always-y += test-fsmount test-statx mountinfo test-list-all-mounts
 
+userccflags += -I $(srctree)/tools/testing/selftests/
 userccflags += -I usr/include
-- 
2.43.0


