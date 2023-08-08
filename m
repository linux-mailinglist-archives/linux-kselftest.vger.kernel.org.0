Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F975773CE5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHHQLi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHHQJh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:09:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A307A9D;
        Tue,  8 Aug 2023 08:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGej0hLFj/Ij0GDAne2yjQc0OZF8yCh7T1XBVy8M9Tmr1GQWB7EX+E1BBSvMxIkC3cZ25OOHhGJlhjWF7RJVk8YfNGcMH62yRCzx/3PM0xDpA7hznrEL+t5aIAtRleCThFjPAWxp+dDU5HMjuH2DMjPX1cuJumpUm2qwcOkjj5rZ9fJggTyoRuUMdz8AIJWQORXMbDrTZxjJTGRHOV7RVz+H+qPyEAGmU+Rvw3uk0qs5FFwG+6M+/7EykWpqRm8jPJSWTJMtbSm9IrQMCjA15ip+0yHhj/qtVQ9H6Ky+qZAeU/iXbHxkxICSci94GS3kDoU4aBQHc2VYnh7MUOXUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tov05UDfCoSIw+bfX1b/1Wtpy0fYLqHT6yk1cdjaYKE=;
 b=kW9uPizH6928CvHu2m2wXEggb4AvlgJrFshIFvYAZF0XyNZdMVBhleG+htpkyoL0Pdra/YxJ/5mYKkkNIsJjHVoAjAoApiE82Xpu2pVHCptd3bhI88TA+pIXKleXmL7kl5eaGyi8JyLNTLXhc78mXpEbjPgtnxPuDaBPs/F4ah+WqPWcFniZJJRaAfvihJx7WnwZyaYRpO3rE92pLi2lkgpnNL/+nGfo7Z0zIY2UhGaMD027eRGbvbF62lIUJbwUVfAZO9hE7x/YjSf1HAmD7O9YvdlKk7J67AVEkBv2aWb3Ih4f9M2gogc1MBWdGXKoBOClO2cdPLHdsPsccwg2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tov05UDfCoSIw+bfX1b/1Wtpy0fYLqHT6yk1cdjaYKE=;
 b=Mzp9X6P86Ad4epC5RHVDRxWfGtMIezgSuZ9CIzwA9uMZkW/RV9NyaOZQfGoMkvbWcgTGBw7NHRCJR8Pvz0ipgh9SUEsie/0hGu+QNPXzhVv0liMMA26JG6ncreXpogVJHltFoQgVhzZARgG2q9Nfyy7Q6XsGcnLyK79oxk3M5Y912P/aEzFp1e2Fr9lc5NvSfTNHCQPMSkZEiUB4EGMTKciEBBSTk1J/q/0Xnv+4kPme3BUDzgkOQQ9u5JezCuGUJw02RkNDYPXo2fEY3vx4guWQBqX53VC/2F6MCVbxigt1E0xs21gknb+5rT836flq5SRCCrV96vJvZGy3LWCCwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:02:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:02:43 +0000
