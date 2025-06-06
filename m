Return-Path: <linux-kselftest+bounces-34420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE7AD0050
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887D8172016
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6572286D48;
	Fri,  6 Jun 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jt4FuuF5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tHM4xvs/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170E286880;
	Fri,  6 Jun 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205449; cv=fail; b=m+knZs9OJLRcevf0FKPHY/Jk1HUxOrJBRpfG8zs4t+uc2g78SNR0dbjcGXiI1flvTyJaU9eJAcV8HpenPnXzq4O+vhcskh3M3ecTWnGPMOtDTqUaef37NP7Fk1k82Sjc/hDxG54fcnMkKe78pPsn0Xhy1+ql9k3uw1G9hVu//+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205449; c=relaxed/simple;
	bh=+qDfhF2NZGQnv85s+FwLr1Hmxv0E35Isy8Xv5jhCTsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oBSb5rfm6vx4oX8il9CAyUzVLg6IKmnNuuqe66J37fDQTjzQQrudTjGi2NR95PiXAw8z/I4vfeyo78MHmXp92EBMhLeUHowbIIMKVqnZvnmQZCogoXLjH51ZnpyFSXBDso9QNBSJmMlCXSjSkwHt4kWEw6qGUq1GOZudQRjJBlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jt4FuuF5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tHM4xvs/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565NHON012606;
	Fri, 6 Jun 2025 10:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=d2aXMs0+HrgnmkaJj8
	8As2h+E2XzCKwrihwAloMNtdk=; b=Jt4FuuF5il3IO8ZslABMRHkoE0BDtNHFbF
	nvu1IdKiKLNIGn/A6zwk/p6neH1JisFzuihXsovnGnMUBTfSv0/gD1IZCTC0Q4My
	Rv6GM1YennKni8yIrpY63+aRx81B8WdqkjWCiDT65/lh6kS35kpTNw1Gh6+Zjr5O
	T12zxFzpt2kNpDctAjYG8/GGk01pg1vfsAVsOSlC2bBzeMfRYHjzDKHgNu2RlUjy
	XcMa2d5JvJJPoh0eiGoueEp8w1/KZSd23qI8G2DljQwoaCBWSut9DFfFCS5VVpHp
	A/Lr/1c69cG4DQTF/aItv6HVbAkb24PhslYZfTHoafF2+p2Spohg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8j7tr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 10:23:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5569KFmi040645;
	Fri, 6 Jun 2025 10:23:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7dcb47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 10:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOWz7hc7kjmWjZRACeJjP5czyJWwrR4W/fEqvd4PzupCbrJ7iH4zHJeWmBjQjnuh0RmE4C8PTsNJn53C+nzYnW+EgUuAzaCZ1UfHPmEkabDiKRZ0Z4c0OWiVSAsRAfgXEYhdcxdQ6yeBe7pyW+iovMZ+07d3NC/pngDd2ptfRpHjX8FB5AcoQpTQ6NcCbJl4KEu2VyYRz2m+3GJhftFi1w5NIEZTUa01QCtiGLNFANuzUQPDBTL9ceQdyop02oHJeKSFDFC5FGRzXkno7D04xYTWe40uTR/zFbXPo8+imixxRXRejJUE3kJGD2mifffdUw/JWuNuhbrNYcfH05uXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2aXMs0+HrgnmkaJj88As2h+E2XzCKwrihwAloMNtdk=;
 b=xreYA0onXUSMupph3SWxkCV9AioqnTytCdDnIBzJxkvgclVtqePpAba7yoIaTYHk/JJKyH3CkurE3stkwoaKJnyc9IaIC0a0ryTaWW4W7w4z31g5+j8U7ioHCNSbkDnuO/yMTE4hgNt7HPTiFIeQVx0PyYK9Gio0Uhzj3L3jnBbv6WAdnfz6MJwFOghSNXMgRt9julQYNTAkyq8wy71r65TC1kEV8L465xbsfid8wrx1aXAjS/0P2OfrH+NDu9mC75invahO2oUaPXlVCG6VEaVx0Ve31Dm9FNi6FOl63V8x8bHKB0YpQwBtknSaN0Y5C2czkbqXLOuC1V/oUsbIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2aXMs0+HrgnmkaJj88As2h+E2XzCKwrihwAloMNtdk=;
 b=tHM4xvs/eA+I8bJYblTFZr011/AEHeVQIci0wzaWJyZoQj5+i3q14joX+0weYJKA/Zh/i/CCYdlEluXZZxmYWWkGHXUio9xrPaOcn6QzJ7KAmPibOmnMYtTBv1sGNCCOqqKaNhaV2KMOkG8T9BaaL9NKet6CB5eOS65wfroN0Y0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 6 Jun
 2025 10:23:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.022; Fri, 6 Jun 2025
 10:23:50 +0000
