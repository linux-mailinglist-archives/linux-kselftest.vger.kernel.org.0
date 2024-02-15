Return-Path: <linux-kselftest+bounces-4790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE10856C2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBA1F23F10
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037A1386C5;
	Thu, 15 Feb 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EwiE0K2O";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EwiE0K2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944131386AA;
	Thu, 15 Feb 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020763; cv=none; b=ev8f1PbIG2DS+w2UnKEeCK8+WT/ZEiFCCDViasSlqA1+7nujqYGFWSh7iFv6S9jWP6z0Mj69xMgo0wq1H9qWv2quuEvMp66uhJPHBU4HW/27Bf80N/vN/BkTMX7j2BtjAYHDJBIFA/34wXymSq9ygEnCmVjOdpSM/kfec1wuGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020763; c=relaxed/simple;
	bh=kTwshfoQak1CLS1xr5RDYhHCXHVCaUTqaWSSjq1FYO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H43CatjdH+cVZ8dGUWib4oxdr4e8s3kEGuledBuNYaBDM4n48lgHj1XxVMi13/FVwDg2rUIU7lt2L/n1lpVBTak7GPU7GsCt7eIChncBaTXQOeTlOyN3NDLhzKcxLNwYJi1XA4Nhe2FDOZqVhtP2DH5Ct5va9spKuz6mAA9VhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EwiE0K2O; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EwiE0K2O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CC5A21F3D;
	Thu, 15 Feb 2024 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708020758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j7vlg+mXthjoDP5TGpttL/27seM8QE8FtozgAP/kMH8=;
	b=EwiE0K2Ow2LZeS7eXltqaLEj9SMPGfxJrNe2JVnWgYyvTo01hEuTbNT2lQZwvjA+eKchPB
	la7mFQmQgCaTCJNelaLArsRt4UXxkPnqKZDn1CzJFcES5idTDpyjNUra0XkVjZf5aLPMkK
	6SiDSaNw68slicU+EgqTYjlsPOt3gyE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708020758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j7vlg+mXthjoDP5TGpttL/27seM8QE8FtozgAP/kMH8=;
	b=EwiE0K2Ow2LZeS7eXltqaLEj9SMPGfxJrNe2JVnWgYyvTo01hEuTbNT2lQZwvjA+eKchPB
	la7mFQmQgCaTCJNelaLArsRt4UXxkPnqKZDn1CzJFcES5idTDpyjNUra0XkVjZf5aLPMkK
	6SiDSaNw68slicU+EgqTYjlsPOt3gyE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D40171346A;
	Thu, 15 Feb 2024 18:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bCyZJhVUzmXsVwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Thu, 15 Feb 2024 18:12:37 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/3] Improvements to livepatch kselftests on top of
 kselftest-next
Date: Thu, 15 Feb 2024 15:12:19 -0300
Message-Id: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANUzmUC/x3LQQqAIBBA0avIrBtQM4KuEi2yxhoQEyciiO6et
 Hx8/gNChUlgUA8Uulj4SBWmUbDsc9oIea0Gq63T1nQYMwrFcJKcgoFvEuxX52ffLro3FuqYC/2
 hfuP0vh9mpdCEZAAAAA==
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708020755; l=902;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=kTwshfoQak1CLS1xr5RDYhHCXHVCaUTqaWSSjq1FYO8=;
 b=x//lwpiP6AjTZUOwc38wQtKsdeWY8fqUEr6j1Ojeo9McMSm2fUgZ4BNJuwJlBY+M03wUDk9Hs
 HnlE82J0mdSBx2V3acBHxucz8S1SQ4UQreah5zg+uJ5vDLuuDdyXfis
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

The changes doesn't change the current functionality. The changes on
lib.mk are both for simplification and also clarification, like in the
case of not handling TEST_GEN_MODS_DIR directly.

These changes apply on top of the current kselftest-next branch. Please
review!

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (3):
      selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
      selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
      selftests: livepatch: Add initial .gitignore

 tools/testing/selftests/lib.mk               | 19 +++++++------------
 tools/testing/selftests/livepatch/.gitignore |  1 +
 2 files changed, 8 insertions(+), 12 deletions(-)
---
base-commit: 345e8abe4c355bc24bab3f4a5634122e55be8665
change-id: 20240215-lp-selftests-fixes-7d4bab3c0712

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


