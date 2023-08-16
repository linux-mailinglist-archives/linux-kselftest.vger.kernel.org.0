Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013E377E0B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbjHPLqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbjHPLqT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 07:46:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD62212B;
        Wed, 16 Aug 2023 04:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PygViG9UikD1AKocjK/hVMM36ccMmccOhVZbZfze3qrobQDmQuqDAgW8KH98exBYPZzEB+4OdUSwNsxNxROuuF86i3hPj3uNYqjSa+3Me8J6MZeU/r/Z7YWclmdagS9bmnsi/nTKV+RMw2sIrC8AcE2tpSnG/PwKRftI7+Zmmf9J8b4lUABMLNIWPKkT6UESvBZsgKmZKQXLJfncUitk0qozE13T5hLVfT9/yNSyjG75YRX0vYyGUmbpIfi+ZXXKd/AyMFjzV2UHlA/UXO38yD7xsACuu/AzFNOheG9VMq3tabPEcslDFBH71UdhTvVBMnC8lDYGFPbp+CD1+jzYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H42ItcpgE42iKSBvDdUB0oBDJZWHf1/RavdV2vz6/Bw=;
 b=EC8+3xKUffpCQqRWKEpqeCW1YQSvic7JFiiCuLBvNRf3+80oGeEpXa4+91IiM1ukcYLEJrYXtPQYaqKdEii7DQb7yJdZnszVce9mdVHVi0p865Ck/2c+NxiYpG6lVEZASQEt0cKITereLm6nMOxK+Jej2Yv46VAHqkmSR+auO3ln3ZWa0j15HS6O8IA+Y6BH6uCj5CKAmzk67vzr6yElusQP5+TP+H2TdqhIsYV0qRH0YGJnbgkQNxQif4bU9F64ggQZkO1P6OBmcOcLlCcZfNUvAk2HWL/kKrsDhf3MO0Cs3AhTpWhZ/B3y+Gw7omS/UCaFuqeOQ9FV65YbRDrl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H42ItcpgE42iKSBvDdUB0oBDJZWHf1/RavdV2vz6/Bw=;
 b=PLDbmJFwND80L9MdjraKhH+14jDsOY5RFRhMRk1gAooEELG/QKN7yxk5aKO1XEgc1olUUoXVr3YgVmU+F33B3Px56pKCrpPRJOX8fEcwgv+VD4ScCr88cTaMkmTOhejlHl0ZMEBcOJT5B3NZAyHXPNh8yIoGasw/6PqWjgCf5auq1w/A5YuX2+z8d6arAbcicESzE5c0KUa/tkEeoqtQbNnHg0JWbazgH3YMmbZvgiEQrq9dsUtRF/0RSEFjEFO6JjXOJ46IdVdO+PknjRkDygC6eiVpDFeIJxCJA8ED0jHWJcS2fIWYDrwB7qHln2DDF57YFjvuTriL+2/70r53XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 11:46:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 11:46:09 +0000
