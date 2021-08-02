Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC23DE156
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhHBVTg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhHBVTg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 17:19:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C11C061760
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Aug 2021 14:19:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i10so21203641pla.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Aug 2021 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVBuXMfiCfWt5hdMv6zWGnMRg21pnjj7QA/tDQ0Y95Q=;
        b=zKexeWwWDxfxwxGu+RH3nuqraBaI9t5GFDWnDdsIK9A8wW/PHdQCbYXtBS+bX3AXzy
         UfeMiL8pZOQz8AvL8E5WZtzODhwG6dL9IN5ycqw6bPzBbpQMMvUhjGKqzemWKpg1eNVC
         hEkqhLmPZFdpIiRREY8kIX1U0040YnX2NiW6Cyle1aASfV9rOuLJ6N+lYrUMKDgvxJjc
         AZV5NnrKBOEQxG0aTMWQdMWIiVwSGKLdFis48uBClIFvUJRMStXKb9zGNWTRgzno4INn
         x55npPu8PhasCvXe7BC5CLNaaY5YENt45917beKl7Prb7ulUg8l7dAAuC9IFrZYORFC2
         rbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVBuXMfiCfWt5hdMv6zWGnMRg21pnjj7QA/tDQ0Y95Q=;
        b=JVX0A0Ey9ayouBwdhpYM19mTg46bT+epOO8yet4fEYqK55Kme7W72f0qBvoArVusDu
         CL68VsQoPlw7NyEVeDoHsB6WMdVzzzSKgiIOo0k1P8lkas7Cf2p+luityk2fWB9NWMbB
         6OpTJjcGZalJz9TxpMhgs1sgBkI7i7QYkv65Od0hby27aN7YiMkOSxUk5UkzNNP5UvaZ
         1ofYHmKIDeLrx/0zuGkVAHifwnO0QPXHpcAFND3NB+q31zDdxXe9+Bmr6TX+ebeZ/RXv
         lmhByAGzTXkHVxSr594NqFfWz+nWyPY0/H7bZNaoo24bq+QW72yXLGphBE6kOXIhzqm1
         0hHA==
X-Gm-Message-State: AOAM530VrdszpqIzkSnDCyWBh8/RJDWjSBSax2D/cIkpGiF+wML4j/7q
        mb6pXQXbglTQhEQLWJtjTjECTg==
X-Google-Smtp-Source: ABdhPJw5iuEF1I72i2Wlv49CHbTsllBAXTkInZEfpNrpHZpI8JXJHhz5DJQpobzibHM+k05k7kX1AQ==
X-Received: by 2002:a17:902:cec2:b029:12c:bef0:ec4b with SMTP id d2-20020a170902cec2b029012cbef0ec4bmr3661093plg.74.1627939165685;
        Mon, 02 Aug 2021 14:19:25 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id 10sm12949212pjc.41.2021.08.02.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:19:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/5] sockmap: add sockmap support for unix stream socket
Date:   Mon,  2 Aug 2021 21:19:04 +0000
Message-Id: <20210802211912.116329-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series add support for unix stream type
for sockmap. Sockmap already supports TCP, UDP,
unix dgram types. The unix stream support is similar
to unix dgram.

Also add selftests for unix stream type in sockmap tests.


Jiang Wang (5):
  af_unix: add read_sock for stream socket types
  af_unix: add unix_stream_proto for sockmap
  selftest/bpf: add tests for sockmap with unix stream type.
  selftest/bpf: change udp to inet in some function names
  selftest/bpf: add new tests in sockmap for unix stream to tcp.

 include/net/af_unix.h                         |  8 +-
 net/core/sock_map.c                           |  8 +-
 net/unix/af_unix.c                            | 86 ++++++++++++++---
 net/unix/unix_bpf.c                           | 96 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 5 files changed, 193 insertions(+), 53 deletions(-)

v1 -> v2 :
 - Call unhash in shutdown.
 - Clean up unix_create1 a bit.
 - Return -ENOTCONN if socket is not connected.

v2 -> v3 :
 - check for stream type in update_proto
 - remove intermediate variable in __unix_stream_recvmsg
 - fix compile warning in unix_stream_recvmsg
-- 
2.20.1

