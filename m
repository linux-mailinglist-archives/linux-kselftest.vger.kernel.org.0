Return-Path: <linux-kselftest+bounces-44741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D24C32A8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0820834CC24
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA7340A51;
	Tue,  4 Nov 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ScL84pcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4033EAEA;
	Tue,  4 Nov 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281038; cv=fail; b=ZPeweJ8VZMbcgktHik+o53huG5SIdYu5CKuf2/EDTbP4odEKjPhrZ70BaezoXGGofeNtTK1NrzAyznYaCpoV3NEymkZaghWhAafy0csEHhiJFDAI78Qk0dsN+DnDRjVu+PYoKiV1+v1CZuYGYnOD6kRIcbqCc+U5wFZ9DuehwiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281038; c=relaxed/simple;
	bh=ro8acqkmz0aKpHQBZE/Lw6EdMT0noeVnsD0f+NvnACQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNC3xLSOkv9uZgC6siMsHAGL6WDASc+wocn4C7CjVutHbSgpgFxHgyErsKXiljTY7wYeGc4wB/P3ZRJNxrvURy5BBnHtFSEDVVu0wmXgk4aKJfMWRXNW0K5nVWz8q0XCVRh4LRj4rlhbqB5F9zFQPbji33kDx+vtaPW7Vudv6K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ScL84pcu; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDk9MdX/zzgfbHjaH551YwS9TorKSG0IoFCln/SzlXG+hJ7qTlgQu6ut/ggP5yAhZlZSRbGjjhyEu5cL/X4EBNPGpC6Kb4fy7VEjEMXDeglqFgr0eR8wXvHmh6JLPVG9jZArCHSJG27+Wxhl+SONxpwAoLO5XnL1eNTWOHKjCi+pQIUTQVJhR/JLc2savQ3duciXLr10oqp5Dcz8zsH1KloyeRlk/CXSS9Bb1KODUDFezXkCTmN3m86z2VfPYXeZBpzyygO/s58/bLsd7W/Rjvw9gAyVga0xy0XEl2Wi9ZO57z7Ur0jwxVhErYMeaS82BhYHSAbfWEIT50Utz79yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7jQlyaCTTtP+NTZxKwgEZombMKiLdziISm5oTH6uw8=;
 b=PaTuTTaI6hL9ES+/husQFz+oS1w5YSXzh5bkInDzTdVYOeighUZkJlKFEHg4JWYv/e+LZCR0IDRtrh1v1hxvlSZUvnVDjmepVTP/s1xVrfwti97lOu0piRWtUZ3+MA2NHt8lS8lGvrexVPvdrUYAshYon/hX95FH2Lulhla67eYmPGxBzpCPoadjgL8ApgxJVfAqm5GiCj9oljr42hSUtYTtGMc/wTqTFWFu1MXbFRQ7ffo/hZkcW+Sm8OdYbtjy6mSjdSbDqLRio+fkBB2eJEY/4PsOulJjibpDxEdMV7jiMfGi4N4e9PRSAM0ZjNcLkO2rC8rGooUBIfeWzLlcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7jQlyaCTTtP+NTZxKwgEZombMKiLdziISm5oTH6uw8=;
 b=ScL84pcuii5nj89AZxoaVI6wV/whJ7DVYqO4S4nPCJgiZgSTB9peSgIk13ZEcCeA/4a4MYdo7NBNom+smrZC3wJL6oh3MAKMiJtPp4A2isJmIZEl7jHoJuO+sQ9hIx1xdeOvfQjtHNCMEpDixx4xlNC2y+NEFWudLcjCx/NHwO/dgE2Ik9ZtFVdoWolEZrSg7v2t5Q40/guRMygrtsfdxP08CIz+S9cnhM4KhuiffXgUvZut2K7P1LBWthKLG6D54iBBrW0c76EkGIovckV0cyQFVSxEcqLhmTzUECQU1etgeVDBRni9w0MiO9LN7xXvu5vslOQYmSGzn93SahVnig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:25 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:25 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 06/15] iommupt: Add unmap_pages op
