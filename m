Return-Path: <linux-kselftest+bounces-15398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F8952D19
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE71F244C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93C1AC8BB;
	Thu, 15 Aug 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+kIJbZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF31AC894;
	Thu, 15 Aug 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719584; cv=none; b=Now7brFzZJNxcB9N5/I9A2o5GSc2tLxZloQa1v15Dqsk8Fp+z4AqVnSLW+Gf2cn3K8kBxx2vQSGFAkzYdcKrNHsP56mJ+ul/nRRpHlOnGgcGXZSVN5SlTuBsj4oO/UJ24jERg3tyyJoaM9vxZkBq5Tp8LbKI3443dD8joFphqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719584; c=relaxed/simple;
	bh=BEOj7P4xJeFSnOj0Ju6Rm9KsxDM/MTPYKwQ7Ti+PJ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chagRu6Uw+ad81StZ7DYn9qTmkhkPy4hiv4Op0da2NG3mDzkIEmRsijytRuXBdCoN0QUpGyf8/nrj0yy3F7xNhUp1T51ZL286dO9u1i3WKqACakFXpAYd1Z2x6ZJNOHhZavz+mH+13x1DSOZ0B9GyDCBH254KTLWXMVLJlWwTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+kIJbZR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26ff21d82e4so473292fac.2;
        Thu, 15 Aug 2024 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719582; x=1724324382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=T+kIJbZRvDA5xU39Cgug99NbgWaAtJkbQq8M+vbYL7rDaMLVfr8IL+ffcX3XUFJtRG
         Tmd3hrFne9pDOUnEsN9LwQyiItFdBC3alhbmuBUTBC91AqDlupKuQS20fRO+x8CAfwKL
         8svsL9u3ymutcOHljfHahEfT4r46xnLA6RE2Zn8i6pHFWYRmYIaoIEJjV5I+QdalICSr
         D6XgodcxUJZjqg0y+l9NmzkOw+eLXfk9UkUFXoLWwmBZOitJGuDce1PnwOoYQxrF0H7m
         Akx7J4qUv4klvkKnm0OSnDvRB/8LwwFMD1QnvZXfElHPUvbqxT0O4N//EWXPoueuif7n
         iI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719582; x=1724324382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=BKvf07fNkAV3SJgyIZVaRRxBDYu6bVl/7nTd6f5k5vLOQqu3d+TKOHOphCNKak41A7
         g/JYueEyumma3ZC2HiwIDJEGpv27lao804QSEkxC/xtz8YQjxtdPS/6FaOFzV4QMtLkQ
         GpPxrSchlSrvRcDjNP7FMrqbtlwYs80xVCoIDkQNiP/5kOxG5xJ91wV5UgD9dTWc/bhL
         5ULD74Db7irfaISEEovePXq+dv2wlAfT/YMAEzQJCmqm572TO/YWOofdnyImnlo/gOt7
         bl4N339kmvKkN7HOh+1PKfadXtQ73L+h6ljF0IaMs+WqNHay3Obfq/f2mprUdncveBoC
         SKmg==
X-Forwarded-Encrypted: i=1; AJvYcCXGjRiVsfaIq0DXhYGHweEHESokw32v4V5r0NDg5rDwQQJi73dLd70IPEvhYAwqXEitnDeJ3W+Bfk3LzL8fvY1z4AjSecLECvg7zOR8Wgl/q+OmIg8KsnybW0fRbg9Y0C3QmL40gIHQShInJi0F7UENvGkE0TsFPcsqf12Cm6wAzYb9Y/CT
X-Gm-Message-State: AOJu0YyS/Qqv6Tx1qLFpiSGi5NiS0+t+/R/NRyKSDVfWuEy3pK/WdANj
	pXQDF4jIlmuKVtAicfgbJdiFcD9ugR8C6wxdilp+2clccjdBg+5J
X-Google-Smtp-Source: AGHT+IGirFlaXoXP71zo21mJ21H4TWzYTBbM5uIkHexbqAUsQWsbNuX/y8HpZaz0jsPUU6P9sUpnzQ==
X-Received: by 2002:a05:6870:7029:b0:260:e6a6:396c with SMTP id 586e51a60fabf-26fe5b0d4d7mr6646453fac.30.1723719581355;
        Thu, 15 Aug 2024 03:59:41 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:f070:7306:329d:c8ca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae6c76fsm829915b3a.94.2024.08.15.03.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:59:41 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v7 net-next 1/3] selftests: net: Create veth pair for testing in networkless kernel
Date: Thu, 15 Aug 2024 16:29:22 +0530
Message-Id: <20240815105924.1389290-2-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815105924.1389290-1-jain.abhinav177@gmail.com>
References: <20240815105924.1389290-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the netdev list is empty and create veth pair to be used for
feature on/off testing.
Remove the veth pair after testing is complete.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..0c32950fdd17 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -129,6 +129,7 @@ kci_netdev_ethtool()
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
 	kci_netdev_ethtool_test 94 'stats' "ethtool -S $netdev"
+
 	return 0
 }
 
@@ -196,10 +197,25 @@ if [ ! -e "$TMP_LIST_NETDEV" ];then
 fi
 
 ip link show |grep '^[0-9]' | grep -oE '[[:space:]].*eth[0-9]*:|[[:space:]].*enp[0-9]s[0-9]:' | cut -d\  -f2 | cut -d: -f1> "$TMP_LIST_NETDEV"
+
+if [ ! -s "$TMP_LIST_NETDEV" ]; then
+	echo "No valid network device found, creating veth pair"
+	ip link add veth0 type veth peer name veth1
+	echo "veth0" > "$TMP_LIST_NETDEV"
+	echo "veth1" >> "$TMP_LIST_NETDEV"
+	veth_created=1
+fi
+
 while read netdev
 do
 	kci_test_netdev "$netdev"
 done < "$TMP_LIST_NETDEV"
 
+#clean up veth interface pair if it was created
+if [ "$veth_created" ]; then
+	ip link delete veth0
+	echo "Removed veth pair"
+fi
+
 rm "$TMP_LIST_NETDEV"
 exit 0
-- 
2.34.1


