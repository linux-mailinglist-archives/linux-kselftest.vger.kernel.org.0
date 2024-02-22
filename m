Return-Path: <linux-kselftest+bounces-5311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF8860457
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119511F21F93
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E573F0A;
	Thu, 22 Feb 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXD9nKE/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41E7172E;
	Thu, 22 Feb 2024 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636043; cv=none; b=lqshvHqPQ21e/kc08FtSzL44YMbdO474aWcyRXYFtkDFvgXAR74z5ZiqMhJ2m6p0m8GoXu7ApwtNLsfxjvBqnceAx65b5R+7msiupUHsSuj360X7V3HEwygHVCxGtKrLs68UAY2aP/hpb/KlvEikTYHSY7MvmQfG3tkw7ksGJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636043; c=relaxed/simple;
	bh=yEcHDxN9RLq38OaBT7T32ipqe63fnfoOEny+8083TOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WHqsO0RLKJHfat6/MFNZ9gXCsylZYYep7J/3vSvyY/H3l29OzQ9NJSjzJ/2dJhpTaVZdehYZSE2dzzq0A5g9VD1BwUT/daZSvWlbRU1Pbq565B679RpIPWKz0JKPCiK311aIA5EtBvIXfHS25z7Bjo/HZj3y1HIDRUqhhjte4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXD9nKE/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3394ca0c874so107832f8f.2;
        Thu, 22 Feb 2024 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708636040; x=1709240840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/LsAF7t/DjHyNUZ4YFga9FjpoydH+mPM4Uvs/yTAKk=;
        b=JXD9nKE/4nZXAgT2Z9S71xEsz6keTY9zT6Vorbyfa8OkjBmeCxeycdYCtjc+HSmfgP
         eAFWP8JEUNy2d6dZe2GtRU4qzvPL32j2eZkgIXwcyc2ZGjDTpnJ6jyyp1Zo/gGVJXFMR
         13CBuJNpC3AFoP8amOx9XATng3AZfwDCr8ED93soqL+pCNqGU6zOL7mQz9NvVtG+6T8q
         WZVEQFQ1m87hGTiYXKDeUAxDlbShtBxOCFa+g9P+LcnOXplmci0TB2cj3n0nfDGKIn1X
         7gN5DzVkamzDIr0zW/a38PVOLnwtW+SpKfktW0MhL2XUBrOrIfPE7J+wH2H+CVlOLJry
         hwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636040; x=1709240840;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W/LsAF7t/DjHyNUZ4YFga9FjpoydH+mPM4Uvs/yTAKk=;
        b=EJ9XFW+NMYtXej9mQN/uC8R6uS3VnaoTJHYvLbl58Xq3C4HNEVKlplg2LeYzkSd8yC
         FqzWFhFLyvv/7ATVqXmMqg3QpdHTK8uvO0h3tSSG/t/qYBDwFN4jBMAgTjoy+8wur6CN
         RUDZjqXiXEZHalt8t+Eif1id25qna1Jy6/hwk5nSXy/AEg6pwoFEWr05LHa5uCL0hr5T
         AZcrRthSqGDqnxGth2bEPVprW/ey89io4RbORbD7NjUr93dQl8jhIp1ugzDVCPEthw0O
         +mKRXLwn23CixbDRtefvUN+jnCwdSsYtPLakdvwGR4aUEh7H+1Ya+XdR9ZD1doUENmI5
         4dSA==
X-Forwarded-Encrypted: i=1; AJvYcCWfFabX1UjEcBKhkvmf7fvUe19o52v9oR3G7lOlKX/Fh9a1KzUdXj2Nvu/RcUSDMI/qCIC5zmC8LFbpYkYsPjYQPkdtt8sjABWcA+ki1gyDGa2IvHVYZy45adSu8poh0PDRi1RhNjuajX+4/5u7dE2GTfLWBQsdwOYx5Y73xA47UP1zJbGl
X-Gm-Message-State: AOJu0YxhoIZzIhjZSLuv73REhGFNDG634MTrYpS001MNz3LYy6/UYRZ4
	ltodNoGhD3K4jeTza1leCPhfDA+ED2qUWrVIBCSe/DgXYesbMVPe
X-Google-Smtp-Source: AGHT+IFXB/nbEaMFXlrONCtpl4m94bpLbDQAxbSjm81SFiVV49HMZ9AYUU5sK3Wv8De5bJ1XDyYGRw==
X-Received: by 2002:a5d:5007:0:b0:33d:67a1:ba0b with SMTP id e7-20020a5d5007000000b0033d67a1ba0bmr196182wrt.61.1708636039601;
        Thu, 22 Feb 2024 13:07:19 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0033d568f8310sm198145wrb.89.2024.02.22.13.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 13:07:19 -0800 (PST)
Message-ID: <2622ff3b-144f-4038-8f05-82c01afc5ce3@gmail.com>
Date: Thu, 22 Feb 2024 22:07:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 2/3] selftests/net: add local address bind in vxlan
 selftest
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org,
 liujian56@huawei.com, horms@kernel.org, aleksander.lobakin@intel.com,
 linyunsheng@huawei.com, therbert@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add local address bind support to existing udpgro_fwd.sh vxlan selftest, to
ensure UDP socket lookup in GRO is working.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index c079565add39..8cc9b6ff3910 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -56,11 +56,13 @@ create_vxlan_endpoint() {
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
 
@@ -71,11 +73,13 @@ create_vxlan_pair() {
 
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
 }
-- 
2.36.1

