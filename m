Return-Path: <linux-kselftest+bounces-13156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49268926D8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40FC28275A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FBC168BE;
	Thu,  4 Jul 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tfrokzVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E99C8CE;
	Thu,  4 Jul 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060929; cv=fail; b=SzHuMD3c2Y/y4GlQA1UPcqyrFQjeliZ0B1HtvgJEmD5NQ0caIpMd4hOWKDRCl9T1+4X2Mm4bZXnQjlXUWy6CZ18wf9RFOBgXtCcYysRjNWCFuegxW8dzThdIA8SqX67W82B/gTQn8waWraCjLCCLLwIeSxy1h4YMe2BQis1TOIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060929; c=relaxed/simple;
	bh=gSAnVR9xl3FM3P1C862bELMBiwcKFvcu0TBdmBklJ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YlFX8nqh04Jeg2i52wHy09aTmdfjZjVi3hsuGRWAt6hx2gPUMrhW1z4PR0kGLVS/jOPo1E6WjIL1FmDiUhA8507mw1zi6BvODFeWI+ZOnQh2AgF1nHzUMGbCCBlvJyhhnLJTaNg6zHqBXK9oQfQpep6/St71+jGxwU5t9QGA7xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tfrokzVY; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrnM0Ws0rH3zqxxmoyUmGpCqkgrqns8mO9nHY8s6aa+qWnTxeS8DMnThY58KIHCSkRNhuoqVRrwelteyqfd4C0pXqkgIXLj5JlmqXvO80KwT9vLmSPTtYQ888Pu9ZTzrpoVDKdAoi98YTWvKUe83cXsndRsW5BlhI8sGjsGLg94r1d7v4QpmqiOqXYLNZz/++qG7haeXMGrPl0V/oXT7wUaHR4IfjqqejLQKKLNp1OEyio5t6s2Gv5crIlPkip8NYJSfqPDA6pqUjQM1B8csIra7H5wLmeZwS28Yf7PVmiuznCdNmmtgt1UWrRuJB50+fuKWGOpiX/1rezwPysMkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/gCnbt+DKW2xz1QEIoUwhHOn+OzpH1TZNFbAjs3CYg=;
 b=kb0mKJpzE06XqzBQuUSTS2m24cPlYIvsdDOagxEzQqVw5r3s6nFJWkFIhgFocZaSmLEMKmYjPKFLYXAHDsMVYoT5IycO7YwLga2w4HcWR5N17Othm4hyGfg4bQ/Y7jbWZxRJ0Zn/qQ6LtGIz/BsxegZqtGQQd9dn5Ub9lrt/tx/aJzuMZ4nx1OBpuq/3j7gDluZiC1aaegTxh4YLzUqFJgddbFtIbVeSVqjGoNM3iiMBSrMGH08+8pHx9pKfsMbuyfiCGYxjYFFqBhyoJss4JKc9bP3a5EITqB6ZEhNJ72+3PqXMrnqv9R5amNkzpDzmP+rqSaPC7MIARgJffDcguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gCnbt+DKW2xz1QEIoUwhHOn+OzpH1TZNFbAjs3CYg=;
 b=tfrokzVYUcYZCOCLqFwexKHfBw0h8/DUprUh9YtgZwGWHZXQmbqNB89NFFIVQJXoe21QHPICeMO/kWPaIUmXRNlCglpadG2E5GPcLYg1hg2C35o7k4WGaCKGOTK05TxNBR5zI31EuwVRcTEcYWOpFLhXUyDmTflJdAk+27Znr8qiUN0XPeeAqb7Ph6tdi67zIBo8cVqp3f3P1Z60MmAb4VQuPsBSHfqwx0wzv90neEoBTX14lSO1pCRbNrFMS14P7L2tms7uLdXO/AdFtC/zNrtxwzkxt27YgHF1qqgz8OuUy5vE1IXLSKDDRUpu3dluo6fFChh/qM7xv/71MGOT4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 02:42:05 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 02:42:04 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3] selftests/timers: remove unused irqcount variable
