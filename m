Return-Path: <linux-kselftest+bounces-25902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5FA2A6C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141971608BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D4227B81;
	Thu,  6 Feb 2025 11:06:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6D226865;
	Thu,  6 Feb 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839968; cv=none; b=d+onwbmM1huFEy/jsCkq8eSZWPkCg/4UNke8opmQHy0zXh8R6EuwgBDqM/HWWscw0glKP9802hFQ4ziGyssycUFXotrqHIdqQFpQEfYIi9L4X6XEFtVMH2+hzu2aI/6wexLCeRJqKmn4t5Ql+tRe6+h0sBJLc3bK/s0Yy5ObOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839968; c=relaxed/simple;
	bh=Jyy3fjHcYmbNNvMYIhBlZWKKDE1L/KQ7LgMtycOTPKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tkd4hq35LgTdQqhwzcBfqmYX1QHdf3SXc+bHTuatZS0enSHc+BKz9s8lw5alusINQCHZEwhl3YGIuxcpjNwGLCdxKqp97PDRGSJimPFyfixzbjiOEIVFOT2gO5sAIaYb2Fm4B4fpIL65B4KYwfyEG2Z0zW2M2nTUVP18HdyIz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab6f636d821so145437566b.1;
        Thu, 06 Feb 2025 03:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839965; x=1739444765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT6gOqSB/enAQnKm21N5slKG1O3Yd738CbU42Ai+50I=;
        b=YE0osjDOQHThh/aeeSMJ7ydVwm6/5bjpAqPYYfJ8du41juYtBvdayDSdd/RUVykQPY
         TadZaZu9+kbWPsmTyHl7m4uKr4014Upj05XV6pCPYpG4+tEu4WGBLXY+7FvtIquq8YyL
         0z0u/0K3taO4cjbR+RuIHf0GM8V7BGG1WVxGGt8tQrcuWS46RjV9FRCz0y0NcA6XBM4o
         xT0s4WSCy0PC2Muzq4qme9Gi1drfPnjGP66OidPj4g23XH473ZynZwQlIx7lBqU4740I
         Au4yAUIhdo/gTXyyWEiuO6vMGUy02aHaeEDcxqNGKfp07Km1/F0mR4yfE88Y/Ur7MXU4
         GDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcossXpNDiwvQ4eIpL34K7BGB1PkoYU8l9lYzvg3+kHpM9ae422/gHwRp/T556XnZ6OoexvhIrZXw=@vger.kernel.org, AJvYcCVepWTBYjsDcRm2StR8zu6rqF4Rb1vEkTmwIfqFvQE9nGYFneLIFb1VpV59K9u/pqY/cQ4PdkX8aUEYl00c@vger.kernel.org, AJvYcCXYrNDA53s6cf8iY0bPBNkjr/WdEHRERS/H5OyO8DAsNyPJ994KK9LjbYXlS95Zz/QWiO8ZZa0Zftby7eNn41Bw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yWJPWzJCmTXrHyWFZZisWL4NSAI71jnw0VgP/1bpUnpmTn6d
	sgpZfDqBgEXn9VEfR6Vwh/pUilJxSYrPvk9kLkMmD+MQ2NPg+D/Z
X-Gm-Gg: ASbGncuMtxECAphOQhViEnDiYIwL2+X5iqPOYvWoQrKYcdzXT1nTOLuvNGu6Pv5O1Mr
	RVUy2yNWP8tIiGl6CwuosaYkmV4mhz7a5ezo+5UKTPsVQYDmH2U9IQ1v6fyRwvJEkBVoXD54081
	2tVMyL6heq0grQzCJXonsiO+Gtbf7pfRwSpSoaLUDdG9uF0FgKEJE8ESPK3HRQ2VOv9eiNBPfqF
	rZA8s9KQtDUJDKi5dL4mQg0mMQj3vEpWapPmmzJqxNJ5E+J0c7xmFmKs/l3pAQzCusB0oo3Y/mn
	u+ao+Yk=
