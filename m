Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDD7D59C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjJXRbr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXRbq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:31:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC92D7D;
        Tue, 24 Oct 2023 10:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGrWlZae08AOu94au2o7efy6gCMwCPMfQwv0iGaFgfCCe/NfNPdmZLXnF+uUKfIhyBb/rEolXiADrwfyUrsYuJhEyhjy7wHiSWgbWEROZPmSBEJBpnwhpiAf634CD9pBtzWCjfSbhWHDTZ3CgcpjUMqYLl/LbTjl2DHWEQJ79VpoJ4rx0Wb5oKFgXJ0BmJZcxfp17pfYjYykEI1b+BKiQdFkD/UcyeBtEnrvVHC4l5X4CqvvhlcP6jtAZu56gj4aSxqf2AqEHbU0vKGTxw6JMk9Ciq4DaCeLq7Sj5sWTR7qjOOntNHgG78tBx7QchQj8C5KrTvNmvja3CmVZgbxO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MauixGajZ9Q60mUaB9rigzIIOaumrxQ8SeAgqJ49zcw=;
 b=T/VBuQkaSk9YBPADkHgxHaMuBOPDTLMed7xmroviVYNYhS03yddKh33sVc/QN4FZFm3flPhNrMQn2qcsIAsxdjVIkbd2zLFdR3k0qCmxFswNnEBAk+bx7DwLNIcMDJ5yZ/tj5Gc0hVMt2yYhQimxaL+Xsht5OTMKOd3bU3QzeE3oLCjwlrws5+veJ2kCQa8hX2AHx3/Yzy1uNW/leiIpVAWyhES3izoc5A910b56/LZWz9HEShRh3umRZPdT4fqfPxPBIkuTMubk1q4JdmfBo8WJXhvAg3koK2O6lfcDHaogum+SAvXVLn7tEVLAUhp7idd7n5cRKuanO0vCKG4JmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MauixGajZ9Q60mUaB9rigzIIOaumrxQ8SeAgqJ49zcw=;
 b=VF0Pxr5wphgff0ShlwqSJEcGB5lZyNtbz3Aa420R1gLWWlhNsykRpcqsmyyAPi9QZbnF5BhK9P0UaS2eAxoMcFiZwibVG6oH4UqfG+egV6sqRR0YW6UpqRbZPO2rhwM/fTC07T+Py+I7HiRveH/NXOK3A7bagWWr7udGVN+0ZZaQQ+G6MowU0VCTBhQ+FSX4OZhyfSfvIfZzHPozzc4gp241KFd+scZUdMiQ9bJo+1JFe+0bveGXkspKWszX3ddHnwQ0Fvv7pX6187T3TdtkIxdK5CSVQ3oZT9z66b0MK7l6/H+T33UucZ9Yk8Z0eZkaiT72lGr+GiD9db7P4eN5jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:31:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:31:40 +0000
Date:   Tue, 24 Oct 2023 14:31:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <20231024173139.GR3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com>
 <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
