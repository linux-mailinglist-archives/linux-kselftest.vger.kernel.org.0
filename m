Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAB57D276
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiGUR2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUR2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7457489EB6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 10:28:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so3253712fac.13
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1mPfR3D12ZnGHuxmP4MWOfQkjon3IFNK8YMkGzC5zg=;
        b=AK+QQ07cWg5OzZYxkHTagjOQVVhcMylfq0iUug7TKRBMO4je+Hyjphi5L6Oy++ntVY
         hD9+BcYVn1+pGlKypGr+DIG6uKTSSql1iw69t9a3NqFVXnWh76Y9r9hik483VgrU6jmZ
         MZYXmLVlTbWBUZNPyPyvGksxg2e+ceQYEpPUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1mPfR3D12ZnGHuxmP4MWOfQkjon3IFNK8YMkGzC5zg=;
        b=vpK8JrPZXj6U5LpBTuCwjlq9ONTskZuVCFvLXKg3Mn3Rj9lqB9jxDBOoNpk7fp26Zw
         ZOvzKeW0sHC93ntoYecEKwIMOaVLuv/Lq1WCIK1o5q7nVk77tmZ//mh5bASok5mGKrGP
         nrzxxaHrmt+wr9p8+NuGA1srquLY0aq0OWaIRIP18OEpfs/oBfxkf0Fy/Lkn9qRplPNj
         JEMs1Z3UkYCQ97Zw/ytYzLenZrxGbZMUWuNBwqQuFvN3UJiGNacRYOS8JVZ9bqnsd4X7
         xnrnd60XV6fPrvNBVT2v0eYpAq1X6eEpvWnC3/TnJZAI+6d6jMtZ02K2hKgT/6B4uVFJ
         hVcQ==
X-Gm-Message-State: AJIora/kU9/e5xFSLqCKAQDkw3AVce7rhxlLJrzzkHrq57VHU+G6pL19
        kdeKNY25jdaubGoqgstCGVPCZQ==
X-Google-Smtp-Source: AGRyM1ucz1/qbrcJkssVY75ngCanvcCZN+R6AF84LUHfijoH0ifhCLQYVSwrkU4TK8tIsfKFLjjkdA==
X-Received: by 2002:a05:6870:9a09:b0:e9:20a7:6cf6 with SMTP id fo9-20020a0568709a0900b000e920a76cf6mr5980435oab.122.1658424494733;
        Thu, 21 Jul 2022 10:28:14 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id du24-20020a0568703a1800b00101c83352c6sm1106207oab.34.2022.07.21.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:28:14 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 0/4] Introduce security_create_user_ns()
Date:   Thu, 21 Jul 2022 12:28:04 -0500
Message-Id: <20220721172808.585539-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While creating a LSM BPF MAC policy to block user namespace creation, we
used the LSM cred_prepare hook because that is the closest hook to prevent
a call to create_user_ns().

The calls look something like this:

    cred = prepare_creds()
        security_prepare_creds()
            call_int_hook(cred_prepare, ...
    if (cred)
        create_user_ns(cred)

We noticed that error codes were not propagated from this hook and
introduced a patch [1] to propagate those errors.

The discussion notes that security_prepare_creds()
is not appropriate for MAC policies, and instead the hook is
meant for LSM authors to prepare credentials for mutation. [2]

Ultimately, we concluded that a better course of action is to introduce
a new security hook for LSM authors. [3]

This patch set first introduces a new security_create_user_ns() function
and userns_create LSM hook, then marks the hook as sleepable in BPF.

Links:
1. https://lore.kernel.org/all/20220608150942.776446-1-fred@cloudflare.com/
2. https://lore.kernel.org/all/87y1xzyhub.fsf@email.froward.int.ebiederm.org/
3. https://lore.kernel.org/all/9fe9cd9f-1ded-a179-8ded-5fde8960a586@cloudflare.com/

Past discussions:
V2: https://lore.kernel.org/all/20220707223228.1940249-1-fred@cloudflare.com/
V1: https://lore.kernel.org/all/20220621233939.993579-1-fred@cloudflare.com/

Changes since v2:
- Rename create_user_ns hook to userns_create
- Use user_namespace as an object opposed to a generic namespace object
- s/domB_t/domA_t in commit message
Changes since v1:
- Add selftests/bpf: Add tests verifying bpf lsm create_user_ns hook patch
- Add selinux: Implement create_user_ns hook patch
- Change function signature of security_create_user_ns() to only take
  struct cred
- Move security_create_user_ns() call after id mapping check in
  create_user_ns()
- Update documentation to reflect changes

Frederick Lawler (4):
  security, lsm: Introduce security_create_user_ns()
  bpf-lsm: Make bpf_lsm_userns_create() sleepable
  selftests/bpf: Add tests verifying bpf lsm userns_create hook
  selinux: Implement userns_create hook

 include/linux/lsm_hook_defs.h                 |  1 +
 include/linux/lsm_hooks.h                     |  4 +
 include/linux/security.h                      |  6 ++
 kernel/bpf/bpf_lsm.c                          |  1 +
 kernel/user_namespace.c                       |  5 ++
 security/security.c                           |  5 ++
 security/selinux/hooks.c                      |  9 ++
 security/selinux/include/classmap.h           |  2 +
 .../selftests/bpf/prog_tests/deny_namespace.c | 88 +++++++++++++++++++
 .../selftests/bpf/progs/test_deny_namespace.c | 39 ++++++++
 10 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/deny_namespace.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_deny_namespace.c

--
2.30.2

