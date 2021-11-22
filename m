Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E90459580
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhKVT1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 14:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbhKVT0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 14:26:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD1C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so34627619wru.13
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1TMbyXiJVA42KdLp4ZFbmRsgl75h8nNEAfazPDRdSo=;
        b=nhhon0a0iJU4XOZWM/q37EKtUelf0QHDpAhbCB8lcjLZtSMuKiebEWR1N0cjpvVzjX
         lq0i5CoypVZUW/BLxpVE48hfeBCo9N0n+7KW+COEAvCNxvOxqSWOZ7vWWHObiPst7cLH
         D0/n5PRLiJwzSfv0wO0reWHD8sK0eXeJgjyWDJD0E7fefYkhdLSLXzVi6W+wykwljJr6
         07HTE0zO95Z6mZ0Vh67X9/v4FTznzPfcV3R35jBwLM55DyGqHKOtHfTjadBp4tYhhEZ7
         GAT5m8WBfS7qh/RhDZ+P+1hVjOPhHCIkeOPAMZkC5fe3XAqmrGjm3/E+GMrS04s7hIcG
         pktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1TMbyXiJVA42KdLp4ZFbmRsgl75h8nNEAfazPDRdSo=;
        b=jbBvpwxo6zWG+4HfF8PglLygrKpJPsqDVFP8Expz9hL/yyRh7elb3nF2SdC/n1CLyy
         aGtdlGV/O2EUmtceOh1e8QgdxjiPxxRDjLRHvfiPVaMaDU9g3jxomVTG0QpaPyny2PYr
         VEzVQxWLe5ECFc4Ls2fU2zx1T+EejHyxIYGA6G0YuzR6gxiZBpEIIDURFCLTMpmXwNAs
         n9ZsQydtkA2Sw6ISgamgwoxVWqwdUHGZjJiZb82LvXvECcehvuagWsT8mSJcCNdGPyWT
         81mCZuy6vQ7WxIkl9Nwf6Wnn0+rGAJwaVkqlUjbZjRMxnKJbdHTU2ibJ8jJScNLYwsfU
         54xA==
X-Gm-Message-State: AOAM532NZQ+mxeaQmpwg1hjJsS3kfhHhdKJ7qSrr5/d9NE31SDBibs2X
        rJ7LW2Szie4rcpcCamKJDOa3Dg==
X-Google-Smtp-Source: ABdhPJwQ8aZvv1YZb9IPjYbrNXZtHXn9m9sywsW/sxTcxH21tqoOkAhPc9B+7Xb7xCMvKs9HpsrMmQ==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr41535510wrt.271.1637609025957;
        Mon, 22 Nov 2021 11:23:45 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:45 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 0/6] tools/bpf: Enable cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:14 +0000
Message-Id: <20211122192019.1277299-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for cross-building BPF tools and selftests with clang, by
passing LLVM=1 or CC=clang to make, as well as CROSS_COMPILE. A single
clang toolchain can generate binaries for multiple architectures, so
instead of having prefixes such as aarch64-linux-gnu-gcc, clang uses the
-target parameter: `clang -target aarch64-linux-gnu'.

Patch 1 adds the parameter in Makefile.include so tools can easily
support this. Patch 2 prepares for the libbpf change from patch 3 (keep
building resolve_btfids's libbpf in the host arch, when cross-building
the kernel with clang). Patches 3-6 enable cross-building BPF tools with
clang.

Jean-Philippe Brucker (6):
  tools: Help cross-building with clang
  tools/resolve_btfids: Support cross-building the kernel with clang
  tools/libbpf: Enable cross-building with clang
  bpftool: Enable cross-building with clang
  tools/runqslower: Enable cross-building with clang
  selftests/bpf: Enable cross-building with clang

 tools/bpf/bpftool/Makefile           | 13 +++++++------
 tools/bpf/resolve_btfids/Makefile    |  1 +
 tools/bpf/runqslower/Makefile        |  4 ++--
 tools/lib/bpf/Makefile               |  3 ++-
 tools/scripts/Makefile.include       | 13 ++++++++++++-
 tools/testing/selftests/bpf/Makefile |  8 ++++----
 6 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.33.1

