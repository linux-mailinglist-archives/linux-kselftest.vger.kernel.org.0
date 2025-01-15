Return-Path: <linux-kselftest+bounces-24572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086DA124D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD37A35F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591E241685;
	Wed, 15 Jan 2025 13:35:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413942459AB;
	Wed, 15 Jan 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948137; cv=none; b=JWGIYNmzWEFuLIfOwHjPPLa9+/1RsTMqrpFED6MqW5/Zki4kAPnyNL/DA0Qud3yi5FoqNf5p9n8JjXFj5WmLE5kxEpnRpVx/+v5bpyV4eqaih0w1Rv+oHSWBFftLI2Vid8Rjo1uxu7g8HZq6Vx/P4fcDplF1VIBqwrZLzqIpui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948137; c=relaxed/simple;
	bh=ulj1HOTDaNMpMqYVSJ4X3p1JpX3evQ0ThnqfDmvEpDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NjCJ66dNc0Pg+Bkoymg7Jx+t/SyXE5MzgYc/QE1mEtZCFP+zvapv73cCRVWDN6Jlfud1igNr40q9avtyNQplLLWcVRk+M1njb6b/95NBT4/lIb0STCfJbjYCaiqhdb2W5XsUo6Cr1PIxzkuOEbm9s6d2uO9q4v2lrGzwMgtlZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6a92f863cso1270215966b.1;
        Wed, 15 Jan 2025 05:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948133; x=1737552933;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SALK4sDCQYvTb0KKst1+p1P7McWo3sTt16aXL5fdW8Q=;
        b=DnyVr8PaDnnEznS/OsmTmYhg8OFFd13A+37eUkycZNPR7z0gs1C+/ezF4d3GW01PiF
         dUfEZwN3zvoZqFizOXISgnhqYCyFV4PuJn3OkYryHzUUElv+B0+ckOoTZh1IGjXTOkF3
         1Xa8NIgvQK0iBC7OcSzEHND9lHQYjBVIPCdU9+1/H18T0ucT8EQ0rmrSPp4jBON735vW
         mCmSEju46z1vZ9kSaXYV0LNSNa8vxqzAyLOeJbQfiw8Or6XhBnpqNCBD+4m6t+P1Xaf7
         M3QJ6xKqkp2RbZ6k8212wmF39VDhOTbSUofpwHKyWJ44e/Sxv69ySwqPGlSyEDUEktsJ
         afTg==
X-Forwarded-Encrypted: i=1; AJvYcCUbk8D5xQzNZWJ3EJ3RamcIBptdtLA6U8V12CPS2ii3mVWsNox/qERgQL5buKCNlM6pRAJSw6VFKxw=@vger.kernel.org, AJvYcCVKiTZAqj3xFvYLo1h5QJV/yF3jKHxW2DtrSoS+xiJ3lLz9eTg32CJXSXxUKq7ktMQxZO0cxzwV9sGl8Ot2@vger.kernel.org, AJvYcCW7CyWoJFKkCrHwHoenr4HBGWqcLXfnkqsEKvCxDYKuRFTql4HNjzC+ERL0b2uRRRVImZ3k3n+P462B7hcUany4@vger.kernel.org
X-Gm-Message-State: AOJu0YzlneaqtWPf3ZWBX3ORlAAoXI5tCnuNSlcwXM8h9i3g9eU0/rJF
	bHaGFs8h6eOflFPfE3u4GrDqLEZYeKfMS+Zwq7YyJe46UyecB8l7
X-Gm-Gg: ASbGnctZ0+rrJKsrgScPc/f6txqvlwu5ZXETgUqcMxijdq6HacjxuCoC7l9hUItSjRu
	n6ajLDEIy/CKbILT/GGwBh5aa4ypjMw3NZX3r+8pXYQXmNPh+9hzS8ryjQfTDKe0EDAhI7WcN6U
	3ZuGfSWsHSSjZF+0iGln5rEOPOex1oSQcnsGG45kI90IqQLsmOv2AXa7Fj6JZeIPMckoho2qRms
	dMcdxIdVSM+JSekxhGpQmI5YNE5e76h3ujejcHP9g4yF8U=
