Return-Path: <linux-kselftest+bounces-1588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDB80D3F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 18:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCCAB2131C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4994E1DC;
	Mon, 11 Dec 2023 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sFFmAk/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15BD9;
	Mon, 11 Dec 2023 09:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYCmc1bB+g7bGjYRT1UaTGXyQG5dRGXSR/oAdtlwvfaok9K6CoEITKDf+llXahhxx7S5r58qYwrIZgoeXg/4ycVO8KNqURGXvYL5NCz4xiXTmZWBMLJxVvHLY4agAGDHVI0Z+s1zQfTsVLklAcAyKU5nQ81iuXt/FniE9sHDQMTH7Wb8qok3rPpKqxBZIKVcff7hp0sQUNQLEEWmI2tGba7G8iYU9uw3DhWVvRSdOh+sa6hoM898oUYaUDJr4eJEJRi2JClJ0aeu36qA0TKZ8oAcEIqBRB2JKgYiAvKojm2bCNH8Guwt3PWmhxIsLiRGmaJy5OECWmDQvprEgvRPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yP7u9O2wCz/kSoUjE7dN5iLfsWSkdF7p8Q8EKz5a98=;
 b=OoMIVmRwRoRnldGYDdpSKNhjDWFMDZ4ElRoNDLCfKfd+0Rlu/e5Be0qYb1LXXp8gUjl9oXk+YmMIR2GNuHSeaqzx5MDFTnxsMwWABPtyhN5gtYL/tphqWp1a2s8oyI9xOh4iYvYexzR3xUTS6j5bjzJgCWn0+u/LFoI65OjHzF7OKuErUa1HYdjLlCx1cjg241Oob9USfm/R+K8eVocdpDdihA7t2a/8K6p/XCqD3wTVfXakAnnTnxZWOwxgy8IFn8acmm/tSKyN/pGqCk+7hEBXZrgwYVIdYsavvqb175STAyOHJ+40AyPX91lC8uzDH8AZcqDxZh/+YmTwMkee1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yP7u9O2wCz/kSoUjE7dN5iLfsWSkdF7p8Q8EKz5a98=;
 b=sFFmAk/l+/+Ad/Laj7RhlVFXgS0o5j+e8EZiB17yU2OC4dMrje6pnx4s6jXa7axQKHoyn9s4ySXSfKgmRufEiRcka0aKKedTEBUoZVPjh3Dzp2Op4v1wpS7vlUc2a0JfzQvjHAKaVzc/u9JUTDo4NScnNFZ+WHhN7KhNj3UTeKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 17:35:41 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:35:38 +0000
