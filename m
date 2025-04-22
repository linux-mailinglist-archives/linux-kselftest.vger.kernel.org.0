Return-Path: <linux-kselftest+bounces-31294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE9A96876
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B538417C3F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3727CB2A;
	Tue, 22 Apr 2025 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMt3ZDj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F745945
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323398; cv=none; b=TnZksCiF7e2uEDFisLDHxFcGE5ygY53WKWXnb+7P7xOOUrwu5dxc/W3jX3fj6W8X5fkj8dEfJzgatUxSY9LhfAGKaK2Tpf1wOF1jhvfNseBQDre0HKXDnD/7S0CjrgqtPpYqyOThyzzgrhnQ3KTKDve64FkXGy9VWJwYk+5Wlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323398; c=relaxed/simple;
	bh=AoQIiPuxskMY/m8ZOL79dvqqFFwceArsoIR8xd7TvvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFrHhD1QuJwWI7hxyI67QRxmV//dxSqvyv/0JLXFWCwW6EjUqIC5QZ2nMYjCVFcTE6LSOUtzsC16y+vAUCpoJL2gfX9FGkkquEqj3ynfTsv2Ghwc8ZC+5wunDT3f3fWLcbZKzQ7i63u48fModslLVfU1Sqe25nWtp3rl0v5V29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMt3ZDj8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745323394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HXYOy5AqnIMDIJuzIwJ2Rz2vEeiO43DThz18Up7zmHQ=;
	b=CMt3ZDj823JtppXqA3mM/btvgSS76ky9dKlNj248PsO+Cl3VYeHaRjLynEtacA7kvZAZZp
	GMIMxqejH3m8ppQ45gKhlirEHC2b3JTDJgSIH1LFE9hfir25ponW08cLx28HnOtuNu7IHo
	0Ilj4JXQsyaM22Kd+4wPJJtXy0muS5c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-WsuSZuUcNCmPoLslO--bNA-1; Tue,
 22 Apr 2025 08:03:11 -0400
X-MC-Unique: WsuSZuUcNCmPoLslO--bNA-1
X-Mimecast-MFC-AGG-ID: WsuSZuUcNCmPoLslO--bNA_1745323389
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59A01195609F;
	Tue, 22 Apr 2025 12:03:09 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BBB5180045C;
	Tue, 22 Apr 2025 12:03:05 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: shuah@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dcaratti@redhat.com,
	fstornio@redhat.com
Subject: [PATCH 0/4] selftest: can: Start importing selftests from can-tests
Date: Tue, 22 Apr 2025 14:02:33 +0200
Message-ID: <cover.1745323279.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is the initial import of a CAN selftest from can-tests[1] into the
tree. For now, it is just a single test but when agreed on the
structure, we intend to import more tests from can-tests and add
additional test cases.

The goal of moving the CAN selftests into the tree is to align the tests
more closely with the kernel, improve testing of CAN in general, and to
simplify running the tests automatically in the various kernel CI
systems.

I have cc'ed netdev and its reviewers and maintainers to make sure they
are okay with the location of the tests and the changes to the paths in
MAINTAINERS. The changes should be merged through linux-can-next and
subsequent changes will not go to netdev anymore.

[1]: https://github.com/linux-can/can-tests

Felix Maurer (4):
  selftests: can: Import tst-filter from can-tests
  selftests: can: use kselftest harness in test_raw_filter
  selftests: can: Use fixtures in test_raw_filter
  selftests: can: Document test_raw_filter test cases

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/net/can/.gitignore    |   2 +
 tools/testing/selftests/net/can/Makefile      |  11 +
 .../selftests/net/can/test_raw_filter.c       | 338 ++++++++++++++++++
 .../selftests/net/can/test_raw_filter.sh      |  37 ++
 6 files changed, 391 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/.gitignore
 create mode 100644 tools/testing/selftests/net/can/Makefile
 create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
 create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh

-- 
2.49.0


