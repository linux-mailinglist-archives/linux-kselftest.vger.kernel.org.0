Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE866C6AD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCWOYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCWOX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:23:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E776B1;
        Thu, 23 Mar 2023 07:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btOv8IbwaMekG6LUgeMDXMUG5pnJgom8NafM+vIIg1OgIgIPoesA8iBs0xi9Rw+FJUyQf9SpIkxD/AvGIa3hF7fKzky6Qx2Mi2RWHHU+9kGhy5Ba5wdvjDS+gjOczfLSvwAACykD3KxHUQgieVDIamCFc8BNOBlEYcr91Mx9D/MUI1jxxUMy/rGiMIxDAcoKUDmSW50gEbNYbHE7XrHq5Di//hT1FxmIWqXwKvB7aoMgBuXHeeiJLP9LS2977teXzC9+++ch2RMm6whYvN0Kqs9AtWaIIkLnS59LBW1HcnkuspQCHmW9WPfZ8JVEYfVamsEaIjN0eFRyW6/TaYtLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU6W+wSeltgEW1C8Si10KCwShBpy9oJZo5Nwqmius+8=;
 b=Z3eRKAQQ/TnwLVbY8Sgth3KSXm8YE9IO3MEhV2PYVX76JaGi2BHQqVg9Q0xN4YKsaebTonXqrskVdEN55cGX34oFpGaf31XzQ5gHogYQmtr3PtLGdHH7uMc+LKklYbc2Xb5pE71EPBbK3egv5pKuXUNf09DnemdAqZDjWVDpzAZ5NTiqGheoQ4po/wuwOcX3bRcw9+Gco715zigsj85jE3irgKna0CN/xW0panrnYMXTh+AIwie2UAz4chXdAuGQ0EPh6gWTnnvTNauQn9QnE813fA+fDL6UT0hqRjtmBpR13Ga3GEZ0X248SnpxbtwTJ9Nf44L+GnGyiY8fz+lCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU6W+wSeltgEW1C8Si10KCwShBpy9oJZo5Nwqmius+8=;
 b=hDgDGDdR5qZcWYanAZ7T7e9b20xrl8qX39Rw3KbiSwmbEZJjDLsJhaOPa21f07tCDHBYM+k63FoQCGBYgGBbJby4C6Wlnp8k/epD/BNDHs8cJKT/PVeD7jctQMh5/bY2hqPEgA9NEglRg+LUmpRhoA5UPsE2/vEKpaVyKNmmNE9IB23TZm1bEFG5/mTL05yRmrOt8GeZnoTkoB7u3mOTROp24wq9gT1GZYG0+LVg/fRNbW7suc30oGAdJ4WfrDyQvPDfW3Uj33luLQtlTrMQquIieaXeYeNUd6fTUE4MVvdE6IU5QPwI2rCCUxAD5+BuE+sQ3OYkOap65EF819vHnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:23:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:23:51 +0000
