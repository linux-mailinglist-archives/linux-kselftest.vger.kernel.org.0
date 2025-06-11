Return-Path: <linux-kselftest+bounces-34772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A05AD61D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D131885052
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677A6247DF9;
	Wed, 11 Jun 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hTKn8bA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C62472A3;
	Wed, 11 Jun 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678511; cv=fail; b=l3WzDH5DOb+PfL5wwfbh8eiNBNW0xMN2F40ApjFCBLCSnWMeThkcfWkH8HgV9qKI6Ns8nMsVqebs3A4X/vh5YTFHAg2UmJHrWLDwWKANZFW8NWcGKj4UmvRTTaFT0/5eM8lN+Sl4/rJkgHljI5TLyAb5Pgo19FKhOBwd9TL8TXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678511; c=relaxed/simple;
	bh=7jcW2ixufnjRElbGLWqTHHQsmuubN1g7u8MQAjN9l3I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcUIn3EgVfk2PXEKg/p1aPQPMZmg9l/GzD+/J66I2oksfTOjQ5u0t/2ierzmD8NCJpeqWI72jUD78q97FfW2arwyic3i/BA+p16z44dkbcUg/30tkpFvzgv0zBOi8TQEfpi4VGRaacyzOShUzGbmaChyVlOO3DL0Ehyxu783DSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hTKn8bA9 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzDIwYmaE/MJaRaDKzmC4bmuiq/oCww+vbdehlwcuU2qwrCfYKn3FBcUzKMtIGA/sjCkXKjYtNMQeiqO9CQ9NqRx2AfsOMP6aF74yP1qE6L5LF3aagbWl9otx8HGV6cq8qYNroAdalXnoiV4X/JdwDvH2aGCWjz/EL1Cmc7DOIkjFPoZEmpEMW8MunQiP53F9iuDQGiNaX6JiewUbatxh24RctkhXoRCkibBeCs+KGdOD+uipZmJFbKYbzaEA4kDsd8tded1nZWC7HNVjfhK1c0+oQn9TqY0nbKAlmFr5LnzosM911Tc1HiAd7gSrg20X84xYjhU81lyd7jAhtwPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6kJu/b9VdoFV4YStMWf42p7cEe9aXtQ0vh+A0YyPPU=;
 b=AeSE0KgwefWDbFCRsE1o4I7trSjfXVKb3wPxNxLbo0Y47hijMCxsfNbICpuIBZGuTty6V6jPIHUUP7xXJw3gWxnzrWoUj64gUIPZY/im9Pkqq28FnYwx3oUCgNQwLL4YZQPSZ4oIWq7oFO+AGpSJU8ryaRlwUMNYvdje19Fjxb/bISydYTKVbHyOz0CP6uxkrRGFOr8LlSeNkdbzVk+O1zCQZjxTP+9pixMTjCasnvSCsEt7biIZAm5OGJO8CtyPUvK1g8iyJA2dxCUQLQJ6t/N109cIcKkmOQW8vEXFscWI1lpVFy6lQShdCmKU71qJvbmMtaLyW6c4RCiNrabgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6kJu/b9VdoFV4YStMWf42p7cEe9aXtQ0vh+A0YyPPU=;
 b=hTKn8bA9mE6iRBKWtQOBHeNwd7bF2CDiqVsjhJWEdlVx6U0tMydW7IzJaoZxlSN1bIAdWJX6rp9VSAQVs/8GnJdZa4eaq/1ERnnJ34axAt/RAgvDhCTiktjMiA224yOSkJsxDkMgRAPn7tqIZEK5D6+AlaFjKu1yD3LTl7p6s0iokM0eO+/T8P5cmFhxNqm0lwGg8cMFPtyOulHh+24JOYmgnDmGutd4bEap9/906Nv7YYAbFuYtlHqsuR2k7Zcyx1xJSjULaZn1RiPJrOylmwf9srRKm5NDA3Yi2HZFozn0ySdd6PIdEPute9B8TK4NulPfijMqp2Bw+AcUNn3WDw==
Received: from BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) by DS5PPF5FAA0E762.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::651) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 11 Jun
 2025 21:48:25 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF0001641A.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 21:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 21:48:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 14:48:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 14:48:05 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 11 Jun 2025 14:48:02 -0700
