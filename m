Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498476909CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 14:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBINYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 08:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBINYT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 08:24:19 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B853E42;
        Thu,  9 Feb 2023 05:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6ARnqvYiKlX9+MhE2N9ZkseKOuiZmZvsNUAi9a8LQv85oOdcRE/u5k8MfwoVAbuKRZ+01ug1jCYLPGvjr3Wk+bqHYRhbJY38KWX6TxBbmTEZH5ZCEIE26g+fjv0LOrP+mkLyzXSvgBq+kC03KqgRUjdvcXRkeiI1X+YossAR7WUWFO9nVmQaulyDyOVPxQNrvFz7kMbRuzQO8f/f2XYtoz6HrsQdeE1mFoE7a0cS/1c51u/OuIjv+ef19zDjiWepLShsCvn8pRD7ap6jaYAy/uPIRnx6qW0Ks+fcIvnIkzrc2ffmIM3rMGvYRSIMmMcIvHgW19S/g8xs7VZTxnZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6/CtLd0uVUuOTR5pM1A1nQ4mWFp9p8GTMMRcKI07pk=;
 b=CsDAo46t6Dz1QKkHVfSZExU+SOsSjB0RsH46cZhhEMNNQ557RLapylhzUhjDf1ntTFHgadMAyMokWD5SYg0vjH4Y5ulASD7lp6M8OuMeWTduntfjygc673xupe443X+iB0ll8+EGJR/wqJYYntcCLcG6ayy2cqFutP3pODHpsuEbwTPNCMjZyV5T+4l2jSdhV6mJs64BSg4FQxYVlkqVV0TYk22oz7FvgqnMg/j0jHm0bJ307InN2SuHtZTy3/3DLDl9XztEoqxtQWE9q9xGykyx/fqrJ25AuUBKosiANTdjh35wHjXEfxc3brr6zOrCiolRjiDMLfCg8QoNlG1lng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6/CtLd0uVUuOTR5pM1A1nQ4mWFp9p8GTMMRcKI07pk=;
 b=AOvx5qYP6+nB4d4LfmQCKcYwgb0TH5nYGMQE3W/PU6oiKHiyV6cotx7g+70F50q08cRiveWxVt73rTKfUW1hMyg3jTICQzjclpUrDsvTckmSW+eUXzEBHjfYfD45rxQ/BI8Q5yAIcmzZjAXWHj3pVok10RixzktwY2D9j0LsdMlXO//mRU1qvDUk5zhier+jAMxeo5IpZadFJrLaQZ5IlYcIY/wsn9HOSU2iQI1TNuPI8c9UeOw/g1+S/UeqtPMByERba6j4qLBV8OAADAsW/MXnYYSRd8fdbDYUuJeNdswkw2FVusZ4M+7U65uJwVjbHFjw3xrR1EvpJgnhCeZnXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 13:24:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 13:24:15 +0000
