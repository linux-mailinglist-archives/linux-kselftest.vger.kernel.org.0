Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19041CE0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346963AbhI2V3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346950AbhI2V3G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 17:29:06 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50907C06176F
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 14:27:24 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h4-20020a05620a244400b004334ede5036so11179303qkn.13
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=cNc6jGThnDjPI1ROaAIDOXBHBBn9Ts0TfXP/c2N4EQM=;
        b=nXw3HxSp5/gbJuY/9VKOMd5rZ8zWZg+1bd3t6obcZvqMyAjqEvuu/VsFXwfvFdDBXj
         4Y5mgz8TDfHMA2MFbUKUu7wOgepF8QOGz55Axa9zrO0m4gUfZPPPD/c1i7qcBY1yxPCE
         8m2BF6Ds1jIgEjTeM8DmxQ5kif+7bmMqD6PVbYxyELJRGMRMpZWFq7JBR4G3ay8K5xKD
         xBG/hW0nBEn6do2u0BObmIwuDDbHR8az7TWLkCuTa4R8THFGK79eX8+ILMyL/n8LSoQl
         6bCSvqYE1F3vVP+jP9p1wmpkYmajdeSdc7ioI+zAzxrDb5coKV9M3Hm/J2edqL63zdO5
         IBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=cNc6jGThnDjPI1ROaAIDOXBHBBn9Ts0TfXP/c2N4EQM=;
        b=FMO12FbwbQPyIKlOAAjeWPdYT64XX/WEG3cCBr+xs/ycM3iS1S9UuH5pKvoa4rnvWq
         +lVIcf3dOm3HEuiK2wVGF2AKuTOxNlS6nZTCr9MgojgU04vNZOTT3uJGM4h86LxHoJq5
         uWbDANSvcGuz9/Ty/KKxHs9Z6FHXvuX8jXJivlZHav4oOm8re6lJFMqRZexIZNF2VooH
         Eac54L1XCnDm7QjD+HF7IiNehB3g6jR3VHEQtVSJ8SIviukUOT6EvvcbG+JGd7QoFQfr
         3Jz59VvhenTFoLNfKdi1LOBbvd2rB1N+4S4JyVJDcwWtqsyaZum1mkxOiu1mQXey5QSF
         CN4w==
X-Gm-Message-State: AOAM533bJC5wrzYLbm4OtDxDVJd+AGg91+NAuo4isyHoq7vMkGreLC0e
        guy+qZCjRBKAyENaCYEYxMNnedlJjHU4qZc7iWeVyg==
X-Google-Smtp-Source: ABdhPJx7qZ1J1thbDsoanP0bIyXW9jDN+YJBHFsBhknKK0oqEnDw16L75o14KW5MsBNjdljYyD/29vAPPuj0wnNt+PjTgQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6214:a6c:: with SMTP id
 ef12mr578832qvb.2.1632950843457; Wed, 29 Sep 2021 14:27:23 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:10 -0700
In-Reply-To: <20210929212713.1213476-1-brendanhiggins@google.com>
Message-Id: <20210929212713.1213476-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210929212713.1213476-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 2/5] iio/test-format: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit:

../drivers/iio/test/iio-test-format.c: In function =E2=80=98iio_test_iio_fo=
rmat_value_fixedpoint=E2=80=99:
../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336=
 bytes is larger than 2048 bytes [-Wframe-larger-than=3D]

Turn it off in this file.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since last revision:
 - None
---
 drivers/iio/test/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f1099b4953014..467519a2027e5 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,3 +5,4 @@
=20
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_TEST_FORMAT) +=3D iio-test-format.o
+CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
--=20
2.33.0.685.g46640cef36-goog

