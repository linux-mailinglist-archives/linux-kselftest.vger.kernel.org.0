Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2362865C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiKNQ7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 11:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiKNQ7F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 11:59:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669402FC26;
        Mon, 14 Nov 2022 08:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1vSSvPmTykC/W3BMOxZHdSbYtsR3FuR7uP1fIq9A4sHBoh8wKrE9u5yhHa4ddDy8Tnz/5+noIgCr/OtPq2aOSxQnsOmHDKOcbaMrK4zvqD6fZx515PqabICJDAxLMXURqvlgwhZ4wJnvO488cRVKbb9EhWJEcfEKDCY8odBbZFBZJEq+YBDSlv9yHqxHPmG06EZBhIr6PpJi9Rm5cO3Q/jvMlJvsd9qZ6KtyRUO9oMsROEXQfdoN8e6axEZLssPMJp9qNuIGCwca+Cr5jpetJxvzwxsToXzTw2uyx7xyWoT4ZqKCbChlhp4c+YEj/j2IZV1KnRSQXXdznnip5zQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FCnV8AOIg3Eor0RIpyCg0CPcN8MMlsrqZc4PVD/HQs=;
 b=LuYQ6hNx06z3fcUcpRvJO1TQa7sOm0OtOcLnlDgkVy3C+DN+GoClH+Nqs8dbXrwmNoJpPlxtnlMQV+CT0aEIJ0RRZRs69zIrynQgTBaF+Do3Ht9KZwAPU22/wY2vt1aYmCgieSQGwYFTYVPhinTGoyd+NgUTsyUfBeU0UUu48LVZ/eHafqvzqR4twjPRodwzfwWEdxMQxA5TNWhZhEr6Or32ye910JDvZpCor+4+AKAZaWJQRS1WfirfrPI32iMvh2fh4JyU8zMVIRyV4h5FBakU3Svj6S7o5EIKssR44mKDhhj/NX6zL2fqGfUolU+H7E5R0t+tRazMJh0mbJBO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FCnV8AOIg3Eor0RIpyCg0CPcN8MMlsrqZc4PVD/HQs=;
 b=dN7Sj+DMnGE39sjMAANXZg8Ybq/LHKQ4lmoH2d6skn1v3pGfc+mIcwY6T4LJ/mCwuYzE9cjv1YTV+3OFeOfUrDFjyv1jhddimw8QXHQEKHn1IPgk78G9dvv2Oc57HxqCuu4NXol133U6jzRbuG6hF8g1D5UgQIAAP3XcxFGFjMQ9R1yU/ckCyS5lfhfVLQOvwJ4fGqz8ATEVV+slJzZ4qi7l9P7pBTM6yg76V7S3nuphf5LTsMrk/QcEKukW0msff3dh/DaH8qG19ocecSya5KC48mUgZ6FsVxYENe03k5WF3vBRYentBWx3akEUR2ne/V0mtxPlss4amvcB9qSUtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 16:58:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 16:58:20 +0000
Date:   Mon, 14 Nov 2022 12:58:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
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
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 02/17] iommu: Add device-centric DMA ownership
 interfaces
