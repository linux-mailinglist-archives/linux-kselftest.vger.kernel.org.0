Return-Path: <linux-kselftest+bounces-12414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4D911F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D531F2263E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA416D9B9;
	Fri, 21 Jun 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdqWyWzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6015A49F;
	Fri, 21 Jun 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960181; cv=none; b=izaZmSUmg436Vd490pjgAal5AIX+wdPtnkuobP4aoGHFtSYKWm23d0ID33kAn0KTyEGUc7k+XdJQVeGfwztwC/U3qSjySgnU9pKJNxt66unjJ6lyk2DvO/wPIB9OHASj4lP2vrNjdJzPO/ZpB6Fj5gfvpw885xphpOMpR9AblU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960181; c=relaxed/simple;
	bh=OrR4Dfd5OgETBTEHGZ0Q1m7Mjce2+HGQVrV0OFDRrWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ar3CWRS6I7j34vjnqF5oZ1EK2N5EWyYogmsUxpf9Gef4YSFUFkeqB67FuErx8kT8skco8OBzd2es3t1SCg/bKNd/Sub4RWZJasZnSGu9Aodvdv5Gwvsr+1WNtEBMNjnIaDSeWk6RVJnjUJmEMHR/5b+YWMDUuzc1Qs85QiL+VDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdqWyWzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7B1C2BBFC;
	Fri, 21 Jun 2024 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960180;
	bh=OrR4Dfd5OgETBTEHGZ0Q1m7Mjce2+HGQVrV0OFDRrWY=;
	h=From:Subject:Date:To:Cc:From;
	b=rdqWyWzqUuqmzr6sJIvK0P1jRz4RjmpFLa5WJw/vOxkxq9EaazMbgsVsbfrWSwIc3
	 c/I1XQEwu7P7tCmH1puxMBEVkTGqa9filtFbSrIwPIcQsfYwTKZpWZTXZ/R0Pd1d8D
	 p49WSp4c2myUTSxQWYUn74WRIPglJsQzqSxZ1jSuEuEE5Yx2wRdh38MttpAc087/yB
	 SBYIHXxxf08tlmWn9u4afBJ4ZA7RdiNJk6R4OtS6mkJH/mAfkBOO4TeBk6d9Q+nCm0
	 IUqB5ZrHXLIljBdjVubtv8ckUuqTfrMhD1MqkGA/Z/0OiVKebQT0W2OuMZ1uJ7inDX
	 lMr6vZMhv/PfQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID 00/12] HID: bpf_struct_ops, part 2
Date: Fri, 21 Jun 2024 10:55:45 +0200
Message-Id: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJAdWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MT3YzMlPiM8vii1ML4pII03ZQ0gyRL08TUJBMjUyWgpoKi1LTMCrC
 B0Uoeni5KsbW1AJ0q6rNlAAAA
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=3152;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=OrR4Dfd5OgETBTEHGZ0Q1m7Mjce2+HGQVrV0OFDRrWY=;
 b=5geDPv01Y1gjSr1i9Fu7RTsBG3JKzhPZS9mmOLuuXst1RIDt860mJSpG0GFQxlDDds2KzKGO/
 +gyptQOqYvwAojlYnG/vLtZL/veXmoY5OgLyJrVe16DYwQqBI/uzU+O
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
Benjamin Tissoires (12):
      HID: bpf: fix dispatch_hid_bpf_device_event uninitialized ret value
      HID: add source argument to HID low level functions
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
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 157 +++++++++-
 drivers/hid/bpf/hid_bpf_dispatch.h                 |   1 +
 drivers/hid/bpf/hid_bpf_struct_ops.c               |   4 +-
 drivers/hid/hid-core.c                             | 110 ++++---
 drivers/hid/hidraw.c                               |  10 +-
 include/linux/hid.h                                |   7 +
 include/linux/hid_bpf.h                            |  73 ++++-
 tools/testing/selftests/hid/hid_bpf.c              | 326 +++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 292 ++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  13 +
 11 files changed, 934 insertions(+), 61 deletions(-)
---
base-commit: 33c0fb85b571b0f1bbdbf466e770eebeb29e6f41
change-id: 20240614-hid_hw_req_bpf-df0b95aeb425

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


