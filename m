Return-Path: <linux-kselftest+bounces-1564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709DE80CF9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37742B214D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94054B5D0;
	Mon, 11 Dec 2023 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PRVsHv98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44142E3;
	Mon, 11 Dec 2023 07:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnqhSW4fRg+jd1hg7QaHy3N2olMP/52Cs1BTfVI7WCO4IHoLuNUUGL5JbldqOzfeKxk5gEVuCB52SyUhpsqe9VSpDTDiaEzKRdPrGn637Ro3+sDrj7bDEVozSa9R7Ae0iDxADjxPuHt4npUga8ntuRmEmeBuWXfERTC9zBmUqZTR+zwx/x7RJwJgUF7CcSiDmQL/rJafyjGOpMjTKtxZWKuO5t2Vv3Q7yFH4bjGcIrZf9J/T7mONTLrjEEYFyA5B/4w5yoDTiUQXV2vnjKxqmivt2d7MIHkcBtHxVLWHKzGLqLAZuokFMbmIO/BZ32VMMOs6bKMBuNW/0ckG0jhxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gduGZK4qruis4UXamfXOvT9JJendFgOrKd+gjuCOQhg=;
 b=LaAsepq1W0Jo6nilw+z7+6OfQBFS0POKQ+SsYPXx6e04w0k8XKb5nqPzLLiWwwc1REypjzkSyIUMU/9frU2OZjYxWxLGClLl4S5YuDwX1WZZo8VZqhXM/3ipDpeHLcLS+eNkvcpg2v91qcGeXSfnDPGl4vo60NZJ1lAk51/7Diq2HbDMwbg+Okr9YrPbXJc1qrmCTzxJDNN1LbuLSuduKoeBivFiJmoRooNmXKK03MfBwQsFm34OGSP+K8l1FuqlyO8apnzuJB/bC3bILDwL59wM06VLHKlFMFJuJcxi5jdDP+mcBl45ModlDhTKXAeqwxevePZoO7K0S8Ll/y/G1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gduGZK4qruis4UXamfXOvT9JJendFgOrKd+gjuCOQhg=;
 b=PRVsHv984I6Ops6ohRg5L9NYiPW5Q+AohGAjltj5nxy8d0ZtPPHx/VUkv8aK1R/qGLyCwf5BLWUjTFusLhGK/nZTm3xE3Ra6H54n1o7NSweGF6qhm/OVsCBfKrpdBeOwF55RUByhmuNQEiQtrouTGukme2rdviTHFvs9gxWaln4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Mon, 11 Dec 2023 15:34:21 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:34:21 +0000
