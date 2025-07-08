Return-Path: <linux-kselftest+bounces-36742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E3AFC110
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 04:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE15716A248
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392D226CFE;
	Tue,  8 Jul 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM5vCsSP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0A225A32;
	Tue,  8 Jul 2025 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943395; cv=none; b=IXhdAN4ZVc6lsFfne2GhNyBB8EI90LFTsO/BsIj+hppc9HnnZi0BZiBMLEefIkwEx6U/gt66bsp9ivKEfpgR2JLhaGGBzMDjw3xjvO6KnGzMS9l5LkyJF2g/x6Oy2/NXpEeMxUEM/lPDsWZlBPpTSevGNyaL18jctBBijoQSMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943395; c=relaxed/simple;
	bh=9ZTeoXsYlOG2Lm0VDPZA1m20VzIMr7P1sL3fBI04xvc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KL+ktN130lKiBOGpWmpoV9dgfSqm11PobqisXG3X28hbnMCqVzAOW8CcIBkfrKVp8rBO+BqlH+o3p+stX4yddFasHEGfJr9xslaFPFXCPAA/mIGw/6X8RBB8l+Wa7YVo0M08ddybzWwvrNJ4ih7q0lMJrqHePPiJnqSkfhg6gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM5vCsSP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71173646662so34141137b3.2;
        Mon, 07 Jul 2025 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751943393; x=1752548193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxMX/xJxzy2hJc4qqxOWGP0PpMg37pMea6Q0wamjJr4=;
        b=LM5vCsSPmnyZHrq4BZZ/luJ2EnIijsk0T9o1NxuEkDs6ux+THXDsf+t/0JnaX4Qvdu
         0Qlih3bCUqrOk4ojA57Ll7szbuL1s9qXhju106dMYhAxrzOe6TZWpiJWWdbrEnm7vWjp
         yWBIOX/W12VwgZ1ZyrfliHFWiMeqLww0Ac4VWcOmWDqOy+e3khQyG0YCcTOvblhnCvXa
         bXvk5LVILh3PQD9VL9Bq2J7ZJAmGx7bvAVuQENV5mvnZp9UeKwMurkMxjRzPd3561ANM
         1oxcvrLEXKDKxHCSpe9wcd2IGToaNLHb+miRRpqhupcF7Lr4rQaynrl5ljbt3QjR/dAb
         e9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751943393; x=1752548193;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JxMX/xJxzy2hJc4qqxOWGP0PpMg37pMea6Q0wamjJr4=;
        b=Ll0bEANr+sWq1NAhRUI7iYpZH0zmM1vABs/xvR2yvEztKVTtkSRBLmcqP+TS5rdv2r
         9z2k3KPJ6K17WA8w//FdtJ+8d5JqOCsnaAK6GFjgL+ytcLy5ldrfz/I3W3FHCiU7EBld
         kYBe/1GkBPKzVowBGi3mfjzZ/iUrU92tDU93YZn0n5BtrIv5D7I8aQtDjExscWnVMEwc
         VrjDFbFgzP8HKyPKSmEWjg2Mn2dBAiXyOud7BJM0AKNDRJ982fYwxIGDrSYHnDBEPRy6
         i1lhWiTlWeQw91JQ+oBljYhBOkCgdGksq+X/PkcxSVPAj0vae5s95VFvMxRqE0nPV0PZ
         FTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUBkzGt3quxaFMlVYC89rFAmDZxDk9eULhvHUnvotAIqjl0RE/Vztjql8oBHMrS7BujUAOL31SL4PUWCfyuc+aY@vger.kernel.org, AJvYcCUjSfR9UibUF3dne5mHvgoQejmgW+5A2zhoLBPByJsXv+IK/0YB7iJ+7bJ37T+VMgFhxq0=@vger.kernel.org, AJvYcCXmiIxTlZGp/PbaKxshKhZFzLnQM4eqLspZ7xkmXVVJz39gIdD643P/dqueLNRPmTcA5BnNyuT5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75w5sG3YVdAY98MslUcaF4nUb3pZEeC+zqCD1B8jmyG7x8F9z
	Rz5N4078VzjGTS0XGgA90W6FkHtpgy5Cm/Dv5gjTk7S7+iRbGiJT9wUm
