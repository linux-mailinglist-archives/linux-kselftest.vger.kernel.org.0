Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871E6F8E45
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 May 2023 05:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEFDQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 23:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjEFDQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 23:16:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338047AB8
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 20:16:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6438d95f447so1753132b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683342966; x=1685934966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12hdTKRnWgWYBI/c8XKFkpu0HU3jtNl5td2foqM9iPY=;
        b=MzphiRViPhHlc280608eePs8ynETZ2b7P+HwIIxB6+Z/axscsWkRnhL10NE6yugEkM
         caE/rr7mt25gIyCHXJcV6rwlKwuI7CWVHAjuLk4WlRoRFZj1GmmQJztnYFG1uGKKXKFb
         3jOPICfSc48ikntdLzz7FHzwlKmeaN6X3stTiGaWGxU0vK2SYh2qIPmaMMaAivD9oiBh
         4T9Wi0G4OE/g8G6OIOWIMquxnbgv+K9B+D5y70sDbNcQbRCugXELWHK9E11l+yj6tVWY
         5r4UwCf3Z23FAw5nshH11I8Bkgzg4s/LGVhRLbShRHDnDWbjGiW+2N3uTtQ5EgARTdBP
         GLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342966; x=1685934966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12hdTKRnWgWYBI/c8XKFkpu0HU3jtNl5td2foqM9iPY=;
        b=c9vwvf0kqJMK4XTAugNTu8G0GRhGHrIoijld/UXm1WkfgxSzb3TOZtMqpthMQNA/Cq
         DpupREBSJ9A7vD2ntFxtHoHcBJiAIU3QMmzlUe59aNVmNQxnRpGW1PALCe/bXe2ryClF
         F6nuHONXRDuWxCgnYEY4Blg60kh5/xQbMm6YIpFrJemAjrejS5U7L4GMh+Z/KHH1FwGE
         TN56tAkwY1O1M8F7uCf4nwQrOdbLE87Kcogj1k1iwa72LAYJCLym2ETnQc6++cqPRZUG
         245iOUIdT66fmnwkjY0uEW6+RnloCie16dj5SpB5ZxgXAUVPONSLm/q96gwdIPJuoVuC
         lGcA==
X-Gm-Message-State: AC+VfDySnZojrRMQW99BPFH3Q0l4l/bPL825Ynr7NO43MshmDSCXRy9N
        wKhKXXUSsa76n/8AaJVd/maTZA==
X-Google-Smtp-Source: ACHHUZ4Corn9SYGDaNfFKrHwTdh7kiOsEP/Mr3gVK9kadXF5bNntSJBGGkp5HLEkIY4hCqufVory4g==
X-Received: by 2002:a05:6a20:7484:b0:f8:a493:5290 with SMTP id p4-20020a056a20748400b000f8a4935290mr4674612pzd.20.1683342966713;
        Fri, 05 May 2023 20:16:06 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id j1-20020aa783c1000000b0063a1e7d7439sm2256663pfn.69.2023.05.05.20.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 20:16:06 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v7 1/2] bpf: Add bpf_task_under_cgroup() kfunc
Date:   Sat,  6 May 2023 11:15:44 +0800
Message-Id: <20230506031545.35991-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230506031545.35991-1-zhoufeng.zf@bytedance.com>
References: <20230506031545.35991-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add a kfunc that's similar to the bpf_current_task_under_cgroup.
The difference is that it is a designated task.

When hook sched related functions, sometimes it is necessary to
specify a task instead of the current task.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/helpers.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..a128fe0ab2d0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2149,6 +2149,22 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc, test
+ * task's membership of cgroup ancestry.
+ * @task: the task to be tested
+ * @ancestor: possible ancestor of @task's cgroup
+ *
+ * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
+ * It follows all the same rules as cgroup_is_descendant, and only applies
+ * to the default hierarchy.
+ */
+__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
+				       struct cgroup *ancestor)
+{
+	return task_under_cgroup_hierarchy(task, ancestor);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2400,6 +2416,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
-- 
2.20.1

