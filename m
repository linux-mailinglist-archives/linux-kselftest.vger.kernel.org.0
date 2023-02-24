Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2F6A1471
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 01:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBXA5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 19:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXA5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 19:57:50 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F81FD6;
        Thu, 23 Feb 2023 16:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7YGhUpKKtUESje2DaA6Wal30cx5jrZVaXgs235s92toXbJc60gXuW5Ke5MdSSPGcSDaeVUMIQImC51oqnFZeH5wt5iFz57kXqtyNcc2VYtEw6cPFKiRJQNvHjgsNoDvAoU8jv5CdMIU599fo4p23K5WTGJWileDkuLe6U6O0RYg+UawTj+IjeQYe/0leIXZXCykhVEm95rooUPYVPcOOWEjD1tdFkFHEE7AM9rE17L9fZ1qY7YXTm6g+G8ti8h2AkrGzecxqi1n6DGb6mwvxnIfh2C4IO3RuLFuaLUCbTuHhNerURQ1jBkC0sVOc6/YlVyZae+zivgXG4YNuNKHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FdM1sZDrzNWnQFgvFsFFiqad3a0hFdz0mVBk/w7W9o=;
 b=gnVkkVZitBBIWkMchJEB63bKRLQZr4nZFKlXrII1MkhBOEuIYeJMKcagSMJh1frTmhDmPI/9luCUTMR2AlyWV1U4O7bTQe/v1cO9FK9eyzh4O9urRV8jS+DeLkU+LnTw6QzaDZ+7f4qOh1gwpR58lFkyAGzlO189qq88++S0huC+enkPnKyI1zHKW6pIOwqA7UDq/yFZI8y/4K2VIHAkTI6Wth5lF2c7Qr/p4ouWepCMI8pD+BAJcRhZXqUMEMYVwQg+6Crgt15tH3onNRLraU3qXonOhugKkUJNXPLiM4j9rGseiotuAMq5gTno/5cIJN4mk2GozKdtgE+hST7GCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FdM1sZDrzNWnQFgvFsFFiqad3a0hFdz0mVBk/w7W9o=;
 b=KwMiDwMR8d7OYqCzbfcVuSRn06pyiQltuRN4my866sdYgwH/KNJrK1C4dPlifETsa/I+rBXV43KjxDh54nbseuGlTdwfvAsSGm9dX67/PxwJHU0OOhC8/cayJOhB/LO2Gf0hGHnbo65tjAyt6IlSWLbNyg0FWqaE8Ay9xY22VZ9CJ/QyjUcj4Ni5vvrEtTYmIsBtBh1jM0k2ncihO0+4Cruw+UdNcwfwwwxA1Vz4vfXXDlP+72VaKi8jbOrQWkJW0VUgjQp6zx7N3Bkklj/MXzjG/ZyuZ0ayc8bXX0xbwBGw3LTotl15V01QgsxXnnJpQG1iPZHYZFme8q+ZADQ6EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 00:57:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 00:57:45 +0000
