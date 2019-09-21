Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41FCB9B32
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2019 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437312AbfIUATc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 20:19:32 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:54270 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407380AbfIUAT2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:28 -0400
Received: by mail-yw1-f74.google.com with SMTP id x198so6846626ywg.20
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ps4mUI1wXYQhLtVI103dUb/qTWn9bG8Bcp8PtHYLuE4=;
        b=EpNbfjIJuRPOCOw8ygVt5WAvRpQfiHatGYZwjgY/UZ3UU4/J5JO29UPtRNCKNGwr4u
         HR5TU9ANXlXVmgDGBTzBUUqpxyem/qzyq7qmjUXu1MGvm2lf3eReibfSpVaSU1x46VOX
         vQaLLmYjM8czMG9fp6VLmj58rn147nDT/G87jkl9sYjW+zzWZtggw8MOoUMcsRv1YSdu
         OcSmW/Yfal5Mdf89cgfBhi4EHglzpZ23RP8my3Qer2lvn0/q9sKxat8FQ+A1Oc8q35Es
         5PlZkq0yAipFEDl8SPEYZTEdNhhJ5hP1AsApRbss8lUYOAmCSW0WkUqxjyIWZ7co7DUi
         5fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ps4mUI1wXYQhLtVI103dUb/qTWn9bG8Bcp8PtHYLuE4=;
        b=DHJErbelQy9CBi0Aw9l9jbWF3nfUzbt6aRwujv37mRCC7gL/ul8O0rS0FNAuIQuzwE
         p9NX/WSqGEpZkfBDB+Tbn9nSIqzAcNnrIrsIezRohBgnHfsRcIzRbC1tHGJkWGuKXGqK
         YeDDZ+eMNsInIky+JSYZT5a0DDCFCazgPAr0pcMje6hiqPqG8sOTa8i5xDZTt1+r5fLr
         YhR1ouP9dhc/dmYycoCmNF4Dm06uOmCK2o58YjrCLhn/seBgzhNBD8/vEkoJ7mxVXmnP
         af5ZpQ8XdwmfIUoohtoc887kRafBzWWmLZdcoq3fGiEUofBhXDsugs9mm/fwSW4yUEr/
         2zBQ==
X-Gm-Message-State: APjAAAXTtfAfF+4hL4awwYWtSmaZtAuTs74Ex1d6cT3EW1WmbFDSbPHa
        SKvVml/fJUJLTSJNKNHOFaJub82+kreM+b/FqAJMfg==
X-Google-Smtp-Source: APXvYqxnvbMbdy5YJ/mEtKLf76ImSyCOMAVrkXJYz9e4+aH2Re3qbb/KlZrY7S4PNlrAaGxfIXAnQgsfQqHuv/2j4Q6tqA==
X-Received: by 2002:a25:8201:: with SMTP id q1mr12174472ybk.373.1569025166777;
 Fri, 20 Sep 2019 17:19:26 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:44 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 08/19] objtool: add kunit_try_catch_throw to the noreturn list
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

