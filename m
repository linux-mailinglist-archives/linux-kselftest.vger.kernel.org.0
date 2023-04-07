Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439E6DAA64
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbjDGIrH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Apr 2023 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjDGIrG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Apr 2023 04:47:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948979ED1
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Apr 2023 01:46:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so39505574plg.9
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Apr 2023 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680857199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5K1Y4OsJcJ4KwCwbQGTYT7oxVpnc4vIiM6hHQQ2APk8=;
        b=L5z2G4SA6MyX2VTrvsYX7fiKhPZ2/afzXT4TdtYxOGCvS+0G5qtWQTdExLTDMrfWrD
         DWgh14164S8R/xx+9veSlgxZn2Yk28Jm1lSUc9LGLnY0ZipjBaMRIVst29rQGP1CoGVP
         VwF1lEebto5ctzHYyH5qzvT+jorn35mhxaFuBGtwR27EByDBB80hTDVKRhoSVvxnHzUw
         0+dct90nfc2yu0mF9qpuNL7ibW50oIIqc8NkU+PKdFQn5qQpS1k3cFpZenfR5TIEFbpz
         hJDctKGJS9ne515dXjQ2AxEAzE5QxmiPhp2Koh+FZ+t6UFfIM1YVOaVXLhlTMgLM6xZz
         t9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K1Y4OsJcJ4KwCwbQGTYT7oxVpnc4vIiM6hHQQ2APk8=;
        b=HT87x0Et9pAX2CWtmgNwhU4S9ZQ59h29MbfWonYiAfLEGCVIpqNejYSNd5J/aG1+Fi
         Q4aj5vz8XvBKQ+X0Bd3HT168mprGUDJL1D/0ciV63DBbPAerks/NQuZz52vXVb1gISv+
         cnIzk8wIEhIOGtcXnOhWt3WKCTCCxFisEfrqx9dzuzWEhuGlQ09zBvL5MD/zyF9e703B
         C/iYS/ZWPAG+HOEIKKw/9EYX7tP1W3Es7xOtDWOT3r5eeUA9LVAovXuzRDGMenhM4UQ6
         FU6/SR8HwZfGtF+ded/W8Fnp+u8/y1M+evdYdGhMC732tqwhiUsNlNXwgYk8FOeSg2fP
         UjBw==
X-Gm-Message-State: AAQBX9fbpElBpWqI6HsadZ6MFxMj0z12dBC4N1g9G5/LywA0tqG0RuM1
        7AQoHd2Wl/5ztTas2nRAj6zeZQ==
X-Google-Smtp-Source: AKy350Ye27QhQgOVdpS1rYrPSe1BiXyfbu4Zr6sUqaZRBP+AOWEFdGMdCVVGvgwJY46k2qIhuhp9Vg==
X-Received: by 2002:a17:90a:f293:b0:234:2485:6743 with SMTP id fs19-20020a17090af29300b0023424856743mr1752040pjb.3.1680857199018;
        Fri, 07 Apr 2023 01:46:39 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a5d0d00b0023b3d80c76csm2333676pji.4.2023.04.07.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:46:38 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH v2 0/2] Fix failure to access u32* argument of tracked function
Date:   Fri,  7 Apr 2023 16:46:06 +0800
Message-Id: <20230407084608.62296-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When access traced function arguments with type is u32*, bpf verifier failed.
Because u32 have typedef, needs to skip modifier. Add btf_type_is_modifier in
is_int_ptr. Add a selftest to check it.

Feng Zhou (2):
  bpf/btf: Fix is_int_ptr()
  selftests/bpf: Add test to access u32 ptr argument in tracing program

Changelog:
v1->v2: Addressed comments from Martin KaFai Lau
- Add a selftest.
- use btf_type_skip_modifiers.
Some details in here:
https://lore.kernel.org/all/20221012125815.76120-1-zhouchengming@bytedance.com/

 kernel/bpf/btf.c                                    |  5 ++---
 net/bpf/test_run.c                                  |  8 +++++++-
 .../testing/selftests/bpf/verifier/btf_ctx_access.c | 13 +++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.20.1

