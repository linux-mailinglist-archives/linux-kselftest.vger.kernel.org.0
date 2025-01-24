Return-Path: <linux-kselftest+bounces-25100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F68A1B8B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7843AC2EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C4136E09;
	Fri, 24 Jan 2025 15:17:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC13111AD;
	Fri, 24 Jan 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731825; cv=none; b=TJNpchOBOY5OUSFKHO/M3ZhANVdDpnEfcV5QXeHSJzOeTNjBwVnWAxpWZZWcG4gLelGQxEj9rSg+10gCf+WVGcrLuZdu35AyQbzokRs3CI2m5PqDAzKZC16iHWe0wMUq94pbczrb88HMBd166CfNCYCkkgdpRRoy0Kxllnht8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731825; c=relaxed/simple;
	bh=I4tDXjbNoT4LxIzUcPbb+zTkPoor0NL5j0tVYugIgao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XhWc8pEHYBgxxOaIeYT2XgS/J3QxwDQfkDv5oip+qJsWl6pFib+C1xDEJr5pC+n96znPHps0cOonCwkgUViE9793vumMxeCLAHY7o2W6GxWHnNkOsgfOVhVK1+OjF/c0HFVfIVE4V14PUHQXJyj0YGHZ1FYRwtqD4MCNAGhSsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67ac42819so357016766b.0;
        Fri, 24 Jan 2025 07:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731822; x=1738336622;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiDVaLfQdBUsgPZv4KWE0dcxSIzXd3jvj05N3hqQrkw=;
        b=taEHgX1P0CoAgpTqZWpzagoEUlqJbp605THVAVz80SO6KYgdbddjZ78Ep2pMg4xu5L
         z0IZBHJ822s877VNL7hB6eaJ9BQlvBV/shkBHER7usBIz+GfLVFQLIUtV/snG1hXgCa/
         HnkTfwjFKcSHtRCHUq/uqumVKhLz4VbyvhNbu0h9tkhEZK4mHnkubDBzPwWLUwCijGgd
         dsRCIlu1FkfUIjIxgJzE8ZPvOvIwHvIK2usGM04RsP+wY098aHEHRxwg+tS7yCr0MbbP
         0B9InHighNXNUogK/GmT2/s8vz/ps6Z2kHs+iUWAI+gMqfYE9C9FhcUlR6jVSIEEqOTF
         sS/g==
X-Forwarded-Encrypted: i=1; AJvYcCUR1nVJ5ooKJGPx1FNrMwH6OWSQsTpWCyqZO3P2EsQA58KVrc4RC35X2h3GWndr2YHL5VwuK0NruKiimRwG@vger.kernel.org, AJvYcCUf/Cqsv2PNsTpqsMGv37x6r5dVJcz8vTOsirzEkIubjrv+waIxXgucvOdWeQF+6DxlsOoaUmWWmAc=@vger.kernel.org, AJvYcCX6N79uKhkab4nxh6CWvM+fnOgVXfn9x7hVmlEeCVQ8IxYYE3BsBLmuTwFaiypm+h/03fnynq3owkZMvInJtkC4@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYGHVbIKz4gKWeM1jWzOqyo3Y6km6rF7EfSbiCHjJzRAh11Y5
	4H9fmxP1bA47den5rLLoHpUukraDIlQcwmzk2GSsEkOhsY+F5gNyRVg6sg==
X-Gm-Gg: ASbGncsHvJXrwkiR5LeseCd41DvyLui3aJlX19s5J4xSzrWvXSpW45Lg/AEPLbBLLYD
	GRZiFksVSGI496Z0Qy1/VLTH9AeyTpoGrH3hmkbawJkMOHtN3GufneKTNHXQmb11rxcZwk83Ji2
	9H0Ftfwkd56+c/Is0KqIQJ7H8HrNxk5FOEqYc5U9TKxnkRWy5mHfqGDaOFRb1TkcHMgdy37YIUg
	NLwVxr363LxGjBBm22caDiCiKLwuYDcTH0d0XkiDhreoxKZByUdCou6qELyr5zlYH9ZAuy+cMMM
	x+xLEA==
