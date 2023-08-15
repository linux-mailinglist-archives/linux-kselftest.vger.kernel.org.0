Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5277C7B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjHOGWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjHOGVT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:21:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B13A9E;
        Mon, 14 Aug 2023 23:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq6D+PEyk2wOlCrDqd7t0kivyCfMFdFIF19QfLHQEP757QkMU9g6DR+p3e/ZYYNVyAYb9pfvoWqEKBIQ+qJiGWCDRuJhE2E9Sz5ihuq821j9cVUlR2oRIVqreZ3fAcd+uOY6yiaiSMMJEIikHRNTmDRNvZ89TvLcFdBN0HwMzbUGBq5pF8TSZtG0i2Sjz/BNOaWZ0rKjgHOxLf6ZCcnujgztZIKNLE+47NQWcVefXk67fGYAjkyTd1oQqyb9zbq/kvx3bDPQ6xrca0jRiz8goSOjMtvGQzlUvBwMYihpR/bgsiJyvXJFxYkQrWgyeS5G6TwUie/3ZGI8J5prGO+JUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZwS7FskMnaQKUKk2d98edQHxbswOuQza+DxRrTTVuI=;
 b=mSO3TiDOBeJNFqjgDqzMqS2EgG+r7Wwk8F0Hm0kAeoj0LcFm2a+0bPJ9NoZZibCGa77tgqgLY04gzJLxEM/07znYePTMLlQ2m28ZtTw9ZenJzouaJqu2sq2jnuh+Xcs6eLDEvVhkcEv4+Ce8XNrJjTKlJE9jl7XiuKoFdTRCEQe0ZmSmqEsAUt10THxq4CvRV4RnTGWQTHCCUO90lMdzMLt0DuxLBG/Fp7AeHLJsVwT8ftCw5Jmu1sS1yciIi+i0isJmdnFapRE4WwNjGZmlblpGSe9SxPOss0rrK+4GIeSyQ6Xmnp6rbssMybIUEUtEZ0URxlwbH5TTQv/a7OLKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZwS7FskMnaQKUKk2d98edQHxbswOuQza+DxRrTTVuI=;
 b=HEzZ/LmeqjskRlsYkgBPI41tkSvhuPfcyXglhiFtXz/Qe4U3cZpHGXQBcDgeSajAfksuXtvE2FTubnlye3UWhIgdwDTaOdN7tyZTSpJ3boHGcVrO4XOArQfiNkSZv0+BNNZuejmz3o2O41r5UJvU6OUM4/CdqfmX76fg0TorTHlDwQRllKAWhsImeQxlyhzu4WJ3ezbL1kJLvg8KpKzqqrEKnUtduQeCx4oA2L3blXVUNGmhlJAdKYKy1cnTTIVNaEzSqqWjC4bSdzyRmMqbVygFgTlZrD7lp2U+dWzeYOAv0asoa6gMvH3lN2cw7WIfjSXiRpmYH9Dwcgs+Wml4NQ==
