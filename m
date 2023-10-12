Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B17C6F69
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjJLNjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbjJLNjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 09:39:22 -0400
Received: from outbound.mail.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF9E94;
        Thu, 12 Oct 2023 06:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJGNG0Z2C/dROPnl+/1XsvpILs/wqrPJxg11VZNRJ/rQFC2+FX8dCLuktfih6ZkkbTa5vGQw37/IrDaD59/VOsQ5uAff3PDATjIhgO228XOT6GfPnjfsOzNhuTmFocK/P1c5QlVy0adlETcn9hrAfYEnQr8THvgxO4bwFJSm9Bl8SPjpPvkLJ77utsw/ToPPxnoJ2zTM7OtTwzc8ljYO+HVRd/67/a9NxUEjk5+dcXz2WKPc1lUhzvmRtZFR1Jt/+fhB6dSiEmwsc5oyVGUND0e0oql4p9jjmBdV+Z56lx6grXsMJqVX3nw0wM06eqFNIln7iLU5kkL+jENwrklTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy5YOf8lJUN0IEJ51ierl49vR4Gn1KeZ2JAVAZwU53E=;
 b=gk7rODOXfDMtExpwnlenyJO+EaB/YTBhgzotk+DxJziTC9V4dp+p2EjWalpRzeGcpHUq3rv8H0bWWxNjswwxP+6INoIK0nclfdwpJuIWUeKeCUM+je/I6AEuTJPDqa4OSssSMfsU5MYWlL2arLpeeD70bZdZVcgFHPtPMpDt9XPCcbqQRta6SQt7ZK3AQAQjSTmZBwm4+SWc6qw+pXKbUOlqSsMf7qE0Tlh0YtYGWnKpu0wdZk8EXckrTMssDKcb3lECqIPtxUHRLvmIR5KRh323RD5b9fBaUG5sWo+YPciF5w3kvaB2c0phGzka+RlY68jwNmH2OIVhukgL33c6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy5YOf8lJUN0IEJ51ierl49vR4Gn1KeZ2JAVAZwU53E=;
 b=YPpkNhQrD52KbdbaUMaN+nwYA9pSTlhPSqjL7TeyUsrmbgGasyEtf8imw/ieALbtp2eRes6nRYOh5maaoMao+WJ/wr0EbDZsqm6R0Hdwo/ovGxydmdfWckoncM0deAp1n+k2Zq82ZqYyLCQrk38+yyKBEQLfPmQARzGAdE8YZtt1fUj7jF1jLQJFRG1Xc9W7ctIDKYspsda78kemiGtN61xgA1XjxLBBHsUV20Og+Z+/n/e1PKt9FG7OYunUQthO0c3VeUuAlQm64g/Q/aWJaEN8CtTcWhJMbBrkydl6UzkiUHBIGW+KMfy5owv27Vd2MfyduZg547ijVs7scfjMrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:39:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 13:39:18 +0000
