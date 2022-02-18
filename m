Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5DE4BB3AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 08:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiBRH6N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 02:58:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiBRH6L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 02:58:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B90615DB30
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:57:55 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z28-20020aa79f9c000000b004e10449d919so1288248pfr.4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pzssXhX8riGRjAd4+3metqANF5chmN7DhU3KIG19plk=;
        b=BXYHGO/apr1trZ7ANJF1Lt6pYKglG4Ybyk1oIZRHZKKVSqoKSXgrBXlJ+1OM+32L9t
         MU8n7K+r76s0oXflCxISCV1ICc0UvMWkHQwSTytgu8Evx0a2e982roAPsTJGWM6fb62G
         4xiTSYukPeiMTehnCZ8Ef6urhW9UdAhyCH8qBQH/Z3umLv0xdGv2JPdSLHgNuZnc3YDQ
         m26WTBm81XDNmFpY/glb5MBqUkdfdOBU4PUPqt6iZ2jAhWr3J7itrrkNCi44IwFV8KeU
         S94sCD0t8mfXDphKvuDMvw2otQeqJUpd7l5aT+oeKWADzDv5u6Czmms69AvfX5QGDeUK
         NAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pzssXhX8riGRjAd4+3metqANF5chmN7DhU3KIG19plk=;
        b=FuGpf9IsoqFwI6GJgWZp2da2iN4YoITmpIqgA+yRXG+p4RmH+w6/Ttz1j6M090yyi9
         joNScxjq8meWIvO80gNLEimTec2hNUGorfMD6CLSdqNn+jY6qFVQZruXUwSpGDhQ2ih9
         reTqehWXzIM8k10czRBeF0NCBJH1C9eDhkJUOQjy2uilfPzIRQdSyC2BqWqobKM21cLh
         XpHIm6/SNc1MRGP29Y7g3D3Qovu5Fj40I8flEL2uA8MoLESLNIcBnRNPzlBbor+FwDkM
         RDfXu195WsxH9tfdh3aBedwMnDQsAnLlURqh1NXP4QeIoyvnyF34+dyCwgetEfs4e76u
         eQSw==
X-Gm-Message-State: AOAM5306hh96LSs6Jl7YIj1cfc1+foSmKVX2JHUcAssxNqkHW9EaFtU5
        GQm1VKQ66wygQU3V1I67KAwDG5mxOir5ow==
X-Google-Smtp-Source: ABdhPJw0UMsgszZC5yB3naBv5jFWjYWF4uP6hg8QghCa4W6xT10Nwxg2nhu4SD1k1Vghgej18o9lOhbEem5LzA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:a50f:b0:1b8:e6ad:f63c with SMTP
 id a15-20020a17090aa50f00b001b8e6adf63cmr333880pjq.1.1645171074073; Thu, 17
 Feb 2022 23:57:54 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:57:23 +0800
Message-Id: <20220218075727.2737623-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 0/4] kunit,um: Fix kunit.py build --alltests
From:   David Gow <davidgow@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, x86@kernel.org, felix.kuehling@amd.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit_tool's --alltests option uses UML and make allyesconfig to produce
a configuration which enables as many tests as possible. However, make
ARCH=um allyesconfig is broken for a number of reasons.

Fix a few different UML build breakages, and disable a few config
options in kunit_tool in order to get this kernel compiling again.

Note that the resulting kernel still doesn't run, but having it compile
is the first step to fixing that.

David Gow (3):
  drm/amdgpu: Make smu7_hwmgr build on UML
  IB/qib: Compile under User-Mode Linux
  kunit: tool: Disable broken options for --alltests

Randy Dunlap (1):
  drm/amdgpu: Fix compilation under UML

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c               | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c           | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 drivers/infiniband/hw/qib/qib_wc_x86_64.c           | 4 ++++
 tools/testing/kunit/configs/broken_on_uml.config    | 5 +++++
 5 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

