Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BE6B118E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCHTAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 14:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCHTAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 14:00:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A9985A5E;
        Wed,  8 Mar 2023 11:00:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFwcIRPdhZuFdhBgkM+1MRH6W9tNQH81B0f3xBlSJEQkHdZb+JpAfI9AUf/gnme1FZnqZUPrRVPzmO9C2SAyvrQccuFZpm5SRb/Gi3aG9Pr+p8zLSfSrPzVLGf/VKGdHcgeqtdXFKpT0/a3qGmgea6ut8wqVbQiy7kwXkHUj8BgGlmUZxHprKKe0k4jsPk/cMg+77Qpm//aWk79CFG/Y5nCspCjdIDeVR0ykzEJiRV6x/FDnsTdt6n2OV3c7dUBeqwtbWWITf05UR4/pDMcBFsBTg3JwHz53mMMRdHgvG0wnBBd1Sox5RuONypkWZR9B8vQsz78k2j3nGqyyl1QvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbNX2+f3tHAjpjr2m5Yz11nV3hVhKhRrygBPWpJMkeA=;
 b=eLvKCb8Hb2PtwjicIZHaVptLOmiov/JFVqWRa7xhdRx/lQhdX4/dEOWHtisBYNzabztGyjZFRh4+6ytOdn7bgDNsVK1QSz1KuCQKr1RZZ+j3QU+EPVUOxpqaw5/T15gGJXMFK1wV5EB7Vv0JZY8SOsYMIFKCgyolOuJhiwjLS62W+vrFxH6UH+0rM+ggRdfYgZQxTqOIH+3KFuIea878n7goJ8blbpdoBV3ABfsbPtF77ELZMyzLZdfylYPsNQSTKEgKZqou+WGuUKsLimWg8SdVyDuFa1MU0nrcoh0652SSEUFpJ/Tz3cz9GwpuyzlE1WDHtTldgHXHJDR0CxKqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbNX2+f3tHAjpjr2m5Yz11nV3hVhKhRrygBPWpJMkeA=;
 b=s1eFvazAX5/eEjCcktbzY4NGDeBHNfymZ2IL8rjiiBhc793cENjrFRciV1720/O/WGxyreF8ZSJjdtJpssyKvfcHSjqhsKSS4qjFEm8UjTF7qrq8Tp6aebJ3x3TR5xOowqZS2/8SYkVf3I2Kha3OGTK2IzmGEN9B+XHQ5ePvREORB5Nkm/gJ9KPYBkEXk7DfEGvX5+0yq0rGZC+YqLSzigU0kU3oDeamaHqTarD3iK1X3dsMUVXeZyuEhw4xXuRAui4qTYzVvl1Y7UZNdiUi4zlXx8E3r3VP1nnHGleiYpGU4FEmB2kyOUO6/EvjE1yBu91n1H9M8Sih6nj+FJkFxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:00:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 19:00:03 +0000
