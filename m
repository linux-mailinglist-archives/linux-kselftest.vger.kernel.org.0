Return-Path: <linux-kselftest+bounces-7308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC189A325
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4149B2899F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC4172789;
	Fri,  5 Apr 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QVDI5ZkD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HREehNmU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB96171667;
	Fri,  5 Apr 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336757; cv=none; b=HT3TsKH0Y60tJbaEicXZipl6fRKXK6S+dh9y5BOt9kW6n7b+baIlA4cOV8PVo/1oc5WChQ0ajNZDhPfXJ9jTs2CPoYAwdmJeR28GNTlbpRglWmxHGmIS0nB/Tnyx/Yas3q7uB1D/jQ1GdXWbGgRIeHwnz8IVKZsWzEl2XNJuuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336757; c=relaxed/simple;
	bh=3MGXpzhZa+gKGaC3J1tW/XisbdnMmhiN8wByr21xusU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D6n4XTtEPWuV1OMkpF8VXBnpkXlzx1tEg9HWeKzWK6Qr52gUFRB5/CI4reo7EI/Kjk5rE84SIUpzPciQVDedGx5TiSg/BEXKVMmZec0vZVW5sp6REfjDvpsQbtUaB0k/p+FYqu4/Ad9FvkarIHE+81TaCOaqF6OfDKqLoYg3H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QVDI5ZkD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HREehNmU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9C1621ABD;
	Fri,  5 Apr 2024 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tYd9ZCVD4B5C76HBNsh7rrYDdpVnw16Z20c+CbVHIHY=;
	b=QVDI5ZkDa7kjXVucu/wn/cG6/Ws0VGhyDLsshTv56UndfTmPEAelmT9rPr1y664+c1f3hr
	q5qvDbIAl0qMBff2JibgGnYew52DqGK97bpc8OjAdmggOrB9ehXwVxKi2IeKdrNaD1xanM
	jajzR0wHDyvh80TTqKymK7F9tMW01LE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HREehNmU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tYd9ZCVD4B5C76HBNsh7rrYDdpVnw16Z20c+CbVHIHY=;
	b=HREehNmUjhmCeyr2mWq5nHivhsblunCRm9u/XprWvOaQT/oRLC/0BYtrQLJFk8t4d1AESn
	H1kImb6MP1s9jbZfefrIbV3CPAPtxfdbPa8ye/6gx53+4XQ02X3qRCT0y3U5gYh6qqBPH9
	nrkijp49BrjomK065BSiQdC00eIThKs=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 91B4A139E8;
	Fri,  5 Apr 2024 17:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TQDGIm4vEGYteAAAn2gu4w
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
Subject: [RFC PATCH v3 0/9] pids controller events rework and migration charging
Date: Fri,  5 Apr 2024 19:05:39 +0200
Message-ID: <20240405170548.15234-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfcexjtczxtbnj559fj95g6y7)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pids.events:url,suse.com:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B9C1621ABD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

The series consists of two parts:
- pids.events rework (originally v2, patches 1-6,
- migration charging, patches 7-9.

The changes are independent in principle, I stacked them for (my)
convenience and because they both deserve RFC:

1) Changed semantics of v2 pids.events
  - similar change was proposed for memory.swap.events:max [1]
2) Migration charging is obsolete concept

How are the new events supposed to be useful?

- pids.events.local:max
  - tells that cgroup's limit is hit (too tight?)
- pids.events.local:max.imposed
  - tells that cgroup's workload was restricted (generalization of
    'cgroup: fork rejected by pids controller in %s' message)
- pids.events:*
  - "only" directs top-down search to cgroups of interest

The migration charging is motivated by apparenty surprising
	pids.current > pids.max
because supervised processes are forked in supervisor's cgroup (more
details in commit cgroup/pids: Enforce pids.max on task migrations too)

Changes from v2 (https://lore.kernel.org/r/20200205134426.10570-1-mkoutny@suse.com)
- implemented pids.events.local (Tejun)
- added migration charging

[1] https://lore.kernel.org/r/20230202155626.1829121-1-hannes@cmpxchg.org/

Michal Koutný (9):
  cgroup/pids: Remove superfluous zeroing
  cgroup/pids: Separate semantics of pids.events related to pids.max
  cgroup/pids: Make event counters hierarchical
  cgroup/pids: Add pids.events.local
  selftests: cgroup: Lexicographic order in Makefile
  selftests: cgroup: Add basic tests for pids controller
  cgroup/pids: Replace uncharge/charge pair with a single function
  cgroup/pids: Enforce pids.max on task migrations
  selftests: cgroup: Add tests pids controller

 Documentation/admin-guide/cgroup-v1/pids.rst |   3 +-
 Documentation/admin-guide/cgroup-v2.rst      |  22 +-
 include/linux/cgroup-defs.h                  |   7 +-
 kernel/cgroup/cgroup.c                       |  16 +-
 kernel/cgroup/pids.c                         | 206 +++++++++----
 tools/testing/selftests/cgroup/Makefile      |  25 +-
 tools/testing/selftests/cgroup/test_pids.c   | 302 +++++++++++++++++++
 7 files changed, 514 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c


base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
-- 
2.44.0


