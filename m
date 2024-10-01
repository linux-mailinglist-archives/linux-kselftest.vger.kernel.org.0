Return-Path: <linux-kselftest+bounces-18799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3E98C34E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14291C24342
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3241CCB35;
	Tue,  1 Oct 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IvVD1i3P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="79AnOGlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88291CCB22;
	Tue,  1 Oct 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799662; cv=none; b=rJ3uZCm0zXIEHClJGXH1gbSRJJoBgF+dxDQ3a4oP+ryWb2a8/vqudb+iJyu6bPfOUhQAdss88EuBkoFNG6DtJAYisHGJfjPFckZoeRC/eYEi1wpqusN6hyDnB4yvIGGNk0poHJbMxxL5+kwGFAp77YabiGPnxmZLU+u/Q/qjHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799662; c=relaxed/simple;
	bh=50Kc/VqmKtTSOxHAWjBypYOatXvkpvo9/GVb9cRxjAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBXMs4tzjZS8Sws/Iyfc32sJ9soKd2eHeOL81xWrxMRpkxk0WLvPhM2SRVfblX0v6BTE0pjEP0TvWFF+In58wyiXVsiOhr6yzQX0O6ehb0jFUn4/y62PK3dqBzPwcAO1OhB/GQlSpcNawjhCrQTPzh5lO0MKUVEfTmrwiUDiB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IvVD1i3P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=79AnOGlo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1756F1FCEB;
	Tue,  1 Oct 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727799657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/QBF9ogG+rLgjsYlGtd5nYLAr8eD5n5eV3Wh2PFS6s=;
	b=IvVD1i3PZoO/G0+SShUuHjmGbgr04z/JU5VYqn7PyYalIFAZK3wDKdp4SVdGNvIdx6Zn0r
	XE3ZyuxQd3vOvjZTSSNf8DTYBoROimPtL2+NhzOAgXAZ7jx+D/nfgIIurnlPXJ1gpfkgB3
	Du68vOdEIPlMrO1rvkQ5KkaIMvNmdM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727799657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/QBF9ogG+rLgjsYlGtd5nYLAr8eD5n5eV3Wh2PFS6s=;
	b=79AnOGloyFDDJnxc20ufPXTF7TToPL8scRX1tzFKC3c6jBT4T+SgMdZOHniLljNnMFTc3M
	udE/zrrCO3/hHsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4AC913A91;
	Tue,  1 Oct 2024 16:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEqkM2gh/GaHRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Oct 2024 16:20:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 01 Oct 2024 18:20:49 +0200
Subject: [PATCH slab hotfixes v2 2/2] slub/kunit: skip test_kfree_rcu when
 the slub kunit test is built-in
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-b4-slub-kunit-fix-v2-2-2d995d3ecb49@suse.cz>
References: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
In-Reply-To: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
To: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 Guenter Roeck <linux@roeck-us.net>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 rcu@vger.kernel.org, David Gow <davidgow@google.com>, 
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 1756F1FCEB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Guenter Roeck reports that the new slub kunit tests added by commit
4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
test_leak_destroy()") cause a lockup on boot on several architectures
when the kunit tests are configured to be built-in and not modules.

The test_kfree_rcu test invokes kfree_rcu() and boot sequence inspection
showed the runner for built-in kunit tests kunit_run_all_tests() is
called before setting system_state to SYSTEM_RUNNING and calling
rcu_end_inkernel_boot(), so this seems like a likely cause. So while I
was unable to reproduce the problem myself, skipping the test when the
slub_kunit module is built-in should avoid the issue.

An alternative fix that was moving the call to kunit_run_all_tests() a
bit later in the boot was tried, but has broken tests with functions
marked as __init due to free_initmem() already being done.

Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: rcu@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/slub_kunit.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 85d51ec09846d4fa219db6bda336c6f0b89e98e4..80e39f003344858722a544ad62ed84e885574054 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -164,10 +164,16 @@ struct test_kfree_rcu_struct {
 
 static void test_kfree_rcu(struct kunit *test)
 {
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_kfree_rcu",
-				sizeof(struct test_kfree_rcu_struct),
-				SLAB_NO_MERGE);
-	struct test_kfree_rcu_struct *p = kmem_cache_alloc(s, GFP_KERNEL);
+	struct kmem_cache *s;
+	struct test_kfree_rcu_struct *p;
+
+	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
+		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
+
+	s = test_kmem_cache_create("TestSlub_kfree_rcu",
+				   sizeof(struct test_kfree_rcu_struct),
+				   SLAB_NO_MERGE);
+	p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kfree_rcu(p, rcu);
 	kmem_cache_destroy(s);

-- 
2.46.1