Date:   Tue, 8 Aug 2023 10:02:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNI88hEKdIt7QJHJ@nvidia.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-4-yi.l.liu@intel.com>
 <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
 <ZM0HO02QRHnIKIIJ@nvidia.com>
 <DS0PR11MB7529E1B07B438DA42B0C9F81C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529E1B07B438DA42B0C9F81C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2031f2-4cd2-42f4-585a-08db980fc0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdMAaN7+SJhWCUCVA58RSqvu2WbBkVpb9kaF6U4W71k54ZaYqDtvIBMcFo7eYA9VW9CxqdJALp7aa6zbuBempxDvaUZXenBm/kDn/bcNhs+L64vznz2UhWuRqrBwYKOeSSclalwEBPZWlGfcypbpYvkxgv10Qz04jPFG2PFYF6BIWDg/igZfelqwsbW0l7N61iH0kKFJ7zNqGhqUm983Y1xbezBLMnyQ0VZEkAiRtHO1Lp2iJJW/FkcNF/u6wl9qNywGWYCeaGqGbHH6ikzG0/pcNFU9QzZ7FYY6XcgppCoXe/xEF7Cx8xBo7V/e0Ap75riIbUFalys1OMMi4xag5oZ98fAbvVKUOmq7ZOhHlrdz94F9G2w937FRZm9+zlKFIWo2dh0QzLb1YH7yHG1Vq4QjC71mCdSwapBT341nahBDd62omWIPVJX4w1XPutoD/8HSA5Fr0WUcSWvevXQCLXLIGDTH+o3yFaHAJ6XClgJ9ynotolHExZf44Aw3jZgelehb52QYnwtMETca0cBcyUIbN1gLPfQcsNBjOLV9ZFs7GzmdRtasanS/ddv3qbMo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(186006)(1800799003)(7416002)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(86362001)(4744005)(2906002)(6916009)(6512007)(6486002)(2616005)(26005)(6506007)(36756003)(66946007)(66476007)(66556008)(478600001)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IHk7eahEEY+tTlGowqKeOkVlCM6IEC3tuiiahRsAco4IKrV3cnVk99NGNddm?=
 =?us-ascii?Q?qJX/AKwd9Bx13GaonvOOcD7UHNp2tofmCc/EgzktEIp4HNyYoyaPmVE3t0pc?=
 =?us-ascii?Q?KEL17KSp4QMONWYEDFrO/+MhCPC66AapE58i+cYUl9Of0HPkewKHjIXXvW9x?=
 =?us-ascii?Q?N5r8rXfzZtNHSmlo83hbW4OsZEeTsItLeogPgc1GfqxljHbZDYDtYEHl5v6i?=
 =?us-ascii?Q?sFTL5BbiHAGGVeTLa5RWQLzHx7OQOXKeKkzWW7g+oAAOI1ixkD82VeDeu1Ux?=
 =?us-ascii?Q?9C7zQI6klyUi8nt19I8hMdhgPHD+7NTBguKAHdMNEoSmCq3WEpk9NaRchJHC?=
 =?us-ascii?Q?jmkHX60Jpy9zWFyxybHv5mI17ufH18O0MyYIbVkX2SWdq7+jlREhaopQGb3k?=
 =?us-ascii?Q?8+g1VsON4UhORVt5Pkc3RpYtKIvawr771qc7MC+8mSV/31i5Va20Ex06I6Mu?=
 =?us-ascii?Q?n/Nf/CvTA2423msyNl6z3pdivLXgue5oM+W/QdMI5PeJRMJUYeoC7VMXfcXO?=
 =?us-ascii?Q?OBtvF3tvxO9UuT0RcX/zEw/n0RoU3byESzEOmzDwUd2598LqqGkeFH76oLkS?=
 =?us-ascii?Q?2iti6sfSk2L7YVLf2cEeBGFQ9X4S8y1ozZL0Losc+lepuNJWy8WOgddJYNoH?=
 =?us-ascii?Q?XXg6uineg8wwRlghxlzQLdPk49kb0lUA3DCHGXhobhwgYteSyDgrf0CNzJ9n?=
 =?us-ascii?Q?0UcHvprIS93ituHzsYwD3RvCjywpQmjUJIF1t63Y83MiWcvusBF/Z7FmvJhK?=
 =?us-ascii?Q?XJj26R486EMdLCnNBlHCA168CoiukoB0CgKGmC3qAGY3Bx4SqhhpodU21VQQ?=
 =?us-ascii?Q?8JGeh342+lKnfngNW0S8zwnCDYMS9lmi6rsLEEh7CflpSnSgnsfmjgH3B/tS?=
 =?us-ascii?Q?UEI1S56ObLpZ/aEQjJfGdydwomOEkFQ3YxW+Vz9fPsk1mJzs/zBoi0rn2WVI?=
 =?us-ascii?Q?UmnCP1JlU4dJm3lxHaFT6oKZ6qDbjz2bzh8kRW7FP94cPm/e3B6O0vwDHPmO?=
 =?us-ascii?Q?eccpvhIo5hMBXk+3IikJAj7hF/OU5Da/GVelpJLe73wb6z26HeTw8O0xKlLq?=
 =?us-ascii?Q?gObWMJPrv8PhovZpuTsxjdAX/5Q+Dm3MHE+b+D7Yla994Rchd0we4GHanLog?=
 =?us-ascii?Q?GU9uwCL6riy+mYcc4nYJh3IkBrK+4A3f43WvCsL2w/2UY2pglcI67WvPWVAD?=
 =?us-ascii?Q?9SB6hHYLRE3+OjHcwrlAfih2p0j8VeJ7cF8jNzj+V496pSZvGNOQAyoDQIfl?=
 =?us-ascii?Q?/e2XZ3TFm74UH45r4AQV7wrQuTHPEQSrMrjXOVGsCwexPWMQhAVvKIl+Ajpa?=
 =?us-ascii?Q?gGbIP9K5kegf2sJVJq9P7EW2eLRBaU8OlCEyN+X2ToCnvVhhOiQ366UfzYbF?=
 =?us-ascii?Q?fLZ9crQw63N+XNjgvuNv3yRPws5V2C4yT5B55yI/MvWvtmiM5nFoZaKjCqch?=
 =?us-ascii?Q?gWUY5aHmo/in+ObS5rxTkp4bnEHo/aUiA/k1IpZJytPNUbmwDiV+jZQUJcQi?=
 =?us-ascii?Q?/IyXpcIEfPuAuc8i79MLZFY3aJCvJmx59ib1srjPOi9pJMuD4QwkCVR3QqXr?=
 =?us-ascii?Q?fJPtPTp3PjlFYeyBXcOmFiawF8zlhW+aCt2mKr5d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2031f2-4cd2-42f4-585a-08db980fc0ca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:02:43.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D7DIM1QnA7EuLBvJfz6aQ0JiZ2yZBB7zb2RnO2RIdu/oTPgc/eolI35Rh7Terwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 07, 2023 at 08:49:27AM +0000, Liu, Yi L wrote:

> > > > +	/* driver has hw_info callback should have a unique hw_info_type */
> > > > +	if (WARN_ON_ONCE(hw_info_type == IOMMU_HW_INFO_TYPE_NONE)) {
> > > > +		rc = -ENODEV;
> > > > +		goto out_err;
> > > > +	}
> > > > +
> > > > +	length = min(cmd->data_len, data_len);
> > > > +	if (copy_to_user(user_ptr, data, length)) {
> > > > +		rc = -EFAULT;
> > > > +		goto out_err;
> > > > +	}
> > > > +
> > > > +done:
> > 
> > No label here, put it in a if {}
> 
> How about below?

Looks better

You could also consider putting the content of the if {} in a function

Jason
