Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B63759629
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGSNFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGSNFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:05:23 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D21986;
        Wed, 19 Jul 2023 06:05:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DBE45C0145;
        Wed, 19 Jul 2023 09:05:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Jul 2023 09:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689771920; x=1689858320; bh=siYFJLdfTwI4H
        sjetwx60OIcBExO9uyJZ22N85nYicM=; b=EyhLIFk3QZGbzPk9a/2CsQl+bWSkx
        +rf5EUc8oHC0kqo0iPXtwSKCKWvopRnD27quu1ojrRkVJv1XSyKruCCxu3TSv+ht
        7Z3ndflYqWdO44tQ980vujHnyzGeWRPUdpuf0t9ObDGPw6hFLCcggxfHD9RetcN4
        f2WQXNEzdp271oELA8NQiRmaZwZoY++Uz+rx5Rgsd0mwG5A7UZSNFNgnYZIRHTQ5
        Sz35NUnbdyD/RvEbWGVceo48O18exJU8GVBX1l6f7mtRA37P1cG13Ci/mn6KheRJ
        051ysczjv8Ys4qqn1zXplhEqwXdcF0Wu9iVSOWeul1LeNkSHCn8sX1sYg==
X-ME-Sender: <xms:j9-3ZNol6LZ1AYQFwnmQr-_3o5RzhuXTA1m3NG2JHEsFpvRyvlML_w>
    <xme:j9-3ZPoVyKtWmj9PnPftQFg3T2WxqnqjJQNNVQiUnQYlF4BYeZiMwC2gSTnw_fKVN
    C9KGd8WCVT2meU>
X-ME-Received: <xmr:j9-3ZKNPyO1HwPVDGQ6fXhe6sbWu0Wsq04i0JwStWFfSOWKqCgcqMG8b9Gb-_UjIienSVo3Djq0CmxhVAuhx_5i4jUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffueevhffhuddvjeetfeeuudfgheegledvveehheeuueduvdehgedtteefheeg
    feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:j9-3ZI7G_T6zgOtN5gnwqWiNxm7BR64f7vD-vRtmxQ-96PIFABP9yQ>
    <xmx:j9-3ZM7inD1TaP-hmWsrEe4mopWmlTLXuiDgzTswPWe9q5HblZf0fA>
    <xmx:j9-3ZAhCYGqYDtQejFEUaftUnw7Ncx8MJGredtEjSe92CATxeffnRw>
    <xmx:kN-3ZNGmaU8pcdpgjOlvZB83Baf1W4j3hZTcSPXdZfifgfmhtbSdfQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 09:05:18 -0400 (EDT)
Date:   Wed, 19 Jul 2023 16:05:16 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] selftests: net/forwarding/bridge_mdb.sh: 'Command
 "replace" is unknown, try "bridge mdb help"'
Message-ID: <ZLffjNMaJZiGJytj@shredder>
References: <6b04b2ba-2372-6f6b-3ac8-b7cba1cfae83@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b04b2ba-2372-6f6b-3ac8-b7cba1cfae83@alu.unizg.hr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 09:02:31PM +0200, Mirsad Todorovac wrote:
> Command "replace" is unknown, try "bridge mdb help".

You are running the test with an old iproute2 that doesn't support the
replace command. The following patches [1][2] skip the tests in this
case. However, you will get better test coverage with iproute2-next [3]
compared to the version shipped with your distribution.

[1]
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index ae3f9462a2b6..a1bd4900acb6 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1206,6 +1206,12 @@ ctrl_test()
        ctrl_mldv2_is_in_test
 }
 
+bridge mdb help 2>&1 | grep -q "replace"
+if [ $? -ne 0 ]; then
+       echo "SKIP: iproute2 too old, missing bridge mdb replace support"
+       exit $ksft_skip
+fi
+
 trap cleanup EXIT
 
 setup_prepare

[2]
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index ae255b662ba3..a1c4aec4cbb1 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -1328,6 +1328,12 @@ test_8021qvs()
        switch_destroy
 }
 
+bridge link help 2>&1 | grep -q "mcast_max_groups"
+if [ $? -ne 0 ]; then
+       echo "SKIP: iproute2 too old, missing bridge \"mcast_max_groups\" support"
+       exit $ksft_skip
+fi
+
 trap cleanup EXIT
 
 setup_prepare

[3] https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
