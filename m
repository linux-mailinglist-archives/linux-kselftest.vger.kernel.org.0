Return-Path: <linux-kselftest+bounces-287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B19A97F0D80
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BA1B21120
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094BE578;
	Mon, 20 Nov 2023 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJ2dRste"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEE95;
	Mon, 20 Nov 2023 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700468840; x=1732004840;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=figct03v9LUKS8X09IKA+eaO6nCGAqrfViTi3hBD1bg=;
  b=DJ2dRstekjQb7NX8kRu62RNhkoQF7HL0M8QnegVyk6DyIWlF7IGg2CuQ
   zqlpisFOYvt0KbND0iT0aMVZQU0iZ+A7ugnqfP+pGNIxlALA0ZHRkltqa
   dWUEbQHd4V3+WjyTCc1u/JEZiSbeotDUHjyS6zYvevkRcIiAJYY6Q5KV+
   Ov06YPm6KXn5v3+k4MZC/NvQsTVDzrx/H54ijgJ6qL6Qzg28qdPGhhkh8
   vOTtgYOVCQcikvppGktdgqc19KJABVHu2v1Aoe2Fs8+zrbXRvqxqGP7+f
   ulSt0FbzAkIkpyCva6+z/DRBsNE34jQsXpEUHo9VuZdon+dehUOpGiFAJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4693959"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4693959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="759724986"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="759724986"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:27:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:27:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:27:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:27:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlNCLDxOtVSj2EehbcxOl+S+U1jCWun7c1DMmOKpk/TAVgeCia2hUr4taHdhF4hnva5xiLFmxDMNex26EtPvw+8ENujoseWnROazObzZyNX/moIZbYEeEthAPCbSLgCj2AXhHyum23kxoDItsVtL+HoV+qHN7fthRgqz8Nh2dwsLHMgLzNYP0AN2mB16XWt+7ifk7ixB5IIPIv/npnCE94A7e5HsQm2gRoWUjxN7gvFsYpyGKMUu96lf0QzPnK8xv1o8MjFSGNdAsH53tBy1kIRxmwat1sV1J8LdLV2FzzRjE+5zgRL/x0PfPUMalBc7cgfRwPEEr4lAwRyiVzRKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhboWRTWhRY9aPGZrPo9dT+y9y9/iNWqkDJUpefqbSA=;
 b=mifQ+Msz03Mi4M+r39Wptcmds33cHBFYSF68cyJIKPqJrbNBBTGyk5UbbkerAE1Irfo47bkawwKMSx52LLkJpoevqYIfJgiqWF3+YQsF/DZStxV2bBbF2uFixSKp61LGV1eqecskGIiShSYta/1qwXgCGOHzx8Nny+9HcvEVnYGbKM6WjsueVnec9c/4XgaB2RNj32uc2fgTfQ0hThM/dvEYEVGjh4CXd1MiGIZ3bBa51D9D+Nf9+ApukBauDfwR/b+pUs+40MD8q6CTid3FYmbP/5b3un2AT6TGuiITjz0Se0952CVrEhNu2E1++7/Fs4ORdAgqJcMQyXCL3hChFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 08:27:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:27:16 +0000
