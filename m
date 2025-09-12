Return-Path: <linux-kselftest+bounces-41409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0EDB55530
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F27AC3688
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960931B130;
	Fri, 12 Sep 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4ZaR96j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DA1FCCF8;
	Fri, 12 Sep 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696337; cv=none; b=jVPaEnIhn3p4YUEmImj3v4/mftmRtLUfbnV+9kpUw6DnwoH+kUPfB+Knp25obBph8wckhO/zagVjEIDgtvl8FovVrNBKOI2jpE9gPSiOvdKUHpas47kKfDl5sGhP+LjYatIosNTyO9s4NP4zWp6Y38hr5mmQpLZUE8fAlaYIN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696337; c=relaxed/simple;
	bh=gtfvdfI+H0ACLSjUJUR2tLLcJx+U29SK+JJDuNQ7ox8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JK74nUHqmhdW17Tmj4ryYGG5vljE8D6p+UMiUkhul/XROmE3T88MXBvPeyq2s+eJ3WVRhqkKEhKQLS/JscwSopZmCmykfAQiK5C5qChB76ds2zAavmf0D5RtsarO8SYzqPj/WOE4RMhokkjrUutkr3M9w14DmJyuaknbTk56GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4ZaR96j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61234C4CEF1;
	Fri, 12 Sep 2025 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757696336;
	bh=gtfvdfI+H0ACLSjUJUR2tLLcJx+U29SK+JJDuNQ7ox8=;
	h=From:Subject:Date:To:Cc:From;
	b=f4ZaR96j9y4Fv5BDp+3cD7er4v0fcdLgYSL8Iv6eBUrcgDCxoCc6kPkEwHyqfpmoG
	 Wcqf7jK79M4mn80aGGGjXIRk+9rSUI51Sqz6dOJ1jCOtVFwqCiG/4SDoxhxOyzQzwY
	 YXO99uuwxX7AmbjdKQxrQgOA7o6wYROVT+DzYKTg6eAXxbE7dSc61Wr7yvBp5Ow3wi
	 owL7QJadoG5ELCdNdwiIynbxhz6+ehKFLOfz/JbQCVpR2zd9qbXwrsFen/adADHur+
	 4vpdkTZafAsKMjUPRjN2bPGDBxKjdkWbDOioPqWAp7+Y4ziMdye7MjdN9fD5gAWKQM
	 bdIv+TXQWP+kA==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v3 0/3] HID: hidraw: rework ioctls
Date: Fri, 12 Sep 2025 18:58:48 +0200
Message-Id: <20250912-b4-hidraw-ioctls-v3-0-cd2c6efd8c20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEhRxGgC/2XOQQ6CMBCF4auQrh1SptCCK+9hWBQotFFbMyWoI
 dxdIDGauPwX78ubWTTkTGTHZGZkJhdd8GuIQ8Jaq/1gwHVrM+RY8BILaHKwriP9ABfa8RpByl7
 kWCkuULN1difTu+dOnuu1ewo3GC0Z/YVUlnGFZa5SLIWsJEIGmnx3uhjy5poGGjbKujgGeu3nJ
 tzAzw/5/2NC4NAqhbJBIVVW/WL1sixvmJDOfewAAAA=
X-Change-ID: 20250825-b4-hidraw-ioctls-66f34297032a
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757696335; l=1534;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=gtfvdfI+H0ACLSjUJUR2tLLcJx+U29SK+JJDuNQ7ox8=;
 b=Ge/420ffPrqyxuns74cDDV0Rzuf5zWMRe4nIq/DbhZh85ai6UUD1mgEeZf8HLly0V4IMJgK8U
 Y07ZmMzWIdsBXq4a2/Bh0mAqQj4DEk9dQW7aer/6ya+KE3b7p1/eKUr
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Arnd sent the v1 of the series in July, and it was bogus. So with a
little help from claude-sonnet I built up the missing ioctls tests and
tried to figure out a way to apply Arnd's logic without breaking the
existing ioctls.

The end result is in patch 3/3, which makes use of subfunctions to keep
the main ioctl code path clean.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v3:
- dropped the co-developed-by tag and put a blurb instead
- change the attribution of patch 3/3 to me as requested by Arnd.
- Link to v2: https://lore.kernel.org/r/20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org

changes in v2:
- add new hidraw ioctls tests
- refactor Arnd's patch to keep the existing error path logic
- link to v1: https://lore.kernel.org/linux-input/20250711072847.2836962-1-arnd@kernel.org/

---
Benjamin Tissoires (3):
      selftests/hid: hidraw: add more coverage for hidraw ioctls
      selftests/hid: hidraw: forge wrong ioctls and tests them
      HID: hidraw: tighten ioctl command parsing

 drivers/hid/hidraw.c                     | 224 ++++++++-------
 include/uapi/linux/hidraw.h              |   2 +
 tools/testing/selftests/hid/hid_common.h |   6 +
 tools/testing/selftests/hid/hidraw.c     | 473 +++++++++++++++++++++++++++++++
 4 files changed, 603 insertions(+), 102 deletions(-)
---
base-commit: 02d6eeedbc36d4b309d5518778071a749ef79c4e
change-id: 20250825-b4-hidraw-ioctls-66f34297032a

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


