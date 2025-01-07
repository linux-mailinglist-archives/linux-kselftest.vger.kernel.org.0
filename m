Return-Path: <linux-kselftest+bounces-23981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E11FA03ECC
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115AA3A0717
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30221E131B;
	Tue,  7 Jan 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg7mflJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561E1DF756;
	Tue,  7 Jan 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251862; cv=none; b=XSV0zCiyLvgo5v3hnhnpR8x/wznfShjxyELmxnpC0QmLKWHU55gWj5owHvMTGO6j1Qs1r4l4FDhealWetLUfXXo1zwUhe3dsTtVYNjpZnkCkkKnjgFfj0jK2eBV7XR+3NWuUGHGraQ/4MW5I7RUQTTwmfwx1TlN6c9ZVMpa/wlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251862; c=relaxed/simple;
	bh=R47DTda37APvq+1TJKFhmAoY6opYe++laPAmzeVqy44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQn9GBlN90gTCjR9M6luXZq4oav2kiwTTj2DOHfvCdobWj546TjwHMmgRHpdmICbg5jUmyviRtuOUCaRAjBTi6znalQvbsqxRz+rlxiU4B7OBkDTp/WjrfpfwUiiJnpYA9gVIS2/ANPHhI6OvKaPagVGdy71zSNvnSMNtsBcE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg7mflJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696AAC4CED6;
	Tue,  7 Jan 2025 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251862;
	bh=R47DTda37APvq+1TJKFhmAoY6opYe++laPAmzeVqy44=;
	h=From:To:Cc:Subject:Date:From;
	b=Fg7mflJwSgchMpES9jN9xaj1eQ/vR3BEm9YLuoMNOnmjqt7cQVyMTDXVLZogS4b9W
	 gOj7YYuse9biIZ6Bb7A9Kmz1/7SQs5izWzRVaAJJgcQPM933l//0VblngaBwV6VZvp
	 79+om3dTwWq8cqO4jQsL6NfpJFdj8I3U9LmQp1tJ2P2Id83Xw2dRPo3f85iVq9ZK5I
	 3IkvyVVuGBXJobq/jdAUhRtc1cGbr/5WkV8fA2DY1VSEaxS1o8PFluOocJNaIZwHvW
	 obp7/wUtswmqeYlbg5/DGC9NULgXqSlwO3JcB4ejdh08w7uIufzYWboO888nRShs96
	 cSoWJFVPuf5+g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] selftests/ftrace: Fix ftracetest test cases
Date: Tue,  7 Jan 2025 21:10:58 +0900
Message-ID: <173625185823.1383744.4020760882101555349.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Here is a couple of patches to fix issues. I think mount_options.tc's one
is a real bug(I'm not sure how it worked), but another one is an enhancement
for (my) execution environment.
Anyway, those should go through kselftests tree.

Thank you,
---

Masami Hiramatsu (Google) (2):
      selftests/ftrace: Fix to use remount when testing mount GID option
      selftests/ftrace: Make uprobe test more robust against binary name


 .../ftrace/test.d/00basic/mount_options.tc         |    8 ++++----
 .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |    4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

