Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6749D276
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiAZTXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 14:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbiAZTXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 14:23:16 -0500
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jan 2022 11:23:15 PST
Received: from forward102o.mail.yandex.net (forward102o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6FCC061747;
        Wed, 26 Jan 2022 11:23:15 -0800 (PST)
Received: from sas1-bdc74852af75.qloud-c.yandex.net (sas1-bdc74852af75.qloud-c.yandex.net [IPv6:2a02:6b8:c14:49b:0:640:bdc7:4852])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 642256FF805C;
        Wed, 26 Jan 2022 22:15:05 +0300 (MSK)
Received: from sas1-1f4a002bb12a.qloud-c.yandex.net (sas1-1f4a002bb12a.qloud-c.yandex.net [2a02:6b8:c14:3908:0:640:1f4a:2b])
        by sas1-bdc74852af75.qloud-c.yandex.net (mxback/Yandex) with ESMTP id JlJu1nJfOU-F4cOTLG1;
        Wed, 26 Jan 2022 22:15:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1643224505;
        bh=O+b5CapC7L3M523CZMVUm6J5g7pUFdehbp9UOnOr/xk=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=E9n8Iml8+ZHxoa+BXBTJos6Ccp1DizV9JZ8zcd2KXVUdGL2hvYFvhQksyriGFd/X6
         4KM8cyqY4/v95sEXDrc5DXUinnWKZDewTaXIaD+Wfjjf2K4UbXsBmkYh4e1h5N/xz3
         dr5PYAQbgeDtQyRXrgnXCx8TPtIzwZjIR9nVxCqo=
Authentication-Results: sas1-bdc74852af75.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-1f4a002bb12a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id vdrU00sr04-F3IGAhXh;
        Wed, 26 Jan 2022 22:15:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Stas Sergeev <stsp2@yandex.ru>
Cc:     Stas Sergeev <stsp2@yandex.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Lutomirski <luto@mit.edu>,
        Shuah Khan <shuah@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sigaltstack: return only one flag
Date:   Wed, 26 Jan 2022 22:14:39 +0300
Message-Id: <20220126191441.3380389-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently sigaltstack() can return multiple flags, for example
SS_DISABLE|SS_AUTODISARM. This confuses libraries (including asan
runtime) and contradicts the man page.

Patch 1 fixes this problem by ignoring any flag passed with SS_DISABLE.
Patch 2 adds a test-case for that scenario.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kees Cook <keescook@chromium.org>
CC: Jens Axboe <axboe@kernel.dk>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Marco Elver <elver@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Alexey Gladkov <legion@kernel.org>
CC: Andrew Lutomirski <luto@mit.edu>
CC: Shuah Khan <shuah@kernel.org>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: Borislav Petkov <bp@suse.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Len Brown <len.brown@intel.com>
CC: linux-kselftest@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Stas Sergeev (2):
  sigaltstack: ignore flags if SS_DISABLE is set
  selftests: sigaltstack: add new SS_DISABLE test

 kernel/signal.c                           |  1 +
 tools/testing/selftests/sigaltstack/sas.c | 48 ++++++++++++-----------
 2 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.34.1

