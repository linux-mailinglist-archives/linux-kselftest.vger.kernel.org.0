Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A521421DF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 07:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhJEFcL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 01:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEFcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 01:32:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9491C061745;
        Mon,  4 Oct 2021 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZwdSb4hH1QTGvodRLIIEgKbVS753IWCsfQMr66VwocA=; b=aGAzxtAZFMbFkqrxhDfwcq0yH9
        vWpms2jvme98Fv4r7ZIFLQ+zazjEO7LmICt5O3wO9WPIINQFw7I4xAQwOWZfZ55De5t91tGJ7toPH
        kwCwrW2yQ96tgi2LaoF3rjlc0FBnCii0JCj827Kg+UXH1LHQ5AVdDEW4pDyugbPrDmZMPnfyVVeiO
        1N7DwJZUB8ADbsBvE0aSUuEPcYq/rp8zlWuY36rmfEfa43581a1rXXzsPRjSybp0QInPJW4pdwIFz
        Wlh5HvJcDOYBXbviIj3QVlqrM6ydfsvOzqnVhtAJiErcvK3Bl5/2PrH/AHNVIVzqJqD5i35Cr49mM
        HtyDfDtA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXd1w-008yyl-8k; Tue, 05 Oct 2021 05:30:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] kunit: fix kernel-doc warnings in doc. build
Date:   Mon,  4 Oct 2021 22:30:19 -0700
Message-Id: <20211005053019.26284-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix documentation build warnings in <kunit/test.h>:

../include/kunit/test.h:616: warning: Function parameter or member 'flags' not described in 'kunit_kmalloc_array'
../include/kunit/test.h:616: warning: Excess function parameter 'gfp' description in 'kunit_kmalloc_array'
../include/kunit/test.h:661: warning: Function parameter or member 'flags' not described in 'kunit_kcalloc'
../include/kunit/test.h:661: warning: Excess function parameter 'gfp' description in 'kunit_kcalloc'

Fixes: 0a756853586c ("kunit: test: add test resource management API")
Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
---
 include/kunit/test.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-515-rc4.orig/include/kunit/test.h
+++ lnx-515-rc4/include/kunit/test.h
@@ -607,7 +607,7 @@ void kunit_remove_resource(struct kunit
  * @test: The test context object.
  * @n: number of elements.
  * @size: The size in bytes of the desired memory.
- * @gfp: flags passed to underlying kmalloc().
+ * @flags: gfp flags passed to underlying kmalloc().
  *
  * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
  * and is automatically cleaned up after the test case concludes. See &struct
@@ -653,7 +653,7 @@ static inline void *kunit_kzalloc(struct
  * @test: The test context object.
  * @n: number of elements.
  * @size: The size in bytes of the desired memory.
- * @gfp: flags passed to underlying kmalloc().
+ * @flags: gfp flags passed to underlying kmalloc().
  *
  * See kcalloc() and kunit_kmalloc_array() for more information.
  */
