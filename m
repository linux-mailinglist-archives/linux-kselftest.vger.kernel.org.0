Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE66A1D67
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBXO0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 09:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXO0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 09:26:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635D63C7B5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 06:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7Me018VPMhP5MZJc3UW/sDD+T7086ZE2r0M0m7jHKEbFlrYZKjdGSIEupMYuE7V/LQgg3kYnjtg40ZiNfpZV0wOkK4Arsgwgec2Bk4qQCoUaqzTLBpyiWjurDc4dz9vapTf8PLSXVeJklh6vF2+ZrUjMo+USC8h5EBMiFiZvjwZTiC1Zej5Jo/BGkdCyOsMQ4IAywI/kjv+T1jGkHvD/3bFWFrD3DuSM7vysAiWOtwnzkAAbN9GXDNGFcMsZcnaYRMcjtrcu4aTAXrbQIFrHNpQ7WcKWNyntgvFmVNP0z1RD8eX2j4/zrOQ9p7AApZFgjiCUX7azw+fZMZV2AwgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4JFu3lhkGmId8VGJMyUYnNKOc+Ji/9TdtgpASm2tpQ=;
 b=AS1kr1aJ7Jgeuel9uzHDwAiWZqc0DsM0CPP3Azkp6c6qz8TacHbmYDb8L3HqZra4cT9Q/Pv42w4jtvcvJ6MySc63tdCDjgJcEMsDHQlmO+X6hmhY6ddgJ/0Efr8Qk5AymWxsAWb6RWo1HcU4DTGc8eHsV5RuMMAlA2FtAedEYnWaShnAurC118/KaTLO1dg0jZrHIci1XHTqf3msDNoIuATsJAo9CLzokh2FEDzUXpKY4fjjCfHplIurvplAhWsyMepZWRXUHFsMs8fnO4kYaGEouw7mzA0MVx4UxFEZkzEkanWdQ0GDSRdUW6IoYcJfLkny81p0BxRnOZaOL92xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4JFu3lhkGmId8VGJMyUYnNKOc+Ji/9TdtgpASm2tpQ=;
 b=XrK16mhcbfaTrKxvRQOMtxtQqASAaTWVzBuW6/h9Cu0VT2uWSSXahtedChRCXC0W3AyUyLrs83OUlY3YnjMO2VqSDSJ95C6TGKffbtFS4qrrfmOGv+rckSnijEDQJblB7y5mtqUTyNzJXaFc9xtdQqyYzx4FoL/48tMXwUluxdg5raDOOVC4EOE7gL5MbsnV+coBJGDvumRQERzW7fpJ6i8FMQ6XVm74IwqopzgozLH0yT7amYYm+ypLyD7zM3Qwpwcq2bG6fkL9rUc9WAuD5/uZMidKrqRmbgvPFQFgX39OH9M7vg5DX1RyN389ayrWB4qRRVeuTXszevKqtJeOEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Fri, 24 Feb
 2023 14:26:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 14:26:37 +0000
Date:   Fri, 24 Feb 2023 10:26:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 6/7] iommufd/selftest: Make selftest create a more
 complete mock device
