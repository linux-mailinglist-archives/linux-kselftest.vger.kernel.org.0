Return-Path: <linux-kselftest+bounces-15600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E4C955D5A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AC01C209F0
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688313FD86;
	Sun, 18 Aug 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duQXJR0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670C86250;
	Sun, 18 Aug 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997153; cv=none; b=ZsARdjgDxF6etCpkpCN3ZEFUbevbwy3Lx/eM0x5x4JJGSc/MXKyzq0yKvW1DbOBlxbI92It9pv9VbQwDvnbgIu11OhmAPOfP6psFklaxZw27QSq4fJWiV1wUFz2MdHzPqtmz/1AdgnnbBZFMwbyneUmBIEYVAR+yVDt1Y1Ev7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997153; c=relaxed/simple;
	bh=ZjASL+VwPuzZue4nCXycd5r5xRpqsleGeah8B5csQPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV4nCB8Yr1eQ5Wn9o1xAGMU8N3P/NGaFoBt1TNU22GNVxa+lMsvFz5MBZXuvcWmYCV2BMuHcrPLZgtRjcVkETutBMBRMJbNmuUQbmgTFteofhcYZs7kGn6ESC9AW0r9VS/mKBblAhfG4K78aJQCyhG++tPEBtQBgMlaTN7hIqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duQXJR0q; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2CE78114AA77;
	Sun, 18 Aug 2024 12:05:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 18 Aug 2024 12:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723997150; x=1724083550; bh=SDWVxLzHkIFY/o5okF0RSVRxEpSl
	7CAAsixgx3QKv1Q=; b=duQXJR0qHJAUNaE127CI2/bHeeZ5UzV30WtJEcNyNzkJ
	semU5H0pr/+Dg+aFP4ECgOsvyKWYLj5BRqPZwh/UaTN/iUIczoeZ7Mk2HbOJocP1
	LfGWsoBQJsWCbv7GxEwRCA16HSuyHqeR2edzwRTAN/O/B/2nHfjuXDBbtvJQoxSe
	waVunugVW3g4RpsLSslhVUfddNsSPVwG85QcnEpAR7/380vL38KTLvE3KJfOGPhD
	7UwDQwhAKGrHI98G36gjXIGKgWqD+eDnjfH2x1QH7nH5kZGfAn4xL5GITV9pt42Z
	Z4qz2tjPmAEQD4ocyrnjRqOjFRHQXkwU9A2h4eAY0g==
X-ME-Sender: <xms:3RvCZqlY0I9ATNYMgQQXyN6Hzq3koZBDP37TvcuA61z7eguJD9EPOg>
    <xme:3RvCZh2yH_2TlgbboxJr1njwGm-8qqMT5d09y-eGIyWTBUoj8xfWWymu7RoNz-Wte
    YbbOc2KiaQU5kg>
X-ME-Received: <xmr:3RvCZoo8oZDPb5claGgaTKRLnrZJUV3tB-mAuWaFETlII99E96_HuBuSS-0Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcu
    oehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefve
    ekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguoh
    hstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhhu
    rghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvsh
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3RvCZukuJjHDwvKulNfgZvtmv1_ZYGXUxHfHzkTY2vrvryex2yHeNg>
    <xmx:3RvCZo0Td8S_F-D6p9lTL1EZzonUi8cnDeqQ-Le36nDVyBy-87mrYg>
    <xmx:3RvCZludJm9fu-judtR0rz-MlcdPbdKaVYjNPmL97sUmupinFrYdmQ>
    <xmx:3RvCZkVTUnGjxagEBXzremv30yN2QEKr_TcTjwsOORILw5DhdeHs9A>
    <xmx:3hvCZio6mVya1HERCKLR7-p7aJ8MSFyA0SLX3PlqNvUOpYiT2kkvhUzT>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Aug 2024 12:05:49 -0400 (EDT)
Date: Sun, 18 Aug 2024 19:05:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: add helper for checking if
 nettest is available
