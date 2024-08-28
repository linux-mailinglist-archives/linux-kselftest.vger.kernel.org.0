Return-Path: <linux-kselftest+bounces-16534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024969625F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45BA284A2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BDD16D307;
	Wed, 28 Aug 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mEMkloe8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MfN8i1Nh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0iVyuTYF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DKNLhB3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDB15B54E;
	Wed, 28 Aug 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844222; cv=none; b=MLTbXTAKAX1Wan7HFFaipyWuorX3yn0x0TIetB3/jOuuEKQ/ZYHMfylJ2VHbJgOz/bcyQUEj5pmKZ0cmQeLE3h63mtjE+ZfI9I2GyVwa2fZXAN2VLWvBfBUOWJgqfA7uMPtVA2aTFBhEcpJn/3QKz9uS3GsDZM72gEgeklTdd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844222; c=relaxed/simple;
	bh=woMfM9462eOJrwEHB3r89jnJI7ptsCPZp79CgwGCT4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUYFnBaPdj0pDWhOKXG8GPBXtKj8rOdf64tRd9oUJzDpWDAIT8FZpjbbNDIGSK/CN5tYejXkuJ17Vb4IlDsDJsCzzHeMVPCJrG363jJDDjRZiC6ntEZmMJxMyAj8hvvQ1fiSdgVhY72fvygWaDsL/bHYS4DUbenglYDPx5c4ZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mEMkloe8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MfN8i1Nh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0iVyuTYF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DKNLhB3p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out2.suse.de (Postfix) with ESMTP id DDD861FC11;
	Wed, 28 Aug 2024 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724844219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS4TScwxClFiQ42wXyGSbjTyqoV2glgYXGELYPtGsIg=;
	b=mEMkloe8uBVVT65y8ATG3DiHAAVImkLXI9lDirmuTeKgh2rFDbXKbQPRFjonMoIPKDTOmD
	v3TnsT8rKiBNZxLlJiyW/bRQFNSAWMrbYgbMYlS8JdV5QHxFTFNk6B0UXz0gygH2M7Q/EE
	eLVSGdwZrXuyISBg8OcXH87M7K6dBVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724844219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS4TScwxClFiQ42wXyGSbjTyqoV2glgYXGELYPtGsIg=;
	b=MfN8i1NhZKFqEHz2fh+F4GZwU/JhkaoOfEUsGv2WkHjuPsMjQA18HArQFTV63SQyTDa9EE
	uya6Y0L68/ffM2DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724844218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS4TScwxClFiQ42wXyGSbjTyqoV2glgYXGELYPtGsIg=;
	b=0iVyuTYFlBgdulA+mST/oUVSrgTpEQdFdfa8adNsEQ1qNNGQIExpE4mSBwNXGiiktB9P3s
	REf5AhuwPFq+jB83IMPiJINNZ6FSbZVxkyk3762SO6csfVUOTjpot6HRXpYOV3twir9hPt
	2POKkYtjuzvJjk7xL+lcIimRDAgx7AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724844218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS4TScwxClFiQ42wXyGSbjTyqoV2glgYXGELYPtGsIg=;
	b=DKNLhB3pEiloMcO4Z2CGHXoLoLC99guHQ3I6cj7US3kbnqTTrMSZhUZlZ87tXKKDlSELsH
	Yx1AzSkpjlfrn9AA==
From: Michal Suchanek <msuchanek@suse.de>
To: linux-integrity@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: tpm2: test_smoke: Run only when TPM2 is avaialable.
Date: Wed, 28 Aug 2024 13:23:20 +0200
Message-ID: <1794c9c1d60a34ebae28d3a18b408765e955907b.1724842902.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <52c629ebbfc8f5218a90fa539f816c8555cb552a.1724842902.git.msuchanek@suse.de>
References: <52c629ebbfc8f5218a90fa539f816c8555cb552a.1724842902.git.msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 

Since Linux 5.6 tpm_version_major sysfs file is avaialble which gives
the TPM version.

Using this file the test can be skipped on systems with TPM 1.2.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/testing/selftests/tpm2/test_smoke.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 58af963e5b55..e5e3386077d9 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -5,5 +5,7 @@
 ksft_skip=4
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
+read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
+[ "$tpm_version" == 2 ] || exit $ksft_skip
 
 python3 -m unittest -v tpm2_tests.SmokeTest
-- 
2.46.0


