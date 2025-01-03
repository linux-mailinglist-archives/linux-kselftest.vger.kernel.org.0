Return-Path: <linux-kselftest+bounces-23853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D6A00773
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5553018848E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647991F9AB6;
	Fri,  3 Jan 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hhe2kiMu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A51F942B;
	Fri,  3 Jan 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899023; cv=none; b=fI3DSWEwE8PF5yaZUd4NJRIiHrXu4wKRQLGHWBptVp19LwjqcckTejS7N50p5iKXtr7S10p+0eOJY9dX40gAhl5ayINHiWmn/48NeKo6sFWWRD0PEIzzuUxJb/PMXZjxwKnmdxArd2lFlvDX2d0ve5ENxA+1rLRQMCTgmKO/V5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899023; c=relaxed/simple;
	bh=Qq7Pee8iCSRt8mgMHNvC+ZA8dk9hrFnGJtuU6c7knkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IljbOXUzkBh4zDl3a8b762f1oJiBEdanDOUAKEhevL4VvRV6J9Oi8DiBtX1mlnGxHnRd/kdgi8ujxFhc1jtLciXD0KWHCSlNq6oBsb14uAkXkryHEF2CsPFxkoSXNtPltjLXHU3UMWUqP/IDI+rriJ0B9qrcX78wW/YoiG+ifkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hhe2kiMu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BD7E40005;
	Fri,  3 Jan 2025 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735899013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/opghz49cFwrWybvdYzXWvegj+VnflH7hGK/zXyau6s=;
	b=Hhe2kiMuGIZeR2BLYdC+IlMNkkbdhXN56HmCxU8YM5x9kf0QomH1R9ROyV0o6ZZcULAQCR
	W8gJWxkuxqmcGXfj05xR53B87xauskMtn9lpOnOGlSHxtmjW6ECaCoJyp+HAAp2iRAQMiT
	9VD7Vwh8MQohQpJPpWfPWBpgijNxZk0yWckDUuPVCWXtMIijDWszaa3cuZQABFCV/J1yMu
	F9bDVd9lt74/dh1EPtThw82I2i/L2BYhdDv4JBGBvfUsdhSXZ9te8rqLtPhBpR+zzbdiNT
	s4VH+rS9kcIl9v3SDAFN89tQkYnImfN9ZPnVH+sYu7XZSQis1wbI8w48kmG7dQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 03 Jan 2025 11:10:09 +0100
Subject: [PATCH 1/3] selftests/bpf: test_xdp_redirect: Rename BPF sections
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-xdp_redirect-v1-1-e93099f59069@bootlin.com>
References: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
In-Reply-To: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

SEC("redirect_to_111") and SEC("redirect_to_222") can't be loaded by the
__load() helper.

Rename both sections SEC("xdp") so it can be interpreted by the __load()
helper in upcoming patch.
Update the test_xdp_redirect.sh to use the program name instead of the
section name to load the BPF program.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/progs/test_xdp_redirect.c | 4 ++--
 tools/testing/selftests/bpf/test_xdp_redirect.sh      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
index b778cad454852ed3a1808aca665dd9f9cc2b6c7b..7025aee08a001cfc42e52174a4acce7869dd331b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
@@ -12,12 +12,12 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-SEC("redirect_to_111")
+SEC("xdp")
 int xdp_redirect_to_111(struct xdp_md *xdp)
 {
 	return bpf_redirect(111, 0);
 }
-SEC("redirect_to_222")
+SEC("xdp")
 int xdp_redirect_to_222(struct xdp_md *xdp)
 {
 	return bpf_redirect(222, 0);
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect.sh b/tools/testing/selftests/bpf/test_xdp_redirect.sh
index 0746a4fde9d3181667c081698249a1b6dd1d7663..3c61a1c22b084aa5ca824ec5e8057aa2fee12b71 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect.sh
@@ -56,8 +56,8 @@ test_xdp_redirect()
 
 	ip -n ${NS1} link set veth11 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
 	ip -n ${NS2} link set veth22 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
-	ip link set dev veth1 $xdpmode obj test_xdp_redirect.bpf.o sec redirect_to_222 &> /dev/null
-	ip link set dev veth2 $xdpmode obj test_xdp_redirect.bpf.o sec redirect_to_111 &> /dev/null
+	ip link set dev veth1 $xdpmode obj test_xdp_redirect.bpf.o program xdp_redirect_to_222 &> /dev/null
+	ip link set dev veth2 $xdpmode obj test_xdp_redirect.bpf.o program xdp_redirect_to_111 &> /dev/null
 
 	if ip netns exec ${NS1} ping -c 1 10.1.1.22 &> /dev/null &&
 	   ip netns exec ${NS2} ping -c 1 10.1.1.11 &> /dev/null; then

-- 
2.47.1


