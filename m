Return-Path: <linux-kselftest+bounces-4887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E889858A4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BD128965C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9618B149005;
	Fri, 16 Feb 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="OBkwBK7b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A884148FE9;
	Fri, 16 Feb 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127414; cv=none; b=Rqp6ChPHPhltJpjksdCznJNS77TCQgspWfzFCc/Zm9tcKwdtodkuGOb4AJrHaeXMInzaz/jXHlIvhUXvEXOcZ8r8uiJCErm/QokawlohU+8BEWEWXGXQqVBuoQAGLZ5BPCgbx8XIf1hilBTozWqMi4qez4nZlHOwhAlFXTYutZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127414; c=relaxed/simple;
	bh=SUlpKvijFULBhu+onKj0KJkGrequq3NY9IlyDbpNHsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtORZfEeiLvzOWWl6kx+fUQ8pmWUAc+uDFOg7Bj4sfL/OeeR7p885uyXtTVDIAwmbv8mlDax+kyf65ww6gTzfMk3A9PevqTgsCemy9tzIpofNawIaHWBlC/ReA93j1eBtBW5NRrMNJuBtm2wLgRXpmEOAhGjaQGax22qyc50jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=OBkwBK7b; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 86162200C99A;
	Sat, 17 Feb 2024 00:44:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 86162200C99A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708127066;
	bh=KBT5QiCYF+jW6KQjYqqpLSpV8B1JmQ2uuG5tyIxcSu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBkwBK7bv651mHZOpD6QhZyzeYarcjkiZici4n8srVvFYAlZfKsBwVFHYnAPWOi8m
	 a7YleW/tQUHWUSaNLLBqNq0JIO0CjGV802Za7FmmlyDmOvIc0waX08uefRzPAirUNs
	 /ctZQi7LcszxAHJaaBfWHyX2OG0Lx4xjLtYvoqeSPYK6fh7celuenNDoc/GXyOr/Oi
	 ZmDSKM1ozAuxeTMHKaavo36EICuh4nlR0tI9q0EcZ+7Q3H5qrM8VQD8sHLiTZCXrWK
	 TyKGQA5EVMjm5PtXFce6IreT3NxvygjvuBrWA3vHk9GC5uqBeoCdI1rfNsi/HiEZ0a
	 O2aiS7FdFH2xg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 1/2] ioam6: fix write to cloned skb in ipv6_hop_ioam()
Date: Sat, 17 Feb 2024 00:43:55 +0100
Message-Id: <20240216234356.32243-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216234356.32243-1-justin.iurman@uliege.be>
References: <20240216234356.32243-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioam6_fill_trace_data() writes inside the skb payload without ensuring
it's writeable (e.g., not cloned). This function is called both from the
input and output path. The output path (ioam6_iptunnel) already does the
check. This commit provides a fix for the input path, inside
ipv6_hop_ioam().

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace ")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/exthdrs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 4952ae792450..f68e5faab3aa 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -943,6 +943,14 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 		if (!skb_valid_dst(skb))
 			ip6_route_input(skb);
 
+		if (skb_cloned(skb)) {
+			if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+				goto drop;
+
+			hdr = (struct ioam6_hdr *)(skb_network_header(skb) + optoff);
+			trace = (struct ioam6_trace_hdr *)((u8 *)hdr + sizeof(*hdr));
+		}
+
 		ioam6_fill_trace_data(skb, ns, trace, true);
 		break;
 	default:
-- 
2.34.1


