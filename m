Return-Path: <linux-kselftest+bounces-36801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA140AFE37C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AC3562087
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DC283153;
	Wed,  9 Jul 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTUMufiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18227932E;
	Wed,  9 Jul 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051842; cv=none; b=GHVdETmSTsl+8441qY0AeyKvPBx7rP8g+7DPxD/ruDUR60lY94vcpy5GAs85IUq3Or09w7LmlJeDydVVTJinQ9bc14SGrNKaVDMuXrpeO7DH3RjKozf87TDQUPousRH6eDOZUKSnZKIIDn+MOLMte69WqGjeybPHNgklsIUd5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051842; c=relaxed/simple;
	bh=0ckeoMQ5l1Nebnl0KzMuj9LfEcK6PzHidQ3yaCof3SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+S9UKQQVu3+hpZCFpV+QCoEPrXmihvhrQuFmQNcRawn7qHp6dmkXJ8p9ZDEXi2nfaHuFPzQZTG2/yxjCwEGpD9RL6o1mkHSsVLDTCGyJn8g5TWC2TZ7JWCMUKsSUqDCncUPtcjOT+oJjn970Um8Qs+7BAGn3GM+hTkUMhzNCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTUMufiI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6126369b3a.2;
        Wed, 09 Jul 2025 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752051839; x=1752656639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVAOmrbVyoXLWkVrNpzcvbjWE91YQcmIcUrXKbyuEDQ=;
        b=HTUMufiIyUSmiAgqwAL4ZAO4pv8J8rHJ3lN4xuc7YuSs0LeccwXtv0y0JwYigi84tL
         I5yKpQH8zEwE9YMVzkinP6lNi97AYiLK7i6nG12WQP2L9durTD+G9D3DA4DBs7OgTMY6
         pYcxC0lFSSAB43NZNzfUZM0AIFmGQh2ndvoofJ0FWz6D+58jrmTnTyHzJdNTpHDQzf29
         n+42BXsm6KeIlueRhWdDusuvefDO1B7FLUkN0oty89+RpfsQDfx/CM7oK4HaC6kDYCIk
         +cikUcHEQX5enHAao4EtSTuYLjhszknzBnRmgs2iaHuB/GjF/wfhLuK5v8gHdjugTJz9
         VFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051839; x=1752656639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVAOmrbVyoXLWkVrNpzcvbjWE91YQcmIcUrXKbyuEDQ=;
        b=NH3j0Qxrh81PG6182dxuchXaq5hZxm9/GM43vyvfR0kVFi+hot1nqe2zJEOX87d+Tz
         xVSgUFS81QAet9yQWjritnKweCl5cOB6TNeNnQLnYeJdkQRR+jI0rbTr1zdWZmXPmtox
         S0//uL8qp1qClUHKea4GhUObIdFE3OlmU7vhAgLJChfKRdCeW8hOFHZeV/VUPRFgYRVs
         GWA0j69gzsCd9sPLBzXNhalbVpM8YOWLUWRjb+uJ89mm7nivEM66ONtTRTg8DcXVkuWJ
         gP3Ev/RkHJ80rHyTukB43eCQw6j2p9sFiMqsVz92pqHricdl8QpkIVV6ZWZWbi4IIOPb
         HEhw==
X-Forwarded-Encrypted: i=1; AJvYcCWFpOmHsIiU9GeweWVOGn94MB1P62sB612Mc2c5JMDo4cYtS6q8BVeOdsl2PUK1JUQI5lI8ixPLGaOfqvh8LE63@vger.kernel.org, AJvYcCXJkl5Y1oKfhBD16a5RZj4ZIIbtTgD227NqspTA0w8msMmDCpVHwoJMxoE+tgO1SWYx8QGxYbIWds57cLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VKH9juaMwIMuJIwDJL8og1dMJ6lBFvNpuKDqaZxin8rS+GZx
	KuY/wzzX4pMzIK9dExu8Cr7lXgQjDredTuHhvi73yNjzNM83wFpOqF2NkDWjm5E2C8Y=
X-Gm-Gg: ASbGncstOXCaVPsj0tdKuBFsGgmUI3BPFoT+0asVrc2/1QulpjmlVi4HZ4K4UhR0fdI
	PGGW9/XwEOwsMbODbBcbCZoVUeCCTgw4FdSXqP+9S2uLdmfnJ8DlNaeaHCtCVB0NjtZhHT9cSyV
	dKncqFeONcA03BPQpYqC6OjPdZULBokZWy5QptCBR8JAhVyCOGjHoVdtoo0BhmR6YVRtS77bMGw
	Roychhielj9bCN5f9UtSNEuVI8CJyfilah8TwpJDMU3zpOx62Mvq36DaqsrMtgQp7E06FMxzLwl
	aJOlRKm/9u4T3b3MSISpGsBsojTL0sGi1lH9OgaApELY/N5RCUunDWJNHGXIaPZiqO9vH9+qyDg
	IkmkOv8W77O8=
X-Google-Smtp-Source: AGHT+IHOMLQc2RNJQeeLL2fQ8zMzHwsIyhA0NyR668Mp2Zi06xsn/uzpuLPE2GJqRGmzRy3L+ZawDg==
X-Received: by 2002:a05:6a21:6d95:b0:21a:b78b:e916 with SMTP id adf61e73a8af0-22cd9fe3f8amr2862959637.27.1752051839424;
        Wed, 09 Jul 2025 02:03:59 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74a681sm13619309a12.76.2025.07.09.02.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:03:58 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] bonding: fix LACP negotiation issues in passive mode
Date: Wed,  9 Jul 2025 09:03:42 +0000
Message-ID: <20250709090344.88242-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes an issue where bonding fails to establish a stable LACP
negotiation when operating in passive mode (lacp_active=off).

In passive mode, the current implementation only replies when the partner's
state changes, which results in LACP timeout and unstable aggregator formation.

With this change, the bond responds to each received LACPDU in passive mode
by setting ntt = true, ensuring timely replies and stable LACP negotiation.

Hangbin Liu (2):
  bonding: update ntt to true in passive mode
  selftests: bonding: add test for passive LACP mode

 drivers/net/bonding/bond_3ad.c                |  6 ++
 .../drivers/net/bonding/bond_passive_lacp.sh  | 21 +++++
 .../drivers/net/bonding/bond_topo_lacp.sh     | 77 +++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh

-- 
2.46.0


