Return-Path: <linux-kselftest+bounces-35175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A1ADC0D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196041887F36
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBD25E452;
	Tue, 17 Jun 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1XyVz+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458025A341;
	Tue, 17 Jun 2025 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134794; cv=none; b=BOmM+N03IPJZ1Rtip6Sgai38+FkQI4Bib1A/qa1kzQKC9cykv6Ktx3I1S2ZnuDFI/ktfEQuHbgvGP82pA2cmTwlSi1T5YAh39JlB8ZkBltIvcVCBmcTnHb4Tq3WZJaV+POrNSnhVGv5UKjEqEjshafc3Tt82boIxYcoI/Jwysn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134794; c=relaxed/simple;
	bh=mawhiv0L3KBPhIbjNO6APLwCsPC/bD2yqJGvqU3ndG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mI23lg5/XPXPOaI62XxNMclyUbiRYiCQN9jzymd/n5HQvtKmhxExyvUFJxmIM58gJSRK6FJ+bhzhFiIqE4o3Vk5l9pkOeP5BcjC1Rby6c83UEtErennaM8xvQRUey7f+DnSvj11gz3JpfSuJ42GDW1P7aPvyLpOC9p5PzWmDINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1XyVz+1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2f11866376so4110128a12.3;
        Mon, 16 Jun 2025 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134791; x=1750739591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nQqyuVseDJyHOiPXQ8YAL67/IptUNPpJxUJ4iDj92c=;
        b=l1XyVz+1+A8QrqB6lu/LZ+hY3eGcPbx3qUFT2hsXhZA5nmbFHOkEGLD39eR13wnJcB
         Z7VuDapmI43SJuLDjYacevlBw2q/HnsUQ512is6AQ9y3sN+xWB+4qg4sGTqv+X0vHyvs
         c+LnDN0oz3Z6eC3GJGW8kebPxXoIQ9VDQ6qcyRZ0ORxwxWqvww4UwRzjQilWWZSrhkFY
         rOlRRG74lxrT7v053aPSvwD+n1Jl3gClIXdFDYSVBwVvGBlS5AxHCFLmavjraP3CsCur
         V6cAollWdfN9XSsIdoKrbSyAqaBjxKVITuTTET8py9iP1MHBkoSSs/QVfFh0DtiBqFHh
         yUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134791; x=1750739591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nQqyuVseDJyHOiPXQ8YAL67/IptUNPpJxUJ4iDj92c=;
        b=CLtqSaGBo0kHWemYaGzwG1t2E6Wm5MW9yQGOirKoVrftvjqleOPbmjU9zkWoMW2HGo
         P4ZT2Z9DjLi0vSlHCyJKDe3R1sYnVjc3qgouXrk8nhLLlmmw3S84FxY+zIKCGeLzz8E5
         29YhVTI4XYbxGR9O6w0dE5r3gsLcEfwsNJD00x5x2p9mvuN+uZXCoIwdL0gWKpE25jjP
         Hw99kT6vY/u2YjLzDMP1pj7lBDTQVgw25VtlCpNbs7YvyNwT6FiihPvj1ySSWEC1uV7O
         qDyoNR4yNWXKNtg6le+0RI5ysS1ouR9gOzu51LyzeLYNX3QUV7v2FhFDZc1wltFYGWlb
         +aBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT6dtpmA30PVtTDC+hsjVrMPRSNJhv/39/YnxxcnECXIyI+0JtJIeGCtvgZ3KD/xlxNrVKVO1sfYkDD9k=@vger.kernel.org, AJvYcCUZGzTPK6ceL3N4sCewke+HHjklr8lKh+Bng9hH9PujsPaZrmC7gY9Qt1Ne7oGHTRf9uiY6pDSusek8y2t/TCvD@vger.kernel.org, AJvYcCUrn596ydqLJ56coVzzkLizBOrG71MjjrIxJ9j4DqPNDeFCbTwMcl+lMdLBC/RirTxuvp+iX3rb@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKmQwAVQeiz+idOYWIPXc/h5g0dBO4ttk9ruM6efPuDN0BIby
	mpZLdpBXcsGfEpTkAsJLhHHiDAX7/SJPxCAwm0lStvmwiNjFom0GsLi0qUmV+f7e
X-Gm-Gg: ASbGncvwNz1kamP5XeH/ZHuudjMA+1wK25tQ+mrMqt3lCYasdHSKCeEPMxGqFLzF5LB
	324frguGXIac1HtqiDZRR+xEqIXxmb+FRFnMTBpzvfqtX9+Bg7EmHRHUR3kdSEzpOd0Tql5/dUs
	CXwOPYhVqXeCsguqcOumAJz9p/3wu+mvpi6zZfjnUFi5Q4ETiSyfGQXHbCQ8feaHGy7jIS0Lng+
	j54h4CNRNtuvMzFTxe/iH66QFcnaTWkyFGmlOwc4oG9KssQ9ohPCJkRaA3ZuE9WmEM7nzzgDREo
	OKE/wRV9ErBxnq02UhWy5sNa8vHkmc33OG0+Jqp4syI4roc1TCPeTQKEfYU=
X-Google-Smtp-Source: AGHT+IGvRdb4I9HaaHhuHW8HBDY1U3GRW+PV9CJvxql3LOfHXJTee/8j/3AWnJ695agzLnIfzr0vOw==
X-Received: by 2002:a17:90b:1847:b0:313:fa28:b223 with SMTP id 98e67ed59e1d1-313fa28cebamr14341945a91.3.1750134791287;
        Mon, 16 Jun 2025 21:33:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb0484sm69909325ad.142.2025.06.16.21.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:33:00 -0700
Subject: [PATCH RFC net-next v4 11/11] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-11-bdd1659c33fb@meta.com>
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

Add NS support to vsock loopback. In theory, loopback can be viewed as
a given CID, and so should collide with other vsocks when the namespaces
are in global mode, but should not collide if the namespace is in local
mode. This has not been tested yet, but will be by the next rev.

TODO: add tests for this

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/vsock_loopback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..1b2fab73e0d0 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -46,7 +46,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -106,7 +106,7 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	return true;
 }

-- 
2.47.1


