Return-Path: <linux-kselftest+bounces-37581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DFB0A85A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C231894F15
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EAB1DE2B4;
	Fri, 18 Jul 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhC/SKeW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904A1B0F33;
	Fri, 18 Jul 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855707; cv=fail; b=ukhoXd10+4jaBgzTLdGpOp4j7/Bxvjlaek3tnL6m1y7hUnjUD++Ij5JIOiJRZMrX7Au07kqhmjxPM3vKZUMTDMQnhZE8dq+EwYDaA5U3BJ6p1Vh527k/kqWKS2asAJRWP7tYUnjq7TQ8O6euYDFEF2oliZ8sj3PgSUwuwuvSoKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855707; c=relaxed/simple;
	bh=8E6w43vA8p/NMHz7U1GcnQbYWeOtMgj/WVPc75WpDkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qfgfsZq0VfG1uLH7nBGWwy8cBMAspTs51C96p96SbxCh9z9sK3ts37LTeXDyZB9+paBPddxGoh/VoomAr2nrJLMJAPMulpyRsgbyOVy8LbUFrK4dO8WJKSf2kdjg4wKhlHx5R+tOBqFAqaiEroGYSdGRfobCPHLaEKLJhsDDuQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhC/SKeW; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZvDMJeABpxFHFXvpLfX/ucVYUi2HET5ll6UFuzIkDB7A0DO8IsJQkMAUEkXLvEADCPJjGRZMV46t12ZFrDEbshmA/9Gzs3nU5bKfQ0NpBUI9/7clW6XBqkHM+G8w+TJqQaDGqF3zyAtLGyWBg3I6DXSpGMeddGRZ9i44MzojTzuREHunVi/sJnWyz7k+Ay+O5AQRFG9yp40qfgmkisQ7Z510+6jB+hGxADWK+TvzctPUKlC//eN4PdMUGmUwCGH3EXg6zTK5L+czikzkhBX7yqlw0UUC/sEIpm14qUs7ER3y0vGF+0E+ZC1qRjlWjBuEALbAhPmYmmI9jDXUgOHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fiNUXr9WZTfREI0w8qXNI73t2Z+maS405wVBtKmi/4=;
 b=b2KJ93Z9YaMUkwoNxHTdyyE+jCnVd/cD4RLnjFHXUFan7R15h1yCNyCZExskxdMc2ha4Tk/SqsTy6MuQv9dWcw0wVrSuRi1ty4iKt4TkKbUEfJGs1unr5fFDpDT3xG70oGLHdbkSKpF99mzanbD/nDkFaz2poNR3UmEu7tkfyQVJs9tqOhEXRSyKoECSap9BnSz/9X7t7r0Wn144gg85a6P23arw0175j3eS5lZjwygMQmFe4FU2Z6/brXaP3dRz3pvzz1uJi8UWG4+6oHbWa/F9BFqoFK7skgbTZ8RBL59FeFbO5hfFZInr66h4Spa5632eVl/jUq6uf/KUWA7agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fiNUXr9WZTfREI0w8qXNI73t2Z+maS405wVBtKmi/4=;
 b=jhC/SKeWypaU1x60cISgUwbryjBj2nvPNWAFlsm6m1+J2vJ6A1fvXzXn8EGwmfzo/v++hoeE4ZHF6A89puX6GlYCcUuhhApFG0U7kdsuBm4Wrnw1/QDmkTd/ozNwBuID1Q1nxQLnNfzf8r/ftQ6bJroWpsmQ0GlDbOaAkFStTl7GAnkT7aSif+iEaTp3e39A4JVo1aKLqP6BTUR2PI8mhA9qBWPXpxX8ayf5GGJGd4XtGij/FAshPlqjGp2UUWxxnwoMx0EhnAHozWPMlr+OPJid9MdBVvHV2TItMz7z8GhUYYw7IUgmJrG7LHfurfnsvwgRD5VYogBXuKu7KKAe7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Fri, 18 Jul
 2025 16:21:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 16:21:40 +0000
