Return-Path: <linux-kselftest+bounces-29620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3959A6D028
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Mar 2025 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C82169B0E
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Mar 2025 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746584037;
	Sun, 23 Mar 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cIT26WBq";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qq5i7jNN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB77847C;
	Sun, 23 Mar 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742749559; cv=fail; b=FIZ5S5l60ZDKJaJtrklAfUjR+ds6C17WGuzZckTbac2329yhnaF0+pHWmWJJ/hM6G3BOm3imd42tzewtu0RjPS+8K8eh0u5bvqBrp2z0Wk6rVw1cAXG57Tu8MWbjlQ6KngEsfaUPX0q2BfZsjX42jUfH8PGejZ08rDC7N+/XjK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742749559; c=relaxed/simple;
	bh=+RfUnG9HGhD3ZJZCD/dJvadae3aNMKKomUJl0/kH2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gux6W4ocMaB7XYkNuoamWxJMXIu5LJL5V3AJeUh2brVIJ0UvN6tMJkoM8wy8GG4E0LLW5ONEP8ffflVHs9EnBBdROpX0kfZe0g8UUQF2jXIXEhunK7LPgFSfs9KsYdSVcc6Gs8NzMKA5N9YQZwL+qQ6hTOZMimGYJjcpV20IVDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cIT26WBq; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qq5i7jNN; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NH0Tht000917;
	Sun, 23 Mar 2025 12:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=9IiBZYqYY/yhAN9x
	Rv9ThFtouFt+HKHKD/6Hn2r1iXk=; b=cIT26WBqob2w7QE8xJL+o0Pt+hQ7t6Ch
	CxFgNSi4G9Ns4M6hRt2H/g3UmepWQgpuVFi3JKIGnmdCeGWpA1giCqkrG+ydPeYh
	0I5JRyrPeo1zROOKA9keV1JRclcFxTTAogPegoG4KWSCYt2l+GlLTeMzpRvRAWXw
	5SH8XUBcBtfzwDM8u2X5TCi9699dRlcE+s3Ru/+tS/bQ6Id6KbCU3SRfmetWIBit
	Y9h35sc0QEr4deVL72zyW0Ux+AALu1uQXu++oyPV96xCtHRnahp3tawTSsV/AVN/
	lbx0OYftJoKA2JQJ3hM6kHRkielEA0PnQFyr1EmmdB3+FEmibcI8Ew==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45jntbr1x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 12:05:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMJRjXsIMX8/IQBloIO17KTxDX+VgB8T14ipKcuZWxmjYIPpF4WvZJdhi/TOnVIYVnLMHqJrkrl3HLIXOueIG3JZIFya2pLHIq0EaDbJSV8q5z/Y99PZZO4sOCBdkf8lSS5uYBaVJOrG7TZZF563M1LRqULHz9P7wzilwVbI6L+Eo7ZR3Kr2p4+tMBOqjwTzzCy0InK9L6X9eruRlvk5ueTqr5kz2eVCrgBltZMEXs2p8Xo7w3R5JBfJP+WAfzxuFLvoM7gZTMzSqh1/+8+vHD/wtM5bFnWITksdArTUsYvSlCDHsVP2jORRtH4hGcgwuxMalmdT6SpFPwvKOT1vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IiBZYqYY/yhAN9xRv9ThFtouFt+HKHKD/6Hn2r1iXk=;
 b=TW35zzsEqTicCtjkX+8Bhoksew1o3624nNrHyJVZwTi5dzgnzcM9ZJStUEemxeRXFEWu3cB3BjeZzSiSZVGgVtfA6zVwcZYXJuF347i6bmQ4FnknQSDy9serls79+D82Jx4IYOQYZJVj5FbITSn9ofOcisuu2CxzP9D/fdZK2kMQt7gL09PzVhaDabKhzKca3tfz7S4vMaUc0CE+tP+ALnEkGf56kw1M1lOGyFwrINM0aCmUKPhCHN/txpGd8xwpetcTmli0C/vGiNhSCa/wRoRIO6ZUhSK9rF5ikrmMP0aKUg4U3c5yLLek8w2xWvJXK9dDkjrU3zCInngajhz5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IiBZYqYY/yhAN9xRv9ThFtouFt+HKHKD/6Hn2r1iXk=;
 b=qq5i7jNNgkvE/9oxpVS7PXi1VwFEybho9kKX8Hk6yHH6beTC0UujyOFypcATSwUKx8ZRpk6miHK7aOCToLaNWC+fuW1vZV3AtS8dedDTLVgnJC4TZLj04jUQ70rgbZUK8vhhhHZi3ONF6xqNXeOUS6WO3mz2s5Z7h8DRVf9Ac0E=
