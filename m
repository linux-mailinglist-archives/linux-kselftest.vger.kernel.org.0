Return-Path: <linux-kselftest+bounces-16289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293C95F576
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B7B1F2234F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6577191F75;
	Mon, 26 Aug 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6SHwfQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E85B69E;
	Mon, 26 Aug 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687288; cv=none; b=nrH7olIgz8h8IyVv30H8Yu3DxexQOjS//jjBa84xdXW3CSrNjl5t1dnvdoSUiGjZEB286pJM2YcMUS7CBk3mLGidaXGJPIQJBk1RFD9DEF5Nmh09Kya1DxEo87G44sWXMVCUho3KYJdDevEdlt43ex082JbG160CcDJffCStUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687288; c=relaxed/simple;
	bh=qsqOmdE6pb2KOZdqN9c9wP9ZIiop87YaLOiibDRDe/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BENqDuHqKYqVuEWTnj72GMY7KgwyJEb8hUAJnqCJNZIxUa6YWr4kq5/JGrSn3FLgAIRNJM4k0TS/iOOkKegw9x2syKKXvKf+JiHhVo7CjaCcjzX7QydowbzawggxktxxxqRFT0fISEns6vJSk/M7UMhpLRf+tC8SSDJUpnamW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6SHwfQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A520DC4DDF7;
	Mon, 26 Aug 2024 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687288;
	bh=qsqOmdE6pb2KOZdqN9c9wP9ZIiop87YaLOiibDRDe/U=;
	h=From:Subject:Date:To:Cc:From;
	b=e6SHwfQtqXVTwFEN72/WkzoWuMLQpPzzdNROQ38TeXcQDiohgNPtcXcO5saTgd45m
	 tEOzGBmMqqbFR8vp9DD+LhLGneaDsEh98lB+sldyuthgBb2J0UCUr798yTow1qeuYc
	 0+clz8xthfe8iKijtmnKg+Vy/iQuarnbgO3PXRyRBrbbrLltaHWpgDWf1isngT5188
	 AxBRUxrbn1IxDI96cJ+KmbRPNxRNTVlyWeJRFFaO5L50Gy4HIKuXakR+9bZMqSQerl
	 dqaT62i86jfapQxj+HDPTp860HnbRIogcxBwc2Hk912h24F+6Jch9N2Um4/hOQZJm+
	 /FQGWBliMWIkw==
From: bentiss@kernel.org
Subject: [PATCH v4 0/3] HID: hidraw: HIDIOCREVOKE introduction
Date: Tue, 27 Aug 2024 00:47:50 +0900
Message-Id: <20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKajzGYC/x2MQQqAIBAAvxJ7TrBNKvpKdNDccgk0FCoQ/550H
 JiZDIkiU4K5yRDp5sTBV1BtA5vT/iDBtjKgRCUnHIRjG/UjqhtOElJLJGOwG1UPtbki7fz+v2U
 t5QNha+ttXwAAAA==
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724687286; l=1457;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=qsqOmdE6pb2KOZdqN9c9wP9ZIiop87YaLOiibDRDe/U=;
 b=HJ2Up3B9fo/XXAzfiRgID8W4OS1j21lqG/N+qjFd4Gd+jJxj3XluywROLeDFl79PDH8UKf1Bi
 U2Brse6CJuFBAIzm+3NdbqvyvL/92V6KDMgKvZOGXE/aMH0H4D7LBHh
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The is the v4 of the HIDIOCREVOKE patches.

Link to v3: https://lore.kernel.org/all/20240812052753.GA478917@quokka/

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
Benjamin Tissoires (2):
      selftests/hid: Add initial hidraw tests skeleton
      selftests/hid: Add HIDIOCREVOKE tests

Peter Hutterer (1):
      HID: hidraw: add HIDIOCREVOKE ioctl

 drivers/hid/hidraw.c                   |  39 +-
 include/linux/hidraw.h                 |   1 +
 include/uapi/linux/hidraw.h            |   1 +
 tools/testing/selftests/hid/.gitignore |   1 +
 tools/testing/selftests/hid/Makefile   |   2 +-
 tools/testing/selftests/hid/hidraw.c   | 665 +++++++++++++++++++++++++++++++++
 6 files changed, 704 insertions(+), 5 deletions(-)
---
base-commit: 6e4436539ae182dc86d57d13849862bcafaa4709
change-id: 20240826-hidraw-revoke-0a02ebb21743

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


