Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F081CDAE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgEKNOZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730143AbgEKNOX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 09:14:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9386C05BD09
        for <linux-kselftest@vger.kernel.org>; Mon, 11 May 2020 06:14:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 8so4754476lfp.4
        for <linux-kselftest@vger.kernel.org>; Mon, 11 May 2020 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5G2udOSHaQZv+/vRn9bY4n/DXBHSBdIm8Dj9bPbJOA=;
        b=hIRznpXq1Mi0E8mpdkPnk3hmCkIkEdeRf6pMnebUkb/1CDDnNzap+KPo0X8tCEvAHM
         xux9V5R+UKSG7LTlNhow80b5oSyz4xu9EjSrj8Pt40WjDISGvgcW8IJY/kKUaLIARklB
         EbZt05Xvxf090qFRJbw+YxVv3z4tehsHGxa7zVsxhhW7/b1rCSP3K5Fg5ihZdeS3Uwns
         dc/rCGAp97V3cXOpMFrs3ekRGUiaufkpPWfCoOFWPi0BgV3Ve2ztEHzwmtpn1PC4zUsJ
         +32zH47SoxY/QYEMo58iwTYlsCsokYNHuIVcee4mk2XUGMQNnJfdWs6oP8a3HdQdYGEO
         lBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5G2udOSHaQZv+/vRn9bY4n/DXBHSBdIm8Dj9bPbJOA=;
        b=Unke+tZ3fhfDDxfLD5mL6U0wr3Q54b+tppwuiXufeCsnRW428XVFu8NRUfMVOtAYiK
         hlxfbk482VRixGfZ5LyYHnbxz2kJOxPgMohOixD/O9BD+hYgpBCLRxgn/iOkYiC+ijYO
         iJnY72sjuBqaWx9LHni0gy4QjOENvJ+ZswfgDuu3jsNQdZrmvQqVJNu5fHFkbrP+fxty
         w9Pkag4DA9aWnYnq8Bq8BMKnes1KB1t8Ad33DyH1k38CX5HKjx/G1Cd13raivs06l2hz
         xD7nOCqjtnKMB6oilzCt7GQlGlMoJPOK/9xEVeZ5u8iezFoIBoRvlkPTrFhfy/2L0PfS
         7syw==
X-Gm-Message-State: AOAM530FesaV9oTJsUDltLqIO3rcM10jL1qRa1i+yQetw+Z2FkEPnrLt
        p7r5FR7nCnn2NG1KM0aN+C8iPQ==
X-Google-Smtp-Source: ABdhPJyxP3hgaWRGIbs7CbiGxBLMK1Agzv2v0iWSsVIzG1UmL0wwG1g4ObOsnQjUF+BkJb3I4c3vbw==
X-Received: by 2002:a19:cc92:: with SMTP id c140mr10986211lfg.34.1589202859704;
        Mon, 11 May 2020 06:14:19 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id f24sm11918890lfk.36.2020.05.11.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:19 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 0/6] Enable as many KUnit tests as possible
Date:   Mon, 11 May 2020 15:13:50 +0200
Message-Id: <20200511131350.29638-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patchset will try to enable as many KUnit test fragments as
possible for the current .config file.
This will make it easier for both developers that tests their specific
feature and also for test-systems that would like to get as much as
possible for their current .config file.

I will send a separate KCSAN KUnit patch after this patchset since that
isn't in mainline yet.

Since v2:
Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
suggested a great help text.

Since v1:
Marco commented to split up the patches, and change a "." to a ",".


Cheers,
Anders

Anders Roxell (6):
  kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
  kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
  lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
  drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
  fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
  security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS

 drivers/base/Kconfig      |  3 ++-
 drivers/base/test/Kconfig |  3 ++-
 fs/ext4/Kconfig           |  3 ++-
 lib/Kconfig.debug         |  6 ++++--
 lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
 security/apparmor/Kconfig |  3 ++-
 6 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.20.1

