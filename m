Return-Path: <linux-kselftest+bounces-3891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C707844A75
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89FE282485
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC153B197;
	Wed, 31 Jan 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFYsw9PR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FC3B193;
	Wed, 31 Jan 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737843; cv=none; b=ukh8eMprLF4or1sfJ3HwQRDIVbnqw5Nw2JQL9UJm0hkHD654Oec29FTqEaJy74lHCdxHu6WrHHoEnsTI0fdwFu4nUZAY7g3XYuOjatcRwpJPQwIVPv9fuuhI3PExQkbeLwgR7RZaWnQH3ZA8jLe/lve81ow36mShlgQPkEFRA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737843; c=relaxed/simple;
	bh=h0+/78PJrDBl/T7h3RlEEe1UbiApGugahjnTY8broM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr3USZkCx0u6afCxnh5ARsTm2NeZmYPJeNu1o29nbSAd7NIm02P1QSEbygUWv+oBOSEDnM9eO0iTFffDdPsWRB0nykbJxI5O7Q3qI86RZlG8coBMu6FzvJmPnWhFeUsXbi3vF99IvoaEqN+cThugRuteHqH0/fV4pTCeYHEWVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFYsw9PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D73C433F1;
	Wed, 31 Jan 2024 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737842;
	bh=h0+/78PJrDBl/T7h3RlEEe1UbiApGugahjnTY8broM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DFYsw9PR3PokgtOPpA06Y3GmoM0ZxJXN7h/YkzgCJZlQhBkUjEe6v/52rtMQpIf59
	 6y5re4ay1LsdWNo0gc9ulgHPIFy0uDntlKYw51A2y7XBqp65vTJznf4HldpCg9oZUS
	 jaS24osDUCEJG05yTnqrpRlWZ9+E8eyYmNQKaHWLtQCNAIRezgK0zS2c+d+JaRGaCs
	 sQvmp5Dbcvm/j8esB4uOJ0nVio6YyY9Qbgr5XZMjABYYOvarDVADW0p504KjkUZfzZ
	 VdMU7oeWgKTMu8XwjUsEmWqGdslYUUFggQbMvuH4N6KDRK8rnT+mxDlo4kZ9QCUveU
	 U7gcOfUAj51Wg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:50 +0100
Subject: [PATCH net 5/9] selftests: mptcp: increase timeout to 30 min
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-5-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h0+/78PJrDBl/T7h3RlEEe1UbiApGugahjnTY8broM8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCgo31rWVxKduKuRkQ1DSI34n9XFxHBCviYU
 E2fJ3i1BCSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c44CD/4wn12MKWL+J8B5sLIxJZqN7XguyG80hSmJvtu648JX29JCO3/x4mMDF3UXhAFv4Ziys1L
 t7Yrm9SVS5M4EncXrjcZlMSd3nkgmlfJIF6uEp5WIokQqhU6vBXFIIWn9QnG7G20FP8dNYseFmw
 +4G0vejI/iEtqpQrdFeYewt7M/i8NEc87BczH/qJTj/qihIx4PFoe1GsHejJplf8Z1YNZUhIyY+
 oxrP+y1nlr82F6ejDBeG13Gq9rePk/e8oGZedrAmBHjHKgEVEIPR3IeGDyp15CIRX1YBGFw2XT2
 EUJGloVOrLupwyND2J06bi58diNpXr2ML4TwxZV9wM2q2iifpe7ysvy0GQTSt2KCNxUCEGbqNxk
 yQoWIFHpHovrNxVU6pAtWZAAHa5KhX2i42rK/dmDblZY1bKMaCSx7mm0ma/1huG8wVu2DgLflEP
 CC0GxAo6H4MtD4faLKHa0CE7iEj4kxmDFsTTEei9yK7EE+eG6APr8n4pL1s+Wp6Tk0609LNPUA8
 fCz+rATWuLbpjSDMSKUto8/YodJyuGf6M4Hw+5S4tVSTM5+vMLfeZIPyydvVoiT1pNT9FIVi9zT
 SpaKyzQB09KNILYQg0lyRtxzW30rV1vSwZKUwml0ih6UUpKnZ7Rxuk1a6aSwV5NeXhg9pXSDRn7
 yJkKIdvoZRa3Lxg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On very slow environments -- e.g. when QEmu is used without KVM --,
mptcp_join.sh selftest can take a bit more than 20 minutes. Bump the
default timeout by 50% as it seems normal to take that long on some
environments.

When a debug kernel config is used, this selftest will take even longer,
but that's certainly not a common test env to consider for the timeout.

The Fixes tag that has been picked here is there simply to help having
this patch backported to older stable versions. It is difficult to point
to the exact commit that made some env reaching the timeout from time to
time.

Fixes: d17b968b9876 ("selftests: mptcp: increase timeout to 20 minutes")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/selftests/net/mptcp/settings
index 79b65bdf05db..abc5648b59ab 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=1200
+timeout=1800

-- 
2.43.0


