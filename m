Return-Path: <linux-kselftest+bounces-44781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D4C33A66
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 02:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5CE18C68C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D427CB02;
	Wed,  5 Nov 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs9ugeJJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8525EFBF
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305811; cv=none; b=Az36iOdhEDAvxRVXt9mdGPWGklfREnwN7x3yj7isjJTmCNIJf0jfZd5Eicg8kDBPRUB3E9qb062lkEF8WvS3/jr3zeszldIGrTmhnrBEtrYFV7Vs0qthTSbPIesBCqE9lIQe1Py30Zs3HNHpzbfLzNw5W7/yUnjSV446u8rSxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305811; c=relaxed/simple;
	bh=9ZdVGaIt/OvZxDjCG8t0f5xRJnb5qgTQFaBNuCOVr0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5IzbH/M1agaSmCI7GuJSAaDcGiG9YlJIIDyDzXhghnydv36p0wgF/nrWDNSVA9GJQ81fyX82cnu4I1ACzC1pCgjkGPVaGaqn1rcBVUC0sK8wW96xWSiOdrVo9ZBYWo5/j7FgmubzW4O5jC9otsLXDEhchyVkrwIRYLOvroL0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs9ugeJJ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-786635a8ce4so33228307b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 17:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305808; x=1762910608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXQPAkEgQbO8euIcwuGERIBFcD6kBEPGrPcFSGxSLm8=;
        b=cs9ugeJJrOPiGhprQlaFybPw90yy1tKkHgTW4e2KCR4YsIyQEVt96vg/NXcY6lihGc
         Ag4CZaDgiBu9IYRtlgOvW60JEyl+7OdB+52qv3Dhmh1gqM9n7OIAc1e51qmaqe0OM/Jl
         cAOgPDsxcV04FsI4KPeX/gu5W7QEw3rZ64Syn4YItgFYRQRsUGst7BKOk+AosltjfkZ8
         OZ4sbaYO8iVfv8Q8QMn+39OKujZCUrI2GGP6WP6iJxu5Ia7e15+GTfJNQkya+OxYgdp6
         ST9Q8GD4g76No5HggNmx+3NWbXfi6RwJhMxWlwUkQZnULPp4YjTq0hZ1DpnfkWteCiHo
         Ip9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305808; x=1762910608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXQPAkEgQbO8euIcwuGERIBFcD6kBEPGrPcFSGxSLm8=;
        b=qDI3rhtfokysMLUSHM9lrsOgdbK07RpMSSShKspsT9NJfRDS4eA1RahxBwgZJxwX5H
         Co88D1ElERrK5m97gk4Y7h/9GhYryxG6uPo2vidOHRh6b6P9Buu9x7hbrSHamF94Jy7J
         FsDvNXeTLTK8H7nBxMfXsRrMh68GY7YCF02gwIj+EJ81oaXcwYBOR9CyBVxMypOXmvVF
         WjW8hQSDv351bp549T3aGrvxhXTJSV3ntKHgvDvgigh7jZDjhYUCToNR/HY+VC0z02sJ
         Uvr4muIlUksubeGyVsdlI/ESykn4vQkGjqEE+kdqO+IDbQ8txOfAr/7Dp0T2wsqDFMti
         r/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR/e8OY+x4uE7bWXMXjWssfRVMt6RSchwmlsa4yRHA+CnF+kJgi/s7hqGx1I3H2wqCceA3R+egKfWEbhnrWw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN51slCzzlkkVPG3ta3Z3gbCfQQzaggimy6inNG+rbKzcH3UC1
	3msOWsGqw20Pd+9PbpKvWSMLbOxaahCdtTgekOYm+ECWyxN8Cjuex7ZD
