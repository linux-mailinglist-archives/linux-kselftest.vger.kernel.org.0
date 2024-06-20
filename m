Return-Path: <linux-kselftest+bounces-12332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E891087D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD071C231F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDB1ACE9C;
	Thu, 20 Jun 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjD9oACv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915071AC425;
	Thu, 20 Jun 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894053; cv=fail; b=MIYB9VTg4nEVOt1X+ZlvFAECmcrWHLWWaFuZ9V98GCSCJFch4MXLCsxwbOQjiT0ZTmQ7naEXlgJE8WOKC/E9k0tPOwlhcjRZg/NOS6TyNL7dUdVtAfJyF8hXiUbqBOjFjaedyY5pV7SWZkMz2A+1qTXm4zkYBr9EeWq17GvR38s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894053; c=relaxed/simple;
	bh=b6BNxkhuwBuziepWkgpru/pOhjYvQ2WYlR6S/RYxceU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mXf5O1b2EK4SzC/EbfiIC2IQDUTyDxEM6q7amrkc9vPeD3vxLgh8LUc+1O6VqVL071y9T+vlInMz0rTGGRtrRQZTlEfIQNV5/h8OIL4vGG6jsUvCHntP5tnY+m/mZt/YfEDmKGPICNmJ7QLU3lqIW+EkKkPFPN1omUfQxH+ixZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjD9oACv; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Var39o8ZV+bj+PNqPW1xy+v0otkOFoV/2Nxn2xRU95PLEIxWrl+qd12rzsS+t555oBjhAK+hlUG9hUh0ZG/jdJ51tDeyN+66/NjgcJVY+z7kNB/B6++f+nqamOuTQAjvBT0sniYYfS4PgHdjgo39vvwhR/s9+6ZZuj2QJm6CEuk3r2DaZl/8sOMw9EIW0Qal7YuR352c0Tlj2bkgbzqIr9YZ9A112ZPqNqFXAH6GBZKLZlWdmPL2J3z+jGx1YC1D74ZUyucnC3jd2UPyukVoKuVP/iEgy68Irlc/rGjj8Q5bXN2R2BLMWtOAHoK3OWHBvCjnY5QkjMjn1QBBM9VMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJrvTea/ydczesTgPuilKi56XznbVeDm6dbhonvQt48=;
 b=T+4j64PCZU9Pecsa1FOp5827y/gIVV0FiOPMOdGFLy1U47u5YS60N1CNhYgEzUYiizzdTjtN024l/bnXnyZuKQfZKh6/BzhcGduSkEUImPmzZXAy7ZOVPcWSR7F2qyq4neOPvVaKcFNAIdAZ9vVKGZTbEKvpu4WHGfdk+LWlnJ5F3KHqC5iHqH3SFTfS5/Khez3x2fimZICH1yOxnNJJR+WQvb7hRZbEsuFg2wOeQ8SQw2ZmONyg/Kby/pAvtYEVRqN1TG4IQHfJVBlYcdup6MDo4/652wzH4vRCaDmKregUyEJGDyjTVEH2BprbID2HeVWeR85KlC2rIhOO2NJgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJrvTea/ydczesTgPuilKi56XznbVeDm6dbhonvQt48=;
 b=bjD9oACvQ2nnOS5qKNKHOpgD/BINQis8E/L513lV09Kr19ybfcbeTglBrhIj+6sRL9GxOTp5g6v5X/x3q6PWENY8gyUSVw0bZWz5GbZN5iefSGwLh6BYmOxHmKUPr8CEWtl7tgNEjvQmdQ0cUbFtTCaU7eszr8iTxj9kp/9bpzkKGjXsxS2p1wP/3rZge4UzybTueOoEE3S95n/v5+t+pBF8gfTWzl4BkmAZ/4B3KTC7THkbRhPNaB/Alb2Za4iU9+cLTBgsh4+J1zWTtYBdpIuuT0gxIRewzhqERXxaGYXgtiYuq1nwb/aCtDfA8mYKx6R4saq7A+4ukmXrSdiaYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 20 Jun
 2024 14:34:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 14:34:07 +0000
