Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188276ACDC6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 20:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCFTQw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 14:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFTQv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 14:16:51 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8746865045;
        Mon,  6 Mar 2023 11:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJlCQWOWD5r2cpwbrwwofAtBBokitxOlepF4FeGp9fuVDzAnBGcfxdMypmI0Dp6+ARndjbWjOrggtw05FW0vhQzhxCtLg3cmbkUjODzI/NrlSYHXGQUFLQMwJIjJt8cbsAYQbgpbfECniB1ZKGkhs27hlnqsTFyypVA2h8o9WJP6nu1W3SfF7c1itwKTWd9unlnBe4XDDdkErg/F/WrtaWAz8x9sXt/k1Q01+5DbwCEPARSTiSnqcx0rbVqzCkLfRGokPkt5D6VRkbJhpXxodB9zcV4ITMEK4C41yL8WaK+0xoqa4cWio1aK0ZhQM4EyRPQogi3NOJzqe4156Q43bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvT+SdVi0w16eziSxKYGpKOAjksL2zbrHiEQa5BKq8Q=;
 b=SDhOwQa6Tagz7sNqMzGq0A+PgbhzYNpfWSCUdeOa6vVMB2kl4mg0WHG7e6BWavydZDm12p0JKDz3Svw6RsYzIBrPiCQVn2IwX0xYpGLYIfzU/d54TuiGj0eCHbRMZyl4+ob4aOtFTjvIRxAmeUbm+aM0b8tBtzzPobLu0KsRGFHO8DrvK7MUHTLx5kZPBrhQXVXQmZ6Y7d2VhqSjsaGpVhYHbtU/i1utYQK4QcSHXhzRQuFnyBzh2DjdNI5UhfIEp5dMgHW4j94CQKgU9qAUjMSGf1MxZIH24c1mh1uIZYBqL7LgPfLzN7hgmOpoNVsDFn9QXalwRRBDgskRXYwjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvT+SdVi0w16eziSxKYGpKOAjksL2zbrHiEQa5BKq8Q=;
 b=Z3r9UJ+0D7ARF27R+3N/6s3IrdGqPVOV7k6oGHfNmRJDbCLw5WnL6QcreUZKYwLZGXgJKIvFIyj4bND9i8YJAroBWRopeSTAXn+BI0e0k+St/BM3Gfvs+a+VTMuPWYk5V7X+OO7j6hjygXLsQIArSSOz2D8tkJgmXpvNPFyLjeGuqOk407PivOQ2rmS/XjL3+GJb2qBpunEbCYL4LpF6RTRFbnGDQtofJ4cX/ayb3Hmw2wtfQNh4FooEFElhB2C0Ppoe+110lsmYF1zRY0+phyEXDbnnTq5AIyzo8W7gFs1FM879+gCuSdxKlrHwgNoeZpZe+rOE6uYUf0be6OxjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 19:16:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 19:16:38 +0000
