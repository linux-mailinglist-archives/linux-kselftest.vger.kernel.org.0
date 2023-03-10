Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707216B4B59
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjCJPm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 10:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjCJPm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 10:42:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A813D1C1;
        Fri, 10 Mar 2023 07:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrmQOFu7pY+G3v+EwfZXCdW/nf4ZNsV4b64lq17i2yOhMOnvRpXB5vzCWaCLELZM8wMKTk2WtWXlvXewOcwWonprMcv777aHpD0RJSdJLwMM4PdpzIEJ5VFse1yyOAfzBhX8kVzqhqJuHWmf1E3Gi4DWHnLC+IzCadJGvfYCTwdcHVWbLIVoAK4oGVmKsO7wcZ0JewZSNhpBiuNljwxV4lKyi3ha5HMpMOaENZ6RK0dh5sCHU17Mo5hq7jP6u0Syu9NyxcLpVW88H+LJoomAxpZonOBlROwGLXwkOSbpU/0stCnE95COCni3KU/DsG9pIUW23rM+e/vFWOnfdKFXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxPn6KK0fnpSqYbqT6ygoKSKYFOl2psE01HXDRz1NOI=;
 b=d2DBkcVlos27IbKtZygWgiMRWn/nB4nAP0Z8/f4q/kypusdPQCv5rNf9PH+eFXpUABp4Bn7WQ/LNpsQYy/CVwA+/inqTlgqY087BPc/+cr1eVH4R2SSvGI/04Hcb8EYxwFCmZjB9ub5QVTbYbtUO+/ZJ2bvQDZyN435l/2wPvhJQLXWsHYjlUAMalpF/omodPYcC5Lnq6gHByR5ngrkTQqAeYXq3azbrybbKVE33HiqWkAf2Wy5jNiTtSQBI1nVV0VKaLGKTdmuvCaxacOSKJQfQytW2wNTzlsozyE2FJasdZw1OIOoX2SAZ/8+YjiLiqHFqeIUknr1ALRXV/8pCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxPn6KK0fnpSqYbqT6ygoKSKYFOl2psE01HXDRz1NOI=;
 b=doA7O/swJXW7Wt3I8L0l9jWIqoilbNqN/Omqsb/xIaBloPKO9QrIoxuHZZztBHQxFI4kcbBi+/eUlCa15d3iHTlWuJ4comuNWjAqmMT3oxH6kIKUSoYFopeAav6qdp+My+cC2qGEwDf859DDOk9xuaChQvZDIlCq0gLJmich4wKFce0k0NcFptFbNgUOXdTmGykP7wO4Xf01QVeNKK3Nxn5V57ZgkBeVGNTx/+Zq5T38r4gg2afio6fg8TRm5cNo06rnnLZljID3LfW2OV2nqABEj/Jtb0yYMqOKPpLmj22A/PN1v8YwOXsYLB1Y9fEQg37OGC8w/AY9CxYqn0FE4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 15:29:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:29:16 +0000
