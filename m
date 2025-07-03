Return-Path: <linux-kselftest+bounces-36370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C227AF6920
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663D2523096
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 04:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA528DF3C;
	Thu,  3 Jul 2025 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE4ZddjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54B28DF25;
	Thu,  3 Jul 2025 04:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516807; cv=none; b=Vf4Vb3HnHQ/ZZTeXq3skH7HMFoku62XgqcF2v5GFn1xya3NEj2UPuPrCwRdBMD5yW5vleRK1sjEV5fKWZvTb/GisjTxIzkJ2aA7gGuWbiZpPwZzjowh/RW8glaYZVUsnjpf4rwiIwgifGAnfkEbkOShllygSMA9HdcoHLHDeTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516807; c=relaxed/simple;
	bh=X8sNzeR99XgAkSmmcSMhUw85PO/D7f6THghA0Cdf+Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjGZjcU0ab/hSSLdwLV9ipYlfvFj0k/o9VEmFNfx6NzbPxukN9OavgDxlpEOCxIVt6uI+KJ7Mfm6LLR/SI/kvtjJoCLWvUnOMjiXhfZsldPognnLytwFmUbZmoMZWYfZZSp//yqoQnU2DdOtcVG5OA2pFrBCT6yrU7PjlC4tPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE4ZddjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0202C4CEE3;
	Thu,  3 Jul 2025 04:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751516805;
	bh=X8sNzeR99XgAkSmmcSMhUw85PO/D7f6THghA0Cdf+Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aE4ZddjAxSRnkjNpuigFU5o+JC/DECPU8+cWQomG7q31GRZluW99r3TbUOzxpE8sQ
	 Z6CdRUaA5ySs+m07PQ5pB7wydY5W3Md4FzbHCb4UplrVzsEdZKkFanP76mfi+h0zkv
	 Po0eu6Zi3Zo8A9LviYB2/vY05vegdyOQc9uM9wanz2rdCMu12A+vybgTPCtSxHm2dz
	 Dojgkwit+Q/tsg6BeXpJ/ogniq49udPIP61LfyWziLKJTX5S4tvIQLFINACyoyEw4C
	 h436mHEextX8w8bWaCxKOWXOubAB3foi+mJw1glxosZxPKutIupo/5FdIN7bb4SmI/
	 8KDPdSyxYjV8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: tracing: Use mutex_unlock for testing glob filter
Date: Thu,  3 Jul 2025 13:26:43 +0900
Message-ID:  <175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
References:  <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
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

Since commit c5b6ababd21a ("locking/mutex: implement
mutex_trylock_nested") makes mutex_trylock() as an inlined
function if CONFIG_DEBUG_LOCK_ALLOC=y, we can not use
mutex_trylock() for testing the glob filter of ftrace.

Use mutex_unlock instead.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/func-filter-glob.tc       |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 4b994b6df5ac..ed81eaf2afd6 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -29,7 +29,7 @@ ftrace_filter_check 'schedule*' '^schedule.*$'
 ftrace_filter_check '*pin*lock' '.*pin.*lock$'
 
 # filter by start*mid*
-ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+ftrace_filter_check 'mutex*unl*' '^mutex.*unl.*'
 
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.