Message-ID: <Y3Jzqv/8WtT0LtHx@nvidia.com>
References: <2-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <e1f7fe9c-5201-3fea-a354-bb79c06ddb4c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f7fe9c-5201-3fea-a354-bb79c06ddb4c@redhat.com>
X-ClientProxiedBy: MN2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:208:234::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e58839-0b4e-4ab2-09e9-08dac6616ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxe3mJHW1eBRYbaZd/Hd0K4MEoOkSTKPcNO9nkhednsE4I/OyaTnWz+TLXsVk3nl4AuLqX6VkHGLDGKeKc8lE8c3XU50vkVV9wn+GqVCaFhU5F/NbSIOvhTLRrNq/K13k8pBeO033oBxrsBG8VNoliPziIcLsSK0960n1vOntBoQ5hES03TyKnQBsxYXtlLhG0FLz5HMSsjVOXXp1Uix6dVBONAVVRCwcw8jyXSx46QTYD3DAhB7/W4nMs2iDFR+xzOeYL6KZqMvdw3CFKqFsCP/uZyKi4tJG4FVWMm1G49C9gynrHx4Rc2VhGhiU7YzKvHb085yOUxdIf6SJNekTNndLZ30U8r11ayoEfP6/SOK4QdVOy+iLzHfnVXKVdSwKo6yNZkNhTaX2vGrwk7HZYBJ1H+crUIr0Nm65SSYa1uS4nLQBgBQjtNqrPhi7lJp1056uso6HIkMOL+aKCPm5sbBGrQMc0nznKkbXglLFfCvQhYbcHwQX/+fIGiuyyekgzxesRz66Fxm/JRPsK5jILlDiYJt90GCF7gM7nJM8BJPlhucwuf6joycsLAVHTnt8OEcS2PEImaAEzkaafTHmIGPWXZP/7BdK6mYv9cDon8QbogEwK+JMcxMty7JpJJhfZLA9cHVmOvaKKhQDk+kq4EScNb7SXJMKohLtPRp4+XR8uUgNhSL+A7CHbUzveEE/lkpcW8dMB2Vt/VMQhj7pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(186003)(6512007)(83380400001)(26005)(2616005)(6506007)(38100700002)(4744005)(5660300002)(2906002)(7416002)(7406005)(6486002)(478600001)(8676002)(66946007)(8936002)(66556008)(66476007)(4326008)(41300700001)(316002)(6916009)(54906003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awGhBOZ+XkiVTDp/jwgUPeomShnhJXE3tmE6MUHyjJn8aJAdrqngGoMj/7LE?=
 =?us-ascii?Q?gyofGSLWiDGCu3dhSibBenovG980HSUAajbcIOqsIhzR3T71BkHKIaP55SnB?=
 =?us-ascii?Q?ugrCi7wyhwWacdcsz8rpfqiz1vVndWHOMpzLopvl9n1nuGAxOdymgK2eYRql?=
 =?us-ascii?Q?BWC8G/xF6elDf5CIX3FuJd3e9mTWDO3nZW6xW72ZvfCUuvND9zWOmsbGfsck?=
 =?us-ascii?Q?TkKveJwPEFStJmSO9NqNdhAZW5kWteQhbNDWVew5esT0Is0x3Z1IWEBvW8eY?=
 =?us-ascii?Q?JTlZZxZXe+70Uzg97RjwImew6hpTsNLTTsN3SkMlzVpc0ovj7M1Uj+WLByCk?=
 =?us-ascii?Q?m2aHAE6jIrl2c4y5Y/FVqJ1DYKB964Z8pF5/9GDPrmqdLwruLofWcujsWH2m?=
 =?us-ascii?Q?MnURdq+LPBoKLziJa1irQYEf4UbJE1mAXbIV9qQ/i2A7+CYvAuR3wCSUfUCz?=
 =?us-ascii?Q?Q1g9pUUaOIfw68cKJNitkRAEN9NU1jvqoz41Jd9eznB8NFGdomBD27sYoUII?=
 =?us-ascii?Q?CoadnN0brXFN0MVG0Xqo3ZvRTAcP3KsCN5ctUKcLKeGke+1DeKUS+/obXlAQ?=
 =?us-ascii?Q?F+/ms5MHH6ny+IbKS3cMNy++HWN+DGM/yw3AjSS+eaStaztdr/1GF0KJxYPJ?=
 =?us-ascii?Q?ILwaBVZZtHZB45n5rchhbxIuy7i7bVY9zAggJUN5bPOde834iHD5l8LUdIcs?=
 =?us-ascii?Q?9p6aGxe6NE665AIZILW1C89NFnqVY5eI9sLR0uBDCFLrIR1PXaDYCliYZAE3?=
 =?us-ascii?Q?n5LmlwXiS14wew7g+G+DfybsmQBlPBmAdpug8r6wdHf6TmCVVqMDfuGSl87n?=
 =?us-ascii?Q?s9+dLUUHsiB6EOTiUCKZnx3ZvGWypiQmUXBa0Pd1OsSglAGPbDcpS4UkA3rg?=
 =?us-ascii?Q?bND3+xOllmAZpSLfl3R6k6qQ/Mp9K9ZYl6YCVa4CMtFR9eiVjqhTUi96iOMe?=
 =?us-ascii?Q?d+Mf+nNM8Bas+EZnj1ptTEdc8oHo/uq9ErRjVKgMQdRtJwxmYR+mLu4d6BGN?=
 =?us-ascii?Q?6jK85BvqV2PXuvKydV0TcVNT6N9dXwN7SNTQTU2glr7+qVjeik0rGqa2iWnn?=
 =?us-ascii?Q?Wt7C3ZKDaCalyTsXOyfnSI0L+HCR5wvAnsKTBdmFwbrfAkCI5BgMBpyKrDA9?=
 =?us-ascii?Q?wsiHxOMm8+aBgVnM8pOO0H/RslFzNk9/pF4Bov298G7Ta3xqtBlbvQ2dpCCx?=
 =?us-ascii?Q?r0DdbpJxZhplxJ0LHq1GU+9wdNTharYlxFcVYGPnqJ6rsZ15hmgo0iM+9EWk?=
 =?us-ascii?Q?T6hCrZHLv6/RgLOOLfkj7i1iRV2U+PizlfSWjZT51bbFYeIIIJ6NdOCq8yKm?=
 =?us-ascii?Q?3BDMiJQNANYmtoNuAN8Rze7KwYAhxtlMF6C/Ky0s9iErXvhNwcs7UwzTIqhq?=
 =?us-ascii?Q?LfYJfpVVjV3FU31M0zVnavGr3NpUW/B8hpChD568eYrxeWJTvMcm2ChC8aYd?=
 =?us-ascii?Q?QeO2IadSPwlVj20PnmmTo97hulJRDTK3h39OwFg/JrzSoU+MAbqAHsiBw/QK?=
 =?us-ascii?Q?lwE9MNPyjbJlNwX7X3INp5kxNPkMyUr/lCx/tq7YteJvMleTBy19GR7ydHyI?=
 =?us-ascii?Q?qU5nYeVxbX6DMkF3VvQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e58839-0b4e-4ab2-09e9-08dac6616ebf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:58:20.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0zl+YsVYJbDAq+thGHQ74iRdmoJ6srMgX5wcyED7y+CLen2d3gtsc9em6P7MbGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 02:33:41PM +0100, Eric Auger wrote:
> > +/**
> > + * iommu_device_release_dma_owner() - Release DMA ownership of a device
> > + * @group: The device.
> @dev: the device
> > + *
> > + * Release the DMA ownership claimed by iommu_device_claim_dma_owner().
> > + */
> > +void iommu_device_release_dma_owner(struct device *dev)
> > +{
> > +	struct iommu_group *group = iommu_group_get(dev);
> > +
> > +	mutex_lock(&group->mutex);
> > +	if (group->owner_cnt > 1) {
> > +		group->owner_cnt--;
> > +		goto unlock_out;
> > +	}
> > +	__iommu_release_dma_ownership(group);
> > +unlock_out:
> > +	mutex_unlock(&group->mutex);
> 
> if (group->owner_cnt > 1)
> 
> 	group->owner_cnt--;
> else
> 	__iommu_release_dma_ownership(group);
> 
> mutex_unlock(&group->mutex);
> 
> iommu_group_put(group);

Sure, thanks

Jason
