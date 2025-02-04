Return-Path: <linux-kselftest+bounces-25661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B972A27050
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2203A2B1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C320C035;
	Tue,  4 Feb 2025 11:35:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0F14A4F0;
	Tue,  4 Feb 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668932; cv=none; b=Toj3SqSTiRaDgV41E1/mAtXg8kc0pYDXsmduyVgaYkjPW60+bc0GUpdEzCd4PNA4fZaSqEcKPttfQTL/sWq5WZLK8GctMjCy7tyGkXzfR8p5CKtHN6Zgp6kNoKaFwkLgqvKwANyhBuACsj6EMF4LxvAXZNba5/yULt4idxyVooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668932; c=relaxed/simple;
	bh=lZSNMkfc2sSNzEP+3urwBqFqc++W+plaDDdgtmHvPhU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SEUhuTgjPz+lJByElfAOC7N1g55FO/ww6htLoZVdYtK14e/xU3oa+ZzItTm/BEWkNVZDpVJOS9n5Aj76ISnYAmqX8NvR/e9szZWus9rigFh+KmlUxI54CU6PmlbNeR1eI7wP7k1ftN974BJ/h7GhkhGAXhnhheZJcrX3KuUAtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab737e78900so284965366b.0;
        Tue, 04 Feb 2025 03:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668929; x=1739273729;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANSy2MgMKMQE2suTHXPIHg9rWz+6iJGj0ynt3tzYX08=;
        b=CQUs76/Aw0rc+i9QqcUSGTpKYWZlwzqVm6CNwcekmVf7ffPnXZtnuod/mSpFZcn6Yz
         Ret3ttV9JrLzlnCt8cUNW6NfqjwDF2il5DKt059ptI4qv+wVVowFd0E2XHz+StMF8OHN
         gBa0IqfaCKmHL0hR5SqXrkYMT2pGFgarkKAIA1CUHC1qxksFuPgsvcbZgyNI1F+g99OL
         7ep7Z8+GA6iMEWlWMUSKMYoyex/OeBuuesUT2cEhyEXAHaAwxnNltcrX6p4RGGPcqfjo
         6S2w/ca/D+PP47ZxiTvD31aZyOiXPcFDb/+t2W3t6Trxlnb2tT3vOsILTkLJ1bZf4tb0
         KBbg==
X-Forwarded-Encrypted: i=1; AJvYcCW1y3927wonYTaI1RWDexynK1WR0HfdMGYij+9eIqKJ/P+gF9w7KqhquqE7o5siyKGDE5yR9u5mG837v+v0@vger.kernel.org, AJvYcCWnJac7uNZOVpm/qz3b/7IkgjVTI0hVhuTb9EPeAATh3htut/+GuM7GxFn84rDhwN2p1YZpY6KEDwo=@vger.kernel.org, AJvYcCX4yXo/hoAND5ZIN26O4I3DLwPRznip0gwRHSIooG+PZ6dxfiiHoRTxuZoAxJ9wXOCP4epAeY90oPzQsRHnXg3K@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtp4CwO3w6fdc+yEVuOUAfnss7Vg2zEAfm1ChxciVh4BSPmY9f
	sKAkEYgZE0ftKO22NXd1FrrKWzNHkz3xFYbjbITWJ6C5UOVplnNi/uaN8Q==
X-Gm-Gg: ASbGnct75HNhkylL42dLfVZtPZ/w0Z4CHWkHSUFegOnI6EHcV4CoWe4XCevIgjD8Dzt
	sJzjwIQruDM+X1r6xtn5GecPZzEAibOrO8aOVdiQ7JvIXz0zLSmmBzDCyFjtd0VUYCF+WVgmzK6
	gTiCBAYxXTe3etxN4Rgfwwc4cQsm0RmT7NT+p5tIIGIPtTDW7UvP8HXh6DXgGjv+ZdIwlsQPQs0
	ERQWM1WPSIkAPWRPA4Nzow1pXSpvmsWN3RDVRXZ5iOk89y85IcTWDxt6xK7DHSufCDI6PrlUq7/
	KFQHNw==
X-Google-Smtp-Source: AGHT+IFELrOyoXwFfymVuPHYD8kTHLRd5jDRSw2ZFzgz+BN+WDBI5w/hsZHAxuWHwsHKX8pr2MkS1g==
X-Received: by 2002:a17:907:7f90:b0:aa6:9461:a186 with SMTP id a640c23a62f3a-ab6cfda43e1mr2858032366b.46.1738668928377;
        Tue, 04 Feb 2025 03:35:28 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d21aasm905017966b.74.2025.02.04.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/8] netconsole: Add support for CPU population
Date: Tue, 04 Feb 2025 03:35:08 -0800
Message-Id: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG37oWcC/2XN0QqCMBTG8VcZ59oTO9vM6VXvERFuO9ZuZkyTQ
 nz3wAiUrj9+/2+GgXPkARoxQ+YpDrFP0AhTCPD3Nt0YY4BGgJLKEEmLiUffp6t/PNGzrqliazv
 joBDwyNzF1xo7Q+IRE79GuBQC7nEY+/xeXyZa92+Q9DY4EUoMZCvXVV5qRafALrbp0Ofb2pnUz
 5aSqNxZhRLrsq7IGRN8efyzemOV2VmNEkm1Mih7dC2FnV2W5QN608G+JwEAAA==
