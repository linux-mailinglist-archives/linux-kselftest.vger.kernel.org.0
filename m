Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4903E2842
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbhHFKKt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Aug 2021 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244803AbhHFKKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Aug 2021 06:10:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE9C061798;
        Fri,  6 Aug 2021 03:10:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so16996009lfa.0;
        Fri, 06 Aug 2021 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Cg4WXIsZYnbUd442Oahs9GZTt+sKbIJi8MwnGCykt+Q=;
        b=XPqTayydqB7XeIci2sFJG36nePUJsDxmFlECE42HuKuMz35087FwU3R8m2z8rbyHs1
         yLyT/0OI0INIF1Uc6JL7iSxDCeWL+dueJp7+GHhHXzbKMHuFFIjqcOPu2zPH4uHF4Ju5
         WNI+8pQFlUjJ4HxxVXKVQKCPTK3IS450KPaJHEXptdTMUWGp4hFb9TN/ttNHUJ5aDApl
         jB3vzdjkd8ltExrmJyZ5NTh2KjNWzshLkWd+0Iv+79fPSKwMaenJAmnUHXVL+JFe0bxQ
         luKyJiMbTVcWvpRPloQMQB775StJgoBumr4jQP60ZUVVy64EbQBgP0oZDnBNJQs6p3SK
         xXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Cg4WXIsZYnbUd442Oahs9GZTt+sKbIJi8MwnGCykt+Q=;
        b=iQpDvyHFRW3OaqZ3/kId5zezvOYofWBM55qP+nPoyRAo3rdIyweMhZWljt+T7DQF0o
         4w7PRrs0onPOoUv1/vb5mCG9EAVRQDfs+3HagPTE51yqJoCpYA7Z7rFZIQUURGhtGPtW
         YoD0CdVujqT+CqdTjpcjk0nJ+DVbGf+tmEC9GEJOD1wsCrYrkfcg7x9IC6jlBuJraCos
         YZLJgciucWi2X2jo7VBowmkwk+w/qDsPWUrXVE9SDTGyCvr7moL9JL7rrDwjHnR/u2ak
         GC/zo7BoQiyWgEcTM9bevaxGLMSGCQpm4Mq6rrSNHp27FKIfBDoQtvJaO7Rpc3O/kmfY
         fGYg==
X-Gm-Message-State: AOAM5339+H4iXywIjWIcNyXmDNmz7wxqkkex7NijUk3D0Xsgexrdd3/k
        y7BexOxTeTG0AFmzhzsmapg=
X-Google-Smtp-Source: ABdhPJyvIQJSwcNKYPOAlz/6bQ9oXP1Rr6I9mtMx2ZN31ncfx4sv/abaI1tq6YjaNJ2Sr/ZX44IAkw==
X-Received: by 2002:a05:6512:131d:: with SMTP id x29mr7572790lfu.655.1628244631438;
        Fri, 06 Aug 2021 03:10:31 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id s12sm640722ljg.60.2021.08.06.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 03:10:30 -0700 (PDT)
Date:   Fri, 6 Aug 2021 16:10:26 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 0/2] add KSM performance tests
Message-ID: <cover.1628199399.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend KSM self tests with a performance benchmark. These tests are not
part of regular regression testing, as they are mainly intended to be
used by developers making changes to the memory management subsystem.
This patchset is a respin of the previous series:
https://lore.kernel.org/lkml/cover.1627828548.git.zhansayabagdaulet@gmail.com/

Zhansaya Bagdauletkyzy (2):
  selftests: vm: add KSM merging time test
  selftests: vm: add COW time test for KSM pages

v1 -> v2:
 - replace MB with MiB
 - address COW test review comments

 tools/testing/selftests/vm/ksm_tests.c | 152 ++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 4 deletions(-)

-- 
2.25.1

