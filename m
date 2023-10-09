Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE37BDEA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376358AbjJINVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376370AbjJINVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 09:21:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE7EBA;
        Mon,  9 Oct 2023 06:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeSDHuk8+vJuJ4d935eHTgSUppQSgOTQ5+OAFh9JIrVZtxuLeLq3vywlcD5LwIUaYGVcpHU7kya7Q5+zVMrWt+OUtFyZWGWmxKWuXldIwMHZdcnC2CO8pbafB9s1XKWjcnCxf3lGljoRzH1ccGdVjJuiVJmxyeYBxrc72qVGLzil0+YRD17nrQK0YwV9S5q/rqsO6zQDNDDkytD7HAH4u/t5fVHV8tMERhFKr/R60QGmt7nFiKRKue9iXIJNQ4zU5xawbEieJdz51gvfY0z5Z3elKZI3lYcl5b1yVcoLmg17PUxB4oWv77hDWdYId/ah35FTfbWJAOHUSwAyzCEBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKxVD0Oeo2gn+zQfqubTHtydjMUVSEnmEbyxxzmTP3U=;
 b=hTAsMqmdxImIUNIyBkwOvA/1ELvfHQZpZE9SW+7d4NlOZMdkU86jjnVfScGLYeQrCAIKuVYO0IHvewxDUe5HEz9ztbwEHqlXm4NWyZcCtwuLUJXfjtDzuu+iuAJIm1k+GHf6WE9hHaAzbKNc/pOmWY1tMmHCzmiQZ0sAmuLz19wYt6YpyULClpLPs8VSFDN1qzV35JUV1OSl/DDdLITlds3X5Wm5AKnCs6OfZNRsZBw1TGORepyWWTSpIKBppHTPvF/C7KY4kWFDQwIKJDVZnadyOs5RpkXGXOCFSBN6mkIJO8p9xof4VCh39Z5tRmZy3AreeTfJAZWhVkLVJ0z2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKxVD0Oeo2gn+zQfqubTHtydjMUVSEnmEbyxxzmTP3U=;
 b=eERgRIi1ehZola8VkoIvDz1+UAMpqQjFhUavlSV1hNMLmadnwtei3XTYpX1VYX9t181yrCCcugDpBNDdliMfELHOP7qvYPkzU0wJEyyyjDTVfCPV9EBRDFUErwGeBInaIwYdB5FgUhsuWLCChQyaCCrin46HZuknci5g1SXWpchJjITR2EDbetHJRljqmZwP1XtdZkxjrPJfEoVE4VC0WkAGLW6/lS0JpRRWtY0pxMPEkeSwHhzBJiv7PllU1h4/6/MnQeL5+l2d3fK2WG4Go4mBKfoEqz4upOWCbMwgVLkS0ZVHz9ceu6GBLMO7yq0M4fF5RjIERw8KYem6Ma8IsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 13:21:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 13:21:16 +0000
