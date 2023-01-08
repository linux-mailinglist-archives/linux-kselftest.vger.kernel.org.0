Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1C661649
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjAHPql (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjAHPqk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 10:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79609FD14
        for <linux-kselftest@vger.kernel.org>; Sun,  8 Jan 2023 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673192747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/njgGAVUPtXskzk1vLp20oMLbjhp3j4lH68KrNnwBwM=;
        b=a3MPBrpgvYrkl6d8DVZosiG1s5kGeSfiglquozlpt6lnuEre6jPkM9SXVj2/KiE9Fq2zPq
        ahI514v+SR/OJFJtOJr581AXBSMdntZm26mGtClOCOMgzRRyyXYTc5UKHQIrpxw8TC4BDY
        N7n8/CakdY3uAkH3bbEHBQBY9SNOy4A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-LHR2pKc0PKa88nuHCuLycg-1; Sun, 08 Jan 2023 10:45:46 -0500
X-MC-Unique: LHR2pKc0PKa88nuHCuLycg-1
Received: by mail-qk1-f200.google.com with SMTP id m9-20020a05620a290900b0070596994c7eso4853160qkp.7
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Jan 2023 07:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/njgGAVUPtXskzk1vLp20oMLbjhp3j4lH68KrNnwBwM=;
        b=grKJqGSxhQGO7FABsJMmd88DqEshpEd4QSuZTgkrvZAJ5p0ha3rhEIxCSZKLkGrb4Y
         e3EBkDpYdfNsB0+tLh5tEq+lEbs9jt3oE1QnkJoByuB7ArZl5K50cfSwmGHg6cLB/I77
         lu8C9kmxykZ092TfXKzhc/BxCK1m5aynezNAOiQxTh6df46T6KNT5NwjwKHcUOBQBOt1
         fb+fQC2ahTK2JnXuszELQQvw+LeU5Y+Xkmf6eO+Yaq3dVDe/YkjpS0qY5uerohGK65/j
         Ik9hkh9EmVzgedSr9irwcP9Y+sqPIx/Xu3xUCranP5sI8E/tHa2mCgy0u6PBUrpdT2Kc
         T5Zw==
X-Gm-Message-State: AFqh2kr2XeUorq7Bv6M1POqvC7T4nwCU0kJy3StvWb7ig2xqpJQyi/JF
        0Pjzi53n9lSo6OW2HlA5iLhrL2i6WHeZhpt79/gBpRLjf7wUPZMZIV6xqFeXvLlxCQ0jACErSRW
        w2V9YOxmC4qHe45QEIhAJE5v+S8dd
X-Received: by 2002:a05:622a:4205:b0:3a5:3cb5:2485 with SMTP id cp5-20020a05622a420500b003a53cb52485mr84046992qtb.0.1673192745855;
        Sun, 08 Jan 2023 07:45:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuv3RaKjIAXyDmemvxrKDMHR6xY19k16gFK4eI7Ku+wXBfLOlr7Kg8h3uL3/4j8pVvZ0zSyLA==
X-Received: by 2002:a05:622a:4205:b0:3a5:3cb5:2485 with SMTP id cp5-20020a05622a420500b003a53cb52485mr84046980qtb.0.1673192745636;
        Sun, 08 Jan 2023 07:45:45 -0800 (PST)
Received: from debian (2a01cb058918ce0098fed9113971adae.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:98fe:d911:3971:adae])
        by smtp.gmail.com with ESMTPSA id fz18-20020a05622a5a9200b003a591194221sm3385902qtb.7.2023.01.08.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:45:45 -0800 (PST)
Date:   Sun, 8 Jan 2023 16:45:41 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Matthias May <matthias.may@westermo.com>,
        linux-kselftest@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH net 1/3] selftests/net: l2_tos_ttl_inherit.sh: Set IPv6
 addresses with "nodad".
Message-ID: <1c40c3a46ec30731d45fbc7b33d71e8c711e310a.1673191942.git.gnault@redhat.com>
References: <cover.1673191942.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The ping command can run before DAD completes. In that case, ping may
fail and break the selftest.

We don't need DAD here since we're working on isolated device pairs.

Fixes: b690842d12fd ("selftests/net: test l2 tunnel TOS/TTL inheriting")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/l2_tos_ttl_inherit.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/l2_tos_ttl_inherit.sh b/tools/testing/selftests/net/l2_tos_ttl_inherit.sh
index dca1e6f777a8..e2574b08eabc 100755
--- a/tools/testing/selftests/net/l2_tos_ttl_inherit.sh
+++ b/tools/testing/selftests/net/l2_tos_ttl_inherit.sh
@@ -137,8 +137,8 @@ setup() {
 		if [ "$type" = "gre" ]; then
 			type="ip6gretap"
 		fi
-		ip addr add fdd1:ced0:5d88:3fce::1/64 dev veth0
-		$ns ip addr add fdd1:ced0:5d88:3fce::2/64 dev veth1
+		ip addr add fdd1:ced0:5d88:3fce::1/64 dev veth0 nodad
+		$ns ip addr add fdd1:ced0:5d88:3fce::2/64 dev veth1 nodad
 		ip link add name tep0 type $type $local_addr1 \
 		remote fdd1:ced0:5d88:3fce::2 tos $test_tos ttl $test_ttl \
 		$vxlan $geneve
@@ -170,8 +170,8 @@ setup() {
 		ip addr add 198.19.0.1/24 brd + dev ${parent}0
 		$ns ip addr add 198.19.0.2/24 brd + dev ${parent}1
 	elif [ "$inner" = "6" ]; then
-		ip addr add fdd4:96cf:4eae:443b::1/64 dev ${parent}0
-		$ns ip addr add fdd4:96cf:4eae:443b::2/64 dev ${parent}1
+		ip addr add fdd4:96cf:4eae:443b::1/64 dev ${parent}0 nodad
+		$ns ip addr add fdd4:96cf:4eae:443b::2/64 dev ${parent}1 nodad
 	fi
 }
 
-- 
2.30.2