Date: Fri, 18 Jul 2025 13:21:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <20250718162139.GE2250220@nvidia.com>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
 <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d26c03-6058-420b-f441-08ddc6172d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKzerOIBHKyPNqD9zUIo5PLDPRiIlf5jpx/1FqSZpd7ERAf7vKZkHnSSVlD8?=
 =?us-ascii?Q?b2qNxmC/tkJWNhz26Rz2k3tlcqy2fM4mvuSWSsSiiQiVle7PujxJDHycOvNF?=
 =?us-ascii?Q?PjzXgIGO6JLYpGEzJu/rxIvTTf6z188jn7QHqfr/1DhmM9zMqofAVifGCj0c?=
 =?us-ascii?Q?0V+sSWsnWweusw9zemPXvFU5OHwGew6BtweVjZg2TptagD3YoTSatJSftuPf?=
 =?us-ascii?Q?h3Xwq6DPIezY00qefPtBXYDcdpMJMLqCGKfBMrwYap1cLgopHf1mnTx0YtfI?=
 =?us-ascii?Q?xqBcaVjzw+nb9tmef8lOsSAGkSurG8uZksImKgNyjJtFmz+Wkxk1DbhUGOdW?=
 =?us-ascii?Q?mMmqrQ8HFnCaw3qJ2NJnAKlO+enpP/XLldvDAnCYfASLVDjBdfG4xp3WGGwn?=
 =?us-ascii?Q?S7pH6jhVcZqdD/6bufaylL7MkYvpq/v90peNXrOgknkwmHYeUWzXxk/4d+JY?=
 =?us-ascii?Q?705sqoMV9ekmmmFC+6wWRoVdegLDWFT9qtAk1f3YbbnMqgFmqCgQDMBmS6dg?=
 =?us-ascii?Q?WKQq/QzWTA2JTjs52ojCn1zU+7lWAh6o1oz93Bj3CZZEtJ/FPA5MRVkSsLFY?=
 =?us-ascii?Q?dQdQPzLfe6JKVvk33hdEjIs6CVvfIdaFbYe8LZyIWwVvQ6z2aFkVa8qvBX8k?=
 =?us-ascii?Q?40y4Tf4Dpl75YJDfb/uPqTPEPk6aPCjWcM5HqZlDmFdMwBScBxbRkmEDf8y8?=
 =?us-ascii?Q?AcnHCWmHxrgKrbC1SyEcK1+X1RJ5tDPVRm7b/JUJCSVrZCHjnO0zPz9l2bE4?=
 =?us-ascii?Q?JRiarKTJZ7UyuQMa8l2k4ZbqTtbfk3+mqGk5gkeoC5DfH0UinKL+STd+CKcM?=
 =?us-ascii?Q?zFJRTNtkIY7onpcfjif/T9BaFPXKLuV6r3sE6kTNGh2xLrqPQpVACUVEjZFq?=
 =?us-ascii?Q?bnxoh/QgpH5OslaYNKbovzNC+FvC45Z7h0tOzMKjJ0qTPgLKi6X6y5x/efoD?=
 =?us-ascii?Q?MLr/T5bO0f/KDL+m1MlSOLC24iouJjSa9YSWauqW0wzBpJoUxeCheugZ8/2t?=
 =?us-ascii?Q?BW9hyYvnBGOJVU+C8NtW2dAd7F8wWhorDB8HtkWUgF0qElTjlxKuOcgUQcJD?=
 =?us-ascii?Q?ZpQ5Uo/J+pZ5xNKmmlqCPRSbxAS5tDWMDI7BxQ+zQ0Nr9RmGFlrUpousto0f?=
 =?us-ascii?Q?GRyH0NwJppGroNtg9iA7/xdDt85Mecq0Bc/gOC2AgxpsDUoWuHNaPJx22EIq?=
 =?us-ascii?Q?qFUCNO1uxON7rf9Si6K5YDJO4RHx3UbpeYIcEWLJctQdBz/zEzltDDkYPQdD?=
 =?us-ascii?Q?H8ar76KdsNv+FjYTigGO6bRh7qCfO5TDxgf85jJ+nOlK8E/Zb3qlpQTHS4wc?=
 =?us-ascii?Q?bdZfOmuz4mJBObWwdYKXltbh5xdpKjf3BE4n/iFwEH38zlLefCCvIHVoRZHA?=
 =?us-ascii?Q?oWO9LuYwFf0NPWM0eEHWqTAivKvGRKMvZFObFdEhhm6hLnUN0EZMqRr3tP0F?=
 =?us-ascii?Q?jGPyC2YooSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sBAXhN1Tk+/OQuqWYME4k8qWiZFqtitP2PuU23ItUd3ndlibmhljKxG4K47G?=
 =?us-ascii?Q?EX7og92fCGvexDwn2l4YSkzWwnkovqZbf9iWcpraKOTtoJ0bb+z46ViCEzBG?=
 =?us-ascii?Q?y5sFgiEpmh5cTRXJHzLzuqQX5SvIuaPTwzxOvBoj3xEn8zcTtxvw1TIGm4N6?=
 =?us-ascii?Q?V8zpxqAunJXt/HmiUPKZHHr9AfjwucVH96OrqvUe8/5dul6UF2OMay505fSY?=
 =?us-ascii?Q?gVpKo9QmEVgVJi18cWMhPudDDIhp7lgdfPgNtdYhe3trsvZ6ULqw1E/v0EF+?=
 =?us-ascii?Q?lwXyKE3VNzQGxtRgKiU5WaOxFLu3I5zQe5kSadRNi85xiI+qBlDJKZqtKnKb?=
 =?us-ascii?Q?hMajXUjKi1F5Y3t39oRaLY4le+dlMK9eqpMvp2vXIG05z7LzkvoNfYS8GRX5?=
 =?us-ascii?Q?xxOACqVLefbw6nTQ2TYpWk+f8ELKJfpCKfLNv6Rds5Ymm2MTtqIxGFRXZO6c?=
 =?us-ascii?Q?fIrzYIkZHrmeaMAAn1cgSzoRIWGKs2WRfaP75h2F3czEwSJGPni9udkDky4Z?=
 =?us-ascii?Q?aW3m0J+a+vYfo2n8FkLqbjGXjm36QIVmosjzsByALSgew6IR46RN8mW7hcWo?=
 =?us-ascii?Q?DNuGjrwJgNOhoWYv0spmNhrb50oC0dtS30d/QXo2mhR8CSo7cuw1CCuDvXMD?=
 =?us-ascii?Q?OE2BiUop529KsUGg2VmGT5Ab4LJIwVihNne7x3hip+adHRwQjH1LC/jQCEzm?=
 =?us-ascii?Q?crQklXn0uYyzJ8wuLtIMfGuvov3w9GCDyXDx6L6EMLPb9n/rlr+x7epspmkK?=
 =?us-ascii?Q?NLa+QOkyHq6iH+jYe/trYVNIoZGeC1x1RlS+RFpKW6iwfU95rOO9SNV6hwKa?=
 =?us-ascii?Q?J8Gh7PZX6yOXGnRUut5tSAWmNiCoXlrMq7/AmljMnRYRBFJAxnA8hbhuQ/gw?=
 =?us-ascii?Q?IJXwBXFazrsfHft99V8AAwgdIGlLEtq2PGvcvFaRCDie20bWkF1DfJj9caHW?=
 =?us-ascii?Q?on7BJIcMyKPG3EFKF4wxxo4FfifCvNs32RYiki31S1Rk2nNENx7SPtaMeFnc?=
 =?us-ascii?Q?wdFNdqQy6nXw+Yh5f++fhaj0P8cQ/NeZkWwNiaml41XERDYxSDbo1YNYyLeg?=
 =?us-ascii?Q?eUyJm6Fa0FEZ5Q2lN85n9f7hxdkIynwTZgQxOXTHB+reM2GSCbZ61RhZxZ87?=
 =?us-ascii?Q?/EADoMTfb8Cznhov7a+IORNd4OUdb6il5AV0gmXrYbNBy6EHzsdkwJZqjLv/?=
 =?us-ascii?Q?h3iZXwokI5R8IN2ek36+DynVPPddUK1/RZy20Fagy/4POlbefze9qLyutAOU?=
 =?us-ascii?Q?N1jZpffNnvtLGgPKwuHMskRVufyJmNdAEdLiiSE+MCW6rnGUY7f0ODfCR+k+?=
 =?us-ascii?Q?WMZ2VnqjHMvaURPFomz5G1zac2jfbIKmUrkBa6GnrmjXq2A0O75vtSCaQ98s?=
 =?us-ascii?Q?53n3azAMSJec/+ebes35nElVR3ynkR23ecNkgedpjY2x3U5YNJ1FaCV2nhlo?=
 =?us-ascii?Q?Opn3Aujlg2AEbHztUSJ7mjcu2mry/49PhOmd0rQ16WR7MvVJeI4oTfeDk+h2?=
 =?us-ascii?Q?m9GZpINcxXpHzbtsA6hshgFr9BzOcBjKgHh/jmllFKfTcChtEcCSu6rNcqBh?=
 =?us-ascii?Q?SLQYjPcr6HefZLKPT4AqAbXJhvLGkFe4gsVUh+eQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d26c03-6058-420b-f441-08ddc6172d3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:21:40.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiHghtZmDWsN0O+evlGaLyp9x4+jnld+UUuUGzVYMdquuXciMP3BZamNtz7UDlaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

On Fri, Jul 18, 2025 at 01:13:46AM -0700, Nicolin Chen wrote:

> I realized that we can't change the number as it won't reproduce
> on PAGE_SIZE=4K. So, perhaps it should just SKIP other page sizes
> than 4K.

Ok, I used this:

+       if (PAGE_SIZE != 4096)
+               SKIP(return, "Test requires 4k PAGE_SIZE");
+

Thanks,
Jason

