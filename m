Return-Path: <linux-kselftest+bounces-10741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888EE8D0EA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 22:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94AC1C21398
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05747161301;
	Mon, 27 May 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KgRzvY8m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE35338D;
	Mon, 27 May 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842208; cv=fail; b=RBxu7iWSK1LygrPDme1QaCdDFcwPPBANOk6AjiFcn5dkROGGKg4AvU98mn3jSzeK7UT1JlCVQAN5W3BPgR7bFYnX2Ien3RPO1ZQM7DNwHvnDw1Ai1lFsf8s3g/hpCsbeMszdDghLyC/y5/nZ/btX6eo2IFJqrtcGljiJDQyZOfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842208; c=relaxed/simple;
	bh=0bEzPARpkWE+HBJKPVX5Df3k9b9aby0odYNcMJkZaL8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fdBGbomD6RHVEL+4Nn4cds2HI6Pzqfw0ZMfXoazsJnkK9gtcjxzR/JxZ3qfc9kU8Kf5y3AGM9xgPy37EZ1Tdv9UhzC2U/wGmzyOnEZXNw4ApYRI3uP5xpX5+IkPvSFHjDRKivsp2JeIKlRPdCryEmjMHQWZ0Q32Sc7FHYjhlsTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KgRzvY8m; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8RLNNZpJ9zBc8cYzIfKZ6+Jw5IcnCwpWP6gSVYoSogEX21FO2Z+AX594KCxst4HynXPZNUYERJfDPA5XT27YEKibtQ2oBrqXPVCiWtBfb/vodLjJtc22E/Atb8Qf/364v6AkUnW85wBVubUNKm4nNRKnxa2aEjrZNoCODNaBAAK42UaK6V7/F2Gmtip2x098LBw4/T1rFOVwb0rwPb9ZuxOg0u6B651tguux1lS9J8DLCyuyFVip9JZOT4OxUNRB8OeZOztbBDt34g2RpWxKYlDTOkzAw8mRWtI5PRN+cRgwxTLwxfli2E0JH464Fc7Or/yyce1nn2BeL7Xdhy0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xQJW+886kOCw8qAz5acZJ55is8fgVwo+MDKs5gDEp4=;
 b=g9TH13Fs6O6u5jQtAq3f5i1ovKcf0o/GiU1zwkg+emx+6wGlBzmIWGqF9CbdgzaMkmDmQBvJH19McriqahlvAU18dz2ZSufwJNHMHCVfgc0J9PbIve6uF413VsEEjZYCdRBgM3pC6lR7wgoLDAw+tMvop8R9iSGHUK1UCDRBsdqtYcXZoY1EDjQp2ASLxv/f9JIEDhUhAOAY3mcBFA/nl8Yw4f5TyeoOMOefllK8O96PBpV+1IM4Tx2TwW9gUxrk2IZ2Y75DORbvHb8oxpUaXGxiOtQqKWUDfNKV9VJnfkQ7DON3bXLZBwPJAMtuI8ok3tIuBt+ZKlG3tvFYg5um/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQJW+886kOCw8qAz5acZJ55is8fgVwo+MDKs5gDEp4=;
 b=KgRzvY8m8wNpr0rFCJ6klJzz4+I1N7TRQwb+ccmcQuxoxVyGobBm6mZ/r8x1jeX5JDtvyDgYj8/V1OfXa6CV2kZPl2bQdkJohmpdxdH/C5RCqFvHbvrE76o5TSNHThsWZ9NQIUY4WXi9OfrCQI6v7QK4zM82dAh1DRrsJWXq1mOYBuEm4kl9YBMa/TUTyvxjQNTTwV12V2Q1oheP/ODdN/VPXq8aqj1ohXk+dk4xRiGqhI4Gvhx89BJaVCN6uMq/Sn96Uiee8VRKrUjVtKAxsfc41Z9YkVjlBu/uIWRh7YR2BOTXbZ83HsyWjZ2AGWCZkwgr6JOd7iyk/pvrs32cvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 20:36:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 20:36:44 +0000
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
Subject: [PATCH v2] selftests/timers: remove unused irqcount variable
Date: Mon, 27 May 2024 13:36:12 -0700
Message-ID: <20240527203612.216988-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: fb500c44-b46b-4714-bdb4-08dc7e8cb90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zgby3R966L70cipkM1hs36uVRxG1lAQEF1g6ZxNgy0SR1R8U5FxRVUQWUjxz?=
 =?us-ascii?Q?89skSZ0VIDW16gHPmaNW8Q5Z6aJk7rB32VH+l/8eAJDha1JI6j5pEWP+B6EH?=
 =?us-ascii?Q?zY41QDesDZjkR2BivPCLMceLGCSxjeE/5142Q/IHICqj6YJZPRwUL4mrOGxF?=
 =?us-ascii?Q?tbnQET3JaiooLyvyF2HFDKFvwsXG8jh+Msi138mCvY42P039sNDiui3pUfSI?=
 =?us-ascii?Q?vqN5WZmitLBHJRzfNTph0F20MYlnkqSZcbRDIiEIvUGOwPkD62Elz0sUIKFz?=
 =?us-ascii?Q?7AV6qxDljZXm4Z/2wpqiWw2X421zrdzq7trvIPb672VFTppQ3y1yub0lJnJ5?=
 =?us-ascii?Q?aJn+HTPlj34pL10n4Z+SpckP+1LLES/gzrDPx4FRiuClqv7SnQpDluOTa3qC?=
 =?us-ascii?Q?YLtfJ9VLSon4XqzurhmQGkwMbpjXykQrPtgc4URFY1y7+JYUa3mr87P7sxlf?=
 =?us-ascii?Q?MKSm1JO3b/Q/KpNqZBYHfn8lLwpvu8oxD1IkCa5I6jBUTvikThO7KHvVqJTA?=
 =?us-ascii?Q?5K1G6wqvu6uZGDZ/D1/4Su1zhJpbbFubV0zTtdnmkN7KlOaJTO+7l1PoUfB7?=
 =?us-ascii?Q?2znfS4RsSBp28WL1xmP+V06KAHdgvhphPOjv2Ma8o/oDMkuLXjJQF8/ViKJW?=
 =?us-ascii?Q?sH+Ny+5hLZ2H/nSpuLIWBe5SWZsKSWyExtJ9QYvV8kKn48pAs+qgkIXBlrf6?=
 =?us-ascii?Q?yBhSJeFEvNaaO7tDC7Fx1U588D/XgZ8xKG9Yk2Oho8TpYClJGUwC+DhGBHaN?=
 =?us-ascii?Q?2j30EhlufcH12DgxavSY7Sq11Y+C8b4S7EzSKZXBZNke8mEGGCCAg8YCNXy/?=
 =?us-ascii?Q?gj51CSfWLAdLDYovP9NYSACvQIi6u5wQbYbhApKm8bwmCepcxT9+9lV2ioxs?=
 =?us-ascii?Q?/ZPQskchXzVlF/hJ/c0YNz1NHysT1Mkx29SHnaVrm+77d7yAR4TM1yHM2jIe?=
 =?us-ascii?Q?+Y8WmWanxK2dz5yvhTF0xYj4JeLoqU1mL3OzW+ySx86cAgMNgfyr90Ce0nrX?=
 =?us-ascii?Q?vbjlCI2vizF7RDA3B7VOoICwYt3zaYIIQ0Q1or7nHEYXQ3dLJ6iPuK6b9otg?=
 =?us-ascii?Q?3esqaQ6TrNXtVAvFtu2y8ItVUYxjc8qKeRTkDl99qXYpKw//Bhd3tX+/w/CJ?=
 =?us-ascii?Q?Z0EE7NJH8hvhOdV81ZyEAlkHv2eD8lInCWyg/ij4hKJLmpsWu6y1zBG/B+Pj?=
 =?us-ascii?Q?CEALtQ06CTp4SkJdXmv6sUwfLzac9nmB4da3CXpKgle6DKuh6sATIKP58Uz7?=
 =?us-ascii?Q?Q9CNMCaoIfAjK4yTxBAzk1g4PAmpAwXUBV0L8esHMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5qX6Cr7HvM9kzsTCSQRhji/B3nd1unN6gJugaw0hTkO7ZqqYTVyeg0CHr43?=
 =?us-ascii?Q?lskzw88vx1+1uW3zZZDPWrowENNr2gGPBN1oXGwoLiAC+pRIAJhjSm/R6Csh?=
 =?us-ascii?Q?Nv4CgAf0ZhJjJFFog+eJFncDcBEFQAzftq/IkjPlcwyt19wb5m4IZSRqMayQ?=
 =?us-ascii?Q?TdIOkrin37miFeQKVrRfXuoPCquMRSxP14ROZn4E0uUFeYKQW/LlS8hUkz3r?=
 =?us-ascii?Q?XDV2F7FdxSjG9nl114AWdLZDUni8300T4kimJhOJhIG0p+aSpbYMAFoIKEXv?=
 =?us-ascii?Q?6ihmelhVCnYhx2zDtuzmWEUPigF8t6jP10MwvBp5Og4zJT3tQzC/LBw/wu/9?=
 =?us-ascii?Q?x6PtGCKpywkq90sIMmcqz8y2iGo1qBy1ZjNBYAyWMEj1aMFKXDxuhYstVd0F?=
 =?us-ascii?Q?WGyf8TqUwn7UCFUP1G2r+ou52dr0t0+e/yjgpWsVVjf6H/mcc0iHf6S3ltvR?=
 =?us-ascii?Q?4JwNLJRVxyZwpzNIpFY4mC/yp05IN2WxHtKqMAD+5zoyH/tevHn/eQ4Ur61Z?=
 =?us-ascii?Q?jwOYKRBzJdiH7dY1KONPNzzoRkt+8Uuvw6uE/gGSkq/AZfqmK98c0zTkudrf?=
 =?us-ascii?Q?glSBxz+tSvcBTFAQXymTN3tadk1CcLvkUNQx/AkUWUOx0/mXbx7k3+K/xS+g?=
 =?us-ascii?Q?DWpHssw/JzqBN6joR3pY/J230K6FDXIFBz4V9MWm/XeiFoBdaQ1G/B/kBAtd?=
 =?us-ascii?Q?KKzbH6pFAMPWKN2x5feRbEWAhj7WjiPgkNj9PYQtdHEvZJGGaEAZEfIRyhxa?=
 =?us-ascii?Q?zCSfLP913X1DKmTsIk3Bo4bO70Q2dgbfLBRslr9aOJRCS/p0OfaKYmQ1XGIk?=
 =?us-ascii?Q?H3XLsaxKTIuWSN4BaZk4DerqsTM7HvMdWOSjKjZpX7kOwM1QQurPh7U+xOCf?=
 =?us-ascii?Q?oX+M1XH6r21qxHZWm43njcPcorw5+NWrKdb/s6mQl1/+j4F7Aigomc4GOMpI?=
 =?us-ascii?Q?y0gl5rZOdGZDfJ7UyMs90AjQHYJiPBbyctsfVOismlormLDLVsjRVBNbZr/E?=
 =?us-ascii?Q?vV5IMB4j3YvBDvvgNZNQR3gi8leCZo/fTK1kevIXR4zmqrCSztoBOi6c/H5D?=
 =?us-ascii?Q?xCeKxANNj2k//Y9nJe71yhyipto3uh3Cv2BT0NNow6W/R/DxT4Zy3vefhiOE?=
 =?us-ascii?Q?+fIZL5y5jfBskDgI73D+rfgZTvG9fUryjv4AWHf/NWReTWivwFWWb59l9OC1?=
 =?us-ascii?Q?/x9kZTW/mJsSdSDAhto7Ped+a7Ufkg1k1hyEMP5v3jOM2edg6oeKorBNl1aM?=
 =?us-ascii?Q?Q2/DkTNUUKdavdkxHjyQNYw9VhH7wsR/sDA9K3YQjqerMErlQmzgixY3ZHLG?=
 =?us-ascii?Q?xq76cYeXfhK8IZXYZoH/oqInYE3va7QvtmtU7hKyg1MINqgvo+YE2+nw8/L8?=
 =?us-ascii?Q?+F3vGuyNGw/glxS+a69Ju7HosfddkwrBXJYbKzSECCzZeLIMzt1/yuT0DKxT?=
 =?us-ascii?Q?pbuUFI47IjThlDF9YXDn2ZDqqwOG4SFuJ/yBazVoRD6E4hrMfqFozCf4e1+P?=
 =?us-ascii?Q?D/pNGZDr+Z72YYIEmCCEm+lIa2BysPYdHd3LQofAezdt1mXXyFJSn+Dao7nt?=
 =?us-ascii?Q?XboV+Y0/Ui+jdHiwk2MqXfaKGmpFjy3dcgH5+xuNvcbVuYuEpSNeGTyd0JTD?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb500c44-b46b-4714-bdb4-08dc7e8cb90d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 20:36:44.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jFwkSvrXxGbKulu57p0jW9ikh392ryzMOUOKhKlwA0g2kfA6IQOKVktZBGF7SfAQb3yIUHbsk8o3ym42AuvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about an unused irqcount variable. clang is correct: the
variable is incremented and then ignored.

Fix this by deleting the irqcount variable.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

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

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.45.1


