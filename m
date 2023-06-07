Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2067972510F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjFGAOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 20:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbjFGAOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 20:14:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2120119BF;
        Tue,  6 Jun 2023 17:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPKDahKzU7kc0aa3tQUqUCx+7J99qIlaTuaErwJoX+4wSCqj2TxW+NgZFcVpcsixbxuvqVsqqgnDr2lZaQNeoOz0MMo9TAjGd+P9Y0YLVr2yI7MKWcVzsQRP7XrlypcJ2ZIf9iJ/Crmw/YPXG98JBwwJjtoHEUWJWGlZPfO3phRDeDSGlnoz1q/9/OXvqhlCUD8bVX5byeDh6rqW2iEXuFLLUvjpXps5Xv5beobi+eKtOaJSizlGvgymkdSUf5xKFtzINlJFnPU4b18LMR21xZam9HVBy/P/4Mmiw6am2VAE3YPPfI2o0oltQwxJzmPFyDNzHE6GogBTivV84oiYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLo4I4ou8KCifDelh89CMfzSU1ymri/JFoPcMTwXdb8=;
 b=YlrOAqzB5Ownt1v3VKCaglVbXHuC6DZ0IeLfnN+k7Q3ZDjabA6VsaMtqDz6BKoHu4ub7oiyyvyIQ5mSm0h9FDndgNK/I6W4llHWcpwHDNI1nd8zohif/puPrYiLs5vQKXWCidKD5HQjIUsREQbOVylWC5p6ebgkl0hkfql4X3UGrk8Sj8ufTZtzvKwzrXKxvy2MCtDhWQgTP7tHG5D7U9xy2vqE65DZmOlliCPknm/2ty2KEHv1KwP26rkvxECA7NS6MvnZw64M+sygRJthK1n7QkzYrur5EbqrZ82JK96bECoEgeiAjXql4KKBN112xP/ef0h+r2bQYLmbBRvfFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLo4I4ou8KCifDelh89CMfzSU1ymri/JFoPcMTwXdb8=;
 b=GmBIGl2qqkBUzeIY0pVxGfbwvFMyin46x0dQtqwnTNoviZRqKE5w6/YC/F2UMWX6ELdDGYxgYPfLcP1QI2xrF+ebZoBCwE7HmT5tTJLg1G5jN9YdatDOd2Y2P7oX7Yer5Lpj5nb5aZmxBmizgEQfcgTn1srcEPs/U/rfGwzrO3x/ffq52e9RthopQTmtynLfJkMKVtvFNq2eIdndQUZxeZ4npiQKNTn7bj+cGWn9YtzChVyqAnkmkzsJ2maR2kxuCZxXipahCxrXjoXVfk2HL+KM0bl7IbPCDZ1Uan0gez6DZoJlXisPv7qhyJrNRKmaluw/ZdkVqi4J0KGyGwz2bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Wed, 7 Jun
 2023 00:14:25 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::a03a:9b2b:92f2:ff69]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::a03a:9b2b:92f2:ff69%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 00:14:25 +0000
