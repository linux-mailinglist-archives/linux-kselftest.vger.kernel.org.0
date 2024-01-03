Return-Path: <linux-kselftest+bounces-2614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346A822FAA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BB21F2485D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49F1A5B5;
	Wed,  3 Jan 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqsJsf7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701C1B267;
	Wed,  3 Jan 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d8902da73so18932415e9.2;
        Wed, 03 Jan 2024 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704292627; x=1704897427; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mKtz0EgC7apyalsnDXJzQCeCS0mb8rF2iA/Grb8so28=;
        b=MqsJsf7CPgZX9S4fj6bwZr67+xaU0Cof6DqYbkO50OGkFZBsCFIujP39Yjhv5dMlMI
         5QlB7qbWraJuhMeFKx6IeJte3VxvixJaENXpdDiGC879zbP6ABdNADRRrLmPsFccAdl8
         nW+NK6py5TLZDDx243AhWsaN7mHERU0UzbRMypNbMlhPiiXN/tjKr6BuVlUEbdR+WKHd
         tPqc7gAeLYxtUdXDlOvDM6DkXeCEbFOOxjru0DTSedaYzf17ceJ1b/xgIECGDKep027m
         Os7bB/zy6vq5W8dM6Q4/kwzzkwTef/uNtZKoh3GqTbDn2aqmZVn6ONQLmgNuMjmedjtk
         JqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292627; x=1704897427;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKtz0EgC7apyalsnDXJzQCeCS0mb8rF2iA/Grb8so28=;
        b=cJOEXQYGcD4O8JCQdWv9FA2WKKRGfhK0XzLCT3fiu9FPOnL6IDkUZ6pFv0np0/UJ/9
         EVeo3wjrEa6/44NLJS1BexEewNX9XdQ9QFGdTRPzUYbVo9pC0bsp1QCoh+4Bt9Cm3pTH
         LMLH9ehwZW5aY4K7k2XtiePMmSm/kVlO7PmW+mOOizsPu4kcVsaLYsSG27o1VOdX/szW
         D5In7ZQ+zu91XDTWy2UnTH+RAroNPFV+q8KyQQsWWboYYuJ5OOeulq0hLb55XG7D+bSL
         ywY61YrbP7I4euHPvFVxO0RbSVk02dig/M/7DNvRNFo/JrKfZhKm/Ie542+Gq1GySpY5
         OVGQ==
X-Gm-Message-State: AOJu0Yx7fHjgiGTXprYv9D5ovHLwqyWbHFNj9zqGA0uwmDX7vNq+tGpa
	c40sBS7opb+XA4EnBqbWSlc=
X-Google-Smtp-Source: AGHT+IFxdHfcPQzQtktas7RDIs3jPPIQt+Sat7rXgM4CE095CWUUFUAint5OMH2GuHS//vU5vmWVow==
X-Received: by 2002:a05:600c:538f:b0:40c:78c:f2b0 with SMTP id hg15-20020a05600c538f00b0040c078cf2b0mr11421781wmb.2.1704292626584;
        Wed, 03 Jan 2024 06:37:06 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b0040b37f1079dsm2484925wms.29.2024.01.03.06.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 06:37:06 -0800 (PST)
Message-ID: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
Date: Wed, 3 Jan 2024 15:36:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 0/3] net: gro: reduce extension header parsing
 overhead
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series attempts to reduce the parsing overhead of IPv6 extension
headers in GRO and GSO, by removing extension header specific code and
enabling the frag0 fast path.
 
The following changes were made:
 - Removed some unnecessary HBH conditionals by adding HBH offload
   to inet6_offloads
 - Added a utility function to support frag0 fast path in ipv6_gro_receive
 - Added selftests for IPv6 packets with extension headers in GRO

Richard

v2 -> v3:
 - Removed previously added IPv6 extension header length constant and
   using sizeof(*opth) instead.
 - Removed unnecessary conditional in gro selftest framework
 - v2:
   https://lore.kernel.org/netdev/127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com/

v1 -> v2:
 - Added a minimum IPv6 extension header length constant to make code self
   documenting.
 - Added new selftest which checks that packets with different extension
   header payloads do not coalesce.
 - Added more info in the second commit message regarding the code changes.
 - v1:
   https://lore.kernel.org/netdev/f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com/

Richard Gobert (3):
  net: gso: add HBH extension header offload support
  net: gro: parse ipv6 ext headers without frag0 invalidation
  selftests/net: fix GRO coalesce test and add ext header coalesce tests

 net/ipv6/exthdrs_offload.c        | 11 ++++
 net/ipv6/ip6_offload.c            | 76 +++++++++++++++++--------
 tools/testing/selftests/net/gro.c | 93 +++++++++++++++++++++++++++++--
 3 files changed, 150 insertions(+), 30 deletions(-)

-- 
2.36.1


