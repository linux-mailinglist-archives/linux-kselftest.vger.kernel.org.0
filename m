Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761DA6288DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 20:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiKNTFI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 14:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKNTFH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 14:05:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5622B1D;
        Mon, 14 Nov 2022 11:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHad/jppxVySYtKjOmpkLGE05+0v2htJW1WETM9RJZ9NK14Chkr3ZS9R3DvfT8qXFwIDni0deQa9+Oh5ISmFBMlqo1lVCWRwvWGKeGojrfoQMJ9ha0lbUVVGJw7AkgQJhy6CYWGUNhnN5x+EgdXLRdaVXKFy/SjPF+1v6sOKjcFFNvkc6iTKtY1U5Ltp32zNjZGcZDCpYtNB+BlFIGfW43zK6d5/hbkCrfrLtHhXlTtgQaoNpxJsEKzpnzc+abQX8nsIK/d5Ci5tWFhw8C6sxKNFtCI6oiRo50VveFasWPDVtASb3lQG//PI8vW7z+jmjPrQV78nwK4TCmWVMPzG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zKM0DQkkxql5TO53ep2aG2RZeB/Y5Pkq7iWQOlO/kU=;
 b=S74rDXbZ1YJlvtAjcPlk5XBs5Vk3I9CyFzU9zCHbMJRp7BxlBdEruUne4brrkkXOinAzgT7PltSMYMMd8u6Qgcnfd1lqVqcdPFUPR4y2lJDP5czqTCNRcoCxc+MBbEAXKnb4jolPDjaNe2d9evgGS9/iCTYzfFipcmHe9AekPlHw2g1YCfJc0SPzqPKtHeg+xEPwLSJtCwm6j5ItTEOsC7LcU7X1mdcB2FDagPUpFCG1FmtnHFsLdlN5Flka9YvN42iYAy7tnoh6yUgYO1mF7KiIsfW+edOzFYeG2IWUK8IA/eaHR6aeFdWrSpN2ukdnjv78CsOGBUxodRXINaFCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zKM0DQkkxql5TO53ep2aG2RZeB/Y5Pkq7iWQOlO/kU=;
 b=IBLrdFttxHn7TG5mfYoUpG//Gh6Ph9IL7VZT1yiF46VFctm+c/5+JpzrQmOp4gKDCjkVWO3HjEcFp5wHr0J4WC5JR0LxQixSErN2qnv1kARiVobty6nmo47vlm5AUvL4LoIdBnNeoJBQhxEXG/J6bXATL6KmGNdf03ZyDJ5xxTy274ouABktmS8lyxUnZCXakGBcsmArPPJtAj5gEa6wmT0FnHsMXPtxf8vnkJN4yrn2pHm+0jAusqEIQgK5fVIK/4hcaVI1FRlW+We9cfqILAAVJ8RCLfcmlvlA0w6PJewnzaMNAm5LP7UrfCOBxjY2hAkTOx451TunGB4xADdczQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 19:05:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:05:04 +0000
Date:   Mon, 14 Nov 2022 15:05:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 13/17] iommufd: Add kAPI toward external drivers for
 kernel access
