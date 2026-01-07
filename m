Return-Path: <linux-kselftest+bounces-48414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD985CFED56
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 17:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01C843000B59
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE313A1A28;
	Wed,  7 Jan 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y0qmfyFY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lYpMtynK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HYRUP9K6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="586rW2Iu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CF3A35B4
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800354; cv=none; b=co75rU6ff1D9XEsRIWMRbqEiTK7Vo5+lxqwCwUKy3/vyjZgV5Jx/3IHhzhwB/T2zdJtZERUEFeR+ZXyl62IwTjyopIAJsc1bgsiCr5bz/6E0hE1fEo6WKiLz6ynn0GeiCoPRsGJwSixqxHTUGIptZDUCgogY2QklheOkT+2r2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800354; c=relaxed/simple;
	bh=6OON2BwgoW5r8OD1ktKGQbg4zg4fXkDB3egXWuCcs6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyjDnfgGJr3b01/ooOP+MicadU1bJlbDJI0FKSe5etxj7kULQRj6IV68eA66A5QDCjgn3vXz/uGsyWy8maEO7RZakcyWaslgkwqFfRv8NFJ+lLBNtQtk5ydPtOkF5x4mz292oOZRJA/B8w0FNZ5RwyghjXbBS2I/BdPQlB4e8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y0qmfyFY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lYpMtynK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HYRUP9K6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=586rW2Iu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A41E5C1FE;
	Wed,  7 Jan 2026 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767800340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQ0QCS3Fgqq7Cs7+suCwQnQWfuDnHC/54TkaNjVT/A4=;
	b=Y0qmfyFYvRt56ts+ZiUkhLoSpSGL9twesU/Fw3WNI7ERPHPQMQSmp/ZUWsq6T/Ev9dQvmL
	dz/+mJzzYIYpGdkrQO1AF1rigT+3vyyEKKUFYFutUarGXCy1ukg5EhuCWVn4PY0062OWqu
	WgpoQ3uSXSQcAHjh0bxbkEewFeY5CgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767800340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQ0QCS3Fgqq7Cs7+suCwQnQWfuDnHC/54TkaNjVT/A4=;
	b=lYpMtynKWm0Enzgwt+Bq7A2zXicDMuj/6tzEYxxnBBNcBlCqkfwASgkcMPj7xkWnl0K20G
	+ysqE9pgpR7Z0jCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767800339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQ0QCS3Fgqq7Cs7+suCwQnQWfuDnHC/54TkaNjVT/A4=;
	b=HYRUP9K6YK/HKOkXG8yX6rJreJ7Dd1K7/JiB5/IWbjwLLsawCCoJhQniJw1Efg8wsGeIlg
	fjTNNDqDstS+pOSQi2KgoXHskFjWZ6EH82POb+/pbByQNIJw9aeXCDjR9xn7RYNSLptGRQ
	WUaq/DbLQAzmndpX1afG0QRxn75uJBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767800339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQ0QCS3Fgqq7Cs7+suCwQnQWfuDnHC/54TkaNjVT/A4=;
	b=586rW2Iur31QHb2T+3e+5n0JT+0lBpG5a6h92DFzv9Vhu6a99hZkxkD5XDeRcNkADXTPtL
	cpm8mSxNExUSkTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 960EA3EA63;
	Wed,  7 Jan 2026 15:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4MOtIRJ+Xmn7CgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 07 Jan 2026 15:38:58 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next v2] selftests: ipv6_icmp: add tests for ICMPv6 handling
Date: Wed,  7 Jan 2026 16:38:41 +0100
Message-ID: <20260107153841.5030-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107153841.5030-1-fmancera@suse.de>
References: <20260107153841.5030-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ipv6_icmp.sh:url,suse.de:mid,suse.de:email,lib.sh:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Test ICMPv6 to link local address and local address, also VRF based
tests. In addition, this test set could be extended to cover more
situations in the future.

ICMPv6 to local addresses
    TEST: Ping to link local address                                    [OK]
    TEST: Ping to link local address from ::1                           [OK]
    TEST: Ping to local address                                         [OK]
    TEST: Ping to local address from ::1                                [OK]

ICMPv6 to VRF based local address
    TEST: Ping to link local address on VRF context                     [OK]
    TEST: Ping to link local address from ::1 on VRF context            [OK]
    TEST: Ping to local address on VRF context                          [OK]
    TEST: Ping to local address from ::1 on VRF context                 [OK]

Tests passed:   8
Tests failed:   0

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: shellcheck fixes, added VRF based tests and simplified linklocal
address parsing
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/ipv6_icmp.sh | 244 +++++++++++++++++++++++
 2 files changed, 245 insertions(+)
 create mode 100755 tools/testing/selftests/net/ipv6_icmp.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..4d29b47bb084 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -47,6 +47,7 @@ TEST_PROGS := \
 	ip_local_port_range.sh \
 	ipv6_flowlabel.sh \
 	ipv6_force_forwarding.sh \
+	ipv6_icmp.sh \
 	ipv6_route_update_soft_lockup.sh \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
