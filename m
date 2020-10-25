Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41AB2983BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418974AbgJYVsu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418969AbgJYVst (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 17:48:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8F0C0613D0
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d6so6013116ejb.11
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pU074RtjEkyjZnTLMDzJX6R1Y/207D0sC+J/EOOsTPs=;
        b=ChazOuCH96T9UctvjyJS1OV4Cai/f9qmCl3cYdHZcpY+pBDXWlm8/YrIv4PALLSIWh
         wVB2meCNnIhoCJ7n1eIw3t/k0v9SltjOYSosNoa9yNHL+iYjQcy63V0zjaKyZK24UfXc
         me+KfcjjAQ11X2MgO18S+pxtrwQpYObQQ84tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pU074RtjEkyjZnTLMDzJX6R1Y/207D0sC+J/EOOsTPs=;
        b=sfpmKjJZKvaIlW1MaPlOT4oqBZ+Cm8h1y5bluJ2QfhkMuuofJSPpT1wypz5os/yLlt
         6yOthSNBS25HoydtQ4VNyhzvRhxu3TZSzdV5N32PPtbt31kASc16e0kjbBLE/uIog4uS
         kQDgaxgzx3NjRa8VDfsdbnw+8u8Bx/TaR8DWqKUItv+6QuZSeF3qvEuToRllRrA46kX8
         SIf5XKM0vauD7koUdt++ZgmjXaty29r+SsK+5tO7iSPLulkO5SP+cUsYz8ROCKuHofYn
         F/tv/BNSs4uir4ZjoYkv787FuasNib02pIcxIcIYOuxcZYfIw9EdWOpb4XAt3wEYJCi5
         JaNw==
X-Gm-Message-State: AOAM530anlV/oTYk+DAnHu1mdMVPbpm7drSVpVw6yJ2Bjax4W9aGZKU2
        D9AhVqKlqgyeXSIfMvwyiWhpqQ==
X-Google-Smtp-Source: ABdhPJzRi7xuqs7AugiF/Li1BWT4PMw6UBqLt7+vT1zkoqrNiAcL19YB9zipY0qRvJy2hotXjPq/Pw==
X-Received: by 2002:a17:906:5e4f:: with SMTP id b15mr13091466eju.353.1603662526661;
        Sun, 25 Oct 2020 14:48:46 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id k18sm4115867eds.93.2020.10.25.14.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:48:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] deterministic random testing
Date:   Sun, 25 Oct 2020 22:48:38 +0100
Message-Id: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a bit of a mixed bag.

The background is that I have some sort() and list_sort() rework
planned, but as part of that series I want to extend their their test
suites somewhat to make sure I don't goof up - and I want to use lots
of random list lengths with random contents to increase the chance of
somebody eventually hitting "hey, sort() is broken when the length is
3 less than a power of 2 and only the last two elements are out of
order". But when such a case is hit, it's vitally important that the
developer can reproduce the exact same test case, which means using a
deterministic sequence of random numbers.

Since Petr noticed [1] the non-determinism in test_printf in
connection with Arpitha's work on rewriting it to kunit, this prompted
me to use test_printf as a first place to apply that principle, and
get the infrastructure in place that will avoid repeating the "module
parameter/seed the rnd_state/report the seed used" boilerplate in each
module.

Shuah, assuming the kselftest_module.h changes are ok, I think it's
most natural if you carry these patches, though I'd be happy with any
other route as well.

[1] https://lore.kernel.org/lkml/20200821113710.GA26290@alley/


Rasmus Villemoes (4):
  prandom.h: add *_state variant of prandom_u32_max
  kselftest_module.h: unconditionally expand the KSTM_MODULE_GLOBALS()
    macro
  kselftest_module.h: add struct rnd_state and seed parameter
  lib/test_printf.c: use deterministic sequence of random numbers

 Documentation/dev-tools/kselftest.rst      |  2 --
 include/linux/prandom.h                    | 29 ++++++++++++++++
 lib/test_bitmap.c                          |  3 --
 lib/test_printf.c                          | 13 ++++---
 lib/test_strscpy.c                         |  2 --
 tools/testing/selftests/kselftest_module.h | 40 ++++++++++++++++++----
 6 files changed, 72 insertions(+), 17 deletions(-)

-- 
2.23.0

