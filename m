Return-Path: <linux-kselftest+bounces-13002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328DC91DF84
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD6A2828E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E87158DA1;
	Mon,  1 Jul 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLBnuc/m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEC77115;
	Mon,  1 Jul 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837606; cv=none; b=qqxoxsCCy3zxnjNshNvZBtdT6A4zcU0d98Vc5bybg7FZdPsWcfxddvbO7192UNcSfp1scbBHoP3XHdg35ObP/7Q1Bw6XQU88KpChlPBjiT2SdOS9yvySWGlAOytEZn+q+6N6/osVMqOmVrDNiBQBuYfDPqJV3ry47eEAIn/UrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837606; c=relaxed/simple;
	bh=e+eEkYsgdY+YmdywxsbLna9/WCkd8alNpTWRJQTosNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kHoOknxx+3Ac+mTQVfuhzBfSR+vMlAtCG4Ubm2H6KjMGq7vP6VNBFvo3teffk4NaET/83crdSrvbsimyGru7ccU0yIzBf86g1uooy1aWvM4eMH5kSHq187tFcJy/lq3BtK5SVFq/bIFcc6/VXqglX4p0RxXYBnlFG0aq8wVKwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLBnuc/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBF2C116B1;
	Mon,  1 Jul 2024 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837606;
	bh=e+eEkYsgdY+YmdywxsbLna9/WCkd8alNpTWRJQTosNE=;
	h=From:Subject:Date:To:Cc:From;
	b=oLBnuc/mj5AteF6VpOm8Vf5fizejOW4VPUI82MQN8GQzguOhWgFsf0gjFGxWVyj4p
	 +HNwU7nCieS8rcICMq96EpVTMOOe1Gq4hOoLUTjnY/BZ+YKK36wie2onoO9ByRYy42
	 939Eh9egAXsYRH7zLw1SsugS5GJNHSUdinTDAjE1Y4BLKCFq2rA3ACI7xNR5LGqeOD
	 bBv2r7fougAwm6e+mBTpn7/QpJ88S61c+HZXToLlfvQyT7/xwmVggWARaf4BOJ4Rtz
	 XoI39h+F8THY1Gk3+W5Hsjrcm3jx/V9QKRGYsYGju0HtiBsv/briCpXoBgx/vHTfOY
	 i0gFSgavcol6Q==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 0/4] Fix warnings in for-6.11/bpf
Date: Mon, 01 Jul 2024 14:39:48 +0200
Message-Id: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSjgmYC/2WMQQ6CMBBFr0Jm7RhaoTWuvIdhUeoUJphipqbRk
 N7dytbl+//lbZBImBJcmg2EMideYwV9aMDPLk6EfK8MutVda7TFwG/0C2M4WX3uez8GE6DaT6F
 67aXbUHnm9Frls4ez+q3/jaxQoR4768l5pYy7LiSRHsdVJhhKKV8t1lrPnwAAAA==
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Mirsad Todorovac <mtodorovac69@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719837604; l=1561;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=e+eEkYsgdY+YmdywxsbLna9/WCkd8alNpTWRJQTosNE=;
 b=xR6TwFULWoXBOP88iMBAyq5yaUBdDpXWbTvsjow53tNj+wbpjRyCVPuvnq564t34BQOev+cqe
 0OPeta2p0r4ARuOtXB9Yl9PQ67o3jfvwtcmooC4CH7TLWWJmwMKW5TD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We had several complains in linux-next that there were warnings:

CKI was not happy: it was the same situation than in an early report
when HID-BPF was initially included: the automatically generated
vmlinux.h doesn't contain all of the required structs and the
compilation of the bpf program fails.

We have multiple pointer to int cast complains and some docs that were
not rendered properly.

Include everything here.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- Also fix the pointer to int casts
- Also fix the docs complains
- Link to v1: https://lore.kernel.org/r/20240627-fix-cki-v1-1-2b47ceac116a@kernel.org

---
Benjamin Tissoires (4):
      selftests/hid: ensure CKI can compile our new tests on old kernels
      HID: bpf: fix gcc warning and unify __u64 into u64
      HID: bpf: doc fixes for hid_hw_request() hooks
      HID: bpf: doc fixes for hid_hw_request() hooks

 drivers/hid/bpf/hid_bpf_dispatch.c                 |  8 +++---
 drivers/hid/bpf/hid_bpf_struct_ops.c               |  2 +-
 drivers/hid/hid-core.c                             |  4 +--
 drivers/hid/hidraw.c                               |  6 ++---
 include/linux/hid_bpf.h                            | 31 +++++++++++++---------
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 16 +++++++++++
 6 files changed, 44 insertions(+), 23 deletions(-)
---
base-commit: d3e15189bfd4d0a9d3a7ad8bd0e6ebb1c0419f93
change-id: 20240627-fix-cki-f372855cbf6f

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


