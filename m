Return-Path: <linux-kselftest+bounces-9446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3688BB8CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE0E1C20DC8
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FAA38;
	Sat,  4 May 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyWGyDeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038D7FF;
	Sat,  4 May 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782785; cv=none; b=Mqv1WzCexBBBFKEtB4OWqlu5UPhjw9Ig/e8QK9/QPwwO2CWoy7o+AZBXfVeOKv0D5JVLAFhYKYVyvX+feD6SItVvMs1XXeAY8HjGqZM3Cyl2Y6PcrpWNCA10p0aOkIV8zbygTHbWOUsy7nKVxa+qKpEfr+YQQRgStW3t4i1l3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782785; c=relaxed/simple;
	bh=dpWHdf4Lt2qh5ayzdY4gmrM1LxVv8Xrq9e3MVXxRmOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ThWXkGpYaGW4NwlKxhedzsWkSW6ekffMvyY4hn4r4j8mTu1yZPbzbO+anXyvvcv7OYPimlB5qrZZ2sz8Qf5306t9OuENgemoxboD7KhoNVR2oEPA44yTkYnLSWc235FwwKIHTQI6L/8kgrApxppc9EkYM5pPV5hNb1Kl1jfjSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyWGyDeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023DEC116B1;
	Sat,  4 May 2024 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782785;
	bh=dpWHdf4Lt2qh5ayzdY4gmrM1LxVv8Xrq9e3MVXxRmOY=;
	h=From:To:Cc:Subject:Date:From;
	b=AyWGyDePNZdxf2QmO3ycbQDZ8aq17SLAx915yM+hq6bof50If3TJG+3cw7F8NJCZB
	 3wlCAnO6Fs1oFL3NekW+8HlfVqSJ4V1XOyvNxIkntqr4FF5Zl/dSU79Xud1uJFFTZL
	 PdKSbtASXioFDMy2tzWxP21+tTLD36qQTAIhru+ODHfnMfcjTqeQ+vXikmNlCEJmuf
	 /K2+aWNUmTIZskmSkPpzL6NOdHGxB3w+VtO8DcTX0ZKr/vRA9jAqVve57ZHX9Wqx9C
	 Td1jYbrNKh1ucg1e4nKciGrMun55k9JCUvHCTnObg6Zi92iOdc+70oMPDq4bx/YRan
	 A+mAtHavm5Cgw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] selftests/ftrace: Fix some errors
Date: Sat,  4 May 2024 09:32:58 +0900
Message-Id: <171478277880.109670.10932081511777701353.stgit@devnote2>
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

Here is a couple of patches for fixing errors on ftracetest.
Shuah, can you pick these to your fixes branch? Or I also can push it.

Thank you,
---

Masami Hiramatsu (Google) (2):
      selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly
      selftests/ftrace: Fix checkbashisms errors


 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |    2 +-
 .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |    2 +-
 .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

