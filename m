Return-Path: <linux-kselftest+bounces-15883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2EA95A3B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3BC1F214F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCB18E353;
	Wed, 21 Aug 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjy4eRC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD84163A9B;
	Wed, 21 Aug 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260755; cv=none; b=A5lvF7Km43eBJnV7l+79vPFTn9HWNzVB4RGi4yNRzoM3gR3s8wcyrtK0ilvqpWeGRywX9kUdRsPCCTjtMXdqu9ojHh+N0f+rWw+oEjwwS5XdTyo/JxK5I0HHxvmC5zio1cogg1GEEv7CfejwHD3+Gd+ptbdz+2nAgeh90XeFOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260755; c=relaxed/simple;
	bh=66Vy8QEs87LEHI71ECrt5vaJ+VHcYj23PosXnQUHFI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnVq3O200F5aLvR424Vi2YF+x0MGLmNwnBGSoi2w7Twyr9kcRRaem6f/9+5G3ohPVpv1ImRulEA1ds6up78EdtWs72CQkdMYoGQDfaTNJZ2l9wuWQhUMlfqQCqLA4ncJDBO2wTblTW+hS3ac9ZlCuHb9bXXwGuZI+MEYYQAQHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjy4eRC7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81fe38c7255so431133639f.1;
        Wed, 21 Aug 2024 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724260752; x=1724865552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aeEtvwVlcf70fL2I/ylSs82ZEoEcvOBQZX7uqyLuD8=;
        b=Tjy4eRC7NudhFdWrDvhI7biE8UgmcJIzdhcg4x30VZ3Edj2hgRojWYc+kvlHWkdAAm
         Q6KtIX0fVH/aMmT9gnM80mgAcn4F2lZVZplrNn3ARiXhRQS/QEDNujjiXuCxO/YhkF+N
         oIUjaFe3Bo3JVwoGiwa7x4qxmD3ZQdHuY9OQ0H+OsZ2YWyH6nVirp+V00fb6wSgZPjyK
         eR9pAVJ6yjk2FmOpmyO1EaFioi4qr3HMB8iQDOcJtj3z2kMnbeLG8XKJX57GOjplsZbm
         RGBeNaHshqqjtl2GSNGQjCtI4MbQhXE3UsfbRRx67MNV6hFLPNUr0+0dubdh5p858V/u
         ZXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260752; x=1724865552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aeEtvwVlcf70fL2I/ylSs82ZEoEcvOBQZX7uqyLuD8=;
        b=f2TST1dajGqmlXkb5lREgmVJDbeRPb8vQugDBWON2MdrnfDXQuLFPiqjnhp1ggtqgj
         rj/wis8413QyayNxirO95RbIGu29xZms3+NxcBiT+V7RrOw9fXG5nmChbbX8zNaO928P
         kBds7JQoRqk2iCkaDMzhRtHe7u5Wuh+Nf4LynZmaqWiklk6GyuRPc2oS8fmN3LiH5+DM
         3rJmmkWY+p8CqfxtG1miLN3r2IifWPqc81dNvqDMHWSrQlvWyymryhKNmlTUu2ORTeCC
         3DIPnwkYxXHQlq15czQ8NJW5VWM4EzQD/jROnvw1ya0sizxfV6+yzno6FW3us6/hAoda
         sVkg==
X-Forwarded-Encrypted: i=1; AJvYcCUiQLoznhbaU6yvPwg23z3Huc/kXtgZIIP1uGcvFBNITN69CmP1rGXSFpsQgWQbmv1x1Q5orfwyCdo8fDhaz25K@vger.kernel.org, AJvYcCVTDdo3QGRWcMO9WB8ZmkbzNAt+KDktmtEdGebeuLgieXpoT1b+WXpEplXYwbpJvOkzTsKdYQNiVcWSSKw=@vger.kernel.org, AJvYcCVhFhSEJappbZJLQEtlmC4DkjwNPXNYo4usW9uGNvglrfKnQjsu9Fb3lLFP20wK9BG4Qthj7nud@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrRc8kwG45Q/wLQEhfYPA73yV1yDjL82jC7wOpuRkSsq3R9iH
	z59ayJSxXxYXezL5asEvLqZZEdWt041SbSNIwmgtmtHCSNj1rFkF