Message-ID: <ZsIb2joq2MjBwk1u@shredder>
References: <20240817183848.658443-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817183848.658443-1-kuba@kernel.org>

On Sat, Aug 17, 2024 at 11:38:48AM -0700, Jakub Kicinski wrote:
> A few tests check if nettest exists in the $PATH before adding
> $PWD to $PATH and re-checking. They don't discard stderr on
> the first check (and nettest is built as part of selftests,
> so it's pretty normal for it to not be available in system $PATH).
> This leads to output noise:
> 
>   which: no nettest in (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
> 
> Add a common helper for the check which does silence stderr.
> 
> There is another small functional change hiding here, because pmtu.sh
> used to return from the test case rather than completely exit.
> Building nettest is not hard, there should be no need to maintain
> the ability to selectively skip cases in its absence.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/fcnal-test.sh         |  9 +--------
>  tools/testing/selftests/net/lib.sh                | 15 +++++++++++++++
>  tools/testing/selftests/net/pmtu.sh               |  8 +-------
>  tools/testing/selftests/net/settings              |  1 +
>  tools/testing/selftests/net/unicast_extensions.sh |  9 +--------
>  5 files changed, 19 insertions(+), 23 deletions(-)

Nice improvement. fib_rule_tests.sh can also benefit from this helper
and so does vrf_route_leaking.sh which assumes 'nettest' is available
in the working directory.

Do you want to fold the diff below into v2 (I tested it)?

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index ec9dbfa6507b..1d58b3b87465 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -51,31 +51,6 @@ log_test()
 	fi
 }
 
-check_nettest()
-{
-	if which nettest > /dev/null 2>&1; then
-		return 0
-	fi
-
-	# Add the selftest directory to PATH if not already done
-	if [ "${SELFTEST_PATH}" = "" ]; then
-		SELFTEST_PATH="$(dirname $0)"
-		PATH="${PATH}:${SELFTEST_PATH}"
-
-		# Now retry with the new path
-		if which nettest > /dev/null 2>&1; then
-			return 0
-		fi
-
-		if [ "${ret}" -eq 0 ]; then
-			ret="${ksft_skip}"
-		fi
-		echo "nettest not found (try 'make -C ${SELFTEST_PATH} nettest')"
-	fi
-
-	return 1
-}
-
 setup()
 {
 	set -e
@@ -334,11 +309,6 @@ fib_rule6_connect_test()
 	echo
 	echo "IPv6 FIB rule connect tests"
 
-	if ! check_nettest; then
-		echo "SKIP: Could not run test without nettest tool"
-		return
-	fi
-
 	setup_peer
 	$IP -6 rule add dsfield 0x04 table $RTABLE_PEER
 
@@ -578,11 +548,6 @@ fib_rule4_connect_test()
 	echo
 	echo "IPv4 FIB rule connect tests"
 
-	if ! check_nettest; then
-		echo "SKIP: Could not run test without nettest tool"
-		return
-	fi
-
 	setup_peer
 	$IP -4 rule add dsfield 0x04 table $RTABLE_PEER
 
@@ -674,6 +639,8 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+check_gen_prog "nettest"
+
 # start clean
 cleanup &> /dev/null
 setup
diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index 152171fb1fc8..e9c2f71da207 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -59,7 +59,6 @@
 # while it is forwarded between different vrfs.
 
 source lib.sh
-PATH=$PWD:$PWD/tools/testing/selftests/net:$PATH
 VERBOSE=0
 PAUSE_ON_FAIL=no
 DEFAULT_TTYPE=sym
@@ -636,6 +635,8 @@ EOF
 # Some systems don't have a ping6 binary anymore
 command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
+check_gen_prog "nettest"
+
 TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_local ipv4_tcp_local
 ipv4_udp_local ipv4_ping_ttl_asym ipv4_traceroute_asym"
 TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_local ipv6_tcp_local ipv6_udp_local


