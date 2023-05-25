Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2EC710408
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbjEYEWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 00:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjEYEWF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 00:22:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51264189
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 21:21:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb7aaa605so274698276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684988518; x=1687580518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=98GS1yBDh3h/h+5NjI7rziULFIid1JDrRb2JVZKNFRg=;
        b=TrJRb1gjIODGA9G7zYo/ODm6PuuPJltD0EoZbN0FAIcLUYYdMaLXh/5IU8HVTcKVNC
         k5wzgdMdFokn8teszJWIGewAhgthSJ74xEx25ozikYO4GrC1VIY3sorovF/gMq6ZX8Zx
         RSDyJE4ZK71g5Sayo/ckvyuUtEdT58zK8TiCXOs845fYwWqyYgM6t/IlPm9s94x46BPA
         QYa/+wL5NzxrwcR94nzoNAE5aOkb8ZCSVbdSXHWA6Ppz8CUSLXOWnbJFX696ET55oULe
         HtqAD7LaZhWbSRN9YFONBTv1QH4ns7fJ+2CdjxdLZeiNql45+MpaB+baDQF3WYiyYyUb
         0wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684988518; x=1687580518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98GS1yBDh3h/h+5NjI7rziULFIid1JDrRb2JVZKNFRg=;
        b=ihFHzxeZu+m1Jyx26Kt4mQZXWXB7kAJ+fsjumC3N3Hz5zcmD8D+3od28cRK58VyR7x
         LHU26rsF4rAlKaMaHQxCFReIT3+DQZ4QapKtMbdqNzIz2cJ7GKOt7jdMBzQ30Y4V6SnX
         LXHo6WEnutz3MsIllIBlTOSOKL0XzN8m86Nl6Jztx3HlaR/LbJqA7mVhkR67A/KMtWA6
         zMDXV5u4N9qdNt02aCFRyTSst+/kNYepTl+OeY5roiycL2J/K2hltCR/1p89BwnP6KLb
         n8gUO4l7+pUU4U1O+yYRGKGWL4M8PPji9chPtkG8UOB1pBg+Me/M0cwxO2xxi8JAwSTX
         EQMQ==
X-Gm-Message-State: AC+VfDylWJxkeSl/xgJ29Y5wfT3mYjvaSI5wmDZDcUA6+7jbzs75MSqz
        QBbAKv5RUrkLTeRpvlCAOp6ngRbryS+IOQ==
X-Google-Smtp-Source: ACHHUZ7gMiNS3iV21rOO3brq86ZzcHBDRBwpvNy6cIuEboXIgU711R2ZSvPfIrHn1P2qoneGVAb2ZjtNAv4qNQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1024:b0:ba8:6422:7fc with SMTP
 id x4-20020a056902102400b00ba8642207fcmr1455878ybt.7.1684988518586; Wed, 24
 May 2023 21:21:58 -0700 (PDT)
Date:   Thu, 25 May 2023 12:21:31 +0800
In-Reply-To: <20230525042133.212534-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230525042133.212534-1-davidgow@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230525042133.212534-4-davidgow@google.com>
Subject: [PATCH v3 4/4] Documentation: kunit: Add usage notes for kunit_add_action()
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic documentation for kunit_add_action() and related
deferred action functions.

Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20230518083849.2631178-4-davidgow@google.com/
- Fix a couple of typos (Thanks Bagas, Rae)
- Add Rae's Reviewed-by.

This patch is new in v2.

---
 Documentation/dev-tools/kunit/usage.rst | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 46957d1cbcbb..c27e1646ecd9 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -615,6 +615,57 @@ For example:
 		KUNIT_ASSERT_STREQ(test, buffer, "");
 	}
 
+Registering Cleanup Actions
+---------------------------
+
+If you need to perform some cleanup beyond simple use of ``kunit_kzalloc``,
+you can register a custom "deferred action", which is a cleanup function
+run when the test exits (whether cleanly, or via a failed assertion).
+
+Actions are simple functions with no return value, and a single ``void*``
+context argument, and fulfill the same role as "cleanup" functions in Python
+and Go tests, "defer" statements in languages which support them, and
+(in some cases) destructors in RAII languages.
+
+These are very useful for unregistering things from global lists, closing
+files or other resources, or freeing resources.
+
+For example:
+
+.. code-block:: C
+
+	static void cleanup_device(void *ctx)
+	{
+		struct device *dev = (struct device *)ctx;
+
+		device_unregister(dev);
+	}
+
+	void example_device_test(struct kunit *test)
+	{
+		struct my_device dev;
+
+		device_register(&dev);
+
+		kunit_add_action(test, &cleanup_device, &dev);
+	}
+
+Note that, for functions like device_unregister which only accept a single
+pointer-sized argument, it's possible to directly cast that function to
+a ``kunit_action_t`` rather than writing a wrapper function, for example:
+
+.. code-block:: C
+
+	kunit_add_action(test, (kunit_action_t *)&device_unregister, &dev);
+
+``kunit_add_action`` can fail if, for example, the system is out of memory.
+You can use ``kunit_add_action_or_reset`` instead which runs the action
+immediately if it cannot be deferred.
+
+If you need more control over when the cleanup function is called, you
+can trigger it early using ``kunit_release_action``, or cancel it entirely
+with ``kunit_remove_action``.
+
 
 Testing Static Functions
 ------------------------
-- 
2.41.0.rc0.172.g3f132b7071-goog

