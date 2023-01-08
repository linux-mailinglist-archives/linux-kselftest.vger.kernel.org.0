Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78066164B
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 16:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjAHPqz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 10:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjAHPqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 10:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A5180
        for <linux-kselftest@vger.kernel.org>; Sun,  8 Jan 2023 07:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673192752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ptAFNsep8HXiPzjvLvKAeNsYgL5tAwOTyUmzT5fDRM=;
        b=io3dq70DBtK/hAhwH/I0y8lfxdl8W2au2uc2rLmyDkqf89laxD7hVCxgWXIPI7FxVTSKUh
        KxTjKEjtPNntIja1wzxH10XnCXW48xLlSngmWRV6TPNtUqL8FrdVW6gNq1siFDehgomAYy
        yyi5ooWwL3ksBXX75YpD5EXQMHDHpus=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-Ane5p1bkPdK8GatcqVPbcA-1; Sun, 08 Jan 2023 10:45:51 -0500
X-MC-Unique: Ane5p1bkPdK8GatcqVPbcA-1
Received: by mail-qk1-f199.google.com with SMTP id bp6-20020a05620a458600b006ffd3762e78so4858528qkb.13
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Jan 2023 07:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ptAFNsep8HXiPzjvLvKAeNsYgL5tAwOTyUmzT5fDRM=;
        b=IjN96Z6GcOP8lNaJnUnoDcDL7FNFMCMO01zlRdUtYidFnttS3qfK80muRP1gywYwPp
         loxVRQRCWu8gJpMDivH0t2rKk7a899j4gMYvKLRvJrq9BwsmhPRj4/6f1+mIBoxMegzl
         610UBt6Y9ZbFO3ttBgxT1MIHFYafQD2jhKlS7JYouEh9PEAKNvRfEERKRKXoHsrNXxxj
         RzjKsPH8INSTF7CJqm4c44He3ZTgDRphnEUNJaNTwzdKo8ildnaDv+luyswrzp8EmdS+
         sXo92AEXZitL6mfBJ8EQtAKdqh2apPbNtHWimI8ZyfCnANhLoO1mEmaG0CGs6CRsL63E
         F1cg==
X-Gm-Message-State: AFqh2kpeO3q25feQL98l2UJ3IcsBH2TnrvaOd74esflJxSJOZCtvDK4Z
        V8pYuQsJIJhVStH/SKB9f3zx+Zu8lo40Tvt2CiUT7TJ3Xx6FKR+hsx2epKxYIRCw5DQf1FpTg9S
        qcaSOq65I13vDscNTLEcgzLyMygYF
X-Received: by 2002:ac8:44b7:0:b0:3a8:2080:3c83 with SMTP id a23-20020ac844b7000000b003a820803c83mr81251223qto.4.1673192750333;
        Sun, 08 Jan 2023 07:45:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8K9N7LoRpQ/4YzJ6vbjqRlP2Fg1jRKW550TELt4V7IZJgqnMhDSkGpIx8RsjVKmaX2FP28w==
X-Received: by 2002:ac8:44b7:0:b0:3a8:2080:3c83 with SMTP id a23-20020ac844b7000000b003a820803c83mr81251209qto.4.1673192750040;
        Sun, 08 Jan 2023 07:45:50 -0800 (PST)
Received: from debian (2a01cb058918ce0098fed9113971adae.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:98fe:d911:3971:adae])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85350000000b003a689a5b177sm3373911qto.8.2023.01.08.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:45:49 -0800 (PST)
Date:   Sun, 8 Jan 2023 16:45:46 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Matthias May <matthias.may@westermo.com>,
        linux-kselftest@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH net 2/3] selftests/net: l2_tos_ttl_inherit.sh: Run tests in
 their own netns.
Message-ID: <76483052cf40e0b0de4ea8dcc71d060a8fed75f8.1673191942.git.gnault@redhat.com>
References: <cover.1673191942.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1673191942.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This selftest currently runs half in the current namespace and half in
a netns of its own. Therefore, the test can fail if the current
namespace is already configured with incompatible parameters (for
example if it already has a veth0 interface).