Message-ID: <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
Date: Mon, 20 Nov 2023 16:29:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: f766128c-cdc5-482c-d334-08dbe9a280b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVDVXORZAhXwOjf3Iy7Od9tJFVonRskaLZAxdWzC7++q/sfnY0sHAxWlYFSikxc3WE8DUJqc0T/MHlExCGLQVg46mPEtqpqPWy+nm//thvVy20fJ5dPP7dYBXcxcnMkPVS09gquNO48avPuHehTNOQ+tzjEjr88UJsXjr2Dtmw9HLYvn9crBXPc84XIWtm1AJAPtse8buAuPdDio8RRBTQME2EIEZc6zTzh20EOMV+vOcbAtaKehYryhhYwUB0xqvf6YFeSE2Tt8e5QUt6oEm1rYPW+sKVKsaIBu1vIikDngKd4Yg6t2DnAcG36vw2xildcgv2JoR+LRV3G6bQkBCHsZUnfeylv4B3DX1o+XFiZV64nRXftM9gP+nxvRhBzAWsLP+vOUg1UHb86htKT6JTNWT5+t38sv4rrad2btOfhHLxnkFy2SuI8sUN8Ylklbkbucu4gZorM/Fd8fPpzQ5gRPXethkaM+7wVcQqRu0+L6ijZ4KAf4wqTd7fWAfYrCEYwEXmlVNgVGqth6PBkRudySYXcMPj64Xx14xtAcoy5NsZSSpbqbyf2KsAmau3OTO7BU4NZyN3K42TVAFnAm4IgzXkf/RMdszW4NAG3rvyUMfqZZ4gfySE+RXuSE1TQX2vVOVvAuJ9aZ3xbvXY2Aow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(86362001)(31696002)(2906002)(5660300002)(7416002)(66476007)(66946007)(54906003)(316002)(66556008)(110136005)(4326008)(8936002)(8676002)(36756003)(41300700001)(6486002)(478600001)(6506007)(2616005)(6512007)(53546011)(6666004)(83380400001)(26005)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NyswVGZGQS9BcCtZbTg5QmZBU1l4UTdpTVFmcFFoMXUzbnZ6SnRxbXRXaS90?=
 =?utf-8?B?WDZZZFIwOVltVmNkb3JvbERPek9DQ2tOWmZnWkR4YzBOMXFOTGVqditGR2JV?=
 =?utf-8?B?S0ViRDl2cDhIaXpqV1VqdE80aWVwTUlRN284SXF2Q1ljdklneGsyYUpKS21J?=
 =?utf-8?B?RVJGanE0T0trUmNvWmpVU1RrWGs1QUFvQVRzNnJVcGpjNlNBYmwvTDdsczNP?=
 =?utf-8?B?a3hmOElsckJobk1SWTNPdzRxTnVNRGJQVkd2dXdoYk5JcGtZMDlFZGhlV0tB?=
 =?utf-8?B?cy8yVWxzL0lNMWk1L3FvaUt6QXZvTDJSVHBWdFdrM2RRVWc5T0NVZS85cExy?=
 =?utf-8?B?L2FYcmtLY2xmUng5NmlUQVJIS0pNSWZaUkcvcml3RmV1NlVyalFXdkQ1ZjZR?=
 =?utf-8?B?djRja2J1R0M4dmJBYUl5Tldwa09vOSs4blBrR244NFhjUFNHOHJvWGowbnZN?=
 =?utf-8?B?ME55ZVFzN25MVWh1WnIrbXhOa3FaQU5aT1lkMjNlUU1hb2hZRnZXRlIyQTF6?=
 =?utf-8?B?SEdiZUVDMUY2YXFuNHd1WjFZYlFEbzJVR21YME44d1FUZVNLWUpBcWtvb25K?=
 =?utf-8?B?WGYzOXVZR2ZKaE4xNFNDZ1E3ZUROZ3FpRU1SY2lBTFlQY0pDNVJMSDVoT3N3?=
 =?utf-8?B?aVJ2YjBDdDJhSzdDVkpWRzd4K1NqRXlGMysrYnphMTdVVGp6eTB0dk1lKzda?=
 =?utf-8?B?Rjhxem1QLzFoMDhhZ090aEtIbTVsWkJvRnBWR1RKQnFvaW41blVubG1KcFBK?=
 =?utf-8?B?SUFIbGVSNjFPREx5eHdoUWFEaUJaRTZLRnllRWJEWDRRT3hZdjMwTCt0R21q?=
 =?utf-8?B?ZlhwT2NlTFhycitndUpmYXFBYnR5K3ZKTlFYaERVZWlkT2RaN3gyU0pDWmtW?=
 =?utf-8?B?YUQvMFMzdjRBcVZYU0I5M3FGemFMbktUenlBZEFjQzJGUEpkZkJBZGpYR1Br?=
 =?utf-8?B?TWdVZW9DV0Q1LzRPcGJ3aUV1VjRhWi9FVW9MS2JzdU9udXQ5NGF1R0ZjZjNS?=
 =?utf-8?B?YTVZSS92a1hsUVdDTjM4alh4UmdTdHp6NUR5alZ0WGczWFZHdENYS0RaMmFB?=
 =?utf-8?B?V1dyWVppK3RkdWRUeDJCTzFzTm1uVFFPbTg3a3ljRVlEMmhFaHAwN010cTFP?=
 =?utf-8?B?WFozV2hKTEFBaUxrNSsyaEc3ZUxqRGlDV2NYUnpUcWdmbzhReXphWFQyeW82?=
 =?utf-8?B?elF6aEVQeUFIM21DN2JhR2J2Y28yNTRmRmVYdVM5cHFVVVpKMGZFQzg2clZy?=
 =?utf-8?B?WnJpYmk1VGRMaHloNlYzblc1V1FkVFZYcjJzME15Z3h2b0s1YTR5TDBXWFZj?=
 =?utf-8?B?V3I2RWdwajkxUDMvbnZuR0xOQjhST0pqek1tVXJ2dEl6UVljamUyZWxDNEhH?=
 =?utf-8?B?Tms2SW9laXVGRTI4OUdSWFBWa2xLZXFOTHpZbDlKYk5XczgyRi96d3ZUa1Nt?=
 =?utf-8?B?VjdCK2txOGJMUU1ma0g3R1pCQmoya3FrcXNMM2d1VDhwRG9oRDVaYmRoTC95?=
 =?utf-8?B?V3pCRTFmQ2xPUkRyNjZkZ0t5bEFPWkowYnZ2OU9udks2eVFRNXo5dlNkZXJ5?=
 =?utf-8?B?MjlodUZDajFva1dZYStCdFNrSHVQR2lJZzF4ajdDcjBjbTRQbHhheFJoaUJz?=
 =?utf-8?B?RDdxcXdHNWQxYTZLTWxWTzhxdDAzelczTFdBRzBoMy9pMmo0dkZpa3dvVnlH?=
 =?utf-8?B?LzE0cnBCSVN6TmRxRjVIMEJjdi9GS0NYckttcmNDcThKM0puc2xzSXNrb2l0?=
 =?utf-8?B?aDFZdFNNMFVnTDhwVDM1YUNYTWZ1OXk1c2lXK05kUThWc2xPL0E4QlBab1B0?=
 =?utf-8?B?R2dMelZqYkhKTVJpeGJDcm1Mcjc3RFhLWEJxeENGcU9LZC9ZVEZrb2J6bVQ1?=
 =?utf-8?B?RnFnWS9ETHhwN01meHNDNmkrZkw4akgrZDZRWExFdzZKNktReERrSFJxOE1D?=
 =?utf-8?B?aUV1eWVqek1LTUtuS2ZZbmFzNXhKdTJvSlNFMXk3a2loYUhGUXhRNHdWN0RH?=
 =?utf-8?B?WmFYSlYydmUzUjBpb00vbzVsclFXaWtoWk02ODRjUTV2YnRNQmx3VzB1S0U1?=
 =?utf-8?B?RXY5M1FmZ3RZdXplc0pNaDNXdkNxSlZ5RFNOUkhBTUc5OGRJSTY0VXpQZHNT?=
 =?utf-8?Q?wbpIX43dJzhuUSnSlrxVguPsa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f766128c-cdc5-482c-d334-08dbe9a280b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 08:27:16.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+j+Cb1NQNJiwO0+pmi47zqlyS+qissTu8HmOPOYh0PuFxmtpEXDw0ssCcsExjAGB/tZL3UW46oemoDDt1YC6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com

