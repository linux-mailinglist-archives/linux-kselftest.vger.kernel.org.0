Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10B746BE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGDIab (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 04:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjGDIaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 04:30:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769ED8
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 01:30:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bf34588085bso5707268276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688459428; x=1691051428;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sfzTTTZzhjYlz4coFh9E2qSX1ec2CbvNDkaAXEgpk5k=;
        b=V8Vsb0Zt5QGQio1EPy5IGW2p8TPoQMJ1oVAgaPnqc8Bl2IMATsQZRlbz2u8dDr8cmo
         aHvazQfMuSXmNAxqMbzFrwGkp7MBrxzmuYCrK2BwIoCc5U+Ty43eJVT2pdEMJjDL+ma+
         aGkT6TxH6vX5m9sWMUsU+RZXMaDJV6vqbQBkD0oyV+3N90lgjPTlbBVuOn0nnzGw2Qvl
         oXx07SyWAgK2Jt9JjDwEMAQje137bsU9yzAunIxWnc4o7Cqc+Ml1mROlOJXkEFdIsB6l
         y3z/GPJWMEe5xVO3UZlkoIid/wmLfG7exFCE/PaAAoNH36bzS5cFinGXDw4qlI7NW10j
         rcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459428; x=1691051428;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfzTTTZzhjYlz4coFh9E2qSX1ec2CbvNDkaAXEgpk5k=;
        b=GwpfEW6C9UG3x4rRVFSKloKFdXcC1HKYbpArFBTq2a6jq2kDk5o/jmkuwLTS6OQY/4
         C8ASFCKoXMfaRCXBQefUXPztQ75uZ1Ckh2SM/oCRr6PCh5Pxb9VVFoVNuBSbqoZTUxBd
         u2dVoZOpl8uKD2EhEfJf3Gx7Y7OC7ktOP/5WtiFVWAT33KMt0gNhNK7+zhyElSJeEUUD
         3g7HME+CNKmzAPi/GQ9papM8iCMsGxcPCbZmALAks62ronvFxBeO1ZsQVtKASvX9Pha1
         JPk8zwIiEWAQcac36QhNmK53A7xTusd/IuIfziclBmNQ2g2XgOOxAudsOEjKhSoB79bv
         5vXQ==
X-Gm-Message-State: ABy/qLaNgx0p6Nm4cBQ6PJcZNWNoFW4XhUEbx5fQ5eIJK3FZDjQE7Jvk
        z/+GF/Jlk/Ya/e0cCU0JL2Qgc5K1FcJ/wA==
X-Google-Smtp-Source: APBJJlGdBVgj65bby9V434H9tf4LMtH0P8VjOntdbYAYDc6gjGY+BtXP400b2TbEy0J1sOLuNq4qDOqdTr44WQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1813:b0:bc5:2869:d735 with SMTP
 id cf19-20020a056902181300b00bc52869d735mr77328ybb.13.1688459428478; Tue, 04
 Jul 2023 01:30:28 -0700 (PDT)
Date:   Tue,  4 Jul 2023 16:30:21 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230704083022.692368-1-davidgow@google.com>
Subject: [PATCH 1/2] asm-generic: current: Don't include thread-info.h if
 building asm
From:   David Gow <davidgow@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     linux-um@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
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

asm/current.h is included by some assembly files (either directly, or
indirectly). This works on some architectures (such as x86), as their
implementation of current.h is careful to not include any C, but the
asm-generic version includes linux/thread-info.h unconditionally, which
leads to errors when either C code or non-asm-compatible preprocessor
directives are included.

Just wrap the contents behind an #ifndef __ASSEMBLY__ to avoid any C
code making its way in.

Signed-off-by: David Gow <davidgow@google.com>
---

This is requrired for patch #2 here, as UML uses this asm-generic
header, but works with x86 assembly files which are expecting the x86
current.h, which is assembly-friendly.

---
 include/asm-generic/current.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
index 3a2e224b9fa0..9c2aeecbd05a 100644
--- a/include/asm-generic/current.h
+++ b/include/asm-generic/current.h
@@ -2,9 +2,11 @@
 #ifndef __ASM_GENERIC_CURRENT_H
 #define __ASM_GENERIC_CURRENT_H
 
+#ifndef __ASSEMBLY__
 #include <linux/thread_info.h>
 
 #define get_current() (current_thread_info()->task)
 #define current get_current()
+#endif
 
 #endif /* __ASM_GENERIC_CURRENT_H */
-- 
2.41.0.255.g8b1d071c50-goog