Date: Fri, 6 Jun 2025 11:23:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Skip failed memfd setups in gup_longterm
Message-ID: <f484337b-3f86-402d-93b1-e451ef596520@lucifer.local>
References: <20250605-selftest-mm-gup-longterm-tweaks-v1-1-2fae34b05958@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-selftest-mm-gup-longterm-tweaks-v1-1-2fae34b05958@kernel.org>
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0601926b-cbbe-40d7-0bf6-08dda4e43ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtRpllf8SBMgNWOSPeQDYh9pPII6ifxMAaozEDkQE8xWzMEgcvPmZ3q/3gt/?=
 =?us-ascii?Q?nRJLsStzvvA10z5XY/d9CZtt5RLDFCCwizfSHgKmiLIu62JCSgDJjqXwtY9Q?=
 =?us-ascii?Q?JjQL8c/QTKLmKVN46MmMsCFIFAoAPmSZYCk8QtfqP7d/P01Bupy+R9ESyH9y?=
 =?us-ascii?Q?cot4r6eqktsK2I+PnZ4qztHLsqd9gvHq5pzJaaQ2XcethBaSs4QbXv8FUdqh?=
 =?us-ascii?Q?mq7VcmGvpmRIdm8OaRZXU+hmsdlL4HnElingbo0hsojscAnK/czWvWbkIpI/?=
 =?us-ascii?Q?oOtQBoMDOt+ckneJqtZ93wCxs+wHA0ld1PjTnmoaFz/US+lXo/YgiKXY9AwA?=
 =?us-ascii?Q?gaXO9GXcDuLeBul9FGj+gBi2eNeoxnBjP9TXm6n8z/9wv99SBGp1AS+hSW1K?=
 =?us-ascii?Q?aV22HbJbe9wuGIVcN+/09nIe96aLjqiKWRBusL3vm08VM5Sdz2x2x8tqnet6?=
 =?us-ascii?Q?aGJwM/ov2KsQ/PhBtugl4wNRsbLkHvM+fp9ulJ3febeaUIKyfGdynV8j0N75?=
 =?us-ascii?Q?9tEL9uO29xu8PA3FtxBMj5mkiAt3ZHa/1Z8rH1ty+vywScFoaQYfbsXH4vOd?=
 =?us-ascii?Q?6M/QBn2m6AVWvumj0m9ct7vNWUw0VVSzRRus6AljkwtyW+W8p/PelCs249sO?=
 =?us-ascii?Q?s+ic8OTKhZpV7zwflcTz2Zao1ELxZe0koQkdaD4Trem0Pxfb8W8Tp+txsBwx?=
 =?us-ascii?Q?vXAyqY3rblInHo/GPI9Re1huYBnR98L97tF9UhNZ3EQQvxbTl07ukYIjbgaq?=
 =?us-ascii?Q?o4ApCpQq+LULLvWeDtE66WKMWuDvNCwgTLdNw/AT8eJEyqgS1YXpuvORCgjn?=
 =?us-ascii?Q?0y3nS0bVB9pL0N3QCXIYsFk48AREcMcJfycORDUi3p1CHOUuk41Mdd5cBchq?=
 =?us-ascii?Q?tgxJ/XVxl/kDYDWQRanAlpBONMeOnmdPr2IrEGMcPUAdBqoXT5Ur/HnbmGxd?=
 =?us-ascii?Q?Me5zA7UDmlUVOCbjtsQlTm/1bB8j9JLYSFn56nTw5oODMGdC9e8sTiWLeT6Z?=
 =?us-ascii?Q?wYUmSQWbGs2c63uJO4wRxVBewsu2LEEzkqgYpRrUCEae6Oq4J0ay9NCKzpvC?=
 =?us-ascii?Q?WB2IObbmxGFsAxKcNEXJsf9pHtDdT+Jnah9lIVv2EJHQOod6/mDkVIiVwCv1?=
 =?us-ascii?Q?2GpxII7mtfJsdhmSFubrBAb5kEorS+EKs1epZVX+47PI6ejciN8d1SdfmLkT?=
 =?us-ascii?Q?tHZfWRN/DNukp61msBsZlpwiSqI/CWQtzt+OztURWMKYSpjYPOlxBxy298z4?=
 =?us-ascii?Q?AC0KDT1lZ3fChHakV1aKT205fPVHohdjpFvpOQtQ3eeY6EY9vVeFLa9MxHOQ?=
 =?us-ascii?Q?F7Mf4Sx2za2h5reUKYXLtTjiqU9FVIFb1bwp3qgIUCzZ/8hDGID6myawG2r3?=
 =?us-ascii?Q?iqGzZB3l7nCLKcWd1ne4jGqqYR7XxGEAmxFYEsCVzVOg+Q3bK6hiCSyApoSC?=
 =?us-ascii?Q?F3JQDJyGY6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OU0et/Vyn36kXyF/8q9ChN9VawEqhS8yaAwrpEQ15zU4WS5NIZFqjd5XAXRl?=
 =?us-ascii?Q?aWH3DsJrWh/PBXLFby128ZoWPNBeWYalSpu6bqw5vIt2zqKeYiuOtKPNablk?=
 =?us-ascii?Q?flT06yu4kX5yvhFR0sTh/I7lJNbKYQbd/InIgY03NCvkMJBmVfllXUckDsdQ?=
 =?us-ascii?Q?jgg2rKWV/eYRDi0rCJ+PcCLQ0I2xIx0gBmADgnwgFvJiyiKrDjoBNf/lsgqy?=
 =?us-ascii?Q?0AHOK8CKsR35+ehNECfawdtSqmziSFIzw6xovZ1Umy+dezN6murA1J2tGS0A?=
 =?us-ascii?Q?j4fDKGQPAd7FSqJn6UwX+EbYE41OrihHTpsP9/2e2ZSOlW/vBCPLyeBzhjDd?=
 =?us-ascii?Q?PwvuAgvO9RlEqwP/Jrm8W/cltREdjNIIM/2QDMa1drGNbTSkUo5r6SxbD67h?=
 =?us-ascii?Q?MsULvTQawuFZCbkE8f82toeaPEZLrVD2x4kChqeYfQS94A2QGXIwpTwoxfU+?=
 =?us-ascii?Q?cDSWd1NBE3Ed/bVYAIyKfHQpElkQCVloD10ZdP8T0GRJYXRRZAr2NIiSGmXE?=
 =?us-ascii?Q?Gs7pVlUbpsTdbe6R6fIT+U5svwqRwfG7mdqNuxm5Er7xbrm7vHsUgiXPKOdh?=
 =?us-ascii?Q?Pnfu1PFXTWHkpJR1964qYXNWewCjdkylM1LrByvz3QD4E5FUQH7iXZNHt0hf?=
 =?us-ascii?Q?+CdMSOxKL79HFAQ7GtDnj/8bjdQxGy3Iv0AFsvvB8nD8T+ZRW8QMhXjCKefX?=
 =?us-ascii?Q?h5ikYU5HUYcW7eGIc4yB2HAs6F08ZwDzYGvitoIY2UhnCTMcbyP7Ul2v9B9U?=
 =?us-ascii?Q?wWcde/zcbP3HqAsebGlw/NNQsbIHsQTNxAVk3wHTyeRKz2J1bOT/clJP38Ge?=
 =?us-ascii?Q?Ar4pn+LQOwcCgBQQ522vDv2bhK77qtl3VD4cnzH2b8bAeq7LTQRTZDAvAwN6?=
 =?us-ascii?Q?KGKi7x3O878/HCLn4JarjgkVZdQgA5tiqtOKVLbgQIcUypAODpzakGf1xz1f?=
 =?us-ascii?Q?2wM8tAq9rXDlW2GeiCfuz8sGqP53wzerhh/0lzHoFnbbaJqIEWgr4ODxWXzR?=
 =?us-ascii?Q?MndfePdJ8SkQEVlkkzpSY3bnGrm/ccmpWCUCfKy50kyR8EeQEARaaya3iZBR?=
 =?us-ascii?Q?W3JWYSfqweWn8WbV1RUaTBUhMxL4xZ59oJSF2uqT9gnigFgbF+8C4slaa6PG?=
 =?us-ascii?Q?6DqAM43jY4im63CST0EP4/vfLozxViyRwNrlqejMUmN0dq8yr23Z5QGONLzD?=
 =?us-ascii?Q?tPeYpsY4gbOow/R10AWEm+cUo5x6AAvFtdfB0J3n/iszUnuWIVs18Ws5HdkF?=
 =?us-ascii?Q?fp7J4x92YvEg28QJuoCSPKYRmIZkU0DW8+8wVfUEXEgEybFiI79/9wLOOvFp?=
 =?us-ascii?Q?Y6ZVSN1fOc5MiAMc23BQY0LsDtePyTQb/HcVXtYqVUfJr5b78m/RSLvgYA76?=
 =?us-ascii?Q?+FCFLnmUMvd5Fi8wbpmZptZXl5AxLjhmNy+WzYzDuXW74WFwp8CcSXHX6SBx?=
 =?us-ascii?Q?o7BdtEVAENnHybW8IqJbzil7CVGvPmZF3U5wCZQNIw7LgVOvLdlo5dkIXoW1?=
 =?us-ascii?Q?i3eZZYZCpvZqUylh0tDz8pJ5wD0hy/pcjRq9vidElQ+S3yLeL+OL5YAE7jOI?=
 =?us-ascii?Q?/jILg22FTZwmUQllfB8dedJFebvN+7c0ubs3oFel4tJ3zXHtmdNQ8yPo056n?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cAKMjM9hnBosEmRy/QVH/PhBWejtftcDOTzmzj+I3XaB6Ervp01guR0xm/5c1eoXBpDkAZkI2RjM9m0vRpY1JuaOUbnEZefl5ln+73xcdXlBoHsF0BVMCuduiNvKLKYB//H+S0v9fTJbXdB3XZYZgM0XplchKv9QnNeGnWzLyYu3gAmuPoYEUOfYJu/t70DhNTgdIW0CENiYKOPB2SzED2rq+XxvGmJH6OzRYT9xQPbHiF4BKJ+2sP+lQDcojJr8LhNL7eqYOin2kIAcQ93p0Fagmz9Wx5Xkqu+igDEcUQ1kXFS/jgX/opgyffcdm9P7tI7YrMQPW5HjzC755n8xacd/9tGSI49PzMrsOdxb4fz9YihbUoIoeVJVygZYFwm+iofrOGAN1bv/iKbySO9UYI0MUrKO/XwebYDuiRCMW0Amx7VWyxuOwZX+6wVAj0cbqapVtSqYgy6MSG3+1iR3Z8FqDsJ+p97lszsqrIN25qpWZ8WQDzsNA36X35aFbzz2JhzCpOJGkN3wLyILb2LHZnUT9LSpHACMkqE+Vem617BFWH7kuooOTaiYNfaQXgHZBp2U2tD98bjJPox4K7KH1yaB91LkbfRlocC3UqKW9mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0601926b-cbbe-40d7-0bf6-08dda4e43ab3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 10:23:50.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdcHUVfQguSIOajo+We+i6moARe29JlWhEsTJcyw5+FBNs8RFEw7XKfcjaJldRzIGNafYoMO3opq4DO//ZhaXEv/ipfKj6RH7PClCx5vdR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060095
