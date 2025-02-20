Return-Path: <linux-kselftest+bounces-27101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B418A3E479
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1BF7AAD4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE4263F54;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5F26388C;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077899; cv=none; b=liQgh2h5Xf3BgX8uKI8kw//+jg0LKCUdkE1/0KkmfNjSzG4tQM2Z3M4Nji7gTF8+WfUJ+NLC90bna3c7x+tpeTXidHm5C8XKZ8ILSnGACUWArYILo4X1k2UFgWkystGW7LhMywdf2oYexb4MjBH97RKlXrWx9mPNuaEDw1nLBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077899; c=relaxed/simple;
	bh=Efnf9gDllCLF+wDUfnuFW17d2G76IKsnJdN3dFQHTzA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=OHt56QhGA8ilq1VOtNwQKDGg9hub4a84d31wQZbovVHgS6hlTDCCMDrP1bynpSfEzgR4esZAtHFjdvyvi/Y4Z+JX1jODOTcMLX6RPZJKVH20i7RHpPEgbv8XcmGQB5rCC+iQNFjjSlHTM2zkS+6aRDf7tAfWYatfqnpQl4mPaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E82C4CED1;
	Thu, 20 Feb 2025 18:58:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlBl0-00000005cQr-0Q6w;
	Thu, 20 Feb 2025 13:58:46 -0500
Message-ID: <20250220185759.811830333@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 20 Feb 2025 13:57:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [RESEND][PATCH 0/3] selftests/tracing: Test only toplevel README file not the instances
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Allow some more tests to run in instances. There's a few tests that
require something in README to be present to run. But currently README
can't be used for instance tests. Fix that and then allow 4 more tests
to run in instances.

[ RESEND to include selftest maintainers and lists:
  original: https://lore.kernel.org/linux-trace-kernel/20250116012009.840870709@goodmis.org/ ]


Steven Rostedt (3):
      selftests/tracing: Test only toplevel README file not the instances
      selftests/ftrace: Clean up triggers after setting them
      selftests/tracing: Allow some more tests to run in instances

----
 tools/testing/selftests/ftrace/test.d/functions                   | 8 +++++++-
 .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc       | 1 +
 .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc    | 3 +++
 .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc    | 3 +++
 .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc   | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

