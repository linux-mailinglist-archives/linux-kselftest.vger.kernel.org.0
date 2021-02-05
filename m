Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7584B31186F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBFCh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhBFCfo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:35:44 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4EC08ED8F
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:53:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id q37so6228708qvf.14
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PlLvWoFhODO77w3ySrXmuuL5rJilH/MWtzg1pEDHD8w=;
        b=JJKJgboeEwzxTaXxx/Y72B6j1XTrlBMj6s2nfEKuv8ndl6+MugSjSiMoE9qr7IZ1VG
         juAdNNPQJeggx3Id04EbFlKX2Nuz6TeSO3xvLSoLQFEDJ6lxs0fCJLBg0ksb7lWpnHc8
         FElOgdQPVutn/y11DQ/SNqp/6NG++Rmn0wYP/ZXr2OcSMClPzv5Wr9eccbgGVNsEUy/z
         v6L/hZ/3nlHRseHq6t5qgth+HYzUODolngqx9n6/agITdMVxcTDWOGMpz27tbuOCeniX
         qJupal0tEBKEIR4ZI8BkoDEnY/lA80MI7z+OW+Qu0Jxav/nUL1Z+EmOHBvePEUpOn69h
         wSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PlLvWoFhODO77w3ySrXmuuL5rJilH/MWtzg1pEDHD8w=;
        b=JJw3vFyPhGScgVLb8WQS1WqGjRn/io2RQ+6fHmwXhIbxS1jQX4lKHvz+lVhlQR2Qq6
         HJRWdY7w0Qofuk2D7tgRPVlTdf4iJ80c7Ewk+Qje8KSPMm7Bk776Sy60LrQM4D2hHEak
         xCH4U4GD5dt6Q9ShBofvC1P/l5ECOkU3uMA8/T78I/1SRNZxh91skZakFPjcq1KlQj8L
         DoIsMz6GWnol990tvAeCHiw9byuwWQhB67gfSs3+zPq4POiwMCX2R1AejWy3l7GCuz4N
         QDy2u2VyjQ0wg/h8AgbuptYJ5NqluAfX7tSXTvmyQB6mKblc+nUPV1fO4Eo9175AYQVz
         r1qg==
X-Gm-Message-State: AOAM533YToU/pUAkL2iSG73vbznnBda8NZrp43pNw4u9wWm+7BSFUzM2
        4y8icSEyepXByCoIX6BESVlEBtoTsGpoHg==
X-Google-Smtp-Source: ABdhPJwzCp+US9JJsnl1rBEeytyUhiYnpXlctiBEL2qaUvUkFr+i4rqQM3Sq1hx+QHRXccPLre1fGb3NIxu9Lw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:1348:: with SMTP id
 b8mr6970824qvw.26.1612569188987; Fri, 05 Feb 2021 15:53:08 -0800 (PST)
Date:   Fri,  5 Feb 2021 15:53:00 -0800
Message-Id: <20210205235302.2022784-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 0/2] kunit: fail tests on UBSAN errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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

[1] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Uriel Guajardo (2):
  kunit: support failure from dynamic analysis tools
  kunit: ubsan integration

 include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
 lib/kunit/test.c         | 36 ++++++++++++++++++++++++++++++++----
 lib/ubsan.c              |  3 +++
 3 files changed, 65 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h


base-commit: 1e0d27fce010b0a4a9e595506b6ede75934c31be
-- 
2.30.0.478.g8a0d178c01-goog

