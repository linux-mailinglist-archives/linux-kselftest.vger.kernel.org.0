Return-Path: <linux-kselftest+bounces-34776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF21AD63F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 01:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E721666FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1C2C324D;
	Wed, 11 Jun 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bv4oJOcr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DD1C07D9;
	Wed, 11 Jun 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685418; cv=fail; b=thvTc4NmsEodVeBJKe2zslw67sjMdJR+bq8ZGCJpRClVe7mtPgr9a4MbdQ+UgEZy1ldYJlU38L/S5Wpv7bhpnOwRKbo0yS00qO2N8/4BF/ZMGQri869Bb1R/aq/jv6jcGFxGHSrc3blN3Vd5j90gtBTAbIFa5lOJuZ0L9tQmVdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685418; c=relaxed/simple;
	bh=a+ftJjN38fKSN478mlvGsHJPM73pjQahltFn5b5vS0w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4XS3d28mywlWIRiC/vh+yiz5Z+UEkAJQ9KZQE9OCxIKXB36ScfjbCTf3Sv5yPiuFVCzFFpHQEatMTGUahATXv0BM87HmyEjjg8MclYy0SiU6wRqJgQoRfgLar09YUqwiqGLFnaeObyPa44B5k7Fpk5LkFxGeBL8NGA76kCSLcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bv4oJOcr reason="signature verification failed"; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKJRr4JsS8OpIM/FJDGZfwYuLpN5WJeE11dJk5ADy6tcZB57T8EpIYVvVJ2StqoanWf9e0bAwGZ1mzlI8KeqlEFAEQl5ogxZfP5n39QFi9St3vY8IkHq2FgtUMe4i8oIFL4JWsXgTHXy3D+kz1xhPrxd7nKcPCVbk1Q33HFHN+E/vVEYalF+pQfNdBo4zYMW+X4anilsG/VKC2cbHuzLbs+ZV98VjNu5gcd6/8fpCBnIyBbfhs6HsoTXiDm3380kWjPFDKyrO0doFi9u+YlOlsu3uMUmByXF2eQQ4SKZOxEhfHMK/41KVVexeWVx0LinCm9CBR+BzBGB64K99quq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwTQw7ICxDk1pkK18jmrHJyZJU1D38C0o+mx5REpRTU=;
 b=dk2i2vhn22M/hB2RqIjHhPZ5xBjvXZP9N1Qk06bfsRisJOVpvsmmw1jxFZ1u/yCY7bX3cTT3uUZWbLZElh9GubpJOHGDLHnEWRRnA/3VVEqtCbbEqd8ZfojIkyQPohBbX2SbKHWYUUUmrBaGA5yHIJAI70H+K3vA814nA03T47+fwC+GyM9RgkD/jPAIaEuXpuge1M1FdL5uvqqvpGfsqRFIRDcuyLAVfeU5zJoKnBYbhp9C6y44FhSRThJpwDwUbQuKYxGaV2S984T4FLVoKPGPcK1M+L2Te7u4u1mMICk2chQ8T+gFz9xkSe8ymXSUsFS6H8undeBEKU4b/Kzn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwTQw7ICxDk1pkK18jmrHJyZJU1D38C0o+mx5REpRTU=;
 b=Bv4oJOcr/Fh8AOgZg6v9BbzYUjIagqzNFeIePqBAno15tqO0wI5MvHnh5Up9a48YP0sNZl2ZHLH/uW8d5Fql3SoPmKxORrKs+er3SPpIDJMNTlBSxkOO/kc+wGbuki5msQtHsSDoUdycNJZeEm0ZWi7xK3xGZ0FUuKaag7UX36w/lZw99nxGIk5KrRpXMWZw7M0nwZhD2h3oMi3ySDePfjR1BeJ0o/GFQ1sL6OcNN5r7FBvhxZ85MJPud/JgCds2kFod3wghfSvyUu+hrt1J21vRGmAATt2PZQ1jLurZG4GickbfFrUtA0fWr/q1TftJf1FbZB3S29X5eOCHF3O5TA==
