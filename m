Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B607D6A3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjJYLeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJYLeC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 07:34:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13579129;
        Wed, 25 Oct 2023 04:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnd7DWiG1d4HIrClW/EbniGaLcd7/qUjX3Bs/yWUI61+ArMOwLBBBRDcFO7O7MFjN8YupCZXPw6gHVYV8Lg8yCb/jKh1gl/oipWBC2XyZXSnw+zG3c2v+fKDz8eG0T1Pi5kuU9tiwbjeW1t7l0eVi2jjC5aj9nFOsZEZn7MpwngiMrJ799WQ1vMEAwHX+uuooFpWXKqLjGWb4BNv9tSCfRbCYzABt340718QNKr18LjSQM8Mb/u36ZtFkO3Qiwai3FQ3CaIvH76gPEFpJmMI07Qo3+Hve3gedXl5EGGG0MvxnxZlJN3l5f2/nRtE15wJNH6BlfSuWxpzD7GTVHAKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfpKJXaPcodKfu0l2Mqsb2iH0nb3MDEqtmU9UDODzUk=;
 b=Dd+sUSKsUep79Uvyy03pGEWl/gcohixNEY5EdRDDuhG0nvZzmyyhHQLjK//bnaPImOVtVu0GN92zTzUWyhnz61xuJ1JsnnkTzfcFRJsUkZ+Yuay17s0gsIPrM3mW1o9Y9Z86dW+iibeSjh95/pS9ttzfanVq+QvPgTevPmIORbPnoGnGAOPr0UjkeCIKe4V5vnM0hbttNGQGK5WZTXIKxqG56mkx9qmf2i86SGXyS5dYfpQvhjUQvxeQUMRpuNwL1aabybXZj9396tYbXvGLfUF6dpCrUTDGKyCqQYNl9scQxW8sRm6Wjo9SGMqBJIlr6X4Kdx520k/d4ZlhTxn3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfpKJXaPcodKfu0l2Mqsb2iH0nb3MDEqtmU9UDODzUk=;
 b=G4Zf/OScCEKa04mFG1yBAlMa58giFxjKha9tZO9OaJJfEl6J61FhLPlGeh/IiYiAHm9Tz/j5PGW9boha/31tAHxXGiTDEu33ETFfl46PDisfVaByfMjjPb0U7sR7MEWWC8nPV6qFm1P4X3kM7vRso84nZuSNbqaXSw6ZkZzKv3hKajf+zs5kJ8aBG5JU8nAxzX4WFyPd9PvE+j0F2KLEcJAyJVGM61gaVHimXJ8AC7tkKMpCIWnjpQdm+W3bQtgGLYlPkt2fhn+7gROXHkWicKBLARawpD4qrNxIiD6CzAgskibGmjiNZpjfgaA9oba40ybcPKBku0CyyU8oo3im8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 11:33:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 11:33:57 +0000
Date:   Wed, 25 Oct 2023 08:33:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH] iommu/vt-d: Enhance capability check for nested parent
 domain allocation
Message-ID: <20231025113356.GX3952@nvidia.com>
References: <20231024150011.44642-1-yi.l.liu@intel.com>
 <62f396d4-f890-477f-b9ea-7b330fec35c2@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f396d4-f890-477f-b9ea-7b330fec35c2@linux.intel.com>
