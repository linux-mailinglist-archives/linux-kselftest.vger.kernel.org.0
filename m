Return-Path: <linux-kselftest+bounces-456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622137F4F41
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D6F28131E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ABF5C06A;
	Wed, 22 Nov 2023 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fWMKENtY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOUl/rwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF41B9;
	Wed, 22 Nov 2023 10:21:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 87DA158034F;
	Wed, 22 Nov 2023 13:21:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 Nov 2023 13:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700677264; x=
	1700684464; bh=pAXMuw36t4A5a6iy5D+iXmBn9GlBmIUIyg5Iqf95p7I=; b=f
	WMKENtYhXbTeI2PbKCiatC9Tzw91bHej/Dcc5zPpOUTJtwujIzZI38FTSVynRHQZ
	wvSlgXN1cWJK5vFYohWU0Xd8HGsILYeCsSqYRy0NSjxMjNdQMOYa5RWuzV9wfVsD
	/diMeZLGKhEv+DFyd+mK4Jcj2k4fpWAx8as99zf9FXISiWle+0zufWAxK/h4rjhM
	A2O6S/Q+yrmX7wtzx+qb6i3CM8nmIQaQYG8H+XU3BkzlCGWdjpTCC5qay8qBYgh/
	O3XP9z1N8e0dKGYe2iutqH46kRpKr9wgIe8VMNPGbjOzaWl5kjrphEhpa/92BVTs
	DVFfgqFUU761A6veKvLRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677264; x=
	1700684464; bh=pAXMuw36t4A5a6iy5D+iXmBn9GlBmIUIyg5Iqf95p7I=; b=B
	OUl/rwQ71o6LTPAGfnbdb7yt2tzHLcVY+feh/mbDVlTzinAGZO14hjxHEf2whgGb
	Jjv70ovgUvzyuHgb3Afo/67RlSm+riohjlSdhF0VCyxTSv8u4E0FZJkmK2rr0muD
	bEX8ab1Wig+Vf9N0/3mgJFqcqAMkLQxPvsoEH8DBwTKbLfS4jsrekfkP7/v39GfS
	l+VfqI3TjRluZhcPai1iaw69lMiX0OJTsumNqcrqb2/7evD5Jppi0zRCZq52G5Sl
	qcTtA+v3y2hwCM45LIdLBSxavaxSkeRmVs25/zFAluABAdTeDaM35lrnRQHqAZIF
	IO9e2RLzIy9npIcb/Jd7w==
X-ME-Sender: <xms:kEZeZWF9ugO6MwFfOlAbcUJO3LhkUpfDmJytgwsLXcBPl5H8I8Iwhg>
    <xme:kEZeZXWkbh6xCuUm8JPnvrGL3F3F2r8ueqL0JqYD5LueRdj8ALVUOTh6kSy1PxEGQ
    o79dEQSLyHzsuJGDQ>
X-ME-Received: <xmr:kEZeZQJ8GWb00iQN-FkZyFCUYret6eZwuKjkG7GKIz4egFI7nzHh7C87kfXfywcZKKkotNnPB1wIdJ_9LnHNDvMva2onEvl9_wAcLbhbQnu7OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeevtdekjeffkefgfe
    fhvefffeetgfeuueeutdetjeduudehheeiffdvgefhhfevhfenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:kEZeZQEF_7DuYmEpcLoQ3tKuf6FtONnvAgvGVCtJR-EX5e36qvTnTQ>
    <xmx:kEZeZcXLQzKV5q_kpir9SeRsXwh8vuqbVIU3zDcuEFfJnqW-5n0UEg>
    <xmx:kEZeZTNdc4BePZKzNr9DvPPgno44FfQe67lrp0lkWrgaq0N9O2NbIg>
    <xmx:kEZeZXZ3YNNqSRgF6KXRCZ15XA-AOBxjmNGmIdyMFAaN-KAGmrU9iQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:02 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v1 3/7] bpf: selftests: test_tunnel: Use ping -6 over ping6
Date: Wed, 22 Nov 2023 11:20:24 -0700
Message-ID: <4c6de574f5de959ca5af77f4463e119186ac3202.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ping6 binary went away over 7 years ago [0].

[0]: https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2dec7dbf29a2..85ba39992461 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -295,13 +295,13 @@ test_ip6gre()
 	add_ip6gretap_tunnel
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# overlay: ipv4 over ipv6
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	ping $PING_ARG 10.1.1.100
 	check_err $?
 	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
+	ip netns exec at_ns0 ping -6 $PING_ARG fc80::200
 	check_err $?
 	cleanup
 
@@ -324,13 +324,13 @@ test_ip6gretap()
 	add_ip6gretap_tunnel
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# overlay: ipv4 over ipv6
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	ping $PING_ARG 10.1.1.100
 	check_err $?
 	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
+	ip netns exec at_ns0 ping -6 $PING_ARG fc80::200
 	check_err $?
 	cleanup
 
@@ -376,7 +376,7 @@ test_ip6erspan()
 	config_device
 	add_ip6erspan_tunnel $1
 	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	check_err $?
 	cleanup
@@ -474,7 +474,7 @@ test_ipip6()
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ipip6_set_tunnel ipip6_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# ip4 over ip6
 	ping $PING_ARG 10.1.1.100
 	check_err $?
@@ -502,11 +502,11 @@ test_ip6ip6()
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ip6ip6_set_tunnel ip6ip6_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# ip6 over ip6
-	ping6 $PING_ARG 1::11
+	ping -6 $PING_ARG 1::11
 	check_err $?
-	ip netns exec at_ns0 ping6 $PING_ARG 1::22
+	ip netns exec at_ns0 ping -6 $PING_ARG 1::22
 	check_err $?
 	cleanup
 
-- 
2.42.1