Message-ID: <391ab316-79b1-4535-a45b-4c01bfb80de6@amd.com>
Date: Tue, 12 Dec 2023 00:35:26 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 "Giani, Dhaval" <Dhaval.Giani@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
 joao.m.martins@oracle.com, xin.zeng@intel.com, yan.y.zhao@intel.com
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20231209014726.GA2945299@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ebca23-25df-4f8c-f24e-08dbfa6f96e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2N6tWvti+16Gkp8vc6La8IgS7LEPK+YEVJcJm1v9gLiuHJN3nksfoCRHAJZ7nuWa4DONIV11KTloNdTl9gL2XjtEY7bAqaQxwvb5QOvfl77f1XatQRvda0W1yDV+//SzPec0CBfLdpNjzIo5Ne1YcnjXgARRjjUjMOGDg8gbap3uDjlFbtKHYt+/Hm+7ul59qPi08p99yWHSCTM98gwvza5lgbYhhe7VWMCdcJFk75t/208mrrUGmHsy9q8FVbNz15a8Kcw4ETjSSzm+hVz2u6VQ/TnaXyC/9+bBgB7mmqk9TYMjdqSRTyTYQ7MSNc8rVqUpGcVhHoZjQ304+k+LM/Xv5rnF95ktA+EJ4gkVdSWhlm9PLH/dIpWO8xyqWizhWber93z06zgUKKPRUn2A0xdY/RcQ8DpzONp3zfZa/MW5Vo1Anoc+r+VUl+hHIJ1/ozftjnqoGLPp1CaIMLJ8rPZRHEqSd4pwVbrFcm6K2wLTIq11AzEQAqeK1SA7ikREtjbd7qEQSxUK0qzemRqeaZ4ml0xITN5QM7J1lbgguqyWSXvaUXYGqI2qajefBF1yjtakv8Y7zbRUQa2Qcc4/eaUtzeW7o1rWZL7lv2AcO4yk9dHW26wehZKZ94lZabcGwLDXFHMUhQ0obNJupDYejw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(41300700001)(478600001)(31686004)(6636002)(66556008)(66476007)(6486002)(66946007)(7416002)(110136005)(316002)(38100700002)(6666004)(86362001)(31696002)(8936002)(8676002)(4326008)(53546011)(6506007)(6512007)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZzMXptVFoxRTdKUUE0cHZubENDU25pZzhBOVpSRUh1eW42cU9FZTlrWU1q?=
 =?utf-8?B?cU9pcEl3c2dKWXpkZGMvRG84SGJ0Y0crQTZHOGZ0czJodE5OS1FpTy9ucVla?=
 =?utf-8?B?YlF3N2NwWk1DOGlKNmk4YU5hb3lESGNiKzh4TDkyVHBqejhKelUrT00xYTR1?=
 =?utf-8?B?bytrZ01WbGQycWMzeVp4bVZWZXI1QnZCZG93aDBDNGgzUFcxY0hnbnJyMnRu?=
 =?utf-8?B?M05ZN1RnUzQ1TElYUkVpVmtjenRZSVQ3SjRSS0VZVGVmU01wZlJLcFZwWjE5?=
 =?utf-8?B?Y2YwQnN3YndmaTRDc3pXNEhOVzFNSFozVDRxSUxBMlQ1bjZ1endxY2tFcnNp?=
 =?utf-8?B?T05PODg4WWptS3BjUTZub1R5ZnhCSmYzOWg3cnk3VWVVelhZd3pKdDFjdi9x?=
 =?utf-8?B?YWVvTXZUeEoyeEQzUEZ3Z3RLWmI1MVZhVUpiRXZIckgxOHFZdjhRUEd5UVlz?=
 =?utf-8?B?M0NHY1VZWHR2RDY2ZS9lTGYzUXBrZUh0MzZHQmU5aGxhcWMxR0M1MWlGazBF?=
 =?utf-8?B?U3Q5RWpMQzJ5UzdzR3NmRFBQT1FKa1lRQ29MTGwvMXhTQmprNXhsOTg0T2hC?=
 =?utf-8?B?anNoSHFmOTlpdUYzc0VPdVRDN2F5VHlWUmJGZHFFZEkvdU14OWpMSlFKREVM?=
 =?utf-8?B?ZEoveUJnMDVuUy90b0s4bW1EdWpQTnJPc0JoUUwzbUc3ZnlCdzM4UjlSS21E?=
 =?utf-8?B?aTFqOU0yTlRmYmhPTVF5N3BNQUhvU3RiRW1FWXpWWnYrUEhsTzZMUndrSHEy?=
 =?utf-8?B?MlY1cW9vQTBCcVZnd3JSVmFTRDhGNG5hYW5aNHFRamdxczlPbTh6dXdwZEZi?=
 =?utf-8?B?dytmaFZWNFg2UjFKMUNVNmhjRUwxR1VUc1BIS1dCenB2eXZGU1FJL1ZGTVR1?=
 =?utf-8?B?NUNpTzF5VTYyUWJwSlZhNzFpbkFoSGpYVU9IK2x1ZjdoeFdLUWlPVjBwYnhX?=
 =?utf-8?B?UG5TNXRMNitzVG1JREJNVjQyUDBtVEhpcDlKY2pSKytScFVQdFFqYVBpOXcr?=
 =?utf-8?B?Q2YzSFlyZGVGS2JGZXd1OEl6aWZXRzY2Q3E4dFhhZHVtUUducUt1dWpPZGtP?=
 =?utf-8?B?N3JMVGZweWdUQWdXMy9UTkNmd0F0VzdraittLzAvTlBOSEdvVFpoQ0NpNHZ3?=
 =?utf-8?B?UEFpTy9zUzcvNHRtNHVKNkVFNDQvZTJ6bEM1djZGU284eC9OcW1jN3Z4SHpJ?=
 =?utf-8?B?ZzJYVmFtdGp4V2x4elZkdCsvbjRtNmFwSjB6VWZPMEJPYW5Sam1BWm81bnNB?=
 =?utf-8?B?V05tSE9Ka2I5azhVYW9TZ3I2VFR3RVZ0emIzeVZjVmU2MEVRWC9DUDlIYW9w?=
 =?utf-8?B?Um8xZFZkYVhIQW1FdktwNVkxb2lLU0VDcG15K3VrTmdiN0Nkc280eno3TGp4?=
 =?utf-8?B?Ym5tUDgyZ0F4TndabFJuRXFiVVBnVm1GMHFGNFhNcmRJRjBtWmxXWGpjdlA3?=
 =?utf-8?B?Z1IvbjlPZjM3VXZWVmppMWo0UU5ickEyVk9XcE9jamFFSEF2Zkt6djdHU2Yx?=
 =?utf-8?B?REJXWTRuZDdHRkZqKzhoMUJQRWwrdmcwdEJJRzRSVUxwUnBrNm0vN3B3dzk2?=
 =?utf-8?B?bFZUaUdycXpqWTYxTUkxc0krZGNpWjY3VUVIOTA2UWxuZzNaVFlTRWdVdG5X?=
 =?utf-8?B?b1JBT2ZJN21wQlU2ZEN3K3NtUGtYWW12MEw4cjR0M210Y3NzSElXMlZLcDkx?=
 =?utf-8?B?TVNiNW81N3hZeVNaQnRpNDl2d1ZKbjRiVFJsZGt3NkFaL0ZhR2kwckFMZE1q?=
 =?utf-8?B?dm1lRmVZajlOMjZiS2puWHBnaGl1SThDS0lBajVMMlNiSVh1RitrY013Rm9p?=
 =?utf-8?B?RFJPV2Zuakg5ck4rNVZhS3VHWUxBejd1Q0dPQ3E1SEpvL3E3bVRTVXVNMTRX?=
 =?utf-8?B?Rk1SSHhVUjF6UmVPV1A3emlDMHgvNWYwZUhpcC9ON21UaSt3RHNtWjhjeEdu?=
 =?utf-8?B?bmUxbUVZR3lQa0hXM3RWNFlZOXNlVGNQcVJ6U2J4bXZaU29WWWtxc1VEekd0?=
 =?utf-8?B?RzB6Z2xpTi96dUVvZklQNlJ4bDBEN2VIVnE5VktZeE1OekFHZ2VkN2Q2VHhn?=
 =?utf-8?B?U25XUlNDV2o5ZFROQ21wUnFaZ08rSzZPNDJiUHNQOHdPOG9GYkJVUUg0a2d6?=
 =?utf-8?Q?t9mW4YMODT3vIKvJASdL7YsNP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ebca23-25df-4f8c-f24e-08dbfa6f96e8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:35:38.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39tfLCAY6lEHk00XgM6Rw1gkKi9jL+NzzaGvTu6rURTIDhcCNygBfoYoQyXFbINk2pu3V9o0AM2dbijAXgaZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438



