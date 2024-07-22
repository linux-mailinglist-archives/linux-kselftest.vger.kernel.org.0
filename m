Return-Path: <linux-kselftest+bounces-13992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59C939190
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B6280EFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962B116DED1;
	Mon, 22 Jul 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="OQr5VMlP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F516DEC2
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661449; cv=none; b=Py8mLDQvXC481HiiHR8i8sqjTYEYGKAkCuqpzDcKVZT6XEVt6O0hdyZtm1fSh3ofmZT/p4wgthy45QPqmVrnSn7ueyaLX4n3oTA3LEtMaN91jniSYDYF05SyI0JUZro8MZdpZ7fJn10OqtJfTGBhi/NQO/UzQ+SMm5J2qsyL+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661449; c=relaxed/simple;
	bh=H1NwTDWsm6JLac8CtJ+mqmRo778a1UcN1lvfUIsLWc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FTrrxMR2YlLeRXOWV7mlgN9gOSxZPtPJeY/dnoI+kLZbKydRMSeWX3N3aieuZirnhAVkl83XnkA9oPu5XuU+Rm3pi0qYUufFDMpuifZkF9tPQGJT0Olg0+D3c+EC+vGHHksKOFCQR3lweu2NcVWH45DRLGmRTTMdyeC2zhna1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=OQr5VMlP; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721661446; x=1721668646;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=H1NwTDWsm6JLac8CtJ+mqmRo778a1UcN1lvfUIsLWc0=;
 b=OQr5VMlP/wKE7o98DO0LWIwQ8IQWZ1NvgSE4Frz0Y6Hg7Wj3dD3n4QWurrPR4IETU2fOKCKt13dVaVWqUcfLj/homg2/wtfmZfk27efuNfiFoBtUYp6cONl0DlEGSr4QlW3PhiPbKvF4rFjfAA3BjCOWxSygedLbnsazDoJ9hnA=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 28a30437924b with SMTP id 669e780644aa569633205899 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jul 2024 15:17:26 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-4c35368b-n90a.c.vimeo-core.internal [10.56.27.205])
	by smtp.vimeo.com (Postfix) with ESMTP id 0C76264D5F;
	Mon, 22 Jul 2024 15:17:26 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 9F159B4090E; Mon, 22 Jul 2024 11:17:25 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers (fd-local edition)
Date: Mon, 22 Jul 2024 11:17:12 -0400
Message-Id: <20240722151713.2724855-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My last patch[1] was met with a general desire for a safer scheme that
avoided global resets, which expose unclear ownership.

Fortunately, Johannes[2] suggested a reasonably simple scheme to provide
an FD-local reset, which eliminates most of those issues.

The one open question I have is whether the cgroup/memcg itself is kept
alive by an open FD, or if we need to update the memcg freeing code to
traverse the new list of "watchers" so they don't try to access freed
memory.

Thank you,

David Finkel
Senior Principal Software Engineer, Core Services
Vimeo Inc.

[1]: https://lore.kernel.org/cgroups/20240715203625.1462309-1-davidf@vimeo.com/
[2]: https://lore.kernel.org/cgroups/20240717170408.GC1321673@cmpxchg.org/



