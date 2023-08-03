Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FA76DEC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjHCDOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjHCDOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:14:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6342137;
        Wed,  2 Aug 2023 20:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NedWsM8CAcDh+d5o76FODq9s5+lA+qLt/tqQ3psLC3BnTfnNR5k9ltPxcqqGfpIfZ8FGtpNF7i7etrSaHw+JqJs786glwkQ2TEFdumyj57zvC3f1lzrjGkjo2n+4wjHi5ej/HlU+WD9e98hADJj0KS7u4h4zQzPAnxWHxmBfDQcpbgRj/wh2FQTJn+Si78aQk9i1ksGyftNImC4KEJYXwjnH3uLeu7G09Xea4fEFO2ONgTM/MvijZvOlsu2EnjhF4xKOrAyZ45N1molSv7LO/KrkR6w6cWzXUCuTWxrgpFdWFJBwsmIBUHlC3ZOoDVu3krz6ldllT9wD+fA/T4VNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwzvP1VC+KIPDMiV1S/bB6ZBm+SzFk0DIjBRkXnpBbs=;
 b=f/OHnrnpsii+VaeaPV0nbHY2YODzpba+Zk3rjCa51D+F2o6ep2xWoIy9CYK+1q711M60UQAInVDGaWVsmSb0Tq4EMV6OSFeVzgr5vRU3tq2ui+kGM7WwMC1KzA9KKx973n70JBiPs2MjQBzMShfkZAMy8gDtVgr8YA+YC4UxwGabGZUp+Aucui21zkAxn61bALVD0TA7q7a+y3LpYVc0ae1dfVDNi/pXzFRVT/nlZMKo6ORk/Ho4i8HQsTSWcU1UuPepZg465CcdpeVAhT8Aqou0kdqACUi9aRKv7GnJKMvgoXUMo55+/81o8+S3OfVE9jwDpyih0Uthx1Ydtyfjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwzvP1VC+KIPDMiV1S/bB6ZBm+SzFk0DIjBRkXnpBbs=;
 b=S3KCs09g4NMpYYhBke0MptTEwma61W3VVc4sxcv/vWBmC0RAtwlB6gCTUhni86hLO+9ate2EYi+tJa2CtCClaBrRLQmZK4KvZN9xNmOImxg1T1oDaFj/HYtJdhmhC2iQVoYH7dYX9GhqVcwUk3lJMZR/XC4jIZNO0Uv5LB75PSMEhTqskWgHIEzMwM7QJiCYIaYvsMPDA4Kqs/bqm0DwHt6Bk3sR6mlIFI6FIdbe7yX29vsZg0osccpEn1OMEwrgCBtc3hq8z0IZ/z73Q1Hz5hXUq89FRW/bL1eDBx36aBQghlvtqogNvAEMg33V7sLuwFNLiZFrtCCcbkS8P0u6KQ==
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 03:13:59 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::3) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Thu, 3 Aug 2023 03:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 03:13:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 20:13:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 20:13:38 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 20:13:37 -0700
Date:   Wed, 2 Aug 2023 20:13:35 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZMsbX4U/wGvE02eI@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com>
 <ZMQCw2iiIqa4CXNG@nvidia.com>
 <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZMe0zQ/29/gLGBwZ@nvidia.com>
 <ZMsOAv9PjZpLaf4z@Asurada-Nvidia>
 <DS0PR11MB7529EA8256BD06A96C8D1A85C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529EA8256BD06A96C8D1A85C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abbb023-c940-40f6-01fb-08db93cfae54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWl2AN9LuxgqSMsd3K45ZE+aB9xzZDDOCpMNwZz6mmx4JPQVVeJolRLjemJmbnJLsUTfYWTJns/1+1k3wT082T9EQxGWg0eLZRmsvLaAyL/KLmoXgdkKkR4NGl7pu0A9XmBCAOlnHfG4ksvFShm3iUcEYQbqtZVYeIQt94KjvafV/K7FOJ80oyEzgd9vQSP63V9y5liQAaGWHKu5oWZG617J3b6TIalA7D70PhnFL2f1flcXqasU6BE12dPLkJa+E2IFtv0NRqDMjdg38tchCnjlHbQTnMZJqoVO1ZBRXK3qJCvgz1IIFcG66uiE/QJpJ3FrYGnqCvMUKala+ffkh7+0axsQdKftermN5yO8X5Y4LvpcHg+SwMVKUg7++MdRMLnGptUuPl2ttmlXwXE0PkGWFRrznS3VZoQj7xpz4pm5cbyQV3njL6Un1gdgYfzl3FaKA6umyUQ8d6fkb9nR+b41MOaf004teGSfwVOUtrgbozLAXlgwOWMsI5XHIlT0vGBL/LI7ctxuLZ8vpdjr5QBmYxI16M+2oyKLeSWnootx2FNAe81HERzDWaqWxXS0YBXS6N2znJLp1tB5A/tKQtU8pzON0AxUdrpmPYAgyZS1w4legIjEa1fDilOI9z1yaFNoNhklfmM+SQN6oyQ5kB6ZYBS2T9ypNWPECsUdnu1ukD5ZFYYsg+VHFmOAdm8kVJPcb0Y6S/i51kjjozNmQ1I+uS+hoPWUsV5H11NAEIpDWDPb9ZuheN6/1WHYyWPo
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(26005)(186003)(83380400001)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(7416002)(41300700001)(8676002)(8936002)(9686003)(478600001)(54906003)(40480700001)(55016003)(356005)(7636003)(82740400003)(33716001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 03:13:59.3749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abbb023-c940-40f6-01fb-08db93cfae54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 03:07:23AM +0000, Liu, Yi L wrote:
> > > > It's not so explicit though. Perhaps worth to have a check like below in this patch?
> > > >
> > > > if (unlikely(klen > sizeof(union ucmd_buffer)))
> > > >   return -EINVAL;
> > >
> > > Yes, stick this in the domain allocate path with a WARN_ON. The driver
> > > is broken to allocate a domain with an invalid size.
> >
> > And here too with a WARN_ON_ONCE.
> >
> > +       /*
> > +        * Either the driver is broken by having an invalid size, or the user
> > +        * invalidate data struct used by the driver is missing in the union.
> > +        */
> > +       if (WARN_ON_ONCE(hwpt->domain->ops->cache_invalidate_user &&
> > +                        (!hwpt->domain->ops->cache_invalidate_user_data_len ||
> > +                         hwpt->domain->ops->cache_invalidate_user_data_len >
> > +                         sizeof(union ucmd_buffer)))) {
> > +               rc = -EINVAL;
> > +               goto out_abort;
> > +
> > +       }
> >
> > Though I am making this cache_invalidate_user optional here, I
> > wonder if there actually could be a case that a user-managed
> > domain doesn't need a cache_invalidate_user op...
> 
> If user-managed domain is the stage-1 domain in nested, then seems not
> possible as cache invalidate is a must. But I think this logic is fine as not
> all the domains allocated by the user is user-managed. It may be kernel
> managed like the s2 domains.

Oh, I forgot to mention that this piece is in the user-managed
HWPT allocator, following Jason's suggestion to separate them.

So, perhaps should just mark it mandatory:

+	if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user ||
+			 !hwpt->domain->ops->cache_invalidate_user_data_len ||
+			 hwpt->domain->ops->cache_invalidate_user_data_len >
+			 sizeof(union iommu_user_cache_invalidate))) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
