Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24DA12600B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLSK4U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 05:56:20 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:12528 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSK4U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 05:56:20 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 47dphf2kC2zKmj1;
        Thu, 19 Dec 2019 11:56:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id iQ2uzmv5ZKGl; Thu, 19 Dec 2019 11:56:14 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] openat2: minor uapi cleanups
Date:   Thu, 19 Dec 2019 21:55:28 +1100
Message-Id: <20191219105533.12508-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While openat2(2) is still not yet in Linus's tree, we can take this
opportunity to iron out some small warts that weren't noticed earlier:

  * A fix was suggested by Florian Weimer, to separate the openat2
    definitions so glibc can use the header directly. I've put the
    maintainership under VFS but let me know if you'd prefer it belong
    ot the fcntl folks.

  * Having heterogenous field sizes in an extensible struct results in
    "padding hole" problems when adding new fields (in addition the
    correct error to use for non-zero padding isn't entirely clear ).
    The simplest solution is to just copy clone(3)'s model -- always use
    u64s. It will waste a little more space in the struct, but it
    removes a possible future headache.

Aleksa Sarai (2):
  uapi: split openat2(2) definitions from fcntl.h
  openat2: drop open_how->__padding field

 MAINTAINERS                                   |  1 +
 fs/open.c                                     |  2 -
 include/uapi/linux/fcntl.h                    | 37 +----------------
 include/uapi/linux/openat2.h                  | 40 +++++++++++++++++++
 tools/testing/selftests/openat2/helpers.h     |  3 +-
 .../testing/selftests/openat2/openat2_test.c  | 24 ++++-------
 6 files changed, 51 insertions(+), 56 deletions(-)
 create mode 100644 include/uapi/linux/openat2.h


base-commit: 912dfe068c43fa13c587b8d30e73d335c5ba7d44
-- 
2.24.0

