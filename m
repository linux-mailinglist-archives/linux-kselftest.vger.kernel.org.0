Return-Path: <linux-kselftest+bounces-8152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836788A6DF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E311C2092A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD3131BA7;
	Tue, 16 Apr 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="thnaB9WR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VxIn4lUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC356130A4A;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277219; cv=none; b=Fj/iYIIbsIJXvjzAhSs3nIGzo2j0XChDt5Y7ihv6d88WefwA7e/ffdnl++omZVJg3MLrwfppuGQ5HUtIsgSQwW0WL9DEAlB7U09IZXAiVuhbtc7D3yqYfpc6Yx7Zrljiiu1k6pZe6xCkNVbSYRRbBI7O9b4XQxD2XcEcW9rWTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277219; c=relaxed/simple;
	bh=fnjq1zyVvQYgrXF/wl6IPhboOrjktoNVcF7GsyNF6J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdh13cX4K7HqtxJDDAiR1zm/MGUJ0BiVhUx/dRNCb0GinBGEh+GWgM0ZWo+A1frFZMYZEnzKlwM+XXdSmSEIxcuEY7onI8ObQXd3/t/r6aa3oISpUtDzKJ1d61fV00mZbskbW2ZOKfixNLbM86sGCg1rRes2Ezlc1yp7BZ5OBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=thnaB9WR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VxIn4lUJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD3F95F88B;
	Tue, 16 Apr 2024 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nm9OmMNv+yRwBNQE7fNDtbSWePhkSHjqXbgzKdCZ+YE=;
	b=thnaB9WR0St7tGY09yQ+nPsqkuehI0QaZgj1S88dnqFAnY8adn5NtDz6dYVS4csShddw4e
	auRQek7jlqpUxKY6oWpecJn7xqzYPYCRiXEgVKPKBCyOoQF4UZojM8+lhne1xQqUgeXrIN
	hKBBoOzYOWWHnhkblat4cwn8LT/MRt0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nm9OmMNv+yRwBNQE7fNDtbSWePhkSHjqXbgzKdCZ+YE=;
	b=VxIn4lUJa+KYM9eJosRsp5HmLK+riJ4QcV7BJd20Iqks4xoaHqJUuwOuigUFk5Sq1Q++7q
	+F6ga5S/ogp+S6/bClh+qGtI21RTAox7WIt8g9wvnELHmNhAGIg8eMHQyn4LEqDbMH7sLo
	t+L44TGsqSu90O/Weysd/u30WCQY4VQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1BD513931;
	Tue, 16 Apr 2024 14:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fG4aLx+JHmbAbQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 16 Apr 2024 14:20:15 +0000
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
Subject: [PATCH v4 0/6] pids controller events rework
Date: Tue, 16 Apr 2024 16:20:08 +0200
Message-ID: <20240416142014.27630-1-mkoutny@suse.com>
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
X-Spamd-Result: default: False [-2.08 / 50.00];
	BAYES_HAM(-1.78)[93.67%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.08
X-Spam-Flag: NO

This makes pids.events:max affine to pids.max limit.

How are the new events supposed to be useful?

- pids.events.local:max
  - tells that cgroup's limit is hit (too tight?)
- pids.events:*
  - "only" directs top-down search to cgroups of interest

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

Michal Koutný (6):
  cgroup/pids: Remove superfluous zeroing
  cgroup/pids: Separate semantics of pids.events related to pids.max
  cgroup/pids: Make event counters hierarchical
  cgroup/pids: Add pids.events.local
  selftests: cgroup: Lexicographic order in Makefile
  selftests: cgroup: Add basic tests for pids controller

 Documentation/admin-guide/cgroup-v1/pids.rst |   3 +-
 Documentation/admin-guide/cgroup-v2.rst      |  12 ++
 include/linux/cgroup-defs.h                  |   7 +-
 kernel/cgroup/cgroup.c                       |  15 +-
 kernel/cgroup/pids.c                         | 131 +++++++++++---
 tools/testing/selftests/cgroup/.gitignore    |  11 +-
 tools/testing/selftests/cgroup/Makefile      |  25 +--
 tools/testing/selftests/cgroup/test_pids.c   | 178 +++++++++++++++++++
 8 files changed, 341 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c


base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
-- 
2.44.0


