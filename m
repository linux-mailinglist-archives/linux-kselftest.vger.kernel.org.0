Return-Path: <linux-kselftest+bounces-16874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B53966E07
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 02:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3872B286D6A
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D42149012;
	Sat, 31 Aug 2024 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ad3uFVkh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90282E405
	for <linux-kselftest@vger.kernel.org>; Sat, 31 Aug 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065028; cv=none; b=k3zCBihHmGBph8o4X1PbfGUmsS79FYuxK57QFFsCbQh07defZquNLP5HoALTPVox/y6/2WLVWKYYaRXpipYWLaWWGvyWyZOdIBoPPujI5RY8CXRyY5LJwblJbae4Si6THSXvwiflWDErEwk9WTEouwmCdcg+Ab049tACR26jnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065028; c=relaxed/simple;
	bh=kO38wLNY/ehN1+du6Pia2RgDKmPHlK2J5tPgcRVG8do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pilOnFIdEqWqEoMieBdUakw/LIkkxXCKB+5SMshUbUcMkLrFhS7UuwGrzty0eygZWa81qS4dqgzNQIWN9kZgdBl5MnscmcCkdG2RDzFPrwEbq+Hjcz0lX820qmSVPAc0YU2kK0RlVukUo94aCiV3+zR46q2FKme2nhiYpKjU9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ad3uFVkh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a74f824f9so2681761276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725065020; x=1725669820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=thFV3hABXS3j0LVWtLXFudwLyebRkUk62CGz3FGVY48=;
        b=ad3uFVkhZ4cyf+NHKQ0zscO86aJmnTISbpLi8LTtKBm1y9WQuh3+/CuEImgzxhGzKC
         hJORxF0kkmEn0aX6bNmWN4sWaGxKhTBVCy88S5cvrTXz7p9/wjTc3ytYvRlkBDE95YEE
         yQXY0TY2XqB8pQz9O2ezpmPTWtrIe0aLN0mj6jbos3nsuHu8yMjlDOr9yxtsxY26taud
         MQe6IoY1IlMZc3/2weBVzLMYcOxImYGtOaSpGCyuljAtp9OaZAJBeir1yyQHmpHV1DgS
         B44CIvNzJPt1Q1L9ZodfbwATJIHSSRqXvVwm3SXXCYXgKHkZJ0iY8+JlTbjSB62vmxpT
         Ez1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725065020; x=1725669820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thFV3hABXS3j0LVWtLXFudwLyebRkUk62CGz3FGVY48=;
        b=IbaKxGZh8NYXor3sWEBs/fB76KNIMG2hrIl6yDhDboAnGWwOM6u8uZN2036xHn71x5
         VWPJ5p5CllpZHfi30Kbyu/yeBJVZ9XCX6Ihc12Lo4fJjnJt9GsGWiyRMkcUh/Nxm1PEK
         91Dw8TSjiAMzg4pJcDUUbTConmJtAW4y08orRnpvbryPUJMM9AFIXpW0lhAqT5Ncwvlq
         TGj5Gttf7UVQUdd0eKrQZT49hDfFjVsxw8K7QpYNFz7u698+cRnQAxHtjAjdUfnchG72
         Vte9+weeK1DxfA5BUPKXHEOe8aUScqEi5SzpirMsBgVNUt/A8iINblO6EQy7euIu2t79
         Mw5A==
X-Forwarded-Encrypted: i=1; AJvYcCWNNMIfdWYmYyYDlPyDQSpSYOr7yt0q7iCxExWtnnbwc3DwRtvug+/yW9pOqQuAajOLRnDrxIJx1G6gJar6ocU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlbTYq9xuDJ3mjDdOxJ+2G39d2Fqk0atIfE2wSaduSI/ERisB
	38XN2G+Gekmxr01TRJqEI0STUd1GqAST1WPMvGVxGs9KaFkL8ODM9352H+UGnCKFCGTap8CIjZK
	waRYgG6QlnYLt9DBUYkeyTQ==
X-Google-Smtp-Source: AGHT+IHz63eTYf6DdNxqFZ2bc1Gw5qThzjOmLKvuoYmvFCpDWXvDOyJZbMlWMoIv4xK6hmmefjhFxFwtZ1TQdKHuTg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:aa28:0:b0:e11:cd91:a3e2 with SMTP
 id 3f1490d57ef6-e1a7a1cce74mr5109276.10.1725065019842; Fri, 30 Aug 2024
 17:43:39 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:43:09 +0000
In-Reply-To: <20240831004313.3713467-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831004313.3713467-10-almasrymina@google.com>
Subject: [PATCH net-next v24 09/13] tcp: RX path for devmem TCP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