On 12/9/2023 8:47 AM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:
> 
>> Take Intel VT-d as an example, the stage-1 translation table is I/O page
>> table. As the below diagram shows, guest I/O page table pointer in GPA
>> (guest physical address) is passed to host and be used to perform the stage-1
>> address translation. Along with it, modifications to present mappings in the
>> guest I/O page table should be followed with an IOTLB invalidation.
> 
> I've been looking at what the three HW's need for invalidation, it is
> a bit messy.. Here is my thinking. Please let me know if I got it right
> 
> What is the starting point of the guest memory walks:
>   Intel: Single Scalable Mode PASID table entry indexed by a RID & PASID
>   AMD: GCR3 table (a table of PASIDs) indexed by RID

GCR3 table is indexed by PASID.
Device Table (DTE) is indexted by DeviceID (RID)

> ...
> Will ATC be forwarded or synthesized:
>   Intel: The (vDomain-ID,PASID) is a unique nesting domain so
>          the hypervisor knows exactly which RIDs this nesting domain is
> 	linked to and can generate an ATC invalidation. Plan is to
> 	supress/discard the ATC invalidations from the VM and generate
> 	them in the hypervisor.
>   AMD: (vDomain-ID,PASID) is ambiguous, it can refer to multiple GCR3
>        tables. We know which maximal set of RIDs it represents, but not
>        the actual set. I expect AMD will forward the ATC invalidation
>        to avoid over invalidation.

