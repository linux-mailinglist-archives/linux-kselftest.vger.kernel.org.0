Return-Path: <linux-kselftest+bounces-36970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE57B00498
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9108C1C87067
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D51271457;
	Thu, 10 Jul 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YylczEb/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B95271451;
	Thu, 10 Jul 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156141; cv=none; b=gueLHtHTC1ynZrgujWqOt4XZAwsL2uCLgQlNTNY4cPWQEt9yEZtLwvCXjmlTQax+VNamMvyJfUooGKsiDUEA2Vw5hNNLLeQanBOS6YNzDvPV6pH6geTt5+rhUUE40UBgxc4/r8/dOboftAE/WsdDoinIWCxGXd2P5Wt9lXD3wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156141; c=relaxed/simple;
	bh=xXPB/krLKx5YsOpAfTB0Ww2kYd94E1CsAKd5TLeuqrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uxnSdbv+7hqEQRfgTXAInw+Xv9qlPGw37BsghqEaOoY23hVYVpWXkd4QftlHUnTfD+q8QDdWQ+K4Mu/MLD1qQfEPE+uzyQPuZ5AFGUQUDGttp6ybkOR7YAV3lWWAnbTxoa+KvpZZPMzNrWdDxWsIipRdcYLs267HFXQA++JL2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YylczEb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26ABC4CEE3;
	Thu, 10 Jul 2025 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156140;
	bh=xXPB/krLKx5YsOpAfTB0Ww2kYd94E1CsAKd5TLeuqrU=;
	h=From:Subject:Date:To:Cc:From;
	b=YylczEb/lpnvmcs+P22XXkdPq/SEHyRIDf3OPwak+WOEA4wZWlKpy/b9/mTwQ6lVI
	 wRtXJJ0oaQMmxlf/sbfy3i/izV6QaKUz9THsxoLk6yqzRaO5AcXmAxcAoX1THklQq/
	 6KQGS5BFnIIkSa0gvXI4Asy4OIkbz8K2/2WUN5i+wA3NmXyBG5pp3jh5UYX3QkVUIm
	 1/B9vOOVktg5jWWMSkDv2Tq8UJ365IKeUHQqUHLYqCA8tUMUM51zz781ABjVd161ta
	 Gcjygpjmhc6RJYQarpgKBFFvPiS5ekgaQUSoYRpEvBejuk0Aujam+TrucL8kazEF9S
	 YfkiOWuDFfQYg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 0/4] HID: core: fix __hid_request when no report ID is
 used
Date: Thu, 10 Jul 2025 16:01:32 +0200
Message-Id: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzHb2gC/32NQQ6CMBBFr0Jm7Zi2ilBW3sOwQBxhYtOSKTYq4
 e5WDuDy/fz//gKRhClCUywglDhy8BnMroB+7PxAyLfMYJQpVaUsCk1BZoz8IfRP5/BQnbSlLhf
 qGvJsErrza1Ne2swjxznIe3tI+pf+kSWNCrU9Wm2MLvtrf36QeHL7IAO067p+AcPypKixAAAA
X-Change-ID: 20250709-report-size-null-37619ea20288
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org, 
 syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752156138; l=1787;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xXPB/krLKx5YsOpAfTB0Ww2kYd94E1CsAKd5TLeuqrU=;
 b=IFj366RpTlWoirqo7i2wkkLeCbj1DlUUPzN43PDtX5SZJYaE7OIToip08KhVVMdsr4LtEJwOb
 UPyxz37iaKxDz18vh+RxwYPwsPDqnt6kfPcZKLGmJxO++5UINOtv3Ew
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

New version (unchanged for patches 1-3), with a test added so we can
detect this.

Followup of https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/

This initial series attempt at fixing the various bugs discovered by
Alan regarding __hid_request().

Syzbot managed to create a report descriptor which presents a feature
request of size 0 (still trying to extract it) and this exposed the fact
that __hid_request() was incorrectly handling the case when the report
ID is not used.

Send a first batch of fixes now so we get the feedback from syzbot ASAP.

Note: in the series, I also mentioned that the report of size 0 should
be stripped out of the HID device, but I'm not entirely sure this would
be a good idea in the end.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- added Tested-by from syzbot (https://lore.kernel.org/r/686e9113.050a0220.385921.0008.GAE@google.com)
- added a python test for it
- Link to v1: https://lore.kernel.org/r/20250709-report-size-null-v1-0-194912215cbc@kernel.org

---
Benjamin Tissoires (4):
      HID: core: ensure the allocated report buffer can contain the reserved report ID
      HID: core: ensure __hid_request reserves the report ID as the first byte
      HID: core: do not bypass hid_hw_raw_request
      selftests/hid: add a test case for the recent syzbot underflow

 drivers/hid/hid-core.c                          | 19 +++++--
 tools/testing/selftests/hid/tests/test_mouse.py | 70 +++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 5 deletions(-)
---
base-commit: 1f988d0788f50d8464f957e793fab356e2937369
change-id: 20250709-report-size-null-37619ea20288

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


