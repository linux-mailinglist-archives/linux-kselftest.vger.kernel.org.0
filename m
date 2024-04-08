Return-Path: <linux-kselftest+bounces-7401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34589C6CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FC02810E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D224A12D1F1;
	Mon,  8 Apr 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NixUm4bz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3B12AAFD;
	Mon,  8 Apr 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585930; cv=none; b=f1xAFHzQUx2AWv+F0JkQZFFOzqG9VlvgNYuTL9Y+rDeNE0UAayZzREfC7GyV2/7oFbLHRY/9RPiv1Cx8jFYwVp0cRpZqwsfsM8jx0uDc+/Z9WFVWTJm4mDQG6rGu70+yfgtFoa2Z4XD43oNFTzHUInWG+rLr8NkLiKMd1hJonuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585930; c=relaxed/simple;
	bh=56AsyIsWC5H0JL0LkAtUWQlFUGlkXpdQfBm/2Ob/Ksg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLHBVANJm5kYX0QhZbFewffNJnTJwOg3m9ovWee94/qZiHW8im3gQramkKcFO+Ux2puHpSfjiV1hrqguMRiNhhoeZ3GmRdzusWfUqEySl1laYmWi6oqbq0yfXcucYUKo/AJutEMupp4DVVesVEAs43c79JKjNJsTkafzMsPc12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NixUm4bz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343e7c20686so2429060f8f.1;
        Mon, 08 Apr 2024 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585927; x=1713190727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB+sQJeuFBV/HMhVbtgA8BmimTyrV33+UXXBE7KSJuo=;
        b=NixUm4bzV1RVyqRGw605M83CBdOI1SHQsSgQx3Po5q/YCp3sQMw1BUptFJBunHAp68
         gysW6QV5o0wxn1Lmi9eHNEZjwFkdgm0VlxxEN8k8bMn6qF5L3mFK9q/9Zwa8feeYLERg
         CrPCBf0wr5TBvZSz33/E6S35BStVInRC5PvEqDjanX2jc5Ap6nmowPRItJAN0if3cIRg
         9THPIaAvYP7DrNtyqNh7MkoMZWNzcgitH8dbi98pKtqbeGBi2QvR3QL7uSv0SpIlj6n9
         90kJ3sDgTFNqB9LXRK2M0bjgxR32h9HFdGVpEOH4lrAIPMUB8Rbj3AVq93zyDXlb76gN
         wqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585927; x=1713190727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB+sQJeuFBV/HMhVbtgA8BmimTyrV33+UXXBE7KSJuo=;
        b=H8Jvq4Cf8shJXOLOVBR5Y8Ao4XLkcHx/hDYGWtEbnHPLTFwZ/KWYt5r9d7SvjjwhWG
         xSVQ6rGa/41k/CNhJMz3GvS7uOsdJDSPMhm1fZahDu8SUmCKcPBVbBOLk9kRb23Le0YX
         mA2qgJ6mbJcue/dij6VPTqIub0Vy1lIqsKJb6SRVbPzPWaL3axoKcOM+hAH9JcKJr0wB
         x2EEJX1oIqRPqDRf2jghh/noTvQB+ItVVkHdQz8o36LJ/2RVSTcFBISPUSoOOMr4WBMK
         NixosmKuokCI2qKlFCZ0Kasr2gIpK0v97yUzPCccyFFIqScGb5ZAGs+FeNwa18c5WUyG
         Q+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV3Xh6HADaV4ZAZXGaxFcHHrTjdhYWApqs6SNjse+QLAIae/Keo2tefbKXixCiauwNiZ9iYUjpir1V5RvKTjSTOwnc4WLupcTozLD4EXJc0blBYE3DLAQRnzogIIPffXWEWozyvExBATHqsrzrcuTRdnjiustG2i0Vx7PhcseBUkz0aS7mt
X-Gm-Message-State: AOJu0YyJq09omzqfJy9qbhJW35IBgyzEAexR8WKyNCtMf63XdFH7Ehu9
	My7OnHkPprO+PotPJ5Ly75Ctn5oWSOwOU5urvG6U+jGVODucCFtX
X-Google-Smtp-Source: AGHT+IF+Ne2vguq6Y8jA0s4FaHom5ZURP2d0cPKC5MWJGJpywVi5rmQX5xXtHhrggPm3L2kgqPvFyw==
X-Received: by 2002:a05:6000:1c2:b0:341:843d:dd5b with SMTP id t2-20020a05600001c200b00341843ddd5bmr7377694wrx.4.1712585927153;
        Mon, 08 Apr 2024 07:18:47 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4104000000b00343e392829dsm8789438wrp.97.2024.04.08.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:18:46 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 3/6] selftests/net: add local address bind in vxlan selftest
Date: Mon,  8 Apr 2024 16:17:17 +0200
Message-Id: <20240408141720.98832-4-richardbgobert@gmail.com>
In-Reply-To: <20240408141720.98832-1-richardbgobert@gmail.com>
References: <20240408141720.98832-1-richardbgobert@gmail.com>
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


