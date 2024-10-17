Return-Path: <linux-kselftest+bounces-20048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15EE9A2E19
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53A7B2231D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7080B227B80;
	Thu, 17 Oct 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sWb7UstH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sWb7UstH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4A33997;
	Thu, 17 Oct 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195308; cv=none; b=hDSXnkNQQ1V3mtt9+Xk03aXWw0t9Ed7JmhUtfsMLZ3Dbzhn2DDIlbBg9jN5PSNZbgqJH6K7DJoQUoZJzjyO+n8wSDyykNiNPcp16j818CEBfakab3gIyP/suPhbOBdd7uvRDhcL/KPUrGWZs6eQbV0aS7Dp53QFZ4n0XkO73+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195308; c=relaxed/simple;
	bh=uVcG2cVOtJxPXJgrNAGPg5moJTK0fI/I7Akda/Fu3yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUA+TD11KXf4tiRrvqXrEmvABpt9OdlCnrX2dH+KXO7zV3oXhmzTXq1rfzZ//ZzPyQvEWIAdjA/wYP/vl8uBS6mTjWcegE7jG/ymzt3V2wNCFFoFhREx5Tvpa/NxYEiiIxvPh1dtgtY58uNM5IgEHyZ5ilOMuClexRh7jpOQn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sWb7UstH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sWb7UstH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73B0F21DB6;
	Thu, 17 Oct 2024 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729195299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QcEClRU86UuFjcjFYZ55ePdo1liVzL+Hv3FxGUse45s=;
	b=sWb7UstHI7aJUr3rherlpMfR1VOqqyUcjJj2orYlOHCxP6bXKhiUYpAoLp7wBQ2zfsoDUp
	sT247bKtgd2+KTQ5saHGDI4J6pPNNtjk28gp5ubqi5UtTi540a67q3o/1n67+luBJagL3I
	vox+s4DZ5rO4F6UoQbNO1DMkSCC9sG8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729195299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QcEClRU86UuFjcjFYZ55ePdo1liVzL+Hv3FxGUse45s=;
	b=sWb7UstHI7aJUr3rherlpMfR1VOqqyUcjJj2orYlOHCxP6bXKhiUYpAoLp7wBQ2zfsoDUp
	sT247bKtgd2+KTQ5saHGDI4J6pPNNtjk28gp5ubqi5UtTi540a67q3o/1n67+luBJagL3I
	vox+s4DZ5rO4F6UoQbNO1DMkSCC9sG8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BD3A13A53;
	Thu, 17 Oct 2024 20:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bZeHESNtEWf1AwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Thu, 17 Oct 2024 20:01:39 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v5 0/3] selftests: livepatch: test livepatching a kprobed function
Date: Thu, 17 Oct 2024 22:01:29 +0200
Message-ID: <20241017200132.21946-1-mvetter@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Thanks for all the reviews.

V5:
Replace /sys/kernel/livepatch also in other/already existing tests.
Improve commit message of 3rd patch.

V4:
Use variable for /sys/kernel/debug.
Be consistent with "" around variables.
Fix path in commit message to /sys/kernel/debug/kprobes/enabled.

V3:
Save and restore kprobe state also when test fails, by integrating it
into setup_config() and cleanup().
Rename SYSFS variables in a more logical way.
Sort test modules in alphabetical order.
Rename module description.

V2:
Save and restore kprobe state.

Michael Vetter (3):
  selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
  selftests: livepatch: save and restore kprobe state
  selftests: livepatch: test livepatching a kprobed function

 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/functions.sh  | 29 +++++----
 .../selftests/livepatch/test-callbacks.sh     | 24 +++----
 .../selftests/livepatch/test-ftrace.sh        |  2 +-
 .../selftests/livepatch/test-kprobe.sh        | 62 +++++++++++++++++++
 .../selftests/livepatch/test-livepatch.sh     | 12 ++--
 .../testing/selftests/livepatch/test-state.sh |  8 +--
 .../selftests/livepatch/test-syscall.sh       |  2 +-
 .../testing/selftests/livepatch/test-sysfs.sh |  8 +--
 .../selftests/livepatch/test_modules/Makefile |  3 +-
 .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
 11 files changed, 150 insertions(+), 41 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c

-- 
2.47.0


