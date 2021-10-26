Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82443B5B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhJZPjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbhJZPjK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 11:39:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40006C061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 08:36:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t92-20020a25aae5000000b005c1494b029aso17739781ybi.6
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ojODAjLfRn1Lf+4i6CRGTfXa2Pbtlhx1DNx7kELm9pE=;
        b=CozQzRWoQnVrztxALVJ1BzDa678ehPrMv8oKOOS8xxgpJsuDHKmPiwdlVPJEhDTD+o
         A7tQpaw1PZikjLMiWhDaGBSCRjb/LhuL21JklXhtEJrHKwb/ra/OtJ3s0mwJtetlL/1D
         8s/0dzuYHhfQZvDNqZVwYuG/oEN+gMsGBn6NAJQaFtOBcbAgSbD9EOiG6JYsIYAzAkXO
         77o24ogRcNw0oNiwlrOEzHY7SwUxwDcETniACjzrM3EDUtCKFA12sIqqqCvl7auraKe1
         6gYK9dtUUXH6gCajY1kKiy3fqYXHrK35HQoe1Cnl7CImi5+LyuF3e/MCFFIxqD/1dPIx
         tqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ojODAjLfRn1Lf+4i6CRGTfXa2Pbtlhx1DNx7kELm9pE=;
        b=ym5m56/rn1E4VrCS3Dc2mVSuK1dNXvIblOX2Eja4PoY/2DNAffYCBEH/F/XUU4leli
         PzLAd+KlYPDGROHNVY4QEsI5JFYJwH1CjMYVklHgrMDkRZ1Agu5gTbKC8T88s3Dd8iye
         r1zzccQFBsAi0ExEnky5nIX+OVysMAPmEy9C7AQeyaX5OQ17peSnk8zOoxsWQ4U34e9r
         hbKblXeOxRYhvcp9tnu6AOIrf9jypqogUcO9b7MvPsZhto1KstAWbC5mNA7SH7uckVXS
         EdZx0tcpuy2j5lSQwWnd2c90SRtOSeA/QMgNx6TCeJ5mxhWb6b8hb5R28kFLAGY4EIFs
         eR1w==
X-Gm-Message-State: AOAM533WIVuMS0KdTD3Xtv+wXLRhFKH/KY35sv91fuGRIv9lr+bE0WKn
        5LB0nSWKL6fvT3AzdMDm9aXlRmTtUNrBag==
X-Google-Smtp-Source: ABdhPJyxj/d0EOrqXaqoO4qUvMk4Qh9ib6ShPlLenahXqtHevjSwpDY5SFjzvcdz2soobWRVGTTRo7hx6ZfvGw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d5d6:b5d1:7203:e1a2])
 (user=dlatypov job=sendgmr) by 2002:a25:3189:: with SMTP id
 x131mr13354941ybx.27.1635262605440; Tue, 26 Oct 2021 08:36:45 -0700 (PDT)
Date:   Tue, 26 Oct 2021 08:36:38 -0700
Message-Id: <20211026153638.3857452-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] Documentation: kunit: remove claims that kunit is a mocking framework
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit does not have any first party support for "mocking".

The original RFC had some, but the code got dropped.
However, the documentation patches never got updated. This fixes that.

https://kunit.dev/mocking.html has a current writeup on the status quo
and will hopefully be eventually folded into the in-kernel
Documentation.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/api/index.rst | 3 +--
 Documentation/dev-tools/kunit/api/test.rst  | 3 +--
 Documentation/dev-tools/kunit/index.rst     | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index b33ad72bcf0b..3006cadcf44a 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -12,5 +12,4 @@ following sections:
 
 Documentation/dev-tools/kunit/api/test.rst
 
- - documents all of the standard testing API excluding mocking
-   or mocking related features.
+ - documents all of the standard testing API
diff --git a/Documentation/dev-tools/kunit/api/test.rst b/Documentation/dev-tools/kunit/api/test.rst
index aaa97f17e5b3..c5eca423e8b6 100644
--- a/Documentation/dev-tools/kunit/api/test.rst
+++ b/Documentation/dev-tools/kunit/api/test.rst
@@ -4,8 +4,7 @@
 Test API
 ========
 
-This file documents all of the standard testing API excluding mocking or mocking
-related features.
+This file documents all of the standard testing API.
 
 .. kernel-doc:: include/kunit/test.h
    :internal:
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index cacb35ec658d..7af7dec83646 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -19,7 +19,7 @@ KUnit - Unit Testing for the Linux Kernel
 What is KUnit?
 ==============
 
-KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
+KUnit is a lightweight unit testing framework for the Linux kernel.
 
 KUnit is heavily inspired by JUnit, Python's unittest.mock, and
 Googletest/Googlemock for C++. KUnit provides facilities for defining unit test

base-commit: 2ab5d5e67f7ab2d2ecf67b8855ac65691f4e4b4d
-- 
2.33.0.1079.g6e70778dc9-goog

