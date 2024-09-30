Return-Path: <linux-kselftest+bounces-18596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957A989E10
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6246F1C21AB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857E1885B2;
	Mon, 30 Sep 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp6wS2qD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635218787B;
	Mon, 30 Sep 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688268; cv=none; b=YkP5Bkw7yG4PCDguB6ZgiGYMLtCGEp4qc9jm4mrLfSPr3ho7z4rEbVvYBfwzGCm8slQBhz2rgBcbu4NF2wcpUVZdgoqi6a/rCpLytJL9LQpjhN/OtVgzgZPaod+kYTmo5eY3jGl3qMen9qc6Z0FWGAm26f7KdPJhzO2EFJzSIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688268; c=relaxed/simple;
	bh=Z+ZE/9b3TlaLquPRSacQe1wns51kZqrwN7LBq5wFqnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGplLU7TeK0W94aNmkVAyPIQzuu3OGa/D1bq4UPYIfXscxw8ZCAYpx1PKkU+/FuchvgzigVcY7jnydo5V7vejer5Vyyopb9FKuTr9jpU6VdPUYjtaT05rl16DGUCzadWQyFh04nIriql6cgTpFlKQS+hHdySi6U+yz6MvsTmWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp6wS2qD; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db299608e7so2561148a12.1;
        Mon, 30 Sep 2024 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727688266; x=1728293066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTZiSyfJKygLF32ndzD/TkJ6YJ7BCKLczFUAKWF71d0=;
        b=Bp6wS2qDNpFfssgx+wXoqbje48bPYgTGNMgQTw/Ls7hYHhMXqJz8boEAUv1o+BN5Ow
         dBLDzPXyToLMMdVHa+/3ZFqhUNr1GCmBgLbtyWz7INg2wDK3QPnEWREC59vE9PDPaF0T
         hWnhoTChWwx/X8Fa++jSd9hkutOM3mg3Eecse9k2DIQKbH1BBaUpPGcp7tpeVgR31AXK
         dWypGiQb37Ma5VY9zsziXsP8zvAz6lF9z7UJ0+FVYCXLGw2o8QYXTJCmvYnbpLNIORyb
         PJ1WwjiJwMzXCzXqsvF8o4PfF+h18znhDGytcwaWK46Ju4YOUIEh61+dDqfKDSTLC8vw
         lFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688266; x=1728293066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTZiSyfJKygLF32ndzD/TkJ6YJ7BCKLczFUAKWF71d0=;
        b=xG51R8Dx3l0LEplptg3b4fIuWgjMZw/t62re/0mk5QW0ELbq4WdK0v5biBLa/2bhkz
         LdsUhRYwpJeHR5FA4nSOOIvda8KNtGbPLRyKPxY6NX0lUsSVRQdu5LSDfs48IMWwtcC/
         VA+FDZzmvwNjAoovOxS7netBBnWJNPDGcm21VkOdsE0CG3GNMcIostz6zS4Kx4T7IWPE
         H4edveRiW9Te/n+MgYJOA61bMsS3rFMfwGRqASKyYhW/E1cZ/KHYxye+xY30tVW47Fmo
         P3pxfUyFdJpAmSzh1REubG99SpSG8FqApcIhjNfyWAnqIyjoWTqsOhCfvbgY7sa3C9Xt
         IaPw==
X-Forwarded-Encrypted: i=1; AJvYcCXaEfmvWzde7vLBAfvs1Nu0ZlYIcEzY++lv+k6w8oGrVLQ7ABRpkM+JQTUNIPdgU98/rehR4pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKAgyLE6Avb0kIdKPakLgRy8iwpqchAb3djnQK0C+CgSp3Fy6
	DTdacKqx8edG6rRTlcL9bJqNUggAcnOQzovqXMQkipTMfzXsnLs0
X-Google-Smtp-Source: AGHT+IF2vmBUSGgX4iYryY0S/Fw83FNAkxUkk5X57aVd0QTtVFz+3PjanV1RVVj2XGo3SQ/wvn+ifA==
X-Received: by 2002:a05:6a21:4610:b0:1cc:e7a2:2bef with SMTP id adf61e73a8af0-1d4fa703999mr19220793637.30.1727688266557;
        Mon, 30 Sep 2024 02:24:26 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5eda4sm51015485ad.48.2024.09.30.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:24:26 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/3] net-timestamp: add strict check when setting tx flags
Date: Mon, 30 Sep 2024 17:24:14 +0800
Message-Id: <20240930092416.80830-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240930092416.80830-1-kerneljasonxing@gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Even though this case is unlikely to happen, we have to avoid such
a case occurring at an earlier point: the sk_rmem_alloc could get
increased because of inserting more and more skbs into the errqueue
when calling __skb_complete_tx_timestamp(). This bad case would stop
the socket transmitting soon.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index fe87f9bd8f16..4bddd6f62e4f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	if (val & ~SOF_TIMESTAMPING_MASK)
 		return -EINVAL;
 
+	if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
+	    !(val & SOF_TIMESTAMPING_SOFTWARE))
+		return -EINVAL;
+
 	if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
-- 
2.37.3


