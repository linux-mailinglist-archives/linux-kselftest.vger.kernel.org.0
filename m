Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620906B4F82
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 18:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCJRxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 12:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCJRxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 12:53:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4042132BF2;
        Fri, 10 Mar 2023 09:52:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgaInzOU1H5sJd67J2vYFGlVs38H0h/84VmZnf0YK0Cf9RY4aXQkx0ZMgZDG7wSSwnKYQKy3QLhtyi5w7/aVMtWNRJKr7ioOL3oDzvv6T65yDZIZw8/Tll5sRzfn3CGHg8lmq65k2I0FYUE/0/ez4Ls3aw0RhjTJpr9YcUtSR0mLEkK/tD7G+0J1ztFN1rMW4/duCkwkkiUwW6YivFJIqNxgb5108jWbTTnQU9rEHOsewyPpdlEd8Ci5Z24huXWwTtAbysdTNMCcoO5U+FdwXe2P+9yYLNDozzG38MVdboiXyARVd3BWmUaglcEy4qatpS/9p01cvZAnRKI7NjlIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBlbLBgqEZsbs+4lI1zac1466siCk/hPJuNt/jJnIko=;
 b=b4CL7nClyiJqSh4ewxW2NUq5DaN2iIFfDRojaTkFNDLFGw4mVlH0ucJ8lGM3RslqOeq22HgWCzsfCe6QTxKgyMHYwWyd0R++W+UV6ZPZAiMvbnHutRLXyg/cD2hOoJR/2noG0kO0YVrzzFCSHLVkkzH7Qc6d/k46ctFU9NCPTEywlFdoMLn2tJ6GgH/KckrbH4RrSXOt5JlHbcXpk2qjZOYLcPGaevLiw7slYllT7SDCECAp/Baz2x5JAnjeyF2A/4AmkaBf06xWsPRB19gzI6yVaOvXzVRwBkAoLJ1+8aR+/jFWQWcQU23nP75nClEhu1Il9VsI1PnzpVvxZPcGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBlbLBgqEZsbs+4lI1zac1466siCk/hPJuNt/jJnIko=;
 b=O+GgCjKAzLvJ96BmlJ8aQFicvFHQxSDJJL9Av9EVwmK1J7bB31deFEAsM0aoydzFAWC6znoSkjqfIQHkO+DeyfLa9+MjLdepNc9V3IEfVa4dIXc+SHRcZ8zX+uULVoz/WT+ecdV1SNqu5afHqhw6DGJEggo23UmJCGDhhzdW1aqRRBIY5TtfXjRyOk785Ks8zvvodjxKaSgYAUu6q3SH4aUM8//oBLnSRK79oLAkCQQa9lt8TZuL9ubjSGm6YBHg+AxF5I6dUwLvXyjO+bgv4Me/1uZ+3jPUHRA6xfY9OXaStCstyySdtsNfzJiiZDDSzYVA05HPiWMVDIcG/SdFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:52:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:52:49 +0000
