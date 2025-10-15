Return-Path: <linux-kselftest+bounces-43166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C9DBDD226
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932854FCB52
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C53164A0;
	Wed, 15 Oct 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="1/kkuHQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF663161AB;
	Wed, 15 Oct 2025 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512993; cv=fail; b=b8HxhZ6V01UoUbh8oFkPgD3fHalAhi/SRzHTPz4FXvp7/67wXUygD8Oz4/CyOA3xjBaOHu9lvaJpvf+tLbAWcnFuK2dBfnF3weFzb/d94IY6oUUrjU3Y8orc223cJMIHT5TDYjQCSVBDPJsH+mMJBKuEOdHiTDNCGDQ+A/YPJNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512993; c=relaxed/simple;
	bh=EJTJWeesANJeqfzhNrcWTN/JcLcCEcaFZIFjxOx2YPI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d+EuEK5oVFipYopy4KXqmC5eFMdRHqlxNcVgvOnKTaexfbthiQwa3XEOAyadPM2pjbQlHa7USxtvNEe1oIAS3xHG4t0ii1Sf4sKtgtGXUiTcMUT1k6WZMGtxGdt/OiTy9J/ZJbW/w99snwAuzP6LF12EpgwwfaK7hKqoQrwZH/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=1/kkuHQp; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfqf7YhSqgPXxAufgbEMcCfayBB/UFTyKmuLCVAhQByc5nGmXOX/lEY4oOpwSTDEr2k2ruAjugf7oVR7EHuauznVSg0J+q4RtDw9VdaSWF4b3BYu33nEIhp1pQth8ELqNB/N0Hzkx0sqW2nPReo9xMWR7vRYQmP8YRodQQiw2VjzI0Iq17N9hBNOscq6NuROnUPTVxp7Kepap9y+TcUFQcF4OyN4uGMJrHnSWVDOUmRYVtLErdHc4EeZJCyhF9Sq/j+HepTb3yMElwkwAbq3EKgVB6pwCXtj4nolvAI0tmUMJgUSBHcoDl1ncmban+PiJPh1m/mfgNySeo7OV8vO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RM4dj4yZv8MUX2oFRFMfTWN7RF8FcbSRFAqtkgD5L0=;
 b=xdWSqjA1CitEs298dKOF7TxkfJXdghKmYIdqkwkExyVvoVvckN2H7iT60N9knc0rOVbc3xkNHGbC0Q8zEjzDwMXOIvV38W6yYb5l2lKBrObUC4cDq9kOtcijiKp5zBlj0L9j9ErOJr3uFDfNrpwU3Mo7tCGUqZ0pBWPlSJlxEQs2kqdS5YU8U5PnemzpvTQ7/tPaPxdwH9VsiAMfFRqrVX97AwlEn9pd46ctoLgvCZHj0ML0U+YYrMTRUzTkkPtklBP0VIyJVFOLrwhF18vgyVMIsyacr7hAPsmEM6CQ7BWQbdkrbAcjQQ9kbOP5C/QCK3mVIOljahgkNu58zTR0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RM4dj4yZv8MUX2oFRFMfTWN7RF8FcbSRFAqtkgD5L0=;
 b=1/kkuHQpks3avMQIfO9bV5jSmyVkYjASu8A2mOE+P1J2ky4wKqX8MdAuIsJw4IUYmhACndChAzF5yUBtEs92ZU/elyOu99773d59qelFtqvIsjcb3ZTU088c25ewC3oSoiCmI9rccEsF4/GEsIs2J/JjMAPg+GBe7yEaz49O3ulb0cU2Q5729X36WM+3KMRQFym60HwosQipDxB6Uml2WQxAO1UetyCYBButv/C5Yv3Cqug+EODOrWGwl8Uv+NZej/mgShpgWwRK6XfFWL8pWAdCwG1RD2SW1Zw9ylOCgwgBRamZECYrfRxTvngpVSBhUeTxGvBimvu3hMxf27/m8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by GV1P192MB1785.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:55::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 07:23:05 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 07:23:05 +0000
