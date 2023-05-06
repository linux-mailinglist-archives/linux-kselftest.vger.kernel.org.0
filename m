Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0446F8D8B
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 May 2023 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjEFBbq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 21:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjEFBbo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 21:31:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF272A3
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 18:31:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9963a72fd9so4754095276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336702; x=1685928702;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hp0Ifesb79HPJK/KIKzPfPQWNmnCC9SBcN/OAlybow=;
        b=wn934bIjSlyYsjqUN/3i+nRgeyQ79+B1hcBs3GqYpWaJGFZXQA53NXLvputweRHFGw
         LMfhnju5v1AaMaoz9f4P0qQIYb5kkxJLnRgq6S2mToWYINn6YFZSntYoHigHqeEq6SRH
         41UinaAMctI7sBvB3z8E9//uz0Rbp52e9gIrDjgSBr6yw4JTzlIHjeObPY/CjBcsKX6O
         3i3syYMHoqqPrAapT7KfPo6h+KYOWD/FKhXk0yctt6mi/6o53LfT6gF6XfKNQuYTu6Cy
         wvc+4/7hWx1xbkRJOTC+2uMbg8jSKXBsY2oQ/eH/QSsFZs2JHRcIbHx9VIAXj/LEoAcy
         Oy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336702; x=1685928702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hp0Ifesb79HPJK/KIKzPfPQWNmnCC9SBcN/OAlybow=;
        b=diqzNVJMmk5ssSBzZvpWG/BE8fOGp+D6Ro/463XCcl8Ao9U5nKM6efB9f8em49b+3z
         kCE2bgHkXxCtMlkY0fYXSfhHgzRN6ChGlgzx+spBOAkFkBJFDGn7BGfZZ3TB5Tc+mORc
         OdRnDr3Wxq5nYZ9UrCx9RffKS77Ams/Ei6x8I4duNHl8t4WJbuObicM8W+tZ+m1yEC2Z
         ofEjF/jPSIttKcgkWpQgYbDbsrlfs+Ga/pQXu8xpQAEnY1Legt4aXSLYvD0r0YaU0gPS
         sLYXexADGyo5Ju9kPLnP/T9ZpxRY7VXHHcSJuGMWir87Z4dPKMT8ERhbrMfDSywY3BU3
         ZuVw==
X-Gm-Message-State: AC+VfDzlp/CG0YuoGLW8YuQglW7n3js5cgrf4vk8p5qFgX22/hKNcd8/
        ku/VOlcxyawSCzHEflP+1zqFRYjBeBQ=
X-Google-Smtp-Source: ACHHUZ41f8Sy+cWp32D8Fr5R8k9F7ETQDqrRG/yHewH0fB/t2EnZKA0kLgCgnG1g9wuRjbqZzUYo9wR+6UA=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a05:6902:1021:b0:ba1:b908:364c with SMTP id
 x1-20020a056902102100b00ba1b908364cmr2063343ybt.12.1683336702159; Fri, 05 May
 2023 18:31:42 -0700 (PDT)
Date:   Fri,  5 May 2023 18:31:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-1-drosen@google.com>
Subject: [PATCH bpf-next v3 0/5] Dynptr Verifier Adjustments
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches relax a few verifier requirements around dynptrs.
Patches 1-3 are unchanged from v2, apart from rebasing
Patch 4 is the same as in v1, see
https://lore.kernel.org/bpf/CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com/
Patch 5 adds a test for the change in Patch 4

Daniel Rosenberg (5):
  bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
  selftests/bpf: Test allowing NULL buffer in dynptr slice
  selftests/bpf: Check overflow in optional buffer
  bpf: verifier: Accept dynptr mem as mem in helpers
  selftests/bpf: Accept mem from dynptr in helper funcs

 Documentation/bpf/kfuncs.rst                  | 23 ++++++++++-
 include/linux/skbuff.h                        |  2 +-
 kernel/bpf/helpers.c                          | 30 +++++++++------
 kernel/bpf/verifier.c                         | 21 ++++++++--
 .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 38 +++++++++++++++++++
 7 files changed, 118 insertions(+), 18 deletions(-)


base-commit: f4dea9689c5fea3d07170c2cb0703e216f1a0922
-- 
2.40.1.521.gf1e218fcd8-goog

