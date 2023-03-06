Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D012A6ACF60
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFUon (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFUom (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:44:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F26422A;
        Mon,  6 Mar 2023 12:44:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh1x9ldhoHQgoe9smRu4ieecdtP/aytES6A9SWersR5Bqf2DAO3RB0HTzNol7PfM5BbvQKBtRJVsk/QGaFQUfHpI9+hIk8k9xwG/4VQv7fbb+Ay6KLxarzorJJ976bS63+OQfJuoOnx85aV1qGR8ozXCWHZVqX4v5fCKuJNpcydqz9E+MF6mxyG0+/z9ntF9GF9CixG/qZ29taNqB6JAheT0KAYjjFYt0rJoYyISv8iOoQNCX5aQjNRfJLbuahAg8x++qNhaMmDReDWE9iOTgMsSQywpGoKCoiCLVQYIyLjMVe2XVZwyqWWojScGPL520xhVXbTVZpH7cl/J8oegqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpc5Nc1WmK/rltOIfDop4O55BYS6DWkqbOHhM0z0NA0=;
 b=eiQw0ZpWJmi0x5+838ESBeZtCVrQfmZANRwl2yX6xDHJ3OdxVK1kqI5F5QBAjyvrAgnnRgSpg3rH5T3vom0g4fsn7fHaQ9cT5VF6T4aSl70VUaEe54u4hp7PvGBk0XJd4MAi40XH35Z6+gdTkWM8ndORhVCLVXoctb4UNj/XFqp5kcP4j5CcSme7cp97IpwtrxGduhyryIPSxfPbFqQXai+LGEeNP2119hLAokMHs8PNLWq4ATfUoRv2K3uKO8IRlaEvizqRDsr8ejcZ5vlcE8AHaNxqXkZMCc7M4dm4eWPVT585BudG1CqHdjeGo6RICvqr+T8jAPrlOU6fgrd1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpc5Nc1WmK/rltOIfDop4O55BYS6DWkqbOHhM0z0NA0=;
 b=SpGgPp/onYU//DbXr16+3AvBHUyMvmqXrJmCPqwjH+ZsNVKV9KXN7mEReJuf7b6tDyKnz/fm2u7BCc7ncfSPPabSlCshER/x//UTxpbqKlv8s4g9t3hbhFXbVvdDmPjvpCgyhLVAiZpRsMmBPtsFrYVci2z5g0uKunnBtlQKAG7zzV8iivvPjFNyQqeF6NazlRAs9W+IBuyv9maujbIGBDcGlCIYkHRXwPqdMF8MafM7Erx07yHCFhpaWTGJIfsNln7LKol8S7g+SA62kQOlsiGAbcJAIULfmaLWtRrtkMfW/mufgI24WrppvUhptU5+H6kZOH3w6Rys5exOFdUftA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 6 Mar
 2023 20:44:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 20:44:37 +0000
Date:   Mon, 6 Mar 2023 16:44:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Message-ID: <ZAZQtNE7aPpzv5RX@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB527622B6031FDB540D2820138CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527622B6031FDB540D2820138CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: bb03eccc-e174-44a8-6861-08db1e8399f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgAipQcm0eFRulWiouflyRKF1myuPl6KhFbC6snNwzygMxZQypk08SmytqWIvcQMCqatU8/CEe/aljlyUxNKn+Bb1myYr+fdu1cu4nBQNQb4Itp0gNIvsK0dUczIJjqC8jlnLz2F8+kqF7Iv/i9M59KlQK9KrqUIHNwB6XaWp5sWGQqqpnQGD/QPG8tAUFEeLD2oe40nsHUVJZmcdr91wQjquLcyaJHxfpEM3r7mpVYPTj2sh01bSk0bbfXJsnwByE8kxxew8/RsHOY0UOpyKHCTbz7rm5VkWezmnM5gCOAj7WthKFJHpvG1RYr3PDYzeqpvXLvo0tsWkZDEhF6UlZgD+EYpI2Hrd8BpWu2m2UR6Zhc0CARaq6tlufO4KrQh2vLORI4PuIsVdqbqARFaa64SJTxeAfLxDYV84cAyZJjWIduvvCpcXDPDLdtDVePTB7aaM2QcBXRNRDdMYYiat7WEwOeUsj2NtIBo2svRm+KXAqDFPOnoc59UZT7hIX5zL2aiuNMKEMmHdpF5FXUhXvgnN5cn0Q3jWHgY0ow4t8S5PRx3Y1sid43atmt+19oQybJ6r/khbkYX6Lr/qHl2BUo2WVdXybnhpEf0VOhVDIjRQoeNCaQVgi2wxWYb4lCflr78kcDmkxRTQo3V8pOilQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199018)(2906002)(86362001)(41300700001)(38100700002)(5660300002)(8936002)(83380400001)(186003)(26005)(4326008)(8676002)(6916009)(66476007)(66556008)(66946007)(6486002)(316002)(478600001)(6506007)(54906003)(36756003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69aePZxeYqzkUhc/9B6f4/MjzTZZgghnKKHPh9HmQp5Z++OT+ys3Wg8f/AIq?=
 =?us-ascii?Q?A4Uc0wFTF1c4SN9vvVBjn1tVkv7KkMnrndVUTVYpo0mE0newNcrqz7CdBuCo?=
 =?us-ascii?Q?/zApdGTIhJjU8kkWusSq3FmRYZOFpmaTT92Ojj/tcIpvKg++MePYpnIig0sK?=
 =?us-ascii?Q?QIYg95J6+cy3LEBmruuKqx7WCmN07Ma5vjyuvFKa0oUUOK8mE0ITYqdpQdxn?=
 =?us-ascii?Q?jY4SUWmog8n7cAItQLB0ZXloqlle9lkUEVXu7I9om6e/DYTgoqY9TsLFT6pc?=
 =?us-ascii?Q?tDoUGgRhnHrWL/rKsHnf5CidfjguH82VfBC6z9ECs3fEChBncdlRVPKodOku?=
 =?us-ascii?Q?Mj9sgMxsQd1dyn8I+JoVLGyumCYHXWaZO1rIWEFxfvzLySfQgIACz3IIhQHf?=
 =?us-ascii?Q?AJEB1OL0/oO3RvV8G89U8sZe540UcFi5fQx15liywtGNIPa1jZVdM/EYZs88?=
 =?us-ascii?Q?3NFMj8559fywt5P++D6SZIXjmhPyf5lkb+zmkEMtXUCp9o9n6Sd+sptuRL5Y?=
 =?us-ascii?Q?gklEFNycYuNfofW0SQZUcU40U9JCFU/NZc37aQSJUN5DWaf/DUvueNloj2St?=
 =?us-ascii?Q?1wqSpYJIYdA0B6/qKvnlKdcf7YK0o/Vszpv7GUnjhDyLnl/+Y0XikiG2Ddoo?=
 =?us-ascii?Q?2zEddQi+bnAiseOgdviOFd3LS6aMA/6/JJjR+yHoNY86H3iLBR/YIDVS0PxR?=
 =?us-ascii?Q?CqQBLtrJSdJL+W1JeOdkXHQCm5kttAWRUBwa15l43eTjxOsF5fU5ip8IGRr4?=
 =?us-ascii?Q?xBmXzwYcitdNGgeAHmnDKepSEiIhZFe9kADjW3+2GENBV47z9MvPfxl702Yz?=
 =?us-ascii?Q?jfJ4YwZ9JRpunLmMAGM8wxNZt+wcbmUnTM+eqV+hizD4CGyvj97wRgqE3rkW?=
 =?us-ascii?Q?x0ktTvoRchrgVta88R+tBgVcBNjq3QxlXHu8iU6m9g8JMtDAteZSFor5Ik3T?=
 =?us-ascii?Q?YgRVkrms7TQp2C+DRx1xuAFyVhhWjU/XWJhjISF5Jk8qwDbOlC4MzXvHDH6m?=
 =?us-ascii?Q?SRGmtzTdGlOVr34tZ1OnFu9zxdMNGvFXOANIWPHaln1tqKwOtmhK6L0pjq3Q?=
 =?us-ascii?Q?ErhwVXLfEai7KcKPFX8q8QhVu+EWbJ22nV/WNkdK0HiXuoh1gBwqcHq0RLhe?=
 =?us-ascii?Q?H6eSeH376FK4DFVx1yWt5i2e1FfEZs3Z9MmFa3yi+RBRPs3+3YpiXvN+lqyt?=
 =?us-ascii?Q?zfa7ljthSpwHqpPUWVX5Z1gIhJBNeiYB7tFsGLvy1W6JGMm45B2Az8RrtFN4?=
 =?us-ascii?Q?PSdRWy4opPWe2F/VhHujXsNTsI7AePcYU2ysGKNenfsagw7RagtFNcyG99Qc?=
 =?us-ascii?Q?eV10+nsTaAeIOGryZpHkJwNx8Be7odgSheBrc/n+X8ro/fEzYUQo1LhWfa+Y?=
 =?us-ascii?Q?XPAhj11jOoDL/5S8p7R6VtHBA+QOYh7tKHXuZbd61ErJntyrJwH4U29foKeb?=
 =?us-ascii?Q?0MtuTHwKzEis3JEXDx86qjiTcWBGkUl6plC4jbks5RZTDbVow3RKg9pPCbvh?=
 =?us-ascii?Q?3RpENj9mttpr7UcnC1pGVx/qx0bncNoN6CH9fnlQVPlYhjPeg3lu3hJoFVou?=
 =?us-ascii?Q?p9dsCGabm1uSjGmPT7VnQhzGAA90/RXyuowNmDF8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb03eccc-e174-44a8-6861-08db1e8399f8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:44:37.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXmN6fWqsYQt04q88bh7uCcKfW0ccdoE64xC5R7QccfeNCg0/EAtqw7grBYuvRdO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 08:20:05AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> >
> > +static struct iommufd_hw_pagetable *
> > +iommufd_device_do_replace_locked(struct iommufd_device *idev,
> > +				 struct iommufd_hw_pagetable *hwpt)
> > +{
> > +	struct iommufd_hw_pagetable *old_hwpt;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&idev->igroup->lock);
> > +
> > +	/* Try to upgrade the domain we have */
> > +	if (idev->enforce_cache_coherency) {
> > +		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> > +		if (rc)
> > +			return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	rc = iommufd_device_setup_msi(idev, hwpt);
> > +	if (rc)
> > +		return ERR_PTR(rc);
> > +
> > +	old_hwpt = idev->igroup->hwpt;
> > +	if (hwpt->ioas != old_hwpt->ioas) {
> > +		rc = iopt_table_enforce_group_resv_regions(
> > +			&hwpt->ioas->iopt, idev->igroup->group, NULL);
> > +		if (rc)
> > +			return ERR_PTR(rc);
> > +	}
> 
> This is inconsistent with the earlier cleanup in the attach path
> where setup_msi/enforce_group_resv_region are done only
> once per group (if that is the right thing to do).

Logically replace is 'detach every device in the group' - which makes
devices 0 - then 'reattach them all' to the new ioas.

So at this point it is still being done only once per group.

The 2nd idevs to call this function will see hwpt->ioas ==
old_hwpt->ioas

Jason
