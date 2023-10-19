Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4282E7D0588
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 01:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjJSXx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 19:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJSXx4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 19:53:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A11113;
        Thu, 19 Oct 2023 16:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEXVvNy85vEnwbdYmP8XMV64aa/YhXh+v5Tv5vRUK7Gu22ZV7UWq79lMGxx0hAvt27XXEcYrDFpHsfMLbZ1WESuka7kKafRlV9OPPrZbPiihEwTYBwavUWkQboSC4DD+jZByz2YxRVzFKkp4/oD92ugbKd+PdD4S7xw/+i4w4ZzWca2kihJ529M4zVktB74VeZsa992Aesmbs/2RkKt7J9HF1BuNtm1zi7NbX0qyqdKvzgr14RnGevAnYynQkX+SOimrIULO764rFR3vPlDu8xNRhVvc4apqkz+IDm5RNbBoDDQ6XDDL/QGd2dgGDguG+RwPAveEMGYem00HETMN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVayXAx730ZfGYPY02vyRo2MaIXdmrPlD7vywQpvFjQ=;
 b=at0JFlgVKmzfn18GCErdnASdp8uAkXmD/UNGuhU6jJTNIsozhrxRzX7IvpIpel3zYeD6T8fTW8v8ruyiLXLS/y7DkUW5tBYj+C6sxFKtKJ/rvEQGU38ycSEAAZEvo4ZFPVlUCBZCAYbZpGK1Vrn6UDGnY16MauGEc4kGRGwIAtrlRpHDr6mYm2DqPIqP4YuNs+h9HamVWIB6aGzJBpEO2crnZ7sisqXDwYKPGDiXJc9BWpgCbgP69Z+bXRny+jctjAuQjCm3g+C6kMCC2xewwwOUMceZCe+4Hcb0a9y5G2bFPH0t0nqqmLWBGIZ5MwfEc3oTGiSxPRQ1JGTK24CMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVayXAx730ZfGYPY02vyRo2MaIXdmrPlD7vywQpvFjQ=;
 b=olMODemOZoGiyglY95X+3pNOH5X8QJ15VJCcM19BqZqwcCdjiYE180NhVsEjiOKLjobMrZErOu4Nmx8fv/YkO/t6huvUJuNN5kK5VHeIM0kyN6VPgzrHuffJ8KNHvbTMBPRMJBa4+FTJXNxhqgpALW1u0WyfDqF6LmsacvXh/Eg2ftuBhTP8nr70uNTMpa71dJaAYtJiaJSoLJN9DflPuPvhzcV7c+3abN2Lr3DKk6r6w2PZb7V9VTCHkNWjJ65woHbkVaJZSgyEO5WA10IaUp4GqSaQ1i5SlTt5QBdDt6xYMIvj+YjEx4TLRDRYXZib+MEcOGAHQIoH0PTr7n+QXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 23:53:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 23:53:52 +0000
