Return-Path: <linux-kselftest+bounces-48151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E59CFCF1830
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 01:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9F23019B76
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 00:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C51A08AF;
	Mon,  5 Jan 2026 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfOPCdJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168F19E839
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572979; cv=none; b=sDXGB53iqw07E1qZO9Wn/fuP+W/PMC3mILnLN1urVm85egyL6ZXuZzb5Iupj4aeyZWPHoG/XWDPnbJMrD8s5ofwvzpJal/qU62h5IyocuNNXD6fG0hjBOR0Qdn9jNqXfZXVwlAxpGBqYPiBgdj5SapFlmAkPPT3Q9oiTPPF6js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572979; c=relaxed/simple;
	bh=R7k14VC3vVWz5wUwTkk93NrVOWEgkpo5zchT4ujK+c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxFJfZJDU13UHuPJzz+phfdH+45PaxkIeFmi+Rc09udMndQkRaGiorCeYePyLAxh89Zu2VP6cZBCe2bXcfjgh4aBGwZUgUHoZJQN1JmdWm7LXynhJC4AVgN9ZhrmtIBoxjBoUW5Jk4+11529aizqd34ItUzo7Hex1VbMZhc1JnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfOPCdJg; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c1cf2f0523eso9442969a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572977; x=1768177777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uO23YZhHNP6Na8oKr9lYMioRYmvDQ+E4qMSAXH4O1T4=;
        b=kfOPCdJgdjwRZ2sm/cLo+9rzdZQKGq0EtAfZ4j51CSoNDUhT+vg9QHlzfIYg7BXh5h
         Kknm1Ge360FVsE9ybdxovMZ5V6iN8dqSYJ+pMD2Vvc9ZQVJkCUy59GpeYVFrB+oh2L/E
         PmFQAg68rReXvYIWLbrfXl0MyllKYgRUnsmubAdLgS5hvd6bqHijhBKBDioDXaED9rPY
         t/tRKF77bJz66GY0QF136vRDAABPIzYpVU8T0uYe8JleDc/kCE9pW5JaMkzblHhvOwb0
         lLFOp6w5qdX8Fcs85SQPw9ZlwGnDoK6oDZt6cAD6LbrzdmPbld1OQTpJcp3R4nUBVykI
         07jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572977; x=1768177777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO23YZhHNP6Na8oKr9lYMioRYmvDQ+E4qMSAXH4O1T4=;
        b=b4aBa/APP+satjF5U0WdSS630/OSzK6wVQxoMgsZ192kQOPw5xy4fg4N/7uOCXz8q8
         SDNucqPt4VcXJyBvD0kylIbZKhWGp5m9ZVFKJwVS/HSfOE3MiRtUWlrUFoyoIwhnhYt8
         qCnhtY15JSgbRXPAvUNip9PI+pWRh08lhFG0s8dMFebHVF2zwaPrbo2mNwLvkl9FB2kk
         OZEmFM6zCBxcyTGKoQjZzMT1IYLpv+G7ltNmGBsXACPWmVtBkfQfgCEb3iPOQLCEHqe6
         ECKLOp14egrzyP4LuiTLtuG+iZu0tvcBtVuNZn17qjmYn40Nes7JOYtC87URR2boBKRm
         2S5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt4c4dOWAWZaCq/8iwzlOr/nx4BQa+MuYsr93qeB6WWd87yoJ8YbldBfQsHNSquw6x9BpgqY/VEV4QmX47Pcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyFg8FhallRp5veRgZwVySMKwPaoFPSA+bXf25xFr/5eDfH2Y
	UL30kjS1SJ/rxeL/m8OyvBO7rkq9im5Jr87wpwkt00RT8J3U7Eip1HF9
X-Gm-Gg: AY/fxX5f+zJW5mtJkPS9YWjxsc3nS9TO7nQPWy0K9q1KNbqvJsXdGTsPrfEXHRD2ix7
	XOQtJXmp2LrUGfxqC8h+7j6+orTO2mNCkwW1GCXCbaHIQl2bSyOy7eRht+t2pf9ZqXf+/zUye/L
	bt526pf/yj+efxF6qKGGfD1fRilsNb8db1TMLdRZ5GxgGf4fj/t0COUATKOU2AFRmIk7MA4n4zj
	rSRHhuo3FpXBZKpXrtIsMJDKvu/aSJzBFceDwqSnc+/A23KEjU9ispnjk4B6B2Ay242YDkj3kfH
	jaNgcNPqVMMTEOZcyuyBnCUGlxMsjUP/wOheMhRT1f17GLCC6qEZ9g3JKuUTVMsWVHQr28EkUQ0
	d+3JbbnXuzE0SnlOSB4UuNHvFvIGKBlUAasSo5CiYiiAPP14OAslrwfJvJnhMT875trx9gd9gXi
	JmRH25sxXAOA==
X-Google-Smtp-Source: AGHT+IEFj/onAwnN6q7XitBIyXARl7Pt43J0EpL/HG5gSDcAd1q+FPGbMbIICB6wr8OHnl12SpH5kA==
X-Received: by 2002:a05:7300:d208:b0:2a4:5005:7ee1 with SMTP id 5a478bee46e88-2b05ecabd4emr35873438eec.37.1767572976876;
        Sun, 04 Jan 2026 16:29:36 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc2:1ca0:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e7esm9441947eec.22.2026.01.04.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:29:36 -0800 (PST)
Date: Mon, 5 Jan 2026 00:29:29 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 5/6] netconsole: resume previously
 deactivated target
Message-ID: <aVsD1Vuckt_9Tr7E@archlinux>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
 <20260104-netcons-retrigger-v9-5-38aa643d2283@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104-netcons-retrigger-v9-5-38aa643d2283@gmail.com>

On Sun, Jan 04, 2026 at 06:41:15PM +0000, Andre Carvalho wrote:
> +static void process_resume_target(struct work_struct *work)
> +{
> +	struct netconsole_target *nt =
> +		container_of(work, struct netconsole_target, resume_wq);
> +	unsigned long flags;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);

This ended up causing build failures in CI as it needs to be guarded by
ifdef for CONFIG_NETCONSOLE_DYNAMIC. Unfortunately, this was always set on my
local tests - will fix that as well.

Sorry for the noise in the CI. Will fix this in v10.

> @@ -1945,6 +2022,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
>  /* Cleanup netpoll for given target (from boot/module param) and free it */
>  static void free_param_target(struct netconsole_target *nt)
>  {
> +	cancel_work_sync(&nt->resume_wq);
>  	netpoll_cleanup(&nt->np);

Will also address the AI Review[1], which seems to indicate a potential use-after-free
when a dynamic target gets removes (and disabled) while resume_wq has some pending
work. I think this might be a true positive and I'll see if also canceling the work
on netconsole_target_release() makes sense.

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=ca5cba91-a1a6-4240-bf10-e4da9c5bc58a

-- 
Andre Carvalho