Date:   Wed, 8 Mar 2023 15:00:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZAjbMIJ/+ZQThQ6y@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAZLgSxd4AuWJSI3@nvidia.com>
 <BN9PR11MB5276F4706574CDA936732E538CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAdB04U96TojE0O6@nvidia.com>
 <BN9PR11MB5276B72B23AD976C1D50061D8CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B72B23AD976C1D50061D8CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e6738c-031b-43c1-5eb7-08db20075311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvUszaynf7p3Ut0uVjHkDOKly6MfokwBMLcuHmo8RyLcqs9j+Pb70Ti1UCs35keMutdwMt4vU6ZfrVdXrTOdc58PZLnva7SIZFOud3i/+qM7AK/9nthe8eeuWf6bLwgT3/988wccgzl2WEyAcwC2DGQ9FWfq1YzNja04IOS/rWlj3uTARyPyH113HbF4Efr3ieY1ytTB08GkpOZnY3HRAk+YdVaYGhRN0muIP4Twjm1zAbOPrc0B22OUqLO7dM/JkitVMuMhzUyPJE5TGkVavE4EI8Rp2vqDDt3IF2wmK0mN/r8V0YNSaQHS5ftaSXR4EuIY0mnId2bPOCskmXN7evoTwXEifAqJXF5uIa6+3xANnJLoVHwxBfF27PBg9seaNUKXy+4BoL1GKvV0ILntl1M9CDPHaJOC2Kytr55t7Eb6OtxnVCUQBthM7kffIG6QN/286FO+oERJIa6Q3M5AcMYzGUbJwThcsuEh6c2qx2z9tiTB3axFq+WZnSdH3XzkrIAQ3ypXMil6sjPVk6IixKrkPxuiB0hrncpIq6Z4pnz7wBpLTlabbG1ZxCDoWub9UbwW/cYI7IUnZk0LeX/0OaI4gPQN17AqgHlByLu8XxINnshjdZgicnc4BNHgyFRVk45ZnlHRqEEHjpNmMYaszA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8676002)(8936002)(2906002)(5660300002)(66946007)(6916009)(66476007)(38100700002)(86362001)(54906003)(478600001)(316002)(6486002)(6512007)(83380400001)(2616005)(186003)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bgab0oCcDc/B4+zfEt8vk/yItmdIqibb6Y6dzf8vLvhOwpj6dIm3lQ3wsmS8?=
 =?us-ascii?Q?X2XP9ttO5J9ee4/ZiZAzVWgw7iEkTPFTmLXlIkQ0UR+gwvFqoO7t14Krdn60?=
 =?us-ascii?Q?SBZZ8DjLJFg0XmtnTlTU1LTrZv7MMrUvO7SWb2+3yS7lwWJmTbSOF2TQ99LX?=
 =?us-ascii?Q?jJaj3GUS18ugKRksJhMF6Oa+40NLQqe2MhRfa89M0rFGWX96irmftwmLutqQ?=
 =?us-ascii?Q?N4sHWabM7dit00bi8pxr5rOFCp8q0Gwv/7dMMBaJOqcFQaMVGk8dGpoilIbd?=
 =?us-ascii?Q?ZtLkNjv1bkNczFgXAQUVd5HAOVoIiYNq/vy/0BiMRJL4yUIze/ae6dCkWQuJ?=
 =?us-ascii?Q?ELjQIg9zoa3aeapnZfg/i82mRy1cjFyt4XUp7mqF9/ua4Ch/nzkgKol8kmHl?=
 =?us-ascii?Q?14+tJfUwVyv17sFUP+JfhvJ1tonxeXFr7b/W7BQiJi4UQ3k3WVb2ZkKSRaTN?=
 =?us-ascii?Q?7w1XWyMx0RvjDhhZ7rNSS7oxJeTs7ly+RwI9sgNysBjYSsnkM0BFDTghVGmI?=
 =?us-ascii?Q?HV5+323YR9TtH7YrXnTW7rt5d50wppmu0n6aBDZc+eYW1DpLO65ekAgptC7Y?=
 =?us-ascii?Q?hU79UxGiPGPrL/HXogjqUQY7tJI7b5+hCFlYl3sLXeGo/25tj6en/6sLQJhr?=
 =?us-ascii?Q?DArncBIZZ60UAjEHTjRJVZmE+tyIhE/Y/jpwjpuaWoR9lYNGJdYD9Vhxz9ba?=
 =?us-ascii?Q?HjWH7KAH5xFwfzNhMofvNX0BDrpketEG0WrNRRnx79ARoWN5YL1bUU8Fhqtf?=
 =?us-ascii?Q?TogKjf7hWaEMB7tUQkMnNWy2lhWOuSvseCo2dVFCWrijOSfy1/HEHXiVj38L?=
 =?us-ascii?Q?w3vkHVmeS7mJnBd+7/xYNq66d4GVTxqd4J0cA8YAIW6ZJc4G6WOhGg8nMOmo?=
 =?us-ascii?Q?eO1+9VQP4VfMOSNQuPpL4LDYlQVPieAXA01I4mA9Am9qtzj8B/uHvFVwokER?=
 =?us-ascii?Q?YlC2xwU5P/HWr6D6S16p/q6QfQM1CRoUWaxtyvdo/80iON0k3QV2GawIQM2R?=
 =?us-ascii?Q?2zrEkNP+MZwPP0wiV4i/eyP1X3zd8G6ylgXaTWsk9GFPRcx5JC/A0TTV3Co5?=
 =?us-ascii?Q?ryiDf7B62d/ZKmxlde3YzTAeRac5xhocpVDCvA/TZCAuUGc+RpcflLHZJVv+?=
 =?us-ascii?Q?hheIcFs3kBBNYvVHbyJYsJITbJERcRJUbJ0w+gGb2EvLUHndzDn+P6PGzR1k?=
 =?us-ascii?Q?FSq8Bxjbe8idHLsN+pPU+rCd9SykAXI4e1aJgq+6yupvSlY92hObL501/MD0?=
 =?us-ascii?Q?/LUlBrKxUPX0/ZtV3a2br0K83MW2rRaluf/yFw7IqHNkRHJMy4BQa4N1Zib9?=
 =?us-ascii?Q?Tm5fjkX0ZoquSzC1ga1ofJpNywBN0II7OAefXhY3qpOdsP91Al+2B5e+HQ/a?=
 =?us-ascii?Q?ffPVNlhr0i8aamHpJwgZziFeDJK+g8CdHLgSDm67TjIdqlG8YWtXTGXSSIIT?=
 =?us-ascii?Q?ywohc22rfeKEena1UpvJI0wG8aBAOV0OHuGJn18roBeLCtyS5AdlyTDtHMMu?=
 =?us-ascii?Q?bkoLD+Nr3wxHy3P/15eVp5knFerUd9XF+ZIN1FWRj3J63fLhwIZ+InchqZnM?=
 =?us-ascii?Q?VqtvGz6Mmz1ay4Mp4tKuGznJBIqNji7K4fvgd1Il?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e6738c-031b-43c1-5eb7-08db20075311
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:00:03.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noAzrxtS0THnKAKW5dd5oZ1Hjh3SIP5P3fxXU+9Y66nuSLuhXULh4BJLVyCLdl0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 07:29:36AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 7, 2023 9:53 PM
> > 
> > On Tue, Mar 07, 2023 at 02:38:47AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, March 7, 2023 4:22 AM
> > > >
> > > > On Thu, Mar 02, 2023 at 08:01:00AM +0000, Tian, Kevin wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Saturday, February 25, 2023 8:28 AM
> > > > > >
> > > > > > +struct iommufd_hw_pagetable *
> > > > > > +iommufd_hw_pagetable_detach(struct iommufd_device *idev)
> > > > > >  {
> > > > > > -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
> > > > > > +	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
> > > > > > +
> > > > > > +	lockdep_assert_held(&idev->igroup->lock);
> > > > > > +
> > > > > > +	idev->igroup->devices--;
> > > > > > +	if (!idev->igroup->devices) {
> > > > > >  		iommu_detach_group(hwpt->domain, idev->igroup->group);
> > > > > > +		idev->igroup->hwpt = NULL;
> > > > >
> > > > > hwpt->obj.users should be decremented here instead of leaving it
> > > > > in iommufd_device_detach().
> > > >
> > > > It is like this because eventually we can't call
> > > > iommufd_object_destroy_user() while holding the locks.
> > > >
> > > > So the lowest function returns the hwpt up the call chain and once
> > > > everything is unlocked then it calls iommufd_hw_pagetable_put()
> > >
> > > but don't we have unbalanced refcnt poke?
> > 
> > Yes, the refcount should be incremented for every attached device
> > 
> 
> per device or per group?

per device

> Now it's igroup tracking attached hwpt and each device holds a reference
> on the igroup. Then why do we want to further poke the refcnt per attached
> device?

It simplified some things, so this is how I made v2..

Jason
