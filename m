Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7A6A82D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 13:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCBMzM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 07:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCBMzL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 07:55:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8F57685;
        Thu,  2 Mar 2023 04:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYEd7d4gI0IDHHk4vv+r460QeiID4u6bsFn2gAQz3nnJGRJxNjyNFgk8xSCKdGkhuZWu1mEj2xtVjbYNQhY9iN8kLFOOn+orp62U99s/WdUA8dxSTRb7PMihgaWKt8WCCHi3dqCjd/EhKf1AwBv5g9rXEOw4rlCuOjPyeAMQlRsye7ZizxB08mOCS1Bv3NVi2HrDMaDnsosBKG0cTIxs+eCIDUWNrSpRCN8ukHnTi0tw9XguKHgZjcHL0u6v66jKe7Vlz4j71XHNTWZ673Pfj7uWNEBEVQ2XZdhAgZMI77iSqowNzWlYUb/yOd1yazYLoNAC66fONrelNgfwjw9d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nrRYRRM2pE9HJVVlarFIuIs3r0Q8FP10GAw4r9TIwk=;
 b=cjicHQw37K0AnF44q6rn47MjA0yn8JW1BZo1utMo4qq7s0jTgeEoZpKChmzbQMLDFQZwz6Egbeuws9L1vIyXMWDdHxHZGTvL9XyM5YsrnwQVS3VzNH0W9zFF4hVgLegIprwAUa7JsKh3vEqkg0cPOURZl+bvLqRztMC4FGe0uV313BrR3QgarkW41WuJ1PzElzQUBJ6m4dpctRtgvZAnFmqR+efbYfGTHLFV/LLala1lyCuuhzQpiZFYAbLg3+CVzX2gqX5NxoysmBqBtr0fYmhND3pMr1TDudYj51KjWotv3vEvnKgnGMZ81DaBocEhyCqhjRtOKaDfrTm+JAU9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nrRYRRM2pE9HJVVlarFIuIs3r0Q8FP10GAw4r9TIwk=;
 b=Xd/JeVgoZUswKZzjYA2vwM1hSjR1s6oGLQ7p7XoNKGuyIuQB20uLbwnk21QJ76mr5tj5nSyfZnQNqIVAzHchRAR6uPRVabCkgOIMT2PTCPFwtebFZ+uCQ5OMDtq1whukEjjwIu/XENNul37qMrH49mVucg1XATYQvQjCsdRxC6sbHXSPSk+ol62Elza+S5ofrQitYxrS/5hVqirWqwRWs/phPBPPTP5fe4bxty6TpjrxXLtqAMPIENtqUdo0ELDWDEr2TK/SsyBX0pmFBPZzAPAuyFn+beqwD4antlLj4u0MeOTg+y9JJ+LfIo94pEQ3W2Tt4FsHHOleZg6nqbzSAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 12:55:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 12:55:07 +0000
Date:   Thu, 2 Mar 2023 08:55:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 04/14] iommufd: Use the iommufd_group to avoid duplicate
 reserved groups and msi setup
