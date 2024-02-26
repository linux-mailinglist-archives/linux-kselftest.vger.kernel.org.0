Return-Path: <linux-kselftest+bounces-5421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4424866904
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897911F2583A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05C1BF2A;
	Mon, 26 Feb 2024 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwAL/jtI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CC1C298;
	Mon, 26 Feb 2024 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919917; cv=none; b=SfG2KP/mwaU0+jaggtJF5dBYCFCx1bXtQ2F58aqhWG4KJklyBoL1w/woLhiceq93UliJhrCy+Xd5bp7StdMZINpvhZfWpRhXTeGFJZmvKqOFxu5/r2QcEydS8X1lmfL+g9nxktzw4CN/u6yKHl+I4cJP+L2jvBRlbFUMgs2LLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919917; c=relaxed/simple;
	bh=TGK9QlcDxLT9CnDYoo+UqUBylwx5xCUZ8XqKKirz2R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAxjseAHfa0RpjEJiYy7zM0ktlklsQpNkvFpLN7570iRari+GujLbPY/bK6lFmBb1tniItjMuWsnre9VMNXXkoBPh6/kKUxOImLnEmw7xxN/3vO9+F6Vy27duRB0Ehs20KkGHsdIu26HCaFsOBxH+BWXLCZ9Y0Ky9DmyThEi9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwAL/jtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C69C433F1;
	Mon, 26 Feb 2024 03:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919917;
	bh=TGK9QlcDxLT9CnDYoo+UqUBylwx5xCUZ8XqKKirz2R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwAL/jtIEFR8smXK99bWFXInd5TvaXsFmefowiPMBIkMw3GJTrhVpK1X57kwj7WcW
	 WvcpXAkibuNtn2MmXeL9FQQXoB6m2qj18vNy09VfvIc35DRUTi1NTkV1CMwkBa6ScQ
	 /E2AQgDELeVHl4TNOoVTnb/VyP9VMIkA+wss3zRbAUwEgVHPefRit4vnlRXT0gCftN
	 2vahTkV6KL7CK0+5g6chtmJ9y28M1L9eSuBr1UYWOsN/elWgf8rJqTYdQqMy9b+VEK
	 yrbrK1740l2LquznMVgJeBNwhKyi1ZeUKAtuehKClFn094TjbOVsTqKwbbgsRAxHFW
	 NH4m8J9fRIIyg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/7] tracing: Remove redundant #else block for BTF args from README
Date: Mon, 26 Feb 2024 12:58:33 +0900
Message-Id: <170891991338.609861.6605068606690943019.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170891987362.609861.6767830614537418260.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
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

Remove redundant #else block for BTF args from README message.
This is a cleanup, so no change on the message.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..516c585f5879 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5747,11 +5747,9 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<offset>],\n"
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 	"\t           <argname>[->field[->field|.field...]],\n"
-#else
-	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #endif
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"


