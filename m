Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655B26EA614
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjDUImi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDUImh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 04:42:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94029ECF
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9229dd8c62so831370276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682066554; x=1684658554;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QGXOKGPxsKPcSFgjvDkI3vSUdEdauxGxM1p17ciSeaI=;
        b=Esgx9zyyjLS5OCFGZfFwCHh48kNPrlj1bsa6c0C+jg+cfvMjYfR9JuaInhoY3gw8SS
         72lgscYbhd5YLbNmfxMp6kWNl53Iovt1oNCa6ErttW7q+r9SgHaO2RQtufUBbyKN05nm
         qBNrY0AqYMrzJPONvh2zgGuZJYkj0OtXeqYkHWLAIiUtbQiKq/vKgayqEu3sf0vnn5mf
         yMS2/ecQTC5eyYcHsMusvSVAWTK4uLSYW4f4kzwooeb3GAGh2y8hbij3cUgca/JNNOit
         xt43VzYG2WbGjSVaU0t/n+HzCF0ILN2Fg+b9NTauH8dKz2p28cGlVNZI/TxOgcw2QfQk
         VeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066554; x=1684658554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGXOKGPxsKPcSFgjvDkI3vSUdEdauxGxM1p17ciSeaI=;
        b=dBLsi+8YWrtFY0uD8r3T8joEvVKAXdvSH8lfBB5yZFzyCSLx2/iPIMNT5C+ZcxXopU
         lajnwl/i4RlGmV9QW9ToIVaAzbJWO9H+e8pSKJjzl6N/uhbACe75K6q9+djVEv3jCHF2
         5rbw/EjgQgFzC5uWE2SkZAzyf9bfUC7JFwzyF0tc3h2Q0guBcvfS5cTRsQhK7H5nWzmI
         76gOZEk7QgtIw6mf0vIeTTCaHfpDDN3A/BUBUN5PrBTt88laKUaUd2yYQ5UUAX7ql9oW
         ZY2hot3HS0A4IjAtejC+9VROHalo/oVCd3CTyEwqtaFu/U/ivYn0V/zvouoBFvlo9h4Q
         sRvA==
X-Gm-Message-State: AAQBX9fF9RsnqRmHfzIWk4u0xD3XV2jt9n4Qoj15fItmLDoOhmIkfmAk
        WtE2PyVOQViJxmSNHQUvmoAwjgF//RL6ew==
X-Google-Smtp-Source: AKy350aFjacPDXmbpRbnA+UWGmGe7fhOAKVdHu+v3geELGlp8dwCo0xY2ydK+m/d9fG2oMX2N3hSoaofqWWt6Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:7401:0:b0:b8f:32c4:5cc4 with SMTP id
 p1-20020a257401000000b00b8f32c45cc4mr1242275ybc.4.1682066553902; Fri, 21 Apr
 2023 01:42:33 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:42:23 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421084226.2278282-1-davidgow@google.com>
Subject: [PATCH v1 0/3] kunit: Deferred action helpers
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is v1 of the KUnit deferred actions API, which implements an
equivalent of devm_add_action[1] on top of KUnit managed resources. This
provides a simple way of scheduling a function to run when the test
terminates (whether successfully, or with an error). It's therefore very
useful for freeing resources, or otherwise cleaning up.

The notable changes since RFCv2[2] are:
- Got rid of the 'cancellation token' concept. It was overcomplicated,
  and we can add it back if we need to.
- kunit_add_action() therefore now returns 0 on success, and an error
  otherwise (like devm_add_action()). Though you may wish to use:
- Added kunit_add_action_or_reset(), which will call the deferred
  function if an error occurs. (See devm_add_action_or_reset()). This
  also returns an error on failure, which can be asserted safely.
- Got rid of the function pointer typedef. Personally, I liked it, but
  it's more typedef-y than most kernel code.
- Got rid of the 'internal_gfp' argument: all internal state is now
  allocated with GFP_KERNEL. The main KUnit resource API can be used
  instead if this doesn't work for your use-case.

I'd love to hear any further thoughts!

Cheers,
-- David

[1]: https://docs.kernel.org/driver-api/basics.html#c.devm_add_action
[2]: https://patchwork.kernel.org/project/linux-kselftest/list/?series=735720


David Gow (3):
  kunit: Add kunit_add_action() to defer a call until test exit
  kunit: executor_test: Use kunit_add_action()
  kunit: kmalloc_array: Use kunit_add_action()

 include/kunit/resource.h  | 76 +++++++++++++++++++++++++++++++
 include/kunit/test.h      | 10 ++++-
 lib/kunit/executor_test.c | 11 ++---
 lib/kunit/kunit-test.c    | 88 +++++++++++++++++++++++++++++++++++-
 lib/kunit/resource.c      | 95 +++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c          | 48 ++++----------------
 6 files changed, 279 insertions(+), 49 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

