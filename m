Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665A7629C94
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKOOtO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKOOtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 09:49:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4FE10FF2;
        Tue, 15 Nov 2022 06:49:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1CajyqRI3hwTH5OTG4V0QR5L2zHOeT0YbJbVraIKr++t6t2hly+oQqRv3SQt8Nk8CA0SCOGEoPrx3ol79ZOv6ItdCDYYYRE+vHzedPGWnc8kZ36wCnbI47Vk8lupyf+2L1WLvXVh6Z6VmzmWZ2W6ucfmAwpQUIYvIG2h0pGYXdBCHeYRK0i3UZqpTeFW4zwiFV6MtqyWLgrstnBlGu4ChHVfLjvt5EU75Nq5dm0Yp3fnkJBg/iL2TagsVfy+P9C2TYq6aM3qaCZHqAjUxnXFTSmbg6f/Ocj16pRYB62Yb5NSRz3Co0maimD8G2L27y3v9q4pNbZRjLbqhautUqlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yvfH4zQLQ+BI3FnwlxjOgFeNphjhDMZUMeTQED5QcE=;
 b=Yh0kcJE/KTmtJXd9MZdHqlkw/Eb1BCNpocEH0Hs1G6kPxJ5/lj7rDeufvSMLrCLx14pcMr+J3wjppjT6cJNWvhhvhzaPf+YeahWX1aL+Qq/rzCb69L7p/81X6v0ko9KyKNqGNVgqLIvqY5lMr/fv2/mHzhEuEu8xwN5hjRZm9C4ZrfxV/L/Nw/ybLnh5uWs6lszl2mzRYU26TYTCABnRJ9h0vOKxTUBn8JJkYKWrl3JqKYWs+lfAPRPrdek66aKYvIU6FVc0+1cBg02qMzuDY9t5ckM0vorOb0+3qixjfJET2Pxq1dpDUqqkCtF/wYl0+T/uKVCpUZvK8Al+8xu+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yvfH4zQLQ+BI3FnwlxjOgFeNphjhDMZUMeTQED5QcE=;
 b=AVWV6bh6ZpGyENu7uFjR2LsFoEt3yZpDlWjKB4AgDJSSJG36fk0ak9G6VOMLn4BWrYW9K3LJ+zf6sp25SnE3X5QsbOW/jMOyzM2z4M2eyU6WLzT8VoT0Fsx4qNVWxCpwUxOLLbdgYNo+ylqN/YBtWvFQ32sSLAayZ1hbZ9Ok8wi5NIq7FiXqVT57/X7GBQXJOSkU2Voqq5B487xn8rJNcyqFDeBaqQ7dNjBBpXSEIBrHFHi1Mh4IxmMhnna+egLMm8hCmgyDUG+GrQ3GKR9o06VOwDtqWI187FF4PEAlYmfK4AE9a9h8j+ONsS4Y20WS87qmKc1flQJOUNQ8wOMFfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 14:49:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 14:49:10 +0000
