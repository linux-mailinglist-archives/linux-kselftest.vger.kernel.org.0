Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0196216DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 15:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiKHOdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiKHOdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 09:33:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA02DB7;
        Tue,  8 Nov 2022 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918025; x=1699454025;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RH61kICgSA+VSksEkFZoZF8txeSawCE5Vgh5snAh8VM=;
  b=Di9m6Vz0QNkepQwOLhRX0MPOkggePV02fgL6GGRrqxFa+n1rqrXe49qw
   t2rOwFaO/tgqbAxFZo2p1yHJ0E7F1HidOKbd8Z7Ns8y/e1VsGJxTUEPid
   mrZy4oqUvEUV7tZd+/+lDMxox8jgcdk3EnRXcvWPwArEx5JyCh2T/mjZ3
   mmy7ATioJa8dOGcblIz/0iyQnZ4nGm0HGZf1mh6imP8pWDCd9qpqQHYSt
   jrk95ojcVBmIznM2ht5JO9jFv/QZ6XM6bGEd2PAPc5X7Hl+ZFPyyZmWTD
   KiKpPZL29I+uTOTxuLG+4azH4wz4iCn5AQxuEW3lDYQWqP7ycLY6S2qUf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="311860727"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="311860727"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="587389823"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="587389823"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2022 06:33:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 06:33:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 06:33:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 06:33:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 06:33:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucn2FWnVuykNunkSZuBep31ZSMTgwn8zEfpWfk1v2s58qmmGDi0gGE7LhLy1r51T127xhbpkmOqSuYfa+7kJ+dRGD5WEbcjvQW+CZTisGK0zdLGU/JdPQCAPbjC9q1LKBMbBrOUw7twEIQewnK8pGLKB6bqDqRckIUBP5OxlxmMUL2pB5uDB8NtZKpfP4/VoJrroqlSjKCqjCt7WzeOWcUp6JqRzVp0PNDcVlV4g1NlH0jUz9pVuZnwMRJ/NFzH4NxMUAjUVfrFppMiDSSYknRmtncZEj4EAUG9afTpmfh/3aS2I9Sx9MwbIHM3PllXBohnuO7kLPDqcbN3v8Tqlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itd/9ntD3UE5sIBdQYeOG9F020ydvm/T35kxKhHrXuM=;
 b=AyzeJNgYPw6Hi+GcuVvNdNsINTIwkxZqfN07oSD9SYDfuH7WvKOfRbOrewimiQNltvEjuRJ4lxjPr8ewIVvYSSHXt515C5dXWlekJyLvaohdijMCDQRJMezLPsi6fubhFlmhaq6VJqQqOzHNHjPgSIGHEQmXvlfOARqLY56u9Sp9vI27oUoOvIz/oiBb++xp+yEbbzlh/RaI8/8nxJLG8xtENAXIAUDV3kCwbfd8YUnJQ4E+ZhlmL7Pm6XtNM++iFP8HlgQEkT7o0uDuPDomeiWowznKMt49zcIQauagKSWk1bvWJ9+712UzUBu9+pgDII2t5gFIuYvD4kQJZPWIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 14:33:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::ad39:e00a:a7cb:4ada]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::ad39:e00a:a7cb:4ada%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 14:33:39 +0000
