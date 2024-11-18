Return-Path: <linux-kselftest+bounces-22192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E19D1775
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F251F22C41
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D191BE226;
	Mon, 18 Nov 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qy+thCX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63C13D279;
	Mon, 18 Nov 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952509; cv=none; b=K0x89BrUlYZkrx1QE0sWCJzkWzoDR+UhG0e8MJOE+ysP2oxj+3sH1UmOV9rhp9v8zBzkiJX8ynG/Zo/vjxyWQhxM+N6alNMdV99T9tyi8Hi+rJQ2pqxtF+blqSVEe41OJEsqilf50aRxbVtkkIdZHzvFzUVDK+mpfTJljNlYIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952509; c=relaxed/simple;
	bh=4xuNA0jW6L91RUvzWGbhLx0szFWOwcsL6++cq5EU5zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQawIWarvUCRPges5lJK6j1PKpKDwTsw2Nl0lvVenlA9H9HaW6vZYHkK9iCoRvB97sXXg+ZZYrzRFhwQhZlfrDQNjU83wU5bqMjflYquBlvHJx3HFpVwCEoEqE1S23jVWb6E0ktGY+SzvD53dsTKOrh7qqv1udLArzRaEwBjzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qy+thCX0; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731952508; x=1763488508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwICQSsecITpZMbR61OSXdeyDQOyyIhRA6XTJdNn8dc=;
  b=Qy+thCX06O8fjBANXg+bEttQIUDujFi7dEF+2xb5addyDbj4uz9XpvGr
   Qa/dX9lSArUbFObsnzp/YqU3qGpfQ5PsPFm72y0f7ywpDxyj1xnGYJtBp
   27zsW6t3itWQmq95pbJSK57ZFo4VY1p9/P9U/AF5nWhLZ8Np7p0BVJcxR
   w=;
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="776663076"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 17:55:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:43227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id 6a9d2a7c-f999-46d5-9241-fbff91dfd6d8; Mon, 18 Nov 2024 17:55:01 +0000 (UTC)
X-Farcaster-Flow-ID: 6a9d2a7c-f999-46d5-9241-fbff91dfd6d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 18 Nov 2024 17:55:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 18 Nov 2024 17:54:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stsp2@yandex.ru>
CC: <almasrymina@google.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
	<brauner@kernel.org>, <cyphar@cyphar.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <gouhao@uniontech.com>, <horms@kernel.org>,
	<kees@kernel.org>, <krisman@suse.de>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mhal@rbox.co>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <quic_abchauha@quicinc.com>, <shuah@kernel.org>,
	<tandersen@netflix.com>, <viro@zeniv.linux.org.uk>, <willemb@google.com>
Subject: Re: [PATCH net-next v3] af_unix: pass pidfd flags via SCM_PIDFD cmsg
Date: Mon, 18 Nov 2024 09:54:52 -0800
Message-ID: <20241118175452.54045-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241116101120.323174-1-stsp2@yandex.ru>
References: <20241116101120.323174-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stas Sergeev <stsp2@yandex.ru>
Date: Sat, 16 Nov 2024 13:11:20 +0300
> Currently SCM_PIDFD cmsg cannot be sent via unix socket
> (returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
> The created pidfd always has flags set to 0.
> 
> This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
> can be used to send flags to SO_PASSPIDFD-enabled recipient.
> 
> Self-test is added for the propagation of PIDFD_NONBLOCK flag.
> 
> This is mainly needed for the future extensions, like eg this one:
> https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
> where it was suggested to try solving the supplementary groups
> problem with pidfd.
> 
> Changes in v3: specify target tree in patch subject

It seems you missed other feedback, especially __scm_recv_common()
needs a small change.

net-next is closed during the merge window for v6.13-rc1, so please
post v4 after Dec 2nd.
https://lore.kernel.org/netdev/20241118071654.695bb1a2@kernel.org/

