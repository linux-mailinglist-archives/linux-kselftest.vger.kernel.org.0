Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739727D85C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbjJZPOJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbjJZPN5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 11:13:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A27A1AA;
        Thu, 26 Oct 2023 08:13:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso7683335e9.0;
        Thu, 26 Oct 2023 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698333234; x=1698938034; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2K3z0z5gFfUSAY8cI9K8dVfuvFeW0ry0Hfw9vGOpx8=;
        b=UthK9RLXAss9Uc34RsA3frDBn8hSUrlNkA8CBVuFwXRXQj0dRFsOF+U4ZlnmzAnv4D
         wzNPY6ileECGNEPYHS1AD7yfIeaskiqI2HozUic6+s3GMmQx9IeX/RqDAvsbT8DG1OuN
         p0eC+GdoLvdrs9hNI4ksvaIYYd+gBVdklEiYj2F9Vd3U0DvZX51GNXpK9gSMNZWJan75
         rpqRgkINlM4rdIxJpeuygusB4u231eATX/zDrOTE23f9Y9AQND6tSHBVnsuGDpBF5tES
         Inuv7AJ8WNDLl7+1ufU7cJYGyomcOTpnypccR7W/Qop0GIlf2Jo7Ed9i0p/qnbC1wv8f
         cbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333234; x=1698938034;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2K3z0z5gFfUSAY8cI9K8dVfuvFeW0ry0Hfw9vGOpx8=;
        b=Mcpw6xBs8USQl+zi5UDl13zsyRdxLwPH+TIia35iSiC9ldy4bJKg5AAcPJLRQ8Tghr
         3XqzhXzZcD32dlaw8CoBJT64HT07ogduaqp57YQDXm5yr3T5koZ5KNGdtSDTkCpmuHWK
         0J15JB0xhs+vr01DXc8x2O8U7Gq2iAtJZNyTaf4eIMZITB1FGROpF4gNO8IhvqGHCKb7
         EFNuB7aPBDd0KIGUputQW2zQM+vJdSQAWo0eD443WO9KxwXGuyLw0lSqNvVEmxB6lNVy
         iqx2PIYVuftQJV3TG19KUzSsA+VYcYmbyYEXvQNSqDxvwu2wpb1QRsaBwFWcxW05RVsR
         uLag==
X-Gm-Message-State: AOJu0YyUr2c6zzqiXObAgpb7Y7j4YgoHNDPeu65VPmPNu0p5Eh9O90N0
        APhz3PuYNp9jyw8oMdUDpT29n2/vjQ==
X-Google-Smtp-Source: AGHT+IHd8cBe4Ai1d6Qy2CT0+g7QIZTLMCqlNByIsBJwU1XiBBXv3TOmRWWiy1SVlW9LO4PtpxPemg==
X-Received: by 2002:a05:600c:154e:b0:408:403a:34dc with SMTP id f14-20020a05600c154e00b00408403a34dcmr39312wmg.37.1698333233516;
        Thu, 26 Oct 2023 08:13:53 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b0040472ad9a3dsm2843778wmo.14.2023.10.26.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:13:53 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix incorrect immediate spill
Date:   Thu, 26 Oct 2023 17:13:09 +0200
Message-Id: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWCOmUC/x2MUQqAIBAFrxL73YJZCHaV6MNsrSWwUKkguntLP
 wMD894DmRJThr56INHJmfco0tQV+NXFhZBncdBKt43SBgPf6FfyG+bihFfiQug7Za0xtpuDA9k
 eiST8fweYjoCR7gLj+34dH7TqcQAAAA==
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698333232; l=785;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=hVtWhlWKiLNsK4TYgLnM0yAhs3/EIdWSD0x17NE3x9c=;
 b=2H7GmzLqjMdVeNw0YfwhoZY6qXRqYIpp46DpQQuOdRtHfXMGnuKNyu6wg+wOQJeOpW4DaB/X1
 l5c9ynjK6qNCwSXgTI+g3ShDQEGI8HgOnTCN6Vca4SHK5J5YcC8Ic0A
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Immediate is incorrectly cast to u32 before being spilled, losing sign
information. The range information is incorrect after load again. Fix
immediate spill by remove the cast. The second patch add a test case
for this.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
Hao Sun (2):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm
      selftests/bpf: Add test for immediate spilled to stack

 kernel/bpf/verifier.c                             |  2 +-
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: 399f6185a1c02f39bcadb8749bc2d9d48685816f
change-id: 20231026-fix-check-stack-write-c40996694dfa

Best regards,
-- 
Hao Sun <sunhao.th@gmail.com>

