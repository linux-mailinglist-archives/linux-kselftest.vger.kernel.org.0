Return-Path: <linux-kselftest+bounces-34126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E23ACAC95
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9683A685E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417231F8751;
	Mon,  2 Jun 2025 10:36:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC221DED5C;
	Mon,  2 Jun 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860613; cv=none; b=fC+vdL4Or4ZBOj9PQshvVWWE8cHFZkCUPwTPR2wdVYFji4gSKGYdG6BpKavaE80au6/r65bcgH9KAO9FgsAWXOdip7JeUoHgK1RWbE7Vo3ojSDvhY+cEYqra/UVW+gjYymIW6QRuE19ps8dHCWNT1W5GZ9cXBNXuCWys7DCwSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860613; c=relaxed/simple;
	bh=Iii/Yj+1tStQr0+EYCTD9JhtDIsq64XtSnizfzrvUYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=msXzwz7fyzkjZsLFYR95rPwWgX9S3Z5vPtQYETwEBb2fme2naNiprLmBkOjPP1xMqYrXnrkMtR5zj7NXXRddlfoPti9WhFzWltGV4t3RT1IuY6bM3/xihulbMg6irxsa3wKXD5RTcrStfGKD5cI1HZ7nkfolm5H4Z6CM48KikOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad51ef2424bso814455366b.0;
        Mon, 02 Jun 2025 03:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860610; x=1749465410;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOvWlqJyIdxb0F+c7ZReClfTkAnCyE8T1KtZuZ09rWA=;
        b=SquxWGodXI0rQOxXAqJ2TipghcuDnKPnjRU8/F6s/hWIym99wyYFMvuSRqS23FcSh1
         HGdRYTh46JuILqoSPpFdp8l5jHNrLwtqJbA2GgT8JFiuyEL3B2BLOUdaIG72I6vzBn9b
         wOT1P/ZnvWBzRk2zgMZcSnJjRm3sh1FpxWcRODtDChsomOS3vjrxhDMh58gnO2fy60VQ
         Y5Y0ul2WHv2HVSIUtI4BrlocQg5vNbqNFIw7+Z5TnTsPigTQt14m82m7E4XK5IBBQUnl
         roddSDmRt6k2xZamZOKgcVro321kl0DsK9U+9oGNbRXY6WfKs66CvI1XlmMCYKkTqRTM
         oU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUTScFPDwu44cZUnVoxdz0r95JQhJ95bKdZKoSrr0KNwYpdMCDP65sTgXeOrwrMpvQ7GcKqH5kq0f2/8Tm0avRz@vger.kernel.org, AJvYcCUUSDEhUPjhOXQGFYlyM/9BJnnvzb2aIpQPBv1/pMMYWzcUG5Org9OGS0TnojF+0BNwUMDMOJW7Z+8NkfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgL4qurHAdnmDJhae0irt5KSAkikFpMM1lgHn0E52J8KX8LtI
	nfVuCIaTVGjmHA9cfXnyMCnHC4dMB5Jz6zts0q3hNpdblejyiy8qiYUpyYKwiQ==
X-Gm-Gg: ASbGncudXjByOrYTjWVdz5SnTN+0b9vJ0ko+FrzKFHCPYGR9Afamy9vZa9v7P8uvval
	MYyZKutDi1xX+14tu18yHjXmcsCJAwgbr1i7FeqbsN19spjlLbcAVT5wDVhYpBtGrIgJ+3u+5FP
	AVQ1+okeBLsaABp//C5UXKG26pkcKbe7skTO3oGVKj6Jtv6mut7TCHG++YloZcT7rbaYEyzquGZ
	3j/phZKTJ1p9HOtR/XrI4ocmGJnkHII32Z/94F+/Zr6d1mwb0BnbaD/1hmE8yL0ZpJg+isy58fg
	vpB+3Pjo1VqqzoHCDcYc/n7xtPMER2YiFIENKo89X+I=
X-Google-Smtp-Source: AGHT+IFqrSsK8DY8V7dpy2QWJnivCTTR1nffZQDrcCO1vwDrUr8YD0Tyd2L3H6BOPP2E8rlS+6MgwQ==
X-Received: by 2002:a17:907:7f94:b0:ad5:557b:c369 with SMTP id a640c23a62f3a-adb494e5db8mr823445366b.33.1748860609305;
        Mon, 02 Jun 2025 03:36:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82ef07sm781166166b.69.2025.06.02.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:36:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/4] netconsole: Optimize console registration
 and improve testing
