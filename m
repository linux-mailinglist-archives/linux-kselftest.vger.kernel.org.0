Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564E8704E30
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjEPMyi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 08:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjEPMyf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 08:54:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B7527B;
        Tue, 16 May 2023 05:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRqfT5slah8b/N3QzDJX3dp36mSW0n8RS9A1/7i24GOSoR8DpDj2WeXAs0q4LZAp/leZ5hilMkLcWGV4sdGrJp4aT53gt83e6NhOqGhSHk6/o6YqemJ4TvV4Iwd6bFwgETQFZThFKsTLFicWrY5R+Qjox18bMBKPXGmgWmHKL3q/uZirh+5YqDGJ4AVFAhS81lfnhqhUOFGQL5nd02zeG1NgW7Ak5VdKOMaeTz1JutQhvYUWZVNDF39s/7Yc1bnXaRb+VHlQSaOfgvydEArP/OMMbtbaSmN90QdB3hxf8UkKieqgfSZH++BrVYMWSQCENjhd4tTGfz/3w/ZqjzWVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUg0YxL07CR9ite2+CkYkl7X3I9ChsDhPcMxuFVHJLI=;
 b=kII1JqERnseccREzsesMFBJfW4K43TkEGOErGAX96KV+GXO3CLyUotS/+J1kOY7pFFM0ELO30pb0vSCUaVssulVIP6CLY0+6qdbOOOVApx/RjxYGis04W9TbBdFhVXtsogylBrsrfnPYXk2k9cImsu1kXFLpp6B0R5Kh+HuUkMew4HziVh65kIwqW2tKwYvL85G+B6l/AWKYBg8zIYydv1Qo4xVsmErzGIGMXDOpNM3KygHfOe62pY82JjqDDRJK+PgOHz/rLysLIjgq243JXFnrpjffZeZo7cDmzzLk8VB6j0kxy+jp9vlZ5Or6munYUHAHCWv8+jEkiYr0OM1SXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUg0YxL07CR9ite2+CkYkl7X3I9ChsDhPcMxuFVHJLI=;
 b=IpGFhq4eFTKZeSvt3rwD3IOvHiVk6HH5ge0S9K84TeJCXzRbIhwzh8a59e6jXYxqA7tqWcvIn6kG/xoUBB8b5iEZJWO3Dvard3N6ts/yL39dfdjHcXqmwbFc7s6bIbUU6y5ra4fXBeU1OFGsvByWyGGoLkT6JPlllIOj0e/wqTi38qelUZ+gPworkzGfQFgee55o18t5UhJe3yN6XTMDsk3tyK7dZKHjjkFgVHFF1k4qb52v8lErAFdrz61lVnPFaLalJb29sc6wOnyifvkP205utWDDv/eHZlABhj5tk0d0XAjdTC95UYkQ+s7PQvEr1EkYDVkVggxi3vIiDdHj0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 12:54:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:54:21 +0000