X-Change-ID: 20241108-netcon_cpu-ce3917e88f4b
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 rdunlap@infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6914; i=leitao@debian.org;
 h=from:subject:message-id; bh=lZSNMkfc2sSNzEP+3urwBqFqc++W+plaDDdgtmHvPhU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+4qBuFMUaJAas6IrJy3xohKFb5bDoqGdbv
 d8UlifptHCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bSfeD/4h/6LVVosjwEF0zlTx+BisqW4S9ngQluYZAoMdy23f1HN2HfqS4tMRwmfyJUSe9Nk3/kw
 AgLyjdhf9YSX1VHpMBrXugEwTN4d+IaIzMlywRpiZI8FyENUZFzC2IQXaD5uYxSCb5/2Eu+iqk9
 uSgFEHd1SaB5cERFZjPdscxiDjDvdKEhYPABwQOJAjg44n5VkX2dnRkTD8qhiygWosG54yzyblq
 Osakk462++7acWtczHnl64WfZ5veirtmkErobXBIaKBTbomd5K1+tW94zu1LaUbuZhmM+BVZzTB
 7daAlooxnsb1uA9moECh6fvSeXTq07AQZ8u6yp0QJl9j8vSfu4jix7A0KQ+ctJoYBMIrbKImad9
 TDMoQPnu06GxhVDR+cNnI1qrqqk3kqP9FcNVPVRU37JMfC+v3e8S9wTi39mf2hKFVwF6vsgia/o
 pFzXgD0fI1WKy7WfU/Sb2t7D1uPgtsEgJiBdvGqf7+SyTTMNEG2vGeW8X9MJZyubXSWUHrjs+N5
 boQBg6wJEGdeG7Hnohgwr87UQI62IOJBgYa55q8yQ/7NSEbFS8Yj2c9Jd8T3zGG5hoegpqzHh/G
 +Ws2DZ+4xXVgOmOjJwdgk+zBslmLgKgvdvOEDP37kHiRYYihzhedtwLI142y5q5ooju5p7YOGgd
 d/OfaOLQqY4NjsA==
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

The changes in this series are as follows Patches::

Patch "consolidate send buffers into netconsole_target struct"
=================================================

Move the static buffers to netconsole target, from static declaration
in send_msg_no_fragmentation() and send_msg_fragmented().

Patch "netconsole: Rename userdata to extradata"
=================================================
Create the a concept of extradata, which encompasses the concept of
userdata and the upcoming sysdatao

Sysdata is a new concept being added, which is basically fields that are
populated by the kernel. At this time only the CPU#, but, there is a
desire to add current task name, kernel release version, etc.

Patch "netconsole: Helper to count number of used entries"
===========================================================
Create a simple helper to count number of entries in extradata. I am
separating this in a function since it will need to count userdata and
sysdata. For instance, when the user adds an extra userdata, we need to
check if there is space, counting the previous data entries (from
userdata and cpu data)

Patch "Introduce configfs helpers for sysdata features"
======================================================
Create the concept of sysdata feature in the netconsole target, and
create the configfs helpers to enable the bit in nt->sysdata

Patch "Include sysdata in extradata entry count"
================================================
Add the concept of sysdata when counting for available space in the
buffer. This will protect users from creating new userdata/sysdata if
there is no more space

Patch "netconsole: add support for sysdata and CPU population"
===============================================================
This is the core patch. Basically add a new option to enable automatic
CPU number population in the netconsole userdata Provides a new "cpu_nr"
sysfs attribute to control this feature

Patch "netconsole: selftest: test CPU number auto-population"
=============================================================
Expands the existing netconsole selftest to verify the CPU number
auto-population functionality Ensures the received netconsole messages
contain the expected "cpu=<CPU>" entry in the message. Test different
permutation with userdata

Patch "netconsole: docs: Add documentation for CPU number auto-population"
=============================================================================
Updates the netconsole documentation to explain the new CPU number
auto-population feature Provides instructions on how to enable and use
the feature

I believe these changes will be a valuable addition to the netconsole
subsystem, enhancing its usefulness for kernel developers and users.

PS: This patchset is on top of the patch that created
netcons_fragmented_msg selftest:

https://lore.kernel.org/all/20250203-netcons_frag_msgs-v1-1-5bc6bedf2ac0@debian.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Fixed Kernel doc for netconsole_target (Simon)
- Fixed a typo in disable_sysdata_feature (Simon)
- Improved sysdata_cpu_nr_show() to return !! in a bit-wise operation
- Link to v3: https://lore.kernel.org/r/20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org

Changes in v3:
- Moved the buffer into netconsole_target, avoiding static functions in
  the send path (Jakub).
- Fix a documentation error (Randy Dunlap)
- Created a function that handle all the extradata, consolidating it in
  a single place (Jakub)
- Split the patch even more, trying to simplify the review.
- Link to v2: https://lore.kernel.org/r/20250115-netcon_cpu-v2-0-95971b44dc56@debian.org

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
Breno Leitao (8):
      netconsole: consolidate send buffers into netconsole_target struct
      netconsole: Rename userdata to extradata
      netconsole: Helper to count number of used entries
      netconsole: Introduce configfs helpers for sysdata features
      netconsole: Include sysdata in extradata entry count
      netconsole: add support for sysdata and CPU population
      netconsole: selftest: test for sysdata CPU
      netconsole: docs: Add documentation for CPU number auto-population

 Documentation/networking/netconsole.rst            |  45 ++++
 drivers/net/netconsole.c                           | 261 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  17 ++
 .../selftests/drivers/net/netcons_sysdata.sh       | 167 +++++++++++++
 5 files changed, 427 insertions(+), 64 deletions(-)
---
base-commit: 145702ca2544bf82c6b244a49163f603fbe746f4
change-id: 20241108-netcon_cpu-ce3917e88f4b

Best regards,
-- 
Breno Leitao <leitao@debian.org>


