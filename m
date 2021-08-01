Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263B3DCC7B
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Aug 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhHAPoH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Aug 2021 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHAPoG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Aug 2021 11:44:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC5C06175F;
        Sun,  1 Aug 2021 08:43:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h2so29023776lfu.4;
        Sun, 01 Aug 2021 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6cYpziN3cAvLIGyn/jbriXRL+JuJAVAp0qqV6b6tEdw=;
        b=KWCT+7aGI6jJ4xmYFubwxVYKyNB+mb390QX0q9lngD9NiqyB/WJmhF5x0ObnXMDAi1
         ppwPXbv2lPf4M9UtR2kBumv5noUirCgt5if1aEhLgshPuiWFIQdxeH8HyyW4jX3o31DS
         LaU52+k7ga5gmMA11QZAws2PLj2eQLH4e0AJwPhPXGPItaNm5Z5AOUUJIVu+AKdB7I2r
         nzb3fE5eITIRvP7OZhOe5Vg0lVexxPToFXJ2Wis+J5NRxGB9Du8zSgsth/9rhunKm3Kb
         /kw2XD7WbZiBq4YSJOBluxJXJBGGh0McX2ss8M4N2nMgXKgsU5Qs0UNroZcC6aCfx38k
         oM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6cYpziN3cAvLIGyn/jbriXRL+JuJAVAp0qqV6b6tEdw=;
        b=sTIX/y7R/63sMefpd8ZBxGGiL3JVm9ZcvjPGzFMF24J0dKHItxqFsBSB+Nqn9KPxR0
         8dZMEZS39uZY2DfOnW78fJU/kRyoUnI3PHf/D/lPmpMQmEX5B+O8+DEPVDUQLwQYOJ7i
         7ZEF8aC21T2hCXHsXz66uzvi1ohfBCCLIYEZtShxp3+8BFzcJPAaitL1pEHnDUcG9T1L
         Bwv3tihlVL0FCAmjbUEqmVUIFdp+MEeN7DVCSpCLSPkYgAZev860sri56+wMd4pS29w8
         uasdX/gJZTUgAl4OI+oqsMFcr/60SBWLdHwc7WErOWyAYo5T7Vy4orFjlXRkXLClBqDH
         KOng==
X-Gm-Message-State: AOAM530PMDdKFGq88F5PZ4ykmzNDMHY15Dfxqqb8bOCOVcFKv26zsskT
        bU3anVybccXDqcUwwvEgU3GhLi6DCgclUQ==
X-Google-Smtp-Source: ABdhPJxwKNWfq+zpcqZs+CyidFP+yt1eJCOv/yLzw99jX1oWuKX/tGWgBaSaYcfQeIWT7H5/3eCNoQ==
X-Received: by 2002:a05:6512:b93:: with SMTP id b19mr2458717lfv.412.1627832636799;
        Sun, 01 Aug 2021 08:43:56 -0700 (PDT)
Received: from asus ([147.30.82.254])
        by smtp.gmail.com with ESMTPSA id y27sm764599lfa.260.2021.08.01.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 08:43:56 -0700 (PDT)
Date:   Sun, 1 Aug 2021 21:43:51 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH 0/2] add KSM performance tests
Message-ID: <cover.1627828548.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend KSM self tests with a performance benchmark. These tests are not
part of regular regression testing, as they are mainly intended to be
used by developers making changes to the memory management subsystem. 
Both patches were developed against linux-next.

Zhansaya Bagdauletkyzy (2):
  selftests: vm: add KSM merging time test
  selftests: vm: add COW time test for KSM pages

 tools/testing/selftests/vm/ksm_tests.c | 136 ++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 4 deletions(-)

-- 
2.25.1