Date:   Thu, 19 Oct 2023 20:53:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <20231019235350.GY3952@nvidia.com>
References: <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:208:23d::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d997d04-a33d-4630-272e-08dbd0fea536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMunuprMaHf6Gpk6hCvEUVsNnWu13PJqXav0WGIDGvVtmmztjcg3R79uIdLAcyOe1yCWxHdaHVXaQ7b7ZaVuy4DzpaISTU4E4qG98w6Cdidf285LGzmX6/5d5yMaVlvmsXY/GzmEN9aP7qUsng+TGuFpWRs7Y9kqyOxDf/2mKtLuB7DPAsunynDFXvK1kwCSsWv702FzSQRNVmXeBuIW/CTTEWTniKackVbazYhYgT/jVDOT0ZfouTHeiYA0Ce8AruZgCbKQqx6SsJRHIQm/+m06P+ErerBvyzrUniwI8lJtImmm3bIDVwFje1VNv8bU+ANox4eZJiII5J5rQf7R1N9XN1QEEsLL3hADOOTNsbf/rxOCnorVJppnEBfYb2qDLs9la6dM3j19WJ2eWLMuYVkQqY19h7dHOMLP/USBwJa3RY0Db7E4Y6RvC7/g8O3UpnLr6QPyFKoYS8W8n9OtTgBNSoT3pxVhmcvR0kxxZa8drPSTfDkGh9cSgOsb7s7BJy3Qm8Lxf+ju6ldhjIvxzC69f2KmLv7s6kNXj/6Yk/hPmF46pWhXed8a/q9BKxl2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(6512007)(38100700002)(1076003)(2616005)(26005)(36756003)(86362001)(66476007)(478600001)(33656002)(66556008)(66946007)(54906003)(6486002)(83380400001)(316002)(6916009)(4326008)(8936002)(8676002)(5660300002)(41300700001)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6MymyCVDBgNHDEM21Ksn6i+tEtZMRlcsgV/vz5SFK4QkQP9xTwnQ+accLp4?=
 =?us-ascii?Q?VPIdpb97fO0QhEK/FiKxxq7uL+KRk6jB6N4d96rv4TdnY35ieSrPRPG0fTqm?=
 =?us-ascii?Q?ssEEnRw2c1DIA9EPcB94ba9J0pGy2tFlkvLirqpH/BceyzSdMis56UxZWQXc?=
 =?us-ascii?Q?cwHn9JbksrmkpBVX0vaPSWl5cefqNKwxXqr2O0V7jw7pzbgJqIBy8YUMbk2n?=
 =?us-ascii?Q?CqsehaT3YK/OMZc3ceLiU4c3zTqICQGvnouZ3X9y5/HmSTbJyZj68Dmp9J7g?=
 =?us-ascii?Q?SVk2GAa1Hk2Nhib72o8D3hjbB/4mXNwSoNqHPiKP48rHqBX65POLe4FpPEqe?=
 =?us-ascii?Q?WujiCYElIvo1Fl4y8kEJTsJ+7ajNc1bMCYs0jqLsCuVnx/pb19p1LwRXC3iC?=
 =?us-ascii?Q?KptLuODssfaoBGYrXzk8fDg8hNH6ZJRVYrWfNB+V7zhthQB6jNJYdV8/zdRV?=
 =?us-ascii?Q?RSRvR59AQCtxVSNb922OWeKj4KcgL/uxhrIiMeuAOJrqaqPIZkdeQPyEZPKF?=
 =?us-ascii?Q?kmxaIqdI4T0TPoJtI+t/uyWJmHMESmGoTvZ35ScgkhUOSrHDo5bLcxbUn6qf?=
 =?us-ascii?Q?w12v+D0HzcGlmxBJvyVhz/2+Ike6VpX3Irp/bDjQKOF905YTZOmZaCRCWsGe?=
 =?us-ascii?Q?5zP9HnYe7uAZ2X1a9OfN54oWaqMdHUzffFblZ8weEm8z4yo4Nw4Jhrw2I05k?=
 =?us-ascii?Q?aHkoS7XjOxQ45GMZnFshnHZl/8bdZVGSkT68YNHbAejnyVhyMZLSRsa2Y6l6?=
 =?us-ascii?Q?c5r67e0OAc90VAQxbxcSBDs/tWEnor1xJijzKMAH4AR9tVBatAKmn1qS/By5?=
 =?us-ascii?Q?/mokoac5oIiKOkEC1rW0BEJtv2WeX5THBUqPiq2ask6dtUMOknFlcf7mirYF?=
 =?us-ascii?Q?mgGqRmgpZ1sb1xDY5R6GDiUVb0RpvgUjLeKNqvm3Md+rg6ItfvFHxZrg4YWC?=
 =?us-ascii?Q?T2IOYEyfhNHEhLacT9hABEnQ+VIeVu+g8U+26gajh5zuzghDs62/1WpCob3U?=
 =?us-ascii?Q?aHBQcUPoo+1gUXgSYFuAbOMTcLjdhpc6wtUS8iHE2daew6TUP+3tScStu+Sb?=
 =?us-ascii?Q?zIiYPIHFddsL7NT9HuCosAi0u0FsPHR0fiU+ajWtDCDd/m3Ff51OD2Wka8FY?=
 =?us-ascii?Q?qmTw48F94Z9MAyNIWeYIPqWTSA/3ztIn3kmIN0jWWRdAwfIu2llnG3K59tY2?=
 =?us-ascii?Q?6nY/1z59zWijdygQEUhjclaQxt+pMKgGNdpB+nOSUyQUlKXtlEdZG4943RlM?=
 =?us-ascii?Q?A1mk3oJiWgZCWXwcLFrl2VEy+Vgrx5a74UCom2Zp+i0UPd2JGRvMTJ28zkvG?=
 =?us-ascii?Q?CcN84BBw8nhcwwNkY5PN1NjnO/zLlmkig/kVdm5siZAxC/QG+usH2RgGSmAh?=
 =?us-ascii?Q?N2H0Wgb5XAQEd2ubIKYXocu6QtBWV6xj5R5YC3NGwNPgqDTLdLW2oBKuk0gR?=
 =?us-ascii?Q?Jkzo5jZZf10wszFh1svVkSU0LY5cr4+B23/B8xoidGzEpRqI2VoOoIrPOE4w?=
 =?us-ascii?Q?xs/DWc8NzieDAdNuAct7mkjg8WuYubXXYZ/3T96ViLUs3mCFD/QSf/MAV/ER?=
 =?us-ascii?Q?kPx+hxrAHRt6y4zIrVyQCeDXbRJAEZhm9mxmUsdZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d997d04-a33d-4630-272e-08dbd0fea536
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 23:53:51.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwQJyUZRlrOv1IxNYI0QhCZ4jEp0poNgylTai7Yb6jyks73jKbSULQLcS03q5vQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 01:56:01AM +0000, Tian, Kevin wrote:

