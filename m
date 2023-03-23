Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F95B6C6B0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjCWOcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCWOch (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:32:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F471EBD2;
        Thu, 23 Mar 2023 07:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0oH4y8+KWriXVb0iEFQlLCtQl0jg8NuH6gByYYW7IfFSgJG8boaRkLE4vu9+tLZ6c48q0PLYXe/dYr+94lERvuT/KAvE//xqttnJw7tBgAMt0feO5Er36sbp9DqN3EWMH86lJoCXckR+fjPF/6wFkzVGyTHTWBVwQG4pg6QCMknOKP8EHV6pYcf5uz776rI1JYVeov2eltkib4zEgkkoleqahne/TeknLt9CraRR8R9/VturjS4Y5sPZ16RGHBrrz//Bgh5Pjpi8xG1eFygDGAuX9LnqHXCSfvVbGDIrRREkfx5LOr2qdWTY/31OVxYvljjcqZdpOFElXWRY8wwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB8LV45cqIR8o+mGlI9klcJoPJEg2p19h+u8nSLW5tw=;
 b=j1JqPnYOkRCawZsSTes6Nr65hcy0tWbh3opbO/R4+ZHNSIG8x9HBsOLkqNBlog2GuA9tHXMLv1jk+oI+WVTs2mtSjatg4UYoqtIAtwFtwvdq9Z5NtFBUDwU979axd54g6rMf37dAEtvZ6cxRTCeO4+z3FvRL8nJmwqQdJyICm1x45dT3jC8TIE6wdAn31tnEl1jQc7Bi+JjOvTQVWFnYJ9KhXvJCinDcoccWY04VIV3Hf0mk7O188YDR55He9N0FrWgzbP2sZvITS9HAHeFfmBYHiFEuU6RYJEQYlF/2Jx4jM5rDARpsYo429fV0y0plNd6Ku1tssgrk0TFVYN4UdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB8LV45cqIR8o+mGlI9klcJoPJEg2p19h+u8nSLW5tw=;
 b=l+6PhOhPvxE1bqncl0egRTk9g9MZUJJLTlaQRNeGzH8xtgecE+cpGphIUhX9mfyVQQ+le8NzdsOBqqFyK66uJ5FnNFFY2FC0HY63JSNzOumLuPa2apZFtyRYb46kj0oHgFQ2oI97jAYrIzpO0/UjZDwLe1W4nAX9r82JUbO43qxQVWlK0s/QtGLbgDSaY8hy2Ppm2WjGgb70sYWtbtt930VKgpzet+asuejrrraZrKYprVEWGW6G8RRIFkLadvVZ8Tu8e7L0RbNRbkqwfW4K8WGIuN5zg27z2cLP1UKDF98JBVLz0Q/S9+TQjHMwtoKWujFUtqIMcL082S4gk+oNSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Thu, 23 Mar
 2023 14:32:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:32:33 +0000
Date:   Thu, 23 Mar 2023 11:32:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 14/17] iommufd/selftest: Test iommufd_device_replace()
Message-ID: <ZBxi//F9AjP3fsnY@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <14-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52760F599640FAEC7A4C41808C879@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760F599640FAEC7A4C41808C879@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c1a422-efe4-4c6d-36e5-08db2bab709a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/nZebPxxQUPiYOwZTZUXlC5NwEZvcFf6IhiQxsVuGdluC/ssuk4E2cwRiykmWlRd1oE06EhIdBd1/UMu/3HZ97Dfn68uZmOuqpIxKCXOI469xgoZn9BSdWST9ur6Hy0zs+GxOhLsmdtxJKCU6ZkAlbVQ+KI8wAVXBYO7ClBPWl8amegvqER1apoUBbiX2TZNQ3inzTIWByZxgXRSKhDjltwSGWlK6w8YbCvN7t0VN+SbagSNv77JRp+nxdHm0t6HfS4L4duSkp9HL3E9QqQmr0q+BvFMlXcbX5VjKFeSwh4oxVgG0SbBVefKOYE3EoivC51g39vCZx7nWntIfrdSaDYKSXV69iGDLuRlkAPARpTPOsAOI+DTFlxECBRzBdvuiFnPQ6Kd3PcBJfJET0MkGc2c8SgNwMHUVcctxXt/Jq4BQFsCzhSBhnOFNB9WCX5WuiCMXfx7KVMu4+68HkVGqDGmZO/zCwRdkciHW7VpstBKWjPKpMxEIo6Ms/MKhF1jVWDIVMiNgsInW7J0wE5iitzVz9INiNA6sMojHTKALX3xqujNEGy9qgrzTiknOQHNJ/KMPoL1yJ6dbBAY4fXRl7a2avc6rRmYWUW53ZcFH7z9RL/3mkbM+GkIsxL3TYmVgbcGtiq/sWviPQ/GqUNiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(8676002)(4326008)(66946007)(66556008)(6916009)(66476007)(54906003)(4744005)(5660300002)(41300700001)(26005)(6512007)(6506007)(8936002)(316002)(186003)(2616005)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJXpYEc/gWxa8Q42G9UDZqq4MGKjctoa4AKxKNFIOSkn92phqsK6jeM81Exe?=
 =?us-ascii?Q?abm78EEH5h6o63UetBKKSBhxOVpiWSSkIGH4uEqq56SxoA/DZaQwke49+M1+?=
 =?us-ascii?Q?awwU5+DOo9f39+s7lm1rJLzU1mGQErkROLaD/xGaJViwFI8vBhfK5UfpxvHy?=
 =?us-ascii?Q?SPdtKIQjGZVwrWqb80/NTcKuBLiYl7sn0BDx8Uqt/AreZq6WJ8mMb56oAVXm?=
 =?us-ascii?Q?hfQfn+Ng31R3fuz/fLLqyncgoIUSBpl923RarkyVDYx/y3t4/nGIACg3Menn?=
 =?us-ascii?Q?PwXl/1gKo94uFD78KaFEkmNFGDUhJ/0KcxjuOe8tGxjXMfzcW+yi7Xfzdi9i?=
 =?us-ascii?Q?jm43x0gNeCdXCTsE/zAaz3RY/wQWN58Qx7Egf2Lae7W67Wwl4VZkulCzxlSW?=
 =?us-ascii?Q?5gs1WshRHAtl0XgQ8zwU4loFxzSyXZTKId08gSWYh8ngL00F8xlPC4BT1fhr?=
 =?us-ascii?Q?zfcWFb8FaDTiRUHSF8wEOXDwC3/MRa4faQFSwXvhYJhaH3SYDcQMaM7TDhRl?=
 =?us-ascii?Q?dvZc+mAiUR85L2xsctAXTd640CzgFe1KIVYAfRR+03osy4og+B61pjonTIQP?=
 =?us-ascii?Q?6mKbwpCaLERvrv9u1Ho1dwmdXbu8SnpZpZBdTx2pCX9YhzAytWbUcE1QPmal?=
 =?us-ascii?Q?2iq00Kv+SrSmFu8kqWku28M8Li60U+CymhCIne3mGHA8tLYbrKdwH2erpNMF?=
 =?us-ascii?Q?xJ/8nb79LJyZ2SD8fTDyG3e8n8uxbqFNy6Do01M2P3c58goP1GVMvoJKkNZi?=
 =?us-ascii?Q?brmn7RSK9BuQ/JsT5LnEaJIeet9QlLzBurEQ2DHnBFMd9d+tIJ+VsK24WaKy?=
 =?us-ascii?Q?2lMBHBcEwS+m59jeNlez+LQC5L5WYmUtVlPYe358y5oB4hIeXXwAZieu8Vh/?=
 =?us-ascii?Q?ToPZRWPlkQPUFzRdNeD8wHAC4PxNulro2rOyC+w8TztSPBtirOvzbv+XXO1+?=
 =?us-ascii?Q?fty5M+Sg4dcHOhcFkJfvzZPKJXHSRjlI31MZ7LYuhsp8I6ndSE0XJDV2nnlf?=
 =?us-ascii?Q?gMxxoIpNV7z1fEG2i0eJ48uSkuvjc1zsCRYhYPRriGChiR9ePjkDrvHpNuiO?=
 =?us-ascii?Q?HI46CRj3367P22PYvHOhdS22KykrSKOAfwj3ixXsc/TpEvCsIpBhOievaMS9?=
 =?us-ascii?Q?wYrgQ7w9euRYR80Ld3D/r+Uzav0OmK6ne2Po6LqIu1L+g0c90nkXXAjkiXxM?=
 =?us-ascii?Q?f/IsW5DOfaivHL1pOoi3Dd6WcFNBCxFcQLxDncTE7o+X6GHgO8Wg98AUAfV7?=
 =?us-ascii?Q?TdvXM4yBZ0UsypQLNcqgxsb8e9mCQccRn7kzBg8bRzyEXeXf+xGqoUd2KA9+?=
 =?us-ascii?Q?71pslHtsF6DoYVcer6i38beFbQcgqd4sPtcA1kK2B/1lftmrAvczMnRkk3XT?=
 =?us-ascii?Q?ANV2yYCtphIzWi+7JaMPK6lp1TDUdLp5rrZ5dCa4+23zYXOlCLVFqk6hG0dj?=
 =?us-ascii?Q?ovGZrYA7hXqPg8pYz6XCzUNMQX6WpmUG7ILkG3jJwy4NZXAYulxQWl/NQp8n?=
 =?us-ascii?Q?RLhY7LjoXkNkRsJ0bfmEnEaV91oFZ8knPgh8KA+p+U08GilWfSqV+OvWQOTN?=
 =?us-ascii?Q?TMjLmga8kXh3HGCKtImdw54MdnQfT2xgT49uKf6E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c1a422-efe4-4c6d-36e5-08db2bab709a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:32:33.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvesP2ZAiPVLKWpPBNRI5TW2IfxDZneSUOjHlkY0j0RJmPNZySAfEVCt2n6Ff+sF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 07:57:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:15 AM
> > 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Allow the selftest to call the function on the mock idev, add some tests
> > to exercise it.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Miss your s-o-b
> 
> > +
> > +	test_cmd_mock_domain_replace(self->stdev_ids[0], ioas_id);
> > +	if (variant->mock_domains >= 2) {
> > +		test_cmd_mock_domain_replace(self->stdev_ids[0],
> > +					     self->hwpt_ids[1]);
> > +		test_cmd_mock_domain_replace(self->stdev_ids[0],
> > +					     self->hwpt_ids[1]);
>
> Duplicated or intended?

Intended, it tests replacing with the same hwpt

Jason
