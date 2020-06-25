Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF920A6D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407163AbgFYUhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405138AbgFYUhJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8FCC08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so3583283pfd.6
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3GeLK+nXjwF6qopXKxu4ABEIWtd3N9QgHPk+DpZ9DQ=;
        b=T+TvmO6fHmdSxxhmwQF6bCqwTYesZ26yWqZboO+42b4Ie4kzH6zGD3MEM6/mR+k1qo
         3/53fF6qs1obN0PM9p7Ghgh3T59x1FbCG7HXARnuUe34xNmxM1tkRPBj2CkA0LelU/GV
         Anxsf9KOCQ0VaVa1QhyynBigEsblv0lSlybEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3GeLK+nXjwF6qopXKxu4ABEIWtd3N9QgHPk+DpZ9DQ=;
        b=Z7KOzw9Op7WdBZ2g3Rt2lq9U0CORX4CuE46sIJePPV+rXTZFvE2CEl0GOEkEHgIeM2
         iNkPh3f4lZszxJ69iHNRafghQpXe8XtnGeLNwrsIVYhkSDR+EoyU7Ojus9+ImlD/21Pz
         I2kIJUrEwarVF/QLExl1GQuaJOC3GPiL8ffguphQl/3uewKTNKhzIibeRTjiTrrwCOaD
         yiRyBhB9DAi/DzdfO0bGzikJzUIUTjfeZszmKoOMCGG4q3I0eMKCH8KSsh3gJrbRvBGI
         LLqtEjr2Qg3zLXPFTjGMIIp5Y2y5l56SvMDuHwwOXwXLIDcPpADsYvBH5ivvNKeqEk/S
         wEpw==
X-Gm-Message-State: AOAM530QjrIh0N2zQ5wT1QJ87K1cna8AySL1Jy4qKRDXNN7wJ1XiSHoS
        TiZY7K3/6yf+loifs7bB8C7ONA==
X-Google-Smtp-Source: ABdhPJxuNWPKYgd5trz2foxr85WYRx00emue48cZggJc6TgB+Btx4HxdZWfpU/cEGBgAfXWd09NKFg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr21957815pgh.255.1593117428713;
        Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm21295494pgm.70.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 0/4] lkdtm: Various clean ups
Date:   Thu, 25 Jun 2020 13:37:00 -0700
Message-Id: <20200625203704.317097-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

(Since this was aleady pending, I just spun a v2, resent here.)

Can you please apply these patches to your drivers/misc tree for LKDTM?
It's mostly a collection of fixes and improvements and tweaks to the
selftest integration.

Thanks!

-Kees

v2: - add fix for UML build failures (Randy, Richard)
v1: https://lore.kernel.org/lkml/20200529200347.2464284-1-keescook@chromium.org/

Kees Cook (4):
  lkdtm: Avoid more compiler optimizations for bad writes
  lkdtm/heap: Avoid edge and middle of slabs
  selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
  lkdtm: Make arch-specific tests always available

 drivers/misc/lkdtm/bugs.c               | 49 +++++++++++++------------
 drivers/misc/lkdtm/heap.c               |  9 +++--
 drivers/misc/lkdtm/lkdtm.h              |  2 -
 drivers/misc/lkdtm/perms.c              | 22 +++++++----
 drivers/misc/lkdtm/usercopy.c           |  7 +++-
 tools/testing/selftests/lkdtm/run.sh    |  6 +++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 58 insertions(+), 38 deletions(-)

-- 
2.25.1