In tcp_recvmsg_locked(), detect if the skb being received by the user
is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
flag - pass it to tcp_recvmsg_devmem() for custom handling.

tcp_recvmsg_devmem() copies any data in the skb header to the linear
buffer, and returns a cmsg to the user indicating the number of bytes
returned in the linear buffer.

tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
and returns to the user a cmsg_devmem indicating the location of the
data in the dmabuf device memory. cmsg_devmem contains this information:

1. the offset into the dmabuf where the payload starts. 'frag_offset'.
2. the size of the frag. 'frag_size'.
3. an opaque token 'frag_token' to return to the kernel when the buffer
is to be released.

The pages awaiting freeing are stored in the newly added
sk->sk_user_frags, and each page passed to userspace is get_page()'d.
This reference is dropped once the userspace indicates that it is
done reading this page.  All pages are released when the socket is
destroyed.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---

v20:
- Change `offset = 0` to `offset = offset - start` to resolve issue
  reported by Taehee.

v16:
- Fix number assignement (Arnd).

v13:
- Refactored user frags cleanup into a common function to avoid
  __maybe_unused. (Pavel)
- change to offset = 0 for some improved clarity.

v11:
- Refactor to common function te remove conditional lock sparse warning
  (Paolo)

v7:
- Updated the SO_DEVMEM_* uapi to use the next available entries (Arnd).
- Updated dmabuf_cmsg struct to be __u64 padded (Arnd).
- Squashed fix from Eric to initialize sk_user_frags for passive
  sockets (Eric).

v6
- skb->dmabuf -> skb->readable (Pavel)
- Fixed asm definitions of SO_DEVMEM_LINEAR/SO_DEVMEM_DMABUF not found
  on some archs.
- Squashed in locking optimizations from edumazet@google.com. With this
  change we lock the xarray once per per tcp_recvmsg_dmabuf() rather
  than once per frag in xa_alloc().

Changes in v1:
- Added dmabuf_id to dmabuf_cmsg (David/Stan).
- Devmem -> dmabuf (David).
- Change tcp_recvmsg_dmabuf() check to skb->dmabuf (Paolo).
- Use __skb_frag_ref() & napi_pp_put_page() for refcounting (Yunsheng).

RFC v3:
- Fixed issue with put_cmsg() failing silently.

---
 arch/alpha/include/uapi/asm/socket.h  |   5 +
 arch/mips/include/uapi/asm/socket.h   |   5 +
 arch/parisc/include/uapi/asm/socket.h |   5 +
 arch/sparc/include/uapi/asm/socket.h  |   5 +
 include/linux/socket.h                |   1 +
 include/net/netmem.h                  |  13 ++
 include/net/sock.h                    |   2 +
 include/uapi/asm-generic/socket.h     |   5 +
 include/uapi/linux/uio.h              |  13 ++
 net/ipv4/tcp.c                        | 255 +++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                   |  16 ++
 net/ipv4/tcp_minisocks.c              |   2 +
 12 files changed, 322 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..ef4656a41058 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -140,6 +140,11 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..414807d55e33 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,11 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..2b817efd4544 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,11 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..00248fc68977 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,11 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SO_DEVMEM_LINEAR         0x0057
+#define SCM_DEVMEM_LINEAR        SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF         0x0058
+#define SCM_DEVMEM_DMABUF        SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index df9cdb8bbfb8..d18cc47e89bd 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -327,6 +327,7 @@ struct ucred {
 					  * plain text and require encryption
 					  */
 
+#define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 61400d4b0d66..209013aaea18 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -66,6 +66,19 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 	return niov - net_iov_owner(niov)->niovs;
 }
 
+static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_virtual +
+	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
+static inline u32 net_iov_binding_id(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding->id;
+}
+
 static inline struct net_devmem_dmabuf_binding *
 net_iov_binding(const struct net_iov *niov)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index f51d61fab059..c58ca8dd561b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -337,6 +337,7 @@ struct sk_filter;
   *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
   *	@sk_txtime_unused: unused txtime flags
   *	@ns_tracker: tracker for netns reference
+  *	@sk_user_frags: xarray of pages the user is holding a reference on.
   */
 struct sock {
 	/*
@@ -542,6 +543,7 @@ struct sock {
 #endif
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
+	struct xarray		sk_user_frags;
 };
 
 struct sock_bh_locked {
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..e993edc9c0ee 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,11 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 059b1a9147f4..3a22ddae376a 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -20,6 +20,19 @@ struct iovec
 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
 };
 
+struct dmabuf_cmsg {
+	__u64 frag_offset;	/* offset into the dmabuf where the frag starts.
+				 */
+	__u32 frag_size;	/* size of the frag. */
+	__u32 frag_token;	/* token representing this frag for
+				 * DEVMEM_DONTNEED.
+				 */
+	__u32  dmabuf_id;	/* dmabuf id this frag belongs to. */
+	__u32 flags;		/* Currently unused. Reserved for future
+				 * uses.
+				 */
+};
+
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 30238963fe99..93cb76813bf1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -471,6 +471,7 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
+	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
@@ -2323,6 +2324,220 @@ static int tcp_inq_hint(struct sock *sk)
 	return inq;
 }
 
