Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE17C8766
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMOFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjJMOFC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 10:05:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974CBE;
        Fri, 13 Oct 2023 07:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYUB2rIBkMKHztucV3SC56/3x0LrxIr6kBZYA4W1GC7IKaqFgk9/t21Z2TD5SZtTnqj0AAXIP8jkBxIJdU0CdxATAtyc8JgzPtnC4THAdN/jbV/ACnrLpvjezlcEgpj0bDGR53jZ4t6nJ9we+XGT2263yL6fvABi5iqaS3JyPC9XsMO+U2Twn4DJMv5srWE8s7zRgJKPyK4JKFQpKFnClfq0jVxULepuJEQENzEyk7lh7Xl7Y7NlDEQA6tSjArhpyrabltHz/N4TsYTNj7Ak2Oz+P/Y+Ec4sdPEF5dzZgsdhNhC52kmPol/6k23urX757Q092spg0OOb2A3ICdj8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed7tn+ROQRK25AbeZJCB3N/jF8bRNi88/xZTk7b77K0=;
 b=MjEEnAKyAHAMs6IPxZspgMpfZGcfMobdpXGVQCjrEgIo6UPJVQSkhWu73fneQLFk89tSM8g8STq1buV6Ar8qJiL5Mva3uYWIz3iZlKKg08cvcO8pzpiS4FHo8MMoxF6C6gNPJMfglhK/CEX1J9bdvSOCjAcJ0vITfnD2u3swvIRvjDrZbk9F8soRMPFb4nO6OdoS0t5xQEm3gdYi2qR6YyFqXuJ2yuApuBA/ld4UouWuBC2Q791TmthNLtLCglRO4OHfH/JFzMFRlE3E1ownFCOXhg6xoz4FARDeiKSa1ExIYKIbpDZhq1Pl596d95EigjSIS8S+4B8h5ulBrclamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed7tn+ROQRK25AbeZJCB3N/jF8bRNi88/xZTk7b77K0=;
 b=sXvlFVtojvMReBtfjOjbL6ZWLlD/QzlUXhE4vH0GSOduA0xlCbpcUgf5dDfi9AhPJpFsBp8e+8TaPizVKBlodNa6bUImb63RJLvYMMFr1l+LOGBxBr/axYA3Pmw/n0dCSNHlNvh/1NykC3mCdQ4f2I7+/1J4fuGol6DsP8OR6pm2j8CCP7whjW3d9AGPjBXP0fs6Wpf7w8OZoSDvONXqb5NSfn6Kt+x20Memkukj8/hkiWda0wkabmMcwmfe7iOY8isx7qMzb4+ATe9MvWrX92FtTGsuCtVGR/SLgl4/Bim74AnkE1k4ZVYMNm/MNRtYXl6jrkcmmk4CL46h5wbJaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 14:04:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 14:04:57 +0000
