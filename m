Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BA76B759
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjHAO0q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 10:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjHAO0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 10:26:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B03A1BE3;
        Tue,  1 Aug 2023 07:26:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbc06f830aso37668425ad.0;
        Tue, 01 Aug 2023 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900003; x=1691504803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnJPtOd/tAS5bP3jRwz3JALotAns59ZHUtYU5AlNpuM=;
        b=ZGnzrX3ZoaH1ZZ13QRn9qI9/shQl5o5X2gXoWyFcjRzSbo95oytz3zedS8/SDcx8nE
         bEbhWiLcEKLB4ZSN11/tiQBkFbmGJNph6W5PUPkT77hv2MXpr0h8sW0sO9ynq8W3SptX
         tDTmloy/O+QwnEKnwIFXgfdw/4cHPmuEZiAxbX6b6ew5gOyhKTIIbMUNXGT1m44pTUHt
         UMfUymD0DZWmG7PpHZkZoRJsqIeRx0hjCxlRyIr2KwbX/f7YY8Ixhu9U9YxYyXNYTle/
         1+cCGU4ZR0mNPJFirVev4OSI/OFrFX7zLb6MlRZWd0jS0l1+Hxft8mVmCnDlWWk9zJIT
         nwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900003; x=1691504803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnJPtOd/tAS5bP3jRwz3JALotAns59ZHUtYU5AlNpuM=;
        b=f4qICekWnbBhsfNsLer6ANIVa8bGcyRMIHBmI2JqtsiAEN1O6zfH+S6f0n3f0Z9vq9
         ohSqCit6OkasY7wcyhe7M9s64g/LV4/L+fTYKmva+OcL04jbiO0+LpBN4zMYpx+HnSTF
         0+wYKCy/Jt19yhlVtCPBaGpi7G7nK7oNpmLqToIAgcQxMoxmPodXHeW0dWicSBWHYA3r
         +T1jeD2CoGJGagOnY2xc4QlKsh/7sezROOf+Lf1ytuaccNpzWxA3A7LXjvUz6N+PBJv4
         zqkAIcygqovt5k2ZV8ZJmhHV6Y1sQPiVutsNivJpIP8fU9M1S7K1DZ+gkqT7Z/5c5Fbe
         6S6w==
X-Gm-Message-State: ABy/qLZeOpgOrz2ewCMfd5wpxBMA96EnFrqUGTdJ+KVmsmIJwaLJkhU/
        l+d0e2lRuioNOIgMTBWLfOA60g2s8H8XCiqz
X-Google-Smtp-Source: APBJJlGp0T3bwxu11JjeJvAP/G84kaAZx5TRCf188WmCYmtolQxWAT/yq+sNvIt6U96wH4E0P87MQw==
X-Received: by 2002:a17:902:ce8d:b0:1b6:6a14:3734 with SMTP id f13-20020a170902ce8d00b001b66a143734mr18267314plg.29.1690900003056;
        Tue, 01 Aug 2023 07:26:43 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001b8a00d4f7asm10565100pli.9.2023.08.01.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:26:42 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hawk@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mykolal@fb.com, shuah@kernel.org, hffilwlqm@gmail.com,
        tangyeechou@gmail.com, kernel-patches-bot@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date:   Tue,  1 Aug 2023 22:26:20 +0800
Message-ID: <20230801142621.7925-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801142621.7925-1-hffilwlqm@gmail.com>
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When error happens in dev_xdp_attach(), it should have a way to tell
users the error message like the netlink approach.

To avoid breaking uapi, adding a tracepoint in bpf_xdp_link_attach() is
an appropriate way to notify users the error message.

Hence, bpf libraries are able to retrieve the error message by this
tracepoint, and then report the error message to users.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/trace/events/xdp.h | 17 +++++++++++++++++
 net/core/dev.c             |  5 ++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index c40fc97f94171..cd89f1d5ce7b8 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -404,6 +404,23 @@ TRACE_EVENT(mem_return_failed,
 	)
 );
 
+TRACE_EVENT(bpf_xdp_link_attach_failed,
+
+	TP_PROTO(const char *msg),
+
+	TP_ARGS(msg),
+
+	TP_STRUCT__entry(
+		__string(msg, msg)
+	),
+
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+
+	TP_printk("errmsg=%s", __get_str(msg))
+);
+
 #endif /* _TRACE_XDP_H */
 
 #include <trace/define_trace.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 8e7d0cb540cdb..002fec07de739 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -133,6 +133,7 @@
 #include <trace/events/net.h>
 #include <trace/events/skb.h>
 #include <trace/events/qdisc.h>
+#include <trace/events/xdp.h>
 #include <linux/inetdevice.h>
 #include <linux/cpu_rmap.h>
 #include <linux/static_key.h>
@@ -9470,6 +9471,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
+	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
 	int err, fd;
@@ -9497,12 +9499,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	err = dev_xdp_attach_link(dev, NULL, link);
+	err = dev_xdp_attach_link(dev, &extack, link);
 	rtnl_unlock();
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
+		trace_bpf_xdp_link_attach_failed(extack._msg);
 		goto out_put_dev;
 	}
 
-- 
2.41.0