+/* batch __xa_alloc() calls and reduce xa_lock()/xa_unlock() overhead. */
+struct tcp_xa_pool {
+	u8		max; /* max <= MAX_SKB_FRAGS */
+	u8		idx; /* idx <= max */
+	__u32		tokens[MAX_SKB_FRAGS];
+	netmem_ref	netmems[MAX_SKB_FRAGS];
+};
+
+static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
+{
+	int i;
+
+	/* Commit part that has been copied to user space. */
+	for (i = 0; i < p->idx; i++)
+		__xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
+			     (__force void *)p->netmems[i], GFP_KERNEL);
+	/* Rollback what has been pre-allocated and is no longer needed. */
+	for (; i < p->max; i++)
+		__xa_erase(&sk->sk_user_frags, p->tokens[i]);
+
+	p->max = 0;
+	p->idx = 0;
+}
+
+static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
+{
+	if (!p->max)
+		return;
+
+	xa_lock_bh(&sk->sk_user_frags);
+
+	tcp_xa_pool_commit_locked(sk, p);
+
+	xa_unlock_bh(&sk->sk_user_frags);
+}
+
+static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
+			      unsigned int max_frags)
+{
+	int err, k;
+
+	if (p->idx < p->max)
+		return 0;
+
+	xa_lock_bh(&sk->sk_user_frags);
+
+	tcp_xa_pool_commit_locked(sk, p);
+
+	for (k = 0; k < max_frags; k++) {
+		err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
+				 XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
+		if (err)
+			break;
+	}
+
+	xa_unlock_bh(&sk->sk_user_frags);
+
+	p->max = k;
+	p->idx = 0;
+	return k ? 0 : err;
+}
+
+/* On error, returns the -errno. On success, returns number of bytes sent to the
+ * user. May not consume all of @remaining_len.
+ */
+static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
+			      unsigned int offset, struct msghdr *msg,
+			      int remaining_len)
+{
+	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
+	struct tcp_xa_pool tcp_xa_pool;
+	unsigned int start;
+	int i, copy, n;
+	int sent = 0;
+	int err = 0;
+
+	tcp_xa_pool.max = 0;
+	tcp_xa_pool.idx = 0;
+	do {
+		start = skb_headlen(skb);
+
+		if (skb_frags_readable(skb)) {
+			err = -ENODEV;
+			goto out;
+		}
+
+		/* Copy header. */
+		copy = start - offset;
+		if (copy > 0) {
+			copy = min(copy, remaining_len);
+
+			n = copy_to_iter(skb->data + offset, copy,
+					 &msg->msg_iter);
+			if (n != copy) {
+				err = -EFAULT;
+				goto out;
+			}
+
+			offset += copy;
+			remaining_len -= copy;
+
+			/* First a dmabuf_cmsg for # bytes copied to user
+			 * buffer.
+			 */
+			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
+			dmabuf_cmsg.frag_size = copy;
+			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
+				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
+			if (err || msg->msg_flags & MSG_CTRUNC) {
+				msg->msg_flags &= ~MSG_CTRUNC;
+				if (!err)
+					err = -ETOOSMALL;
+				goto out;
+			}
+
+			sent += copy;
+
+			if (remaining_len == 0)
+				goto out;
+		}
+
+		/* after that, send information of dmabuf pages through a
+		 * sequence of cmsg
+		 */
+		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct net_iov *niov;
+			u64 frag_offset;
+			int end;
+
+			/* !skb_frags_readable() should indicate that ALL the
+			 * frags in this skb are dmabuf net_iovs. We're checking
+			 * for that flag above, but also check individual frags
+			 * here. If the tcp stack is not setting
+			 * skb_frags_readable() correctly, we still don't want
+			 * to crash here.
+			 */
+			if (!skb_frag_net_iov(frag)) {
+				net_err_ratelimited("Found non-dmabuf skb with net_iov");
+				err = -ENODEV;
+				goto out;
+			}
+
+			niov = skb_frag_net_iov(frag);
+			end = start + skb_frag_size(frag);
+			copy = end - offset;
+
+			if (copy > 0) {
+				copy = min(copy, remaining_len);
+
+				frag_offset = net_iov_virtual_addr(niov) +
+					      skb_frag_off(frag) + offset -
+					      start;
+				dmabuf_cmsg.frag_offset = frag_offset;
+				dmabuf_cmsg.frag_size = copy;
+				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
+							 skb_shinfo(skb)->nr_frags - i);
+				if (err)
+					goto out;
+
+				/* Will perform the exchange later */
+				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
+				dmabuf_cmsg.dmabuf_id = net_iov_binding_id(niov);
+
+				offset += copy;
+				remaining_len -= copy;
+
+				err = put_cmsg(msg, SOL_SOCKET,
+					       SO_DEVMEM_DMABUF,
+					       sizeof(dmabuf_cmsg),
+					       &dmabuf_cmsg);
+				if (err || msg->msg_flags & MSG_CTRUNC) {
+					msg->msg_flags &= ~MSG_CTRUNC;
+					if (!err)
+						err = -ETOOSMALL;
+					goto out;
+				}
+
+				atomic_long_inc(&niov->pp_ref_count);
+				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+
+				sent += copy;
+
+				if (remaining_len == 0)
+					goto out;
+			}
+			start = end;
+		}
+
+		tcp_xa_pool_commit(sk, &tcp_xa_pool);
+		if (!remaining_len)
+			goto out;
+
+		/* if remaining_len is not satisfied yet, we need to go to the
+		 * next frag in the frag_list to satisfy remaining_len.
+		 */
+		skb = skb_shinfo(skb)->frag_list ?: skb->next;
+
+		offset = offset - start;
+	} while (skb);
+
+	if (remaining_len) {
+		err = -EFAULT;
+		goto out;
+	}
+
+out:
+	tcp_xa_pool_commit(sk, &tcp_xa_pool);
+	if (!sent)
+		sent = err;
+
+	return sent;
+}
+
 /*
  *	This routine copies from a sock struct into the user buffer.
  *
@@ -2336,6 +2551,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			      int *cmsg_flags)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	int last_copied_dmabuf = -1; /* uninitialized */
 	int copied = 0;
 	u32 peek_seq;
 	u32 *seq;