Date:   Fri, 10 Mar 2023 13:52:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Message-ID: <ZAtubgIHAOtrnIbL@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-9-yi.l.liu@intel.com>
 <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
 <ZArXyj3iiPa95aCu@Asurada-Nvidia>
 <DS0PR11MB752928ECB7D395C601F14246C3BA9@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZArgAXMUpNjDfFgZ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArgAXMUpNjDfFgZ@Asurada-Nvidia>
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d85369e-0086-49be-a3cb-08db21904369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqW1bNvi14gfyQmwBwxqZ8Tk/aYTrUZpub9wmvTeohPE7Vdz0Yji8vuGOUG9AiBUXU2vCGRwGiA3SBwnBucZ0ckUDupDqx8vLXOyXF2MPwr7LYcoK9BnXR+wFTJfaWdwCc5r33fUOpX604k0Bt1uDmNKgDmCekekVgbfcSSAfTLuyK7FUxCLkltArIxxPZgyKCkQGmNwTeBPRgcJeIlgElQLKOwXyaGB3oIn3ODqKffeQ3yktuOAFTMTnyQ9ANeT35Xf1XQ+yx/LRyPSOqQjsA+F4UQzYD8a/q4wpY4BzqS5s9lGWl1SFGqf+csXt2yXbIQLja6MYMObAxZRsvTo4Y64LNxXudBHScnVBXC/d+tLu6XW8h+uArfpJV8ctjInVJXtrbSfGp4gqcg38O7g0GWNRsCFDbPuWFGLXtR9g1NY/g1nnvoHkI13+tQeafbo9MEqTAerhHmJBFT1+sd0/gYW4D0oD0Z8qDmEPndfiJa1l3LY3lvvCVaqk1kjvUS+VzGYNUGbaCRqGpE3Ysy7vW5sPggxE5Xb9dtCE59GDRRjOAVyVhuCpreNpMEee9pXjiSkO/l0NsaUhWERELAngRInWC8tlhq/48kN5L+/lAp9krK+JePEwYPcpwO5/mbDQDFNRxSi9BvmpSJyovY70A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(36756003)(6636002)(37006003)(54906003)(478600001)(41300700001)(6486002)(8936002)(5660300002)(316002)(4326008)(7416002)(2906002)(4744005)(66476007)(8676002)(66556008)(6862004)(66946007)(6506007)(26005)(86362001)(38100700002)(6666004)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLjdF+s7wAXDzn6WBZ2eWeWKXd/cMxRjwRT0lqpbTZ8dsHm3qf7OblP7bT7q?=
 =?us-ascii?Q?+f0ZnPMDsP41IZcUcnrwZlt3HfSmuKkOAoNbbgcp8k2uHIfduMnmCxOCRZ0D?=
 =?us-ascii?Q?7FIk5xb0HN/WhNLuAokQqyEY7tuTbV/NrQimfcyUVsoqtXTh5qOHbcd+Uy8Z?=
 =?us-ascii?Q?OTb4FMxidKn3BfHV9YcS31be8y5a7AmRcyzVDzRyr3PJaXAvy6Bvo+J6WnQG?=
 =?us-ascii?Q?XaubkwcRoMUEohI+OrtZSlXIK+eeUJiV3MTPxzgw2dmkjK5+FrUBxwv20AfX?=
 =?us-ascii?Q?erNG6DQyAqDKGdiuBIYtNt9VA2TfbDswz6GYhh+KFxgcjn+lWBVML9XfRmGe?=
 =?us-ascii?Q?BnQBDqqlo0m08d3LPwUi5Uzt7KAckApbeZZvzcMOXR5RdNnKRKJ9XQXpmgDq?=
 =?us-ascii?Q?g5WUQsHFjdGe0jIB0jCs1uw3bsu9I1LkmT+FpvAlYA/QHbYe1kx+8RYY9jMo?=
 =?us-ascii?Q?uMNzig6Uoq72GucCllYgwp4ORZUDRWcq7CrpmBbrA946bBomjxwlHPUh+ebn?=
 =?us-ascii?Q?5bSMggs+Yh7kHIbTArpHndrnT17LqzbvlJHtOspVkGLMPOoPDbFq3zX9Eknj?=
 =?us-ascii?Q?xefN4/GOwvfoIn6GhQPSxY0rpWGQWM9+hI2Ol8c6hFqwadG4KknZVorjzFhK?=
 =?us-ascii?Q?rnWA+TOE8EnuuzRnb2A4P0sE3ME6GmH2nuI0Mv0M4Jy7VVMKv4e7nLTX+ZaT?=
 =?us-ascii?Q?cenMrNlEBRmdgT9/PITEsm1IMjD96K633Iwrxr2/8Savw07h7u+eZkUhnjXR?=
 =?us-ascii?Q?ehuiY/gePZlqtoZdLFrKveRjJfdVcWAxRXXiZxWKfAu9rH5RbHX1MjuntcJW?=
 =?us-ascii?Q?L4ENucYybefA1vU11nkqU6hk9Hvi8dOnTK4NvFcFwLAQ/OXB7Ci0ycC7ckYR?=
 =?us-ascii?Q?yFXMvQcT21/OBqdoIcKhf/vrxpUxod5DPwqNR0HMevyFsy5grj48dBBLKY2O?=
 =?us-ascii?Q?KvzryEEoeITg6dGgLfpX/NWd3Rqd1VzvnrQkK6Jo9TjlhqWDKiEB6DJv13lL?=
 =?us-ascii?Q?DJQ5wT2Z0HSGZ41tu2GYQCGUgrUCSE4IYV6YGmM4v0Xf4a0QzmZxkrF9Yjrp?=
 =?us-ascii?Q?Nen1cwx/fnEQJJdXg2K+C+ZholRMLlxD78RuF6hg0VDWYROcfAoHA/x4RzIQ?=
 =?us-ascii?Q?rZAr+HVitY1zmQLiKMYnZesUZ5GVTic5mUWpGigZXHnmSSp4hy/vtljETcUx?=
 =?us-ascii?Q?TdzowQP2f0hLmL9OzJ+aFQ5EoS1WFYgqfRHyPSpndNmTqs6jPtOeZgrLVD3a?=
 =?us-ascii?Q?XrTxIy5TmAmmiJt69kiJgEX1npCGPghFzMBFSxv1qZ/3AhyOTJbAcJgTSO4p?=
 =?us-ascii?Q?so3/p4x8gQcdykqjoQV30/9HnrCUQ1DFrYiZ6/YRFbm7M226+QG+Po/JYYHR?=
 =?us-ascii?Q?LxmRhAds0/jCDadTu0tvuLMLyTuBH/Tr1WTx8rjVXWHE/ra2tj+Htc8UvtYy?=
 =?us-ascii?Q?iYL3EJ2DULwvSs7JXqRgHDg6oNFzoWEYw7Q5yLuWDOLX1G385ldx0GAxnvP8?=
 =?us-ascii?Q?zKAw2shBDnD9e5Q3rZYm3+5X+KBtKEkwVhATCmREBt7bAYTSSZ9ATgRoFUai?=
 =?us-ascii?Q?NVbBYHo817mfAaMwctWaIDbT/ZC9iycISupOpfDp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d85369e-0086-49be-a3cb-08db21904369
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:52:49.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CFHBCLFUhC8pmtUda5MN2ZSVhhdTpQZQOiYBd64LH9Nqxi7ARMErF1F2QORDMk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 11:45:05PM -0800, Nicolin Chen wrote:

> Yea, that's what I thought too. Yet, I am wondering a bit if
> it'd be better to have an ops->hwpt_type in the drivers, v.s.
> maintaining a potentially big chunk of the array here.

It probably is, some ops->iommufd_data.XX is not a bad idea

Jason
