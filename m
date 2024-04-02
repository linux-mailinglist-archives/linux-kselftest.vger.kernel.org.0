Return-Path: <linux-kselftest+bounces-6980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240188951E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 13:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A3D2828DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E864A98;
	Tue,  2 Apr 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QpRvpNoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359860266;
	Tue,  2 Apr 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057607; cv=fail; b=fJ94RjHrSJukbVJfsw+9GOp5mstQMKMCtl9D8FQSyUNVal6rTZi8PqH8f8J5RLn3eC7m5zsi/JQLhww8Mvqnw/+lfIV/8uypuCKL0s2P+fYxK9Xr41I2ijiDKbxynhv9Y7MuAKdyWXkey9+99Ghp28HcKu4hN+4Q0f5e1isoY5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057607; c=relaxed/simple;
	bh=/Gqz1AaF24dyYJ/Win9vTvckfxrrw3vyjZYICheqiCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQVD0i8WXnKBf+T6zi/cfVgbrRokQUnzCBvsmxytKFWV1p7uAtCSSJCZseq4zh6Htu+xyXf8O7axMJSAMqiCKe4jMlNpUbdMTFhsQaabaUFA1uueo03Bk2RTXUy4REmOOTGDS3eakuN8ognyUUk9QiG6HZ/k2Gjrcsa76YrSg0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QpRvpNoZ; arc=fail smtp.client-ip=40.107.237.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGZ3HJTgEvYP3O1FjRMtaiTJHJm6O8j4/JDvZMYmsD/Mt5l4RfOswRtO0qh6xSI34B93I2e6fsOhKPIDKcfWGO3J/3tNWIPorCeqPIYVRYZbzUqJjhSkxs9/ORxE99ziPk0PvCASqPoYeSJXgKTc/BbMEThJEsTGHko2WLegSYOAW9yJnegKeaHCn2SgRvgjDDo7CKbAgnwsiENGUTti1bpalJhDmuSk8NuZ6rSHJv7BJswmUbfDaOC2DV4thHl/xfVFd//xldW3CJoIdG/pYl5BKxy5R1RFEYvo2EdPlz876DOmbiCR9BJB+SZ/XzjYlsjzZAnlPNl04NRI2enklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhnQbraZzXH/gaUOZ8T9pvSz2SodY+jJC0J9PjHc/24=;
 b=GP+XC+84Qxp8MYrY4xmffHIWsARvNN5LmMR8l/8pxUgt8v4WjPt2R1OqKlM4a7VR1MsLGZSyJ9yJo1C4HUpmYRtls1TyKODrSeK6TGgqwYe9XD/l9/GdwOrLlWMRkxFIaPhQmh+o026OoGB+cGs2THb9LVOPJ/V7RU94zF/Hm9BZuKLvOARoZmV9//JGo8rge/D1aNk08etjbpIfW2dMS+WmAZHMjf1SK9IDhd6UfKc4GLd27wc7mprsqxk3LbwoJgnFd0Cmxlw1BF7NcBEr8OWraSfpVwPhPnOjVtATBDyK6fZ5lDfi4FyKPtxGLcsDN3lDExe+daRjjaDACQZ3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhnQbraZzXH/gaUOZ8T9pvSz2SodY+jJC0J9PjHc/24=;
 b=QpRvpNoZGdury1p2I6pU1xNdPygKfwlt5RtncfCn3Ehynm+YR6Gwr+zMuaq/mHTcsOF2qsjxxggoONuf+FIWx2GnbfbzmSEWyZZMJ47tRNmNK2MCVOiTD7RT3Z61NkyW7XcOTqzOB3Yx4eJrt88bnMfC8Vz8A//8Y/rTDPhkCFtptacZ75UxnfveSgQsXil7dC6RaZ8PxQTI+7kzF+1tFXG8PeLCc4RF0mgtBV4nSJIZdIW9x6u27F8khSV4Js4RdSgPgt8ME/ZUz7qFNjGgzWW8qgoIP5ndyW3A0h+uiM4HEbOKl4QpuUcMFOEpy1HaCI5R3K/M/YmwCKymTadxJg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:33:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:33:21 +0000
