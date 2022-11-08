Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227F62063E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 02:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiKHBlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 20:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHBlL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 20:41:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563DA1A046
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 17:41:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so34868879ejc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 17:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3m6AiWfuY/c5JtWGjyntVyGmhigK7R7Ad8+dzqQqrx4=;
        b=dP3ljPg/9qygiKA/dDPsotHqcRHTNNOnVjVNCwojASOHEm5E24yka0C4NNBcgxXPER
         6F2yEr0kp/pbhtPxzjbZnEFj0iPen3J/L5WPkmN0VzkyyKbHG31yIN6wd2pNx1OPlZ4/
         ZB6D6UCqDFYtBDqzeQLD5VXY5lvb4b8ZTlmMaH4Is4i6jc9pYT0ctrdpMqhHTHtUc621
         MdogFGO+MyutZPPFgOv2ugEM+W2EvLG9MyO/vljdES/yTmDEE71OjDRwCM9LzQLJ53cH
         WtACNmw7fNyD/zNSCLNijQ6PU5SE8ixeZziDVzdmEp9nd8LO9CJ8qTCNSsRzZg7cl2zW
         iaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m6AiWfuY/c5JtWGjyntVyGmhigK7R7Ad8+dzqQqrx4=;
        b=35pgvBh8w0ssQr6SgjcFmOqnkVKTK9AL3H4Y8tq8h5jdB139UzZPOVCCQ+3XnWbQfm
         w7jGMyG86e0IKLiMlpduHBbj7lWmxcYTLUqe/ENJCviUtKXc0n8zoUEeqayzubsiS8lR
         DHLMaiFkY8ZSiBTct6/1o7nLUFoFfrFYuC5+n5CurdAeN0/BxvX/HzbWQbvai0AMrqyM
         absNwpE7tqTXOeCD7TWFKw4dh8lwBjkKPDkPx9PWZvdZ2i+nZ5Nxdq+l1bDNH8TLP9g6
         OqrBXXq6aIhb+8DwN03CeHK//8fEiess5VTVKoOgltmLlNRMNN5hkJuAS7BHqN2DYf5c
         aCmQ==
X-Gm-Message-State: ACrzQf3lUQa8+XJcme/B9/42a7qgtoUpb1t3L25UUoy8utUssdjXtJUj
        okIeYHU28967QZ+7o6F+HCufjsrNy1UlyKq994CMAw==
X-Google-Smtp-Source: AMsMyM6JG7hEJPPIpFHzqUdlCSkKgpCdWyeP888+/ltpZFZGfbfSv4Oyof/GrM3Kl9eRfd4IidhedU8ZKl5k70/OQLc=
X-Received: by 2002:a17:906:1c52:b0:7ad:c6c5:eae8 with SMTP id
 l18-20020a1709061c5200b007adc6c5eae8mr44428635ejg.439.1667871668795; Mon, 07
 Nov 2022 17:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20221103162302.4ba62d72@maurocar-mobl2> <CAGS_qxr1=PLFzM8bGjdowZwdOXMEPiJEnffPUGQvwdhYVJJNvA@mail.gmail.com>
 <20221104084955.4e6e1093@maurocar-mobl2> <CAGS_qxp3mmhdxKY1PreGRzVW=+4LVQKBRAAJT3VH8APTFtKJxw@mail.gmail.com>
In-Reply-To: <CAGS_qxp3mmhdxKY1PreGRzVW=+4LVQKBRAAJT3VH8APTFtKJxw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Nov 2022 17:40:57 -0800
Message-ID: <CAGS_qxpZokOs5vEhiiTtD4_c0h79MabGm4dmQ=C+t0qoZEc6iQ@mail.gmail.com>
Subject: Re: KUnit issues - Was: [igt-dev] [PATCH RFC v2 8/8] drm/i915: check
 if current->mm is not NULL
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 4, 2022 at 12:20 PM Daniel Latypov <dlatypov@google.com> wrote:
> rmoar@google.com was working on them and should hopefully be able to
> send them out real soon.
> You should get CC'd on those.
>
> I think the follow-up work is just crafting an example parser input
> file and iterating until
>   $ ./tools/testing/kunit/kunit.py parse < /tmp/example_input
> produces our desired results.

I briefly played around with this on top of
https://lore.kernel.org/linux-kselftest/20221104194705.3245738-1-rmoar@google.com/
But instead, I tried to make it so kunit.py parse could be just given
a directory as input so we don't have to do `find | xargs cat`.

I can't get module tests to work locally, so I'll replicate the setup
with some regular files.
Say we have /tmp/results with two files:
file1 contains
  # Subtest: suite1
  KTAP version 1
  1..1
    ok 1 test
  ok 1 suite1
and file2 contains
  # Subtest: suite2
  KTAP version 1
  1..1
    ok 1 test
  ok 1 suite2

I think this should match what module output in debugfs would look like.
A key thing to note: the top level test counter resets between modules, iirc.

The patch below makes this almost work

$ ./tools/testing/kunit/kunit.py parse /tmp/results/
============================================================
 ==================== suite2 (1 subtest) ====================
[PASSED] test
===================== [PASSED] suite2 ======================
==================== suite1 (1 subtest) ====================
[PASSED] test
[ERROR] Test: suite1: Expected test number 2 but found 1
===================== [PASSED] suite1 ======================
============================================================
Testing complete. Ran 2 tests: passed: 2, errors: 1

But there's a few issues
a. the error about multiple top level tests with "test number 1"
b. how do we make this handle kernel output with prefixes (timestamps)
c. and what happens if files each have different length prefixes?

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 4d4663fb578b..c5b2eb416c2d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -189,6 +189,14 @@ def _map_to_overall_status(test_status:
kunit_parser.TestStatus) -> KunitStatus:
                return KunitStatus.SUCCESS
        return KunitStatus.TEST_FAILURE

+def _kernel_output_from_dir(dir: str) -> Iterable[str]:
+       yield 'KTAP version 1'
+       for root, dirs, files in os.walk(dir):
+               for sub in files:
+                       with open(os.path.join(root, sub),
errors='backslashreplace') as f:
+                               for line in f:
+                                       yield line
+
 def parse_tests(request: KunitParseRequest, metadata:
kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult,
kunit_parser.Test]:
        parse_start = time.time()

@@ -496,6 +504,8 @@ def main(argv):
                if cli_args.file is None:

sys.stdin.reconfigure(errors='backslashreplace')  # pytype:
disable=attribute-error
                        kunit_output = sys.stdin
+               elif os.path.isdir(cli_args.file):
+                       kunit_output = _kernel_output_from_dir(cli_args.file)
                else:
                        with open(cli_args.file, 'r',
errors='backslashreplace') as f:
                                kunit_output = f.read().splitlines()
