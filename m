Return-Path: <linux-kselftest+bounces-38681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37FB20BEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262603A2A4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB3E2D3A63;
	Mon, 11 Aug 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Po9lv6wp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMIqSH/m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE02D3725;
	Mon, 11 Aug 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922445; cv=none; b=FYR1GvVvlpF1m4wS0ROUAii9onoLtDq/npKDfhtZ/oq6hvsqVr4b3AT3f1epdcxZCD14NgssayxLFjnXtWGMg4Rfn2tUpvWCJL4WHLHsQjEPQA9EAHvPGPzmsctoZhfORtPDJ1PXzviWIsXlY58ZvqFWAmT+UfxQ5eQFGEpo5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922445; c=relaxed/simple;
	bh=htXPeoJQbqZF99qNLNd9d1DXZW8gekEfqBS0qiLgXnQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=H+l21o75kokIfQqyrJ2gjNB+aYBLdbLIB3fMS4PhHLyzbsEYW9O3Aqvpxjzgb9tiyH3VQNJ5kJK/3JxPb3Gnk46Yo0bgaPaqgVcn15jMkK0RW5q/MRh/byzrfmwnJ+Rg+62if0XUfDsxTKAWHZE38BR03qG/dfzORI48H+EM30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Po9lv6wp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMIqSH/m; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 776A27A00CC;
	Mon, 11 Aug 2025 10:27:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 10:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1754922441; x=1755008841; bh=rMbp2slgZNPMZBdtwwLs0
	gFz6mlpsBWyNd50uJSqprE=; b=Po9lv6wp5cNnhwq7FnSd+1LBLuGRSnUES4YNu
	k9UjRMHBPhHWl4fVSH3e0Fj7c4ytkWoJ65QkEk8zKCgzy2IRgRxXJSbGvPU82cBq
	SuIL+UK2kH38kv4RaPx0OYRK9smVXb4wC9J1NB1N7Ko4ZT55A1fbxZL5FMK0M1nL
	KaR21iI9y21fP6G+tQNk4DQY+QANuIW0/K+UrOeR+6+W0YRD+N//+IHQaJILoOXE
	lwy/Sagq5pmZfQVNGQeABcfmCArNewWw1uwpUgoufo+qCyyC0da73Kc53aJSC8+F
	TJNoXepPE6z22rP7v74ofETMT0ELiRv+AH02ivwp9w20ETf7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754922441; x=1755008841; bh=rMbp2slgZNPMZBdtwwLs0gFz6mlpsBWyNd5
	0uJSqprE=; b=jMIqSH/m84H0fxvAkYHCfnnGQ4JOmivzE0CBwYtvc45rUsR+TWZ
	dczcm2A9OQHcvg0LhWWz/NTqfA7Y7cqYwrQpTKImsJpRK4LggSZo70XG/GSJS6hw
	5dcmcs5Z+geY2JU+xzeFAFDkLDyyPCB7eZV147XYnWa/lnGvmQlBlW7dWpqbJsGL
	GDdKeYh9JPZLGC2EOoFvng5Gi+9o57sDI4V4y+leGbH7d50bnzKyZcAzoNMq5GXJ
	QZo1d/1R8YVCUOvqKkE0WYuLDe6on6sWOFBxvFYo5CUNvRYapKy1ReKygym6trBr
	ltaNWVd2NxG3Yak7eZ6O/zo1uYHJwSeyDrg==
X-ME-Sender: <xms:yP2ZaPWJzRrpP9ltA3-9VvKRJ5uCUxL8rgmhjei_nRzvvS1oEXzhBg>
    <xme:yP2ZaMwi0udgOAXjOnsdpRjrNWioudJFigAFoy5Hi_7aI2eafAPXmVYYqgC1py1_i
    lQSlhD8kec6IEW6OR8>
X-ME-Received: <xmr:yP2ZaOygNps19jicmFbv0yfgl5P8Zp4e9CdVIl1qGagWrtl0bcUI9i0Yk-Ae_TtMJP7NFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiioh
    hrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    hhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:yP2ZaJ3LhMpP9TW_U4_BCUft-O83kvxzocYByxg4I-xgmg4dQg6r3g>
    <xmx:yP2ZaEpTsUZEEe7QsKiL_x1qNtL4UnV_pY1KeZiJni4pglskVGX90Q>
    <xmx:yP2ZaHBybZ8NlL1hTMeD0KFfWWpYo_MEEqtN7qBPkMmq8_bc966Uaw>
    <xmx:yP2ZaNrqZRhdo3yI6kycEqJxGC2DQVAxvsP9lq7ia2TIt3RCr16SsA>
    <xmx:yf2ZaIBTcb0Cdzwcm2ChwXeNGKpNbklxyCUvUI3Cfs8xgVVc0o1bsq7f>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 10:27:20 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 4E7619FCA5; Mon, 11 Aug 2025 07:27:19 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4AE6C9FC54;
	Mon, 11 Aug 2025 07:27:19 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
    David Wilder <wilder@us.ibm.com>
