Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19955F175A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 02:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiJAA1Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 20:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiJAA1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 20:27:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8DF13F724
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nl8-20020a17090b384800b00205f930565cso2879636pjb.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=Yx9Af8bOm1bsyDcoY6iyCuhMNlgDZrO5QF0W+Ekocqw=;
        b=bhIGnFwnLLvNwjKym8nryqeCeLf27mms3ruZCiRQ3ydGnjrlcGJ0Vocut3wbgyHkJk
         AlNKztjHrJBWGmA/kL04zh7VVwyw+yQkkn4MTwgBMISHSpnwnsfvRF7WDjTnJx/nm6Bz
         DlOF2jil+2Td9Ho7/esm3pSrHYE+gSweJInHxv5nZx05C4iNzGthOzeFk20LfZ8qRa9A
         9tcREyDXHpVuwvi+VtSONUB0UhGYw3ZcCPFZvZyajMzsD+NEVli9wWV7/+z6XB1BCu0b
         wW8mVlT3uhFsdqWXTYKcX605d0+pXJxWi0gX6sH1wmdut1xN4pZs7ERfDsrDh2ddkAgi
         ke/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Yx9Af8bOm1bsyDcoY6iyCuhMNlgDZrO5QF0W+Ekocqw=;
        b=aI5MM/sx7qfcySUxkESh917hY35rixLx67R1RYmqcznoWW22CtwBahiaEUIxV1kqcJ
         ZHPv6k6m0lqRpke6tYjc/dnHEH5IB6UTu7UQ8QGxEbmP5zmzIECqkX06CTHOIvcOymya
         HZZP9eyYn3LkMLg5n5NYtLaw6K0ALprujWrqxFqVCjoxYFbWoscSwFmRV27gBOpJwo4W
         nvBADK9hPcttTfiaT+Kz5veHK5Bg5b73DQdZ6z4hSeKhMFD5uQQvkn7NnCsNWYS7P8wW
         930Ks9BVoY9rqBxVKBQ8kZ3dNntKR6fVl0GGcJy0Z3wY5HpaqQrs+POt/6+As/qB/6rs
         0Lpg==
X-Gm-Message-State: ACrzQf394tQ7DznHSG1xcx0y59pRu4fVlnrj3aPbMV04iroGs2KmKbY8
        N8DAJV1RNmrnVYZUGLlPMz7d2kqi9Goslw==
X-Google-Smtp-Source: AMsMyM5IVFTekcKTXajYLNEacNQl/AJjlItV2LaBQSe6tFMBniwHDLo5aMjZrr2ICNNW+bUOV4VEHjVZ1m6uFQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:26d1:b0:53e:1d86:bead with SMTP
 id p17-20020a056a0026d100b0053e1d86beadmr11687414pfw.26.1664584006167; Fri,
 30 Sep 2022 17:26:46 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:26:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001002638.2881842-1-dlatypov@google.com>
Subject: [PATCH 0/4] kunit: more assertion reworking
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        miguel.ojeda.sandonis@gmail.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RFC: https://lore.kernel.org/linux-kselftest/20220525154442.1438081-1-dlatypov@google.com/
Changes since then: tweak commit messages, reformatting to make
  checkpatch.pl happy. Nothing substantial.
Why send this out again now: the initial Rust patchset no longer
  contains the Kunit changes, so hopefully both series can go into 6.1
  and later we can coordinate the update the kunit.rs wrapper.

This is a follow up to these three series:
https://lore.kernel.org/all/20220113165931.451305-1-dlatypov@google.com/
https://lore.kernel.org/all/20220118223506.1701553-1-dlatypov@google.com/
https://lore.kernel.org/all/20220125210011.3817742-1-dlatypov@google.com/

The two goals of those series were
a) reduce the size of struct kunit_assert and friends.
   (struct kunit_assert went from 48 => 8 bytes on UML.)
b) simplify the internal code, mostly by deleting macros

This series goes further
a) sizeof(struct kunit_assert) = 0 now
b) e.g. we delete another class of macros (KUNIT_INIT_*_ASSERT_STRUCT)

Note: this does change the function signature of
kunit_do_failed_assertion, so we'd need to update the rust wrapper in
https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs,
but hopefully it's just a simple change, e.g. maybe just like:
@@ -38,9 +38,7 @@
             });
             static CONDITION: &'static $crate::str::CStr =
$crate::c_str!(stringify!($cond));
             static ASSERTION: UnaryAssert =
UnaryAssert($crate::bindings::kunit_unary_assert {
-                assert: $crate::bindings::kunit_assert {
-                    format: Some($crate::bindings::kunit_unary_assert_format),
-                },
+                assert: $crate::bindings::kunit_assert {},
                 condition: CONDITION.as_char_ptr(),
                 expected_true: true,
             });
@@ -67,6 +65,7 @@
                     core::ptr::addr_of!(LOCATION.0),
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
                     core::ptr::addr_of!(ASSERTION.0.assert),
+                    Some($crate::bindings::kunit_unary_assert_format),
                     core::ptr::null(),
                 );
             }


Daniel Latypov (4):
  kunit: remove format func from struct kunit_assert, get it to 0 bytes
  kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
  kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
  kunit: declare kunit_assert structs as const

 include/kunit/assert.h |  74 ++----------------------
 include/kunit/test.h   | 127 +++++++++++++++++++++++------------------
 lib/kunit/test.c       |   7 ++-
 3 files changed, 80 insertions(+), 128 deletions(-)


base-commit: 511cce163b75bc3933fa3de769a82bb7e8663f2b
-- 
2.38.0.rc1.362.ged0d419d3c-goog

