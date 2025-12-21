Return-Path: <linux-kselftest+bounces-47786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CFCD3D31
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 441C130010EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E423B62C;
	Sun, 21 Dec 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agma9H0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7A1494DB
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766307508; cv=none; b=kcvSuKnLCkIYFjmeU5yx/1afc9Ml9ydgG6erNo1pPaUfdz2Mkc3Sy9KRS9h1HEDX38G4F53Il4oGuLXsm58S/jUS57pd0HPpCjCpK4INn40vwmvmcyMnMw7RyXF/mXMebyXQZ9vEMhlI5K6kXOC/Mx+eAfaRzke8iMjYJSW4Q1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766307508; c=relaxed/simple;
	bh=Upjd/vKlJ2f/YN/2ULi8//hZnJGea63SdaJgD5m3SIg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AS2w3sglD17cmBingNNFC6mrLjGwFAIfVJr291IQtChOLTzUk7HOLEEIwI2gAUsdZCOUgS4W8C+FCYVlL4DRZ/H40WhbGgVNfg1qmdYrqtCLUQKQVhwru55VCLFz4XI3BKT8uq17f7fY/Lfg9Pu+lM/lqjvSfETky2WH2+0jElk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agma9H0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766307505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jv4+N3yPqzFBNXywZidTgEMmHvkbMjhW+YkPHiUuGYg=;
	b=agma9H0EmhlmQ5FAes3o9JnFNBRungPJ5iZT17P9Qusqgp0CZE8iFA1xyBki4ARzXEI09k
	jsH0jdKxsi0RUVoNIoOuBotgjGwqK6Pno2rESpujmpuZawwtxhbwJYXDUEHnX0Tw4AMJ64
	rkN9cGQweyHioElYWum38Vs8kOOlsms=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-sMSeTc1RNy6-vFsI9gpUGg-1; Sun,
 21 Dec 2025 03:58:19 -0500
X-MC-Unique: sMSeTc1RNy6-vFsI9gpUGg-1
X-Mimecast-MFC-AGG-ID: sMSeTc1RNy6-vFsI9gpUGg_1766307498
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE806180060D;
	Sun, 21 Dec 2025 08:58:17 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CF2F30001A2;
	Sun, 21 Dec 2025 08:58:15 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/3] selftests/mm: hugetlb cgroup charging: robustness fixes
Date: Sun, 21 Dec 2025 16:58:07 +0800
Message-ID: <20251221085810.3163919-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Changes in v2:
  - 1/3: Parse -s using sscanf("%zu", ...) instead of strtoull().
  - 2/3: Fix typo in charge_reserved_hugetlb.sh ("reseravation" -> "reservation").
  - 3/3: No changes.

This series fixes a few issues in the hugetlb cgroup charging selftests
(write_to_hugetlbfs.c + charge_reserved_hugetlb.sh) that show up on systems
with large hugepages (e.g. 512MB) and when failures cause the test to wait
indefinitely.

On an aarch64 64k page kernel with 512MB hugepages, the test consistently
fails in write_to_hugetlbfs with ENOMEM and then hangs waiting for the
expected usage values. The root cause is that charge_reserved_hugetlb.sh
mounts hugetlbfs with a fixed size=256M, which is smaller than a single
hugepage, resulting in a mount with size=0 capacity.

In addition, write_to_hugetlbfs previously parsed -s via atoi() into an
int, which can overflow and print negative sizes.

Reproducer / environment:
  - Kernel: 6.12.0-xxx.el10.aarch64+64k
  - Hugepagesize: 524288 kB (512MB)
  - ./charge_reserved_hugetlb.sh -cgroup-v2
  - Observed mount: pagesize=512M,size=0 before this series

After applying the series, the test completes successfully on the above setup.

Li Wang (3):
  selftests/mm/write_to_hugetlbfs: parse -s as size_t
  selftests/mm/charge_reserved_hugetlb.sh: add waits with timeout helper
  selftests/mm/charge_reserved_hugetlb: fix hugetlbfs mount size for
    large hugepages

 .../selftests/mm/charge_reserved_hugetlb.sh   | 51 ++++++++++---------
 .../testing/selftests/mm/write_to_hugetlbfs.c |  9 ++--
 2 files changed, 34 insertions(+), 26 deletions(-)

-- 
2.49.0


