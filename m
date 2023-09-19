Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0485B7A6284
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjISMRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 08:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjISMR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 08:17:27 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A6CF1;
        Tue, 19 Sep 2023 05:16:36 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 19 Sep 2023 14:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1695125793; bh=jgojT0/qkebdX/NC1gyN3feF5ayFu9EmWsCehwSIYls=;
        h=From:Date:Subject:To:Cc:From;
        b=haFjko9n28nV72CXQgz81q6PwmeRhDS8I9cFSTA81OttFj+baVhE+vsARmXSz7QAe
         bhgTCHfOvNxywxQdwpGVsS7FqtXzdOf9Oq7pqNgbwMk9QeEeZaxOHX+HuO9Ru54s93
         uqujaj8wnO58x1wUf7H3tI6X3mL62u0znAZjVbSE=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id BBE0981FF3;
        Tue, 19 Sep 2023 14:16:33 +0200 (CEST)
From:   Johannes Nixdorf <jnixdorf-oss@avm.de>
Date:   Tue, 19 Sep 2023 10:08:13 +0200
Subject: [RFC PATCH iproute2-next v4] iplink: bridge: Add sup20230919-fdb_limit-v4-0-1a2a59694d67@avm.der
 bridge FDB learning limits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-fdb_limit-v4-1-b4d2dc4df30f@avm.de>
X-B4-Tracking: v=1; b=H4sIAOxWCWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyT20230919-fdb_limit-v4-0-1a2a59694d67@avm.deE
 vPSU3UzU4B8JSMDI2MDSwNT3bSUpPiczNzMEt3E5FRDEzPzZLNECxMloPqCotS0zAqwWdFKmQV
 F+aUlqUa6eakVJSDZIDdnpdjaWgAVJ3dscQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695110892;20230919-fdb_limit-v4-0-1a2a59694d67@avm.de;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=x8E7QgYAbZ3xfWXTk6mu0Nx+hGD/dY7CVIChh66zl7M=;
 b=AaFY/zE3nQ6DpF2PqqmH4gHuw/8M41ZtXy/U9Q23gG+yh0+8wDsku9PtzLqfdERVvW92sDEBB
 lu5YL52t7CYDDtR1qxAbiXtDqpkTBQIKpq7exbeQ8vzw7XR20230919-fdb_limit-v4-0-1a2a59694d67@avm.deL
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
X-purgate-ID: 149429::1695125793-5CE17D5A-53E64937/0/0
X-purgate-type: clean
X-purgate-size: 5244
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support setting the FDB limit through ip link. The arguments is:
 - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
                    number of learned FDB entries, with 0 disabling
                    the limit.

Also support reading back the current number of learned FDB entries in
the bridge by this count. The returned value's name is:
 - fdb_n_learned: A 32-bit unsigned integer specifying the current number
                  of learned FDB entries.

Example:

 # ip -d -j -p link show br0
[ {
...
        "linkinfo": {
            "info_kind": "bridge",
            "info_data": {
...
                "fdb_n_learned": 2,
                "fdb_max_learned": 0,
...
            }
        },
...
    } ]
 # ip link set br0 type bridge fdb_max_learned 1024
 # ip -d -j -p link show br0
[ {
...
        "linkinfo": {
            "info_kind": "bridge",
            "info_data": {
...
                "fdb_n_learned": 2,
                "fdb_max_learned": 1024,
...
            }
        },
...
    } ]

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
I will resend this mail as non-rfc after the kernel UAPI changes landed.

Link to the kernel changes: https://lore.kernel.org/netdev/20230919-fdb_limit-v4-0-39f0293807b8@avm.de/
---
Changes in v4:
 - Removed _entries from the names. (from review)
 - Removed the UAPI change, to be synced from linux separately by the
   maintainer. (from review)
   For local testing e.g. `make CCOPTS="-O2 -pipe
   -I${path_to_dev_kernel_headers}"` works as a workaround.
 - Downgraded to an RFC until the kernel changes land.
 - Link to v3: https://lore.kernel.org/netdev/20230905-fdb_limit-v3-1-34bb124556d8@avm.de/

