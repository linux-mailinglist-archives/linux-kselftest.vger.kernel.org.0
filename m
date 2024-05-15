Return-Path: <linux-kselftest+bounces-10268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4F8C6F1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178921F22DF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E764AEF5;
	Wed, 15 May 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghnZU6Lo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328353C48E;
	Wed, 15 May 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815294; cv=none; b=XwPPGvRYFRorT4+T54DCASVXcIeQpNxMNtjaJrso7BhCHQ0UP3oIO2yrJ2thkGKhLNQzaBXO2/u1byrqhmFlyuRLfkl3bFkuCDzpRKToTjAYF1RPixtY5CgspuiiX/2nZ+W49rrAk0oS4+1rZZhoBd7gkiH78CMrA4SLycaVoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815294; c=relaxed/simple;
	bh=87pAH5rgJ9duXfdK2NawbTwlmgvDGgI55KthCb1lDmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsAf9pKtgegoYk65MtyaPByqf3yNNQCXWJchG+kYk4VfsJ+FjYFGZy+mgxFZctfJ+8kTrrkoAnadqLBjXcEt7UiuH7U9J4O2HjqPDs2sx+IILzpXQh340tYU2bTVj9dnqS+TjM4P8rDAwKolQeA7ySWXc+sxQR7+3qwfld6QyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghnZU6Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D31EC116B1;
	Wed, 15 May 2024 23:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715815293;
	bh=87pAH5rgJ9duXfdK2NawbTwlmgvDGgI55KthCb1lDmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ghnZU6LoTFF6lwPJXdDDnAfS7ApnRky1jXlgI4CC5+L+mel7zKhwzfBMTzqFaceXS
	 5pHhj8uFQGm3sxvfc1TQHr7hr7iupgkb7U5FCcVc44vWpBQyzxLC+KG0hJXmdfSxcJ
	 xhHLHqkv8U3QWQCDnhocE/S7BdAQDItKNb195m6/VbMhxLOtYDCPpw6KzDz/ObK5fC
	 y4jfx3Az2HZpIAjsnHZu5US+yFcQrqW+0ALyc63oVWEHSAXCNcs1RfZyqL9yMCJ+xL
	 HOeuuwXjyzquFJlV2DYJTXGSY65reg8EPzuEmi8MNCLE+Ey/S7i5VPr8fP+oYXXevZ
	 +ns0c2p+ly4dw==
Date: Wed, 15 May 2024 16:21:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <shuah@kernel.org>,
 <liuhangbin@gmail.com>, <bpoirier@nvidia.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate
 the expected failures
Message-ID: <20240515162132.476a6b43@kernel.org>
In-Reply-To: <87y18bju1n.fsf@nvidia.com>
References: <20240509235553.5740-1-kuba@kernel.org>
	<875xvhu97r.fsf@nvidia.com>
	<20240514174321.376039a5@kernel.org>
	<87y18bju1n.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 15 May 2024 11:02:28 +0200 Petr Machata wrote:
> >> And then either replace the existing xfail_on_veth's (there are just a
> >> handful) or convert xfail_on_veth to a wrapper around xfail_on_kind. =
=20
> >
> > I think the bridge thing we can workaround by just checking
> > if ${NETIFS[p1]} is veth, rather than $rcv_if_name.
> > Since the two behave the same. =20
>=20
> I don't follow. The test has two legs, one creates a VRF and attaches
> p2, the other creates a bridge and attaches p2. Whether p1 and p2 are
> veth or HW seems orthogonal to whether $rcv_if_name is a bridge or a
> veth.

Right, my superficial understanding was that the main distinction is
whether p2/h2 can do the filtering (or possibly some offload happens).
So if p1,p2 are veths we know to XFAIL, doesn't matter if we're in=20
the vrf or bridge configuration, cause these construct will not filter
either.

If I'm not making sense - I'm probably confused, I can code up what you
suggested, it will work, just more LoC :)

--->8------

=46rom 7a645eb425530f647e88590ba7ba01681e73812e Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 9 May 2024 16:28:41 -0700
Subject: selftests: net: local_termination: annotate the expected failures

Vladimir said when adding this test:

  The bridge driver fares particularly badly [...] mainly because
  it does not implement IFF_UNICAST_FLT.

See commit 90b9566aa5cd ("selftests: forwarding: add a test for
local_termination.sh").

We don't want to hide the known gaps, but having a test which
always fails prevents us from catching regressions. Report
the cases we know may fail as XFAIL.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: liuhangbin@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org

v2:
 - remove duplicated log_test_xfail
v1: https://lore.kernel.org/all/20240509235553.5740-1-kuba@kernel.org/
---
 tools/testing/selftests/net/forwarding/lib.sh       |  7 +++++++
 .../selftests/net/forwarding/local_termination.sh   | 13 ++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/=
selftests/net/forwarding/lib.sh
index 112c85c35092..79aa3c8bc288 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -473,6 +473,13 @@ ret_set_ksft_status()
 # Whether FAILs should be interpreted as XFAILs. Internal.
 FAIL_TO_XFAIL=3D
=20
+# Clear internal failure tracking for the next test case
+begin_test()
+{
+    RET=3D0
+    FAIL_TO_XFAIL=3D
+}
+
 check_err()
 {
 	local err=3D$1
diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/=
tools/testing/selftests/net/forwarding/local_termination.sh
index c5b0cbc85b3e..a241acc02498 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -73,9 +73,12 @@ check_rcv()
 	local pattern=3D$3
 	local should_receive=3D$4
 	local should_fail=3D
+	local xfail_sw=3D$5
=20
 	[ $should_receive =3D true ] && should_fail=3D0 || should_fail=3D1
-	RET=3D0
+	begin_test
+	# check if main interface is veth
+	[ "$xfail_sw" =3D=3D true ] && xfail_on_veth $h1
=20
 	tcpdump_show $if_name | grep -q "$pattern"
=20
@@ -157,7 +160,7 @@ run_test()
=20
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
 		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
-		false
+		false true
=20
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
 		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
@@ -165,7 +168,7 @@ run_test()
=20
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, allmulti" \
 		"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
-		false
+		false true
=20
 	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
 		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
@@ -173,7 +176,7 @@ run_test()
=20
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
-		false
+		false true
=20
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR2, ethertype IPv4 (0x0800)" \
@@ -189,7 +192,7 @@ run_test()
=20
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
-		false
+		false true
=20
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR2, ethertype IPv6 (0x86dd)" \
--=20
2.45.0


