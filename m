Return-Path: <linux-kselftest+bounces-5351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705786176D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73481C256E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71E1272C1;
	Fri, 23 Feb 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+BmOVmG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22984FBB;
	Fri, 23 Feb 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704895; cv=none; b=SeDDY1ahLKFQ0ymCEBLVlSS6VTWGeMovLPP1spiG3CqjzAsHpL1Xf+HSIx+vJdM0FG93adYDrA1Zt3tX5+EhAwWi1V1Kyk8kVA1hdXEBR7GgfE0ZJfuMbUZvFmkXLMsldI2ZMjHOPcFf1iaYfrDjHDR1fNH6i6wcMboeiIV24j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704895; c=relaxed/simple;
	bh=oMPcTg/HR4My2+n2kEfVTapwJZ1FPd+w13TvTlMGAjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZVyIt0zf5OfbzR5Qc8aBZF4m4nXSMv9MZWDrBBg3a1bDKNZ/Xh+BhiHANUpD6kusNtrfjRb3l1KyXIMDCawfAu64k1zS5OdAt89m6Rm4Vi/5CG3tvlj2ivCoi+0EQRgUz+umIyPLoLMQRsbgCN5+b8jIZ972KdmgFEj7xHsp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+BmOVmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9455C433A6;
	Fri, 23 Feb 2024 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704894;
	bh=oMPcTg/HR4My2+n2kEfVTapwJZ1FPd+w13TvTlMGAjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k+BmOVmGu1WVPgWV4tYATEy6Do8BYxMpQTMFseaweyFcBFympiJdfwoRAewYGG3cP
	 SY6EPq7p2y/MOVlxvpFG9jDXs3D0cfFUBVK/HDCHQkC1wVBv7nIPYVlERiEPrVQQfI
	 K49wNZfJ1CKShcWbTdtD/84xXoLo3WHAqrGSrBqFOy8AMhPS4xisKyzXwnWGcyKI9A
	 3viuMXfqbT3fAnf/t4wOA4x/z/UWd5vxDvZcx+afLvzq0YNiFe19fowsc89Zxcmyow
	 b+r6XGQoScDX5GgaorUKEGoOldDxch3BvMfp7rJJ33M993JWCroLg6HeXgrlJmN5HY
	 7syt9QjVvaG+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:14 +0100
Subject: [PATCH net 04/10] mptcp: push at DSS boundaries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-4-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LIWA9w8Hu+BN9Y93ANJ69iVx7kuDZyfmJaoFzfkKwwg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqohB1/YeTq+OuqgfAFqE+ePW4jlRE5MgU5
 dBhI0B65D+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c8+gD/0TZOAF6HLWBlDgOkRrcVEyvyirDvqagkCH4NhEHL3pxfQ3Yss/bShQ8PAtfjS4x58pd8G
 An5gZ/9oMnL3b76r/pphg4y1m+h7yJct0Akv9tNRXzlvHmXhkZdqpcrUrjInpznaDKcpoyrtRtc
 fG4yHBe9Pux/Q4h9BvvnoVhxGJCDExtd/tgoA0NbxDxFx2ACwifYshqjVVVkLCyNrc2d3p+YjUZ
 NVcs7O4i8S2OMfddssO1IsOSQUJBIj4KbVOqgFWBofDZtsfdxkMM51LPRDltbj5DK3FCdCXOLG9
 oyeM0BEz576RQXnZ6v2cNFhmYRjYxnqZgkiXu+wEIMoX42OJDkbA8TFvDhBQONutMgLAJyXCfq0
 vvYc7LVRI/oU2Gy2eQi388Wy6h4oDif+NOMhbqX+Qb2PkfIMH0hM3rq9CV6kUjpsGt8/zG4EDBf
 JkQ121N9cBZRJBWGrhB6rO0JRAdei25kj0uHYK/HthmaBZkEvBpAP3GJ+VNtRrLFTOj6Vfn/jLU
 U2vyzeGvCDMVnRTuCYF0bkjAkS61cTtGq68biANBrHODMZh1Gcnz/eUbgvPKizuWXWERBHHH37K
 NMASOEQ82uSbYJTRVgjhV5D3atJIvnVpuRBlanPJ+Ptx/DiaIp6ox+wiIjGDMOcp+BH0J0aQh0S
 c2hEkViXtfrVC8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

when inserting not contiguous data in the subflow write queue,
the protocol creates a new skb and prevent the TCP stack from
merging it later with already queued skbs by setting the EOR marker.

Still no push flag is explicitly set at the end of previous GSO
packet, making the aggregation on the receiver side sub-optimal -
and packetdrill self-tests less predictable.

Explicitly mark the end of not contiguous DSS with the push flag.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 948606a537da..442fa7d9b57a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1260,6 +1260,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
+			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
 

-- 
2.43.0


