Return-Path: <linux-kselftest+bounces-48304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42CCF9122
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 16:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C584300E417
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3C1A5B9D;
	Tue,  6 Jan 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpwwydRv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1A495E5;
	Tue,  6 Jan 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713460; cv=none; b=D6hqtFk9bmt4HeoeV2SyhugXfdQ40vQV2Si7T9iYhqgJvMS4J4ZCAsX8anSCCTS8EDZifkTmN1WOYHVsO0l/AveNy8U88c83nVH5JC/6xyNuNhrTGIWhDRxw6tnjwohDb16Mbt2p2o+mjiY9I6T5+AYktW5N2gJL8xSp92Lv0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713460; c=relaxed/simple;
	bh=Mw7nfQCHeUM3uDi0R20dEexIPwWV8BLFQ41kVZNMYwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h9i9jUUu7bawIUQB9xl4YrAatz4g2Nz0mb0yJ3d6y8oNNR0uek3RbEe+XJ3wupuv59rIrvsX8paV/SB3QHSgXx7iGtOd2iBnDGwCxu/6I7P/LaNUGDsQQ7otioJRqUTMBQfCQQ5lwB61f0Dht75fLEybVGdbMO47rAYkEslZzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpwwydRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A1C116C6;
	Tue,  6 Jan 2026 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767713459;
	bh=Mw7nfQCHeUM3uDi0R20dEexIPwWV8BLFQ41kVZNMYwI=;
	h=From:Subject:Date:To:Cc:From;
	b=dpwwydRvgpZFKUzTTmDufq120UDCBnTfK7H8GM1ydxnkDDHfhXFWdHK/PdkoHwD1f
	 qtoxqQFGlvJZCOoVMIZJahhqTXavqvuzD3axEaBypIdKglCUrBo5i2zGH3rH6g6TjR
	 O5OrtiLgW/yc3vp2o51a7nhsAyJaWUKMWPWB/aEQRwUoj5yummP17X8EO7pwe40F5J
	 mYbTumKBLGwx6xLgKkoYFxqwNT6C66IZ7NntiT/df+jOYs/12KVRAHLfFlz+d8D1N2
	 rblRYza+/yP+82yH2Nos3JgLeiv+ZWfRzqocrfVzOpi3H/Zcb8W+tcg+Exa2VzCP5H
	 mJoG2xDFmThnA==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/2] HID: bpf: fix HID-BPF CI due to new compiler flags
Date: Tue, 06 Jan 2026 16:30:53 +0100
Message-Id: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G0hFKvgV8VBrqgGX0ooK4t8NH
 gdm5oHMSThDWzyQ+JQs+6ZgygL87LaJUUZlqKiyZMjiJRGD3DjEgH5foyzu0Abrhhqm4JwfDGg
 dE6v2n7v+fT9uzZnFaQAAAA==
X-Change-ID: 20260106-wip-fix-bpf-compilation-4707e0faacb1
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767713457; l=793;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Mw7nfQCHeUM3uDi0R20dEexIPwWV8BLFQ41kVZNMYwI=;
 b=MbYPLEhUr8pYGRZLhFk5HldGIrNl86gko1KGYhfaUmAHlPUQ0kgSyjLlfZTOkfz5pfYcJXT3M
 IIVrerHi+HoDRA0/mmVh/Q6JfH5f7U+sfUNVB+V2QOKq+OR6YD6NIvQ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Since the merge with v6.19-rc my CI is broken because of the newly
enabled -fms-extensions.

Add the missing flags when generating the CFLAGS for bpf.o to solve this
and continue running the tests while applying the patches.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (2):
      HID: bpf: fix bpf compilation with -fms-extensions
      selftests/hid: fix bpf compilations due to -fms-extensions

 drivers/hid/bpf/progs/Makefile       | 6 ++++--
 tools/testing/selftests/hid/Makefile | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: fde4ce068d1bccacf1e2d6a28697a3847f28e0a6
change-id: 20260106-wip-fix-bpf-compilation-4707e0faacb1

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