Received: from PH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:5::31)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 06:19:08 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::47) by PH0PR07CA0026.outlook.office365.com
 (2603:10b6:510:5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 06:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 06:19:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 23:18:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 23:18:49 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 23:18:48 -0700
Date:   Mon, 14 Aug 2023 23:18:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
References: <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
 <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8caa0d-6d5e-445a-b423-08db9d578853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5MVQmuOE0kTj5pHekgSZIfklaNoptJJ3XnXoPpkm1z+pDzL5E7g3vGpMZIBqZ+zfkX3KchsJllHHV1+exHMWkD6L0Yst1BRoVzPilnnaJgADysrZ3+6sXbWbZCBhTELq6046pSLNPIS1uK1NoyafOQRw4/ZqmxNw63edZEyR2yeTzqa/s33bH4fxo1ftzVXX8Ok3aRgH/VacRxm5B4uYhXb2ur+kH5xicxugPLdAlrAEyELRaxNmHAsB7I0ON8OQO3/wY00xwUG7uUfGgKeAxn51iFOWfTckLf0d8rdYA0G0je0q2Scv0hEIOF+d72HzFKDv1+h51/XR5ATC16DxkimRpGeq0zTwzDqZbmKbkfZXyKml5Q+z9FY9pE3DuPracmBqKp9TZ4w3hGnKh0AFX6vLxo+0tQ262cje6dg4J+TcGZrG3SjdqNyW2WQUd75Fm/gm8YYcjVMbpWOjM1bZWw9HqUEz/v8FsZXEuQM6WpYKYjyJhLDJyxELiBC+f3/JrFJ28XMX7NcgonSDk0hq82so9aAHJl2hiTbp1Z2Ds/FWDsIbySyWByyQQBO8N3JYEmWB2sGx5b04n/Tf3TeKZ1NcYemZisI0oSnrzUzEKO9IZHfDPE0yOLIvgSJr14MdHprFDFsXWyXufznWb3wxnxezaVAjl+OPXE6fWN/ggWcaBA3pR6/MT4S7j/gLUPVM54CzhB4AbX/y41lkYYmJ3H2i0G5yw8hghboEXU+sw/Pbh0j1e1NrZLy37K9KkMB
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(186006)(1800799006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(83380400001)(426003)(33716001)(336012)(47076005)(36860700001)(86362001)(40480700001)(55016003)(41300700001)(478600001)(356005)(7636003)(54906003)(70586007)(70206006)(9686003)(316002)(8676002)(110136005)(5660300002)(4326008)(82740400003)(8936002)(40460700003)(26005)(2906002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:19:07.6553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8caa0d-6d5e-445a-b423-08db9d578853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 09:45:21AM -0700, Nicolin Chen wrote:

> > But if stepping back a bit supporting an array-based non-native format
> > could simplify the uAPI design and allows code sharing for array among
> > vendor drivers. You can still keep the entry as native format then the
> > only difference with future in-kernel fast path is just on walking an array
> > vs. walking a ring. And VMM doesn't need to expose non-invalidate
> > cmds to the kernel and then be skipped.
> 
> Ah, so we might still design the uAPI to be ring based at this
> moment, yet don't support a case CONS > 0 to leave that to an
> upgrade in the future.
> 
> I will try estimating a bit how complicated to implement the
> ring, to see if we could just start with that. Otherwise, will
> just start with an array.

I drafted a uAPI structure for a ring-based SW queue. While I am
trying an implementation, I'd like to collect some comments at the
structure, to see if it overall makes sense.

One thing that I couldn't add to this common structure for SMMU
is the hardware error code, which should be encoded in the higher
bits of the consumer index register, following the SMMU spec:
    ERR, bits [30:24] Error reason code.
    - When a command execution error is detected, ERR is set to a
      reason code and then the SMMU_GERROR.CMDQ_ERR global error
      becomes active.
    - The value in this field is UNKNOWN when the CMDQ_ERR global
      error is not active. This field resets to an UNKNOWN value.

But, I feel it odd to do the same to the generic structure. So,
perhaps an optional @out_error can be added to this structure. Or
some other idea?

Thanks
Nic

/**
 * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
 * @size: sizeof(struct iommu_hwpt_invalidate)
 * @hwpt_id: HWPT ID of target hardware page table for the invalidation
 * @q_uptr: User pointer to an invalidation queue, which can be used as a flat
 *          array or a circular ring queue. The entiry(s) in the queue must be
 *          at a fixed width @q_entry_len, containing a user data structure for
 *          an invalidation request, specific to the given hardware pagetable.
 * @q_cons_uptr: User pointer to the consumer index (with its wrap flag) of an
 *               invalidation queue. This pointer must point to a __u32 type of
 *               memory location. The consumer index tells kernel to read from
 *               the entry pointed by it (and then its next entry) until kernel
 *               reaches the entry pointed by the producer index @q_prod, and
 *               allows kernel to update the consumer index to where it stops:
 *               on success, it should be updated to @q_prod; otherwise, to the
 *               index pointing to the failed entry.
 * @q_prod: Producer index (with its wrap flag) of an invalidation queue. This
 *          index points to the entry next to the last requested entry in the
 *          invalidation queue. In case of using the queue as a flat array, it
 *          equals to the number of entries @q_entry_num.
 * @q_index_bits: Effective bits of both indexes. Defines the maximum value an
 *                index can be. Must not be greater than 31 bits. A wrap flag
 *                is defined at the next higher bit adjacent to the index bits:
 *                e.g. if @q_index_bits is 20, @q_prod[19:0] are the index bits
 *                and @q_prod[20] is the wrap flag. The wrap flag, acting like
 *                a sign flag, must be toggled each time an index overflow and
 *                wraps to the lower end of the circular queue.
 * @q_entry_num: Totaly number of the entries in an invalidation queue
 * @q_entry_len: Length (in bytes) of an entry of an invalidation queue
 *
 * Invalidate the iommu cache for user-managed page table. Modifications on a
 * user-managed page table should be followed by this operation to sync cache.
 *
 * One request supports multiple invalidations via a multi-entry queue:
 *   |<----------- Length of Queue = @q_entry_num * @q_entry_len ------------>|
 *   --------------------------------------------------------------------------
 *   | 0 | 1 | 2 | 3 | ... | @q_entry_num-3 | @q_entry_num-2 | @q_entry_num-1 |
 *   --------------------------------------------------------------------------
 *   ^           ^                          ^                |<-@q_entry_len->|
 *   |           |                          |
 * @q_uptr  @q_cons_uptr                 @q_prod
 *
 * A queue index can wrap its index bits off the high end of the queue and back
 * onto the low end by toggling its wrap flag: e.g. when @q_entry_num=0x10 and
 * @q_index_bits=4, *@q_cons_uptr=0xf and @q_prod=0x11 inputs mean the producer
 * index is wrapped to 0x1 with its wrap flag set, so kernel reads/handles the
 * entry starting from by the consumer index (0xf) and wraps it back to 0x0 and
 * 0x1 by toggling the wrap flag, i.e. *@q_cons_uptr has a final value of 0x11.
 */
struct iommu_hwpt_invalidate {
	__u32 size;
	__u32 hwpt_id;
	__aligned_u64 q_uptr;
	__aligned_u64 q_cons_uptr;
	__u32 q_prod;
	__u32 q_index_bits;
	__u32 q_entry_num;
	__u32 q_entry_len;
};
#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
