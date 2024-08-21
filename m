Return-Path: <linux-kselftest+bounces-15884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E495A3B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF690B231A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC121B252B;
	Wed, 21 Aug 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkgMs1mp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DD163A9B;
	Wed, 21 Aug 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260767; cv=none; b=VzNZFNmsp10pWd4esZu1qWt4+tarXK/twDdI7Kt7XS2lP7ppi04bbkC8gNhY0FAmcIk5rgYZM2GpjZHpCsobCADx9huyyZE/MRupkh2n9Zs8LVygw6fNE4pcVX5EEdCT2E/96RxUOcacqdjsW62o3j0vWzdk3MfjiB8aE7fL0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260767; c=relaxed/simple;
	bh=plYZXFNk9rSlbVsfuxjzQlythilmvSFccRmlgogdFMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bu/4ZtthfC/8lZD6n14gnc15j0itAz+RUo0Ll5LP15pob0yEicv2IKi9wBT/yavle33QPuRReC2EB3qZtxSZPeslEonH9UpQ1qw8ut2QnRUM4NshAhsdojaGJ1byEcuJRBRxaS8DYHMH06VubcN6o1n89pnreoHaPe02myBFsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkgMs1mp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db51133978so4320963b6e.3;
        Wed, 21 Aug 2024 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724260765; x=1724865565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/0hikUDUFqirM6RDbNFvSQVtHApfkwMVkRRxVRdI9U=;
        b=PkgMs1mpPgl7Lg/h5LrrBQ8cKy35fCPmN8pZNEpV8AC4LxXupRbGG9TAIy6IZI2zph
         23T/pyDnQ6ck9f3RwV/1duaGBB0Kzq2OcDQJWMA58SjZVUfBxD3aNEOPL3JNrcgoMLKr
         U8xfHFIwCXyCO88yetFXf2oWBWbh3xzI9gAqKVLXZN+a5SbGgDvau65X1DvsKI1zoQud
         wQCwtiRWdQn4u3IJCVCR0u0am66avzoyFORBXVQUwcWj/V3/Jy9PRGRKlWX3eLSo9F3X
         ln73IngBp4yQFo36a1dAtSo60oIuj1VkxPrA9mXmhNqm0H9zxXCKCYSaqwC3eqDxYIdP
         nq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260765; x=1724865565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/0hikUDUFqirM6RDbNFvSQVtHApfkwMVkRRxVRdI9U=;
        b=KiooLZtpQ6s90y8iSa0sPppz3ZDlQnZigokAnLx8KlHxygYjWFBhv2ExsosvSEbyXj
         dWUS81K/giyzP7uTzXQHFLDeLT8OaVJiEDdfFYa9JL2ocZ8TmPRROVdC2s46FGr12SU8
         CegKz2RF2nxZXGm69JIe6cjSHKxHHS2xp2I/jvK+fS5kcQzsfk6b4jSGG3FZXyVagH36
         kyBsPSqNp4ei112I6ZZtp6y3iyHirAtZxQdrysNVHMrDVLbWK6TgkrBs8v4zD9O99rom
         0E1SJVW/WWUaKxhSc02nTUAc+K/dIfr9vr7YAJSTAJtl9jM/Xsg0I6tFgmWf9Ia/9/6I
         xuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV64uB0IA6KEw6DVNjKL4OrIYaA8JLBettbmNqfKblpkyZ9L358jhRuvhDHjB+M1QNcWnAgAUTo@vger.kernel.org, AJvYcCWfk05VyoWeP73IDIkT6DQ3WPtp2RMmzmvY10mXv5fDTkpbPSmMYi4Vd0T8JcoOBlQ/6ujzwyv+WL3PNvawo8nb@vger.kernel.org, AJvYcCXdiapBYlNR/OHyvXxGqQVmSEYtgWkHw5dpB0LEpT6Q02od4JN+ruE9WmvYZ4PrEHF0CB4BgZVosRj/JBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+WuWFqZVfGZFp45Y9G4DU0t7J6/wVvHXBvu620nhltyBvUVq
	9lJze++6i20KYPD4gcIIVo7SxKPCufiXIJgpiPdqXgpipZ0XLxOF
X-Google-Smtp-Source: AGHT+IGymdg2j7tqXYa3mGg9Y0MdXYxPaO7C9c0BBoxxwEjjkItuhb4cvwE2lgetUtKWiY7g5ifPzA==
X-Received: by 2002:a05:6871:689:b0:24f:ef6b:353e with SMTP id 586e51a60fabf-2738be3937bmr2981116fac.36.1724260765117;
        Wed, 21 Aug 2024 10:19:25 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:2256:a75d:4176:9e6a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356929sm11454913a12.73.2024.08.21.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:19:24 -0700 (PDT)
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
	Abhinav Jain <jain.abhinav177@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v9 net-next 1/3] selftests: net: Create veth pair for testing in networkless kernel
Date: Wed, 21 Aug 2024 22:49:01 +0530
Message-Id: <20240821171903.118324-2-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821171903.118324-1-jain.abhinav177@gmail.com>
References: <20240821171903.118324-1-jain.abhinav177@gmail.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/net/netdevice.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..999d72b6670c 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -129,6 +129,7 @@ kci_netdev_ethtool()
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
 	kci_netdev_ethtool_test 94 'stats' "ethtool -S $netdev"
+
 	return 0
 }
 
@@ -196,10 +197,24 @@ if [ ! -e "$TMP_LIST_NETDEV" ];then
 fi
 
 ip link show |grep '^[0-9]' | grep -oE '[[:space:]].*eth[0-9]*:|[[:space:]].*enp[0-9]s[0-9]:' | cut -d\  -f2 | cut -d: -f1> "$TMP_LIST_NETDEV"
+
+if [ ! -s "$TMP_LIST_NETDEV" ]; then
+	echo "No valid network device found, creating veth pair"
+	ip link add veth0 type veth peer name veth1
+	echo "veth0" > "$TMP_LIST_NETDEV"
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


