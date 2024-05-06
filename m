Return-Path: <linux-kselftest+bounces-9510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA248BCAC7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE2B23113
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACF14262B;
	Mon,  6 May 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuNrdVqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA11422DF;
	Mon,  6 May 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988192; cv=none; b=MbOZu82Ij108xGZ8dthr7ccjslVZCl58b2XFbldSLzCpY0sGlh56m4gqX+3xM1YunmGGV2c+I0QEdU+n4ldJAdOnuG7+junCn/rMxsw0PLUYZBYALtCD70Mr86w8HegDZCn48qXVLbYpdSDJAsRWXOVmv+4HXd2m5uStmv2cue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988192; c=relaxed/simple;
	bh=7R8HvbMKxhvQTD+6WjeeyIDykaL5AbTSf5Sm3F3g0MI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AUZjCUfAn8QZ1QVmOo7BrOqcDw+zFNFXfb8DYLvsVhfCpUXBcDSY23o7Vhm5sBsclOHX7kcyGI4CQJRNy/rZxNP73vkd1YIzOj5mSZlayu2aW2Ea0HmRbYh7y949JmUDo4X09a95+98CGTcl7ALGg3Csc4oB5/LjvQBmlh0NoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuNrdVqT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34dc9065606so876781f8f.1;
        Mon, 06 May 2024 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988189; x=1715592989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFC6StoIxDlALEXd4nLUmHSyf9IY2MMtGBaOD7tAdoQ=;
        b=AuNrdVqT2UmBFWV0VaJLAudIHJ70EEfhZ2ElqRSmC3mAi0ItloQVDDDZ5lPv7/j0ZQ
         FpxXhLy25ioz8ZMCua+6oGWfrZkq410waAtf8SWCSLqaFkhmjyQDG5Yc71Z73ncUnut4
         YlM5MZortfqceTl6h0uJPV/ndquTjaHJWg9pJZwcxGvGnGRSWqvDTA17FhwrwGr7K94i
         2c9LK9RcP6y1BaEPqS3Dzt98xCj2zoIGY2A5S2d7e1FiNzuBB6RswfkyGz+2CJqg93qe
         LnqCHLMupeOCN7etatDtNZqMkSRSApjf11ojmeLl3r9OAlZfhlDtKBYqlkl5vSwV/Z09
         IvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988189; x=1715592989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFC6StoIxDlALEXd4nLUmHSyf9IY2MMtGBaOD7tAdoQ=;
        b=e5mdci64GvQWC+2wJpNE7JzpQsXpMRbe/+2y+imXpW62FTRyJDuc5/kqkJD4Q7bLom
         yjpP4DFlzWA1ScyC0Hz+wCMJ3hh1tLV8r4LPIxq/GQksr0pD8e71fgi5Hy2Sw71MteX1
         wFDlX0CPrhXjdxZtb8jDEx+L1VxzTGoFBdIc22aSy2Rz3zp5GmvGd98tNmaao/Dmzd87
         MV+z9GIlxdhXUSMdGB6qIDvKpncrh7AszAzvgNpPSs2evwSauDYL15yk+8JPYraFIWzt
         OgXfugkI1qFHvL/xE6DCPUXF4wz2max+2CdBHCnKkM2FjBjCR3ZiwTeUkHF15WrS4IW7
         e0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXSBgnqsjIGjjV2xbugysKY2zojw2cFIiBq/Z+kh0JSEBSrBV0TXoC74E2z5RSJl0zI2N/ejy3egl9C1dX8bWc3bmARoMzoCJc6VQKvi9YL9sWYg6XAzbVB0NRZVsnEKLuEVuEHvzstSQ61CoTkqPrcYf0EMHb8lP6gwzPsRWBbp1hCd0dW
X-Gm-Message-State: AOJu0YySFE6y6BQlCOJ+GSQ9wdqN9F3xPEBp605TgnDvJHeTsiZbzBrm
	ZhLHDw5iUii8BUhnZv7r0K1YlFtauZB8AHDFh86lgc5G5+t1cXld
X-Google-Smtp-Source: AGHT+IGjIrpDBGch+to3JaV8LBAuxxB2Ga3LtyGnnPAJ2JlqrZq8rCBohLuC0CT4tqUcS/qjLx2jlA==
X-Received: by 2002:adf:b186:0:b0:34a:6fac:6dab with SMTP id q6-20020adfb186000000b0034a6fac6dabmr11603134wra.12.1714988189159;
        Mon, 06 May 2024 02:36:29 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0041b434e5869sm19100938wmq.43.2024.05.06.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:36:28 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	alobakin@pm.me,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v8 0/3] net: gro: remove network_header use, move p->{flush/flush_id} calculations to L4
Date: Mon,  6 May 2024 11:35:47 +0200
Message-Id: <20240506093550.128210-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cb fields network_offset and inner_network_offset are used instead of
skb->network_header throughout GRO.

These fields are then leveraged in the next commit to remove flush_id state
from napi_gro_cb, and stateful code in {ipv6,inet}_gro_receive which may be
unnecessarily complicated due to encapsulation support in GRO. These fields
are checked in L4 instead.

3rd patch adds tests for different flush_id flows in GRO.

v7 -> v8:
 - Remove network_header use in gro
 - Re-send commits after the dependent patch to net was applied
 - v7:
   https://lore.kernel.org/all/20240412155533.115507-1-richardbgobert@gmail.com/

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
  net: gro: use cb instead of skb->network_header
  net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
  selftests/net: add flush id selftests

 include/net/gro.h                 |  75 +++++++++++++--
 net/core/gro.c                    |   3 -
 net/ipv4/af_inet.c                |  45 +--------
 net/ipv4/tcp_offload.c            |  18 +---
 net/ipv4/udp_offload.c            |  10 +-
 net/ipv6/ip6_offload.c            |  16 +---
 net/ipv6/tcpv6_offload.c          |   3 +-
 tools/testing/selftests/net/gro.c | 147 ++++++++++++++++++++++++++++++
 8 files changed, 225 insertions(+), 92 deletions(-)

-- 
2.36.1


