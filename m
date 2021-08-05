Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F63E0DA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Aug 2021 07:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhHEFO1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhHEFOY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 01:14:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD3C061798
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Aug 2021 22:14:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a8001b029017700de3903so7681949pjn.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Aug 2021 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=f8VLcDJC+GRjS77dEkbSH6oWriAdkrwFK8WU/fuDD0VoO5jfFofEfUhFzBRQ/W0qwL
         DFZ/l/JHSWlAXdZDv/POklmCvh2gbAKB/anr+MLYyldRM7T/sFqsveKKbrqeqZAnHuG/
         mahuvRljWFeg1AR5PQBmTelYbs2vJo8ipHPxbP45gHbimwrKlIEh1M+Vw4hpnbz0WzyH
         XDIVvOfc91KduWvUIqiJyIyCved82FFZAjPYfUFH3QGNVYpfiLllHIEV6c01AWhEkNwf
         gwdKMH22KS58YnDu4LhZxT2pkAeRsPPnYu+Bjh7KueEvt/KT+tjteGWmKFVWpadAI80c
         4UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=MHX4EGGo5E1RS6aF6lycLu0GS3QpDmJN5rxEh/mgwaoeHphhhYMtis1M634h/2aEHE
         z1NuPg8e4Ec1qE7BbugpBaO7K6B/HCekYyR2K71Otsr6qx7qjtdYSQ/zw9GgVlbQ2J2A
         mUuwLH4VmmbWgkohJs+hotkk2R29iYAVgAr/74PZOLcDGLqOJEi535XCqSxxCI/lr5VP
         OTqAG5DkvlfIWxlxv7T3aXtdT49hFTDY6Neix68jiGYlyboR3HZd09v7omaQssDUgODU
         gCkNfDivIxa/kdQvCEO9nwjYVAJBQRIz+/3AVd1essunX0MhWLyhmibxPTfnBrZMgRXI
         PgqA==
X-Gm-Message-State: AOAM533NdoPcfJgeMWLVAc0rmE3idMt1Vzbr633DKpiTv+e0u6rRva6B
        uxAzMWC9vJpYTMTkDYoQ54g4Ng==
X-Google-Smtp-Source: ABdhPJxoqkDuGMiJPBMRXDNgMTWDDbDekyZOw7bqlEeTLB83QJFlTOdX9N/wIdxhzebo8D10q4B+iA==
X-Received: by 2002:a17:902:8a98:b029:12c:3177:c3ef with SMTP id p24-20020a1709028a98b029012c3177c3efmr2465741plo.21.1628140450732;
        Wed, 04 Aug 2021 22:14:10 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k4sm4201098pjs.55.2021.08.04.22.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:14:10 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Thu,  5 Aug 2021 05:13:35 +0000
Message-Id: <20210805051340.3798543-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805051340.3798543-1-jiang.wang@bytedance.com>
References: <20210805051340.3798543-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two tests for unix stream to unix stream redirection
in sockmap tests.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a9f1bf9d5dff..7a976d43281a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -2020,11 +2020,13 @@ void test_sockmap_listen(void)
 	run_tests(skel, skel->maps.sock_map, AF_INET);
 	run_tests(skel, skel->maps.sock_map, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_DGRAM);
+	test_unix_redir(skel, skel->maps.sock_map, SOCK_STREAM);
 
 	skel->bss->test_sockmap = false;
 	run_tests(skel, skel->maps.sock_hash, AF_INET);
 	run_tests(skel, skel->maps.sock_hash, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_hash, SOCK_DGRAM);
+	test_unix_redir(skel, skel->maps.sock_hash, SOCK_STREAM);
 
 	test_sockmap_listen__destroy(skel);
 }
-- 
2.20.1

