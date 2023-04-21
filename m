Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCF6EA688
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDUJGK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjDUJGI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 05:06:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828ED9747
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 02:05:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so1790532b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682067939; x=1684659939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7Gor+HyigWUptAicqNrnUV7OWWzKb4EB5Y/NKnzKDk=;
        b=AqSlwQWUT8L9K4ECbDjaIgqfE+kvnhVu5XBk/orZX4TvYWdP2JMIqo2EAtGtbRxJfC
         Brh4aTcdFPDFq2W87VZ/lyuijo9i1XabaMupybi9TG0KSAY3n8/7qduVme4N96E4yVA2
         Nj+pwpfWHDBHw3cIo8iABR+i1MYBeBXXfmen/MpKf0HlyPiD1h76aosi7w87DCCtHO07
         JKkyfOBfAhgZw3BAHfXERUUWzW977vxcuDbT9EIVdancwvMmEJ1Mx5K/EBtXD0ikYN69
         8bzf4UCap2tn4ZEEB6XaBNOe9DmevejMIJmTB8sVVp86vmMz1a1/4OvloqZ9sY1qBcb+
         8XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067939; x=1684659939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Gor+HyigWUptAicqNrnUV7OWWzKb4EB5Y/NKnzKDk=;
        b=lStEL8oTp0ZPzrV899uK6u3rNbzG1+jfWYf9ZMRj2nG7iK4dX5m/KpMAyxiPNV0Im3
         MXhIzbwBTkUn/5nYFSmWF6Ps9Og3afCq96b930fLmQWvCXaZLskGj/qyeIAE9vVA5Zau
         wgaCalUkxBd2/cXXwUqe7RWXap9qoqgYJM1xVvJns+Jw3R/PYXvHxyIkULL++/q6spAp
         N6EvAD8BBzBMdnmi9RJmupp3p6KdnY3dF8K71jxc1tVsRQMorhvNhNGQ+KBmnJyqZI9Z
         hMjTNOaoYv9YInc9v6nvDOBeouCQjAfewQa7Ehp+Z3HdunYrCBMUMz72JC48273pDhaf
         BvKg==
X-Gm-Message-State: AAQBX9dgg7DEATjBMj51t5clhP7kEbsFGIM/0XDITtFLSDK6evq/Px5A
        O+Ja1xtg90Wfb20EZUv7eA1DiQ==
X-Google-Smtp-Source: AKy350bGh0r2HzVUtnjDAeGQE04dIbA1FwnRRA9ypzIonP3Wg6Gtjp/PUEQ/1HsEFKLZ3Q2UYyU5bQ==
X-Received: by 2002:a05:6a20:42a3:b0:ef:6883:cfc3 with SMTP id o35-20020a056a2042a300b000ef6883cfc3mr5418119pzj.58.1682067939009;
        Fri, 21 Apr 2023 02:05:39 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a950300b0024796ddd19bsm4192309pjo.7.2023.04.21.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:05:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Add bpf_task_under_cgroup() kfunc
Date:   Fri, 21 Apr 2023 17:04:02 +0800
Message-Id: <20230421090403.15515-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230421090403.15515-1-zhoufeng.zf@bytedance.com>
References: <20230421090403.15515-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 kernel/bpf/helpers.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 00e5fb0682ac..88e3247b5c44 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2142,6 +2142,24 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_under_cgroup - Check whether the task is a given subset of the
+ * cgroup2 hierarchy. The cgroup2 to test is assigned by cgrp.
+ * @cgrp: assigned cgrp.
+ * @task: assigned task.
+ */
+__bpf_kfunc int bpf_task_under_cgroup(struct cgroup *cgrp,
+				      struct task_struct *task)
+{
+	if (unlikely(!cgrp))
+		return -EAGAIN;
+
+	if (unlikely(!task))
+		return -ENOENT;
+
+	return task_under_cgroup_hierarchy(task, cgrp);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2341,6 +2359,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
-- 
2.20.1

