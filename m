Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943DF6898C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjBCMcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 07:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjBCMcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 07:32:10 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793B879F3A;
        Fri,  3 Feb 2023 04:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=assyKpz/W84+CyVobCxgGMCHieTpuNyg5ei/IT89T0eTT2nUbAWeJgGUz7aS1YqBMi9TNLTEFTyhvQn3y7LHnfwD8kh1AzDJ0OXWXBIN8RehN0L10MomUxR0P1cilngFpQkoqZ9qPibMdCdkEmL84YaWVD7MdJ8Yp4VwiytRMDrc51ms+pJVJk0rzoFIzV6DlxIk1AffhTdUdVY1WmENPnmkbsUS7G8rwT88XDPzsCwojrEJeYTBRWlifXTFxyW8o2ruIVC925ecVKxiG7PtXQTPqwZLo4m5AyDBAh6dmn5EbI/65R3iiUP0pmGIyNy2LcxiYBdahA8Xr3fOnmib/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7T6Bs32OA8nGCSjbcOrXDzcKkR/MGfrPClu0ZEDBAk=;
 b=O7YNYvoGYr1YYLiNHHs52NYpkLZPB5MjuyL3tv6jXT6jDMpja14racDXQ13LepkNFAtthYRjDbXzE8mZfxSMlypvy4ow8thX6xv9d2MVxkyRlvXI0J1XGaB5AYFL+PbTMhX7GWvGnGf0wcUJmHzKaeEFjVtEMx11drQzZYyLqllrruyVWchYjahsUFwNyffwapcgDD1eIHfiFZn8r4LeecT2WkU1M2nwl5KN5oehdTo4DPM7IVwW0AtieMjahcVNV9S+8OnrIHH+YraphV+DfOon1YHva+VdABFDrHRlPnBi1a40Yevy4y+aJUZm5y4IxiaKzoLKWiz806VHa6hNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7T6Bs32OA8nGCSjbcOrXDzcKkR/MGfrPClu0ZEDBAk=;
 b=tBd9go4KlRePZA8AXyMjShmpwgQZ4ljTbjmq7up875VWcKR9AYozPPUFXlmjyD/fLyhhxaoi/mHI9X+KZgKuPU1ZTKREAzdclS1BE/mS/tIUdM38fGWysE0xW96kL4haY218e/2XcemlDId9QSoTE4psciE+iALlz2jYpEN8HWsRMnrwpQ02XghjmsinGw+DVGasVZvjUNhI+4TXew9VJPci9vwhIoEaoCVRayaJKp3cjk3WWI0sH8b2Q6GPlr5Qv8Xt9tED+7wM2/nGqgjuJYSLajF3yuzPMa5hy/ugXfiufrS6RUqJN66Y8575cq26/enOKLLMXNhOFkME34/vAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 12:31:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:31:54 +0000
Date:   Fri, 3 Feb 2023 08:31:52 -0400
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
Subject: Re: [PATCH v1 5/8] iommufd: Add replace support in
 iommufd_access_set_ioas()