X-Proofpoint-GUID: 82dgC6lnjtKkNGoJjGfuQB9F5G-2T_p1
X-Proofpoint-ORIG-GUID: 82dgC6lnjtKkNGoJjGfuQB9F5G-2T_p1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA5NSBTYWx0ZWRfX26vYb9iAUidM tT+OE0su1YgaIf2D7R7YLWCiZj2IvAQ4kQoWrvYE49MWiGbGrLtRPizvrGm/lg4xecyESwWQCdA d9/F5h8vANW956xxlYyKry+MUbOtTi3LOda0dQ0nLapQkAG4lnDYuMIX0te6AEAtyTpfNIPeEdQ
 wAxT5oANFvP8In43C+UToDJBGioB7D4BpbAucI1bCjzYevnD1/8NZcskA0fFsWuUYMKj6nVZhQJ /0bK2xR+tyZXfAk4seeR623Ziq47NttkyBvrRUK61Jt5H6nAWa10Uy9yD2SY9hUC3JsIsxd9Eb1 Id0uKAPEGvQwaNHTdw+1RcnezJkUPTo5n5e/jHmnd4vctSzbzR+vyeNjB5CQAiVDi4idhJIxNHB
 WCUepYol0ePmw3w0aoO5Pjx07zYctW4ZCEVacj/mgM9n2Ecu9fcThJPf8If2RurUVrRufd6u