Message-ID: <2cbd00ff-a51f-bd0f-1bd9-67db5f5d22f4@intel.com>
Date:   Tue, 8 Nov 2022 22:34:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for
 physical devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        <kvm@vger.kernel.org>, Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <12-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <12-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0637e9-9131-40f6-bfcf-08dac19639e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZhVXqxpznRbt09HzoxKwnAZR/Obu2rgO9KDnS8uKyiNa+ZVr0a0h/OwKC2lJKAbGO0wL851OJjh66oS9GJIiH/R2qVZGGTEVij3k2xSGUOFbEdRihX1trLbLqNdTyqks9Nt86YSkAtVd71K/kdqk1f3rvu6yH9TpYdjwwOOaJ80iQHT4lhskWNmkv4Ue/RRLiphLvBtB/6wp9VBcJ39MmPA1XklNDeCnjtQ/Gjyt/wq2b52vhvEMBVHxG9LrkzVGQwjeCA4Hr2Qj8qMmGuC0zleXThdoRYmSIZXyT0V2fVUTAx0AxiEJL8WAvtl+hDis3/6UxK00ZZNLoHBkiahI6LnTOsReTJtHuqhvHWI6RmaS+huBzgUZwXw0YlrRe1wmIrNwAio86JSqNAvB3dmsV6+BpxnogThzfKis3icRE3FsgyEtbtAGH5TN39fuFoagrf6qBCWaYFoUh2yLk+H6R8d0UHhwMLhyJpGSE35LdcsAmHqrmhBOQ3/gV23P8BOIE9XlUZhdZzixYEZaUEuixAAO/o7JlsC0LjQ5pfJhS8u1PI8wd3+Mv6Jz755mxBRx6MhUT5ER/929eMo5xeeNY4+djx1MB0yaYATt3cvE3ERdG2btUU+WKZ/MphQ4YdXvTAqZkL+QqUEjQcHUWFiBr7cSaUEjsX7Y/o4TeHD2xqn5nA4f19AQnwLX1loW7vdvkfePeU0T3YaHxwDYL4jtO04rXfaPOGJ/biCkpBuO0d/lEggx2hDfHlKrawmaqlqacTDnC5dvlw2YEBsb2ooPLUjCdgP/Qa5/2E+FBLVhaT/2ME0qFcq1uUh7b2tnyXw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(8936002)(31686004)(82960400001)(66899015)(5660300002)(7416002)(7406005)(38100700002)(41300700001)(8676002)(66476007)(66946007)(4326008)(2906002)(31696002)(83380400001)(36756003)(316002)(54906003)(86362001)(110136005)(6486002)(6512007)(478600001)(921005)(6666004)(53546011)(6506007)(26005)(66556008)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDROQUFsUEUzTTlrN2Ura0w0NFdONjIycFp2TFB5aHR3TkFhc25BM3pVNjQ2?=
 =?utf-8?B?VmlQSEdVdTJPRDY2K0w1R2p5Wmt6VWhGMXlPeE9hOHh3VVk5RHRveEsrY2FC?=
 =?utf-8?B?K3BXUDNlaVRVRE1CUm9FMHd0NFg1TzdCNnhUR0NwL202TmxBUU1iYmg1cTlm?=
 =?utf-8?B?bWtQWVFzdzdtVlFrRyt6b2Rab1FwNEVnaC92SldHY1ArSFRiOG9nckw5eEFE?=
 =?utf-8?B?aGdqK1NabE1VSjQ4NkFPOXdLSGEvM3lSWU40a1pJWXlvZTlMRkZKYUF2b1ow?=
 =?utf-8?B?clhVRXk3TE1IODNGMFRkNW5ocFcrTXNuODB1N1RlTStLZ0t4U3lpa2NMNHhl?=
 =?utf-8?B?RFNvdmpIZnk1RjlnZ20yVFJxdUhWb09mc2hBVEg2ZUlTWVFNbGpYMWlQMHVy?=
 =?utf-8?B?N3RnR3E3UzZ0RmcvVi9tMjR6dVozOUhtTzQvNS9lT1Y4UVZ5VmZVbUFQYTF6?=
 =?utf-8?B?ZmVRQXF3UHBVSXVMaXNkTkFXaHp2NTdERUJQVzVYeUZHSHg5Qm96VEh1RWlT?=
 =?utf-8?B?QkRhSS94eVFzS01kdlpKL3RhY0h1OEFvS2FvbnloMld6WWtZVVhaclZFRTEv?=
 =?utf-8?B?VThNWU54TUJsSDQraGplY3hPbXQ4MzVEaWM2UGJXdzk5SWNTSHU5cmpNS1cz?=
 =?utf-8?B?aEl0UERkTkExOGREZkFLbERSSUNJeG5YZmEyTVRDV2JqNjRET0RSQUQwbndm?=
 =?utf-8?B?NE81N2JsQ0FGM2xoUmJPMGt2OGs3UzNXb3dEM083OW8wenFMdXVPWExTZ0F6?=
 =?utf-8?B?RGplVmVCekk4cEE1bnpNa09pVytpSk1XZkcrcUI3ckJXYkthOGVYS25wVDlt?=
 =?utf-8?B?Z1p6UGxlcUdUMmtpRHdLSWloRjlMSTAxcTdBL01xY2M4aVEwTkRtTE1HN2li?=
 =?utf-8?B?STFQL1BkK292Zy96ZVJlN3d6RVNib1Y1QUNrZTFJSStjT1FqTWoxMmZDMTNC?=
 =?utf-8?B?ZTJzMkxGTnUvN1ppMEJqWHBZR094L1Q5UzBnU2o1aHlldVpHWFdZQlFoWHNT?=
 =?utf-8?B?ajJ1VUMzVXlqUGpTa0ltRkRueXBHZUxEQzVTUVBOODhZK2ZzRkpOMG1GY2xJ?=
 =?utf-8?B?OVUrSUtjajBLcVplNzVmRmpwSXQ3ZDhyVnFOQVozeUpUQlJFYUpQNlBPbEp2?=
 =?utf-8?B?bVRnUEVQcnM2VGFGclJ4cXVOZlFxQXRPTXExYUduSDQ3TitVUkJTcnpjQWJX?=
 =?utf-8?B?Y3B5RldLMkwwdGwybmN3d1pDZ3ZWRHdRbnl0UHc4U2lOWURaNU5LbHpDa2JZ?=
 =?utf-8?B?UVN6S1pOV0lZNEd1UXJnQXM2WnB2SXJ2WGlVRXY4WWVacDVpQWpTVThEYi9W?=
 =?utf-8?B?MWNvWlVUWEk4OFhDTUQ1aUxlOUFoN3dSbmFwOWpCa2kxdkRYSkhkcDFheHht?=
 =?utf-8?B?bi9wUTRmNGt5bStNbzJmSHpKeVpLK0Z6QnZFRUJ5bnhMdHV3MUFzUVlPWXpq?=
 =?utf-8?B?ejZGejdDNHVIajA0SkxuRGlVVTZUODcxUEJ6di81RFJYMGgrc0NjWFFBdTBP?=
 =?utf-8?B?V2ZicGs0VVlvb0xsbDhybk5TNFpkN092UWNqUGl0YlIxdG16TWxxcnRhcG9o?=
 =?utf-8?B?cG95VlZCNzByU2hjYXRNOUJsa3h0a1ZOR2UxNGdHdHZPRi9BSHV1SWszZTNj?=
 =?utf-8?B?THlIZG02akhqRUxDTjN6eTlUcUtFTmhIa1huRWVZS0pjdjdobUgwb3BhY2hi?=
 =?utf-8?B?eHFUNFFJeUFEUXF4UGU0dlMyc2F2cFcyaFpvY0RCUHRrVU9ma1NtSCs0OCsx?=
 =?utf-8?B?bjNibTlwQnl2aW9DU2lUd0lVQkNoQ0JNK295SndnRWc0VVY4aFUxSm9xclRB?=
 =?utf-8?B?anZRWmxqajFDWEVHNk0zRHpkbzFjbHRmL25tczU4bFRnanFLREtmM0lLaW9H?=
 =?utf-8?B?QlhTSVFTVmtGQlg5YzMweWFiaytURDBSaHpYdXNsZTE4eVNFUGIwV3M1bXVF?=
 =?utf-8?B?WHhlRGdkYmVwOEpKOXloMFFsbUFsS0FmeUc2bXZWcWNzUWZ0K0Z1SWJmMTFh?=
 =?utf-8?B?c3NYbHVodS94TDY2emFhWFpYdUVqUWFnUC9NSTQzYm5LbHlmMy82V3FKN1h3?=
 =?utf-8?B?RXo1NEJacUtwMHZjL3FtbmVya3ZSc1NUZkhqWWVyRHYyUFhmWnk4TzJWQXV1?=
 =?utf-8?Q?A7dwUvX4X0/9lifu/+WNYcGFG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0637e9-9131-40f6-bfcf-08dac19639e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:33:39.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr0W0gqM0eRlxczu+tfi1g7LZnM9dXtJm/NQ96hjORScfb4xvGB4dguxC/AHrTYf5FJnz0lLlVZT503Cqw0gdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/11/8 08:49, Jason Gunthorpe wrote:
