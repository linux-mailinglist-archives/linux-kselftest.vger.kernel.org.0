Return-Path: <linux-kselftest+bounces-35167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49CADC0B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7095C7A8083
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40A241664;
	Tue, 17 Jun 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBFNpVGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908023D283;
	Tue, 17 Jun 2025 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134780; cv=none; b=WXw3hs7RWZtL2vM8G8CkFRDa3KBIv9y/pdytOWwic/5BgdTd+m+Bukp5dsq/5gw54YIy/CqHaYWLB+qsBSv7YymmwWH689Z9658X/+yJKUwUQXy5TofEwvPoLeZLqd5g1LwOyH9iaN3e8VjCMchlAsfMfotCr9/c4Uc+/nL6yaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134780; c=relaxed/simple;
	bh=7Efr2DcHjMHIkxPORLOyvtBZdxZGWYv5we2eZThllc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GvAlQ/mw4ZGTyvcTdPbRL4KZ6X0sEn5Q1e7Yrkr9fhbqFhs4+c3w9Ii0SnQCVci+r288WWkQifN7EAA53lSOVjCEMGCdBCelj5zTiplwfKq8pmmTMFJTVQORpPhDiWcF7srP4PgZbqF1kGBoGghprH+6GYlTdHH4yOsiFxd/JQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBFNpVGM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso4599515b3a.2;
        Mon, 16 Jun 2025 21:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134777; x=1750739577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ01K2ow09UDDYywMmqZNZsYWpIeR8YfQL254KQmb7E=;
        b=FBFNpVGM4gvIWChnCLkP2CljW40poIKA6l+qJeslO/w2oDFb+ZAx+O+mQMT8aP96gm
         x8XjaZmzkU0ZBGGRZCQnhhKtPSMBRc+ASfO/oZAniFr4fonMICsbXFYje5md6S2f8B6G
         J5reQ9h78weEfWwj1c7iVA7MO6YbfBMSA66rt8ix4iebxykznMn7z+6+4RwbyvyIDRjS
         pzgW/8M1PuOpfV1l296P61ptbkIntqeE7Z7kLxGvPM+w1Xpq3Zn8AMjF9Hf+ST0AbcZH
         6zxGfbnvOP/wR7onK4YrFPHLCIxADbTHe4EwAh7YhUCmqg1BmNRcaZENBI1pAfpB9GoA
         GGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134777; x=1750739577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ01K2ow09UDDYywMmqZNZsYWpIeR8YfQL254KQmb7E=;
        b=nly5YEzmysWaXvDZeXid4I5rPstO9TSNNBZpHk5k+yYYznAbYYe+P0QpAVqkItNiMw
         UsBfdEmO89nekFPJe8QqHI6S2LGUBsckgFO1WfPAewr4jfqYF2ABDM4Aa0La5Q0EkULH
         QQuiFJBOptBZwH2InM4MmV9QomCuWuN614Ix0WDh/LdUkDwfzU9uyUjLxE+ChlBmRP1G
         UwSMYwtseR9O/nMiNWZ9/Xh0yDf2+qGwDbj6yE8BvIyuv0aIbKKBmKb2MvUiNw33GkUe
         CQdHymFO0jKL1aI78kuo1VpEhCUHGMhm+hZoVPW2GUoBQxIVDK3+iU+nORxsuxzeiBzF
         pzag==
X-Forwarded-Encrypted: i=1; AJvYcCXGoqU2f8kcuwa03MWfseoZRIc9OAbPXJXNp9ey8qlyho9ViLbL3HaRrpeSJenSjEd05d09gNZ4GhfQudow0OOz@vger.kernel.org, AJvYcCXWj/OE2f1ZAPTmbTT5vEj4A9X4nv2cKEHo3fYxvOCQCOIQWOMyUS/fIV6C+mxL3M6wwpcz5gq+@vger.kernel.org, AJvYcCXeByotg/9g3+9PjZvR4U2dHZe2R8jepHLFH/0ycA/VRZ5NZDIQZvQSrvKYWsmqRAKVO+gLl3MAHFyZNDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyawUWJhIKr9jKDLgQcOP7g1qxf9GC+P/OpPrO9hQwMavH2IZY9
	oZOkVDmJRwdlbvVY9cy/1SsX/IdxtBiW8LuxcotDl9MwebdzRmAJlgsCYE+VHOhv
X-Gm-Gg: ASbGnctjc5XtPGXRSy+uwJhrtR6531rX7xnZ5K7PasAKZSaNrFVeAo8aFDxp8riW2p0
	Igs4JhCcCmFBDSnoMNdEMZM7l3jDj7tgcVRh0nrLFGr5YUw3AmSflgnSY8agkCeX8HLb1Fr7NDm
	m7Z2e4fvQvrE4KsOuGqY6FeNyfRklMY6BpcJ0+U1N3l8MtnTTCWFBdVAHSkiQqG8q6upqtaPbVK
	KecQY07JGvGcPqVkSIbftnevyTp22AA3GeBcdMJ/g6kMTygyVf2wIbl3eNTd8ws5KtSGrHI6zrZ
	CaXylEvqCL/qJANvsqBNMItroymP/2TbARqrrq3D/NCnOoLdLcz3sue5Aqc=
X-Google-Smtp-Source: AGHT+IHE/6Vn5YLgKjYSKZNdlfgBKY7zuMuQFBI6H0V1HGZEpIY6C5PiqCL/O1sycxc9EJbkuM+V3g==
X-Received: by 2002:a05:6a20:cd92:b0:215:df62:7d51 with SMTP id adf61e73a8af0-21fbd584d3fmr17784132637.11.1750134776981;
        Mon, 16 Jun 2025 21:32:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a0e7sm7874487a12.16.2025.06.16.21.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:56 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:52 -0700
Subject: [PATCH RFC net-next v4 03/11] vsock: add vsock net ns helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-3-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add helper functions for setting/getting vsock NS modes.  This commit is
in preparation for adding NS support to vsock.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d56e6e135158..e0b9e6732d53 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -256,4 +257,49 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+extern struct net __vsock_global_net;
+static inline struct net *vsock_global_net(void)
+{
+	return &__vsock_global_net;
+}
+
+static inline u8 vsock_net_mode(struct net *net)
+{
+	u8 ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.ns_mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline void vsock_net_set_mode(struct net *net, u8 mode)
+{
+	spin_lock_bh(&net->vsock.lock);
+	net->vsock.ns_mode = mode | VSOCK_NS_MODE_WRITTEN_ONCE;
+	spin_unlock_bh(&net->vsock.lock);
+}
+
+/* Return true if mode has already been written once. Otherwise, return false. */
+static inline bool vsock_net_mode_can_set(struct net *net)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = !(net->vsock.ns_mode & VSOCK_NS_MODE_WRITTEN_ONCE);
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if vsock net mode check passes. Otherwise, return false.
+ *
+ * Read more about modes in comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
+{
+	return net_eq(n1, n2) ||
+	       (vsock_net_mode(n1) & VSOCK_NS_MODE_GLOBAL &&
+		vsock_net_mode(n2) & VSOCK_NS_MODE_GLOBAL);
+}
 #endif /* __AF_VSOCK_H__ */

-- 
2.47.1