diff --git a/tools/testing/selftests/net/ipv6_icmp.sh b/tools/testing/selftests/net/ipv6_icmp.sh
new file mode 100755
index 000000000000..4ac0954e2963
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_icmp.sh
@@ -0,0 +1,244 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test is for checking IPv6 ICMP behavior in different situations.
+source lib.sh
+ret=0
+nfail=0
+
+# all tests in this script, can be overridden with -t option
+TESTS="icmpv6_to_local_address icmpv6_to_vrf_based_local_address"
+
+VERBOSE=0
+PAUSE_ON_FAIL=no
+PAUSE=no
+
+which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+
+	if [ "${rc}" -eq "${expected}" ]; then
+		printf "    TEST: %-60s  [OK]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+		echo
+			echo "hit enter to continue, 'q' to quit"
+			read -r a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo
+		echo "hit enter to continue, 'q' to quit"
+		read -r a
+		[ "$a" = "q" ] && exit 1
+	fi
+}
+
+setup()
+{
+	set -e
+	setup_ns ns1
+	IP="$(which ip) -netns $ns1"
+	NS_EXEC="$(which ip) netns exec $ns1"
+
+	$IP link add dummy0 type dummy
+	$IP link set dev dummy0 up
+	$IP -6 address add 2001:db8:1::1/64 dev dummy0 nodad
+	set +e
+}
+
+cleanup()
+{
+	$IP link del dev dummy0 &> /dev/null
+	cleanup_ns "$ns1"
+}
+
+get_linklocal()
+{
+	local dev=$1
+	local addr
+
+	addr=$($IP -j -6 addr show dev "${dev}" scope link | jq -r '.[].addr_info[1].local')
+
+	[ -z "$addr" ] && return 1
+
+	echo "$addr"
+
+	return 0
+}
+
+run_cmd()
+{
+	local cmd="$1"
+	local out
+	local stderr="2>/dev/null"
+
+	if [ "$VERBOSE" = "1" ]; then
+		printf "    COMMAND: %s\n" "$cmd"
+		stderr=
+	fi
+
+	out=$(eval "$cmd" $stderr)
+	rc=$?
+	if [ "$VERBOSE" = "1" ] && [ -n "$out" ]; then
+		echo "    $out"
+	fi
+
+	[ "$VERBOSE" = "1" ] && echo
+
+	return $rc
+}
+
+icmpv6_to_local_address()
+{
+	local rc
+	local lldummy
+
+	echo
+	echo "ICMPv6 to local addresses"
+
+	setup
+
+	lldummy=$(get_linklocal dummy0)
+
+	if [ -z "$lldummy" ]; then
+		echo "Failed to get link local address for dummy0"
+		return 1
+	fi
+
+	# ping6 to link local address
+	run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
+	log_test $? 0 "Ping to link local address"
+
+	# ping6 to link local address from localhost (::1)
+	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"
+	log_test $? 0 "Ping to link local address from ::1"
+
+	# ping6 to local address
+	run_cmd "$NS_EXEC ${ping6} -c 3 2001:db8:1::1"
+	log_test $? 0 "Ping to local address"
+
+	# ping6 to local address from localhost (::1)
+	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 2001:db8:1::1"
+	log_test $? 0 "Ping to local address from ::1"
+}
+
+icmpv6_to_vrf_based_local_address()
+{
+	local rc
+	local lldummy
+
+	echo
+	echo "ICMPv6 to VRF based local address"
+
+	setup
+
+	lldummy=$(get_linklocal dummy0)
+
+	if [ -z "$lldummy" ]; then
+		echo "Failed to get link local address for dummy0"
+		return 1
+	fi
+
+	run_cmd "$NS_EXEC sysctl -w net.ipv6.conf.all.keep_addr_on_down=1"
+
+	# create VRF and setup
+	run_cmd "$IP link add vrf0 type vrf table 10"
+	run_cmd "$IP link set vrf0 up"
+	run_cmd "$IP link set dummy0 master vrf0"
+
+	# route to reach 2001:db8::1/128 on VRF device and back to ::1
+	run_cmd "$IP -6 route add 2001:db8:1::1/64 dev vrf0"
+	run_cmd "$IP -6 route add ::1/128 dev vrf0 table 10"
+
+	# ping6 to link local address
+	run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
+	log_test $? 0 "Ping to link local address on VRF context"
+
+	# ping6 to link local address from localhost (::1)
+	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"
+	log_test $? 0 "Ping to link local address from ::1 on VRF context"
+
+	# ping6 to local address
+	run_cmd "$NS_EXEC ${ping6} -c 3 2001:db8:1::1"
+	log_test $? 0 "Ping to local address on VRF context"
+
+	# ping6 to local address from localhost (::1)
+	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 2001:db8:1::1"
+	log_test $? 0 "Ping to local address from ::1 on VRF context"
+}
+
+################################################################################
+# usage
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/} OPTS
+
+    -t <test>   Test(s) to run (default: all)
+                (options: $TESTS)
+    -p          Pause on fail
+    -P          Pause after each test before cleanup
+    -v          Verbose mode (show commands and output)
+EOF
+}
+
+################################################################################
+# main
+
+trap cleanup EXIT
+
+while getopts :t:pPhv o
+do
+	case $o in
+		t) TESTS=$OPTARG;;
+		p) PAUSE_ON_FAIL=yes;;
+		P) PAUSE=yes;;
+		v) VERBOSE=$((VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+[ "${PAUSE}" = "yes" ] && PAUSE_ON_FAIL=no
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit "$ksft_skip"
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit "$ksft_skip"
+fi
+
+# start clean
+cleanup &> /dev/null
+
+for t in $TESTS
+do
+	case $t in
+	icmpv6_to_local_address)		icmpv6_to_local_address;;
+	icmpv6_to_vrf_based_local_address)	icmpv6_to_vrf_based_local_address;;
+
+	help) echo "Test names: $TESTS"; exit 0;;
+	esac
+done
+
+if [ "$TESTS" != "none" ]; then
+	printf "\nTests passed: %3d\n" "${nsuccess}"
+	printf "Tests failed: %3d\n" "${nfail}"
+fi
+
+exit $ret
-- 
2.52.0


