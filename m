Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B469486A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 15:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBMOpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 09:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMOpn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 09:45:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF431ABF8;
        Mon, 13 Feb 2023 06:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acr5WRCvuaiStRHon+0tZI5Nl0IDFCusXJlw4v5R0p3YXrq3FqNLQF3JmwLWQxL3ISIMSHFg8zXBmXBoUbjmqcDEgivG6JV1StIWw7ou22vM8rwRCXiPj7fNKwiLZJmGIcHY1e5Z2X4Dasn5E7colf70vOwy+auBSUMfo7JiJ8KpSnr2/7qMSedhwMITSjIWQe8WZ5b3lh43d3xZ9IWmEGAkaGGNlUEyjRzT3HYeam8B+o3UamThpMn1NLGH0PktTMJpUwkOARbaQ9/e91L0odr2gNZ30XkvrzaX3jBHMaNDoxtOthpf0OFfA7vvFUG+zwFHDBqNNoQ4DJQ+1YDS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UMR6M35eolN3G4Ept00gmsSD2SPIiOlMArfKWc2f6c=;
 b=aopDicTuGojlmr1RIaoAPpcl9McpqIcTA5r96tLlIR6WdvrtFCQ2vcogG035owElojmAvyMtAF7y/cXx1TRS7Vck47/vsnMpNAyOH3MuA5nRQPHTBUNhmy6dIuxLE00ASFdDor36s5EE0vPGfGu3nQqgWS/vTHvQuz3NPT6ePWRQL5qm/7dcMyFNnbG5ZhKjXyeSPkseNEsrRZIePwE0okJPXI5EC2EjoNrKknTW5GeS5PXIjWAtfDxAS2PYXh/RnSxp4U6nJfHmebGRyU2bUFbuUMIUj08ydMJWF0pW8jubyJ5uuD4JG+BAgt8VXjr5cJo+3nphfziRQoMudMTlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UMR6M35eolN3G4Ept00gmsSD2SPIiOlMArfKWc2f6c=;
 b=NgfBXiSHjxSapm7m4SPzgStO1xs9lOqG4iqIaF6BwPmiq8rjMMNmxyQdxb8fOCq6klyaJLvMZh558RVDnEV2Kne6YuWtLjv4FUODkV4DoOVzVVE+o0IvTtT+dERyLyZPPUzqstuhoYa8f+dQXY78IgMbv+emPlEip96K5Vi5yPGugG1x3lB3dISX+JmX/8DtUfaQNZmyZPVzykr0z3beQs/D9hqrpEj5x4vzsCRSSrAh1pbWv/OQVKQL7trAtlu86JDrY1wWG72QIr9WEplO1JViCNXLB4FlHG1/qJB1K34+bOrIdgHs6PtsAmtH14N2Cx/A+4jJC/2NKiS6fWzhzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 14:45:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:45:39 +0000
