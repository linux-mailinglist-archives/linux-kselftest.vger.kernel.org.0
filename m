Return-Path: <linux-kselftest+bounces-8707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259D8AE905
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 16:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C291F22070
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA207137755;
	Tue, 23 Apr 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qpT3A78d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F8137900;
	Tue, 23 Apr 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881059; cv=none; b=V/l1E5GNNi6Fli8UTkTmNYco23vCNGHi/MvVh80IcNiKeHlX35w4iwVM/pYBIhnYKBPal04z7avBpClQJh429UJ+VlUXjMEzSmZ8wD50R9umoNMW8dWyYVLfQUn2C5oIBV9AS04UCKkXK5z5xE7H6zKNcxr1E0DOiwCq3a3ec8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881059; c=relaxed/simple;
	bh=neo6VBlrt3qDMQ41DWfk27jOXU9k4IUrHGw5mjmSN2I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QnZg/+iKdIU5jBKc29SkkoyjqhuF4xCPSXEsqL518JR/ML0N01+RgZngKVEEpi17/Gqld5UMlID1shv49f0BZY1kTnBywhvzg0+pu/cvE6QoAK90kZTe6H00TminBDdsPHPZQ7QrmOze1fnY37uCauXF0C7/yfjTlvdDFq4fLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qpT3A78d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713881051;
	bh=neo6VBlrt3qDMQ41DWfk27jOXU9k4IUrHGw5mjmSN2I=;
	h=From:Subject:Date:To:Cc:From;
	b=qpT3A78dofnqODQw2poC2hDIcGFP3T7ESuNcdikFHEdSGafE9QYN2hth0gc56/wrT
	 Ghpv2hSSn4fyCAiLIwJ6bbTK4lzQSq/hsa7aaRNnjCW3y6A2TD+QEksq9Yp2X8mudb
	 QBojiq+BjOVTfsPExYtD3jycZr0uiAfbZFNW3yG0xRqPxCLTPkYMLk5ytz1YOFKeN1
	 z9CO/EBQFYtRj8K+puzwEkjRUhSrbnCi/nJnlJpcahuHll4lJLCET0nhQlEb11/8HB
	 N6nM5+CxR/lxd2cHIKNhme2wRhMHnNDHxPWYrsX2R8jRtGe+lwEX82DRlIFprGVAlw
	 B0VHZ7JchKZPA==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E86737820F9;
	Tue, 23 Apr 2024 14:04:09 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/3] kselftest: Add test to report device log errors
Date: Tue, 23 Apr 2024 10:03:39 -0400
Message-Id: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALu/J2YC/x3MQQqEMAxG4atI1gZqUUa8irhw2r9OQFQSEaF49
 ykuv8V7mQwqMBqqTIpLTPatoKkrCr95W8ASi8k737rWNxxxMVR53Rc2rOmEnez71H37FD4hOir
 poUhyv9txep4/oPpJVmYAAAA=
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Log errors are the most widely used mechanism for reporting issues in
the kernel. When an error is logged using the device helpers, eg
dev_err(), it gets metadata attached that identifies the subsystem and
device where the message is coming from. This series makes use of that
metadata in a new test to report which devices logged errors.

The first two patches move a test and a helper script to keep things
organized before this new test is added in the third patch.

It is expected that there might be many false-positive error messages
throughout the drivers code which will be reported by this test. By
having this test in the first place and working through the results we
can address those occurrences by adjusting the loglevel of the messages
that turn out to not be real errors that require the user's attention.
It will also motivate additional error messages to be introduced in the
code to detect real errors where they turn out to be missing, since
it will be possible to detect said issues automatically.

As an example, below you can see the test result for
mt8192-asurada-spherion. The single standing issue has been investigated
and will be addressed in an EC firmware update [1]:

TAP version 13
1..1
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `model_name' property: -6
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
 power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
not ok 1 +power_supply:sbs-8-000b
 Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

[1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (3):
      kselftest: devices: Move discoverable devices test to subdirectory
      kselftest: Move ksft helper module to common directory
      kselftest: devices: Add test to detect device error logs

 tools/testing/selftests/Makefile                   |  4 +-
 tools/testing/selftests/devices/Makefile           |  4 -
 .../testing/selftests/devices/error_logs/Makefile  |  3 +
 .../devices/error_logs/test_device_error_logs.py   | 85 ++++++++++++++++++++++
 tools/testing/selftests/devices/probe/Makefile     |  4 +
 .../{ => probe}/boards/Dell Inc.,XPS 13 9300.yaml  |  0
 .../{ => probe}/boards/google,spherion.yaml        |  0
 .../{ => probe}/test_discoverable_devices.py       |  7 +-
 .../selftests/{devices => kselftest}/ksft.py       |  0
 9 files changed, 101 insertions(+), 6 deletions(-)
---
base-commit: 7b4f2bc91c15fdcf948bb2d9741a9d7d54303f8d
change-id: 20240421-dev-err-log-selftest-28f5b8fc7cd0

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


