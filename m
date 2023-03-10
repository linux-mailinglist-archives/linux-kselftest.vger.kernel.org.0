Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3F6B4978
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjCJPNK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 10:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjCJPMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 10:12:44 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8071269A9;
        Fri, 10 Mar 2023 07:04:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enhHiWhLRGkEzV+Zaw6VxImzQ66SrbILkglIh3RYS3m9bTAVJKY/qQ6izPGZRztVZpHXk5I9AJHPpBcQipPRQRaxGm75H7UgNzeF7F/0gOc/QA+mhb/IFjFdPQZybgzWRFi2wGz91NkVdBW8Tdgusn7EbMju2rLwQcqj+Aretzq5jGndsHtgBGzjk2B5ElolqZq+mZegOi6gPwBwR7BaoylYZh9X0ifRGh8KkcpJIa6q4jGkHIQpq1Ff6PCRpfT9jSQtRgQWfPubSy2mgb7t8jY/sKtNla+NgVarMu5lT2p/j4OddFFqeUKM1HxLU0qIjP9CSL86ZJ233T2s6PG46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSGs7GmTCSKxK36gnRJTIiCQAzD/aJeKs1ou4sAq0/k=;
 b=F62ZKwL5KGih+D6jUhqYLFl5o99AGXb2DWw1JCvebNebhv7kSlNFAftE+EYt6Eq14ts0IIC8Y3FQDJBc8XxcuxVMvOdoZfXo9ls6XyfvI/luSp/IzU1GBj54ISsp/tz+R4rACPyh58KwmdqsJtFcBP6Kan+Dw39P/STZVgSC4sjil0iVUNEGgXjIEDOgc/T0bYJhpBopPZEpKU8otm3H7nohoCYbYp/1Ei8qiHgidomAUBZJ32/94pnZJeKEb+5DArCiTJflMz6teFtfrPUG77wLQykxBwZz4xt0/bFDYKzq2soIqMwHzkPRN5OMeh5b3Bx1tuNZ3LV6Lsc4fRYXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSGs7GmTCSKxK36gnRJTIiCQAzD/aJeKs1ou4sAq0/k=;
 b=Frmp4hb0oLrAZr4gWYJ5gF7nV+eCe5xm3Lvgy2BBiWEMBB6jpXQOGAdhCQGUfsEzwlHdvR7pqVva/6XdQm8BNo913HQtHrQpJc/63Z5AnBrFjtXcp6yFkZiTBtDJFSFB3iYhsPcedhXZ3msFPj1gITbJpcJd5j+ChaQ0mUcc4RdfPXKDWNDKoVLMFOV4doUStxO1b+pSg7vvOrY0UBWKhopKSAzM2rFYMOiIaWR+OyKPHIPq9kIBDLQXtqXNL3TXC67OOQdypqDaYdLfqqbMbIV9uCOYDOa2f8/RBR+Y48pHoNObzSvD1hHtevmGofMPDDvwrBXUxeEKPxPX3YszGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:01:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:01:34 +0000
