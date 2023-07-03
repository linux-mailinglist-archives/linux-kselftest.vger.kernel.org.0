Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5018E746196
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGCRxN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGCRxM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 13:53:12 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A910E49;
        Mon,  3 Jul 2023 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=1385; s=dkim-tub; t=1688406789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbuZxhAorkaMg20j4SIBabc/JGzysoTgj49OGqoJEp0=;
  b=eBMnRwQtN6kq+hxFoYjJAg5O3D95VMqLCLBZqJVUhoUltoglXN7iWOgh
   qPCFqLCOsPEQUYQVbJACmcReSRwNRL4edSwjUBbmOZ6OSrM/spVMPqN7B
   BWKYG85UVFXKTIZX351gWvnCuJo9fDrTHDSJoRh2tQH4RzIJy1q0kd+HR
   c=;
X-IronPort-AV: E=Sophos;i="6.01,178,1684792800"; 
   d="scan'208";a="1387329"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 03 Jul 2023 19:52:05 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 1/2] net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
Date:   Mon, 3 Jul 2023 19:50:45 +0200
Message-ID: <20230703175048.151683-2-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
References: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
socket option SO_TIMESTAMPING_NEW. Setting the option is handled in
sk_setsockopt(), querying it was not handled in sk_getsockopt(), though.

For consistency, implement the missing getsockopt(SO_TIMESTAMPING_NEW).
Similar as with SO_TIMESTAMP_{OLD,NEW}, the active timestamping flags
are only returned when querying the same SO_TIMESTAMPING_{OLD,NEW}
option they were set for. Empty flags are returned with
SO_TIMESTAMPING_{NEW,OLD} otherwise.

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 net/core/sock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9370fd50aa2c..cfb48244ed12 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1710,9 +1710,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = sk->sk_tsflags;
-		v.timestamping.bind_phc = sk->sk_bind_phc;
+		if (optname == (sock_flag(sk, SOCK_TSTAMP_NEW) ?
+					SO_TIMESTAMPING_NEW :
+					SO_TIMESTAMPING_OLD)) {
+			v.timestamping.flags = sk->sk_tsflags;
+			v.timestamping.bind_phc = sk->sk_bind_phc;
+		}
 		break;
 
 	case SO_RCVTIMEO_OLD:
-- 
2.39.2