X-ClientProxiedBy: SN7PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:806:127::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ead23ae-cb08-47cf-dc76-08dbd4b71566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YhvoZnzcIpm1Bf75/Ko0qJTZ0AvI0n3tSyEZAVZ47beOemJfTJPB0/OscASbyPF922N5tx3ywHYJrWsTcnQCVcxFealEIfySAoN44DF7xiJB3RzWjgeC4TobuF1TtJO33b9g7Fe32xLj/4fXrtbD3VjXuOkV7SgrSBVcgz6+fhrTwMw27jj9gV/Rv0yYDvVqpSFJd04gqJF2+EJigRuQpHIatD2k/TqRMuoceBI6YTD4VoxfIxJrwkfUQNjniAee071b6SV4/2ymyTfzTepeCNoFCtci8rSrADB49DVvoda4Pj9jJOrg/ZrTkuoI6OgeI5x+6msWpyOUVta+EAvl1fv9GBdQysPakC0lBLErHfPpJbci1+yjDzpHR4AmTuF67AkvSK2IBT1+Oxs9+uL/YxJrZavlI6lTkQo0p2wWI8TQjnUH10f8e23TpjqLAqlG7M4awH8lxOMmRSOVne1KgT7aG8JjoKVqMUAhi4bllxp4rj0cGagLM1luXP/r91+ZA+vwYBy+HhTFabnfYPCa11JdC8apTKrbRUSal79js1KclMmxcm9hjVvBR/nWGFK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(37006003)(86362001)(1076003)(2906002)(38100700002)(41300700001)(66476007)(316002)(66946007)(66556008)(478600001)(6636002)(2616005)(6506007)(6512007)(6486002)(83380400001)(4326008)(36756003)(7416002)(5660300002)(33656002)(6862004)(8676002)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fw0IQDE30H2WgmPiM9fNcE+pqTqC3OsLMDc9KxPA8BrJ1IbNTHBgWSSmqCMP?=
 =?us-ascii?Q?hUYWtaW4b3EK7zv+P7tOpWh+NM7Qb3l023s2EBXaj2On1iPg8yT74RsM8/jd?=
 =?us-ascii?Q?lGhDpLNwOEJu3p2u7DS27ZbfaAQHM3MV41OSKVekolJqE0CRqkEuDfCg2jmP?=
 =?us-ascii?Q?G2eghn1qf/Aqb/O9W1t4vIzjgg6J2xSgBPfjPhjhuXqoQMq9/K+3EJW49h0G?=
 =?us-ascii?Q?3kC8sK6tH1Dga6KIU98wXevCO65QLUFYnhA6ks6dC6M8EulVdv/wMAgA3QoF?=
 =?us-ascii?Q?5q/sO8NfJvi8tUSdkoHzNtMIQltzRzKzqs7ISuKi75Ysrz2781cUC1aNHy/a?=
 =?us-ascii?Q?xBcEOglarZeb+z1ZvVemQ09uu3Ew34NXDBjwYdkVesVFtvOUx8SImO04lgU6?=
 =?us-ascii?Q?ADFeA1L/Pe/MsurGBKlQaCTFXfdcBHiEV0XkfFXXe21RM4DWhqv8NWnH1SiZ?=
 =?us-ascii?Q?MquhkH7EvGOP2g6Y6ZOraTOHGqcTyrSM3ARBYdEXtwf8QhMwbBVNkqDgSl2Q?=
 =?us-ascii?Q?VCTRZZkLNsJ2k+671seKIAg1aCjzdvPjSVLCcprk8w0mXli+ze86gbkgSjyn?=
 =?us-ascii?Q?ZltC9siPLmERHPTNG7k33S21w/vKfshuNvvRpB+LONpUPYaB3LRjl4OF3tdP?=
 =?us-ascii?Q?1UgVNQ7WuPa8FB74i7MqGESdAYKol1/PXjHTWRgUQLioqsCQTTpijvH+G+xw?=
 =?us-ascii?Q?RF8EqYT+4MIv6V6JWOCRbsAJAfiFkdyKZOLKkd03dA52mv4JqXgOJ291WUIB?=
 =?us-ascii?Q?8YP1qYcGcn99vflEX1XlxQ35Sr9uvGFu3DbCLiZ/wYgNEY8yq9lZ2tXi/NXS?=
 =?us-ascii?Q?Fpnstq2K7ymDaxFXNYH3z4rMYH1RBmkFjfOcJZAw2/gEE6YtsX7VI97tDl2D?=
 =?us-ascii?Q?jrcRswfLY1v8BK/KsXlMdZdOr8GN9W3Jyb7SHzOErYmg2Vgs7ZaWIzgE4xhM?=
 =?us-ascii?Q?qDi3sP+M4HARCmrQOoxHInakJ1GDV7fInAzFd4AHP+Nv4MhMuFX6L/A8eAig?=
 =?us-ascii?Q?95SPKUit5A139NImd/RMf0BAgYe5c28fv4q4oFiAfI90+uVOqRXLp009nWJA?=
 =?us-ascii?Q?nUgRVvvlbNf9bRvLlqALdyS+2cFEl55RHS2Bl8G3ATFJ/N4/X7ysIP9n/d/K?=
 =?us-ascii?Q?P2VQnDcMTtpvXgNDcijljMCQtzyAM3fF784TUrlh5j25LAncmeXtEuEq/sq8?=
 =?us-ascii?Q?8Pr6nxd47VQMptsB+o/0mO90fN3aKeJhaVBxIZEfTGviaLlSumKBRsCEyRvR?=
 =?us-ascii?Q?nxJF7rWi7RymICT0+55dV5sbpfRnQs6zadzpG8ejrW/P2XHpmKcFC//Sw9lB?=
 =?us-ascii?Q?pPSXZR6+a8w8zjTKafYrHS9kgd4U0eY2ZyvMf5kkX+Z4AerFMB5/NASVHDOx?=
 =?us-ascii?Q?UTngTlsTSxYcCPtz8uz9N5jT19U2d6/99NFcyuq3BOnsEYxINLsKf8fvUJOQ?=
 =?us-ascii?Q?6JdXEcYX5kQVIfdrlNGVAWdoaj7GoBD/FGrUmy8tXZCekGE0kzfMhFgVU4jE?=
 =?us-ascii?Q?YHGhEl292OWv+8j2Tic2OVh1FQYoysQM/HYos++dYM/e/oVvAq5E8ABa+Qju?=
 =?us-ascii?Q?MNWqFs69hUlahrxHzJ3hDzGrBbcTPkgpDvmvPtOH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ead23ae-cb08-47cf-dc76-08dbd4b71566
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:31:40.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORpauZtNgZOfPOwoyKITNG9N/ezjp1y4Lfo0pYEMDiRnTaDHVHGvlgD8pGL6oFsb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 10:28:45AM -0700, Nicolin Chen wrote:
> On Tue, Oct 24, 2023 at 02:18:10PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
> > > @@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> > >  	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
> > >  		struct iommufd_hwpt_paging *hwpt_paging;
> > >  
> > > +		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
> > > +			rc = -EINVAL;
> > > +			goto out_put_pt;
> > > +		}
> > >  		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> > >  		mutex_lock(&ioas->mutex);
> > >  		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
> > 
> > ?? What is this?
> > 
> > Ah something went wrong earlier in "iommu: Pass in parent domain with
> > user_data to domain_alloc_user op"
> > 
> > Once we added the user_data we should flow it through to the op
> > always.
> 
> Hmm, iommufd_hwpt_paging_alloc doesn't take (or need) user_data,
> but we could pass in a dummy one if that looks better?

The point is for the user_data to always be available, the driver
needs to check it if it is passed.

This should all be plumbed to allow drivers to also customize their
paging domains too.

Jason
