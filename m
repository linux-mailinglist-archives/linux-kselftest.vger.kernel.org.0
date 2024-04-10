Return-Path: <linux-kselftest+bounces-7571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977789FBBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF20B1F21049
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B724172BB8;
	Wed, 10 Apr 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3A5tOq9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B116F0EA;
	Wed, 10 Apr 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763334; cv=none; b=DB1pdHMi9N/J66CMFfxaxk+iOdaXw1sz3blDjYQ56G2gF4gmaZiaMMAti+P5diiGdc1MPFgMZNVwnA1AwZX99rU2sN3rfds/vdpKyWrv8hB9NXJgVNEa3DqhbNAcSBPMXu8DMY7Nkt4LdOopXRpVWwt3GJAyyE5ilmIVbgkuaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763334; c=relaxed/simple;
	bh=56AsyIsWC5H0JL0LkAtUWQlFUGlkXpdQfBm/2Ob/Ksg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhAwXw3Y3Zu+mcwFCyT9QJ+ZF7zzraIUta2smDcIbKH2TI60b24E6fPRKewuS2okUEvJm7XXIrQqLfBWIWwj311J74OSdFO6jWfSRbDVaJw4kDo+00MiZM85P/d93AkcNQTccej3JbDiw+QkYwEYoyNWm8cGcnhAAM43rJCxrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3A5tOq9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so18003545e9.0;
        Wed, 10 Apr 2024 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763331; x=1713368131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB+sQJeuFBV/HMhVbtgA8BmimTyrV33+UXXBE7KSJuo=;
        b=N3A5tOq9/nediaNh+/qoZM/mIxP5PlN/lDKRY/heOHF3bX0DTW28cRli9S2YesTb5t
         F6tobDv5E+OVo6tvTsVaysJEpPrZpWq/bUKx5mE+m+j0Zl3iI/qvLmg0VAw3OoU5uvW4
         O3JQrMwyDPcd3Bm+hjTC5wrtpM5CZ7PK1rqxWF41LthKN11p942m7fUpycfiLGLPnbTm
         bSl1TphG94Gml3TqldvPLrlmuft/cQzi51kRQLpzHyxbG6QXQiazwjNVtF78JGO7zy9H
         uvbMcjiSfhmPJ0wzmBMHI2GYlEaUqOFuomB0XyGs8ZmF5f5FGZn2QTS5gRxKQlyN//t2
         T2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763331; x=1713368131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB+sQJeuFBV/HMhVbtgA8BmimTyrV33+UXXBE7KSJuo=;
        b=UHxklMtXTcypxDcjhhyE54TjAadPWZ6tGzjfwb3Yz8Z2WBJbtmF9Ud/h7GtU3VxE56
         03bU1Jvitn8aU0U/rc2BCXxlA2OONDPuQYfSvQbPbd3ZRRWw9lt/TamKhxSTCigcWdo8
         9G5GIxToq/VyYP9qM11DhTD8OMEXO7PYXpbccZUcPF3WlNSC79TitYpsdG6wozA+xeeb
         qVy6D9C1k5Vjt70zohCPaadJWcZ33Mp/kB2DXFhmyd7OCk8xhPVXQS58EZvwMgaau+oa
         pdN+j95RY5o7qgTvJvRk05em5FSdimj6PBNxJzM3V+D9nb7MTBmFnsdHBZz61clv7cI0
         kcTg==
X-Forwarded-Encrypted: i=1; AJvYcCWIcQuETvXZ+tjet3Bdm045Z/Y913ClFiU5H2bUdDCnaVlW8DC4I3ZbJxPcbCQrVh0Jb41+L/jgq5+McA6iwi3EnigZcpWmRsg1MU2N+43iHQWPDCRbC+ZfkaiQZv8oHiVthO+/w/xpyYdaVuLa39aPmNl5tjyWpOgshlb61svJjm0NtrIW
X-Gm-Message-State: AOJu0Yy3ix9jJkT59CANBxkFvdzha3d3z9aJ1B8Rap+kZSOa5l9CSqzj
	YBDIf5Td3RMpKIJWw1g44Ew4KV3wHQQfk7Hl1Weis+pXP4VDGJgD
X-Google-Smtp-Source: AGHT+IF3QnEZThB8P2DtBhWrRps8ug/RqQ/K7aYUrZf+/dfCJ17PbmCFm1GoTRpQfLx4ODCTDKPw9Q==
X-Received: by 2002:a05:6000:4595:b0:343:b5dd:fe1d with SMTP id gb21-20020a056000459500b00343b5ddfe1dmr4881133wrb.28.1712763330629;
        Wed, 10 Apr 2024 08:35:30 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id dm14-20020a0560000bce00b003437a76565asm13963985wrb.25.2024.04.10.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:30 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/6] selftests/net: add local address bind in vxlan selftest
Date: Wed, 10 Apr 2024 17:34:20 +0200
Message-Id: <20240410153423.107381-4-richardbgobert@gmail.com>
In-Reply-To: <20240410153423.107381-1-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add local address bind support to existing udpgro_fwd.sh vxlan selftest, to
ensure UDP socket lookup in GRO is working.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 83ed987cff34..52c2de895abe 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -62,11 +62,13 @@ create_vxlan_endpoint() {
 	local -r bm_rem_addr=$3
 	local -r vxlan_dev=$4
 	local -r vxlan_id=$5
+	local -r bm_local_addr=$6
 	local -r vxlan_port=4789
 
 	ip -n $netns link set dev $bm_dev up
 	ip -n $netns link add dev $vxlan_dev type vxlan id $vxlan_id \
-				dstport $vxlan_port remote $bm_rem_addr
+				dstport $vxlan_port local $bm_local_addr \
+				remote $bm_rem_addr
 	ip -n $netns link set dev $vxlan_dev up
 }
 
@@ -77,11 +79,13 @@ create_vxlan_pair() {
 
 	for ns in $SRC $DST; do
 		# note that 3 - $SRC == $DST and 3 - $DST == $SRC
-		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V4$((3 - $ns)) vxlan$ns 4
+		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V4$((3 - $ns)) \
+					vxlan$ns 4 $BM_NET_V4$ns
 		ip -n $BASE$ns addr add dev vxlan$ns $OL_NET_V4$ns/24
 	done
 	for ns in $SRC $DST; do
-		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) vxlan6$ns 6
+		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) \
+					vxlan6$ns 6 $BM_NET_V6$ns
 		ip -n $BASE$ns addr add dev vxlan6$ns $OL_NET_V6$ns/24 nodad
 	done
 
-- 
2.36.1


