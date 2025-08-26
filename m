Return-Path: <linux-kselftest+bounces-39943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6745EB35F43
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC85C36519F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBBC340D8E;
	Tue, 26 Aug 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC5w6rYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91208307484;
	Tue, 26 Aug 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211996; cv=none; b=tjsWynZ4rmPsmiabUhK/dEHk+N0q47gjpHZ9FC7g1hwKWkxzVYSlNtfSRdbQGg+mfVY2YqTOEe5X696erMg0mIMjsjM09+32y/TYdHBa0cBIW4vycScLaTZkZX24s8QHgUy/dlMrWsmYvwkOUdmmEjwHnoGkffIsrTToLcc7Sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211996; c=relaxed/simple;
	bh=FdTxkx27DEI4OddOd/l4Cuq+3wL3DnqDXP41ZxT66wQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UU8g33Oc2BBUbV8nzl0jZYOCPTc5u4pucTQqf3JGQ0N56r9N7/+BQIybakfXYHEEyNNK/5N+7Nj44NmANBiYWwfIYTxzWxChThVDcw0KyheyEdpn4c0p1i4pVHMNaHzg5LhzBRxqnqgEXiIXPUzjO7I9CToNTiHhj2PURMIjIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC5w6rYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8373C19422;
	Tue, 26 Aug 2025 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756211995;
	bh=FdTxkx27DEI4OddOd/l4Cuq+3wL3DnqDXP41ZxT66wQ=;
	h=From:Subject:Date:To:Cc:From;
	b=AC5w6rYOpqfy4A3s3qhmc2ysemAvxx3gKHj/LVVvO4yTPUY9LZaJS/7PuOE4ABjzm
	 QNX3VZyrsbKxxwnwkR/wqCKsblVBHt1vOngzuGzxE46FcSCSJqfLylAQAtbZ2BqOu0
	 U3yXcIjvTfiR/kq+cIqy71DeRgHb2bWnknYgvzXvDjKjAvFt6LAcoC6WjcwSXy0YmP
	 uQd6pIamL2q7yBM/MYfHrfcvSNQvMhTv71QvTKwxLN3kYN2rxBKHQbV2JpcZk+bvXs
	 uzo7E0gMHsICQDMol7KT6jJSHWWp/s3UNM4tPDEzpXzJcUzsW44OwWvzAoFdxC3G71
	 KfZDMv3ByteAw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 0/3] HID: hidraw: rework ioctls
Date: Tue, 26 Aug 2025 14:39:38 +0200
Message-Id: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqrrWgC/0XMQQ6CMBBA0auQWTukDNCiK+9hXFQYYCK2ZkrUh
 HB3Gzcu3+L/DRKrcIJTsYHyS5LEkEGHAvrZh4lRhmwgQ63pqMVbg7MM6t8osV+XhNaOdUNHZ2r
 ykLOn8iif3/JyzR41PnCdlf1/5KrKOOoaV1JX26MlrNBrGM531sBLGXWCff8CvgPp3J0AAAA=
X-Change-ID: 20250825-b4-hidraw-ioctls-66f34297032a
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756211993; l=1497;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=FdTxkx27DEI4OddOd/l4Cuq+3wL3DnqDXP41ZxT66wQ=;
 b=Ehpo9uX+I+5To0S/HtUZphec62X4XoCGF1CHNK+99O3EF/JqRZEZuOrRHAYMCDwppr2pPsXwE
 vn95o49EWksA2kCoco8qmcp8x4NQwQoKh0B37tdwkcoyxgWKVNlHR6q
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Arnd sent the v1 of the series in July, and it was bogus. So with a
little help from claude-sonnet I built up the missing ioctls tests and
tried to figure out a way to apply Arnd's logic without breaking the
existing ioctls.

The end result is in patch 3/3, which makes use of subfunctions to keep
the main ioctl code path clean.

Arnd, I kept your From: and SoB fields, please shout if you are unhappy.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
changes in v2:
- add new hidraw ioctls tests
- refactor Arnd's patch to keep the existing error path logic
- link to v1: https://lore.kernel.org/linux-input/20250711072847.2836962-1-arnd@kernel.org/

---

Jiri, checkpatch.pl complains about my co-develop tag. Did we get some
consensus for AI-assisted tag?

---
Arnd Bergmann (1):
      HID: tighten ioctl command parsing

Benjamin Tissoires (2):
      selftests/hid: hidraw: add more coverage for hidraw ioctls
      selftests/hid: hidraw: forge wrong ioctls and tests them

 drivers/hid/hidraw.c                     | 224 ++++++++-------
 include/uapi/linux/hidraw.h              |   2 +
 tools/testing/selftests/hid/hid_common.h |   6 +
 tools/testing/selftests/hid/hidraw.c     | 473 +++++++++++++++++++++++++++++++
 4 files changed, 603 insertions(+), 102 deletions(-)
---
base-commit: b80a75cf6999fb79971b41eaec7af2bb4b514714
change-id: 20250825-b4-hidraw-ioctls-66f34297032a

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


