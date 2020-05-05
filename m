Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A41C5324
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgEEK1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 06:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728638AbgEEK1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 06:27:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76DC061A41
        for <linux-kselftest@vger.kernel.org>; Tue,  5 May 2020 03:27:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g4so1058103ljl.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 May 2020 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blGQJMoBvAS+iUdy6OjWgWZCgbDmhcjzl5awL9j79VQ=;
        b=jpA4029pUaIVnF4l5PbVwW0LEra4+nkabdz0qEKiJpYh8EP7TB52OoKvjTZLfRHpnc
         xwVpZZFisR3GARWRYbIp86xNASa+7K2ZN29F8TflMofeX8A1wgcrutrRov2QmOHCftnB
         f2Nby+IcpbDf9Ux1zkpH1exN6WAs0S3Z7rlShX2tEhTOErYgTI8gr3NgJuEUZ9iXX8CP
         4MvayBIM7sw+gf5FwkxCYvV0D56OuYUWbruy8qGMst2KgepBJVkakOuSVqHfil4Sm2C3
         ra9kpmz7uaVBZHrkCHzzcs9M/MCHmtuB+zqpuqS0kCk5tirZf2ktYoGqUfgvujroKJiO
         LqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blGQJMoBvAS+iUdy6OjWgWZCgbDmhcjzl5awL9j79VQ=;
        b=mMWmU9zt83EiAFEQ5ieMhtVJZux0znL8IMR+Em8msiqQG8X11VbqHGIqnkv94OR+kC
         mw6uUiE2quXUaX+frWuQVHZ4EgJqaLnd4UuDMIMVmOsWEEBN0Zw6KRwrsViO4CKH6aFe
         CwSGNMR6FGO1tEzBMLmObRmSbNBXcqV41rIMuKzC5v/AFm5pGICwINYSDi77IeCS6zDF
         eGziWG6Gbshqx8VR8HkW0E1O2s9RR0PSr/Ot+/hQpJMhW5Yh+koWAp800qR1kcPW4Sfs
         jNRYgSWdlB5k+fX/ckbAanOeRzbhyfVifwa6fSAf/iANg/ko2LXb5FWqGFlY5jZ4VL9J
         almw==
X-Gm-Message-State: AGi0Pub78ir8uSZlAyKsfjFwKwrZwLWq6xnP9tBz+kif/mr7n0qDJnRa
        zLuSfMP7BX+27EVDah9od5OzFA==
X-Google-Smtp-Source: APiQypKfa8VOGWn3WPZrzc/EhIZHCyr2xy8NZIclTsRKBVWbLEv8EvZCy1rPGqOMeOu9F7hKN9nnXA==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr1422695ljw.71.1588674419933;
        Tue, 05 May 2020 03:26:59 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id u16sm1860861ljk.9.2020.05.05.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:26:59 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 0/6] Enable as many KUnit tests as possible
Date:   Tue,  5 May 2020 12:26:47 +0200
Message-Id: <20200505102647.7862-1-anders.roxell@linaro.org>
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

Since v1:
Marco commented to split up the patches, and change a "." to a ",".


Cheers,
Anders

Anders Roxell (6):
  kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
  kunit: default KUNIT_* fragments to KUNIT_RUN_ALL
  lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
  drivers: base: default KUNIT_* fragments to KUNIT_RUN_ALL
  fs: ext4: default KUNIT_* fragments to KUNIT_RUN_ALL
  security: apparmor: default KUNIT_* fragments to KUNIT_RUN_ALL

 drivers/base/Kconfig      |  3 ++-
 drivers/base/test/Kconfig |  3 ++-
 fs/ext4/Kconfig           |  3 ++-
 lib/Kconfig.debug         |  6 ++++--
 lib/kunit/Kconfig         | 15 ++++++++++++---
 security/apparmor/Kconfig |  3 ++-
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.20.1

