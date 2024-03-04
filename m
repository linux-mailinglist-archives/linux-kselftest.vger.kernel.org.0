Return-Path: <linux-kselftest+bounces-5810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B586F900
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2E21C20A20
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A233D1;
	Mon,  4 Mar 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMfzHCFR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D56613A;
	Mon,  4 Mar 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523650; cv=none; b=Za2kRW6DBTnEey9Eq7TD/0PErCNUbczhuQAGLMpdkZCA8wr/o/BEdnP78WnBZvs49fe+AW4Dyopy3Pq3mxuE4e5/03+eGzTei2MGFo+DyVlxxcuggqNMC6PCkZHN4kCq8bX6uWk92zX+iDO7DL2cmyYdIS22fJChbfDs9e+29nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523650; c=relaxed/simple;
	bh=JOiQGf8AkuLDba6mZptSjrJ64jXNcst88pFN6BENs2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnpiO+7Kl5ddfIf5cHE/uR40kLSaSNvTWC9f6TQHBZ5uoCkwPttDwq9AvHz3kgobB+vzEQAwFW3kh+sFhXMO0Gzvnatg7TX+J1rgaa+rpS2vf3z/ZyW4fyOk0JxJV9eVKrwmXw/jrfdwKTY52nfusb5ajeNUas9d6qfBQKztoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMfzHCFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461ACC433F1;
	Mon,  4 Mar 2024 03:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523650;
	bh=JOiQGf8AkuLDba6mZptSjrJ64jXNcst88pFN6BENs2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMfzHCFRn1m/iFXZjsu3f9uPO6ciPqAFm5qem2l0RoitTTr3fj31eKZRyOkdnRHgV
	 IRvw1ocrf5bc/FrITz2gA4KQMIKPI/oIDoGbnbTyF/xKE1pw6Y7RTBUJb1wCn6m8IK
	 fqnPdfQHWKg4bq+7W+vi0aIaOu2QU/HLsfTUoRKDAbUxNWPtIMMNyI/73Av/yJY8O5
	 39M/S/44JhZvRnqh4l17i3jLrmpu83mT3LqAJjhLiz24JVrIaeSg0oqziST8r1Son3
	 e6prsPegjgk2tu3h8rtrqp+8+6Kb+iWqqNe5QtBK6Lx345uRBx7QIwQKu2MGJ6WEvN
	 36s6eXaAMDQ0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/8] tracing: Remove redundant #else block for BTF args from README
Date: Mon,  4 Mar 2024 12:40:45 +0900
Message-Id: <170952364558.229804.17285528811097152410.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170952359657.229804.14867636035660590574.stgit@devnote2>
References: <170952359657.229804.14867636035660590574.stgit@devnote2>
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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


