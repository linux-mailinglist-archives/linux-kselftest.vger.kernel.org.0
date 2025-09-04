Return-Path: <linux-kselftest+bounces-40763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B259B43822
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FBE7C798B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257E2F90EB;
	Thu,  4 Sep 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I+aI3m2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AC2F60A7
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980679; cv=none; b=V6U1L0TJfYSrC2c4yxr9TmZdynpAOYewZMloNzRVAmSYlrQBASE2+y1YICqehfHnXA+AAlw2+ZWn4MGX1GRECxFEsBUh5ATFYWeiEFJnrGsma7Uii/KWTWnc/asRzkTcemd4dB6BtOsoUM/QWyIBhnMLX+hlG76TVXaR1SRpal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980679; c=relaxed/simple;
	bh=yrtlMz283qhgQvQnYvkzX09Jt/X/dryEKXnZxQWQYRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IFnkspKwh+fmQEmmEY2IxbKlWrH+Uy9FaE4QgkhmgzlD4VcRfLUdq04+G1vydIucNjM7m3DQFU8iU2fXXEQb9txD2fqZllK5gP+iWNROePKXIbVuAAKSyYWHpyq4Uur0n7HXgI/fK4gwOQfpHCUWyZlYCDF2B68nzNguuEtKKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I+aI3m2k; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 70C701A0D4B;
	Thu,  4 Sep 2025 10:11:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F090606BB;
	Thu,  4 Sep 2025 10:11:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2ADEF1C22DF32;
	Thu,  4 Sep 2025 12:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZSZ8goOHFryzVPTOu4Qe4jcSRLbtJ28Jz7W7uTxLsR0=;
	b=I+aI3m2kIvZChpvCDeSpBMUOkm+MMc3sP0FMKZWd0GfE/xC+5URMibib60E76inOYi1xeU
	1X0EjNMKQVBHSYdFvTUj8kZfCMdiWOL7jouvn7XHQYSK+lvHCB3wnW6NIRg5jocFp27UA5
	Eft44aZ5j6l6vg64yEd32hpz7vbgUa4SD3/Og54Nf03TMEy5+Vc/22MyhdpEOot7cLpVzC
	egXaLzMCFOd9j4vwm+AWSVAp+irDAH6d7H9W5EjMUpeID04TLhVCgPzGF8ZTPhZw04HAtR
	JO4Yp3uUWn45+0mCRBk7S+plubA2Loifxtx0R/H2XC0BZqDiZanRVP+15pPQow==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v3 00/14] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Date: Thu, 04 Sep 2025 12:10:15 +0200
Message-Id: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdluWgC/1WMwQ7CIBAFf8XsWQwsRcST/2E8tJTajQoNNKSm6
 b9L8GA8vsybWSG5SC7BebdCdJkSBV+G3O/Ajq2/O0Z92YAcFUdxYkt6MG4Hw53RqhcNlOcU3UB
 LrVyhmwbm3TLDrZCR0hziu+azqLyWpJC1lAXjTEvdaDStkZ25dCHMT/IHG161kPFnGY5fC4slt
 D3KRvUKhfq3tm37AEOTn9bYAAAA
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

This is a second version of a series I sent some time ago, it continues
the work of migrating the script tests into prog_tests.

The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
are defined in xksxceiver.c. Since this script is used to test real
hardware, the goal here is to leave it as it is, and only integrate the
tests that run on veth peers into the test_progs framework.

Some tests are flaky so they can't be integrated in the CI as they are.
I think that fixing their flakyness would require a significant amount of
work. So, as first step, I've excluded them from the list of tests
migrated to the CI (see PATCH 13). If these tests get fixed at some
point, integrating them into the CI will be straightforward.

PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
tests available to test_progs.
PATCH 2 to 5 fix small issues in the current test
PATCH 7 to 12 handle all errors to release resources instead of calling
exit() when any error occurs.
PATCH 13 isolates some flaky tests
PATCH 14 integrate the non-flaky tests to the test_progs framework

Maciej, I've fixed the bug you found in the initial series. I've
looked for any hardware able to run test_xsk.sh in my office, but I
couldn't find one ... So here again, only the veth part has been tested,
sorry about that.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
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
Bastien Curutchet (eBPF Foundation) (14):
      selftests/bpf: test_xsk: Split xskxceiver
      selftests/bpf: test_xsk: Initialize bitmap before use
      selftests/bpf: test_xsk: Fix memory leaks
      selftests/bpf: test_xsk: Wrap test clean-up in functions
      selftests/bpf: test_xsk: Release resources when swap fails
      selftests/bpf: test_xsk: Add return value to init_iface()
      selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
      selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
      selftests/bpf: test_xsk: Don't exit immediately when workers fail
      selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
      selftests/bpf: test_xsk: Don't exit immediately on allocation failures
      selftests/bpf: test_xsk: Move exit_with_error to xskxceiver.c
      selftests/bpf: test_xsk: Isolate flaky tests
      selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework

 tools/testing/selftests/bpf/Makefile              |   11 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2604 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  294 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c      |  146 ++
 tools/testing/selftests/bpf/xskxceiver.c          | 2685 +--------------------
 tools/testing/selftests/bpf/xskxceiver.h          |  156 --
 6 files changed, 3170 insertions(+), 2726 deletions(-)
---
base-commit: e4e08c130231eb8071153ab5f056874d8f70430b
change-id: 20250218-xsk-0cf90e975d14

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