Date:   Tue, 6 Jun 2023 21:14:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZH/L3ucGnzHf5kqf@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
 <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG2fVj41GgosR1dk@Asurada-Nvidia>
 <BN9PR11MB5276F1410A11ED631CE6824F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG681VohNlw2vvLD@Asurada-Nvidia>
 <ZH897AGywGVbt51Z@nvidia.com>
 <ZH+McCPS14Wc25JL@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH+McCPS14Wc25JL@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e8bb80-0e25-4fa5-4484-08db66ec267c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnbq074F/Pt0tTmKP32FRpjZ3NIve76hSKFJGxW3PlUYODZynDVY45DPFMJ/zj+Mr9hbAf+a7t2yr4yL3Ru7YNyJGvLvisbhfjyqvd1L0T6vvoT5Pu78l0th3g1DKYz+xKLgEXqioO7UPuAgksi86EW0vsB43uwkMFSvNaGRCZ+3+Jps44VZ+3OXYYg7odsv2eCFQbhNh0Bq7hd/mCjg612cWHik6r8b+4TzBhZOeE7qLSz9LUD3pvfJBhUeRkif5Qoi/KsPiNcuRYfbxCgmcahAKbUtAS09uP1O5PYIawdn90et9I1DnkIjsL8wac1iWHarvC6bD2qRpiRlEVjzoQYryIc2damH+lMoYUAOcdSleHRsHf/eHIw6joTPIknbLtTfMRtv1xQJUQK2ujJTh5sHGVyC2YmcgtPwXf72ZxLJ6If7MrlPgkC0qu2RQR0GfYpUqhj0j1P00LSqVEz5Jmqr20k4JMFCZxMd7OtVBszjyIIaxKdClEWyoC1Qp13dzgU32EIuvD41t5Z9ICtUZC8sgiZscfsNKHZAnwqhRcD/Jo1jLUgxO5Rf0eXh/bJ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(6862004)(8676002)(7416002)(6636002)(4326008)(66556008)(66476007)(5660300002)(66946007)(8936002)(316002)(41300700001)(37006003)(54906003)(66899021)(2906002)(4744005)(478600001)(26005)(38100700002)(6512007)(86362001)(6506007)(186003)(36756003)(6486002)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7yOOPTv1w2vdvzWZHBeokUCmNyHjqbHKB2TEoTYADJvuQV0riJ8e8c/5WwQY?=
 =?us-ascii?Q?L01tSSEOUTwPkXvmTq0i/5L/1zIa6nSojmUYXWy4INjYhC9vu5Gdt3MNvy96?=
 =?us-ascii?Q?C6cgTKSC7mXFg7vrIE/yBEN7JFfiiwKV4XbEhxoX+bZAeVPS/5ZWYjHuZBcJ?=
 =?us-ascii?Q?9dZTyXHSFlvlZQ5UhT05G+m7bof/UBcvhd2xoXpzB6AFv00b8IJjG2x08k21?=
 =?us-ascii?Q?poICBQC61GDwWTz5Ylz+Xit41BxT8gZ8qSoEgHzv74fIpD30XS8TIy+g18hW?=
 =?us-ascii?Q?XzG477xY8iU6WJtXdukNlWXDElifXLOqepCdpj36xDEuwBxcbAp8lrPy9WQp?=
 =?us-ascii?Q?dv+ZVhGA5Lf41vmoYNZZbhvEfIoUKEAWMuFo4eCcrpQy0F8LNR0qxc01TZqV?=
 =?us-ascii?Q?T3o531lMIpRIvqv6lz/2l0rqKKGrJgD/miIrfoqEAZG/OwCH/Ir542Ss+dwR?=
 =?us-ascii?Q?AHlf9oqBAAhvuGjWMOtfiL2rRaPgCd5AHmH3v1wCLoO/LMmD0MfZaAlkt+7d?=
 =?us-ascii?Q?3gjsgxaAYp5no67KUMQoXl6h0kOfNBcU1IZntBbiIf1jBtxEP6C/I0nzOwvX?=
 =?us-ascii?Q?OIzATH/NmFroxQ68dmsdENXMLteqSpQfiOYrT6E8WoGwHO+IWA12I9iX9218?=
 =?us-ascii?Q?YwDiKfxbT737GkbjBooJvb01zj222Hz2smDrAYU3mBaBtfhcXNYTzaXvTE86?=
 =?us-ascii?Q?fGWW+wnfKr9gR0xfGz0Tp1vQfrLGQs0qCq6bgG4sD50PaNO/SCcvMH/29qDE?=
 =?us-ascii?Q?1xdicKJfiBtgabKTduLpM/+5eYphcOnRgDJZzdcXa2WWZqdlRSyYdp4EgEbJ?=
 =?us-ascii?Q?iL3rUjVrfX6q83WkfiU9gDiiTwx1P4QuVjJkzXg9xM/JlJ1PQOxV9UF2O47m?=
 =?us-ascii?Q?MZKbnhAhnGVCwluDEu93WRVfrw0wz14UWbGEEXXEmzzLCdvmCBppSz3B8XzN?=
 =?us-ascii?Q?q9CxRJitM8NUPHiaK42iQt/hQxwbviWxe1XODe8T6i70dXWTyrZ9E2pDkgIm?=
 =?us-ascii?Q?2ZAiAdH1aMLHzTn+BVQxTgBs9+cnd3NKW2NbFEn0FHiZoA2AwESQB6nWjQko?=
 =?us-ascii?Q?xMNJsQKywMim/9/JvcI2HRVsEazrfPb8RSYg9p9LvKlS+OLKJJU9pwKcP3oK?=
 =?us-ascii?Q?EWGzhPZ1ilN2saepXfOFCpROxcp7jvhlwDsHrsLx7pfOuLars4jGhzJi3fv2?=
 =?us-ascii?Q?ERNcm7fg5aJ7fJvBit+saWkhiXL8rjjttCAuwZaAggCI8mP9g4OF5p26kV46?=
 =?us-ascii?Q?tRzwyzpB54sSHhca6DfaaWWHIWgFnpm7sT3mi+VLIPjhCIg49x+NaX3LqiU/?=
 =?us-ascii?Q?eu44K3EAe26Wrzf7XIWEgdQmd0Ybg2Vv562ptMMpD9q/HlMmv0L4ssFzYtik?=
 =?us-ascii?Q?IJdqw4EZ0cQhM2z65Z+DwaeZL2VHdibbl038EZ3X9TptO9uAzSwJXE1lslnN?=
 =?us-ascii?Q?TsTJetv2pE+fOHWXeT3WZlcj29yLzd7/dY8X0z0YKnhzhmM+URQY9MxtvjdM?=
 =?us-ascii?Q?ooFR+dvwn+dQSumEZetkXHVWuxmRcz76hyuOcLgjl6s+vj1ra+cLJsoIW37f?=
 =?us-ascii?Q?ONXF/ApQ/ZE+U11lR5kLZ4I1WIejh1+Zp3oxOzSP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e8bb80-0e25-4fa5-4484-08db66ec267c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 00:14:24.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3omhVmm3xYprW3zEkmvMsgp4vHL7xJktoJGc6Eq0HW5QVkvRXJOVwxSt8cdVhLqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 12:43:44PM -0700, Nicolin Chen wrote:
> On Tue, Jun 06, 2023 at 11:08:44AM -0300, Jason Gunthorpe wrote:
> > On Wed, May 24, 2023 at 06:41:41PM -0700, Nicolin Chen wrote:
> > 
> > > Upon a quick check, I think we could. Though it'd be slightly
> > > mismatched with the domain_alloc op, it should be fine since
> > > iommufd is likely to be the only caller.
> > 
> > Ideally the main op would return ERR_PTR too
> 
> Yea. It just seems to be a bit painful to change it for that.
> 
> Worth a big series?

Probably not..

Jason
