Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0BF3DAE4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhG2VYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhG2VYf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 17:24:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD516C06179C
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so8556517pll.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P804EkvFn0VAlLFLpkTDkQMHTFJyfBf84bJVijuk6QE=;
        b=dC1o5JwNCalIc67spfo5hNab+Dt0qiaAvRdyb6QJWJjb7FGcopjbDBCsHQpNE2IaOe
         UcEVgwF5tJrwHTYjVuYgX69nUh/EAgA4SBL3DvkM+uGmWDfL60Ia6T49V2eCKRaYz9xM
         bKV7smjFUa/wIPtS6zGFAJZyXU4vq7XKInKyzN+iBHDec1qgD/LzaTnVZ0clUVkV/olz
         XqAeR+893OZFQCSVTk6SLZZgnTLxQdeRB7tjaBcAmvj75Slckg1OLeuNLmhgtfDEVn8B
         pwScqVVtKTN5mhtRFh6zHIivp35KrEGFaLif8+MhnB2cPgiOW8OIItL3UP1AR5XMl89L
         diog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P804EkvFn0VAlLFLpkTDkQMHTFJyfBf84bJVijuk6QE=;
        b=gVWJk+/IBwLWsjC3GjzL7qaZqetlVv49MqbeGQQ0W+60DOBnI6wvWTs2pOi5p6xLI7
         srh4ycg5UZ92oyDYzpboGlDlm3pvMt2WcUYB4rmmeZ51pUnPuO1Wnkuxd2ReaxjJ9gF2
         9M1p6qmrjEyhFHkuFVvqOUblnPddifdex7m2K3G5e5k6oZ/sSV5JH0VMYtuL8GDLkLcZ
         1QMY+jU7qpM+MvVcF2ECNwinLEOwqkXW1w0Sk0neBvACYNXASl/fMWbADpRQlMy7q6y1
         EdNf8R1m6HVJ69bAbCZBYXT75T/3oR78UywJwHWcROd25kfvjB70huwuLd6LG3k7Zf+9
         uU7g==
X-Gm-Message-State: AOAM532yt9rqJf/L/5GIorX3MwVdo41VjcN3Ml8T3hMVXal0cfr8Fy38
        CXdq+SNhyxcZLQOgZc/7siHmSw==
X-Google-Smtp-Source: ABdhPJziHcTOM0HV/igPeyKZPBHiSrcNPd/zNJ5Eq2CehLSbnnVWlq3d+PFzXrcE/5iZ4h8SYCseWA==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id y7-20020a1709029b87b029011e7c15a597mr6542105plp.6.1627593871331;
        Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id c15sm4686258pfl.181.2021.07.29.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
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
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 5/5] selftest/bpf: add new tests in sockmap for unix stream to tcp.
Date:   Thu, 29 Jul 2021 21:24:01 +0000
Message-Id: <20210729212402.1043211-6-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729212402.1043211-1-jiang.wang@bytedance.com>
References: <20210729212402.1043211-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two new test cases in sockmap tests, where unix stream is
redirected to tcp and vice versa.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 07ed8081f..afa14fb66 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1884,7 +1884,7 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	xclose(p0);
 }
 
-static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
+static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
@@ -1899,9 +1899,13 @@ static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				    REDIR_EGRESS);
+	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				    REDIR_EGRESS);
 	skel->bss->test_ingress = true;
 	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				    REDIR_INGRESS);
+	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				    REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
@@ -1961,7 +1965,7 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 
 }
 
-static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
+static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
@@ -1976,9 +1980,13 @@ static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				     REDIR_EGRESS);
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				     REDIR_INGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				     REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
@@ -1994,8 +2002,8 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
-	udp_unix_skb_redir_to_connected(skel, map, family);
-	unix_udp_skb_redir_to_connected(skel, map, family);
+	inet_unix_skb_redir_to_connected(skel, map, family);
+	unix_inet_skb_redir_to_connected(skel, map, family);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.20.1