Date:   Thu, 23 Feb 2023 20:57:44 -0400
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
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y/gLiNs42UyO58zJ@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276941167B52F7C0A7A4BA68CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+zVliMV/R0ALrlT@nvidia.com>
 <BN9PR11MB5276A3EABA1F00DED4B5B5DF8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A3EABA1F00DED4B5B5DF8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:208:23e::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: e178ebce-2b89-4136-cd4c-08db160223f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4MlEjhn2XUMg6yHd/BoTcI8NtZnHg26kTelIUSAwZ4l7gkC53RzwvbZBESlRqt1XjhfsPtl1XM6Ol8dr81OnA57Snkk8z2hIHq60+IrmrABXgWgK/O9KZekPvq896UpW/oLOyaGPjJbFgyiwvJ3iqlxNO3Q4mqgKdSZP0KWwQja88JX41mOm34XIrvcfBqw8fKNrI3DnCAHhEycH/V4W/iNmQpupFHTNJLaz7CunI1iaAReCQHkfx71mNeOOeT0zrQd/W+HdJAMEqeVYYMh2g35Ua2WF2TWvAqTMmJaUXespi8I6qf2MvNaAg4+JsFT2GEN6yXvgn7NqMhyYYl+6W7OXRGZO1KzmsdrM1NW0+6rvcxmRU7V2Kf7aAY5g+A8eSA6tZc673wWwxl/zJ6ZWlRjeazOwZEWjkK2z78QJRAKDiLeDmFFW/qixRY3DQczEmVrkc9qlxnIz+PJo/N+BeZdej9lC0fKJvVYVXZoBIWI1/RO78invvYfzEkoM4DXkWdE/iff/JZnt0US7Zf4TL3Prmai+TgRVUqYgo0F/mXfvUjAr2ZlRXd6lI5YkFyZlVO6Yl7IuCBz+KtxeGPnPpY+osVn93TQMFXFvvkvrmxem1CGVs/U7iso0gm9Ln06cE4LfGfccwMxEJobSaxc8G2w6o09sgDPD0GsRhDAXlLF+Kr4POKpkmc4qGe9vuoz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(6506007)(83380400001)(36756003)(316002)(54906003)(38100700002)(478600001)(186003)(26005)(6486002)(966005)(6512007)(7416002)(2906002)(8936002)(5660300002)(41300700001)(2616005)(8676002)(86362001)(6916009)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y86lpUbaSqoETzGW28KZT+ouZSRlra4iYbJi/ZlM+j3dbBSXyQTkjcHdegnH?=
 =?us-ascii?Q?RKYZhl9UFgnqPOIghniw59Oiyv/mxb8N7XmFLlBY04UjyQB7cFFDvo4q86Pi?=
 =?us-ascii?Q?w7WrM/e1osek8dIVgcohZ8ioTRxIxv1VM0YOPpjG5JC+MKEFDJs5a6myFK1y?=
 =?us-ascii?Q?tBKTAPAdPuoFL76Ko9mK2vcMajGViznm/O04b5ED65aM2QMynztBEXA4CsME?=
 =?us-ascii?Q?GW+ODEMVCG48HuviWYMdQI0FOD71nQ29vhbbnVjSxp6ZAY1spzi8wGhzdGB/?=
 =?us-ascii?Q?ECV1ORkgIVNNsJxkRUOFVKh4zOMXYDFxLA64GwPUEzGIIj7t06ROiTOhoDnt?=
 =?us-ascii?Q?EndJQpOffxtaAoUPF0JMsNQM927QFeBpHJN6du/EEP+kuzaOwbqX5ASfbgDD?=
 =?us-ascii?Q?tQVZ8jarwa1maIirh/b1pZYhj2cSJYRct/cLJ/vYp5gVU9yO+46dhiu2a6nl?=
 =?us-ascii?Q?EjNjg3MtFU/RtUn9ULw4JRxJEfNfhsbvOBLlQ9KW8cmZe3PrNJZWnPLR47iW?=
 =?us-ascii?Q?QrVT7/9pnOZddQCHFyFi7wTUlsngCRL0ML4TPhBrryeN/N3MHZoxbYSLal6i?=
 =?us-ascii?Q?fb2xDHUuDpboxanqZwBOV/FagTMffE4z0QOI9iygxJKSZyA2LISNBGGL+LQk?=
 =?us-ascii?Q?nppirRcTlADmS8+AnazpVfEkoj78/mO+DqiujJN+JizmZpv0yXY72Gm2szxV?=
 =?us-ascii?Q?daE3zHQKQxaKXqwHdtaSghQSITUIMk2gTqqC1tKIJBQHzA61EfclverYUjT6?=
 =?us-ascii?Q?GNnZgxKCO4UBFjN3lbNS832BSkI5zbc2Njv7r8nRL9S/TI0Arkpqy9zM/Sp0?=
 =?us-ascii?Q?AcG2limxOxBEdQsOED46S8FRr3xRfmAgQilFZzRWTEOXGP3THIpHzhzqtyOE?=
 =?us-ascii?Q?Rg0YTK9VwDOQxpUWtIFYvGe7DQe5KFPYo7z32xpXAkoDYYRkDsK4CdeyYuLE?=
 =?us-ascii?Q?BvDVCS4kdl2VRj8ncK7WW0MijJBOwMaaLDaQSni14KPPzQtAskYprnEOFuI8?=
 =?us-ascii?Q?75dEZCW0NdKGsOYpfXtA0JQ4NSNO6AXaygxPDKaqN6PSgts9CiE4Zj3UDIAv?=
 =?us-ascii?Q?MLnJYMI0f52tPyExU9U7RyF5wDd6vnu6+BWcbn/iAzoxKGi6DDoEySC1ayZf?=
 =?us-ascii?Q?Rmzn0Nx1DtBm9qgrM0tV3RZ5p2l3V/ycyfxw0LwtTgFg5vFeU+kKh0Jww5W4?=
 =?us-ascii?Q?msX4LtWSyPuLFC9nkQ06sKV5GzTU++IzyzM4oRo/uHt/fZTFNx5DvxxnOTfV?=
 =?us-ascii?Q?kiF4CeKjHb2iH02A0yDvlPop4tog4Lfatnvmc8sExsYv0oCjy/S/lyCK5oKo?=
 =?us-ascii?Q?M4ASwqrN4XnEvYIUlR1k1wqDhKCKA1baaeM6LxLPP16bo/AvOjwM33ZmXXT1?=
 =?us-ascii?Q?ROtB0OwsVxcwh/TY8+MqABv0mycB79SBfhFjOQB9xExfQ9yZZStxLkTXg6Qj?=
 =?us-ascii?Q?kMN8m4XbfHLwyCtuYFmaavhDplKHfQOrRL7wEuQFVToULr0wSa3Cux6TWbW2?=
 =?us-ascii?Q?PA+9NfmgwnQ+a0IcN+bAiWGpmHV2UEVTU2fXMlR7vwKyLMRA988iZKuAg2xU?=
 =?us-ascii?Q?1qWR9gPcB1mZgr1tPc/mebEEhEUrZNippFjgwNaZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e178ebce-2b89-4136-cd4c-08db160223f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 00:57:45.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfhPTy9YQvZsUMH+d4skycPhop1WHZKzoVNUqAI5SjiF8f6PQB+hu7O3/yDD5+P1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 22, 2023 at 02:11:39AM +0000, Tian, Kevin wrote:

> > > There was an attempt [1] to fix error unwind in iommu_attach_group(), by
> > > temporarily set group->domain to NULL before calling set_domain().
> > >
> > > Jason, I wonder why this recovering cannot be done in
> > > __iommu_group_set_domain() directly, e.g.:
> > >
> > > 	ret = __iommu_group_for_each_dev(group, new_domain,
> > > 					  iommu_group_do_attach_device);
> > > 	if (ret) {
> > > 		__iommu_group_for_each_dev(group, group->domain,
> > > 					  iommu_group_do_attach_device);
> > > 		return ret;
> > > 	}
> > > 	group->domain = new_domain;
> > 
> > We talked about this already, some times this is not the correct
> > recovery case, eg if we are going to a blocking domain we need to drop
> > all references to the prior domain, not put them back.
> > 
> > Failures are WARN_ON events not error recovery.
> > 
> 
> OK, I remember that. Then here looks we also need temporarily
> set group->domain to NULL before calling set_domain() to recover,
> as [1] does.

Sigh, this is too much.

I made a series to clean up all the domain attach logic so the error
handling is all in one place and all the same.

What do you think?

https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

Jason
