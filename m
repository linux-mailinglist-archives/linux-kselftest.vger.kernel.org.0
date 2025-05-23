Return-Path: <linux-kselftest+bounces-33692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966EAAC2C03
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48A37B84A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA7220F4B;
	Fri, 23 May 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Ak0UH5a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766021FF36
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041539; cv=none; b=Whg+oYD6jqdB4aqmX/e5gDe1Ad/q6XrZ/KfuXUc079CvQmu1JlcHXxhm2Owt26IdFv0kekRIA8pGP0TG8F4ptJVKe0ZHRyDuibQIQ5Uob29jdKf6Vv1hj2KVuvaOEwIH9+i30JL2Wrer9agvwQb8vOx1TLrQPJ8ZaVBBVGUtwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041539; c=relaxed/simple;
	bh=SIJBs96ZP3TjrQVbKdqlUnzxUYhpJqa8IzMH0N3Au9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fM/lUJKpy343p+s4nYNedzTGw5yF/Kvr0PZPF7HEU6/iMNM2peY/tOINlxB/upLAXuo7dsT1GxPxCkdBhMOjPS9yc9+2Sc2Ow8EFw9g1hMis6V1ljES4web9lFsO6ZdJC5XE8Ocytg+b/VIYF2vBiFsJ13kvq2t8104tIOf62yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Ak0UH5a; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742b6705a52so685594b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041537; x=1748646337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq3MiSoN85Fd7+UjYw33GE3Gx+T8lZk2tdUUfBjVWzU=;
        b=2Ak0UH5aep5LFN+ctDLa5d3tgrBGVz55INoZ1p9FPO7DINx2MjVpqiClKGvFr07m3X
         sK6zNas/j/JZwlUzElyWqz977wGiVqJZy7B7wG/g35ntFojcacHEk5qWo1TqX7I8Mn48
         squUp6r0HLI28vaE9rsl2CWfskxiy6SgHtyUdvGQ0Y6LFGkEgoUY3igESaki6OBG5Mzd
         pujJOKAnRn6KDkNUrjGglgmAWi1wQCupWNhzZbRc5qceOcTH4WXf/T3R1DSGBLKsFWrL
         ipp+8gFZfIM5i5rUamkWnoavpuP8SbigsEMXGz57NZV8rodprywfr4GitH1DwXojtPmF
         7BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041537; x=1748646337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq3MiSoN85Fd7+UjYw33GE3Gx+T8lZk2tdUUfBjVWzU=;
        b=XpW3nI00M2l6izZD4z5reFljuCj3AhSSvThAMWr9XhLZzOTyDjf2XRlglKCRfJE+8T
         IptKAQt48zAaew0u0iqFIK2TTVhwWtgOfg/zueXoDWJtcEYCic41skl/gC5uw85IcwZ5
         ETi70z4HiY73j7XulKUF8uDXU5yaGTaLDrmMMlbyiXGye2Bwj5suBiStS9XiHrrsHf/u
         c5NVixi49T69YnFg0pqcxDcEkQMiln+NyC+CZ8xBWxKVNGuWip/u/7EAdRWy00lMfbow
         6xxVZKmPmgaV+ZQ/O+gzxcd8vO10rgzqsMBFd+QfdzdPMKKtSqu1IQ3Q68Q2623KRnUe
         aDPg==
X-Forwarded-Encrypted: i=1; AJvYcCVksQSFkvcUvPQN4n0FuGH0DHsfsrSbVVnL+mWUSHXREpNR0IG7HSfsOrQwNU0Viny0M7aNSzp2x1DbSng8bjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTl8XCMlO8JoEUY6RG3ySE0K9GZETL8FPM/Y4N//0XYnIsHSr
	it4x/F3GrI9VVE5+zoasj8GG6OwksFrUI3+cy4SJaobeiovocdKppwONRK43jz5Q1V6Bfstmqrt
	yTeWFOOX26jZ3/QvnYUGTDLdpVw==
X-Google-Smtp-Source: AGHT+IG51r7w5vVd7tKoIq/pEiL9OrbNLMGxS3kuiPEdD1pFnzFqPLxgz+6QVaSF58OZ1dsgx5z5OO52eQLnZEtFAw==
X-Received: from pfht14.prod.google.com ([2002:a62:ea0e:0:b0:73b:bbec:17e9])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c6cb:b0:1f5:9175:2596 with SMTP id adf61e73a8af0-2188c24060bmr1641078637.13.1748041537083;
 Fri, 23 May 2025 16:05:37 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:21 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-6-almasrymina@google.com>
Subject: [PATCH net-next v2 5/8] net: devmem: ksft: add exit_wait to make rx
 test pass
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

This exit_wait seems necessary to make the rx side test pass for me.
I think this is just missed from the original test add patch. Add it now.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---
 tools/testing/selftests/drivers/net/hw/devmem.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 9b3e2c78f457..6effb9e33fd8 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -26,7 +26,7 @@ def check_rx(cfg) -> None:
     port = rand_port()
     listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port}"
 
-    with bkg(listen_cmd) as ncdevmem:
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
         cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port}", host=cfg.remote, shell=True)
 
-- 
2.49.0.1151.ga128411c76-goog


