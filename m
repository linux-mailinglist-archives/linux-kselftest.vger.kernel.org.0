Return-Path: <linux-kselftest+bounces-48701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742DD107C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54B8830217A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 03:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5530BB84;
	Mon, 12 Jan 2026 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqUgpN5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40530BB97
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188580; cv=none; b=Ik9LZlhsmcqyUsveX+IVj/DbpzBBBAIsMZthu9Peq5VjNRZgCbXX46FUzhfrwmRMEPQ2aOss92Uq/IDqtupcpvH199M2O3TgEtEpKKmWrCEe+ZnQ27JBa7wLe4MsyE89PdLz/qMGkvC9Nt+0XPczpNgwqmvyqCP5BSSaSZMn8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188580; c=relaxed/simple;
	bh=UUdVs8j7VA9m6zvW0rt4/EZwKeh88/gjMVptAIG6e2E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t8lKS0rXiviKXkKNOaZfN/gGOp3K8CFs8tV20nO2x3IMpKX2IhFTV8vyvHXn1LuKglLZTQsv3e7/9nFl+CbLYkZXgNTQYFYMJ8UuNx43f3iui66VAmpEM3WnKTzeZzRTsYbCsTjHcvl22d4pw4CQvBXRKfEbUPcyq+HkmTl6f3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqUgpN5D; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78fb7704cb4so56988497b3.3
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 19:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768188578; x=1768793378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hoNUOG2P22leawShonh5OVWkCNHeP5L5yPB4VezeJw=;
        b=IqUgpN5DmM0i5sdmM3C2qRhMOMdlFGlCNaOIowJjdbU4IB954vEAPrcQ4SEwCeZY1W
         pq6glZGJbEvObx9kOCU3Cygnq1qLGvMoaMqRpi/jP2wztqXO+zOgrEMP3bSx7UuGTkDn
         buSZ2tM3iVavMWzMEF6VwVfJih6vKWCfIBH8RGxAqzY9YQLjeO4MQ8CpshMVzBw+Fmar
         /6/0rGa+N2YuMa3Kats1S3zi1/GwGWDep1q2/Elr4t/XfMWgCm66uQ6frcxbn1owtUg7
         Q0h26gbSaGvQNq5CNw84AcJqqAmdYCLnAqCbTYKB2/R83NR4E0u0zSQsxpA5P6iAUNlw
         PR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768188578; x=1768793378;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hoNUOG2P22leawShonh5OVWkCNHeP5L5yPB4VezeJw=;
        b=MEMl5MHaCeszG7C1MbCt72Yiji8HX6UlHpWv9nDMfv4UUsM5U/jq/Klm+YCyMcKIRL
         FCHb2waIsQc6b1/K1KGUq18VX1M/qh/gQYCNMIB+n+PnCA3jO+etqetOUq+Tw1cqshnl
         zVQgFUn8WtYoJTJphv7rQrqlJ2XC1OlY1dwUr7Q+3zGlYX7/ujfhBVa2D7rMadsLMSqT
         KevZKG2GlKVggF+yBy2Wg1SQbG0AsvJ+rwh1iO9y0Hw0p6VCeGve0E4mIPtaAc3V3f0W
         7/hCCeK7HW9BE6HreyetHrOPsbE06Hti57KXT0TvYl02oNjmtEt7fD1G+aK9u0zJqqXy
         T+hw==
X-Forwarded-Encrypted: i=1; AJvYcCXubzVZlnjd1slf1PBrbwZxp/bKEAFUnzP0ux964fzgmNDzKnU2D5F8FduLwzJbOx1839kPb42w8SF1uJZuu5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjx7NpU5qYYohpv7qXBuaCcmUApHxTXsXefNZ5tMmxmtHc5G80
	DlYXnPt6l8Bqtw820UHNVUWPA3N3nw3Xu5LodwCxpCJ37ec+6KV3/Tn1
X-Gm-Gg: AY/fxX4ZXh2iTi+hx3kY2dPDxQIajXpnnn5+1p51xgQS38WsfPwM0ht6p7d+rsfTQof
	KSzDtH9y4eqo9frGY+Ed06M53l8QbNhcLdHumqUCMHIgD87FyyT05daIIsmP77mbsiFoscyS8cd
	QPpsoaggseVCkOaD3kNNs7uFfO4A9OS0Qaebme0vp2tjx3B8JLspM/hdSw6KeAxpHMIgZNED+ec
	eLcCEknRpJhNlxvya18XyfL61D/7wReKAO+DeqE9YHrqaSyBoE7fO/pK8TFC9lasgRzRhwxC7zw
	U0oN2Xmci7RDmbtt8cXLUpxEk+QFOU2JFmn/2CbSiG0xtzAp3u013tfBSDpHiAEQsyKr85WsjjK
	EjcgqHmWPSxpkeTaYuq01+lf+b/j7xFoyMt4q/3aQNxgzuMpHrvK5LKYYHUgD5Gi/T8IhmTCzsn
	4dqUfFE/qs1P7mzmLMLS/utpxxOKIud7NqYVyOj3k5AiAro48MkIEOZnxtq4I=
X-Google-Smtp-Source: AGHT+IEmPrppbEVxfjylMWJptXyBZbSTaF2447Z9XdxfTQFcxgt5gPHDheeSQ2GIZkCMgGzZ/IrBOQ==
X-Received: by 2002:a05:690c:698e:b0:786:6179:1a47 with SMTP id 00721157ae682-790b57fdfccmr129020517b3.44.1768188578084;
        Sun, 11 Jan 2026 19:29:38 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6a4d00sm65224337b3.41.2026.01.11.19.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:29:37 -0800 (PST)
Date: Sun, 11 Jan 2026 22:29:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>
Message-ID: <willemdebruijn.kernel.e28b1e33bbf@gmail.com>
In-Reply-To: <20260111171658.179286-3-gal@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-3-gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: fix RPS mask handling
 for high CPU numbers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
> 0xfff0, only allowing CPUs 0-3.
> 
> Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
> 0-15.
> 
> Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Should go to net instead of net-next?

Reviewed-by: Willem de Bruijn <willemb@google.com> 

