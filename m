Return-Path: <linux-kselftest+bounces-6886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D1D892414
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E719FB22A9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1F13AA52;
	Fri, 29 Mar 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvvCJknS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BED13A3FE
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740003; cv=none; b=aTF6W8zwTc4HHYunt7vTIwUMJuIuCa80Ouu4o/Qj2FGOqgl3GUSKCpaaMPHHCiT7oBIDAwi4y/o8imqlm7JCe9Vg9uES2EszwDp4hEFkFCl/ZhrWiK48svWD/H3cwFVOTrxg8FaxYIFJhL6GAEdZbEmZXxtXKDfBUPzGNg1+0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740003; c=relaxed/simple;
	bh=WvFjbe5Gio5p4zohr/Ppr/b/4wbz85m1gtQran9FEU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzJ5djwnodh+3oIHR5eEw5YaQv/QbFE/XpowdZ3/clqtQrQ5MJwx/IeREK6IIHKwx7cgpj7lApSnqoapqc+XJf89rFHAkTqqG4h58ShZzQjGgk9nedGFHWeguDWHPV9t7ZvzGMsDiNCIt2yLPuMEPshTQmixvB7J7PORq/EyDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvvCJknS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so3954326276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740001; x=1712344801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbvV0u8XBY9xDuz2lN6+l2kDTrO5oaEqCBNhNq59mVw=;
        b=TvvCJknSETV2b5BHoBV+KHircI8RG0r3NWGwFE3P8O2fNVH8UhXhSyYWOs8xHMQwi+
         JQcm/rFPV9qi9wcA+Cycz3qFdUQafYOqHgt7tcWjRmadeCspMxquKCarJlP/2Tt0gPyK
         vWBWsxJQVSYM2mQvfjpCnxIrozNIs1BqOlq0MMzjIL5TMfH1N+yqPtXN0G+CVKEBPePq
         mkDZI56i3WlEsh/Xdis8+3OyY5ZQE9BCFrRSqwID+0yRUt2ulb95t6T99qGGG9+ehzyQ
         ggprjrdAJgvVv0YtvPFnyS2ECmQzTXvgAF2wG/UoAlO5rA3wISh+LLYNTrg9KKpWV6Vu
         VIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740001; x=1712344801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbvV0u8XBY9xDuz2lN6+l2kDTrO5oaEqCBNhNq59mVw=;
        b=JrETTcywF57KNwHcsKStJgXvs1pqxsbqjs5O3cEiIG6TcAyimRqLZDSyOZt+EO03Ji
         CqFzG+BaeeUMGjKSqe3o4XCWpRtew21fAsxL4Nrm799vsho5qjOY/tIPzcD33ypop3hJ
         W14m/Pmkwy1SsvYmreR3WZjhdk/U4wY7iQ0c9zCU/bIukbXaMJWrcUkDJIAON1Uk0ODV
         eIlrXZlKgvUZ3AE52N9Q+WOy1sRlEdNcjHulzRgUa9Y8IuTBGcQuazTcYIPlZ/NOOIuU
         v3zRO59ig/Z9vpNJPS/nMuiPB7B3dSwdr6JUo/35zgdVDBLujVRDX8vds0lLUumcbevR
         ygFg==
X-Forwarded-Encrypted: i=1; AJvYcCX3LBywFJMJmG6VOV9XjwNkmDfKmGkoJLoiRFEFeKrSC9Y9wA8818ezCqlSsyz90kW/953VL0arGzv01q6GW/TS3oJZhPIt+iTBEu8ATBFi
X-Gm-Message-State: AOJu0YzppVm6gjz5Y1Wrlv+0RNqU3DwRrcWlCmy1bcmpwF8ZbKl1L3s7
	ghxPKE0RLM2qE9loWLTjk01z+Fpdd3jZtwHgbhu29Rin/6OQBktQRd1sC6LfhwZs7fWwwopdjA=
	=
X-Google-Smtp-Source: AGHT+IHV9/yL97+mJdhDWN8bvqgaKmZP0Anot8i5ZOBRqXEQJ86jHkPNBbIG+1NcaUZYkN/9StR9FKyYew==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:2404:b0:dcc:5a91:aee9 with SMTP id
 dr4-20020a056902240400b00dcc5a91aee9mr893141ybb.7.1711740000986; Fri, 29 Mar
 2024 12:20:00 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:49 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-5-jrife@google.com>
Subject: [PATCH v1 bpf-next 4/8] selftests/bpf: Add recv_msg_from_client to
 network helpers
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Copy recv_msg_from_client helper from test_sock_addr self test in order
to use it in the sock_addr_kern test program.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 31 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8eae4afe3ec3d..ef0a94d9e9d5c 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -498,6 +498,37 @@ int get_socket_local_port(int sock_fd)
 	return -1;
 }
 
+int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr)
+{
+	struct timeval tv;
+	struct msghdr hdr;
+	struct iovec iov;
+	char data[64];
+	fd_set rfds;
+
+	FD_ZERO(&rfds);
+	FD_SET(sockfd, &rfds);
+
+	tv.tv_sec = 2;
+	tv.tv_usec = 0;
+
+	if (select(sockfd + 1, &rfds, NULL, NULL, &tv) <= 0 ||
+	    !FD_ISSET(sockfd, &rfds))
+		return -1;
+
+	memset(&iov, 0, sizeof(iov));
+	iov.iov_base = data;
+	iov.iov_len = sizeof(data);
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.msg_name = src_addr;
+	hdr.msg_namelen = sizeof(struct sockaddr_storage);
+	hdr.msg_iov = &iov;
+	hdr.msg_iovlen = 1;
+
+	return recvmsg(sockfd, &hdr, 0);
+}
+
 int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
 	     const struct sockaddr_storage *addr2, socklen_t addr2_len,
 	     bool cmp_port)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index a4a458c858d59..f88f2470e3fcb 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -61,6 +61,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr);
 int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
 	     const struct sockaddr_storage *addr2, socklen_t addr2_len,
 	     bool cmp_port);
-- 
2.44.0.478.gd926399ef9-goog