Date:   Mon, 13 Feb 2023 10:45:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+pNEtgyAJwLjERa@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <20230210165110.4e89ce55.alex.williamson@redhat.com>
 <Y+bk+GSCPKOJfr1f@nvidia.com>
 <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cc4da8-5645-4882-45be-08db0dd0f969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0HENpH1G4aMnsDnl0AIu1JOjoos88gFmnAGhoCEpIxyS5Q7l8edqirDG96xAVyzL0wUW9Sr6fSk8iXlIqyWAYZJLOYsZ1LlJvu0SDBDkXTnMJtAgH2Ejc1468Ittk7XS0yNMMRdyVGNnByiqAFgIYzkok9O91+JBOFd0hXwHor/zsaLsXJgMXsz3fdPEgmciYBoPYgsV+nPtjdAT+ybTsrIuK1FTbxBNReKUtbzBA/qur9FyO5pg1iwKJNON5Z9koMOAvI+9mS3AFeQ9zg5KrgkY2URocUITeo9w06pLFhfk/4YOK4PJMbtWMGew183IJj+1/t7kn17/9Y0WED6JoB8asiwOCOvHnglMToQR8R3BOVGd1fE9Cl7O88GjuBEVoMcWQJ9fiNECftmgoXYfSwpf633a8tB87zBrEpByT1xa7FuolIvXDRlqXfDXYky72bldLzfJEYWHYISLm2xiPMSF46ZGd7q/U1A9gjnZ1S+6/eKki477Kxl/QXKE8o8RAttE4KPDFMjsN5DZT3JTW9Z1HFnHWvDrnID+9DIDCGYrVCHa4ePD1hMvsSMDRY21tEBs+OcfsZHmMPG5KHKiMF2ici9sAdrRc6e1M2D++gVD8L/ecA7SQFqAfC7+dY+1KI1WKEFATBMkNUFBkHn4r07F9/VzSl6AhGzYCLfpw1CbEG6P4aZ4V7EyOyssQ2O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(316002)(54906003)(66556008)(6916009)(4326008)(8676002)(66946007)(66476007)(41300700001)(6506007)(8936002)(4744005)(5660300002)(7416002)(2906002)(6486002)(478600001)(2616005)(26005)(36756003)(186003)(6512007)(83380400001)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpnRjDlnKGtx6cDIjkfQXnBPYGXGULr5H7Z9zIIUyNWlAKBBgRVZKOqbMYV5?=
 =?us-ascii?Q?rVbitJOB8kALErecoF7DplwGxxnLj99NqkgUN+OVOc9I4U/jPpmpvN7PJtNi?=
 =?us-ascii?Q?X0zQLl8W83LIKqNJiXM2kisuh1ljoGPgo8QV1t9GRBHuFzXg+jZSN3vkTNPf?=
 =?us-ascii?Q?8GDKICBXk+MQOnptXYd7a8o2RphHLMR86DfhIWIav2AsUgi/MLYcuyuGkF77?=
 =?us-ascii?Q?niI0O0rKtEb98Z4s8tPg4xfT1wDFBLXUGsv7zOtJdi9ouw4vv44bOk9wZBsa?=
 =?us-ascii?Q?7lmrU+y2jfJjcFRaOaO0itgMqE0qu8+25MHqFjXomwq+7lCj5rmuqA14kqkB?=
 =?us-ascii?Q?+aBoIl1OY3gIcOGD1Yj2DuajDo5LNL/XvYn6oKFj+KG+afA9/qbaDbcKcppo?=
 =?us-ascii?Q?l1Qn7geWf+yjJmazcclGMRoa9yDuQUDXtSpOHzn6z+kqDKa60LnC/hPuYzf+?=
 =?us-ascii?Q?256zGDgmfgnp123pyUhEcJAdwbQVC9WK1SSJGMhT6QpF7pxiDJAaoEXKF5FH?=
 =?us-ascii?Q?SGzO2wiPZ8YmGB2PCJadWZ9MF9Ee8EUIfWKeokV7Pt5u8vOFvuuoPAUYvyq2?=
 =?us-ascii?Q?Z7csJXH8s2Y6iirRaIbp0Ez80ftI2n69QZdcym1MoTwHUsqDYyxCRrqlBqyl?=
 =?us-ascii?Q?RjJN1d77/fLxDb3XjJMqMg0kwoeWM97dEkleN1fBnb5+mN9sQyhMmcf1DUx7?=
 =?us-ascii?Q?cArnfuvLjfaHLDEwEvwVywj1J/SFp3zsR5MQiw4z8ZqtE2A94UH2MuFaW9V3?=
 =?us-ascii?Q?0DP9w7dZKoCZ28KBDI0sC3ZAGfkgDxHmbyBw+TwkgNAVfQT80SwNTOiI7yyJ?=
 =?us-ascii?Q?ToJqIX8gUQSGq2aztKghV1O5B9lHhGp39fekmPp0VR49rs90+RwD2ynjSbCu?=
 =?us-ascii?Q?30FnfL5+p3FTbPmGpFFg4Df3lrpIBIRtrwgbvzD3xycY9v6utDaOmFtyrG8K?=
 =?us-ascii?Q?JQpAhotdZBXiIpWp8XK23u0RmJLMxOcDhI3KIS5LjoiRD+N2UdmxGyPWUxWP?=
 =?us-ascii?Q?PPXBe2L82od5cgRdEsvEViqI9iI5CaHT2ObpGTVrRx1QbbMQfokihNGu9sow?=
 =?us-ascii?Q?xmQjbOMx0XINaCcah2Z2kiyzSRuPxv+lTltpSYMij6B6AhxV0R/lMo1t7oJZ?=
 =?us-ascii?Q?FjkPZugr4bnhiAoBTBPdSdS8s+X8s99BZeK/T+uVPsGDHZAhM0n00PZpQ7P4?=
 =?us-ascii?Q?F8FLkCKm/WSBLylqlDH4OByjLQawTSPj/d3QBbTSG/pLwL9rFH/A0h4tcwwY?=
 =?us-ascii?Q?P5Ft7JRDVfoPJ/C5PybmIwhMKR/N3y9m0fpdqDvLYcK4qtoCKjikq/vcYqqj?=
 =?us-ascii?Q?xPWHGDvBmX3L5gQbEMHeojxSMh7cb1oNDBCHK6+Mq6umAraCeaiwHLAwZWhU?=
 =?us-ascii?Q?cuCN2VtFp0/QzlrA48SFePEv0nGdALqhoqzl2119WNbiSz2Fi8Kwiicq01PS?=
 =?us-ascii?Q?jCRO9QX238blb5ejfA8p3kCdjL5CV0ukF5CeMWMcR22hA8R15x/XkTyd/3WN?=
 =?us-ascii?Q?IIZ4Aty/gDfD3Rknr/1ZYdJZOVrnoOjb/7NmUrt/B00aPzssOUMoANS4rLW/?=
 =?us-ascii?Q?el5KIKFza/57034rzT36xXTBskhlGpucullMB/UW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cc4da8-5645-4882-45be-08db0dd0f969
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:45:39.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q6xdr5cJ5y+KWAWhh3X/7E1Ew5HwJ2ZIyC/JvqrtC1GPUSHkJDggR0T8H8ZcRsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 13, 2023 at 02:24:40AM +0000, Tian, Kevin wrote:

> > This is because the cache tag and the io page table top are in
> > different 64 bit words so atomic writes don't cover both, and thus the
> > IOMMU HW could tear the two stores and mismatch the cache tag to the
> > table top. This would corrupt the cache.
> 
> VT-d spec recommends using 128bit cmpxchg instruction to update
> page table pointer and DID together.

Oh really? Such a thing exists? That neat!

Jason