Message-ID: <Y9z+uAbYtgk30no+@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <bfe5aed6d354ef547979f0b256c8a3f9bd5b223b.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276D06D3F9AA6202E20F8E68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D06D3F9AA6202E20F8E68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6457b70d-f310-45ad-bfaa-08db05e2a1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfG+/K0/WYBDTmLZTuZnWTRiDdL2aWsFTY1KREMDvdiUHN2+74tr2c2uKy0tRfGkt7zQc+PSC7Go0Q2W6fVJmn4dNmcAWOjqwEkYVYYDwNtW6ugWzy5SfAbDFSgFbnPv3C8JERO+mjchKOtA8CU7As2dltGASnTEHDpJ0bat6YQaPhYCSFEaFYXSxThMfKC3s1+oRfqyPjh/0cDuMb9Y9QNnNyqg+j/eeqy1zhNWcFJy1AIZSxUWtt1fLxQrFjQ/++0L2q/B0z2f/+ed7RWidNjIpuYHCXGu2jLsUP911h5QgHjnpVR+Ym4prPgiGrhYlOMYPgh50XWwx3kxaSB+JJtI0FyCMHsqg6IiKU5al6gLhX0dgPrsia9Sy4YIIAmv9Roe04GmmKJPphJ869/8+QUmiCegR6+JOFDr4q3dsEbpGF6wodLoz4lxdgYr6lLcgrAwgP8i6Yxl6JBjABTUpYMP8gdOx3byMJzPDkIf9ePWAYk9ySUJfXUjxXABq72EGo3JuWgXq8TXUKB4HUYOEHDGAYnenJ7r9XkJTmsXARX9XD3O65ykrWS6IXe7NJfrSQFu2NysY2jNwfBwZ5Vi0nkXDodJMd1qTO7lN14L9FTHtyOhazJ9UVZXjvkXF5cekceNxTi/oQCV6jjSml87Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(2906002)(66946007)(4326008)(5660300002)(478600001)(36756003)(6486002)(7416002)(6506007)(6512007)(2616005)(26005)(186003)(83380400001)(8936002)(66556008)(86362001)(41300700001)(66476007)(38100700002)(8676002)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkF6uAXrPF+8obsAq6uhSeZL1lo5SylV+tLpQly88ytA1ImNp0dPzs2B0UTD?=
 =?us-ascii?Q?epjFD/zY4T0lQ8YDUrHukJBNl1RcteD9HeuXm/2R3RiV4kD+lQqsYOMERV9D?=
 =?us-ascii?Q?Q9S6CIbmKpVBvemEb/lChoxLaAwYMAaBf7b1vLO87l+kv/dotDOnj0elLeAp?=
 =?us-ascii?Q?MLpbknpGCzjgnob8d/zUnnpmkUJjApaW/I9I64E5hyEwGENxnMCo2L5BTmj5?=
 =?us-ascii?Q?VXeXeXMhGhn0KsACQf9aOFo8iRaAMmqaqiFVinEO60TrMvmZj1ttXOyttJp8?=
 =?us-ascii?Q?IfhOYkiHXWYUN+eC1L32+BIQUPdgQdrfIMdXyfpROCo9pm7Z9t1ZQMbMqRUD?=
 =?us-ascii?Q?ppPShw5db/yfz1NOhhQgxwd8mmSVguTCDDee4Uz1A/ZcYIhZC0ZrNeNOyPYV?=
 =?us-ascii?Q?L04u9TK3AqnSQXXVhWUef8pu26f6olii9vUYSJCvzfycIXifhEWdvQUMYjT5?=
 =?us-ascii?Q?1S72tkYUWATim2OWSRrEkKPGQLPb0BTZmuBDMVTCvQ8Q+2FZm3gOXGhAfZob?=
 =?us-ascii?Q?dAJ+mNtxiMbuF9iHnjUEIwZDpBiMOuDkAxC/xlGBblK0Rih/9ScCaZJdO4xF?=
 =?us-ascii?Q?HfMkZtwoEeJKrRBdpNlNDpRBVZejC0uvyq8EOGYEkIj+Cuet+aZ4BF5x0RxP?=
 =?us-ascii?Q?I+yfBm35ySMu7ThFnAR+1+HNt+2MWS6+pSJAQrBU2JqI9ChgtvcFQ5bY1fek?=
 =?us-ascii?Q?X/IlyVmGV1ssh36j54SXGP0UY1hJm5XpPsl4A7riEUHTxi+qZsuQhCbn5+VF?=
 =?us-ascii?Q?9jH7XEDxFiVHBwaJGa+ivliTRz95jHt7LJ9dca5atRJtlXHQFozgnsKNA8rJ?=
 =?us-ascii?Q?0CKe+9umWLMgU9dl3YY0tgIg0UJ+LYu7HZKrg4lTcHt+0KSM7+2tiIjal1Hh?=
 =?us-ascii?Q?Sh93I3VV5AmnkxNAm3L3O/vL+wNMsWFoLUczR60OZCAXq2VlkV42iEfF/Bb+?=
 =?us-ascii?Q?gIZPDiAOsMXvx4ffisrZXIn/bkejtU8K+fW3Gt9umpN2CexPmnnlUIDyqZJD?=
 =?us-ascii?Q?/EpxCRgoAmjeB7iGdusl6XcirBW9VMDr21X+XFhj4ufO+9vXIEyIamlFgsIo?=
 =?us-ascii?Q?ORR+DPPif0YnBNznu7HU+5mq8hOSiX5DliFWKMXQEr2tpz3IyfxqVkpfOI/s?=
 =?us-ascii?Q?HNLMCIJnjZqFqvWSRR9k/Ma543rzI33EckeZSc93UvWEsBUKPRI35ZAAV286?=
 =?us-ascii?Q?6Z3bo8tM9ldev1MjTKtoFJmmVo8TrcrYs8mfFWSqEBfoMNybEowjFoM/pWbN?=
 =?us-ascii?Q?ww+P4tCqYSfpNEhOy5IXEPw55i0LYOX5gROXRGNFOZvUsT5IazbwFQBSmOds?=
 =?us-ascii?Q?SsHxtjpqfgXJ/U3CUd+iee+vcRyb+ACgGqj2ElkLcHHmpXkq1kcM4n3Qau4p?=
 =?us-ascii?Q?EVf+HReRWIuRCCFF50L+8JmZjeACsZHCQrXUvdkTlThdaRLewEyzo34lBtos?=
 =?us-ascii?Q?ajWzQVYtzX4XCmaED7vWXjbqZC+850mD7Mg1TMlwwjEh8hbSEmRB7GQooi+q?=
 =?us-ascii?Q?pgV6QtGaufabYySOGCqMGS2PD1Cb3WMRmUVFBxC6Tv/Ux1RtUDTHQxw7lvBz?=
 =?us-ascii?Q?AwG/SRmBQv1UdcGtihlqjT7XL6aPQA7REDkAb3aB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6457b70d-f310-45ad-bfaa-08db05e2a1f5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 12:31:54.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y9YQfGzb3+5hb63vCLeg24EBaYitSCQaJpMx2tMx36fcX8Hc6FtvTI1/i3q5lFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 10:10:45AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, February 2, 2023 3:05 PM
> > 
> > Support an access->ioas replacement in iommufd_access_set_ioas(), which
> > sets the access->ioas to NULL provisionally so that any further incoming
> > iommufd_access_pin_pages() callback can be blocked.
> > 
> > Then, call access->ops->unmap() to clean up the entire iopt. To allow an
> > iommufd_access_unpin_pages() callback to happen via this unmap() call,
> > add an ioas_unpin pointer so the unpin routine won't be affected by the
> > "access->ioas = NULL" trick above.
> > 
> > Also, a vdev without an ops->dma_unmap implementation cannot replace its
> > access->ioas pointer. So add an iommufd_access_ioas_is_attached() helper
> > to sanity that.
> > 
> 
> Presumably a driver which doesn't implement ops->dma_unmap shouldn't
> be allowed to do pin/unpin. But it could use vfio_dma_rw() to access an
> iova range. In the latter case I don't see why replace cannot work.
> 
> Probably what's required here is to deny !ops->dma_unmap in
> vfio_pin/unpin_pages then making here replace always allowed?

That makes sense

Jason
