Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05CF7DBF3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjJ3Rle (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjJ3Rld (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 13:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866EBD
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698687648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=I2JHh73zIxCYXhkBKGYhrEXftWXIPybkxG0xOR3on7I=;
        b=JVDG+3FIRekzkNPYmZZiPWy+bQr97R1oxI2i+2gak8nUEalnFGvmnst/HqooTRCn4/wCxG
        Uc7/WOzhB2LtmyLzf+bLpXlELrUT0iAZ2a5i28tyvnYnoQEzVOb8P7OOI+InNIWZeXxBTR
        GEgTLzcCW24VuZo0+LcAPGCIGzcH0xE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-v0sxq-xTM7WfvCGIiVSQ-A-1; Mon, 30 Oct 2023 13:40:42 -0400
X-MC-Unique: v0sxq-xTM7WfvCGIiVSQ-A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7788f0f099fso601357185a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 10:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687641; x=1699292441;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2JHh73zIxCYXhkBKGYhrEXftWXIPybkxG0xOR3on7I=;
        b=rWJeYX6F53Z1Jkn3kTWiNHFV5wEIZjT+FnO9CO8rNyJWcBu4csCzsL/5thq6UCr/aG
         qkfhXrwHf+OTD9hK6mqwtbROV6nyQRTliy0QPijj7VJG71tQlcScgrsYKtFKbAVbL9QO
         gJcrpbs9n8kdVQNW4wVGC2O0z/UD20mBnDew4P/L/Xx3EL3xFFFio7sb273V8Mokp4VA
         cego3S3EMnJrMwqHeqsDLpcwItMt3kOGVSGdYCzmkffJG0u6IO+2K+sRwf44le0fjy4M
         i+1/BHfEtBDKiJPmWNM4YmLx1nHUkP3sEtomjNauiNN4grEL5xPxTgeZYwGjeAHhMdPk
         +KsQ==
X-Gm-Message-State: AOJu0Yxc/IDIjXpGF5SMOlrOMrLlXmjd+Lbgd0QBcMZknbCXTb03VPF0
        eejfEV9TOpkgQv9TS4WlnOEyfa6vBDz/JokIvnCj8Handoc/thUY6GI6lhU+xjWu3wWs7Maqj4o
        jvd7fVJXbg1cqoXSsOhg4dYCYmXPoXYIiX5DvwuE=
X-Received: by 2002:a05:620a:2589:b0:778:94cc:723 with SMTP id x9-20020a05620a258900b0077894cc0723mr12430098qko.1.1698687641243;
        Mon, 30 Oct 2023 10:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoqut/KAS12Hj1elfEzt5W6duWsTX0hSRvTSrWXOatBJSSICCKoO+CiCrF5FveWevaaikHtA==
X-Received: by 2002:a05:620a:2589:b0:778:94cc:723 with SMTP id x9-20020a05620a258900b0077894cc0723mr12430079qko.1.1698687640998;
        Mon, 30 Oct 2023 10:40:40 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id w7-20020a05620a094700b007742c6823a3sm3501927qkw.108.2023.10.30.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:40:40 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:40:39 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sockets used by udpgso_bench_tx aren't always ready when
udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
kernels, but can occur in both. Replace the hacky sleep calls with a
function that checks whether the ports in the namespace are ready for
use.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp/

Changelog v2: 
- applied synchronization method suggested by Pablo
- changed commit message to code 

 tools/testing/selftests/net/udpgro.sh         | 27 ++++++++++++++-----
 tools/testing/selftests/net/udpgro_bench.sh   | 19 +++++++++++--
 tools/testing/selftests/net/udpgro_frglist.sh | 19 +++++++++++--
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..04792a315729 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -24,6 +24,22 @@ cleanup() {
 }
 trap cleanup EXIT
 
+wait_local_port_listen()
+{
+	local port="${1}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
 cfg_veth() {
 	ip netns add "${PEER_NS}"
 	ip -netns "${PEER_NS}" link set lo up
@@ -51,8 +67,7 @@ run_one() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
@@ -97,7 +112,7 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
@@ -118,11 +133,9 @@ run_one_2sock() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 12345
 	./udpgso_bench_tx ${tx_args} -p 12345
-	sleep 0.1
-	# first UDP GSO socket should be closed at this point
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 894972877e8b..91833518e80b 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -16,6 +16,22 @@ cleanup() {
 }
 trap cleanup EXIT
 
+wait_local_port_listen()
+{
+	local port="${1}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
 run_one() {
 	# use 'rx' as separator between sender args and receiver args
 	local -r all="$@"
@@ -40,8 +56,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 0a6359bed0b9..0aa2068f122c 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -16,6 +16,22 @@ cleanup() {
 }
 trap cleanup EXIT
 
+wait_local_port_listen()
+{
+	local port="${1}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
 run_one() {
 	# use 'rx' as separator between sender args and receiver args
 	local -r all="$@"
@@ -45,8 +61,7 @@ run_one() {
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 }
 
-- 
2.41.0

