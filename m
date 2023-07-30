Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FC768522
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjG3LuO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjG3LuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 07:50:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3C10C8;
        Sun, 30 Jul 2023 04:50:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686ed1d2594so3530685b3a.2;
        Sun, 30 Jul 2023 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690717812; x=1691322612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHtQADxWGfF7hnz/vUvRDC9nByJ/dzs4+97gI1+O1CE=;
        b=gCzPYiH4mX814sxszirQr4PUNl5yEgo+oIa4ETrHS7M6DNGAwjdBRu0aZ9ehkAWOXd
         /TS66FABEb9zf5+VQCtBFbMgOrPqZyCGZITlb+By7RCR+8kfhp0kcMyJigvSLZeUjF6+
         eLgvmzOUBP+pKMZH9i7pW1rHn9at5+tqWGgoUlNnJaMRPe6LdIohjnIXqk6FwmhO7cEn
         thG21pJbwJCItYo4/0iZBi88I5nHhVs1psUyOQSWNToyBgcl4xhTnMnpMOVKu8GExS/U
         4LWIBxXGUEwloZ53axUNNPrGtnIGNeSlnivMX7VJoOn78zhFH9U7ud99pPEUQ7HY+I2v
         XWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690717812; x=1691322612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHtQADxWGfF7hnz/vUvRDC9nByJ/dzs4+97gI1+O1CE=;
        b=Mu59LBa286gYkUZHKrNEM+BXRwJb1IGWKHUpo/uo/MtjcjsnX/eZRZJx/ORD8BX6Qq
         lupf6EL2O0QQfTw3P0ImYmqeOxLkbh1kIELvBlNWILRZDYP2ng2fm79WTF+4+kkq8Fva
         T4SqhfzLyMgWx2PPtxiB+gpCySy/EmlzfebKnlwuForhH5KRrGba5IDB8KjQPwqoaue7
         gg/wGOOQhLg+WgJI9IZ+D38fbtckzk7C6/xLnv2ex0jt5EP5ZwOh4JFqEDNcaFmZ9Sg7
         Z6jx1M0Nv1nW/PK0UVCjnZuh9jY7b7xetyLN2rvQrMdvUF12pxEbmIIZGmIw1vZ+3lKw
         3Tdg==
X-Gm-Message-State: ABy/qLarAmO2WbKHodASTBk8zglWU4a9jfRs9L2eTlz0PWDa9xJ017fN
        FOpNizn8/m3QLJk4lHXBZYw=
X-Google-Smtp-Source: APBJJlGPHjjo5RX6BHZWkFHJmiAf/THxXCJnVSzcWV9NP0QZu5/is50PyqtWJquRVC06u6Uby6kk+Q==
X-Received: by 2002:a05:6a00:14c5:b0:67e:45ab:b86b with SMTP id w5-20020a056a0014c500b0067e45abb86bmr9272804pfu.28.1690717812507;
        Sun, 30 Jul 2023 04:50:12 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id z9-20020aa791c9000000b00640dbbd7830sm6044479pfa.18.2023.07.30.04.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 04:50:12 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org, hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date:   Sun, 30 Jul 2023 19:49:50 +0800
Message-ID: <20230730114951.74067-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730114951.74067-1-hffilwlqm@gmail.com>
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
index 8e7d0cb540cdb..49bed890f807e 100644
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
@@ -9472,6 +9473,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct bpf_link_primer link_primer;
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
+	struct netlink_ext_ack extack;
 	int err, fd;
 
 	rtnl_lock();
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

