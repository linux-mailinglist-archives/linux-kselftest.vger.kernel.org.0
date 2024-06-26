Return-Path: <linux-kselftest+bounces-12796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B029182F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8650D1C2231D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DA181D1F;
	Wed, 26 Jun 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+CWNp0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7714532F;
	Wed, 26 Jun 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409606; cv=none; b=C6/sT9/vNk9LXaxKCxDmZ0T2BTMkmpWCMTDCRMSftW+9dlCDRuAR/L8OCicRWTkvsLcOHydCW4amxVrjwP3gbfHioklJS6kX9vusc3+XwoPrRdpOkvzwgnosrnOdVZdBVZP91tK02K24xWeVVcAWBiDQVE363nB1rFLrNWDGUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409606; c=relaxed/simple;
	bh=fowNjRUPqytav6kaGkQlvoda+Xzi+RnRNNTdb1ay/w4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uDzRdHO809pElUfnlR/2+E+lZkhZ5Vrtw7BgGnW07BDCqpOO9z5TfFzwq3QA04BCjLrpk0SIsijCezWeAyEI+dZFRa2DGAn96rGJPWPnLBU0VyEyewoi4aAl8aBNaavTHodrbVaW2iNo7kAxsgzeoCENFrShniMEYUdcGymBn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+CWNp0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97179C116B1;
	Wed, 26 Jun 2024 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409604;
	bh=fowNjRUPqytav6kaGkQlvoda+Xzi+RnRNNTdb1ay/w4=;
	h=From:Subject:Date:To:Cc:From;
	b=o+CWNp0wBeOKZae3utxe+j4UButbC6veYWb/eExT93eqfVkpVxPJP+LGaGLXf0o2p
	 MPFSK/1sfFA5golJK83DMjP81fU9IrCxi76uYmcMZmklUOkU/LV23GbR7JYM2DTQuV
	 x+2ESFukVxb9GPlDgz6mMAYsjZhGJvIwZ13/X6+yv4n4hCPvEFYK6HN8BoPK5DpFpW
	 VnkpeGbeX7Fll1xLsrN6HiJFxbA3kqRBCQo6kOXp7xJSwcH2zpBsKw7N3JEhJh4h/U
	 M5G++Dx9icZ8Q0cIj00runDqrGNsyIuqt9sTGmmqi3WnVttpQcYmlh9+EZyuE4K9zQ
	 C9OQi/RN9pZjQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID v2 00/13] HID: bpf_struct_ops, part 2
Date: Wed, 26 Jun 2024 15:46:21 +0200
Message-Id: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4bfGYC/12NwQrCMBBEf6Xs2UgSWq2ePHjQb5ASErNtFqWtG
 4lK6b8b6s3jm2HeTBCRCSPsiwkYE0Ua+gx6VcA12L5DQT4zaKlLuVGlCORNeBnGh3FjK3wr3a6
 y6EpdQR6NjC29F+EFTucjNDkMFJ8Df5aTpJbq59Pq35eUkMJvratdXVdWusMNucf7euAOmnmev
 wW9AQayAAAA
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=3372;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=fowNjRUPqytav6kaGkQlvoda+Xzi+RnRNNTdb1ay/w4=;
 b=SejyWtK62WC9iE0OJ8KJDNd3lehwTElCdkkp4775Sjrkc7Avs9E7oefzFyCPTzk9bbRuKdjAX
 myisqS+QNMLAPqNQ2lfy+3FHvQtg4+F4PuLrZ2t1rejxnE9JHSJN4Hr
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This series is a followup of the struct_ops conversion.

Therefore, it is based on top of the for-6.11/bpf branch of the hid.git
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.11/bpf

The first patch should go in ASAP, it's a fix that was detected by Dan
and which is actually breaking some use cases.

The rest is adding new capabilities to HID-BPF: being able to intercept
hid_hw_raw_request() and hid_hw_ouptut_report(). Both operations are
write operations to the device.

Having those new hooks allows to implement the "firewall" of HID
devices: this way a bpf program can selectively authorize an hidraw
client to write or not to the device depending on what is requested.

This also allows to completely emulate new behavior: we can now create a
"fake" feature on a HID device, and when we receive a request on this
feature, we can emulate the answer by either statically answering or
even by communicating with the device from bpf, as those new hooks are
sleepable.

Last, there is one change in the kfunc hid_bpf_input_report, in which it
actually waits for the device to be ready. This will not break any
potential users as the function was already declared as sleepable.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- made use of srcu, for sleepable users
- Link to v1: https://lore.kernel.org/r/20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org

---
Benjamin Tissoires (13):
      HID: bpf: fix dispatch_hid_bpf_device_event uninitialized ret value
      HID: add source argument to HID low level functions
      HID: bpf: protect HID-BPF prog_list access by a SRCU
      HID: bpf: add HID-BPF hooks for hid_hw_raw_requests
      HID: bpf: prevent infinite recursions with hid_hw_raw_requests hooks
      selftests/hid: add tests for hid_hw_raw_request HID-BPF hooks
      HID: bpf: add HID-BPF hooks for hid_hw_output_report
      selftests/hid: add tests for hid_hw_output_report HID-BPF hooks
      HID: bpf: make hid_bpf_input_report() sleep until the device is ready
      selftests/hid: add wq test for hid_bpf_input_report()
      HID: bpf: allow hid_device_event hooks to inject input reports on self
      selftests/hid: add another test for injecting an event from an event hook
      selftests/hid: add an infinite loop test for hid_bpf_try_input_report

 Documentation/hid/hid-bpf.rst                      |   2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 165 ++++++++++-
 drivers/hid/bpf/hid_bpf_dispatch.h                 |   1 +
 drivers/hid/bpf/hid_bpf_struct_ops.c               |   6 +-
 drivers/hid/hid-core.c                             | 118 +++++---
 drivers/hid/hidraw.c                               |  10 +-
 include/linux/hid.h                                |   7 +
 include/linux/hid_bpf.h                            |  80 ++++-
 tools/testing/selftests/hid/hid_bpf.c              | 326 +++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 292 ++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  13 +
 11 files changed, 955 insertions(+), 65 deletions(-)
---
base-commit: 33c0fb85b571b0f1bbdbf466e770eebeb29e6f41
change-id: 20240614-hid_hw_req_bpf-df0b95aeb425

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


