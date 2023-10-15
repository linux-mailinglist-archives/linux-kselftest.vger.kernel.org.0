Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9E7C9970
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjJOORm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjJOORi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 10:17:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D475FB
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9b95943beso31283205ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379454; x=1697984254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3e16X3BnACnel0/w/bQT7bK9RdqePAG/1Ajmk33nB0=;
        b=jOjNclAylNWhZ4hB+LFckWl9nZjeAdYIUYBxlpMMjRuXSf70wdqUDw1m3PBBelChkk
         nLQqE4n8aa2ZoFfZ0BjparIqreNrV64Ff8ga//0p9P24HdmueiH3bYlOZh5ZRUTxmr2Q
         Bsj5n/KP4Bxq9SQMLWBtg4QAkrprtUZBMOMUtzk1wBV8jdslEszB6tigt/mgtHUr2vpJ
         JmIC6Jy+LcrAjl7OPP7dUxx0xGOGSWCJLnSZbdocit6jH4QD9KyHFU7VaAenZptOZxaF
         //tXuDZUaogqUgVHPqMaYTdCX1EvdVrD0nkZ8h+qUdchz4L8I16yD4/NSCJ8//WBPnw2
         OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379454; x=1697984254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3e16X3BnACnel0/w/bQT7bK9RdqePAG/1Ajmk33nB0=;
        b=YxWKBcmgTQ4VLFeED4UbdhoGpM69hlnSm11W4MGZfnhyV4T8/cSJ3Eqmya2pOTd63g
         p+FD2Yd4Yl35wsZHEzkKW5JHKa6Zmt3QjGN8h/cFJpOLAgujqQNWYQJ1mxF3Tu0VKJSf
         yNeh7IYqOiSK6iL9ip+vaoWYMrSlnRVawUqesJNnZfhGKAnZgHZp/EgL9IudP4B5bzFb
         dZGzTuuvpMBnSMmsPqRQ/SYIxR9+XONEVR9sXZL03zHRpug/rrySZjdlFKq7ZNMCtP8V
         ZjFfQuLjgqWHV2f1eb4sOHPU1X8m9CDnCMA9ezfH1DrOIBmFO3ppp/coyMGh2iVokd7H
         4S7A==
X-Gm-Message-State: AOJu0Ywjje3J1C93VxTZnNr6t1PFp10aBJanHM5b3Pckg5CNrf88AT16
        wttNxJq7D8EkUIEsb+eikGHkjg==
X-Google-Smtp-Source: AGHT+IGa+4527nTRMoq3BT4pWp6MGz5aJZtlZUNhOW5hIrk1Y1oqpKECZxuWNJqZ5/MeAEwk4c/hSg==
X-Received: by 2002:a17:90b:4ccb:b0:27d:51c4:1679 with SMTP id nd11-20020a17090b4ccb00b0027d51c41679mr4375745pjb.27.1697379454522;
        Sun, 15 Oct 2023 07:17:34 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id ij6-20020a170902ab4600b001c0c79b386esm7058350plb.95.2023.10.15.07.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:34 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Andrew Melnychenko <andrew@daynix.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 3/7] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
Date:   Sun, 15 Oct 2023 23:16:31 +0900
Message-ID: <20231015141644.260646-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This new extension will be used by tun to carry the hash values and
types to report with virtio-net headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/skbuff.h | 10 ++++++++++
 net/core/skbuff.c      |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..1f2e5d350810 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -333,6 +333,13 @@ struct tc_skb_ext {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_TUN)
+struct tun_vnet_hash {
+	u32 value;
+	u16 report;
+};
+#endif
+
 struct sk_buff_head {
 	/* These two members must be first to match sk_buff. */
 	struct_group_tagged(sk_buff_list, list,
@@ -4631,6 +4638,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_TUN)
+	SKB_EXT_TUN_VNET_HASH,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4eaf7ed0d1f4..774c2b26bf25 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4793,6 +4793,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct tun_vnet_hash),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
-- 
2.42.0

