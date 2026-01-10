Return-Path: <linux-kselftest+bounces-48661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C71D0CD2E
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 03:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37787308790D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0424DCE2;
	Sat, 10 Jan 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRZ//9XF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2825C804
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011548; cv=none; b=rCVqPCLDDTCzpvbzlxaU4Mwv8Tax1rrQHydN4YqnQiUah8uu9iqZ+pCz35bknXYplHHHeWm0h+5Cjy4jAQcRRVllYaMKGXbgZWrnmMLqZemIfeAVZRiFVXWm3Qos0wPu6E1+dHInTkshdXP9pvdDza2eeE7dKe+chBIMpqPKws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011548; c=relaxed/simple;
	bh=6tucM9ZQ59G0xrDfMuItsfF1GTt7N8xzYil/t1gA1PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DACED5jRFmcXls5WwdsaBZr6JVMjF2ItYKg+F1uZ5hRzQEwjTLINqpyrPfa8oJQOKc3dV4xrewlLNUISqEwEOeH83upAlnp6cNkhPj4+L+9dtBp+dD2Yp8Cc5YO+qtZXr5MWazSZX86t2fUyGECCYMafS1fpvajiAxqIAZVr8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRZ//9XF; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-790b7b3e594so35271877b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011544; x=1768616344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXRdbOnUYiudn9GxHVVfvuR3By+3aRth8g9ruHEmquY=;
        b=RRZ//9XFWutooYFdB4GTmpzjV5zZXDbguHHvTNrat3+JjePN7DsXSBz2YEoc1sBUNr
         CWu19+T0PsjbWWn41lO6qbwbaQCFgEKUdQZRxI6vEVYheN8zDQV/QhDWt1gK53qaLMxV
         wBg6p4gCF9VZK3tj0a7cQ2ddG+jgbuShYTP4Ijfwm9A1A7+pU9pml2geDMy4xT0YWuZG
         BqjWeoJXTdjafCZrbOD/GX980Rkv6SR8HuaMHHTTdDLCdIlDx+KBx2QN4XIEAeFvTfW7
         5usfQLENdof2Bu2Z7IWiVc121bGmVIZb6qnKORdhNx18h83RXKnRXKU7JJn4RmFRM0vI
         zrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011544; x=1768616344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DXRdbOnUYiudn9GxHVVfvuR3By+3aRth8g9ruHEmquY=;
        b=Ia5ZRmISXRHwFrso+IgNzlPvy+9drMeDU0VXK4EM8vJVGr91og9hURmuvufKVR17fq
         rDf3ylTs9LjlkeSyqWo7ZlSbZCXAH3oURqKMD26nCYP0gkdGc8Ux+Sui3ho4jHN2sEQC
         0az5j3VD+HloY0lAKjMCnYYu0/gQ6tHp+HZYg6QKedGypx6xD+efUyfkVQIilPFqmjX/
         JPqdu4Cg/K5DHPK+MjqQUMvdXHUV+9gkZzO8irEuhWc36F8hhDyD7HiWWjYmj7MmIuiC
         Gn1NUnCiKFOT1WnLVOaVMoeAdSevzaNwiXIW+aZI/vBT2hd5Tr9oi//8CbkhL205LZyW
         l5kw==
X-Forwarded-Encrypted: i=1; AJvYcCX4CTHpjVAQzN0Fzhxudu9GXjQVYqw2U4JcDUfq3HnAh8nobZIYXc46yeeQgjGotUa1D6UdHHth6oJblsNaypA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPW7wX5BtBkZzXouEGkzgAlu9R7gMKNKAMIBvt7TbJDgjbU9iL
	bhwgCQBcPsnsTAJmO7MVLkW9ifpyILomJ2uedHV8Dc/MGlbQV+WG55FK