Received: from BL6PEPF0001641E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:e) by PH7PR12MB7987.namprd12.prod.outlook.com
 (2603:10b6:510:27c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Wed, 11 Jun
 2025 23:43:31 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2a01:111:f403:c922::3) by BL6PEPF0001641E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 11 Jun 2025 23:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 23:43:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 16:43:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 16:43:07 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 11 Jun 2025 16:43:04 -0700
Date: Wed, 11 Jun 2025 16:43:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, Thomas
 =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Kees Cook
	<kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, Mark Brown <broonie@kernel.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEoUhPYIAizTLADq@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEn5jmXZbC5hARGv@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c3de30-9fc6-45e6-b2d0-08dda941c5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?8o8EaeiJi3LLRqMCZ0Umyz4Nem2QTJhrtuNNGLobeLFyEjSncIIpzbm7vN?=
 =?iso-8859-1?Q?f7uYlK3ImiueBvTVu/cJaCcYa9JIdpbst3QO6dj4JceYrNoJHWwJXRNdkW?=
 =?iso-8859-1?Q?QEb9AIDD9m6tNT9s2s0VHT33BAam6UhfgxyanoX5/2Rp36PRxBhI6fLX8e?=
 =?iso-8859-1?Q?ujSvdyJXIMP4IZ0c9YmMuFiotaxyDHvyxlO6aNZRV/tAFiQcMa+hqhMVAC?=
 =?iso-8859-1?Q?pasMGzo0RM/KUOCQpJJL2IJg6Drai8f2VONPAlzqK2UoBM2kqsEmuq7zwR?=
 =?iso-8859-1?Q?ktUjjFT6XY+K0+2LMHqIYSLTkFMhx14kaVvY/T7dHhSqLMKZvXH1XiuhF+?=
 =?iso-8859-1?Q?gytZ2tNkRK+/jkHRj3G7pW2tQahBXLpzApS6q0AgjwNAGwOu0TsDyIBz1l?=
 =?iso-8859-1?Q?Oo7VeR0aNbTLvQMieB5+uaqabF2CbCDk+LbDdiKlCrDP3emwe7oLrbiBfo?=
 =?iso-8859-1?Q?vnfKnWurMKGKNFMd9FWqbeL/Ho+5znKMrnF2gAkGRzeSl4AqB6MIChBBOr?=
 =?iso-8859-1?Q?nJHaRuPWv7iSqkbUu80lo2iDv1bWu26sIWsxOPBMRlCJ4nREInBqyn8ocn?=
 =?iso-8859-1?Q?rrL2OstyAXeaLzMNDHW33lhZa2M/WvFZtO/zEhXZWHX/cZ9qw4VITGEoi1?=
 =?iso-8859-1?Q?5P1NGg5DSQ1l69L223lbzfABZBO91xPl9Qe34sBxn5lWUPB5DpTkqSpSep?=
 =?iso-8859-1?Q?1kD0tSStGklA9R7TRAKMhxOjIlQQthrBwZfJb0ehhI7Yb1fFm49iCyJ0A+?=
 =?iso-8859-1?Q?SmpqWl1HWSbGpdtqLHNaIC0TkS3wpfeEEkAW0+ugwh2Gt4B+uBi9zVGUSq?=
 =?iso-8859-1?Q?MdTMKW3SrIPckHHK72wKx1tyIOk2jVTvDXf3c7Q0NaWB3mnVcSikHgxGfj?=
 =?iso-8859-1?Q?WnbndWNKBRLdfeN14GVvprdkLyEKY/DgttS+sts9LaGBuoSqmCXbY+uw4F?=
 =?iso-8859-1?Q?ipiDiMqZ6vEOpCZZppCLxxM6uYxuSMN4AMO18r/JZrAhHEzA7Cg4zwNYsg?=
 =?iso-8859-1?Q?ifsR+vw78z3awAldTzQjQFQqYlBWTAqVk3BfcX7YU+5LPxFyWfnFBkZYhG?=
 =?iso-8859-1?Q?abd2yEA5RNi2pchEKj+0dUf5EUUjUkTsj/Xlx66u1Hnu9tsLwZj3vBCJQD?=
 =?iso-8859-1?Q?rghexSnuIo+yTyOM4TVvNCe16lVh9h1FWRTTvPm8FLLuLfH0yL90/mbD+C?=
 =?iso-8859-1?Q?5vMEwPUyWYMgFULZHRwModVFpfykXlc3ZVLQY27D2uvyOqzt0I02n0b08O?=
 =?iso-8859-1?Q?3gC14CDvNY0W7WoigArFNpSFNsI6xAHr+248YtmEagf86cSV4jyF/klWVw?=
 =?iso-8859-1?Q?dx5QhVZ4SzjnJl9/hgDUjOh8FZCbAfoVucKhqRW+1BLXIxa2J2GT200u31?=
 =?iso-8859-1?Q?pPyrP67fu7b9LXXkj+ZY+NVlpgR+W0Nnqhyhmpt4fE6Nt9nTDGDUQxoAn1?=
 =?iso-8859-1?Q?KHmFne2O7a56cWePle+PujRfLbCaTvqrb34Rvv7go8aO2+jZY5cwLby2X5?=
 =?iso-8859-1?Q?RUBT9EIzDcNX8LMBqTypZ/4GmrIBSL64AXdoR/FRqII+FjerVjt46hvLIF?=
 =?iso-8859-1?Q?0I3y2Uflv7GxPxeeCTfNOss2SH2e?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 23:43:31.0114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c3de30-9fc6-45e6-b2d0-08dda941c5c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987