Message-ID: <Y/jJHPGLQUdcNFUJ@nvidia.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <6-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB527674E485D533D57A9965888CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527674E485D533D57A9965888CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:335::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8442b0-ba3e-4354-88be-08db16732363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHD/fm7K/2pTFY8PqYhbZFqnCq0QCtwx2EUvPiD0Kag2WJPUF5H/etlZoryFz0T+9H6vZ7w1tmwFzG1Pvca038m0k/da8SmJdjbCRR4SYMmDIH+fuCNUrZJDf5mLElW0Io2i+Hn3lHdAXduysK7YguelrnG6pL0XHBmMbHiXwJV8n8OGMXKAxbfvhNmhthBM29GdS7kkWeCF6hKcs9or0Yn4MJtNZ3Zy3UCR3qdwX+r+Mgfv6WcIOK5PkCajs4z5BNVKUuR8LjNPRy1BWXETYiPrSC0YI2uMGD4343dWzhZGBIXCQzma5paUWXJUVQrp1jQARTqlnGP8VAw/R0PCgsmRrUbM5e1SgLiQOdSFNttyO3tvPijceNFUMWCsyKvtXr/YLu5UU9OSxcvtszvOXdbCFS+kwUFNtLdjXIPTnrMPddyw9RBaZSkmyKeXu6604ywZQNfX4xKCvaR3g01GuUWKjkBCN7vmTWrm/iD8ZuAVO+W/aRbqEQ/vnm6REhAzXwT11OuASkwy0xXYj9+kornDLZNYPjOgMiXfbOpGIMEYFI/h09OfSLRIv79OWV52uYwftxGBNcYXQEk9jQMHGu+OQseZ8WZs+T4DVBZHucI5iEekh924QztA384bybqsFACgAvi0THmebhZmfFsyRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(8936002)(41300700001)(5660300002)(8676002)(54906003)(316002)(36756003)(83380400001)(66476007)(4326008)(6916009)(66946007)(478600001)(66556008)(6512007)(6506007)(26005)(186003)(86362001)(38100700002)(2616005)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A4ilRuvcQvZ1zZ1vguWd4nOxgh3qkkLmtOLbUYgxV5qHqbocfRGJ6WiIR4kb?=
 =?us-ascii?Q?Y1Ei0EASvujusNz57Rl3BGlzdOsk+KDjkPrRXBXy1saDFpXBJ3+W5ilIS6yj?=
 =?us-ascii?Q?CPapXrthEyahKJnnTnknrlMJlDkmY3EydGD2h0EiEJuC21qWJFC92oMgcfMt?=
 =?us-ascii?Q?p9VXF5rtUOJ1gLFVF2YmMXbj/bUO91hZIDJ8FUeLpek9R1GbaGwwPGFiBcFw?=
 =?us-ascii?Q?Zk6xb+oKj/SC04y0vZtODMfUGaCoRGS6G/n3Nfg1F3S2PBz8sOQ9DOx3NoDc?=
 =?us-ascii?Q?p4WQkQcx0XJymb0fWKQL2V0hTdftyCWyH6q0B7IANzG12I3x+3okg6P0LD+L?=
 =?us-ascii?Q?/dXLQzzwBXAHDd1Kt2dqNSjYNYnK0i0EdviJTip47Y6SRVgSKyod2qzBMSfg?=
 =?us-ascii?Q?xfVAvOTKUCd94wA8BL+9IPvcUNIH3kSd+gqdHkpGPPLo+dc/p3Xyto+KtmQ0?=
 =?us-ascii?Q?gjIligtoIk2Z2JpqN+s8jw883ATUt5DhMo+eEuRv3w5eZxoEKAijN8E2Nhxm?=
 =?us-ascii?Q?fq76lhySGiYAQYgCOINPpmAYMX3wGiJGXPdGBqpz3w2zfuw17BkdWNum1HeS?=
 =?us-ascii?Q?EkfOFR0KLdjlVfoIJSC1uMMWNnPUnWdIW6kmppEUjPDS8MjapvgQViyNmR4G?=
 =?us-ascii?Q?C0x840o+RQgcDxEFk8l2WD9fV0Wae0duALFcDLn1WPU/GqRtewVr7btPI1Ih?=
 =?us-ascii?Q?/5pDpsGmGse4GDQFGT/5uVqAAn574eymTLTZObrummQAfuUfPwmu1D/XXS9N?=
 =?us-ascii?Q?9G42eOT1kFuc4Z2br6mCs6vwjR7igSc6y+r2uWaWCzGPgy0R8wUpmIl2BVbE?=
 =?us-ascii?Q?zk0A3dc6C4HVFnc4aHhp44htX3KbIC5BJPWiOhO/cMlFbpNAUteDWLvcifHX?=
 =?us-ascii?Q?APeAVt/kIRvdKZ2SbjsuFGs6ZLBAjd9n0M3MozbrxUnIR94/urL2EzWpouUj?=
 =?us-ascii?Q?281+zo45iKDpUw4qZmN9nxbKDC9v6kpdNaZ/SIICv/hSKRIj+DR2pP32eyrV?=
 =?us-ascii?Q?VgDTh77ln+HljwnyKnzqgilHYUh7rouiRfBt/oO4utBy4qUdOycI5f5erCvU?=
 =?us-ascii?Q?Jyntg3kb/3KBdJrc+j8FpZxC4vtdcDTEo1/Kk6o5l71zzwqWLd2pbv80/2ot?=
 =?us-ascii?Q?zUI586Af+blDoR8tPL+gzYmhotu8yqr5gGolJBqxbXysM52tQNQ7PUnH+BHz?=
 =?us-ascii?Q?fiP+dVrF6Ie2ljsVaZ3fobxYMi/skgkSeAiiZ4iNKlcRjDuxYXB9/Uccib+s?=
 =?us-ascii?Q?MAJqy7OvTJ5u9fW8NVX92kk0ewCxC36beHmtdfp2BTzTN7bg3nH7JUi4B9A3?=
 =?us-ascii?Q?+l7nUWMrhfvzfFkOeKjd+TlUDk4WmbXvA1mryoINkXtGcZlua0he8/gQjMCH?=
 =?us-ascii?Q?9k4y1OrFsmN01bfnai7z03e8nug0r5Wf4IvUVOrKz/AEFLBp4mYwrNfaZ9tu?=
 =?us-ascii?Q?4hxMgBhMXN1OsJkxumjFOji/d/bxeTF6KgwU9dxsm8cIXhHZgmOVoAIckJ/D?=
 =?us-ascii?Q?CjfyafcyU++TqH60EQvWfgmg8z/nvp/8wWdFQD4qX5CWj7NOFmSrsBJSTfmX?=
 =?us-ascii?Q?sI6xtXmsOhYF93yUy/jZeUim1bQtHJ1ALvzrss1E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8442b0-ba3e-4354-88be-08db16732363
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 14:26:37.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBYKxibJzmSoeiTZfnMcWvBKacXJxY0PR2Y+d742D6T9p40lsUbLCNql42tVJ4oN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023 at 06:50:43AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, February 23, 2023 5:03 AM
> > 
> > iommufd wants to use more infrastructure, like the iommu_group, that the
> > mock device does not support. Create a more complete mock device that can
> > go through the whole cycle of ownership, blocking domain, and has an
> > iommu_group.
> 
> this is a nice move! Presumable with a real struct device we can further
> extend the mock device to test nested, pasid attach/alloc, etc. in the
> future.

