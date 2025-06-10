Return-Path: <linux-kselftest+bounces-34556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A07AD3605
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259B97A8235
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA56290D93;
	Tue, 10 Jun 2025 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ixfbwWCC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6IJxC6d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L5LPzlMY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QqvtAvf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCA222598
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558137; cv=none; b=OcAIQBwXkwNM0AFjEMs8fSv5CgNeTG1uhyQq76WOm4VqE1DaILEB67cfc5RwkdkCQYjbF2DeeD6FmYPiZ8XUFfz2UafvdRmAPHNT48GfJz6bqEe8cs5A/82yY7LcdQBz1hGUGiogS3j58M8Nl4mlyd+L71EPYiDfmduLY0dFh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558137; c=relaxed/simple;
	bh=6Z6RdtFgu89+ueb/BzlO5rNh6RCM0Q+YM8hETMjuPs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twfndKZdL6ZZF5lzK0NC5n+bXDNkPjbCS8PwrjTOs1Nf2aRxxBCFmNyEaUu466r1D5ZRTF9OF4XHTzbYqWL59qTbFMxWgQcrekjB5GYpDP/Tuml6tKJ8448qIWbTGbgMgFtLyNKChZI9X+xIiNI5Hkfg2CuXI8B679j+BftoHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ixfbwWCC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i6IJxC6d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L5LPzlMY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QqvtAvf9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEB73211F1;
	Tue, 10 Jun 2025 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749558134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5t7Or3woO7t0abLNHbSdmQ4BjdUmYarkFC/ji/k7CaU=;
	b=ixfbwWCC3PzUi1vbx6ECWYGG8YvFpCea1TbXtwulrv8YZwateQ7vQViedXF53/JBruh3tu
	kfTxcF8+ME2rmjr2xLn/OAyvAuF2q9CLej4L9uw2j5SF3j9R2HmpWbDOTO1uqb+NottzXA
	8hDVe6tV6HuEEV4NTs/AW7Wm3CbDl50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749558134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5t7Or3woO7t0abLNHbSdmQ4BjdUmYarkFC/ji/k7CaU=;
	b=i6IJxC6ddnkW6oBDZ2kteTRPqg4wZvncGS7IDA2XZZbSvcGLXOrtUdkmO2toMTBs51a5dR
	tiZYmRZS6yf5RDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749558132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5t7Or3woO7t0abLNHbSdmQ4BjdUmYarkFC/ji/k7CaU=;
	b=L5LPzlMYm0oPF4xdmxX0mAS5nv5HjJ4HZvVdu1kx44YPEPEAaCIkzlXpOyWPWSL+/JZSvf
	9OhE2SXIGbAxjrC8298kjzpAwd737n0jJdk1gHXFRlGoizJgwA8FLtysp/p9uRmJQETXU9
	cNa7mKTKzyaTC0jF5oalf49B0S1zvdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749558132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5t7Or3woO7t0abLNHbSdmQ4BjdUmYarkFC/ji/k7CaU=;
	b=QqvtAvf9koJ+7uHRAUVpCm+wg63s+4xupMSXzGvHmZT3Aqzplc0oCpIGFIe4s/Llt9zwKi
	X2J1eJV+YfhhgVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F25D413AD9;
	Tue, 10 Jun 2025 12:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Df2N3MjSGgRdQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 10 Jun 2025 12:22:11 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pu Lehui <pulehui@huawei.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Aishwarya <aishwarya.tcv@arm.com>,
	broonie@kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH] selftests/mm: Skip uprobe vma merge test if uprobes are not enabled
Date: Tue, 10 Jun 2025 13:22:09 +0100
Message-ID: <20250610122209.3177587-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,arm.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

If uprobes are not enabled, the test currently fails with:

7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
7153 12:46:54.639306  # # fopen: No such file or directory
7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected
read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma

Skipping is a more sane and friendly behavior here.

Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
Reported-by: Aishwarya <aishwarya.tcv@arm.com>
Closes: https://lore.kernel.org/linux-mm/20250610103729.72440-1-aishwarya.tcv@arm.com/
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 tools/testing/selftests/mm/merge.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index bbae66fc5038..cc26480098ae 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -470,7 +470,9 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
 	ASSERT_GE(fd, 0);
 
 	ASSERT_EQ(ftruncate(fd, page_size), 0);
-	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
+	if (read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) != 0) {
+		SKIP(goto out, "Failed to read uprobe sysfs file, skipping");
+	}
 
 	memset(&attr, 0, attr_sz);
 	attr.size = attr_sz;
@@ -491,6 +493,7 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
 	ASSERT_NE(mremap(ptr2, page_size, page_size,
 			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
 
+out:
 	close(fd);
 	remove(probe_file);
 }
-- 
2.49.0