X-Google-Smtp-Source: AGHT+IGt5sXVoPCFD/NMTDdlvFSvgoOs1cqdB0gLt7NTHLg9S9IfSV9GbbpY5XrTZcAEXxmAo2TzPA==
X-Received: by 2002:a17:907:60d5:b0:aa6:a228:afaf with SMTP id a640c23a62f3a-ab2abcb139cmr2753855966b.52.1736948133280;
        Wed, 15 Jan 2025 05:35:33 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90da0d9sm764196266b.67.2025.01.15.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:35:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/5] netconsole: Add support for CPU population
Date: Wed, 15 Jan 2025 05:35:17 -0800
Message-Id: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJa5h2cC/03NQQqDMBBA0auEWZuSiYKpq96jSDFx1NlMJEnFI
 t69YDddf3j/gEyJKUOnDki0ceYo0ClbKQjLIDNpHqFTYI1tEI3TQiVEeYX1rQPVd2zJuanxUCl
 YE028X9gThIoW2gv0lYKFc4npc102vPoPxPof3FAbPaJr/dQGU1t8jOR5kFtMM/TneX4B/iPkf
 K8AAAA=
X-Change-ID: 20241108-netcon_cpu-ce3917e88f4b
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, max@kutsevol.com, 
 thepacketgeek@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5085; i=leitao@debian.org;
 h=from:subject:message-id; bh=ulj1HOTDaNMpMqYVSJ4X3p1JpX3evQ0ThnqfDmvEpDs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnh7mj4ovbpc3+8RLnALPtLdIZci51EBJyVBkvP
 Vd0ycrX0f2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4e5owAKCRA1o5Of/Hh3
 bTYaD/9Or/0PCBZ6RxYA9GN1yOIZRCzplMG4SkXR/D86PUqUwUdEH1SNqTB6gT7t0oXCQ+a7H0K
 RF/zPWOHHMCqVANtHwW5C1b/0N6uDDmv/mgVYFdhHMa8QJyd9/5PHBbSYbBHr7faYGL4Y/WVTXe
 pNn39H08YyewZzhAfIsh/ZLckDYCubnkUJiM4UyVeaqslrLMFkVVuwtGCLYawPoyMB9hXoezvMb
 w0wo5IL9DI3x4cvBuNDBXSze72YeoE0Bb0anloCGi5P4GWgfD7ogidSM4JkfviS2dyzjvNuvq6w
 DZoB6WpJLGClpXXJHoXejzS/2ilQogWJu5xFBC0JvEPWGtzmw26lqLIzgR8qBBgzRCLI8Y/3nRC
 jJLChsrg+cQG58rLM+G398z0ZKfxheDwOwMEEqHs+APpLEFsObwqPjxe/CXe6Y6Dz1O7Jw+0pDL
 qMDc/6Y2BxDEhz3AcbZpj5YNsr4OAL18d44m+p5G9vJtVdNiEo9bYiGRHxCTDkPeQLZppdKfjxG
 va1nkYZfUNFPnqPD8IbVWCD8yrmZBXplBrZPSXmGGNd9DRU2vwhwDKl9vnfTMZcqRAvy2PVJ8YY
 S69nc+seupuRIAfno5EPTwikmHVGQ91S0TFOLmVF0WQaN/sQRCrR80OrbasLqTnXLiC40Pqpd90
 mLGyKbkTpT0EKkQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The current implementation of netconsole sends all log messages in
parallel, which can lead to an intermixed and interleaved output on the
receiving side. This makes it challenging to demultiplex the messages
and attribute them to their originating CPUs.

