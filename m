Return-Path: <linux-kselftest+bounces-15397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1454952D17
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A961C23458
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB21AC891;
	Thu, 15 Aug 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e37ggKjr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2251AC885;
	Thu, 15 Aug 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719577; cv=none; b=pLnjYd+886FlwTqaVfxJv/F1G56YBwmxX2rJBj+/9ydzf71NZyJW/iNucSls3HGZjRmPZThthcrXSQUhYL7KxO+QJ2FkN0Ic14ROenEw3/XJVFwFwsAhQJb3DYbGHWYOiuKO1Pisa5w8x24iGow7SvBSo7YyIPk5hB0bxZ0yWYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719577; c=relaxed/simple;
	bh=kGK5MK0Ncm5BsPliSkW52dbOqbLJtaSRSnBLaBwRSvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+U6Y0bBW1uUp2veiPzZm1qINrZF739DnAITPPbQnvUU0tl0nO6zFy4nj+kTXJT/AaR55pjf6EVauP7K6G482VLKyw5r1mFh3dNhEmXKI1E84eI6ri0CpvMeuAgucZt8tmXViodO43STbKokZKFF85tWa2N3xXY4jdHnuz+hxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e37ggKjr; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d8060662a1so481958eaf.2;
        Thu, 15 Aug 2024 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719575; x=1724324375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2gYBlopv26SnjKVkCkpqHG9JrB7DcQ7BheR1nwthfU=;
        b=e37ggKjrmzJmNiiNj5oNZQeb9WmSDBKgzTSsY9P1x3glqPCuwbN8bK5UT6KFKUTIgj
         JVqAvNRb5jjuF8Sve7wqOT15ubsWWSyZYL+GKtp7fb+CLlkeAjFPDHmR+dH4OEgvexFu
         57+oD7eVe+zasppQKKOfP7XGOYfZPqdSw9g6RR0HVtCmdSXN4O8SMTAitURlaGsDKGtU
         jMzW+Wxlp/uLXMp7x5tu1pbgEMEfnz27yQB1fRJYxvr8l58Jmoo8ilfqkXB9IBLtPZNM
         qi6aNCtE1mz1vqHV0U/FeYk9jUsqL0XIgfrPAPLDwocHuMMQs1UAPz6VQ9LLT6deDlo6
         mtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719575; x=1724324375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2gYBlopv26SnjKVkCkpqHG9JrB7DcQ7BheR1nwthfU=;
        b=A0c2dkJr6tTob+K1dpr3FdtEz0n6qF6hs5LP71enSdFDF6ykYdieoV52WoWtMH+GSS
         YPx1Q4vvEizJfLGISa8T1DXGbRMuwYneVSla51mSVcGmRVDYMap7nPtTmkgyLPMXb8re
         6Lua0pF85f6fYzbajisnpjBMQmlTihfcbCzItFZgx+0N9biOovbJo+vt6qz7Ho22AHOk
         mp+D8HyuafOp4Xg5if8C85cvBNmsss4XPw8ldysiD+ROxMDyT9eEBLh5cW7h3n5caesA
         Uf6UCRU1WVLL5vqXqOBr8PZJCAmN9a9b1/gS8pzu8XjfQoVNkrDL6pMNNGoyiF2ghbZf
         uVXA==
X-Forwarded-Encrypted: i=1; AJvYcCWBWYodfSY/c5ABi1wVEmmlvfVVKZ9CvhFaY3ZDrvlBgzaOqHi015A4UpA1VJ8tIxPxRa2Zw6jyh5da6r1+NrYW@vger.kernel.org, AJvYcCWuJYPAFdpvGzu014KMH3OR8ccfdwkurD//i4Z8Eh1xG1l1LqYL2SBi7yxRw98EfNGYRKoH41HY@vger.kernel.org, AJvYcCXA+Ozv4izNin48pL+guuVGqY2DT5r3JMpg+P76qSWeoxR3xUE6b93VCoOW/TeuTIIz5WrYNAsYHWSqG0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjppqhmqXEJzw4BN0CaQG9nIRtA1dyqH32xzIC1EJQxIDhPdof
	U+TgozsKOgKvkVcEXKfYVAFOE5YvAl/TFSan936h94JSqmQ89iHxHBsducxk
X-Google-Smtp-Source: AGHT+IEYmmBlJlhHJ98IDOAH9ngK/JFXn2aR2ujYNasQpsZ1E67vf5pcJQm/CI+wVYIf7gS39+OZgg==
X-Received: by 2002:a05:6870:959f:b0:25e:1659:5eec with SMTP id 586e51a60fabf-26fe5cdafedmr5716486fac.51.1723719574965;
        Thu, 15 Aug 2024 03:59:34 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:f070:7306:329d:c8ca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae6c76fsm829915b3a.94.2024.08.15.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:59:34 -0700 (PDT)
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
Subject: [PATCH v7 net-next 0/3] Enhance network interface feature testing
Date: Thu, 15 Aug 2024 16:29:21 +0530
Message-Id: <20240815105924.1389290-1-jain.abhinav177@gmail.com>
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

Changes in v7:
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
# XFAIL: veth0: set IP address
# PASS: veth0: ethtool list features
# PASS: veth0: Turned off feature: rx-checksumming
# PASS: veth0: Turned on feature: rx-checksumming
# PASS: veth0: Restore feature rx-checksumming to initial state on
# Actual changes:
# tx-checksum-ip-generic: off
# tx-tcp-segmentation: off [not requested]


# PASS: veth0: Turned off feature: rx-udp-gro-forwarding
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

 tools/testing/selftests/net/netdevice.sh | 61 ++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

--
2.34.1


