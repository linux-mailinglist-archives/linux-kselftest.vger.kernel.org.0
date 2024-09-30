Return-Path: <linux-kselftest+bounces-18589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C155A989CE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38E11C219F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B717C7B6;
	Mon, 30 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjLzb/uw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+fD/IqS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PQ3SPeHb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ieXzy1Ws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38917B506;
	Mon, 30 Sep 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685474; cv=none; b=KKl09M2R0VnkbTKIWZU2rkDevjU8dfgiTIWqUCjzRdpDIJkYgZmmKjTxCKHeT0W69o2Qh+PeLlnxQJK4RWgaG7bC1ZeL0yXgjXo9f77KWmPSEPUcXf1573XhJNTSqg/WeYDWeu7Ne39Ov2HIMs7vF8DgIobdp/K4wMn/gj5TR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685474; c=relaxed/simple;
	bh=0WnxLPEui3oDtLBzlhAtJkEteadIcsQlNHVOikq11/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfG9nJE2TB/9rps3qsHZF47nkvxJRMk8JuofZ5+zTnB7sw20N63PdHZxspfLfM1aLDUEM5rey3gPC32gth29ihn44XngCqXSOQTET2AjZNqG3yFTPiN2Z+D/+IdRkXGtnhq5kklguic6mqBi3/1wRRUgTftFS+O7Q6xToBQ9Ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjLzb/uw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+fD/IqS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PQ3SPeHb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ieXzy1Ws; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED95F1F7F6;
	Mon, 30 Sep 2024 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H0gPESO/BntkG0B4FSGoHsx0d2Sq64W+wU6e58nb2w=;
	b=rjLzb/uwGOFEw+Hby88kVfZ6SY9u9G3VwCebC0uBG/wfLFdcGzoLW9/nGKYN8nLJ1IfnoZ
	8TsglSwlbyMUSvj1GTFAb3BgQfmECblArMuIo6r0nloHMtOANcBaHUPOswwJ1f7lJUYpFV
	nJ1vJYemy+HAUJwUw3uBo/VKk2gZ7H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H0gPESO/BntkG0B4FSGoHsx0d2Sq64W+wU6e58nb2w=;
	b=a+fD/IqS8IrfYHbEqPLoSF7McWtLoH9HqjXeNJUxaiKqSH6cDuH23b6cFz6hfCUit1hk0G
	TCNywWatBwD3/OBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H0gPESO/BntkG0B4FSGoHsx0d2Sq64W+wU6e58nb2w=;
	b=PQ3SPeHbkR498u6YpBNmc6BAyZslVulywJ3CcMI9L/dQlwk2vUqvhoB2Jzl3EJZieOv6Gg
	ryvkLqrkU3fUGjIfyQn7gunbXEvOZuPr+Klak8BBaxSmXULi4k1KX5LfAwEURvBI6jq0f/
	ilnq3b8Eo8C3YG+ZHS8o/+uIBMI9NfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H0gPESO/BntkG0B4FSGoHsx0d2Sq64W+wU6e58nb2w=;
	b=ieXzy1WsmRbQR0KOCAAEMkokIjqUT2C3bv/cY+uBLi+lUt9v8imJrWllq5HhG/bAZZtN60
	5GxU/9v1G7bU1WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0C9813AAA;
	Mon, 30 Sep 2024 08:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ABOwMl1j+mYhHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 30 Sep 2024 08:37:49 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 30 Sep 2024 10:37:17 +0200
Subject: [PATCH slab hotfixes 2/2] kunit: move call to
 kunit_run_all_tests() after rcu_end_inkernel_boot()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-b4-slub-kunit-fix-v1-2-32ca9dbbbc11@suse.cz>
References: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
In-Reply-To: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Cc: Guenter Roeck <linux@roeck-us.net>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Brendan Higgins <brendan.higgins@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=0WnxLPEui3oDtLBzlhAtJkEteadIcsQlNHVOikq11/s=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBm+mNb5kW6gBMYJomoCQCnVJVj2vq4E+KW7TR+P
 v9VoTSjjjuJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZvpjWwAKCRC74LB10kWI
 mmuxCACeREhmlg/rNG4s+kT3WJNgk6FnivDPqNnOL4qEeWBIaPwJLleugyX0FkcYNrF03p70/WB
 pbKNdzte33X1JZ+yutnxQBs0wb59bq0Cy6NJc2h1MRe/zwbNUPZ8T+SrZwg+RzRYF8uOnmi/Evg
 PrgWiuYKvoo8av4sqAUo0r1nd3bu88M4blrWPVYYbX7ws1PlO+zA/c73XJUGI4TGo8xwfi1gJDr
 1Hc6U6Zsx9qCAVg+8sbG7SVeI1SgqHw4mDqc+Mq7lVU+9fO4r5Wky0LH8loHaH7PJadIY5R/sQD
 FtUOXqUHggLFkJ8XP/N5cwnK9/61pYbheifxulWZWjhzRjNr
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.com,google.com,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,kernel.org,gmail.com,vger.kernel.org,google.com,googlegroups.com,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Guenter Roeck reports that the new slub kunit tests added by commit
4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
test_leak_destroy()") cause a lockup on boot on several architectures
when the kunit tests are configured to be built-in and not modules.

These tests invoke kfree_rcu() and kvfree_rcu_barrier() and boot
sequence inspection showed the runner for built-in kunit tests
kunit_run_all_tests() is called before setting system_state to
SYSTEM_RUNNING and calling rcu_end_inkernel_boot(), so this seems like a
likely cause. So while I was unable to reproduce the problem myself,
moving the call to kunit_run_all_tests() a bit later in the boot seems
to have fixed the lockup problem according to Guenter's limited testing.

No kunit tests should be broken by calling the built-in executor a bit
later, as when compiled as modules, they are still executed even later
than this.

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
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index c4778edae7972f512d5eefe8400075ac35a70d1c..7890ebb00e84b8bd7bac28923fb1fe571b3e9ee2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1489,6 +1489,8 @@ static int __ref kernel_init(void *unused)
 
 	rcu_end_inkernel_boot();
 
+	kunit_run_all_tests();
+
 	do_sysctl_args();
 
 	if (ramdisk_execute_command) {
@@ -1579,8 +1581,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
-	kunit_run_all_tests();
-
 	wait_for_initramfs();
 	console_on_rootfs();
 

-- 
2.46.1


