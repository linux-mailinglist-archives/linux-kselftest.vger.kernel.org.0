Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7D27DCF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Sep 2020 01:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgI2Xu4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 19:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgI2Xu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 19:50:56 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E28C0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 16:50:55 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w32so39708qvw.8
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=y64gCzYCkai7AxMDOAccdFDI8O3APYfmcQlop7QJQJ8=;
        b=cRyJUap6ryOrDfaRkftF8F2PiQN5Kqv/zRq2pzb1QXs73YmyPESuX1xwfQs5AzZeSE
         k8JUbluHoDC4hEtO0ichR5bf31yvFzmZdMh49rWKQKqv0j1h9stJDj3+bxPwt/m97wtk
         v/Vwj0XRvfFRlC0NAQJuFGgNi8EtCs/ozaRlwFt6YBiWcco+iIQ6f3J9aC3vg4f1XqK1
         gPZI3AuDkMMrM36qviYeXLRViBs1sejywtfvbEoFYvunNV0AlrylhbTiX6vy/9R7GkvH
         5MbDiRuJ3438olcvxDEFNaba/9kcyrSoWnMYQEThNJzTjMelHXewl9J38ewLf4EUA3Qr
         8Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=y64gCzYCkai7AxMDOAccdFDI8O3APYfmcQlop7QJQJ8=;
        b=culxZq011do/L8NePn6tS204l70Fajj0W6ybMr0jWWy1KTS8UqizD7q+K6LwK5/Xrl
         6yL2CXsteADIrqnxbK4DfvXCFsnjuxeJwdRTDFtqaSEbKWH2x84QxpA8PpT80MpYDg+5
         4Dpv1FdZ1KosootV+NB81ghTDfG8rYH5xDGa3YQyYfAS8I30hoMP6AC/I3DdH4QxKvwD
         LP1u3q6sZZrukS9Em0Baim65il7LYLMbYP8PNR9cmgLhU0LydGo3fPg0Yj0Aw4zsriGB
         eoTKk2OKiNrps56dZt0ZA9dJL6LVMKCy4ee20ktK6u5gqS71mVNjb+ICVkUsL9I/mBjT
         LMfQ==
X-Gm-Message-State: AOAM532YtQ5uPLeQtz09SGoTK7NDney3NWDMMdSCWDgr+PUgleNa/yWe
        5rSdV00tNUbujqmS/ASklxeyXtbbtuY=
X-Google-Smtp-Source: ABdhPJxxcDSvZKQ8KiekE+T4rYPWqxkFy0WW0Gn6rtGDsoJp0Wyi8mau2Z14k9GeUGSXm93hrJJTEq8MB8k=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:ad4:5387:: with SMTP id i7mr6722288qvv.43.1601423454885;
 Tue, 29 Sep 2020 16:50:54 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:50:43 -0700
Message-Id: <20200929235049.2533242-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH bpf-next v4 0/6] bpf: BTF support for ksyms
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v3 -> v4:
 - Rebasing
 - Cast bpf_[per|this]_cpu_ptr's parameter to void __percpu * before
   passing into per_cpu_ptr.

v2 -> v3:
 - Rename functions and variables in verifier for better readability.
 - Stick to logging message convention in libbpf.
 - Move bpf_per_cpu_ptr and bpf_this_cpu_ptr from trace-specific
   helper set to base helper set.
 - More specific test in ksyms_btf.
 - Fix return type cast in bpf_*_cpu_ptr.
 - Fix btf leak in ksyms_btf selftest.
 - Fix return error code for kallsyms_find().

v1 -> v2:
 - Move check_pseudo_btf_id from check_ld_imm() to
   replace_map_fd_with_map_ptr() and rename the latter.
 - Add bpf_this_cpu_ptr().
 - Use bpf_core_types_are_compat() in libbpf.c for checking type
   compatibility.
 - Rewrite typed ksym extern type in BTF with int to save space.
 - Minor revision of bpf_per_cpu_ptr()'s comments.
 - Avoid using long in tests that use skeleton.
 - Refactored test_ksyms.c by moving kallsyms_find() to trace_helpers.c
 - Fold the patches that sync include/linux/uapi and
   tools/include/linux/uapi.

rfc -> v1:
 - Encode VAR's btf_id for PSEUDO_BTF_ID.
 - More checks in verifier. Checking the btf_id passed as
   PSEUDO_BTF_ID is valid VAR, its name and type.
 - Checks in libbpf on type compatibility of ksyms.
 - Add bpf_per_cpu_ptr() to access kernel percpu vars. Introduced
   new ARG and RET types for this helper.

This patch series extends the previously added __ksym externs with
btf support.

Right now the __ksym externs are treated as pure 64-bit scalar value.
Libbpf replaces ld_imm64 insn of __ksym by its kernel address at load
time. This patch series extend those externs with their btf info. Note
that btf support for __ksym must come with the kernel btf that has
VARs encoded to work properly. The corresponding chagnes in pahole
is available at [1] (with a fix at [2] for gcc 4.9+).

The first 3 patches in this series add support for general kernel
global variables, which include verifier checking (01/06), libpf
support (02/06) and selftests for getting typed ksym extern's kernel
address (03/06).

The next 3 patches extends that capability further by introducing
helpers bpf_per_cpu_ptr() and bpf_this_cpu_ptr(), which allows accessing
kernel percpu variables correctly (04/06 and 05/06).

The tests of this feature were performed against pahole that is extended
with [1] and [2]. For kernel BTF that does not have VARs encoded, the
selftests will be skipped.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
[2] https://www.spinics.net/lists/dwarves/msg00451.html

Hao Luo (6):
  bpf: Introduce pseudo_btf_id
  bpf/libbpf: BTF support for typed ksyms
  selftests/bpf: ksyms_btf to test typed ksyms
  bpf: Introduce bpf_per_cpu_ptr()
  bpf: Introducte bpf_this_cpu_ptr()
  bpf/selftests: Test for bpf_per_cpu_ptr() and bpf_this_cpu_ptr()

 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |   7 +
 include/linux/btf.h                           |  26 +++
 include/uapi/linux/bpf.h                      |  67 +++++-
 kernel/bpf/btf.c                              |  25 ---
 kernel/bpf/helpers.c                          |  32 +++
 kernel/bpf/verifier.c                         | 190 ++++++++++++++++--
 kernel/trace/bpf_trace.c                      |   4 +
 tools/include/uapi/linux/bpf.h                |  67 +++++-
 tools/lib/bpf/libbpf.c                        | 112 +++++++++--
 .../testing/selftests/bpf/prog_tests/ksyms.c  |  38 ++--
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  88 ++++++++
 .../selftests/bpf/progs/test_ksyms_btf.c      |  55 +++++
 tools/testing/selftests/bpf/trace_helpers.c   |  27 +++
 tools/testing/selftests/bpf/trace_helpers.h   |   4 +
 15 files changed, 653 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf.c

-- 
2.28.0.709.gb0816b6eb0-goog