From: Florian Schmaus <florian.schmaus@codasip.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Florian Schmaus <florian.schmaus@codasip.com>
Subject: [PATCH] kunit: test_dev_action: Correctly cast 'priv' pointer to long*
Date: Wed, 15 Oct 2025 09:23:03 +0200
Message-ID: <20251015072303.81266-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|GV1P192MB1785:EE_
X-MS-Office365-Filtering-Correlation-Id: 2481f0f2-ae33-434e-723c-08de0bbbaecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uXNeie5WsmH2P0L289wpadQEK9JYObuC1X/FS1CDvTYTexmrmG6w8mKdNiQm?=
 =?us-ascii?Q?OI0Kp4HPmqK8Q3LfOdMa4s3INE5ni92hgWg8yNFK1+8oOHj5sck0P75W+BUU?=
 =?us-ascii?Q?GW2dy4FenU8pt8VoI4ms1V8gk5+UunzbV3E0/KTpKzN6+oNyPFMDlAR/PqqL?=
 =?us-ascii?Q?U5cqwoLD2YhrPUPTDIm+wsSa6zGHpknUATXnYcM2ped2PNXhwCrOfvJfjZa0?=
 =?us-ascii?Q?OlVLetog21/tVFbMTpnnN8kkcwAWORlSgtHDWu5gvmKGBWUhtB1JAwGwwt8n?=
 =?us-ascii?Q?gBqMC1imS0FKHe+4uswDVJmQHj2qptk6HEZJW+NUrP1EZul9wKJBFJIAMzom?=
 =?us-ascii?Q?5fmtEZUTs2IO1KWCDRTiyf01Joa0oRVski77sHqizQzkFlMA7J0Gvp+ON+lv?=
 =?us-ascii?Q?LysID9w257dzpQJkaU9HiWRp8tfasPiPGYX2wzwZPOwA6CRVDA0pCPxTE4Tl?=
 =?us-ascii?Q?913PJcjlwo3+6fGmIdbCNwFwDnqyjYPKTZ5KixkuKjlognQTmTVCwkkz9BpI?=
 =?us-ascii?Q?t1tpv39OK8CYcNcYLOmn+pGCDPcgvO4/EW0pY6bZBOGOEdNb76xY5Cu8vu9R?=
 =?us-ascii?Q?7ODok5ujFDlba9cSPwXwj5Pvg4jKDbvnHF//l1iRjnD0kT3F2MW8WDIIec1s?=
 =?us-ascii?Q?KWdg0FjS5K+LZSESbC0ezwIjAY4lSibnidnjSZeg67BWE34lPATIzW8gTEE6?=
 =?us-ascii?Q?BM1UI8B6F3SHXyaHeKN5o7IH2i86kV+6c7T6ypSiRiczfyiWFQc9WN56Y4DP?=
 =?us-ascii?Q?49neWbO2Z2LHgTwSx9e2ipWr22wDPhOdYawDggB73i+/Hx/5nqO6hnrGrY+8?=
 =?us-ascii?Q?h6RgHPzEBJy6Z5IALgqoS2QsvAmTUVez1+ZllxUxTCCSQ6wDGHv3RaT87A3M?=
 =?us-ascii?Q?k0Db1kgWNS4NA8b+vNOch9IY5PCK5NKXSAdPboPgdBLO3ywIxolR/rWihnLZ?=
 =?us-ascii?Q?dTlm/IkmMFxyBpOvR/GMPHaT1c1Ibam6AgqIcFekwLvTH4swC/DdQIWsbuxF?=
 =?us-ascii?Q?Mh43I2IaKjpPgYLr+Ts8ieOSBHhSXsRlBbZ3yMN2W32zRdhIg8GEcIt/VPmY?=
 =?us-ascii?Q?kHfLYVgtFQ0UVKPau3G/R5kLFwgnWbnXGds4H2baXsww3AncLON/s56rjNGN?=
 =?us-ascii?Q?lJioGAyLgYki44w43rZXsArGSsKmoXNMKku6ilyeDNSX+ZRYZyrUKwyt091l?=
 =?us-ascii?Q?Ep+huHc3AzkO38Jo8KROZbl7WTZYua3mhrEk+Si2fk25HfYkD+rK6uEuj4fv?=
 =?us-ascii?Q?hfjujmTkz2iyrzmPmKn7I9DwaiYzIww0GCSfEtJvSConrJ3FsYAC0yS4ihvt?=
 =?us-ascii?Q?Y50eo+gzl4kmPLSDwRhqPtgOQKjLC0v8QhS9dtPVfwcrRjrYZ8kumOndxqAw?=
 =?us-ascii?Q?M0951CndvnRw05pQG8idWJQIZjBPTeP/9f6ivNjlYeVQ4hJ+JeWiChmN8f7G?=
 =?us-ascii?Q?q+016SL06Uvtk57OcLQZgJzwec8pvUcO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8RKIo0VCT3cxWIpy0VJxERa1LB/lx8JiikkZRwoYOrqqeNI5gy0egRXHThD?=
 =?us-ascii?Q?vQrG8aqcAociHQ01htt/hwNH5tqNz9mAfn24WiEc7VCH92t6PmTGOkL24lJZ?=
 =?us-ascii?Q?xQ1IsWZHAg4XtI8oP54l6OwKgvJhMy9ZfyMHm1L8sUBHMOWPR45d78kf2bjW?=
 =?us-ascii?Q?WMlp9DKO9Zzzng5t+9pbRdlXlnsr6eDrg52aJB+DQfrzKoUxdWfcg2lSbG9m?=
 =?us-ascii?Q?8ZeZjP8OV7yV62E6ow7TqtxicSwMN8QJqrukTWh0mcIpre0VfLq5HZ1l2PzP?=
 =?us-ascii?Q?FacE+ZJ5zpcI/YFcbuOwdqEj/0Z0UoUkFeQdlPRai4vn6t+QkB37Ilw33AJg?=
 =?us-ascii?Q?fsQlgCnDnK3C2lmfuX//bnsLQgU0rwRsuaCU2A9iUZdRssdfnIsB8CFwulHO?=
 =?us-ascii?Q?YulWP/LhSJLAuUESj+a/yxYyMeELf7lFeRyCZurlPs52awytjaHfTYJ/yEMg?=
 =?us-ascii?Q?KK7eNmYv5d+imtbYEjk1bWy9ryKt1lVxMUQbnxTU/KLB+rNSLAL3xRUafNKK?=
 =?us-ascii?Q?yMK14Ft9KViW62stD0sPZqTNDbAXYPXuWeb6EujrLE5Evusz2Jdt2u30cCPO?=
 =?us-ascii?Q?pok2CqCTUDWNselqNHt3OEUHw/ox2K6c3B2Ex4KtDHzSF1G2mWDKn1PSAOyG?=
 =?us-ascii?Q?Yp1hvxdMjwMQs7BJXylJTTpP360b55w0q11AoTbJiGR+hgVpUrcRk+nyj+E+?=
 =?us-ascii?Q?q9BeKBJEJhDS07ZWFwleRcBRqyk/4ZwaIZCGpqUmiF4toYaikk0lDz+8a6xa?=
 =?us-ascii?Q?sRGNQLmxAbHlfNbauA/XfAvdtW6INj+xd9OUYMJlM50SOkgE+Owi0T8JH81z?=
 =?us-ascii?Q?D3vYOvD1saIinskiZ3+3m26ca1PzyKJKgGKyiUwrkJVI2qqPEudqgMPYkeIY?=
 =?us-ascii?Q?WXYmZuOdYUlfQSCWc+UliVoiuO4xwd315I8Tb9Ux9w5b8doCJrmaSIc2nTj8?=
 =?us-ascii?Q?DNqRQwjh+PKwqMXGYPERk/mNOdPcGihSU1ZKVX3JvZUbFMpGwwBNgjaWDWhU?=
 =?us-ascii?Q?2wdAJ1t5QFpA8nWwh+Hw2aPp3hVmYkAw3MXA/cRVLRhE2Ifyn7I7l2IMWMzC?=
 =?us-ascii?Q?wtiANndaNhQqrSqfzhjcJdl3KJBensHUVpSQzQQVKr/YPLLxxM/ljzgVV+BF?=
 =?us-ascii?Q?sX4ZzYbavUd4M29eJrmbuWwod283ki/zSkVGRJ4N/Wq74HZjPzPOYXSmg3gt?=
 =?us-ascii?Q?joCpkkBcNBxELwM2j3MDzQ5m0TFFofkWmRm7xGhvwlBA2lnUDJwEsnNeiE86?=
 =?us-ascii?Q?NWozjd4DuEj4ztRFxzSRqZUjXtezFZyB6PfzF/uWwFDJfusMZNZa+83dAI5T?=
 =?us-ascii?Q?8KDBjlpZTHHmZYtlt+u/GDL6OT3ZNlX1xBoEivvcHXLlf1oof2lFTMz7MSJB?=
 =?us-ascii?Q?jQLiqwJ9SA6yzwbekimfXN661q/dSq8ixoQipzpyBRaBKBgip9S9w3ntKbD6?=
 =?us-ascii?Q?BWI3hGulFh0gbnsxOq6FDu4Rfzb3Kfjb8D5XrAIudJLbyeCayxb0kxx6QmWW?=
 =?us-ascii?Q?Nm4ywMTj5NgvXDJ1Vu7iY1aC/fGMGi0HWVFmgGmtU8ueL8wuSrIxejkF5Wdq?=
 =?us-ascii?Q?cejgOrno6+gnj14Xeu6w+8RTem7Zp2WS8QtKJXLgT5jG+uVniyWZAfoNc6MN?=
 =?us-ascii?Q?gLfeMVubFQNCSVKYjq+6EyvpwLwa/s7hnZdlKXZdKfu7ITpiP5sJJHMQlpHF?=
 =?us-ascii?Q?n7a9/g=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2481f0f2-ae33-434e-723c-08de0bbbaecf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 07:23:05.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Egf/VYALKad+IceJlkxucGCMs+C6PS3SmZHt7cqXr4h3qXCSGOO4mAL2Vs/pPntHjqmP9KyPRkCFnTFrCunKs6d1Ldw2HjLufZNO5X63k7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1785

The previous implementation incorrectly assumed the original type of
'priv' was void**, leading to an unnecessary and misleading
cast. Correct the cast of the 'priv' pointer in test_dev_action() to
its actual type, long*, removing an unnecessary cast.

As an additional benefit, this fixes an out-of-bounds CHERI fault on
hardware with architectural capabilities. The original implementation
tried to store a capability-sized pointer using the 'priv'
pointer. However, the 'priv' pointer's capability only granted access
to the memory region of its original long type, leading to a bounds
violation since the size of a long is smaller than the size of a
capability. This change ensures that the pointer usage respects the
capabilities' bounds.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 8c01eabd4eaf..957b67818489 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -739,7 +739,7 @@ static struct kunit_case kunit_current_test_cases[] = {
 
 static void test_dev_action(void *priv)
 {
-	*(void **)priv = (void *)1;
+	*(long*)priv = 1;
 }
 
 static void kunit_device_test(struct kunit *test)
-- 
2.51.0


