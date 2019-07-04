Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72C45F05D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2019 02:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfGDAh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 20:37:59 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38947 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfGDAh6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 20:37:58 -0400
Received: by mail-qk1-f202.google.com with SMTP id j17so5518035qki.6
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jul 2019 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P7qQxupR077m/rPxlenNGlU3U4VVv+id9WBQp+CCiSA=;
        b=eX6g8UJwZVNX+4r+AShnzJta6FGseuE/5NG3bFT5qUZ29kjG3eSigy79cygGRMy3wG
         OlNuhPBgbypVjqEcuiDHgE8ZRW8TX/6T/BgVy+sLlM5y+9VJjnZhvIDMlYZBOk2ci75G
         h9xN0mf0vc5siI3tGh96t9saSuC00p9xuUwaUPkUcu6P9gaKRQ9QK0tgT0c83lmxhbU3
         2FMuBJqZmiDCRtom/5lZVTemVzcNLahTde7XIKJINA6n2Xld/6QvzyMORAoQ1D2is3wV
         ghoNX0qf/AFPDEbC7dn7jjJOxJsOmrsv/J4evI99aFvqYr9hJhmbq+e2Zzdo3qYeS+O3
         59sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P7qQxupR077m/rPxlenNGlU3U4VVv+id9WBQp+CCiSA=;
        b=bmf/tbORUY/gZlrzBObRDeaqHin+ll+EGvDk+OpH03AXWfU+9GEfca2Sk/40VxjE0D
         wxqy0wPiB+SjEm2VToGJVjwFvXdeT3KUN4IFCjnrgbcCpBrcR1gd3YFsO9ehKfA+Fehi
         dvSVe67J+S3Wi4I6GCLPBEAGmmwmvRvM/5xIEGnHyTXvFXzhsTGuQjOBnlpd8WfhRYde
         lJ3Fq0Cl9fdYX1Hza5+K0hFDVMVRtXC4vEkQY2tStShY4sZVTUyAhCnUuZCB4Bsl4orW
         BnJl2eICkUTMM9GofrfZ60wTi0K5N1NXTkveFYt2Yunm3/ZZcwD4zEACI8yx31DfFrgI
         PCPg==
X-Gm-Message-State: APjAAAXGeBkvRJ0kbCw93Acq06UgzRdtAqBJwQ4DceUw5zEJLPqzXeRJ
        5UENugksbDDVRTXf3SxRaKyGhfcYJSshNaeHk5xTPQ==
X-Google-Smtp-Source: APXvYqytggehTlSFZvjf2aviCQRPatILKKaUGgr20IkSkXU2ITJH43rWfM0KxJCOSm3yMfSZQ3zYRWZoJDKAEm/SDyDtaQ==
X-Received: by 2002:ac8:7b99:: with SMTP id p25mr3074172qtu.243.1562200677358;
 Wed, 03 Jul 2019 17:37:57 -0700 (PDT)
Date:   Wed,  3 Jul 2019 17:36:05 -0700
In-Reply-To: <20190704003615.204860-1-brendanhiggins@google.com>
Message-Id: <20190704003615.204860-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
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

