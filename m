Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C053664469
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbjAJPTB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 10:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbjAJPSl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 10:18:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2375C1EF;
        Tue, 10 Jan 2023 07:18:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZBHBByvjQf62CG/c2to6LW/LipV+hUhNawF00CETHClhqcSfPvZqR9JdlCCF+RjDHzReX4R/+x2nitZCAwaGn4zx6t9XkbfCTLs3nLq77DwvNOF/lHtLNdrN9XQEXVV5ZgfqpT7Vp6JXpmji6EFde1FRTUUlyoILYq8HinxoN/tlBG4XNV8EfMAOtvM4HEjt8sHGCX7wT1MmH/EITj/jmWQTTtuSFzvevEX84JkJZfHYjmb2gLUnpt+SzloZk1F9edGXYhcMzbX8qQuZoBaZN6aEaKP1Ey4CKtEhuoB8cbwYf26b6V/JAdrAgNIneCdRPM6zQ3GWyI4y6Rx3f/HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL56lFbJKkCa8rfUsGkFjdlSO/Jjx6uOd8Ce5PK7ej0=;
 b=IHLinwLV6I1poeT6S1f/0hBqlFRyuqCDOiX7jvBlNhlgBbG8mYTJ9iccK7/QDtBlXVbqBZQl2pb9SeDeysDayYNWxJubmYiQY9/mfBeaOgkQpQzUHilJIlUi37gKIjCbKV12ZPqICgeTfpKxktZ9KKem1u9m7IYym/JmiIFsfqhbERYuuYM6qB1nD9ExIaq36EtJyDaBx4vt+ikahTUEXFi/fTPWVIlf8aKA7yBrbJhSJKfHwz6mDRfcJmv9a28AGHJHASbUPIRGOI3WV5igbdx/PdnnLoB5UpoEti16Bb2xzHICp03dDFf7STrnmk5r/p49hDMkYKGH6lKVbugTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL56lFbJKkCa8rfUsGkFjdlSO/Jjx6uOd8Ce5PK7ej0=;
 b=EktoiOMpeMtlvFNVn/uy59nUgkasrXrRuRsr3sqEHIeTeVV+s70fEKO5LB0P56m9h0D4IRJisf6CC2tz1IAFdFZaTYjXyoTk8PHArY81IUMvyCIgOwhn7FyGyZXSQ9nMYBM/X5MY/bfTBIpiUE3p+0dYiAoHdYpt8swiXKf5i7meofV406Vc1xpgSn6pYNIsJmweJrg5ONvV7VrrYDN0+wp8vxCjl3ff0rck4WvlsuMY/XFvVGeuvl5ljt/rOBYlyZXPURcTRVZVUY6Kz/S7FZN6kbhNuDOB2rFdLtcpet6VtsbjfEsU6khVN+kyK0N0MkhVKOaWPhdyiqh3v8s4bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:18:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:18:24 +0000
