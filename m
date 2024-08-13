Return-Path: <linux-kselftest+bounces-15265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3712950D3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8BA2850D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226FF19DF49;
	Tue, 13 Aug 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pMwUFne4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373335589A;
	Tue, 13 Aug 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577897; cv=none; b=A7ue/SqHon30H6ZauR8B3hmQHkud09xNETQxTvGMHsT1VT3FS//x3GGAAZpngQUe+cra30MS0/MKKQ8kwGOWYY6oqjFjc8AtuihWoFs67m9N5acKsf1KZI07ZzldIqlZBn8prDtBoA60DuLU38FhctI3sxHgjaZEsB1SsO7Tabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577897; c=relaxed/simple;
	bh=XtWwt1oYdjy3qJ/1lKeyNY+5x12gEy2WBxAW2zPJIHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6qPKfqzE+F+GkGq4VAxhkc+cj4YdDHiiZB6lLy1LCBRflwCwKOXO+41ZKEk2v9GQO5swK5R531HSZ/QPwIGsQG5c4bCqDzPfjyo61V4PJkVImWkoNCFxgEra5UJkejz4iQZhpJwlcn32ctsZYD41okBjFo+e3hYqDNTMrTH13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pMwUFne4; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723577896; x=1755113896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtWwt1oYdjy3qJ/1lKeyNY+5x12gEy2WBxAW2zPJIHU=;
  b=pMwUFne4IhOykyVOQU0LUm/zVDjUHeA6rWkH27jAmbrESTqfj1uU5qvQ
   dQfD4GSBeGTwc60O68fON0WGGWbaz3xcJwXufHNM1yTTBs76i8bgj6v0O
   0fXahWqf/UfsU4UZ4QvipLEt5CSjbJYmpETY9vbZ2GU6V8NoAa1e9S4QX
   w=;
X-IronPort-AV: E=Sophos;i="6.09,286,1716249600"; 
   d="scan'208";a="673708519"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 19:38:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:3184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.61:2525] with esmtp (Farcaster)
 id d2bfa5a3-3d3d-4fc5-b153-09f4356060fc; Tue, 13 Aug 2024 19:38:10 +0000 (UTC)
X-Farcaster-Flow-ID: d2bfa5a3-3d3d-4fc5-b153-09f4356060fc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 19:38:10 +0000
Received: from 88665a182662.ant.amazon.com (10.119.205.65) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 19:38:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.hunter.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>,
	<javier.carrasco.cruz@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH 1/1 V2] Kselftest: msg_oob.c: Fix Compiler Warning For Incorrect Specifier
Date: Tue, 13 Aug 2024 12:38:00 -0700
Message-ID: <20240813193800.19311-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240813191932.991638-1-david.hunter.linux@gmail.com>
References: <20240813191932.991638-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Hunter <david.hunter.linux@gmail.com>
Date: Tue, 13 Aug 2024 15:19:32 -0400
> Apologies for not looking ahead of time. I definitely need to remember
> to check ahead of time. I understand that the other person was first; I
> just wanted to get some practice sending patches. This is all still new
> to me.

I understand, but let's not respin an unnecessary patch just for practice
that waste community time...

