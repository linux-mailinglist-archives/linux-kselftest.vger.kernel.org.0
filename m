Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEF7A95D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIUQ40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIUQ40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87C102;
        Thu, 21 Sep 2023 09:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfoE8m3IE1Nkw2yVOucuzls6lHYkUY3vxPu6v5s5D+Tgfq8k4aAjwtC8+EN4IK0mg+AIN1QwHCmMU9qGsPra8jfHkI1O+9xizMmLRWvVhj+XDesEDtosJJCl7QLwbLaMJKWVanS1lOyeiAzMyC9PvfB55q/Tk2Pgd89o80BUu9LpKAVGa/Ty3wf4/s6Q3zb2s0vSgLdv210i5UWqcxJFDnib3HsqY/Aaa7xvsi/evEiDcmgk6f/LlMK1Vg72At+gvFkv7o2QJmRP84Hc3oxxezmi/7l21SOohfl1Bw8AfjGs+YgRWAP7Ffed03uZXp6UnstaBn6muoEuo6xlJ9Rs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDUWmeI9gjUEfXbQ2yzBCsBxZlThdepoMx/N8AX6QII=;
 b=adWPBo10uV4T9ldA71EFQ4K+H5JWtlD+Z5Kxm5zkyXxyzzdazke2uIzEp/9QBKFrLybTsSjpKCPDxaPHAJhe7MXQUu77C+IcPBOtF0ghhH/zyNsllLBIpS996Ksla+/7MXPSZJE9lNDCz9vKBx2CsXF3BV2Xi47YX9mMwxkzw7yFH5dFTTBnmOnFf7W6DsrnHveIeHNXbYOVtTXGGEDKhA2tfVhmTadeBEXajP3vG2tGuR8Wi5VPiOBDP4MvvBmBlTRUFzZlGE/efD1bJkS+AfyTE3NN+uTSRWWMF1f3Hav4cvRy8hXjZqkiVgf8+GL0kDHmZVWI3N57Ixpr+AbDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDUWmeI9gjUEfXbQ2yzBCsBxZlThdepoMx/N8AX6QII=;
 b=YJMtBW6ZHEs8maKZfMne8MSUq7DOK2/3MRhMQGIIWN2CpSy1GTG/13kNKugnegoKTDSbWM466WF06hbViSBLOtAMCGBo60F0prPN95hTfT9HmTI4Z6IRIl+JbUkUZ7d8Qju1nhtdeB4brijcGcouHhsvBx5PHgI8W7s1Y6OeR5/NuUziLL1W97wzVP9tJGuJILe3R9mY+9+XEECYgJmkaZbG5mQFGuOuPo9yaKg+UUfHJYopMROI90o+sW/X8scpITBtyaVYiI0gyZ0+cG31hPtyiMnNhZLKco1A442mMY4HctL5KtkJDe2wWOh3fykae6lNZnyXuvnXjdyQbYy6hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 16:44:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 16:44:50 +0000
