Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94157BE3F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346587AbjJIPJ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbjJIPJz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 11:09:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541BB4;
        Mon,  9 Oct 2023 08:09:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3D6221883;
        Mon,  9 Oct 2023 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696864192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ISQ9n4D5T3P8ooumknvc+YiFO0JDSQRXu8nxDrWSZQQ=;
        b=ZnayWCvnMF9L+nOSQ/u0lRORq0pD9+ifKV4GqLv9wH7Z5tc1ily0R1cd6V7h0m0JWlkPKP
        MglvcvQ4TdGnmeKxfB3ROOGJbNlYwmKuqqyUxzGOWPmlSHlhdVEv3VfQYmdL6Py2OiS9kk
        ehffi4TuE0QPZBYHC9UV/EOCEo4SFr0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B4BE13905;
        Mon,  9 Oct 2023 15:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t/q1AMAXJGW6JgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 09 Oct 2023 15:09:52 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     shuah@kernel.org, corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] Documentation: kselftests: Remove references to bpf tests
Date:   Mon,  9 Oct 2023 12:09:29 -0300
Message-ID: <20231009150929.25953-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the bpf selftests are skipped by default, so is someone would
like to run the tests one would need to run:
  $ make TARGETS=bpf SKIP_TARGETS="" kselftest

To overwrite the SKIP_TARGETS that defines bpf by default. Also,
following the BPF instructions[1], to run the bpf selftests one would
need to enter in the tools/testing/selftests/bpf/ directory, and then
run make, which is not the standard way to run selftests per it's
documentation.

For the reasons above stop mentioning bpf in the kselftests as examples
of how to run a test suite.

[1]: Documentation/bpf/bpf_devel_QA.rst

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/dev-tools/kselftest.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index deede972f254..ab376b316c36 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -112,7 +112,7 @@ You can specify multiple tests to skip::
 You can also specify a restricted list of tests to run together with a
 dedicated skiplist::
 
-  $  make TARGETS="bpf breakpoints size timers" SKIP_TARGETS=bpf kselftest
+  $  make TARGETS="breakpoints size timers" SKIP_TARGETS=size kselftest
 
 See the top-level tools/testing/selftests/Makefile for the list of all
 possible targets.
@@ -165,7 +165,7 @@ To see the list of available tests, the `-l` option can be used::
 The `-c` option can be used to run all the tests from a test collection, or
 the `-t` option for specific single tests. Either can be used multiple times::
 
-   $ ./run_kselftest.sh -c bpf -c seccomp -t timers:posix_timers -t timer:nanosleep
+   $ ./run_kselftest.sh -c size -c seccomp -t timers:posix_timers -t timer:nanosleep
 
 For other features see the script usage output, seen with the `-h` option.
 
@@ -210,7 +210,7 @@ option is supported, such as::
 tests by using variables specified in `Running a subset of selftests`_
 section::
 
-    $ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
+    $ make -C tools/testing/selftests gen_tar TARGETS="size" FORMAT=.xz
 
 .. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
 
-- 
2.42.0

