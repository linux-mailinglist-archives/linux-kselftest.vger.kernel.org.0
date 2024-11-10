Return-Path: <linux-kselftest+bounces-21742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D229C3136
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 09:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B89B20F85
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75514E2CF;
	Sun, 10 Nov 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ARcykrM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC88149DE8;
	Sun, 10 Nov 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731227287; cv=none; b=sXd7rHyrUeX0AkkCC/GonzFKNMLVzW/5hQSQzZU08VbBFDrh4lwmV3q9pR4q4gEiDLK8Ey1ffqf+JBC1g3GTO5MVoVDJbj4pwLidOGRq3tZ17Gid2sD8U629SoAfpwN+BmVWJwTj7CHOoGQNWAjq5nWlSL2YYJwYCbs/aVMmmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731227287; c=relaxed/simple;
	bh=s/HE862Ebjc4x9QSbLryT2tjzrtXi+x51IAifw3w0tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rORzx/T4Xa/NxRVReSlDISLJXU2tmiVpLaiQoKmuKL1Rp4eUicksTRSG4j94BcwZ0JlJkw+VBFIX+J9RHHrW4pDX9fCzuLogvAebIUt9plIvma1tiNym9OF+42M8yImOeX0LkAIoxCF7FaaofpZGdtZ2qvdaWrLn6Bm0ee5bqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ARcykrM5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0mQMe
	EqbIH1W/gwL+X7sQKXQSByBBidMVZJPmvHc5LI=; b=ARcykrM5vVDJAAnqHpFGX
	SHDrebMAk55e2TQdvZzL5nx7QpYXtE+9HEaBgFkqc0XQO2tCVRF9zR0ZsiW/EsGG
	y7ZaihYzSVFjlkVpFsoKFjprM2ZocHCeiGsBhr2uKUska6muzLcrN/8R8fqCurQe
	u6NR9GEUDdQFDKFOKnNZKg=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_zwRbjBnO5BvEQ--.51752S3;
	Sun, 10 Nov 2024 16:26:23 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	daniel@iogearbox.net
Cc: mykolal@fb.com,
	ast@kernel.org,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	haoluo@google.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	Jiayuan Chen <mrpre@163.com>,
	Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Subject: [PATCH bpf v3 1/2] bpf: fix recursive lock when verdict program return SK_PASS
Date: Sun, 10 Nov 2024 16:24:51 +0800
Message-ID: <20241110082452.40415-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241110082452.40415-1-mrpre@163.com>
References: <20241110082452.40415-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_zwRbjBnO5BvEQ--.51752S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkAr1DXF4Duw48JF4fKrg_yoW8Aw1Dpa
	4ku3y5GF9rZr18Z3s3KF97Xr1jgw1vgay2gr1ruw1fZrn0gry5urZ5KFy2vF4YvrsrKF98
	Zr4jqFsrtw17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_WrX_UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxGTp2cwXFTxvgAAs6

When the stream_verdict program returns SK_PASS, it places the received skb
into its own receive queue, but a recursive lock eventually occurs, leading
to an operating system deadlock. This issue has been present since v6.9.

'''
sk_psock_strp_data_ready
    write_lock_bh(&sk->sk_callback_lock)
    strp_data_ready
      strp_read_sock
        read_sock -> tcp_read_sock
          strp_recv
            cb.rcv_msg -> sk_psock_strp_read
              # now stream_verdict return SK_PASS without peer sock assign
              __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
              sk_psock_verdict_apply
                sk_psock_skb_ingress_self
                  sk_psock_skb_ingress_enqueue
                    sk_psock_data_ready
                      read_lock_bh(&sk->sk_callback_lock) <= dead lock

'''

This topic has been discussed before, but it has not been fixed.
Previous discussion:
https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch

Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue")
Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b1dcbd3be89e..e90fbab703b2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1117,9 +1117,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 		if (tls_sw_has_ctx_rx(sk)) {
 			psock->saved_data_ready(sk);
 		} else {
-			write_lock_bh(&sk->sk_callback_lock);
+			read_lock_bh(&sk->sk_callback_lock);
 			strp_data_ready(&psock->strp);
-			write_unlock_bh(&sk->sk_callback_lock);
+			read_unlock_bh(&sk->sk_callback_lock);
 		}
 	}
 	rcu_read_unlock();
-- 
2.43.5


