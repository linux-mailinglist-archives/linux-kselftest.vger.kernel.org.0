Return-Path: <linux-kselftest+bounces-35173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1BADC0D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C56318847F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE71025CC42;
	Tue, 17 Jun 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSFDaMtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB225C6FC;
	Tue, 17 Jun 2025 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134791; cv=none; b=RH+qb4EzTg7+cJbDGAQ49/NOyjqdmrx3eWiphaOzuepBafWIfVaHtML2fQVcr5iDDNYzX60W4Oe1ZRjKTOcBmff3LSrDZC0WPPSGhwfP/J+HPAYcefYxGR5uVikDcujcI7iRhHP6api4XPyM2Uh04bLij5INphgWABI1l+P5sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134791; c=relaxed/simple;
	bh=SvB3qBm1VTjIjRDl1c4e6i1RbCCzA1EXVBxQVVn1tvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUg+h2ZSwKQ0fGRl/FsAlYX8j0WoCCO7LMBXnWE7/nApEy6q2gw++CtYxC8ZCe8Wg66fxf/p7Mci9TR42Tl3jtSFS0gK2hT+xY3Shqykxbm4D17nrX+4y3RTDEj4iNGU1/gV5jOM3SdZlfiBFxfl9d47OWqFESLXIxU8K0xhePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSFDaMtt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2d46760950so5474786a12.3;
        Mon, 16 Jun 2025 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134788; x=1750739588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMpypbPx49C4LhAqP1zWnTq1tGkVcmiL21eIZ1oGdsw=;
        b=LSFDaMttFlZEFAQm3jrRD/9wdtNkMFOcSpIpQwvU6DMf/EwBkqrdEyGUYD4LJYLYGq
         2Js7tPiXWCYpVnxYM/N3dyVh5FqwdtqlCMDm2HWDX086hHWOMQQBlWzBNSV28PF4VSde
         XXC4+XQZsQOhn2F0XrXf4tNBjoZGJsvFcvCHYVTCIWy3aylKxF827Q+X/qczIyBFcDwp
         U2NW+i3Bt54xatERDXyg74J/QivFT7Kzx6Oznx30xJ6xjRvrC0lENmvFxuKiirhq2P30
         bvez1OL+jSgD2pJUObHLLtI/f5BsiyTC0f5Y/2XLb7jWxNvn4pY5B2R7Y40gUU/0CZ49
         cSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134788; x=1750739588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMpypbPx49C4LhAqP1zWnTq1tGkVcmiL21eIZ1oGdsw=;
        b=iI9gn/mf+HKCzYMcVX/JF6tT1HAJOAym7gAvbJSI0gRlh3dQA8GIJ1S3ol1gnAV1vy
         1XHq0I3vD4PIeYNw0wo7jHh6UupWcnHMuoF0SzK8deHpdyCJNtNmdS/KVDp2H9DV9U97
         JfjwpVqbI6Zm/c8zXpKpXvk+s6iFk+SYLIJzPXrKLd73I89jp6jJppw4AGFtmKJLDg8j
         lSKwjB+2f780kjhSX+QLIDieWBcaISWYLzfUXA+ekzNU3DH5ZWIjuYfyaSLrnbnJLqVx
         2ynfCueMBssrGPv9kjsWzw00gy3Vv1KnmnVncEPcmo044p40xJf1sEtGwe7P8EnJHD0K
         a0mw==
X-Forwarded-Encrypted: i=1; AJvYcCVIkrK8EvlGqtpd0DROxv7BlIn/PCOTmMYhoR3n4dSY7MxoNU30m7A+z84hLXduUQjPEq/JElIr2dFnX2MGwy6i@vger.kernel.org, AJvYcCVMowbWMnpY/AX/UmOmV725w8bW+yowLvdazpcBCSPS9T47RTaTMEm/CEcSB+LcPBBbUoC1Mxut@vger.kernel.org, AJvYcCX3b/fK20Dq31Moe7OnhFpAuci2b0+fFoBSoL1nNh3f7d5nHsrQQ8dXQ4qIBm9caFab0LX6q/EzRB2D2TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVrUCALYxinh7TB7hcnJHyxrwSO556E+UIQr6lrWFeqOINbl7
	g8ksbJEGcXAyJbY+Ynxvt2s3NtT1qabhnEuDnMvEvhwjDMZ9iJIrhQRZi3zDtyLr
X-Gm-Gg: ASbGncsIPy8iDPu88GeSiTSGmGq0Y43cA8O40xy8ijLyedZZU42SdjNs4l45jycaqvo
	10GG7DAAFJPjLoUqkqFpNfoRn1nGU9ufldACOoI8ehF/h5BCN30QS1176q4cH2/55BJnm3KOo+Y
	wQnzkZt6hgVMTsagbdJMGm6PETFYMKLmyIzIwF5YfXXSMrSDFxy8yGV5lr+aRQ1eBUx/C7Zqc0P
	Wc34ZMeXnUA8HCvLgFnwhuAWSGP8Xxmn/6JTSZ74aotMSIiucDKJja4C2G9m6JiyOxEnPkXythw
	snbArGzfjcr3sVH6N41TOO+cXxFBtCrUGtUNR+UFQpceKKtE5ZL97WXyIV7pi+5O/s6rkU8=
X-Google-Smtp-Source: AGHT+IHan/Inn+3hHqs41XckrP55r8fD+/kVg11iHSZaNVdMOIOPZ8mHU4EEhc6WhlTm03MzuZLWCw==
X-Received: by 2002:a17:90b:1e07:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-313f1e2bfa7mr18799476a91.29.1750134788030;
        Mon, 16 Jun 2025 21:33:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm70339985ad.115.2025.06.16.21.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:58 -0700
Subject: [PATCH RFC net-next v4 09/11] hv_sock: add netns hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-9-bdd1659c33fb@meta.com>
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

Make NS changes not break hyperv. Guest vsocks still remain in the
global namespace always, so the behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4..85b22366ef00 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		return;
 
 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
-	sk = vsock_find_bound_socket(&addr);
+	sk = vsock_find_bound_socket(&addr, vsock_global_net());
 	if (!sk)
 		return;
 

-- 
2.47.1


