Return-Path: <linux-kselftest+bounces-46668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC983C90237
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 21:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F8ED4E2C6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2E315D32;
	Thu, 27 Nov 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUPfxoq0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACB314B65
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276273; cv=none; b=dKBPp4C27LBDPHzSgKYD2JT4HkI9hHI5K5NYseEimJWqHqapbm9HyiDuJQUolJe02Nv/i0HB+93EiwyVBh14gsMbBVc66DCiJC5ilbOtTTBBplUvJcEO3MZk027VGebpinXJtIHKMmDvMukKPLUfzy1dVCfito02AhwRcpnI76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276273; c=relaxed/simple;
	bh=wKLX50upMBXTkaYsn5OUPjFxWSff+rFLBPN8t4x3gXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwRnAebhvIWdFL+CW844NuTLzFPiQqN2coMpFOX0gSph6Isw1+iaQRN0l3+21j+TRxJbJ4GirUtQQr03OcQKSQElovqP8kFHDixjlD1d/EzzrGQDe3yJ0/FX5DL+vZ8oZK90F1oI3L4y2s1R7ghjMD6HmzzJh59MzUWxbA897bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUPfxoq0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so762524f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276271; x=1764881071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqckiZGHf3bNG1zTutRGSVS8PaQ4OMxeAJnwQy2/Q0I=;
        b=aUPfxoq0Hio5ZQS2G2fSjo0D2AbYa5RAD/3sviTaZmeuhfDe4kUhhkqG2F9uicqq0T
         8NM/Iw5A++YZYbDOWzRar66j0C11LjMgtJQF7Dr5fk1sihqoS+x+sa3pvL9OeooNkjq7
         KrYdJIji7Lnlis05CvAHPwGc33gcPaQFQmFnwH5+zLPNn5KYaumjEHhuj4TqR6GZeilF
         a2i7co6DnN73ELuYq1t1Tdl9td/uKBKv3Ggw3Oe6Cfv+n5nxpVI/CpOmzwBx9XMxr2O9
         V0o5xHOiytQhzFticuvKM+PxRrxyhK1ykMRjt0+y7fkSOZcr6gq1zdHtYoW0onuSX8wI
         iyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276271; x=1764881071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqckiZGHf3bNG1zTutRGSVS8PaQ4OMxeAJnwQy2/Q0I=;
        b=W6mTMgKptfSlhOpDVvXN5t0CCqtZMNjJ6OcokEHn7is1FRakpR6PyOO7uVxcbODWb4
         1phskVdQ31JW2YqqT+SMD2/J0c85wgLoo3mbw1muZz/S4CH96GEYoruWf6NYVDOooxsg
         l3tsHSVXxR0DDa3j4pauk/Iz7mXzoT/V9gdAGE/SLXKQATxRhfMkgI1+Nby/QVJ+pwHh
         6P7Ylum9Nvx2arQQ1vFw1nZov0TGSBx+a95IesqlKhjYpVMFQB0oooHoU6MCmHppbPxq
         edtb7t6NjVh0JkcJt8FaEQN1rpFgIGTI5QWD5EyTy/57dXyLg4cKBYhdmElN/zt6r5Lr
         x9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKmCbIKOYYxNOArjkxuKrH6l3MVK2IySdA04toU9JarR4SBji+PjMj4raudDGFQmH4pTm7SbFVsQi8Iu/nfWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7JDIgvZdUOcL7Yfm0HXmc4I0YyH+Vxj4eLfU50HeZ4JmXUFv
	zDYieReOimGphENlbxCdgdQAmHOXLrrCN64xIopbbnsV7jMBxXML5YrB
X-Gm-Gg: ASbGncsK23gd0UADNLGvdtL5nvm8nGKcfH5IdAjBUuEYhHx88K4rQnM9RXdwHKBZgeQ
	bSQDHRCgvz+NpSSNuuWhA5JwvRL5LGwrrlGwAx5QR5lAD1yUlVE7xjJ78oKejsSLmJSwfDnUY4n
	vHlGmDFUln6PZU4PAiYEuKFRqYooeZz7fsAa0h2u2Ri0nf8Yi5AWTqfa/7n2AOUcTwa1QcgL/oJ
	ZOfLfIj0ge280sXrv7qabwOWCYg61hknnTUP5HgVJEN/JUfRQn8EkrvUw/ssNkg7bbT3qHCn9WH
	HUsajOyu2kZNOPws1xwiUUIIg62tKRE/FqIOYBG1ZPk0rt8QKRJOTgXCMTkOnZ1BPWvYS5DnXVf
	+htIMryb/ESibQd/iTSBhuVhIvAzYHZ5WW/6Qs7L+2ze/pwYtTNTTpyZMXmEbKZbIOQ2+8iGCd/
	3t5eSf6f4RZnsaIwFRgOzVcjxa
X-Google-Smtp-Source: AGHT+IG8xP4HJO4DnqjJPYdufQcB54g2uija30UcXEQTiQoRe6u8ZY63WY3zQ9RB9/Vh8e5LOItojw==
X-Received: by 2002:a05:6000:2c0c:b0:42b:2c61:86f1 with SMTP id ffacd0b85a97d-42e0f34a082mr13136672f8f.35.1764276270574;
        Thu, 27 Nov 2025 12:44:30 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:29 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v6 1/8] net: page_pool: sanitise allocation order
Date: Thu, 27 Nov 2025 20:44:14 +0000
Message-ID: <337ee90a6464e9b9ab09d1850fd9aedcb0e13679.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to give more control over rx buffer sizes to user space, and
since we can't always rely on driver validation, let's sanitise it in
page_pool_init() as well. Note that we only need to reject over
MAX_PAGE_ORDER allocations for normal page pools, as current memory
providers don't need to use the buddy allocator and must check the order
on init.i

Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..635c77e8050b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -301,6 +301,9 @@ static int page_pool_init(struct page_pool *pool,
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
+	} else if (pool->p.order > MAX_PAGE_ORDER) {
+		err = -EINVAL;
+		goto free_ptr_ring;
 	}
 
 	return 0;
-- 
2.52.0


