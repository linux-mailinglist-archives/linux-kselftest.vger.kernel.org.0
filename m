Return-Path: <linux-kselftest+bounces-10452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F88CA547
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 02:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C401C214ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336347A5C;
	Tue, 21 May 2024 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PswzUz4U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5712D05D;
	Tue, 21 May 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249617; cv=none; b=OYMPJmTz/l68Bh/Fb60ZEO0enhlquHUACLV7Q3Wr5/69zQSWF2BgToWO/C4sJle+ZCf9P8nZds2984++tdK+AUmzSLn8ME7bZCiRspidEQ7H79P08+GuASQ0d6ZHXx9UDKo4ru3P/4g2T9SK6bivXf/HVEuDk43dULoU8d05dKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249617; c=relaxed/simple;
	bh=M6fK2QjVTyZpLYDWsH9B5XiDlgg7Qj/yroYm1r2MPzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kZO3cbQO/zBNVN800UrZ1g9YZrd2d3r7EBm7EPuvcTlgbMRXTXuRoedaFKfBEaq8T6E/+2f3CLz+b+jbz11YTRO73Ccx+CcOJcf6pgWHt82TE0XZwJB8bQRP7OO1gIg+yU0gtVWFA9SQHgVwkWd+/0cBmI0GLXpKyVFf9PX9FCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PswzUz4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC731C2BD10;
	Tue, 21 May 2024 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716249617;
	bh=M6fK2QjVTyZpLYDWsH9B5XiDlgg7Qj/yroYm1r2MPzA=;
	h=From:To:Cc:Subject:Date:From;
	b=PswzUz4UbGnrNJGtVcmJfi9JId5K6kWEu6MwTPtfsBksk4kiYPzR8Xvx9iRDlYjOV
	 0PCWxOvQmfZGcwK22cOT+tjaMJPrXg7bbkx9/jaPyEptZSTbZqLUaME9nV5T1Xcion
	 re4L3xgyNzXRJK6FBz2S7fszixsIYD4JV+lharL7NqyF7o4XcCtYDr6M6TM1W0iSuh
	 WcBntAkhJUswOVe9+hSxgDlDjZ6Mj8ASWXAt/hsMczuK52T8bLpX+/ngk2anOkCVvk
	 rUCbnBX0eL9RNnfqozNx08vL27pzgjvdJuF7b+j+eopcxlBMSHAAgC0jVhHj/iBPx5
	 7bRDvrXAGUsGQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] selftests/ftrace: Fix config related issues
Date: Tue, 21 May 2024 09:00:13 +0900
Message-Id: <171624961322.252417.15852003285637286674.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Here is a couple of patches to fix some issues related to kconfig.
I found these issues when I built the kernel with
tools/testing/selftests/ftrace/config.

Thank you,
---

Masami Hiramatsu (Google) (2):
      selftests/ftrace: Fix to check required event file
      selftests/ftrace: Update required config


 tools/testing/selftests/ftrace/config              |   26 +++++++++++++++-----
 .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
 2 files changed, 20 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

