Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97AD765618
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjG0OkX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjG0OkW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 10:40:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86BF2;
        Thu, 27 Jul 2023 07:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA0G37Sp51xW3jvHwyqZnBixwDZ2pz43ydxGWObrFyJbsnpuccEEckw5U2TpYJoz1oF1YStwkVkQ6ocNS992bv/P4NTo8ICkZSpGl4zi2KqxtbgB++L9BoaF1V3Lw+11YaQ6iAuCESXDgYLYC9j98McZEVhhJHK0sQ3HPLatPqO9gWusSt4ZOHGn2GUQuo5HYgGvsDNspV+prtY928ywNv6Cp4EG0WNOvKgVrXYdnv5X5Z8UWvT1Mpo9KYE1vrXr9gdF2/csTdahfZqoEinV4GWtKLiX4XafDKi9L30gAYp4nqgvMtzVIQfzRqiff3jQNmq3aH2jdHBpZOFbXDfhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyZTck3bNcS+EKC2nux5qKgwjWd1GQ5h+XStu3yTi8E=;
 b=lDQe90PlcDnJW/Ty9b54UJMp0lfYhj/FcM55vfbNuC1jQIsaPNIAFCE+jkVZ1KsUrbbtLekjJ+og4LuWWzq9SGXm7ymljC0ZD3v49uJhF5ilcoKmj/mVbvxFVCL39PvTqK6v0bEghA9a5vCcgUPtO4jGVkexLWLbSYZItXUdvumajdZecOVTzj570I9EUXYt21qQm04wPuvA8Y95OEcYxBIfYneicekUVMEr9qUQVmF/2ZYlKrQsyf9+8iIFuCutzaUhWu9xFhVAIhjzy679PIgvKKNOgqKTJsfDw7ubednqnJaiGQr7D+fVqtYAqcWcST3XM54RBTu/ZXm99FCbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyZTck3bNcS+EKC2nux5qKgwjWd1GQ5h+XStu3yTi8E=;
 b=GzgdkC/rGz/nZInybe17mUVt/7EOi4uYENZjvEHQk9AcV2NaFtcLblyoepbMdGkDrIpLVXUA3IOE5WF8sa0eE6NpAp7S2t07AEb8BFyK3PnG7QR4W4aITpMWRLRQZMsx6bj+YIGkshL5hkfYvjHXkR+cHZe8nN5yyT5gx2aw8dtz9k5vUXRBw+J60GrWvHmoCMqqs5UVLr2Iu4UpolAdpr3FWUd1Qec2X2pB0+0IHvGm3cYVLWXxhktO/FJUvexgilZPEatUA+sFYLteyFxAgOt8I/qtFObJmB1M17cFC5jmDwa6phb2zx+7yN3psq4lNdJ3t1l/zCGqkUVeWDJiUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 14:40:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:40:19 +0000
