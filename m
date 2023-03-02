Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C56A82A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCBMv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 07:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBMv4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 07:51:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270544A1E1;
        Thu,  2 Mar 2023 04:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOnmiHoEvBc7TpMSThtfFLbZeAHa8VlvCfYalaFKkGAFfaxBmBuLCzaZd9FJ7WiJ5nkD/LqrvkINSCpe2GIQa21P637kJwA/pvAC6Q7cM4qRm6ss+WOE1PkQiY9k/3jNUgTFtafhenInNWCFatSibJO/TAGBm8/urfqPoNmPf8H0dMQdjgvgF3LKOyMgcR0QFpkzfGXyT+2vFbqZOv61b1skcDihDfQlyB+b8hgo4oZlijI9vRXfXToLCDiPAnNEzr1wM9oNzuS3ieBuCbnKg3ohbJ8KMTSFha16GhDdPsszRr5IbigrZs+zrDgrxfT9K+eQxB3X0Ac90rHdMF7Jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxDfzwVYWyTSJw9+2UBLp4eNI5Dhwmhg71nqxG/XpHs=;
 b=ORfW+JpB667ni7Hz7nEO6ntpFV7MKdgpZRT5MKJZscxoJorWTnVrXdlX+Vii2EjRcB8SDDNf4fAtaQH9oe9keEA33Tl9dOAtgDXkzWJMP7IuGNWRB+96jkKXnBroH5HnDICyhrP14hDXNBfaxzID+2saRVispmvl/Tfce9JwophNUZ24S0NzX0kzlPE/gcFCVjB4ZlRFbwY3DPcTML/z5LQeXcFSTQXyLzl3QI//Sey024wuMK2kUwvsWcti98JqlIzyQQblldPqTjbD+GaxZmOLgMAMC42D9rfJ19+z76/jT6uDpPh/YBi0DbDvh9dVks/iqQY8KCIF71CypB+Yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDfzwVYWyTSJw9+2UBLp4eNI5Dhwmhg71nqxG/XpHs=;
 b=h22CTg7ufOQitN5rHEzGiUDKCFhWG7pt1BxH6+se1mPGjFdaqwjhrO/Aw118sdBKduy7krkPNnfT5Kkv7p4u4Gj7nXcsP/DowygoO1LQ6xlqSlxs9TaaPw1DY4nmDS4G8JIOOq9YEsqj7paglTLBllT+UfMhlRC540wlIFM7NPG3urX+2hlFwnqXFDVGUeGWySio73XR3SsNQAsFvSHnzqM9kmsgCVVS0xuDtWO7/zATp0yOuKuImQgnm3TzS4ExZWIz2Zv8+ltvG59vXi3Am8h6NsiQUHDDYaD/cMFJwD/tKhg3GapQOI8U/33PZEdeCtBU68jQM8gqTRjECK409w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 12:51:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 12:51:51 +0000