X-Gm-Gg: ASbGncsDskudYzu2JxWyeM4dQ/Bt/jFkkrIlkUrcMVorfEVJhP/2shpVTYCi+2X2fjf
	Nvw0F2KYf8g/K8XGvgzAcjxNvMwRB9mkb36rr8Gg9Zc5WVVpORxRzkPyeeteIJKslJxljAqWPBi
	Vf1hvyMObmCpnFVh2x0mC/vJuScCP95jRlyZh0kZ+tEp+ukoJW90E6FyU2Qp5IYK93be2AWtwtK
	3dKyPjXWEsMVOTZ/5PqP6BUg/bAVzJBg0qn6SGN15+gdXV/eUh5T2/0qMRdVr+1JOuaRfO271/Q
	s9SYlwp/Ra7Ww7wnppMyztgw5TdAHZdC6faDMiHrhMO9UNYvBBkZ7pGE/XqCwEoN91JoD5STQRy
	poyNNC8O140ISPfGLiT8ldup9+UUvVf/snKz3uON9iwdHRjXhg3WBee4eMb1qkRWJUtnYP4ksme
	AM5DWpHnNUgxs=
X-Google-Smtp-Source: AGHT+IGmZcasptx2/HU85kDuwAXzBhZHQkoteu1oE0YpB1MwZKyvKWzYVmBym2flQTEn3Ob02W1r2A==
X-Received: by 2002:a05:690c:6311:b0:786:652d:50e with SMTP id 00721157ae682-786a419d7d6mr14885297b3.37.1762305807568;
        Tue, 04 Nov 2025 17:23:27 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691db1369sm15259657b3.16.2025.11.04.17.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:27 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:24 -0800
Subject: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update devmem.rst documentation to describe the new SO_DEVMEM_AUTORELEASE
socket option and its usage.

Document the following:
- The two token release modes (automatic vs manual)
- How to use SO_DEVMEM_AUTORELEASE to control the behavior
- Performance benefits of disabling autorelease (~10% CPU reduction)
- Restrictions and caveats of manual token release
- Usage examples for both getsockopt and setsockopt

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/networking/devmem.rst | 70 +++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a6cd7236bfbd..1bfce686dce6 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -215,8 +215,8 @@ Freeing frags
 -------------
 
 Frags received via SCM_DEVMEM_DMABUF are pinned by the kernel while the user
-processes the frag. The user must return the frag to the kernel via
-SO_DEVMEM_DONTNEED::
+processes the frag. Users should return tokens to the kernel via
+SO_DEVMEM_DONTNEED when they are done processing the data::
 
 	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, &token,
 			 sizeof(token));
@@ -235,6 +235,72 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+
+Autorelease Control
+~~~~~~~~~~~~~~~~~~~
+
+The SO_DEVMEM_AUTORELEASE socket option controls what happens to outstanding
+tokens (tokens not released via SO_DEVMEM_DONTNEED) when the socket closes::
+
+	int autorelease = 0;  /* 0 = manual release, 1 = automatic release */
+	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_AUTORELEASE,
+			 &autorelease, sizeof(autorelease));
+
+	/* Query current setting */
+	int current_val;
+	socklen_t len = sizeof(current_val);
+	ret = getsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_AUTORELEASE,
+			 &current_val, &len);
+
+When autorelease is disabled (default):
+
+- Outstanding tokens are NOT released when the socket closes
+- Outstanding tokens are only released when the dmabuf is unbound
+- Provides better performance by eliminating xarray overhead (~10% CPU reduction)
+- Kernel tracks tokens via atomic reference counters in net_iov structures
+
+When autorelease is enabled:
+
+- Outstanding tokens are automatically released when the socket closes
+- Backwards compatible behavior
+- Kernel tracks tokens in an xarray per socket
+
+Important: In both modes, applications should call SO_DEVMEM_DONTNEED to
+return tokens as soon as they are done processing. The autorelease setting only
+affects what happens to tokens that are still outstanding when close() is called.
+
+The autorelease setting can only be changed when the socket has no outstanding
+tokens. If tokens are present, setsockopt returns -EBUSY.
+
+
+Performance Considerations
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Disabling autorelease provides approximately ~10% CPU utilization improvement in
+RX workloads by:
+
+- Eliminating xarray allocations and lookups for token tracking
+- Using atomic reference counters instead
+- Reducing lock contention on the xarray spinlock
+
+However, applications must ensure all tokens are released via
+SO_DEVMEM_DONTNEED before closing the socket, otherwise the backing pages will
+remain pinned until the dmabuf is unbound.
+
+
+Caveats
+~~~~~~~
+
+- With autorelease disabled, sockets cannot switch between different dmabuf
+  bindings. This restriction exists because tokens in this mode do not encode
+  the binding information necessary to perform the token release.
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


