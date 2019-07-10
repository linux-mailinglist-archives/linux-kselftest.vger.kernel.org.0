Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280BC630BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2019 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfGIGef (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jul 2019 02:34:35 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43697 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGIGef (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jul 2019 02:34:35 -0400
Received: by mail-qk1-f201.google.com with SMTP id v4so18392630qkj.10
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2019 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zxmYDY9n+QBUjDbNH9DRIe0/wlKXcDbLcLkE9B0ZmxI=;
        b=C4g3uHhNIZIht1nDzDUYm5V2TjqZkqGF4g9U0/Ah+KUIKNc92+/rAoZLx/j01ufbx7
         NTm9IwMbUppcuvs4/CbGM/P0DyEHMaX5TywaRSRvptj6oN81uoUUr62xNvGuYDcNVDhI
         49JoB6UQIsqC/ex5+qHWG3RBZgDlLpJreDtgP29yMI72YRGwOp5k0fkqtT7o2iuSgqiU
         jq5xmkuTYFQ0vqw+N5FHoRuAmb15morhS8McfPpBFBEg4HYmxmXZTsCM3/1UF7oaf6qT
         6YjxVprc/Kxlv2BBc7YWTCmJqDgvhPwsK5BvIOIwE6wSlnDUwRReHV24YJIEmr9unbnc
         X8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zxmYDY9n+QBUjDbNH9DRIe0/wlKXcDbLcLkE9B0ZmxI=;
        b=Fx6LoZg2BsEib8wY4YgTP06C5CWMQxny6aN0AZdi/tmyMPZT5ikJZv0cpw+q+wX8RQ
         X+4JR15z29DV1eovZjfkanx8j5BxVYLdqqAdxdvcLqo+Nl5QweuZQNGRMYpRSBuSCf9n
         8jl8ir3GjRKgzUmOa8H1UqG7+ith1MY8N30iAXOvlU37jjZSZR801I4/JXW+x0d6uYB0
         JngFvkqu2UQkmUql93m/+0OgSs+ajCKmYX/I2LA/JzgjGA+OUXHG6GN01Ywv7D2E4nkw
         7+/HD0XIDMqaVDXOTncGzl/WjAUCQky7myYspXrMD+VsUuIoqU3kq0sTVALBEQTRcWN8
         L4/Q==
X-Gm-Message-State: APjAAAUX/K2tKJwCIvjnBn6lkrfXcp/T731RoBTgZR9ST0hb61VfwhOd
        q32YcUc+DxPnqdt9LLlkbMKJRtH3yBoVrl+7OiokYQ==
X-Google-Smtp-Source: APXvYqwOwsIg2AU8i+/acrVUiG/ZVksl2o22EvWFY5S+OQozRKmXPRdDhqqqE6sia3AQVvck9Y39W2rm/r7998eZ/E7wPg==
X-Received: by 2002:a0c:9895:: with SMTP id f21mr17680434qvd.123.1562654074507;
 Mon, 08 Jul 2019 23:34:34 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:13 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
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

