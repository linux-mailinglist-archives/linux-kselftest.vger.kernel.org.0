Return-Path: <linux-kselftest+bounces-6142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42D8771EF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA531C20A82
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DEF4437B;
	Sat,  9 Mar 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbq4/Swc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DE40870;
	Sat,  9 Mar 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998251; cv=none; b=pqVA4plgnDJ8DG1447/wvrwvk/zCFE8S/xRIVC66wUZPk1tNVF3Bj69xO9Kh9oyjcte46UwmFUotJQNCFIq95XBWsp2Gp9Hrm65eb5YhyNpUuGMPpve0irukOIY9HnFSmcBpG+ntkW/5zWQqeBHWWGSiwTPzi9+/V4vHeyIbj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998251; c=relaxed/simple;
	bh=LDZSn9x6ERPVBZCwcA41BSWXp7sOHx0YTKjIjEVfN9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EyFAZod/PSYmgF8ZDr2LfdBwxZ4i26iAoYXMTpFBZWBTdgNRygXwhjVqOcvbDlGChVcGp2BnnNwp9S3WxPW9aCp4JcwMfgOwDvLGfDWFcWcGvh/R/RmgPYWSwWWYuNMpLlqCaIdtyipYQIJkSeYC9dYUfP8toy2eCZKnIpGVMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbq4/Swc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41318d2bfb2so10976815e9.2;
        Sat, 09 Mar 2024 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709998248; x=1710603048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cC2XYmDoC9bn9YpZ/SBsMJ9hBkbqwULt4LWRN+/LUY=;
        b=gbq4/SwcFbfp7aqQHiX8TEw6k6iziTUPHHDIfS1D6wx9EsEASKsonPSgtj3NayQQRF
         q3Cm1p+ADypSqtmtP5f4SuQJkrfCtyfdP+uIWwF2t3ahT9/SsfEFz+TQ/GqcNamPRVai
         5g3Ih2KnKBJ4ptDeZzFUIwqu9FWbVTN/BCPVAfufcUi0jflOny1iHY3HIHKSNTwZYYFi
         swvU0OWVdusRPPWwPR2IgHnjj+5BIHGzkcJAhNgjT+KK8pq76w9VvxhulHODVUCQb/NP
         vYcQFZhJNnc9gBZucrNPyhaHsZpdlPPvEraFiqsbPYViuG2eAF+SOyIZnjZRy+cmi46E
         v5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998248; x=1710603048;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9cC2XYmDoC9bn9YpZ/SBsMJ9hBkbqwULt4LWRN+/LUY=;
        b=XYrt4cDOuIA6shg1qalJ9cH/fJm9W8goJd7CrRq/cyb95A64AYaIONfm2pdwbSMOdy
         tO7XxmE/9x9j+GAKic3qcYmKO7rCw9sXklcawLm+ZQJA4y0pOEKlSAOQmqB58MiGHOAx
         h03+P+ZaMf7nW00zg13PNIcHkMGJyJ/eIXqLr8lw0o7S5jnfLQiiTyS4qsX4f2yhSlwQ
         1bptpNx68jJ0yV9I/J6nHMd+tCYfcURzIPKhT2khdBGXudcAaT3z/rCqbzwA7vl0Jisu
         Ho7z54ljlOwI5nkH10AVE1jl/Tyq5cfpzb0Ip7aeBhB+iOBomQWZopRihn5CKYkVqBib
         Krvw==
X-Forwarded-Encrypted: i=1; AJvYcCWMnGMd7vYPfWPZzLYXDesVa9WNaUv4+7Lg3LxK8MxKdi86UE2IOgZCbwi+brxm42JeIjNRZcOzBLeNp5LRoTIbQWmCej9d3DT3izled9+z2SLAJoFlRC/TJleKaouMa0Ys0P6g6OLjBa/OVcCiApZuIBYgUkiymqjogtWaSXYEvRtG5LpW
X-Gm-Message-State: AOJu0YwQwdiU6xqUfFg+QbOPv5BY9bMChZxupAXj+9yZV+x+L/VABKOF
	iLJO+JZYI2Ls0HNt+5hu2dArbXJN8nM5/9OYn+8msV/vfuY+dlBx
X-Google-Smtp-Source: AGHT+IGW2SFiz75macsVV3w8TuGUtPaZM1Ki5fZNfGl4d33ZA9KUpSmI1Qhz928mJNe/4CU7NgAPFg==
X-Received: by 2002:a05:600c:5403:b0:413:123d:63af with SMTP id he3-20020a05600c540300b00413123d63afmr1528818wmb.38.1709998247551;
        Sat, 09 Mar 2024 07:30:47 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bw4-20020a0560001f8400b0033e2777f313sm2075195wrb.72.2024.03.09.07.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:30:47 -0800 (PST)
Message-ID: <3b30f9bc-9540-4cdd-bbec-146d1d57f33b@gmail.com>
Date: Sat, 9 Mar 2024 16:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 2/4] selftests/net: add local address bind in
 vxlan selftest
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, gavinl@nvidia.com, liujian56@huawei.com,
 horms@kernel.org, linyunsheng@huawei.com, therbert@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <b939cc50-fffa-40fe-847a-e2bbe0dadb60@gmail.com>
In-Reply-To: <b939cc50-fffa-40fe-847a-e2bbe0dadb60@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add local address bind support to existing udpgro_fwd.sh vxlan selftest, to
ensure UDP socket lookup in GRO is working.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 9cd5e885e91f..ed66365a2fc5 100755
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

