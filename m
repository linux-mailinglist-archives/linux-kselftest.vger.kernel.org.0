Return-Path: <linux-kselftest+bounces-28035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACDA4C08E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1662E16B0FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC420370D;
	Mon,  3 Mar 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFl4/HWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8BF9C1
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005825; cv=none; b=vA/2JndwGDUez8RTZTUM5VDqPUU0ECh1itwSdZz9ZAP+OqGirkqm2zrTN9IEuhUArAiIl8URfVBmPaOErMg8Wl94cSSZnLkNluKIkZqcZy+sXFQqzs38IGCTjpxgAHGj0W5HfLj3JbZl0LEcSfYREVgcV25MZRjc34kUeR74SnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005825; c=relaxed/simple;
	bh=FR8f6OTYzxpbDZfjxI2ncturkIcoZjcEe9JOkVroDsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SF5P/eQFxToc1iTyYVodN7SAzwkf4bEZtEsakTtM0Fo7BfboeTlOpD357bAeDCBB8ThnzuivCEIne8G2y4PHRlLJbudCv8+InwHNAUETCb6bfLBAOiyjYagMpOyBFCmsgAMPtx0tnxR9d141j4FLA4ad78MGTn9YwT/VEPKTv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFl4/HWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=55Yz1Z9WIVSPvjndpkumuunccgMCP6JbGoOXhDzkQHQ=;
	b=bFl4/HWZI0I1vAWNoNUZxtO4UpHcVi3hK/kg9sznSDFcR+Mpit72fAd7CBlIlR8gtxHhw6
	BNzwWLnreaBDocX7BgZL2DsLhxk1acA2UkESu1ko4G7hOjmjUxvjOSFZIvSkseu+wRgHhP
	qd/zibWXm6Y4+ia13JMfSIJJs8225PQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-3xCsZy3KMYWE7PIkSWdDkw-1; Mon,
 03 Mar 2025 07:43:39 -0500
X-MC-Unique: 3xCsZy3KMYWE7PIkSWdDkw-1
X-Mimecast-MFC-AGG-ID: 3xCsZy3KMYWE7PIkSWdDkw_1741005818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D7D41918165;
	Mon,  3 Mar 2025 12:43:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D63CE1800367;
	Mon,  3 Mar 2025 12:43:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
Date: Mon,  3 Mar 2025 20:43:10 +0800
Message-ID: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Jens and guys,

This patchset fixes several issues(1, 2, 4) and consolidate & improve
the tests in the following ways:

- support shellcheck and fixes all warning

- misc cleanup

- improve cleanup code path(module load/unload, cleanup temp files)

- help to reuse the same test source code and scripts for other
  projects(liburing[1], blktest, ...)

- add two stress tests for covering IO workloads vs. removing device &
killing ublk server, given buffer lifetime is one big thing for ublk-zc 


[1] https://github.com/ming1/liburing/commits/ublk-zc 

- just need one line change for overriding skip_code, libring uses 77 and
  kselftests takes 4

Ming Lei (11):
  selftests: ublk: make ublk_stop_io_daemon() more reliable
  selftests: ublk: fix build failure
  selftests: ublk: add --foreground command line
  selftests: ublk: fix parsing '-a' argument
  selftests: ublk: support shellcheck and fix all warning
  selftests: ublk: don't pass ${dev_id} to _cleanup_test()
  selftests: ublk: move zero copy feature check into _add_ublk_dev()
  selftests: ublk: load/unload ublk_drv when preparing & cleaning up
    tests
  selftests: ublk: add one stress test for covering IO vs. removing
    device
  selftests: ublk: add stress test for covering IO vs. killing ublk
    server
  selftests: ublk: improve test usability

 tools/testing/selftests/ublk/Makefile         |   6 +
 tools/testing/selftests/ublk/kublk.c          |  43 +++--
 tools/testing/selftests/ublk/kublk.h          |   2 +
 tools/testing/selftests/ublk/test_common.sh   | 167 ++++++++++++++----
 tools/testing/selftests/ublk/test_loop_01.sh  |  13 +-
 tools/testing/selftests/ublk/test_loop_02.sh  |  14 +-
 tools/testing/selftests/ublk/test_loop_03.sh  |  16 +-
 tools/testing/selftests/ublk/test_loop_04.sh  |  14 +-
 tools/testing/selftests/ublk/test_null_01.sh  |   9 +-
 .../testing/selftests/ublk/test_stress_01.sh  |  47 +++++
 .../testing/selftests/ublk/test_stress_02.sh  |  47 +++++
 11 files changed, 300 insertions(+), 78 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_stress_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_02.sh

-- 
2.47.0


