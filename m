Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411E694897
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBMOtl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBMOtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 09:49:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB871422E;
        Mon, 13 Feb 2023 06:49:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fngvj002mKQhMS5ORgXLVTH5eG4KYx0jhrf1vSiul8GvQxO9jIDIFtrPQvzm68btoScZ7bnfg54LVMnnP0kQ4xJnrNg2vndn5kKe7uHVzCwnQDihq1FqUyGK+YYSRgRERS3CBMR+x1i+6rWT5N6teI9R1ngbsR31aFgnFTu2BR1eUtf4qVB2KMoFNO1//z5UgZz1V7jTmLYsWMrcVPerZ/IxtLQ0l7NuPhFkDXRZO63otgF+gn11DILFYhrz3Tfp+thluorcTwcVFVmHgCWIJtK5KgA4UrlIGM0hMfKOF8B5t9jDR0RvKlSzXDibC3Hm+et3xp6fqsO7SRvVqrHAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLovIQaAoMykAp9HxPgrrRJNU7jfQ+dVemp6iVGMPtQ=;
 b=WtqCfUbQNK543rdRIBqHFNrRCZ9peIuxISy6ZkymRI+I1/zIms9E6uA+u5GEIe1fbtkrgVns71Q2/299imeuhFsNoCHnqkpLUuvGllwh6mJrJAv13aslZU77JhEUq/zpgAI1r+KEfD6D68x+NgE1nPCnxL+2/ivKPaVDJX177iOUyH67P7nTyDdI24Dm/LIeyBfm6xpzr0PcKrmy7vHkV0Lm/KxvI0/tm8oTE0X3N64ZHm+oVEUg8f6exXwW+PMoJFRm6QMTpA+ddlAIpfljxXXjOjKveHHp2zSUyZweKcc2nQgf2RrXbW7XJEINf/GDiWmjqmsrMhGlqSGl93pQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLovIQaAoMykAp9HxPgrrRJNU7jfQ+dVemp6iVGMPtQ=;
 b=pOFovVbGUqC3B5n9raAItAzQye+eyAGcuS6XKGi8ZXVfLBu8M9Qoqiq2QpDrBLmWOAzHWBGCPjYxYkMsIU9U+u2Sf8vV7d3n6sqmzEt78yYw+KnFKVUNkh1VDkUJLUnQmQ+ZrlWKOckx/VRDibsMxOqNWr5RrrQL28znlDZyAUzpgn33SEQlUvGl1Al+KYin3HgOwwaSDibTAX4bBKcfwxl5C2kumKtxunS2uxcNwLtfTf2a2N3+rXOP0jr22vKA7z0HkPW7RfX4WtS4+dYSTGCSLZocY06tghiVVV2trN42R/J0X5Xw60D6S1jUs8hSLMlpdieYedyD0C2y8+0Iqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 13 Feb 2023 14:49:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:49:36 +0000
