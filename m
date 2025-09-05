Return-Path: <linux-kselftest+bounces-40841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A6B459F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51359189759F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C335E4DB;
	Fri,  5 Sep 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="e/3s75mY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99735E4F4;
	Fri,  5 Sep 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080810; cv=none; b=skaLzusnyMTHYMml/U1uao5zZ10Nbv4bE8x4UYMdnzWZuesvvr2B0VFsVe352XQGB293yWpzfabDnYSRtgbhaX+OCa5YaUQD1lzgHgoHutrc8XptY2TTVwUFudulMMtozK28Lqor+ykihwk9iozNgCRzYi4PdL6KNAAbM/pzu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080810; c=relaxed/simple;
	bh=WsTvQdk5SLRSwYxtWu3xg3TLl86kAWY1TFGkuPDqHyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZZYDk4cGDqB2MG01SB/IAtK39HnNkmCYg4xKGvfs9x0Tu/MXjIF/zRPxJP4pc3DreZNXmNYjfcAj8mFI8y/7yDL+UTW7I0/pwYlshXxsJ1sWFpkFoqGbczCcL7B7Z6rbJlNTe+AQ9O2yrCF7y6sVayYpCiGkqMPrQ9y6W3TQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=e/3s75mY; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757080807; x=1788616807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MYPGoopsnxRklQrVm59gCgP5304cuODi49N8bsfqroQ=;
  b=e/3s75mY5HtZr/mt+IEzOEnQ0PgCIx/Mc5a3OUf0fYW3PyqFyHn8BE0F
   vQMBCJvEwUBT/ByXow7PDprasH/L7yTJf9LbtCNkxN5xP5ajzDB3sId41
   Q1YgRXuJziXBw9U2tN5EUOJhZprpvm7qp3r/fO6sY6NedL/LC/CMoOJZN
   THtBOZJXOzk7P2r5+lgu/SLPusNQSrctfNc1OifGKef1+kcTGC0BvIoXp
   1VkvK55EbkjE10jv2YTFC9t1F7aUeTOvbScGHq8NB+bI1Ldu6RFxZ0AhK
   RYOMNuHwO+Fnpl3Fx7zwkmAsFgumRaHF5bSgS4yMHUBRm6cNY6GVsBPv8
   A==;
X-CSE-ConnectionGUID: eyNe4lJUTPOmmrdZvYPL3g==
X-CSE-MsgGUID: r3YLrCOGQqK9+q7FY+gBKQ==
X-IronPort-AV: E=Sophos;i="6.18,241,1751241600"; 
   d="scan'208";a="2367827"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 14:00:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:9904]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.92:2525] with esmtp (Farcaster)
 id b8ad8269-924f-49b9-967d-ce768d08406e; Fri, 5 Sep 2025 14:00:05 +0000 (UTC)
X-Farcaster-Flow-ID: b8ad8269-924f-49b9-967d-ce768d08406e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 5 Sep 2025 14:00:04 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 5 Sep 2025 14:00:03 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: <seanjc@google.com>
CC: <aqibaf@amazon.co.uk>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 5/9] KVM: selftests: Prevent PAGE_SIZE redefinition on x86
Date: Fri, 5 Sep 2025 13:59:57 +0000
Message-ID: <20250905135957.12341-1-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aLqh2ojEpZZhjheT@google.com>
References: <aLqh2ojEpZZhjheT@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Thanks for the suggestion. I don't see your previous redefinition of PAGE_SIZE 
upstream, just 3 lines above the warning redefinition:

> In file included from include/x86/svm_util.h:13,
>                  from include/x86/sev.h:15,
>                  from lib/x86/sev.c:5:
> include/x86/processor.h:373:9: error: "PAGE_SIZE" redefined [-Werror]
>   373 | #define PAGE_SIZE               (1ULL << PAGE_SHIFT)
>       |         ^~~~~~~~~
> include/x86/processor.h:370:9: note: this is the location of the previous definition
>   370 | #define PAGE_SIZE               BIT(12)
>       |         ^~~~~~~~~

But I investigated further and found that both glibc and musl define PAGE_SIZE in 
sys/user.h:

glibc (sys/user.h):
  #define PAGE_SHIFT    12
  #define PAGE_SIZE     (1UL << PAGE_SHIFT)

musl (sys/user.h):
  #define PAGE_SIZE     4096

KVM selftests (include/x86/processor.h):
  #define PAGE_SHIFT		12
  #define PAGE_SIZE     (1ULL << PAGE_SHIFT)

This creates redefinition warnings with both C libraries on my system. I've already 
sent a v2 patch series with the PAGE_SIZE patch dropped but I'm not sure what the 
next course of action would be for this?

> Please keep discussions on-list unless there's something that can't/shouldn't be
> posted publicly, e.g. for confidentiality or security reasons.

Apologies, doing this for the first time! Hopefully this one works as it should.

