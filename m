Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20D4700ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbhLJMs0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 07:48:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJMs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 07:48:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A9A471F3A4;
        Fri, 10 Dec 2021 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639140290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tyX8eHsv4yca+5dS0yCodfRUS2p5U199cbE1aYVQ0Wg=;
        b=Cv28ulr/lKQan3KXTIgXATo+HdBWkQceu7FZll5tz055xqFR362vkmXUQYabQZtrB14L+2
        yaOSr5zgOllyqgvh5IDNy64Fr/DUFpZ3hxCvjFZWatug/6Gjl7+6M8jjUFIGEh1slgHNB6
        VG9Hm7mKkLEzk1WYcUN4BtxGu2aT0mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639140290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tyX8eHsv4yca+5dS0yCodfRUS2p5U199cbE1aYVQ0Wg=;
        b=7SLV04/4WceaOB32q+JlkftEbMnnyos3ooZfjqPswX4UcnJy5CoM6cwd8B86kGcyuBqJ7g
        MVbLSjPZVu7BFVDw==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id 8E193A3B81;
        Fri, 10 Dec 2021 12:44:50 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 0/2] livepatch: Allow user to specify functions to search for on a stack
Date:   Fri, 10 Dec 2021 13:44:47 +0100
Message-Id: <20211210124449.21537-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

livepatch's consistency model requires that no live patched function
must be found on any task's stack during a transition process after a
live patch is applied. It is achieved by walking through stacks of all
blocked tasks.

The user might also want to define more functions to search for without
them being patched at all. It may either help with preparing a live
patch, which would otherwise require adding more functions just to
achieve the consistency, or it can be used to overcome deficiencies the
stack checking inherently has.

Consider the following example, in which GCC may optimize function
parent() so that a part of it is moved to a different section
(child.cold()) and parent() jumps to it. If both parent() and child2()
are to patching targets, things can break easily if a task sleeps in
child.cold() and new patched child2() changes ABI. parent() is not found
on the stack, child.cold() jumps back to parent() eventually and new
child2() is called.

  parent():             /* to-be-patched */
    ...
    jmp child.cold()    /* cannot be patched */
      ...
      schedule()
      ...
      jmp <back>
    ...
    call child2()       /* to-be-patched */
    ...

The patch set adds a new API which allows the user to specify such
functions.

v1: https://lore.kernel.org/all/20211119090327.12811-1-mbenes@suse.cz/

Changes:
--------
v2:
  - no separate klp_funcs, stack_only attribute is defined
  - tests rewritten

Miroslav Benes (2):
  livepatch: Allow user to specify functions to search for on a stack
  selftests/livepatch: Test of the API for specifying functions to
    search for on a stack

 include/linux/livepatch.h                     |   3 +
 kernel/livepatch/core.c                       |  28 ++-
 kernel/livepatch/patch.c                      |   6 +
 kernel/livepatch/transition.c                 |   5 +-
 lib/livepatch/Makefile                        |   5 +-
 lib/livepatch/test_klp_func_stack_only_demo.c |  66 ++++++++
 .../test_klp_func_stack_only_demo2.c          |  61 +++++++
 lib/livepatch/test_klp_func_stack_only_mod.c  |  70 ++++++++
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../livepatch/test-func-stack-only.sh         | 159 ++++++++++++++++++
 10 files changed, 402 insertions(+), 4 deletions(-)
 create mode 100644 lib/livepatch/test_klp_func_stack_only_demo.c
 create mode 100644 lib/livepatch/test_klp_func_stack_only_demo2.c
 create mode 100644 lib/livepatch/test_klp_func_stack_only_mod.c
 create mode 100755 tools/testing/selftests/livepatch/test-func-stack-only.sh

-- 
2.34.1

