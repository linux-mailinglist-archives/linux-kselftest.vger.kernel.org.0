Return-Path: <linux-kselftest+bounces-28997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F0EA609EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6151888ADB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E391C861D;
	Fri, 14 Mar 2025 07:15:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 571B8192B65;
	Fri, 14 Mar 2025 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936514; cv=none; b=u0lo2koyAwNoK0/TgBqEBRNfFapEDJtlyB4sKfICuxMJGsyQ+qrDU+MP4yftfgwnrbEqwpzdAuAaTF5R6KSF3ckXijY2Kk/iyFiHmWUQn6EsP/a2K5KneT+w98Jp9xAJvqc1V7Llb5Dgd6QuONAp5nCUs19ikPRDiBe9tbwkSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936514; c=relaxed/simple;
	bh=2/4BHfz5ze4ticFIca7ZvvexEMkbfV6F2Gd0lB90Jn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WT1L26ER8ugdGxOLTb+UEcDa5lPAvXQZZAnZQdSL818l8YVGrsUU4FC0fpDEGwxYTxdltoza7hd4Qp9bQAD1CNGo/aorv7tTL+Mmpzw/gUywK2U9qAGH3NCNBnE+2VJEDajXPeKkGNMICPzY8VLWX5aBziQFp8jMwkEWR4gDJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id EEA2660680979;
	Fri, 14 Mar 2025 15:15:07 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: zfigura@codeweavers.com,
	corbet@lwn.net,
	shuah@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	wine-devel@winehq.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 0/4] ntsync: some small fixes for doc and selftests
Date: Fri, 14 Mar 2025 15:14:50 +0800
Message-Id: <20250314071454.201697-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are four small fixes for ntsync test and doc. I divided these into
four different patches due to different types of errors. If one patch is
better, I can do it too.

Su Hui (4):
  selftests: ntsync: fix the wrong condition in wake_all
  selftests: ntsync: avoid possible overflow in 32-bit machine
  selftests: ntsync: update config
  docs: ntsync: update NTSYNC_IOC_*

 Documentation/userspace-api/ntsync.rst         | 18 +++++++++---------
 tools/testing/selftests/drivers/ntsync/config  |  2 +-
 .../testing/selftests/drivers/ntsync/ntsync.c  |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.30.2