Date:   Thu, 21 Sep 2023 13:44:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20230921164447.GQ13733@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0018.prod.exchangelabs.com (2603:10b6:a02:80::31)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 250479ac-4ca1-42d5-8b63-08dbbac212bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/mL70pJizYk8Qf6BCkWrhs++hsxsxN2fonag6wosGudHXMlPUrZyZYKk2IK/MdtuMmfUhOHaZvyyfr1YjJGvQ2TrRyEj+jt56s+s28qIlBgxVEruVOaBQyMdNI33s3ebKOEfih9wM5b00P6DVzlVWzcXq8rSctLl9J1yO/275N1pT1CQttcGd9gUbnjp87zSY+E1C04HWTvisLx2xIW59QmzgtOes6MiHMM4RualmCLGTS+d2xfMs133cfTv39Fk7USOH9Tz7x7xwE3wDv/hi/fYhGkAWUmu+vvxo6kQb5QMHf6lc5zcxWPzz3CpANUnvSDlUE0nwnVnUoJ27igaLY3rihVLVvC53sbF4sCoJE33mRnhMnTW0ynOj54NdHrTqmGg0FVuIsBxVqskuZXmMfL57RMofiw+hNnl75UUv4rI9iOhTvIQ6hMhxLiOWJzOPqM0NAIF9AkJhIiCHLLN1J/YHg+rK7aY4EEPyPgW9yzas1+FCCyPvgSZBEerxA1f5YLpr2IxNCXyTnWDWIxbSzT1gnuTjFqno5gqYsqbNIDFZ9qFryBxp7J6XzqA6gF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199024)(186009)(1800799009)(6666004)(53546011)(26005)(6486002)(6512007)(4326008)(1076003)(2616005)(7416002)(2906002)(4744005)(66946007)(66556008)(8676002)(66476007)(5660300002)(6916009)(8936002)(316002)(41300700001)(33656002)(86362001)(478600001)(36756003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzHJmDOEMyrwqJOXPnv0ojedd7N0bhyC5LHiRjcVks5mPmnS4dT/XtdLVknB?=
 =?us-ascii?Q?VrXBl1JlqJi5wCG5LdUJ7oeEe2bW5jZPKofaekNpwE1b+Smj9nASH4xeY9vi?=
 =?us-ascii?Q?zI15g7FVqGS5B3E3dpcyMKxkwOmz3YgMt8wWFtblJwrRmGISzcy3bfvgjyPR?=
 =?us-ascii?Q?IBDwANEbwHMIyEXWsREudBBqIYfOo3NRmr+e9ZWMj2li7zayW8WbcwZvM0a6?=
 =?us-ascii?Q?STld50oUKRrqzxTw6fWM4w0bj7DYS9heFrKwOGgQGNtShNXLsDXW1A0fiRqc?=
 =?us-ascii?Q?SyTM3cfY6OOYyE503Ccl8xWVuae1siGwGoBMXwWbaH6UL6OumFb/H3ApFgu1?=
 =?us-ascii?Q?77qiUWQbIsOqw7ntMTe9ehYAx0kykHfHgPc8CxNsxDP+MYOGqewNoXChSQcN?=
 =?us-ascii?Q?ZHH5FFio1lG/Q7X1aOrQEp5LmPg1p/VDDfFNe3j5FkPpUSzxw7Gikdn+7Bnv?=
 =?us-ascii?Q?vVgjyDyDi3t9oOW/8Jq+VEpHeZdrnQR2DGqAF8+YUf6epAFCtYpohniFFnum?=
 =?us-ascii?Q?rFSysKBz1GE6RyMUKt9bJ6zS32OvWF7DrWcIByvCzzqByyzQPzKzfIuyju7O?=
 =?us-ascii?Q?eMYVY4ZiIaTe7/bXQbek8XPAn2rhMI+59BnXvevoApoRA0f5hP42SUe7Znd9?=
 =?us-ascii?Q?GpXwisDNGIAViWWxoUlqtEdHR/CsX7aK1Yz/Tt3NneOpAL9sm1FxRGTTw4yY?=
 =?us-ascii?Q?SDUxnKOwftRXNb/LHYbsMx2//FxYf2DuR+JBDCDwxj7Ccr6H+S5Rhxm/niSc?=
 =?us-ascii?Q?YEWwBFEKw5ydUhh0JlecNGCYQ1m53bmpKFPuhKQenPWFais5hfoqqptScJwO?=
 =?us-ascii?Q?THJK3chCFFN1+yKbKJ8OhC3ZzF27qYhWjhQiRK3vO0z1vGbVoJbWhSthkaom?=
 =?us-ascii?Q?4d+sBGpcB7h/Rt3D4o+M1GczfKui9W+EzMl9A/aTeHSrhgRgYe2KLzOeUfnY?=
 =?us-ascii?Q?lawYcxXE1BteBjxc+ibzID4SVcom3CXVpEnmGVkH9Fs4+5t24a94XFboaHZy?=
 =?us-ascii?Q?M1rWFBSniv3zx5rt0+uq8/kqidHpdxPqOuqSw7ie64QCzabodCVROv+QZWq0?=
 =?us-ascii?Q?ew2sVphoGqbk+hPGqDYtZ3rMDq8nLqwZynn8ueRvNB+ar4PdrO+1ix/QC0Z9?=
 =?us-ascii?Q?0kkQ2mp1Twt0EGGEeegK8NIRgs79yvYOowNYwEnto9MaRjPhZT2mO0N2+Agm?=
 =?us-ascii?Q?pE9HkNL4ZUdES1X0k12nfsC3rEzu9EOWLoTze/H8hR9iF9a9zwK7jAwvoqiV?=
 =?us-ascii?Q?5PImkBXJ9DSL38duZdmLFavEjB0x15VWdEd0+74aVLnirLGK6gf96loSBsHF?=
 =?us-ascii?Q?DgrQZNKgRG+qWVqIjg5iKaxlmEqMGGisEK6CU3a744wqNMXME+X+8Xi3yudu?=
 =?us-ascii?Q?1/viMRmOyAZklY5aktvLC8RCWalXp/3C8gnKZDOKAylWkoDahv/TIgUiO11H?=
 =?us-ascii?Q?YWQqpu5omKYb4J1rJnWy5V11cl6v4yhIvxnsPdvS9/kXjGwRUNxoSVDjcO7j?=
 =?us-ascii?Q?sx8Vh6zvDTUa7AXl8zqglH/lK04DhyFludzWDKywA/oTuFwXPby8cK614123?=
 =?us-ascii?Q?oUckI8c8T35psDqiLWCyrLUpF2EeQkSF4B9fbMjW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250479ac-4ca1-42d5-8b63-08dbbac212bf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 16:44:50.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpA8V5sFHJBBnjK23WLo50G7XeczJiV7cbYBTFIHMo/GoG891AmAF70AWUvaJhwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 08:12:03PM +0800, Baolu Lu wrote:
> On 2023/9/21 15:51, Yi Liu wrote:
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > index 4a7c5c8fdbb4..3c8660fe9bb1 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
> >   	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
> >   };
> > +/**
> > + * enum iommu_hwpt_type - IOMMU HWPT Type
> > + * @IOMMU_HWPT_TYPE_DEFAULT: default
> 
> How about s/default/vendor agnostic/ ?

Please don't use the word vendor :)

IOMMU_HWPT_TYPE_GENERIC perhaps if we don't like default

Jason
