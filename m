Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5C6A4385
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 14:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjB0N6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 08:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjB0N6c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 08:58:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B9786A2;
        Mon, 27 Feb 2023 05:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPaRCbtiXXNYyQczuKlLdsGP6yG2B3z2kjLq4usAs4z9Bx493YzbKBlzT7cIi0qN5w05X7egUshiq6G1fbwF/TQzNDiTQRgaWG1v4KtPQ3s9bLIzfYHwJDpOav8jaUY6cUBjhlvFnblGZyOihbCRphmayGAptgClIf78ljq0llzyNcBEpBJNdWJwXDixlRorzivpRCyo38m/Db2y4Zz9M4S+g7aXUiqrPjZGDkEgRKLFJv3QTlsUq9kg4wZCYM9H5NiGhqv7FBN8Rkvsop7IfO43WVjoS5c1dODSWdqdAUYVQkHjwuBBkEdKQRqS1FR+knOz7JXyYenWiMlusVOeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7QCcPOiCh3WaTU81+S/Lj/+EfTgBimAdK8evtaOpx4=;
 b=fFejz4E9xnhoxQpkGmo3tzjLHFiKynPYtJ7W+NydfTgarYfE77+tjjq+CiJ6LQ/IgDmMxX7+ZNDiZvgqVtl/0NvzbnIS8bdsEGgl137bt9MHpzfXec2NZUkCZwDtnerMzmrmS3ek7Z/6dawiRjaaXXjwKtre3g4oBH9WU1HKURtVji7bHH8DgOET7kLTQsQ2v+CATs7lVGHoIG5aO49aJfDc0EO+39XzpoCOHn1LUllAJqpQ1kFt+OefIWWyvEkpuQnWeXqyX9g7Vq+dnmuw4+jNFgIvyf1ZK6EK+dbjn4H3ouY/fDylWFKBILmf6IsGShRKrIoO/lpmvnZvqWi1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7QCcPOiCh3WaTU81+S/Lj/+EfTgBimAdK8evtaOpx4=;
 b=WXPz5xCXWFXR3BpQihA5DTcMMu8QAA0jKf+NAd1ZN8m0Grj+Jp8wi0JQx0KgBWGLcTV72Crzs5nziv46Ru1aBW6KrMr0UfcE3/LTdglBDSGBGC0kQO2v+lPlaP21dyHyDyflcy00GMYLbDmZIkHuEOgDs1hKxp+BlgLGNxIS6AjYsE9BMqdFtF7StBUy2aUMQjcZMDzCbGPFbynd3ZvjBaW7UqxogpmnzRlyL8CSJuf3Bb3bM8au8jnfVq6OJgnndGhXnBeFpLqlGbtZIgi6ZG+WWipqOOlD1JCfpNjpCy84pQqGrR25ARuUHZD0/JQHRcgeMPa4rF7vZg+V/o+YcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 13:58:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:58:28 +0000
