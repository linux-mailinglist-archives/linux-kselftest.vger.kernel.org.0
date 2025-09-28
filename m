Return-Path: <linux-kselftest+bounces-42557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C6BA77BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C2F172138
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938F28C840;
	Sun, 28 Sep 2025 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lB+Gq3u5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A321FF36;
	Sun, 28 Sep 2025 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092467; cv=none; b=sKGxDO91qC/sQQxdEinLAWuGBGhgXcUsbv1/9qU6AuObKyaZa466JF89+yPJ/WcAXK6RuprcLF1uhQU0891trbj1nvmVTeuXOe3Hlj3Ci7LI1gqoER3x5RvTC4cFvsQTKc/c6NQOhr+qyUpIvoVGvIExUyNL2JTMwKEapXNWq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092467; c=relaxed/simple;
	bh=SHw0rKL+G76APQClxdB3j0xlgk+acQxsuBMHdPqMnxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMAWCHbj6P2frx+5hcWtYNjdubdW91d/pYg/0U57asfYYQHVpdoCr594Xh1/r80ZjMeMxOLu/FSmm9UKCNFBotolYWYiyFWFXJwiKrm4FPmA/fX8So4OfLSEGMs1zpIdMP5L7ttyjM+u1t2woUSXpKHXkrktRXVG6MQKs2sNb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lB+Gq3u5; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1759092464; x=1759351664;
	bh=+6HCzx3gGrvQkKPUFCzreP+p3OBeh/rxN92gkAk48SE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lB+Gq3u5eMA4CgoBuTfXKGTkML2OrnrA2iCcNsmfnZB9Yl5LnUq9Wy6EIjH6/0pYO
	 F0rDJmpmuJa4/oWp7+FKTjUgwcgmPYABE5lZzQeGUhJbq3H3+ebm+4kK+AOTaTQTIB
	 wQf+VDVDv7R/kmGJ7A/sHBegKrKLKWMroGMdDzX+JgAXKlEBlFbRZYA31Ei35U0dOA
	 GUficfbRcpgJJ6DMGVjKu8ilcwFgy8SDGvmmXVMIIRNieOMEyHpP4etAD7xEJ4UBCe
	 lIDLREQTQTY1m/GiFLL9kIUzGlSz3t8e9/OBSMTaz1Y6dUVKhnHlP6XtdMlRu306CO
	 VUnLFV3DbY85Q==
Date: Sun, 28 Sep 2025 20:47:38 +0000
To: kuba@kernel.org, pabeni@redhat.com
From: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
Cc: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>, davem@davemloft.net, dsahern@kernel.org, kuniyu@google.com, kuniyu@amazon.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] ipv6: Check AF_UNSPEC in ip6_route_multipath_add()
Message-ID: <20250928204708.1613737-2-maksimilijan.marosevic@proton.me>
In-Reply-To: <u3HUdiCPiMCv5kkEVMXU9bKhZLDParnZCqUybez-bALHM78ymOclmc2pzUXgAGu-Bdwi30aV_LJkhicY2rwhZdjBzvYWyErXQpDQN3w4Ihs=@proton.me>
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me> <20250904090301.552ef178@kernel.org> <u3HUdiCPiMCv5kkEVMXU9bKhZLDParnZCqUybez-bALHM78ymOclmc2pzUXgAGu-Bdwi30aV_LJkhicY2rwhZdjBzvYWyErXQpDQN3w4Ihs=@proton.me>
Feedback-ID: 97766065:user:proton
X-Pm-Message-ID: aca81420f2b53a256835526d441d52ffb3fc7eeb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This check was removed in commit e6f497955fb6 ("ipv6: Check GATEWAY
in rtm_to_fib6_multipath_config().") as part of rt6_qualify_for ecmp().
The author correctly recognises that rt6_qualify_for_ecmp() returns
false if fb_nh_gw_family is set to AF_UNSPEC, but then mistakes
AF_UNSPEC for AF_INET6 when reasoning that the check is unnecessary.
This means certain malformed entries don't get caught in
ip6_route_multipath_add().

This patch reintroduces the AF_UNSPEC check while respecting changes
of the initial patch.

Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Da259a17220263c2d73fc
Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config()=
.")
Signed-off-by: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
---
 net/ipv6/route.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..884bae3fb1b1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5454,6 +5454,14 @@ static int ip6_route_multipath_add(struct fib6_confi=
g *cfg,
 =09=09=09goto cleanup;
 =09=09}
=20
+=09=09if (rt->fib6_nh->fib_nh_gw_family =3D=3D AF_UNSPEC) {
+=09=09=09err =3D -EINVAL;
+=09=09=09NL_SET_ERR_MSG(extack,
+=09=09=09=09       "Device only routes can not be added for IPv6 using the=
 multipath API.");
+=09=09=09fib6_info_release(rt);
+=09=09=09goto cleanup;
+=09=09}
+
 =09=09rt->fib6_nh->fib_nh_weight =3D rtnh->rtnh_hops + 1;
=20
 =09=09err =3D ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
--=20
2.43.0