Date:   Mon, 13 Feb 2023 10:49:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+pN/vtO8I/oiMOJ@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a62ea8a-8882-4a4c-b536-08db0dd18694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bwpvf4Wo1Vfz2XmrLeqwHmqHgN2cjHFXmLlP0r8Y7HUfhUpcYrSj104m1xlAgS5kFUTuhoL2WUbUZq4yK1+bRMTj+4y7m/RGjJQyMTD5GJLYInwvGp2RCGtcKEExhPqDc/xgKhHA9x0rJWv0oaiJdhNhe2tkd2Zz12BkRZWaaL0YUkTjnlIx+7Tplm7idqmM1Qb5h1WyRdUzgkrpmfhNmeBRDryt6RfXqgsogoOJ0GxQM10kRMOIBgbr/9kkH0hfIBdJQMCKLpJwW6hW6hFVvhfzRzmc00lK6nwnJBKJcjyGw/zjNmEV/8OB7lcRwfCzcIDov+Z5jpjnfIxItux3XBj7FPduFUDzcqlhaGGW0iI0473IoTe9VBVyOzNgTe75lt8GXg+BEI6MwnkzBrZY98IDUn5kNvnrglBJpE10+jWZ1NLEWlSix2vCHv0VtlOjTQERFOlNJ5uLu8Aqv3seoCnbW/GFq+mpByzddf2tyKTj8ci7EsddB6R+xUwshUo6Z8mdsMl3vMJY61YUVHpaYbP1dzY2GZlZ+ejzr7i0MxNm5TcBxRcmnwK02RzOpiESo3vtBANp0zYwIdsGUhJD+M1iwCSCa+hY681ktJc7bwycirc9HvaHkzxDCyWyG7ZZOKUH1lEhsaVZPW67ZJXJTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199018)(6636002)(37006003)(54906003)(2906002)(316002)(36756003)(66556008)(8676002)(4326008)(66946007)(66476007)(38100700002)(41300700001)(6862004)(8936002)(4744005)(5660300002)(7416002)(6486002)(478600001)(86362001)(26005)(186003)(6512007)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZLF37sdwQhVvAqjPcqlfbRqqGglP0RBjOX9Zb2VqO5XqkdgESpidgCkWi93?=
 =?us-ascii?Q?xKe1TgSj8RMZv4XccvBOGbJOq+YhoLAHz3c/bxL2IeX0vOWd/a/8XY06hetD?=
 =?us-ascii?Q?JidSJJZphosmygemqAjtDXq+kL54/Q9U+MPNEcvlMpx4BBPdtQvF5B6nY/b4?=
 =?us-ascii?Q?VURFNsGkVnm/PtzSYurY+y64hLaD64RfYrXcmFknmbhKj79jYOsp6bFmhJQd?=
 =?us-ascii?Q?oo39JwHSZs3tMhbqPJ/rX4soGdbBjBqEAQWUfMlmxspD+9A4G+lfpAIVk0Ti?=
 =?us-ascii?Q?lSCeXTX+cAG3pLQjsN4jk1vglciSGk6jOi7q1k0aql+kwlBSYAe7Z9kje2cw?=
 =?us-ascii?Q?T9V55EYrgWVsiylUl4HxTLkDtpv3Qc/1PypozzqfoI7PSZZbyRIuy/jY0uek?=
 =?us-ascii?Q?QqXMrYF+S/xEC2sR1ivQzhCe/j70zelMiIdn01Dte9mQzE4CR04FxzXw+VB4?=
 =?us-ascii?Q?DAXWQq9PHtv55huwwdiOBgiifZ/OhjPwfA3RrduVet37d04BoWHZQhxCTuwJ?=
 =?us-ascii?Q?xRXBOUEGm8lPfYs6IpGdSXVEfE+fhkMcHmFLXeATaDQC+pIit1Ib5RyXAKyk?=
 =?us-ascii?Q?ydbCHwClr08lNN0all+o+p+NLAH37x9ePwRDTu2ouAdgpsYXXLFTmosa1YWo?=
 =?us-ascii?Q?04J6gWXj1TfoeMewnAFVBeVHRBkx62rJzIadvDS/B7kC8Z6x/KAi3L5AW7Y+?=
 =?us-ascii?Q?3CezGSBLS8KzEhjmjUiNMaMZzlYWFupdPrqf6jfdpP4u0Z3ntK+7T2Xb9iDh?=
 =?us-ascii?Q?UD84GqK2EHkDrY+tNtUDtVWAZw71DPvMN7QCJk3SIsRwwTri4PXe2DYeMMTi?=
 =?us-ascii?Q?FBnQOs+O5ewZ+KQxDLIT1RQWAxGq3XEhVsg6VSai16XFFWseFs44cBFf81//?=
 =?us-ascii?Q?IErO96kJaxJ2Bj2DNyU45dpDwHkDjLI2PYQ9LaOyCyxv86EOglcm6QEU7KPF?=
 =?us-ascii?Q?98sndLUCetitqfMFHecsxVDURpYepRRGQPfQkmRIZjwukrQ8c5FXXbX9MXcj?=
 =?us-ascii?Q?10hJHpufpgENb1mQudKnwjQKS4WpKuPhZ04M+btMnLo/jSZIO1jbvP79soxK?=
 =?us-ascii?Q?nbwmCr36MZEOY2vzzR67yAWReZjEDVRR9HWwCACnx5eN23MbMsgothMgwTF2?=
 =?us-ascii?Q?OskHUa8E56DUKRqnG+5GFye7rcGCafD0x3KmHsyszxL9qjI5TTGjn0lDSpxc?=
 =?us-ascii?Q?Q5EEuaq80eN0FzKy8Pc2/e6m0qZpdZWfmskuTLLCRQ9hcLJ4Qm0MkP+b7SzL?=
 =?us-ascii?Q?BBoR9OS+1K5dD0voIxcMr7llmkk1E7VtF+UI++P5/FbuJbKzWevDBMXI1CuT?=
 =?us-ascii?Q?p8XU1mQ3LcA2JXLNVOpRy/+Obxq3rITYsd9jIu50MnOWVyt91e8TlktF1QcV?=
 =?us-ascii?Q?Da6HJyYj7aIYq0+Gl/4P7QLO+LpJ66reM/wZcfrvhHDM4OQ/vOfQi1OFRAJX?=
 =?us-ascii?Q?0+wsEvMrIBBtREEbW4WyXjmkdPW5bCFMQ1Z6XPRY5f2puk9ZKtNaZW3NSrO3?=
 =?us-ascii?Q?h4R8xHk3NLZe3ymSfJ95HQRK+No4s09mhZpX59aJYo2ASWHP8nuDhwpK1B9x?=
 =?us-ascii?Q?X5kkmlByPwjpuczwKuQp/xpflSiqELOs+suSSpTX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a62ea8a-8882-4a4c-b536-08db0dd18694
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:49:36.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JFxGkLetWD/Q0dMHnB5zje1i2WOx7RGts3OWVp1X+kjLAi7MQmt6HZgcMI4mBUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 12, 2023 at 11:48:30PM -0800, Nicolin Chen wrote:

> What about point 1? If dev2 and dev3 are already replaced when
> doing iommu_group_replace_domain() on dev1, their idev objects
> still have the old hwpt/iopt until user space does another two
> IOCTLs on them, right?

We have a complicated model for multi-device groups...

The first device in the group to change domains must move all the
devices in the group

But userspace is still expected to run through and change all the
other devices

So replace should be a NOP if the group is already linked to the right
domain.

This patch needs to make sure that incosistency in the view betwen the
iommu_group and the iommufd model doesn't cause a functional
problem.

Jason
