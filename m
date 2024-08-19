Return-Path: <linux-kselftest+bounces-15714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555049574E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EA71F22043
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A0200121;
	Mon, 19 Aug 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxOZdpbP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF620010F;
	Mon, 19 Aug 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096767; cv=none; b=COjzbfeHLQ6l0sv8EZAS+whjb+0uw6QoNMT445KpDssG2416G9wGCaAyThSTdsvJRGTTEioO+DFaCHinKVISdBooS2vpDUtCQDQMT2NOimeIJUsVEaJJf47yJhbLAy2AXGWH/vxHtOzTwjZbzbRKtoi0CU25KKoa2DopwD1YHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096767; c=relaxed/simple;
	bh=Jx+YWM0xAm1SJYDNQ2FKQR/nOU1ci/rJbdfBM/eYfVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NEc6NBnGB8WM6DEqSEelpFrI5FPTP29oydSmBV8bTbYIicYPtZ/K2E4cpM6hGj63HBhnTx6Iyo9pB5t/Oo+oaRjQ8OyPFKbvLkjOgggPyztDMiLfz3dQyURc+31RuKnOt1eJEZj0vDmCTiZedH9nj3iYu0CFJYhn2dpREsmSSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxOZdpbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8161CC32782;
	Mon, 19 Aug 2024 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096767;
	bh=Jx+YWM0xAm1SJYDNQ2FKQR/nOU1ci/rJbdfBM/eYfVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sxOZdpbPTfOho14Lob8dME9KnFExsvsRzuI3FonckSwAoW/LwRl8T86cXWwSREbFu
	 mNcGuYEx39u7BY/fprpbLvX8S+RcEDNCB0Nr8zYdpluScTQV7Kkbf9VESzyWmXITsy
	 kblwizI63AKguRvsKpZTHtdP/PIiC1msrcm8x5i6FRW+udU0c31tWXaSfiwbA+LBvu
	 OSiAyZxP67nWOB3o4rESJB2zHSVD4GMusWdEVEtv39GOk/iIH61nuvLurOpwXNfuKJ
	 hNOdCGgcnutdjJyb5BP97z9dQD3OCVYvcV+P5YfsBbB39x9ZFmX/Aff8r6gCUQmzeJ
	 9skxpzWf+yWlg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:31 +0200
Subject: [PATCH net 13/14] selftests: mptcp: join: validate fullmesh endp
 on 1st sf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-13-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Jx+YWM0xAm1SJYDNQ2FKQR/nOU1ci/rJbdfBM/eYfVY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DTJVOVB9sJ8kjZ0OocKVD7U8C9JFMxKOk3o
 wg+S3L7BZaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 cympEAC5jUlrqyf5A8ym+tGS+wfj7itFGEUzkqyrl4306G0MTE1YzDRS1+QrrvXnnwLFcLgZrnI
 pr3NXoiyy4N13R+GqC5Bzg5y/IAXiEvWl1VZlQ0I9/uKBY7hshS0BtLmHb8jjQmxQwGyj02qd+s
 Xd3a76lJOXSd/KNXQ1XBKvDN07rLgRp+RgkbP6PERymW60fJsi/cr34G8MF/VgvLDz/QjErMqqx
 avRc7LTY/TatnkelF9yQDUn0wy3197DLQkFe/XafscbONHYW4A+0dcF5IiXo7i19oNunxyCbsx3
 M+Rih/jtI83KEI385MAT16cq30TzlI3RW0VU3ZBEvSy2esk3xYA2uwolOd/R5fffZeI0lNQQZgB
 L0boCnpEZr5fj2qkNvfzABPaYo15OMM5i7IAw8a42PUvHRQJNjX0ncWQjZfWP6A8C1NyZGUz/Y5
 O6Oc9y3OQ1Vd2LPY7xkxqx6duQGqY4ziXt0q8A9hL7HO7DWv9sswVirY5Rzv+LTJ1HCUWxPuoQn
 4w9FiVK0uBu51L0qW3rcVn1vD29Qm8UkgoSabSPUh1gJjQVC8Mu6iillu3TRMkE6UY5c6J2ApEl
 fo0mRBwk0ehbiGhawNpxhm/5a+ptJkv+Q5vu3zRYFVTiLabmvKY+0w2lmdsTeu5BjzmJQeJjTzc
 vaw0VRvvcQf/aKQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This case was not covered, and the wrong ID was set before the previous
commit.

The rest is not modified, it is just that it will increase the code
coverage.

The right address ID can be verified by looking at the packet traces. We
could automate that using Netfilter with some cBPF code for example, but
that's always a bit cryptic. Packetdrill seems better fitted for that.

Fixes: 4f49d63352da ("selftests: mptcp: add fullmesh testcases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f609c02c6123..89e553e0e0c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3059,6 +3059,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3

-- 
2.45.2


