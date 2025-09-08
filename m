Return-Path: <linux-kselftest+bounces-40995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25769B49BE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8893AC0E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84D2DF71F;
	Mon,  8 Sep 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3jkUlFs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6621FF39;
	Mon,  8 Sep 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366876; cv=none; b=Agfw5D4Xg6X5ZrdFFTLxf7jHxHsV53P8ZJG4oFJ4O0Hno4/B7jH35x1S+C9wMYEZ6DVtkeYl0D1m9j5OAwuLmV8TRFy8Z9kKH8vudZ92HTaw2zBBN8Xqv3nfn9xZEW+Y4o8p2+hgQk92Ca0Q8Pa/rBGGRS1HOMf1wFNNq8AeU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366876; c=relaxed/simple;
	bh=2pnkprJwXgpBNzbLgqI2s8p4b2iZai3DkVfEhF0IFOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmnoRNHkF2///z9n4EGzuNcwoBjs/+0TZeNuhgcaDIgQ3U0eIlJyxA+Ru1eh9Ka7aSEBrIxnDd+uHZW1nuNiAe+jwfoFnRx2DI70g23RPTP/i3/qdj8Em+PKvlwZUC/hsnHbJNR0+bFZT4Brqw+WA5oO8WTSSlL+R5XSX7NvZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3jkUlFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B48C4CEF9;
	Mon,  8 Sep 2025 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366875;
	bh=2pnkprJwXgpBNzbLgqI2s8p4b2iZai3DkVfEhF0IFOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C3jkUlFsAXhgKn4zS221intRVHQASC087PDVppT4sbCPu/9u3ZDmu1RvrOYoY0HMr
	 1oU1l/91o9Khjxf0sFcqvouS1qYv4IL1SYt8JD3Nve0eCEDrRNUEawf5tZuD8B4UZS
	 wqsJgRdxO5c3OV0l3yHUpFFoAt5yA9deuRIkWdF53DNrcilhb1UVa2MQOF5+HTjVtn
	 OJ60fj4en41jp0qASWvyd28cm48Qxb9l2CpLZRY4v/iSeQY/OVEqSRHMheR3mhYfn6
	 l6ZeI3b7grUHLXXgZw4tVDmCgpfzCPQy05oP+3PzyRe/uQcNY8eAc+IDNBrV+ktQRV
	 l7+EuYkONKJ3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 08 Sep 2025 23:27:27 +0200
Subject: [PATCH net 1/3] netlink: specs: mptcp: fix if-idx attribute type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2pnkprJwXgpBNzbLgqI2s8p4b2iZai3DkVfEhF0IFOE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2ewWWXn1/beXCCTqdUh/uiDl/eelwfGHZ690xS/bZz
 uxOu5sr3FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRox0Mf6V1HuzeZd3uo38m
 72959pSYH8Z/26xSub7e2Zv6Q6Gu7CxQRdZHlullLT+fateIRZybc/kiZ3dEheqmAwwfBc7Ul2/
 lAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is used as a signed number in the code in pm_netlink.c:

  nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))

The specs should then reflect that. Note that other 'if-idx' attributes
from the same .yaml file use a signed number as well.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 02f1ddcfbf1cfd81a398dd03c52bb9f281c1aa08..d15335684ec3d6256505f2b3887ce5818eb57462 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -256,7 +256,7 @@ attribute-sets:
         type: u32
       -
         name: if-idx
-        type: u32
+        type: s32
       -
         name: reset-reason
         type: u32

-- 
2.51.0


