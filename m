Return-Path: <linux-kselftest+bounces-25316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19CEA20EBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219531884ABD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B21DE2C7;
	Tue, 28 Jan 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hg1LFN2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6BE1A239D
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082348; cv=none; b=SVuSJ1Z0KbnIfZlbjqfXI3zdF0WJYWKAE9gFygHat/xaTgHPhchRStok1xva2nhe5LAUNvz6Yi634Op5bN1fdu779UrOowlKJ30TFZ25Nsp1wdmbZX7jPDsib1/CGtAM++x2JDAH3HweL9vFG0Q77T6xOPoBTcAa90NupALD4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082348; c=relaxed/simple;
	bh=LZmOEJdryxrhNyxRVuGtx4pBi0TzeiNuchAG5UbgT1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cF+mPk03cmwH0fLe9Ip8i4JN58dYn2IElllrVoaEPzDma1/RhXe8Gss7fL+Arnhqem+AXBNblfy5Wba1fhWok3A3Y0FoD57AQs6nBxrlV/KYfQ1EDRsy/aBqxPzTSJBonIP5lo1UiVdG4NWVlaUcXs9gSkTh3OsXQoUnmXb5n+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hg1LFN2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xdSqaNifCZv378rC/EnkK3vuTxiqQI7/VJ4PQOg4Jss=;
	b=Hg1LFN2K1BK9mdvmw4jqzO4sh8WRmF+MueJEh0r8zMKc/ln+y1TTB7wvHBkyKPiB7NHs/p
	N6aUjeMplhiRJoHfe0BjcOaTInnFG7tvVkehJVxQxzPWmkl66p/Blt/cqdVS9HCfDDMWXP
	0nbxtDtVdhK8oRkUNk2EU3qw588NsKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-3roPT_tnMjSK_Yf-MkPMcQ-1; Tue,
 28 Jan 2025 11:39:04 -0500
X-MC-Unique: 3roPT_tnMjSK_Yf-MkPMcQ-1
X-Mimecast-MFC-AGG-ID: 3roPT_tnMjSK_Yf-MkPMcQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AB5E1800366;
	Tue, 28 Jan 2025 16:39:03 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48DAD180035E;
	Tue, 28 Jan 2025 16:39:00 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 00/21] bcachefs: eytzinger code
Date: Tue, 28 Jan 2025 17:38:37 +0100
Message-ID: <20250128163859.1883260-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Kent, to continue our discussion from last November, I've gone through
more parts of the eytzinger code and as a result, here are some patches
for you to consider.

What I've not looked at are the eytzinger_to_inorder and
inorder_to_eytzinger functions, as well as the implementation of sort.
Those functions could use a bit more documentation, but the code iself
looks reasonable.


Shuah, I've also had a quick look at converting the tests into kernel
selftests, but that hasn't gone very far because of the lack of support
for basic functions like __fls(), __ffs(), ffz(), and
rounddown_pow_of_two() in selftests.  Are there any plans for making
those kinds of primitives generally available to selftests?


Thanks,
Andreas

Andreas Gruenbacher (21):
  bcachefs: remove dead code in is_aligned
  bcachefs: bch2_blacklist_entries_gc cleanup
  bcachefs: Run the eytzinger tests on modprobe
  bcachefs: EYTZINGER_DEBUG fix
  bcachefs: eytzinger self tests: eytzinger0_for_each loop cleanups
  bcachefs: eytzinger self tests: missing newline termination
  bcachefs: eytzinger self tests: fix cmp_u16 typo
  bcachefs: eytzinger[01]_test improvement
  bcachefs: eytzinger0_find_test improvement
  bcachefs: add eytzinger0_for_each_prev
  bcachefs: improve the eytzinger0_find_le tests
  bcachefs: convert eytzinger0_find to be 1-based
  bcachefs: convert eytzinger0_find_le to be 1-based
  bcachefs: simplify eytzinger0_find_le
  bcachefs: add eytzinger0_find_gt tests
  bcachefs: implement eytzinger0_find_gt directly
  bcachefs: add eytzinger0_find_ge tests
  bcachefs: implement eytzinger0_find_ge directly
  bcachefs: convert eytzinger sort to be 1-based (1)
  bcachefs: convert eytzinger sort to be 1-based (2)
  bcachefs: eytzinger1_{next,prev} cleanup

 fs/bcachefs/eytzinger.c             |  89 +++++++-------
 fs/bcachefs/eytzinger.h             |  99 +++++++--------
 fs/bcachefs/journal_seq_blacklist.c |   7 +-
 fs/bcachefs/super.c                 |   5 +
 fs/bcachefs/util.c                  | 183 +++++++++++++++++++++-------
 fs/bcachefs/util.h                  |   4 +
 6 files changed, 240 insertions(+), 147 deletions(-)

-- 
2.48.1