Yes, it should all work better

> > +	/*
> > +	 * The iommu core has no way to associate a single device with an
> > iommu
> > +	 * driver (heck currently it can't even support two iommu_drivers
> > +	 * registering). Hack it together with an open coded dev_iommu_get().
> > +	 * Notice that the normal notifier triggered iommu release process
> > also
> > +	 * does not work here because this bus is not in iommu_buses.
> > +	 */
> > +	mdev->dev.iommu = kzalloc(sizeof(*dev_iommu), GFP_KERNEL);
> > +	if (!mdev->dev.iommu) {
> > +		rc = -ENOMEM;
> > +		goto err_group;
> > +	}
> > +	mutex_init(&mdev->dev.iommu->lock);
> > +	mdev->dev.iommu->iommu_dev = &mock_iommu_device;
> 
> I understand how this hack works but didn't get why in this case
> dev_iommu_get() cannot be reused...

I'd have to make it an exported symbol.. It could be done, maybe it
should be done. I'm unclear how much intrustion we should create for
the selftests.

The other thought I had is that perhaps we could fix the bus binding
so that it wasn't a hard coded list in the iommu.c Eg a flag in the
bus_type or provide the list when binding the driver or
something. Then things would work perfectly. Needs Robin's series
first though as it allows multiple iommu drivers.

So.. I kind of left it like this hoping that other parts would advance
more and we can revisit it later, it is only 4 lines.

Jason