Subject: Re: [PATCH net] bonding: don't set oif to bond dev when getting NS
 target destination
In-reply-to: <20250811140358.2024-1-liuhangbin@gmail.com>
References: <20250811140358.2024-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 11 Aug 2025 14:03:58 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <783434.1754922439.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Aug 2025 07:27:19 -0700
Message-ID: <783435.1754922439@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Unlike IPv4, IPv6 routing strictly requires the source address to be vali=
d
>on the outgoing interface. If the NS target is set to a remote VLAN inter=
face,
>and the source address is also configured on a VLAN over a bond interface=
,
>setting the oif to the bond device will fail to retrieve the correct
>destination route.
>
>Fix this by not setting the oif to the bond device when retrieving the NS
>target destination. This allows the correct destination device (the VLAN
>interface) to be determined, so that bond_verify_device_path can return t=
he
>proper VLAN tags for sending NS messages.
>
>Reported-by: David Wilder <wilder@us.ibm.com>
>Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/
>Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
>Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")

	Does the test update part of this patch apply all the way back
to the oldest longterm kernel after 4e24be018eb9?  I think that's 6.1
right now.

	Generically, I'm wondering if test updates should be separate
patches from the functional changes as a general policy.

	-J

>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_main.c               |  1 -
> .../drivers/net/bonding/bond_options.sh       | 59 +++++++++++++++++++
> 2 files changed, 59 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 257333c88710..30cf97f4e814 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3355,7 +3355,6 @@ static void bond_ns_send_all(struct bonding *bond, =
struct slave *slave)
> 		/* Find out through which dev should the packet go */
> 		memset(&fl6, 0, sizeof(struct flowi6));
> 		fl6.daddr =3D targets[i];
>-		fl6.flowi6_oif =3D bond->dev->ifindex;
> =

> 		dst =3D ip6_route_output(dev_net(bond->dev), NULL, &fl6);
> 		if (dst->error) {
>diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh =
b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
>index 7bc148889ca7..b3eb8a919c71 100755
>--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
>@@ -7,6 +7,7 @@ ALL_TESTS=3D"
> 	prio
> 	arp_validate
> 	num_grat_arp
>+	vlan_over_bond
> "
> =

> lib_dir=3D$(dirname "$0")
>@@ -376,6 +377,64 @@ num_grat_arp()
> 	done
> }
> =

>+vlan_over_bond_arp()
>+{
>+	local mode=3D"$1"
>+	RET=3D0
>+
>+	bond_reset "mode $mode arp_interval 100 arp_ip_target 192.0.3.10"
>+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
>+	ip -n "${s_ns}" link set bond0.3 up
>+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
>+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
>+
>+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
>+		"dev eth0.3 ingress" 101 ".packets" "-n ${c_ns}" || RET=3D1
>+	log_test "vlan over bond arp" "$mode"
>+}
>+
>+vlan_over_bond_ns()
>+{
>+	local mode=3D"$1"
>+	RET=3D0
>+
>+	if skip_ns; then
>+		log_test_skip "vlan_over_bond ns" "$mode"
>+		return 0
>+	fi
>+
>+	bond_reset "mode $mode arp_interval 100 ns_ip6_target 2001:db8::3:10"
>+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
>+	ip -n "${s_ns}" link set bond0.3 up
>+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
>+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
>+
>+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
>+		"dev eth0.3 ingress" 102 ".packets" "-n ${c_ns}" || RET=3D1
>+	log_test "vlan over bond ns" "$mode"
>+}
>+
>+vlan_over_bond()
>+{
>+	# add vlan 3 for client
>+	ip -n "${c_ns}" link add eth0.3 link eth0 type vlan id 3
>+	ip -n "${c_ns}" link set eth0.3 up
>+	ip -n "${c_ns}" addr add 192.0.3.10/24 dev eth0.3
>+	ip -n "${c_ns}" addr add 2001:db8::3:10/64 dev eth0.3
>+
>+	# Add tc rule to check the vlan pkts
>+	tc -n "${c_ns}" qdisc add dev eth0.3 clsact
>+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol arp \
>+		handle 101 flower skip_hw arp_op request \
>+		arp_sip 192.0.3.1 arp_tip 192.0.3.10 action pass
>+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol ipv6 \
>+		handle 102 flower skip_hw ip_proto icmpv6 \
>+		type 135 src_ip 2001:db8::3:1 action pass
>+
>+	vlan_over_bond_arp "active-backup"
>+	vlan_over_bond_ns "active-backup"
>+}
>+
> trap cleanup EXIT
> =

> setup_prepare
>-- =

>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