Date: Tue,  4 Nov 2025 14:30:04 -0400
Message-ID: <6-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:208:2be::6) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 89db0e21-674c-4a40-2075-08de1bd034a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/Il/utm7pyEpwHn57Mp0gLD0O1fF9rfsCf9bX/O5KKq7XCFduVw4DdDyGGn?=
 =?us-ascii?Q?IZHekV1p/3POHkJQL4krTmeGdmN6hyTFWp1FEji2zWotq4mCf1hDRhk8RYC+?=
 =?us-ascii?Q?Lft/v9+Qz7kfwpSB/FKrGgmMY6KdvbUipcQ84c1Jz49586aQjwyoSxhsDyR1?=
 =?us-ascii?Q?/fPl+OTpReyBbVGJveCZyN9zjAQIEcCrG1OH3/utRPtGR0dT2MQpHa5QR8sr?=
 =?us-ascii?Q?K8ykFAU/pe7/7ol7CuXfTtvtP30MMD19eJt2GqmL+rIEN2pBFE1UjUhFsn5t?=
 =?us-ascii?Q?QkoK7Npha/hYI8+M1Kgvp8uJQdPyA2QYsB0RVbsJt53Dqt/jymiUkfLojxNb?=
 =?us-ascii?Q?0F0MJEvUMOa0LHC2LjYcROYCElKQuEvHEZteyd+kBAKrEGEDRGC0tQOztp6y?=
 =?us-ascii?Q?hyGDeJeQ9WUv2AM4I8USvTMkmW5Iic3sJeuIdaUC7jCWLf+wg433DoOjRbCJ?=
 =?us-ascii?Q?f8ftvLHlyecZB56cjfn18iQmlKzf0tHzVLD13Vjb0ecc9wn28ijDcvceQ7Mz?=
 =?us-ascii?Q?45mQNRKL9ollJo1ffFm9lkmtsrreUQquk4JPZVG8SP8fnoewF8ksF5q40onJ?=
 =?us-ascii?Q?Y80ueGQZ1X/b2Y6O8M5p+LwLnq1mBgbVsy0GLkN2DVfFuy11SB4/vXmdrHwS?=
 =?us-ascii?Q?NHdfMbB/FArBWVzBqIFnMz51wf8RlDacJ7EEAiS+qQUCnBN7rEv07z2idauW?=
 =?us-ascii?Q?Uy0kaF5fZsrzu0rttMLD6i8MOcquH+tY8PSvmMNlsfrL3wYLFe+0Dr5gRAyw?=
 =?us-ascii?Q?9NtqCAIiHZ0O5NNIxyxr/SluIOALi6cEbmWn/CpM+UfAx0hX7S//ymJa+/Mk?=
 =?us-ascii?Q?bxTE2vGuhMrATzV4bjAEfVs5tEtiZDkE0Ef8f8VB3LjwTQryrSPpmQymmxa2?=
 =?us-ascii?Q?xXwtNeYtEloXtMjWG04Qiuw6azEaTgcqFMgOjnewCBdkiahyY1NwCDUwWAcj?=
 =?us-ascii?Q?s3qAXAzNnRThjP9NA7QetxZBdfyMuSu+ziv4qMvdT2AGzAMvvkxzwjZ5ESUq?=
 =?us-ascii?Q?EYMzPya6Nh4V846jv8dhWbB8EQnV6/1BE/QMXxigL0599D6S2k43jYD2Pfk1?=
 =?us-ascii?Q?bSNbccoPiZUzFewTIHcHCPzZVIx+M9Av7q9LylW2lzZ8lI8/mp2P+8Xlmp1F?=
 =?us-ascii?Q?QTcxjVVMA/rkMx438jol0wRvMyTjVf+TYIPZ44EW1xuf/1iCViy93S3oXlQq?=
 =?us-ascii?Q?9m3QZmOGV0FjgxIpeC5GQ7fZjHGTtjbIvzjO1C7a8bV1HgxKEnV4EzYxhm9J?=
 =?us-ascii?Q?DlA5K4jqwEanEvxH1QUETwYGpw9d76mJEqqRgZPjijWp++Zzc9mv4kPIt5ou?=
 =?us-ascii?Q?znzBnpce6KTbLLhqXj4P5USvB/JfOBFuqSFekuxWdo44OwfESi3y8EAoYhJV?=
 =?us-ascii?Q?4xi5DYeW8ggImk0WCuW1MIFHrr7gRWxWG2sT8GRHwiElu6rVEZBjtQL4FKWp?=
 =?us-ascii?Q?Lnvvlv9T8Pa6fzUw0UVjjoQKrJJwmaM05c+uFKP1GGT/1yaTJbB3mk9w4udN?=
 =?us-ascii?Q?Ws0GOqQ8wp0sGbo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gH9jxv7vfAQQrUzStRzWVewNCwKJyyc57Dk7n+qeXodFuU26RqsaL0CsBX26?=
 =?us-ascii?Q?XJZT1l7i7Y9Al3HRRyVSUDogrnxZqadcoJgOwI+ED+yfgC+4PoGYexFUWrrQ?=
 =?us-ascii?Q?99UfhjOwjfcg82tGqSvMGNw3qktq/jWnTCVRsb814/35fEYmOsZB255gu4S6?=
 =?us-ascii?Q?qq6W9XYx1Em17KQppAUO7Pae8GjZQTcmSiFAWxGPVRClGi++9byYpNZz8vHa?=
 =?us-ascii?Q?oOuWvvnuM78UFQwMIk12JnsNGydGVoCsxMLPReA6kke2ubDQzCyoHlHFRb2K?=
 =?us-ascii?Q?dh93pBqDWBA/UVB7+Fgc30tXhZrh1LsM9w2/Dt0uaxw9jFWgZ4cBU4y9UthX?=
 =?us-ascii?Q?tOP8gql0KwbVlrXGpW1dJvp/vWrgBJsdmfqHKoXZSWKNHZUkRjwqK50it1me?=
 =?us-ascii?Q?8tbf9eABfP5pJTj7GNPQT5TGqTRre/7JWTV2rakfDMUJOHtSMdWgRhHyvTFz?=
 =?us-ascii?Q?DQfiXC+bXUZ8ZC03n/H8uoAKfWNtZtt48IyuH6xY1fbanvaJmaAv5P+AowG6?=
 =?us-ascii?Q?+Ia+/+FYijpzEB99FFI2rAECEdBkTEJQbQoP5E/ZM2rikqeboQtLE1Y5Ilwu?=
 =?us-ascii?Q?jg3ngXZpgu8OBD9oZvx56KjacbDrz/mHDz3sANJwdIqzvft6qbNRrYcpkmRC?=
 =?us-ascii?Q?R5vnzkbFEeOKIAlBRTc/vsVuluAQ511D9k0h/5zwLQSqnd98VTf1BcgQOPKg?=
 =?us-ascii?Q?EyalAu/R9rh06XwGJCHq2Q4zyP6nvlhnVRFuSg6yeJQaPO+WEr7ZrqkL5GiU?=
 =?us-ascii?Q?SJ0ec0LQnTrsamd3j2FqBR+99voERl6E+Ewu911+MvDboQKCznU+UTl0YXQo?=
 =?us-ascii?Q?Bh09l3W/j1MEV+HImaq/AoQrQtxC6AT55Z1071As/vx6ti5jUdE+cKmz70Y7?=
 =?us-ascii?Q?3W4FRKOfVG6U0g0jpT+bBCx2+FXBnA7mYsfnWQgT3nXRcp56zBY02Z3AJeiL?=
 =?us-ascii?Q?yJ2b/zS8vIuZOwhGR43ArITthnAw8MZMfIVaZT7OIi/OPMLx2xyzfkQSkj/Q?=
 =?us-ascii?Q?a2bJr6fjWboTYfIl8cYGcksjwa5YGY6uSXXrNEAPyjkzxhs7E2X1wRw4rz9B?=
 =?us-ascii?Q?pXnsT8+IORdGB9I5/t/KK+I+gOo+kIQq4YeQJ69bfxmfclu7eBr4lv29+7bJ?=
 =?us-ascii?Q?2hjFyX5y7Ar+fVpy/AcfEZX5pB3rPGyNh8loURwgVeAlwp/U9fuJTZg1HM38?=
 =?us-ascii?Q?/yTc48S9/QaCmOJnSxiYQ55eyPm2KTUAU2tMcwnZS+6v0JJWlOC4PutHmHIT?=
 =?us-ascii?Q?p5FhN8iSuWQryUAKlH8b2abQJH6gt12N/A1fDJoGBNY6RumOWBWTh06gjctp?=
 =?us-ascii?Q?QE8lS3wx0cWP0oiIJUdmMgKfi2a4XJ/ABdBtnf0XYNBSq6FOmxfIsQAoRK3W?=
 =?us-ascii?Q?JTcmyxuIkcCQeXZowG6xlqaX6n8vyhzXreYDzLLgyyI9r6GF+LayMrR+w378?=
 =?us-ascii?Q?DkmCg4spgUACBFdmz9/VIOM/GgYuLoJ7LI75JHA+k0w9Sm0PKAU1zP2XvVRe?=
 =?us-ascii?Q?sidTwYN5HKWX80ABAGITl52MXiQphYUg6NYcmMs+Cw7smFjxqCLQ56Fi1lCU?=
 =?us-ascii?Q?XO9TqLnZ0mz7SDQmVLo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db0e21-674c-4a40-2075-08de1bd034a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:18.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH+HIt87zOl2kznAjzBfaAH0h+lgqtkWaNOgC/0DRSsXRn3YV/YGY8Jk5AvEWUmw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