Date:   Fri, 10 Mar 2023 11:01:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Message-ID: <ZAtGS5pZF7fnsCJ6@nvidia.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <10-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52760C4E5C89118C1B898DA48CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760C4E5C89118C1B898DA48CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: fc149d11-d3d9-46a0-2233-08db217856e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptj2NImZaJ5C89zHeDp9aCyY3I4Wi8RyScI8FL6iBE4Xpuur7jGpq6WV7yl9EMP/9VFHpMiOzGOgAd8tZUE1WxMQNmVnvKl62mB48mzwRyYNr4wATyys3qebSFADp3PAE4tXiiyoZRfHzUfTZx76PfLqSekU7jstxgXvk0s0pebv7lz+7RJhObKsjnNFgkounWfGiCeH7fsjIMjbxjhnfaHcUL53Uzxpx889UMG0tsqzfJkUzXtVkAduGrMJyIe6BuqZ/EWqU0uwoakQBke9TafZQ2Q9bxRRAezLl6oDrvDDOZ3KkBwSInG0GAKzOarDdTVO5XP98curd0qWyZDTgfQ/r4xInrLthpaZi8axzW2jjykd1i+aZ2sa4YKWGv2msbg3j45jyUxaO5rzv55IWPsi61ccAn4DNUUjaxqxl8/7ZDh91DWW8GdlpvOYPGP66KjBfbIP5aOwLAJ6/hX1F2ml8cLOgxe5VB0JQyD9eorX1fDnQMSuR+xyN2wrq4xqXvvnuERHbbz2rG2hMKIuyclVkxi63pRWGcRAJ4V3yyjeUcMQtUJ/UxVfmx8aFxQoQzNVylV2ng3x/kZFP1DAB/K7v/u+iXlNiLqwhoOQA/CiYNXr2SUL+iflmpUB8ceT181F4ipWoWQmv77qsRb9nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(186003)(6486002)(36756003)(478600001)(316002)(54906003)(86362001)(38100700002)(83380400001)(26005)(41300700001)(6506007)(6666004)(2616005)(5660300002)(8936002)(66946007)(6916009)(66556008)(6512007)(66476007)(8676002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q22U1jSU7YqwvI47o/4HCCyj8yWLcWkDX4jILSJgBvcVzSFuYE0ch+ZHatMf?=
 =?us-ascii?Q?Fvn3s5Gva+F+Hgvqldxj9AnNeF1hlZVxKh7i491PFyunoGIk2EfhIK11J0Eh?=
 =?us-ascii?Q?jP9KZhJD5W7/czqu2n6b7cjtQnRmjJx/zGvooHvx+ogiyUKRGxllzxQFzbFn?=
 =?us-ascii?Q?zgkoowbaxb/oYFqhtxiQbB45lbZLCaKQDCpauYPn/psL5WptOkZEaiPXOLRz?=
 =?us-ascii?Q?wvJTNM1GdcfF9oJpPaFLQTmBaOo56ugoe4O2XAqabrDFfeQcC2pRclcwaoN4?=
 =?us-ascii?Q?z6UBpofeWcXcYNwx9dGpBjPFDGHlQzsdAPc1W6MEWSmx741xuzwp+XuOPAd7?=
 =?us-ascii?Q?BC0o4EsnoR0Qyx2SQl6mAGv2sgVjs+cReIt/V2oXHzuRlPu0rV2+c4KvGZaf?=
 =?us-ascii?Q?WhKShHxFP65VF1Q7njh2OwKWPuU1fs0oHXO4GlRBr/bsHOT5tTSEDZGa0+nW?=
 =?us-ascii?Q?h+u1WE1+nEZbDkm3bdUp4PtrbWevqKlaR3RT8yT5aViMe9GXI+iy3yW89kRi?=
 =?us-ascii?Q?X58fxvVVaXTS4MmDLOKaXRBhf5hvBCpJAiiM7o1HpVNd8zYkTpv6GEdCdeXB?=
 =?us-ascii?Q?LPCP9F6crzOoBG5hda0P1JqfOuP3VakhLJJnHKmHZStAGIu+1SNxc60tcuuV?=
 =?us-ascii?Q?YqA06IkIXFGVObUUuXG3Vg+9AWHoiAqZa+EjBRZhbEVvlR6f7IGQQPPUsKSa?=
 =?us-ascii?Q?wPHxP4DqqlF0sSVgE/FrQK1vks6pEnzBT93mAVDkCY3YIJ9OOxNP39l6tpwQ?=
 =?us-ascii?Q?vzSKiXNp0dBead6JyOoTAd2xzchKFWXJKK0zurP3YkqNmO9mG/lwAybBi+ht?=
 =?us-ascii?Q?Tq9i8rGBTwuTzHmyHVSELM5XSCTtMWTfXiPzPGQVAt1ArtnuBu2RwpZ9ikHC?=
 =?us-ascii?Q?nnorTYp73+0EexLbaPe6aXvx05pf4i4UqwEskcfjcm+LXANFafJXHEbTvnot?=
 =?us-ascii?Q?OKjJcnkc6msFqQQZUjXhbaezUigGBwsUFB1drZLMwgkjwyg5endN+2lGJ5O1?=
 =?us-ascii?Q?mJfExuB5ZF/j47Csm5yYVLowZu3IHtHuqkZmHz5yCj6N39a1Xr86H/uYMjbl?=
 =?us-ascii?Q?pzc6nfaldX5x9ZCge8z18eRe7APynzAChRU/mDUMT4IDfc8ZXgXh+e50c42w?=
 =?us-ascii?Q?CFZtqIdEhQJ4Wsi226CZHQhmq957tDcVGlxCzoL1oDMnKkRA3xTId/z7Z9KE?=
 =?us-ascii?Q?PucLOZC83v+0Z+wbZVfuA/Ck49RcnhJw6Mlem9CpDue1cDXcJj1r+VuCY/f9?=
 =?us-ascii?Q?ZaZHs1lDt4JGnmG/0wPPHfWZQ06EA7yhvZB0NaFD5E699aLq3AqkfANN0GzP?=
 =?us-ascii?Q?+kJylDWSNXisRlax2a0RNYU9VK/H8XmqGJeypNFOlOjoMlIOUVM4M7n7QRXJ?=
 =?us-ascii?Q?Ivf1aLCYEhRr4LIQQrQq/p3aDoGopgchjxwg0xBzBLwuQnf0SRjvvZhRs+tX?=
 =?us-ascii?Q?KuDAUW4H2AZzJvTErElmyny8qGF07lrTGkUNSHa0fb0puV/lsHNb/4rzQyKJ?=
 =?us-ascii?Q?DnC5PyhzcMnx8bFhGCaxl+UeaG8wbhvPx5jYSZq7yua9/mSYfV6mh8vlp4hN?=
 =?us-ascii?Q?XeAU8kQUCRJDLn3b2P90U49/CoWjpDepA8l9wB7W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc149d11-d3d9-46a0-2233-08db217856e0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:01:34.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cUvr8RkpS1dYmUtEtFHy5ViCseIBVJ2jvZGpfPn8fHC1/pXpadgp5kRs8y5JAEV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 11:26:42AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 8, 2023 8:36 AM
> > 
> > @@ -379,52 +388,57 @@ static int
> > iommufd_device_auto_get_domain(struct iommufd_device *idev,
> > 
> >  		if (!iommufd_lock_obj(&hwpt->obj))
> >  			continue;
> > -		rc = iommufd_device_do_attach(idev, hwpt);
> > -		iommufd_put_object(&hwpt->obj);
> > -
> > -		/*
> > -		 * -EINVAL means the domain is incompatible with the device.
> > -		 * Other error codes should propagate to userspace as failure.
> > -		 * Success means the domain is attached.
> > -		 */
> > -		if (rc == -EINVAL)
> > -			continue;
> > +		destroy_hwpt = (*do_attach)(idev, hwpt);
> >  		*pt_id = hwpt->obj.id;
> 
> only when succeed?

It isn't necessary, but it can be, it is just more ugly

@@ -461,9 +468,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
                if (!iommufd_lock_obj(&hwpt->obj))
                        continue;
                destroy_hwpt = (*do_attach)(idev, hwpt);
-               *pt_id = hwpt->obj.id;
-               iommufd_put_object(&hwpt->obj);
                if (IS_ERR(destroy_hwpt)) {
+                       iommufd_put_object(&hwpt->obj);
                        /*
                         * -EINVAL means the domain is incompatible with the
                         * device. Other error codes should propagate to
@@ -474,6 +480,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
                                continue;
                        goto out_unlock;
                }
+               *pt_id = hwpt->obj.id;
+               iommufd_put_object(&hwpt->obj);
                goto out_unlock;
        }

but sure lets do it

> > +		if (IS_ERR(destroy_hwpt)) {
> > +			/*
> > +			 * -EINVAL means the domain is incompatible with
> > the
> > +			 * device. Other error codes should propagate to
> > +			 * userspace as failure. Success means the domain is
> > +			 * attached.
> > +			 */
> > +			if (PTR_ERR(destroy_hwpt) == -EINVAL)
> > +				continue;
> > +			goto out_unlock;
> > +		}
> >  		goto out_unlock;
> 
> two goto's can be merged, if you still want to keep pt_id assignment
> in original place.

Ah, I don't like that so much stylistically. 
 
> >  	}
> > 
> > -	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev, true);
> > +	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
> > +					  immediate_attach);
> >  	if (IS_ERR(hwpt)) {
> > -		rc = PTR_ERR(hwpt);
> > +		destroy_hwpt = ERR_CAST(hwpt);
> >  		goto out_unlock;
> >  	}
> > +
> > +	if (!immediate_attach) {
> > +		destroy_hwpt = (*do_attach)(idev, hwpt);
> > +		if (IS_ERR(destroy_hwpt))
> > +			goto out_abort;
> > +	} else {
> > +		destroy_hwpt = NULL;
> > +	}
> > +
> 
> Above is a bit confusing.
> 
> On one hand we have immediate_attach for drivers which must
> complete attach before we can add the domain to iopt. From
> this angle it should always be set when calling
> iommufd_hw_pagetable_alloc() no matter it's attach or replace.

I looked at it for a while if we could make replace follow the same
immediate_attach flow, and it doesn't work right. The problem is we
can fail at iopt_table_add_domain() which would be after replace is
done and at that point we are pretty stuck.

The design of replace is that iommu_group_replace_domain() is the last
failable function in the process.

> On the other hand we assume *replace* doesn't work with
> driver which requires immediate_attach so it's done outside of
> iommufd_hw_pagetable_alloc().

Replace with an IOAS doesn't work on those drivers. It works OK with a
HWPT.

> I'm unsure any better way of handling this transition phase, but
> at least some comment would be useful in this part.

	/*
	 * iommufd_hw_pagetable_attach() is called by
	 * iommufd_hw_pagetable_alloc() in immediate attachment mode, same as
	 * iommufd_device_do_attach(). So if we are in this mode then we prefer
	 * to use the immediate_attach path as it supports drivers that can't
	 * directly allocate a domain.
	 */
	bool immediate_attach = do_attach == iommufd_device_do_attach;

Jason
