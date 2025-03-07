Return-Path: <linux-kselftest+bounces-28467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BBA56378
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56C47A87EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640520A5C1;
	Fri,  7 Mar 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mD+2175h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5F206F16;
	Fri,  7 Mar 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339125; cv=none; b=uUMBcZX/SvxaGEg14pj4xP+oWR4+/OqyhUp/hXHLaqARXBfot8F7fGII5ujdSq+BcmiVONhEED/q1OuhPnzUoIUCwewTc94cf8jr0EhObhSb1SzMGKS8ocEStHhUDPXiJcrz7j4DScvzljqOEPi3/KNmjr7vkJKxa4bB4nrXUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339125; c=relaxed/simple;
	bh=UcblwryEiR71Xfu/dHRtNCXOR5qYBSqNNgTJihF0uOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nl2KY8S2HW7seaEs+FmDxzKz3VFahBz4FszFuYdIjo9Itq9esxemXN2tUnsbISvxGmLf0qdKbmTWIXhG7PIMWi3ji2IJyr3WVBFJMRif+FFzPiXy5G3ikF3b7tB1/ylcI5+3H5mu/jWgKzmhUpG3OO1/vjC6xhwDVCT4d8ZqPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mD+2175h; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE4EF432F5;
	Fri,  7 Mar 2025 09:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741339114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hotar4zMqOb9mVGLlRBJrVzkTVe0vONc6YkWTjZAAas=;
	b=mD+2175hCQdf85YQwoDinDAQfwQvl1VEsXZxYtZVDXGugmtTclGLB15Ln3PeaevSJdsLmL
	mzgsUbyeWiZ7v6CSYP9Z6I3/GIkv0Dk2RleolIL5cSULC+Ri3pw+k0bEBrU/ZkE1iKym/6
	QCtLWkR5JKl2dw3LovlZfMhcmrZeG2HzsmpEU3mWkOgyAOeiJDzLJBFIVr9kXn42vHYayo
	tGDrxnBouJkjOB0c+UHi97JzguIn/qt9JIHXybf+pNLa6J6UwyAVNBwR+4iSatEfK+Svp1
	r3rNTr+bvyfr1CAgj/zqSj4tW1Y0TMbpuJv/feya5jut+fN2RXQSaM4gw5C4DA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 07 Mar 2025 10:18:23 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: lwt_seg6local: Remove unused
 routes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-seg6local-v1-1-990fff8f180d@bootlin.com>
References: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
In-Reply-To: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtt
 hhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

Some routes in fb00:: are initialized during setup, even though they
aren't needed by the test as the UDP packets will travel through the
lightweight tunnels.

Remove these unnecessary routes.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_lwt_seg6local.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
index 0efea2292d6aac3a33f4745b1cdbda803fd1f307..9c74b88730ffd98f8e988a078d218ffbcd9ee95c 100755
--- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
+++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
@@ -99,19 +99,14 @@ ip netns exec ${NS6} ip link set dev lo up
 
 # All link scope addresses and routes required between veths
 ip netns exec ${NS1} ip -6 addr add fb00::12/16 dev veth1 scope link
-ip netns exec ${NS1} ip -6 route add fb00::21 dev veth1 scope link
 ip netns exec ${NS2} ip -6 addr add fb00::21/16 dev veth2 scope link
 ip netns exec ${NS2} ip -6 addr add fb00::34/16 dev veth3 scope link
-ip netns exec ${NS2} ip -6 route add fb00::43 dev veth3 scope link
-ip netns exec ${NS3} ip -6 route add fb00::65 dev veth5 scope link
 ip netns exec ${NS3} ip -6 addr add fb00::43/16 dev veth4 scope link
 ip netns exec ${NS3} ip -6 addr add fb00::56/16 dev veth5 scope link
 ip netns exec ${NS4} ip -6 addr add fb00::65/16 dev veth6 scope link
 ip netns exec ${NS4} ip -6 addr add fb00::78/16 dev veth7 scope link
-ip netns exec ${NS4} ip -6 route add fb00::87 dev veth7 scope link
 ip netns exec ${NS5} ip -6 addr add fb00::87/16 dev veth8 scope link
 ip netns exec ${NS5} ip -6 addr add fb00::910/16 dev veth9 scope link
-ip netns exec ${NS5} ip -6 route add fb00::109 dev veth9 scope link
 ip netns exec ${NS5} ip -6 route add fb00::109 table 117 dev veth9 scope link
 ip netns exec ${NS6} ip -6 addr add fb00::109/16 dev veth10 scope link
 

-- 
2.48.1