X-Gm-Gg: ASbGncvZ/SZprGWOxYITDxIz2VTQMezaZwc3iM6S0h1mMW6uo5lnvNAet+KijjQrIgW
	aA5+JlnYM05D4Zrx30zGa9ycIi9K0PlNQRaoxfecga8kwhhXWdcTUBcfIjGqqCRwmX0KeGYCiun
	sQbPVq5PJbIxTj4oAnQ8ZPWYWamqTg+iiDOOFIMmsmoSONWHMfDam9JFf6Ozxfsl1dbLIOPAlTq
	97RJR8PHUHFV749I6jcUPIoVDK5H3qN/tmgIn+15qpOWGab1C5VD05I2uGR20CYp/nrMQo3ieui
	eUkvzUeQSmSBfYRMDv1XNaEvutDR7Ksn48Zmj3yWoZnPdjfxaFMJ/QRo20zOJqHIpZVnLOXp2Ds
	KH32vGmbLjuTZL9DlrxSCOCV+ml6rKZ7SzvXVQkE=
X-Google-Smtp-Source: AGHT+IGbyc1ivKnu4Md1jd3PRtXFprZzrt10RDAYU25UxhegDOAebXcSzzdd+a4hHyIKQsluIr5PFw==
X-Received: by 2002:a05:690c:7012:b0:714:268:a9f8 with SMTP id 00721157ae682-71668e22b3fmr206639087b3.27.1751943393255;
        Mon, 07 Jul 2025 19:56:33 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-716659a1440sm19459037b3.35.2025.07.07.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 19:56:32 -0700 (PDT)
Date: Mon, 07 Jul 2025 22:56:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf@vger.kernel.org, 
 kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
Message-ID: <686c88e0283_29b0d29422@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702-netpoll_test-v4-3-cec227e85639@debian.org>
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-3-cec227e85639@debian.org>
Subject: Re: [PATCH net-next v4 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Add a basic selftest for the netpoll polling mechanism, specifically
> targeting the netpoll poll() side.
> 
> The test creates a scenario where network transmission is running at
> maximum speed, and netpoll needs to poll the NIC. This is achieved by:
> 
>   1. Configuring a single RX/TX queue to create contention
>   2. Generating background traffic to saturate the interface
>   3. Sending netconsole messages to trigger netpoll polling
>   4. Using dynamic netconsole targets via configfs
>   5. Delete and create new netconsole targets after some messages
>   6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
>      called
>   7. If bpftrace exists and netpoll_poll_dev() was called, stop.
> 
> The test validates a critical netpoll code path by monitoring traffic
> flow and ensuring netpoll_poll_dev() is called when the normal TX path
> is blocked.
> 
> This addresses a gap in netpoll test coverage for a path that is
> tricky for the network stack.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> +def test_netpoll(cfg: NetDrvEpEnv) -> None:
> +    """
> +    Test netpoll by sending traffic to the interface and then sending
> +    netconsole messages to trigger a poll
> +    """
> +
> +    target_name = netcons_generate_random_target_name()
> +    ifname = cfg.dev["ifname"]
> +    traffic = None
> +    original_queues = ethtool_read_rx_tx_queue(ifname)
> +
> +    try:
> +        # Set RX/TX queues to 1 to force congestion
> +        ethtool_set_rx_tx_queue(ifname, 1, 1)
> +
> +        traffic = GenerateTraffic(cfg)
> +        do_netpoll_flush_monitored(cfg, ifname, target_name)
> +    finally:
> +        if traffic:
> +            traffic.stop()
> +
> +        # Revert RX/TX queues
> +        ethtool_set_rx_tx_queue(ifname, original_queues[0], original_queues[1])
> +        netcons_delete_target(target_name)
> +        bpftrace_stop()

One risk with stateful tests is that the state is not reset if the
test exists (or crashes) before reaching the cleanup logic. There
are ways around it. Jakub added defer for this purpose, for one.