X-ClientProxiedBy: SN7PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:806:122::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee603a2-29bc-4544-0f17-08dbd54e46af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSaUzxXQhPT+n3HJYGPR3bSjWShvN5JzbDtPg7IhMxLisvWJNczuuWdi+xpFFamvTrnKlMIclMn+K2yI+ys73T/gn1SmtnWS79zC5JEfIPUT6KuUnP1Gr0IAUJw17pUcFjl4/mLCZHRuYPXavFsEGmJCxnAMoWUWdo7eWkCLwuFMHPCyl/C41LLge7+kKCcD2lufAlCHo1V/QV2HRSgvPJGncZ8nM8SN9sR7QezbrpXQq85qlnTbREMNC+rdJG1Ediz46WYL3Hf34fjQYuc9kSytrHa2fDNLySe+7B/EpWN1DvV+X4YlPydQhRiI8Exv4nLLIvBJL7oyoIQB1KEke8BFXuGLpGWKzPU7P0DrcxglJZv6T03AuG0xCkhLiWLp45+GaKzkIORxehuL5DFT69buBclgSQ2wJZYYLqrHtB0VQMy82d1BpV3gE3cs63NpbXtC0hjzrHUVfqOehSBqVYGcjAAfv2ztWr73yM7jphviyev9DgK/3wCuP52NsEInyF1krd6RZ9brnn+ffZsB8Ec5s7wUyKTS3hG3MzGtMdKj5X5vsBrDebsI48oZFENY60Ux+jtnQY3S/AovQUfZFpGrnyukUtdkwr+PoIuEVZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4744005)(2906002)(4326008)(8936002)(8676002)(83380400001)(6486002)(966005)(7416002)(53546011)(41300700001)(5660300002)(6512007)(6506007)(86362001)(316002)(6916009)(1076003)(26005)(478600001)(2616005)(33656002)(36756003)(38100700002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqvlfS1inqOfSTIJdqfAPO96g9AmJGYDw+SRz+5/l3w4HzpnABzNzW+M/HoY?=
 =?us-ascii?Q?OqOIhDahyuCu2ls/AuBoXGhB2MA3yrl35gQHPw+pYdJq5OPDvZiNx3GNkq6K?=
 =?us-ascii?Q?EZuS76lcdDEig1yY0PjtSukCvjqxHBnjXt9QYDTUY4V5qZXpRH0BUa53MfDD?=
 =?us-ascii?Q?2KLBOZW9/Ko/mB2vFkLqjynQgI2QXuFSVZ1GG1+iKjpBSPPp+C9oGLE9ny2j?=
 =?us-ascii?Q?5/hiR4eGvGe05puOKDNne7xNY3UaY1TGpj3vVZjez1ls4UIp24DDtbUt57Av?=
 =?us-ascii?Q?XtQ1uh6RbjaobKgaGQJr0Sa3IdO6gw72a+m2qf0ce6vxD+bvDs7MK072pWVQ?=
 =?us-ascii?Q?81PTBXEsw0NsZjKKjmYRfDhfDLGi8r3ULXfkRi6FYPb0yyUi9DcC7QU/fOlT?=
 =?us-ascii?Q?1rZ7lYF/0+kiEwvFidyRWcbfjZiTX86uloj7DjRRwTK3mcJJY+dJc26UGrik?=
 =?us-ascii?Q?4IW8SeB/b21je2REltKGygemv8QcY7vZXG3fDLSZPSam061YditxidkBfa2h?=
 =?us-ascii?Q?ipMM1vRdZAagpnpTXJrnLfAzapkmf2RW15hW31km5937t5iw0tDLTxyqCn0B?=
 =?us-ascii?Q?Xuy74naOeiEFnUPdGEmSMB0j59oDZqvuX5xrFqvj1BSqnuM3hpeYbuSiMcL/?=
 =?us-ascii?Q?X+DchuhP/m6YZXC8Xq74A73WY005aP0Sx0CZDtEzJ9FM1YZ55ptPljRZdS14?=
 =?us-ascii?Q?U9xD4iBV4vROlC9UHFtGtvzQ7QFMvj6tkZsWkN1y9dj7ywWIVaEEqeUwb4xT?=
 =?us-ascii?Q?vKvSU0aQBSKwHz9IzUtgSewWKU4BucsECqL6ksGEMBljMvYrTcrJ96xTm+IE?=
 =?us-ascii?Q?4mioUVZNBuaUpUlTXk7CZ5hz8Up41nUdkuEwXET/Dll79VoJlN2R9Gn/IoAG?=
 =?us-ascii?Q?FcSWk6lDP8pgz7jDLBawBRZjoh+IY0jtAhBxoXg6wJSMVYuZ5rIvtqkh2sbX?=
 =?us-ascii?Q?WpZa5zJr6rPu1GsccKSSpZlvlN5fyArYlkpH6AVUB587/QNX/3utL/thgZ2w?=
 =?us-ascii?Q?py9zmJDDVXySGknm+Qx9s/PWgzw+oQxaGhOBU4nF6tjhMu6Q812V8OQ0grjJ?=
 =?us-ascii?Q?YjnP4iaGGYx5beSlmg/tKf5FdAlJ5qBRDLjeqic4A8YZ1Th+cbiFRQEZ1YRL?=
 =?us-ascii?Q?xCOJegNadp2gRfejI9s82j8ObLWgwGpMv48Poo9oYkD+GoDGFirYYwyNuATM?=
 =?us-ascii?Q?K3PEUGZNBt1vwop3+eUeVgT0yXvssBWO54Y8eRPdyslzcgiWD3dxptQA5H2u?=
 =?us-ascii?Q?iaHH2EclkVoE5JyrPWJnI0p1ustBb57oy8JjdUWAKOpsseZZ5NSgQMg20Qqn?=
 =?us-ascii?Q?+a1Ich/sJ9QacakG76XAjxY3VoExjtSabL0hxIEBbDa0BXlLiHfIDjDJaXaa?=
 =?us-ascii?Q?z5T24Cmc51+IDMfcBsldfPR4LCUSxznECKdqeO9zZ2W+TvY+S6KLE9SV9gP9?=
 =?us-ascii?Q?xsS2bMu0+PNoRjIKn3NDOZHIkge0pDP/EqKqsYBGRIj7rWYK+OXgjClrZWxt?=
 =?us-ascii?Q?MSdm5bKrlTfyJchgYGxv6QVGGsNqyQcqli30sJ1hYnozDyobNjb36V/tbF2W?=
 =?us-ascii?Q?Rq67jnYrU3rTwZTUuUo3E2pRWR6N8BmjfsJelFGS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee603a2-29bc-4544-0f17-08dbd54e46af
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:33:57.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3KL2DB5oGeQRDyYF0NsIQc3W//tquh0JCdBB2y9A3z29G4i6TQmqN8oH/UxpdUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 25, 2023 at 09:10:08AM +0800, Baolu Lu wrote:
> On 10/24/23 11:00 PM, Yi Liu wrote:
> > This adds the scalable mode check before allocating the nested parent domain
> > as checking nested capability is not enough. User may turn off scalable mode
> > which also means no nested support even if the hardware supports it.
> > 
> > Fixes: c97d1b20d383 ("iommu/vt-d: Add domain_alloc_user op")
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> > v1: Based on Joao's dirty page tracking v6 https://github.com/jpemartins/linux/commits/iommufd-v6
> > ---
> >   drivers/iommu/intel/iommu.c | 2 +-
> >   drivers/iommu/intel/iommu.h | 2 ++
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Hi Jason,
> 
> Given that this fixes a commit in the iommufd tree, can you please pick
> this fix as well?

Done

Thanks
Jason
