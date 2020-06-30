Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7C20FC29
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgF3St3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgF3St1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 14:49:27 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5DC03E97A
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jun 2020 11:49:27 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c5so15072608qtv.20
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jun 2020 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LEHppYXCQPcRgd0zlbLe7CmHbNbqX0AwBnt1nKT8kmo=;
        b=gDKmgaxn/Cl6wcc1lPhuw4d+qqZAEQfqpIWDlxkB2OP7eOtiDx3WCaV9AFMCtBGcEW
         6y4r4V13gqh1xMTARtmFL7ye+2ccgbPwchESgvOexvYAy6hhtgrGLCKG6QC3Vkrev2y+
         IcxsPM4HEFx4vUl3Trmszcq2jN0HtzaH7vyAMM+/hVR7gCA6JLkndlLF4fRw/mi2fYa/
         rqJwYliZI3TiCxV3OBUl6aFdha/b4dwy17RorxyAwRczDrSXGLV+oykGuVWj1ZNTPbvv
         I1GjO7O7ckRnbMSSppCivAiy/2XvKnfWVijFknFlTXq65JbU2aUhnsfHnxvk6sQUTHLf
         fWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LEHppYXCQPcRgd0zlbLe7CmHbNbqX0AwBnt1nKT8kmo=;
        b=E9fQmcdzv34VHxvVm1iAnLm3VoIHUV773l101Be459dqGnGxzGU3NlkEBRDDzsQtnF
         eOgvg9NLky4o+1+9tNjRzYMzhNf5l01g/SBTuXGP51XhL9gmTBXoP172pZsJPbgT3ceJ
         qRt8aU+Od8vaaHAOuM9qK3oGEAMcTGCGkPiheBi/ckUob9u5N9P4XKxf7mXJ3gLpWhN/
         OLPY0I20XT9CDwf9H/y1FQSKBFZYNVU2OH3/zo+h6EaJShaMq7fFz7hq39URvgqzcSkU
         X3pnc7Z+EPoKQt8A0G5kAF1Cyb6pf1V63Tdi3mk5kwhwoCCL+21ZEQfdX80ndrbIUOwu
         ZOGw==
X-Gm-Message-State: AOAM533RvVcEU+r2ieUrQZk1Ss/s98+equtObUKFDpCohbcIjJQ5HhbR
        5k4dfW9o5eRRobr4CBFQuDmQyrmICR8=
X-Google-Smtp-Source: ABdhPJwRys7ufIj6Wc7BHqYbfXPqG7SI1+88BKjiZMcxuVaaHmLS3yYhRz/blmSR7Scygm3uV5jRzePkDzQ=
X-Received: by 2002:ad4:4105:: with SMTP id i5mr11143826qvp.170.1593542965986;
 Tue, 30 Jun 2020 11:49:25 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:49:22 -0700
Message-Id: <20200630184922.455439-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next] selftests/bpf: Switch test_vmlinux to use hrtimer_range_start_ns.
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kselftest@vger.kernel.org
Cc:     sdf@google.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test_vmlinux test uses hrtimer_nanosleep as hook to test tracing
programs. But it seems Clang may have done an aggressive optimization,
causing fentry and kprobe to not hook on this function properly on a
Clang build kernel.

A possible fix is switching to use a more reliable function, e.g. the
ones exported to kernel modules such as hrtimer_range_start_ns. After
we switch to using hrtimer_range_start_ns, the test passes again even
on a clang build kernel.

Tested:
 In a clang build kernel, the test fail even when the flags
 {fentry, kprobe}_called are set unconditionally in handle__kprobe()
 and handle__fentry(), which implies the programs do not hook on
 hrtimer_nanosleep() properly. This could be because clang's code
 transformation is too aggressive.

 test_vmlinux:PASS:skel_open 0 nsec
 test_vmlinux:PASS:skel_attach 0 nsec
 test_vmlinux:PASS:tp 0 nsec
 test_vmlinux:PASS:raw_tp 0 nsec
 test_vmlinux:PASS:tp_btf 0 nsec
 test_vmlinux:FAIL:kprobe not called
 test_vmlinux:FAIL:fentry not called

 After we switch to hrtimer_range_start_ns, the test passes.

 test_vmlinux:PASS:skel_open 0 nsec
 test_vmlinux:PASS:skel_attach 0 nsec
 test_vmlinux:PASS:tp 0 nsec
 test_vmlinux:PASS:raw_tp 0 nsec
 test_vmlinux:PASS:tp_btf 0 nsec
 test_vmlinux:PASS:kprobe 0 nsec
 test_vmlinux:PASS:fentry 0 nsec

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/progs/test_vmlinux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index 5611b564d3b1..29fa09d6a6c6 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -63,20 +63,20 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
 	return 0;
 }
 
-SEC("kprobe/hrtimer_nanosleep")
-int BPF_KPROBE(handle__kprobe,
-	       ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+SEC("kprobe/hrtimer_start_range_ns")
+int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+	       const enum hrtimer_mode mode)
 {
-	if (rqtp == MY_TV_NSEC)
+	if (tim == MY_TV_NSEC)
 		kprobe_called = true;
 	return 0;
 }
 
-SEC("fentry/hrtimer_nanosleep")
-int BPF_PROG(handle__fentry,
-	     ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+SEC("fentry/hrtimer_start_range_ns")
+int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+	     const enum hrtimer_mode mode)
 {
-	if (rqtp == MY_TV_NSEC)
+	if (tim == MY_TV_NSEC)
 		fentry_called = true;
 	return 0;
 }
-- 
2.27.0.212.ge8ba1cc988-goog

