Return-Path: <linux-kselftest+bounces-14224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA093C08A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EA51F21924
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA631991C9;
	Thu, 25 Jul 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iGB0164o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD4132492;
	Thu, 25 Jul 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905570; cv=none; b=cFZxqZyNmgz4+JQR7HVSADWY5qtFQfIvBl/s7kLEIRLmecAZnGQSylHMD0+AP9knxis+wqUNT3oAMDQ9gclPfY9sBsn43s9spurfWUCe24AuZNk9OfqT7sdQYOZWWxC1Y1hoG2QE6goECCIhiXTm6gg1AA/Mqrl6v1rlAadR9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905570; c=relaxed/simple;
	bh=XtztIq1aXisVUKyTE5akYt0PhhO1DqKxrOMgan8F3WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCH/9fASDzUtH2+mBeCXvAe1jksfKN3+9R+8CQOPimx73fQ+KhWm4sFibnod0PnE3bdhknVCeYhsOcHey+QWB65vBNsmIVa9cgi8MCLlPEXkI0HaAUMgFCZxhmE6S4MlMtdRqVBK+ErKi+kQl+GH28SMaXHeIc+Dgnqx0e/wWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iGB0164o; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721905566;
	bh=XtztIq1aXisVUKyTE5akYt0PhhO1DqKxrOMgan8F3WU=;
	h=From:To:Cc:Subject:Date:From;
	b=iGB0164oCaVFSk2V5Nh1i+F374okHtBUyDOqzcoU9/00Ps/YKJf+zgh0fhZVZXHv3
	 qXBptMhTWu4kVJSjE4bLKIRh/UaAXrx7+jEloiIQnxgOZVdHGR6vYpKw/pxGB3yJKB
	 8RUo1YGaCU9n6SrPlUoqL7xJavtdd/fH8OL7JmA9kEV/ns7sPXTj53VCqUNh7Kbpkl
	 vXTMDMAkvSGvLstTJh0D0HS/osW+TI/WH1vL34n1bnBRwEuY2ERAPPFMZXdA853WtL
	 oYTwHUc7/4ryFSxBAV1mODUo8N17RvqizYtQLVRC2Bvog64H3LXuiiPD/T5rdILIdm
	 qCP2TmowwzuBA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7325C37803EE;
	Thu, 25 Jul 2024 11:06:05 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	tim.bird@sony.com,
	mhiramat@kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 0/1] Add kselftest to detect boot event slowdowns
Date: Thu, 25 Jul 2024 13:06:21 +0200
Message-Id: <20240725110622.96301-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kselftest to detect and report slowdowns in key boot events. The
test uses ftrace to track timings for specific boot events and compares
these timestamps against reference values provided in YAML format.

The test includes the following files:

  - `bootconfig` file: configures ftrace and lists reference key boot
   events.
  - `config` fragment: enables boot time tracing and attaches the
    bootconfig file to the kernel image.
  - `kprobe_timestamps_to_yaml.py` script: parses the current trace file to
    extract event names and timestamps and writes them to a YAML file. The
    script is intended to be run once to generate initial reference values;
    the generated file is not meant to be stored in the kernel sources but
    should be provided as input to the test itself. YAML format was chosen
    to allow easy integration with per-platform data used in other tests,
    such as the discoverable devices probe test in
    tools/testing/selftests/devices. Another option is to use JSON, as the
    file is not intended for manual editing and JSON is already supported
    by the Python standard library.
  - `test_boot_time.py` script: parses the current trace file and compares
    timestamps against the values in the YAML file provided as input.
    Reports a failure if any timestamp differs from the reference value by
    more than the specified delta.
  - `trace_utils.py` file: utility functions to mount debugfs and parse the
    trace file to extract relevant information.

The bootconfig file provided is an initial draft with some reference kprobe
events to showcase how the test works. I would appreciate feedback from
those interested in running this test on which boot events should be added.
Different key events might be relevant depending on the platform and its
boot time requirements. This file should serve as a common ground and be
populated with critical events and functions common to different platforms.

Feedback on the overall approach of this test and suggestions for
additional boot events to trace would be greatly appreciated.

Example output with a deliberately small delta of 0.01 to demonstrate failures:

  TAP version 13
  1..4
  ok 1 populate_rootfs_begin
  # 'run_init_process_begin' differs by 0.033990 seconds.
  not ok 2 run_init_process_begin
  # 'run_init_process_end' differs by 0.033796 seconds.
  not ok 3 run_init_process_end
  ok 4 unpack_to_rootfs_begin
  # Totals: pass:2 fail:2 xfail:0 xpass:0 skip:0 error:0

This patch depends on "kselftest: Move ksft helper module to common
directory":
https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
which was picked through the usb tree and is queued for 6.11-rc1.

Best,

Laura

Laura Nao (1):
  kselftests: Add test to detect boot event slowdowns

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/boot-time/Makefile    | 17 ++++
 tools/testing/selftests/boot-time/bootconfig  |  8 ++
 tools/testing/selftests/boot-time/config      |  4 +
 .../boot-time/kprobe_timestamps_to_yaml.py    | 55 +++++++++++
 .../selftests/boot-time/test_boot_time.py     | 94 +++++++++++++++++++
 .../selftests/boot-time/trace_utils.py        | 63 +++++++++++++
 7 files changed, 242 insertions(+)
 create mode 100644 tools/testing/selftests/boot-time/Makefile
 create mode 100644 tools/testing/selftests/boot-time/bootconfig
 create mode 100644 tools/testing/selftests/boot-time/config
 create mode 100755 tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py
 create mode 100755 tools/testing/selftests/boot-time/test_boot_time.py
 create mode 100644 tools/testing/selftests/boot-time/trace_utils.py

--
2.30.2