Date:   Tue, 15 Nov 2022 10:49:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 08/17] iommufd: Algorithms for PFN storage
Message-ID: <Y3Om5Wv2rE4fH9y4@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762E5ACAAE7D7B398730D78C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KCvnLOZpGXAGhU@nvidia.com>
 <BN9PR11MB5276E1EFCCDBDFA8D6C58FF78C049@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276E1EFCCDBDFA8D6C58FF78C049@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:256::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d039fb5-51cb-465a-52e6-08dac7188e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnzxflYdm9UGCQVLyp8NXQOVjhsUOJf1Cl2d2QxaRT1/gSuLbJIHT5Ucx2G+cCOnsNFO8611T3r5GbDgR8w1Syv3A1pXYdmGQY91qMFzQaOnMnk5GSv24UL34WeCk33Bl0yTnEV+m77gG56UeASS5B0LMgsayBik/aHkZgbTOT1ogoRNNXnq/guK2uftDblXCg/H6H3XbGtevoSqBxvdSuYIHOKHlvZF2HRzH4N/tSQWkg+eo4x5aG5T+FQf3xlSA4rl0JG/Zz0s13V73+09zoVh8xZEPOTJQZKrzBy53OdntVTFS9O/NkoExmx41+i+RFE9LenB/pkBzB1KA2XX/WboGjiUk0YG0sjEUcaww8v61qNI1txQOoU0G7CJCIqpVCqDSbB+I+XjZiEf0yjX7sNDZOkn5nNGWTxkXT1SMUoPKF7EL1+Fa289ZoMrBlv23rN22t+DxGq0UAVLE8tuXrv5QE6RhC1nFtIwBAhc55GuGLhwsg6OBTL+a8Q6Ma6iDeYB1NjIO5snOmtwhxP2E7T83J/k1ASyW5T2c4uYsniUcBzcTbxdnzooilt9ouEQS8s3qVntmr1eeSHen0xoQNGiDQXMb2Ca1WNJlz2L5cNZk5h3cqh3LcBozp3EFSJjtiLVm26QPs/N8Bwj8XwmSfKJn7xurY0EbZDJdxPzXz2HLRO49S0SNT3TVe4tFphP5L2CtPBNxRKCUycp82r5+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(6486002)(478600001)(54906003)(6916009)(6506007)(4326008)(7416002)(5660300002)(26005)(66556008)(7406005)(66476007)(316002)(66946007)(8676002)(6512007)(186003)(8936002)(41300700001)(36756003)(2616005)(83380400001)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjF3ejNwYTg5ZU1BMkt6TjZaVHhIalFLcUNTY3FOOVVwYmtqbHpqdWxScjgw?=
 =?utf-8?B?K0gyVjQzMCtITldnZ0JoYStxd1liOW45NEpvV0J6d2NDWGVpWWFiUXZocCt0?=
 =?utf-8?B?RnFRL08zcy9hblMwOGlFVCsySmVwOVVtSmtlNVNMOWxpVTFtbGdHU3ptNVpk?=
 =?utf-8?B?b2hPM0x6VWppWEtlRm5ENm85Nk5wNGprUVlTcUFOcE4zVG12bm5VVi8wdllD?=
 =?utf-8?B?eFR1bTNqUFFGcWxqTEl3TEZkVUl1ejRjRnA2cXV3QzBCaC9ZM25udXU2WTlj?=
 =?utf-8?B?Qk5iTTFBbEQ0bkVpRThrNXd0a2xxemM1YkZhSTNFS1ZHcUZ1bHJEWGJPZGpC?=
 =?utf-8?B?bUZwNDJDakxoc2VyU0NzRWljb0tyWXNaTzgyd1lHTDN0YnU3bDNuL2JDT1Vq?=
 =?utf-8?B?VkMzMjZWZE9QNUpXbkQ4d0pSa2dJUUVVY0RNYkozYnlsWWpaSDFRaC85Mk9I?=
 =?utf-8?B?UjFsclp0RDZqQ1JhWDRWRDd2R2JsWEpDdnNMVDYvU0pOMTZEbkxlVUNZMXJV?=
 =?utf-8?B?TlV0VFBwME83YWNxOWVzMWpvTmhvWVlVZ0d3b2k1cTBhd2c4Z2tvSnU2Tjhk?=
 =?utf-8?B?UnpQNU5XQVA3b2VXcU5ERkZIcDhkWVRETkE5QUEvcVVuN0h1NVdhYUxsK2dh?=
 =?utf-8?B?T0dtZkRYdkN1TlVRUVhjNTFwOXhwQ0N2OExVeGFxanR2Y2xBV3pZRkI5NEF0?=
 =?utf-8?B?ZnFoQkpYalF0ZEppaU5IUnJvb1FXQytuZ2ZoSTJ5Y3oxNnlVMjQvRG83bkpH?=
 =?utf-8?B?NVQvNTY0Z01ZVmJEWVE0NEoxeG5nN3l2YmtTd0h5cE4rT3ZYSlFWQ0p0L2d2?=
 =?utf-8?B?Yk9oaUJZZmlZRWp6Wkk4dDlZZ2szOVNrTDFpT3I5WWVrT1lYWnhqQlgxdWVw?=
 =?utf-8?B?UVZqRlVTQWxtV1Ezc1ZLOVV5UTJvc0taaXk4SStvWlErUUhPUjBvVlFoYVVG?=
 =?utf-8?B?S3JVVGwzSEFtR1c3SGpJUmVsWmFBeHdNSFJOMDVlTURyWDRxanMwVEZqbXN5?=
 =?utf-8?B?ZkE0aVYrdytJOUxxTkd4MTdiOGRVWkM2N0JiNGpyOXphWTlMTTRrcXpwK1R0?=
 =?utf-8?B?dHFXZkduOUcyeW9OZDMydU9WUXVoQ1FOaDFJeGIyODhYWitOUHcwdit0eXNo?=
 =?utf-8?B?TnIrMCtqL0V0b1lKQkV5THFGZ1RKVkJ6bzZ5cVVSNnRaMTdFM01lcWVVTEtr?=
 =?utf-8?B?eFIwMU5URkQzNzhwQkdoblBPeWZzYkZBYzl4YVZNVEw1SjBLVmwzaFM3Wi9h?=
 =?utf-8?B?azgrQWFtcmF2WnpTTjRBNU1TMjdhZDVLeUFzRnUzdEJ3R3ErL1hwbm9JQkRa?=
 =?utf-8?B?Nm9jOUg2ejZYbno2MHVZZnhPVjJuU2NEemNkdzJHZlUveWVnd1h6UDZYclcr?=
 =?utf-8?B?clk1SHc2K1FHUVZ2ZERvOEdzcHVVc2VpWEpUV2taeERBQ1pZRDk2VStDNGFx?=
 =?utf-8?B?TXB5TnloNXhZd1FaNEFqTjZ3a0pZY0RHSVFnYWV2M3FOSFpRcU9GUnRsZlMy?=
 =?utf-8?B?bS92UDJEaFd5L0xJVElwaXREUDMrMWJvalBhdVQvd0h3VVFBRWF6Zks3VW5a?=
 =?utf-8?B?eXVwTHROOU1xcVFlV292Q2ZkcDBBNC9NTmVWRStKS3hyS1J3WjhtZXYrL3Zx?=
 =?utf-8?B?OW9NTUtBUFNUamxreVJwczhOVXhlOUhxZTc5OHZaRGw2VUZ4bEt3Y1NhdU1p?=
 =?utf-8?B?d1RxMFBMdGNzQjRoWVdxSjJxcDJ3NXUrdTVmTjBwWFpFMjJQbWFIWXg5QnVl?=
 =?utf-8?B?RUxiVUZTMkFWZmhZK1BmU0RHVk1rOE83Ri84QUhGMW9HSHNBMjgybHVERU1M?=
 =?utf-8?B?dTNTcXJ4LzJuQnQwZjNaQi9TSkl4ZnlabnMvcFN4SmpCa3h4UzFzelFhLy83?=
 =?utf-8?B?bDJ4OGMwVDlSSEJKRlp6ZHZKOFoyQWhQMHRVVEVxU0FkK29EOVFKd0h1L0J0?=
 =?utf-8?B?U3A2a2Y2SnB1ejVZRWhJcjFlTkR6T3E5eE1oWnVNT3FjTjIzVnYrRDlDSitG?=
 =?utf-8?B?T0FsTGRvQlB3U0FmSXZIZ20rdFlkZldNanRXWWNCaEpNTEVDelFucTkxdGZ0?=
 =?utf-8?B?T2RkaVpCaXpyeXlZalJ3N3lNUjNLR1RLZ3VrcHUvZkRrdEZaZjRVWmlrQ09M?=
 =?utf-8?Q?5Ubs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d039fb5-51cb-465a-52e6-08dac7188e17
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 14:49:10.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzjbWCnghH+s561FdWy6OnhsmnvfDNmB1Cyp+w2cupUzMYInTAaf6F0y1f15TruF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022 at 03:06:57AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 15, 2022 2:03 AM
> > -		mutex_lock(&area->pages->mutex);
> > -		rc = iopt_pages_add_access(area->pages, index, last_index,
> > -					   out_pages, flags);
> > -		if (rc) {
> > -			mutex_unlock(&area->pages->mutex);
> > +		rc = iopt_pages_add_access(area, index, last_index,
> > out_pages,
> > +					   flags);
> > +		if (rc)
> 
> iopt_area_add_access(), which I suppose you have already fixed when
> compiling this change. but just in case... 😊
> 
> > @@ -1819,40 +1838,49 @@ iopt_pages_get_exact_access(struct iopt_pages
> > *pages, unsigned long index,
> >   *
> >   * This should be undone through a matching call to
> > iopt_pages_remove_access()
> 
> iopt_area_remove_access()
> 
> > @@ -1865,11 +1893,11 @@ int iopt_pages_add_access(struct iopt_pages
> > *pages, unsigned long start_index,
> >   * Undo iopt_pages_add_access() and unpin the pages if necessary. The
> 
> iopt_area_add_access()
> 
> with above,

Yep, I got those

Thanks,
Jason