Date:   Mon, 6 Mar 2023 15:16:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 02/14] iommufd: Add iommufd_group
Message-ID: <ZAY8FI398003FEPX@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52768565CB65BCACA4E3808E8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZACb415lOsmjaJz1@nvidia.com>
 <BN9PR11MB5276F5AC80DE63A6F5B020ED8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F5AC80DE63A6F5B020ED8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0036.namprd19.prod.outlook.com
 (2603:10b6:208:178::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de918de-c935-4ea8-d906-08db1e774efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNRxXsX45BVVyy056Xe1BaTyz1EqrCxtgsV35aR04GULrt21zM5steOzdmC7WFodube+MHW41tBdIDVMDTsh3J6RHQ1taIafe4N8OfRlovFRQdYH7vncpRc2wSRJHWIN6NqS+1LZGZnHdocqexqxxao5NRCmOwJni8CCvzKCBpgKesb6B65pusc7XxERYaEdkEyPyXcqAahEoYZCIyBG+pMtNL5AQU8VmaBQAn/7JDScuAvneBVOHq5Zz+LfI6wFt4RPXOHqrh0RfEmxFxNgu2PUduxZxQMilNOpoPlh23n5y5ypINQpZaHeL/K++NfmemXAqXz+6y2DzYynGwa/pOGb7v3eqVy25zWOL+pcq6bBT/Lkea07ds42sLbKDfFtW02gRFcdHjmLk8bmYWa1QH7LzioMwVOQmw82hLTy0xDp8SXfLCTmf+mlnBc+etAhxDvH2n5vH6fwrt9VmVbT9sOmOAj4soqY3jHqZwhuqUIUMDIn3ytxdVODOrciBL7+55kqgcRb9I+bcKn6cIZ4y42gIvQhVtJvIuxnkE13HqTYPxxUosj8Nuq0a0nURy/FGe2nyVp0Vc5P1lv7jP6gpxJKRcYncA9dDGV1pBF9o1S6lyQwEAOXXD6yQlGQNg0pnp5DLfcugRrs4/YXcNlvAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199018)(2906002)(86362001)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(186003)(4326008)(8676002)(6916009)(26005)(66556008)(66476007)(66946007)(54906003)(6506007)(6486002)(478600001)(316002)(36756003)(33656002)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cCXIJWPvzht5zX8gAew6M8TUCDPcYRIPVvfkNwUhRd3XWL7RZ/aP5ewBGOJ?=
 =?us-ascii?Q?eyRvrA2vHO/PXodsUtgbY9nNgjGcYwhaIiK0YVSVr5x/nqNBdzK2XYNYcJs2?=
 =?us-ascii?Q?PE6V2tSG/sXNdN33QqAnx/zxf/0EfHBy2qiclkPAsknPdctvwdIDnIZWSBZp?=
 =?us-ascii?Q?K/qjBhQ/KcJIFv6IW2BQ3EqR/talmO8bAQIC7a8EI4G0cgSD2p7fXIPAJh6S?=
 =?us-ascii?Q?/MXYs0ioSc6tQP5wSDO9uNGe5jw1RuBOIGUjZe6fo4vtC9jT5tVI+55J1aSD?=
 =?us-ascii?Q?sN2q9vD/b0JKe8G0CfqrJp9tagXY3fdB4YusUXBwnP992reXLSX8j7QOFD+G?=
 =?us-ascii?Q?E2u03hcle8Jdt2ISnAcZqnA/uoTv9tcPO9FYxrj5NcfFZLtzXwmUD8FdJQWg?=
 =?us-ascii?Q?AxcBN7FExA8QO/W8b2BiYKeywCKMVrf5nxUKQ/mDx0ULisq09h5Mcyth8V9s?=
 =?us-ascii?Q?L9kMLkUdnQTY1FmsAKHAQFiUe7fGgYIriILy/TP8vtRrkbevXFSC8+BQeeft?=
 =?us-ascii?Q?LKwpR5T4d1yJGs3TWlxAZtmXws03uNBOz7AduiBK3QN3Zl5g5SDDNCPGBfHp?=
 =?us-ascii?Q?C/mQTPE4wf14iJRXocOTI8FzkHCme7RAJi+w/Q5Q5Z8/EnSs72KevtbOMLpH?=
 =?us-ascii?Q?Pasg7NrTorce38uhCTq9pLgTst6TQFxDyHv3GnDnkAgnEzcirSM3ol9owMtU?=
 =?us-ascii?Q?wMowff5eftTbfWORw6v5qa9oBruyUtsdaYF4g5akerOnIE3MmIs5cQq8EzrB?=
 =?us-ascii?Q?CTFulWTHgUaiSSQHGrR+bd+YPxACcbHEeBt5I6nMqncbRqUObfUJTyHPicA5?=
 =?us-ascii?Q?PMsXzeoPP1TVauLjV1l16AWIzNgB1drPThVo42t8WZpGzRk77blGiZZD72Lt?=
 =?us-ascii?Q?WZyza6RprQ1/L7RCT3Lsm3cdIAm7hmKGRFnd4lTQpz033vSBBOrb8PLf73OY?=
 =?us-ascii?Q?JE+eOVZ2s6PuDgh9MkpbWRVWIkckwEMds+68UvLj14cQDpp6hnyYdOBpsncf?=
 =?us-ascii?Q?gqjTD3Qoz0aS7ehTnDoYKuLRObFRvSBpfESnlsX/fHxgX+pt2aBgpznpEIVw?=
 =?us-ascii?Q?2BHRQAvWfwte9dx1KI7itnaZ5NP4j7r4hI7K4c+AYlDOiBtXqXb232+m4zfy?=
 =?us-ascii?Q?RA7xt3+eAF2oTV4dg2FpnswQgN1BlfGluyasWIC/Wkxf7X89I/+wRpDT67c0?=
 =?us-ascii?Q?oME2Bdb4WiKm4P04MZtSe7P0fzXRf4CEJ2KnjNK9oleI9cNVm9k1jOxMW30G?=
 =?us-ascii?Q?cFxeJ7WTATbpIFLeQlHvpuVGcaaaNGZgSoUueiEE1rdjST4bmCUJCvpa/1qA?=
 =?us-ascii?Q?hBS7TWsaYrSGMhB5Mwudbkgtkae+mFjCt2vjFB+J2xubNkzhc4b6zC1JSeYD?=
 =?us-ascii?Q?tu3iwfQXTpO3Kd4LQUFlUZB3ZCiJIugS+0YgrQ2Bd3AhZN3zOdpPua6lvwAx?=
 =?us-ascii?Q?iP9MdPYQSiAUKEIORw/uTs6rlw+nEMlUysoCIxGGZl7/RLNq8ZoHBPmGSZ3Z?=
 =?us-ascii?Q?CYNoE6eoADbcSDhWaQ7+jRVgbefCXWdafvUTV0N3ZqxS+/bXmePWAMjpP2XA?=
 =?us-ascii?Q?E8aDal0gRLrCtO/f8dYl5pfvOCUlBBVfCo8oYp7D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de918de-c935-4ea8-d906-08db1e774efa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 19:16:38.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xXafEp2wMj7wPcEsnJnoDhEJl6fpeP+3eW38dai8xJtDvaPH3tH5hEw9frTDFOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 03, 2023 at 02:13:30AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, March 2, 2023 8:52 PM
> > 
> > 
> > > > @@ -98,7 +195,7 @@ struct iommufd_device
> > *iommufd_device_bind(struct
> > > > iommufd_ctx *ictx,
> > > >  	/* The calling driver is a user until iommufd_device_unbind() */
> > > >  	refcount_inc(&idev->obj.users);
> > > >  	/* group refcount moves into iommufd_device */
> > > > -	idev->group = group;
> > > > +	idev->igroup = igroup;
> > >
> > > the comment about group refcount is stale now.
> > 
> > You mean it should say 'igroup refcount' ?
> > 
> 
> The original comment refers to the refcnt of iommu group.
> 
> Now that refcnt is held by iommufd_group and no movement per se.

igroup has a reference as well and it is this reference that is now
being moved

Jason
