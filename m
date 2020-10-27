Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AEC29C7BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 19:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780433AbgJ0StB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 14:49:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38546 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781685AbgJ0StA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 14:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mP7cR0zaw4Ej4sdjaXHQZnAyKGNxbHCXBGjaXsoryyU=; b=umGKTtlnkuJ9YWi0a+YFX5MUBI
        +JlENx1NVdZKDrDqsfvtq2xhLHscreRs0qXxc8yOtgdtKjCwOENhyykJYZSTyIFu8qtOeegNIWx8I
        w96IyBT2uzyH8twlqVfilVCUt+R1oGd49ecznEvNHBw7wclWcC3xGCbexeqOpV6QHY+T71Nc1dAQU
        92wyosqjKHyjNTSnmyYtdLHgxL138lJj/fX8EVv6vCe66C2ICR6RoIjtpywuJoVxPlYGQQXuVvzY2
        oIQU4jY551+v0QPdh2lYpLohxiPLJUPGrKgZr5F6Ax2u1gAwxBaZkaK0j8g0MqFXwCF+v9eu9WDBH
        51s/tUwQ==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXU1j-000882-0N; Tue, 27 Oct 2020 18:48:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH] KUnit: Docs: fix a wording typo
Date:   Tue, 27 Oct 2020 11:48:53 -0700
Message-Id: <20201027184853.20830-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix a wording typo (keyboard glitch).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/faq.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201027.orig/Documentation/dev-tools/kunit/faq.rst
+++ linux-next-20201027/Documentation/dev-tools/kunit/faq.rst
@@ -90,7 +90,7 @@ things to try.
    re-run kunit_tool.
 5. Try to run ``make ARCH=um defconfig`` before running ``kunit.py run``. This
    may help clean up any residual config items which could be causing problems.
-6. Finally, try running KUnit outside UML. KUnit and KUnit tests can run be
+6. Finally, try running KUnit outside UML. KUnit and KUnit tests can be
    built into any kernel, or can be built as a module and loaded at runtime.
    Doing so should allow you to determine if UML is causing the issue you're
    seeing. When tests are built-in, they will execute when the kernel boots, and
