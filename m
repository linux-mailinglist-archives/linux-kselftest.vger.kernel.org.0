Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770CA13C5A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgAOOP5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 09:15:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729393AbgAOONC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2f/3xqMCvPgjOWRi/4hBoG4txZFOAtpty8CahkBiCk=;
        b=LCJ9rwZhZBhUQyyEowGvJOOpCRbfCJHqwYj1Vkwd8h9l1DmnAe0TpDb0GQbwldJj/Mmvpk
        jOdqPSwENct28kra+Wn1mjRF3QQrj7t3LpdaRQo4LB3IRH8SsP3ZYCzNbs2Wm7xZmOfjLy
        8PZLFPdIVlFIwf6n+z/UX3Uyuvxr5DE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Ji9O-vKbNcm0m8GvqEZfDQ-1; Wed, 15 Jan 2020 09:12:59 -0500
X-MC-Unique: Ji9O-vKbNcm0m8GvqEZfDQ-1
Received: by mail-lf1-f72.google.com with SMTP id i5so3263152lfo.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2020 06:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L2f/3xqMCvPgjOWRi/4hBoG4txZFOAtpty8CahkBiCk=;
        b=E04FXhXK148WixmwOj0BQT+cBjXQvYupu8CT4OQY9KMBa+r68g8760HkmmAAJ8/Pdt
         9mfB40CDZW1SGouHBr0b9sBN4UrMdEbAjcLqzlZB8e7QnWodupkInnlK7Y1kiRv0ZbQo
         G8JMQ8+MsQCSCBAM4j486bH4mHqXQW522Q+UNLpGJhjg+IrbbicDI/AK3es9/K8FZYvA
         qiypHkehcNeaFMwdWmMygI5c2elkNOM/lTT7xw93uTqtV8sGEe+yftWoya34Ec6rVxiV
         9/nfdxf422kflyPhkWAMLGsCQRIN85YSAY0fY2qMRd0skPbJMHFNsQqezlFp9zXzl1vW
         WG+w==
X-Gm-Message-State: APjAAAU9A7eauZKibB6LzB6TrQtdpHlJSmUx8sOKuuLu8OpXx/BgrAKO
        8aMkGfJnCAgDBijI0j8U1YPzWajhcnkkllVYG4zPqBkqqwkA2BctoNYrd/IQw5uOMkYMmLp0yaa
        MNAbUxATZr0SwojuzUnEZJYLUSuNe
X-Received: by 2002:a2e:9587:: with SMTP id w7mr1910166ljh.42.1579097577655;
        Wed, 15 Jan 2020 06:12:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/am/cdvueKyne+fGOGIHUIMVc0ISCYot7rVGpWw5I/QvHynTKT2v2M5koWXR3yS6NY44ANQ==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr1910116ljh.42.1579097577147;
        Wed, 15 Jan 2020 06:12:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t9sm8960034lfl.51.2020.01.15.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5F6421804D6; Wed, 15 Jan 2020 15:12:55 +0100 (CET)
Subject: [PATCH bpf-next v2 06/10] perf: Use consistent include paths for
 libbpf
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 15 Jan 2020 15:12:55 +0100
Message-ID: <157909757530.1192265.16430056843174690136.stgit@toke.dk>
In-Reply-To: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Fix perf to include libbpf header files with the bpf/ prefix, to
be consistent with external users of the library.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/perf/examples/bpf/5sec.c             |    2 +-
 tools/perf/examples/bpf/empty.c            |    2 +-
 tools/perf/examples/bpf/sys_enter_openat.c |    2 +-
 tools/perf/include/bpf/pid_filter.h        |    2 +-
 tools/perf/include/bpf/stdio.h             |    2 +-
 tools/perf/include/bpf/unistd.h            |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index b9c203219691..49f4f84da485 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -39,7 +39,7 @@
    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
 */
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
 {
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 3776d26db9e7..7d7fb0c9fe76 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -1,3 +1,3 @@
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 license(GPL);
diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
index 9cd124b09392..c4481c390d23 100644
--- a/tools/perf/examples/bpf/sys_enter_openat.c
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -14,7 +14,7 @@
  * the return value.
  */
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 struct syscall_enter_openat_args {
 	unsigned long long unused;
diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 6e61c4bdf548..607189a315b2 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -3,7 +3,7 @@
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 #define pid_filter(name) pid_map(name, bool)
 
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 316af5b2ff35..7ca6fa5463ee 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 struct bpf_map SEC("maps") __bpf_stdout__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index ca7877f9a976..d1a35b6c649d 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
 