Date:   Thu, 27 Jul 2023 11:40:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, alex.williamson@redhat.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v9 3/6] iommufd: Add iommufd_access_change_ioas helper
Message-ID: <ZMKB0XrtGIvR3lzB@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
 <5d7d275ff12c1c991ac80392b19f1ebf5214177d.1690440730.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7d275ff12c1c991ac80392b19f1ebf5214177d.1690440730.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dfc68b-cfe4-4371-01d5-08db8eaf6690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKai30n2wrj5OshP3iydYdgNmr2EfEfVQ4sICYipY+gAnaj9eNWpqIqiPsl7D822n1jww9rA9zF0WK17E35j1dFnTiZp9R8KbdBASoC8+SmK89Ahh9lvuPU6qjJlV71pg2d2FYYB++p4XsiR89a5mRqp/7Q4qLGq6jMggnDe6Dzxym4BfnIg/5HmVOC8/4Ta7JJpjYz5IUvicnVc1MSYAivJoTNT4Y423495k7vLgRyj/fK8jZ6LqBL8v6c2P+6U5qfrjwpow8T//idwHwhN/qrlToVeGVmhRjFhwWCsm6xk2Bh5/B7N+FyTJ7uot4oy6shlWkZzzHJpRJT3ekMPsL6oz22t5udG+y/Cz162VO5nIvHfOqxK5xOGHIMUFPRVqOrJKjs/41MX+lUARXfDxSaaKvMt0m672xI1ZLLZiY99qUXWyMOa2uU7frY4oTR/PwnF5YEeME8o7HklZsnNMSRGpgqBoM4Q7fYVmf1iJVe1iP/VubTws7ORK9X+EJ9zo2Sx2YAsfw1UPpKKmLmedbVoL1JMkh5EqLLjTByxB+Fzye/FtKWjezXPYoaKWNoy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(26005)(186003)(6506007)(5660300002)(36756003)(6862004)(8936002)(8676002)(7416002)(86362001)(2906002)(2616005)(83380400001)(66556008)(66476007)(316002)(6636002)(66946007)(4326008)(37006003)(6512007)(6486002)(38100700002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQsM15Xp9ISVXarzyNh4sLn4Uw9vck7dQQZECCXKRR9C5S1RjIbKHWtXkJR8?=
 =?us-ascii?Q?4FM31rreLGCu7n8ykIzGb+y8ZmWilujbHnUrRQPrngfVxUnxgiSC1GydKpBC?=
 =?us-ascii?Q?Wx745BQAnN1sd0FwvVTMkryxDmrgXObsKc5HPy0Gx+nufMBHJpNk2CsnF8jZ?=
 =?us-ascii?Q?dKZoJgbdxQaMW4/uG3sp0h8A73SmMwtF1zlNCJV0eOuk/S2LbPJnb4BUFGHx?=
 =?us-ascii?Q?qR8F3fJ7F6zsWJtG7LBBGLzJZxTl7TL2X1zQCWEg/YxLWldWqo65n3fX3JXV?=
 =?us-ascii?Q?+wTwkFuR3Rxp+EUmpLjh43Bfm8GRdsbcK5qW399D7Yg44qEzl3zE1b2pNj+L?=
 =?us-ascii?Q?+odEkvSMGtg5HZUisAYv1ZlAT+llQmt5HBgTlZ2fDmXWMBZAjUnFE87iT9zQ?=
 =?us-ascii?Q?8uALIiRcNOimJvoU0qwGZYS/TX7Yo16bYpeDLWAHpHVHlfn62dtRsR4mKX87?=
 =?us-ascii?Q?FZG0MDNK/GPNlFE2+Qz+WlrrrMNYBBqJaGTfUqpggg8hatZndjuiZ91lBN5V?=
 =?us-ascii?Q?wc6boVdjYAK+uUtbMWJ8yBXJpgAozADLz99sxfTg+o66UVtHij0Nlbh+bdzG?=
 =?us-ascii?Q?q5jWFJOKX43jZfw2Q627BYU9og+caiHMcGoeUVpyG1/IHeC1um5ugQIEm+HZ?=
 =?us-ascii?Q?5MRptnCUP/PxKYMNBLmonvZ64mdtu1gZ65xPu+IpZxDG79YrxhS9UYRM2Swj?=
 =?us-ascii?Q?jPPP84thWNqGw4oTTUsHNBl5gBJmZ6KzrU21auFlZGBnf/nict+anJOG4eDM?=
 =?us-ascii?Q?L+L98YfrOQfJQx92D1Tc8Gux6D4Usq5qAmAMAf3pmxChlhv2hbDysYDe8EYl?=
 =?us-ascii?Q?kNB8oiZP35KbJ1u0+Ab+3lnu02Ak2MWNkxCQTxIr0/Zvt87pQqJEJPEPN04/?=
 =?us-ascii?Q?T/0mGeRBuBNXE89LnCgHXTgpJUFIdceuy8xsdmE9wPtVCaERhVFK4lBM3iq4?=
 =?us-ascii?Q?NH6sGlXWjsXWV0DSxuLjYAJ/9/w8fbuNdL7ZZXbjzz33WVy3ntIbFhH1uX1W?=
 =?us-ascii?Q?/GQ/0Za/ukZE101wFuAR0+F6aqCyz1DgNBMZnDuMPkLbmK5uqqF+avybCTVk?=
 =?us-ascii?Q?y8Gq3TaL87M5hVqpIRAr+0/JX6dkP7s5ug7wyif1BGGztDbzvd9/elr9LEe9?=
 =?us-ascii?Q?e3SO0OkoTpjAPXjeukoSDPPyIQZVrvnCB40AwFUMq/lOFIkxi0dOQtTDMsCT?=
 =?us-ascii?Q?Qmbi4v7O0ZGkC+Q87+WdsvlJEAM8ubmGFSAHvT8L5KzVa2+DoMXnOSmOEu36?=
 =?us-ascii?Q?z4WlOTkdjRyXiz7x/jikACmdY7+ZWBTqH1i7NtTY6hd/wl7rmgB/kPts0HL7?=
 =?us-ascii?Q?JYg6T8DLhW+wP3rnnuanHRUkARZzdPF3p2i4pJ6QOvMm1fsSFuOJEf22xsee?=
 =?us-ascii?Q?Q2C8HcPKFCREiB2a7MOPvfi4V/mx1W2ophFQ/TsSgnhuN8G3QA3bITCSrscw?=
 =?us-ascii?Q?uiHufc6b9Me+UJHWiTJaoeKUfYHDhOe3z7oN8vhE0A9ovu11bqPdeOW5TRYv?=
 =?us-ascii?Q?/+pC/reycavnwXjXBEu9ynosHnbBL8o7I+9RQGXWUwigkxkG1OotHXw4ybF5?=
 =?us-ascii?Q?SRqrhNfCVXgDDBGARbRCboH2+5oA24MJhhkjdEhX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dfc68b-cfe4-4371-01d5-08db8eaf6690
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:40:19.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j74f7NOQA/pLcRZFVMxVpOn0tEW8aNjWw/CuLPmPyvJAdCtkCa1OR6nSHJR0Eb5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 12:23:08AM -0700, Nicolin Chen wrote:
> The complication of the mutex and refcount will be amplified after we
> introduce the replace support for access. So, add a preparatory change
> of a constitutive helper iommufd_access_change_ioas(), to take care of
> the existing iommufd_access_attach() and iommufd_access_detach().
> 
> Also, update the unprotect routine in iommufd_access_destroy_object()
> to calling the new iommufd_access_change_ioas() helper.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c | 112 ++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 7a3e8660b902..d9680a247e1c 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -684,17 +684,69 @@ void iommufd_device_detach(struct iommufd_device *idev)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
>  
> +static int iommufd_access_change_ioas(struct iommufd_access *access,
> +				      struct iommufd_ioas *new_ioas)
> +{
> +	u32 iopt_access_list_id = access->iopt_access_list_id;
> +	struct iommufd_ioas *cur_ioas = access->ioas;
> +	int rc;
> +
> +	lockdep_assert_held(&access->ioas_lock);
> +
> +	/* We are racing with a concurrent detach, bail */
> +	if (cur_ioas != access->ioas_unpin)
> +		return -EBUSY;
> +
> +	if (IS_ERR(new_ioas))
> +		return PTR_ERR(new_ioas);
> +
> +	if (cur_ioas == new_ioas) {
> +		/* Do not forget to put since we allow a duplication */
> +		iommufd_put_object(&new_ioas->obj);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
> +	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
> +	 */
> +	access->ioas = NULL;
> +
> +	if (new_ioas) {
> +		rc = iopt_add_access(&new_ioas->iopt, access);
> +		if (rc) {
> +			iommufd_put_object(&new_ioas->obj);
> +			access->ioas = cur_ioas;
> +			return rc;
> +		}
> +		iommufd_ref_to_users(&new_ioas->obj);

Kevin's suggestion to just open code the refcount_inc here

And have a wrapper func that does:

iommufd_access_change_ioas_id(struct iommufd_access *access, u32 id)
{
	struct iommufd_ioas *ioas = iommufd_get_ioas(ictx, ioas_id);
	int rc;

	if (IS_ERR(ioas))
		return PTR_ERR(ioas);
	rc = iommufd_access_change_ioas(access, ioas);
	iommufd_put_object(&ioas->obj);
	return rc;
}

Does looks cleaner

Then we delete iommufd_ref_to_users() as there are no users (once all
the branches are merged).

Logic looks OK otherwise

Jason
