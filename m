Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446673E4D40
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhHITsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbhHITsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 15:48:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC30C061796
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Aug 2021 12:47:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso795548pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Aug 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUFIOXGUgEZLnSbRpqnZTUxb7XP4VLQZy2Ys4V5jqps=;
        b=bbSikQjppSa0AHU+g/q+rfbrDDDVD7IJmPTYJLA64zD6iV88GqGUYPDGzlzBuhA3RE
         KykCtwjjCvyIP3ElZJnowZ/6TVoN5rhPjutJ9FE6mwcPrIrBmkHepuN/r+gXfCJ8evVN
         lunN2yQ6D63OuJkgURikDC/rY7vA+TekFgk/w4NLaK8R9PdmI1J0EN3IBriaAQd9eOab
         espG/+yIQrj58MvUGAvT6FrIT9L9G6OZU++zsQqCWiIJKeC4gvVjFqmUxl4QpxUgr1g/
         CNMgFX0b08579waSAcLBrqYteZJ/GVpv/q/gu+kW+zwrBE/XDggl6U3VIr+QvHwwQQUy
         YIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUFIOXGUgEZLnSbRpqnZTUxb7XP4VLQZy2Ys4V5jqps=;
        b=nfhvwATZwzv+394AucGeViHC4w0iQZMbh6uh22CB4sDG2mHzLZ94i1rpbIyGvlJxmm
         eltEP8gagqIpOZ/cLw1I5Zy8mr2nkGK23zkJab6cPeLVHdC2SHxrjpJHvx9am1c3Eb+y
         Kzm88aPVmee6VQz61TABwIBAhkc8W/sUuEId5vay22VdVa4WCjmcfaOlvVFC1EnsvdWE
         TAaVLVsbvlG/DaekkgJEW2v03bW8VuR0rIRgg6HGyEp4leb+m2C7yioFq+uZMiplxCLU
         Mh2mQ/mVxx/WK501LYtLeEPCB/m/FZ9v6nmd9ksjmINTeSMYS9/MeyLA1ZMbZN/f6uOB
         iPWQ==
X-Gm-Message-State: AOAM533j9m0meRFMKPIqMfMl8Q2QcAOn1IhbhmFx3CHVcZBxZBDAxavr
        Pea/dteAhCkcuXVmD/JbyEMojQ==
X-Google-Smtp-Source: ABdhPJyD5plcIXNVB+dsuBEACNFRhwvrhhOepYM1wjxa4WvAXtvB81fY6QsJoKK0waKBDmFIigiRwg==
X-Received: by 2002:a65:6653:: with SMTP id z19mr172690pgv.394.1628538475733;
        Mon, 09 Aug 2021 12:47:55 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id x19sm21372291pfa.104.2021.08.09.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:47:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/5] sockmap: add sockmap support for unix stream socket
Date:   Mon,  9 Aug 2021 19:47:33 +0000
Message-Id: <20210809194742.1489985-1-jiang.wang@bytedance.com>
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
 net/unix/af_unix.c                            | 91 +++++++++++++++---
 net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 4 files changed, 187 insertions(+), 53 deletions(-)

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

v5 -> v6 :
 - fix READ_ONCE by reading to a local variable first.
 
-- 
2.20.1

