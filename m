Return-Path: <linux-kselftest+bounces-12463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E965D912E5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F47282C38
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3D17BB12;
	Fri, 21 Jun 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="E364x/FA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A016CD0A;
	Fri, 21 Jun 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000910; cv=none; b=Q6pmAUdpswAuEVThFf8IUuwYgDGHnuYPIyOVVxdzhYqTPUAsFnfTSHDBY8yFr/LXeg4ofJ6imvxrHMK+ZuIi9ojK73r5zmiqMbSPVI+SL7Qb5bIez+dhv4cg/xPHHN1+0Da4FGBZX9QfL13Kc/ajVBlIhuUTxJN7DqL3zf/a7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000910; c=relaxed/simple;
	bh=dEX0u7dN1C43v2kpsVBy05pvZaud4mLL4Q1/HJRJOzM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNtKOCi1+5rUAKWpbcIMw7qalomzSJCkZC+B3jWWd7eBYG3QCkwwNCa49tUujH8NMSRF94143AnS451fnea9UWgHJfhMow+3KNwifRh5sQpfrfEtaOJJevmPkllo6CW+VoRZWFf2PCyTlKjUl5FoUutKg3MBqgoMSxX8jUG4zf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=E364x/FA; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719000909; x=1750536909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cjFX5+KGjVctEsjcauGEjNTPHotOoWaKJe6iGg4ahqE=;
  b=E364x/FAeIT62/p+ewivUekBvtz+R5VGS/7rnjdoeTuANC8T23V4hw/1
   0YyLbDHORbL/RZ/DiXynbrGEdJO7AaIiiYVOnqQS9znFONgVWxsin2too
   4UDzxDIqqB4OROkSa1gMA6+/u4nFwPpHr/fC6Vwv9eoKEyjhmTV324MD+
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,255,1712620800"; 
   d="scan'208";a="98641151"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 20:15:06 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:58514]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.94.206:2525] with esmtp (Farcaster)
 id 6cecfc43-1604-431e-b151-5844ee09a129; Fri, 21 Jun 2024 20:15:06 +0000 (UTC)
X-Farcaster-Flow-ID: 6cecfc43-1604-431e-b151-5844ee09a129
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:06 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:05 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.95.134.31) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34 via Frontend Transport; Fri, 21 Jun 2024 20:15:02 +0000
From: Roman Kagan <rkagan@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Dragan Cvetic <dragan.cvetic@amd.com>,
	Fares Mehanna <faresx@amazon.de>, Alexander Graf <graf@amazon.de>, "Derek
 Kiernan" <derek.kiernan@amd.com>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-mm@kvack.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 0/3] add support for mm-local memory allocations
Date: Fri, 21 Jun 2024 22:14:58 +0200
Message-ID: <20240621201501.1059948-1-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In a series posted a few years ago [1], a proposal was put forward to allow the
kernel to allocate memory local to a mm and thus push it out of reach for
current and future speculation-based cross-process attacks.  We still believe
this is a nice thing to have.

However, in the time passed since that post Linux mm has grown quite a few new
goodies, so we'd like to explore possibilities to implement this functionality
with less effort and churn leveraging the now available facilities.

Specifically, this is a proof-of-concept attempt to implement mm-local
allocations piggy-backing on memfd_secret(), using regular user addressess but
pinning the pages and flipping the user/supervisor flag on the respective PTEs
to make them directly accessible from kernel, and sealing the VMA to prevent
userland from taking over the address range.  The approach allowed to delegate
all the heavy lifting -- address management, interactions with the direct map,
cleanup on mm teardown -- to the existing infrastructure, and required zero
architecture-specific code.

Compared to the approach used in the orignal series, where a dedicated kernel
address range and thus a dedicated PGD was used for mm-local allocations, the
one proposed here may have certain drawbacks, in particular

- using user addresses for kernel memory may violate assumptions in various
  parts of kernel code which we may not have identified with smoke tests we did

- the allocated addresses are guessable by the userland (ATM they are even
  visible in /proc/PID/maps but that's fixable) which may weaken the security
  posture

Also included is a simple test driver and selftest to smoke test and showcase
the feature.

The code is PoC RFC and lacks a lot of checks and special case handling, but
demonstrates the idea.  We'd appreciate any feedback on whether it's a viable
approach or it should better be abandoned in favor of the one with dedicated
PGD / kernel address range or yet something else.

[1] https://lore.kernel.org/lkml/20190612170834.14855-1-mhillenb@amazon.de/

Fares Mehanna (2):
  mseal: expose interface to seal / unseal user memory ranges
  mm/secretmem: implement mm-local kernel allocations

Roman Kagan (1):
  drivers/misc: add test driver and selftest for proclocal allocator

 drivers/misc/Makefile                         |   1 +
 tools/testing/selftests/proclocal/Makefile    |   6 +
 include/linux/secretmem.h                     |   8 +
 mm/internal.h                                 |   7 +
 drivers/misc/proclocal-test.c                 | 200 +++++++++++++++++
 mm/gup.c                                      |   4 +-
 mm/mseal.c                                    |  81 ++++---
 mm/secretmem.c                                | 208 ++++++++++++++++++
 .../selftests/proclocal/proclocal-test.c      | 150 +++++++++++++
 drivers/misc/Kconfig                          |  15 ++
 tools/testing/selftests/proclocal/.gitignore  |   1 +
 11 files changed, 649 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/proclocal/Makefile
 create mode 100644 drivers/misc/proclocal-test.c
 create mode 100644 tools/testing/selftests/proclocal/proclocal-test.c
 create mode 100644 tools/testing/selftests/proclocal/.gitignore

-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


