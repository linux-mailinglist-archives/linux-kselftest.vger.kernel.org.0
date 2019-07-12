Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D02E66891
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 10:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGLISO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 04:18:14 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45777 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfGLISO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 04:18:14 -0400
Received: by mail-pg1-f201.google.com with SMTP id n7so5285731pgr.12
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2019 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i+cHtqqH4D1BH2a9iTheu+r071sQgiMbeMpUxd8ISoM=;
        b=oHpfhzNbJmulqM6XSNH5su9esA0AXBMlIYp9xnUAqjTBxFDowcENzhm8NkKmPbzmBf
         TfIjRelR04iLN1TttiN4WrjDbgNJqROj8ZHFleOvrhDsyhjxlOVAKSIO3dzyZoQobaI7
         JWKbSLVf4RHLIrH4o+UfsD8ykJ2/IyL5O6ecYkykXB52Po8SpR2jZoRpgc9FNom5cM7L
         rW8BibE3ShU7hHecNSLSWPt79g74xsWLSFavd+V86jp0tTlXJ/wwZuXnzaPPuQYJ21My
         /ZSaqrVaDRaCkFVnpYDKUKzv1IQHchCGI5eBif6HuLTcLqHw+1CSS5LXiGvHFAFfgFXn
         LNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i+cHtqqH4D1BH2a9iTheu+r071sQgiMbeMpUxd8ISoM=;
        b=hDw+POYyzGyKL9p1+O0Ba8hRbkAxkdAXAEaPvp4XD88qx0ehBxe1Ud+uQ4X5DkKrCi
         H3ZqADcTIdtGX7QkWgnAI+K5swAJzurVhBFqV0/DkMOsdyqEbRMPnUQsvH9/N+6xAq3A
         E0Iz1ljFJ4AFTr+dph3ifiwtnxw0VzOwNsGLBewjjs5L3wbbZqtySS+z43ZPJO1ZA3jm
         LHj9VV8mVUIxrHEvRY4j9uHl1mATQRmleSieNgZK045pab7UOobez2RrYu2wyGmJe6Z+
         k3E2T4uJcumocuHNfSaY5pHyRjwkSQfqRY9tNaocAve6zhGyKF8aAh4KAif9yTTp/Ki9
         jlbQ==
X-Gm-Message-State: APjAAAXj0hPrLh3Fw5YuS7yuNE9M+qG3otjgYFiqBhptcX2vEw8Avivd
        vSFcnYPDGtMyqQSXSxW5O2Pluy0fEyAUjjgnUwLuHw==
X-Google-Smtp-Source: APXvYqzz2gJJL34hDMbBwPs85xg2+0dv7RK7cTbtv7ZbF6XViPSV/DLjekY0hrvbIynZL7ZvM95IzPNpuP225+5zbR75Zw==
X-Received: by 2002:a63:3046:: with SMTP id w67mr9536501pgw.37.1562919492919;
 Fri, 12 Jul 2019 01:18:12 -0700 (PDT)
Date:   Fri, 12 Jul 2019 01:17:34 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 08/18] objtool: add kunit_try_catch_throw to the noreturn list
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

kunit_try_catch_throw is a function added in the following patch in this
series; it allows KUnit, a unit testing framework for the kernel, to
bail out of a broken test. As a consequence, it is a new __noreturn
function that objtool thinks is broken (as seen above). So fix this
warning by adding kunit_try_catch_throw to objtool's noreturn list.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f991957269..98db5fe85c797 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -134,6 +134,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.22.0.410.gd8fdbe21b5-goog