Date:   Fri, 13 Oct 2023 11:04:56 -0300
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
Message-ID: <20231013140456.GR3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
X-ClientProxiedBy: BL0PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:208:35::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bdd1cb-f6aa-4121-f1d1-08dbcbf561e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjTlDl6zISsRmwM2zszd1KRX9fGqw5zt1VgperyroXOjFV49n8NgdT0jwmxeJFgOvKe301ipe9wGl6wyEZ64H7CxDg522EM4Q360f1ID9ZJTeYdFa51E/cF1iKNl8xbweJ7+Q6Y2Y1bChBcT7zLxJFrErM96OI84v7btn5ws8PtGlXrbAaOBPLHrK1O8MHNLyEIgDysNhgMZpDl/pfiePd3bOyoOk+/EPk84nNHMH+bvcK683FV5rQCJ5TYoB0IV9krgcR9YVB7ep9A+7Zi2S8RcHFAP/5z7cdcGGKKIjPO9EO/sREa6QNAgC/z745EYqzMbFywNKdDvVgaOIu3vXV1lUMW+rByMo1Ovg++ZR2ehG2pIcYce/cGGp4g+MqpOOCZC2DIBLDT26QQvPiy92lf3O441um/PHyt3hhNsLnLFrmF/tfKXCfNdMw5Z5TgjTuZhZeV0W+v9NGY+Tj4qsspYM+cWJ9qEILcLQr3A6qTdZmPzfYq+F4oLqP5ay6TFyJzReAlIX+91aHfx6tU9CBPGy0JROcOBq1W9tdrfGpCpTP1vgO0v5h4paDdlrm3I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(7416002)(2906002)(478600001)(6486002)(4744005)(41300700001)(4326008)(8676002)(8936002)(5660300002)(6916009)(36756003)(66946007)(66556008)(66476007)(316002)(33656002)(6506007)(26005)(6512007)(2616005)(86362001)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3LMJjyplS90qCfS9AOSd/RXHZUKRJfOG9ST0P4ZogozCBKFJq2p9UvE5UMqI?=
 =?us-ascii?Q?aSbuWK0t5eDYKw2Cvz5qHCF7fdBuaMfZ5nk8jp16ii+X0seU8Cqs8V1GOgmG?=
 =?us-ascii?Q?zNxI/Mrtl0BjkFR/JhEwidbNnnGfvfIRUXh6YKfY/NyLWapRVCMis7w5RCBi?=
 =?us-ascii?Q?D2SAyHM+pE5PT5/VwFzNJ656FqPz03XzQqKSFJ+sO6NYUsCti1hixKuCSRT3?=
 =?us-ascii?Q?WicpksfNna36get0xcS0ulYwGIbYD5b1eB5zTB5BoFqOGklMZi0Vl1G1xZR+?=
 =?us-ascii?Q?ZTwytPwXZVckEig1uJaLMUIsyP8907X3pX0YZilxcMsxrIqKoPw8EHqRQUt+?=
 =?us-ascii?Q?qusygaDp3lqy02CIdfpF0oV/pUkk2v3zIpDxx4zm7GmWhEIPPonEwROUu5N4?=
 =?us-ascii?Q?thVzqoBJwZz/xUGLyXwJ9nKh5XhZuSHtSSBXbu/NZlw2Lt+cy6r+m+FXbvlX?=
 =?us-ascii?Q?GNTqz3eJNB/TIaELDgWKJFq1FIljJc7H9NmNlw8/8kJyL8g9IEkFMz7LQ5Yx?=
 =?us-ascii?Q?X5Qzsy5cZ9mg8x83FCsIFtFLFrkt9c0OEG+tpcTD++isWegXZmk0aRI5WzQt?=
 =?us-ascii?Q?bwwGPLpRQ+ccBUvl9Z0zm701CZ9SJzmnUZZNcqM/iF8s/3hZ05WfFvH2joAd?=
 =?us-ascii?Q?5/U0vyH2jF5q9woKGY97NUsmz17vC2XFlbmv28Lcr9/AdIh5jwwILGrWAKKA?=
 =?us-ascii?Q?Ltrf/I8u9jtQlhKLckA3kqY8/gdAvC9eEP7gggZWq7T5NKe/oQ8FJUByqEO0?=
 =?us-ascii?Q?PJBFIKdqKtB8tskFVA2YTVEgYVKkEM2EnFg8Qz+nGDihMBBHHX5Fi1OaFgEX?=
 =?us-ascii?Q?4e1jKR4q2w7st9qN6OGqY8q9BO36+Awv6lZZEXl3Hqo4use2eFsyN5BhGMkD?=
 =?us-ascii?Q?gTem/cHflZEh0a3qIjh8RY9AQDLeNVbAyAFpfJk3hYPNfuovsbJko4Gkqlya?=
 =?us-ascii?Q?GqQ+tSiY/aGX3+tO4Tw/6PdHL4OPF7qY3RiZILsI21nB5PqHjOWaV5WWfTUc?=
 =?us-ascii?Q?3dVfLEO+7/F9v7Jnr9MKGmPGAAwF3/XdJyGRgsCe5dhb5loDtdEu6zLWP6O0?=
 =?us-ascii?Q?bcDROSFz2dW4K68V/cxqk0QXpWftsewm0nVdY26reOv5Am7o2msaL70rQwQl?=
 =?us-ascii?Q?CLG3P53TBM+fV9jki+b5T091ZqwobqwAL7WCFaV3VfZ9Swn0h6Z3nyivy0SM?=
 =?us-ascii?Q?zla+9e+pUr/VaUyBUUSO7lYRlFfCeENKTNteTTiRMndh4PuVFxP4CVEl4u7D?=
 =?us-ascii?Q?h4O7eTMxQfDzM0hxYDOeQow6zwvS5BaHEifv+10xqE9k4p+dnMFniIbNQDpE?=
 =?us-ascii?Q?Gd5A+eiccQqWi21ypQiPWk8ST8RJOKMoNbw9S8EGiCGxTBiCwqG54g5WBs1u?=
 =?us-ascii?Q?Zzp+m9jmcgnq/cNqEdpLja/43kAUaThLVeij2xziC0Umym2k6z5WAJNj/WBk?=
 =?us-ascii?Q?gOD9M7AVMAlm/24R3AwFIJiETw9PbObEczpud1pMQhpcvnFt3ED62NWlmAG0?=
 =?us-ascii?Q?xX8p4FwwX2NRfxm403KHvfGoKW3EZ5Nvl6KzsbLbXv/6IRhra9D5Ll4RGtA5?=
 =?us-ascii?Q?63JNKAhneI2ItQwQ/yg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bdd1cb-f6aa-4121-f1d1-08dbcbf561e0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:04:57.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex9R1VbdO/S2o5H15OcXa7ClM2pnR5Hc7bV7ACFAo2KuUFjNExhQbIDBW5BhPVma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:

> not really. Below the users of the struct iommu_user_data in my current
> iommufd_nesting branch. Only the domain_alloc_user op has type as there
> can be multiple vendor specific alloc data types. Basically, I'm ok to
> make the change you suggested, just not sure if it is good to add type
> as it is only needed by one path.

I don't think we should ever have an opaque data blob without a type
tag..

Jason