X-Google-Smtp-Source: AGHT+IGaEysIzJ+FvecPICu7FWwm893o/oSK2o0KS2BjDOuOMqFALXfkbNcBUpXteS2VGXltB4OPHg==
X-Received: by 2002:a17:907:706:b0:aa6:5201:7ae3 with SMTP id a640c23a62f3a-ab38b3b23e1mr3234662966b.40.1737731821293;
        Fri, 24 Jan 2025 07:17:01 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676114e14sm140324566b.163.2025.01.24.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RFC net-next v3 0/8] netconsole: Add support for CPU
 population
Date: Fri, 24 Jan 2025 07:16:39 -0800
Message-Id: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANeuk2cC/1XNQQqDMBCF4auEWZuSiUmNrgqFHqDbUorGUbNJJ
 FqxiHcvtRTqdnj/NwsMFB0NULAFIk1ucMFDwdKEge1K3xJ3NRQMpJAKURjuabTBP2z/5JbSHDM
 yplEVJAz6SI2bN+wG18v5c/M0ck/zCPeEQeeGMcTX9mzCbfZ1Mf13J+SC12iyqsmsSCWeaqpc6
 Q8htpszyV+rBaLetZILnus8w0qp2urjrl3X9Q1epiWD8gAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6455; i=leitao@debian.org;
 h=from:subject:message-id; bh=I4tDXjbNoT4LxIzUcPbb+zTkPoor0NL5j0tVYugIgao=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67qwqJLef6THzZ4hZkIi/d99dIiCtTfZ51Yr
 BcvTtoqHw2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6gAKCRA1o5Of/Hh3
 bTjgD/9N5BNHsxHvM/WU6q9j91jY0D+1I9Q94y10mVlZ9QxOfbG40Zp5QIDEb7pbJyCzEmVAtu2
 38JFj8iSntrEitSGZ/ReFIu/9r1+qd4ZxzipJ6MBCgFAjquqwKmXidNxnxM/p2DnB7BRyuvP8/4
 Cy+6t8ISGNUHgHRPrg5zEmhQNVX52lSF/BEvFHkTb8TtpYrEVduS1A5owRFPqI7kVgF30LmSlqS
 APlwmEoSr2i6ZPHgkEM0oB0wr1et/LTKU+pMXXxjbThq/0Nk/KXnxyExfKu/ecOWULhLqJVaueU
 ggrsfXYrIOHNg4GyhzjmmnrNGFGG1pO/vGGdC9M9PwagVFo75nNEoWGs0/qXrXa9DglEeH+Zvjc
 OcGwMRAgS4NiKfoGDs6I641rOzuMoXSs4K9UsoMbVS1m5UqYLkcewYHvl7PI70krLmJ52j4gFkx
 A1jHzmxuf7xwhNgeSpVi4S3Jxr/+w1umlobpm9/ljZmtbzWqdpZuNOoPgXKRbXUxTxp09lNV+a8
 09nOP1fs4PLdR8tQh8b5/AEiOTZyX77q+07BhsN2XK3vJsXeZtikjxXGeXoQIlbgijT8SpqRFmU
 UVHHKltVWA5rrRj1LfAcT2WjijqaH/NirvSJEqnSyGssZRRCMRJ5kEzZNedkWe0WXq61IFIfd8M
 KXWNy1FaBu7XoAg==
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

Signed-off-by: Breno Leitao <leitao@debian.org>
---
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
 drivers/net/netconsole.c                           | 260 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  17 ++
 .../selftests/drivers/net/netcons_sysdata.sh       | 167 +++++++++++++
 5 files changed, 426 insertions(+), 64 deletions(-)
---
base-commit: fa10c9f5aa705deb43fd65623508074bee942764
change-id: 20241108-netcon_cpu-ce3917e88f4b

Best regards,
-- 
Breno Leitao <leitao@debian.org>


