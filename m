Return-Path: <linux-kselftest+bounces-5264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09285F223
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 08:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E28B1C22D58
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1E1799D;
	Thu, 22 Feb 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bEvS0puG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90956F4E7;
	Thu, 22 Feb 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588162; cv=none; b=tIQsxyxxTvR73DWiZrGY9N1IgMPlNL1z4N8ha5qYgiVvPO/Ls4SXoIsjMWfangRTSmyUs/AOat3wSqAb+2u0hieaqSHS939UYdtIpvuZZkQJZtBa+U5Qvf1jnR9t8Lk2xpdNq74XkSeeLZy4LccPkBE40YruxUTRo1n+PiMWZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588162; c=relaxed/simple;
	bh=vBc4/x2wQFPFFwAbmQ8acN+qW4Povt5PrHZ0s3wsjbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eIAgQuP137/SkbGLuHyeKEHm4fIjVUPHK3Leu4nJZs8ldTO/IjQrUtb7h57VMlHdo4rKCpZvSSXMgZd0+YRx5jauuof82i6f5xO0NoQV3iv4gJkuS5ZqkLfVfgRokWxrzTDMrP9s9w9PXGet89CrwVOjyRT72G8seFzl3uYL1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bEvS0puG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708588158;
	bh=vBc4/x2wQFPFFwAbmQ8acN+qW4Povt5PrHZ0s3wsjbE=;
	h=From:To:Cc:Subject:Date:From;
	b=bEvS0puG8WpfSE1cw42dQrqia0mh4GN4bXlMR5kk1uWq3HuHaD1APfIOyq+UTkbG0
	 ed4yJXZT1l+458fOA5hUo+2kgIMSgVtzE/vvqg3Bu/voTKYL7k9e63Ps26VJJKQIRL
	 WgHIzDRgVpHyW6O6duL1J8FfkzVWyNiCpltEksYHTw1uhoCpVf3TIz/lxpznWgc/LA
	 Mw8zaJWPASIoDoOHpHQMWkYZK7y6jqsNWMHhTZH3hScQcN5xHVuP56vxOfpGFU5iSC
	 l29kAJ6VhYE1KKWT3E/b2gQ0zSPOaPv6NOOrAUZts6FyN7b/bFDsq8s7GD7ZP8NUu+
	 U1Z/XnH8k4cbQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CDB43378042B;
	Thu, 22 Feb 2024 07:49:15 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/iommu: fix the config fragment
Date: Thu, 22 Feb 2024 12:49:33 +0500
Message-ID: <20240222074934.71380-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The config fragment doesn't follow the correct format to enable those
config options which make the config options getting missed while
merging with other configs.

➜ merge_config.sh -m .config tools/testing/selftests/iommu/config
Using .config as base
Merging tools/testing/selftests/iommu/config
➜ make olddefconfig
.config:5295:warning: unexpected data: CONFIG_IOMMUFD
.config:5296:warning: unexpected data: CONFIG_IOMMUFD_TEST

While at it, add CONFIG_FAULT_INJECTION as well which is needed for
CONFIG_IOMMUFD_TEST. If CONFIG_FAULT_INJECTION isn't present in base
config (such as x86 defconfig), CONFIG_IOMMUFD_TEST doesn't get enabled.

Fixes: 57f0988706fe ("iommufd: Add a selftest")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/iommu/config | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
index 6c4f901d6fed3..110d73917615d 100644
--- a/tools/testing/selftests/iommu/config
+++ b/tools/testing/selftests/iommu/config
@@ -1,2 +1,3 @@
-CONFIG_IOMMUFD
-CONFIG_IOMMUFD_TEST
+CONFIG_IOMMUFD=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_IOMMUFD_TEST=y
-- 
2.42.0


