Return-Path: <linux-kselftest+bounces-35045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E9FADA80E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2577A84CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68E1DF725;
	Mon, 16 Jun 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WuNLzXg2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0191DEFE0;
	Mon, 16 Jun 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054506; cv=none; b=Pljb7CK5rab+fS/x6fSPrxJlicfou+34jB8YI9ouPFIXrfMkjnq/EBt/K3zXTY7W/lTjjbnDS4fyFI5YCAhF/0Q8GTaYKEiGxuZXlBZo6S337xZ1BaPNv0lLAj1NfhDlqcfmMS0sP5mmXXfFaoanAOviEWm2qZMnea2QR+tXX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054506; c=relaxed/simple;
	bh=01Dh3/JKpAgSejIE64mTqC7VtvSIfjcSsvNN6mHkM+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prlCHYejN2YYaQO4oOSm24zqvbqzRsPN4TIEVQGhmWBgT0T5nRGZRrGaYknZVX+oyY9SfHi/tl8kFw8rUJ9uMNJY6yEffWEPiL9C0fwzy0b5hNFzMx5HaiUzyCTEBTvIEE5BXwavVGjJtNbtDEeRtaRLBLRY67IDTPALL2PuNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WuNLzXg2; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AE36241ACB;
	Mon, 16 Jun 2025 06:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750054148;
	bh=erA/UguxQP3JF42uo8ErXFFZLH61G26696D+fredls8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=WuNLzXg29xfR148rjWOUb+YH+JvpDP+hamry+rGpqMX1TA8aMECgQr0vtJ0OdX6hG
	 VPVelFgYlbaHNY5W8by7xS3c8kK0idWr7grxrtbBehbZP/GEYEsvMYpoOTgWLkwblC
	 +6Ln9HNM0jKhjm5JakpMrVFXEeY10nlcA48Py0MmdJP96P82oDe1UdT4G9eZP5tydJ
	 FnroepdEFMuPU1Ui2XSy/pByPMZrBS+9ykPh5ZhQmrBkjm6CIeWNqT8tp1AEgX6guy
	 ablifj+xMou8qXbwm5sSTm66eb3i88UXtc5Rg9QTNEN/U/6+D/52wwauaqPgPeSR+R
	 puDt3XOAvUceg==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shuah@kernel.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 1/1] selftests/memfd: skip hugetlbfs test if not supported
Date: Mon, 16 Jun 2025 14:04:23 +0800
Message-Id: <20250616060423.2180088-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616060423.2180088-1-po-hsu.lin@canonical.com>
References: <20250616060423.2180088-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check hugetlbfs support before starting tests in run_hugetlbfs_test.sh.

Otherwise on a system that does not support hugetlbfs the free huge
pages availability check will fail with:
  ./run_hugetlbfs_test.sh: line 47: [: -lt: unary operator expected
  ./run_hugetlbfs_test.sh: line 60: 12577 Aborted                 (core dumped) ./memfd_test hugetlbfs
  Aborted (core dumped)

And it will left a fuse_mnt process behind, which may cause some
unexpected issues.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/memfd/run_hugetlbfs_test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/run_hugetlbfs_test.sh b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
index fb633eeb0290..15f4d1299563 100755
--- a/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
+++ b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
@@ -10,6 +10,11 @@ ksft_skip=4
 #
 hpages_test=8
 
+if ! grep -q hugetlbfs /proc/filesystems; then
+	echo "hugetlbfs not supported, test skipped."
+	exit $ksft_skip
+fi
+
 #
 # Get count of free huge pages from /proc/meminfo
 #
-- 
2.34.1


