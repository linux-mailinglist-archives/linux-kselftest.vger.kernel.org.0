Return-Path: <linux-kselftest+bounces-11803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1B905E47
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 00:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4E2B23D70
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974912AAC6;
	Wed, 12 Jun 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaSDEKGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED11C14;
	Wed, 12 Jun 2024 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230334; cv=none; b=djZjmpp1MmBBqe1o7oS0yZ7axeJFmrznpnYAlxB6LP/n+3BEU0RN7L04NNrnnUbSRLxOiqyPCSbJjcqFdu/PxhWcREWpP1nEw1X2tG1eO432Hyb4Dyacv1O1e6YONYFXwM4iEmYF8Kb475o2U7JhwYdkH/B3if/aBZ96heiGArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230334; c=relaxed/simple;
	bh=u7GHi5Z1GZsq+IxhBO/WJI3EakrV1PcZZ0OzD6obEbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HyPKwZdUnSo3zbtb/XE5Qbt0otBLiwmpjRBHIxIjkA8nKh0feOJto6t60Q8U2qsIdF2HJz/A052tEU98JKvn/X8psMsvvILdDvdT/5BuofPWcaZgih1K8a4rge+7npWoTacvERPXKemJxKbEF1na8P34hTa+o1I1/5WSZnU+WS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaSDEKGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2575C116B1;
	Wed, 12 Jun 2024 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718230334;
	bh=u7GHi5Z1GZsq+IxhBO/WJI3EakrV1PcZZ0OzD6obEbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=eaSDEKGhkM2xrA4E0ZxP7iIKy4aKLWT9Si877cXaIg6KBLgbkH5EkaK658PolKZ1L
	 gtYDPLyGifDB3P8tgWQIH1mFdMHWLjcH/6VOSlSrRC9WwWzRzFipLeO2TbquXUA/PA
	 4gzsRE1f1n+TeqCg6LaxGLDXF5crzPp52nmQxDnfLQ6MOKiGb9siOhsZOCi4T7cXOI
	 dabEUinztOrM14elcnjXRD5q13tGc5JuwBuSfQdz4TblWEVUhtoRMVKHruDp1pw+1k
	 Gbr5XmC2v48+mu1kijPM5DXdR6dZz8OwhKlQ1DRuVaob9gqKciRPE86gJB7MCBxUGM
	 jkcP4qr1DwfxQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Add required dependency for kprobe tests
Date: Thu, 13 Jun 2024 07:12:10 +0900
Message-Id: <171823033048.152840.662759412433336839.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobe_args_{char,string}.tc are using available_filter_functions file
which is provided by function tracer. Thus if function tracer is disabled,
these tests are failed on recent kernels because tracefs_create_dir is
not raised events by adding a dynamic event.
Add available_filter_functions to requires line.

Fixes: 7c1130ea5cae ("test: ftrace: Fix kprobe test for eventfs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |    2 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index e21c9c27ece4..77f4c07cdcb8 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event char type argument
-# requires: kprobe_events
+# requires: kprobe_events available_filter_functions
 
 case `uname -m` in
 x86_64)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 93217d459556..39001073f7ed 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event string type argument
-# requires: kprobe_events
+# requires: kprobe_events available_filter_functions
 
 case `uname -m` in
 x86_64)