Message-ID: <ZACcqDj9lgbOayDP@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <4-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276499B820C0250B4364AC98CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276499B820C0250B4364AC98CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f1709a-fb69-411d-bd14-08db1b1d5996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go08fZCPZs4m2jGTWwyjWG/vjdYqDJozj8HeMSwCOSRwnCPVTm7+b11V0i52xl7GBCVVHE0Xf9IQUNsRMkbnPRU9G34Wv8ru3V/bvImvykSHact0zVt/3/6UXRmaiDLyS/fczAfiHmmy3YUNIkRh+ev1EMmwgiKwig7HngXu1uEiplUMiZMcHVGGwbjf2KeLVYhaWYDrH4u9M6OyEGzdJvubtt9fWp6eMH8jSorFYY3d2NpJqI6umMp6PN2DLB5XAIKETkeko8ILuB0vQjovNSJhMIKnV5bmDoLoa3fLCqPUFOlOq0UM/pkxtdwGwo3SVcpKEq3JXm7+9XSlxWWS0Eht7JJYrhKbn4g54KPzmHKVrG7skEBSuwMIVLpzJ+7j/UOXiEZ2NsbtZn/ACpbPjXrkRsJUAi8i080F2FC2Zgg+tNZ0KADxIP/64zKPhnyTLyFkHAaZyMa8ZMlpUbMohpGhJld0DCwP8oi+HhLNi2HDvKfxYLAnpzA2RG6cUlHovkKgfWf0YeqMtjxZAU0Lh3DmcuSDNxv3Gdo9O+fOvhaU5KjcUVvwDjoJSFaUWfkqBrjtns4R/cnaz2OqHUeSJvB9qyKs5njAuhaIV4N2KKG2o4wy86l7qg/X4vUNM37BCTXbwYQqRR6mHhMjKRMhSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199018)(36756003)(6506007)(6512007)(6666004)(66946007)(66556008)(8676002)(66476007)(4326008)(316002)(38100700002)(6916009)(26005)(478600001)(54906003)(86362001)(5660300002)(2906002)(4744005)(186003)(2616005)(8936002)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxRBS2+G4tsIocPRP4yOQkVjEJmE1ilcMCn25eZi4ivu75XJYD3nr9pQAAHs?=
 =?us-ascii?Q?3jVZztrFzSqV9CFZrpCq2NVzQkF0MGRIJFMa3yMJulOmte8wTaXZwLzsaY02?=
 =?us-ascii?Q?VVWSDeFWA7CudfSHyr3R4/MZMOjM16yXf1M14prVEZG+mcOduO/tD9G1eIts?=
 =?us-ascii?Q?mf1qa6BoB3m26KzScDitpLMNvcw6ysYyiQrZV4Caeu0gWElRnWqDDuKym17C?=
 =?us-ascii?Q?5W7JpmsBdAuELd4N7acJCB+ioZtWWxyUEOxOPJvU5LyTnnyvLftLyZm5jVDQ?=
 =?us-ascii?Q?maSVFDt5/EmyR3TV1CkFykuvUiH3n79uSIxCU9bnXk2YNLeiJyWPkQ2gRrXd?=
 =?us-ascii?Q?x1KzQ6WYDZ5um1cs0IO7V5Sdc6JdG7OKxsP6dPL7QdTc9sc/nSNtLhQ9IXtN?=
 =?us-ascii?Q?nZXUPYbpmN4L0g1+zEPg1g4wcqlFa32zYq8SprIYNtfgWu/nle0mGoZ0Enpx?=
 =?us-ascii?Q?Tf+Tt72ynQn9TLnRD27k8uMrUp80abdjIz6egI1okkdWA5eS0xUqtu4Iv24N?=
 =?us-ascii?Q?vvemGAzTK14buDzQEfTOKDX1fbeDFbg7erCTGLa9yc9LJkv65Mt2TOz8uUQN?=
 =?us-ascii?Q?0dNgDYTADZvuI3iI4z9rHt7PofYxfaUmV4XEo9G4PJy2jCVzVHUq10v+Dj4Z?=
 =?us-ascii?Q?+RnFDrFUwGfc29aZPiN3KBEcsnkme04H8E/ar/wkpu41pqGtxwWjvJGMPE+v?=
 =?us-ascii?Q?MRxget7yg7k+pJ9lduonLIOaGmhAoAkGu9NZgPwNj6greXoH1L69HXr8A9z0?=
 =?us-ascii?Q?M2FXmhKOj1mNlnToZaSsNavLVHEgn3HkJ+QvGAxMhLvabCyh/wfBlnGLfy7N?=
 =?us-ascii?Q?KXDeucORiEU0a3Km0Ro8FFUQqojGFrn1sst/dQZ2O2VsfCDrs/vTnpWIUkFW?=
 =?us-ascii?Q?/X15JGaz7WzuWc/rkWOfWOdPr3yBWYAVg1QbNroEHGzDJFvp8HE/Rmt8V0Gy?=
 =?us-ascii?Q?uu+6UL05w5e0QPFKDDDz547+Dlujll0HGkhm8SS+MUPa6KBmP0jwCpo7iIyd?=
 =?us-ascii?Q?WPBDxFIQ/M2MxAejWIywl8A9Zw+v8HgbT5BAI1M7EuOZ1DIjlpLftOwpS8vy?=
 =?us-ascii?Q?cz0D9/RId2tJzqz1Ir8XwFjhV5BqFs4LA4nUmU+UG0jg51K1STlONLShMMRj?=
 =?us-ascii?Q?AOe4b90eYLnzFRF4XxXcRifrtB7lyauyz+4ZaAG6t/S/uEg6uzfQ0+YixPDg?=
 =?us-ascii?Q?WvnRxkxBoiBSVwdbw0zAby1vxIwPd+P20sgMNEKDfoVqS0UP+uTMb8IF5ggR?=
 =?us-ascii?Q?dYmufY3hL5xuR25kcN69Uk/L4faY2S89pFf6wlk0L94r6Lj970GYFnQjptBf?=
 =?us-ascii?Q?BHQzD8sFAzCr2Ty6OvYQ5X2u2A1lkos7zN90Z302YKcyyfZE4DSM/XDeSEoc?=
 =?us-ascii?Q?4YkSA+E0ydY5QyTwdGFtXt27ObQNhSCPy317ITOzlVL82ix3PXKLsZRYxQwo?=
 =?us-ascii?Q?Cj/vs17LgiYbVontuEYEgXUZ08AdKHBfTlA2oJLw8H+TzYgNmCjCWpcmA+8h?=
 =?us-ascii?Q?G8ArF8R7SnQi+Y9BI+1NhFlWX8qlrLrdFWKuxsUT3kNuGUxhQSJYcNZXLI4A?=
 =?us-ascii?Q?bg+m4wBrkDuRZYV3+Xjj/nLQ0dbN833yNhiNCF6v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f1709a-fb69-411d-bd14-08db1b1d5996
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 12:55:07.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vuzg823d7RvljCrQ/x94pt0ZcvAME/mU5bpyzxTRwj5yTH5UO0VsNhZJmthFJ2nF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 08:06:27AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> > 
> > These items only needs to be done once per group, not once per device. The
> > once per device was a way to make the device list work. Since we are
> > abandoning this we can optimize things a bit.
> > 
> 
> Are we sure that a device hot-plugged into the group won't increase the
> list of reserved IOVA ranges?
> 
> Currently iommu_get_group_resv_regions() queries reserved regions per
> device and then merge them into the specified list.

So, maybe we should export the device API from the core code and use
it here instead of this group stuff. We don't need the core code to
merge each device together for us anyhow.

Jason
