Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263CB4F8DD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiDHE7x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 00:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiDHE7u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 00:59:50 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F227CD7
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 21:57:46 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id u3-20020a632343000000b0039cac94652aso3657665pgm.11
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 21:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gNaeesmpk/bm+MvfeH4duevmtiNSegapk87qzryE4Rg=;
        b=VpC1ILFh71v7mqF4BnD526/zj/1F9/XWSKZb9oFAzDRpeFV9yY/r/588MgB3g8zJ6y
         9815ldbxekiYjWVP/6ssWMPIv1e6OOWSYXhPJD5ehrJh2cPyZkAbco6d9GNMUG8lAvY9
         dgzR/DFOkStbhSrRdvZxFaSrP/VvGFLF0vj8sLGDEAsNk4dniKdJXCvpc1jyoH8QkyIS
         7U6YMCqjLB+EJr/Z6ZFDhpBTUOImx4UBG+GjU4uqsmqL9rJOwxWamOcDIMkEfXdfSf8Z
         iNbxoOtRAxHdZOpmu11faMMTfVi93twrruvLp8IpCeBXtSA9DW3R9D6v0ehQCsPE3Eei
         dAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gNaeesmpk/bm+MvfeH4duevmtiNSegapk87qzryE4Rg=;
        b=dicIOBTjfCY6NhZ2wlAN+VkFkNhwczEbAM2x4LaoFgx6pnK2B7Z1/nybY3S+HUDPfz
         d0lIlmwGIpGpRB3e3KOK8ioMl8xRIHnYCUiE706v0PtQmnFBSx5cPAF/CcBcS4Nr7Rk7
         COOF/Q7rtVz2MSPMMLHl7ZAo+GvbsI4Rq7Af6e7zUO9zceOL6cyOa3AZAq2c9ZPlXoBR
         mTUEZUJGqIcKzYtqlRXeXliQVBnnsEdL/D7nGfdeiUuLXwdpmodsgt9v9N8gqD+cKRha
         ZLGpIJNNonmeFdUCqg1r+r/tGB6OKbZSdNDznK2jvDAtwTE86fqtepq5ZvZPr1mIL5fV
         IA1A==
X-Gm-Message-State: AOAM530XcPWqOPR3fp7O0Ra5gOKskD0nN9a1wHgPk6hp7S++wCjFxIJn
        P6BCKgCFXAlzN1c3EBsw9TJ802hwMOQyrefE
X-Google-Smtp-Source: ABdhPJyZ29N+vSD30BVtv+iUBfQdlGsNN2NbT8PHWHlFuN3vXkcsq9aRVlHd3msWZm5B3br+LUtusM05DpEHehps
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:3e82:b0:1c7:2920:7c54 with SMTP
 id rj2-20020a17090b3e8200b001c729207c54mr20048577pjb.2.1649393865785; Thu, 07
 Apr 2022 21:57:45 -0700 (PDT)
Date:   Fri,  8 Apr 2022 04:57:39 +0000
Message-Id: <20220408045743.1432968-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3 0/4] memcg: introduce per-memcg proactive reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series adds a memory.reclaim proactive reclaim interface.
The rationale behind the interface and how it works are in the first
patch.

---

Changes in V3:
- Fix cg_write() (in patch 2) to properly return -1 if open() fails
  and not fail if len == errno.
- Remove debug printf() in patch 3.

Changes in V2:
- Add the interface to root as well.
- Added a selftest.
- Documented the interface as a nested-keyed interface, which makes
  adding optional arguments in the future easier (see doc updates in the
  first patch).
- Modified the commit message to reflect changes and add a timeout
  argument as a suggested possible extension
- Return -EAGAIN if the kernel fails to reclaim the full requested
  amount.

---

Shakeel Butt (1):
  memcg: introduce per-memcg reclaim interface

Yosry Ahmed (3):
  selftests: cgroup: return the errno of write() in cg_write() on
    failure
  selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
  selftests: cgroup: add a selftest for memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst       | 21 +++++
 mm/memcontrol.c                               | 37 ++++++++
 tools/testing/selftests/cgroup/cgroup_util.c  | 32 ++++---
 .../selftests/cgroup/test_memcontrol.c        | 93 ++++++++++++++++++-
 4 files changed, 166 insertions(+), 17 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