Changes in v3:
 - Properly split the net-next and iproute2-next threads. (from review)
 - Changed to *_n_* instead of *_cur_*. (from review)
 - Use strcmp() instead of matches(). (from review)
 - Made names in code and documentation consistent. (from review)
 - Various documentation fixes. (from review)
 - Link to v2: https://lore.kernel.org/netdev/20230619071444.14625-1-jnixdorf-oss@avm.de/

Changes in v2:
 - Sent out the first corresponding iproute2 patches.
 - Link to v1: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/
---
 ip/iplink_bridge.c    | 21 +++++++++++++++++++++
 man/man8/ip-link.8.in | 10 ++++++++++
 2 files changed, 31 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 462075295308..6b70ffbb6f5f 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -34,6 +34,7 @@ static void print_explain(FILE *f)
 		"		  [ group_fwd_mask MASK ]\n"
 		"		  [ group_address ADDRESS ]\n"
 		"		  [ no_linklocal_learn NO_LINKLOCAL_LEARN ]\n"
+		"		  [ fdb_max_learned FDB_MAX_LEARNED ]\n"
 		"		  [ vlan_filtering VLAN_FILTERING ]\n"
 		"		  [ vlan_protocol VLAN_PROTOCOL ]\n"
 		"		  [ vlan_default_pvid VLAN_DEFAULT_PVID ]\n"
@@ -168,6 +169,14 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				bm.optval |= no_ll_learn_bit;
 			else
 				bm.optval &= ~no_ll_learn_bit;
+		} else if (strcmp(*argv, "fdb_max_learned") == 0) {
+			__u32 fdb_max_learned;
+
+			NEXT_ARG();
+			if (get_u32(&fdb_max_learned, *argv, 0))
+				invarg("invalid fdb_max_learned", *argv);
+
+			addattr32(n, 1024, IFLA_BR_FDB_MAX_LEARNED, fdb_max_learned);
 		} else if (matches(*argv, "fdb_flush") == 0) {
 			addattr(n, 1024, IFLA_BR_FDB_FLUSH);
 		} else if (matches(*argv, "vlan_default_pvid") == 0) {
@@ -544,6 +553,18 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BR_GC_TIMER])
 		_bridge_print_timer(f, "gc_timer", tb[IFLA_BR_GC_TIMER]);
 
+	if (tb[IFLA_BR_FDB_N_LEARNED])
+		print_uint(PRINT_ANY,
+			   "fdb_n_learned",
+			   "fdb_n_learned %u ",
+			   rta_getattr_u32(tb[IFLA_BR_FDB_N_LEARNED]));
+
+	if (tb[IFLA_BR_FDB_MAX_LEARNED])
+		print_uint(PRINT_ANY,
+			   "fdb_max_learned",
+			   "fdb_max_learned %u ",
+			   rta_getattr_u32(tb[IFLA_BR_FDB_MAX_LEARNED]));
+
 	if (tb[IFLA_BR_VLAN_DEFAULT_PVID])
 		print_uint(PRINT_ANY,
 			   "vlan_default_pvid",
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 7365d0c6b14f..e82b2dbb0070 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1630,6 +1630,8 @@ the following additional arguments are supported:
 ] [
 .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
 ] [
+.BI fdb_max_learned " FDB_MAX_LEARNED "
+] [
 .BI vlan_filtering " VLAN_FILTERING "
 ] [
 .BI vlan_protocol " VLAN_PROTOCOL "
@@ -1741,6 +1743,14 @@ or off
 When disabled, the bridge will not learn from link-local frames (default:
 enabled).
 
+.BI fdb_max_learned " FDB_MAX_LEARNED "
+- set the maximum number of learned FDB entries. If
+.RI ( FDB_MAX_LEARNED " == 0) "
+the feature is disabled. Default is
+.BR 0 .
+.I FDB_MAX_LEARNED
+is a 32bit unsigned integer.
+
 .BI vlan_filtering " VLAN_FILTERING "
 - turn VLAN filtering on
 .RI ( VLAN_FILTERING " > 0) "

---
base-commit: c31fd80a2268c0b1b77e1d65827003a2327315b8
change-id: 20230905-fdb_limit-ace1467c6a84

Best regards,
-- 
Johannes Nixdorf <jnixdorf-oss@avm.de>

