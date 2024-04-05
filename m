Return-Path: <linux-kselftest+bounces-7301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1E89A30C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C95289793
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9917166D;
	Fri,  5 Apr 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C0JGWdqn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="afuAoHsU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188417164E;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336755; cv=none; b=e7mmHLUqHOuwyl8lIqDohAndKGGlNQM9kPVZMWisxcG5W2/dZAuFOQDZtmMozu1GeJweWnxBrHAgXfJVr3lObOa9lzRagRwV/cQKz5u5Oov2MxX8EjRVymr4j34w/6PHGa8+56hI+5cVFjJhJCiDEjA1p4+s4ugsOyA6CezHJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336755; c=relaxed/simple;
	bh=292FtAHAQkVnLeVN989TV5AQEa/YkR9Vv3e9Rljpa14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9ZgvNxXPXBD9BAVk6iEAKinGJHSFJcFPloKd4FGFl7Q1BLeF98hDheU1LTcv4CHaMSxYCWeyBdavX8Cmx6NpoBI6/sqnzI2qhO0wqijTYsf7EcOkfeZqcpX1f0d4YrKGrWR/QkHSEttgO1lHgF1S03cbEg4rPxO8Q2+V64wyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C0JGWdqn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=afuAoHsU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D78021ABE;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vT8XBjOmiOF2DZOaI8CF1LOaUqXXvEhx/xriwZY31Nc=;
	b=C0JGWdqn0yuOJeZdigrbYy9nkvUEiDe8JxxzqOL2EJ87oIECnDUXhxlt56Raw64ImP/hrL
	8y+jI+/SK5758gU+BEsDOBisv7hWDx8f0BVlypYkMgPdPZauB5xFl5BLdU+4qR6RL5X56s
	AKtAopOR2L37mXgsDUnMNUielg9mGr8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=afuAoHsU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vT8XBjOmiOF2DZOaI8CF1LOaUqXXvEhx/xriwZY31Nc=;
	b=afuAoHsUSSaWfJ0EVXtxzDQO6En30JUuysIxxye+1XlE7NzesjZW3wnqpEN2FrDtARb9lI
	4S7yvOd/HQFJBl1UxmTMW5kIpZadEtwjFy0A+I9tYfBE/JNAML1+1Lf59G6qpcjrFcOUOO
	Su8w6yWg3z3u/eVP4Rk3OE6UQpU8ACc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BCB7013A92;
	Fri,  5 Apr 2024 17:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WMJiLW4vEGYteAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Fri, 05 Apr 2024 17:05:50 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC PATCH v3 1/9] cgroup/pids: Remove superfluous zeroing
Date: Fri,  5 Apr 2024 19:05:40 +0200
Message-ID: <20240405170548.15234-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405170548.15234-1-mkoutny@suse.com>
References: <20240405170548.15234-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.51 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[33.76%];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 0D78021ABE
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spamd-Bar: /

Atomic counters are in kzalloc'd struct. They are zeroed already and
atomic64_t does not need special initialization
(cf kernel/trace/trace_clock.c:trace_counter).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/pids.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 7695e60bcb40..0e5ec7d59b4d 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -75,9 +75,7 @@ pids_css_alloc(struct cgroup_subsys_state *parent)
 	if (!pids)
 		return ERR_PTR(-ENOMEM);
 
-	atomic64_set(&pids->counter, 0);
 	atomic64_set(&pids->limit, PIDS_MAX);
-	atomic64_set(&pids->events_limit, 0);
 	return &pids->css;
 }
 
-- 
2.44.0