X-Gm-Gg: AY/fxX40FV8p84hDF7OaWdVSmJeLuBH0UiVDqUEyS0BZbFZU6q/yB3tvRQJMf2wo9Rm
	waL4tfDX82utVS1Nnsgulvhr4i3IEdRdrtEjag7mdnZDJTf6aw+KnVWlFpPiP1IwsrTsZpJ6TpP
	z357Ha70dZsot2xSZQakFa9LxN2eOtwrokoDnBFfx8WSkwLKt4+WOnll9KoDtFD9pTyNAZhZ1Y5
	gAM0oM0EIxj5+KOCEJ7RJTllNfJiDxaGFQ32rQHkARFEgkz4UuyYHVglq9hkzonEKdk+0DOKB9u
	lLVR6tqSs2n+Mxb3eS2NIKwjHu/kHeqMdhmOrsPX0spiOh5b51cwWb1wTDY0SivUfWVjszxlfst
	2eZ3HDgXRgYsF7nmYizu+KtZgp518RnvRsPQl+xNVN9wtDK69tLqc0NPzLSlPcd32SFIZsqg8g/
	1OAh+lhHkUAw==
X-Google-Smtp-Source: AGHT+IGzRizbGlIsAZwDp+VnMT+8idkBjcUWkmHJRYK1pkT2bOkNYQhUeyud4a1V268OgPfep68gmw==
X-Received: by 2002:a05:690e:400a:b0:646:a3cf:a2e8 with SMTP id 956f58d0204a3-64716ba374amr9762926d50.40.1768011543796;
        Fri, 09 Jan 2026 18:19:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa672725sm47421447b3.34.2026.01.09.18.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:19:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 09 Jan 2026 18:18:18 -0800
Subject: [PATCH net-next v9 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update devmem.rst documentation to describe the autorelease netlink
attribute used during RX dmabuf binding.

The autorelease attribute is specified at bind-time via the netlink API
(NETDEV_CMD_BIND_RX) and controls what happens to outstanding tokens
when the socket closes.

Document the two token release modes (automatic vs manual), how to
configure the binding for autorelease, the perf benefits, new caveats
and restrictions, and the way the mode is enforced system-wide.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- Document netlink instead of sockopt
- Mention system-wide locked to one mode
---
 Documentation/networking/devmem.rst | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a6cd7236bfbd..67c63bc5a7ae 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -235,6 +235,76 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+
+Autorelease Control
+~~~~~~~~~~~~~~~~~~~
+
+The autorelease mode controls what happens to outstanding tokens (tokens not
+released via SO_DEVMEM_DONTNEED) when the socket closes. Autorelease is
+configured per-binding at binding creation time via the netlink API::
+
+	struct netdev_bind_rx_req *req;
+	struct netdev_bind_rx_rsp *rsp;
+	struct ynl_sock *ys;
+	struct ynl_error yerr;
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, ifindex);
+	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	netdev_bind_rx_req_set_autorelease(req, 0); /* 0 = manual, 1 = auto */
+	__netdev_bind_rx_req_set_queues(req, queues, n_queues);
+
+	rsp = netdev_bind_rx(ys, req);
+
+	dmabuf_id = rsp->id;
+
+When autorelease is disabled (0):
+
+- Outstanding tokens are NOT released when the socket closes
+- Outstanding tokens are only released when the dmabuf is unbound
+- Provides better performance by eliminating xarray overhead (~13% CPU reduction)
+- Kernel tracks tokens via atomic reference counters in net_iov structures
+
+When autorelease is enabled (1):
+
+- Outstanding tokens are automatically released when the socket closes
+- Backwards compatible behavior
+- Kernel tracks tokens in an xarray per socket
+
+The default is autorelease disabled.
+
+Important: In both modes, applications should call SO_DEVMEM_DONTNEED to
+return tokens as soon as they are done processing. The autorelease setting only
+affects what happens to tokens that are still outstanding when close() is called.
+
+The mode is enforced system-wide. Once a binding is created with a specific
+autorelease mode, all subsequent bindings system-wide must use the same mode.
+
+
+Performance Considerations
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Disabling autorelease provides approximately ~13% CPU utilization improvement
+in RX workloads. That said, applications must ensure all tokens are released
+via SO_DEVMEM_DONTNEED before closing the socket, otherwise the backing pages
+will remain pinned until the dmabuf is unbound.
+
+
+Caveats
+~~~~~~~
+
+- Once a system-wide autorelease mode is selected (via the first binding),
+  all subsequent bindings must use the same mode. Attempts to create bindings
+  with a different mode will be rejected with -EINVAL.
+
+- Applications using manual release mode (autorelease=0) must ensure all tokens
+  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
+  leaks during the lifetime of the dmabuf binding. Tokens not released before
+  close() will only be freed when the dmabuf is unbound.
+
+
 TX Interface
 ============
 

-- 
2.47.3


