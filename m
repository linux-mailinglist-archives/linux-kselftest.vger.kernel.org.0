Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4282F13DB89
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAPNWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 08:22:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgAPNWa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYGxxZgSLFtlH8jcI3Nu4qoKg9CPPVXnWephfx6aPc4=;
        b=A9wQgrs8/TEaPDSljURzycYnOsG0n6U9ZiCzUhQezl9lDEs74qXmiwSDvH7AdCQRvjIiRc
        nNnRlkrHnZKQaHMOVN3S6BcIYQAdl+v9dxSxD/O//xYiHKLuV5LOEoG6wGR6NcEVsszAEG
        RBPGASFMhlccUMQuACB6/sQsAvMfjbI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-t81Q9gWLMwOxS71Spi4TrA-1; Thu, 16 Jan 2020 08:22:28 -0500
X-MC-Unique: t81Q9gWLMwOxS71Spi4TrA-1
Received: by mail-lj1-f200.google.com with SMTP id b15so5139048ljp.7
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2020 05:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xYGxxZgSLFtlH8jcI3Nu4qoKg9CPPVXnWephfx6aPc4=;
        b=LKQPzvVNzG5LQppifiJWzHlwUMbs/wQ8+NRVm5dEMMacEgfjCQDed7gdeCCEgedUbJ
         iNEDoQAvTTcKjTUF9iUWo0iNS5C5u+4I89UcRBNC0yuHt9Fv2/hMwFS2XpbgCEgPXyv7
         oxpIgbme6VbKroVZkQWGqg+Z7ih9I+hIlnhQO/LXA6hyLuBsOKi7ZJPxpxf5XlqeoBtE
         ANvtZFDBtG2wy8+3PnTcgAd5lHgReUcieOneWTKHWKIroPwBv7xARyMyus64nRRxcHyp
         Saa6XPEwLsW41LYO2sLPeQeBu2QGcXD0oj2JNULWwiZ1MjLJZUEHF8gPlL+CDtvZOzes
         vE1A==
X-Gm-Message-State: APjAAAXUoRol8raedMkDQ9bsWwfTl97yQwXfkvCcxu5ESOoxQAB89//i
        25fLhsSjweCGZ835ql+tvX3NrZHBWuArOPWUsDA8wGIVRUq2GVBt2Y96OQ4htXLVYr0ODQ5mjyz
        oncskS2MvzcGM6BHjHoB8vEGQkS6T
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr2348635ljm.155.1579180947071;
        Thu, 16 Jan 2020 05:22:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfmdIbBJX76Kqg7+Yyy3+Jb6vlAiz8KLU+B3P9UXhqphkNxoSBonQsyrf+47I652QC3NESmg==
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr2348613ljm.155.1579180946842;
        Thu, 16 Jan 2020 05:22:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s22sm10945565ljm.41.2020.01.16.05.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 19EEE1808D8; Thu, 16 Jan 2020 14:22:24 +0100 (CET)
Subject: [PATCH bpf-next v3 11/11] libbpf: Fix include of bpf_helpers.h when
 libbpf is installed on system
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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
Date:   Thu, 16 Jan 2020 14:22:24 +0100
Message-ID: <157918094400.1357254.5646603555325507261.stgit@toke.dk>
In-Reply-To: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The change to use angled includes for bpf_helper_defs.h breaks compilation
against libbpf when it is installed in the include path, since the file is
installed in the bpf/ subdirectory of $INCLUDE_PATH. Since we've now fixed
the selftest Makefile to not require this anymore, revert back to
double-quoted include so bpf_helpers.h works regardless of include path.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf_helpers.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 050bb7bf5be6..f69cc208778a 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_HELPERS__
 #define __BPF_HELPERS__
 
-#include <bpf_helper_defs.h>
+#include "bpf_helper_defs.h"
 
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name

