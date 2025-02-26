Return-Path: <linux-kselftest+bounces-27564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB031A4557E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A0D17B8DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9F726869E;
	Wed, 26 Feb 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1sxNdH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171C25D537;
	Wed, 26 Feb 2025 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550778; cv=none; b=aglvSlM1n30nfjL5RcjO+kVcIasjztHF1XELMkK1Hqwo4yZKm84Vklo71FBLt4/UCgFqvbZv7Yur6vIERLMANLefKfp4YbsCXbPURz0+I5hVpsaeQqv4ezmIBou3rSvVffCTar7q1FWcsUya7W+Uza2z+ySAg1wHC1Vs1RUsdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550778; c=relaxed/simple;
	bh=rTIWsvwSXOxRGP7gdPh5Kj5+1kZtjKcGRJoEmjFzL94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cb/QA8Krj8H32ucjbVu3J+A6xq05ha3Xh8mZUElOV4TPf81wtZfble2IlBmpv5xKqcS88uZzLr+OZ/ml9EWTd0VwEhpyizLKDJhF4Rg1zxmWv/4i/pxIMIAokHIbYY0dCXIu6bO/u0bsiCfvQlc8LDpU+uQdPCg/+s/YCykDHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1sxNdH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F2CC4CEE2;
	Wed, 26 Feb 2025 06:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550777;
	bh=rTIWsvwSXOxRGP7gdPh5Kj5+1kZtjKcGRJoEmjFzL94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1sxNdH9K5GH7hn4OGHnIraoyvp5d9iEK5FAL/VQZIZXPwZpUO4ch6TAgzA/s3vEx
	 Z8/IcnmC8URMVb5LLpOcK4yNC/GcKXk8ui/NJS/a8f1/XPboScV/lpk6Hd2JHcVPQ8
	 7ImrbH6945f7+uw9KbTCUCXei2iSwjk1Lg/7aW5f7q/4Fg3NVW3nYwx7GFIihjzKu3
	 EkqUFvo7yl6hGZ8IBglY2XfsZf9L6LHfc20BgJ1UNvMviQksmtQMV135Z5ELapLTc4
	 5tX3nWvM6C4Yv9tu6k/lmEBLSw0A96QwmgIIbCjSzbcOeGCKIkEKbAoEubDjsC+v2o
	 UyJ3cKWdF2+Jw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 7/8] selftests/ftrace: Add new syntax error test
Date: Wed, 26 Feb 2025 15:19:35 +0900
Message-ID:  <174055077485.4079315.3624012056141021755.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
References:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
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

Add BAD_TP_NAME syntax error message check.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index c9425a34fae3..fee479295e2f 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -27,6 +27,7 @@ check_error 'f:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
 check_error 'f:^ vfs_read'		# NO_EVENT_NAME
 check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
 check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
+check_error 't kmem^/kfree'       # BAD_TP_NAME
 
 check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 