Date: Mon, 02 Jun 2025 03:34:40 -0700
Message-Id: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEB+PWgC/23NSwqDMBRG4a2Ef2xKEnyPuo8iJepV7+SmJEEs4
 t4Ljjs+8J0TiSJTQq9ORNo5cRD0yhUK0+ZlJc0zegVnXGUq12qhPAVJbzqyrhrXta623UgehcI
 n0sLHrb0glLXQkTEUChunHOL33uz27n/F3Wqr625pLJWmJGOeM43s5RHiiuG6rh8g3lNgsQAAA
 A==
X-Change-ID: 20250528-netcons_ext-572982619bea
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=leitao@debian.org;
 h=from:subject:message-id; bh=Iii/Yj+1tStQr0+EYCTD9JhtDIsq64XtSnizfzrvUYY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoPX6/XCo3OGp0efr+CfY3n2LxrS9VH9qlf6pd6
 vzJTtkLITaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaD1+vwAKCRA1o5Of/Hh3
 bTRED/9FNDpQXJQZFpIM6d8twxfbI14m6eLbFhZcbuYmAY9jfqOVzEt9hR3yy3msK24qedtwrcE
 MbL5oNbemOnQJ+L+TQ7dXi0Vv+vLuvQatDn3vMJu1jVlNzhVh27uICk8o4dRKScpFRcM0fiZlNE
 zEHylAkhPiY0zF5kd5jqWAh6pPxfP49UEbscwRFT2d9FtqfDOROZBM/twJG7bOnuaHvsGt/v1Sg
 73jzVeoHsYHNbNpfGeCM4y5NhVgVPgfqJL9mS7ctKk1NK9N3BF2QcT0lOCUxQEIjCn4hpBC1+8s
 zjDRzm/aAWPdYvipQhFPKIt1Gp6V9DYYACHB5p8qus6ePsq/SS5f40LqSnEw2e6Flv6cHoJPoJu
 DC0JVs/yBo8nEAew06loItGrhP2JO371QtOniyGlYg0IpXgre3erm6D7TJt+9YgsHBX33DDJvX0
 v+EJOCANYkK08zpVwff9HxojfEDUEW2VjZ7mRPtk17jujo2VHnV7gRayfEGOEIpsDIg0TPpXzd/
 uEeOGMMwWN4xX6eUdSYALfNQxRTydVTRM7Czy+ER/yFa2lmumtdhlykQCQE+7ZOmEbA7E408lZ+
 5FgIndLqDVHVnI8uwRotrmvzQkzQKiiq8qREuxUFHMjcti37V8XOcSFFnT9YgFN8qh+9AYn7Q/l
 VfN4KeLASj4NrYw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

During performance analysis of console subsystem latency, I discovered that
netconsole registers console handlers even when no active targets exist.
These orphaned console handlers are invoked on every printk() call, get
the lock, iterate through empty target lists, and consume CPU cycles
without performing any useful work.

This patch series addresses the inefficiency by:

1. Implementing dynamic console registration/unregistration based on target
   availability, ensuring console handlers are only active when needed
2. Adding automatic cleanup of unused console registrations when targets
   are disabled or removed
3. Extending the selftest suite to cover non-extended console format,
   which was previously untested

The optimization reduces printk() overhead by eliminating unnecessary
function calls and list traversals when netconsole targets are not
configured, improving overall system performance during heavy logging
scenarios.

---
Changes in v2:
- Added selftests to test the new mechanism
- Unregister the console if the last target got disabled
- Sending to net-next instead of net (Jakub)
- Link to v1: https://lore.kernel.org/r/20250528-netcons_ext-v1-1-69f71e404e00@debian.org

---
Breno Leitao (4):
      netconsole: Only register console drivers when targets are configured
      netconsole: Add automatic console unregistration on target removal
      selftests: netconsole: Do not exit from inside the validation function
      selftests: netconsole: Add support for basic netconsole target format

 drivers/net/netconsole.c                           | 61 +++++++++++++++++++---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 27 ++++++++--
 .../testing/selftests/drivers/net/netcons_basic.sh | 50 +++++++++++-------
 3 files changed, 107 insertions(+), 31 deletions(-)
---
base-commit: 914873bc7df913db988284876c16257e6ab772c6
change-id: 20250528-netcons_ext-572982619bea

Best regards,
-- 
Breno Leitao <leitao@debian.org>