X-Authority-Analysis: v=2.4 cv=QI1oRhLL c=1 sm=1 tr=0 ts=6842c1b9 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZiO-fQl754xuO2oiRLUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206

On Thu, Jun 05, 2025 at 10:34:31PM +0100, Mark Brown wrote:
> Unlike the other cases gup_longterm's memfd tests previously skipped the
> test when failing to set up the file descriptor to test, restore this
> behaviour.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks, LGTM. I tested locally and this resolves the issue, appreciate it!

Feel free to add:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/gup_longterm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 8a97ac5176a4..29047d2e0c49 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -298,8 +298,11 @@ static void run_with_memfd(test_fn fn, const char *desc)
>  	log_test_start("%s ... with memfd", desc);
>
>  	fd = memfd_create("test", 0);
> -	if (fd < 0)
> +	if (fd < 0) {
>  		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
> +		log_test_result(KSFT_SKIP);
> +		return;
> +	}
>
>  	fn(fd, pagesize);
>  	close(fd);
> @@ -366,6 +369,8 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
>  	fd = memfd_create("test", flags);
>  	if (fd < 0) {
>  		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
> +		log_test_result(KSFT_SKIP);
> +		return;
>  	}
>
>  	fn(fd, hugetlbsize);
>
> ---
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> change-id: 20250603-selftest-mm-gup-longterm-tweaks-e685a8ae9751
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

