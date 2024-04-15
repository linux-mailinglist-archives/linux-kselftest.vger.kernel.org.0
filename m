Return-Path: <linux-kselftest+bounces-7993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71338A5679
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B076280ED0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5A78C90;
	Mon, 15 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aYa+4+LD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806178C6F;
	Mon, 15 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195162; cv=none; b=GR6HSDvMcMjkVXOYDQng4SSUeAUpkkcPdWLoA0FLPcXiSb22c+nC8MFQLfmlR7saHyIKw2tiD5Qha9LUVtLI1MDx0Ep+9c9NU8ggP3LAaHa7JO+Uye7YpnU9W+clJOOi57CWk9uuVZumj4P3FVm0GcQ71JDlmezbSsoRSTxB1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195162; c=relaxed/simple;
	bh=vTMM4G0Y4RPv3M8sa5vKLmKrOmU51iOrPL7k4DC/0ao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NjpeSkF8sOLc1A5JA2gKMoj6Bk1lfjlNm15ZYFTwEPmXLtkE7szkzD0XcCJFycsgiHLf+eA0pu83XFXmnxWCloeqct2XuYVDMw1NICHqZ+37e9hnnA9HPa6S0c4ArzeJVi2n/R2h/6bOAWRro39yheRWDLEI3bRvTpbviDx+sbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aYa+4+LD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713195156;
	bh=vTMM4G0Y4RPv3M8sa5vKLmKrOmU51iOrPL7k4DC/0ao=;
	h=From:Subject:Date:To:Cc:From;
	b=aYa+4+LDiV1+WLSAKh0gVw2BUV4UptqCGb0tABhP0DfFlOZVssYRaTFi2bVgUmAZV
	 O7YfhPme3UndzvJNZ1fgvL4Y9+oPpGzhSLcZsDqcxxe/eRe6CmnpjJvfHzzgRcW+CS
	 rnSRCAOLQwGzKE233wouciInKVhxmtYUEzPDzr0tfthCr0WAIb4JB1Nr35InG/EkXa
	 MUz9vvOameC3jUiv3ki9U2HKhX2bN64sY4yhPPWq2QL8QfOWRxww8xkyPIwT9U5Mxl
	 TRcGnRllgIfkTwVZ8hTeTIx3eIFth2uQGsmt0RgXRBljWvnbuiMtoa+jQjmzAjVopi
	 E83UPAxKZzmOw==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A6BC3780022;
	Mon, 15 Apr 2024 15:32:35 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/2] selftests: Make sh helper and power supply test
 POSIX-compliant
Date: Mon, 15 Apr 2024 11:32:14 -0400
Message-Id: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH5IHWYC/x3MwQpAQBRG4VfRXbuFTA2vIgvxD7fENBeR5t1Nl
 t/inJcUQaDUZi8FXKKybwllntG4DNsMlimZqqKqi7o0rKf368OK1R3Qg/2ucrMuPABNMzprYB2
 l3Ac4uf9118f4AaEhqzlqAAAA
To: Shuah Khan <shuah@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, 
 Mike Looijmans <mike.looijmans@topic.nl>, kernel@collabora.com, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

The patches in this series make the ktap sh helper and the power_supply
selftest POSIX-compliant. Tested with bash, dash and busybox ash.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (2):
      selftests: ktap_helpers: Make it POSIX-compliant
      selftests: power_supply: Make it POSIX-compliant

 tools/testing/selftests/kselftest/ktap_helpers.sh                    | 4 ++--
 tools/testing/selftests/power_supply/test_power_supply_properties.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 7e74ee01d1754156ed3706b61e793fbd46f5cd7b
change-id: 20240415-supply-selftest-posix-sh-aee99cf85e8f

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


