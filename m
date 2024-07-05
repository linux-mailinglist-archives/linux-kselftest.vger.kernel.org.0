Return-Path: <linux-kselftest+bounces-13259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6A928F8C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E71C21287
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7F1494BF;
	Fri,  5 Jul 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="27T/u9DY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BA148FF2;
	Fri,  5 Jul 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720222211; cv=none; b=XaEZPoDM57TCj+a1zKwOTVlf0LYCuhmbWu9RYTyEwusMknkNrhRAqqKN2sCkJAcCR5iR1a/PJgKCs42W1YBEsLnrbk9PsYeqi/djj+hN27kwdMihTPJffMD86AOGoThHaz1TXMxHMgIgm8J8BlUmc8BFAw3QAM7OtFIzXW5tzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720222211; c=relaxed/simple;
	bh=hEAYBzWA0a0y+dYKFS2DJxhMUVWhROyH3K3JrHLkUkE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=czdJrnI5lOm/ny8ZmuGNqKJ0XuvuUIuqLJt3vNDKQoO7XA/+fZwkiCnDx3sJXAt2XhtbhkpECoVMQKRpyby8FO5ij1aiskIoCA2iSu5G7wZ1+PQpV3HiSFD3URpRTc1X5akJfSWP2TATDBkPyjw/QTyU9Cl354RLn5P+wAXeOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=27T/u9DY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720222207;
	bh=hEAYBzWA0a0y+dYKFS2DJxhMUVWhROyH3K3JrHLkUkE=;
	h=From:Subject:Date:To:Cc:From;
	b=27T/u9DYfK0YwmBN1J13WMc/2Jg0yeXBDGXeFWWf7RhQQGz+Jt5pyzAqId/xdvVb/
	 h5rJqbOocNvgES8PO7eVKQmPNzcy0zO2gixJJu7yXNnaTSjQ70gHxbVlEuWgvqJBWX
	 BM1SAMVtMlmH92LSEB4Dl0y5wlvm1gxXVUcqyxJh96x4WEd9q3KhnvUf3HnslmE8qd
	 V709B9A7626OsTy/f/NWxWKj6YoiyyR3qWUkyB8plA4aGmU3yWE0ohrSjwGs6sT0nI
	 No8Mv66AuCFXdUj8wmaACpGIdjWuaDbqRwinFjLp/xf8K/WXYwl0OmuC7ldjwdcLUX
	 lNeRRoQ95N2Fg==
Received: from [192.168.1.238] (tango.collaboradmins.com [167.235.144.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C80363780BDB;
	Fri,  5 Jul 2024 23:30:06 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/3] kselftest: Add test to report device log errors
Date: Fri, 05 Jul 2024 19:29:53 -0400
Message-Id: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPGBiGYC/22NQQ6CMBBFr0Jm7Zi2IqAr72FYQDuFJpWaKWk0p
 He3krhz+V7y398gEjuKcK02YEouurAUUIcK9DwsE6EzhUEJVYtaSTSUkJjRhwkjebtSXFF19jx
 2VrfaCCjTJ5N1rz177wvPLq6B3/tLkl/7C57+B5NEgc1FaNnW0jTdeNPB+2EMPBx1eECfc/4Aw
 ueGqrwAAAA=
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

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
Changes in v2:
- Rebased onto next-20240703
- Link to v1: https://lore.kernel.org/r/20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com

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
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240421-dev-err-log-selftest-28f5b8fc7cd0

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