Date:   Thu, 23 Mar 2023 11:23:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZBxg9cRIpsozB15G@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a6c945-0cb7-492d-3ea4-08db2baa39a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8n7YU7tYt9vYyZaiIH4HEtwKAV1lGz54YOMZcXa9karHABH9F7FGFTDTw32g4v0+rlokhVlYWGwSQ4fD5PjGNeWPKBCpnjbaFVfT5RwlHA8HGZlcesQ8fkc2zgbZ0wz2NfCovC7SViVjsgcKsvPOpzvvH+9V4nqNFKtgtZLiVFhU/BgFWPfs67n9k0xbUfgzzo940uZKpPXfkZAwhv7X3DGcs0J8PAoZWQb9IS7xBIXZChl5BgQp95eMxgyvarWI1iPq8vZCEgeH+X7Qd5+UYZMiCcA6Gfv4naDl58KFbeHrhwcZ6+lsCbGFSlV2w2cSfAYxydobBHEe+kEk/kW3MdNe/S/3iqQ+U0EJiJYwA/rfCnfUlmSLMoYcKikvqmZBJZArdnhx8UPfM4gO28B2suolrwm55nyZV7rMr6ec2ZkBLWuy0oCqRsPLbAtc0kDbmaRIfoqVNVqBXqZ9dRBY53WLpu2iuv9X9qwlVpACkPmuk1lpg8coSCryFh8b8xC1/FfTTOQzffHt+ek2G4FXZ2i94Wjd+BZFpXAV2LTmC0i0ekabf1DG82Jv7Ts3IfyKgcKMTobMmVCSuSA+NT/YWykgNfA4q4lPRU+PR4o7gBVKe08cyDv3xVcMNz0phgzMkGKKZxby3TID1W6Q05ZKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(6916009)(4326008)(66556008)(66946007)(66476007)(8676002)(316002)(54906003)(5660300002)(41300700001)(8936002)(26005)(6512007)(6506007)(2616005)(186003)(478600001)(83380400001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vyPmwftLx5aVCp51gy2wc1Y+sBcuRFXpMcIlyg5BR6BkHCly6px22C0goBgN?=
 =?us-ascii?Q?wYng/29X/bnnBkCUWyvPO4cOogZkrqRZmN4THqXgbwse8+FZaoMef+Y/Vf5Y?=
 =?us-ascii?Q?8wIEUPxtyQFfk7BritXs/Bas2+SDLHeQdlIDc3fgJr4W/Maetc+ZDmIqQJ8C?=
 =?us-ascii?Q?7mjhYInvytC8fHg2Bl3j/hlo2s8UKxe61WMRv2gkd4U/inraGaeMUFu/MRkT?=
 =?us-ascii?Q?A5Zl6eWlPL2P48aCVfJgUSyyL0AUKqJS7inpWoeNCqYv+N3U15VCFcQ19LIZ?=
 =?us-ascii?Q?ckRtJvPLRUFWBwkwJQReV8XOe3JAhUPOM3ncZoLoowSTr4ewxxWmfOnAGngd?=
 =?us-ascii?Q?XVOarpWVaC4wRxrkZEdoZZLpJEIAIn3MUpPeyjutAbybDeXRwcO2VJnHewKm?=
 =?us-ascii?Q?Ge8c3e1RAj6Fnp8vydM+UWabYw4symvMofyHQOUEvPFLFQWQo8zAJd1konwW?=
 =?us-ascii?Q?2wNuakXcjc+Q1phGY38xSM52SJkuxbri0jivg9lrZhuHMErkg2yyT0jpogxF?=
 =?us-ascii?Q?fmqGIX3RCkLvxXUr8SGrcFbJURORuCq0SfQXUJ+Rxv0lRVNLk7xZ2VE8+SPB?=
 =?us-ascii?Q?L5efio1R3mgs7H54Q4Sd0iEVzHzApPXAmCN/bUfVs869ZPrpSLIS96dA7DOp?=
 =?us-ascii?Q?sShCXFQKWSST8sWNII/9UIHfwh52P9Y6lSbhxIdet5RtMQ07IjJwRhZ2w9tY?=
 =?us-ascii?Q?WorTzSgjzpqaDK/nvKDUsP9YanMnSKBGuQPExVrXQ4xpTfXCE9DEk8t1u/Zk?=
 =?us-ascii?Q?jxmrAzREfqzjFYucl0LUg8VSs7fVvaiNDuhi/BF7IIi93qVVWYLB1IceFzys?=
 =?us-ascii?Q?BXl0SnVAfDmGRaH6ipRyJwvJFlqI6IshmHr7OrSY9te8XnL3Oe5wP93zcTgh?=
 =?us-ascii?Q?k8Iv4Id/8xXv6ir4wZYw3A8oLFIA6BObqTy2sIBbOwe+wFqwQWBSNJly6FNO?=
 =?us-ascii?Q?b/kBcY89H4Y9mdA3zaVMRJ4x8EgdNfQcqwSQTGvB2EPgL1AsYHhzmCq9qh4h?=
 =?us-ascii?Q?MJyUq/3ES2d+jYu6ugRDP20thGSwBJVptx/CZ9D2CCG6R1Qt8hqqlzievVmx?=
 =?us-ascii?Q?5VDxAh9c8iAeTEnkS+MRgSHPa3hi7IvxcW3bPC/+9NZ+WJiQGV0d4yPtF7jO?=
 =?us-ascii?Q?K8bxZx8dsTh9VLM0nk/yPsbLawnTytxLXubivSrYZ18RkKWZPdodK8hyPtPe?=
 =?us-ascii?Q?ZX3M+NGf6pxSH5hyYCqJC7ZH4LMGOwKGiDlGbopaajyw9KpB40OgXh/l4aa5?=
 =?us-ascii?Q?VJ5hsbFylWPEsG6hSW4NGS2kVxGuikjvvuxQ081SdSUV8gC6ZMh0TDD+E2HF?=
 =?us-ascii?Q?OOO8sVMhun3diL41FoKjbNk5/S2vIK5ofMJmQgSee5VHgpo8ePGj245pBwlX?=
 =?us-ascii?Q?Eteo07pfX4aZSn41M/7e81SU0zr7thzOsic1S4qN+gP9cHDJ61lmNrmaYqDn?=
 =?us-ascii?Q?4hXDIYfStNzCRgJuOK6PktGjlFd59640Z5Z8uj4t7v5vBqkA39TcbVAzeT2Y?=
 =?us-ascii?Q?lftlEg1mFw7dgx1Fv7aT2d3O3pW7G6g31SCOa0RiHwWX4yroWvP7gFOfd6Dt?=
 =?us-ascii?Q?3C+J0iNItEL7cLz9K6CrCNsagRKiFxEKbwkTyXYw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a6c945-0cb7-492d-3ea4-08db2baa39a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:23:51.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rkb0LwkMxOryaKDzpspIcxb7PJ8i4fER8xBGn4TuyWZ83pxgUEk5L36FRp/ybOGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:15 AM
> > 
> >  	/*
> > -	 * FIXME: Hack around missing a device-centric iommu api, only
> > attach to
> > -	 * the group once for the first device that is in the group.
> > +	 * Only attach to the group once for the first device that is in the
> > +	 * group. All the other devices will follow this attachment. The user
> > +	 * should attach every device individually to as the per-device
> > reserved
> 
> "individually to the hwpt"

Done

> I thought about whether holding igroup->lock is necessary here.
> 
> The caller should avoid racing attach/detach/replace on the same device.

I think even if the caller races we should be fine

The point of the lock scope was the capture these lines:

	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
	if (rc)
		goto out_detach;
	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);

But based on the current arrangement none of them rely on the igroup
mutex so it does seem we can narrow it

Thanks,
Jason