Date:   Thu, 9 Feb 2023 09:24:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y+Tz/kkZ68e9QWR/@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F36D2F07209AC7155BAB8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F36D2F07209AC7155BAB8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:208:a8::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: a21ca10f-40f8-41af-a34c-08db0aa0f0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TveSWZMEFCD/jUYUcym3cM40vQAL/2E6BFo0BG2ztldam2odBZhkhi3FDEfSg6+a6Cb8yYJq9iWUrEHGhxU9HheZVUv611V5HGGXFD/TUwy2XvJGL7QkpoGK+lFzFObH8skzfGaNF1dyRXQL+FvHeF5XG082+e2+Aah8yufbkOh/Z/aSpugga46AtwqqtLWyAGYg2jEfGmr3SE6LJHHTiHl13YRQ6ttOPsu9JxxbleLFN0cxWXClAHUnVTUFom1rkU8LbAhKd/FMIXqLRgq0lkiMZPD5WXBuNnpqm6uHdEnCPSKiER+iR4ZwQVPZICrb0O+WpHx6W1HODwmoOP9L5gc5mB06VvkA/pWuPsS5XMrYAzPpf6s5Zc199NyZVsqPD5/VfFYlVsrDWJAGdyMW0UBocMBmAAMpKFM3NgshVQHYagT0iVVyPbYWF6wExICXYxfDm0ekCGym+/aAEFnq1yWdfNFWXcVz105cFgm8e9hD7JTx5YnEjIhTTp7NKIrYAMsOtFVWRpxkZf5ALNb2M6bqOg7kfvKvUfYiDBKux+HgdJP1MxhMUSjjf5lMgDHyZiy1Z6u9c4zaltRAiqZ84QaQJ0C3RMdAUmqCCz3q+VzcrWXDOgP44fxLt50OMkfKpWN0Ry8dAYac/vgmZ75gqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(54906003)(86362001)(26005)(186003)(6512007)(36756003)(2616005)(66556008)(7416002)(5660300002)(4326008)(6916009)(8676002)(8936002)(478600001)(41300700001)(66946007)(66476007)(4744005)(6486002)(6506007)(2906002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BT/0DCCzFnRlsJnCV4ktRyrCQ/ixvTx+m6PjSC+uIesqfo6e7J8mr5Kj2dWk?=
 =?us-ascii?Q?+NXElMHc8OdvWmuN3XUo1PThnyp23sQD0ukkSOJYg0H5KvKvJcYfs3nQ9lZs?=
 =?us-ascii?Q?ImnIhvbFI0uR9bZztLLj1mq18S+V9CIAg3TRyE8Jw3GqvDeKkLfPMLzZffTQ?=
 =?us-ascii?Q?t3EDCIrBhwW88GVVj2n7sPfpQqXv8kft+rhRsCquJ/hfOPVOxKFxgNIEsQCf?=
 =?us-ascii?Q?rZPd8I2fwWHKY4y+iydacR4ZB8Km2rSbMcVVfcuIkouV+e5Nv313D0yjMLKs?=
 =?us-ascii?Q?TOs96cwcjE4QUa6mtT6Rl9W1N2zfLBzttjoQp1ThAudNhHdYjK5NEKLVtR5p?=
 =?us-ascii?Q?SzWsXThVYGsMBN/1ogp5/KnA4n90mKeLDlcl/EhtKFqPq5rUaEL9z8kEwX2+?=
 =?us-ascii?Q?86T0nGww1sXK7gMgYBcaT8CEBGS9qZVgnWhjgAxyYWXxmBVirixw360JJwiX?=
 =?us-ascii?Q?z0MErlw2HNGWZ5GJwx+GFBqxmJxB5AXp39BwkxwzBaC99++6Kd1/r47sJaeJ?=
 =?us-ascii?Q?gkiRIbz5ir3dKp5PrRZGvqzH9k5fHgzCDyf6CI7VhZrCL+0ItPYiNxe6qzet?=
 =?us-ascii?Q?J295Z3TaDmtifapoZ3u3KEn62LB7vay/JrrEfU3a2uqr2sc8Ll/6XUWsZ9Vi?=
 =?us-ascii?Q?LXzNV7ZX6C5aQ597vD9jmiECFEQWiZi6kPE5jrLWREfAye2SOeTtcPFNY+Tl?=
 =?us-ascii?Q?Ix+nAwK3/UMNOBepo05o/RxYlabVLMA7xpalCT6M2e9i9DP7ReXOt37Z0pFC?=
 =?us-ascii?Q?ddGN0ELRlIEJ59Ubr43WE1QDwGj+5GviNb7SO1Rr4SkGgvJuBLWekaPmI4LR?=
 =?us-ascii?Q?VrjRyYQK5eFiZaf7VkVglE3XokYaYJP1IysfBxOxzTLE5q23lqva7XS0hRDc?=
 =?us-ascii?Q?C0jHMHyR0LTVV0akTWW4av58sYQEvUILS7zc1TEZijLKjtnIzYFzZklg8WQE?=
 =?us-ascii?Q?iYlrGCtr3CkM17TAJBpa2abqkQTfnWNH++GGtmJXRp5VUnoRFiDX+7WI7s8b?=
 =?us-ascii?Q?yh1UpD8wiTJqp7bWiRaMLSYMAAkgwVbxErhybDLss6T9RpY5eik/2fZpxC6h?=
 =?us-ascii?Q?xLke9R2WgmvZ+vQSFcuqafbMfzZ0VVoxq7MhH02i2KYWfkawF5JSp1kHDU1j?=
 =?us-ascii?Q?7PgCbH8nloZlQ7HoIbcMbcXiJqvSHGoOKql4p+I6tycX3aoMePRPa05sY1yI?=
 =?us-ascii?Q?SuE0A0mIwFOQKThfYYK+XS1VrEkXZL6TboDVEFmsk3oqs1vi/oq2ReQoHfRN?=
 =?us-ascii?Q?QH/6mbEuwfwb10GW4JVszdStoRf7Dc/6kztUo7s1OamxCvAt+F95iQHJIov/?=
 =?us-ascii?Q?uBtgAF028jaRCXQe2GpfaPsGHLhZePca+mktoJFnmzQtQDM5n4z7cJhmi8AZ?=
 =?us-ascii?Q?e/BZ5xeNsZ/5ZiAw1/YnfLqJEkut4a0LR+ee0XvY0DtlOFDn31+oj54a8DkO?=
 =?us-ascii?Q?oda2wxPB2c0nDs9fTzCiwKp1jfKBuHKiQ+qL18mFivSBabri6giUrw/HiM+i?=
 =?us-ascii?Q?eiFhVd8pfDJ4Zhj3DYGxz8S5XgOg6e58tgk3ZpwedEjuLyr9AXNNM18oRynV?=
 =?us-ascii?Q?ytiMGrZvAGs96fNXlKeLPXLuPBEnKbqXZpk7juNT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21ca10f-40f8-41af-a34c-08db0aa0f0d5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:24:15.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5K4VlmBJfgOEuNVI7CHGyOmcNPiFM/4WLzJSEFMMNWgwiL6j4riWKY7xesW/btP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 03:23:47AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> > 
> > Because list_del() is together with iopt_table_remove_domain(), it makes
> > sense to have list_add_tail() together with iopt_table_add_domain().
> > 
> > Also place the mutex outside the iommufd_device_do_attach() call, similar
> > to what's in the iommufd_device_auto_get_domain() function.
> > 
> > Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> shouldn't this be a separate bug fix and backported? double adding a
> list item would certainly clobber the list...

AFAIK there is no bug, this is just reorganizing things

Jason