Date:   Thu, 2 Mar 2023 08:51:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 02/14] iommufd: Add iommufd_group
Message-ID: <ZACb415lOsmjaJz1@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52768565CB65BCACA4E3808E8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768565CB65BCACA4E3808E8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: bae6e56d-af9b-4e13-6d22-08db1b1ce4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybPzFBkNG18Fc2rR0rbD88nGkS3ipcQ1DZnVYO6yF6iKOPYtFVKtoM38wk1exr2aYtFgksLBvbLTNk0E0bb/O+Th67am5V8mN329AhQfLOf2XpHnUQJi5vXMlAv82gKQgWzGpUiyQnm9vKjR53hqLtJDeONmGNxHAu8Rul5ax4kgyUq00dC2//0+MGXvFYu0jcCfdqQTDqElm7D6lQE5EnTkhRjEhr5jcJk1lrnOvuEsgRonAAaszwFCE6SQv9p1uqFV48VtHwBV9McLG4Obe0SpfAwRT9I+zntcqQ7j1ulI5dX+7tL4X4HCxoaU41yY9U+V+olpALS/S+pH7N7roWCB0jGGAKa+QbuI+cePxwAbKUWfodUL4X6ca6dWSJXMVjL4y46CEt6SXC+oEBrDZ/E914u+nz2peQzOd3edJTOaRUOlYUKQX+14S5t58wkMHfKycVl88KCGaLf8hgIxUsl5jr3dUq6uf2qdM16VNGQocJnvkR0Y/o6jY8iqdihqtecSv60+quGAvI4uqObcZXfKmWN+3cfmKHGeGvDXXIPAyMk2mTC1CujXbCAHozKTr+3fjnojyZW5EgWYrJn+3jdy6ZDNn9cXXVkq9TNs/GMnIgujGI3aG8VkGAspg4KncTvKt+VBHIWFSRHKh0tlew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199018)(36756003)(6506007)(6512007)(6666004)(66946007)(66556008)(8676002)(66476007)(4326008)(316002)(83380400001)(38100700002)(6916009)(26005)(478600001)(54906003)(86362001)(5660300002)(2906002)(186003)(2616005)(8936002)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O4O/bM4f0YY30MsaMZWAPSDWl7ZLOX7ll35q0rNsyO1jcvI+Uj7be0SDdHs9?=
 =?us-ascii?Q?3PAiH9D0X345rJWI71OQkX1aKcm1O56twmg7KEZ3BoBKw5NaoRItF1Yt+qB1?=
 =?us-ascii?Q?2g2d2HoMghCBazHJNXbC7dnM4S6T0kQ7IHqxlU+kR8yeB1pby+yAEdJNsKhu?=
 =?us-ascii?Q?IDxHBvpvaVA0HI3CY/AO13ylW0AV/lSU+t2y+NMLaOxGPU/5JqmrWOFD4Wn9?=
 =?us-ascii?Q?MHu2yrSJQ9bYq08J3rOUy8qeeN7ulpU+U/vhzBFXo+Cvkj3znlUy8uH/AQp9?=
 =?us-ascii?Q?ypkQRhWEFL3ri0zC/4xGm+c9z10tV4bdhhvbCbyRP9F+bEpDO0qzMcnxg2XZ?=
 =?us-ascii?Q?ta5D/gscZtHHMxo5Yhf8Kz2cU4ByJimCwUdIs/NS24cabUhstYGNNx+Q+SJV?=
 =?us-ascii?Q?SRD7rkuLCQDXWmbM8EjeOdrsuYQNcRY0dmehd6MfeMhpV1cwKROnSMoSkfSV?=
 =?us-ascii?Q?dYF5A+FpRiLwMIKt0o7vY3mFbhTX+vKutVxMkhBqSfqtfG8OMvtB8RNKE805?=
 =?us-ascii?Q?twNfE3xKDDK6rcMUFCGi9LWoCBn1hZlok1CzqUIoC7yE6lyQuysk0VL3zZFN?=
 =?us-ascii?Q?H8cC4AakTz220XmntVB+fBtUe77ApxydXUeKg+idEvuZOi2I04trrqhCI4s2?=
 =?us-ascii?Q?rtVpx03M0o1cF5XXkQ5ukE5kB0jTke7/Zdlbl6Wlfum/pedcXZkCqlcdtfd+?=
 =?us-ascii?Q?sOWQlN9jGM7zsuq4ti3sf/gg2XhOd2Og4dQkIMVuBidiWGmvHZTEU734HxmB?=
 =?us-ascii?Q?9OsQAzZ7j5n5uMjDFpbFKxKTa43QDIo87hC2yS1QkmLH7Dv191H+CMLhB8pS?=
 =?us-ascii?Q?5VMqydNhOXpOwqT/am+T8JjF41Hip4KpOP2BZCe9euTktD4Wd+/kcKe/VA0D?=
 =?us-ascii?Q?MLGf6714bQdemfzWSf21zad86bnuJCHMDXzu5h8ckH7A9IjLQZCWAhtWby2x?=
 =?us-ascii?Q?CLOr0vLlkmF1DjGQPWYF6Uc5iZjjIndcbjTUti9LEiT0VKbd4iA+BuMeGTvL?=
 =?us-ascii?Q?i6GjxrI8kMhmv40dGzgItYxBfFyF4A9l3+pVJ++QXbcxM79845CSj/B/KX9y?=
 =?us-ascii?Q?J2U5o2w9YTbAy7drRGwGbWwFrg/YjKGO4Qg8999En5I/ld7ark3Gsf0tk66I?=
 =?us-ascii?Q?ijyGuT5OImOyatBONzek3t4ult7OyTXv2Ce9NaUAqIEJer7Ywhnbjgl+pqIm?=
 =?us-ascii?Q?Naw+qYeXSF+4EpKcu+0bSJasq6xYsYKIBhJljxo4ptvCC5cQox8cMfQoz9+y?=
 =?us-ascii?Q?TdIEknu85goJMceiMZukmH3rv55TIpxE1sou3Z0lfuczyIOX6QUKfDoHyPwf?=
 =?us-ascii?Q?pFr9rD6BzqL9dO+WkRCRJhJ40REjYH0nD+XIJjlAhX4yFFZD1ox2Yp5TCa42?=
 =?us-ascii?Q?MivYlZKXHPaJIHzcV4Ac9m28Ol8iAIFasH4xWwB8+eJ4Un/jYhdAx+agQlQV?=
 =?us-ascii?Q?voj/0eu16Y3Gwr7KfjvpO2Chx2vFM+qakFDIL7278MBfZiOY/FJu7r3tS560?=
 =?us-ascii?Q?uSe6izc8LhvBsPB7jMTQkXzO3lzYPsNPw82onKFwXC/8f6SBvw4tEoz9yqYF?=
 =?us-ascii?Q?mQvJAwVIxGCkO3h1e49EFxjM0UaAPEKlQM/oPqfD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae6e56d-af9b-4e13-6d22-08db1b1ce4e2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 12:51:51.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y849Hz2S+JxR4lwfcZEUDkQIuPabjqgBfWXwWF5VMtMfOdNMCSDqMNRiRQSdawql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 07:55:12AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> > 