Message-ID: <509489ce-0169-4021-ad56-a31544752aa4@amd.com>
Date: Mon, 11 Dec 2023 22:34:09 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Giani, Dhaval"
 <Dhaval.Giani@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <BN9PR11MB527647A4DA1620DE354983898C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3e77a4a3-3be8-4e04-9435-1f66df93078d@intel.com>
 <20231211130555.GB2944114@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20231211130555.GB2944114@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: b45c2f34-cfa2-4c37-e5ac-08dbfa5ea565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tgPzp1LYX2ja30oJrkVbeIqjgLjr9IMfslzvSMf9w4QXxoYfzAw1c2t/SfKnH4TTHYOZ5A1zu8OolSQrYAGYdp+7/7h7AG3s49VG/MnFj8Is3UmtbSHM2dUejOyMs3Jedtsmg3vylhXn/HrjTsuMNPOQxj7PUk/BB1l4i28unMZ9aRxEzm1Qn/IASzvT6rYTocL7Ap0o4/rS+8pPkgPfAqfJTkeMggV42ED3Y8cHvXCGMPNW2OfmJ5Un5fLTe0oSPWv49zCBJyNOleYtkWI13ydNVGMWCVk7QFxBGMnhYT5g+hln5ExREB/PetnTp6hEPhfDdH9pH9oPt7RzsSu3k97iagml/wVY0UQoF7opciMgQluTe+DtnWW5LUl3Jf8PC0uSS5aaxKvTDn1G/OnO/8mi554YgowaQ5gAT5eWdQ6WnOIQGChPp3Ng70TrgMTftPf5Ipxwi09or5fXpVS5smoV8t1F+bRfb3FfNXFcWbaZiJK0VfvdvYXSyfBQpqYj1FlgipXgZlWYeoNoQTDG2kHRTMLnyJKtdrYKS8+e9opgJvHhgDj+z2W4K0kmDgf6euxh0pq0XWUUQmWI5tNFWfn2BLA+9zEUdIoZRzR65AFSVf1UlBu9i6ik9WcBW6myzNT+ZNmpV6rfjKeh5x3WhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(5660300002)(7416002)(2906002)(6512007)(53546011)(6506007)(2616005)(31686004)(6666004)(36756003)(478600001)(6486002)(38100700002)(83380400001)(8936002)(26005)(86362001)(8676002)(4326008)(66476007)(54906003)(66556008)(316002)(110136005)(66946007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBLaWxCVS9taW12WGhmZHdkL0ExZHJkN1o4d3dGMzZ2cnRmOUt2dFpHYmJp?=
 =?utf-8?B?NUZkSmRUTlBGMlBVbG1yNytwUmI4Y2p4L09LV0Z1OHhJZWdnUzg5Zm5HbTRO?=
 =?utf-8?B?VWcxcDlSU3FnU1o5WXBTOFBkcTcrY1FvdlliL29LWEdIMm5OK3ptZE5xOEdr?=
 =?utf-8?B?N3FhU0ZCcTNiRjNRZ2VXOVNhSnc2VC9ENFRRYldoVXVjWk9MaEEzb3A0eWdB?=
 =?utf-8?B?TmJKazlWU2ZyNmdpQ2pDOXBQVmVERExnMjRqbThlTDF5OWFobU14NDY4cmZ1?=
 =?utf-8?B?LzhRWXBTeXUvTGlLSEdxOXR2d1VjakU1OFRmcDBhL3JvWFFmRC9YZVhxQzZv?=
 =?utf-8?B?TXdwZy9SWXBpajVIbU1LZEk5NXZGZnp1NGRMQjlPcU9PZy9oTmpBUjFFUWFh?=
 =?utf-8?B?dzUranZXUjRzTk82Z0xPTXZlSUpqeE11UGtYSU82ZzM2eXh2SzFreFFSRTNt?=
 =?utf-8?B?My83MjhoRlZhclRFRC9PWmhiZFl4OFhUUmxacUlSRE1hSi9XdmdaU3hLMUI1?=
 =?utf-8?B?VkJQaFBRdk4yUlp6VEFsRUFvcDE5VUpYR3BuUWwwRmRSWFlmZVNhQlNROVZ2?=
 =?utf-8?B?b2loNmpQRTVUL2NNNkRIQUE2L0xyV2FWR3FqOGZhNUIrbmloOHM2OHBUYnZO?=
 =?utf-8?B?NTRMTU5OWGVqWHk2b09TK3JWSnlDSXUxUEg0dHhBbFNUU2p2RU5kK3BRcHg0?=
 =?utf-8?B?bXd6Y2NOYUg2VEQ1UDJMVVpCN3pNcGJZMUI4OXR6RDVOQkVNL0c4V3RiK3NZ?=
 =?utf-8?B?WHhyL1JSQnJSMEI1amcyWWsybmcxTlVMdEVXTm8rZ2c3TE96KytwdVBaT0Vu?=
 =?utf-8?B?QnhXazZaSEk5VUNPMlFMajI2L3RWNjFaNk43Y2JkeG1DR3kzRmVhZlFWdEl5?=
 =?utf-8?B?dGNnajZpQ3J2eGVmVmpnTWlpa1BmM3RCcHpJNUxJa2RNdFlMajZMaWdDbmlE?=
 =?utf-8?B?RmJ1MkdWaE40SHV0b2FnalZtUW1WWFdMeUNDQjZkRXZBTERBUmFNSlkrVStn?=
 =?utf-8?B?L1BaWVFSdEt0QVN2cVNpR015UWRUMnBWTEZWQm0vRkV1TDlFeGhycDlOVi8v?=
 =?utf-8?B?VWhoVGN5YjVZdWNjNEg0emh5QjRUTEpqU3RxejhpcGltSHNWK0ZVaHNFU0ZN?=
 =?utf-8?B?bEhIeDlKWGl1SVlGbzhyelR1NG5ucVFFcTREeFY3YXA5allWU25mS0VFMzE3?=
 =?utf-8?B?NVhMWDZoVG9BZ2hsaHB1MStZWEx6T1NoVG1kOVBwYkVBOHFCRFNCNXFubnE5?=
 =?utf-8?B?M1lUK0wySmhSdnZzSVVFMXdJSkQwUnIvVTEvdTA0UXg1dnNDc2lONmlrcWVi?=
 =?utf-8?B?N29qZ1JXNkpkR2J6N0R4LzZoQXlMK21kaStneUNqaVAxZWc4aDZIRHc5REk0?=
 =?utf-8?B?aC94Slo3ZEJoUHpKMkN4cGFuS3ExUUkwVGZzR214Ylh3NlRmaWVlbUhCNVZp?=
 =?utf-8?B?cTVJdXF4YVhmTW9XNEJtaXV4OWdaVllMTVJPL3EzRGdhQU5henRGblBJeDNR?=
 =?utf-8?B?SnZTRHZmM2JUcytYQVZBcHFVcllOQUZxMC9nMXhVdkJQQ0czajNQNVlTK1Ey?=
 =?utf-8?B?OTl4NVhhTW5UdDhPMzBGNnhJT2dIRTVENHNCOC9CRjlSRUttalhwNi9BWENm?=
 =?utf-8?B?YjkvcDNSMHdaYjNScFVFa3A0TWNIcTEyUUl4dEw4VkRmVy9PUzZSUnQzTkUy?=
 =?utf-8?B?QjRubkEzNnZPb3ZKZy8wakF3M0toM0E2VDZGdVN3NDcwRzdGd1RleTAxTWc1?=
 =?utf-8?B?bVdHOElLU0FaSkpha1NCNVFpdU10dXJzbkRIZ1c2cWdraUxqUklSOGRpcWln?=
 =?utf-8?B?TWR4WFQ5WGs1RVliNC9xbjRqaGp5TlhiOXFXY2c1YzQrK1F5djk4T1dSY2t1?=
 =?utf-8?B?SzcwQ3g5VWZuVlU2RVN3NE03VHlWMVRtWllVaTdpTTBxRnNsYitvS21HSHVV?=
 =?utf-8?B?VDJuVzVhRFNOZU1ITmZtUkRqd2k1MVFRU21YMURKY0RKRVBER1g3OVhNREYx?=
 =?utf-8?B?blhSdnZBRUt3dEY1ejlYaUU4MS9XaHhMZy9FYVgzMHdtZW9jNFlWbEtZcllR?=
 =?utf-8?B?Qm5KSU5mWmVtMnFqSXFTdEtBT3BzdVBpUmVrUlZOVkxOa0xOYjFqZFNjRDlB?=
 =?utf-8?Q?U4HW5KlvbSrlqn350mYupWAEw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45c2f34-cfa2-4c37-e5ac-08dbfa5ea565
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:34:21.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGP4n4hHRDt4C33QtzZ6OxrAmwPEbVsNo8Mb2IrS4fu10PPdM9mTMvo04coQo5oieFMoAK/N8CwZv8348Cnacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079



On 12/11/2023 8:05 PM, Jason Gunthorpe wrote:
> On Mon, Dec 11, 2023 at 08:36:46PM +0800, Yi Liu wrote:
>> On 2023/12/11 10:29, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Saturday, December 9, 2023 9:47 AM
>>>>
>>>> What is in a Nested domain:
>>>>    Intel: A single IO page table refereed to by a PASID entry
>>>>           Each vDomain-ID,PASID allocates a unique nesting domain
>>>>    AMD: A GCR3 table pointer
>>>>         Nesting domains are created for every unique GCR3 pointer.
>>>>         vDomain-ID can possibly refer to multiple Nesting domains :(
>>>>    ARM: A CD table pointer
>>>>         Nesting domains are created for every unique CD table top pointer.
>>>
>>> this AMD/ARM difference is not very clear to me.
>>>
>>> How could a vDomain-ID refer to multiple GCR3 pointers? Wouldn't it
>>> lead to cache tag conflict when a same PASID entry in multiple GCR3 tables
>>> points to different I/O page tables?
>>
>> Perhaps due to only one DomainID in the DTE table indexed by BDF? Actually,
>> the vDomainID will not be used to tag cache, the host DomainId would be
>> used instead. @Jason?
> 
> The DomainID comes from the DTE table which is indexed by the RID, and
> the DTE entry points to the GCR3 table. So the VM certainly can setup
> a DTE table with multiple entires having the same vDomainID but
> pointing to different GCR3's. So the VMM has to do *something* with
> this.
> 
> Most likely this is not a useful thing to do. However what should the
> VMM do when it sees this? Block a random DTE or push the duplication
> down to real HW would be my options. I'd probably try to do the latter
> just on the basis of better emulation.
> 
> Jason

For AMD, the hardware uses host DomainID (hDomainId) and PASID to tag 
the IOMMU TLB.

The VM can setup vDomainID independently from device (RID) and 
hDomainID. The vDomainId->hDomainId mapping would be managed by the host 
IOMMU driver (since this is also needed by the HW when enabling the 
HW-vIOMMU support a.k.a virtual function).

Currently, the AMD IOMMU driver allocates a DomainId per IOMMU group.
One issue with this is when we have nested translation where we could 
end up with multiple devices (RIDs) sharing same PASID and the same 
hDomainID.

For example:

   - Host view
     Device1 (RID 1) w/ hDomainId 1
     Device2 (RID 2) w/ hDomainId 1
   - Guest view
     Pass-through Device1 (vRID 3) w/ vDomainID A + PASID 0
     Pass-through Device2 (vRID 4) w/ vDomainID B + PASID 0

We should be able to workaround this by changing the way we assign 
hDomainId to be per-device for VFIO pass-through devices although 
sharing the same v1 (stage-2) page table. This would look like.

   - Host view
     Device1 (RID 1) w/ hDomainId 1
     Device2 (RID 2) w/ hDomainId 2
   - Guest view
     Pass-through Device1 (vRID 3) w/ vDomainID A + PASID 0
     Pass-through Device2 (vRID 4) w/ vDomainID B + PASID 0

This should avoid the IOMMU TLB conflict. However, the invalidation 
would need to be done for both DomainId 1 and 2 when updating the v1 
(stage-2) page table.

Thanks,
Suravee


