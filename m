Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41729534090
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbiEYPpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiEYPo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 11:44:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF97B57B25
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:44:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id on14-20020a17090b1d0e00b001c7a548e4f7so1453289pjb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GgY7NSiX6uiGDtMHlohDtQsx1OJlx0SAIigzyTay35s=;
        b=jowgYFt7SEavOK8Pjjl0zBdyPggQe+XS6DE8u89llg5eDqiCPe3JleZudMhvvt60Tx
         KUrtmfXVebiCd4AudyFe5/7URbeh3YLBqpZsFGhazkj4rewAPV3pPdlvshEi+2gezxEH
         mUCy9kHiaL+UHJfSyXq7u34pU5RUrFK90yNOEMZNCllIi+pfkZE6X4qm79Dbbp43dEbH
         zu3eKe7pzRlHpv61tz2wvEjFc3VHhVpP3WI399rkB44ERWn0kHIDMkzoJZfdkgfUt5m5
         GdJkcOsLABE6Z3vQprG6bFgxefZJ8FWtiR+cKBLd4ZZf8c7N00hAdGCNokw8ZxfwGHmO
         8iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GgY7NSiX6uiGDtMHlohDtQsx1OJlx0SAIigzyTay35s=;
        b=7ltUbuLbTykUk6N4v7vhpt510oHd2mDZgEoGesrRgDwcWpqAcYf1yevQzU8Yjt+fpN
         Alz8a87pSY+uvlEJmiUW8q28IEy4oTzrdMV3TVdSpKPM84meXk8wuy9TGTnz4XuChhYF
         LAOIHL5Koc5Vl68cRE3FdeLZqaEwT8gMkL4GtrPpKbi5tIV/znAqCGyDRC2qppJnhilu
         iC2Z39s4RpQ0zyP9N0n+QJJkcWh8bySzy8uD0PMPN8/J7FnMKKUPP6r3WJ2GvjYSr/pE
         C1th/vwFCQwTCxCM3t3XKQpJ1HuAhdrSL9Vx8HoZn+klXMZDzdSPaMEYm0ze4j6XXTOk
         Q4zA==
X-Gm-Message-State: AOAM533tbMuhFs019EkWXnNQh4fpQf2LZjh2JqlFxoVMYYbkdipG4zYN
        i6ZUwEoaGfFcIRJjNLNEFcHf/Cgwqgsv1A==
X-Google-Smtp-Source: ABdhPJws+4oVrU34s68yHCpWDk1FFIPQdgTM7eK3gFqhOueOd5NicV9AOgO6qRBSK3sF6bdGOWE2XldPmjZXAg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5bba:b161:2a8a:2ddd])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:9318:b0:1e0:b957:ffda with SMTP
 id p24-20020a17090a931800b001e0b957ffdamr2678266pjo.199.1653493496291; Wed,
 25 May 2022 08:44:56 -0700 (PDT)
Date:   Wed, 25 May 2022 08:44:38 -0700
Message-Id: <20220525154442.1438081-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH 0/4] kunit: more assertion reworking
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
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
kunit_do_failed_assertion, so we'd need to update the rust wrapper in https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs
But otherwise, I don't think this series changes anything on the
rust-side.

Daniel Latypov (4):
  rfc: kunit: remove format func from struct kunit_assert, get it to 0
    bytes
  rfc: kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
  rfc: kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
  kunit: delcare kunit_assert structs as const

 include/kunit/assert.h |  74 ++-----------------------
 include/kunit/test.h   | 123 ++++++++++++++++++++++-------------------
 lib/kunit/test.c       |   7 ++-
 3 files changed, 76 insertions(+), 128 deletions(-)


base-commit: e7eaffce47b7db72b077630dbe836f0c4132496d
-- 
2.36.1.124.g0e6072fb45-goog

