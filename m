Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1B3E1ECE
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhHEWfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbhHEWfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 18:35:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9AC061799
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Aug 2021 15:35:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso9425264pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Aug 2021 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bk6BNtpX2bsqpgJ2JxfChzF+Dc9XGh58ZUTm6AVu4O8=;
        b=jkPQQclQNlPFdS72CY978/hPr2qVc+s2HI7k3Zt5J5omsrvgJrSH1HD6Jlj3MJQuge
         Hu6oevksHhctJSP7LGkcFv4wyWcBgJT6QPpaQnaRUQ4FhqvebMSplo2jua+7qwJoQzwZ
         Mip06e6aahIM1xlclwJ0sxNnvwEExMtpIGz4CNCGnrVXP1C0MR9ZU4mj+xdv433qzDFZ
         aIpD6RgaD8pQnITX8PDXOBpxF91+rNzasXZzhJ83NVvAGP9peUHJfSrRAjFn/2XGtO7D
         8he1Wp3CmtH9tGUXRkWy1gAYOJdmigbLVm5IVFtpKloVbksmaKwuWgDXF9380pGsbfVU
         PLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bk6BNtpX2bsqpgJ2JxfChzF+Dc9XGh58ZUTm6AVu4O8=;
        b=N1v3+y2SeyE5lJjIHF4g79kTLTifoJZ/JSLTgc6OP5YBDYKUamHmKBjlzm45yHRcX8
         9y7dj+t2ChyXTPhrMdRt2lPRifl/7osq5Uap/oivxs3SEso1CT/i/Nv+A+O7ooXCXf8F
         ammP0Bas5EVULIeuk8Poefe2YbQSCJ7nAm2By0rLNyn8wqUjcFbHX6oKSqerz0A5WAu5
         Pv4AnQoyI+XSN+iok/SeygSw34bDBR1EvgyQJODLQFsPaFXdgR2cc2/sTWFVdq1Ep/xj
         jovdeNV0lpIAs4GDqftSHNge/Jrie2EQNbmz6Q9siluhhoWuYvc24TSYek+zhu4EjX6J
         4dtQ==
X-Gm-Message-State: AOAM533idIP8fbgiCNu7xoo9yMO410CL0iJIdW/5rVb6zgBxhDHygdGx
        95QrKrOznt8054GrFsRkH58Sqw==
X-Google-Smtp-Source: ABdhPJx+MU/IrGDBdxtcJdhIiCl5rl4cocHpzWp/j1JxUgHqkZ/hkVdHuXYGMoa6ZhUBgkpqnS9dSg==
X-Received: by 2002:a17:90a:9747:: with SMTP id i7mr6976516pjw.141.1628202908950;
        Thu, 05 Aug 2021 15:35:08 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id z8sm7931638pfa.113.2021.08.05.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:35:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/5] af_unix: add read_sock for stream socket types
Date:   Thu,  5 Aug 2021 22:34:38 +0000
Message-Id: <20210805223445.624330-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805223445.624330-1-jiang.wang@bytedance.com>
References: <20210805223445.624330-1-jiang.wang@bytedance.com>
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

