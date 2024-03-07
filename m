Return-Path: <linux-kselftest+bounces-6047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF8874FEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A268C1F2227C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BE12C7E4;
	Thu,  7 Mar 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI7afxEi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40C12C52D;
	Thu,  7 Mar 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817999; cv=none; b=qvfZ/KXr0h8NbyYFYsRqoEt3hk8vmqmPTAQpsXY2l/cDxS6tpunCjf0I8Lk9bAnlBCpfXtj9SeTfH5C9EGAgCrTONjcUj7ZPck0vYQwCgQ1Xoqbwfn20HNZY+mxJQT4pAZPC36oE5+ueMw/BSypNB8EjAAMpiYCmpG4duO63ywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817999; c=relaxed/simple;
	bh=LDZSn9x6ERPVBZCwcA41BSWXp7sOHx0YTKjIjEVfN9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UnIh90rruJtDoh4tZt97jdjxn7b/0YFLxfCzoGlYbRc6IoE1EFjAE1lajtVAmylz+RbFoV8sqCFZjZ2cuM300STYDfT0LmYxdS820hsLm8a7o5goSFsJ1wcS+M7PPRT3UsaGQ8OtBqt78WduE4anT/5qdHYUjHAmRhpx4y52fck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI7afxEi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41312a01b1eso3262185e9.2;
        Thu, 07 Mar 2024 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709817996; x=1710422796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cC2XYmDoC9bn9YpZ/SBsMJ9hBkbqwULt4LWRN+/LUY=;
        b=HI7afxEizFiBYh2alMXSgRkzxwfaKaIP75DLfpN5OMfZZexBmQQ3/L2nMiJJuXyLXC
         443OArN1icVHb3VItPwKiK3x6M5Lw+exyGcF3viUer76iEHTQxF+UjDCmIZj5mydIu3R
         OljZM/hpzi1ryl+NzgqqxxLnSErGkB04V4/FXnnsQFtz6PF6xaDBDnOCE0uj0A3or6JX
         /qRfNOjDmf4L07J1nTHDFMXlBVuvBFPAOFCMgvOo/EWmLX5eV3gwEh06LkP2fNYfHSFj
         yEBoh03dBFTKF9Aevg9nAwbMwSgWl21erTkebSsLfKvm8zK7nayhjpsp3D18xy/q1YfR
         K4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817996; x=1710422796;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9cC2XYmDoC9bn9YpZ/SBsMJ9hBkbqwULt4LWRN+/LUY=;
        b=wI8JF9w+/Dj4R08tr4mvJVCLb0ZOJT5oqM1NAImhtkHK8K3qa+z21uhEASPqR9dmvg
         RObXxtQ/N1gBeNo84NmOW5kEQRdeE3QaNp0El9H/2iIWUzvjl/vCR938knAC32TIgMYM
         6YWYbtWQ4vwYlAAS1iHtJHUkzPI6zxzKortJtg6fjA/aQRBgon7Hb8vuV0Ds8ZFry8rj
         PjnkcqE0YXtiGzfbSOVjH9serdwN5oxfdGFFC51+whYA6LoeltBCB9hn0/A5A5ag4q3I
         Gln65CtCrfVeyJjFGq/4TqOlT1IHTN6NvRrdGLLDZg6di7VlCO7n0jDru6Ny0XQlxFOj
         W/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXww4pJeMNLoEGeriK/dCKr/ZGzEhPRAV31A97ivRQSXcVYNTQ6PXIilD51MACNbtWE2rhby4nHzF8g3VT+ZccL6+ugU9N1Ivk780CGSDFDESEBvxX4CLNnpxQLUPkXTLbHXIQEHsksfhgSYZKNk96Nr7AHa5Lyty2qMPfc2OppKo5GDF8I
X-Gm-Message-State: AOJu0YyeyMnA6uEwvmwmo2u6ynORZpZYtbU7A9ANjr8wLore0X2uEksD
	MKWn2VOH77nfG75D3QYBpeyglipbShXK13H08LfnwRTAgZhV7bNf
X-Google-Smtp-Source: AGHT+IErJTGKzpmtrbt+mIwiAJUcQKrHCrk4BLoKdstTxnoqDKVKm6e3Qnb21e532R46gvpdCN2lcg==
X-Received: by 2002:a05:600c:5254:b0:412:eddd:1289 with SMTP id fc20-20020a05600c525400b00412eddd1289mr5462256wmb.3.1709817995935;
        Thu, 07 Mar 2024 05:26:35 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b0041312c0cc45sm1208587wms.0.2024.03.07.05.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:26:35 -0800 (PST)
Message-ID: <4ae68011-ebaa-49e8-bfb7-9ac071dc56d2@gmail.com>
Date: Thu, 7 Mar 2024 14:26:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v2 2/4] selftests/net: add local address bind in
 vxlan selftest
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 shuah@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
In-Reply-To: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
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

