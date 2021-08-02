Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB53DE15A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhHBVTj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhHBVTi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 17:19:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D7C06175F
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Aug 2021 14:19:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so21223822pll.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Aug 2021 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB7YFrieIpmwVCmE7FizVML0zcWrHXYydeLPQdihUz4=;
        b=S/pRWwTVzlbZMfxX44uINtBvykBVML7GHvPj/N/zYNtvYZgXV9ZcQPs8nnQci/OYJG
         r+zMFXQi7GLtgEA72n4WC5TVz7Sh985DoEKIMnWvct7wmQqP2lBi9cFG74oFbLNn/vBW
         mTctdwglEUz3DLAGCTiT1Ta57dY/ch+qyO6ISrc6FKrr2AtGvH+DCGcLxesLkz351FmB
         4CK8hgIcKGjfD57stZ7SfTnu0v0yl9lZ7UhIsblOAHETz2OW1Bfgbv9vRO/DoIS1uVMX
         leIXzZ2Zfmmv3TrujCvcGCYIKgNG2Ns+8CkJ80hIwDH2hng85ODddAqar6KY8ZFlDuNU
         S7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gB7YFrieIpmwVCmE7FizVML0zcWrHXYydeLPQdihUz4=;
        b=ezVzvK4R2GEMT42A+iCZAXXeFTz2q/OOrcY1pgMJA8A40bAtqypQejbHeSsCsAl1zX
         schn3f1o7XzmWW+H2WSLWO62F/rwIcZpRRNNnGOSkE0scoW2s4MfxWE2pXUqYYXacj7p
         LR51VdTnZJ2AuarBY4Q5eggbTLgCfGjTB0FnLRnqqhi3wwULTGvjDLzCbrR4SDIJD4mp
         Vf/5w3UCE9dc/HEqaB6tyS8h25l/o5u2NDwz5hLyN09K2rvzcIU3lQ6VBMpHBKV83OYL
         ae/cDQ0uRVBKsxk6IKkbGfpPBD8F4UwNfYAWnAHGNZjHHkjX0VBqZkTz5xBMF+dFSVw/
         Mdlg==
X-Gm-Message-State: AOAM533fqGo3LZH7aiwwU5cvjFeSoLD+Pe3TzBYNUnrblzElqNO6bEqJ
        kzRIJdW0VK5VqbTj1s55Misacw==
X-Google-Smtp-Source: ABdhPJwI66JYy/BibL9BT54xY85Hdzga6ldif9ry5yFD41JVVMqtj5dUpSFqUjrCpkLbfCqqe+E2rQ==
X-Received: by 2002:a17:90a:bd92:: with SMTP id z18mr19229054pjr.195.1627939168194;
        Mon, 02 Aug 2021 14:19:28 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id 10sm12949212pjc.41.2021.08.02.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:19:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/5] af_unix: add read_sock for stream socket types
Date:   Mon,  2 Aug 2021 21:19:05 +0000
Message-Id: <20210802211912.116329-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802211912.116329-1-jiang.wang@bytedance.com>
References: <20210802211912.116329-1-jiang.wang@bytedance.com>
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
index 89927678c..0ae3fc4c8 100644
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
@@ -2311,6 +2314,15 @@ struct unix_stream_read_state {
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