Date:   Thu, 12 Oct 2023 10:39:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20231012133917.GL3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
X-ClientProxiedBy: MN2PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:160::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 043936a1-5a07-49e0-7bc0-08dbcb28a272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbHhKe4IP0MDNYJ5a36IP+dnhgt9GciytGyAMn/KHFOESNw/BJIq8Q8Dr8WXQXyrWKDEIaRnvkk5D7FN41sq11NPkPILxDmcV6XwFNdtbktsq8uFIBBIQOrCnluL9AwEz50qQ04+iCljSveTpjny4UjTNhkfZc2wZlh9oysOktzYMIQwsiIwd/ed1CT2d/3UySdciz0BUF2xmT9mkGfu4/L4NG1Vspou1R0flTGQ61RJXtlrHXOxkwGRcSIaCkUjT5Kvy6sJNcQq9Jwia4J9qiy2a1jCkOFqFkYGXU34iKJFgbW3zBjzSXi4f53lWYwAwP8h9CGr6Ot6i2HM3ZBuHx/NOd/nb6MHVoBdVyepOD8JqRk3VqtZYCWkrQuk7aTAjmiqMxQWPxwGcY58GfKGiYF/KKbm1ZeSaYshwFFqF87Q/HzzMuU85sVzyQUqwBv7EdgS98O/3VDLJ8FwZEyGl7nVLaI3CCI3Y/zm3IDWIJrXKwhB967A4emrIHo+Nku0536/XLRVFgSPBE5N8yfG0K0TRaWyizfOfayodZSxCkRC1DYvJEQVbO3qEzPwb6Yf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(1076003)(107886003)(26005)(8676002)(8936002)(7416002)(38100700002)(33656002)(2906002)(86362001)(36756003)(5660300002)(83380400001)(41300700001)(6512007)(53546011)(6506007)(6486002)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vyv/h9sNHIQyS2S3NK/ISgKwW3m1QdOfnyMZCknf2pccvUAQxz2nzNbzF30?=
 =?us-ascii?Q?ke/pSacoEIMkp3FcCCQcUSEnWEtRLW4jNhqUPdj/VhmhQo51gECBhGwo1EvC?=
 =?us-ascii?Q?GXSpT3FkSq5+64RNnMrNQefkULcrFgU9TtJEvUgr9vbXwEy/MZ/MaVWOy+4i?=
 =?us-ascii?Q?YFBNdpvX/7A+bVLA1hr7ne4Snx0GWuDUM5pDupzTdR+MzEOhCAJ43iYjDIQn?=
 =?us-ascii?Q?MBMry5NyEmTReD0RzNBR18fsVwnlDzDwQsOAy7jUYQKesVWPjm8mdvGVeNvB?=
 =?us-ascii?Q?o7Vns95sm7ePr+oX7ApxBk2T/Oq/Dal52lmadU8J7n/vuxAJhQVX4j8bzZ17?=
 =?us-ascii?Q?aULi41KvCSW7fNaehajpdnkZoyIC6yY4wLr3f7X1LQ+qNcAkmC0W8/thxF0W?=
 =?us-ascii?Q?aPf38v9amyi2kaPqZ69EfbplZLSkyAJrTz1gKX9D2fgzPQQDJ6tGsTBAVPUl?=
 =?us-ascii?Q?QbeOWwdAx/ri8E2i3k7BEY54xu4ZSvypRCDWCi4sMsEYWSsk5JRoKwQxM0xS?=
 =?us-ascii?Q?9m8484PVECHPKyeK7uRQxR8aRIoM+PWOYl4w6YfQHKXFR6idxlIxqyIOnJt0?=
 =?us-ascii?Q?h6s/qKezj4pruDWuTGcEXkXQdWAvO865/zpNCX/dNDoe3h/R2o1JMr7a4h0z?=
 =?us-ascii?Q?X4jSxQAPnX3bpCjjfufFXPqSQXtE3LTrgufmew3lIgMCDUYd+SLc6OaDdy89?=
 =?us-ascii?Q?qMscu3XRwudE8VAszsiyZaLRQTZlj/zKgg3JTuvPnxyvkyE6AweuaaZ0+7Ly?=
 =?us-ascii?Q?PWlHLQAX/8t2WLAPc1xjYWxvNTi+D2tgiFAIgwtEmqpz1u9Bzk0Zdm152w1l?=
 =?us-ascii?Q?c94byaKlnjUhP+fTMwF3i7AwDYfBaowg4cQxa7dIjXqS3LwS88B/YUeVlARs?=
 =?us-ascii?Q?RxrxXL5cY7RYOKGyjcHbqXcwQUgvL+jMcb//AE/LpkBWFCrok0qFcnEoZUUr?=
 =?us-ascii?Q?pqURYtx6ZlJz+5vwIpQCbmauUIbZt4Za3PA7A4tlMcbMiAejLOeqbYad3Qdl?=
 =?us-ascii?Q?nGtwrpAl7LjJYM38jez9c+Rm/hXNfg0c67ZAyWEjb18z/jFiCQIjwaMErqF2?=
 =?us-ascii?Q?9r63MLhxdqcbvYOJM3lZvmYJGFyT6noz9pxRCqrN+bMB27i2d5NdVZipLKjR?=
 =?us-ascii?Q?+niFeGQ1MRy+XMi6f50uXWKPOX2OAKG1remAAPCPkN5zXCaqC1tP4KHcS7HL?=
 =?us-ascii?Q?sEkVYrUc9zpRLCZPilKQPFy8rFuSjRyUdIsbGfKEwyxc0DJDUh2RYXoAgE0E?=
 =?us-ascii?Q?RypBjDTC/4mWoBjYKVTHQokaeXXQIZ/x/fEhCgLT7kSBOqFXngS7XN6lsvNZ?=
 =?us-ascii?Q?+dnY9I7ZhgeN1dqY2oWcN3FSKHuM+48kF67Q90zOMBebAGnZd4zscoQo90g4?=
 =?us-ascii?Q?c3DLWk6/PpiRgIEGkg5zGET4Bc+f2pWDx8t3OmUXs+ZT52+vbmaume1o18mz?=
 =?us-ascii?Q?OK/RlZh0sj2kpVWMdwe9jc4zzPcX1q7cCaFWfGOlI42BkSkaGSq5nvc5ilPe?=
 =?us-ascii?Q?0gEG+DAfJ4J5A6lGNInBFiU68bsTF79g46aT3LBOyHsCZ4T1xQZPIKP/6Xct?=
 =?us-ascii?Q?mjraTzXNDo6D7+YoZP94lkK2nhm13noBTI5T3Js5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043936a1-5a07-49e0-7bc0-08dbcb28a272
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:39:18.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76gHhmHY0MSqu+pGj8uk02Nx+PFrGBXzAiWUNFyFFdQCin+79IOBmCjF0HkG7/SR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 12, 2023 at 05:11:09PM +0800, Yi Liu wrote:
> On 2023/10/11 00:58, Jason Gunthorpe wrote:
> > On Thu, Sep 21, 2023 at 12:51:22AM -0700, Yi Liu wrote:
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 660dc1931dc9..12e12e5563e6 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -14,6 +14,7 @@
> > >   #include <linux/err.h>
> > >   #include <linux/of.h>
> > >   #include <uapi/linux/iommu.h>
> > > +#include <uapi/linux/iommufd.h>
> > 
> > Oh we should definately avoid doing that!
> > Maybe this is a good moment to start a new header file exclusively for
> > iommu drivers and core subsystem to include?
> > 
> >   include/linux/iommu-driver.h
> > 
> > ?
> > 
> > Put iommu_copy_user_data() and  struct iommu_user_data in there
> > 
> > Avoid this include in this file.
> 
> sure. btw. seems all the user of this API and structure are in the
> drivers/iommu directory. can we just putting them in
> drivers/iommu/iommu-priv.h?

iommu-priv.h should be private to the core iommu code, and we sort of
extended it to iommufd as well.

iommu-driver.h would be "private" to the core and all the drivers
only.

As include ../.. is often frown on at large scale it is probably
better to be in include/linux

> Just one concern. There are other paths (like cache_invalidate of
> this series and Nic's set_dev_data) uses this struct as well. I'm
> a bit worrying if it is good to put type here as type is meaningful
> for the domain_alloc_user path.

There is always a type though? I haven't got that far in the series
yet to see..

Jason
