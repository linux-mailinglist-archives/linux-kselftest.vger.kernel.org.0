Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351966E88A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 05:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjDTD1w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 23:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDTD1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 23:27:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AF40D4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 20:27:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f6461af24so373024a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 20:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681961268; x=1684553268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tV8crDjofyv0750I49wkl0WcXsLL7eDJ+4zb9fuL8U=;
        b=U+0vKGQyRzTzOtm6Vwg6IvsfLIs8cE/cGzeNtzx/bOizHJ7DmvCcD5SqTWcXZ3lBG2
         X5Q4SnbgVn3mM3KKXRrcEk+hkuadH13xYkjRW8+NkOOBf4R3tnIG8xP1HK7ZpXcSeSAv
         KsQh6BDaa92EkVmqCUis//S7ULVq1/T7nJIeAcivnmkYVQlN/PGIxl7rD1yKFrCW+n18
         u5/CbN/u0PnvTmUZqaaOnDZelKOMiL4snXvUbf1RiKmuhhFvfnGaJu2h48DrkB4ivmRb
         rYePZSlLBGn0jt7Xp8hRYCw4igd1jgE9zB5dXzu8APxgZpI/+fc5nAJIJvKMZfbbNNJb
         zjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681961268; x=1684553268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tV8crDjofyv0750I49wkl0WcXsLL7eDJ+4zb9fuL8U=;
        b=jH62ufqjNR6CBMfQzuMHOlsTA0olAic9b8oibtDXnBFTYSgs6jvR6e/XlBA0FlSGAq
         ybGFMAEVhJJS2Q8+9vuFE3tKE3IQ6ZgPyB9JME7sa70aWHVSFvkc3vTBJCM21cFcNnYm
         NJTygsDt1AuAiwFc0PfcC9sq2dG0oaj/Oxmxy0idY6ASjRdJFaa22uh3dBiy8mkIDmwj
         t4Kpo1/JU462pAYHCJ4wyI88SZUWm3CpCnfwzGzuV7W8z/i7cMVuSdd7+eBALdE71kUb
         Sq6s3koxLm540vm4WLLFcd4Qx/YyooyKOXvg81nxk7g4gLkw30t2xMM1EY1mojRq8S7H
         Luzg==
X-Gm-Message-State: AAQBX9ePQpJIKwJrdg6leNacmOfM62y4L0VpIYnTC2ivhiEdmemmoccB
        V+VqSuAyKVF2p6ObBYZJjE9NWA==
X-Google-Smtp-Source: AKy350b11RA/ThCptub+7HGqXeK5nxFLIG8g9zQvW6pVmBjrPR/BPpPduPKtIrxkCPLdy4PmJp7wMQ==
X-Received: by 2002:a17:90a:5890:b0:246:8497:37c5 with SMTP id j16-20020a17090a589000b00246849737c5mr123367pji.46.1681961268202;
        Wed, 19 Apr 2023 20:27:48 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z15-20020a655a4f000000b00517abaac366sm115231pgs.74.2023.04.19.20.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:27:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/2] Access variable length array relaxed for integer type
Date:   Thu, 20 Apr 2023 11:27:33 +0800
Message-Id: <20230420032735.27760-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add support for integer type of accessing variable length array.
Add a selftest to check it.

Feng Zhou (2):
  bpf: support access variable length array of integer type
  selftests/bpf: Add test to access integer type of variable array

Changelog:
v1->v2: Addressed comments from Alexei Starovoitov
- Add one more use case.
Details in here:
https://lore.kernel.org/bpf/20230417080749.39074-1-zhoufeng.zf@bytedance.com/

 kernel/bpf/btf.c                              |  8 +++++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 20 +++++++++++++++++++
 .../bpf/prog_tests/access_variable_array.c    | 16 +++++++++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c |  2 ++
 .../bpf/progs/test_access_variable_array.c    | 19 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 13 ++++++++++++
 6 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/access_variable_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_access_variable_array.c

-- 
2.20.1