> Add the four functions external drivers need to connect physical DMA to
> the IOMMUFD:
> 
> iommufd_device_bind() / iommufd_device_unbind()
>    Register the device with iommufd and establish security isolation.
> 
> iommufd_device_attach() / iommufd_device_detach()
>    Connect a bound device to a page table
> 
> Binding a device creates a device object ID in the uAPI, however the
> generic API provides no IOCTLs to manipulate them.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/Makefile          |   1 +
>   drivers/iommu/iommufd/device.c          | 402 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |   5 +
>   drivers/iommu/iommufd/main.c            |   3 +
>   include/linux/iommufd.h                 |  13 +
>   5 files changed, 424 insertions(+)
>   create mode 100644 drivers/iommu/iommufd/device.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index e13e971aa28c60..ca28a135b9675f 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   iommufd-y := \
> +	device.o \
>   	hw_pagetable.o \
>   	io_pagetable.o \
>   	ioas.o \
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> new file mode 100644
> index 00000000000000..a3bf3c07d3f800
> --- /dev/null
> +++ b/drivers/iommu/iommufd/device.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommufd.h>
> +#include <linux/slab.h>
> +#include <linux/iommu.h>
> +#include <linux/irqdomain.h>
> +
> +#include "iommufd_private.h"
> +
> +/*
> + * A iommufd_device object represents the binding relationship between a
> + * consuming driver and the iommufd. These objects are created/destroyed by
> + * external drivers, not by userspace.
> + */
> +struct iommufd_device {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_hw_pagetable *hwpt;
> +	/* Head at iommufd_hw_pagetable::devices */
> +	struct list_head devices_item;
> +	/* always the physical device */
> +	struct device *dev;
> +	struct iommu_group *group;
> +	bool enforce_cache_coherency;
> +};
> +
> +void iommufd_device_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_device *idev =
> +		container_of(obj, struct iommufd_device, obj);
> +
> +	iommu_device_release_dma_owner(idev->dev);
> +	iommu_group_put(idev->group);
> +	iommufd_ctx_put(idev->ictx);
> +}
> +
> +/**
> + * iommufd_device_bind - Bind a physical device to an iommu fd
> + * @ictx: iommufd file descriptor
> + * @dev: Pointer to a physical PCI device struct
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and returns
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touch
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *
> + * The caller must undo this with iommufd_unbind_device()

it should be iommufd_device_unbind() now.

> + */
> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	struct iommu_group *group;
> +	int rc;
> +
> +	/*
> +	 * iommufd always sets IOMMU_CACHE because we offer no way for userspace
> +	 * to restore cache coherency.
> +	 */
> +	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> +		return ERR_PTR(-EINVAL);
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return ERR_PTR(-ENODEV);
> +
> +	rc = iommu_device_claim_dma_owner(dev, ictx);
> +	if (rc)
> +		goto out_group_put;
> +
> +	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_release_owner;
> +	}
> +	idev->ictx = ictx;
> +	iommufd_ctx_get(ictx);
> +	idev->dev = dev;
> +	idev->enforce_cache_coherency =
> +		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> +	/* The calling driver is a user until iommufd_device_unbind() */
> +	refcount_inc(&idev->obj.users);
> +	/* group refcount moves into iommufd_device */
> +	idev->group = group;
> +
> +	/*
> +	 * If the caller fails after this success it must call
> +	 * iommufd_unbind_device() which is safe since we hold this refcount.
> +	 * This also means the device is a leaf in the graph and no other object
> +	 * can take a reference on it.
> +	 */
> +	iommufd_object_finalize(ictx, &idev->obj);
> +	*id = idev->obj.id;
> +	return idev;
> +
> +out_release_owner:
> +	iommu_device_release_dma_owner(dev);
> +out_group_put:
> +	iommu_group_put(group);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
> +
> +void iommufd_device_unbind(struct iommufd_device *idev)
> +{
> +	bool was_destroyed;
> +
> +	was_destroyed = iommufd_object_destroy_user(idev->ictx, &idev->obj);
> +	WARN_ON(!was_destroyed);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> +
> +static int iommufd_device_setup_msi(struct iommufd_device *idev,
> +				    struct iommufd_hw_pagetable *hwpt,
> +				    phys_addr_t sw_msi_start,
> +				    unsigned int flags)
> +{
> +	int rc;
> +
> +	/*
> +	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
> +	 * creates the MSI window by default in the iommu domain. Nothing
> +	 * further to do.
> +	 */
> +	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
> +		return 0;
> +
> +	/*
> +	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
> +	 * allocated iommu_domain will block interrupts by default and this
> +	 * special flow is needed to turn them back on. iommu_dma_prepare_msi()
> +	 * will install pages into our domain after request_irq() to make this
> +	 * work.
> +	 *
> +	 * FIXME: This is conceptually broken for iommufd since we want to allow
> +	 * userspace to change the domains, eg switch from an identity IOAS to a
> +	 * DMA IOAS. There is currently no way to create a MSI window that
> +	 * matches what the IRQ layer actually expects in a newly created
> +	 * domain.
> +	 */
> +	if (irq_domain_check_msi_remap()) {
> +		if (WARN_ON(!sw_msi_start))
> +			return -EPERM;
> +		/*
> +		 * iommu_get_msi_cookie() can only be called once per domain,
> +		 * it returns -EBUSY on later calls.
> +		 */
> +		if (hwpt->msi_cookie)
> +			return 0;
> +		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> +		if (rc)
> +			return rc;
> +		hwpt->msi_cookie = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Otherwise the platform has a MSI window that is not isolated. For
> +	 * historical compat with VFIO allow a module parameter to ignore the
> +	 * insecurity.
> +	 */
> +	if (!(flags & IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
> +		return -EPERM;
> +	else
> +		dev_warn(
> +			idev->dev,
> +			"Device interrupts cannot be isolated by the IOMMU, this platform in insecure. Use an \"allow_unsafe_interrupts\" module parameter to override\n");
> +
> +	return 0;
> +}
> +
> +static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
> +					   struct iommu_group *group)
> +{
> +	struct iommufd_device *cur_dev;
> +
> +	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
> +		if (cur_dev->group == group)
> +			return true;
> +	return false;
> +}
> +
> +static int iommufd_device_do_attach(struct iommufd_device *idev,
> +				    struct iommufd_hw_pagetable *hwpt,
> +				    unsigned int flags)
> +{
> +	phys_addr_t sw_msi_start = 0;
> +	int rc;
> +
> +	mutex_lock(&hwpt->devices_lock);
> +
> +	/*
> +	 * Try to upgrade the domain we have, it is an iommu driver bug to
> +	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> +	 * enforce_cache_coherency when there are no devices attached to the
> +	 * domain.
> +	 */
> +	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
> +		if (hwpt->domain->ops->enforce_cache_coherency)
> +			hwpt->enforce_cache_coherency =
> +				hwpt->domain->ops->enforce_cache_coherency(
> +					hwpt->domain);
> +		if (!hwpt->enforce_cache_coherency) {
> +			WARN_ON(list_empty(&hwpt->devices));
> +			rc = -EINVAL;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
> +						   idev->group, &sw_msi_start);
> +	if (rc)
> +		goto out_unlock;
> +
> +	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start, flags);
> +	if (rc)
> +		goto out_iova;

aren't the above two operations only once for a group? I remember you did
the two after iommu_attach_group().

> +	/*
> +	 * FIXME: Hack around missing a device-centric iommu api, only attach to
> +	 * the group once for the first device that is in the group.
> +	 */
> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		rc = iommu_attach_group(hwpt->domain, idev->group);
> +		if (rc)
> +			goto out_iova;
> +
> +		if (list_empty(&hwpt->devices)) {
> +			rc = iopt_table_add_domain(&hwpt->ioas->iopt,
> +						   hwpt->domain);
> +			if (rc)
> +				goto out_detach;
> +		}
> +	}
> +
> +	idev->hwpt = hwpt;
> +	refcount_inc(&hwpt->obj.users);
> +	list_add(&idev->devices_item, &hwpt->devices);
> +	mutex_unlock(&hwpt->devices_lock);
> +	return 0;
> +
> +out_detach:
> +	iommu_detach_group(hwpt->domain, idev->group);
> +out_iova:
> +	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
> +out_unlock:
> +	mutex_unlock(&hwpt->devices_lock);
> +	return rc;
> +}
> +

-- 
Regards,
Yi Liu
