Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9F4BB3B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 08:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiBRH6U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 02:58:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiBRH6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 02:58:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A89161120
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:58:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7-20020a255607000000b00621afc793b8so12788598ybb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7R2K/W8nkggK1CJfPpQftpPmnn35SzGH4U6ga+9D7QQ=;
        b=V+xlF6qh6PP/HMyXbXzf7qS3SXtT2e2Zoo2s9HHCNL5egQM9rIMawyFSb8Ck3LfwA5
         X2PDtPb4B41RUBMfC53NXkmR01khgouCtY7ufZ8nImmPIdsQeCYpJScdMsdiL67euac7
         qeL1eOg1Ft+dXUhi7ilG7/B94k93I+51LINTfDl0LEdOed7L+X/iTVGsv4gBykmKduLH
         zfc9gPYFlLKcTC+N1/G8sBoai9qpugRP5wp2kS2Z0qjBAHrwCGGvICeoI1wCj0/sYzx4
         I/Xk9CutaMf0v7CcxiLDDdxBmur+yOzVl42FB7lj1RA7MFHPAP5lxjz0Q4EeFFyYLtPk
         7C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7R2K/W8nkggK1CJfPpQftpPmnn35SzGH4U6ga+9D7QQ=;
        b=AlXwJ3EEV04cjSH+6KpdPphxUTQ/GchsOWp5AtcGJN3obeDUKF8wtWSfKoUTpaNUm8
         KvZ+XTwxQ5s7K6sxMkCFptTqUE4p0w0FrEpr63Y/eyOb4w17JpkQk888mcdSMop4xkcB
         7zCHF11Qng28n9E8EBWn2dbF8ozUF8LDyVO13Hy8PTH8beGEr4EEiT+y/+z2w1f4OB7g
         VSN/CZtRUxXD55t/fcXkdSJBWK6HP7ft8iD3tPrkjk8duWKu/TybVve9E589q2W9eHeU
         GzJ1Rfjn4ZOMdX1x8wIMeGizzNnXsKRU43X0NUmYz6QY837/RpR04aTCr8VGS74j/eS9
         WL4A==
X-Gm-Message-State: AOAM531MMvW/5TMHm4uinCavwefYE+XP0qs/4YsT6e6zxCDaq9xt6tZ8
        XvuNRGycNY9x/5Fxun7aR0r5HzqsnSR5GQ==
X-Google-Smtp-Source: ABdhPJwRyBr1QVgpmKaKId2Xs4Ti+wE4zEnLnzEuBxqhMYKF29LS22m3wSG1jSe6jV4DAclduKLzF34NZOIuaQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:9e:b0:2d6:c96d:bf01 with SMTP id
 be30-20020a05690c009e00b002d6c96dbf01mr767575ywb.421.1645171082793; Thu, 17
 Feb 2022 23:58:02 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:57:25 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 2/4] drm/amdgpu: Make smu7_hwmgr build on UML
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

The User-Mode-Linux architecture (with the x86_64 subarch) defines
CONFIG_X86_64, but doesn't expose the cpuinfo_x86 struct (instead
there's a cpuinfo_um struct).

In order to allow UML to build with allyesconfig, only check cpuinfo_x86
on non-UML architectures.

Fixes: b3dc549986 ("mdgpu: Disable PCIE_DPM on Intel RKL Platform")
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a1e11037831a..a162552f7845 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1738,7 +1738,7 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 static bool intel_core_rkl_chk(void)
 {
-#if IS_ENABLED(CONFIG_X86_64)
+#if IS_ENABLED(CONFIG_X86_64) && !defined(CONFIG_UML)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
-- 
2.35.1.265.g69c8d7142f-goog

