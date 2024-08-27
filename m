Return-Path: <linux-kselftest+bounces-16376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C00960435
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B94282E7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686231946A0;
	Tue, 27 Aug 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciE157JN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794554F87;
	Tue, 27 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746787; cv=none; b=D9sui+zM+LuWmOvS9lt7MNioEC3MW976EWh+3ygSohW74DieJsrdnq02hURa6rHunFwxx7oXh+3nUr3aP6OZ+0hAj4+aGLUgTbgCHc3AbGsSgknL/nO6rXss0vLZONfs4aoLUOjSuNO8a4vrluZCs973HJghVfFinMvdcRPiSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746787; c=relaxed/simple;
	bh=l9jLhRaVNGsjftqzso7Iz+62AT9OrJ7AK6WJFJW4oLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XDDFjI/6+gOTFufHCtZAIlxmwsQ6Qos0nQRt//PViQEYFFNb6+A6+6tA0vSUTPfheY1cUbGOIoFLr7wJBxHCvkApH8DBtthZhEZyEAQOxVhpgsl2n9e49Bf9JtXS7iH65VDUGSXMHx1r4AnUpb6s95vVU6k99LCLDsueYSUuttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciE157JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A368C8B7B2;
	Tue, 27 Aug 2024 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724746786;
	bh=l9jLhRaVNGsjftqzso7Iz+62AT9OrJ7AK6WJFJW4oLE=;
	h=From:Subject:Date:To:Cc:From;
	b=ciE157JNfiab/8KNP7ALzeNUL2ejolZbKZUUjCxKeJM9k0bf0mKJUol6wLEarXTfh
	 3wM1qAczfPNeC1BtI0byrlyGLU5oKN7O7S+ewBI6YueCuvaTHGb9f+E+2Mx94sf1S2
	 hUHMvRZkCcXHTuwWPJFA2YscPPr5WdjoXDCWZYa67Vam5AnO09JhxjjNNYGfFJp2G2
	 JRefogPepfpzLXqFnDLyxqZZScS1mUkiTyIymGVMrqIzVsoHBgN639n6wSzCq2ak81
	 BDS27pxDhot4DneK1vArzC8d7nkHhbwQIJcsork+GCuVynhjNeJipcB+I19uKy/VEy
	 kvulBy/SxbG/g==
From: bentiss@kernel.org
Subject: [PATCH v5 0/4] HID: hidraw: HIDIOCREVOKE introduction
Date: Tue, 27 Aug 2024 17:19:28 +0900
Message-Id: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCMzWYC/13MQQ7CIBCF4as0sxaDSAu68h6mC2in7aSmmMGgp
 uHuYhM3Lv/JvG+FiEwY4VytwJgoUlhK1LsKusktIwrqS4OSSkurGjFRz+4pym+YUUgnFXqvDkY
 foWzujAO9Nu/alp4oPgK/Nz7p7/UnmT8paSGFtV1jTrUfbGMuM/KCt33gEdqc8wfc7oiHqwAAA
 A==
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724746785; l=1951;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=l9jLhRaVNGsjftqzso7Iz+62AT9OrJ7AK6WJFJW4oLE=;
 b=pJvnN49V0o3khwN0tyBhamjORVIZ5yyRXlMzJCj9y75vi6aWvq9IQRR0ooML45p/ZDhjRnhbi
 b7beTbM1LS5AgKKWDf2ZbSBAXsSa34Rav0f78fXmin9h0atATHWLgru
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The is the v5 of the HIDIOCREVOKE patches.

After a small discussion with Peter, we decided to:
- drop the BPF hooks that are problematic (Linus doesn't want
  "ALLOW_ERROR_INJECTION" to be used as "normal" fmodret bpf hooks)
- punt those BPF hooks later once we get the API right
- I'll be the one sending that new version, given that it's easier for
  me ATM

For testing the patch, and for convenience, I added a new selftest
program that can test this new ioctl. This will also allow us to
integrate the (future) BPF hooks and show how this should be used.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v5:
- check for ENODEV when required in selftests
- create new common header for the HID tests that can be reused in other
  HID selftests
- Link to v4: https://lore.kernel.org/r/20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org

Link to v3: https://lore.kernel.org/all/20240812052753.GA478917@quokka/

---
Benjamin Tissoires (3):
      selftests/hid: extract the utility part of hid_bpf.c into its own header
      selftests/hid: Add initial hidraw tests skeleton
      selftests/hid: Add HIDIOCREVOKE tests

Peter Hutterer (1):
      HID: hidraw: add HIDIOCREVOKE ioctl

 drivers/hid/hidraw.c                     |  39 ++-
 include/linux/hidraw.h                   |   1 +
 include/uapi/linux/hidraw.h              |   1 +
 tools/testing/selftests/hid/.gitignore   |   1 +
 tools/testing/selftests/hid/Makefile     |   2 +-
 tools/testing/selftests/hid/hid_bpf.c    | 437 +------------------------------
 tools/testing/selftests/hid/hid_common.h | 436 ++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/hidraw.c     | 237 +++++++++++++++++
 8 files changed, 714 insertions(+), 440 deletions(-)
---
base-commit: 6e4436539ae182dc86d57d13849862bcafaa4709
change-id: 20240826-hidraw-revoke-0a02ebb21743

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


