Return-Path: <linux-kselftest+bounces-44493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22783C23ADB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D7E4F61DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F6309DDB;
	Fri, 31 Oct 2025 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ob4cVRpg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221511D5CFE
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897895; cv=none; b=hwmhcc1htugxIxsV5r21Cr8bLX8LRooQHF5qACOx67HlTSFu2VyFQEW9zPH4P2Rp+sf+rpXZrj28ZHhxdx34nCHjD7aj1UdT+NnZHSGpWjRcc6mxYsHf33pBle8OW8sSzBK2pSXz9No7e9AJaqE2TnBPCP+eqhUSR9Cl0t0P6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897895; c=relaxed/simple;
	bh=/fIlMoCVtfAkMLxLU6rMfA4iyIayW+obhotqMO34MNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MyCcBASpTJYtkVF3IFGC9TfJlthK9smf88gTc3+Jqdt5UNkBrYrNkeidqSwthw4cMzN+oLhnPrGxcTANE5xKfgOiJBmQrMRELn5+ngNdXd/FQ0b0+cpum4xYMvledBwWNEkQBURKqYRqVFs04r1tFpHn1vF+IBfKpDF6pQkaM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ob4cVRpg; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 13F624E4142A;
	Fri, 31 Oct 2025 08:04:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D290560704;
	Fri, 31 Oct 2025 08:04:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D2051180FB50;
	Fri, 31 Oct 2025 09:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zASfK0vPq1/4Nb33lJuBcso06uGImpqUSDtZvTvCZV8=;
	b=ob4cVRpg+X51uqtpe+A23/YvrDyAC1pkwAdvcLBAz4ya6yjBfw0hq9zu4ZWmPfyHAy1teI
	iNmP56cQPR8DC2R1zJD/e9rfYMNlMCil/fnCEFELTdWOyG2PnoH1ep5i1r8zJDBOF2mFTn
	NcY1ZykT4ry6IMytvJ8Zb8gjLSKjAz/LKeJVnAChb24n3CVagWhsIS8OjfSL4Q77r40rb2
	/s48qRx+W+toNquJ5R+9XYHR+huLYVRFMTHmh8swCAkEJODcX31/SwClNWBJv9ATNSpU2w
	YoKLuD2E8og8ghsfnG7zEwz5U9aPzmzWo9Ca0qIWnUO/8Jk++Lb/nTIKwQyjGQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v7 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Date: Fri, 31 Oct 2025 09:04:36 +0100
Message-Id: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJRtBGkC/23NS07EMAyA4auMsiYoseM8WHEPxKJNXSYCmlFbV
 UWj3p0oRVA0s7Ts7/dVTDwmnsTT6SpGXtKU8lAG93AS8dwMbyxTV2YBCkiB9nKd3qWKfVAcHHX
 aiHJ5GblPa628iPbSy4HXWbyWzTlNcx6/an7RdV9LqLGWFi2VdOiMg9AEbMNzm/P8kYbHmD9rY
 YE/FRTsCorSLlo01BFoulV4VGZXWFRk9MCI2vg7yhwU/ChTFCgmR+ha7+ytol+llba7oqKshRi
 IW6/UnV/2oCDsyhZFjcXGmq7vg/+vtm37BuTtDZWwAQAA
X-Change-ID: 20250218-xsk-0cf90e975d14
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
are defined in xksxceiver.c. Since this script is used to test real
hardware, the goal here is to leave it as it is, and only integrate the
tests that run on veth peers into the test_progs framework.

PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
tests available to test_progs.
PATCH 2 to 7 fix small issues in the current test
PATCH 8 to 13 handle all errors to release resources instead of calling
exit() when any error occurs.
PATCH 14 isolates the tests that won't fit in the CI
PATCH 15 integrates the CI tests to the test_progs framework

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v7:
- Restore 'test_ns' prefix to allow parallel execution.
- PATCH 11: fix potential uninitialized variable spotted by AI.
- PACTH 12: fix potential resource leak spotted by AI
- Link to v6: https://lore.kernel.org/r/20251029-xsk-v6-0-5a63a64dff98@bootlin.com

Changes in v6:
- Setup veth peer once for each mode instead of once for each substest
- Rename the 'flaky' table 'skip-ci' table and move the automatically
  skipped and the longest tests into it
- Link to v5: https://lore.kernel.org/r/20251016-xsk-v5-0-662c95eb8005@bootlin.com

Changes in v5:
- Rebase on latest bpf-next_base
- Move XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF to the flaky table
- Add Maciej's reviewed-by
- Link to v4: https://lore.kernel.org/r/20250924-xsk-v4-0-20e57537b876@bootlin.com

Changes in v4:
- Fix test_xsk.sh's summary report.
- Merge PATCH 11 & 12 together, otherwise PATCH 11 fails to build.
- Split old PATCH 3 in two patches. The first one fixes
  testapp_stats_rx_dropped(), the second one fixes
  testapp_xdp_shared_umem(). The unecessary frees (in
  testapp_stats_rx_full() and testapp_stats_fill_empty() are removed)
- Link to v3: https://lore.kernel.org/r/20250904-xsk-v3-0-ce382e331485@bootlin.com

Changes in v3:
- Rebase on latest bpf-next_base to integrate commit c9110e6f7237 ("selftests/bpf:
Fix count write in testapp_xdp_metadata_copy()").
- Move XDP_METADATA_COPY_* tests from flaky-tests to nominal tests
- Link to v2: https://lore.kernel.org/r/20250902-xsk-v2-0-17c6345d5215@bootlin.com

Changes in v2:
- Rebase on the latest bpf-next_base and integrate the newly added tests
  to the work (adjust_tail* and tx_queue_consumer tests)
- Re-order patches to split xkxceiver sooner.
- Fix the bug reported by Maciej.
- Fix verbose mode in test_xsk.sh by keeping kselftest (remove PATCH 1,
  7 and 8)
- Link to v1: https://lore.kernel.org/r/20250313-xsk-v1-0-7374729a93b9@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (15):
      selftests/bpf: test_xsk: Split xskxceiver
      selftests/bpf: test_xsk: Initialize bitmap before use
      selftests/bpf: test_xsk: Fix __testapp_validate_traffic()'s return value
      selftests/bpf: test_xsk: fix memory leak in testapp_stats_rx_dropped()
      selftests/bpf: test_xsk: fix memory leak in testapp_xdp_shared_umem()
      selftests/bpf: test_xsk: Wrap test clean-up in functions
      selftests/bpf: test_xsk: Release resources when swap fails
      selftests/bpf: test_xsk: Add return value to init_iface()
      selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
      selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
      selftests/bpf: test_xsk: Don't exit immediately when workers fail
      selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
      selftests/bpf: test_xsk: Don't exit immediately on allocation failures
      selftests/bpf: test_xsk: Isolate non-CI tests
      selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework

 tools/testing/selftests/bpf/Makefile              |   11 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2596 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  298 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c      |  151 ++
 tools/testing/selftests/bpf/xskxceiver.c          | 2696 +--------------------
 tools/testing/selftests/bpf/xskxceiver.h          |  156 --
 6 files changed, 3184 insertions(+), 2724 deletions(-)
---
base-commit: 1e2d874b04ba46a3b9fe6697097aa437641f4339
change-id: 20250218-xsk-0cf90e975d14

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


