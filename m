Return-Path: <linux-kselftest+bounces-40591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65922B40151
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E311B60D0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82542D3735;
	Tue,  2 Sep 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xhs0WtNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5022D0C72
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817624; cv=none; b=mS8hoY1G5Q0diIIZX/MDr0EDxOv5o9kZUVeyMntQTXyD9kZ1iEMM9CnAHIryIdfYR/MD6i8DexSCYiTJFmBRLEb0V0VPcii6+GHvMsnqhZtc/3+jEqcDsDpB4yMiW0h46QNCPllTVASNf2RKdjtkLzHmfHXTc4qtFi5dLLH+lvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817624; c=relaxed/simple;
	bh=GMEf6EiSdX0vFH/h/bzrixMuPQlQqcPnUDYYGB2d/aw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjLYQ5oDYuJFpiWmMl8rgby3GyUdEvTOsua4sl6rkwzyrxkd8VrIv/n9ILhSgMw9HLtcD2n6F7zmPrp3cUOSBMteWAL5xltE8sc/sRbiJpuoHcC45/AVL183mLoyg1UQXLHrs78ckVt/9uLdnXc1gIsD5ILcGgPew7dw9jZbdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xhs0WtNR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 489671A09B9;
	Tue,  2 Sep 2025 12:53:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D3F860695;
	Tue,  2 Sep 2025 12:53:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D3FD1C228A25;
	Tue,  2 Sep 2025 14:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817618; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=xugUPbYWNv1VVbKMqmzqvQ4aFGqHbEziO/2FwF6oyHY=;
	b=xhs0WtNR9DqwnwFiqh79+t4UOXdkSKWBliA7a2Jd4do/GpIV5gwl/Z371eD4OAMSFxg3+R
	S0S5/X39kzEbxN4vsQI/zMwIiwn+nkzDzVQfHKzDrq0p7i2kSLf1Uu+e3QoW4HDHKElCu6
	QWaJJEV9DLNMCDxD5c/nRGN4gkpI7JV39lidXh6Cxdr12JQ7zL6hez+xgaw4/8k9I97H75
	mLu+uRsr4XP95wMfQE/IobBx7G12eDMkiBcYPfVBXu/++uH/CleUz5VR7dPSXo8ElxZKfK
	Yq/p9F5kT8zsq2iaAZVJ58H+U7RY7Cbt+/Ip8wHtOkNQyiuvvULWiN4/4Kwqqg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v2 00/14] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Date: Tue, 02 Sep 2025 14:49:50 +0200
Message-Id: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7ntmgC/x3MSwrDIBSF4a2EO67FR4K1o+6jZJCYm+bSVoMGs
 QT3XnF4+A/fCREDYYR7d0LARJG8q0NeOrDb5F7IaKkbJJcDl+LGcnwzblfD0ehhET3U5x5wpdy
 UJ8z7yhzmA8ZaNoqHD7/GJ9F6k5RQTUqCcaaV7rU0k1GzeczeHx9yV+u/MJZS/hYjf3iiAAAA
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
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2616 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  294 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c      |  146 ++
 tools/testing/selftests/bpf/xskxceiver.c          | 2698 +--------------------
 tools/testing/selftests/bpf/xskxceiver.h          |  156 --
 6 files changed, 3183 insertions(+), 2738 deletions(-)
---
base-commit: 1e6c91221f429972767f073295e2dd0d372520e7
change-id: 20250218-xsk-0cf90e975d14

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


