Return-Path: <linux-kselftest+bounces-4787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A0856A47
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4CA1C21DCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D910136667;
	Thu, 15 Feb 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="01FKlZ2e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WSXmafZ0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="01FKlZ2e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WSXmafZ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630E136644;
	Thu, 15 Feb 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016135; cv=none; b=upYz1I8Tzr5raluGBYNiSFsKhtsun5Zo76lHD8JMRKV60XKbso1tM7nIt3A1F/wztKSuVTeiixA4LXN4yvlzXljIQFun+/7s9/otggmr/apqEvQ240YZUGbLG+x7RRYczgrvslG3EnYjNOuvKqkDf8EufhRvLBy/U3pVmxfBPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016135; c=relaxed/simple;
	bh=+0UJSlfWMmd8U6AtuQoamLR1RlagrGh1ENR1LLeXmV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPXrU+ltATeQLte69IdQekO2f5eK6cpI1id0hrJsylNl5AwVcvpKs5NOsnypU410lvPuF1XMzNaX9JDVnZoA+X+2z8pI8BAV9xG2nTxLsCAVZf3NyYcjLPaBXvum5aW2Z3dPLRK7N89YTklHWG0TEJoRxvRaPwwVKi1hEf/342k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=01FKlZ2e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WSXmafZ0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=01FKlZ2e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WSXmafZ0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out1.suse.de (Postfix) with ESMTP id B7AF9211D2;
	Thu, 15 Feb 2024 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708016129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HHI73AbiDsgFPpKe9TkJUmUEu7LiJywR0x6tJv++5SM=;
	b=01FKlZ2eJYvRpCDFGs5WClGtaZcibEiXNB0fRuhPAyZ/6JlJfm4WBfckCeupeigq9EY6dl
	mWqEhwKhNymwYGSAkpp7vnGiEXn8K8HNC4jVVdbifGph0NAjE4TwBBaClQqnWa2WVovLYq
	mZBpOIlYSGGg0hb/TleNeb3giUfHJbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708016129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HHI73AbiDsgFPpKe9TkJUmUEu7LiJywR0x6tJv++5SM=;
	b=WSXmafZ0ynuqlWv6uACXEuFrkDxjS/Gfy6KOGkN0ZNEa+YflSpYEZsCrYv8wN/E9FmLvAo
	UIxC/uLFDza3twDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708016129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HHI73AbiDsgFPpKe9TkJUmUEu7LiJywR0x6tJv++5SM=;
	b=01FKlZ2eJYvRpCDFGs5WClGtaZcibEiXNB0fRuhPAyZ/6JlJfm4WBfckCeupeigq9EY6dl
	mWqEhwKhNymwYGSAkpp7vnGiEXn8K8HNC4jVVdbifGph0NAjE4TwBBaClQqnWa2WVovLYq
	mZBpOIlYSGGg0hb/TleNeb3giUfHJbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708016129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HHI73AbiDsgFPpKe9TkJUmUEu7LiJywR0x6tJv++5SM=;
	b=WSXmafZ0ynuqlWv6uACXEuFrkDxjS/Gfy6KOGkN0ZNEa+YflSpYEZsCrYv8wN/E9FmLvAo
	UIxC/uLFDza3twDQ==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: root <root@jostaberry-6.arch.suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: powerpc: Add header symlinks for building papr character device tests
Date: Thu, 15 Feb 2024 17:55:21 +0100
Message-ID: <20240215165527.23684-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.55 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[jostaberry-6.arch.suse.de,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com,suse.de,vger.kernel.org];
	 BAYES_HAM(-0.35)[76.37%]
X-Spam-Level: ****
X-Spam-Score: 4.55
X-Spam-Flag: NO

From: root <root@jostaberry-6.arch.suse.de>

Without the headers the tests don't build.

Fixes: 9118c5d32bdd ("powerpc/selftests: Add test for papr-vpd")
Fixes: 76b2ec3faeaa ("powerpc/selftests: Add test for papr-sysparm")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/testing/selftests/powerpc/include/asm/papr-miscdev.h | 1 +
 tools/testing/selftests/powerpc/include/asm/papr-sysparm.h | 1 +
 tools/testing/selftests/powerpc/include/asm/papr-vpd.h     | 1 +
 3 files changed, 3 insertions(+)
 create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-miscdev.h
 create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-sysparm.h
 create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-vpd.h

diff --git a/tools/testing/selftests/powerpc/include/asm/papr-miscdev.h b/tools/testing/selftests/powerpc/include/asm/papr-miscdev.h
new file mode 120000
index 000000000000..0f811020354d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/include/asm/papr-miscdev.h
@@ -0,0 +1 @@
+../../../../../../arch/powerpc/include/uapi/asm/papr-miscdev.h
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/include/asm/papr-sysparm.h b/tools/testing/selftests/powerpc/include/asm/papr-sysparm.h
new file mode 120000
index 000000000000..6355e122245e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/include/asm/papr-sysparm.h
@@ -0,0 +1 @@
+../../../../../../arch/powerpc/include/uapi/asm/papr-sysparm.h
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/include/asm/papr-vpd.h b/tools/testing/selftests/powerpc/include/asm/papr-vpd.h
new file mode 120000
index 000000000000..403ddec6b422
--- /dev/null
+++ b/tools/testing/selftests/powerpc/include/asm/papr-vpd.h
@@ -0,0 +1 @@
+../../../../../../arch/powerpc/include/uapi/asm/papr-vpd.h
\ No newline at end of file
-- 
2.43.0


