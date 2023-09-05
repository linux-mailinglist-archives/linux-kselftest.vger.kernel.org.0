Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5C792579
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbjIEQHx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354469AbjIELzZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 07:55:25 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B91B4;
        Tue,  5 Sep 2023 04:55:20 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 13:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1693914591; bh=kosZK5ws2xLosd0JTolym7WL9xE6UdyuEKk7TSJ0nDg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=h5auX9XjUHuBNnLuRq3JaVBpo+OG07KL0XreDYKZ1UE9dQTGIj7dhmQdUwIzEZ632
         I24EbXgOR2jzbFPOggL/jco52PrEJbY1HtcJVTme3HOcVHN8HmCsbqbqy1fBbkgj63
         5wWPJMYjmI+JMdMOswhL+ielvIIFGqUxbvBFXnb4=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id CD28A82158;
        Tue,  5 Sep 2023 13:49:50 +0200 (CEST)
From:   Johannes Nixdorf <jnixdorf-oss@avm.de>
Date:   Tue, 05 Sep 2023 13:47:23 +0200
Subject: [PATCH net-next v3 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
In-Reply-To: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Johannes Nixdorf <jnixdorf-oss@avm.de>
X-Mailer: b4 0.12.3
X-purgate-ID: 149429::1693914591-40CAE7EF-9EC1E11A/0/0
X-purgate-type: clean
X-purgate-size: 6746
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a suite covering the fdb_n_learned_entries and fdb_max_learned_entries
bridge features, touching all special cases in accounting at least once.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
new file mode 100755
index 000000000000..4da17ac65357
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
@@ -0,0 +1,283 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# ShellCheck incorrectly believes that most of the code here is unreachable
+# because it's invoked by variable name following ALL_TESTS.
+#
+# shellcheck disable=SC2317
+
+ALL_TESTS="check_accounting check_limit"
+NUM_NETIFS=6
+source lib.sh
+
+TEST_MAC_BASE=de:ad:be:ef:42:
+
+NUM_PKTS=16
+FDB_LIMIT=8
+
+FDB_TYPES=(
+	# name		is counted?	overrides learned?
+	'learned	1		0'
+	'static		0		1'
+	'user		0		1'
+	'extern_learn	0		1'
+	'local		0		1'
+)
+
+mac()
+{
+	printf "${TEST_MAC_BASE}%02x" "$1"
+}
+
+H1_DEFAULT_MAC=$(mac 42)
+
+switch_create()
+{
+	ip link add dev br0 type bridge
+
+	ip link set dev "$swp1" master br0
+	ip link set dev "$swp2" master br0
+	# swp3 is used to add local MACs, so do not add it to the bridge yet.
+
+	# swp2 is only used for replying when learning on swp1, its MAC should not be learned.
+	ip link set dev "$swp2" type bridge_slave learning off
+
+	ip link set dev br0 up
+
+	ip link set dev "$swp1" up
+	ip link set dev "$swp2" up
+	ip link set dev "$swp3" up
+}
+
+switch_destroy()
+{
+	ip link set dev "$swp3" down
+	ip link set dev "$swp2" down
+	ip link set dev "$swp1" down
+
+	ip link del dev br0
+}
+
+h_create()
+{
+	ip link set "$h1" addr "$H1_DEFAULT_MAC"
+
+	simple_if_init "$h1" 192.0.2.1/24
+	simple_if_init "$h2" 192.0.2.2/24
+}
+
+h_destroy()
+{
+	simple_if_fini "$h1" 192.0.2.1/24
+	simple_if_fini "$h2" 192.0.2.2/24
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	h2=${NETIFS[p3]}
+	swp2=${NETIFS[p4]}
+
+	swp3=${NETIFS[p6]}
+
+	vrf_prepare
+
+	h_create
+
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+
+	h_destroy
+
+	vrf_cleanup
+}
+
+fdb_get_n_learned()
+{
+	ip -d -j link show dev br0 type bridge | \
+		jq '.[]["linkinfo"]["info_data"]["fdb_n_learned_entries"]'
+}
+
+fdb_get_n_mac()
+{
+	local mac=${1}
+
+	bridge -j fdb show br br0 | \
+		jq "map(select(.mac == \"${mac}\" and (has(\"vlan\") | not))) | length"
+}
+
+fdb_fill_learned()
+{
+	local i
+
+	for i in $(seq 1 "$NUM_PKTS"); do
+		fdb_add learned "$(mac "$i")"
+	done
+}
+
+fdb_reset()
+{
+	bridge fdb flush dev br0
+
+	# Keep the default MAC address of h1 in the table. We set it to a different one when
+	# testing dynamic learning.
+	bridge fdb add "$H1_DEFAULT_MAC" dev "$swp1" master static use
+}
+
+fdb_add()
+{
+	local type=$1 mac=$2
+
+	case "$type" in
+		learned)
+			ip link set "$h1" addr "$mac"
+			# Wait for a reply so we implicitly wait until after the forwarding
+			# code finished and the FDB entry was created.
+			PING_COUNT=1 ping_do "$h1" 192.0.2.2
+			check_err $? "Failed to ping another bridge port"
+			ip link set "$h1" addr "$H1_DEFAULT_MAC"
+			;;
+		local)
+			ip link set dev "$swp3" addr "$mac" && ip link set "$swp3" master br0
+			;;
+		static)
+			bridge fdb replace "$mac" dev "$swp1" master static
+			;;
+		user)
+			bridge fdb replace "$mac" dev "$swp1" master static use
+			;;
+		extern_learn)
+			bridge fdb replace "$mac" dev "$swp1" master extern_learn
+			;;
+	esac
+
+	check_err $? "Failed to add a FDB entry of type ${type}"
+}
+
+fdb_del()
+{
+	local type=$1 mac=$2
+
+	case "$type" in
+		local)
+			ip link set "$swp3" nomaster
+			;;
+		*)
+			bridge fdb del "$mac" dev "$swp1" master
+			;;
+	esac
+
+	check_err $? "Failed to remove a FDB entry of type ${type}"
+}
+
+check_accounting_one_type()
+{
+	local type=$1 is_counted=$2 overrides_learned=$3
+	shift 3
+	RET=0
+
+	fdb_reset
+	fdb_add "$type" "$(mac 0)"
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne "$is_counted" ]
+	check_fail $? "Inserted FDB type ${type}: Expected the count ${is_counted}, but got ${learned}"
+
+	fdb_del "$type" "$(mac 0)"
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne 0 ]
+	check_fail $? "Removed FDB type ${type}: Expected the count 0, but got ${learned}"
+
+	if [ "$overrides_learned" -eq 1 ]; then
+		fdb_reset
+		fdb_add learned "$(mac 0)"
+		fdb_add "$type" "$(mac 0)"
+		learned=$(fdb_get_n_learned)
+		[ "$learned" -ne "$is_counted" ]
+		check_fail $? "Set a learned entry to FDB type ${type}: Expected the count ${is_counted}, but got ${learned}"
+		fdb_del "$type" "$(mac 0)"
+	fi
+
+	log_test "FDB accounting interacting with FDB type ${type}"
+}
+
+check_accounting()
+{
+	local type_args learned
+	RET=0
+
+	fdb_reset
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne 0 ]
+	check_fail $? "Flushed the FDB table: Expected the count 0, but got ${learned}"
+
+	fdb_fill_learned
+	sleep 1
+
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne "$NUM_PKTS" ]
+	check_fail $? "Filled the FDB table: Expected the count ${NUM_PKTS}, but got ${learned}"
+
+	log_test "FDB accounting"
+
+	for type_args in "${FDB_TYPES[@]}"; do
+		# This is intentional use of word splitting.
+		# shellcheck disable=SC2086
+		check_accounting_one_type $type_args
+	done
+}
+
+check_limit_one_type()
+{
+	local type=$1 is_counted=$2
+	local n_mac expected=$((1 - is_counted))
+	RET=0
+
+	fdb_reset
+	fdb_fill_learned
+
+	fdb_add "$type" "$(mac 0)"
+	n_mac=$(fdb_get_n_mac "$(mac 0)")
+	[ "$n_mac" -ne "$expected" ]
+	check_fail $? "Inserted FDB type ${type} at limit: Expected the count ${expected}, but got ${n_mac}"
+
+	log_test "FDB limits interacting with FDB type ${type}"
+}
+
+check_limit()
+{
+	local learned
+	RET=0
+
+	ip link set br0 type bridge fdb_max_learned_entries "$FDB_LIMIT"
+
+	fdb_reset
+	fdb_fill_learned
+
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne "$FDB_LIMIT" ]
+	check_fail $? "Filled the limited FDB table: Expected the count ${FDB_LIMIT}, but got ${learned}"
+
+	log_test "FDB limits"
+
+	for type_args in "${FDB_TYPES[@]}"; do
+		# This is intentional use of word splitting.
+		# shellcheck disable=SC2086
+		check_limit_one_type $type_args
+	done
+}
+
+trap cleanup EXIT
+
+setup_prepare
+
+tests_run
+
+exit $EXIT_STATUS

-- 
2.42.0

