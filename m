Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA934ABF9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiBGN1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 08:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445593AbiBGMmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:42:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33BE033DB2;
        Mon,  7 Feb 2022 04:33:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84DE11F37E;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QzKGUR8l2ANJZZ33siPyM5ZbfG1iAsiLZfA06Eklo2s=;
        b=t4tem1l8nL6PTmdZ+KQ4TZfGehFe/oB+t+9GgFdng1NUQhi+1jlTKMBMHSdpTLeu3wkInk
        Le/Dz3WF5awnyQQynQfzCqGdSQgj1lV3Yz95XfP7yHip1fyy9NNH7VNG/ercZMPDt2HPd/
        JiWKNEsych/QP66n8tcndCK5NjNoLFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 592D713BBC;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +7w4FQQOAWLMegAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 07 Feb 2022 12:18:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [RFC PATCH 0/6] RLIMIT_NPROC in ucounts fixups
Date:   Mon,  7 Feb 2022 13:17:54 +0100
Message-Id: <20220207121800.5079-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is a result of looking deeper into breakage of
tools/testing/selftests/rlimits/rlimits-per-userns.c after 
https://lore.kernel.org/r/20220204181144.24462-1-mkoutny@suse.com/
is applied.

The description of the original problem that lead to RLIMIT_NPROC et al.
ucounts rewrite could be ambiguously interpretted as supporting either
the case of:
- never-fork service or
- fork (RLIMIT_NPROC-1) times service.

The scenario is weird anyway given existence of pids controller.

The realization of that scenario relies not only on tracking number of
processes per user_ns but also newly allows the root to override limit through
set*uid. The commit message didn't mention that, so it's unclear if it
was the intention too.

I also noticed that the RLIMIT_NPROC enforcing in fork seems subject to TOCTOU
race (check(nr_tasks),...,nr_tasks++) so the limit is rather advisory (but
that's not a new thing related to ucounts rewrite).

This series is RFC to discuss relevance of the subtle changes RLIMIT_NPROC to
ucounts rewrite introduced.

Michal Koutný (6):
  set_user: Perform RLIMIT_NPROC capability check against new user
    credentials
  set*uid: Check RLIMIT_PROC against new credentials
  cred: Count tasks by their real uid into RLIMIT_NPROC
  ucounts: Allow root to override RLIMIT_NPROC
  selftests: Challenge RLIMIT_NPROC in user namespaces
  selftests: Test RLIMIT_NPROC in clone-created user namespaces

 fs/exec.c                                     |   2 +-
 include/linux/cred.h                          |   2 +-
 kernel/cred.c                                 |  29 ++-
 kernel/fork.c                                 |   2 +-
 kernel/sys.c                                  |  20 +-
 kernel/ucount.c                               |   3 +
 kernel/user_namespace.c                       |   2 +-
 .../selftests/rlimits/rlimits-per-userns.c    | 233 +++++++++++++++---
 8 files changed, 229 insertions(+), 64 deletions(-)

-- 
2.34.1

