Return-Path: <linux-kselftest+bounces-27040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31DA3CF2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786C23AC34B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603E1E5B78;
	Thu, 20 Feb 2025 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8lEYp+B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE81E3761
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017376; cv=none; b=sCQHuvjxeGHzXcK3w+W+m/jvhHJlVaHkJ+y0XxJqumubb++LScdP5GARSHsXWEauP1zOilluKDgMPkaCQqmYeaoYImXhwB46Ddtqd/YSU33Pone50fijWsFohVD3EodIOevU5yDNjQNurPL96AXfvfKk1ADGP7T8ieYIuIcbZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017376; c=relaxed/simple;
	bh=xktwRXpJMJv986Qo4eDPxj726JXR+3eKG4eS+/XdbOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RCQJWBMkHYyooPd1jcimTuZJbDX9oxm0KFS6M27ysdNVnKmssjGemkhgBHk07JgO0O6xDL52VOjDP/94y2m24KHCGSpsBUaO6tJz5mu7rSI2rE6ncAGadC+KYgdpiXTvefpHZjnhAW58vrYTs9c41yOWlUippQj1TCccd+7v7KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8lEYp+B; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso1464269a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017374; x=1740622174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouoTtMMhd3rb00vY+DSWvls3bj0wfOCkxx6qaQ7XOwM=;
        b=O8lEYp+B+GVf5CBtc+j9zd8esl5qp9PbFOIlFXkgRUQrAGZZrELqla2NTPg2aK3emc
         sl3cy3BV5y91hr5LK3qG+VwHZwZ2d4PjgEuHdJ1NGrU5WZ07DfNEmLdF6izUbgNRSiH+
         0YEb/8yk+ZX8vKRG5Dimu7PlTeE6MPmgMxqvqWlhwum6FXBiPgS0DFvTK9raF9wguRHu
         1KbRNK0uKflT++GpxkxUaRep2pIYBQbr6A9L6xvl1dI7LngmEsmYYE2Z8hbWmR6xEp9m
         WtCI4gzjWX14ITRR8T/v0SDRP5fH/YhfbxFwKkPGmqMrS8cTNR9F5y16RwsDTHJqYXV1
         r3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017374; x=1740622174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouoTtMMhd3rb00vY+DSWvls3bj0wfOCkxx6qaQ7XOwM=;
        b=Fcc4UuXsiOQ8PsGUGxsYrXYq/QKdzUVIesq6zUAW3UobCwDQTuAmZrN501A/Dq+cf8
         DYLJ8o/yCOx4mYmYVGoFsn4QNCEotTNrqjPvH+KDTzLDL97hQ91OSLG5OfE/wUkjHnau
         eogFtR2lXPXcK4ohbmDhwyj7T1a0bGm6FnE2zaq0E7o7FlPyKR/tkTlLnrrlufTcySLn
         keS64iUF6rfYVO75OA0NWZWzcq8M7u3E/D9PupEDxzqFFx1CpKxouMnheHlWHZPaavSN
         9gmAmPQFdeKylU/NkHzP3xdNdf7u1WqW8bVkvNgFLMhAi2WTUvZr99SyyJetN+21PThf
         qTww==
X-Forwarded-Encrypted: i=1; AJvYcCX5d8gSqvCv9a1PT4xtvMCK3Mg/jkgpgK1SZAhnmyxRygHamV8LKBzh4pfLyEtON6QxxExvRtM2bUnUkJbqrRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTtg/BUpYkJqOVKYUqoYrF0d2DJ4dZGoFcWfAaHqXtNx8UwZr
	4rc7gYIhp3kPdzoJBJ3qhdtDjyBAWf/V5e3KMhwCgaXSzx5GHhRbuvYxCMvNq8TgVtlWTKxIfL4
	3FomUcoV3xOa3eEXuv8TLTA==
X-Google-Smtp-Source: AGHT+IE63Y1j485C5r+SG910yHgU7D0EniRUvxRKp0z0ZOdOvF2csyUI5aFQVIvnQkQW3zk2gmV0Mv7QAnOs+6jCLQ==
X-Received: from pjc8.prod.google.com ([2002:a17:90b:2f48:b0:2eb:12d7:fedd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5202:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-2fcb56f6d59mr11204857a91.0.1740017374316;
 Wed, 19 Feb 2025 18:09:34 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:13 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-9-almasrymina@google.com>
Subject: [PATCH net-next v4 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- New patch

---
 net/core/dev.c         | 3 +++
 net/core/netdev-genl.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ebc000b56828..f65a2b41a2c3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3850,6 +3850,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 
 	skb = validate_xmit_xfrm(skb, features, again);
 
+	if (!skb_frags_readable(skb) && !dev->netmem_tx)
+		goto out_kfree_skb;
+
 	return skb;
 
 out_kfree_skb:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1faa2cf4057f..a154480a6e22 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -970,6 +970,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.48.1.601.g30ceb7b040-goog


