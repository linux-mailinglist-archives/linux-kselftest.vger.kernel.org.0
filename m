Return-Path: <linux-kselftest+bounces-34836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB47AD7A03
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F2E3A2DC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36F29C339;
	Thu, 12 Jun 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZTZS3/qj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF6433A0;
	Thu, 12 Jun 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754427; cv=fail; b=CCQfM7F5SdOCF94+1fWCp3UjGuW8RTbpgKqfL/c9Rv7570xdgW5F1XCDFglkLlAE3PNpb3+xtnacKjR3NFdbrc6M5ekZkFRPwxwvFNhQtTjVnQzy97LuUPPwaeNilZCP1z4+flSNNEd97hOACl+8cOiuREM4qahLfdZfJxk0gn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754427; c=relaxed/simple;
	bh=8XyKSsDzcTjvO37QEMKnrbqKkhhOtyT2Q6DvDINjp+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmt8Ia19ZSouS1xPHpbTN1lp039zpnWU9i3kBvQRcgkGtSy4wwbRg5aRPRXfzVbRojT7/rjvqZXOry+/ud03WWlHBTGfn8KRsRaOJi+JDP9wxVtIkGbevCtfZgSyHqf74vrUiRLLq06cL/KEldTiekb3N0wdKusHC2r6R9ptJI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZTZS3/qj reason="signature verification failed"; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx7S6XqY+PGM9atTIwL2ZQjLzcSUGhyt3Umj2qHFD91c8S00NaQyQ9TzGBVSbcvwfRGpGMqrIEzFu8uLfCrZbRPm1bQU58yRKBZbe6wLBgwwSs53xfbFhVmkw6AwjGXgPu5483JK/CGVjXeqvXUmjrG7PHhZ4QwMSBCjVvQJugT3RQhcwOoN24gd3x96KT0q4IsDZxEC64nNKFOi8J7PXLWR8xNUl9+3D3XddfHbJ32S3aEaqrgyqdGEAXZahPWuc3pJYrxiUZssreGU7e4uqOsc95Xq8HrwjRF6YaRzB8BeCa+E7UDtBq/q3PIeJFPNtYUSRHihzd5LsgGLx7o6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly+Pf51NLs484Cb6/M7X1vFlYZdBCXkcK6d6ufzZtfo=;
 b=B+Y9QRi+tvCpHtVghx9MFXGpf51JuYg8ZiFo1A1S6P1w/xwJnmFlMxBNU+ZRo5gUaOaVNYyE5QkWjU9uN1iZYA65yqiOfMOXa6aIjxBzUISCro8lky4S50AD8JrN7JFRzW9lo3Rgaco5o4hlMVhXmGVO7Oh8cp3Di3BUMmHy90J5J0vignffWjKKkoKwN/ZwHh2zZ/0AHKRlHiUamCDp+Pl6OpBLs/z/BVkHKRpMZ9Ri6yXh0Al72o983j6acS4Gl/qqD3MFGnHNBFgOBDydpNzV3iDbscZzwazOnoPnjAeS5Zr82eU92nl5qXC5vhTJ0p53JdPGaxE1fEEJGNqgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly+Pf51NLs484Cb6/M7X1vFlYZdBCXkcK6d6ufzZtfo=;
 b=ZTZS3/qj1y5Ic7vMeBJhKI0cR6XBmcnXdEkCNhUmTIWb+gHntTNG2z2REOpwON4+w+fM7xLKlftFnSq0MFzxVrnj8cH6dF5pmBpe6abak4osXLTPeAO2k2CjJPQPPTUxKFCmQ1Vg8p2DRYMYQL8Y7T1BtRZHhDS/XYlNF7wUOOtWHNiou+QkI9WHxHxiSw0eNSbTX4V/pqhi3pA0Ra364vPZ87H3KOTzBveIkUliTf3beqeGLv/RwxJXM6ME/i0R5Oc3lohUlqqsNt5gdeJqvA8Chv11aWoX1uZCeg82T+u+2Kd9A435NLwSn3YErsZqhJ3GE3X+ZBgB5iZVcW2gCw==