Date:   Tue, 16 May 2023 09:54:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 02/19] iommufd: Add iommufd_group
Message-ID: <ZGN8/K2qg4zsaeYQ@nvidia.com>
References: <2-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <89d800bf-87cf-6a7d-85b3-74bd457b1454@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d800bf-87cf-6a7d-85b3-74bd457b1454@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6bd522-07e7-47b9-557c-08db560cab23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNjsxtSrCw3VDWilNOwHgNii7A1teXWNeiXok6DZiGOSDuGZrxybb2RjlFPIkk5//IXYBFlz+azBOMq8g9EiRDM7b8ohM1va24F9qsWaWVtffivLzqh/eeatRsvrnpMrgV9HNM+csFDwpvUv6uX92+SsSauaDr6A1e+pwJ0hXp/YAn8c1Nly4eJ715KSzSd8pqkDFlVSTqSPopQ2RV2eFTC+yuOhPjAnP5mQusttAivj6K5dGdIGMe/0eUMTB89M9GJ3nsgb0GC06pfitH5seluJGKimFRaX/n9UXrixchdqZGc5vmKr6Mv73Ws8jYABQUAOmXR3HjCWG2oSI09GeUfGB3X4C0L241iZQqDrqxtGsHaY+DHEGqMP8yD5AMcbhlPQ8oTIQPGhtpfFxd7X0C1DeGYPRBNS091xo2sBcWImbeCC2L+gZ+VE7sv619dZWSaR+KRlXx67ivNYvatk8fFO+izr8HydUq93AOk4bM4BH1Zd0yP3WAJD/f8Zv5GtRLRzwxEG1TXxjPyFU/EWneyu+MI5DQdNRgWrv24loArdQ/xhiLIS83hF0UsJUXSy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(6916009)(4326008)(316002)(41300700001)(38100700002)(36756003)(66556008)(6506007)(478600001)(6486002)(66946007)(2616005)(66476007)(8676002)(86362001)(6512007)(26005)(53546011)(8936002)(5660300002)(2906002)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gz/Fl1ernAC6crBjwAjm3DgX7Wtw7BC0sCiLz9gErI2UZL421z3sKHDluJVa?=
 =?us-ascii?Q?pPTv+QV5ohe3ndLMoF/20lGU3fbO21yNwWMl1iIp18k6dfntDhCAkO0wf0Mg?=
 =?us-ascii?Q?bDOZXMV+bZ66n84mwph5kKLV7ZrSZ8ZkGk7lha0OBJ8Ln8NJMKimR0V7M4R5?=
 =?us-ascii?Q?hiX28MXGHse0KVzJXpqqVzoEOnM1IJvf9wFexvsRSfOhzwWcYHkgQUx8L6sV?=
 =?us-ascii?Q?7hpJSnt6BmgIQcGL0GJXZQA7XajSCnBW/F7MXNyrfrBiX6Um7l3xxOTo2k4r?=
 =?us-ascii?Q?2vE+Tvv6TTdpbj4oIWgp3t9/h/k3xPNlu+RlbYNwl7A1pIvAdw42VWrE0oc+?=
 =?us-ascii?Q?3RuVqF0ZnuhEAlnX+zTxk2LqP5D4y0l1wFF9IHL3nT0eu7bOY7P3W/2rnCVy?=
 =?us-ascii?Q?RCMkhB6vR7Itc4vrOSUq9C7dG5D6DNmvkg3f8b6IPrFnBbjX00GHVAQ1ihgb?=
 =?us-ascii?Q?/vfLOKU54+c9QLmbv9HpNLKfPIneegTwbBZYh/mD6o9M79PjTeN3hS+ScOgq?=
 =?us-ascii?Q?JbuIhvHE/tVlrnz8VqdcWm/mwPD29jyb7/GQg1++JU+eQZP/HTbZJck1fLuE?=
 =?us-ascii?Q?9huCSTxzLm4en4v+SVChrN7TUwgUOnE1DTGkHx1teXfYsK5180L2Kz9COjnY?=
 =?us-ascii?Q?mAultotBwHQLaUhdmwSnHVgxEOg2yOQ/8OgdMK+kWdHF0bariyWiRsdf675b?=
 =?us-ascii?Q?/bnDlP7vJVVMftTxGc54Y9lImUar8qU2UHd3JhBWh/mqcmFmMUUSkEPBOOlY?=
 =?us-ascii?Q?PA7xWwzJB34FDGBuVrnW/a1yx5W7VgbhY4QXt2xuudoVHnXQRkVYHXDMQyjf?=
 =?us-ascii?Q?rt5lw1JQ7G4JXMYN3N5ydpXhAl+9qKvag63AaPAOVOGrGuYuQFwHMZeDaGn5?=
 =?us-ascii?Q?oeJdJGWONqAuxSBLPk/aTt0TDlH0w2gSKyVXdaG3TLSsWYr809qhaOFbNzQY?=
 =?us-ascii?Q?04sqAQu/6VasHGSPmL5bhWygbNG9U/AGuIkbw8aDoSn/g1nz/Yo30EN9kPPF?=
 =?us-ascii?Q?zlVWIoygsq/DdmypxlRu21BkaBflZjZEj4nNm7gvMFC/IwID4XiAYKVooHSH?=
 =?us-ascii?Q?D7lSUMHxGX53eyzWoiBiNgNMbxqPIb0OZj5JtohrTL1jxkmiIa9KPdKXfgbB?=
 =?us-ascii?Q?oyMmkFK905EhBamYzI/Qao+8VlXW4EYseEwbe2NQjwO/8/014Fp1OzVcu4RT?=
 =?us-ascii?Q?0q9TLmxIYQwXWd3X73IRMqeAZ0Gg+SVHow+t8vdgEwHSnHKkNZJfomdxccd3?=
 =?us-ascii?Q?sOJ1sjAXlXBBwLbZi9L/ONWG+0kpPQ+G4e98MaobLjZkOuZmN26iIZluIWhf?=
 =?us-ascii?Q?d4CsmBoBDwVvjGffmobgcDtb3MHCJTUwZzwb9mvXiJceHMP+OnbKfsk5LUAv?=
 =?us-ascii?Q?upkI2bVgeKuEk572M7NLdCf7kk0AKglfPyMea/zJFgBfjDvJsf0yUm6SLsF6?=
 =?us-ascii?Q?vGhlURA2AGmcpyZgPv/8kCGDvzCLfJ1ZdAgGkyDIyVIaikwqL0oertPvqAUx?=
 =?us-ascii?Q?bvismyZo8dRUp0IKS+PSat9U5jriEhC7xfJv2k3C2gjLrn6FnNgeURwZCGqF?=
 =?us-ascii?Q?owBfhnfRJ0b4kvP+P2vBQTVEZsdM8IKGf3WL4HZx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6bd522-07e7-47b9-557c-08db560cab23
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 12:54:21.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEcE/1ZglaNILLrDNR+uqDppjNP04SYsfIi2RTE0geEX7fB+Wf1SfMY448rpbGnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 10:43:23AM +0800, Baolu Lu wrote:
> On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
> >   void iommufd_device_destroy(struct iommufd_object *obj)
> >   {
> >   	struct iommufd_device *idev =
> >   		container_of(obj, struct iommufd_device, obj);
> >   	iommu_device_release_dma_owner(idev->dev);
> > -	iommu_group_put(idev->group);
> > +	iommufd_put_group(idev->igroup);
> >   	if (!iommufd_selftest_is_mock_dev(idev->dev))
> >   		iommufd_ctx_put(idev->ictx);
> >   }
> > @@ -46,7 +154,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> >   					   struct device *dev, u32 *id)
> >   {
> >   	struct iommufd_device *idev;
> > -	struct iommu_group *group;
> > +	struct iommufd_group *igroup;
> >   	int rc;
> >   	/*
> > @@ -56,9 +164,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> >   	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> >   		return ERR_PTR(-EINVAL);
> > -	group = iommu_group_get(dev);
> > -	if (!group)
> > -		return ERR_PTR(-ENODEV);
> > +	igroup = iommufd_get_group(ictx, dev);
> > +	if (IS_ERR(igroup))
> > +		return ERR_CAST(igroup);
> >   	/*
> >   	 * For historical compat with VFIO the insecure interrupt path is
> 
> Hi Jason,
> 
> Perhaps I am asking a silly question. The iommufd_group is get in
> iommufd_device_bind(), but put in iommufd_device_destroy(). Why not put
> it in iommufd_device_unbind()?

It basically is like that, iommufd_device_destroy() is a helper that
is only called by iommufd_device_unbind() through the usual
destruction mechanism.

Jason