Date: Tue, 2 Apr 2024 08:33:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Joao Martins <joao.m.martins@oracle.com>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after
 a failed assert()
Message-ID: <20240402113320.GO946323@nvidia.com>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
 <20240327114029.GC946323@nvidia.com>
 <ab5d2b61-2dd2-46d6-a106-a9aea69b0a1a@oracle.com>
 <20240327163832.GJ946323@nvidia.com>
 <24c54707-421f-4c5b-8a34-245328cad347@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c54707-421f-4c5b-8a34-245328cad347@linuxfoundation.org>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB8107:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xTF1rIM9D6kG5CRPP3c3N6XrB/RJNt/ymiDGwS+fWnpKM1QtFPaYpop4PLAAhvJwkWfpne3Bw9bZZlzxehXCSgBJJrqJy38xt5Y2WDIfyEegLamK4DjKy3AJgFnwvKLUur8uBDh9VVJEPbjMUvb18hBzUbPT94tR4JcihgESHZmC4PFCe2Fxp6iFV33kX1GMAxOyxbxEzgwap4rQMMwYxJfr870/kko6djOgmlPmO5jXcFV0nYXUcm4nexYPGoqHfsr5Lcw2X+zCbTHSpgyheFzAhctpXE0cSFWx6QY8VHkWgm2SaHlwZcyWksZ6TmHuMZlkGBjhhHq2vC2jDMvzUOxtW8g+THdt6MxpW66cYG37Y3v3vEMn/1FFl6Qde51bXehncaISjvAQyFVkG+UkkvVml1FE/bXYd0i+vb89sgsOB5FGlGlphf+86Lm8GQIZUZxaCPUxf0ABd0v6EDRO9cCPsZ72WDU0suLc8XlsC8p+axZunmLksXJ4v1XaokvpxwXa3X79bDDxzC6siNRisgVDHGRi6nclS+10NOgqgiTrZ0T0ttaxCzgEvTze1300dQ4jDu2KWTJn8eClgiRhmqDVk9VteNo5wnyFxD0TF7Yx0iH+xzx0j8V4xrsII/RT1Gw2Ya0r5in5ksk0i5m1Rc7lQL32BWQbZ8qx0+xnBVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xyALzwOjZ5zlwJjn7ntGfG1WGb0QatRScUzaYXcatyk1xSCPuGukzvjKmtN?=
 =?us-ascii?Q?hkhoYQRDpCQ/9w+h3DmXK2H2Ycf5WptIEb2IDWrS1gcdnFoEktux88KKRlUq?=
 =?us-ascii?Q?fCKQ0Np3rxRTmQSRneL0CP34tE47i4ffOiVjV5uRnOUNTw1eykFiVXzgMGIs?=
 =?us-ascii?Q?3UuQtNpgt36JZlqcIwt6FKgjWSE+lDZGLoTTFY1edZHHOaRpPSiR7ICIqAua?=
 =?us-ascii?Q?NO1DF4HrfIlZxe9+sCH/Grb5zsvWfU52xzEYpJ6lKJ7+L0ka8ot+YwdF7WIX?=
 =?us-ascii?Q?8OjktazTYqzy38ixLJ0yb29iXZMtvsbCFIby/WnYPhmUsAZAMB1tsZAHLnsM?=
 =?us-ascii?Q?HoBVHwdlUsKJ1Cau6FIkOtHtZ8vr/lV4RUaasOiXi19N5E+aIWST+DragA3i?=
 =?us-ascii?Q?/4G4yi8KlMVaUv8YO4ybBEjxQOPjKgmYJttue78k7mY9BlGMWTKVZjl7Bz1l?=
 =?us-ascii?Q?Uy1VYdbQFqPCA3VWpfl5sG9xr//jsFjMLr6vxGfL4VQnZygVcbVdIAsYXHHn?=
 =?us-ascii?Q?ygQ9FM1XuA0VctZ1ZSxnFvCYIc/dNQDifaNth9MT3aSHHvwc2hFPgQ6i2uHd?=
 =?us-ascii?Q?WN43PwVsyV2ejy/K1g9dvZE0v90OgH2I086YVdukSpBXcM8pcGGg3OAK+2A+?=
 =?us-ascii?Q?4QbvCFB4vNQz6ruHSJ+MvPS+oo42+8zQRS8sr7vkgMt5SVcBn9L5CAGdH9RB?=
 =?us-ascii?Q?IVoZSXIsj7y7JJ8MzUarJV5TiW61cQwu1kyj1M5jas6fhkUjS2amV5zS2waY?=
 =?us-ascii?Q?7GXB7Lm0x+25tBpjo0YxrqQbPXcp3iFgKXUt6nT/uAYnJbgGuu95/nZirFQw?=
 =?us-ascii?Q?7Q8bVH35IR/mBabTDwqSrIqSL6++YiEwEq0+Vohpeyl102RAg2r57EAnbGAB?=
 =?us-ascii?Q?SayhNOSKMP4JXmmJBdVcI9DZwNHWbn2SFqjqRVZsy8iPOZ8cEnaLRs06JfDU?=
 =?us-ascii?Q?OTtAs1tQw2gJRIBX60MQ1UsEcXD/gIVzyCdQYGA5qgjRUXGhIQozoZ0u2cFN?=
 =?us-ascii?Q?SrGamES97L5udmEnbSEc2YDNA5SbamCyz65qxTwHicuxSO4MuqNSXZIYm9ny?=
 =?us-ascii?Q?6wFnwG4ag/P6m3QlvqzGGRBj0FLLhD7+4jO3BfO/NqgfgGJ6hurlJ2sh0hdC?=
 =?us-ascii?Q?5jcf+L9HADfYorp4CBYQeorzPHrRcsyMzJFEcZSXfw3ONq7VnkIyMAg6aVNQ?=
 =?us-ascii?Q?JyPlPHdossiQ+444WPZY06+YtPOAKaShwj8ITA3fYK9quChaRKvmoz760FKj?=
 =?us-ascii?Q?HvU5Y5MO3kWa+T0jzkkYOv1NORV68Xb82Un/yKTeGyN4S8jaJf9ZbJlsPmJ3?=
 =?us-ascii?Q?w09Wgdku2YpXLJN9Mi5iZ0M5GxeZM7DNdDk+KoMaVBzhmDIqANlo3Xl0h4ez?=
 =?us-ascii?Q?7s9MQEZJhl6uTWk4+j/yW2+FzTyHpFxjNzFYKjfBEKGBMo65WD3QxQtLmkSZ?=
 =?us-ascii?Q?5BcJXpCRjACbnbk4LCI9JESZxc+UFGA/dJz4rGYITy8sjKBzDscpQlLWfz0C?=
 =?us-ascii?Q?fODqUCiEXriKr/yGu1jXsPkvrzN2eK0D/jb1yvB5GlEgpj6oFlMA4JZjkqjZ?=
 =?us-ascii?Q?gN4yDOc3wp5myjnY2pw/dhq08l35JMOQP4+8S+Y3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc3eaeb-3755-4733-2c63-08dc5308b311
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:33:21.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVk1yNC999xwO6QF/9yohVvjHqWtP4f/yp+Jnxb2sY+1JfpayYiJZwYGFu4gITRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

On Wed, Mar 27, 2024 at 06:05:46PM -0600, Shuah Khan wrote:

> ASSERT_*() is supposed to exit the test right away. If this
> isn't happening it needs to be debugged. 

We know it doesn't work in setup/teardown functions, you can see it in
the code it jumps back and does the teardown again in an infinite
loop.

If mising assert and ASSERT causes loops that is also a bug, we can't
guarentee that no libraries linked into this (like glibc) doesn't call
assert.

Jason

