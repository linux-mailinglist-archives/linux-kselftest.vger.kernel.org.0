Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6215D6ACF29
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCFU3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFU3u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:29:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093F15884;
        Mon,  6 Mar 2023 12:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQwrE/KMp+e13UA5diBo9QFawM+3v6qE+tK/mCmtlc2p+6dxPgAIw2/I0JOkycSe6BPN9FdU7mkhrNtFRV2ahi23ZcZYhGC3vsHjV+y6aGEWwVS87OXqmtUxSp7gW42aqm0fcQxajQ7H8RlBAMHForHc4tVEB11VLbwZW6i7jGPH8+5HNLEzGNv0O7FbYPPdorMB4BRIVYVp0u+nW5PgCqV/QmLeGNM7m2cu1Z4Ys7t7mLM9H6xaWr6jIrtWOg5rtxb4Phh/SSqkKbcEUAox4uaHeYDArTVy7h7dsvzEab4T804//QhJSLmiFVTUgLVaF25wy0XIszdQJGQifVTmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BllewijTVdcum5KqF3BufLDeRaAOXDm1iT53Tfx5JuM=;
 b=DwfwAZY+70ZUb1Eft+AqTYn17KgFGO+USlCEYnVJB02KQ86YUKeOwbCtmemO++Mu2Sg2K4ZubYvMs0uYQ6Dw/KRhf4RzuBHSjTLlVMzE4sHqZEhW3iWwHYR5boREPT5KGGfDJv9LVAX7FbakEWuT/8i+aM8iKJptfDDM3J8tfFlPEU+IPTRueIsU0yt1zp95y7t5IRyCJ4AjMK638OuYjCdLBFbfChidHfQ8Usccpqm532rsJt0UlXoFx9X+18h8//rKngKir0j4n4wl5n+UlgNXoler83wo6tyTOq+nPZ8kgdorSsANBNOavjeGlE1KsxidSuu1PoPLrtJnKrTfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BllewijTVdcum5KqF3BufLDeRaAOXDm1iT53Tfx5JuM=;
 b=K+fKAhN+oXBOolxGMYa0wnS58v3+EOtUrnG4IsMoyNTZld/CF31uGs6ZCXIlELj5l3c0Pg42rF/twdbh/uJ+JuCxYgZUxXIHo37QHT94uYtozVXSq8Wd/OISvDmeVkfkNvWDSRpbh6eUOHVIwEKTRIB4OJi83anZG+uUGz0TTR0v0VSnK3njnkwPBZB4H7T+6Qu9LPRauBvjZoV/M6Bj+Vaqdc6mlatye6ywKB88LWa0C31+1vQNECrrOX2VnX56p6fFq0zvTh+jAGymQHC0k+M2sfFY51rFod9tEXxVnlD/Hcsu+hma2cvgJXvNiYffafKpeIChsF7bXwRXIJAZNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 20:29:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 20:29:47 +0000
