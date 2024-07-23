Return-Path: <linux-kselftest+bounces-14087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7EC93A43F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBF11C225CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F4A157485;
	Tue, 23 Jul 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPHwfX1f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48014D2B8;
	Tue, 23 Jul 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751730; cv=none; b=ZNcTjL3pQTFpPC80+Ih6uBlUtYkDbFR8I6TWsGHjLdvFG2HpMrOm1MO4pN+dryg0QOAm7EOoK5k6vrYl0bHuQAJaVXRPsT28vHALuylEZWhupQxFtfl9WdfRInOZXeaHIBCJurC05BPw/as7zUfpdpOgJdyR3KGvLaMv8JFAWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751730; c=relaxed/simple;
	bh=FMzdl7ub859Z2WbgsSW6HhSuQj7usqZNfev9Tp8upxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F33bhBQkvoFoPyojGXD4Ywp8jJsnt0xQ10a+9GjZdmzV7kKb16ytAvyoEPagLyGLky6dj/Px/YR49x1zOht2qe9yrzDICRVPcxzhRJyH7di9CQyRwBuoZf3sjPRxc7l1sk0bE/vGXmhzoPt2vOS1PPv2cI79Lm27c1MRDbl/Xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPHwfX1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93516C4AF0A;
	Tue, 23 Jul 2024 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751730;
	bh=FMzdl7ub859Z2WbgsSW6HhSuQj7usqZNfev9Tp8upxI=;
	h=From:Subject:Date:To:Cc:From;
	b=nPHwfX1f1A/IZ1TSnkp0cSP6MX1l/v1vZGH8lBk+b3QEBnhuC0j2i28qPRTPd/DtV
	 hNTPCbs21krpp7ER8N670EWhrP0sZooB24MJipoWLdmN44xBIITU6bTf21hUzRvBSQ
	 drt03Au4hwMX6Y/iOaf9fCTTrI68I1tU0zn03hmAG/geCdfJuQkG2fSZdn8ACc4qu4
	 SSgIXzeNQJvT7Do6rKFBc4GQ2qMJHfL/ZVr1cDvOwX1PUMsOkY9KmeXhiqbsa17AN9
	 Uv1YHoq/R2ddtCfijc2PC+8rdzuQ5UhhZP2ggU9JJdqDr85pqB0zkiRLOe81bkPpB7
	 tRKxaQUBWqwyg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID 0/4] HID: selftest fixes after merge into 6.11-rc0 tree
Date: Tue, 23 Jul 2024 18:21:50 +0200
Message-Id: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7Yn2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3bTMCl0zXUND3aSCNN3ktEQz45TklETTpGQloJaColSgPNi4aCU
 PTxel2NpaAH5DAGJjAAAA
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721751728; l=1241;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=FMzdl7ub859Z2WbgsSW6HhSuQj7usqZNfev9Tp8upxI=;
 b=mX/0FMEzPp3RQlq0qMvTxHOeYwsp571R+5/dsGb2h+Oez83GG7n+xDJUPPL0SgCg9xsD83Hxn
 Rx3Z7tKAZVYDQCMtC0KvlAKYfozftCvuhlqCnL4gYAGCHAYEUujxXpv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

After HID-BPF struct_ops was merged into 6.11-rc0, there are a few
mishaps:
- the bpf_wq API changed and needs to be updated here
- libbpf now auto-attach all the struct_ops it sees in the bpf object,
  leading to attempting at attaching them multiple times

Fix the selftests but also prevent the same struct_ops to be attached
more than once as this enters various locks, confusions, and kernel
oopses.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (4):
      selftests/hid: fix bpf_wq new API
      selftests/hid: disable struct_ops auto-attach
      HID: bpf: prevent the same struct_ops to be attached more than once
      selftests/hid: add test for attaching multiple time the same struct_ops

 drivers/hid/bpf/hid_bpf_struct_ops.c               |  5 +++++
 tools/testing/selftests/hid/hid_bpf.c              | 26 ++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            |  2 +-
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  2 +-
 4 files changed, 33 insertions(+), 2 deletions(-)
---
base-commit: 6e504d2c61244a01226c5100c835e44fb9b85ca8
change-id: 20240723-fix-6-11-bpf-cfa63dcda5bc

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


