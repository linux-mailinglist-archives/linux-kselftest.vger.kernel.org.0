Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2739F15E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFHItt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhFHIts (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 04:49:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8337C061574;
        Tue,  8 Jun 2021 01:47:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so23559905edt.13;
        Tue, 08 Jun 2021 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LP7nFbnq6qcvyOkQ/eqHCyZ+QiHn+JFAk2tG3rdzWY0=;
        b=a5lhZhCl4AX7h6pLmBkkfx7R11USW00VKxiXbXALgVc5vkrtjTjeOVgj9jXZN6tcHb
         fYBSh1O/SDjL6Td6zIMEshaMw4L8k/+HL/Tp4EFvFiL7gYyQYu77t304qKA/Jcxldmhp
         ILBz+FtGwLdvaO4KcTfzo6cG3SFQeDCKO5zhthJLLG93Cvk56YMSo57jFcY5/Fci+NTH
         uJtovpPUpYSdXp4HmL8MBG0bZmUBxFJwbwTTEkDGGTRFKCuoARidW3du+833tke49CmJ
         8D6AYB6xjFt4th+6z0x3IJ/YQ34kr6HV4RHt6bmd3G3Ze7PEX2xrWKtCVLvA+e7qGWwA
         8V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LP7nFbnq6qcvyOkQ/eqHCyZ+QiHn+JFAk2tG3rdzWY0=;
        b=V6k5nSJ5kN3n1tIRS0fDce8Ds3e7AOYVa5lsCcxFCZzRs4e34Iakn88rPPVnrYjgWe
         o+ePjlyy2iRX+7niS4QMGwZQma+Byktgy5vNooKQgxjpZzYtXROZnR2y/rowXtX60yEK
         ElsXWXeE5tUpbbfUadujBD8KKViU7cFc1OoDUMR8LpquD1nXtm1/1+ZWJXz1ASqWfCHF
         hd67ZvdmlU6q7krLX3F+lK1LrdQfsrpXRyCS+i6xl7mOC8bKwX1uxQ2Jdt7ge4jDiIHi
         TYHwJLaSShBEP40nYH8Sw2krDhYpZDTJYhYP9josP29VfDnhAEoAi3Wuk4vJgPdLDTbk
         UEfA==
X-Gm-Message-State: AOAM531dOFLYQOqH4rfjabS2fuUlJo9MPjFOjy+m5K42lfE8dyyPwvU4
        4Hc6aNGtE+4CJBItLX9Lqxg=
X-Google-Smtp-Source: ABdhPJxbozwNM8CusgeCC8jfXCJ0vbl4GQkbSksYzTs9VzuuME+SXmGvS3eOYxxG25rtPYTwZyDY9g==
X-Received: by 2002:a05:6402:3082:: with SMTP id de2mr12038774edb.214.1623142062429;
        Tue, 08 Jun 2021 01:47:42 -0700 (PDT)
Received: from localhost.localdomain (ispc-static-34.84-47-111.telekom.sk. [84.47.111.34])
        by smtp.gmail.com with ESMTPSA id p13sm8556583edq.67.2021.06.08.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:47:42 -0700 (PDT)
From:   glittao@gmail.com
To:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>
Subject: [PATCH] docs: add documentation for SLUB cache kunit tests
Date:   Tue,  8 Jun 2021 10:47:40 +0200
Message-Id: <20210608084740.6282-1-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Add documentation for a KUnit test for SLUB debugging functionality.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 Documentation/vm/slub.rst | 104 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 03f294a638bd..ca82fc1649ee 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -384,5 +384,109 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
       40,60`` range will plot only samples collected between 40th and
       60th seconds).

+KUnit tests for SLUB debugging functionality
+============================================
+
+These KUnit tests are used to test some of the SLUB debugging
+functionalities.
+
+KUnit tests are used for unit testing in Linux kernel and easy to run,
+so it is probably the best choice for this type of tests.
+
+There are tests, which corrupt redzone, the free objects and the freelist.
+Tests are corrupting specific bytes in cache and checking if validation
+finds expected number of bugs. Bug reports are silenced.
+
+Config option
+
+In order to built and then run this tests you need to switch
+option SLUB_KUNIT_TEST on. It is tristate option so it can also
+be built as a module. This option depends on SLUB_DEBUG and
+KUNIT options. By default it is on with all kunit tests.
+
+Error counting
+
+To get number of errors discovered in slub is used test API kunit_resource.
+In test_init the reference to the integer variable slab_errors is added
+to the resource of this tests.
+
+During slub cache checking always when bug should be reported or fixed function
+slab_add_kunit_errors() is called. This function find resource to kunit test
+and increment value of data in founded resource, which is slab_errors
+variable.
+
+Silence bug reports
+
+The function slab_add_kunit_errors() is returning bool, which is true if there is kunit test
+with correct kunit_resource running, to silence bug reports, so they are not printed.
+We do not want to correct errors we only want to know they occurred, so these reports
+are unnnecessary.
+
+KASAN option
+
+Only 2 out of 5 tests are runnig with KASAN option is on.
+The other three tests deliberately modifies non-allocated objects. And KASAN
+does not detect some errors in the same way as SLUB_DEBUG. So, these tests
+does not run when KASAN option is on.
+
+TESTS
+
+1. test_clobber_zone
+
+   SLUB cache with SLUB_REDZONE flag can detects writings after object. This
+   functionality is tested here on allocated memory.
+
+   First, there is allocated memory with SLAB_REDZONE and then the first byte
+   after allocated space is modified. Validation founds 2 errors, because of
+   the bug and the fix of the memory.
+
+
+2. test_next_pointer
+
+   SLUB have list of free objects and the address of the next free object
+   is always saved in free object at offset specified in variable offset
+   in struct kmem_cache. This test try to corrupt this freelist and
+   then correct it.
+
+   First, there is allocated and freed memory to get a pointer to free object.
+   After that, the pointer to next free object is corrupted. The first validation finds
+   3 errors. One for corrupted freechain, the second for the wrong count of objects
+   in use and the third for fixing the issue. This fix only set number of objects
+   in use to a number of all objects minus 1, because the first free object
+   was corrupted.
+
+   Then the free pointer is fixed to his previous value. The second validation finds
+   2 errors. One for the wrong count of objects in use and one for fixing this error.
+
+   Last validation is used to check if all errors were corrected so no error
+   is found.
+
+3. test_first_word
+
+   SLUB cache with SLAB_POISON flag can detect poisoning free objects. This
+   functionality is tested in this test. The test tries to corrupt
+   the first byte in freed memory.
+
+   First of all, memory is allocated and freed to get a pointer to a free object
+   and then the first byte is corrupted. After that, validation finds 2 errors,
+   one for the bug and the other one for the fix of the memory.
+
+4. test_clobber_50th_byte
+
+   In this test SLAB_POISON functionality is tested. The test tries to
+   corrupt the 50th byte in freed memory.
+
+   First, pointer to a free memory is acquired by allocating and freeing memory.
+   Then 50th byte is corrupted and validation finds 2 errors for the bug and
+   the fix of the memory.
+
+5. test_clobber_redzone_free
+
+   This test tests redzone functionality of SLUB cache on a freed object.
+
+   First, it gets pointer to the free object with allocating and freeing and
+   then corrupts the first byte after the freed object. Validation finds
+   2 errors for the bug and the fix of the memory.
+
 Christoph Lameter, May 30, 2007
 Sergey Senozhatsky, October 23, 2015
--
2.31.1.272.g89b43f80a5

