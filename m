Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7942ACAD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 03:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgKJCBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Nov 2020 21:01:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKJCBO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Nov 2020 21:01:14 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kcIy8-0001sO-A1
        for linux-kselftest@vger.kernel.org; Tue, 10 Nov 2020 02:01:12 +0000
Received: by mail-pg1-f197.google.com with SMTP id q5so84851pgt.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Nov 2020 18:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RK2xra2umGqFG+SzI89RLBjV289wxSEZaa8bAGmNZH8=;
        b=OKsXbswRE4bzbu0blgtVDrmY8sg1eJqtmuVo3JtuTZYs5VJ/gDIk62tqERQaILoxoP
         /AYnub60Hhh0/WXON4Ge3IYudme3Wyd70v7B+BSwKvP74/uOI8TEiwdzcOGRQEmMp/2T
         8K0CUNt9RTeZNc2yX62ke/z1egtuR/Bf/8Ct3zermSO3lOqSD0IKNyJraIB+aXHbxipx
         skTPZvPYIECi4E8kF4yW2gaAcSCR+vhKqKYVTrhEe0Ry38Ng3OnIExLJwlbGaZrWldWX
         WtQiNzZc8tyjvuKjV1dgIoL4xPR1QvwXqe8p7z0oqwdCbAc/ZuhXhVeSvRgCArfP5WKf
         cOoA==
X-Gm-Message-State: AOAM5317L7bUlrwZ9psWqWzeVLbcu+5XUeHqe/4J/Ft3eKQ7B+5bheDl
        otH3oYORUysCUukpczBlxOPGvGz5E8ElYvqLsusFboaKYSUDv6tUGCaa/HYFExyT4I+OovImg8d
        8mnvzEPfXF+rxV/+BaXOmCzUWGB/FPl6ntJ9Dg9miZI4i
X-Received: by 2002:a63:4006:: with SMTP id n6mr14920444pga.171.1604973670943;
        Mon, 09 Nov 2020 18:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY3UB2LhbbRYn8No1bJ7jZB3fD3rnenjheE0iTW1dlEQcjHFmUi1r5RbodJAJDhdcKbtmrEg==
X-Received: by 2002:a63:4006:: with SMTP id n6mr14920420pga.171.1604973670597;
        Mon, 09 Nov 2020 18:01:10 -0800 (PST)
Received: from localhost.localdomain (223-136-189-104.emome-ip.hinet.net. [223.136.189.104])
        by smtp.gmail.com with ESMTPSA id c193sm11855552pfb.78.2020.11.09.18.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 18:01:09 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org
Cc:     davem@davemloft.net, skhan@linuxfoundation.org,
        po-hsu.lin@canonical.com
Subject: [PATCHv2 0/2] selftests: pmtu.sh: improve the test result processing
Date:   Tue, 10 Nov 2020 10:00:47 +0800
Message-Id: <20201110020049.6705-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pmtu.sh test script treats all non-zero return code as a failure,
thus it will be marked as FAILED when some sub-test got skipped.

This patchset will:
  1. Use the kselftest framework skip code $ksft_skip to replace the
     hardcoded SKIP return code.
  2. Improve the result processing, the test will be marked as PASSED
     if nothing goes wrong and not all the tests were skipped.

Po-Hsu Lin (2):
  selftests: pmtu.sh: use $ksft_skip for skipped return code
  selftests: pmtu.sh: improve the test result processing

 tools/testing/selftests/net/pmtu.sh | 79 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 33 deletions(-)

-- 
2.7.4

