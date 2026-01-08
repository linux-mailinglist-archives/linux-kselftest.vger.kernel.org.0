Return-Path: <linux-kselftest+bounces-48475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848BD03F88
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D3BC354DC1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1B3033D3;
	Thu,  8 Jan 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="a1u4w6qv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602A41E5E6;
	Thu,  8 Jan 2026 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863716; cv=none; b=mvfNZfssubPIrYik+Ox5n08LGUAFceXDyx1fP/WpZ/EVSsi3Xl4O8KRlpMxui71rwd2jzI9Gn+mMmiGgLxdaN3tiYlHX87AnpWCSaq47465skCMKyJyrCv+yXFqtXN/82vtacovAMChmjnTwi/ttwWT6qCvyyyGWD3B+tDpg1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863716; c=relaxed/simple;
	bh=1JP+HbI7Kl5ngl+Pn72ddBqB+JFpEhzTc0R/Hx8E6JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URPhqB6M7rMHLMfMAtiqgPckQr4oqVDEic44lyJrJgiWFW0vY/LcGLgiMLxq/5rjp77A16wNbPqjLndVa8GvBBN8TwRzWTevXN+KtcOaN3rzaWf5cNvmwy1KF9VZS+oKULQlrghOcEwXIrJ6HxeyODfe2bqUlDi5wAZvuuAR63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=a1u4w6qv; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D904240041;
	Thu,  8 Jan 2026 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1767863217;
	bh=bhbyFxLT9xjffG67Z+OkI6jFvGuaD1qtiqcZ7tiZdzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=a1u4w6qv3+pBB/0QO6zP//6bgQY0NLcexRwUD450sbjMyYozbPiPrP/p06U9b3N3s
	 sOsOMiI+QLg6lJBWrxSUAWdOhFWuceTjyn42jIPzdbFdWw6jMDVnzMsz3WwAsZ4Umw
	 mqLlHT9oL0NxXC4dMZvfraleoZDyZkdTQZ2kq/pkthGYe4UrjPfd9/lvZ3KEBy8aep
	 EOGKWHIKChuaWEkFKFITKy3rYk7O5Al/nJJoesSpQe8+0mFi+mlwTPBVurcJwsIl4n
	 dTcdikITSZD9QyO6fMDFcoco1sQ28s6WVmPji9P2LhcCrhaciOtfDdgBc2L2czb9vJ
	 cCKQFsH85OBnHqQ3orb7zDRsnZK42guZG0ty8vQe/M16mUFYzsOWaW4Zt2XB1PcDj/
	 /xeQ/PjesMTDCKl3C+DlQX4bGaY/9uo2k30pHEQTTcMixA7NIGLIe+tRP8ZemWCNQo
	 dRke/LL+xJ6guG5ChkjjGMwHx/SPJRWP1mgKGgxG0oRW9cfk7DJYfPXWdIAAuJRDjM
	 Q498J4isPnGHX1x1OCNn6MBAEPhw+NrSC8aOdohlmpWYnFdc67lMy/xFdbyyMFJUSZ
	 woiTt5BA/ECjrT3BQhKVZMl6x6ulynRbJZJhxaOlmPu+o7Q+tdv04slAS6/t/sTUuJ
	 e8x83OjgJdfpLY4eSY+O5JGY=
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	shuah@kernel.org,
	mike.kravetz@oracle.com
Subject: [PATCH 0/1] selftests/memfd: fix return value override issue in run_hugetlbfs_test.sh
Date: Thu,  8 Jan 2026 17:06:05 +0800
Message-ID: <20260108090606.20660-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clean up task in the end of this script has successed, this
test will be considered as passed regardless the sub tests results.

$ sudo ./run_hugetlbfs_test.sh
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-EXEC
memfd-hugetlb:  Apply SEAL_EXEC
fchmod(/memfd:kern_memfd_seal_exec (deleted), 00777) didn't fail as expected
./run_hugetlbfs_test.sh: line 60: 16833 Aborted                 (core dumped) ./memfd_test hugetlbfs
opening: ./mnt/memfd
ADD_SEALS(4, 0 -> 8) failed: Device or resource busy
8 != 0 = GET_SEALS(4)
Aborted (core dumped)
$ echo $?
0

Fix this by checking the return value of each sub-test.

With this patch, the return value of this test will be reflected
correctly and we can avoid a false-negative result:
$ sudo ./run_hugetlbfs_test.sh
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-EXEC
memfd-hugetlb:  Apply SEAL_EXEC
fchmod(/memfd:kern_memfd_seal_exec (deleted), 00777) didn't fail as expected
./run_hugetlbfs_test.sh: line 68: 16688 Aborted                 (core dumped) ./memfd_test hugetlbfs
opening: ./mnt/memfd
ADD_SEALS(4, 0 -> 8) failed: Device or resource busy
8 != 0 = GET_SEALS(4)
Aborted (core dumped)
$ echo $?
134


Po-Hsu Lin (1):
  selftests/memfd: fix return value override issue in
    run_hugetlbfs_test.sh

 tools/testing/selftests/memfd/run_hugetlbfs_test.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1