Date:   Fri, 10 Mar 2023 11:29:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Message-ID: <ZAtMyrAOyWV1mDlx@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309080910.607396-6-yi.l.liu@intel.com>
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 755f4eb6-7a7e-4354-7c14-08db217c35d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lj11vrTJPh6cqH75++oFnwk9nBxpfNNfX1IMqsSNRucEaduXzzz5LMEy6Glho/g75qP3tg6O7T8aJsVmeDdCL/yplfzXs7n8N1CwY81I1jGKc0/r/WPGUbyNmt5Hz3enn4hHC6ALtJOHMGMKwpQYm61r9WIz4w1hEsst+CNX7eIa0lu9jAKg0lCPpPbnkyFx4M/S1GbRKxnCGfGTZaU95JBCbJnUztzWzbXTAsxKgLKup8+exMOaxtb5KaJ2h6NXpzQCP7uQ1s7E3vzqKQRNvqW1vhaOnz29M/yYsIhWh/o22UL+hIuXQyOALgk4Ti8SLbIRgGV5eKAeu6X4BwiIOhqr7KWCS3lTzK4po9FRtFPus/cV1LwXYGMrTLM8vUs0IVZhuvRjTKeNC7bsL5fU2gbpOBJDTjlsG+bkTGX2WgaGNsS+C2xYOEphvi/2i6LRmi4y4PMq/Ulh95RuiQbRqltbZVHK3K97B9YBvuPbDliHIU1QodVAWqDh7ZPR3L6wzX4hkIMUfd1rgN4b1ZCmGrsntFncyUPP7bmRg/FyW2JmUEb9vEF1wANQgTR1JkNq7HiSmY37n5SzJjjBD6v1wDZ7hC8x6GotTDtMNFjCg5swRuakE4oKFb1ii0KIA2KTteki5v/42YlRJNl4nQOIVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(36756003)(83380400001)(6512007)(6506007)(26005)(186003)(6486002)(2616005)(8936002)(8676002)(66556008)(66476007)(6916009)(86362001)(66946007)(4326008)(41300700001)(2906002)(7416002)(5660300002)(38100700002)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8xjBOw9be/oFjmX/olzzETObieP1ZEj6r/ZZNvQw99zm6BGKQq23oN3OyYZ?=
 =?us-ascii?Q?poslC/A/oP0SPunypDNc2NNZJIhrIh5pT9i8PRtMWKMgi7Alb+YFXLBEqrRb?=
 =?us-ascii?Q?0srMXcZqUcwqWuEIk2t0JJFCElAyuPX76Lq3O61O4ysfbX10wsc087rAyNY+?=
 =?us-ascii?Q?0+m8QDpnz/4RSjIh02+MQrXrQkqxvotk6SSJdqZR7TdBzvFD/wL1/YrgAQIk?=
 =?us-ascii?Q?pDOY4YswW1F2UYFwxPMCLJX8sIhCLl5t3rx6vnm2SfxDVbl0fJwoMY50VX1X?=
 =?us-ascii?Q?GOnsvK42nZpEAKTUwsfZJ16Wg0BfuoW0GW0SSbDK3FekYfx6mZpMmsGCzFec?=
 =?us-ascii?Q?fEJmcR/Trd/CTykrGw+M1H7+DhfL3gWa82ug6szbgmbm/H1dl5RvAA13nO8R?=
 =?us-ascii?Q?BTngqtMMJ3NB+FFDt1BcWoZR0UbgF1Hq7+XIiXe0b2AVxKBq2vQSZoH78iXk?=
 =?us-ascii?Q?VgXWXA0U8UlK61FeP1xzbfijS5cLv4b7U1WNi5NSZZDYGDdSjk9ee2XFJ6Wp?=
 =?us-ascii?Q?J3cVX3Wv6dND6BRfTW1nxX6XFQeo6z5UtA6+yCw/NWTDK1NeRiZ/YsJTwfux?=
 =?us-ascii?Q?dnLhkjIfXsLtXshL1TX3IIJI1ztgiQUMinjkqmT62CDMnoZomko3CLILApGE?=
 =?us-ascii?Q?XsRDKVqRm3anxEWKuyShwvBVVaznkn32Igd9+kHuBXwecKghjEOExxXDF2VN?=
 =?us-ascii?Q?qkUSFagRGtc6UlhPcnEkdopfoCVdxZiDi0Qqz5Ri6emqr0CMsdsth6xFWCnr?=
 =?us-ascii?Q?Ks7EwwrbDnXIdNCSb8/UEWBUv7j40RZZ83C0ZUEXaAaHfeNyO1PzKLslb1CN?=
 =?us-ascii?Q?HJI72ZKxfZA1G1hK16ivEdO5n+jId7NH0dY5nRJHvbZrtXm173PSAFJP1iQ4?=
 =?us-ascii?Q?ZdUsPrwT0wKhdj1AIlt9zG2TQZFYT47QUHDjKxP3NcIWfB3jgluw901ckX7L?=
 =?us-ascii?Q?fqjEF7ruNzPBLSM1FNvbMLkf/A9e+EFptbk6dqjUMPV3Lv1RQT10jWUk+0wI?=
 =?us-ascii?Q?G7shMPT1LYeO8N7LlEbsh8aIP7lTbg0Dl6IShGHYmjzJZRnc6o2y4dMNp+Z9?=
 =?us-ascii?Q?kP29XBoB85gIGwBxWBsPhgIfX59jNVNFcnc1MFLuWGMbeBqXclCXMaSi1caC?=
 =?us-ascii?Q?fJmIPK5y1uMAq8FcHMy3wDPo6FLzdGM48Ld8V8fnQB93MjcKhHKhhGs5mHFD?=
 =?us-ascii?Q?NrmjPdRfBEE7Z6Kr+EE4oBiNX9mWmOO7hmb9IqMDoqVxj9ktz/IhxoCP99dH?=
 =?us-ascii?Q?jSWkqUlZAeb1bU+iFOMCVi7Yo6SJheKFfF1WjPE2pC8tZKfsclVjECxNxqbF?=
 =?us-ascii?Q?ztntIbXURQe3f48ZKu26wehRolHb/lhUXyMDf6c3OVbSKgn+2ibgjeoecIsO?=
 =?us-ascii?Q?9LdGB7fnePeAo6Q3VIdANG/mKWPaLhYfByWHTdZx7XUapfcamKOh40JC5RW5?=
 =?us-ascii?Q?DK089oX8PGN/fF6aJiiEYrpo6CnYzJ/a6S4YIZo0pl//iVdbTb2hOGpEw8wI?=
 =?us-ascii?Q?8gJKyiwlz4JwWhl7CClmxZWKp46xcHz0qp8i4o5oD/aAQWK+80VzRAmrvvDt?=
 =?us-ascii?Q?qeoPMBAuaKqoDrMNMlLD80y25iz5DmCOGbwe+F33?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755f4eb6-7a7e-4354-7c14-08db217c35d9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:29:16.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NCSsLKoF9vYSEZRxBC+0fEpQjpl03xRZjXDlMUfWa+atmTiBex/P7AZn7DufnT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 12:09:03AM -0800, Yi Liu wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> A user-managed hw_pagetable does not need to get populated, since it is
> managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
> calls into a helper, where the hwpt pointer will be redirected to its
> hwpt->parent if it's available.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 16e92a1c150b..6e45ec0a66fa 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>  	return 0;
>  }
>  
> +static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
> +{
> +	int rc;
> +
> +	if (hwpt->parent)

This should be:

   hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED

Ie if we asked the driver to alloc a domain and it allocated an
UNMANAGED domain then it means IOMMUFD manages the mappings and it
should be populated from the IOAS.

Arguably drivers should EOPNOTSUPP if presented with a parent in this
situation, but still this code should be clear about the purpose.

> +		hwpt = hwpt->parent;

And we definately shouldn't touch the parent. That is already setup
and owned by someone else. Just return and don't do anything.

Jason
