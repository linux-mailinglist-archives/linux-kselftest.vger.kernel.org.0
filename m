Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882459A669
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351334AbiHSTUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349802AbiHSTTs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0011141BE
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 12:19:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33352499223so90810327b3.8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=7jW9JSFdBkYgLRSlwkmM/JIttkYceIPDZWewEa3r/u8=;
        b=oR+QcvLsAx7r4XQNN3cL0Twl29NyDz8147I+ryzAyb527+xnsfUFeLqIySHJ854uy6
         ifH5GSNUxqLNTHZJIeGfD/3JXqZN8VpCi9HVpQ2fhFh+7fp1MKED4pUCnMP9FHX7Fco3
         zkuh6QuX8n2LVfXK3Vb6ZiWkTTAFWETBsHj5R2e5uxY6TwbeZ67/O8q9UxiBX1GMQEM1
         bt/E54Z4WsqFvIW9H+kN6PCddfpJYitM9/XHsCODdiIMc7pIbiT2CkjRGpPhQ7DJCqWi
         htrgbPkPU8Kj5Q1ngR1iVrLmBHp+vZguUJ3nXGw2WVxx9hf+vPmWnueCPSxgycGDaVbS
         jlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=7jW9JSFdBkYgLRSlwkmM/JIttkYceIPDZWewEa3r/u8=;
        b=Ns2PBxLQ+QapTpuZzEvr9uvexzNvFDywp+vWRhQyBCTj+2yB9lg0WKmBC2vnQUDy7D
         GEtMJLgVN2rq7CdkOq/la1SzPj9fpudRkGtMoDapvwo/go1WNAjHEMiRoNXAfrGVJT5d
         sQvO77xpNSlqenIJdMzJV3uV2fY2ZIpA2uh3HRXypMvULyuwnmlNct22WSpCNrZ1hRJl
         NcBlPur41poXm8iCcgXl5MjL7IH1caN8hqSlrlA5TWzUHnfCl7qcrC6Sy37C9Bu+zAIf
         dJausE3oTXSU//58v8pFPQnyt+xR61wdL6+0K7HcMjPwfrHPjtnGwuyPcuKCOHyYQ0dD
         cQfQ==
X-Gm-Message-State: ACgBeo3GxcRPWej+jnWmGHl75qp/qd7L0S5aAcECgOb0UO4zmTX0K0/L
        1/F6+ZyS3yB9WsfXnXShKXfQVxahSlzgc4zk3F1R
X-Google-Smtp-Source: AA6agR4VD42sceVnWm58Z+eDpzGYApQVQC8yQTgPQxRlFe0oL38C+92/Nyrf7mt8jHbHD4sASoH0kBeSt4AWuHk9DBj1
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:676:8328:93fe:a318])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:154d:b0:67b:7908:9660 with
 SMTP id r13-20020a056902154d00b0067b79089660mr8579721ybu.607.1660936772678;
 Fri, 19 Aug 2022 12:19:32 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:19:28 -0700
Message-Id: <20220819191929.480108-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 1/2] selftests/vm: fix inability to build any vm tests
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
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

When we stopped using KSFT_KHDR_INSTALL, a side effect is we also
changed the value of `top_srcdir`. This can be seen by looking at the
code removed by commit 49de12ba06ef
("selftests: drop KSFT_KHDR_INSTALL make target").

(Note though that this commit didn't break this, technically the one
before it did since that's the one that stopped KSFT_KHDR_INSTALL from
being used, even though the code was still there.)

Previously lib.mk reconfigured `top_srcdir` when KSFT_KHDR_INSTALL was
being used. Now, that's no longer the case.

As a result, the path to gup_test.h in vm/Makefile was wrong, and
since it's a dependency of all of the vm binaries none of them could
be built. Instead, we'd get an "error" like:

    make[1]: *** No rule to make target
        '/[...]/tools/testing/selftests/vm/compaction_test', needed by
	'all'.  Stop.

So, modify lib.mk so it once again sets top_srcdir to the root of the
kernel tree.

Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/lib.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 947fc72413e9..d44c72b3abe3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -40,6 +40,7 @@ ifeq (0,$(MAKELEVEL))
     endif
 endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
+top_srcdir = $(selfdir)/../../..
 
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
-- 
2.37.1.595.g718a3a8f04-goog