@@ -2515,15 +2731,44 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		if (!(flags & MSG_TRUNC)) {
-			err = skb_copy_datagram_msg(skb, offset, msg, used);
-			if (err) {
-				/* Exception. Bailout! */
-				if (!copied)
-					copied = -EFAULT;
+			if (last_copied_dmabuf != -1 &&
+			    last_copied_dmabuf != !skb_frags_readable(skb))
 				break;
+
+			if (skb_frags_readable(skb)) {
+				err = skb_copy_datagram_msg(skb, offset, msg,
+							    used);
+				if (err) {
+					/* Exception. Bailout! */
+					if (!copied)
+						copied = -EFAULT;
+					break;
+				}
+			} else {
+				if (!(flags & MSG_SOCK_DEVMEM)) {
+					/* dmabuf skbs can only be received
+					 * with the MSG_SOCK_DEVMEM flag.
+					 */
+					if (!copied)
+						copied = -EFAULT;
+
+					break;
+				}
+
+				err = tcp_recvmsg_dmabuf(sk, skb, offset, msg,
+							 used);
+				if (err <= 0) {
+					if (!copied)
+						copied = -EFAULT;
+
+					break;
+				}
+				used = err;
 			}
 		}
 
+		last_copied_dmabuf = !skb_frags_readable(skb);
+
 		WRITE_ONCE(*seq, *seq + used);
 		copied += used;
 		len -= used;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index eb631e66ee03..5afe5e57c89b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -79,6 +79,7 @@
 #include <linux/seq_file.h>
 #include <linux/inetdevice.h>
 #include <linux/btf_ids.h>
+#include <linux/skbuff_ref.h>
 
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
@@ -2512,10 +2513,25 @@ static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
 }
 #endif
 
+static void tcp_release_user_frags(struct sock *sk)
+{
+#ifdef CONFIG_PAGE_POOL
+	unsigned long index;
+	void *netmem;
+
+	xa_for_each(&sk->sk_user_frags, index, netmem)
+		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
+#endif
+}
+
 void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	tcp_release_user_frags(sk);
+
+	xa_destroy(&sk->sk_user_frags);
+
 	trace_tcp_destroy_sock(sk);
 
 	tcp_clear_xmit_timers(sk);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ad562272db2e..bb1fe1ba867a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -628,6 +628,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
+	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
+
 	return newsk;
 }
 EXPORT_SYMBOL(tcp_create_openreq_child);
-- 
2.46.0.469.g59c65b2a67-goog


