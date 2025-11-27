Return-Path: <linux-kselftest+bounces-46652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D821C8EC5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28FC23472D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C200322DA8;
	Thu, 27 Nov 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQHeAbT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EE287507
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254013; cv=none; b=ELXGDR6c459QhpSFcNlGPHNxNK4A25o0HbM9WGM6ZEPun8Z5V9prmcoF6m8yyipXLuWfyMxFIFfG+M4G/0rGLeqj3CmOPKagzM3yo9n6x8AnSMT3HJrHPoh3Jaod8V8I1+GKvj3FMmg8iFPAq3iblHmKnGSj+i7yIOGUwSCZT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254013; c=relaxed/simple;
	bh=tvZva6AUWDs6H9DZPxZEMtv2jwVTqWRwj57A2k4OIuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVG26QyNcGihaupMAFJ7wEVhjKktiS5DOWGYoDF+A9zHvoNHF5yMcIQbWEPvlAElOxdYLcY9lpS9TSGt0SIRld2MKEE3pGIxE0FBIkrzeMZtGxlcFwjgo8eC2bfkZAyusFY96HKBt0Knjph2RweZoQoLXCc+b4vY+2X8aghzZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQHeAbT3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso980718b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764254011; x=1764858811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78FV6UYSi7/8C8kaIgUgHtZvrrRC53ZClmIsNXE7ZJo=;
        b=FQHeAbT3mQlmETrt5SGPEvZhnIvl1jsjx+iqFMMjgkP2IvemlI0qMyVnaVC2FhxppL
         gLg7LRJZ7HbIr+iTlIIEbe8I5NV08uSnBIcbok/53ucyXoYaPw5nMz3xBkpKu4U6B4qd
         cLNMLpL/z8kOFenOGh9ecAXh4FP39yBnk7EcySPbUZ7TPJ+5vLj90dnppBGCEos27YD+
         HCWg6mGios7kr1PfIa5j1YHCbl36cpp94cVp/w+OkKGgTg3VF+otTafp50mWWIEgTmnD
         lqnZxuuQjrH5Ntv4gkHC2RBw+IbaJ86LiVWAzCiyjJ2bj+zFVk23SbbgCQQjGhrlKnae
         ijtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764254011; x=1764858811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78FV6UYSi7/8C8kaIgUgHtZvrrRC53ZClmIsNXE7ZJo=;
        b=PdNONymGb/+XPsk4f2BYOQV5UhwbAWakVzP9oyqTfFz27QD8q0lxYYFBZd66kdfnlX
         XrRdo/X1gKxmFw7Vwyl2w/V5++lKK9/NA6x5mRS0eQKieP2L7iHk04rZNpqHWuOpPqL3
         E5XKg+wmCWGDd1oaygxyTGNj7kXXr11mJFReP8JcYfoanDmkzQxhFrvHtdjZeYoOJBjz
         IjLwJ5pIBql32s+zS0kJLb8hKQcz+hM6ND0InDG6mbnczThKq6T2q+1dDR/jshsSLlE7
         sUydvVC8X2qqT6b5p98iveBZonsT9VNiycD2HaY7lDTlr1LtL65BKQIMhRlJJHwAp3Xx
         Wfzw==
X-Forwarded-Encrypted: i=1; AJvYcCWbehPd66Fu5D8U6U8Lj+H/xaf+DQpC3biKX9JuV3prr8ex5qbA/HlE/SmxUNnE65invsAJClaJ+6fFoYlvc3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIRzgKTLlQg+TIvnXU+uAIk4QRStPoiKOAqf+hJA0YwI37J3w
	mUbImhlA5xSMJy3ukFmvNIoWp7DQC9TXT5TeH4EShhDNScp4qZe/Re5e
X-Gm-Gg: ASbGncuewYCeeaW/9jh6DOM94uq2y2aHZM4sFxwN/a1Y5+dFDqogQwVbETkz3ExtDKc
	2UeVJN96PcPNHawRlm/5ue5bJUselVTDl80/sUiQwKmJHkV+vLkn6u2OZHJtkLBYGNyNvNE3hh2
	hmu5+8XnWM3f1FsaCMDStDX45DMN4jmJfA9xsA1zcnawYlckcd8kCfy5JSgt9fmMUKWk7qohbH8
	/6XwYyOmaUkiqDBohq+qVNJTV9DMPHdGJS5f6pwbl8zFaPeViWlQXtYgSONf9clsmZmSxGc9IIv
	5hh3nCuZ9WWNuXkExFFs+HR1uRT/ufWst3rlcauhyB0ydeRktOdIbtf2CpOOFP7YFhqqhUpDczc
	dobe8op4e/YNlTpklC03EkVYWopZ9ogbFwGWeGSM6IAdJh0FOYKXLbXjGBWKXoK2sic2Omqw3FE
	wiXiPZOangOYQErppDnYkNbPh0xA==
X-Google-Smtp-Source: AGHT+IHOjobWASJ73Zrh6Qa8pXI3uqzF83ifoElBRiObxI4QCVxxJ5b3Dg0i0XAfIuHwjIf0lHQCdA==
X-Received: by 2002:a05:6a20:3d1c:b0:341:5935:e212 with SMTP id adf61e73a8af0-3614eb77688mr22536575637.18.1764254010884;
        Thu, 27 Nov 2025 06:33:30 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f9260a4sm2157958b3a.58.2025.11.27.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:33:30 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: bonding: add delay before each xvlan_over_bond connectivity check
Date: Thu, 27 Nov 2025 14:33:10 +0000
Message-ID: <20251127143310.47740-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub reported increased flakiness in bond_macvlan_ipvlan.sh on regular
kernel, while the tests consistently pass on a debug kernel. This suggests
a timing-sensitive issue.

To mitigate this, introduce a short sleep before each xvlan_over_bond
connectivity check. The delay helps ensure neighbor and route cache
have fully converged before verifying connectivity.

The sleep interval is kept minimal since check_connection() is invoked
nearly 100 times during the test.

Fixes: 246af950b940 ("selftests: bonding: add macvlan over bond testing")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20251114082014.750edfad@kernel.org
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
index c4711272fe45..559f300f965a 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
@@ -30,6 +30,7 @@ check_connection()
 	local message=${3}
 	RET=0
 
+	sleep 0.25
 	ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
 	check_err $? "ping failed"
 	log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
-- 
2.50.1


