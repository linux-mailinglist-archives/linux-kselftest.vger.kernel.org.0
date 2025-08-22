Return-Path: <linux-kselftest+bounces-39677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB7B318E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E24C1891E19
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855E2E6114;
	Fri, 22 Aug 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b="mnU+/eBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9jbUHlD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BD1BF58;
	Fri, 22 Aug 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868012; cv=none; b=dK4GV1BwqSbJo/gs42xbJjV0Vev2b43N7UddE3VV4W9yqlt90jumHAaN8DfwAyvH+JMM09gJlRKQvaToSChfSszNW1qP/fwR3RI0X5fOPDuKkD/yrXM2ez1zTN5YPgCm392BVhzDGZkV4H8NscX5yWBiMSiq2vJTUqF4b2HDMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868012; c=relaxed/simple;
	bh=yw1DYP+lVPQxKzKGU+Nee0RWVoi/TtIbBGS/FR3hiYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VaZ8pKV4V/DkRnoQWC9SCUGYNSyPthGduX18T4gwnHXW/5QAq4/O5Vj8j8IvEzNv1fEugvL3StdCwu2Csm9N4zSlLVlY7BnffJkSTIpdlgddTG0Dc/ilRs6X9muqKr7PcWVzM13BSRQSFk1h1uxgRbHIbLolbTKGA7eK5IWnFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com; spf=pass smtp.mailfrom=debanilchowdhury.com; dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b=mnU+/eBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9jbUHlD; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debanilchowdhury.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id D78431380084;
	Fri, 22 Aug 2025 09:06:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 22 Aug 2025 09:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	debanilchowdhury.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1755868008; x=1755871608; bh=9bh7i8qHdyhILSV5h0O2MUCYUDYongXH
	YOkqd9oQIdA=; b=mnU+/eBEU5Pg5BwRRNFVsFhcIKVN6ToI5nSOAD0LZxv476XP
	Bm4OCb3ypzdOWUnsTd1oUVeMlX87hAspPcehfsVMFJ8GyJYPsb8gqLX+Yz51Af3i
	YH71Kys7GcE11KG5Sq+y+1Ts2kgjoZh8ck0KRszA3/lk+QewMcDsLSKX23VuWbwk
	QVMvn/EW4pD1yVG0wxuShqeJ+8WLAIwJ80GUmuq8Rc4X82OqDphlPGuzmx8YKINr
	0eZ8jiWrqB0dGNKGIfPWUDJehu9GLnISTrNaKE+uuiQkikKxzWvrArlzVEwfrtmz
	+xZ+tO4rSVJAQ3Mil4HaL7//4+e385cn8SXYaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755868008; x=1755871608; bh=9bh7i8qHdyhILSV5h0O2MUCYUDYo
	ngXHYOkqd9oQIdA=; b=Q9jbUHlDAxU+2JvK8DtrIub0xT4i4q/hCp+9BsR/H0yh
	Ea1nvI5nVh0e7lsnN7upBQPnspXhqlmECpNA5KQFI4hT2Yjm5tgfo8xlFVk/P1ao
	tRbz4QsDaIXr+Ur1DqIX02PP9yMJZs8QoFY6EMVdCeE3d+7RBOP/Cn1rHs1WVnnl
	55KrNtgp4IO5pB5elkPbi8CIjqn7ViHzcJ0x4tljB4oVLAn7NMbdAgKIseWllFC3
	gs3fH42KDZqBtnLlP6RDWay6cOppWreNc14dmDFER3SV8i7PtcqqDMY8Tfg3rqY0
	Wo347o2plWM330whvoXRRCG7Rsx/uBknh7jXRvp0og==
X-ME-Sender: <xms:aGuoaIWP-BTFtcRWvCxhHKq_AF9-Hyv4-mcGsaBfsygZSmYBdp3lzw>
    <xme:aGuoaKjhmznP_WF90RkQR8nvEGGpNI83QHVycqscuajBHPuLVrT1fQ1f8dyKy-C0x
    JOkAipBVVZ-LwDU8N8>
X-ME-Received: <xmr:aGuoaOtFbUKPOMBrV_EXE7Yirj0k_DcRxkiIS9MVqewQZrkTK5GelvS56IaClwgc8FFJeby7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepffgvsggrnhhilhcuvehhohifughhuhhrhicuoehkvghrnhgvlhgu
    vghvseguvggsrghnihhltghhohifughhuhhrhidrtghomheqnecuggftrfgrthhtvghrnh
    epuddtfefgffffiefgtddugeefvdeuteefhfeltdeuieejvdeludetveettdetheefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvg
    hluggvvhesuggvsggrnhhilhgthhhofiguhhhurhihrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehskhhhrghnsehlihhnuhigfh
    houhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlqdhm
    vghnthgvvghssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugi
    dqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkvghrnhgvlhguvghvseguvggsrghnihhltghhohifughhuhhrhidrtghomh
X-ME-Proxy: <xmx:aGuoaL5Bv_wjVe8KIYU7yd8-cZsKAVwONBJK6jAHwJI7EW9NWU3baA>
    <xmx:aGuoaKMhlbVuQ0oe7jxhBDimflgLWPgzFNNZxzK_vn1cAmjVPr3Phw>
    <xmx:aGuoaJuTcQ8pbcKNyKHkQact2dViqgcJeCOrAv8t_aVkeEQ10OnChw>
    <xmx:aGuoaNY5DaoWtFpCTTu6YJCfk6goCbjb8xqJYfQCG-y3LMLz9PvBCg>
    <xmx:aGuoaP4sPuxtrFfz-6A5R_41ZvMSHLrQvJ-6JDS5E_L2sprATXKlUlvT>
Feedback-ID: i77364836:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 09:06:46 -0400 (EDT)
From: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Subject: [PATCH v2] kselftests: netfilter: fix spelling mistakes in nft_nat.sh
Date: Fri, 22 Aug 2025 18:35:54 +0530
Message-ID: <20250822130642.4510-1-kerneldev@debanilchowdhury.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changed a typo in an error message in nft_nat.sh : "cannnot" → "cannot".

Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
---
Changes in v2:
 - Added commit message

tools/testing/selftests/net/netfilter/nft_nat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_nat.sh b/tools/testing/selftests/net/netfilter/nft_nat.sh
index a954754b9..05a34c135 100755
--- a/tools/testing/selftests/net/netfilter/nft_nat.sh
+++ b/tools/testing/selftests/net/netfilter/nft_nat.sh
@@ -569,7 +569,7 @@ test_redirect6()
 	ip netns exec "$ns0" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
 
 	if ! ip netns exec "$ns2" ping -q -c 1 dead:1::99 > /dev/null;then
-		echo "ERROR: cannnot ping $ns1 from $ns2 via ipv6"
+		echo "ERROR: cannot ping $ns1 from $ns2 via ipv6"
 		lret=1
 	fi
 
-- 
2.49.1


