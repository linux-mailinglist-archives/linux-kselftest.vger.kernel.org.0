Return-Path: <linux-kselftest+bounces-36762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69138AFCF32
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EBC4E0D58
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDF2E336F;
	Tue,  8 Jul 2025 15:25:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A22E2653;
	Tue,  8 Jul 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988352; cv=none; b=gHwrdu7MRzd1ewMEsSa0lw+BIa+qY9NOgwgcXrlrSCEZ+cjJG2GfpLpwdxGy12NAawKunKWceUYb6gibyOvu+qVN6nKmglB5PxVyiDU8qnxjxGIOEo9X4kHSgxAx2ZyOwoKPPGhcYNiX87g8tEnEJh78XpqnAI/7thwlecA4qDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988352; c=relaxed/simple;
	bh=uGgX3GJd4mYElheRctbkZiUbQcWMpUgRQRqQiEn8HzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5ebym1HpN5XmP1TlHcQeElY9oqOvZJyjIfkKpAawBZXzQMNQdoeKZ0askdRXQpha6gEYXSGPlIVABrnx/mxTO63tIvqFJkM4OP+jIIalbKvFW2yCJ3j5idRhbwpfps3s67ajz0oePADHvYzh+WoIOw/QbWnpd/E6QMuaB1IuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so754887266b.2;
        Tue, 08 Jul 2025 08:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988348; x=1752593148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHdiudIvhlbsgKzAlTM7QB3ITrST0Cb2niiN+w8u02c=;
        b=tuRE5PJt+++77tm01MNN+9oa8yoEswPo22GH67Pbul5le2m95HR1PnS0Q1EDAK5TQZ
         KKzmEsdJ42tVvzUdPhPMziEVa/h8C6YA42hMN2kI+3gnxOBNF4TnnaDaSmWZJ/1bJZdt
         7GrzVPFAvPK/3sqo3C9Vb6xu1/GkmaAIbHaJfJ2tok5lm0X9X7xCyL2OSy0gL+mngZXS
         h4W61Hi2RCvOwjFN6NKh3CjaGz6TUie2zXENAlqquDdSFjcNFxQeOhCQYZJi3gzAFzR2
         3z/80a9xnaPdPj5tND9B7X19J4QrX+QTqPOoRAZLAptKU0Qj5CVq/XYTPe9dSeWKwq6w
         HMGg==
X-Forwarded-Encrypted: i=1; AJvYcCUye+XpxnhsSgZlo2E8eGMfykZAUv2NcnbPSfYM7cUVGyr73qNHZ+1yyf1YS09a+cgH9IIQFbmPB6F1Gi/Q@vger.kernel.org, AJvYcCVz6Cmmntg0TWr8ZpIqAdVv5CzpqIoC32zJITzhXjPcjgoOhC+1zUYKzUyAm4kLngJP1rQ=@vger.kernel.org, AJvYcCWA+MFh/e2zQI+o0I8TGoNuCnSh/z2Jfnzj6MtKgMVW4TzYrooXa5VQhEARYrUQfh/SbqBdOWia@vger.kernel.org, AJvYcCXTGNZUHwYmjacCq2mn7nyxRXD1/lbhH8oKwqGOCzYFjqRCwfuucSHZOkcbuypzLKoeghklx0bYtMJ+2lujVr9S@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAb7wSFCIHuGRXm0xV+5fLAfYph/rBMwyPYKod1QHD+jeyMQb
	UIYN/fNABGTwjR1z71A+miH8B/ZbE3PoONgOG1hTzm7LQOWOfU8G+/hI
X-Gm-Gg: ASbGncsgbg7deqaa1kv6+VY9ozjHE8UqlaNGjwea/dlFlkp5SAnAFLuF8mQM6ZZbFb1
	yCyrG28qcxh+ROhx1Jf+dny3FAg4vuS9M3qf0IgWzgbwDaFgKznSe9wwHm0xPrR6QzSxjkJqCtQ
	PibMu0KL3+fU9/MunvrlVv4hsuSI6CiV0uTY5ViHx3sEnn4czbdFRLOLf84s5NPM3/ThSP048sn
	LjPed9xvfohQv+EgLDEL34ueuumJzPtzlYwG04s1/ryba3ySE7AMs8QS+PiDyxB1QOhoVXsiuVx
	yWHE2c240Qbuxo27Q7f+089RP5PDLVfRzzd++t6nEOasIytthz72YQ==
X-Google-Smtp-Source: AGHT+IEA+QZGmBo8k4QMmJoLm/1b04TQE9pmYlrZApkhUSPJ2o4Gc1WfGzMhLET8/ETifijZH+Wpmw==
X-Received: by 2002:a17:907:d582:b0:ae0:bff9:98de with SMTP id a640c23a62f3a-ae3fbd50f78mr1862989866b.40.1751988348225;
        Tue, 08 Jul 2025 08:25:48 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e757sm909637266b.156.2025.07.08.08.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:25:47 -0700 (PDT)
Date: Tue, 8 Jul 2025 08:25:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <aG04ece5RWJCpMmA@gmail.com>
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-3-cec227e85639@debian.org>
 <686c88e0283_29b0d29422@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686c88e0283_29b0d29422@willemb.c.googlers.com.notmuch>

Hello Willem,

On Mon, Jul 07, 2025 at 10:56:32PM -0400, Willem de Bruijn wrote:
> > +def test_netpoll(cfg: NetDrvEpEnv) -> None:

<snip>

> > +        bpftrace_stop()
> 
> One risk with stateful tests is that the state is not reset if the
> test exists (or crashes) before reaching the cleanup logic. There
> are ways around it. Jakub added defer for this purpose, for one.

Agree. Jakub suggested about "defer" a while ago, but I didn't realize
we had a "defer" helper in our test framework. For a second I though
Jakub was talking calling the stop later, my bad.

Now that you raised it, I found that we have "defer" as a helper, and we
definitely should use it. How about something as simple as:

	diff --git a/tools/testing/selftests/drivers/net/netpoll_basic.py b/tools/testing/selftests/drivers/net/netpoll_basic.py
	index 398ac959151b3..6017b71f154b2 100755
	--- a/tools/testing/selftests/drivers/net/netpoll_basic.py
	+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
	@@ -27,6 +27,7 @@ from typing import Optional

	from lib.py import (
	bpftrace,
	+    defer,
	ip,
	ethtool,
	GenerateTraffic,
	@@ -251,6 +252,7 @@ def do_netpoll_flush_monitored(cfg: NetDrvEpEnv, ifname: str, target_name: str)
	# Start bpftrace in parallel, so, it is watching
	# netpoll_poll_dev() while we are sending netconsole messages
	bpftrace_start()
	+    defer(bpftrace_stop)

	do_netpoll_flush(cfg, ifname, target_name)

	@@ -338,7 +340,6 @@ def test_netpoll(cfg: NetDrvEpEnv) -> None:
		# Revert RX/TX queues
		ethtool_set_rx_tx_queue(ifname, original_queues[0], original_queues[1])
		netcons_delete_target(target_name)

Thanks for th heads-up and review,
--breno

