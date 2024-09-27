Return-Path: <linux-kselftest+bounces-18451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B3987F14
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 09:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17A9280FD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C417A5B4;
	Fri, 27 Sep 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TsgjXtw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131972628D
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420621; cv=none; b=inNX4bJpEbUltg3oxgdF2VqQ07QrwuSQ0ce1CTyowJ66gUGBdFdAvJA/bOoZ/nBdT1HSYygy4pLXRq7EKH3awoBnL4VPOu6BR2Yw81wGLezOSsRtlH4J+eSuj1NizhctfdhvoEeA9rq04Ebn79Cmg4+gY3wegmDofKZ12rIO4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420621; c=relaxed/simple;
	bh=lit4drWWoXlbmB5xZse2LmMCZxlhgrRVhkj6To1hqgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bVNi+CHAF1mUwAUO/dt+ctBo377iATzdTcpprmDGOSAmGIStyimIcSEP7H2VYmpXPuHgsJbRfQYcPHypzX2Dg0CxSr/UalgaIpiv8peEAfwT4qWaClhIccnum9z8htyMHw/fK8wQWensMZPty2gxPBGpTWNAsDAAH8Oxy2SlX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TsgjXtw5; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1727420612; x=1727679812;
	bh=lit4drWWoXlbmB5xZse2LmMCZxlhgrRVhkj6To1hqgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TsgjXtw5oLnaxqJigC6xC0V/xqHrIOg6CjZQf7itOmroJ9dE9/nq/sKkQZ5HmwSbC
	 DLyGXmt3WZ6zaebx2yIoXcptiFH3O/4joGo6uzfVP4shV3mn8Zhv6PzuwOwE6lgvEM
	 XDMjqgKD67zPUhmCEZyk1OFNAzaQdrnB2hkHATFwtFGlQkAtRNvHTzXS7UI+joxncJ
	 6xFVQDWL7FI8U/kcrSTjNG7Ika6lEe6myG16ggU0egR1i8U9uISzKE+CgBkhrWdT93
	 kjb5M3wPQ413rqvVZ500NZYQP3iO2MLeq8BDvfBfanfn/DB29pO+Ytkr/fSR/da4xD
	 b+QJoBSXlTO3A==
Date: Fri, 27 Sep 2024 07:03:28 +0000
To: "davem@davemloft.net" <davem@davemloft.net>
From: =?utf-8?Q?Kacper_Ludwi=C5=84ski?= <kac.ludwinski@protonmail.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "petrm@nvidia.com" <petrm@nvidia.com>, "horms@kernel.org" <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>, "shuah@kernel.org" <shuah@kernel.org>
Subject: [PATCH net v2] selftests: forwarding: no_forwarding: Fix issue  related with assigning two different vids to the same interface.
Message-ID: <fQknN_r6POzmrp8UVjyA3cknLnB1HB9I_jfaHoQScvvgHr59VfUNRs9IDo4kQHm1uxEp8_Luym2Vi6_aUGJIec3ZPhjY2qnJ57NgLZGA3K4=@protonmail.com>
Feedback-ID: 10783966:user:proton
X-Pm-Message-ID: 8d9b28129d518c775345aac79bf29a46b24a3f0f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fix typo.
Currently, the second bridge command overwrites the first one.
Fix this by adding this VID to the interface behind $swp2.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tool=
s/testing/selftests/net/forwarding/no_forwarding.sh
index 9e677aa64a06..694ece9ba3a7 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -202,7 +202,7 @@ one_bridge_two_pvids()
 =09ip link set $swp2 master br0

 =09bridge vlan add dev $swp1 vid 1 pvid untagged
-=09bridge vlan add dev $swp1 vid 2 pvid untagged
+=09bridge vlan add dev $swp2 vid 2 pvid untagged

 =09run_test "Switch ports in VLAN-aware bridge with different PVIDs"

--
2.43.0

