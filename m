Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05137764D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjHIQQn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHIQQm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 12:16:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B50CE;
        Wed,  9 Aug 2023 09:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT3WgT2Ko8g/eFsrIYyvjLftiqWU4gZM86lu/ZZnVyd5YQUT/Dmz8NapiF9EST5CJ3J7pbx11CPu5J5gRlFxrdfkVjbDs9BmzK+ckAgBfk/be4zaby1T0uzoOua091etWRzXFCf+mZXBOyR22cbayFwaG3ZEYMRKDV+Ls9naBpD4kz0wDwQtF4upEwJ3FFokyxlw6shiWW7PLg3y93QykkHOl90FJ7uw6n49KXpbHx5GOjskyApKbDDkdrwDXkU4V9+Xa7adKudKelAEm0xgfCSiqIcP6o79hI1a6nYGnxsvlOiFWom5pv4ZTM4NCUn9wkDKU8YUya/XFdNsK5jmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUi+X9Mk5dfSIiglxDfaThphw6gZArIuBWPbvUtVQEE=;
 b=NayBnpCovCtEzwMOqCJYCspcumigHJj3r597ZENeWfdrIe4LlXHYyI0XvGrgq03EiZGRd4/Pwh9AaQM/IpipGtLCYf0z+EhXs4Y/Qr1EHmcjaqgPdZJ9xUDTMTbhC+HQZQ9PK2GzmghuZ4McUPzZ0Pz9COYDdP9ilUTjn+v0/xlyYyer673j0iSCQZ/Z9zwF9JcT6iT9yovR26Y3AiQJuMIjDbjNcgxB0kohXFHAi31nBtbTBrAQSiFJFLOdLT2g2MApNzBJLKHzznlqhGBSpmbiJOwvyhSeP7N0AGPKFFFu8oIoK/1de+gKBhGZenn32Z+qabAy87Tjf6MwycNUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUi+X9Mk5dfSIiglxDfaThphw6gZArIuBWPbvUtVQEE=;
 b=eihUf9/P2q4WvMsKKRpxSFlTBKTPFbmmztxa9VAtbhNMKp8MdAL0ymexCBQzGIjG54mcf0Pc2lUvpPhj6V6ycO9VD4zRfeQ5e4Cq8QduT8SHACCs6iqIcD924gY6/ab0rDYT4mwqwno6qwjk/Lk2D0TEldN9FmS741ivWV5tL04QKkJZwyiR5hoRZkKu742jbRLqyiV3TSqGOoQR6DExNfP6FDcKm+CX6OmYCCdcAhUJf559IEwY2YB6DQh6eYclBqw70WetvEQHsjOQm49MN0XPKAHdBZ9VgpODsFEyj3HnKClzkskIYQ/4ryrgr24dAwsc5ILAL1rQN2ZqtF1fjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 16:16:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:16:38 +0000
Date:   Wed, 9 Aug 2023 13:16:36 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNO75LVZemR0YZUR@nvidia.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-4-yi.l.liu@intel.com>
 <aa455c36-83be-7757-7171-05460a459a2e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa455c36-83be-7757-7171-05460a459a2e@linux.intel.com>
