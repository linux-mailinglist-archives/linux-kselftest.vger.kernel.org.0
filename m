Return-Path: <linux-kselftest+bounces-47809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32927CD475C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 00:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DCE6300463B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 23:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE931ED6B;
	Sun, 21 Dec 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+y71SnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5062FFDCB;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360623; cv=none; b=Z53iG/HUTek39J/7eJoOHc7SdtRhz56kTuw0VLQu9KaECHFkgrMnmF1XBUvM9cY4c0HAhYA9pOJa3A+mTFrxIBGsGLA8+ovEq69ZbeGpHubH/ApN6pgBazy5e14zUBGOiYOQl+2zQN67+zz4cNPjmppp3Pj8pJDe7iHGf+KErfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360623; c=relaxed/simple;
	bh=QBoH70Dkw89XQVaUU1T4z/oKmYh+dG59fCRv+673Egs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eMJ54GHZJ8w+8EwvS7GgnIPpXOmads7ykp91LyGlj3SXFPjOKLZOfG8ak8OpDf78ElkE2mOpWbXX5gCFEL9yjuXSsp/iaQotA/NrZyG4iiDvB9AKRM6kR7A6x7Iv1mn7UpEBSlEr/JFeO4I3VyEFl1w1vqWMvwmgHQBU1gWXum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+y71SnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94384C4CEFB;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766360622;
	bh=QBoH70Dkw89XQVaUU1T4z/oKmYh+dG59fCRv+673Egs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=E+y71SnR0RQtsyrD/t3o7215aYzIy7honF7KLzxHzpu1Lop3SaljQHoSZ5PBw4M4T
	 Z+P6lvKMFAEXELHOyZZsfsqf5anq/Z0lfszYPHdLO8cGEG8qiXpkpytCd8j0/EviTf
	 QTrnuU4WYufKOkG9yy0GdlsMIc8atTGoqKxwMsduI5+QdIg1U4AOPxUT9JHpHj+UGX
	 NfLTXrTEsqaUReT21Q5KVhgZaoSDVuegMVUbxWB6fBZE5k5bAAeYvsWrH1sxSAtVJY
	 gqDD7A8g+3iK3mP793wq2PfyMf3Ps38UVYxIAP5EJ3SRAMiH1sYbCyPsxHylWDR51p
	 5iWO79SDiPSmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E25D68BD5;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
From: Peter Hutterer via B4 Relay <devnull+peter.hutterer.who-t.net@kernel.org>
Subject: [PATCH v2 0/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD on
 compatible touchpads
Date: Mon, 22 Dec 2025 09:43:33 +1000
Message-Id: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NMQ7CMAxFr1J5xihJFaiYuAfqEDUu8ZJWcZuCq
 tydUDHi7f2v/7yDUGISuDU7JMosPMUK5tTAEFx8ErKvDEYZq+vhxjMG9jgnElkTzc5j5zqlBj/
 qTrdQl7Ub+XVYH33lwLJM6X08yfqb/nzmvy9rVEitIWsv1llzvW9hwuUcaYG+lPIB4agIIrYAA
 AA=
X-Change-ID: 20251111-wip-hid-pressurepad-8a800cdf1813
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766360621; l=1571;
 i=peter.hutterer@who-t.net; s=20251222; h=from:subject:message-id;
 bh=QBoH70Dkw89XQVaUU1T4z/oKmYh+dG59fCRv+673Egs=;
 b=cOwtMVQybWIsiV2IZpx4Z3rgHj+lWv5Y7FsaRvwvPvr7dSB6F71+YsnU5Emg2bPD7Eyki6K3m
 iT/VWkIKDAqC7BOJkSwGpjTge9T7D5GXAeV1JGhERfp5FwiUGmBfEqc
X-Developer-Key: i=peter.hutterer@who-t.net; a=ed25519;
 pk=QoL66HDbFudb9Xt36p2XxsSohZSHVHesRR9c0pI28a4=
X-Endpoint-Received: by B4 Relay for peter.hutterer@who-t.net/20251222 with
 auth_id=582
X-Original-From: Peter Hutterer <peter.hutterer@who-t.net>
Reply-To: peter.hutterer@who-t.net

Nicely enough MS defines a button type for a pressurepad touchpad [2]
and it looks like most touchpad vendors fill this in.

The selftests require a bit of prep work (and a hack for the test
itself) - hidtools 0.12 requires python-libevdev 0.13 which in turn
provides constructors for unknown properties.

[2] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes in v2:
- rebased on top of 6.18
- hid-multitouch changes split out into a separate patch
- Patches reordered for slightly nicer history, tests changes are
  grouped together
- Link to v1: https://lore.kernel.org/r/20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net

---
Peter Hutterer (4):
      HID: multitouch: set INPUT_PROP_PRESSUREPAD based on Digitizer/Button Type
      selftests/hid: require hidtools 0.12
      selftests/hid: use a enum class for the different button types
      selftests/hid: add a test for the Digitizer/Button Type pressurepad

 drivers/hid/hid-multitouch.c                       | 12 ++++-
 tools/testing/selftests/hid/tests/conftest.py      | 14 +++++
 .../testing/selftests/hid/tests/test_multitouch.py | 61 +++++++++++++++++-----
 3 files changed, 73 insertions(+), 14 deletions(-)
---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20251111-wip-hid-pressurepad-8a800cdf1813

Best regards,
-- 
Peter Hutterer <peter.hutterer@who-t.net>



