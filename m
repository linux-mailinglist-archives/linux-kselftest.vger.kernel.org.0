Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53691C23A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 07:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfENFp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 01:45:59 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50926 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfENFp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 01:45:59 -0400
Received: by mail-pl1-f202.google.com with SMTP id o12so3277766pll.17
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2019 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VbH5YRFZXncUKHJ08BK/QLvXpcAkrT2bjg0doJXq4Wg=;
        b=OCf3XCWWrg+X1Zfo2KaJsFc8CYMd22l8ZwpB9CroJFTOGYu/0vFhezR4iaTz3kE/3I
         fFp/IuLXCNLvi8L+VRx6kfU3G3XY4NvmC2B9UA+fcbK52mbM47Ly7LjtfuOk6l07r1aw
         7rap3NRlqFMOpBj4U8/6gt0ZxmeHgu+VVL4G8SUAfYBjc+woQRb3nnHSwQ+9kZJCiUQt
         cTYxnNoGEKgBfOjbhfz3gOpWG7YpeM8ZnnTHcHXv+OkS1fJtg5JRoCpiq9Zu3adkDaG8
         r5CO2AuRSUkRtDKGzZGriujyukwMGH26KBv6iBCZjdqXbRKNz+iY3fC3Z80CkCmbNL9k
         fnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VbH5YRFZXncUKHJ08BK/QLvXpcAkrT2bjg0doJXq4Wg=;
        b=s5l1yjNzbSCG+0Ph9nT/xlkh22qSmnADU8+twiyuPCVrgp4SUUvOYjgjx4ELFvdx2x
         UburisW1pTs9uH61Rvrx0wrem8B/zJR/LFAzfbf0N1XvxocEuX0mK+AGwFNcZ0ID0yXc
         3N0O+Lp3ndDj12ZEX38Kufa/0fcs2mmD5NNH3JMUid+DI+Miniyzay1NZr9ykrieMI1B
         U8SDFUMIo1kZ3AFt/A/l6P4Sz0Ss5XFceAIIymSr9QZ9xnyCuFds4UjPAnvoaH9ElOPb
         nJbe6gC9H5rKskm6JOW+E5dg7Fa5P7dEtMU2DV0p+LL0muU7G5X8BLhA/VTC7jng9gyQ
         yZSg==
X-Gm-Message-State: APjAAAVTkq8CuGLJSY1cCdW97zXdc3cPg4PAovD4tfUdBjlfs4+QIa1V
        gKcPMjN0K71rVGGguY3Q60AGqYdy+hIlX1E0ZwCiSQ==
X-Google-Smtp-Source: APXvYqzjyPHISZHTubFgYiNc+UUgch1AmojyVKkhg7WJQC/48paQal1w/wN9VXCtsmHigQZU/YpJ2B4lN0a4vVc5IsORIQ==
X-Received: by 2002:a63:4852:: with SMTP id x18mr22462430pgk.14.1557812758075;
 Mon, 13 May 2019 22:45:58 -0700 (PDT)
Date:   Mon, 13 May 2019 22:42:42 -0700
In-Reply-To: <20190514054251.186196-1-brendanhiggins@google.com>
Message-Id: <20190514054251.186196-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 08/18] objtool: add kunit_try_catch_throw to the noreturn list
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This fixes the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

Reported-by: kbuild test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 479196aeb4096..be431d4557fe5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -166,6 +166,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.21.0.1020.gf2820cf01a-goog

