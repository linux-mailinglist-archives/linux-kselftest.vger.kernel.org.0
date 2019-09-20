Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9060B9A8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2019 01:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437009AbfITXVU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 19:21:20 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42812 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407129AbfITXUB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 19:20:01 -0400
Received: by mail-pg1-f201.google.com with SMTP id d3so1748738pgv.9
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ps4mUI1wXYQhLtVI103dUb/qTWn9bG8Bcp8PtHYLuE4=;
        b=SnZOsrrlWJenGk20gQW1Rwp5y0l+UpBWU6rQ95Ow7AO3VBAJbCntTU3oMaEnvHfJbE
         Az1+XHvzex5yH9YFg4jrae0doIjkNfK2WKgj242VtDhXD7eb58D9+84nTodB0jFlCnpA
         F3JdXTDadG8BO6TY+IJp1iOTvFuTuNf4zY1e2+f4L1KBvmaa5008SAMUudZJV/WVeS/1
         DWMTXY9ED1V9wBZw/L3YY/bPCQkkAeUj/UWD1IVV8rhopQcYgoNXGkyPmKZ/Ip+AAvzH
         W5sULkrrYhl61N0NfZ7xJKxt1MnQS64YyhlU91UwMiWNkDlJcfHS5jVAKyPqQcRv8148
         lTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ps4mUI1wXYQhLtVI103dUb/qTWn9bG8Bcp8PtHYLuE4=;
        b=BSx7Qt17uPfSxeLhAuB7VufOrYeuydNMzaBKPhoLBv/v9uegNPhBxCM0uXmx+9sLDG
         ug00uGox32sZuQB4P0tTCVox+ZKGPmUQEFKa8N5wpYQdY6nzNp9FsnSAqdSMR0VBdUam
         oQy/h7qOl73170tV9wGmoDOB7qN1UViNSvFZW0TSiM8qfmoR5T/Ca6VGhei8ka4gp2tM
         Eb7uVRZp1QVA2p1By5f9wUDCE6qoVa7OvYKPktXsHsnWd6JwTSGHC73tAJDC8yZ3l7d7
         uZKOudDaIERgNbO0Wvcnwiv2BA5P5OFnWlGuP4B4APSHRVIBBqqqLbsAZPbWimUgUMo4
         aOww==
X-Gm-Message-State: APjAAAUaU/VOi44X/Fl8H2PjMnv2lCrGEVfIbDee+jldXWY5YNm7WrFX
        p1p2k8U2YnctwMGCCCW7CcBMXndQnmbBAc+VQPUJkQ==
X-Google-Smtp-Source: APXvYqyRyEtSIoadJVkzfr7pCBqe/P8Wqalii5pRNBWiJia3EUvmP93K/4Z5BGLmgvurL+sQYFSnEu4syCjzL5l2a736Qg==
X-Received: by 2002:a63:30c1:: with SMTP id w184mr7246294pgw.145.1569021600602;
 Fri, 20 Sep 2019 16:20:00 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:12 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 08/19] objtool: add kunit_try_catch_throw to the noreturn list
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
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
index 176f2f084060..0c8e17f946cd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -145,6 +145,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (!func)
-- 
2.23.0.351.gc4317032e6-goog

