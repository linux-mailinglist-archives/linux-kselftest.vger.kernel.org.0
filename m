Return-Path: <linux-kselftest+bounces-5806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412786F8F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEE228150F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469B33D1;
	Mon,  4 Mar 2024 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NacBqozn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005346ABF;
	Mon,  4 Mar 2024 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523611; cv=none; b=SglWrATUccwsld1cnE998xkQK2AtRTuLd4LfqW1lguhag7HTUn7yNWCnvVfXmZTaoA0/7O2DyJq83h29N9+QWO8RI87f1Hl8eg+ZfYs1cxuM14Gogb/L0dSAhrLYxQtF8PTg8VEz8e9+Pl4ocpDCr/NWHEPHC+2OiZi1SaZ8n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523611; c=relaxed/simple;
	bh=S57LBagA5sfS5PxIPRcS7nfl3DEhORZYcIUUZT8qPdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvY3NgJHHDo84RKB8mZhz/nGHgQE4QCdqAOLZzQliVvHAxOazLd2opmLI0/bi07LsGH6yU4/0d3oc0DR76BBLpJFN8bNZnr1HYnlgJH8tMocZdtU17IxbS8ozibz+o4edtH2MpngrpRioQignfseu4Omqk6tfFP+JqztPLvjycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NacBqozn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2D8C433F1;
	Mon,  4 Mar 2024 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523610;
	bh=S57LBagA5sfS5PxIPRcS7nfl3DEhORZYcIUUZT8qPdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NacBqoznCzzfaWEgzeK4cvGYokk7JfPd7hZI2y1k3H9t5eH8As1V1XnB/k5PW8iIA
	 LHiFLnzBTQ4dfIsZTn7REGHpP+GdHprxLw50GHsRIgjC6fJyU7DFGF/I7rJzQ7JcdK
	 XuyJMdgX9pPMbh10GuKq2QWoupVs4QhdOdgDJULEMQinHfHPrBwOaW+A+IF1uzzYcD
	 tvTBbnDwx6g21Phai5nKIh0L++9ZZcVdcgqqRiV/01leBSzP28ZK3/5fB7GYlUF3J+
	 KSzCYCRKKb2yNHSLn368v5CR0iqK45rFyAFoNXQUJTOl3gtc4AoCYIZRw0bv6Oi/S/
	 S6Wr1vQUJCfuw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/8] fprobe: Fix to allocate entry_data_size buffer with rethook instances
Date: Mon,  4 Mar 2024 12:40:06 +0900
Message-Id: <170952360657.229804.345771440723430834.stgit@devnote2>
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

Fix to allocate fprobe::entry_data_size buffer with rethook instances.
If fprobe doesn't allocate entry_data_size buffer for each rethook instance,
fprobe entry handler can cause a buffer overrun when storing entry data in
entry handler.

Link: https://lore.kernel.org/all/170920576727.107552.638161246679734051.stgit@devnote2/

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Closes: https://lore.kernel.org/all/Zd9eBn2FTQzYyg7L@krava/
Fixes: 4bbd93455659 ("kprobes: kretprobe scalability improvement")
Cc: stable@vger.kernel.org
Tested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6cd2a4e3afb8..9ff018245840 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int size;
 
-	if (num <= 0)
-		return -EINVAL;
-
 	if (!fp->exit_handler) {
 		fp->rethook = NULL;
 		return 0;
@@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 
 	/* Initialize rethook if needed */
 	if (fp->nr_maxactive)
-		size = fp->nr_maxactive;
+		num = fp->nr_maxactive;
 	else
-		size = num * num_possible_cpus() * 2;
-	if (size <= 0)
+		num *= num_possible_cpus() * 2;
+	if (num <= 0)
 		return -EINVAL;
 
+	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
+
 	/* Initialize rethook */
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
-				sizeof(struct fprobe_rethook_node), size);
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
 	if (IS_ERR(fp->rethook))
 		return PTR_ERR(fp->rethook);
 