> > Otherwise we have a problem where the order devices are attached to
> > the domain decides how many domains you get. ie the first device
> > attached does not want CC (but is compatible with it) so we create a
> > non-CC domain
> 
> in autodetect model this won't happen. If the first device is capable
> of enforce_cc then the domain will be created with enforce_cc.
> 
> there is no "does not want CC" input in autodetect.
> > 
> > Then later we attach a device that does want CC and now we are forced
> > to create a second iommu domain when upgrading the first domain would
> > have been fine.
> 
> then in this case the 2nd device will reuse the domain.

Then you have the reverse problem where the domain will not be CC when
it should be.

> > Hotplug is another scenario (though Intel driver does not support it,
> > and it looks broken)
> 
> Can you elaborate how hotplug is broken? If device is hotplugged and
> failed to attach to an existing domain, then a new one will be created
> for it.

A non-cc domain will ask to be upgraded and the driver will let it
happen even though it doesn't/can't fix the existing IOPTEs

> there is indeed a broken case in KVM which cannot handle dynamic
> change of coherency due to hotplug. But that one is orthogonal to
> what we discussed here about how to decide cc in iommufd.

That too
  
> > Really, I hate this CC mechanism. It is only for Intel, can we just
> 
> Intel and AMD.

Nope, AMD just hardwires their IOMMU to always do CC enforcing. All
this mess is only for Intel and their weird IOMMU that can only do the
enforcement for a GPU.

> > punt it to userspace and have an intel 'want cc flag' for the entire
> > nesting path and forget about it?
> 
> I dislike it too. But still not get your point why adding such a flag
> can really simplify things. As explained before the only difference
> between autodetect and having a user flag just affects the decision
> of cc when creating a hwpt. whether we should upgrade in the
> attach path is an orthogonal open which imho is unnecessary and
> Nicoline's patches to remove that check then also remove this
> patch makes lot of sense to me.

I don't think we can remove it, it is supposed to provide consistency
of result regardless of ordering.

Jason
