Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011757D27F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGUR2l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiGUR2W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:22 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15B8AEC5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 10:28:18 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10cf9f5b500so3318572fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6LYDJ5GUZQ1KxKmuQvjM8e+PjJ6MYTVNoyEg+XMI5E=;
        b=F39o6zdL20qsFmVOEom+uZ7fZ1c6R3EBwJRsLcWhmxXYO27c6yuW+TxLtfux5NlgDH
         irmniKptcO3EquVJiLXT4swrivgKEjFsVwhHaOVwvQVf4TU8rP/Px4s8VIliE+DPGanH
         T7MHIVfNsMtTbYomDDw28omIpxiFgcqexK0jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6LYDJ5GUZQ1KxKmuQvjM8e+PjJ6MYTVNoyEg+XMI5E=;
        b=SLuGWmf2BV57hGsYIQcCuKpF4Ww3sbfoTwWpb4r7kqfwvCYEoH7B7aGB9F2UJ5V7HI
         g4bMFmuMlxdOxgpX5J5h7dTtMn6DgGUlzAQaK95MotgEsHUiMDvfD03uoN8FDoGRASPZ
         4t2vf3T1e5DpX2gwg+YypGejsAeC78HiEpXJ0QPoekrA0d/DeGf+PUeGAz3xnjcqjLBV
         2v7dkZQY26p4G0gNodBTdVYjeiMZe8pZy12ObTR+XhsGPqvQwtNhxkpuqRGwym1uAHeY
         oVxcL/beOgkOZt0gqS7ABqxFPHSEJ6gAs9sJ8pTrOaSSZx2IfEdmjniMOi5Iot4lEsvX
         cdYg==
X-Gm-Message-State: AJIora/gYU7pLdXQBbB/v5/Ixk9He8jjMuLokYGSAw0pg5R+/gd89ie+
        S+b9jM30O8PMO+oF9UaCaRiRog==
X-Google-Smtp-Source: AGRyM1uMOCDd3dpPREZw9AxRpt6f809MJwj0HOOSGYMg4yruTLyaIlx1XyM20S/Pw+ozM4Rqwgc/dg==
X-Received: by 2002:a05:6870:b398:b0:10d:67e:c615 with SMTP id w24-20020a056870b39800b0010d067ec615mr5426833oap.203.1658424498275;
        Thu, 21 Jul 2022 10:28:18 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id du24-20020a0568703a1800b00101c83352c6sm1106207oab.34.2022.07.21.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:28:17 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
Date:   Thu, 21 Jul 2022 12:28:06 -0500
Message-Id: <20220721172808.585539-3-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721172808.585539-1-fred@cloudflare.com>
References: <20220721172808.585539-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Users may want to audit calls to security_create_user_ns() and access
user space memory. Also create_user_ns() runs without
pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
for mandatory access control policies.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v2:
- Rename create_user_ns hook to userns_create
Changes since v1:
- None
---
 kernel/bpf/bpf_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c1351df9f7ee..4593437809cc 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -250,6 +250,7 @@ BTF_ID(func, bpf_lsm_task_getsecid_obj)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
+BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
-- 
2.30.2

