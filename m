Return-Path: <linux-kselftest+bounces-15194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F894FD9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 08:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F175C283BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92B39AFD;
	Tue, 13 Aug 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k/wSoJUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234612262B;
	Tue, 13 Aug 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529593; cv=none; b=kXfWpN9pII73KVR9h+sV6/KO0PenTzYrv3J7MOqdXXffdJAbOZOmnLIgumCCIN1+vqNTMyD9btaF5N009WP7aVdag6KZrWkhXdmojvTXayaub7olDOJGFByvFVycDH9LJUSOJJ0by22trismJGT9FPsqnevhXoB6m++ekZV3Vss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529593; c=relaxed/simple;
	bh=gKFhI0S2mlLMqPuudOyLilnNWOeupixtPdSxKimBLLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8HWVyIHOBUccFc8TAs3Tkzjwlfm+gw89l5DZS3q9wX/H+36Jw3XjHDxvKrVsm8i9paxN4QczxkKs16YIfuEFmm8MBGwG2QlrHYnEfwLbLXEjOwO8R1PS9/Z+ccLn2hFJugay4lt0KbZ0P/VkMvq1TyFTbMAQiTBrcCfF4eqQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k/wSoJUC; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723529592; x=1755065592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKFhI0S2mlLMqPuudOyLilnNWOeupixtPdSxKimBLLs=;
  b=k/wSoJUC/guXrTE/4tHCYL0P8/rMQONi1MLDxyE+FoMpVKpoSDYdvHAx
   0mjO355h/gh+8JB7xB7docWhB4/MiMr4H/oGDT8J/ajIgW6LmB/Uu2nTd
   gLnxEsgYFKyelQUFQhSmiAo5MWFI4/DMWUmbBuuqs7CYBLdF8lAT/AHvu
   o=;
X-IronPort-AV: E=Sophos;i="6.09,285,1716249600"; 
   d="scan'208";a="420886268"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:13:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:5817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.23:2525] with esmtp (Farcaster)
 id bdc15a2d-7174-4d53-9c6f-090ba981ef3d; Tue, 13 Aug 2024 06:13:08 +0000 (UTC)
X-Farcaster-Flow-ID: bdc15a2d-7174-4d53-9c6f-090ba981ef3d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 06:13:05 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 06:13:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.hunter.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>,
	<javier.carrasco.cruz@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH] Kselftest: msg_oob.c: Fix warning for Incorrect Specifier
Date: Mon, 12 Aug 2024 23:12:54 -0700
Message-ID: <20240813061254.36825-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240813060036.754213-1-david.hunter.linux@gmail.com>
References: <20240813060036.754213-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Hunter <david.hunter.linux@gmail.com>
Date: Tue, 13 Aug 2024 01:59:57 -0400
> Change specifier to %p to correctly substitute type 'const void *'. A
> specifer involved with a macro is causing a misleading warning to occur:

You may want to run the test before/after the patch.

This is the 3rd patch posted for this warning, so it would be nice to
check lore before posting if the patch/issue is simple enough :)

And here's the correct fix.
https://lore.kernel.org/netdev/20240812191122.1092806-1-jain.abhinav177@gmail.com/

Thanks !

