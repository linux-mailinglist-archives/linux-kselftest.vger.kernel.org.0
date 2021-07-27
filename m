Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B03D6AD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 02:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhGZXd2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 19:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhGZXd1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 19:33:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF35C061764
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 17:13:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b6so15276651pji.4
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8KgAJIkqSeG/hKZeeo63HZDWfcmzz7HUI7sYt9dwKU=;
        b=C+RhA7ziN1zDjtNR5+EWOcd/bjdRj04Spii1eQKtWinQJJ3cPwHJ5PMQGFIk1k6V/X
         /OG3RhKw083oQqwms2GGh+IGNokqmQvlpQryIcvnNxViHjBQ3JG9/ggT6U2f1JeztaC7
         PhnA0NYnNdKdjxvUjVsBBKcYDy1RFuPwLdHeXSJRtkf9N6+W2UqxcKhiKmrWw9usjUjn
         0zjntieDPS7WgWaNlj6ixS7f/jZg+dQzEpDZXFQ6DN3kgXCdtrX6uAfIjSTbo8WYh0tA
         0GNhcmxd3RqR4ofhzUqka4PMQ336tiNOH6x7dwoSqSXW6e2YCZlByhLSJxh/3jyiAbjW
         49YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8KgAJIkqSeG/hKZeeo63HZDWfcmzz7HUI7sYt9dwKU=;
        b=QgOsykPYiaKEBb6w/qb2Ki2RZ4sY7oEoF+9hVVckbItZ2rLiqXna1sTDk9a2W9QzdL
         U74agKAEHBgipcgHrWrIfpanhrbu0N64KFqv5owUXC+MWhlep9V7h4mSj/UPOQFF1NUu
         ytPlIwnEii1HlQ+bBuC/1VBwMjeCPnLeRQSupLjWGIfmHaObDrkGPXQ/ZqgBBtJsnMwm
         oYWy/b8ftmrvt/YhzBX90QV2fAzvKBGg9VQENEZxGlhC7yuSe3qpruHeQbSJ9ia/3La0
         j2n46h15Pexywq0l9o+KO8knQms8dhiAZAHcWjNAbTuJnDC2VogNYqkdHm/UaNSbsbBC
         8ihA==
X-Gm-Message-State: AOAM531hmgIkZtPCL3t/3kMw3K2SRQzMH/kNb+NME+tJvb98DXbTxts+
        uXVegJtPXYNRSf+o6+8fGFEOOA==
X-Google-Smtp-Source: ABdhPJy0qtMofanpMrj7StC17d15Tex6Rg7PpBZKhRx0uLrez5+EamqiCFlDgTM0GIGin3nNRVdEUg==
X-Received: by 2002:a17:90a:9f91:: with SMTP id o17mr1459607pjp.29.1627344834176;
        Mon, 26 Jul 2021 17:13:54 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k1sm1079452pga.70.2021.07.26.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:13:53 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Tue, 27 Jul 2021 00:12:50 +0000
Message-Id: <20210727001252.1287673-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727001252.1287673-1-jiang.wang@bytedance.com>
References: <20210727001252.1287673-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two tests for unix stream to unix stream redirection
in sockmap tests.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>.
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a9f1bf9d5..7a976d432 100644
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