X-Google-Smtp-Source: AGHT+IHZhgx2NkwwTtFBUrw0Q8DB6zCAoQWyDc5raYXxHFDLc0eYIgLG49dIU6AMvbpPnK8iz3o6bg==
X-Received: by 2002:a17:907:3fa4:b0:ab7:4262:6851 with SMTP id a640c23a62f3a-ab75e262775mr736412766b.30.1738839964483;
        Thu, 06 Feb 2025 03:06:04 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f48495sm81643766b.26.2025.02.06.03.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v5 0/8] netconsole: Add support for CPU population
Date: Thu, 06 Feb 2025 03:05:51 -0800
Message-Id: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+XpGcC/2XNQW6DMBCF4atYs8bVzNgGwyr3qKoK7CHxxkSGo
 lQRd69KVTU066fvf3eYpSSZoVN3KLKmOU0ZOuUqBeHS57PoFKFTwMiWCL3OsoQpv4frhw5iWmr
 E+9EOUCm4FhnTbY+9QpZFZ7kt8FYpuKR5mcrn/rLSvv8EyTwGV9KoI/lmGJuAhukUZUh9fpnKe
 e+s/GsdErmDZY26dW1Dg7UxuPrJmgfL9mCNRk3cY2RfDz3FJ2v/LOPR2u9f65HrWkb373fbti9
 oZkyUYwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7066; i=leitao@debian.org;
 h=from:subject:message-id; bh=Jyy3fjHcYmbNNvMYIhBlZWKKDE1L/KQ7LgMtycOTPKg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJea01MWFVnkbbnUkqr7k5ktG5A/tTd9CanVS
 jO4jhPsyQ6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bV1CEACct5/Cd+xUq7v1ASGPePZvi7K9f1OaKZTTcWSE/Xw1gjS8837odWk2SYyIaxWs2BabKFA
 MhtNaTgNZofmUK4XjZqepXewyhQc5rMYBiLqGzAw1WvwS49Ne88fYCUSSjX+L8eRajYmapvWDxG
 nUcm/l8DelenyXUHcfpJ2KjrIJXlJn/jS0QxQK35z+XxY54iaeP97+XXKkleL8221hWnj7Lry4K
 rt32jyYjE48VnE4FBHjG82CAfYdy5jVJS/Z22oiY/4hEztkBMhwPIRUz2T6unNqL0ntudkPxj5J
 WMevsRSva3JPih/kqTgywozzjdn45vQdWdewSbcuHAIFIVS/bFkS+gUJmn4KnE3jXOBwk+oVH95
 9dicnovCZQZtz3Nw/tlYDiZ7D0S+hqrMwWmQQxW/E8PwAj8gkNnn/y1AwWMwNAkZngL1piMz0As
 HKhRM/lH+HGPO5NmWBvtcMA7g/dVEtoL0eLwOftmcDxtduE/APfFhhB4wg4Vnhp6GQDm17RRSFd
 ADHg8IJqTWbd+eTK7S6ZbZcdJF0atl+Woy4oUaBCC+S7utY4McEQ+2UCCUqqUFCF8sO0d5EW0kg
 8izkeVHKaGjmjEpw5MDP84RnSWo3/rvlQkTqPjFg77fhE09YfIGs4Us8OLUYw8ufK+PfFq3Ctz/
 JXexTUFnVZ3zXDQ==
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
Changes in v5:
- Fixed a kernel doc syntax syntax (Simon)
- Link to v4: https://lore.kernel.org/r/20250204-netcon_cpu-v4-0-9480266ef556@debian.org

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
base-commit: 09717c28b76c30b1dc8c261c855ffb2406abab2e
change-id: 20241108-netcon_cpu-ce3917e88f4b

Best regards,
-- 
Breno Leitao <leitao@debian.org>


