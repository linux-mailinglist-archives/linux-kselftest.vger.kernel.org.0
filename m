Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198603DAE34
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 23:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhG2VYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhG2VYX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 17:24:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC48C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 14:24:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so8475007plr.13
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYC8KR1e6cqjZEWqNUpcJSjzZr7ivDjCCKhTW6pvrp8=;
        b=J4gsgcv9npd42uowK6FCRab6BCIbq1nL30If9Vwc9O7N7TA3MVKdHK5DrcecNIIjGt
         2BST6np+0zG1UJE9FLvaWxPqlkCJ0z8CeG+Qp9uIzaNY2NkVxh62xq34f7mxjLz/qeEH
         2JSnzPwrHduImAqiMNnHxn+1koYwkU98+bQ7oOMJkG8rJFqPJMF/gBKkiqeJ1njSuCE7
         mr8Rlp0IOIroFisfjJIFAFF2tuHnqtS39jyO8YE5Q3aToZMHX352h4rrYylTrqLdOXra
         rLKWUn4iMau9UCa05yrXKKshFEo0Oj6gUi+X4CzgxA03Vzm8LhMwen4BxJBs0YgJUkKb
         Vecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYC8KR1e6cqjZEWqNUpcJSjzZr7ivDjCCKhTW6pvrp8=;
        b=AZ5SlV2d3/s6UeSfuuK2SZV0iQ3WYyvypRiQ2miFPiP88xv/ACn2UDy8BfiRKQTIMC
         dQUnjmjdhwlyS0KUk9kz8XGwBJ2TJl5dwBJChiGxDrTu7+qtTkY+SQCiaFPQ+03I/RZb
         7zaMbCohTPLXXMEt84JYy4mrL3wp5AAuXflhPjqA2Zo7Jmu/k4xTxDN38k/CnWsTDeI3
         EtfxtLzSHiShq9PfqBXqknIto4Qjc6hNM83zCohIskeM6ds4wZsrdwG5irwbEL3QyKxM
         fD0OPLasDRW26Sm6gyKj5V4vSSIVLMXzi0jIC46tZG6HaSSwcU39Ztu0Bj/xYTF8c9Ye
         6ofQ==
X-Gm-Message-State: AOAM530mjWRMSD4KxYzWK9uOMYNJIFD96uxwsiHX85pyfxQzjvpECNuf
        wxmXPJvcLz3Ee1MdPwY1g9jHtQ==
X-Google-Smtp-Source: ABdhPJxZt3PxYhY8WjvtXMUVa1ZGqb479iYdG28Hl5xpwwMrwbrv+iywtasIIo96PBnb4T3lttiEvA==
X-Received: by 2002:aa7:8284:0:b029:312:1c62:cc0f with SMTP id s4-20020aa782840000b02903121c62cc0fmr7069697pfm.75.1627593859920;
        Thu, 29 Jul 2021 14:24:19 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id c15sm4686258pfl.181.2021.07.29.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:24:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/5] sockmap: add sockmap support for unix stream socket
Date:   Thu, 29 Jul 2021 21:23:56 +0000
Message-Id: <20210729212402.1043211-1-jiang.wang@bytedance.com>
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
 net/unix/af_unix.c                            | 88 +++++++++++++++---
 net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 5 files changed, 192 insertions(+), 53 deletions(-)

v1 -> v2 : 
 - Call unhash in shutdown. 
 - Clean up unix_create1 a bit. 
 - Return -ENOTCONN if socket is not connected.

-- 
2.20.1