Received: from BLAPR03CA0088.namprd03.prod.outlook.com (2603:10b6:208:329::33)
 by PH7PR19MB6112.namprd19.prod.outlook.com (2603:10b6:510:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 17:05:34 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::5) by BLAPR03CA0088.outlook.office365.com
 (2603:10b6:208:329::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Sun,
 23 Mar 2025 17:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sun, 23 Mar 2025 17:05:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A63BE406540;
	Sun, 23 Mar 2025 17:05:32 +0000 (UTC)
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0FD95820244;
	Sun, 23 Mar 2025 17:05:32 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: npache@redhat.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Ensure cs_dsp_load[_coeff]() returns 0 on success
Date: Sun, 23 Mar 2025 17:05:29 +0000
Message-ID: <20250323170529.197205-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|PH7PR19MB6112:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0792ade9-6444-46da-39bc-08dd6a2ceccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/8KzKDoF9hQ8VBuUD7ypWa5aM3P5pCEovGmbpYPfh/Sl2zbGeVjvoSwrhzdk?=
 =?us-ascii?Q?REkwCKR0hyhzk7UwCpaizifTXtLRUZ7GfieuSzywGz+uuxtw2IvciNhleoMO?=
 =?us-ascii?Q?0neoSzZKfHdgm77q4BSm0bwHUk70Qa8oxiuMoJNflnFJebMC1AzsrCz5uNd8?=
 =?us-ascii?Q?c+KEfJ87+qDoqcgmxYxmu4s+tKPdMBiH/Q4DOnm740Kb4UTT6F/6IJV18MKX?=
 =?us-ascii?Q?OpAwiXE/qJysxqsT6tOhinHI6D9/fki2fZ7ydaGuGncZ4iaakZuNlIcswtt4?=
 =?us-ascii?Q?D616cC+Igl2TWk5RtxSIIYAFGBXWoQ5KAEVE3/Tva/s1DTjF0E2xBeJnT1WX?=
 =?us-ascii?Q?LXP5oRoSZ2R8TJhug4lfFV52ReMuJS/ioetVX5X2TOBBXRsPDS4DAQxF1q51?=
 =?us-ascii?Q?FftntmqE0t9LJTXs0zNrXYwtyzp8qyWo7Hg2oYe9jfUJlqE8b1OP3DKKmxFn?=
 =?us-ascii?Q?d5dg1/xoT8wSuG3/MOvPVLOJf3juutUZU+nIVLOUNvJ46W/zfxY0d4uTXmy4?=
 =?us-ascii?Q?W4nQ6EwpmkenmsCxV8EmSNlZ8EblEy0xYp/9DGjU/b6gKX/6KC+O4DWJthqR?=
 =?us-ascii?Q?AosOaCN18dcPLY6lAtUb+3ZdFYxO40DWalkArHDdgY+xOkbu/yXwF5qTevoC?=
 =?us-ascii?Q?HFFJOPlRBt/WqRro90p3Q+SECsPwwjqE8xXjvdTmquW6ys/uQu6ePIuOcXOY?=
 =?us-ascii?Q?GoHEKHK+7fR69XrPHb4rMiaj0kqq+H9XLVqH74g2OsR6S7WrjUEliNSpRXVM?=
 =?us-ascii?Q?yin1/I84wn5MyC8WiyAEeqd1ga25CZ0JkDnedRMT5cS6MqBkcYeaT+jLYPBh?=
 =?us-ascii?Q?m+Dawc1eCPmp97ZJvbPFWw1vXlAVRQFBJJooJEQzLqfEsquZbmcbiLgLLa+K?=
 =?us-ascii?Q?2cPh2yad6/Sk51+sWtSgsdqfj8mgCJCBODxl+8V/YJgrcwxYmAILr0EGLrJJ?=
 =?us-ascii?Q?q2+ic4wn2GlUeUdl8oHolIWgFQ2fk+Mc2L9NRx8naFGZP4cq97SX9SlQeWmP?=
 =?us-ascii?Q?MSEOUTNngBFh5J/I0G1smuvPfaNU22SRN0x+Wtl7SD+ZotKGMTIrh4e0+4aE?=
 =?us-ascii?Q?0vGbaQ84zD6/FyYCgPoF162QHhHC2XW2/TKasCuiQI6OZgYWYySMYWjHHwrU?=
 =?us-ascii?Q?vy0aFZMJZ+fghQTu+hrojAGtJCs59hb6mZxATXfxQ7iLnWYm1rH9OUmnaxic?=
 =?us-ascii?Q?lTrxfMK6Vgkegnq94zVPjUsjS9X0z0NqOF1k+Z1AYXC5oEyeNW3pmPNQQ6xN?=
 =?us-ascii?Q?SEIyO4BJnDNOHBLAN5U8sDRmLctnFbjhcVSAyKYvRv/0xYvUyfhZzO/N6tip?=
 =?us-ascii?Q?vzgli4JRDQBvYfvAAjqYchPPEEVnQ7mTfaqYf9nAqEtKAMg7b3Xx+fhyCv4D?=
 =?us-ascii?Q?uDCrLZS1NazIvkTGKF3HZCl+s6m8D4R4qtWU7BnO8/eKvW5jqOzTk9N6con/?=
 =?us-ascii?Q?qXl9QEdXKXAg7qkQi9HpiLejBkPsXoqRrc1XkNTXfz6B9U+IWLFanhbY0Rqm?=
 =?us-ascii?Q?ndouFOLmmbryNO4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 17:05:33.8425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0792ade9-6444-46da-39bc-08dd6a2ceccd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6112
X-Authority-Analysis: v=2.4 cv=JJM7s9Kb c=1 sm=1 tr=0 ts=67e03f63 cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=yZ6Zaq0YVcDfNhcyRqkA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: isEcPU5dpL6FVRWrTKQVZyCcXiUIhlwy
X-Proofpoint-GUID: isEcPU5dpL6FVRWrTKQVZyCcXiUIhlwy
X-Proofpoint-Spam-Reason: safe

Set ret = 0 on successful completion of the processing loop in
cs_dsp_load() and cs_dsp_load_coeff() to ensure that the function
returns 0 on success.

All normal firmware files will have at least one data block, and
processing this block will set ret == 0, from the result of either
regmap_raw_write() or cs_dsp_parse_coeff().

The kunit tests create a dummy firmware file that contains only the
header, without any data blocks. This gives cs_dsp a file to "load"
that will not cause any side-effects. As there aren't any data blocks,
the processing loop will not set ret == 0.

Originally there was a line after the processing loop:

    ret = regmap_async_complete(regmap);

which would set ret == 0 before the function returned.

Commit fe08b7d5085a ("firmware: cs_dsp: Remove async regmap writes")
changed the regmap write to a normal sync write, so the call to
regmap_async_complete() wasn't necessary and was removed. It was
overlooked that the ret here wasn't only to check the result of
regmap_async_complete(), it also set the final return value of the
function.

Fixes: fe08b7d5085a ("firmware: cs_dsp: Remove async regmap writes")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 42433c19eb30..560724ce21aa 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1631,6 +1631,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	cs_dsp_debugfs_save_wmfwname(dsp, file);
 
+	ret = 0;
 out_fw:
 	cs_dsp_buf_free(&buf_list);
 
@@ -2338,6 +2339,7 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 
 	cs_dsp_debugfs_save_binname(dsp, file);
 
+	ret = 0;
 out_fw:
 	cs_dsp_buf_free(&buf_list);
 
-- 
2.43.0


