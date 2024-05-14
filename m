Return-Path: <linux-kselftest+bounces-10184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C98C5A0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 19:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C94F1C215FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4917F37C;
	Tue, 14 May 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmYMBgAX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3332AD1C;
	Tue, 14 May 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706411; cv=none; b=jSJviLZpre0l6USxF3WHLsFLx4WRixrPfpGxMD7sM9usNw+6y1CXXDwSeKF4Lu4+QFIY2fk2VRsjmbS831pJ12PN0Aw9mCX8LrcxI8qHTCufhp9JclmDfWVVUntxIhEqqcfIj8jbylTqJBFuKLcxVKrzMK2fe1eyAiC5KqjsIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706411; c=relaxed/simple;
	bh=myXA2G0Xw49AlkC8lVgzyk8+knCG4OkEt2v5csHBEko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApLAaVGo2IxpHknBrLhvh4IMBQyKi962HxohM13gq43mXEI9gi6IYxo+4oYwy3L0yDNx1ZZCb9zGwA40Ga+D/jt8NOs5ExBkB1/zdt/9ez/Tl8VFKcttCcB+eoOVMFgCa4M3cz9gN/0EU3zdx7R3xEzC0p+F+vp3EHJIg+9JHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmYMBgAX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e4939c5323so72550981fa.2;
        Tue, 14 May 2024 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715706408; x=1716311208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyHBRVBgS14zuN34iI4Hkq/dBvDFESfJ7FWpiCIUk30=;
        b=nmYMBgAXJwQQwspu2thFkbWzSVc6frVBDjM1TkbAlU8B2vLWNB+mgJCJw4ewf/yVMX
         gagbgBsiODvs9WHoguZNBidno8DgRGtuCeaNfqZVMR8V3PDcS8S/2BgBC7M4yjYQlOEU
         Af7qDMT4YQ0p5oF0U8T39qKX170bQHqNeOknP9z1ZRfL8FFDF4MY/wDhoPKTwb70xL57
         dnskLhwqM/rpfuyERCxD3bT5grUupseGF9TL6EWhqbgd646XDNMO49vVodozyKKx3C9n
         +LFfIiIJlLaBOZE072Eoytu9bFWGPlo0ilNGRtTzhcgjD53SU7JgMeG5XDtZPVI/KrDD
         c1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715706408; x=1716311208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IyHBRVBgS14zuN34iI4Hkq/dBvDFESfJ7FWpiCIUk30=;
        b=k1OHMdoXD1105/Z0Nd9meUsfXDBXhQb4W6lIno9WE6BV75RshQkahsDFHzvK973qeL
         vVBexq6db/JZeT4Wm0oIQQgY1mePSntwsa/dKsZpuAk+xSmK8LKWRQqsd3dOr/X8BFfi
         MQ2g5f2WmeyB9h+ge0AVQ7KieRuDkpVVqy6fQIslod9L872BR5P8GCB7S346PbHhGkow
         9abpmcn3IdNZXlQT3WSMwy1Kg98kWSAa/P6fVkeXJy2BAbunpUP7Oom5gr1TQNZ3Rq9s
         VYeXE/bqS88Auww6StTuzrfLeQNu+2SlpxsCAHLK4P/7ficRtXE5T+Njoj/GSGSDxhY4
         zYmg==
X-Forwarded-Encrypted: i=1; AJvYcCUABGs5wMK+oAHRrkQC/PYxZpWETyTBi/RGmR1cShv7ztaGchrRKbvsGbgWagMWU2x+i2q2lCVPMTDOec2zIaMYdgKbCYuF89AtircORK9gXYUITXsnRYW7+Tg95Y6iYllivkNhYuicQd+jMAxXfCL2PTFEonhRsOkN8jLZKbJT/sWrCDNm
X-Gm-Message-State: AOJu0YziRM1equUBD8s7HjOL8H+SpnBrc9qGkejJU5150JKQ0JwEE44G
	RB7P83N0JpMHCA8SG2IoGaFhDb8NMeyFwfqU2LJiQQL0AYYraIbM9d9Wfw==
X-Google-Smtp-Source: AGHT+IHKAHrJL4JHb2eSoXriNeAEkmodYMxHBrXgi2GmZTZ2VQ5iPMRlbIK3ZWZJUPMkViu8V2WqnA==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr108576151fa.46.1715706407529;
        Tue, 14 May 2024 10:06:47 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42015deac1asm80799915e9.17.2024.05.14.10.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 10:06:47 -0700 (PDT)
Message-ID: <fca08735-c245-49e5-af72-82900634f144@gmail.com>
Date: Tue, 14 May 2024 19:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH] net: gro: fix napi_gro_cb zeroed alignment
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, alexander.duyck@gmail.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240509190819.2985-1-richardbgobert@gmail.com>
 <20240509190819.2985-3-richardbgobert@gmail.com>
 <CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
 <20240514071407.257c0003@kernel.org>
 <8e0b027d-4d30-4f0f-82ef-113287f17c6a@gmail.com>
 <20240514090626.69676cb5@kernel.org>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20240514090626.69676cb5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add 2 byte padding to napi_gro_cb struct to ensure zeroed member is
aligned after flush_id member was removed in the original commit.

Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index f13634b1f4c1..b9b58c1f8d19 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -42,8 +42,7 @@ struct napi_gro_cb {
 	/* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
 	u16	proto;
 
-	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
-	__wsum	csum;
+	u16	pad;
 
 /* Used in napi_gro_cb::free */
 #define NAPI_GRO_FREE             1
@@ -85,6 +84,9 @@ struct napi_gro_cb {
 		u8	is_flist:1;
 	);
 
+	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
+	__wsum	csum;
+
 	/* L3 offsets */
 	union {
 		struct {
-- 
2.36.1


