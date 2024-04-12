Return-Path: <linux-kselftest+bounces-7811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352528A32E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68331F21BCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A71487F6;
	Fri, 12 Apr 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7kc4ROG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51185C52;
	Fri, 12 Apr 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937375; cv=none; b=AXLy5DhROhPXJpWyVsbCECRq42E5X96pPe8oEyKIaYrMTVGDMcXqNDfUHEhNjj5L8uDLjQAgycM46RpJpi8B1YrbDuPLO+feCnTmCNorprGk2Ug6PoaKE0JhN4NgDKjUVBnCajsTy9UHVimI0wmnn0iajJ9Bm4YyNPQQSFI/Wy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937375; c=relaxed/simple;
	bh=CWM8g/CIXJwPdo9qYSKWaUiBcAlUs3ZXqGZC+yTCa5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LoA4KUqPAQe4lOxseKwvERgI2zJy8DFqk96JYLqUqLakJeftOsikid4sxaelqxi6G9MSsB1FpyLkC2XSJ0rsrrVca6G/13qXAiD3OMZ8QLiOFGTnM6vsTmOESEc/U6e9NRT8yFCR5iWZ3KNx7/bZgFTT6TGqqdZnb3AE7rjEmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7kc4ROG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346c5b83c6eso747887f8f.3;
        Fri, 12 Apr 2024 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712937372; x=1713542172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bu3sEbh7xedZD3Kgac/kjn7z9acHHxetUgBU6xP5gBk=;
        b=O7kc4ROGEYg67sIB6T1RO3jx0uqug31DS8ZHBPOK3gPtRRteMWJ95uskqGFkYBo+sk
         bVIzTD/vUymr313pjtaG2fuJS8fKtxbWrItJpGJ1XdHDTd7pZ5HfPzwSBOTYqrT1lMED
         P1NI8baDPTe6COhtsf0UYI3mlrRBCf4iJbIUsBlF5A+mkb+VvaWbKdaWLaqvLKehNlct
         ORwvOQilqoeqDWIy5qERp/OGfEW/NIwm9wxL4Ow0XU+u/50icqM+RvH0M8ft4tIz4ErN
         oJfI4YStlicGhXcnlaib/ZdWY2kq6WlFmoH9RXe+2sbp67sVw1JY5R0ToM4KCmLx1Qmz
         alng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937372; x=1713542172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu3sEbh7xedZD3Kgac/kjn7z9acHHxetUgBU6xP5gBk=;
        b=uc3XNVmyY/o8RYQdJnZhX8LxAPuPCZ8/ePaU1NdFErSeDENCiMaJsKUhtlOfj6BP1f
         WKJU2lHL637z2J5bCJ5n2T8fKUzdaDG9sokP+HE0CKArUTlZKkPzcBPRdqhDKhtGK8n5
         Zo2LpqMp1q/tRiCaTD+ncWg6y5vR9LYClij7SgWraBaftvDgJcLS2LNNRWDhnsD22oIs
         c2rXVMGuMdioLM3gv9g//fkXoJAQOSt5+nc5fullgPh7ZC6/RrTQnvCpIOqu8TuQudzA
         ceyz6gkwXbgcqmamtB5wbl57k+asSOhTFw8+ABcgSXKSY5CMCbAnCsUfzrf+/jjja94N
         VVSA==
X-Forwarded-Encrypted: i=1; AJvYcCVPZX54MnYtyA/a8n6j84bkFY11aEC7LF3kPurOdvh5aV4vpfHHrOcpbKYe8BeNmmkKBtKWu987hqqAYzi37n8wtuS3+ilPXaa724b9XKoqnuScNAPoPRPdHPB1fnVJnq69EXNHNt/2CEL/yFxafx4GMrK70GmHmZnOqlAr6PRVOqiCEaDW
X-Gm-Message-State: AOJu0YyaKJqmQbJfqkz/pQRH+y/H94R6xo3yWeJNT9JD/MmgBQo1NuDV
	lpbQq1z+UcW8W1cYq3iyZNPW2KvaA4GYJ8WHH+BYScwlNYJIPdZJ
X-Google-Smtp-Source: AGHT+IF+kNepTzS+vyTA9aIEN4ndFMTXuXLMJP9SGHegD9ZH5zdAnPQ+knsC5bFPi9ZuJ46WKzxUOg==
X-Received: by 2002:adf:f38f:0:b0:341:d833:1f7c with SMTP id m15-20020adff38f000000b00341d8331f7cmr1793215wro.70.1712937371803;
        Fri, 12 Apr 2024 08:56:11 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d5388000000b0034335f13570sm4550663wrv.116.2024.04.12.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:56:11 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v7 0/3] net: gro: move p->{flush/flush_id} calculations to L4
Date: Fri, 12 Apr 2024 17:55:30 +0200
Message-Id: <20240412155533.115507-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series depends on commits in the series submitted to net.
(https://lore.kernel.org/netdev/20240412152120.115067-1-richardbgobert@gmail.com/)

The fields network_offset and inner_network_offset are added to
napi_gro_cb, and are both set during the receive phase of GRO. This is then
leveraged in the next commit to remove flush_id state from napi_gro_cb, and
stateful code in {ipv6,inet}_gro_receive which may be unnecessarily
complicated due to encapsulation support in GRO.

3rd patch adds tests for different flush_id flows in GRO.

v6 -> v7:
 - Moved bug fixes to a separate submission in net
 - Added UDP fwd benchmark
 - v6:
   https://lore.kernel.org/all/20240410153423.107381-1-richardbgobert@gmail.com/

v5 -> v6:
 - Write inner_network_offset in vxlan and geneve
 - Ignore is_atomic when DF=0
 - v5:
   https://lore.kernel.org/all/20240408141720.98832-1-richardbgobert@gmail.com/

v4 -> v5:
 - Add 1st commit - flush id checks in udp_gro_receive segment which can be
   backported by itself
 - Add TCP measurements for the 5th commit
 - Add flush id tests to ensure flush id logic is preserved in GRO
 - Simplify gro_inet_flush by removing a branch
 - v4:
   https://lore.kernel.org/all/202420325182543.87683-1-richardbgobert@gmail.com/

v3 -> v4:
 - Fix code comment and commit message typos
 - v3:
   https://lore.kernel.org/all/f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com/

v2 -> v3:
 - Use napi_gro_cb instead of skb->{offset}
 - v2:
   https://lore.kernel.org/all/2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com/

v1 -> v2:
 - Pass p_off in *_gro_complete to fix UDP bug
 - Remove more conditionals and memory fetches from inet_gro_flush
 - v1:
   https://lore.kernel.org/netdev/e1d22505-c5f8-4c02-a997-64248480338b@gmail.com/

Richard Gobert (3):
  net: gro: add {inner_}network_offset to napi_gro_cb
  net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
  selftests/net: add flush id selftests

 drivers/net/geneve.c              |   1 +
 drivers/net/vxlan/vxlan_core.c    |   1 +
 include/net/gro.h                 |  82 +++++++++++++++--
 net/8021q/vlan_core.c             |   2 +
 net/core/gro.c                    |   5 +-
 net/ethernet/eth.c                |   1 +
 net/ipv4/af_inet.c                |  46 +---------
 net/ipv4/gre_offload.c            |   1 +
 net/ipv4/tcp_offload.c            |  15 +---
 net/ipv4/udp_offload.c            |  16 +---
 net/ipv6/ip6_offload.c            |  19 +---
 tools/testing/selftests/net/gro.c | 144 ++++++++++++++++++++++++++++++
 12 files changed, 238 insertions(+), 95 deletions(-)

-- 
2.36.1


