Return-Path: <linux-kselftest+bounces-33370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA75ABD1D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6800D1B6760E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298626463E;
	Tue, 20 May 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e902NndO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D56264633;
	Tue, 20 May 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729514; cv=none; b=Y7Rru2N6ditSC/7AFjXSqk80O0RfO61eipq0aRn/YzDTt155lDoX7nc8NtsCXK/kvADbaG62Qk9oDB9wCCroId1SkAJCmOJRk54aKGL2YVVBs+HhbzqwB+X4tCHiPpXcMISPiKJ8YwIyRbAqlfHF4kWqBoR1fnWLpqhwWSO6sDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729514; c=relaxed/simple;
	bh=0fMlZnOwy6++HE+XUWcaI2oMFuGmWDyAVKhdYgPKuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ieqm5jTDoNb2q2W6Ud5u8Cp0vOnwuKt+AwTuvqcwhDv0GylgSlBsHspUS+CwRzqo8kJ4qndqSaNQ2NMspg8InyKiJFnSCLv01A1IZuK7xQqpTgDXm7dVQstoNE+osifNqMxitjYFfpVmALonNXp7hPxvDxURnPAvlW3ZAt3jP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e902NndO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF113C4CEF0;
	Tue, 20 May 2025 08:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729514;
	bh=0fMlZnOwy6++HE+XUWcaI2oMFuGmWDyAVKhdYgPKuGo=;
	h=From:To:Cc:Subject:Date:From;
	b=e902NndOZUw6cSoa9nqPNUbRickIxHDAgazFGAo+CtnIJlX1mt3MOfdjNL7cnFnUX
	 evSpAsYPVquCgkBxrWFiJF2kOuCMWbk9oRXeGTlGsw7BgoePE+gnC2DmsPmLKqrnT3
	 zqHjuRsvsemq2uvVJYuVjnLiOK25BnUc5VQ+HVzGsvz2oPmJFbw29x8OWxg5EC4DDo
	 Qnl6gLMAcNrfCm3rv7ipTendt6gOtfzsIDBozqwksi8fTEsWCILOoPJQhZZXTYx8W2
	 LNvJhkq7SmKW7nVfNJyN2IkdoeKF70Kbl9TnGZBPi8VmCdfQ+Bspfrh/bGpmynR7bG
	 evtqkUoUKkOVg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	brendan.higgins@linux.dev,
	davidgow@google.com
Cc: tzungbi@kernel.org,
	rmoar@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] platform/chrome: Add Kunit tests for protocol device drivers
Date: Tue, 20 May 2025 08:24:27 +0000
Message-ID: <20250520082435.2255639-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The protocol device drivers under drivers/platform/chrome/ are responsible
to communicate to the ChromeOS EC (Embedded Controller).  They need to pack
the data in a pre-defined format and check if the EC responds accordingly.

The series adds some fundamental unit tests for the protocol.  It calls the
.cmd_xfer() and .pkt_xfer() callbacks (which are the most crucial parts for
the protocol), mocks the rest of the system, and checks if the interactions
are all correct.

The series isn't ready for landing.  It's more like a PoC for the
binary-level function redirection and its use cases.

The 1st patch adds ftrace stub which is originally from [1][2].  There is no
follow-up discussion about the ftrace stub.  As a result, the patch is still
on the mailing list.

The 2nd patch adds Kunit tests for cros_ec_i2c.  It relies on the ftrace stub
for redirecting cros_ec_{un,}register().

The 3rd patch uses static stub instead (if ftrace stub isn't really an option).
However, I'm not a big fan to change the production code (i.e. adding the
prologue in cros_ec_{un,}register()) for testing.

The 4th patch adds Kunit tests for cros_ec_spi.  It relies on the ftrace stub
for redirecting cros_ec_{un,}register() again.

The 5th patch calls .probe() directly instead of forcing the driver probe
needs to be synchronous.  In comparison with the 4th patch, I don't think
this is simpler.  I'd prefer to the way in the 4th patch.

After talked to Masami about the work, he suggested to use Kprobes for
function redirection.  The 6th patch adds kprobes stub.

The 7th patch uses kprobes stub instead for cros_ec_spi.

Questions:
- Are we going to support ftrace stub so that tests can use it?

- If ftrace stub isn't on the plate (e.g. due to too many dependencies), how
  about the kprobes stub?  Is it something we could pursue?

- (minor) I'm unsure if people would prefer 'kprobes stub' vs. 'kprobe stub'.

[1]: https://kunit.dev/mocking.html#binary-level-ftrace-et-al
[2]: https://lore.kernel.org/linux-kselftest/20220318021314.3225240-3-davidgow@google.com/

Daniel Latypov (1):
  kunit: expose ftrace-based API for stubbing out functions during tests

Tzung-Bi Shih (6):
  platform/chrome: kunit: cros_ec_i2c: Add tests with ftrace stub
  platform/chrome: kunit: cros_ec_i2c: Use static stub instead
  platform/chrome: kunit: cros_ec_spi: Add tests with ftrace stub
  platform/chrome: kunit: cros_ec_spi: Call .probe() directly
  kunit: Expose 'kprobes stub' API to redirect functions
  platform/chrome: kunit: cros_ec_spi: Use kprobes stub instead

 drivers/platform/chrome/Kconfig            |  17 +
 drivers/platform/chrome/Makefile           |   2 +
 drivers/platform/chrome/cros_ec.c          |   6 +
 drivers/platform/chrome/cros_ec_i2c_test.c | 479 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec_spi_test.c | 355 +++++++++++++++
 include/kunit/ftrace_stub.h                |  84 ++++
 include/kunit/kprobes_stub.h               |  19 +
 kernel/trace/ftrace.c                      |   3 +
 lib/kunit/Kconfig                          |  18 +
 lib/kunit/Makefile                         |   8 +
 lib/kunit/ftrace_stub.c                    | 139 ++++++
 lib/kunit/kprobes_stub.c                   | 113 +++++
 lib/kunit/kunit-example-test.c             |  27 +-
 lib/kunit/stubs_example.kunitconfig        |  11 +
 14 files changed, 1280 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/cros_ec_i2c_test.c
 create mode 100644 drivers/platform/chrome/cros_ec_spi_test.c
 create mode 100644 include/kunit/ftrace_stub.h
 create mode 100644 include/kunit/kprobes_stub.h
 create mode 100644 lib/kunit/ftrace_stub.c
 create mode 100644 lib/kunit/kprobes_stub.c
 create mode 100644 lib/kunit/stubs_example.kunitconfig

-- 
2.49.0.1101.gccaa498523-goog


