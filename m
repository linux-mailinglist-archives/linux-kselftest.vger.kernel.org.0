Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64715456C0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhKSJGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 04:06:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhKSJGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 04:06:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9D809212C7;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637312608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ryxkM6ZbOxi24MG6rSk91RHcGNahOuxWWYehYmvANH0=;
        b=V/HDO41YdtoPLAXxelWgfN6gmcIWbFxWOl3SkR81bNnwhxjqPbCQExx+yKEqWe87Jutq+S
        dVRVrK09MZtVGUGpd1YZkd20459X2mY+7SHvKTCFDBy7jvV3ITg/AbiANKgPxuZzduATo9
        3txD0OZ82hyd93VBLGOHsNa2aYrZSJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637312608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ryxkM6ZbOxi24MG6rSk91RHcGNahOuxWWYehYmvANH0=;
        b=0ulmvSMfttdtL4TLvkxS3Uo4qOPTW1Q8fSgzGoTCUHrdRXJm3PNwOoYIaqoZ266mBSdW2m
        SPUo94CSftl7+MAw==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id 84721A3B81;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/3] livepatch: Allow user to specify functions to search for on a stack
Date:   Fri, 19 Nov 2021 10:03:24 +0100
Message-Id: <20211119090327.12811-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.33.1
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
patch, which would otherwise require additional touches to achieve the
consistency, or it can be used to overcome deficiencies the stack
checking inherently has. For example, GCC may optimize a function so
that a part of it is moved to a different section and the function would
jump to it. This child function would not be found on a stack in this
case, but it may be important to search for it so that, again, the
consistency is achieved.

The patch set adds a new API which allows the user to specify such
functions.

The first patch is only preparatory. The main work is in the second one.
The third patch adds a test.

Originally, I wanted to add it all to klp_patch struct, but it makes
more sense to do it on klp_object level. It is also easier to reuse as
much of the existing code as possible in that case.

I am not good with naming so bike-shedding is welcome. Reviews even
more.

Miroslav Benes (3):
  livepatch: Move the initialization of old_func to a new function
  livepatch: Allow user to specify functions to search for on a stack
  selftests/livepatch: Test of the API for specifying functions to
    search for on a stack

 include/linux/livepatch.h                     | 11 +++
 kernel/livepatch/core.c                       | 50 ++++++++---
 kernel/livepatch/transition.c                 | 21 +++--
 lib/Kconfig.debug                             |  1 +
 lib/livepatch/Makefile                        |  4 +-
 lib/livepatch/test_klp_funcstack_demo.c       | 61 +++++++++++++
 lib/livepatch/test_klp_funcstack_mod.c        | 72 +++++++++++++++
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../selftests/livepatch/test-func-stack.sh    | 88 +++++++++++++++++++
 9 files changed, 293 insertions(+), 18 deletions(-)
 create mode 100644 lib/livepatch/test_klp_funcstack_demo.c
 create mode 100644 lib/livepatch/test_klp_funcstack_mod.c
 create mode 100755 tools/testing/selftests/livepatch/test-func-stack.sh

-- 
2.33.1

