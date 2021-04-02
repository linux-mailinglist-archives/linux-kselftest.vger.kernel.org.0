Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0C3530A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBVVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBVVk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:21:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BADC061788
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 14:21:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d1so10478538ybj.15
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pLQkTorwCYwky2g/2k815QvRDGpmPY6TKLyyHbJKO4I=;
        b=riaRRJrThuvFjp0ZSMenzpmZBo4w7SGkow4l29Dt0aGPlAuTz9/NNvbSvQpKWKBECo
         9bEoj3gQR8TLidzqvjKoiPGcHPybQhfDHHA5O+nz9Pd0HTZijdJ6ZgAJinOjUpw5kD/n
         OkzcyumB9FmutO3Dt6Z8UYCU0/KYjRjaASOSq9AGzjqWLVBmXKXhx8822gEkWOOhY84C
         JHVdeeqkslBf+eorShjBBGddrThY2r+V+qhOre4ANYiITwapBvyz9de7S365jdv1mJ/2
         z3G+8J+DCd1gP00ozG6gSDz8QAZAluGRfGd5oR9dU/SfPBGkmLjRtQZABvepmzlpMvHh
         21RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pLQkTorwCYwky2g/2k815QvRDGpmPY6TKLyyHbJKO4I=;
        b=VN/GZiVyIw73EA3Wcltn96MqEOXqpVj5EoDlPe119xpWiMBQLGcgKs5VeVWFonOVzS
         hEj0E3wbN6doaMX2JTcqod+WURsKIcT0NRGXH2BzdBXJI2W1zexiqZByVbJ4HKs6t12J
         n248hwNJOJxMnmOIQjUE/IO6jovw44BGMiWybXyA2bYcTj3fTdOjnnSTb7k/1ROq+Ily
         B2+4v45OmBM07Qzbukhm3vvYLhSn7hsSnaizCXaUl065yF+2gxjGLwSGtBTvy6iveDvp
         Ynyzp54ev+iA2FBjrf4ksnpTrWZl6ndv55URLRXij/MMARjg5MrOUsb7JfbukcpdY/8r
         3j6g==
X-Gm-Message-State: AOAM531m0dhOwxUUpfaAAc1Cw9/nhSBqSwvtKVpbo7x4fh94WT/pfTUS
        IHmAPHPiEZfLuoTJukrg/FatPNuGJoKFQA==
X-Google-Smtp-Source: ABdhPJw/ku6iREyVU7XFkY6QvZ7AgANa4cUqmeAj1pg3oLIbi+TkoXMg0jjyEwFeKyv97/WSFxN3vbseFfB32g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:51c4:ce05:b8c5:b26b])
 (user=dlatypov job=sendgmr) by 2002:a25:2515:: with SMTP id
 l21mr19890329ybl.362.1617398498458; Fri, 02 Apr 2021 14:21:38 -0700 (PDT)
Date:   Fri,  2 Apr 2021 14:21:29 -0700
Message-Id: <20210402212131.835276-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 0/2] kunit: fail tests on UBSAN errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, alan.maguire@oracle.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v1 by Uriel is here: [1].
Since it's been a while, I've dropped the Reviewed-By's.

It depended on commit 83c4e7a0363b ("KUnit: KASAN Integration") which
hadn't been merged yet, so that caused some kerfuffle with applying them
previously and the series was reverted.

This revives the series but makes the kunit_fail_current_test() function
take a format string and logs the file and line number of the failing
code, addressing Alan Maguire's comments on the previous version.

As a result, the patch that makes UBSAN errors was tweaked slightly to
include an error message.

v2 -> v3:
  Try and fail to make kunit_fail_current_test() work on CONFIG_KUNIT=m
  s/_/__ on the helper func to match others in test.c
v3 -> v4:
  Revert to only enabling kunit_fail_current_test() for CONFIG_KUNIT=y
v4 -> v5:
  Delete blank line to make checkpatch.pl --strict happy

[1] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Uriel Guajardo (2):
  kunit: support failure from dynamic analysis tools
  kunit: ubsan integration

 include/kunit/test-bug.h | 29 +++++++++++++++++++++++++++++
 lib/kunit/test.c         | 39 +++++++++++++++++++++++++++++++++++----
 lib/ubsan.c              |  3 +++
 3 files changed, 67 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h


base-commit: 1678e493d530e7977cce34e59a86bb86f3c5631e
-- 
2.31.0.208.g409f899ff0-goog

