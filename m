Return-Path: <linux-kselftest+bounces-822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF4E7FDB2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E52282C19
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9D374FA;
	Wed, 29 Nov 2023 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhX2ObSP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F137146;
	Wed, 29 Nov 2023 15:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241E9C433C7;
	Wed, 29 Nov 2023 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271501;
	bh=cZBkVWd4/6X6QdhqP9qGKmaGIqbyGs6bbXMaN3ewrnE=;
	h=From:Subject:Date:To:Cc:From;
	b=QhX2ObSP4vuiRN89P3DObSkygZj45XzBHq0O57ay8hpLuz5qJM3jzw1br1tonuGM6
	 U4mtnbvtDNL20/7q18PRF+qQ4asBaD71fkpzgZy2BXwVGsHJqlwBJWQlcEZ5Htijr7
	 LigfN2aX4Pd5kYkZ7GP3kIoBtkzYOJj/hd0NrTZGkE43xtz/ceqs94MWHOh3mTB+u2
	 JgzrKS6xJR1/NJFlY/w8hS2dV6RODrdJCRCIdaAz/s6QsCPPsLmRJcEXUaA18J88cY
	 CKXHXhYSrWEOxmo04eJHvaOGJlzuW+aesKSW8eTmH3cnq/AL6T+QqMOom0nIsGCZJZ
	 Ntp5bte5WOf2w==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 00/12] selftests/hid: tablets fixes
Date: Wed, 29 Nov 2023 16:24:25 +0100
Message-Id: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlXZ2UC/x3MMQqAMAxA0atIZgtNFBWvIg5FowZEpSkqlN7d4
 viG/yMoe2GFvojg+RaV88jAsoBpc8fKRuZsIEsVIqF55DLK+xJYgxpr0U01tWy7BnJzeV7k/X/
 DmNIHXPFSuF8AAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1942;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cZBkVWd4/6X6QdhqP9qGKmaGIqbyGs6bbXMaN3ewrnE=;
 b=sAY39EC2SafO3vFoESZlRu2bryuijrK3ykmpRUQU/H9rmM2cLfZt1Y+vBZSgqfpI1hDW4or2b
 kF/NgbmL04wDPW1m3dNaZx6nhX6BwGZPQ7wdd8xJUP1p+qLGRWH2DuO
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

[0] https://lore.kernel.org/all/nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm/

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (12):
      selftests/hid: vmtest.sh: update vm2c and container
      selftests/hid: vmtest.sh: allow finer control on the build steps
      selftests/hid: base: allow for multiple skip_if_uhdev
      selftests/hid: tablets: remove unused class
      selftests/hid: tablets: move the transitions to PenState
      selftests/hid: tablets: move move_to function to PenDigitizer
      selftests/hid: tablets: do not set invert when the eraser is used
      selftests/hid: tablets: set initial data for tilt/twist
      selftests/hid: tablets: add variants of states with buttons
      selftests/hid: tablets: convert the primary button tests
      selftests/hid: tablets: add a secondary barrel switch test
      selftests/hid: tablets: be stricter for some transitions

 tools/testing/selftests/hid/tests/base.py        |   3 +-
 tools/testing/selftests/hid/tests/test_tablet.py | 727 ++++++++++++++++-------
 tools/testing/selftests/hid/vmtest.sh            |  46 +-
 3 files changed, 525 insertions(+), 251 deletions(-)
---
base-commit: 4ea4ed22b57846facd9cb4af5f67cb7bd2792cf3
change-id: 20231121-wip-selftests-001ac427e086

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