Date:   Mon, 6 Mar 2023 16:29:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 06/14] iommufd: Move putting a hwpt to a helper function
Message-ID: <ZAZNORtZsXjiT+Fo@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <6-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB527614F2188AE6BC5289DE1C8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527614F2188AE6BC5289DE1C8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ed4083-d81b-40a9-452e-08db1e8186fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwwxrywL8Y/QInBCyVvc8VfZSuS7g9inhBRU0m/X3KmB2F6UP+103EJCUV1b+t+fwtU9eILaLzCHAnhrK4ZpZUN17YQosajkXna4OotI56PXabipbUNCxrZ9RGN0Ye9LprugxZ8by8mUaOGX4sGoY2nGY/H6uTn6y/Bs7ubLnCTZmRJrceyXkt17NnSuPWL2dZkm6XitVxzM+4d+Qt7VFxchsNVoU11YKuHF7YcrLDZpIUCFokvCKzf8UTvEvsK7i6gcgZA7bCO8gGFJiDagCHHxcMaUIBntbiALOn+gNbE2ra+nyUdyF/4m4th3c17aGT5jO/ucy4DwFgAIwFA1R88ksQ1K/qVeItJSguOtqkWgg0i4YimEJuxhi2yLNcjhXm5uHUrv9Z+njRFY2hKVaZtZyyajsxib3V6BtvfnxZNtNL0cO08CnwOsYIS75Y9PJkIG2D4KzdFF+qM+oK/PzY1LZ1//9wIFCtZl6r8YA8iYlpi6EfGC8pxT8MiMyUICzDDE4BPuJGc1iqv+XjOaUQPnQEPsLO2acXHwg14iA7sRNAJsr/lShgg8CklJsfJOKZF8UAzYeCVct9HBQKfi7mMvUZm20fcQYfS7XO2qxyXQC5YenQTiEPNlW5Ch20uhE1FhI9vftmo98RgIHxPUKL6Jo8FVYc/0fWhJ7UDhmkp2GTY2uwybcjZak1ZxDrcf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(6506007)(6512007)(6486002)(36756003)(83380400001)(86362001)(38100700002)(186003)(26005)(2616005)(41300700001)(66946007)(66556008)(4326008)(8676002)(6916009)(2906002)(66476007)(8936002)(4744005)(5660300002)(54906003)(316002)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLMOctTcOakycpJykCuHnsMiwFXJ+hCUrV1HURiY143LvK50ETuXquk+nfFm?=
 =?us-ascii?Q?cP6LTMci9wyo/bXpGHNa6zx89vwS8G8iHYuKZ/ysjwqrc+vvmrCQDnPwY6UP?=
 =?us-ascii?Q?vr+Qk20edRc9GOkvlnGgr3LHqcuWL8+362NklTT1Emj5ab7OQHdtrMOFfnbR?=
 =?us-ascii?Q?finLoY2K8i2HPJ97st2GVYaRtQXAjIRiUOEEiobdcswW/GSXPSJgMXvMeRJq?=
 =?us-ascii?Q?F3yb6IPlb5EWWt46y9lv542P+kOgVuMGAwtEQLHKsr74n7rQRdQrA1ipjefk?=
 =?us-ascii?Q?MT1NPiCKq9gGzxgpyPQrLm3Eagq9nsRoHwp/iUZ9Y2L/uy3ba+/cbcfFTWa7?=
 =?us-ascii?Q?gHxfMv3RLmv8M+YmNhyfT9rndHqW1oCVhIiA9FD2uQsK03v89gBWO0Nn0eti?=
 =?us-ascii?Q?cyICR5mtZjBICvxsVVCSsWpQpWiDgJKDvXD2FEOhP0Xbk951rXc4smcxWEK/?=
 =?us-ascii?Q?iOzh8lfBhgA/4KZskUCqXSdn8JWH2uj7raNQJUt5IGxt0/yP3JbvEdsy4Dyp?=
 =?us-ascii?Q?mHuwj7RV+ncgPTvySuSWeKKzU4Jz0cYUcEUNJKOEBtPfwT5N0fE0HqhfId4n?=
 =?us-ascii?Q?aT89/OJrSKfXnhQesovhfVLEbQSSJmvEWXf12y2zJnKHQSuP2JDygrlKC33L?=
 =?us-ascii?Q?Ztq85j+DVf5MSj77BA5KpcM1LyTY8PebWFiqE/rfqQKwv47STqEIN01zch7d?=
 =?us-ascii?Q?m/EETgOic6TXBEwEqTAEU50IYxOnS9aCaiHAvFwtVgTez7lfP4hEFA2wuHoJ?=
 =?us-ascii?Q?02Bb9P3AAqIYxQGuRtiv+YVmiIidw/01RKHEKwZH1shz+MCFeMmRokzYNxUQ?=
 =?us-ascii?Q?JF5dwK8/QOi3UiIILTZE4KPFiewEwM/r8BwHsDnLrXXtOxQ7pffg2TRUyZOQ?=
 =?us-ascii?Q?ckP/N1gMVU7cDPK2mWWBYSdaHZ6tA+oh4YazV1Ono5ge1NbZtv4dp8TODGoy?=
 =?us-ascii?Q?AEUA5B7UgYezbhhFkyiVF8X80NSaFCdY1TXCr43YQHoptPTLT8BSwRlAglIt?=
 =?us-ascii?Q?N2kNRwpcI9Zd0CDttXkdJYz5rAgPjtd9Akg9gkB0QqAFC1yOs9wKKBW55pmy?=
 =?us-ascii?Q?c4zc/U+IDHuMb7pH/Err+eQuP/5Hv3FRjEhI8rMiFiGwfvRdN4gYwm9Ekg9E?=
 =?us-ascii?Q?Bw6qkdA4zrayff0fMvQfi7XgAxH1qrYRrFk3NYl+yRrNUka99KOL7SNNvn9a?=
 =?us-ascii?Q?Wh4Ulr+gYOCWYVWqjjrmg3enuQLDFRnwayb4OOgEtFCb1d61NoG32KAIeEzF?=
 =?us-ascii?Q?pQIDrG2DHVAoN65pRk8BHPuPwPic6tgHSJt5xufwVcTgVkAzGtuR/Rumt2it?=
 =?us-ascii?Q?7EZArVf9Vs19TA8lsPj9QYfKT7fhb4N6d5XSJoKq/2pIohoNwWLX9InKNre1?=
 =?us-ascii?Q?KwX72a6Vun47vFIz2iUcLuo6OxHpeWM3dvcrxtx9fpXNmIf0zg3Te1cbUgM+?=
 =?us-ascii?Q?rlDMDj+mVBveVBpSM7OTTIo94i5K3GVFuTmGS8n8ycp2EsUDFkeeU2QpSd3a?=
 =?us-ascii?Q?3MbXGZg0U5jX8UBNg4ElUbj0hZpbjkv2abpybQcbkovqSFn4Jx/KRUZzdef3?=
 =?us-ascii?Q?GpKoryLTkAhIMbUje+CJv/MpnqWtrWpURTkQWEc/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ed4083-d81b-40a9-452e-08db1e8186fd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:29:46.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jJtsyV0VTQjlTBJkxVVP0RHvT17HQh2XkV6PG8DotVe/EpejLocUzvMFqnxw4AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 08:12:28AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> >
> > @@ -481,11 +481,7 @@ void iommufd_device_detach(struct
> > iommufd_device *idev)
> >  	hwpt = iommufd_hw_pagetable_detach(idev);
> >  	mutex_unlock(&idev->igroup->lock);
> > 
> > -	if (hwpt->auto_domain)
> > -		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
> > -	else
> > -		refcount_dec(&hwpt->obj.users);
> > -
> > +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
> >  	refcount_dec(&idev->obj.users);
> >  }
> 
> As commented in patch3 this should be called in
> iommufd_hw_pagetable_detach() when idev->igroup->hwpt is cleared.

Same answer, has to be called after we unlock everything. The issue is
not device_detach which has simple locking but
iommufd_device_change_pt() in a later patch.

Jason