As a result, users and developers often struggle to effectively analyze
and debug the parallel log output received through netconsole.

Example of a message got from produciton hosts:

	------------[ cut here ]------------
	------------[ cut here ]------------
	refcount_t: saturated; leaking memory.
	WARNING: CPU: 2 PID: 1613668 at lib/refcount.c:22 refcount_warn_saturate+0x5e/0xe0
	refcount_t: addition on 0; use-after-free.
	WARNING: CPU: 26 PID: 4139916 at lib/refcount.c:25 refcount_warn_saturate+0x7d/0xe0
	Modules linked in: bpf_preload(E) vhost_net(E) tun(E) vhost(E)

This series of patches introduces a new feature to the netconsole
subsystem that allows the automatic population of the CPU number in the
userdata field for each log message. This enhancement provides several
benefits:

* Improved demultiplexing of parallel log output: When multiple CPUs are
  sending messages concurrently, the added CPU number in the userdata
  makes it easier to differentiate and attribute the messages to their
  originating CPUs.

* Better visibility into message sources: The CPU number information
  gives users and developers more insight into which specific CPU a
  particular log message came from, which can be valuable for debugging
  and analysis.

The changes in this series are as follows:

Patch 1: netconsole: Rename userdata to extradata
=================================================
Create the a concept of extradata, which encompasses the concept of
userdata and the upcoming sysdatao

Sysdata is a new concept being added, which is basically fields that are
populated by the kernel. At this time only the CPU#, but, there is a
desire to add current task name, kernel release version, etc.

Patch 2: netconsole: Helper to count number of used entries
===========================================================
Create a simple helper to count number of entries in extradata. I am
separating this in a function since it will need to count userdata and
sysdata. For instance, when the user adds an extra userdata, we need to
check if there is space, counting the previous data entries (from
userdata and cpu data)

Patch 3: netconsole: add support for sysdata and CPU population
===============================================================
This is the core patch. Basically add a new option to enable automatic
CPU number population in the netconsole userdata Provides a new "cpu_nr"
sysfs attribute to control this feature

Patch 4: "netconsole: selftest: test CPU number auto-population"
=============================================================
Expands the existing netconsole selftest to verify the CPU number
auto-population functionality Ensures the received netconsole messages
contain the expected "cpu=<CPU>" entry in the message. Test different
permutation with userdata

Patch 5: "netconsole: docs: Add documentation for CPU number auto-population"
=============================================================================
Updates the netconsole documentation to explain the new CPU number
auto-population feature Provides instructions on how to enable and use
the feature

I believe these changes will be a valuable addition to the netconsole
subsystem, enhancing its usefulness for kernel developers and users.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Create the concept of extradata and sysdata. This will make the design
  easier to understand, and the code easier to read.
  * Basically extradata encompasses userdata and the new sysdata.
    Userdata originates from user, and sysdata originates in kernel.
- Improved the test to send from a very specific CPU, which can be
  checked to be correct on the other side, as suggested by Jakub.
- Fixed a bug where CPU # was populated at the wrong place
- Link to v1: https://lore.kernel.org/r/20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org

---
Breno Leitao (5):
      netconsole: Rename userdata to extradata
      netconsole: Helper to count number of used entries
      netconsole: add support for sysdata and CPU population
      netconsole: selftest: test for sysdata CPU
      netconsole: docs: Add documentation for CPU number auto-population

 Documentation/networking/netconsole.rst            |  45 +++++
 drivers/net/netconsole.c                           | 223 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  17 ++
 .../selftests/drivers/net/netcons_sysdata.sh       | 166 +++++++++++++++
 5 files changed, 407 insertions(+), 45 deletions(-)
---
base-commit: 7b24f164cf005b9649138ef6de94aaac49c9f3d1
change-id: 20241108-netcon_cpu-ce3917e88f4b

Best regards,
-- 
Breno Leitao <leitao@debian.org>


