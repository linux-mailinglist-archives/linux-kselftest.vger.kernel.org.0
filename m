Return-Path: <linux-kselftest+bounces-22501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267A9D8478
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 12:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A72164DB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7B1AAE0B;
	Mon, 25 Nov 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NJUVo3MQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654919E961
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534114; cv=none; b=iJ6TGad8V+34+6fbnoz0feYWzVlMsAxo1LNakBY/spZW3nVv8AMEKgFfsuMBl0mubUnhiPGabRmw7F++bg8pwMIcEz/+yo04RksRWMAbyT5S0o+exvzlV5EqF7bLp9AnNjtHswctQN+qmn7K6ZHokRjiofcuGR54KCW35fOc6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534114; c=relaxed/simple;
	bh=8+WrTeIjHJDsvO6eNUfMcipH42y2RHwqgZd720PD++E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DEBiN4Sws5ZDKBsAFRJbt1wpaHMBJDSKOlCT/Jc4iJj4sXwxzCBlkCaHt7p01OjgK7o62TlO5/V/zg5nRAZeG9oV8Q1iT+qwZTO8Qu1G6AGAvKoRfkg3jlpC4LjHWCQR1caIM36VHaDxRkKMTJbWINtPaXBfhdnjKwyeLBBHr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NJUVo3MQ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732534109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4iiNlDUMS/v/1sWsQak88i5dwU1nxdsRUlCF1jU/hk=;
	b=NJUVo3MQ7dgQTljsVnJm87JCU5R42RgqSjNOH2rCQGRqUHTyI6MAh9a4l0+XT1DaB4V5FL
	1I/UlkxLKWv/4eB4xdGWaAtwp/oxkGloutT53YMaLwyrU4wlmDRsKney/gp7w+msT9Of2T
	hI8AbPHzJDDBr9ijXSyeP54lpGChz30=
From: George Guo <dongtai.guo@linux.dev>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH livepatch/master v1 2/2] selftests/livepatch: Replace hardcoded module name with variable in test-callbacks.sh
Date: Mon, 25 Nov 2024 19:28:12 +0800
Message-Id: <20241125112812.281018-2-dongtai.guo@linux.dev>
In-Reply-To: <20241125112812.281018-1-dongtai.guo@linux.dev>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Replaced the hardcoded module name test_klp_callbacks_demo in the
pre_patch_callback log message with the variable $MOD_LIVEPATCH.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/livepatch/test-callbacks.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 32b150e25..150cb68fe 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -259,7 +259,7 @@ $MOD_TARGET: ${MOD_TARGET}_init
 % insmod test_modules/$MOD_LIVEPATCH.ko pre_patch_ret=-19
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
-test_klp_callbacks_demo: pre_patch_callback: vmlinux
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
 livepatch: pre-patch callback failed for object 'vmlinux'
 livepatch: failed to enable patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
-- 
2.43.0


