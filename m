Return-Path: <linux-kselftest+bounces-15346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A643952287
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB832282158
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC61BE86D;
	Wed, 14 Aug 2024 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9keJ5ip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB331BE857;
	Wed, 14 Aug 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662931; cv=none; b=i79xi8DQsEJqIpaZGfg86e6lqqGdSR3adlXBQljGnD4ra+9kRrtCtxElg0Ew8+nssSZOYJt8n0VHHS0bIRFCpvQkqj13NaVs5G/sXHZ6Ab+l8piogUeM7Phx7Q6Kdi/IYjo+EWT+ZL6MaxWJrcrxT93VkhezfGWzDon9/IlUxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662931; c=relaxed/simple;
	bh=kCKmkxqpKDVIZ5/l2Mxu/MdocjIDTV7PR9QYSVEYqoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKUzec47Dzsr51HrI2F1Y4AHkA8wUyjYmDfOFiMnOwwcwNqjyb4wzGOWq/byEk/Wq+7jg2CfDTTmjh09OyJhQuKeXC+ehKQ9NswGGxrT+TKFgJk2xj8sd6mnSXnE/Ipq1HkZUV87ymwRCPzjv+x24WO1HumTxMOYKZleajryxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9keJ5ip; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so223565a12.1;
        Wed, 14 Aug 2024 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723662929; x=1724267729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y569x91Td7XRE+lMbNluWg7Ybo+veJRFXIycDOnA3b4=;
        b=I9keJ5ip+Smm9NAmj8UPga8hU5B42Ysu8PHQTlbUoNEOG8kzp38CnfAkRcTh786TkC
         bS/EP756H7zecZKeE1Izl18sec9/ImPfo1af6+mTE7fVX/YfvkGVpqbU+gqncznvg8yg
         3PXXPnT19JUHkM9Ge8PmARMnG/YFMtie6rGMFpsj0OlUFYtxsuCWhdmRMw7tsk0XdwcN
         mIfNaZF+Cup0fZo3LrHxuyz4vB8aFRKEbH8dpjO28iJy45XvhaUjaluSe5XSY5XNPP8J
         7I0fmSQFa1fgHZcOEJ3AFtYjMAAAVdMvxnDq0F7r/H2wKRz9Xuq7HBv1N0BBeugKqcLT
         bXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723662929; x=1724267729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y569x91Td7XRE+lMbNluWg7Ybo+veJRFXIycDOnA3b4=;
        b=eyVAatD39sI016N3Axw5OSy9CPI8GE2DYDjaI+u3lfzTBFhu9lBfU996dOf3H1ci6p
         gAzmCuRgNkRWiY4+tMrzlLSftXniP/vgu+SO3esZ8dIZJX3EFcKXONsmMt72HVBfu7A+
         mmZ0kKlgLPwPiy+mf7sZq/CoB1XANdbI0OkO9D/qNLCOY4vEYfG9X0xp1kbv0SS4fo1G
         g/Sj2RzH/2vyBRBvUxZECjJsQSsx61Wg3kS9CvCj5+zE+RygUYkNoOFVVZkdMwXjoIPH
         9Y+/87bkImbz8P06RGURWY+WNSZY8GaAKjYaKkb93ZRaeN+Xuv1SUbaBEm9Xi9HynQh6
         UFkw==
X-Forwarded-Encrypted: i=1; AJvYcCVmPOj2Ksq8pbjjdK3be0VIK1k8+hygeufH8O7mFiGKqLQ0tjickaNMHfMhRzL+Wrm+HY98XtzJqfZC9tEtokrGNUMZd0bD8OZhActmlEElW1B7ScV9LFg/dFW+Q3yldME5keMnN50ljuo2nDQHFoE6Oz+Wf9ZuRIbueA1drn7KBh5L9QVZ
X-Gm-Message-State: AOJu0YxbQHTT7Cx59Pe2iVmw8QWTTfWCqXa4HH5cibVpWV1Djnx7LIKV
	6VY3wpzVJsBUTIhe5L4VyvpXziu160H+VoGpUmp8jHGLByURRo9m
X-Google-Smtp-Source: AGHT+IFkKwmvDWZNC3rpujMmYQWLJn0M72tWGasujGlI7tpvi7MnznnyiGEFQFPLO3Awn2JHMQ7z2g==
X-Received: by 2002:a17:90b:4a83:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2d3aaa7a01emr4207219a91.5.1723662928994;
        Wed, 14 Aug 2024 12:15:28 -0700 (PDT)
Received: from dev0.. ([49.43.168.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac844e54sm2134282a91.44.2024.08.14.12.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:15:28 -0700 (PDT)
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
Subject: [PATCH net v6 0/2] Enhance network interface feature testing
Date: Wed, 14 Aug 2024 19:15:15 +0000
Message-Id: <20240814191517.50466-1-jain.abhinav177@gmail.com>
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

Changes in v6:
Use XFAIL for ethtool operations that are unsupported instead of SKIP.

Changes in v5:
https://lore.kernel.org/all/20240808122452.25683-1-jain.abhinav177@gmail.com/

Rectify the syntax for ip add link.
Fix the veth_created condition check.

Changes in v4:
https://lore.kernel.org/all/20240807175717.7775-1-jain.abhinav177@gmail.com/

Move veth creation/removal to the main shell script.
Tested using vng on a networkless kernel and the script works, sample
output below the changes.

Changes in v3:
https://lore.kernel.org/all/20240614113240.41550-1-jain.abhinav177@gmail.com/

Add a check for netdev, create veth pair for testing.
Restore feature to its initial state.

Changes in v2:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com/

Remove tail usage; use read to parse the features from temp file.

v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com/

```
# selftests: net: netdevice.sh
# No valid network device found, creating veth pair
# PASS: veth0: set interface up
# PASS: veth0: set MAC address
# SKIP: veth0: set IP address
# PASS: veth0: ethtool list features
# PASS: veth0: Turned off feature: rx-checksumming
# PASS: veth0: Turned on feature: rx-checksumming
# PASS: veth0: Restore feature rx-checksumming to initial state on
# Actual changes:


# PASS: veth0: Restore feature rx-gro-list to initial state off
# PASS: veth0: Turned off feature: rx-udp-gro-forwarding
# PASS: veth0: Turned on feature: rx-udp-gro-forwarding
# PASS: veth0: Restore feature rx-udp-gro-forwarding to initial state off
# Cannot get register dump: Operation not supported
# XFAIL: veth0: ethtool dump not supported
# PASS: veth0: ethtool stats
# PASS: veth0: stop interface
```

Abhinav Jain (2):
  selftests: net: Create veth pair for testing in networkless kernel
  selftests: net: Add on/off checks for non-fixed features of interface

 tools/testing/selftests/net/netdevice.sh | 55 +++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

--
2.34.1