Adapt the script to put both ends of the veth pair in their own netns.
Now veth0 is created in NS0 instead of the current namespace, while
veth1 is set up in NS1 (instead of the 'testing' netns).

The user visible netns names are randomised to minimise the risk of
conflicts with already existing namespaces. The cleanup() function
doesn't need to remove the virtual interface anymore: deleting NS0 and
NS1 automatically removes the virtual interfaces they contained.

We can remove $ns, which was only used to run ip commands in the
'testing' netns (let's use the builtin "-netns" option instead).
However, we still need a similar functionality as ping and tcpdump
now need to run in NS0. So we now have $RUN_NS0 for that.

Fixes: b690842d12fd ("selftests/net: test l2 tunnel TOS/TTL inheriting")
Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 .../selftests/net/l2_tos_ttl_inherit.sh       | 162 ++++++++++--------
 1 file changed, 93 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/net/l2_tos_ttl_inherit.sh b/tools/testing/selftests/net/l2_tos_ttl_inherit.sh
index e2574b08eabc..cf56680d598f 100755
--- a/tools/testing/selftests/net/l2_tos_ttl_inherit.sh
+++ b/tools/testing/selftests/net/l2_tos_ttl_inherit.sh
@@ -25,6 +25,11 @@ expected_tos="0x00"
 expected_ttl="0"
 failed=false
 
+readonly NS0=$(mktemp -u ns0-XXXXXXXX)
+readonly NS1=$(mktemp -u ns1-XXXXXXXX)
+
+RUN_NS0="ip netns exec ${NS0}"
+
 get_random_tos() {
 	# Get a random hex tos value between 0x00 and 0xfc, a multiple of 4
 	echo "0x$(tr -dc '0-9a-f' < /dev/urandom | head -c 1)\
@@ -61,7 +66,6 @@ setup() {
 	local vlan="$5"
 	local test_tos="0x00"
 	local test_ttl="0"
-	local ns="ip netns exec testing"
 
 	# We don't want a test-tos of 0x00,
 	# because this is the value that we get when no tos is set.
@@ -94,14 +98,15 @@ setup() {
 	printf "│%7s │%6s │%6s │%13s │%13s │%6s │" \
 	"$type" "$outer" "$inner" "$tos" "$ttl" "$vlan"
 
-	# Create 'testing' netns, veth pair and connect main ns with testing ns
-	ip netns add testing
-	ip link add type veth
-	ip link set veth1 netns testing
-	ip link set veth0 up
-	$ns ip link set veth1 up
-	ip addr flush dev veth0
-	$ns ip addr flush dev veth1
+	# Create netns NS0 and NS1 and connect them with a veth pair
+	ip netns add "${NS0}"
+	ip netns add "${NS1}"
+	ip link add name veth0 netns "${NS0}" type veth \
+		peer name veth1 netns "${NS1}"
+	ip -netns "${NS0}" link set dev veth0 up
+	ip -netns "${NS1}" link set dev veth1 up
+	ip -netns "${NS0}" address flush dev veth0
+	ip -netns "${NS1}" address flush dev veth1
 
 	local local_addr1=""
 	local local_addr2=""
@@ -127,51 +132,59 @@ setup() {
 		if [ "$type" = "gre" ]; then
 			type="gretap"
 		fi
-		ip addr add 198.18.0.1/24 dev veth0
-		$ns ip addr add 198.18.0.2/24 dev veth1
-		ip link add name tep0 type $type $local_addr1 remote \
-		198.18.0.2 tos $test_tos ttl $test_ttl $vxlan $geneve
-		$ns ip link add name tep1 type $type $local_addr2 remote \
-		198.18.0.1 tos $test_tos ttl $test_ttl $vxlan $geneve
+		ip -netns "${NS0}" address add 198.18.0.1/24 dev veth0
+		ip -netns "${NS1}" address add 198.18.0.2/24 dev veth1
+		ip -netns "${NS0}" link add name tep0 type $type $local_addr1 \
+			remote 198.18.0.2 tos $test_tos ttl $test_ttl         \
+			$vxlan $geneve
+		ip -netns "${NS1}" link add name tep1 type $type $local_addr2 \
+			remote 198.18.0.1 tos $test_tos ttl $test_ttl         \
+			$vxlan $geneve
 	elif [ "$outer" = "6" ]; then
 		if [ "$type" = "gre" ]; then
 			type="ip6gretap"
 		fi
-		ip addr add fdd1:ced0:5d88:3fce::1/64 dev veth0 nodad
-		$ns ip addr add fdd1:ced0:5d88:3fce::2/64 dev veth1 nodad
-		ip link add name tep0 type $type $local_addr1 \
-		remote fdd1:ced0:5d88:3fce::2 tos $test_tos ttl $test_ttl \
-		$vxlan $geneve
-		$ns ip link add name tep1 type $type $local_addr2 \
-		remote fdd1:ced0:5d88:3fce::1 tos $test_tos ttl $test_ttl \
-		$vxlan $geneve
+		ip -netns "${NS0}" address add fdd1:ced0:5d88:3fce::1/64 \
+			dev veth0 nodad
+		ip -netns "${NS1}" address add fdd1:ced0:5d88:3fce::2/64 \
+			dev veth1 nodad
+		ip -netns "${NS0}" link add name tep0 type $type $local_addr1 \
+			remote fdd1:ced0:5d88:3fce::2 tos $test_tos           \
+			ttl $test_ttl $vxlan $geneve
+		ip -netns "${NS1}" link add name tep1 type $type $local_addr2 \
+			remote fdd1:ced0:5d88:3fce::1 tos $test_tos           \
+			ttl $test_ttl $vxlan $geneve
 	fi
 
 	# Bring L2-tunnel link up and create VLAN on top
-	ip link set tep0 up
-	$ns ip link set tep1 up
-	ip addr flush dev tep0
-	$ns ip addr flush dev tep1
+	ip -netns "${NS0}" link set tep0 up
+	ip -netns "${NS1}" link set tep1 up
+	ip -netns "${NS0}" address flush dev tep0
+	ip -netns "${NS1}" address flush dev tep1
 	local parent
 	if $vlan; then
 		parent="vlan99-"
-		ip link add link tep0 name ${parent}0 type vlan id 99
-		$ns ip link add link tep1 name ${parent}1 type vlan id 99
-		ip link set ${parent}0 up
-		$ns ip link set ${parent}1 up
-		ip addr flush dev ${parent}0
-		$ns ip addr flush dev ${parent}1
+		ip -netns "${NS0}" link add link tep0 name ${parent}0 \
+			type vlan id 99
+		ip -netns "${NS1}" link add link tep1 name ${parent}1 \
+			type vlan id 99
+		ip -netns "${NS0}" link set dev ${parent}0 up
+		ip -netns "${NS1}" link set dev ${parent}1 up
+		ip -netns "${NS0}" address flush dev ${parent}0
+		ip -netns "${NS1}" address flush dev ${parent}1
 	else
 		parent="tep"
 	fi
 
 	# Assign inner IPv4/IPv6 addresses
 	if [ "$inner" = "4" ] || [ "$inner" = "other" ]; then
-		ip addr add 198.19.0.1/24 brd + dev ${parent}0
-		$ns ip addr add 198.19.0.2/24 brd + dev ${parent}1
+		ip -netns "${NS0}" address add 198.19.0.1/24 brd + dev ${parent}0
+		ip -netns "${NS1}" address add 198.19.0.2/24 brd + dev ${parent}1
 	elif [ "$inner" = "6" ]; then
-		ip addr add fdd4:96cf:4eae:443b::1/64 dev ${parent}0 nodad
-		$ns ip addr add fdd4:96cf:4eae:443b::2/64 dev ${parent}1 nodad
+		ip -netns "${NS0}" address add fdd4:96cf:4eae:443b::1/64 \
+			dev ${parent}0 nodad
+		ip -netns "${NS1}" address add fdd4:96cf:4eae:443b::2/64 \
+			dev ${parent}1 nodad
 	fi
 }
 
@@ -192,10 +205,10 @@ verify() {
 		ping_dst="198.19.0.3" # Generates ARPs which are not IPv4/IPv6
 	fi
 	if [ "$tos_ttl" = "inherit" ]; then
-		ping -i 0.1 $ping_dst -Q "$expected_tos" -t "$expected_ttl" \
-		2>/dev/null 1>&2 & ping_pid="$!"
+		${RUN_NS0} ping -i 0.1 $ping_dst -Q "$expected_tos"          \
+			 -t "$expected_ttl" 2>/dev/null 1>&2 & ping_pid="$!"
 	else
-		ping -i 0.1 $ping_dst 2>/dev/null 1>&2 & ping_pid="$!"
+		${RUN_NS0} ping -i 0.1 $ping_dst 2>/dev/null 1>&2 & ping_pid="$!"
 	fi
 	local tunnel_type_offset tunnel_type_proto req_proto_offset req_offset
 	if [ "$type" = "gre" ]; then
@@ -216,10 +229,12 @@ verify() {
 				req_proto_offset="$((req_proto_offset + 4))"
 				req_offset="$((req_offset + 4))"
 			fi
-			out="$(tcpdump --immediate-mode -p -c 1 -v -i veth0 -n \
-			ip[$tunnel_type_offset] = $tunnel_type_proto and \
-			ip[$req_proto_offset] = 0x01 and \
-			ip[$req_offset] = 0x08 2>/dev/null | head -n 1)"
+			out="$(${RUN_NS0} tcpdump --immediate-mode -p -c 1 -v \
+				-i veth0 -n                                   \
+				ip[$tunnel_type_offset] = $tunnel_type_proto and \
+				ip[$req_proto_offset] = 0x01 and              \
+				ip[$req_offset] = 0x08 2>/dev/null            \
+				| head -n 1)"
 		elif [ "$inner" = "6" ]; then
 			req_proto_offset="44"
 			req_offset="78"
@@ -231,10 +246,12 @@ verify() {
 				req_proto_offset="$((req_proto_offset + 4))"
 				req_offset="$((req_offset + 4))"
 			fi
-			out="$(tcpdump --immediate-mode -p -c 1 -v -i veth0 -n \
-			ip[$tunnel_type_offset] = $tunnel_type_proto and \
-			ip[$req_proto_offset] = 0x3a and \
-			ip[$req_offset] = 0x80 2>/dev/null | head -n 1)"
+			out="$(${RUN_NS0} tcpdump --immediate-mode -p -c 1 -v \
+				-i veth0 -n                                   \
+				ip[$tunnel_type_offset] = $tunnel_type_proto and \
+				ip[$req_proto_offset] = 0x3a and              \
+				ip[$req_offset] = 0x80 2>/dev/null            \
+				| head -n 1)"
 		elif [ "$inner" = "other" ]; then
 			req_proto_offset="36"
 			req_offset="45"
@@ -250,11 +267,13 @@ verify() {
 				expected_tos="0x00"
 				expected_ttl="64"
 			fi
-			out="$(tcpdump --immediate-mode -p -c 1 -v -i veth0 -n \
-			ip[$tunnel_type_offset] = $tunnel_type_proto and \
-			ip[$req_proto_offset] = 0x08 and \
-			ip[$((req_proto_offset + 1))] = 0x06 and \
-			ip[$req_offset] = 0x01 2>/dev/null | head -n 1)"
+			out="$(${RUN_NS0} tcpdump --immediate-mode -p -c 1 -v \
+				-i veth0 -n                                   \
+				ip[$tunnel_type_offset] = $tunnel_type_proto and \
+				ip[$req_proto_offset] = 0x08 and              \
+				ip[$((req_proto_offset + 1))] = 0x06 and      \
+				ip[$req_offset] = 0x01 2>/dev/null            \
+				| head -n 1)"
 		fi
 	elif [ "$outer" = "6" ]; then
 		if [ "$type" = "gre" ]; then
@@ -273,10 +292,12 @@ verify() {
 				req_proto_offset="$((req_proto_offset + 4))"
 				req_offset="$((req_offset + 4))"
 			fi
-			out="$(tcpdump --immediate-mode -p -c 1 -v -i veth0 -n \
-			ip6[$tunnel_type_offset] = $tunnel_type_proto and \
-			ip6[$req_proto_offset] = 0x01 and \
-			ip6[$req_offset] = 0x08 2>/dev/null | head -n 1)"
+			out="$(${RUN_NS0} tcpdump --immediate-mode -p -c 1 -v \
+				-i veth0 -n                                   \
+				ip6[$tunnel_type_offset] = $tunnel_type_proto and \
+				ip6[$req_proto_offset] = 0x01 and             \
+				ip6[$req_offset] = 0x08 2>/dev/null           \
+				| head -n 1)"
 		elif [ "$inner" = "6" ]; then
 			local req_proto_offset="72"
 			local req_offset="106"
@@ -288,10 +309,12 @@ verify() {
 				req_proto_offset="$((req_proto_offset + 4))"
 				req_offset="$((req_offset + 4))"
 			fi
-			out="$(tcpdump --immediate-mode -p -c 1 -v -i veth0 -n \
-			ip6[$tunnel_type_offset] = $tunnel_type_proto and \
-			ip6[$req_proto_offset] = 0x3a and \
-			ip6[$req_offset] = 0x80 2>/dev/null | head -n 1)"
+			out="$(${RUN_NS0} tcpdump --immediate-mode -p -c 1 -v \
+				-i veth0 -n                                   \
+				ip6[$tunnel_type_offset] = $tunnel_type_proto and \
+				ip6[$req_proto_offset] = 0x3a and             \
+				ip6[$req_offset] = 0x80 2>/dev/null           \
+				| head -n 1)"
 		elif [ "$inner" = "other" ]; then
 			local req_proto_offset="64"
 			local req_offset="73"
@@ -307,11 +330,13 @@ verify() {
 				expected_tos="0x00"
 				expected_ttl="64"
 			fi
-			out="$(tcpdump --immediate-mode -p -c 1 -v -i veth0 -n \
-			ip6[$tunnel_type_offset] = $tunnel_type_proto and \
-			ip6[$req_proto_offset] = 0x08 and \
-			ip6[$((req_proto_offset + 1))] = 0x06 and \
-			ip6[$req_offset] = 0x01 2>/dev/null | head -n 1)"
+			out="$(${RUN_NS0} tcpdump --immediate-mode -p -c 1 -v \
+				-i veth0 -n                                   \
+				ip6[$tunnel_type_offset] = $tunnel_type_proto and \
+				ip6[$req_proto_offset] = 0x08 and             \
+				ip6[$((req_proto_offset + 1))] = 0x06 and     \
+				ip6[$req_offset] = 0x01 2>/dev/null           \
+				| head -n 1)"
 		fi
 	fi
 	kill -9 $ping_pid
@@ -351,9 +376,8 @@ verify() {
 }
 
 cleanup() {
-	ip link del veth0 2>/dev/null
-	ip netns del testing 2>/dev/null
-	ip link del tep0 2>/dev/null
+	ip netns del "${NS0}" 2>/dev/null
+	ip netns del "${NS1}" 2>/dev/null
 }
 
 printf "┌────────┬───────┬───────┬──────────────┬"
-- 
2.30.2