Message-ID: <Y3KRXr80txHsltNP@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <13-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527648D864FB42027975487B8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527648D864FB42027975487B8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: d065e32a-a95a-4808-0afe-08dac6732337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDkx49u+4gF86sSg1ZCO0tCmDhkzR2JXUTu7nll9GMQjeCPut1Lmjf/oBMxbNLkDdNJGWFYsuuf8t3g7AvHXv2i0We0ZH3OjYssIaOOnFEshiMaIQwCeXAN4zzddKmvZo6+oLfqGtCmNtyelV7kPJuCRC6uJFfnanaTJhUevdXzyZpTPMX5bvO0PCJXraNTcDU2Wnhv2RNdce6f8bDg1ZusM+y2G76mzGRT/qdlF07HSUAjHmualfC/hVXUh+qsYC6vQo0JrrjWmXkePbCoXSkfePrLJ1Fq/N9r+oEWwBuzz5wpIxpFoQ5a6L2/x6LPbxIfJlP0n0KUYkcXcZajkcOxNQXz5nna2zWcnWRVPmePmTvgkbyw0KepHgTol4Uma8C5DMo3m4cl6t9Z9boJDBTh8u7xUyf4qpDlOs5B2HIqlgXfRksezNUP0U426cPPd+ivTCO5SWe33s4cEpuI1lZ0AlYbugJjS4GGY0J7n9mQ7eg8HaHxi9swWAuMl6UxscYTNNaJSGCeXIyskh/QC3DRLj8w+7uoxbVXAS9VW9Wwd3i+O+smN2bTbKQ/cZCmaARDZnXcGCCIC1MxYLNyEFloG6s4ST3UKw2i5jAIa2ZVEOa5/YB/68pd1FT9o3KFeM0vQ5Dh2AX9Q0VbTeUjEU11xmQPbK1bbfdDJ2lDKCG2k0CPd2qGqvd4qrUvrU29l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(86362001)(54906003)(41300700001)(8676002)(36756003)(4326008)(2906002)(83380400001)(186003)(66946007)(2616005)(66556008)(66476007)(6486002)(6512007)(7406005)(8936002)(26005)(7416002)(6506007)(478600001)(5660300002)(316002)(38100700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZGa2jslIggjli341LVDcfER2AvxL22nQh9LrDA2KjXXbdL4iAxdLl6lAolIc?=
 =?us-ascii?Q?3/aPb2rzdyfBdTLCxkFWP0YaM3XJpS/F0JALXnO06B/ESx21uMEKiWyLAZy7?=
 =?us-ascii?Q?x/vq2NR2GKKlQUT4y5DNp0SK01V4EKInb4M/jH+LsH5nsKK8zXDXjYtXMQP0?=
 =?us-ascii?Q?e5fBxvfTfESSmFCB9TQsPvzT9J0MYTmMrUrI473U0kMHaW/GAMrHRvA6jdqM?=
 =?us-ascii?Q?LSPmggS7WSoQ6Kyv1hE1ANO6JCby2a1eCs8556tfHRHIx1XdEoHKIIqNF/D1?=
 =?us-ascii?Q?fc7dkOKpAneGHYPT8Xqx3huyvfH2ppHDrtxkDgkQ0EPefnggoT6350lp+qxI?=
 =?us-ascii?Q?62Cub4DSdtI0MUPHu/6DZuE0kzUIlySa2P2spL76ZT6Go+8eMjVPpWJ5BznV?=
 =?us-ascii?Q?vyXMPJE30LJe5g3Fq1hTQCveZjTeaJjIEn+S4G6AID3XUW/ldCNLyOLahbSw?=
 =?us-ascii?Q?e0rerwXfJvHySxsRpvj9LFjfn/jh3/qdfxNpg4036d3zoMTIZ2Fp8U55UbJH?=
 =?us-ascii?Q?XPq9O6FIhHXtJGR52R1aYW9Uv2VlF5GQ4RR+MQbvr6GeIXXf5a0svbjF4vdb?=
 =?us-ascii?Q?eLzST54DHQgfNYpTkFs2DMSoOv9qSViHhTLlq8vIElLd7o7HTgqXayjcaIU+?=
 =?us-ascii?Q?y1YBqv/mWlHfO2j46LTgGK1TIFb4nToKgtUDIuXWS9RoZnMt3iDKdia+DF6A?=
 =?us-ascii?Q?1Yv904rc7vsWNcL9TGClBfsTRLreIYTlhTu89zZeVncliqfUtxid/5q5X7/9?=
 =?us-ascii?Q?P4dmsqpHLvamV3sbTk4SYUXVSukxRyEMxky11h/6FCKnYs1YSW264Brsv9fr?=
 =?us-ascii?Q?tX2VvJtR7K5RjTPSYR64iLa2XmcIYg4U5FCC64Vfs0HHQ9hk2fEUY50eb3bL?=
 =?us-ascii?Q?UqoytnOJkkSflUqUB0KTAY7gWjcikN1+P4v4WQpApq1KAQPiUo6cLJM6x+/D?=
 =?us-ascii?Q?Atko7UM8OwCO5p5YE0RwwIpxxAiGMA7e2mCeriC3acX2GiPTqb1xeZEW5BCi?=
 =?us-ascii?Q?qJpg2cORnT2+kaBnqDF+J9zoufZjsWxn6H2sBkZ7glT0mk2AX9bGL0eggtoX?=
 =?us-ascii?Q?Up4/2KLkVNJRIuClLl4qxULS2AmpvlJ7SIT6oVL9M4LEnBal+b27iNrIuwMp?=
 =?us-ascii?Q?vlfLCLrJ6MhPWd7V5UMJ61hXYI3NhP9jW2EOYzc5xYvODWUykoTbcG7DGq5/?=
 =?us-ascii?Q?YoK2UdkrCxAhUmn32GBCpxuPUfXDGripyi6os4LM/SqByqb7nER/aZvo+7b7?=
 =?us-ascii?Q?Bjr6dN5Y6XZF2uerX1MNQKhPgfTsZJdNBBj2xOp2zIiU/SrINzWIzguY/7mA?=
 =?us-ascii?Q?xVmPMBVRnjGWfjObjWpovfCFxXC5ZbJQ4fIuVlZwkECP8S5fhiyToGmnxUA+?=
 =?us-ascii?Q?l3Ce24usiv5iaQOiB/PQY3IM/55aa3tr06185y5tcxNmF7LCwkWRaTQCIGk6?=
 =?us-ascii?Q?Px1En8+HZA/UUnDU7n4rLfdOFzXJfF8BjIuji8XMzYS2IPwqyAQKJPu+/fjY?=
 =?us-ascii?Q?MIWXjoAavvg7E3ZvbtJaoPUYXOoKUXkqOfIZbC6MLhOX9ofiyx//qXJ20kF8?=
 =?us-ascii?Q?9uBLC2TeDgGmQidNuv4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d065e32a-a95a-4808-0afe-08dac6732337
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 19:05:04.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7xr5vS2AkuYA/Uyl+tt962/vliCtVQ065mFR4/hI7pnpyqAmIzfMUiT6hnhal0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 08:25:35AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:49 AM
> > 
> > Callers must provide a callback that immediately unpins any IOVA being
> > used within a range. This happens if userspace unmaps the IOVA under the
> > pin.
> 
> with 'must' then let's add a check in iommufd_access_create() on the
> unmap callback.

What I did is put it on the iommufd_access_pin_pages() call, since it
is fine to use rw without providing an callback

> > +struct iommufd_access *
> > +iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
> > +		      const struct iommufd_access_ops *ops, void *data)
> > +{
> > +	struct iommufd_access *access;
> > +	struct iommufd_object *obj;
> > +	int rc;
> > +
> > +	/*
> > +	 * There is no uAPI for the access object, but to keep things
> > symmetric
> > +	 * use the object infrastructure anyhow.
> > +	 */
> > +	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
> > +	if (IS_ERR(access))
> > +		return access;
> > +
> > +	access->data = data;
> > +	access->ops = ops;
> > +	access->ictx = ictx;
> 
> I didn't see other places referencing access->ictx before this func
> succeeds. But just to be robust it's always cleaner to put this line
> together with iommufd_ctx_get().

OK

Thanks,
Jason
