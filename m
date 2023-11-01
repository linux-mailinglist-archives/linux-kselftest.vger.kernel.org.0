Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0036E7DDD40
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 08:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjKAHeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 03:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjKAHeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 03:34:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD8CC2;
        Wed,  1 Nov 2023 00:34:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40859c466efso49778055e9.3;
        Wed, 01 Nov 2023 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698824044; x=1699428844; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNER9LrxazZc1unOxuOkdAcLGVcUlD990LvgBax6cfQ=;
        b=U+Eo8//ImwAm/xb63bBv6qIlYM3zMC/rkrDMlqqBeO54o2g5cqmsbdig4klgxWEGQS
         4zx9FBa20bH3R1JXVldkJLacEoZPtaKfRbVmtEE0CImaDcLqVerOQLDFc1WavANtLvfN
         jR7N3/Kp/ORZc5NrLnJfpoIg5Xjkm1ObjvBOgmszTf1TlBAPDK0RUHk6pUQO2nw9Sks9
         BWUdIkuHe7gUHhyO+j0qFyUbmtD8W7POZfyJn9OH8nsGqZ96+zuzC3qJP1yXd8Aggww6
         whzx1yigwp7ChAlNxg2Md7a+9Pjq8qEQAaBaGJuMOnTpIXxQfRNqBqtZDCVAMVcNcLdo
         fbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824044; x=1699428844;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNER9LrxazZc1unOxuOkdAcLGVcUlD990LvgBax6cfQ=;
        b=hPGy7MCVat8ZiMXQxKMkqd3+IeLeeSdMN5cvGW5Oi5mca8fedGmRx00QVUNY9hhjoV
         o9vOKUfK82viRLzItA61ysVfOSZYlZcTkzimT3/blAbphCni2/25U+/g5mDChLrPRah7
         eA9L+g6r/3piUAl8Sj+xYR2foUJz319QnStMsmJc9w66Islw1YXyjeRjHffXhp6vypc/
         7u7beHF+NrKHyVWqyeL6Upb5cKoxMYnahynJCv9CT1Bs80vpZJL7JAv1i5n9cxfnx1V8
         wFXcEnVr2M7yRnYa9Jpml6z0tHb2D/p0n65D42WoiHoKd+nQuxKQeDh2X01t9FuUYtJ7
         WUyQ==
X-Gm-Message-State: AOJu0YyYkZ4NGbosLI40uT8OVlE69sg4fUcyfiG4kMa+4gjCaPyvVx7a
        BiIfF0bx+2vIgyNmv4i8qw==
X-Google-Smtp-Source: AGHT+IE6y1ECsS1CldkeqwBwwBTEcRnocbIRQ9ScNQbDZ/g+HAVE/8uaVRMAhit/TRF95hut2FnPhg==
X-Received: by 2002:a5d:4dd0:0:b0:31f:bdbc:d762 with SMTP id f16-20020a5d4dd0000000b0031fbdbcd762mr10362561wru.44.1698824043971;
        Wed, 01 Nov 2023 00:34:03 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id i18-20020adff312000000b0032d893d8dc8sm3401810wro.2.2023.11.01.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:34:02 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Fix incorrect immediate spill
Date:   Wed, 01 Nov 2023 08:33:21 +0100
Message-Id: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEH/QWUC/4VNSw6CMBC9Cpm1Y0rBmrryHoZFKVM6UShpG9QQ7
 m7DBdy85P03SBSZEtyqDSKtnDjMhchTBdabeSTkoXCQQja1kAodf9B6sk9M2RR8R86EthVaK6X
 bwRko3SVSCR67D+gXB10RPacc4vf4WuvD+jO71ihQ9Y28kGssXek+ToZfZxsm6PZ9/wGmKn28v
 wAAAA==
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
        Eduard Zingerman <eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698824042; l=932;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=ThUo/m341SAJSMmR2TyDAT9X66kZjyxv8buNFFdDyPk=;
 b=jRSllAPO4dRAxroXA8lhNYVdg4dJk1qH6cH/WAifC4BTdStaARj0dl001Z/g8eSOcGNdFZDqd
 Klvb9C7V63JC+K1JYP/uosvqd+iyfCNQj7Mh9tue4iiL1yr7U0CnhUL
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
- Add fix and cc tags.
- Link to v1: https://lore.kernel.org/r/20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com

---
Hao Sun (2):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm
      selftests/bpf: Add test for immediate spilled to stack

 kernel/bpf/verifier.c                             |  2 +-
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: f1c73396133cb3d913e2075298005644ee8dfade
change-id: 20231026-fix-check-stack-write-c40996694dfa

Best regards,
-- 
Hao Sun <sunhao.th@gmail.com>

