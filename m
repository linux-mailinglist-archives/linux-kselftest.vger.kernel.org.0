Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD63B21E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFWUmJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhFWUmG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3EC061760
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t32so3298306pfg.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lnn9jp/s32hmkbL+/fflp0AYulLa8VCq66U0jv/eDes=;
        b=C1YmvtJB6ygrlO6e3yWlLKjc6iRwUSJaKCLlk6vJQ46k0QV+mgo5ZXBkqnx1ETI7Bo
         0ImQPtsKOnj13rIVcLAnUm4f4mWTuB9d6UG69Ymk9JjWlge3TjqC4Q1y3alDooeS3+2r
         vThLKpEt8iYquBxfy1ZwtfJBPAXkp9aG2u5k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lnn9jp/s32hmkbL+/fflp0AYulLa8VCq66U0jv/eDes=;
        b=RGhcHrzDS2+2oMwwCA7nbD5myFAgG3WieBSswHEVezrVC6VFh4uuBR0s1IXDOGqnnV
         YiuPHsjT/401V3BNZu0TM8sG1x5BBZxK8zQ8t7Qu4m4w+egIRvDVeLCShGyLQHbRKF5O
         vB+4dg901XMUKCdcp5q3hUW+Rd1wic3lOeoZlcVw8WnoqRlg9ArRjiK49fxMCuwiojZY
         XrwEgkvn9aF9sdqHCzbf8kwfqWy4ym3T1JzM3nukBp3kYs8SSuRhi+hZHzH8qBh3YB2y
         OYHBpp2yLEHhV2RRhI0ownlu17f+cxGFsrzW6aRNn/sp1EuPHshPJQNYwuTof+1kqzH1
         aNQA==
X-Gm-Message-State: AOAM532TN0h143n1OIB40sKKsr9RCB0jQyzHkN1JtIm1AL4iGEDXRlvm
        u99mEkPlkFXJd2gDw57cDKF0WQ==
X-Google-Smtp-Source: ABdhPJy25JF5LfPlvMzjiFU6YxFBAIl/9LluZtx9nqJMnVqSL0stDwYx7dEMGfPl3SHI7ZOODjCkFw==
X-Received: by 2002:aa7:8254:0:b029:2ed:b41:fefc with SMTP id e20-20020aa782540000b02902ed0b41fefcmr1498913pfn.42.1624480788262;
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 92sm6294061pjv.29.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/9] LKDTM: Improvements for kernelci.org
Date:   Wed, 23 Jun 2021 13:39:27 -0700
Message-Id: <20210623203936.3151093-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject; bh=zEuv0J1e6Ce2pKHimEyiAaIYYKWtyU0Hog/oTewgJ2Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wFChS5JDlFBZpH8NNFzZZUwtqUxgF7CN0I4TwO T784QdeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBQAKCRCJcvTf3G3AJkcxEA CluTxSMcPooRUNQtu6ITHy4aTzsPHZRIHL4Ygd6kjyDQO3ldSlcQafSvdwQdU9mmcXXkKfA4FU2E9Q VUiby+2TjqiTHS7GoDzvduYDAiJ2qTPK9eKfipp6zcwyrZEfXmFV0l1CBZIuab7G5uKq67+Nqx+j0G gAihVQFVrIDuP2xqSolSgSDZ4HDV7qRcpcOz4dp86mvfQyvp/vjTodFTYpSQaUWb54m9CKgmerG/Ki cw1JyjSGPQBCXev0rY4IyRn0WyUFzfa1DKIZnRMI6+up9iNTR1pKOCeqaP7q4+rHpJs9yCm40WlT8A AhF7CDUWj6J/ocghjGEByr+ObzUm/F5ip+eGRHPubl8oavMB2pBKov2vM+v6LTcJQkKMz82OFHU7P8 SLKxRr9PO5BSHuwCr80Ju0BqWRDohcjP3xK2j9hqvhzFCEhoIew9IDYZtAo1iqEAY5G5FA3m336cFW hc/U9lDeHJSo9RedWBRcTz8zLAQTYsnRz4QTdORHzmHhfc8VRVdQ5+HgYJqk4sSEt6JqKmH06zys0y L4zXmsaU4uuKIzVWtX89R1xPRARgF1FDUy4hFicEfL6TR7hpGzMdxcsv7jdn7CQUfbcgmrwkN01S9O 0SfggbzjvFahUpHkHC1b849WPAa/AinczkLUw1s9B21RYzD335XtCKHTAEjg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a bunch of LKDTM clean-ups to improve and expand testing,
given feedback from testing at kernelci.org. Adds a few new tests as
well.

(If a pull-request is preferred, please let me know.)

Thanks!

-Kees

Kees Cook (9):
  selftests/lkdtm: Avoid needing explicit sub-shell
  selftests/lkdtm: Fix expected text for CR4 pinning
  selftests/lkdtm: Fix expected text for free poison
  lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
  lkdtm/heap: Add vmalloc linear overflow test
  lkdtm: Enable DOUBLE_FAULT on all architectures
  lkdtm: Add CONFIG hints in errors where possible
  selftests/lkdtm: Enable various testable CONFIGs
  lkdtm/heap: Add init_on_alloc tests

 drivers/misc/lkdtm/bugs.c                     | 11 ++-
 drivers/misc/lkdtm/cfi.c                      |  3 +-
 drivers/misc/lkdtm/core.c                     | 58 ++++++++++-
 drivers/misc/lkdtm/fortify.c                  |  3 +-
 drivers/misc/lkdtm/heap.c                     | 97 ++++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h                    | 46 ++++++++-
 drivers/misc/lkdtm/stackleak.c                |  4 +-
 drivers/misc/lkdtm/usercopy.c                 |  7 +-
 tools/testing/selftests/lkdtm/config          |  7 ++
 tools/testing/selftests/lkdtm/run.sh          | 12 ++-
 .../testing/selftests/lkdtm/stack-entropy.sh  |  1 +
 tools/testing/selftests/lkdtm/tests.txt       | 11 ++-
 12 files changed, 236 insertions(+), 24 deletions(-)

-- 
2.30.2

