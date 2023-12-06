Return-Path: <linux-kselftest+bounces-1264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1653806C6D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30431C209D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B61A593;
	Wed,  6 Dec 2023 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv8bVqp2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A113AEA;
	Wed,  6 Dec 2023 10:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13FCC433C7;
	Wed,  6 Dec 2023 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859567;
	bh=MP5Osqlk3WWNvfz1umQL4sknHomsrrNZ86F+mX66gqk=;
	h=From:Subject:Date:To:Cc:From;
	b=Vv8bVqp2O73pOUsQgqYfaeWi+3TOeCIJt97guWPdh9zct6Y6R1QAWpa3khsidJCQJ
	 f6C++TP6HtzbWRI7TSTbsz+SfBuJa4L3Gpwtel6yd1PDTr46b3r/eNnEb73w11a5cy
	 vIAW486Cq5wgeDtTEwiJ3XkVQRbc0n+UNU2MPJo1Y0c0ZJgGpMuLOjt21h01k04pXn
	 7PqFMnUbZUZso+VsI7DG4FBNi10PEPlpOsg99SO6nN3Q4vnDrX5D1zu/k1oMXPHA/4
	 7BgLlxAAjo0tDlbFfvvrHMBeKUXcH4GoLjXtlnnHSBOxJBD94igHQ0vGTilgBtQuoN
	 iyWd52/MeHgGQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 00/15] selftests/hid: tablets fixes
Date: Wed, 06 Dec 2023 11:45:51 +0100
Message-Id: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9QcGUC/13MywrCMBCF4VcpszaSiXdXvod0kbaTdrA0JROiU
 vLuxoIbl/+B8y0gFJgErtUCgRIL+6mE2VTQDnbqSXFXGow2O0SD6smzEhpdJImitEbb7s2J9Pk
 I5TMHcvxavXtdemCJPrxXPuF3/UmXPymh0qqxeLDoCBvd3R4UJhq3PvRQ55w/jlbesqsAAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=2588;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=MP5Osqlk3WWNvfz1umQL4sknHomsrrNZ86F+mX66gqk=;
 b=yRG7lL0VsLWZfjQjVIZklm361Zje0ATbNRtCMBXruossTn9s51/kgTVezacnjtazhcOJjaZkV
 5JZMgPzMqo3AaOi3Ew/NYH3WcFjwgDJgzT50o4hikvwTwsRdUYja/l+
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Hi,

the main trigger of this series was the XP-Pen issue[0].
Basically, the tablets tests were good-ish but couldn't
handle that tablet both in terms of emulation or in terms
of detection of issues.

So rework the tablets test a bit to be able to include the
XP-Pen patch later, once I have a kernel fix for it (right
now I only have a HID-BPF fix, meaning that the test will
fail if I include them).

Also, vmtest.sh needed a little bit of care, because
boot2container moved, and I made it easier to reuse in a CI
environment.

Cheers,
Benjamin

Note: I got the confirmation off-list from Peter that his
rev-by applied to the whole series.

[0] https://lore.kernel.org/all/nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm/

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- took Peter's review into account
- Added a few patches to make mypy and ruff happy given that
  I had to add a couple of type hints here and there
- Link to v1: https://lore.kernel.org/r/20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org

---
Benjamin Tissoires (15):
      selftests/hid: vmtest.sh: update vm2c and container
      selftests/hid: vmtest.sh: allow finer control on the build steps
      selftests/hid: base: allow for multiple skip_if_uhdev
      selftests/hid: tablets: remove unused class
      selftests/hid: tablets: move the transitions to PenState
      selftests/hid: tablets: move move_to function to PenDigitizer
      selftests/hid: tablets: do not set invert when the eraser is used
      selftests/hid: tablets: set initial data for tilt/twist
      selftests/hid: tablets: define the elements of PenState
      selftests/hid: tablets: add variants of states with buttons
      selftests/hid: tablets: convert the primary button tests
      selftests/hid: tablets: add a secondary barrel switch test
      selftests/hid: tablets: be stricter for some transitions
      selftests/hid: fix mypy complains
      selftests/hid: fix ruff linter complains

 tools/testing/selftests/hid/tests/base.py          |   7 +-
 tools/testing/selftests/hid/tests/test_mouse.py    |  14 +-
 tools/testing/selftests/hid/tests/test_tablet.py   | 764 ++++++++++++++-------
 .../selftests/hid/tests/test_wacom_generic.py      |   6 +-
 tools/testing/selftests/hid/vmtest.sh              |  46 +-
 5 files changed, 567 insertions(+), 270 deletions(-)
---
base-commit: 4ea4ed22b57846facd9cb4af5f67cb7bd2792cf3
change-id: 20231121-wip-selftests-001ac427e086

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