Date:   Wed, 16 Aug 2023 08:46:07 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
Message-ID: <ZNy2/4D9AqjtUAnF@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com>
 <ZNuoWRH/HthxsLMd@nvidia.com>
 <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 6192387c-2652-4ca7-ed84-08db9e4e61b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqI+z7n3kMWd/rAjYzxFNbDoGlFSg7Qrc0AxQrRavsZSLj7mX/0vm6ePfN1stCXnphl3IUaiCebT5jQAuDGlBQHfFxkGzfOIMzDHTsyBxSVjaUMBIsoaQY52QTXEjdJk6wsnxy8TYsf9R4u5FmmxJEdSgUZMbc457UqNYX7GYeKxF66IdoXXk/VN8csoMJB6WAybRTvuNLBFLPXJIuxwYZjM9d8y00z8wtK0LTxlSEckLm5wldBBdi79QgUgTh9E4Y8AV5KuFePT/27zwgnVUKwwwte4gc/haBzHhm1qIV0iVTHklbKX+KtYU43BGNZnUAzrrsVeaQ8XN0EAgw3mh2Wk9aeu8opkZx3D6QJ2LTfmOa/zMHBCrl6a+yNz+cAm+p2UUJIDMSCZ5fyc8s0HdUsmoOn+Q79j+x3DP+WmHDNyfURJM670owkxAbZD5Fz8gLIRjH4VE9vZd/hLvQIkwkOs5SwB/J7ZcoMuXy3QmiLaEka0mJ+xeu4KjlAshildkxQvez3umvJQNFMWe0RI1jnT3QgMUmlJkgHjb0vztS+MpS+PrM1XnobFbPTGpgwj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(26005)(478600001)(7416002)(86362001)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGa8YBXHX+IJiunKy+IC8BiH77pmRAiKi6L0Fn8iKKkwOq11xuipoqpQj5wg?=
 =?us-ascii?Q?WzRqIS3HlzllBnSmWDSIrcTkXyo8PIRm4OMMGhv+W+3UibaIr6LL0V4G/exT?=
 =?us-ascii?Q?uANnBmG7Jv5ybdOML5gyv94XTyS3ootF0X4bj0WIml7L14l7b8hl/icrReA1?=
 =?us-ascii?Q?qe99HxxrMxlkUCfbrTyMhcwZNp+KINaXx/0WgWI0APHSfG4GmN0Zpgd8wSLT?=
 =?us-ascii?Q?yvruUZAymuC4rfIqmFnh1dK+cWN+kswJc4fWaNH8nfIAxisDUmmSdR+Y5LE+?=
 =?us-ascii?Q?msCgA4PkAYYuAfmpWjtTznDGvEIogKwClYJnglkgdbNKIlviUkoBzw04DxBV?=
 =?us-ascii?Q?mBhUP4W99LQ2KpnuqpVapOC+rg5ER81ZYk1cqzLwCaZlwd2GGRWYNaNUznRp?=
 =?us-ascii?Q?Tbry5ubk4twRz0Wm1VMJLcxKZ8fFM45sw9enqXAV5onftYkeECxsq27k4LBw?=
 =?us-ascii?Q?AuSyJAeKDsJaqFNUIagwAZtjVoFWauvAKbSiqc+kxeOoNIxaQc5h3f8AotSE?=
 =?us-ascii?Q?acwtdpegyaqJMhIT58QbM0u6zSVcD9zXFc7d8l51KJo534Jpuq1QH+v/hBqo?=
 =?us-ascii?Q?V6wWAEOfbC47c4oajzOSx8Am69dsWYjyXd7Y2Y72f6zZcl2z8B+3FcFQGpcm?=
 =?us-ascii?Q?Y1YwIFtoiyll59rjVW9e51rlu9OXnaA4tXGeqC07OBD29+QV1o5cAx/uvzVe?=
 =?us-ascii?Q?BomAVVXH+7UTJ906JJByFyc09U7Sjg4S30LnhdTG4lSca1BqeZjxzcGsjq4f?=
 =?us-ascii?Q?KrDKtKwbH/lplCWV1HDSUNPxHC++qV+6BKnavG2ZgsMhLUlc3lPZ4/q8a3ti?=
 =?us-ascii?Q?BWaKrn1EiRcmUy5iyoJ7QHffF4G/fYRB4TF7lmCJnPL/coufZ+N78ruimLEc?=
 =?us-ascii?Q?Tr/4SjmbrsDx1rGUPTMR6hpPM9q9Dgwn54nrM9GC4zctS+2if7keovCL/W11?=
 =?us-ascii?Q?kofBG9gaGaQO+Yr1qfbpx+SLPzymuUI+71HPToGBhLb6U6Zv5xRF1fyAZXmf?=
 =?us-ascii?Q?lBRbMezKjLsakOEOERuZV9SnwgqMO4gJMUs31TvIpC3pUBwg2LHaOABOT1l8?=
 =?us-ascii?Q?STH/T5PjrO4nN7Ilu17ikKlreQgiUTjCw09ak6FaoqxBVUOzv3HtwhuOUUjV?=
 =?us-ascii?Q?lxitBzloqWILP+HbVN8cnFVHtlBQ4DuGSVMqJecQfHknkv/GpqBEu8OR+rIS?=
 =?us-ascii?Q?miGzp5SpfiV3OaLS/pMHTRgF+ZjmVxyjdts0h+v6pQDLipAywdqGJnuH9X/V?=
 =?us-ascii?Q?hMTn2QUphxhml5Oe5CfiHdbtkg4Njw+5NfXHCN7+6l791NiljgGimHdykHCo?=
 =?us-ascii?Q?bMrFo0bglFtrlv3+Q56tjqiFd14Cbd5q+mHEAURk4cot/ul4say4SHiAiyXx?=
 =?us-ascii?Q?ZdajfsCVaAjj46nKmr2rbzz093K5J9IbNaYCMInmv56kEK/4mscDgEGweGSL?=
 =?us-ascii?Q?SnJSkvIqjRjsZ4XU/6dljUzlxAOIlR2qXqa4lrZMGbwNVuIrUR5ZDOhy3Jpw?=
 =?us-ascii?Q?/Z4zCfwEZBB+8pOaJ70Rrw088jhlYUyVs81Ti9W7fVZscU/K9JEyDwSTPKpE?=
 =?us-ascii?Q?XeTn1OfHB5BRDOmDf9tnWttS2tE6A9rmMCN+ucdT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6192387c-2652-4ca7-ed84-08db9e4e61b4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:46:08.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cb8U5cn98h1QdJJzg50+oyhZ9zdTeWEzZBFrtYM/8EWgHZzgLMVvYLpyRXMKjjR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 08:35:00AM +0800, Baolu Lu wrote:
> On 2023/8/16 0:31, Jason Gunthorpe wrote:
> > On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
> > > Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> > > ---
> > >   drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
> > >   include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
> > >   2 files changed, 42 insertions(+)
> > I would like to pick this patch out of this series to go with the main
> > get_info stuff so that we have drivers implementing what is merged. I
> > made the trivial fixup.
> > 
> > Lu are you OK?
> 
> Yes.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

I changed this to an acked-by since you helpd write the patch :)

Jason
