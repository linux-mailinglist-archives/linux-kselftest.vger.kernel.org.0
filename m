Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC173F1CDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 17:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhHSPeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbhHSPeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 11:34:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDAC061575;
        Thu, 19 Aug 2021 08:33:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d4so13795081lfk.9;
        Thu, 19 Aug 2021 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=h8Bu2sX4mQooXbRWe0x6sLuCvlPizN+9dv1SfrTEIoY=;
        b=GCkGQM+Oc+rTglB8uAs1igR5f/9rJqSk+tvrlxWZl4vYARlNnLgeUrjuJusZzmob2C
         9/EQtBirZWZpMPj7OV2oIVSvt2ipNyqgJObt5nzA6sSPMH06DoBniCLtmdwJfM3zXfEQ
         Idsyj/h2+GHTaEve8eCs+en11Wb6HoOK0c0M2vwLHNbyP1waB7X0/3ubjF8gpRSYKTSV
         JAGdxNb28b1bCEYKtCwwEhpmhikBh8flkpSzZ+GWO2T8K6T48aatentmFu0xvUtv63z3
         QJiWNHpZNXvSiYCbHlqnisXvaYAMOr7k7YV573iFVcYch0/erH/xgwz47r49/lzVwCSv
         5x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=h8Bu2sX4mQooXbRWe0x6sLuCvlPizN+9dv1SfrTEIoY=;
        b=ctlQ+c1Qfkb+ATnZNnV8pEVR9gLXjt/5JImTBwjCFQE8roV8z1F/gqsAbHVNUhA2BK
         +OnnIjIYErZnGXwpgD8fbq3NQ3oZm8qR+48RhhDvp03GpwWpUQbig2p0CW0TvoDIbL2s
         kL6B+j4Wdc22wIKh/WFNoSzY7apYsx2ZETOBrecmYcsbxi84Zm1D+zKexnmOV9VO96uh
         crLREnJmqsNwOB2LtW6RmQG+P1ERKnJmHpH3eKv4CrPZgirsOEXOTVlaQOzN03fm62jp
         v3VMen0cGMurMLmSSAvbqtLSsce18QmAnlxoFVibFgqCghw4mnPPtJ8gCgzAj1j4mULW
         EYmw==
X-Gm-Message-State: AOAM531Cv1ti6jGtKmkXfkgm1LgVLGBSECWMFHsmOlVin+PU1qyQ0Wek
        y0zZsMnDK0V5wdJdc9S9sSuz+sE292azCw==
X-Google-Smtp-Source: ABdhPJw+FocjAr5ZM3fRbW3ghtvsRy1dJBEhVWGae9OJPGqrA+EI8dSYCLiH3NTxwMLSpEg52ERLjw==
X-Received: by 2002:a05:6512:e81:: with SMTP id bi1mr10712658lfb.58.1629387223959;
        Thu, 19 Aug 2021 08:33:43 -0700 (PDT)
Received: from asus ([147.30.82.254])
        by smtp.gmail.com with ESMTPSA id j13sm338287lfe.48.2021.08.19.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:33:43 -0700 (PDT)
Date:   Thu, 19 Aug 2021 21:33:40 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v3 0/2] add KSM performance tests
Message-ID: <cover.1629386192.git.zhansayabagdaulet@gmail.com>
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
v2: https://lkml.org/lkml/2021/8/6/422
v1: https://lkml.org/lkml/2021/8/1/130

Zhansaya Bagdauletkyzy (2):
  selftests: vm: add KSM merging time test
  selftests: vm: add COW time test for KSM pages

v2 -> v3:
 - address COW test review comments

v1 -> v2:
 - replace MB with MiB
 - address COW test review comments

 tools/testing/selftests/vm/ksm_tests.c | 154 ++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 4 deletions(-)

-- 
2.25.1

