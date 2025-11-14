Return-Path: <linux-kselftest+bounces-45666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7AC5ED2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 087564F2E2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B003346FB5;
	Fri, 14 Nov 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLo+abK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57A346FB0;
	Fri, 14 Nov 2025 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143951; cv=none; b=EpVMnr7KHb426KiQN80xt7GYq+y6M6JgwpAZ5EeLNCVXfPn8rl7IOAVWNZGByYXbtqvIr7mONzbGKFo3RgWP0HdPrN3SwdFmZYgnqUz7m22gKGYaQuHQ6j1vIyw1BV46BYP0eujMM0hHcpEsTAg1fVpUbE6eio8svxTiNyehHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143951; c=relaxed/simple;
	bh=QIeCsov8dwW62lkBk2JAwnnC41VOoAFnNv9LbRKTX48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMWLJ8ugETuAsFAF4XdphkmeQfS8AfMeOG/XQ4xCKtuXrIViU1dhqSpmSfdnwLlxV+KZoTXWB0iQlSW0SoKacQ8aSC1p3vQN1x5xKOfPdhHoz8StslxW9OcTAazVfZaxklbqNVdes2N3RNujLcS19SViVJD5By3b/2eaFaqoXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLo+abK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AE8C113D0;
	Fri, 14 Nov 2025 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143951;
	bh=QIeCsov8dwW62lkBk2JAwnnC41VOoAFnNv9LbRKTX48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MLo+abK7zGyHmt55J48u9HpiGXojztohRugY45NagXgTTF34XNWrFVztoaJmOhg2L
	 BRkeLijwJozZa2WWNPVHDpGY5p/WVsNL/tvxxb6w1n+cnYhLTGKNDL1U7MfHvmklxb
	 b07MYNy2mp6Wm+eTuzkrBaAy//TsRP61eFD6+pkwMetbS1PdkWyhFZyrDsXU+4VBdW
	 0dttS+YzNZE1EnACqAlkDpLVnBBxS6xlV5XazDM/Zm48Lc2p2+u3K1D/YcNC8F0+of
	 CJdtTZLiBB3xfRr3z0JgccDFMBuoRkiwbkSjvXWv/It5JcH2QWPJ03/JpmoW69GODC
	 UY5CEvhotbiqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:07 +0100
Subject: [PATCH net-next 3/8] selftests: mptcp: lib: stats: remove nstat
 rate columns
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-3-863cb04e1b7b@kernel.org>
References: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QIeCsov8dwW62lkBk2JAwnnC41VOoAFnNv9LbRKTX48=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC/4+s0/muvJF+BuLU9mfA8sFnq7mtWX5u+KNmX2vE
 0+f37xDHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOxF2f4wxP1pF/wxzwNHV3O
 9Fz3BJerziabF58wucJ13ufAlpSvygz/U47yJS8Qn3k3lPnih8w3DOeWe+zzvztt6/FSrS3OT9j
 y+AE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With the MPTCP selftests, the nstat daemon is not used. It means that
the last column (the rate) is always 0.0, and that's not something
interesting to display.

Then, this last column can be filtered out.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 4a26d4150603..c5571100f797 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -390,9 +390,9 @@ mptcp_lib_nstat_init() {
 mptcp_lib_nstat_get() {
 	local ns="${1}"
 
-	# filter out non-*TCP stats
+	# filter out non-*TCP stats, and the rate (last column)
 	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat |
-		grep Tcp > "/tmp/${ns}.out"
+		grep -o ".*Tcp\S\+\s\+[0-9]\+" > "/tmp/${ns}.out"
 }
 
 # $1: ns, $2: MIB counter

-- 
2.51.0