Date:   Mon, 9 Oct 2023 10:21:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [RFC 0/7] Add SIOV virtual device support
Message-ID: <20231009132115.GA3952@nvidia.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: e5144cd5-c480-40dc-21ff-08dbc8ca9e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0ys9j73n/ZfEuLVf9udvm5NK8t81x5tvUneAnZOhrda1ahmx7l9v9pGZ7oUUtEJ7TAz5NcI8fFwqOT+JPQW+xwtOGP9U0k/GmWw1VHSTSCePxkM0IIoJBJMRiX8uQgsO+mOMv3AH65QuAFZzrinYRjQRbb3e1uyYbsJUGSNb/wTPADkyFuVuUURhLbTdQgeYalrE8nEuCdfo39jmP1wBwRRzjn3IobkZ4AIiPvDoZwXRrOFNSCQTtkLeFhY441wjMKpYai6MEcjYiHO9UKbJoDXYbYfZb+KzYEDQsqnhuK8sL6w42BIYY09PlvYHR7xyG2adjUzNv2qnbAjgLTrMxBmBxb28SYOOn1hvxMdCdu/R7bSwfDKkRkuoWUHJ0f71KwCqqLAtmZJAcx8T/w8invl6yHoKvX9OXDgZ3d60lD6c3DsyHAEl5XhFk4+gwtYez17LpzyYXn3e6v3PXOuYsLjXDkw+pQ0U2SRvaw93Kb03V+i1kTH0aedQUuyKvT3DkRiy1mLU0kv84APapnoc5zSPNtd9eiOkOdsbed5nZNbub+c5e6aRTxujPvv7iZw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(86362001)(33656002)(36756003)(316002)(6512007)(2906002)(478600001)(8936002)(6486002)(4744005)(41300700001)(4326008)(5660300002)(8676002)(6506007)(1076003)(2616005)(66476007)(66556008)(66946007)(7416002)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tkK0roaCW3OT1p5/2wD/qVUigdzRd+oUb7QBKa2dswTszqhPmrVNGEx/CYV3?=
 =?us-ascii?Q?7b9mAS0eoGThNNlZrIP34vLzsDdpSsWGk+0SzAd7cPLd8ODeLDKA0uTomDXm?=
 =?us-ascii?Q?JnoAfGH5if4t8fw+B6u5gLlvmfNXcHp+Su9b9hijUiJG4KKw6yqfbpafKces?=
 =?us-ascii?Q?KB5c0aRva6mqsByH3GEuyJr+y6mNxhV7DsP0L4fzQxQbQsL/I6l7tP4y20+B?=
 =?us-ascii?Q?AIxh7GYvNK8d9R462WFBH9rB0YYwIBcLsJQ03BD9R7Iy6F77z0yR3+k4qHoG?=
 =?us-ascii?Q?81K4T84OQEVJSoCuq6u9cyMSSO3K4Ti5SBVZSE8TRLB3d+FAqUJ5pIpmCMLa?=
 =?us-ascii?Q?HTwKDWAqVOK6KTanDqYi2BDYdOfnx91WdQFt8ufLzlV0yjfuATxihBaRIEiM?=
 =?us-ascii?Q?s1lvvZ9w1VJPKxgFt3O9EKVsam7MouCmOvZWYPjZ19F7+qPuW8NThe+NQM2N?=
 =?us-ascii?Q?VscBbocNw8vbJ+oSC0GGhjKdBdAD2XlKjxg/tHucisdBEUi2g/OG6liXQLP8?=
 =?us-ascii?Q?n1TF0UVqolnkaQfl/ESoPaVccDpv4OW/pIRsVXe+53XywDNfGDicGcK9FFKs?=
 =?us-ascii?Q?na2bOPSgWk7Eu0BnuspT+YXyHpx/XD2RsQY0mS4czTICrTulKMXv2L/HKnru?=
 =?us-ascii?Q?bq+9rqDfm13DIujhmSTLS2waqIPoX7H3+x0gnMGoh2KroPiLjTreIvQCzMuZ?=
 =?us-ascii?Q?VLH7SQ2mhK1jSPjrtlzXqqKWHbn91/bEDfaAlyXrGpcUNIarU0ZcknYkEJpR?=
 =?us-ascii?Q?16KWU7Xg4YFhz+0Pxb4SCwfcAwwxZX4HLGTkliELXI4qXCZu1jRwYJmNJa54?=
 =?us-ascii?Q?qc8b+MKPSWK0Ibo4kTtcB2gYdyisDwK15IEta4sfPoTJtbxvwz9BbHgFIEaK?=
 =?us-ascii?Q?p7w43EZjVOZJaKiC7emZqkNt/4bZEXQrOOP6N9Ul/JVIQH6Rkdbg6YkMlfoF?=
 =?us-ascii?Q?IsaVVSq9+cYGN7Mg+t75zqza0IMHTVdLaRCx/UGLmXym8FDyXwNb2p9CjrFx?=
 =?us-ascii?Q?Zc2RnrwOigPayJKGCCvlcRVT3eDiDIwuWTF5LCZsPUu/yADBOCG5OEUztAHJ?=
 =?us-ascii?Q?AeWocXHT4DrTESIn6h2j1a5QpiIYzMuqFWEyZvBUzVx7mzUbkX5dsSnpfvR7?=
 =?us-ascii?Q?MAMDSz9kk+vsGkFezybOmSoH1/vLweQMb1HFYXmADN/e+XhXBjw756Y/EIqO?=
 =?us-ascii?Q?iUmz2D2E1xf5hyk26s/vZZGHA8BYFU5IL01tKh792Mrxuy1n0LucFWu00TlN?=
 =?us-ascii?Q?50lZG0aB1Ez+ld/c4i6og5nEz/CQGaoGSf3mTW0SPDjEsKyGt5ylzSVqKbxT?=
 =?us-ascii?Q?FQ5o/03b6DE8OCL6ZOF9autW+TI9SHob2+UlY3bG8oUluRskWVemuXEDTHij?=
 =?us-ascii?Q?EmmZ5XCtD1WBKvgNMSNwrNdY8wQ6vOm+mki105WIm7rHWL3K1jbfH9xsOIcC?=
 =?us-ascii?Q?WcMeyHg7qXnrlVCUOVDrVwyRhUXtvGT5IDdqpwZDzgw9posInGgDsUF3YFMX?=
 =?us-ascii?Q?EApaE56+1IY7h7jfknh44IgOGyukEUZa0RbDCed+waGsJNhOtDUwhVXtu5mJ?=
 =?us-ascii?Q?YYfCCUkeGoMnZX4/Wng=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5144cd5-c480-40dc-21ff-08dbc8ca9e19
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 13:21:16.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nZjHgjgA+51ubJsUNqEbhkzFnLTYuZGx0hYoXGPqSgUMulKc32S0KpE4bp9gX/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 09, 2023 at 01:51:16AM -0700, Yi Liu wrote:
> Intel SIOV allows creating virtual devices of which the vRID is
> represented by a pasid of a physical device. It is called as SIOV
> virtual device in this series. Such devices can be bound to an iommufd
> as physical device does and then later be attached to an IOAS/hwpt
> using that pasid. Such PASIDs are called as default pasid.

I would want to see the idxd implementation too..

Jason
