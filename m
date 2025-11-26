Return-Path: <linux-kselftest+bounces-46567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11697C8BCEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FC544E504C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FFB33F39F;
	Wed, 26 Nov 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l0+uYE+k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pA7qptr4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n2iYVi6u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ITcgysbd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609632E14A
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188410; cv=none; b=f4duI4+qostRmynxaP1YSVs589/YYr4RZagK4qJZu/MwfZT0Xdfj4zAkrddfZ5S6XDch0ewSA9Qi/9SvuwS7EC+nmGsZntjuDzQ+e8DvME/Fw2fLm3sjRREevI1Mhza+y+o7BILmVE48PtOf/ME3ge4zOF1kuDN/KDILP0Ye7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188410; c=relaxed/simple;
	bh=3xf/d4zi+3N7+h/wteuZciKcrT6tEwTTuvcqiCP7G1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hskt7cFha8EWalQhK9Hrc1z93UFdaTY5wtdXp1Y8QvTEZp5u+gI/OsGVz2Q1ezHo3Nq4uNoj8mNFT2OyLWr3e2mtgWhdSVB4++Ejj/swi1Nefq655KJUhGA/owVGb+09w/UMxg0wosXLc1KnHU6BCC+NqnRl+Bf8uS4URQbeNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0+uYE+k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pA7qptr4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n2iYVi6u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ITcgysbd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E863F336C0;
	Wed, 26 Nov 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764188404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW6x2f8ex+aAbpzCN3iK/uH0KKwVGB+ilGfHO9wn0l0=;
	b=l0+uYE+kzwYOqInHDqx1cUl7p9XBrq7Yf2UgQv7cS719mm/FUqIFPRRbpmJs67H/+ybEjq
	91ZEPOQUopYlU1r3Hes3kOdiGIVBdEOntbiA/FriRt899RE+ZJKBf5CHRroo86AjMTr3VF
	IjKC5q+X6POH6wA1ImmsQmhlRstFBjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764188404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW6x2f8ex+aAbpzCN3iK/uH0KKwVGB+ilGfHO9wn0l0=;
	b=pA7qptr4mXpDz3Bne2sS08XSDJMtYzaDypIiWREHfDAH8P3aprlEBRmdVfqMmuH2DN6oke
	38SXAfNwZCkDwrDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n2iYVi6u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ITcgysbd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764188403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW6x2f8ex+aAbpzCN3iK/uH0KKwVGB+ilGfHO9wn0l0=;
	b=n2iYVi6uCDE4prnL9u2nprriR112FhQY9ZOaPJ8pxiV69SZahh8MqMTaBQ9Yxtd8j+Qy5L
	+tLuNQQL0LrwbpPFyHwD3sK9t7hWu347hwwHJfvU/XkCRHCNxKHmgl3KPaN006w6O59LNu
	u9QFbVqOHIL94czpPk7bxdfWThUo6qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764188403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW6x2f8ex+aAbpzCN3iK/uH0KKwVGB+ilGfHO9wn0l0=;
	b=ITcgysbd9xZG8i53uOY5HMYqCCLMrfmsFNi9qtO+cdOV+5LIKmPehpF5yfgyjs4W18drrZ
	7zqvNcu3UQc4CNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47EDB3EA63;
	Wed, 26 Nov 2025 20:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yE1jDvNgJ2mDEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 26 Nov 2025 20:20:03 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next] selftests: ipv6_icmp: add tests for ICMPv6 handling
Date: Wed, 26 Nov 2025 21:19:43 +0100
Message-ID: <20251126201943.4480-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126201943.4480-1-fmancera@suse.de>
References: <20251126201943.4480-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E863F336C0
X-Rspamd-Action: no action
X-Spam-Flag: NO

Test ICMPv6 to link local address and local address. In addition, this
test set could be extended to cover more situations in the future.

ICMPv6 to local addresses
    TEST: Ping to link local address                                   [OK]
    TEST: Ping to link local address from ::1                          [OK]
    TEST: Ping to local address                                        [OK]
    TEST: Ping to local address from ::1                               [OK]

Tests passed:   4
Tests failed:   0

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/ipv6_icmp.sh | 204 +++++++++++++++++++++++
 2 files changed, 205 insertions(+)
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
index 000000000000..d4764219007c
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_icmp.sh
@@ -0,0 +1,204 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test is for checking IPv6 ICMP behavior in different situations.
+source lib.sh
+ret=0
+
+# all tests in this script, can be overridden with -t option
+TESTS="icmpv6_to_local_address"
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
+	if [ ${rc} -eq ${expected} ]; then
+		printf "    TEST: %-60s  [OK]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+		echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo
+		echo "hit enter to continue, 'q' to quit"
+		read a
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
+	cleanup_ns $ns1
+}
+
+get_linklocal()
+{
+	local dev=$1
+	local addr
+
+	addr=$($IP -6 -br addr show dev ${dev} | \
+	awk '{
+		for (i = 3; i <= NF; ++i) {
+			if ($i ~ /^fe80/)
+				print $i
+		}
+	}'
+	)
+	addr=${addr/\/*}
+
+	[ -z "$addr" ] && return 1
+
+	echo $addr
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
+		printf "    COMMAND: $cmd\n"
+		stderr=
+	fi
+
+	out=$(eval $cmd $stderr)
+	rc=$?
+	if [ "$VERBOSE" = "1" -a -n "$out" ]; then
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
+
+	echo
+	echo "ICMPv6 to local addresses"
+
+	setup
+
+	local lldummy=$(get_linklocal dummy0)
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
+		v) VERBOSE=$(($VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+[ "${PAUSE}" = "yes" ] && PAUSE_ON_FAIL=no
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit $ksft_skip;
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+# start clean
+cleanup &> /dev/null
+
+for t in $TESTS
+do
+	case $t in
+	icmpv6_to_local_address)	icmpv6_to_local_address;;
+
+	help) echo "Test names: $TESTS"; exit 0;;
+	esac
+done
+
+if [ "$TESTS" != "none" ]; then
+	printf "\nTests passed: %3d\n" ${nsuccess}
+	printf "Tests failed: %3d\n" ${nfail}
+fi
+
+exit $ret
-- 
2.51.1


