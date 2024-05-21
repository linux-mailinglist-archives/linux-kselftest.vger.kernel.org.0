Return-Path: <linux-kselftest+bounces-10471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783058CAAA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FD0B2220E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E92612EB;
	Tue, 21 May 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FJekK48L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gtLbwtE9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43456773;
	Tue, 21 May 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283296; cv=none; b=BKe4LnCZOKjCGfkzOHujbWeaqSLz7HdxkxGc6pidaBMG7W6mTRI3PPWbzye5j0HZc7LsckH3YhQxPkUFlA0qpYm+npBKa06kWDxrb6rntB//FxHk/Gqy0KTDPlkBSdvolnQBYjuDAsNBcd/qlae6SYlleMufrJtXYPJmViAv4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283296; c=relaxed/simple;
	bh=L8uimhUWPGJ0KgFqNtZBzgCwE1GHpNZQQzxQkiu/s8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iOet4Yd6jPua90IeXB0cQLwZjqY2yofAGmFBNV4sYvQs7S5yBlNwCaG0L1enuUzDVbNVz+21IKWbi20SLRs/KlMmP6/zvquDO+kZkgE1zL/fQW7cS7e1U6SmfCHqJv7gexSL+wQSCZEeux74wFB7lOlgA+KLv5AdwJ0dCuwdzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FJekK48L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gtLbwtE9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAFFF5BFD4;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZ4Ycnq4O0FTSEXxyM/FN9hxtXkMlycqRzRAQFk7JpY=;
	b=FJekK48LN8HJZVGjtkX1O8HxoUAslBvUSpjlLDF0K3O/d4dxHKLY4p6wvRRoDVvWhkme7m
	jkcGKhWTgpBSSYaFUFy2Nx542HB0B7EAgcIwiXwAJq0VOavL/FPMxTuQ8wrHrKzP6OkSwJ
	2fpRbKlyR8KLzGzw1DXhmOIwc93QG7c=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZ4Ycnq4O0FTSEXxyM/FN9hxtXkMlycqRzRAQFk7JpY=;
	b=gtLbwtE9AF682EdeTUVgQjtZYm8yEWrW72jaD5lqZYaOnunV0DVvRf2IzZFZGPPu7Avm5V
	Cm+z7F+aEk4jSpCJTu30jomQ4HWXgT120dwOVU5bGtlD4GBhfsF6WUMVtqTcf0PG42pJw2
	TYq28W+k2BLdii+PetWtWUYbKoE/BQc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADB5513A1E;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fc8KptnTGaZYgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 21 May 2024 09:21:31 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v5 0/5] pids controller events rework
Date: Tue, 21 May 2024 11:21:25 +0200
Message-ID: <20240521092130.7883-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6j1h7wxugqfdyj8pnx7tibp9)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

This makes pids.events:max affine to pids.max limit.

How are the new events supposed to be useful?

- pids.events.local:max
  - tells that cgroup's limit is hit (too tight?)
- pids.events:*
  - "only" directs top-down search to cgroups of interest

Changes from v4 (https://lore.kernel.org/r/20240416142014.27630-1-mkoutny@suse.com)
- rebased on cgroup/for-6.10 (rather cgroup/for-next, there's no rush)
- introduce pids_files_legacy at one place (Tejun)
- more descriptive Documentation/ (Tejun)

Changes from v3 (https://lore.kernel.org/r/20240405170548.15234-1-mkoutny@suse.com)
- use existing functions for TAP output in selftest (Muhammad)
- formatting in selftest (Muhammad)
- remove pids.events:max.imposed event, keep it internal (Johannes)
- allow legacy behavior with a mount option
- detach migration charging patches
- drop RFC prefix

Changes from v2 (https://lore.kernel.org/r/20200205134426.10570-1-mkoutny@suse.com)
- implemented pids.events.local (Tejun)
- added migration charging

[1] https://lore.kernel.org/r/20230202155626.1829121-1-hannes@cmpxchg.org/

Michal Koutný (5):
  cgroup/pids: Separate semantics of pids.events related to pids.max
  cgroup/pids: Make event counters hierarchical
  cgroup/pids: Add pids.events.local
  selftests: cgroup: Lexicographic order in Makefile
  selftests: cgroup: Add basic tests for pids controller

 Documentation/admin-guide/cgroup-v1/pids.rst |   3 +-
 Documentation/admin-guide/cgroup-v2.rst      |  21 ++-
 include/linux/cgroup-defs.h                  |   7 +-
 kernel/cgroup/cgroup.c                       |  15 +-
 kernel/cgroup/pids.c                         | 129 +++++++++++---
 tools/testing/selftests/cgroup/.gitignore    |  11 +-
 tools/testing/selftests/cgroup/Makefile      |  25 +--
 tools/testing/selftests/cgroup/test_pids.c   | 178 +++++++++++++++++++
 8 files changed, 346 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c


base-commit: 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
-- 
2.44.0


