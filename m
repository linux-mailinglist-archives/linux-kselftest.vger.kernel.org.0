Return-Path: <linux-kselftest+bounces-39113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB16B28508
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801391CE74C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2B630DED2;
	Fri, 15 Aug 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qblfX77W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20E30F535;
	Fri, 15 Aug 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278937; cv=none; b=TXT9GSt1X6g8g9qJ55+yht1nn/BXcdoNvJNmUfq7CTZQM1B2lz6YD0OWw+365AMVWz94tVNC7+e5ZixbZzsejEcMhh0rQQfKPwGEOSIX5ZZnBYH74zPYcLXqDpbqNm3rK/8TxJsQgLw4jTV9SVlN8/oAEOs99QRFJ24MTAkl7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278937; c=relaxed/simple;
	bh=wVhVNJGxv9DpeQikf06WEKzYzRCoz7rAHEfrPSheFI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/o4mR60meAaa9ctEC/RltaTGzLTGcMQyEtsuGmwGiqMzyOnIx+Puqp00wnivDx0aRA/l1Z61l/buf9jZkcAu4Gwc1KjR0jy9z2cjtIal1zT29fMH2y0xQdYeD0vZAQfsbdJz08CyiVh1+LKuSIYH9UndY6TX1JM/BoxDxueeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qblfX77W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3284EC4CEF1;
	Fri, 15 Aug 2025 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278937;
	bh=wVhVNJGxv9DpeQikf06WEKzYzRCoz7rAHEfrPSheFI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qblfX77WfMr7lbeZ0LnyyzXE9L5zCPUQG1OdxgwaHw9MullTYwslMf++eUw59NeUb
	 3k3j6gTeZMDfQ6bRbwkT3JxQqm5Bl5QDBBl3LtdfnggrzAsNA6mg9QGkUtH/VNbhYi
	 TgomWnEiZgJzBujK2a9CyUgCPiQE9iZkn0teUPIHLVhQCAS6o4o/LFhxVgiLgfy2ek
	 jV8qwI7uLOREz0FfnV5CNaFN7Kn8GZb8xAlssjbgFk2aAIHMGrAYmc9gGvL5ehUr8g
	 /DnJ1wxt5335lU1Ssxt+54H814+LNU6FuYVsUa2reCSq//ytcBKaS+7lPyh4D5jb8f
	 iO3gRx8HZY0Yw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:21 +0200
Subject: [PATCH net 3/8] selftests: mptcp: pm: check flush doesn't reset
 limits
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-3-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wVhVNJGxv9DpeQikf06WEKzYzRCoz7rAHEfrPSheFI0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm5zmrq2022CFr2n1zTWrYzLVPvZev/ej88u+xeq7w6
 qClPJZxHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNJfMjIcC3ttm6GXdzaX0dt
 lfbl1acvL84UnbD5yvIcq0WrJU05pBn+F5p8DNzJ3tTNvjy58xfXzBK1bYtFuw9cZmv5bMcw+aA
 3IwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This modification is linked to the parent commit where the received
ADD_ADDR limit was accidentally reset when the endpoints were flushed.

To validate that, the test is now flushing endpoints after having set
new limits, and before checking them.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2e6648a2b2c0c6ea0e9f030c942077a0f483092f..ac7ec6f9402376a34602ef1ca6c4822e8dde0ded 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -198,6 +198,7 @@ set_limits 1 9 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits 8 8
+flush_endpoint  ## to make sure it doesn't affect the limits
 check "get_limits" "$(format_limits 8 8)" "set limits"
 
 flush_endpoint

-- 
2.50.0