Date:   Mon, 27 Feb 2023 09:58:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Message-ID: <Y/y3A4LJqunT0ZwS@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <cdbc3707-d326-26d4-3adc-ff2ed80aa2ba@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbc3707-d326-26d4-3adc-ff2ed80aa2ba@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 136b3611-60e5-49b2-846e-08db18cab422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IppGlsq+KYoR/htKQjTxCm8pl/q4xlISa3MA3ifvgWyvOKpfmRUyAeaWeow5Xy+Gg848ET5Lp2X7wgD3C3dVq81oyWK2YOCYT5S3pr3Z0GHYDbZrSL17G4v+ImJfpkpRhQdLODNHtv/r34e0k9U9GrK4tvgLll/7UMOvI3SC5mwAse485hLxRTl7sx666jzETK9aAlWntdTgaMOIi/WrbPL3Jaleafqd3K5HbS7sviyQLpJ7Xd9WM8+sMBauilYpm5OB6tGyxiH4zzKojhXpFu5ZsmX6ctHHVUHdsiupWJG9gfcUmhQ/Ku2Z3wIMud27R1IBuZ1s+2r8AQVxlo6JPHYYa1fAtVUVgb9EQjDCWvThhcX840X2pYwRmjXF7kKqPSnGbi17ggOzcVpWZ0s3wW5WQpb1OY0dHE/K58G0UoLLNxlMKRPe/+0xVdqp7HdzjT+kiOj5Feg0LW7R6SMcvi1P8OW7RGdfqoaubszt8XsQWev2I3I2fOm+M029d24pkzDUeKgfc3ZVK0AmUcJyajVqA863wtR60OqJLJSq61PjfffDE950/MDY1oQnvh/YckQWuBn7X5xRypuKlR2CHSnbuaGdQXAnOwzaaXcPH1qeYnYtoS8TawZNy8xledceRJM8hfBqloiJxd5edYpgYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(5660300002)(4744005)(36756003)(86362001)(8936002)(83380400001)(478600001)(2616005)(6486002)(186003)(26005)(6506007)(53546011)(6512007)(66946007)(66556008)(41300700001)(38100700002)(54906003)(8676002)(4326008)(6916009)(66476007)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaOBfdEcAQL4WOg7IX2hhmCUzS2rWLkYoz19jUr6j2KamyCzp5Lo7xCA5QHT?=
 =?us-ascii?Q?QvWmnpDXR74xaJ/n7/qcMs3YAJMHlgliNgxnCLuo1TCqR1mnIdATX/aikkxa?=
 =?us-ascii?Q?gTT49p6fMTCJO8LqGH1gh4iTu9Ojsjiq0oSa9IAYLYDfH2S5/VMi1iVmeNu3?=
 =?us-ascii?Q?iBp7oy6p3GboZGiJgd9zDECKzA6ZDUJn308tAlbFp3FaDm8WvL5ddfCVsD+b?=
 =?us-ascii?Q?0Cr/6hVplX87xn247Kq5xh+SumuC+Xy6k30yExNPfyxPPG1fa1MNJ8lZn3fF?=
 =?us-ascii?Q?ydiYzAK+8xU8xUTr6JM8ndlheMulXFVnXjpw1RmSNS3MMxbZEfFKAbDHy6kD?=
 =?us-ascii?Q?ENv1KCdJ8FwQtD6aAjCPccEOCgzsRD38C+MEFd8LNcsmW3pThCyMKdt/MhL9?=
 =?us-ascii?Q?avcZsWXfXe5gKr/VW73nfRsRsQJ36/7Ep4Z7vaypkzPcJS386u8hszuPs2R4?=
 =?us-ascii?Q?he5uqvYoch3wVa9TH6lfg+8WZrdthKnzEjfGDcvHpYWxM/al+TzV60F/mH0q?=
 =?us-ascii?Q?vKe5AKF6suYf2RZgaOKwoEocOzY98uxgXIdwmGR7MXqvoEAnu1Vl4QuFDJTe?=
 =?us-ascii?Q?eHdmSNhhCzsrpu4kJIxU+eN5W4flsI07T91ee2Mmrft2WjpF5htSqqusUhlS?=
 =?us-ascii?Q?WCBCRSFGWtG+lxK4vSzIL3zzJQNys12Wd7lJQOVGgUa1yM56wzLjeUJ01mww?=
 =?us-ascii?Q?0ICnkQod2LS+7EixCFyqN11x/vniWvzYeNEvHSJRCACIrIXVGUXUBQAoQ/Kq?=
 =?us-ascii?Q?gMoIbdF0wGshVW7PwURKA+kbMmDHzOEWZtJx5fui623Fj/BnWRdTqavLjtDy?=
 =?us-ascii?Q?HZmcOYfuQ5lgvkBC/PtRlWt6Py2F26AUTL90VvaklCW99tvccnQZ9MQrOeWT?=
 =?us-ascii?Q?wuBYpsjxTxtXIFpzJ3reKzS03YUYmePhNCN7cnNt9JFljdqFY2I/rkdjUIi2?=
 =?us-ascii?Q?JCifjxROkeejZiRUH4FI1xZvW+sYEvNwOLE4iMUYHVDpMvAidqvxvQcg+Sy2?=
 =?us-ascii?Q?mJlhT31V139Ig5biN2xei5LLCgjRo9amoAseFVQXZjiQTJ32jBxJGDl3gQzo?=
 =?us-ascii?Q?PzSiCQMVPq4Io1fe93vJaI4cwRGBlsnMrhzVmQkqxvNPSWGKJXg4MrYXgRyn?=
 =?us-ascii?Q?kNe0NbnzMG/cXFfflC81QPUIxkOyUcenbuyPahnIWRu36qmV0qxP6LvjuOvf?=
 =?us-ascii?Q?lqFe8dFdbWvC95vYx1aIjhT1CF+0jwMUaEq1ddfc8CTjcGoln61Xbl/dzv4Z?=
 =?us-ascii?Q?cNe5L3n7hu2LtoV6FAWyl9X5lMGrPXBMNPELn9nxSekbTG71EthR1q8KpGxx?=
 =?us-ascii?Q?uxA7+4l0925+zM6K0uYyCFPoi6QAFShnoyRKS+QFyBsBr2n02cdgy+iiQWsV?=
 =?us-ascii?Q?pdtspon3PcgjqDXSKFT5eorsUx+13YpAlwKS6BSTgmH03ay61XLvWEjCyWNK?=
 =?us-ascii?Q?4uAvuZVfyS8vAD6ZPJNxnpBGrroSLiSuJeqmOY1Ug63WWmJREDwaOLmFt6KF?=
 =?us-ascii?Q?DsIXP5S4JYsQ+n/mM2vzOVZd3cNhyaCjGiQY2LDauRRVkl69d9EcUZKG5Kpx?=
 =?us-ascii?Q?r/SwEHqnNN9nIrPWUgUAJPRCwhw4R22CaIXTOjom?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136b3611-60e5-49b2-846e-08db18cab422
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:58:28.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXVxjK2MFeljMyHJuqeKEwJnzR4j09vXDYyoIJjtpW0E56Vi/+vX0x3VHF9AUT/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 26, 2023 at 11:01:59AM +0800, Baolu Lu wrote:
> On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
> > @@ -437,25 +517,77 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
> >   		struct iommufd_ioas *ioas =
> >   			container_of(pt_obj, struct iommufd_ioas, obj);
> > -		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
> > -		if (rc)
> > +		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
> > +							      do_attach);
> > +		if (IS_ERR(destroy_hwpt))
> >   			goto out_put_pt_obj;
> >   		break;
> >   	}
> >   	default:
> > -		rc = -EINVAL;
> > +		destroy_hwpt = ERR_PTR(-EINVAL);
> >   		goto out_put_pt_obj;
> >   	}
> > +	iommufd_put_object(pt_obj);
> > -	refcount_inc(&idev->obj.users);
> > -	rc = 0;
> > +	/* This destruction has to be after we unlock everything */
> > +	if (destroy_hwpt)
> 
> Should this be
> 
> 	if (!IS_ERR_OR_NULL(destroy_hwpt))
> 
> ?

Never use IS_ERR_OR_NULL ..

What am I missing? all the flows that could possibly have err_ptr here
do goto_out_put_pt_obj ?

Jason
