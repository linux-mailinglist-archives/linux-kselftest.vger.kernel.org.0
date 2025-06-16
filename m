Return-Path: <linux-kselftest+bounces-35044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9258ADA80C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C2A1890C81
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBB73451;
	Mon, 16 Jun 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t6jzsDIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC41DDC2B;
	Mon, 16 Jun 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054505; cv=none; b=DleU0Bvnql3/jCw2EZXvfCGNjWp/PoYylSilDsGO+z23uhg+veS6jOaqBQNk7lmsH+jjj1nMMQinRppBQLzUQyRI0z2ED/EYGNEdRKWogn2J80l+QATmnSm84apfZm29cJJKpw9U21K+dDn0hG3JEAsZ6gyVD+zFLHO4txarLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054505; c=relaxed/simple;
	bh=U3gAWtas0w8lcd0mklJbeVTO6hyVioa32oso/5iwvYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQapqyPfBAcDhS8liLKl2VHwz8E3kCm6tcH9aMXYYEzCil9jp7kioLqjdbfXtokNAPBesAoraPE8u2u5J1aNhzktwBiGXZm2y8G62ztZlNg8dXTv2gGDBwJotlWX+rEgHxyOYMEx+Ze7IoA8hTCs6jB4A7Fu3TTO7JhMV76Wz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=t6jzsDIB; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7C18A3F6D4;
	Mon, 16 Jun 2025 06:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750054144;
	bh=vzI5ep9/sh3GCOqZmoaGn6MewpD6iKj4fiizSXxMo+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=t6jzsDIBQbmnovZkpMrJrJfvfMiLt49gE3FqGsLDm6laMtiOPvZoDTKZP763VLOzV
	 uQlsAAlkenGQq0e5YctDv9SzYSnLH16eRy3kYMT+WQAvWTAQbrCgZmvJGxFSGOWS6q
	 g9bFXI4FFMB8q4Ajp+mMA1HYsRVJPtAKVprFTbhF+nfMSF6EjkD3MEadiae0b+/7tn
	 bPvAGw1RzMKkIVJULKPNt9KhDDmDjA7clHRLv+6jUXjRJVo9JdrmznVI3qE6K/hWw8
	 wvVOzHMJl8SX2vDSZogOKXDXngvqbdx9pBypSGkaHFOHzdcli+NAFXkUT0GfB2rDcK
	 31sIagiUlRnBQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shuah@kernel.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 0/1] selftests/memfd: skip hugetlbfs test if not supported
Date: Mon, 16 Jun 2025 14:04:22 +0800
Message-Id: <20250616060423.2180088-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Patch tested with a kernel that does not have hugetlbfs support enabled
and the test was skipped as expected.

Po-Hsu Lin (1):
  selftests/memfd: skip hugetlbfs test if not supported

 tools/testing/selftests/memfd/run_hugetlbfs_test.sh | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.34.1


