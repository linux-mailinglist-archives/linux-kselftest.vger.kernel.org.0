Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E0315A37
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 00:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhBIXqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 18:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhBIWRy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:54 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46607C061788
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 14:14:57 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m1so41991qvp.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 14:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tHzagjGXNPuISlrYDgBoG4oBntJ3U4L6LA9+/1TvcMM=;
        b=eCF1+XPVXmXXaI4fnLU1x7QL8R6qK2JNMWmlE2E62fRh1zTbhVtYHZj08JTzIqJ4PK
         8iUfuF7ufpcCB7JhZSyh3JYJ8Djz95SyqrVAMqVWmIe0mz6ki+oSRh9ZxSBwUGPd4wOI
         vzYq4ne15W5p0HA/9KS9h+YZF/J500SeX5+ulB2qPLksWvD2TyL5bl3zw1aFvyyWn2MS
         3nRj4rhMIR/2JsmcbOKFxTemUEXojiox9b1ciw3AWuVRyBeXeYy2B+Lb99xZGooS5rzO
         TwIlexBz0HelhQc60To56Q3eGlteuA6urOlfaBtWG+J5C10UWpCra+6nuFlarR7BKyDP
         eB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tHzagjGXNPuISlrYDgBoG4oBntJ3U4L6LA9+/1TvcMM=;
        b=BHQMnSf+v794E7ZXd1lA8pblRgaufbUwMj2AHk+CTPM/6imd+5KN2XJjtQICS8E6nq
         0D8iBeVmIBJ37wVTmgrc9eFPDIoGqaUZsmijAm4DBW2x4iaXt5wmklDwXCk6GhhNH5k6
         MAiI3fNslKKy6zV1u9i8ajw60TTzKgC0MXPVODaqA7xckTLWqlQTix76L9m4kFVFcj0q
         3HSLpTB+W1HJtp4QqYgxSyuhKYdGurzNRXsw4YEOzGnBVYwR1i+llSjxBo2+DDJdKz7S
         w6S8dmjC3nFKw/NDQwkOm+YYy0ebHHODyYivv/JB4Eh2DWkaY+9HUaRaGAhTbBlUcXQD
         TQ2A==
X-Gm-Message-State: AOAM531Lwv5nw+SlN49cIGby6KNOPFcijvu4veMDOu9fF2+E7wlaahec
        6a3BGan2FbU4keK3867KM4ve7484UeRLIA==
X-Google-Smtp-Source: ABdhPJxJ4VTOHMNM5P/K4n8751sRWqretvq2TSUKAFdhSNAerNSAqTaGPw0DXxQkdni7LFsqvrIJS9WrxYAu3Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7dd9:967f:92f4:2aae])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:1ca:: with SMTP id
 c10mr13380525qvt.44.1612908895933; Tue, 09 Feb 2021 14:14:55 -0800 (PST)
Date:   Tue,  9 Feb 2021 14:14:41 -0800
Message-Id: <20210209221443.78812-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 0/2] kunit: fail tests on UBSAN errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
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
  Fix kunit_fail_current_test() so it works w/ CONFIG_KUNIT=m
  s/_/__ on the helper func to match others in test.c

[1] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Uriel Guajardo (2):
  kunit: support failure from dynamic analysis tools
  kunit: ubsan integration

 include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
 lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++----
 lib/ubsan.c              |  3 +++
 3 files changed, 66 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h


base-commit: 1e0d27fce010b0a4a9e595506b6ede75934c31be
-- 
2.30.0.478.g8a0d178c01-goog