Date: Wed, 11 Jun 2025 14:47:58 -0700
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
Message-ID: <aEn5jmXZbC5hARGv@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEm6tuzy7WK12sMh@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da97f07-0502-4f81-6547-08dda931b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?jraXD+arxW0EHB9EvXE+3yFtuh1aOyzjIkq/Mb1aBdZ76nCdBLbzvmw3rQ?=
 =?iso-8859-1?Q?IkdHJNvLkzNMCqKmMFxk2RwS0Xm3p9dtv60M1JxlYUYHghflsDEVzHPuSf?=
 =?iso-8859-1?Q?bf8IRl2thZW+jrveBy5bq/LEU5v1twlJZ3PEPTRYzoQiSymvNsEvydW1+S?=
 =?iso-8859-1?Q?LEslyTCgXcQ4D14QMyfgtpjThu15Z2eoVVp9+tas9jtrVG6Y7uyAqtMASf?=
 =?iso-8859-1?Q?gp/unIdDrIQ1zxxLNCefHAAVW9551pjxQDe+r4LtRUizPtGl8kICKYocD0?=
 =?iso-8859-1?Q?tK6b5EkspOSWtqpZekw3LX4KbQMGVYTquvpoJr8gF+hPDw8vB82seLwEUt?=
 =?iso-8859-1?Q?57p5K1Uzqqsx03W6i2W7ahBbNpLHSYQSBttjTV5+OY0jPDz7KMUNGgQPLW?=
 =?iso-8859-1?Q?86chY5SEtMV/NNf/IDOB1RWi8Xrh7R2qOeeNrK6fecuw2ccDlD5KK7ifpD?=
 =?iso-8859-1?Q?OuLjlpZ3XOqaj8xobl0N+OMVVbDxdqD5wFPZ99O5+W0n566i/3mprJjtvo?=
 =?iso-8859-1?Q?ZVGfn3s3aVQmLG6OblUbzSmSC7BAfLAyYQsbbvO1o1F43iZ1b4UXmE3Pfd?=
 =?iso-8859-1?Q?RceD7tu66W5HSq7vEkuXlHvxSmxPVWTCoSQArkDOQinnnofNZXkJ0dmvf1?=
 =?iso-8859-1?Q?EQn/lyjiPvSEFuHZ1maLFzjmcI/RBXT5VphksN8CJ5A/3VZzK1oNaZYDkH?=
 =?iso-8859-1?Q?sHQPdr94JhOCXJfqJZ+IMP7yorPUtt3W7LXCZpRsVDCLfSGvbB6NPrVyul?=
 =?iso-8859-1?Q?GTlzdI+5CRVlSn8qPH6TdQ6HWlGNSkzg7qfOGFY/sZjUGtk1gGl1+VpdCK?=
 =?iso-8859-1?Q?w5VrLpSP7EAGxL1RV9Jk/t5wVMkkidRXghK42kLpsXeVyRDHp/xtbHY5h9?=
 =?iso-8859-1?Q?/yfDUXXDRF5NuDTDHRc6hPmuzOpynII2vKDXDwSq87+pFpS3o7FooC7znK?=
 =?iso-8859-1?Q?bKdYqaWP3JiQcGfG+oz7Tu5yTjphajZGPCNh1xb8F7BSXyjl7Ole6qe61P?=
 =?iso-8859-1?Q?m9gGDGZRgvji30tWVTyUPLIY7JrIZWNI2RSCJj/3ILdczfwvgtJxx63Byk?=
 =?iso-8859-1?Q?hdIgzeaqXcGidA+V+q+J1h1PyqLly//5JnBMm6kSeNJ2P2wTdNToP0d1jj?=
 =?iso-8859-1?Q?CGM6oqHlIams9E2lPKYcsgc+n1z4+xsFzeBZXS0cJ/pEXvlfrK9yhV8XCO?=
 =?iso-8859-1?Q?jHtPFrfV84M1Vfx/qDrg6FoT4XmtFA58EIaVq8bIfLC6ltkg9XLMVvvDpg?=
 =?iso-8859-1?Q?i8PvGATEVsInU2PcqOOgZPBgdgQg5mUokibXRY45Eozl5eR14PedoBxxdG?=
 =?iso-8859-1?Q?6kv+Fsv9XWYCrzKvnkAvbU+oGEao6MvZdHksSSFgKAityAaK+fWsW4Wphl?=
 =?iso-8859-1?Q?YFLTJCLELS9iCv+FRXuyHvN+QcFFYSolV9rsVo969OYpB+TfUKx6PX2sCc?=
 =?iso-8859-1?Q?/xzY4AhJa05maOOkuKKHvbjkLNb5wPoo1ZliY7Y5ZC/nryBb4fSMyi5vz1?=
 =?iso-8859-1?Q?OZ4urBj50GbnlX8tLEHtUJxmBn2W3UwdDrh/umvMATokNAciidQpGkywoo?=
 =?iso-8859-1?Q?sZL+X7l/1SimUd8MSMka1JDbw5so?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:48:25.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da97f07-0502-4f81-6547-08dda931b1ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762

On Wed, Jun 11, 2025 at 10:19:56AM -0700, Nicolin Chen wrote:
> On Wed, Jun 11, 2025 at 10:04:35AM +0200, Thomas Weißschuh wrote:
> > On Wed, Jun 11, 2025 at 12:05:25AM -0700, Nicolin Chen wrote:
> > > 2) parent doesn't seem to wait for the setup() to complete..
> > 
> > setup() is called in the child (L431) right before the testcase itself is
> > called (L436). The parent waits for the child to exit (L439) before unmapping.
> > 
> > > 3) when parent runs faster than the child that is still running
> > >    setup(), the parent unmaps the no_teardown and set it to NULL,
> > >    then UAF in the child, i.e. signal 11?
> > 
> > That should never happen as the waitpid() will block until the child running
> > setup() and the testcase itself have exited.
> 
> Ah, maybe I was wrong about these narratives. But the results show
> that iommufd_dirty_tracking_teardown() was not called in the failed
> cases:

Here is a new finding...

As you replied that I was wrong about the race between the parent
and the child processes, the parent does wait for the completion
of the child. But the child exited with status=139 i.e. signal 11
due to UAF, which however is resulted from the iommufd test code:

FIXTURE_SETUP(iommufd_dirty_tracking)
{
	....
	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
	^
	|
        after this line, the _metadata->no_teardown is set to NULL.

So, the child process accessing this NULL pointer crashed with the
signal 11..

And I did a further experiment by turning "bool *no_teardown" to a
"bool no_teardown". Then, the mmap() in iommufd_dirty_tracking will
set _metadata->teardown_fn function pointer to NULL..

Thanks
Nicolin