unmap_pages removes mappings and any fully contained interior tables from
the given range. This follows the now-standard iommu_domain API definition
where it does not split up larger page sizes into smaller. The caller must
perform unmap only on ranges created by map or it must have somehow
otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
scan for them)

A future work will provide 'cut' which explicitly does the page size split
if the HW can support it.

unmap is implemented with a recursive descent of the tree. If the caller
provides a VA range that spans an entire table item then the table memory
can be freed as well.

If an entire table item can be freed then this version will also check the
leaf-only level of the tree to ensure that all entries are present to
generate -EINVAL. Many of the existing drivers don't do this extra check.

This version sits under the iommu_domain_ops as unmap_pages() but does not
require the external page size calculation. The implementation is actually
unmap_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize __iommu_unmap() to take advantage of this.

Freed page table memory is batched up in the gather and will be freed in
the driver's iotlb_sync() callback after the IOTLB flush completes.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 156 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 5ff1b887928a46..e3d1b272723db0 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,29 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+
+static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
+			       struct pt_iommu *iommu_table, pt_vaddr_t iova,
+			       pt_vaddr_t len,
+			       struct iommu_pages_list *free_list)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+
+	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
+	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
+		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
+		/*
+		 * Note that the sync frees the gather's free list, so we must
+		 * not have any pages on that list that are covered by iova/len
+		 */
+	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
+		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
+	}
+
+	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
+}
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
@@ -164,6 +187,139 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+struct pt_unmap_args {
+	struct iommu_pages_list free_list;
+	pt_vaddr_t unmapped;
+};
+
+static __maybe_unused int __unmap_range(struct pt_range *range, void *arg,
+					unsigned int level,
+					struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_unmap_args *unmap = arg;
+	unsigned int num_oas = 0;
+	unsigned int start_index;
+	int ret = 0;
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	pts.type = pt_load_entry_raw(&pts);
+	/*
+	 * A starting index is in the middle of a contiguous entry
+	 *
+	 * The IOMMU API does not require drivers to support unmapping parts of
+	 * large pages. Long ago VFIO would try to split maps but the current
+	 * version never does.
+	 *
+	 * Instead when unmap reaches a partial unmap of the start of a large
+	 * IOPTE it should remove the entire IOPTE and return that size to the
+	 * caller.
+	 */
+	if (pts.type == PT_ENTRY_OA) {
+		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
+			return -EINVAL;
+		/* Micro optimization */
+		goto start_oa;
+	}
+
+	do {
+		if (pts.type != PT_ENTRY_OA) {
+			bool fully_covered;
+
+			if (pts.type != PT_ENTRY_TABLE) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			pts.table_lower = pt_table_ptr(&pts);
+
+			fully_covered = pt_entry_fully_covered(
+				&pts, pt_table_item_lg2sz(&pts));
+
+			ret = pt_descend(&pts, arg, __unmap_range);
+			if (ret)
+				break;
+
+			/*
+			 * If the unmapping range fully covers the table then we
+			 * can free it as well. The clear is delayed until we
+			 * succeed in clearing the lower table levels.
+			 */
+			if (fully_covered) {
+				iommu_pages_list_add(&unmap->free_list,
+						     pts.table_lower);
+				pt_clear_entries(&pts, ilog2(1));
+			}
+			pts.index++;
+		} else {
+			unsigned int num_contig_lg2;
+start_oa:
+			/*
+			 * If the caller requested an last that falls within a
+			 * single entry then the entire entry is unmapped and
+			 * the length returned will be larger than requested.
+			 */
+			num_contig_lg2 = pt_entry_num_contig_lg2(&pts);
+			pt_clear_entries(&pts, num_contig_lg2);
+			num_oas += log2_to_int(num_contig_lg2);
+			pts.index += log2_to_int(num_contig_lg2);
+		}
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+
+	unmap->unmapped += log2_mul(num_oas, pt_table_item_lg2sz(&pts));
+	return ret;
+}
+
+/**
+ * unmap_pages() - Make a range of IOVA empty/not present
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @iotlb_gather: Gather struct that must be flushed on return
+ *
+ * unmap_pages() will remove a translation created by map_pages(). It cannot
+ * subdivide a mapping created by map_pages(), so it should be called with IOVA
+ * ranges that match those passed to map_pages(). The IOVA range can aggregate
+ * contiguous map_pages() calls so long as no individual range is split.
+ *
+ * Context: The caller must hold a write range lock that includes
+ * the whole range.
+ *
+ * Returns: Number of bytes of VA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */
+size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_unmap_args unmap = { .free_list = IOMMU_PAGES_LIST_INIT(
+					       unmap.free_list) };
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
+	if (ret)
+		return 0;
+
+	pt_walk_range(&range, __unmap_range, &unmap);
+
+	gather_range_pages(iotlb_gather, iommu_table, iova, len,
+			   &unmap.free_list);
+
+	return unmap.unmapped;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 5622856e199881..ceb6bc9cea37cd 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/mm_types.h>
 
+struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 
 /**
@@ -119,6 +120,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	size_t pt_iommu_##fmt##_unmap_pages(                                   \
+		struct iommu_domain *domain, unsigned long iova,               \
+		size_t pgsize, size_t pgcount,                                 \
+		struct iommu_iotlb_gather *iotlb_gather);                      \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -135,8 +140,9 @@ struct pt_iommu_cfg {
  * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
  * iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt) \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