Date: Wed,  3 Jul 2024 19:42:02 -0700
Message-ID: <20240704024202.84726-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecb0095-19c5-45b7-3901-08dc9bd2e3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4BXPI9X2/xNrEHAnYWRApYcCRrhhIJb0PBSG3jbJ/dWawAJizAkDHHSZx2Nz?=
 =?us-ascii?Q?7WWKbugtJFSwfNoBhfUF0vpLTVtlfSBWCCyd6XOInT3xCZ5ouZY+hYJQo/EY?=
 =?us-ascii?Q?9Mzg/ZecocMMFK1nUl9rnxNCffJBf1XoVqHiPeP8gLjpHeHQ48ae+ihfbX1x?=
 =?us-ascii?Q?o91rHB3WYpEtF8TEYX8A77ICmAip7DlLdwj5HTWhyu5SX/6ZF6c+1cL3SuSV?=
 =?us-ascii?Q?BK6rwsD3ZOi4c4eQas8wwA3n5EA5GXAH2oqNXSwCJvoiwATCVool+mkA3tiA?=
 =?us-ascii?Q?kfl8iGVQAzQX2/7cfqbH8zat9PHRgN2TGzx19pB1AvWRERAl8nWxHDTrruAr?=
 =?us-ascii?Q?97z9Fm6dyAZK01NURYmgCD2S+ug1M4iZ/Gtifaw8TLkrLLV7jhHX3YzdaFdw?=
 =?us-ascii?Q?Xv+eWnFP6BDO4uD1jnJZM/nHUECfhbew9LhioQZo4Dc6Ft9PptHt7XpjKGYQ?=
 =?us-ascii?Q?3U9OH04iNAfXFkFd5+NGL20eDCV7B09xIxC7iznhdYhVh4vXJHsAc8a9XBBl?=
 =?us-ascii?Q?puRBuIgvjjCW/uFg4H3iAIfjHud03TUxmLITCzahV+zZv3mJwDSCblfAvQV2?=
 =?us-ascii?Q?Og97nm5yDQ8L2CDmKhZdpjQ1GUsb/LE46L4Ez1CmSWFLOK01HMdsOH/KC+/P?=
 =?us-ascii?Q?uj76qhsQLHF0D+yOP3C8sWvcb/Kj/NRDd43GeHzGRMoZrg0yDLy0Y2B7HEy6?=
 =?us-ascii?Q?mynR+kkJLtPfS89H5D1Dt/GRQqQ2W7FmcK5aTaO6orQqXGr6451PqpgwWEvq?=
 =?us-ascii?Q?zwj4fR3Zrh7g2zBU8NHPrqiZnuHrG2D0LYBrmW/bu2agqKUZR+PU4FzGVeJB?=
 =?us-ascii?Q?ExsGBT689KO3VI0+uTgjH9sbFXiWQH1TZ02CeFWH3ZsWpR5GTmmcmzBJDRtU?=
 =?us-ascii?Q?cn/i7Q/jgS1qKWBMqRr++kknj4URY16lJCNkiFQkL9SF20jWvtGeW+kYc/qz?=
 =?us-ascii?Q?uAs0cR/jBvtRjUSBg+0sTJFFvN08FrdGysOFl6PVGbBVleoHwT0O+2XmvW63?=
 =?us-ascii?Q?v6iQ2Ii19LDWvVHlSKCER/3JPW82DeCI3LRtSzoQRRrEk6lrlaR0Y1IdCjTH?=
 =?us-ascii?Q?TrxGQcTnGdhbsktfmoyGkgxDsfeyQ6UnvK43jno4b797QXZdyt6sG5NROXDp?=
 =?us-ascii?Q?aLVw8eVjMOMRtcL+p64JPQizNGbJoaJWZJLENPNPjJZAt1yVzOb+5MajONid?=
 =?us-ascii?Q?KiUqR9tysyLm7z8wQLJpHMALKXcb4jU51wLcuYLbDAIwBddmvqwe4kk5KaMa?=
 =?us-ascii?Q?bl3aPCnkm3qEBiVUXruJFX9jwDE8CayleTTC8ECsXvilAu1ErZh/s6ZRT+d9?=
 =?us-ascii?Q?P61QzaalhyEoJRzE4obxgsjrQ9RpBNXb9waldgUzXl908g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKCiFHyZt1aNUB/YAGPY2OO/zuu6606hXe0D3zVPTNCDcWjz/dSzH23dDN4c?=
 =?us-ascii?Q?bdR8e3rkRsqV9FjAk7TjddzSCaJuAvkP72XOK0KH9FOq5WdliEzTuC9HVu6c?=
 =?us-ascii?Q?rXmQOJA/qFmd4lEWYw/qngkEuYSu/8qyYC2VPD/pKfwc4PDfv2ctVJyr0K23?=
 =?us-ascii?Q?fJ77ptZdttnBR15hCxNr3DixK20jZZuFzRcrCRx+ds5n3AKzkf7+ekwxToqZ?=
 =?us-ascii?Q?iF8OVnI90J6YXONMPPx+j3Vv797mlBJJoDLBffIAwMuHpxXCP5zJFgMd9fep?=
 =?us-ascii?Q?6itw5FElWx/b4DRVTZQTxfO1jQIP1kHpOTgHxPpgfVd9jvw9cWdSYpnFvFO1?=
 =?us-ascii?Q?cNXKT7e7lOW4fHLOKbfyl1Xt1oUf4sGy6NcOIeIZTahKnpa/R0C6H86WbQYe?=
 =?us-ascii?Q?qM3hGcPYk/d3xFXm9o1rV8cm+mu4qWC6OF1nvOrtDShpWJIFFjGgvWZplmLc?=
 =?us-ascii?Q?QkLNknYhEzNI04Ht0E5tHdLEZKBmZLF4s3tMas6OiCvJBPcwQshUefWBtb2v?=
 =?us-ascii?Q?PVu8UxRVD/5f8881DUsdFAE66wHRXXf9X8vF4eanf9SbFgvSUUNgLA1tQnEZ?=
 =?us-ascii?Q?JknyHOGsjoMFtmzduVQD1u8jhVIrygKBquGN7O6fSC7FrSgw/KYqZOLAlga+?=
 =?us-ascii?Q?MtCGwMePXyvL7xao893k7fRMD2x+idsKMoQCdobOFnCFLGZrDISRgqxMLmF9?=
 =?us-ascii?Q?bYFM9gZbxwQGMOOUfZ9zJSH4/bpYR1yBJ4SLnNwMaVlrnULsFdgnX2DNipFA?=
 =?us-ascii?Q?VDBjjEa6uK5ZELunC9w4bLUImUNj6qrIPusJvu3iWcVsSw9IikX0RtVHoPeZ?=
 =?us-ascii?Q?nvGbW+ZOeOWhzMrka57bQXCbQm6eNLEsl9twxDMOCKcPd5NqMv+EosSRyWtM?=
 =?us-ascii?Q?yA2xspH5HudvvGRbZtHBaPLwH+I16ManktHD7e/vgSLFKEJHK1c7rsPYzQpj?=
 =?us-ascii?Q?B2vpbaP9tlnZDvSyhv8VTKVOo8jV7q/MRnfoQVzW3U+9DhH0AFq7yX7IsXpR?=
 =?us-ascii?Q?KVutiCowJfjFCXzmYhdTRXdzTq7AOE+fYz8OSGFZQxlzSSRCig6Flt9UCEbY?=
 =?us-ascii?Q?Ixlu0/ehdr2Fou1BMtiLBqdCpiI02eYo7fWmLbCpTFy/REZDB6Vhu6q2dIKf?=
 =?us-ascii?Q?Bk6YeAmsLWvuB9VVS03edEcYs6n7jeU51BCZZE017BkAcxTMqN7uydAHm/ic?=
 =?us-ascii?Q?/Qp5YVo1HRew+zkqtjewWrpyUIlnh51sBPgV44oUVoxGcWAdk66Nbieri3tg?=
 =?us-ascii?Q?3u0Vaz8h7ZrsE1V1vqFmDxOdYEoD6s5+Ca8lyTA/4pkq2eBnC0dnPzAKug4/?=
 =?us-ascii?Q?9OsNb9NgpUP/JnWvcqtspyXmpyO6tRfpfXT4JlEzOJrzk3F1Q6ZLHPDs1XLw?=
 =?us-ascii?Q?A1QuYzQHpktzaZJ5RFXDZCfkipAmSVe+S/2tS7JwIlsjo+Z4yJx8ZjJRpxWM?=
 =?us-ascii?Q?PipgETgU1AYLZehZH0Lc9obFENBKx04HbzI1+4dM+K9aaSyLa1YuOsDMz8zI?=
 =?us-ascii?Q?tHXcO7sSQKC0GoaZ11cEFB71h3C16EpPD0YtcddiPva80or4htLHmKzZAg1a?=
 =?us-ascii?Q?IFylMamu+RD1NkKSkwrwaHEMOmVJL4B6xKd2Q38s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecb0095-19c5-45b7-3901-08dc9bd2e3e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:42:04.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9x53Yh5obotrNWpoNLGw37gimWztSDLGpgxNUfzyF24Iav7v9znznkg5LSt0ZUyAF4/eTCBA/WUqEIXVsYRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about an unused irqcount variable. clang is correct: the
variable is incremented and then ignored.

Fix this by deleting the irqcount variable.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v2:

1) Rebased onto Linux 6.10-rc6+

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

thanks,
John Hubbard

 tools/testing/selftests/timers/rtcpie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 4ef2184f1558..7c07edd0d450 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -29,7 +29,7 @@ static const char default_rtc[] = "/dev/rtc0";
 
 int main(int argc, char **argv)
 {
-	int i, fd, retval, irqcount = 0;
+	int i, fd, retval;
 	unsigned long tmp, data, old_pie_rate;
 	const char *rtc = default_rtc;
 	struct timeval start, end, diff;
@@ -120,7 +120,6 @@ int main(int argc, char **argv)
 
 			fprintf(stderr, " %d",i);
 			fflush(stderr);
-			irqcount++;
 		}
 
 		/* Disable periodic interrupts */

base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52
-- 
2.45.2


