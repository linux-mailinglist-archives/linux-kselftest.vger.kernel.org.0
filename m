Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA429D615
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgJ1WLk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgJ1WLi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86FC0613D3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UuWciXtDDMkvKh0Vv+GVLGgNQQOwDDD9jqSv8mkONwA=; b=I6lk8Hx+YtZLEeLtSc1E5QRXeR
        Ak9LUcdMvh8Ur2JJqCOUZPfWCfauGFeTnRpmYrBnAxNR8SXY8ntNaelx8POwCANijIzc+1kV1BNmz
        qrMybcCzW8k5NkjVwde57qCbB28odbFImsjLIsJ817Pbk7p9s1MGgDmQDRrVptNZeMbAsI3CRyC/6
        hUPIVPTHJGTIQamK1neUpF38LfMdZ8aXSqhAyxn3xXPapE6iYnQZWTHeHnMia0tw/13Amgpa3rWMs
        Xxueu2CsiuJ3DIO2sUvImj3rORv7V3ZXgNFW0lfmS8IDfGffHS8ZPepBAdkU0cKwz2xUxYGdjjELG
        JumX3F3w==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXpSp-0007Qd-KC; Wed, 28 Oct 2020 17:42:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2] KUnit: Docs: style: fix some Kconfig example issues
Date:   Wed, 28 Oct 2020 10:42:18 -0700
Message-Id: <20201028174218.11750-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the Kconfig example to be closer to Kconfig coding style.

Also add punctuation and a trailing slash ('/') to a sub-directory
name -- this is how the text mostly appears in other Kconfig files.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v2: covert spaces indentation to tabs in Kconfig example

 Documentation/dev-tools/kunit/style.rst |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20201027.orig/Documentation/dev-tools/kunit/style.rst
+++ linux-next-20201027/Documentation/dev-tools/kunit/style.rst
@@ -175,17 +175,17 @@ An example Kconfig entry:
 
 .. code-block:: none
 
-        config FOO_KUNIT_TEST
-                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
-                depends on KUNIT
-                default KUNIT_ALL_TESTS
-                help
-                    This builds unit tests for foo.
+	config FOO_KUNIT_TEST
+		tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
+		depends on KUNIT
+		default KUNIT_ALL_TESTS
+		help
+		  This builds unit tests for foo.
 
-                    For more information on KUnit and unit tests in general, please refer
-                    to the KUnit documentation in Documentation/dev-tools/kunit
+		  For more information on KUnit and unit tests in general, please refer
+		  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
-                    If unsure, say N
+		  If unsure, say N.
 
 
 Test File and Module Names
