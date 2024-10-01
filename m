Return-Path: <linux-kselftest+bounces-18798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0198F98C34C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA94B25676
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC21CCB23;
	Tue,  1 Oct 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iaEL4Lld";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tEWKbSau";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LjpeQNy8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DHkhsOPK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD01CC8B1;
	Tue,  1 Oct 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799661; cv=none; b=oHFzON6O5B8Aj/busgCpfX1TrALRnamX0Glx8dWwktZsQj3+JDetDoJEjDDsnmGGPXFVdb3Bok+fHC7bgoFOW0tXzJbKpA12yIr2BAAHayVebJ4itxS/+EdDivx6HjfqI9pHPzsjsW+ekHLXBeTSIpqSvEVXk90j5WOSubfVxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799661; c=relaxed/simple;
	bh=os0gbSo3qZ6ketnZ8D4kNtVNoVerxUdP32lLBlRDOc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AtImntZ2ZXZ/xEP16zOxtxyfWT6yj6V0WtoKYNYgKkOk5el5iLN7AfBSs5RbAA1d0XrLp25yt/dUPIlknJdk7FZMl+GIn4lS3VrWQJ+nnj9yLgeW+QDScZCfdA6I9i3QsXf3xtNMy3eqM5fJ6HHPC4iNXySShMBTcQXFAuHS+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iaEL4Lld; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tEWKbSau; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LjpeQNy8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DHkhsOPK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B56F221B52;
	Tue,  1 Oct 2024 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727799657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3PhvcmkdUaKSuNudlm3dhlTOitdcFDsZnftiGiVqUw=;
	b=iaEL4Lld++ApSkAycDIwCObVHeLo57S2Juic3KKfsJng0AKagrzk3SuSVTwNlNwmLemyVi
	n4JQjcitu47HHRectmuqyBkgu8S55gKxgiTdgZW/OD51Ryb4aVsGsWGsG+QuOMMYhMvj9z
	0b8eJDcw43cyfdPOv+qVf+e286g8D10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727799657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3PhvcmkdUaKSuNudlm3dhlTOitdcFDsZnftiGiVqUw=;
	b=tEWKbSauBTSa3OKgNTEk7pwfR+qwoeg7UgC3IJpuvy14YNgsiR0PX07dI302GpJ8ZcOQqb
	Ol+ht/PTuLfNOHDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727799656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3PhvcmkdUaKSuNudlm3dhlTOitdcFDsZnftiGiVqUw=;
	b=LjpeQNy8M9fyrecwMvXMgrlKRj9pxfifObq0F/b5NqbUiF6NszDrbHjGtzDzno2gfe2s2r
	w+tE3xSY7sGthiTprodwALIDHqjFit5xDkaAGnngfGNs2q/Gr8n59rnjS6EbIORrBwfg6f
	+gUeRQK5TPIm/Fyt0Uw7ltTerKRKX4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727799656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3PhvcmkdUaKSuNudlm3dhlTOitdcFDsZnftiGiVqUw=;
	b=DHkhsOPK5Ol1ydtCnAMX5wm0uxCplIcMWDZdJ10GEI4Qms/wHl2gZGzfl7ZLXkFUw0P6HP
	yC8k4Z4IK9+wbBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93C0513A6E;
	Tue,  1 Oct 2024 16:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gpe9I2gh/GaHRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Oct 2024 16:20:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH slab hotfixes v2 0/2] slub kunit tests fixes for 6.12
Date: Tue, 01 Oct 2024 18:20:47 +0200
Message-Id: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8h/GYC/32NTQ6CMBCFr0Jm7Zi2NBpceQ/DotMWO5GA6QBRC
 Xe3wb3L9/e9FSRmjgKXaoUcFxYehyLMoQKf3HCPyKFoMMpY1dQKyaL0M+FjHnjCjl946sjZoL0
 +WwNl98yx2DvzBtI7qtI4/Zy2xIllGvN7f1z0XvoDXzQqrI13TSAir/VVZolH/4F227YvY3sYF
 L8AAAA=
X-Change-ID: 20240930-b4-slub-kunit-fix-6fba4d1c1742
To: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 kernel test robot <oliver.sang@intel.com>, 
 Guenter Roeck <linux@roeck-us.net>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 rcu@vger.kernel.org, David Gow <davidgow@google.com>, 
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,suse.cz,intel.com,roeck-us.net,kernel.org,google.com,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The SLUB changes for 6.12 included new kunit tests that resulted in
noisy warnings, which we normally suppress, and a boot lockup in some
configurations in case the kunit tests are built-in.

The warnings are addressed in Patch 1.

The lockups I couldn't reproduce, but inspecting boot initialization
order makes me suspect the test_kfree_rcu() calling kfree_rcu() which is
too early before RCU finishes initialization.  Moving the exection later
was tried but broke tests marking their code as __init so Patch 2 skips
the test when the slub kunit tests are  built-in.

So these are now fixes for 4e1c44b3db79 ("kunit, slub: add
test_kfree_rcu() and test_leak_destroy()")

The plan is to take the fixes via slab tree for a 6.12 rcX.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v2:
- patch 2 skips the test when built-in instead of moving kunit execution
  later
- Link to v1: https://lore.kernel.org/r/20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz

---
Vlastimil Babka (2):
      mm, slab: suppress warnings in test_leak_destroy kunit test
      slub/kunit: skip test_kfree_rcu when the slub kunit test is built-in

 lib/slub_kunit.c | 18 ++++++++++++------
 mm/slab.h        |  6 ++++++
 mm/slab_common.c |  5 +++--
 mm/slub.c        |  5 +++--
 4 files changed, 24 insertions(+), 10 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-b4-slub-kunit-fix-6fba4d1c1742

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