On Wed, Jun 11, 2025 at 02:48:16PM -0700, Nicolin Chen wrote:
> On Wed, Jun 11, 2025 at 10:19:56AM -0700, Nicolin Chen wrote:
> > On Wed, Jun 11, 2025 at 10:04:35AM +0200, Thomas Weißschuh wrote:
> > > On Wed, Jun 11, 2025 at 12:05:25AM -0700, Nicolin Chen wrote:
> > > > 2) parent doesn't seem to wait for the setup() to complete..
> > > 
> > > setup() is called in the child (L431) right before the testcase itself is
> > > called (L436). The parent waits for the child to exit (L439) before unmapping.
> > > 
> > > > 3) when parent runs faster than the child that is still running
> > > >    setup(), the parent unmaps the no_teardown and set it to NULL,
> > > >    then UAF in the child, i.e. signal 11?
> > > 
> > > That should never happen as the waitpid() will block until the child running
> > > setup() and the testcase itself have exited.
> > 
> > Ah, maybe I was wrong about these narratives. But the results show
> > that iommufd_dirty_tracking_teardown() was not called in the failed
> > cases:
> 
> Here is a new finding...
> 
> As you replied that I was wrong about the race between the parent
> and the child processes, the parent does wait for the completion
> of the child. But the child exited with status=139 i.e. signal 11
> due to UAF, which however is resulted from the iommufd test code:
> 
> FIXTURE_SETUP(iommufd_dirty_tracking)
> {
> 	....
> 	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> 	^
> 	|
>         after this line, the _metadata->no_teardown is set to NULL.
> 
> So, the child process accessing this NULL pointer crashed with the
> signal 11..
> 
> And I did a further experiment by turning "bool *no_teardown" to a
> "bool no_teardown". Then, the mmap() in iommufd_dirty_tracking will
> set _metadata->teardown_fn function pointer to NULL..

So, the test case sets an alignment with HUGEPAGE_SIZE=512MB while
allocating buffer_size=64MB:
	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
this gives the self->buffer a location that is 512MB aligned, but
only mmap part of one 512MB huge page.

On the other hand, _metadata->no_teardown was mmap() outside the
range of the [self->buffer, self->buffer + 64MB), but within the
range of [self->buffer, self->buffer + 512MB).

E.g.
   _metadata->no_teardown = 0xfffbfc610000 // inside range2 below
   buffer=[0xfffbe0000000, fffbe4000000) // range1
   buffer=[0xfffbe0000000, fffc00000000) // range2

Then ,the "vrc = mmap(..." overwrites the _metadata->no_teardown
location to NULL..

The following change can fix, though it feels odd that the buffer
has to be preserved with the entire huge page:
---------------------------------------------------------------
@@ -2024,3 +2027,4 @@ FIXTURE_SETUP(iommufd_dirty_tracking)

-       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
+       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE,
+                           __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE));
        if (rc || !self->buffer) {
---------------------------------------------------------------

Any thought?

Thanks
Nicolin

