Return-Path: <linux-kselftest+bounces-13756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5D931C33
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 22:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA9528176C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699C13BAE9;
	Mon, 15 Jul 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="Va2dqn6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05C13B58C
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076386; cv=none; b=NXQPGScL5OqHngS9ErmICXrwSkec6u+rkgkGBJSiSAuayEkAuej8GYu9+FDlwntGiZn41iFTuf2MN2zmdQU5XSu6iiXyLUeRJFW8j/48CdJO4Acuu9S2kC+rKxv0fscPragD6Z2VRDB/ZLJLm0IFnCPDJzjRLqxRaBEG0/djOig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076386; c=relaxed/simple;
	bh=60XeB4Y6cdSYT0bzY86psxuZFgQeK3RBilXsfgGxjq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKsXc8pmQGpvGhkqjGgcMirS9DPGLXkVXVpqJbQJWoTG+jIs6XyA+Srn6RRRQ0pw8HRd0GdddV/JIotSnN5X4gFA1Z89OT0VKAtP+4hd8v6I/tJafcpmQ3gK1rULaYWSrDbEK/S2dQnizOwdxJ1luxCR2u0UvVgrPYMwNiXhtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=Va2dqn6A; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721076384; x=1721083584;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=60XeB4Y6cdSYT0bzY86psxuZFgQeK3RBilXsfgGxjq8=;
 b=Va2dqn6Akp21i4jZG7p9ivyj7aAB7Gsxe3vBNQ9bs96Om7ZNi+oc94kEpBbPH+CuMbm4ALiL8CCRi/9Gs4fDCTg8ieO2c5pIekhhkHzMGdmvTcBgwp6raaxKHIN6ibRkgIQ0/sFGjSqSvqGZZtoTkWC8Tlt7n8ikCBWsM3Fsfv0=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 12c5aac5a65f with SMTP id 66958aa044aa56963350d380 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jul 2024 20:46:24 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-c45160e0-vtn6.c.vimeo-core.internal [10.56.27.201])
	by smtp.vimeo.com (Postfix) with ESMTP id 732246011D;
	Mon, 15 Jul 2024 20:46:23 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id E104DB4070C; Mon, 15 Jul 2024 16:37:30 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 15 Jul 2024 16:36:25 -0400
Message-Id: <20240715203625.1462309-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rebase of a patch I sent a few months ago, on which I received
two acks, but the thread petered out:
https://www.spinics.net/lists/cgroups/msg40602.html.

I'm hoping that it can make it into the next LTS (and 6.11 if possible)

Thank you,

David Finkel

Sr. Principal Software Engineer, Vimeo


