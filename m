Return-Path: <linux-kselftest+bounces-5418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D38668FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE6C1F250B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A641B94E;
	Mon, 26 Feb 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKAgH8E/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0A1B947;
	Mon, 26 Feb 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919888; cv=none; b=sIAEATmiqUpVIvysB9cxmNDsdsnnopGRZR/JbGxe2XnzgJuCKh+Di5k2fUB0cE7DozWi1PbHG8+p0R8rbgKNvEbA/jYvwWQ2rad+rCZeGvGN+dGluli3Ds1uO0Axl77ojtkkR8Vc9ptsXotgcWL/VoC4UWFIh7uUTyV31jb/sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919888; c=relaxed/simple;
	bh=uBscQYEWaOjRVRSlzctG/Sn/fNhszLxXKt2J3iXHHPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW8b/gM7VhLRnmTefYJL1G8jsRX84qWsLB8c9Qg/KUvWDxii1JpcnIxeXF/W8gPXcDgXkEMQ5hOJT7I559Lev4TuIrlcSP/o3TSCa7tINFGd6fEUP66+xZRBRROuzHiNtbxIpoMftBg2rfah6fcheZDkuDxHv62E3XGGIPwYkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKAgH8E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F164C433F1;
	Mon, 26 Feb 2024 03:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919888;
	bh=uBscQYEWaOjRVRSlzctG/Sn/fNhszLxXKt2J3iXHHPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKAgH8E/OIWGmMV2x07dLdCnDAA/HbqMnUIVQzeFym+TXjuxO+5tmSqlClrj8u4N7
	 LQZlL7fb/+h4tSXecW2l64L4AFwZnA87UgpA9ufz91BWZvLfXGS8aGb3hwzMLr8nDl
	 A1xWn4YVnzFzd2VVmrbWY5V5Ccdd5EVozQlbw9HIPxtzH7DkuctnfrYvhYMHo+S+nJ
	 C1vKGz0MjuyAgNtrlCM7/d7m4U+Mq+/JYyOpnsSnxZDywhRgjCjnSnPhDH2+yI3vUv
	 YvCwlHbPaxbeccevHZNm29R41lsQn9pts7jq2wEljOkPI8ECrKpR5joiFjCRKqWaml
	 WJ+vSMEjJqyhg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/7] tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
Date: Mon, 26 Feb 2024 12:58:03 +0900
Message-Id: <170891988369.609861.16668663308029384207.stgit@devnote2>
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

Despite the fprobe event,  "Kretprobe" was commented. So fix it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 7d2ddbcfa377..3ccef4d82235 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -210,7 +210,7 @@ fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 }
 NOKPROBE_SYMBOL(fentry_trace_func);
 
-/* Kretprobe handler */
+/* function exit handler */
 static nokprobe_inline void
 __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 		   unsigned long ret_ip, struct pt_regs *regs,


