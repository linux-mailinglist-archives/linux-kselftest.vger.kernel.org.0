Return-Path: <linux-kselftest+bounces-28367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6EAA540C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 03:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB33AF0C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F4192B96;
	Thu,  6 Mar 2025 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFp+HLV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3A18DB2C;
	Thu,  6 Mar 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228787; cv=none; b=RGg4XLW9r+BnyWsm8NwAbxLpfGWrTZPRi79xkHX52LjM+zhWxNv7t8s0/q49ct1umV/Tx7WYHtrj7zjBF/bvRUwbXWUs77T6/Gjl0g97EtDu6vdtmEgm+VsuxNAL2ovMgWmiRHbbkxIJNHbVlpNNGVswNRWdL+Qo5VKnvAL9feI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228787; c=relaxed/simple;
	bh=8WBcXaLXL/iP7nl/3ES4eit2pxrZ+37ELIaPFNukPYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeBitLxT9aMRl/nA84D/5obZZmRVLeex39iosa1pOULVD+6uzEdQ+Io/cAs/hodU8juNx+URDnnpzHc4OaG0UryuX4D2OCMtEfH+9sxTQMM2IGUy3ei8TUi0GaQBX6NhLf6dOoqvw4FFUmXZH8XbSB8220LiuONFxVB36/i8/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFp+HLV6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso3295705ad.1;
        Wed, 05 Mar 2025 18:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741228784; x=1741833584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO/K3jIMTWzpsGmyTlzR4YihT171aoPHTsbAGep3ycE=;
        b=GFp+HLV6g6pcMSUQx65h975kuaTuobaOZIlzxP2V0lh1OPfLSZwK8ZTL7ALVKA6yrc
         B1UE6V8FoQuqckwyU8pr0K9qGsA4rkCHGFVuXtstO1FVFoK4X3ChGqCJAYobS2587QeS
         K8u649xEOIvWHRYF0mXMAn8gpH6qNBRsnLf9zyflJw53LHLKI+MzIssxWds9MlNuT+JF
         0ocqNuOy6kJ4jIAeyLrNsInq4ssA6QCfdck0UQt2rUqJh1/itGlPw4xVex7F9Ef1/6EK
         IzwJfX+9wOa2ehDB6v6N9AplXPIg981agLJmxq1msGG8b/ow8tAuk3aSaM35iT/Xnu/m
         cdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741228784; x=1741833584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO/K3jIMTWzpsGmyTlzR4YihT171aoPHTsbAGep3ycE=;
        b=qrmMUvum4UaC2Obrrg02fs3B2DB/J/BdQqqcpvadn7G4rKzmkJsWa66dUqVRVNTGyR
         7fnZn+arvkPx9MB1603wDrHUp+Hf1PoLanAJbT/h9sIDiHGXAJPRJlJi0COJhyHtv9vc
         9eoatvzqm8gkGr39mmzYG6yeHQIuBGFWBbq+ExDdSFbso0tD8hmIFHzQmLn8R0V5SjdL
         VQp7ylrDUU7quxR3wk70QhtQo2rUsq8uNIANicveXDZ3k0gKDeT3yEkIYwNheT5pd8GI
         XVaM+8u37WFFNBi5rYSCQViIZGgHrDl+ba09qkPI4uXthCb9cAT8Ks9PA3lCN0L2facz
         0czw==
X-Forwarded-Encrypted: i=1; AJvYcCURbwHudxyMU5Ax1qI0Uy9/i+1vhSDS92ssDKksRkouKLM2JebitTqXsAM7qxQarw1uN4Ajb6DEsdUPjdnfJPhO@vger.kernel.org, AJvYcCXZOZwM87ewpnasyt3QqZEBPKTcg77NKGA034j9vt04j8gJ4mMb/pH4NG4nab8vM2BW40Fk8y3Jx/HTJGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFNU73f5HeKDzIoE2YH2NFqHS/UvNSmXdF9jaZGi+nOxST7Hr
	HEHix2kVoIxWPrK9Aw2tslFGw1554TCe1m1wHU2iDn+uGuD1nlI6JAVo28DQNdWh2w==
X-Gm-Gg: ASbGncs0STNJdnfji7//yU78J5FS+z2cklgz3dSJZwVrIqBS1DxEartkHb/Cu7CMeo7
	8hQ6ZSgbkhjDhsgcTcfw35J4KqoaVMieODcSKg2+1BH/ugcbQa37uCHGzh6lw/6GFuiLlrNt+Ga
	daL6Cc6EHMoQaKPVJcyLCb1zyVFAL/PQbSiuTrflUQyMg88SzZgKv4oSEFhi0RcPuKm1GGIhbVk
	RxZPfdeQPTnaqFENuWTwMWtScdAStPoYB+Dv1iVp3J7lfjI04TGxpgbWTL0hO46GDJq+417slTa
	pf1I8hsscoMBdTEQHqCPGCmeozzKkpnnX0YEkzftQUQuynxJaqIU3URpSdg+9Yd9
X-Google-Smtp-Source: AGHT+IHYwOCpr7hGkL1F7WPPMLX5exZ5+7vBbvbuOwSyzigC1YACRXQNSDsEgsOfuAbn3XruKcOAKw==
X-Received: by 2002:a17:902:ce0c:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22409471a71mr26077915ad.20.1741228784127;
        Wed, 05 Mar 2025 18:39:44 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm1292185ad.243.2025.03.05.18.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:39:43 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 2/2] selftests: bonding: fix incorrect mac address
Date: Thu,  6 Mar 2025 02:39:23 +0000
Message-ID: <20250306023923.38777-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250306023923.38777-1-liuhangbin@gmail.com>
References: <20250306023923.38777-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct mac address for NS target 2001:db8::254 is 33:33:ff:00:02:54,
not 33:33:00:00:02:54. The same with client maddress.

Fixes: 86fb6173d11e ("selftests: bonding: add ns multicast group testing")
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index edc56e2cc606..7bc148889ca7 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -11,8 +11,8 @@ ALL_TESTS="
 
 lib_dir=$(dirname "$0")
 source ${lib_dir}/bond_topo_3d1c.sh
-c_maddr="33:33:00:00:00:10"
-g_maddr="33:33:00:00:02:54"
+c_maddr="33:33:ff:00:00:10"
+g_maddr="33:33:ff:00:02:54"
 
 skip_prio()
 {
-- 
2.46.0