Not sure I understand your description here.

For the AMD IOMMU INVALIDE_IOMMU_PAGES (i.e. invalidate the IOMMU TLB), 
the hypervisor needs to map gDomainId->hDomainId and issue the command 
on behalf of the VM along with the PASID and GVA (or GVA range) provided 
by the guest.

For the AMD IOMMU INVALIDE_IOTLB_PAGES (i.e. invalidate the ATC on the 
device), the hypervisor needs to map gDeviceId->hDeviceId and issue the 
command on behalf of the VM along with the PASID and GVA (or GVA range) 
provided by the guest.

>   ARM: ASID is ambiguous. We have no idea which Nesting Domain/CD table
>        the ASID is contained in. ARM must forward the ATC invalidation
>        from the guest.
> 
> What iommufd object should receive the IOTLB invalidation command list:
>   Intel: The Nesting domain. The command list has to be broken up per
>          (vDomain-ID,PASID) and that batch delivered to the single
> 	nesting domain. Kernel ignores vDomain-ID/PASID and just
> 	invalidates whatever the nesting domain is actually attached to
>   AMD: Any Nesting Domain in the vDomain-ID group. The command list has
>        to be broken up per (vDomain-ID). Kernel replaces
>        vDomain-ID with pDomain-ID from the nesting domain and executes
>        the invalidation.
>   ARM: The Nesting Parent domain. Kernel forces the VMID from the
>        Nesting Parent and executes the invalidation.
> 
> In all cases the VM issues an ATC invalidation with (vRID, PASID) as
> the tag. The VMM must translate vRID -> dev_id -> pRID
> 
> For a pure SW flow the vRID can be mapped to the dev_id and the ATC
> invalidation delivered to the device object (eg IOMMUFD_DEV_INVALIDATE)
> 
> Finally, we have the HW driven invalidation DMA queues that can be
> directly assigned to the guest. AMD and SMMUv3+vCMDQ support this. In
> this case the HW is directly processing invalidation commands without
> a hypervisor trap.
> 
> To make this work the iommu needs to be programmed with:
>   AMD: A vDomain-ID -> pDomain-ID table
>        A vRID -> pRID table
>        This is all bound to some "virtual function"

By "virtual function", I assume you are referring to the AMD vIOMMU 
instance in the guest?

>   ARM: A vRID -> pRID table
>        The vCMDQ is bound to a VM_ID, so to the Nesting Parent
> 
> For AMD, as above, I suggest the vDomain-ID be passed when creating
> the nesting domain
Sure, we can do this part.

> The AMD "virtual function".. It is probably best to create a new iommufd
> object for this and it can be passed in to a few places

Something like IOMMUFD_OBJ_VIOMMU? Then operation would include 
something like:
   * Init
   * Destroy
   * ...

> The vRID->pRID table should be some mostly common
> IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. AMD will need to pass in the virtual
> function ID and ARM will need to pass in the Nesting Parent ID.

Ok.

> ...
> Thus next steps:
>   - Respin this and lets focus on Intel only (this will be tough for
>     the holidays, but if it is available I will try)
>   - Get an ARM patch that just does IOTLB invalidation and add it to my
>     part 3
>   - Start working on IOMMUFD_DEV_INVALIDATE along with an ARM
>     implementation of it
>   - Reorganize the AMD RFC broadly along these lines and lets see it
>     freshened up in the next months as well. I would like to see the
>     AMD support structured to implement the SW paths in first steps and
>     later add in the "virtual function" acceleration stuff. The latter
>     is going to be complex.

Working on refining the part 1 to add HW info reporting and nested 
translation (minus the invalidation stuff). Should be sending out soon.

Suravee

