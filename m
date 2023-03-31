Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC356D1949
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCaIE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCaIE0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:04:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04A1BF6
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5417f156cb9so213830667b3.8
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680249863;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=al17D1L4XTbs4pYJ8zF9ZEmB1iUe7QZQUslg7cjDk8k=;
        b=NN5rllUn7z5cAukKAQhp1rwdUXUdXZCk6Agwukpukqrju6mzhYQD89E0c0Z5tmy59G
         8Vs1PvmVRMYA+fl3fDiKvm6z9SobcVYWtJaIxBneiAHptry7HDItaF0wiobXVPAvvQk6
         /ggYZ7qPZGfiN2lWSJx6uF21Q1Qr+t396NThNAZvx/KVgm3+o/AFnvmghY+4mX+aDi39
         ER8ElTBFLcYwMmwX0VfE4kWGeoc9Vd3tS6vWCh01voFFWuugYoN2HpKYoYxcEkm2yWvV
         UdXlm4UNrhb/QrcsuCJmI2gFkx74A6PsTBly7tMU0tGIyWdNwnjdg3qfbTRG40ylN1Ri
         YbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=al17D1L4XTbs4pYJ8zF9ZEmB1iUe7QZQUslg7cjDk8k=;
        b=SCn3eQKUhQQQmV0yvePtsy65cUToeovG6QvOwNl9fEKVs6i0BlwDvd6Zxu+zlVtJa6
         ftOqQM321NsORkJ/1kcPHF275typeGbdpZbgEPkJjEwTM0BtgWdKZibTFc+wNQM4BS+8
         jLACyXuwRjdMl4HUElOSxOBPLdL7KZDOPIQkP1wqyXI0L2s4FayEafBGS5OSYPP4L74x
         G6b9ceAMVQvL7biZ6u+iRWhYKCdsZ1T632QXcbWMapCJRRRzHFcFZ23p6kOUEwVvMbrr
         GV7vTxs5eeqOV90qc9LdXvBPHwb+yQrXBI5Fl+iJxAYvY5eQ0erdfABlsxNsB9yRKCWQ
         Bs3g==
X-Gm-Message-State: AAQBX9crbluH2hjfynEsQKU+Io599ZHhZhMv4O+ZDF6vC8ASj/u5LUzY
        QSweVAxZIFWeSd1qne+lHNw5NhHbBr8mlQ==
X-Google-Smtp-Source: AKy350ZxG+yXW6g9M5yV6cRAcHZv4Z0HyMWh+Hc60ubXYENYkJHfxhXSDOav7MWL5llndfGIzfWA4uu5IQ3Wmw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:b349:0:b0:544:b7ff:b0df with SMTP id
 r70-20020a81b349000000b00544b7ffb0dfmr13295561ywh.2.1680249863505; Fri, 31
 Mar 2023 01:04:23 -0700 (PDT)
Date:   Fri, 31 Mar 2023 16:04:08 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331080411.981038-1-davidgow@google.com>
Subject: [RFC PATCH v2 0/3] kunit: Deferred action helpers
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a follow-up to the kunit_defer() parts of 'KUnit device API
proposal'[1], with a number of changes suggested by Matti Vaittinen,
Maxime Ripard and Benjamin Berg.

Most notably, kunit_defer() has been renamed to kunit_add_action(), in
order to match the equivalent devres API[2]. Likewise:
kunit_defer_cancel() has become kunit_remove_action(), and
kunit_defer_trigger() has become kunit_release_action().

The _token() versions of these APIs remain, for the moment, even though
they're a bit more awkward and less useful, as they have two advantages:
1. They're faster, as the action doesn't need to be looked up.
2. They provide more flexibility in the ordering of actions in cases
where several identical actions are interleaved with other, different
actions.

Similarly, the internal_gfp argument remains for now, as this is useful
in implementing kunit_kalloc() and similar.

The implementation now uses a single allocation for both the
kunit_resource and the kunit_action_ctx (previously kunit_defer_ctx).

The 'cancellation token' is now of type 'struct kunit_action_ctx',
instead of void*.

Tests have been added to the kunit-resource-test suite which exercise
this functionality. Similarly, the kunit executor tests and
kunit allocation functions have been updated to make use of this API.

I'd love to hear any further thoughts!

Cheers,
-- David


[1]: https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/
[2]: https://docs.kernel.org/driver-api/basics.html#c.devm_add_action

David Gow (3):
  kunit: Add kunit_add_action() to defer a call until test exit
  kunit: executor_test: Use kunit_add_action()
  kunit: kmalloc_array: Use kunit_add_action()

 include/kunit/resource.h  |  89 +++++++++++++++++++++++++++
 lib/kunit/executor_test.c |  12 ++--
 lib/kunit/kunit-test.c    | 123 +++++++++++++++++++++++++++++++++++++-
 lib/kunit/resource.c      |  99 ++++++++++++++++++++++++++++++
 lib/kunit/test.c          |  48 +++------------
 5 files changed, 323 insertions(+), 48 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

