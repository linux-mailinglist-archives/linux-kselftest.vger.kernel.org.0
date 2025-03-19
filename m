Return-Path: <linux-kselftest+bounces-29468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF845A69C85
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2AA170D29
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691612222A2;
	Wed, 19 Mar 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ksl5/o2C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB7221F3E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425558; cv=none; b=seg9sXippv2hKbVgUh0wY+HJOxcf5jAQaS3UrisZCH3unxEFE00M+5yMh4Bm7/22sZoI5QWQ/r35iWLH3cXYxrxikH0I++Lypmyvd7CEu3IgpRHB7i8+WI0xJB/0Or+asWsywRquXL5qn0QSidKsoLcLx8/M3S4ODQeRoEHInhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425558; c=relaxed/simple;
	bh=LmwAD6/9aquNzytRBY1gcavajfnLc7fxEGs2n19fJSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBtYXopK83yOchdHSY2MlPjLoF6Rv7k/X+y1HFUdOHi/ZFv/ofYTSJyhXNEKOpnlgkyrYFhJrwlTojlPnFFlenI4p+5fp80LBC3oD67ns3ASpFQEW3SV24oSZyXEegEXozk4vZnMhVoR7vCHToFssAf0a1j2BM4t3ucRWBypTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ksl5/o2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742425554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dpj3t+buqjjPgv0f+e6vq0WAn2anL3UEuZpKME7d92g=;
	b=Ksl5/o2CsGR72wB5USceuleWIitrk5ryQW3gM72kJ3HG5U+zkrVZ0idJdhhAyqz+R05e1f
	6GVFR5FUpVoax3gR+veEuPlxYs3okH61F8nE/6dlcv2PAxhOSTeGO8DEhTv6jUeQyMSCCJ
	IhQLwYm2ltXBgt4nNk1mM/BMSivRaAU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-ZhLic6xDM7qw8jowqkcBYA-1; Wed,
 19 Mar 2025 19:05:52 -0400
X-MC-Unique: ZhLic6xDM7qw8jowqkcBYA-1
X-Mimecast-MFC-AGG-ID: ZhLic6xDM7qw8jowqkcBYA_1742425551
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE29E1801A07;
	Wed, 19 Mar 2025 23:05:50 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.82.139])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 185701956094;
	Wed, 19 Mar 2025 23:05:46 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: rf@opensource.cirrus.com,
	broonie@kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: simont@opensource.cirrus.com,
	ckeepax@opensource.cirrus.com,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	johannes.berg@intel.com,
	npache@redhat.com,
	sj@kernel.org
Subject: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
Date: Wed, 19 Mar 2025 17:05:39 -0600
Message-ID: <20250319230539.140869-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
depends on clause, and set CONFIG_FW_CS_DSP=y in the kunit tooling.

Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file download")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/firmware/cirrus/Kconfig              | 3 +--
 tools/testing/kunit/configs/all_tests.config | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
index 0a883091259a..989568ab5712 100644
--- a/drivers/firmware/cirrus/Kconfig
+++ b/drivers/firmware/cirrus/Kconfig
@@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
 
 config FW_CS_DSP_KUNIT_TEST
 	tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
-	depends on KUNIT && REGMAP
+	depends on KUNIT && REGMAP && FW_CS_DSP
 	default KUNIT_ALL_TESTS
-	select FW_CS_DSP
 	select FW_CS_DSP_KUNIT_TEST_UTILS
 	help
 	  This builds KUnit tests for cs_dsp.
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index b0049be00c70..96c6b4aca87d 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -49,3 +49,5 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TOPOLOGY_BUILD=y
+
+CONFIG_FW_CS_DSP=y
\ No newline at end of file
-- 
2.48.1


