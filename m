Return-Path: <linux-kselftest+bounces-29864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E59A732A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2231189C205
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3FF21507E;
	Thu, 27 Mar 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SDJ8hkzC";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JXzAsqgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05309215040;
	Thu, 27 Mar 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079975; cv=fail; b=VobvNwSHnI5Tp/LhPu7cTFefDAiyad8WEc0oIxvM0EuNduwEh/P0EJPKCzILoo3r2ybUg2JBOehPJU+t5fpYBPsWQabK+ZW2CdUpMkr6Rv0cwJ3DrG2+ty13wFVFAXrY56x8OQ1hYRr/2Sw44RlaT8lQolME/FPtF8KaIx3vomQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079975; c=relaxed/simple;
	bh=7A3/59rbNrFqmoTf1/63lzhBji0iptwKOVE9vFWF44w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DvbVyMaSFxPOQMlnFj1G9qD+9uReSvKF5Sd5iOG5qTPWXi9d9PaFVmEWWEJ+PJ60n8T+ePQxpuwhWzhqLT3Mv0kkTF0PlIxmKO5zP2b9pCeeWvO9dy3sG+3V0oeyLqtVFi94hjacLcwgh2Qj1ILiS4DpdXzaQ9rfGJ1rdaHCaxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SDJ8hkzC; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JXzAsqgl; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R4tfTP019524;
	Thu, 27 Mar 2025 07:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=81403euldJNslPof
	GPhbAwIeU1fCqXpuP0L47elURmQ=; b=SDJ8hkzCyqGiHs75HJOvDk4p60umhBOf
	kS+u2CHKthp/xS0WFaOExKSUA1lQhCwhLuALAkS+kCxLwjH0t6Y2aGNyVpBP5uNC
	7M9ASz8og7berVClSvwl+SVAZF94scTz9aSlIvzU3y+BID81sqxPGpKaaXEhbtq5
	DnNsdkOyYGQHskYhdnwbp2B8bBbpjYHD9uF9S2G9kmTHdamsNRrYSVsanMXpxPNQ
	DTYY/Hv0eoljleRRgkXkrpI//Aa9W0Vi4bCO4amFrrG2is57Q5PaNmnOPVObI5Zh
	lWbGAVyPidoX8jIEwj7aQXK9tU1Pytcnpzq94cZEu4kgv+K3Z/svbA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45jntbye5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 07:52:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf3pC3oRm87sQQ1tfjgti27dFYnh6XgMI2kXxhbdMxStDSdI6bDffOKLyEcEfj03Ogqqlt0uDDwot2xMXJSC2o/x/vnF1Z7E7VDxKv0ZLaZr306wZfJKpkikoFnD3p8Go4t8nQm0akDyojgJo6Z409PW9vaDIMq/NU7j7bzNk8SL6gUfEb9+YFu23rs3a+/oLDuD6jX8R2QfHi+uI2vD2en/6SZEZmTctTqOofwDzwa7aR1U6OsaiEzbBJHg/+ezoBo8bs4dYqFfpjy6UKSPpeuO2Rtbdgy4G/TreN0xe3HOTcI8XpPK3Y4jANgtNwPLgJUHbeEw4anPheXdQ8/Keg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81403euldJNslPofGPhbAwIeU1fCqXpuP0L47elURmQ=;
 b=PMd98YXtUNDST7NUftDh/Pi+UtexE6bqZsQNaYUuJ6iKO11I+yjD77ZXkUcGAg5DcbV0JXf0J5OYvcYEJf0XcBMSrZRDoBsFBORyVoQCUsh1ysy1JGFyMdPsmjbExtBpsBIyxYvgZHrprq4TIzp/U3OMnPBOtCeN4HKzCsdsILjsLzBOMUbfLSa5qYeac+qs4ak3rpGIy7ZqwYB5ajuRdcNlqnrvsx4HJfaXNNXnR9GAh4eUgNea3bSk69LnYldygdZHRFcPkAgLuTM6g29LhiXyWLXZjkVgY/OK8a/5J9bc2di1lZ2nISu40jwx9WVKF2DFtMf7USOtSyDwYMl5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81403euldJNslPofGPhbAwIeU1fCqXpuP0L47elURmQ=;
 b=JXzAsqglS/nbvWRhDakzDMYAN4oahx86GGxXj6cGvDkJY5SI1A6TEUNSupk8sixnXCp9kQ6EPvuXe19mUIyvRT8+kMDc3IAOjKiGXj9nXA0SGySsz0m1vBaoigycgdLa0tDpqbpoI0a9IgQnw8frwT6US+EsjA9XV3NvdPX53tc=
