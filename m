Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9C603A5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJSHKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJSHKg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 03:10:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98B5A3E7
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 00:10:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g28so16387430pfk.8
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ATQaVsroISOqJtVsarQoMnG/5wwQ4/l548peIQxMKHw=;
        b=ZGbaJX7lJhTkDWn7GSuJwGOmz/0zK7c6OTMJD0HMnRANR0zos5zjNUiIl1tOuovbmt
         aK4gyP3VVM62FTXi2Af5QPUqzPV5N9oxPaQqBkhPgFeHp1/sQituM3+hm12nzW+7s/7I
         wczpdO2E6c33oDhbzRJtLl1KzEUqXolnICUkoBY7PaLPhAjwuoGKC+ndUi71os4bDHcw
         gDUcK7Qcf3P5MKjjH/tV+oyQdQT+tk8MYrgccDn8GUX7gmCbPCupI7tYdaB+fauxzu9M
         +AIdfYsLMXLi+RFWgLES92r5RT21DRQBOwfewdbtJcBx2x49HQxkvZCpZNb009tGk2au
         h/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATQaVsroISOqJtVsarQoMnG/5wwQ4/l548peIQxMKHw=;
        b=uZN8XQxQMePUP1pBuMZKSzX5H5d0x9wNpjxrUStajP4m5pwVCEhMNjQ6iwg9BQfJvN
         idBlOMT0ybOUtyBw/BZFHjGc9+tCdYoSZlUB9EqHfNCGDGCG0qZYdv+vsE57RCS2w2fe
         WryVmXRou3wA+PTjyNcPpOSqEkmYDt3umhKl97Ci2VHMTy1qRP0DmmY6xPrrn78bPHIR
         p1vPu7knxvIftx4ERSItFd7YiPGf26T/yHxOEdOpQWei9W0z/RQBi0uU+Dp5CDQ3D6W1
         dvokfWnLjzeceDenJUYoA+qbihhrKeJs/ORvk2kuNcLNVGjkn0yNJdC7acohdPr2mPzN
         Hpaw==
X-Gm-Message-State: ACrzQf33OTVE2K1FI7z+X9o0YPGVOm6fq7nEOUbWYtkuG+PX09uAjpZo
        255ha/VEshfRab8tCF2KHPjgLw==
X-Google-Smtp-Source: AMsMyM4eJ2ONA70hoaQfrLucLxu4Y8uAr48HeE0P13av3z6DXNQbI9HUlRHv/yK9uSdngnaZkXBuNw==
X-Received: by 2002:a63:f806:0:b0:439:d86e:1f6e with SMTP id n6-20020a63f806000000b00439d86e1f6emr6061715pgh.46.1666163433424;
        Wed, 19 Oct 2022 00:10:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b0017d7e5a9fa7sm5682445pll.92.2022.10.19.00.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 00:10:33 -0700 (PDT)
Message-ID: <634fa2e9.170a0220.e401d.a4e7@mx.google.com>
Date:   Wed, 19 Oct 2022 00:10:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-5-gcb05c81ada76
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 0 failed,
 7 passed (v6.1-rc1-5-gcb05c81ada76)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 7 builds: 0 failed, 7 passed (v6.1-rc1-5-gcb05c81ada=
76)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.1-rc1-5-gcb05c81ada76/

Tree: kselftest
Branch: fixes
Git Describe: v6.1-rc1-5-gcb05c81ada76
Git Commit: cb05c81ada76a30a25a5f79b249375e33473af33
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

---
For more info write to <info@kernelci.org>
