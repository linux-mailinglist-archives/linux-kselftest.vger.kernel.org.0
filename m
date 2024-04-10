Return-Path: <linux-kselftest+bounces-7569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CAE89FBB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2951F219DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C916EC1F;
	Wed, 10 Apr 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUmhn/29"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714B16EBEF;
	Wed, 10 Apr 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763320; cv=none; b=YvoJVuyR/cToTaSIGfNzlZ8ixa8xZeufDdvoHvwlb+63v0+bsa1tFjbw3gl4Ey8VNWcOl9noBcoUxYx92qa91v2Lyhvf9hnneGqanyYJwuwYNZSNpe4BqfdkMAYt09+7OVSstUW2SiNYrNjFH5WktubeUjLapQloHBcsyDfTqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763320; c=relaxed/simple;
	bh=vWx8hjmgbGaYijZPOHAFQF3Diarftvn5nTcDZWxUfWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NC6D1ojATcEyfcdbg3hJeozwzB7auAZ9nnyGPXWTdX9lwTjp2QuCeTZmE7yxXTE4BPpyZYPr/7gearDz3iEttWLEipp2/67rBsAlz4Vm5iHPsVh6cjaxmXV2V+nkml2BRCIl3HEiw1sayr30ieQmF0OpEuomF+dW7XONHXtQxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUmhn/29; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343e46ec237so4116290f8f.2;
        Wed, 10 Apr 2024 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763317; x=1713368117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68baX53kYRdqiSV3OuL3sThzmNqdOFLBEOv/P9LxiMo=;
        b=lUmhn/29r1jhMngW5rBuyxAxpzyouSBQc7BhiLnU7QSuAUUY1IoLnwGvoXFNAPS9+o
         MCJdoX/M25J6nnBSL1OPsbV8uFAfleloNrDW0fS1LvX9MnIN5dAP9xWOrYuPsJbrJKsF
         x6fyq87Yh0K74Iq9kXx3c79Ecm3RZpybAFRqMkmzMladSRu3CWx7CeSIqM8rqpZ3CIVU
         PcuSpRkUMwr8fTf34+Ukjpti6l02M/r3vyzMkmzCMDgnNCpPrjllt2EKQEOCuTNj72Q+
         yUL5gVKH1OApCTyfEIDo+IXJUJ9c5bYGZ1pqwToVySlZPS1GX3EJjGW0f/1QIE9Zqmmb
         p9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763317; x=1713368117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68baX53kYRdqiSV3OuL3sThzmNqdOFLBEOv/P9LxiMo=;
        b=Ht7Xk4I6LLPsj4VP8DKMyaYcjxiGa2Xx4VYjyJOrvnx6ev53eT1qJXrORHyLsx74cD
         J1mhbJc9WN1ubd0bA0MbUJHVtbSfSNDRPx2CvHdHECD6PKqeggwwoxoqPjkN7i5f42Z/
         Z87nXFq3dvNYyhP7zqXEo7ozdSyMAhMjaNBxaEU8TnzMz9+XoO9HHn9fDpDODo3RP3PS
         fczEHlgW73flRNDEI/9S6t3ZHWqh1Inn3Jgxn+ZYIFcSnHUn1PzSq50MDtMwh8vJnXV+
         SXklDiMbmoGraXxV5oKVD9i3vsvtb0q3/Sw11MBQ7a9lEfqLF3/2kT5ZZ7R+F629C8Bb
         CNKw==
X-Forwarded-Encrypted: i=1; AJvYcCXV4j+hWfgALjTUmAzGFSPkaxg2SCNCV/8QfwDpk+ogErJn4DPn+hBCngSGJeBzJwqpu1RDoWnhJJZP8tc6tNDejPPX6MMwrAL1lvBbYWD5Iq7pY73UjXYTKESy4Ba42nTBQy1od9sSGC0WcTclXQqaqOkQyOafl7Tp2/JodVGIkm/YiRFO
X-Gm-Message-State: AOJu0YyjkoayZurNJwFXP+7850ONUUEaQmV51scBoHn4ToTsYhXNNpxF
	YuvEdsDR3rket2pVbAVN8k4ysc6IgW2tlHAYaEJq460zRCPcmBfg
X-Google-Smtp-Source: AGHT+IFpCTXftuYdAbu9wXWKxlU/Jww9KocYRa4/MBt6ILtJAroKsGboJFb5WMAzrx/I3nDy7QQrCg==
X-Received: by 2002:adf:b312:0:b0:346:b6e:395 with SMTP id j18-20020adfb312000000b003460b6e0395mr2143793wrd.9.1712763317311;
        Wed, 10 Apr 2024 08:35:17 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b00341dbb4a3a7sm14043505wrs.86.2024.04.10.08.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:16 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	dsahern@kernel.org,
	aduyck@mirantis.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 1/6] net: gro: add flush check in udp_gro_receive_segment
Date: Wed, 10 Apr 2024 17:34:18 +0200
Message-Id: <20240410153423.107381-2-richardbgobert@gmail.com>
In-Reply-To: <20240410153423.107381-1-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO-GSO path is supposed to be transparent and as such L3 flush checks are
relevant to all flows which call skb_gro_receive. This patch uses the same
logic and code from tcp_gro_receive but in the relevant flow path in
udp_gro_receive_segment.

Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv4/udp_offload.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..1f4e08f43c4b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 				skb_gro_postpull_rcsum(skb, uh,
 						       sizeof(struct udphdr));
 
-				ret = skb_gro_receive(p, skb);
+				flush = NAPI_GRO_CB(p)->flush;
+
+				if (NAPI_GRO_CB(p)->flush_id != 1 ||
+				    NAPI_GRO_CB(p)->count != 1 ||
+				    !NAPI_GRO_CB(p)->is_atomic)
+					flush |= NAPI_GRO_CB(p)->flush_id;
+				else
+					NAPI_GRO_CB(p)->is_atomic = false;
+
+				if (flush || skb_gro_receive(p, skb))
+					ret = 1;
 			}
 		}
 
-- 
2.36.1