Received: from MW4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:303:8f::18)
 by DM4PR19MB7286.namprd19.prod.outlook.com (2603:10b6:8:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 27 Mar
 2025 12:52:25 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::a4) by MW4PR03CA0013.outlook.office365.com
 (2603:10b6:303:8f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Thu,
 27 Mar 2025 12:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 27 Mar 2025 12:52:23 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 95DA0406541;
	Thu, 27 Mar 2025 12:52:18 +0000 (UTC)
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9FAB1820244;
	Thu, 27 Mar 2025 12:52:17 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        sboyd@kernel.org
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] clk: test: Forward-declare struct of_phandle_args in kunit/clk.h
Date: Thu, 27 Mar 2025 12:52:14 +0000
Message-ID: <20250327125214.82598-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR19MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e118ee-11af-43ca-fb8a-08dd6d2e3876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE5uSlhOY1BMVE14UC9jU0xFeVZ0Z1dSVWpNQnpiYXZzR2NkbkxQWXFhMUhB?=
 =?utf-8?B?aERvQmozKzJGTWh4NlUzT1Z6b0YxSDlqVWF1aHdkU3VVZ2hIakk5YzJYam5T?=
 =?utf-8?B?dEtnS0phMmJmcmhpcllUdWNhZ3lBVDRKMEp5UUV4aUpxeXpDR3lrYzVpdkZr?=
 =?utf-8?B?QVhPRGE2ZjBTVUMrZFNZU1dTRGRaTkYvMG9LSnRaNWR5eDlDemhtbWk3ZzZi?=
 =?utf-8?B?cUNWU3NYWnJFQWQ0QWRRQ3pkeFJIQ1NOUHJTQm5Zb1dUK01KZlZYN3RYOUF5?=
 =?utf-8?B?L3Q0Mzc4Y2E0ZWtyMk9MeUg4RnlUb1dUVk5qOFlXaXNKejhickllYzUzTGRB?=
 =?utf-8?B?Z1FjWmIxWmM5NEJNaGdJcnhVczgvYXNiVnN3OUlDaTNXeTRpbFlFY2drUnlE?=
 =?utf-8?B?S1VmM2laK2toUFVvWGtrVWhzWnZHa1Z6VkhydTc5eHdGWnVvTXlXZnVpY3hO?=
 =?utf-8?B?amQ4MGpQcExra1ArREswQlk1eEdvbGlzNnA4eFUwWkNBMmI0SXNHRlZqNGtv?=
 =?utf-8?B?ejRiVkJvVGFuMEtvanhaVWt5R3lDc1NqRk43SDdtZkgwWHZOT3F3NUwwRndQ?=
 =?utf-8?B?UUJNa2FzbnRaMWxva1RzS2crdGtWR0ZwYTJGa3lQY01YdEVuemtwMWI0RGM5?=
 =?utf-8?B?RDQvZ3lNNFVpcDNTaUFEcm0vbkxBT2lib3p0bUw2aVB1OEloZmlTZHk3S1RU?=
 =?utf-8?B?dlFRQlFVS0YweDFlUHJNMU1QMXorMG01OGhDUGVFL0N1SjJxU3hUUVNCS1la?=
 =?utf-8?B?N1R3dXJuTDJEVUlJVk1DN1BJZGNQc0dCYktzbVNtQzRodlRJVVVpOWhRaWhI?=
 =?utf-8?B?bDZ5NW5mNGV6dERGTFJxblVOYVAxbVFmUlh3TzdMOVUvUUdXTjFRT0dwcmZX?=
 =?utf-8?B?TkVyb0VzUnBtNFdyVFJweXAwQ3FZbWZYaWxuN3lKSXBwUWl5QjZ5WmZQZWpD?=
 =?utf-8?B?MzFUeEpuMWxvKzF3Ly9TbXpXT3dieTFTL20xNWJLUVBNR1NkOE5RNTUzYXZL?=
 =?utf-8?B?NVlZaVY0L0xsVGdMbHdhMzNNZlpJODR4MU5GZWkvTkg1a0pPeDdNVVo2SmRC?=
 =?utf-8?B?ZWRxd2Vpc1VVZTRyblRLY1RyYk5kbmxTNVdtTVBkUDZ3RDNMN3dVd3NzTUxj?=
 =?utf-8?B?aEdVd3FCeWZkL2RPVE9vM0RTTnYvU2dtSWh3UjY0a2QzR213WnBVWERreXZl?=
 =?utf-8?B?WXU1WXlwRkQ4RHNsQ0FmTExNR3k4WkdnTjRWV3RQMXJSM0grd0NDaHNLWnJx?=
 =?utf-8?B?VGNaSkdjVHZCMUJubUN1dW16bUUrOTJWMzh4OThyZ29zcE1tcnBnRXhheEp6?=
 =?utf-8?B?UDh5OHhxTXN3bXZoNWxtLy9QYlRqeXM5TlQ4SW5oNlIrTUJ3ZlNJQ0pQbVk3?=
 =?utf-8?B?YmtmNit1N1VkcituYUtxY3l4UE5ZSGFydUl2V0Y2Y3JxN3NLcFh3VTdzMWpw?=
 =?utf-8?B?MlRjV3ZTbG9WeEJ4cnhLWllSczNWd1BtdHpUVVVieTlKRzNPRFV6VlhIQ1g3?=
 =?utf-8?B?SHZBaGgwaUVSOW5kUmpLZXo5REtKdTFCRVRCYjA4M3Jjb0liWDJXWER2UW1W?=
 =?utf-8?B?d1poNm4vRmp2NVBQdWlNd1lBODZGNSt3WWp3VEQwalJadE1QUndtWFJxakdM?=
 =?utf-8?B?Y28vTDdjY0dBTWpONG0wT0Z0ajZiMDRoWXlseG5PcVUyQ1JjdGpDSGRuZGI5?=
 =?utf-8?B?RFM3YXY5dEZXOE1yTEtkVTVQTkNHZUh2YURvdXZxdGVXMUVvbmlhMmMxVUhL?=
 =?utf-8?B?VEhGbCtrMkcrcVlYRER2NlhqRHVZK0t2SWtLK082c21vSUk3R0hrajBVZDBz?=
 =?utf-8?B?ZDFjYThaSm8xeGZyUVI4SEYwMWIvVlZ4S0lReWYyaWppRVZxbngvQ1BrWFZv?=
 =?utf-8?B?N0hFVmR1bUdjQkNXQ29mWm9pUTVaZytkYXBuWnBFZC9XR0RBRmdSSlgrTDNI?=
 =?utf-8?B?ZGYvTE5JOXRtZzZTSEpwQnJSdnZIZTFiWXU0K0VlM2lqa00rbkRyTjF0QkdB?=
 =?utf-8?Q?JyqHxUfkreHyMF58ltsOuthMjUsdmA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:52:23.6442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e118ee-11af-43ca-fb8a-08dd6d2e3876
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7286
X-Authority-Analysis: v=2.4 cv=JJM7s9Kb c=1 sm=1 tr=0 ts=67e54a0d cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=gJEpmvavZCLp9qHwePEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: D5adHYrLq3rTt9nn9p9_G65fiK1touf_
X-Proofpoint-GUID: D5adHYrLq3rTt9nn9p9_G65fiK1touf_
X-Proofpoint-Spam-Reason: safe

Add a forward-declare of struct of_phandle_args to prevent the compiler
warning:

../include/kunit/clk.h:29:63: warning: ‘struct of_phandle_args’ declared
inside parameter list will not be visible outside of this definition or
declaration
   struct clk_hw *(*get)(struct of_phandle_args *clkspec, void *data),

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/kunit/clk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/clk.h b/include/kunit/clk.h
index 0afae7688157..f226044cc78d 100644
--- a/include/kunit/clk.h
+++ b/include/kunit/clk.h
@@ -6,6 +6,7 @@ struct clk;
 struct clk_hw;
 struct device;
 struct device_node;
+struct of_phandle_args;
 struct kunit;
 
 struct clk *
-- 
2.43.0


