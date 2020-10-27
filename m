Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C162D29C7C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829124AbgJ0StV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 14:49:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38712 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829117AbgJ0StQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 14:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=46Byy3Rt7NiFA9tn4Js32CXeLAf2iqHq9BuLVB2Ne/U=; b=1zdoLICv1XhcaJtSVlHYDS2FBr
        TZ+cvKhtf/4Wp59eTV6qTMjIRIIib02AuDj+iN4aI6+4261zSvmHbpvZE+1r06f8DkHTxaaUSadzW
        nYzebO6Y5xXb75jPI96C875iIAUoF0NVusWU/C5iWC6MbW2ZCnhdMa8KAW4IAfFJqRyUorulRRfgq
        pP9UYeHRuEL1QKkpFTJ7yhwLB9HIUlT8Xis8HiwakwTt8EhIM8hSC6aXForWjFYa63RyJr8n617uC
        zrVN7FRW7FjQhbl1bimjtx61K+rLhoK+ls/VpLDrEfBGzsL6ADBofQreaXkWzRlevaNuHrw2Sb+wS
        RTykY0og==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXU1y-0008AW-Ik; Tue, 27 Oct 2020 18:49:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH] KUnit: Docs: style: fix some Kconfig example issues
Date:   Tue, 27 Oct 2020 11:49:09 -0700
Message-Id: <20201027184909.20881-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the Kconfig example to be closer to Kconfig coding style.
(Except that it still uses spaces instead of tabs for indentation;
I guess that Sphinx wants it that way.)

Also add punctuation and a trailing slash ('/') to a sub-directory
name -- this is how the text mostly appears in other Kconfig files.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/style.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20201027.orig/Documentation/dev-tools/kunit/style.rst
+++ linux-next-20201027/Documentation/dev-tools/kunit/style.rst
@@ -180,12 +180,12 @@ An example Kconfig entry:
                 depends on KUNIT
                 default KUNIT_ALL_TESTS
                 help
-                    This builds unit tests for foo.
+                  This builds unit tests for foo.
 
-                    For more information on KUnit and unit tests in general, please refer
-                    to the KUnit documentation in Documentation/dev-tools/kunit
+                  For more information on KUnit and unit tests in general, please refer
+                  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
-                    If unsure, say N
+                  If unsure, say N.
 
 
 Test File and Module Names
