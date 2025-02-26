Return-Path: <linux-kselftest+bounces-27574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF4A457DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 09:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDA2188C06B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE8622422A;
	Wed, 26 Feb 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaLAbz9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE554238144
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557516; cv=none; b=nwnh5lGYhP1k6127m7v6CGfzMpX6g8Rmh6anC+g+nJ7ev2hfehTHRdjVK1E6eQ5si7/kRGW+PXN5tnj8nT++C9w1njjSG9JadGVwJaLqiFMRh3Y4SrnPTfMArMxsTeaOhCmTbUZaD8ynPtghxKgae3S3z2EU28NGA2QBUocm6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557516; c=relaxed/simple;
	bh=thYh+kh7bmm/Oc94RL2kLofYZlOwZzJbL65XyKbsJuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wz/MQ89NgkjlYchmTEH1jppy+qo6Ga5AvGIwYAE1gXKbm5SWOQ/vPQXJ0xn9QbTrx4FQvxLXcPMoTKxHTEMczPyVAKnSeookx6GyYcnimhIcwfYpojURG8OLuUNa7nWv8Tf/2YH9NbgKHe3zyD8CafflndfxeVqscXVLqcb6gyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaLAbz9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740557513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vgs1HUfMfS7u6IO6Rd6mvAHnQHEYNah2vIPRERXqkZ4=;
	b=WaLAbz9UmWcBMrsepxrVq3+idGGJFWND2k6njFJQQwcHMgC5WrKEtdu9ww1WN9/R+VCzyF
	a6HV7vZ15h5vo7Je/2tiD0KQmBqvz4leM4/EBGeCqQIcYQH6vjg+wsH7JBaZRMze5FB37C
	TM/V0+AVczuJ7JoAT+sWrxhY6mCcZ+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-eRZJ6sUWPXiup3tA418EIg-1; Wed,
 26 Feb 2025 03:11:48 -0500
X-MC-Unique: eRZJ6sUWPXiup3tA418EIg-1
X-Mimecast-MFC-AGG-ID: eRZJ6sUWPXiup3tA418EIg_1740557508
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F4881800264;
	Wed, 26 Feb 2025 08:11:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAFE41800367;
	Wed, 26 Feb 2025 08:11:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] selftests: add ublk selftests
Date: Wed, 26 Feb 2025 16:11:31 +0800
Message-ID: <20250226081136.2410001-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Guys,

The 1st patch adds one ublk utility and one entry test.

The 2nd patch adds test over file backed ublk.

The 3rd patch adds test for ublk zero copy.

How to run:

	- make install
	- make headers_install INSTALL_HDR_PATH=/usr
	- reboot
	- make -C tools/testing/selftests TARGETS=ublk run_test

Thanks,

Ming Lei (3):
  selftests: ublk: add kernel selftests for ublk
  selftests: ublk: add file backed ublk
  selftests: ublk: add ublk zero copy test

 MAINTAINERS                                  |    1 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/ublk/.gitignore      |    3 +
 tools/testing/selftests/ublk/Makefile        |   14 +
 tools/testing/selftests/ublk/config          |    1 +
 tools/testing/selftests/ublk/kublk.c         | 1671 ++++++++++++++++++
 tools/testing/selftests/ublk/test_common.sh  |  112 ++
 tools/testing/selftests/ublk/test_loop_01.sh |   30 +
 tools/testing/selftests/ublk/test_loop_02.sh |   21 +
 tools/testing/selftests/ublk/test_loop_03.sh |   32 +
 tools/testing/selftests/ublk/test_null_01.sh |   18 +
 11 files changed, 1904 insertions(+)
 create mode 100644 tools/testing/selftests/ublk/.gitignore
 create mode 100644 tools/testing/selftests/ublk/Makefile
 create mode 100644 tools/testing/selftests/ublk/config
 create mode 100644 tools/testing/selftests/ublk/kublk.c
 create mode 100755 tools/testing/selftests/ublk/test_common.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_01.sh

-- 
2.47.0


