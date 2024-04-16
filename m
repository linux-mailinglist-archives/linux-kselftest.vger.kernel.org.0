Return-Path: <linux-kselftest+bounces-8158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC58A6E0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD1B2745E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232151350EF;
	Tue, 16 Apr 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="APOrWBCW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="APOrWBCW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC156131753;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277222; cv=none; b=GTZFUcpyPhIewxOTZixe8vzB2GuOe2vhyX7RuLIisLinE3rIiWc9olq4QeL0g3ZzMl4lL7Q6yMe3bqiMb9UADM9mDWPxhsssXVSZc2jc7RkWCP4+uwoj8Gkf9ZlJV3G1YbY2VWNRh3FGYbFtSN8Oyqh5BLeUMIGGPnul1tjEIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277222; c=relaxed/simple;
	bh=292FtAHAQkVnLeVN989TV5AQEa/YkR9Vv3e9Rljpa14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irsUotC1/RGVslHEwzPJfb8S1f4bsDt3lnIY3CEPTe4W4bXEuXHbBOHHkC6+Qq8HCZQxN/xGgdK301cBpYB+Zsa6KPbDkh10QF+NWUZdKRyWSxv0xGOY2upyWvhw7pO+y3rZrf4w5ucyB/VU+14dM5oH7qcbj7V9wfq0pjgGMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=APOrWBCW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=APOrWBCW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CD65374EA;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vT8XBjOmiOF2DZOaI8CF1LOaUqXXvEhx/xriwZY31Nc=;
	b=APOrWBCWxBz8CHg9/eOvGTrgu7rE3CXyuTCx4m1l7Wz7tx9O75yQLuXZ1ykLJ9LKp3dDpx
	r8AEksQ+YF2dsYtmRQas+gLk15Nql1MYyHxHRh/MJ8XsI+fMQN/+dlgm+p2D2xAnpMxUhX
	qgAEc1pGmQfeKKoVcsN/Q4z11Hl6j0g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vT8XBjOmiOF2DZOaI8CF1LOaUqXXvEhx/xriwZY31Nc=;
	b=APOrWBCWxBz8CHg9/eOvGTrgu7rE3CXyuTCx4m1l7Wz7tx9O75yQLuXZ1ykLJ9LKp3dDpx
	r8AEksQ+YF2dsYtmRQas+gLk15Nql1MYyHxHRh/MJ8XsI+fMQN/+dlgm+p2D2xAnpMxUhX
	qgAEc1pGmQfeKKoVcsN/Q4z11Hl6j0g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC47C13942;
	Tue, 16 Apr 2024 14:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sCujNR+JHmbAbQAAD6G6ig
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
Subject: [PATCH v4 1/6] cgroup/pids: Remove superfluous zeroing
Date: Tue, 16 Apr 2024 16:20:09 +0200
Message-ID: <20240416142014.27630-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416142014.27630-1-mkoutny@suse.com>
References: <20240416142014.27630-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.78
X-Spam-Level: 
X-Spamd-Result: default: False [-1.78 / 50.00];
	BAYES_HAM(-1.48)[91.55%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

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