> > +
> > +	/*
> > +	 * All objects using a group reference must put it before their destroy
> > +	 * completes
> > +	 */
> > +	new_igroup->ictx = ictx;
> 
> Looks the comment is not related to the code. Probably put it in the
> destroy function?

It explains why we don't take a reference on ictx here.

> > +	cur_igroup = NULL;
> > +	xa_lock(&ictx->groups);
> > +	while (true) {
> > +		igroup = __xa_cmpxchg(&ictx->groups, id, cur_igroup,
> > new_igroup,
> > +				      GFP_KERNEL);
> > +		if (xa_is_err(igroup)) {
> > +			xa_unlock(&ictx->groups);
> > +			iommufd_put_group(new_igroup);
> > +			return ERR_PTR(xa_err(igroup));
> > +		}
> > +
> > +		/* new_group was successfully installed */
> > +		if (cur_igroup == igroup) {
> > +			xa_unlock(&ictx->groups);
> > +			return new_igroup;
> > +		}
> > +
> > +		/* Check again if the current group is any good */
> > +		if (igroup && igroup->group == group &&
> > +		    kref_get_unless_zero(&igroup->ref)) {
> > +			xa_unlock(&ictx->groups);
> > +			iommufd_put_group(new_igroup);
> > +			return igroup;
> > +		}
> > +		cur_igroup = igroup;
> > +	}
> 
> Add a WARN_ON(igroup->group != group). The only valid race should
> be when an existing group which is created by another device in the
> same iommu group is being destroyed then we want another try
> hoping that object will be removed from xarray soon. But there should
> not be a case with the same slot pointing to a different iommu group.

Yeah, that is the case, both the group checks are WARN_ON's
because we hold an iommu_group reference as long as the xarray entry
is popoulated so it should be impossible for another iommu_group
pointer to have the same ID.

> > @@ -98,7 +195,7 @@ struct iommufd_device *iommufd_device_bind(struct
> > iommufd_ctx *ictx,
> >  	/* The calling driver is a user until iommufd_device_unbind() */
> >  	refcount_inc(&idev->obj.users);
> >  	/* group refcount moves into iommufd_device */
> > -	idev->group = group;
> > +	idev->igroup = igroup;
> 
> the comment about group refcount is stale now.

You mean it should say 'igroup refcount' ?

Jason
