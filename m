Return-Path: <linux-kselftest+bounces-5375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F657861D69
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348D21F2502D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7414939A;
	Fri, 23 Feb 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkQyW0h7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA90146E94;
	Fri, 23 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719556; cv=none; b=QTreNTtyuw5IuZ7jQ+gr3cKfG26tMNpwZ681y1eSQcSMW4kX+aH04sZ1zgP1y1yciLLFAR72zZh+Kv2gw2ao9763Vi4jywIrbLddVY/R2DvbAIAiM4gEWgWxAWGIQinXTMoOpZhLp/HzTTCfgbRopjDwyI1XophvCJNEFSiFph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719556; c=relaxed/simple;
	bh=Tita/JUXCCZaQUK9VD3z/BlM+pOB6MLFoH+QoKGPM7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5uvaHa1O0M4BhzE0gaLdAoqQ6KzZnVPTjZl+2vNKOb4ycjitlMzSlWOAUVITZeK5Wkwwh28sWK1VWS/cFTA4a3BhmUd9dlc0fBnEKDaxPleGptzmLamDR+KklcI7+y8IOr51+yuFHGcWJZM7kyzuY1HaWVa5BXKWp3sd4RMBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkQyW0h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB41C43390;
	Fri, 23 Feb 2024 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719555;
	bh=Tita/JUXCCZaQUK9VD3z/BlM+pOB6MLFoH+QoKGPM7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JkQyW0h7mHwhLAa68bzlb5r8Q4FPbWtrQmrtPU8XU7QI4aUwtLZEIQPzF/1wHYLsk
	 JhngJChXFjsTC80pcJAZI7orX+3kbRB8hQZpqcsik0yiEVsCs4EoL6FcQBJ/SfW6q2
	 3UAosM1k0sSK8mpv/ue3uZwpECIsPSO19qZSCR4nUMwmJb16UZPxdsC0FUSj4YjdAI
	 jue8389cIF3hmfGw1bsRcjay2NaTulYigHIZwojwh9KQAzQ93mKr2Ek2xypVpIIE6o
	 hP4s4o4qIf/8kko4nPO7fplwPkJ3FiLoovJnZLyk0e1JnfBZNiTrirgeyGDawVgUz7
	 qVCwCOdkiJLYw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:57 +0100
Subject: [PATCH net-next 5/8] selftests: mptcp: netlink: drop duplicate var
 ret
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-5-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2TF2DefMK5rCsE9EkAWVPU+W7O7ZdLPJZXqcYpu15OY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qljgRR881Jpgh4LE5QvrJMcRz3Dy6ITZZh
 CXk07trp1WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c8S4D/4u+3kcCDRpA1MAJ3d+XaWUnFCkr/9Xoj4tJE3A5LM2vh9S9rdjTElxhRXAyC4OMaNHaMy
 c21IjmDJu5OJqIVLsl0ThDEINOOb5o9FA/rndh+DsQhJ6Qb7wxGo3nFk5AqkYHkjEAgVG3/28kb
 2DI3Vz5m+BKX+Edz0yu91tAa3gWW9SVX3yRCQAZ+yfIKJq89elCB1UIdAzj5A3f0zxo57//4V5c
 tRyTlEDxQt8xMkwXvjZCrS3N/2AYz7IFwJJUskzTxrFCHaJUALs9UlExnNFZfpE7+NlTfYtcXHq
 KePO84bfteqDmYU7JJFNJZjKhZEGrdjlfzgaG/MTu9NxSPNuE5PHf/5JMgc4cJ33zjm/FXazAaT
 TA3KP8tbyVxYbmVkVqtq8097zgzZnmBnWjpfn/6WbblzKYU5MY67a++ATRq/cdAEGLuHxbavLFj
 gGJLm7arlSPdYtWoElTEj9wbBn9u/uPdvZaK8ZeTqB4xoj+9XiYgeYX4npxRD9mvulvbZgngz2s
 6YyLPCKOACER9QCAfpoPU4p7TgBlZDepu01NPnwBJD5COwZzYDqaQS6VqZmySy6X3w3KjTBQ1xS
 uUyp8zIXokQKM/5T5MAG5SnJWbC09gaWTQQMYjBMZTtDvgpBFYdEZNIXe0bYw8guZiiFTceD9xR
 SQG135ia4xMRGyQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one that has been defined from the beginning, with
commit eedbc685321b ("selftests: add PM netlink functional tests")

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 71899a3ffa7a..ebfefae71e13 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -28,7 +28,6 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 err=$(mktemp)
-ret=0
 
 cleanup()
 {

-- 
2.43.0


