Return-Path: <linux-kselftest+bounces-27646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF4A46AFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194DB163E7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E523906A;
	Wed, 26 Feb 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtIjqmS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF74239597
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598098; cv=none; b=Hc+DWEC5xmlzswC28yAWsAH0pQju7bEuIjwqQcFGuD/UBMxawY2qlP3+Bw2JqwvGiUf2DaQzYlmCPn6ILybqk7An2VsDtqjLA58aPAApxH1bbGwbpXSK4foHv6CI2+AjeGHh3RMNRLkytapcNG+OvXcfQgZAGWl+8sRFVMOWBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598098; c=relaxed/simple;
	bh=bl9Plq6JnXW74ZZ2OyZkxJ1bQfSDrH+0T8qUb2SbqgY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bdf/UwL1u5Ryw95t6z279GWNyntO0gtyEtEQTfO/bUprTqiwZmSe2X/bNHkjBaMaxo1tk8b0hpoQJKrGJs0ji8Cf4O2v1K0HTnCI6xZt2xLQWnePNXF+yVnFsSHirtEkO74ejr5SttnVSngcbiLJ5kdjbGI18jJtbwEazufYA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtIjqmS6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d8599659so2010895ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598097; x=1741202897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qKg29E18EQ/8K9KKxW0a2f9wLs1Xc02tFARhkKQdFJI=;
        b=JtIjqmS6IYgExDgS6kJWBRzm7hW5KLRv3qNhDdu4R5/AxHzceNro3vmM+Vz9BCpL4t
         Rq5H4ZTpBA+0X5wzNrZdavjmpVQzGFqHl9wk4Ojrs/NpVPY5rfdNxJP6PsR6pwyiw2no
         uujzXnSg94EReU8HPNdl1ZUbjsUIgpFeRYmDN+xHP3cT47gBZhKvuiIrywCdCWMlR/T9
         x9QyacQapqkvSYxVDHXDNZTuBu0NYQuR55OC22xFoX3XA2+FYJFA6hcCexbCKgqVMdnU
         o8t2vGZsfzvhCs10Oh1Vyjhgo+jKenDTysLDNfSDfg+rfjDmt0/qevl64d0ggr7xa7f9
         aRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598097; x=1741202897;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKg29E18EQ/8K9KKxW0a2f9wLs1Xc02tFARhkKQdFJI=;
        b=BfFmRDOQvsuuKHuQGM0sKhTEsAQZXtFsWMzeVfEH4Ne2dgT99TiCIdVdeM5cMdUDCO
         XwpbzW04Hk6n/f2QIt9SrvY74fnoJ0a3u/QrQKqpmRjjYSX1EXp4OMfeKoMu69dzWg30
         RrV8ARx2oVSxc9m7V/BQ3y/TLG1DUty/NZMuxtoUkl20RRA7JUzP+kdwmxZAKY+oyLOZ
         0+xcVEGCl/qDE1ySjPJAxoiN6CPcTTLbiGWApuU220gYVsCrBbT2HJzXy/4mjxujt/iO
         /fY1qztj3tDZTk5L8q/CiinZbHy89p4PIKT0+dHKm65gyapfcjMruB4o+85yqkIcHox4
         7E7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQmHFkaSz+3CeDdBHr5Ot/XroQuqVpv3au7OnYr+cdGfIW/MLfo/pxS2Q39LqpUzjerhdej6Jvpvi+3Bp0xcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GOwvHBdbgC4PdX1bD8AeJPGDajEHvYc6tr3UrgOMKhOIhoMt
	vcGHfLiijntjWq/WpWnyj3eJv6G0R5JI0Z2rAUWAPwvu7TZQsYs1CRznz0fIIqF+2HutLVlJ51n
	rFt6zr3NG
X-Google-Smtp-Source: AGHT+IHKu4c7meNjkGUZE1g8urh4/azLv13+UGEM3NtUkBkRgsExSR+jbSrEuSkHB2KxuBwP29fasZf1vU6dkQ==
X-Received: from pfhj23.prod.google.com ([2002:a62:e917:0:b0:725:1ef3:c075])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8d41:0:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7348bdd0046mr5402845b3a.13.1740598096762;
 Wed, 26 Feb 2025 11:28:16 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:22 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-1-krakauer@google.com>
Subject: [PATCH v2 0/3] selftests/net: deflake GRO tests and fix return value
 and output
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

The GRO selftests can flake and have some confusing behavior. These
changes make the output and return value of GRO behave as expected, then
deflake the tests.

v2:
- Split into multiple commits.
- Reduced napi_defer_hard_irqs to 1.
- Reduced gro_flush_timeout to 100us.
- Fixed comment that wasn't updated.

v1: https://lore.kernel.org/netdev/20250218164555.1955400-1-krakauer@google.com/

Kevin Krakauer (3):
  selftests/net: have `gro.sh -t` return a correct exit code
  selftests/net: only print passing message in GRO tests when tests pass
  selftests/net: deflake GRO tests

 tools/testing/selftests/net/gro.c         | 8 +++++---
 tools/testing/selftests/net/gro.sh        | 7 ++++---
 tools/testing/selftests/net/setup_veth.sh | 3 ++-
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