X-Google-Smtp-Source: AGHT+IH+uuH2xGcskOcKjSb6iL7jGNbOj57uGMJr/Y0q+o+XvmHI9WHJ3+JZfq9wOKJJ2tp8rwDccw==
X-Received: by 2002:a05:6e02:1a43:b0:39b:3651:f148 with SMTP id e9e14a558f8ab-39d6c3bc397mr29583585ab.21.1724260752521;
        Wed, 21 Aug 2024 10:19:12 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:2256:a75d:4176:9e6a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356929sm11454913a12.73.2024.08.21.10.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:19:12 -0700 (PDT)
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
Subject: [PATCH v9 net-next 0/3] Enhance network interface feature testing
Date: Wed, 21 Aug 2024 22:49:00 +0530
Message-Id: <20240821171903.118324-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series includes fixes for creation of veth pairs for
networkless kernels & adds tests for turning the different network
interface features on and off in selftests/net/netdevice.sh script.
Tested using vng and compiles for network as well as networkless kernel.

Changes in v9:
Removed veth1 to avoid redundant testing as per feedback in v8.

Changes in v8:
https://lore.kernel.org/all/20240819121235.39514-1-jain.abhinav177@gmail.com/

Remove redundant variable initial_state as per feedback in v7.

Changes in v7:
https://lore.kernel.org/all/20240815105924.1389290-1-jain.abhinav177@gmail.com

Create a third patch in the series to do SKIP -> XFAIL replacement.
Add logic to incorporate XFAIL on setting IP address for veth pair.

Changes in v6:
https://lore.kernel.org/all/20240814191517.50466-1-jain.abhinav177@gmail.com

Use XFAIL for ethtool operations that are unsupported instead of SKIP.

Changes in v5:
https://lore.kernel.org/all/20240808122452.25683-1-jain.abhinav177@gmail.com

Rectify the syntax for ip add link.
Fix the veth_created condition check.

Changes in v4:
https://lore.kernel.org/all/20240807175717.7775-1-jain.abhinav177@gmail.com

Move veth creation/removal to the main shell script.
Tested using vng on a networkless kernel and the script works, sample
output below the changes.

Changes in v3:
https://lore.kernel.org/all/20240614113240.41550-1-jain.abhinav177@gmail.com

Add a check for netdev, create veth pair for testing.
Restore feature to its initial state.

Changes in v2:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com

Remove tail usage; use read to parse the features from temp file.

v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com

```
# selftests: net: netdevice.sh
# No valid network device found, creating veth pair
# PASS: veth0: set interface up
# PASS: veth0: set MAC address
# XFAIL: veth0: set IP address unsupported for veth*
# PASS: veth0: ethtool list features
# PASS: veth0: Turned off feature: rx-checksumming
# PASS: veth0: Turned on feature: rx-checksumming
# PASS: veth0: Restore feature rx-checksumming to initial state on
# Actual changes:
# tx-checksum-ip-generic: off

...

# PASS: veth0: Turned on feature: rx-udp-gro-forwarding
# PASS: veth0: Restore feature rx-udp-gro-forwarding to initial state off
# Cannot get register dump: Operation not supported
# XFAIL: veth0: ethtool dump not supported
# PASS: veth0: ethtool stats
# PASS: veth0: stop interface
```

Abhinav Jain (3):
  selftests: net: Create veth pair for testing in networkless kernel
  selftests: net: Add on/off checks for non-fixed features of interface
  selftests: net: Use XFAIL for operations not supported by the driver

 tools/testing/selftests/net/netdevice.sh | 60 ++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

--
2.34.1