Date:   Tue, 10 Jan 2023 11:18:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
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
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        zhukeqian <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 00/17] IOMMUFD Generic interface
Message-ID: <Y72Bvh5kLD7f96nC@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
 <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
 <36b0fdac061e4680b5966d2774f0026a@huawei.com>
 <Y71szSt7jRFKTMcl@nvidia.com>
 <5481b0e8-84dc-52a9-c99f-1df3417328d6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5481b0e8-84dc-52a9-c99f-1df3417328d6@oracle.com>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: f33719a6-5d08-4e8f-a7db-08daf31dea4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sg4zy6dOibIiqj6X/jwvhKZLGDpzjlfOzylB3lMq6j58QYgt9F14Kj9pd6+tGWUVsLwYotrOErzH+0kcIwSLqK0qP3+2rQGgdPLxxg+OpcuDkDH7orACIcEo8Q3zFCMNtxa90zxezhjsSYPIeg2t9DaD6mD7DB0dZd2DGGSuFzMFtphsID/p6S8FWUCa6T2Td2YmUi1VClX9uc6lzN1LrSLqieU7iJVc7SKGgh8zznWIIFLVEwuU0DFFqyA3x5uqwEBZi9fizyMrDEm6xbNObs6Woq+B/AbB241+VxhYWXWoU9BHaA+09eRVRmTmtZ/WnSfqjs7t0QOwVc1XpQv+T9sDuwmpwqPFvcF+WGYc1oEI1VMQ9m9mSmQ5S2cwZQus3smX0hW5M2LO4IxA1gTp65vqKE1Zu4ZFJZjMH4etih5ye+HSYsYqj4zG2HZfxn7hSaz0Co6syLvpUXg0adJlfOR59c/bcdvWk8w3uQhe0fDTnY4scUCRGqO6Yo242fBsJw2A8YWh/E2tb2KfFm9FRRx84QIQytttHDLkD4KmWcYcMoMyi8pjb+kUSHLLgqeJ/uS5lx0J93BBzeU7FN6l7CmjLHT8uc6ho0tPDTweohwFRFLDZ37GDZvE9SHDeNfJBldX3/eqkccFuoojBeCJfMFQLfrNs2TSsGIBDEIuvLU5Qa0T35/x6EwlLbbZiGcr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36756003)(186003)(26005)(41300700001)(4744005)(8936002)(6512007)(6506007)(2616005)(53546011)(2906002)(316002)(6916009)(86362001)(8676002)(54906003)(66556008)(66476007)(66946007)(7416002)(7406005)(4326008)(5660300002)(6486002)(38100700002)(478600001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5euydxR/nBaToc0ZMw3CPDBGi7IivYrVBiWcvAv52ltupprDhVgN/Mc5Uld4?=
 =?us-ascii?Q?auijngrmOuLPQOqeVcbAVIo8VzZNqOOVQyh4eRr1pVKmw9YngOdDCAC9fQDs?=
 =?us-ascii?Q?MphZ3Q8/Sjonda2KGwayEG9rYox70/mO/bpRH5tvcIkJFAEKsgDHcsuhB5ni?=
 =?us-ascii?Q?jqZsvtLmDS1aGVJZ7n96IZyVNbBhRXP8vr8/Er9+ONKbmQxldz1+FIsvHmXt?=
 =?us-ascii?Q?/jbOSAOdqObBpTg83bWIqP2kg/Fc1vw1VZKndqwJft+maB5YyK2rgqdT4F+6?=
 =?us-ascii?Q?Ez5CCK4vpNW3kZsa9GlaWWlKhYHd3qShnqBRkpxeVIlqMS+ujZS7aYW2CVjY?=
 =?us-ascii?Q?IQot/JT/f5YVHyZ2g8qjWKazdf+ouR/9LjU3sVg1yyQ/H3O9jnSvrHg51JSf?=
 =?us-ascii?Q?3iNOqSYi67bnEjy6hqovpbDjh0Lo7RN5KSJnxpyDJWbuAJ2gk3c3m8YsC9R8?=
 =?us-ascii?Q?bwif04Z92ohqZWqbyvnZJnpaA5NafuWOHw8iiOv4MRbh8evQ0HXvSmxSsUjJ?=
 =?us-ascii?Q?VBxPXZjHMEpvwnok6ppEMPmbiZIqHN5fz/KejZCstLRrEcZsyXJvnUZxZsgs?=
 =?us-ascii?Q?cQM1XgPI3Ui1C8cwaS1wGX42fOyuzuqJ0BLRLNKuXgg82Kw9/VrAhBPQYuli?=
 =?us-ascii?Q?uh64A8Ip5q4+qMP4twwxL1m6b9rQrPJppB6nm7SP1Z9F8iCL+bCPQXmeJh+z?=
 =?us-ascii?Q?qD9Ren8Er7bt/jqulbbmWYlro8cfT9wM6Y1ViRe5zxG8nt00u8WZfLuFUfH9?=
 =?us-ascii?Q?SxdHp9lXp64vbyXPlTCD6lgjKFSMpIeh9oupkOchb/hfTKyiu6PpQqugos6S?=
 =?us-ascii?Q?Kdkh7UVD193iQT4dYyjTv2BW6yNXXppN/zxQJ8hSU9U7RdM8pm4YbidiiSJm?=
 =?us-ascii?Q?ParBEh41yjU6Oj7BY5PWPdvU89lo0edOaZwuWGMM2fL8tNG4YrDGLQgFkPOK?=
 =?us-ascii?Q?Lq0H/dqXaqBSYfV65PCbhlWvtjS8Ho/7QKfo0FYydXKraQPM9fJWLMWgdb8Q?=
 =?us-ascii?Q?NVrCRv8KTDztoqiGijM/DrQgfesmMW2XCskOj4PnhimXF4CeIDMs+Cd77a3p?=
 =?us-ascii?Q?YXHSt7yV8pMTCn5r/hpgyMY5855aGaHkD/RvJTXAh4AuFhIOmbjxVGTHYbGI?=
 =?us-ascii?Q?lQ7E+9OF7grvkz8l9+xPbkwPd3zvkRXhZ0KI0fNHKlfYFn76HkSz7AlSubVx?=
 =?us-ascii?Q?pKUrgiLd9S18WCwEd/RY8DMCHJYoW9QDgUxIBezlwwpIsVi9a4vb8DScbNgu?=
 =?us-ascii?Q?Y5j61GLgLTvNTVQYgE9tOAGj/zIPhJrfuyhzUum4qvnrQwKHhzSsk83Uhl4q?=
 =?us-ascii?Q?l3Ox75B+PY0rzjoipm9XhoUY0r+46o2Jik+bkaUWxWYrZvheO7JTpzlnnYif?=
 =?us-ascii?Q?La1nobdhZjr7Rn5HDY8ukiU/lNj6Tq6Iq4PgjyaChyM0SjjVgzTT7MVeZVGo?=
 =?us-ascii?Q?ya9UZk+EewJBXrO+ttFa4xgmPnQ0dhPxHEIBXsrHjClY02xeNhYW1cvSdwiZ?=
 =?us-ascii?Q?kVZM7bscuxTiI8N2/SteqXel/I+1UK6JX+dywhzfUAEV8DOUXxS6PAjmEaqg?=
 =?us-ascii?Q?c+3dGMINPpi7Mzh7JL4/LCbL7TdmndiIUN/tI0v7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33719a6-5d08-4e8f-a7db-08daf31dea4c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:18:23.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYj+mQ9+++WATS83fAB5N2bifhkVZtL3z7mHFc0Kx9rrEZnNECY/wv4acdnrYSa7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 10, 2023 at 03:16:23PM +0000, Joao Martins wrote:
> On 10/01/2023 13:49, Jason Gunthorpe wrote:
> > Can you also look at the dirty tracking stuff? I'd really like to see
> > that done for the huawei vfio live migration driver
> > 
> 
> He did look and provides comments based on his testing of the initial series
> (IIUC from what we spoke at LPC). v2 should be simpler, though I am still
> working it out the merging of unit tests into iommufd.
> 
> My plan once I post the v2 was to handover the SMMUv3 part back to Shameerali
> given the fact he has hardware that has the feature and can iterate more
> meaningfully than me.

Sounds good

Thanks,
Jason