Received: from SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::17)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Thu, 12 Jun
 2025 18:53:41 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::3) by SA1P222CA0043.outlook.office365.com
 (2603:10b6:806:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 18:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 18:53:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 11:53:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 12 Jun 2025 11:53:28 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 11:53:26 -0700
Date: Thu, 12 Jun 2025 11:53:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Willy
 Tarreau" <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEsiJFku+wR9KxE8@nvidia.com>
References: <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
 <20250612154242.GW543171@nvidia.com>
 <aEsUGP8xPTDjG0ob@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEsUGP8xPTDjG0ob@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4219867c-b887-4bb0-6400-08dda9e272f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?aunnaQODNKNODhjsvjtgPcUth06+djaWddDkhKTb38UBl9leScrFUAsG+Z?=
 =?iso-8859-1?Q?1hM+vC7tNi4GCieGIlnFQpvn1JTkmcCXiEqMvbfjiVU5fnBr3tU90uD2hi?=
 =?iso-8859-1?Q?YXAH8hxsbQaVzawTcxcUhGc/7bV2dGMMqooaJzkB8pXCpotUNF2EA8O28z?=
 =?iso-8859-1?Q?Dc70++U5VI7iDSlvOETJpUu3o3CXB8PIIy0EDINs6VyeLbeCfPBjVcL3a8?=
 =?iso-8859-1?Q?eStmydLPuexf34jCjXa1vN1SkX1qj6b1xjkIKAYs+iCWd9+CWknn1veI21?=
 =?iso-8859-1?Q?6fl36odNIpHhCcEbhTMga+kKYhGZY8GleOQNCxcJd0NcEkcjLyGftzV8Vg?=
 =?iso-8859-1?Q?RoRl7SVTk8Ivg6oI+0Yw3N50JmzNDfKes7weyTgGbJ7wtb6rwaTMVyrMXN?=
 =?iso-8859-1?Q?73LeTE8oc1Div0+cId4wPBk2wl0JbME3UtdF8AD2WkWsXTRSWXYEHzsnC3?=
 =?iso-8859-1?Q?QIlwbKPx0ztPflSJx0aLKfx/79/wcpcUSuJPViTGsmnUJbfcmsXMot5IqN?=
 =?iso-8859-1?Q?jZsO4s+D7PsLjn521fxx7oVUh8US6gTlw4BjqNfGYrS31GONwUOzIihZmE?=
 =?iso-8859-1?Q?r/GPd2uurGAU+4eHnqG0wQ7v+EWZLokjatWnW4gteAfuuGKfXbfeijyaZO?=
 =?iso-8859-1?Q?00Z3Yy2H/oSe4rmTzF5FzIfwFCIp74JGh11RNpxXw+YDeQbJqPYA/cG/c6?=
 =?iso-8859-1?Q?fprDVDMDAJL3oHb3fvf+u/dd0nn8ea9CytiKm00KO8dQxJYMGnMz6xM+7X?=
 =?iso-8859-1?Q?lgj6OSCydgr783vydv+2b9FBGVhuHdELvReEWH2JA5S5OMw+Li8GMjbF0a?=
 =?iso-8859-1?Q?rkXCKnfXMhU5+Z7Y5UHyd6DUyESSI+Tgn+Coo6deFjfoe1Z2hHHsvO1qzu?=
 =?iso-8859-1?Q?2Leik55ISyk55d/Nh8HsBysNe1LzOlVb0UY+9FaqvGZ7D4/uNfa/1YK8Ax?=
 =?iso-8859-1?Q?IVrUPIg5fDt+hULw5ynxU25fkyNsimn2e6X/Kwpdv4+yVjVN5+WWga8N9d?=
 =?iso-8859-1?Q?13ACiKOtVszy0aorBOyFIm+nlWkeXDO9EX4dsQR/WRuIttEEz2DgFwmZ6t?=
 =?iso-8859-1?Q?uIpcDLk0GfohDqYXgwRJLJgKfDt5xKuAx58H1aSAVMQGulLAiDabeWVX3f?=
 =?iso-8859-1?Q?nMpsE9P5+5s7EuseN7bbYPM4eqxbNJuyBR8yCppZgpb4Fpk5ps8fPAgxR5?=
 =?iso-8859-1?Q?eGKKHlrbxFp0JykS7Tltjd+ipsc4siwwsqf6cmgDaLqma7RB9e6fSnl1P6?=
 =?iso-8859-1?Q?aEvNBOOYrq6Kv7PlpfDFNs2IMxLaYj+pTVRm8BEveuExs2wYOkzHoZ3hzH?=
 =?iso-8859-1?Q?HgLF0ssxro03Etz2WcwB+9u6M6dc87nZnHHW+WD8RfnICLka3OSGd1m5tM?=
 =?iso-8859-1?Q?h0vUlg05dt4C1FeR8Q6hdnAZsDVRj//6lydCXiLGIDxnryjrnZyyodJg/L?=
 =?iso-8859-1?Q?5rLWK+BPWxiWw/LuRLuleeG3Rsx9s46cTWZLXcy1T0Z5ljQ7J34pUTjma8?=
 =?iso-8859-1?Q?lcuuqHscYSeMPnxOURvbaSlyfQAV/VjmkVPvpE3vVulkVSCmF/SnYfdZAB?=
 =?iso-8859-1?Q?8ktA4uunPNdoko42JLbkpVZUTwtj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 18:53:41.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4219867c-b887-4bb0-6400-08dda9e272f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

On Thu, Jun 12, 2025 at 10:53:34AM -0700, Nicolin Chen wrote:
> On Thu, Jun 12, 2025 at 12:42:42PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 12, 2025 at 05:23:01PM +0200, Thomas Weißschuh wrote:
> > > On Thu, Jun 12, 2025 at 11:58:01AM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Jun 12, 2025 at 04:27:41PM +0200, Thomas Weißschuh wrote:
> > > > 
> > > > > If the assumption is that this is most likely a kernel bug,
> > > > > shouldn't it be fixed properly rather than worked around?
> > > > > After all the job of a selftest is to detect bugs to be fixed.
> > > > 
> > > > I investigated the history for a bit and it seems likely we cannot
> > > > change the kernel here. Call it an undocumented "feature".
> > > 
> > > I looked a bit and it seems to be mentioned in mmap(2):
> > > 
> > > 	For mmap(), offset must be a multiple of the underlying huge page size.
> > > 	The system automatically aligns length to be a multiple of the underlying huge page size.
> > 
> > Oh there you go then :) Horrible design. No way for userspace to know
> > what the rounded up length actually was and thus no way for
> > userspace to unmap it.
> 
> OK. I think we would have to skip those cases then.

Or.. maybe we could just allocate a huge page:

@@ -2022,7 +2023,19 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
        self->fd = open("/dev/iommu", O_RDWR);
        ASSERT_NE(-1, self->fd);

-       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
+       if (variant->hugepages) {
+               /*
+                * Allocation must be aligned to the HUGEPAGE_SIZE, because the
+                * following mmap() will automatically align the length to be a
+                * multiple of the underlying huge page size. Failing to do the
+                * same at this allocation will result in a memory overwrite by
+                * the mmap().
+                */
+               size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
+       } else {
+               size = variant->buffer_size;
+       }
+       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, size);
        if (rc || !self->buffer) {
                SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
                           variant->buffer_size, rc);

It can just upsize the allocation, i.e. the test case will only
use the first 64M or 128MB out of the reserved 512MB huge page.

Thanks
Nicolin