Date: Thu, 20 Jun 2024 11:34:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mostafa Saleh <smostafa@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620143406.GJ2494510@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 260eb621-efc0-4142-0526-08dc91360a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N36BAooavfOaseKK9zeEcN+TnooCIRczRxVNIeT9b485fY5qo+zXQUQamTDw?=
 =?us-ascii?Q?TPlnv5kVPBT2enbU5dcelJIAF/JurBTmyT+2lGa4E2dSemh5G6GBg1f5PSS0?=
 =?us-ascii?Q?4Fot2BDqACvju12eay/cJT14jlGt5SqFN+RvmCMb7w8Xk2snzZu56EuAu8bh?=
 =?us-ascii?Q?Yuzcm1LTOKg8f23rUiUTIUsMaEFZPVW6ByLY1S9QAjJUHllJ5mIYpzUvs16m?=
 =?us-ascii?Q?xD/NkrJAX6gfsEhFYtuY54mlGQonIq0lB2oIEeJvBynM7aAMSbYDzV6jGnlZ?=
 =?us-ascii?Q?nhe+7AVkpUdnhlnp7VtXxAt2J+a65gkABBwRFN54VBLCiFPU2C6nyWgecgkQ?=
 =?us-ascii?Q?qte7ycyYZhhR49/HIxcBhxYc5LzSb4AUPzbmaMlda/w5io6I6mIbuc36xDee?=
 =?us-ascii?Q?DRpdWjRWvb/eW96znhvDsNnd5CcRIoEUA7OeapT7jGTXlOnjDQCX4EO14iZN?=
 =?us-ascii?Q?uY6yKwX02I+hECNMt83wUVoX8GEWFoB3a2ckWNvD69NsFqVFIj6H5DBiChcK?=
 =?us-ascii?Q?qvx+w14YaFhVdfyp346UmQ+2VM9ceWo9qhVeAelhrUwwbvlDba40evPHXdh5?=
 =?us-ascii?Q?vw26WzPZx5VpB3p4OQfak9+roPMBXpB10Pg7PZOt+aCmJU5S2U4XrY/EuydM?=
 =?us-ascii?Q?2cqhb8rBKnsIC3UYqrO857q8DTrOEJAskd+SJ8GhIv/vy6kL7eZT+MOYTPqY?=
 =?us-ascii?Q?VGGyUWxe81rv5MGMUGcAZpimBA7+gF3fky5WLuGkoW1ZlA9UHN0Tj+0mIA3x?=
 =?us-ascii?Q?l2G7tDyEApokKvWJR6TJAOBroOhr5zI5KlJOgetBxKgI+uu8XBgNFmgCYTek?=
 =?us-ascii?Q?ZqIRY0Sa3+YT8Sw9OrivBSKdW172bRqtmdTDZ/FW7TAly+SmM/H8qdo4TRDs?=
 =?us-ascii?Q?eUSx2s5XHYGN3Mq9dFs/lcvCOsKEvDrC16agIByUeE9p+EuiGJvQ30zPcnJ8?=
 =?us-ascii?Q?byHE3ADT8g6J3iWi1nqsxAgc4H/mKMRsNbOenR+A5NFskqnpPTtyVbA2ruFj?=
 =?us-ascii?Q?VwNH7lN1YlcEEDo3VrKqRXWJE/8RHUVgv2CpWf4nu6dcSNQfKvaCqBzpVtpa?=
 =?us-ascii?Q?UVSWPBh4Drv3OLjkDqZChBIwtVbNTa5XsukYNKq5GBb9XRARMisFZa9VnTP4?=
 =?us-ascii?Q?A3ggPbx/SHP1ldUQFNbRewKawUtW7eGMRpt5dkbKqGoDADLV1kTEdjZq1oPf?=
 =?us-ascii?Q?DubNI5dDumq2T/ywlVRB4/4IyyrhlIVezN4WIBAnNVPy3W2sgaNofF2Itpas?=
 =?us-ascii?Q?ThBShogKz+xK/V4lSJbQ+otIBBTFDOeVtGT0Zvf/hqgE0ic7aAgr5QdV7ZZG?=
 =?us-ascii?Q?yotrqJrOxJlbPcXsZgWoGibW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gs+ibIdjjoSB6rRjO53e2pVnEiB7zVYdivtUADgtqBaQ3u5ooHjIX973Gjep?=
 =?us-ascii?Q?ockF44bx9Ysig8+K2JoBoOJy7XYaQ9itVVFCsb8kcsOk/136qVw7C/zqFkkS?=
 =?us-ascii?Q?xUasCEaJLFoko1RdLlBpCqMwE3XUXyd8hqRxHJfzhnlEan1egVZz+RLQZu5D?=
 =?us-ascii?Q?/rUgW5z/jk09I9pvxPQJQ+/jcVFpaRbQBe41Aut9rqy1DYlNa20UzzJvHXDI?=
 =?us-ascii?Q?zyNAK5KXXdk1X2kExy0nPnGPo8MrlPGpFSD10aH+RdCEOgt1415RCTLvpAVD?=
 =?us-ascii?Q?AM/xvi6EpTRfgXyvBvuS3PqLGEkoqwUcXL/+SFYmjLKDvnmAZUjIjoIRBMkx?=
 =?us-ascii?Q?B4BhxvaGOSwA9KUHXUsJ7k8KnkCrDiG4siwjVFaVILliQcoXlqGwJqXk1BsX?=
 =?us-ascii?Q?NU3LvHVMWhZ8ixrvD0pKIpxfNzoMVgrf/uL7+JAcx7i1NmpEKLTDiOc5m22x?=
 =?us-ascii?Q?Un6oKtqkl+9TAMD9z1ZxTk0uHETpN0rJ+qpmdAQeU7JOBbSqwyrYFSZ0aE3w?=
 =?us-ascii?Q?2uW5j7sch6OEhAi3RSYkofCyFLFFccJjSekwUTLZ5mOkFm1pQ33dsBYapF1S?=
 =?us-ascii?Q?p7NTm51dQhy5sfABcZCa2t5ZIZDO8r8gtQjeKakey6qIMnRjq8cwhT0QNbic?=
 =?us-ascii?Q?GmJCpBhwYf100RkQw+cE//TB2wLfCUx05evmGF0paza83LuH5qemsmwWfNGw?=
 =?us-ascii?Q?qUMPAu5PqdimKlwwj2T1LUhn9sQfth7ZfoYVuBo+jYh9F5gSgluHaSyl83cD?=
 =?us-ascii?Q?xm+agRXjFYdDauwcO+pCKwVnwSR1aUjqrWgJ9xjKquW2Oez3RqyMI2ZEj/9o?=
 =?us-ascii?Q?3ivbhxnFa3C8h0DD18Tc47wd9LYGeHSxsVlVlnFAfLUbq4nVCfZA5QsEEIMr?=
 =?us-ascii?Q?nJAxja+2S4WVd/oQ+aVc/TG1o2Jl2ZwDfB/mHJ9WmM3sfPSdcq6LxJeCmG0n?=
 =?us-ascii?Q?qiXvqXRilhTFV4eLYhRnQd8ZE7q1/pvlwVs6jC3twQVJcuusnUrh75DM9Ydn?=
 =?us-ascii?Q?aFZoZYZChKXDTDKjBzzNu33/rvczWKoclOOoqk/GhFARXGS5pmkro2M7fwBu?=
 =?us-ascii?Q?S5nCA9oMa4g9dLRbIWJ+xuHSPUFQvgsbWX1+svBw5cqXMg+YoeGhbjvpyTTy?=
 =?us-ascii?Q?V/Mi68X6tM9KYIdq+byrLNG6+O9MEeb6EdyZTRYKmglMlNnqADzq3Iu1Lgh7?=
 =?us-ascii?Q?RDNSvWPKutqftCoRi9bh6ucyA6Kz3/XOnH+zoNRiN03K4fRkFjGIU0aBjHjV?=
 =?us-ascii?Q?dqheYN04QwgdbmAl5SQLX3o2PyoVYkLjpUH6oT25UP46WT/rxgjg+DYtqE9L?=
 =?us-ascii?Q?9RhDu3LLHJyAb5Ptf4HIch5nusvjpjGmyt0lPjSOzNNWPAH+alTZvyDAJSBf?=
 =?us-ascii?Q?sYWBuZ97matIlTi0lKO2hZr6iFx8biN1N/gy8pWP8R64+FM9YeilA69swIPM?=
 =?us-ascii?Q?+AbonCiTFbe6i4Q494Mfr1ZgYOYBoBa+v5rO0VA0dO0r/KsF306G1stqmxJ+?=
 =?us-ascii?Q?8ZuzrAOjuTwliM0wsjUofhZBEG1PvaDx88U2HwxdouD69NDl09O2jLx3jSZR?=
 =?us-ascii?Q?am+5+Ug5WwGt9t/FepFfYTlxERJYuDbG0AAPwKpt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260eb621-efc0-4142-0526-08dc91360a7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:34:07.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYTE2LPn7FiSaR8XWn3KgS+NrTbaEvgBrigaypJfyvt+US5muDXHb7+U0hGzdBd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

On Thu, Jun 20, 2024 at 04:14:23PM +0200, David Hildenbrand wrote:

> 1) How would the device be able to grab/access "private memory", if not
>    via the user page tables?

The approaches I'm aware of require the secure world to own the IOMMU
and generate the IOMMU page tables. So we will not use a GUP approach
with VFIO today as the kernel will not have any reason to generate a
page table in the first place. Instead we will say "this PCI device
translates through the secure world" and walk away.

The page table population would have to be done through the KVM path.

> I assume when you're saying "In the patches KVM (running in EL2) will manage
> the IOMMUs  including the page tables", this is easily solved by not relying
> on pinning: KVM just knows what to update and where. (which is a very
> different model than what VFIO does)

This is my read as well for pKVM.

IMHO pKVM is just a version of CC without requiring some of HW
features to make the isolation stronger and ignoring the
attestation/strong confidentiality part.

Jason

