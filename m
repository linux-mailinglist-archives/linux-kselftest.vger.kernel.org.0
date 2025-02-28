Return-Path: <linux-kselftest+bounces-27918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B8A49E91
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA271695D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE526FA5C;
	Fri, 28 Feb 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpYmnHXA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E828E7
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759578; cv=none; b=DKBqJNEwac91/EhECa8jksSLF3vFux5dm3RNFNZza3yvVk30jLx3Lzt/RaVCIT1X4MoPug1Ih5P/ZfkvamAjsEGV0cJBQ1WRP1/MGml5hPSakKNOYmZSXHeS2K4xSXAPmsPTAh53RuizcH+KFI+RIEDAl3dRE+0a2v5davpXvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759578; c=relaxed/simple;
	bh=xHqhDBpGs/c0S60zBgSR6mnV4ugSzy4wEYs6iQvGjYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU0bA2xoWl9zqxVP4ykKyw3r5JnOh6eUCBz5xAX10qK6xZEyC+o976we+ZeZapBMgeOZlsY4CnoRqyLpjxBrAScJ3BQiufNTI1WKCtC3ywJFeuWoGrSjQb6hunBs5fUpB9ffji02mc3X4VYUj3Norz6VjgYOAzTri+dvijI43ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpYmnHXA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740759576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSC60nogDtbt1/sOIKHIvmCRxAOHn+S7+bhVoCo1v88=;
	b=hpYmnHXAMIdiPrzGq2WVP/fEjhzrkvwEeXHgfw5VDlsJZAj7guIWHJnM0mrEuvooRqirf9
	d5nHtc74BkCwrXnLXbNSmpcRLWOFEXuBj7uRsK9z4k7gvbvzMqXIS9oiduGzAbR6dzeoTO
	3DrBGO0lYrTB+ad8iriVHeoF/JyIlnM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-IdmVib2zOPCxngTxXBK5pA-1; Fri,
 28 Feb 2025 11:19:34 -0500
X-MC-Unique: IdmVib2zOPCxngTxXBK5pA-1
X-Mimecast-MFC-AGG-ID: IdmVib2zOPCxngTxXBK5pA_1740759573
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CDE81944D03;
	Fri, 28 Feb 2025 16:19:33 +0000 (UTC)
Received: from localhost (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 081501800357;
	Fri, 28 Feb 2025 16:19:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/3] selftests: add ublk selftests
Date: Sat,  1 Mar 2025 00:19:13 +0800
Message-ID: <20250228161919.2869102-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Jens,

This patchset adds ublk kernel selftests, which is very handy for
developer for verifying kernel change, especially ublk heavily depends
on io_uring subsystem. Also it provides template for target implementation.

Please consider it for v6.15.

The 1st patch adds one ublk utility and one entry test.
The 2nd patch adds test over file backed ublk.
The 3rd patch adds test for ublk zero copy.

How to run:
	- make install
	- make headers_install INSTALL_HDR_PATH=/usr	# in case UAPI is changed
	- reboot
	- make -C tools/testing/selftests TARGETS=ublk run_test

Thanks,

V3:
	- re-organize code, and move target code into standalone source file
	- fix one error handling bug
	- add licence tag
	- add dma limit for zero copy file backed target
	- kill checkpatch ERROR

V2:
	- fix one sqe allocation bug, so ublk zero copy with io_link can pass
	- dump log in case of error
	- add one more test for mkfs/mount on zero copy


Ming Lei (3):
  selftests: ublk: add kernel selftests for ublk
  selftests: ublk: add file backed ublk
  selftests: ublk: add ublk zero copy test

 MAINTAINERS                                  |    1 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/ublk/.gitignore      |    3 +
 tools/testing/selftests/ublk/Makefile        |   16 +
 tools/testing/selftests/ublk/config          |    1 +
 tools/testing/selftests/ublk/file_backed.c   |  220 ++++
 tools/testing/selftests/ublk/kublk.c         | 1110 ++++++++++++++++++
 tools/testing/selftests/ublk/kublk.h         |  326 +++++
 tools/testing/selftests/ublk/null.c          |   38 +
 tools/testing/selftests/ublk/test_common.sh  |  113 ++
 tools/testing/selftests/ublk/test_loop_01.sh |   31 +
 tools/testing/selftests/ublk/test_loop_02.sh |   22 +
 tools/testing/selftests/ublk/test_loop_03.sh |   33 +
 tools/testing/selftests/ublk/test_loop_04.sh |   22 +
 tools/testing/selftests/ublk/test_null_01.sh |   19 +
 15 files changed, 1956 insertions(+)
 create mode 100644 tools/testing/selftests/ublk/.gitignore
 create mode 100644 tools/testing/selftests/ublk/Makefile
 create mode 100644 tools/testing/selftests/ublk/config
 create mode 100644 tools/testing/selftests/ublk/file_backed.c
 create mode 100644 tools/testing/selftests/ublk/kublk.c
 create mode 100644 tools/testing/selftests/ublk/kublk.h
 create mode 100644 tools/testing/selftests/ublk/null.c
 create mode 100755 tools/testing/selftests/ublk/test_common.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_01.sh

-- 
2.47.0


