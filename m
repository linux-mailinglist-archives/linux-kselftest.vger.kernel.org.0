Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A57DE7CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 22:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjKAV67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbjKAV64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 17:58:56 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72C123;
        Wed,  1 Nov 2023 14:58:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A09A332009F2;
        Wed,  1 Nov 2023 17:58:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 17:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698875928; x=
        1698962328; bh=eqg8kBzUlhFAqzjLUQUYk852zJUL1hnwyHqIYJEQJ4I=; b=t
        HW7gfuxZt2IpsigFNSAGtFkaGWlkD254uWlaLOiW9/LOiVGNzNiW+cW6Rqm52OwX
        dq8xsC8bg20X7xsd9O03oaw7JmiIwJo9+b2DQypjhW9imeI1q+A0/jaSd6+8o2Hl
        x+0DbvAUDSMySwNc3qxFG1xRldECa3OQmZJoAVYq1XW3DE8glYgsJJ/kidLaexGj
        +k6DYT2p2FQGSN4YoDzqM5W52iNKRVpMxYpx1igNjEBX/61+5TIi96E/vIUhzrxS
        BdsrgX2ohDcdXa6jVlZBheHzvHByMmt8RPsco8gSpiXVOzpJc0UzaxzxxB8mPE9+
        JOV5+Iw++UVRqbD2htMDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875928; x=
        1698962328; bh=eqg8kBzUlhFAqzjLUQUYk852zJUL1hnwyHqIYJEQJ4I=; b=b
        QlYJBO5IjDycz76FiSSPN46yeluUZXirjwykHwIei3GYGDCpQHD1tr3DMutw6Zpi
        eTPBPasqlntUVzSuRapk6Dbb1oMiLMV7mSwjgzgB8tbm0GWDhr/V8ZhmRb7mjKKC
        fDxDnwSB8XI1B3jgRL82diEEP1Pd3iimjCHQjAyIeRGepEinE15tnLykKTUX8Inl
        ExdGu6twDEdBn38DqUWU72zzx0bqswN4iN0faSmwbKhQKD9Zk06QxgpYtmdfBlEB
        1kIoxNeevT42a3bm2PRGxWy7YVV1YssaHoavl2FckOEM9turNE5+CYcAzFu6bhZH
        ROMjTtlElJpf1esv/3ejQ==
X-ME-Sender: <xms:F8pCZWOL-cz7GJ6vkEsU7uEmrHnaq7pa38Fc3B7B17CMu72_pMwe6g>
    <xme:F8pCZU9ntRqBLFRX_E_lDkP8dEDntvtm3CO-gpStlYNIQ9N_YgbC-6C6Nm4zhgRGL
    31W_f29S-sWxn_amQ>
X-ME-Received: <xmr:F8pCZdROQhAVeYcJthGBiY6qWnYSTjrmiI6aT_S2WWbUHPF1ZJku5MX8JCAsG2cgf_1IFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:F8pCZWt0YUfeWpllCrmsnZMsYmFLAqkL1aHp09_AYT5PFAYGQ_Drdg>
    <xmx:F8pCZed3_kuyq2Qmw8yqhflB5wX0SuHfI02oXbB0Y1HhMjPunA_DZA>
    <xmx:F8pCZa0z7VZosbwHiSzspzecnz57vn9hOEfVJ9N2-WrhFmEG9UruyQ>
    <xmx:GMpCZVBx8EsaPpap6Z1jwQSR8zg_D9As6GJtblpArl_KT3qIFmOhfw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:45 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, shuah@kernel.org, ast@kernel.org,
        andrii@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 4/7] bpf: selftests: test_tunnel: Mount bpffs if necessary
Date:   Wed,  1 Nov 2023 14:57:48 -0700
Message-ID: <b80767f488fb8fe27859200741d1096400b95588.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, if bpffs was not already mounted, then the test suite would
fail during object file pinning steps. Fix by mounting bpffs if
necessary.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 85ba39992461..dd3c79129e87 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -46,7 +46,8 @@
 # 6) Forward the packet to the overlay tnl dev
 
 BPF_FILE="test_tunnel_kern.bpf.o"
-BPF_PIN_TUNNEL_DIR="/sys/fs/bpf/tc/tunnel"
+BPF_FS="/sys/fs/bpf"
+BPF_PIN_TUNNEL_DIR="${BPF_FS}/tc/tunnel"
 PING_ARG="-c 3 -w 10 -q"
 ret=0
 GREEN='\033[0;92m'
@@ -668,10 +669,20 @@ check_err()
 	fi
 }
 
+mount_bpffs()
+{
+	if ! mount | grep "bpf on /sys/fs/bpf" &>/dev/null; then
+		mount -t bpf bpf "$BPF_FS"
+	fi
+}
+
 bpf_tunnel_test()
 {
 	local errors=0
 
+	echo "Mounting bpffs..."
+	mount_bpffs
+
 	echo "Testing GRE tunnel..."
 	test_gre
 	errors=$(( $errors + $? ))
-- 
2.42.0