On 2023/11/20 16:09, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Friday, November 17, 2023 9:07 PM
>> +
>> +	hwpt = iommufd_hw_pagetable_get_nested(ucmd, cmd->hwpt_id);
>> +	if (IS_ERR(hwpt))
>> +		return PTR_ERR(hwpt);
>> +
>> +	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
>> &data_array,
>> +						      &cmd-
>>> out_driver_error_code);
>> +	cmd->req_num = data_array.entry_num;
>> +	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
>> +		return -EFAULT;
>> +	iommufd_put_object(&hwpt->obj);
> 
> the object is not put when ucmd response fails. It can be put right
> after calling @cache_invalidate_user()

yes.

>> @@ -309,6 +309,7 @@ union ucmd_buffer {
>>   	struct iommu_hwpt_alloc hwpt;
>>   	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>>   	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
>> +	struct iommu_hwpt_invalidate cache;
> 
> In alphabetic order this should be put before "hwpt_set_dirty"

yes.

>>   	struct iommu_ioas_alloc alloc;
>>   	struct iommu_ioas_allow_iovas allow_iovas;
>>   	struct iommu_ioas_copy ioas_copy;
>> @@ -348,6 +349,8 @@ static const struct iommufd_ioctl_op
>> iommufd_ioctl_ops[] = {
>>   		 struct iommu_hwpt_get_dirty_bitmap, data),
>>   	IOCTL_OP(IOMMU_HWPT_SET_DIRTY_TRACKING,
>> iommufd_hwpt_set_dirty_tracking,
>>   		 struct iommu_hwpt_set_dirty_tracking, __reserved),
>> +	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
>> +		 struct iommu_hwpt_invalidate, out_driver_error_code),
> 
> ditto
> 
>> +/**
>> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>> + * @size: sizeof(struct iommu_hwpt_invalidate)
>> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
> 
> remove the first 'HWPT'

>> + * @reqs_uptr: User pointer to an array having @req_num of cache
>> invalidation
>> + *             requests. The request entries in the array are of fixed width
>> + *             @req_len, and contain a user data structure for invalidation
>> + *             request specific to the given hardware page table.
>> + * @req_type: One of enum iommu_hwpt_data_type, defining the data
>> type of all
>> + *            the entries in the invalidation request array. It should suit
>> + *            with the data_type passed per the allocation of the hwpt pointed
>> + *            by @hwpt_id.
> 
> "It should match the data_type given to the specified hwpt"

above comments are well received. :)

>> + * @req_len: Length (in bytes) of a request entry in the request array
>> + * @req_num: Input the number of cache invalidation requests in the array.
>> + *           Output the number of requests successfully handled by kernel.
>> + * @out_driver_error_code: Report a driver speicifc error code upon failure.
>> + *                         It's optional, driver has a choice to fill it or
>> + *                         not.
> 
> Being optional how does the user tell whether the code is filled or not?

seems like we need a flag for it. otherwise, a reserved special value is
required. or is it enough to just document it that this field is available
or not per the iommu_hw_info_type?

>> + *
>> + * Invalidate the iommu cache for user-managed page table. Modifications
>> on a
>> + * user-managed page table should be followed by this operation to sync
>> cache.
>> + * Each ioctl can support one or more cache invalidation requests in the
>> array
>> + * that has a total size of @req_len * @req_num.
>> + */
>> +struct iommu_hwpt_invalidate {
>> +	__u32 size;
>> +	__u32 hwpt_id;
>> +	__aligned_u64 reqs_uptr;
>> +	__u32 req_type;
>> +	__u32 req_len;
>> +	__u32 req_num;
>> +	__u32 out_driver_error_code;
>> +};
> 
> Probably 'data_uptr', 'data_type', "entry_len' and 'entry_num" read slightly
> better.

sure.

-- 
Regards,
Yi Liu

