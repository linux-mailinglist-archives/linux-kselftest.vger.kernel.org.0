Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4C3E4D44
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhHITsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 15:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbhHITsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 15:48:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0CC061798
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Aug 2021 12:48:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j3so17724893plx.4
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Aug 2021 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bk6BNtpX2bsqpgJ2JxfChzF+Dc9XGh58ZUTm6AVu4O8=;
        b=KC3n99VEaWNMUZdMdyY9zKGuyHsfZ99gdj1BB7pOe2GUIDHiKeQq6fujCf6k2XGlNh
         +f4qPDcQfvMWe4mORcVFByr4dKslSWEb8icxESZ6C1/ByE3DLvsf1vh3hJ/xmXhvKAN+
         uWRapfdmnOfNsSQBsIjQ1ceIYU7grQPapTkVgGyF22CTqGxvZ2y5mCkb8qd0pzWKnNcF
         chaQWAExevXr5Uc5ZvD89GrU0ovBIGw/OGRU6+ZedZXfiDG1knEX1/qMjGWUNw3lSSWe
         v131W5ApL9Mv4JrqBegMNNchTq7RZvPkqlk2xffd9SBabboRCCxjKetqifpRprVgYn+L
         FDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bk6BNtpX2bsqpgJ2JxfChzF+Dc9XGh58ZUTm6AVu4O8=;
        b=slSuTJTR6mTdFYM3yys4dzz2vExd9N9h9HjOsW+BB/HKL1lVWvxsUIMdB00qrAeXjl
         TiIUcn6gF/B9jsZSMKfKKwBHFEaeqBjaU1yoQbDZnsIqNKuqhco1JUUA38eJjIhtWK4K
         1I1N6WKtQPemMiPqxazdNw15vbwFg+rVHiLqiwDIZO3v4I4LS6+cic4FJkJEAR1z71Pd
         ZhIx41HmIzSKRtHL0J53KKgDfmvTZa7mf/amqlvpubnhcCrXSUjChvGulpcn+73GqOmq
         X75UrPPoLcBI0Teom/AEejD5blI57m3/IUGw8avzYJAVK2JyrUPM0GmIeU/kkGFI12wO
         zHeA==
X-Gm-Message-State: AOAM53343fLh/eqfIs5rXQQ6B3bmxZPC6D46udH6BXiA4dUmEaVFaa76
        bTZXN+22CyJhcj02bLDjE/ScCg==
X-Google-Smtp-Source: ABdhPJySPma0qcyCvbQl7EQglifnKgFqZACeqma2+pn5TmUI6Fx81WMsMt7hM8uzAglt8BHLW2yrUQ==
X-Received: by 2002:a62:1d45:0:b029:3ab:415e:8d5f with SMTP id d66-20020a621d450000b02903ab415e8d5fmr25383591pfd.8.1628538480679;
        Mon, 09 Aug 2021 12:48:00 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id x19sm21372291pfa.104.2021.08.09.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:48:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/5] af_unix: add read_sock for stream socket types
Date:   Mon,  9 Aug 2021 19:47:34 +0000
Message-Id: <20210809194742.1489985-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809194742.1489985-1-jiang.wang@bytedance.com>
References: <20210809194742.1489985-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To support sockmap for af_unix stream type, implement
read_sock, which is similar to the read_sock for unix
dgram sockets.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
---
 net/unix/af_unix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 256c4e31132e..c020ad0e8438 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -672,6 +672,8 @@ static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
 static int unix_read_sock(struct sock *sk, read_descriptor_t *desc,
 			  sk_read_actor_t recv_actor);
+static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
+				 sk_read_actor_t recv_actor);
 static int unix_dgram_connect(struct socket *, struct sockaddr *,
 			      int, int);
 static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
@@ -725,6 +727,7 @@ static const struct proto_ops unix_stream_ops = {
 	.shutdown =	unix_shutdown,
 	.sendmsg =	unix_stream_sendmsg,
 	.recvmsg =	unix_stream_recvmsg,
+	.read_sock =	unix_stream_read_sock,
 	.mmap =		sock_no_mmap,
 	.sendpage =	unix_stream_sendpage,
 	.splice_read =	unix_stream_splice_read,
@@ -2358,6 +2361,15 @@ struct unix_stream_read_state {
 	unsigned int splice_flags;
 };
 
+static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
+				 sk_read_actor_t recv_actor)
+{
+	if (unlikely(sk->sk_state != TCP_ESTABLISHED))
+		return -ENOTCONN;
+
+	return unix_read_sock(sk, desc, recv_actor);
+}
+
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				    bool freezable)
 {
-- 
2.20.1