X-ClientProxiedBy: YT3PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e3619b-4a1c-49b3-155c-08db98f40252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rETjz7xLiKdZft99KyU/DEv/AC6GsahRi2eLuizpH40xjPJqqWILfLuJAPOVXNVfUxwPHlueU/GIcbq8FzoVWKwiA8euV78oaODsPFpR8irc2l3vOYBYqimawrwOq7effs7up+uMVynbz7Vo6D4htnmLEMEOVpy+q/J38M0vPZJE37sjVjUFzeNDwmez+BPSm2kB27AAOOkDpDKQ5YDpTJGOyB2iJgDWElocu93V9QtlmApfXgOeLwUxMIFsBxy+iaFMm9UWvr5Ak3WTxwTdlY2TAurxeGHV+OakXcxZLzJZxPzYWf8wIhULri0rp5A0pCAajDcWfTSVbeDW8yL5J8XZu5iLDRsuC4Izl9776j8B9RFNVM95C34c/EMm1ocO1xk2T52J+aY0qBkDtmPm0Z+P9L1z3jUqPpAwpDrFC04IqnB0v9x0qCYT98oK00IgjQ9kZMvcILCG9nSc1QmKn5SrefYPqOYs2mchRbRrrB+Uvrf7IU1IyiqYfN8NQjbrShdG5dIG+dR9ZNA+encr3+tD51k56gB55PCJmQwGv0/kzLudQI/WGEMydr6Cprp8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(186006)(1800799006)(6486002)(478600001)(6512007)(53546011)(26005)(6506007)(2906002)(316002)(6916009)(41300700001)(4326008)(66946007)(8936002)(66556008)(66476007)(8676002)(5660300002)(7416002)(38100700002)(36756003)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TbkX9pvkApsyo9HwLptFrz4YtzLZmzSzoW6IrEL9bqVTWrL+DG+xP5DzzTQ8?=
 =?us-ascii?Q?RPO7WzA68W5pCvVaCMy3BBwqnR521KtDcpL2MQmkf0Uv1x2i2G8vxYpTTI7O?=
 =?us-ascii?Q?e9upLwxa51UojyGCrjNCXi0u6gyiKtmJfeExbh8deq0rUQb8jXHY0dlzz5CQ?=
 =?us-ascii?Q?gWt8m/PUmAgnoRKZEWpaPRHmuqNT4G6+IUDHX6Hpk2wVryn3lzBziYVHCx2b?=
 =?us-ascii?Q?1ytOd+yd6eWaK3eTlwF1C8pSis50Zy1vVsgy3ro24l6drHj+pbsbQraTYnrC?=
 =?us-ascii?Q?rhSIVHvuYWMHJ1GEpF0DTUWB6cUhO/GWcWgTCjWIlRWMxiKOFGYRZzeOkJck?=
 =?us-ascii?Q?bM7JCIqqThLjtLzsUDmjgM6HWozbdr3jZQ0IkvhHyEvj3QgOX7kEfFLsUiHg?=
 =?us-ascii?Q?K185sftoyQvK6lnwEyacCpD5ORMAg4SHxhvmcopns5pYrTtCxI8Uh+nw9aph?=
 =?us-ascii?Q?w276j8sP0hr6p6QB4LGRUI0NF5pTKYqOqFwMkT3QigZOs1wEG8ebdCYqcjqF?=
 =?us-ascii?Q?yhBHwDJCV8FdiczCecpP8MUIO2FpYvPXwtkIU/xfrSBv4yhcBcGUbB10gUXZ?=
 =?us-ascii?Q?7a4BVxSscyAQP3adtqKALIL5jiYNk5a+Ta67y/km6YEYX76GYvYUBV58zwMK?=
 =?us-ascii?Q?jC9oRkmhHIofLQ/9TI1BcwmyEkogvD/LCQrjHDNBmj3rOXMKU7APqDIHTv4y?=
 =?us-ascii?Q?TPJu+4zv5Ikl7Tzp0rdfhOCUM/WONoLvo6uIxd7snrMxPDtZB47Uyn+hcnx2?=
 =?us-ascii?Q?HNA5+oYRSzlj68me+uDoyXuxeyFhZ5Mvu4LvtPV5M0UMfn2KUTcE5zHEQ/Op?=
 =?us-ascii?Q?HoDQ4BvB1HfI0udfCC59pIs2ScC0A1+c/t2LBgxI/QcSp6pnUTAGzUKTED0V?=
 =?us-ascii?Q?QPqXHorg6HfRs02CBEZQ5t5eaStW2LfBrQa53cY+mTUAEG8Vy1p8e3wcm/KR?=
 =?us-ascii?Q?TF5RpcFbg8lHLeNzh3wEBRnH7H1RzgB0OBwyGQQdEvz6GKE0bwqlRCRKw4J6?=
 =?us-ascii?Q?fJgIKUa2nNZUy3bwcIDghXuFJ3scjmTQcMYVYkXSKJ7pknoDSxu78RPsNwB1?=
 =?us-ascii?Q?WIVI8Ep3dYSD+8i62UwJ/uPhnSEwJrL99JGqxGT2g6+McaOUJpw4XfJM8TLm?=
 =?us-ascii?Q?XKxF/Vfgh+YV3lGOcobD7bp0lY1Z/izglQOKbvFW+FMB5gFAc0OZh8VOLwgy?=
 =?us-ascii?Q?1Lzjo0B642yRkH/hawv7WBW3byAqOC6MqTQuL4v1fIm0ymqOms3XmoBv6FiZ?=
 =?us-ascii?Q?I8t4DVJEz6hTdhGD4iuQVT4JLLtYns4IQg1boih+WECxCR24bmwnQYwBI8Mf?=
 =?us-ascii?Q?KbjnvZ5dNSiYwoXP+5g/vfv5O145XuWhvZHxbA8dwt82RjZOLwEhdFkqWYCN?=
 =?us-ascii?Q?FRkYiGt3Ia2fTGtf8eA7uBTSqzjWrFrxsu/CtP7vgciEDJnmf0FbcaRvObGj?=
 =?us-ascii?Q?XVKXN7LiV+ViZGA+iLBXWNr5m+kGeO6AK0kvLe2AHZIjpqgLE6zbPZNZCL5W?=
 =?us-ascii?Q?NmCheAS3IW2oCF/ss8zF26tTc5D3qLuDPAAWqzXyolwtgqplxA2riT8H7mga?=
 =?us-ascii?Q?/0rf14rJXOzIRxM/u0iUAcY1q/wCxVXH0d8vkG/g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e3619b-4a1c-49b3-155c-08db98f40252
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:16:38.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iDwYuIvXKYnPm0dwB9NfolH6ZLGgq3E30bJ3Ac8YUYfyA/exZn6P3Ik9/vuqmHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 06:16:19PM +0800, Baolu Lu wrote:
> On 2023/8/8 23:35, Yi Liu wrote:
> > +static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
> > +				unsigned int *length, u32 *type)
> > +{
> > +	const struct iommu_ops *ops;
> > +	unsigned int data_len;
> > +	void *data;
> > +	int rc = 0;
> > +
> > +	ops = dev_iommu_ops(dev);
> > +	if (!ops->hw_info) {
> > +		*length = 0;
> > +		*type = IOMMU_HW_INFO_TYPE_NONE;
> > +		return 0;
> > +	}
> > +
> > +	data = ops->hw_info(dev, &data_len, type);
> > +	if (IS_ERR(data))
> > +		return PTR_ERR(data);
> > +
> > +	/*
> > +	 * drivers that have hw_info callback should have a unique
> > +	 * iommu_hw_info_type.
> > +	 */
> > +	if (WARN_ON_ONCE(*type == IOMMU_HW_INFO_TYPE_NONE)) {
> > +		rc = -ENODEV;
> > +		goto err_free;
> > +	}
> > +
> > +	*length = min(*length, data_len);
> > +	if (copy_to_user(user_ptr, data, *length)) {
> 
> copy_to_user() returns the number of bytes that were successfully
> copied, right?

It returns length on failure and 0 on success

Jason
