Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26132160DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgGFVNP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 17:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 17:13:15 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6512C061755;
        Mon,  6 Jul 2020 14:13:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i18so34187028ilk.10;
        Mon, 06 Jul 2020 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJcRuZiW502lyt79q4NbNcGnwyJ5bsa33N05bbGF6KY=;
        b=u62B0UkX3Y5Ghv3KLsmRbWh5iZsuqE7Tg2gYoNrBDeKn0g9XPudAf2hiLSAw2qtKNW
         EqG68CcxSfaFy1wnvs/jmtohM40ooCYB3jj7UakldKKTNM5Sxq81pcQJ8oxfUepnnJCX
         3NLgO8RHahrVbXlpqn2I232Yaycb+iTWerH4FKitrEkbeGTajER9gvZJ9ZOwGR9UAPxA
         EMJz30vEkEFr8HRKKboBS2QdQQG+RpSOk/L0WyAuY4DJSNEjEN3288zUAgOzD9CVNIAD
         G68r572Hx0SIPX57J80kfM8OVSgtNbvMwHi24Gkvr504adVgu+Di4767PIj0l8V0AR3F
         S1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJcRuZiW502lyt79q4NbNcGnwyJ5bsa33N05bbGF6KY=;
        b=HYj0hhjU9ByYsKsRgAV2VOrk6h5TmHS41CJ7CQBziNcEuHLYYHdDuo8vBQn6KXR3OC
         Z6q0zoe6Z//FpAt85zcPy1HY+b+p67+7MGkXpQOKmDNSiMmpfU1TkN+DE7LS8CuuQGth
         oZEhP5FT2A8go8+iZQoAcyyrlZ+SuLX2PM4wLbR/wZKeX0ckz6SAn7pzXARhwjjnssjZ
         9U6zDULaXkwVfLASoAaO2/vRCHcf8SsGkyZh58KWjFYtmtugXiLy/TocFTx8jEeQZoNZ
         F3PdiO+wAXFQHGFZausOZmPCNYcD4TcxC+ASplajSTZB2dxiZT3Fn5dEu1ceWwc3PZuC
         V/Rg==
X-Gm-Message-State: AOAM530GyPeWnR86No1KvKAsCpdYWD8oDZRQIXkkFfBkDqCKUkaxJhwz
        YixVQ9YeDh0WxfZ/1fdtWIw=
X-Google-Smtp-Source: ABdhPJxBfXiijyzTvCt+rqu5fGevbWpaTa6x9RidouHcC6XeG1NXLhmQkDfGhT5aqV36pviWfctWFA==
X-Received: by 2002:a92:49d7:: with SMTP id k84mr32828118ilg.84.1594069994305;
        Mon, 06 Jul 2020 14:13:14 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id i10sm1063652ild.14.2020.07.06.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:13:13 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     changbin.du@intel.com, rdunlap@infradead.org, masahiroy@kernel.org,
        0x7f454c46@gmail.com, urielguajardo@google.com, krzk@kernel.org,
        kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 0/2] KUnit-Kmemleak Integration
Date:   Mon,  6 Jul 2020 21:13:07 +0000
Message-Id: <20200706211309.3314644-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

With these patches, KUnit can access and manually run kmemleak in every test
case. Any errors caught by kmemleak will cause the KUnit test to fail.

This patchset relies on "kunit: KASAN integration", which places the
currently running kunit test in task_struct. [1]

[1] https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com

Uriel Guajardo (2):
  kunit: support kunit failures from debugging tools
  kunit: kmemleak integration

 include/kunit/test-bug.h | 15 +++++++++++++
 include/kunit/test.h     |  1 +
 include/linux/kmemleak.h | 11 ++++++++++
 lib/Kconfig.debug        | 26 +++++++++++++++++++++++
 lib/kunit/test.c         | 46 +++++++++++++++++++++++++++++++++++-----
 mm/kmemleak.c            | 27 +++++++++++++++++------
 6 files changed, 115 insertions(+), 11 deletions(-)
 create mode 100644 include/kunit/test-bug.h

-- 
2.27.0.212.ge8ba1cc988-goog

