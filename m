Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF03E1ECA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 00:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhHEWfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbhHEWfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 18:35:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3789BC0613D5
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Aug 2021 15:35:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a8so12486483pjk.4
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Aug 2021 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcO4lvjnu3cqSavtHa0vi62hVqJGIYj0uCi6qLCTukk=;
        b=pqenJBmlitgkdTgYvxHX0fWULNvELRnrDRZbQXoUtoAjR9cn8Lsv0UPnniV1MTke1w
         oAeOqLI0K6nbDWMshXQmZ3G+rrP02ae+izq+HJLbXEYRrnT5DTamX6AztS7QCgVDnVSJ
         U+TMHcOcaQGOwzPXZPqNy+i/tMvnlDmjoob5Sei+Q7oIB8ulQldD2EUsX0Fwdn2dbzHj
         s66yEVKily6FLePbVKUtNnAI94TIUokp2BapbXBp7dVaU4a8yT++MPg1i10HY7k39JrB
         /+9OBQBPXrAiFqlibpcW9pMjxLwkCLuJE/Zq4mA+z0tfWzeP0TwlCBrhsl9v4unQkuTL
         Lq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcO4lvjnu3cqSavtHa0vi62hVqJGIYj0uCi6qLCTukk=;
        b=aPs/OifMFyoKFZ7t0QYoQxTxI7J+5SQLitRzlWrcQATWzp2QM11Ig23l07DzSdG6ZQ
         llyUn4A7VYJwMcLFWjChYv47t60RnbASWVtv7t/yBu3umR/bM7te9QeV/XsxGIo3oHCO
         ZzLSmqPBgr5GmtgrfuoIz9X3e/Q5i1yOGy/adjnM8WRryez0IGT9S3TwzC+lfDj7WPPO
         CcAJoN0ud1FFI/dWiQNJbji+uvThn9OINL13PC89Ci5Aq3MH2AmEWeyDN9y3XwMhb3eg
         yYCgnIaOT5pjK+c2zyXDvhnAacyFOL2PYK8fZdFUQmlFOLzmMWewUmshjNybeYfTPifx
         UW4A==
X-Gm-Message-State: AOAM533pW8iAZjbWZta8pSjxzQHZ+mwSwzu5wGnSG0l6wtgygGgyOMsk
        B7PSbtfGPTPs/cDPF9YK1cyy1g==
X-Google-Smtp-Source: ABdhPJyk6OQTY1jbncrw9oG2ihZzoZY3iNajitoOztK8kD4V5vZULO46zvKoC8pkGRBxh8KE48ygJg==
X-Received: by 2002:a63:86c8:: with SMTP id x191mr467778pgd.166.1628202903769;
        Thu, 05 Aug 2021 15:35:03 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id z8sm7931638pfa.113.2021.08.05.15.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:35:03 -0700 (PDT)
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/5] sockmap: add sockmap support for unix stream socket
Date:   Thu,  5 Aug 2021 22:34:37 +0000
Message-Id: <20210805223445.624330-1-jiang.wang@bytedance.com>
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
 net/unix/af_unix.c                            | 87 ++++++++++++++---
 net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 4 files changed, 184 insertions(+), 52 deletions(-)

v1 -> v2 :
 - Call unhash in shutdown.
 - Clean up unix_create1 a bit.
 - Return -ENOTCONN if socket is not connected.

v2 -> v3 :
 - check for stream type in update_proto
 - remove intermediate variable in __unix_stream_recvmsg
 - fix compile warning in unix_stream_recvmsg

v3 -> v4 :
 - remove sk_is_unix_stream, just check TCP_ESTABLISHED for UNIX sockets.
 - add READ_ONCE in unix_dgram_recvmsg
 - remove type check in unix_stream_bpf_update_proto

v4 -> v5 :
 - add two missing READ_ONCE for sk_prot.

-- 
2.20.1

