Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3213DB96
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 14:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgAPNXO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 08:23:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgAPNWV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JNaXEay+BfE39lyxyJ2PEP3ihhAoXZzq/eELhC4L1o=;
        b=PXTrRSNK/2aLBLlVEZNlZj+gAi7F43FmmR2MmqmeC/T9kfv5/UpMZYgbVPEWNsvB6m7cF9
        R8AVwUoGNI6RW7Jj1nQVp1riwMaSAiiQb2W0VKphO9AIBsBLN3UMqUO6il6Sx/v/0Nn4ai
        l8clMlk3N9SdquHLQJdbiLeWxv5g7PI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-p0szXVABO0qr_mFE-j7XBw-1; Thu, 16 Jan 2020 08:22:19 -0500
X-MC-Unique: p0szXVABO0qr_mFE-j7XBw-1
Received: by mail-lj1-f198.google.com with SMTP id s25so5147543ljm.9
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2020 05:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1JNaXEay+BfE39lyxyJ2PEP3ihhAoXZzq/eELhC4L1o=;
        b=Jx8TQW9SXC67Yuy3yCaB6pgQW/8p98AOX1O3iE+Jt48/nSb4a8hSY9LxTi4ucMjBHw
         YD0XFnV4m8S1oLWRfZSDs+POTrLVnBlljSjLqmJXLvGnQIe4281pQe7Ya9GuS6HSadRE
         AOH/C20wAlCCnFMg7dYoC2K+jF84ST3vCd615YL476lXxuDz7bjznRb0nGkM8nvwICKd
         oC+8keQF+4kaoSEpWfQEkSiFX2BYO0Eo8af+Sju402NzH1ddYO54OAWN+xsppoVhQoSj
         uUZBsJq86SUOH3AO2CGMqp3aZUaxfT0jef4O+IsB0rF5Oz4a71ipcV/ITi0iX6Ca1sx4
         5CSw==
X-Gm-Message-State: APjAAAXFvyidNDclx/O1pfUY9Hh+u85/A+3PWpe2ANT1+Kfo6lz1plFL
        +UAASryxrUP9Tslrn3PLQbY5ydhAGSvBOEiuC4JAul3zrcnrAvIyAlbU/3pe7n8Kmn/OqZbRme2
        IgpeiYqQxDq9iPpXeh8TWnjGy+9Um
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr2097979lji.181.1579180937449;
        Thu, 16 Jan 2020 05:22:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmjI3D3P1O0fXnsgjkFsT/4yKIO+PCfW2/djdyLIQ9ovy7b5zFtyo0PIRC1gQN0jlZQeucRw==
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr2097957lji.181.1579180937304;
        Thu, 16 Jan 2020 05:22:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v8sm10931631lji.16.2020.01.16.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2129A1804D6; Thu, 16 Jan 2020 14:22:15 +0100 (CET)
Subject: [PATCH bpf-next v3 03/11] selftests: Pass VMLINUX_BTF to runqslower
 Makefile
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
Date:   Thu, 16 Jan 2020 14:22:15 +0100
Message-ID: <157918093501.1357254.2594464485570114583.stgit@toke.dk>
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

Add a VMLINUX_BTF variable with the locally-built path when calling the
runqslower Makefile from selftests. This makes sure a simple 'make'
invocation in the selftests dir works even when there is no BTF information
for the running kernel. Because of the previous changes to the runqslower
Makefile, if no locally-built vmlinux file exists, the wildcard search will
fall back to the pre-defined paths (and error out if they don't exist).

Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 246d09ffb296..30d0e7a813d2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -127,7 +127,7 @@ $(OUTPUT)/test_stub.o: test_stub.c
 .PHONY: $(OUTPUT)/runqslower
 $(OUTPUT)/runqslower: force
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	      \
-		    OUTPUT=$(CURDIR)/tools/
+		    OUTPUT=$(CURDIR)/tools/ VMLINUX_BTF=$(abspath ../../../../vmlinux)
 
 BPFOBJ := $(OUTPUT)/libbpf.a
 

