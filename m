Return-Path: <linux-kselftest+bounces-5202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B385E455
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAB91C219CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E18526E;
	Wed, 21 Feb 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="erenU/EI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="erenU/EI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA47F7EA;
	Wed, 21 Feb 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535838; cv=none; b=uwxtP6X1puqxxvYrkAi35c2ounL4pPzqhZ0XwbF79s0Beo1PoUwJ3Nwu+gUnG2zxv5vhnHvaLx4BBwrRr9mje0acpQS7if3GzvsiLI26uh1qvbyLmGop3dqS3/nhj7oqQJS3EACpogTMrpP0qiVXaUrRzKJtR13An4Y7V4YT56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535838; c=relaxed/simple;
	bh=nS/ZyedR6nH3JtZFpVfJkjI78xte1D6C4RPjQY5fx1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tDCLPe0NQIna2u9l058dILn0iWs8tBaACafjq5iQUT2vcu0L+8oAN1yOFPGAjlRBMdK3sg0QbNgGc0tmosJ9uv1Ftlaqw69QUuwVTiyXtMPByjjJu5YGX50Pf9Hg0Sri4gYS1Qd4F6aUZRFl5FqZfh7Ex9iyjTTLQt/55zlncL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=erenU/EI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=erenU/EI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B42ED1FB73;
	Wed, 21 Feb 2024 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708535833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/NN2+sq1xAVLXm/JkL3fp/m2niJueXoLh/i76v1f6HM=;
	b=erenU/EI2kK79/+VjbTDGnWWYfOzm70d/lYQleCEHRmb9Sa90mXWWKxaN3E8j7IL/RE6pF
	XKmXrp7Z20ddG05Na36FCJEhPPmhO5AnBCu2DETHymiEgVUvrcxD187eVSMnCIJqp1QXBD
	Wo73jHUfqoM20nAPR9PI1AJc3GYQyxY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708535833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/NN2+sq1xAVLXm/JkL3fp/m2niJueXoLh/i76v1f6HM=;
	b=erenU/EI2kK79/+VjbTDGnWWYfOzm70d/lYQleCEHRmb9Sa90mXWWKxaN3E8j7IL/RE6pF
	XKmXrp7Z20ddG05Na36FCJEhPPmhO5AnBCu2DETHymiEgVUvrcxD187eVSMnCIJqp1QXBD
	Wo73jHUfqoM20nAPR9PI1AJc3GYQyxY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 275B513A25;
	Wed, 21 Feb 2024 17:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Mbv6Nxgw1mUIcQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 17:17:12 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/4] Improvements to livepatch kselftests on top of
 kselftest-next
Date: Wed, 21 Feb 2024 14:17:02 -0300
Message-Id: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4w1mUC/32NQQ6CMBBFr0Jm7Zi2FlFW3sOwgHYqTRBIpzYa0
 rtbOYDL93/e/xswBU8MbbVBoOTZL3MBdajAjP38IPS2MCihtFCyxmlFpslF4sjo/JsYG6uHfjg
 Z0UgFRVwD7UXx7l3h0XNcwmf/SPKX/p1LEgVerk73Z1cba82NX0xHszyhyzl/AT4GEcmzAAAA
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708535830; l=1557;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=nS/ZyedR6nH3JtZFpVfJkjI78xte1D6C4RPjQY5fx1o=;
 b=Tp+GghEI83ax7qFfhbqafKjq2aCbkMAEFZIyyXNaLDXTffEFAH3CyuLWNSY3ebRB8PyfQCLs2
 YNutPLAjDvcCvX7PiGSKF1R8MokMzEIJFrp4XTbhBrOh6PwooYNXGvW
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.08)[63.83%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.18

The changes on lib.mk are both for simplification and also
clarification, like in the case of not handling TEST_GEN_MODS_DIR
directly. There is a new patch to solve one issue reported by build bot.

These changes apply on top of the current kselftest-next branch. Please
review!

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v2:
- Added a new patch to avoid building the modules/running the tests if
  kernel-devel is not installed. Resolving an issue reported by the
  build bot.
- Reordered the patches, showing the more simple ones first. Besides
  patch 0002, all the other three didn't changed since v1.
- Link to v1: https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com

---
Marcos Paulo de Souza (4):
      selftests: livepatch: Add initial .gitignore
      selftests: livepatch: Avoid running the tests if kernel-devel is missing
      selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
      selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling

 tools/testing/selftests/lib.mk                        | 19 +++++++------------
 tools/testing/selftests/livepatch/.gitignore          |  1 +
 tools/testing/selftests/livepatch/functions.sh        | 13 +++++++++++++
 .../testing/selftests/livepatch/test_modules/Makefile |  6 ++++++
 4 files changed, 27 insertions(+), 12 deletions(-)
---
base-commit: 6f1a214d446b2f2f9c8c4b96755a8f0316ba4436
change-id: 20240215-lp-selftests-fixes-7d4bab3c0712

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


