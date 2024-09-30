Return-Path: <linux-kselftest+bounces-18588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249B989CE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8861D284790
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A517BB35;
	Mon, 30 Sep 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQFPm0ln";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0z87cj0H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQFPm0ln";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0z87cj0H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7F3FB0E;
	Mon, 30 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685473; cv=none; b=hKAQeaSGN198P00D7gRBdhDeBuKNgchHD0r/RlxrxjZwJngRqc/e7ZlmB4buunYBJqUcpRV8lEsW9a5krojuuWIv7upFJZOxYooUHLuu31SEocDnj+uuOX6vVVOHyLyAg2vbR9uWtntWh4TpBd4mKUrBX+a7VGZa2tr32Y9U+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685473; c=relaxed/simple;
	bh=TBIV+URHv1FdKGYyHeQbsxrBmZ+Bh312UVwmuZfY2NE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ahcyxjYttcI4vzEyitFlZUNpjDq44Z2qjOOIhf6LiwdT8wCyrZ9SQDafdU6wxRJaXb4zbyRP4u04PnDRD6NfYwOrrL4MmA/66dBXgTNuaXlHAM8H253xaWQQNBPJ6r69Toph6rKuF5+WQG1hSD/9ubx/2kv5zaIqdmX2qg3A3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQFPm0ln; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0z87cj0H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQFPm0ln; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0z87cj0H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3C12216F2;
	Mon, 30 Sep 2024 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9F9YjQEJflSAgogUDfRl6vMT3iaVqscBAMrkCSe/tcs=;
	b=VQFPm0ln6EMEIhg8R38aZrROCVV2HGVsPuwbHO8RDlizDB07NcaGx8vXZPsKxVwME7r3Ni
	P/Y/QX6tnm8LZTv9raekzHSoF+sOsYVdfy2ONzsgWjG5r4tMAkc8n9dThDXfdTJDpxBw/q
	PpuanjAKQhzpFrYYw+/pfxiX/5t8n34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9F9YjQEJflSAgogUDfRl6vMT3iaVqscBAMrkCSe/tcs=;
	b=0z87cj0H9kLzyWbQVNC++Suat0IJlmeoJ21/v5rDr8ZxQfP9TrdMubu7WJ2gKQckAXn53C
	fsyiLbKVgL721NAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VQFPm0ln;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0z87cj0H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9F9YjQEJflSAgogUDfRl6vMT3iaVqscBAMrkCSe/tcs=;
	b=VQFPm0ln6EMEIhg8R38aZrROCVV2HGVsPuwbHO8RDlizDB07NcaGx8vXZPsKxVwME7r3Ni
	P/Y/QX6tnm8LZTv9raekzHSoF+sOsYVdfy2ONzsgWjG5r4tMAkc8n9dThDXfdTJDpxBw/q
	PpuanjAKQhzpFrYYw+/pfxiX/5t8n34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9F9YjQEJflSAgogUDfRl6vMT3iaVqscBAMrkCSe/tcs=;
	b=0z87cj0H9kLzyWbQVNC++Suat0IJlmeoJ21/v5rDr8ZxQfP9TrdMubu7WJ2gKQckAXn53C
	fsyiLbKVgL721NAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF0113A8B;
	Mon, 30 Sep 2024 08:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /VG/Jl1j+mYhHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 30 Sep 2024 08:37:49 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH slab hotfixes 0/2] slub kunit tests fixes for 6.12
Date: Mon, 30 Sep 2024 10:37:15 +0200
Message-Id: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADtj+mYC/yWMQQqEMAwAv1JyNtB2y4p+RTy0GjUoVRoVQfz7F
 vc4AzM3CCUmgVrdkOhk4TVmMIWCbvJxJOQ+M1htna4+GoNDWY6A8xF5x4Ev/A7Bu950pnQWcrc
 lyvp9NiCLD2pa979pn+cHOcUlinIAAAA=
X-Change-ID: 20240930-b4-slub-kunit-fix-6fba4d1c1742
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
 Guenter Roeck <linux@roeck-us.net>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 rcu@vger.kernel.org, David Gow <davidgow@google.com>, 
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=TBIV+URHv1FdKGYyHeQbsxrBmZ+Bh312UVwmuZfY2NE=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBm+mNTZ364+mQdK/3uDVoTN9uln0OvX42XSvP/v
 S8tG4oiwAuJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZvpjUwAKCRC74LB10kWI
 mtNgCACdBeyDV9q9gDZB2VB6AwRjsZDMJ2nVbWsEajf1tYbUlKQki1FMk4qKFmRIFA0FO47Yyc/
 36p3Ub+mQeobJ8xBFXJDJJDmyQZYp1W3btfFsJizHuVrKoQV33F4vInTnSLBgps6ES4Qq7mAAEm
 8XEJJeoO9mxwCqkn3d3GQE99zE2tb221YmQm8W0CvE7YYFMN4w0hrPoXpVaukLgfAlX7P3PJtjB
 yHgdogMlBWBlLqg7N9W1q+CEANohsrG8FtaZRzPOQZF3nS2kn1vu8il3IKZoy9wQ3zg0QpaQslZ
 RqP0CyjbWWLhXZUqrXzkt8eBgBCXEo1LBwqCyaS2yEfCvfVa
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Queue-Id: C3C12216F2
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,roeck-us.net,kernel.org,gmail.com,vger.kernel.org,google.com,googlegroups.com,linux.dev];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.com,google.com,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The SLUB changes for 6.12 included new kunit tests that resulted in
noisy warnings, which we normally suppress, and a boot lockup in some
configurations in case the kunit tests are built-in.

The warnings are addressed in Patch 1.

The lockups I couldn't reproduce, but inspecting boot initialization
order makes me suspect the tests (which call few RCU operations) are
being executed a bit too early before RCU finishes initialization.
Moving the exection later seems to do the trick, so I'd like to ask
kunit folks to ack this change (Patch 2). If RCU folks have any
insights, it would be welcome too.

So these are now fixes for 4e1c44b3db79 ("kunit, slub: add
test_kfree_rcu() and test_leak_destroy()")
Once sent as a full patch, I also want to include comment fixes from
Ulad for kvfree_rcu_queue_batch():
https://lore.kernel.org/all/CA%2BKHdyV%3D0dpJX_v_tcuTQ-_ree-Yb9ch3F_HqfT4YnH8%3DzyWng@mail.gmail.com/

The plan is to take the fixes via slab tree for a 6.12 rcX.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (2):
      mm, slab: suppress warnings in test_leak_destroy kunit test
      kunit: move call to kunit_run_all_tests() after rcu_end_inkernel_boot()

 init/main.c      | 4 ++--
 lib/slub_kunit.c | 4 ++--
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 5 +++--
 mm/slub.c        | 5 +++--
 5 files changed, 16 insertions(+), 8 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-b4-slub-kunit-fix-6fba4d1c1742

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


