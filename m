Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6166423F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 14:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjAJNtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 08:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjAJNtK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 08:49:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC854E434;
        Tue, 10 Jan 2023 05:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaNpA/82wHCfrzWU6it4n6UKDbiptW0cSMGXQrMQ+zbZkNIdIpk3N9ayDigZDO7A0A+dra80RdhZPNrfO0f4XZQJS3ueOc5PSL+zq4XmlXMYKGZd9O83M0dS0RoQ1ntCIh+r2REgTauKdwfJp7Mzwqwtx9JgAnPSiSaKiBxk+c8O+r5xBEWbmXhFKPR1iO9aEJhwafFsW0HjP3ecyYa5NxunaFP7qvIT0Y1dUFl2ZRCCOrX6UjKDExtGCLd6Z+AF2wTIhJ2Ttp/clldLI64X9iF801Zt9o/E8rHbYSzYIdg7UyS8J1ybiCmOv5+6SGz6RwOSrsvoJHg1zseFzMcN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30ADi7SmKKflsICxuEjPFnULaxwBK2WQ2Aqgoh2hZ+c=;
 b=By+cSx/3Gp7D9HDDlmVZJasafn8Sn0rmVZdRE+bTkOCcymLbwQp/teXgRrh2B0hDHPotKkvS087NYFuq8rQvw7M8rAiWfLRW8oMrcF+0lGeZ+UpxXt68IZFm4JXzeypr90x+YmAmNO/l6Oz7SWfWVQCrlBuB33Jb9aG/SHwlpTxugI/3OGW47h4Fm4NJfjqJnd2unrSAAzE9oS1b0OWybd8cshsPxchB8i0oYN7h6LOgItZGkNRxYzSdddS4GBr46hcwkRNoYlurwkkvX0EDH5HK4Z5ffjeIQxFHYWKgBUFxqcTadAAWUG2nMAUuCBIEUul4gpaNlsI8AzAfrawN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30ADi7SmKKflsICxuEjPFnULaxwBK2WQ2Aqgoh2hZ+c=;
 b=XLCIeAQl4zn/p2iKytEzwH7d8oENEsQEeyb5onI5H3fXu11lOtKI+sceaHc6tm//7tWNVOh9F92MiP+QbVMV0wlvM0ELg5OIhbHftieNtp1isRImTqAwUUZKYba4kaBYpqZrA5ffwS+tCdCTfn/g0lUtl4GcMrcUvYd2xna9TdLwkfm967iGPCQIJ1NfylpsbF1O/rQwdLuRzJEe5iR0CrVjkKcIpT27DQKDM7yjCvNyWs8sojCJ4cKz0TXzvLyA3ssZ92aybavJERdoJS4dLtvE8872MtTL1CQWaBFyKwS5/GCSoLd9nqsVDEvE7C5IsRpL6UBzXFrrHmznvZ2X2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:49:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:49:07 +0000
Date:   Tue, 10 Jan 2023 09:49:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
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
        Joao Martins <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        zhukeqian <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 00/17] IOMMUFD Generic interface
Message-ID: <Y71szSt7jRFKTMcl@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
 <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
 <36b0fdac061e4680b5966d2774f0026a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b0fdac061e4680b5966d2774f0026a@huawei.com>
X-ClientProxiedBy: FR1P152CA0137.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:200:22::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 667fee0c-6cdd-4d58-9b66-08daf3117180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boQATzeObUbGsTbvM1Kzc/LV3D2IXC9AmS9a1OH3y2yw8aQjrWRYlE26ZMgz/kudCjnTRvGel/lMXggsmszCsT9tmFFm8QecMCsBg3UXMogrwm+66lYFwJzGv05TNrK9uuto1XIzpznLiif/wmxRC3vEB7ni6rGJTPiTLXf8ObAoDhmLAyZEG9BQuRSeyjORiDli5R+ZSZ+SE0QMygf1GoUahmPvKCGVgKBt/JsN95366sIHBHGJplBK9Ov6P9to5mkpJt2vDzEB3Pdos0mvNjSYSlFs+GnIDyWhs7gLsLdZci9w/P43WDmqG2l0+FAjewsbA142/OsGPVa++apD2y85VQlYFS02kjApqzSbXZfdvmEdw6vUuYRXvpCySNjZCwj9s/6ivNeIl9EF5lBsozN5Mbvodz9GjH80h+TOPPcKKF4m+PM4F2MxqLMnxE3dRybeuazoPnHOjDLbH9L5PtPxGbLbNOmrW4tvsa4F1aIIslmhHLdexwfjIF6Qx02wLfijC0Wlh5cHU9+KQUzwpzfz3K6akw+onCyeg1C4lATzSaKMhV6Q3zIFL4bDTbArBKdgJk4CC1CCPREVb68krRhmt5QByCIKtsNZQkoCeDHZ9S1AfmgZIWyB6MZFKKiXUzRCObQdzjqfLuamKniAqVoZs6X4y0aqsC1v5V8zG+/TlzMcJywVr8StK5tE7QdySWXSiAWG2vvE0apnFTn4FGo0u2Lwe02HnkCq8d1SQ0td7mzl2a4nUMjFdf4puC+t0+KX7+RhOKs+IKHlIaTBhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(8936002)(2906002)(5660300002)(7406005)(41300700001)(7416002)(4744005)(4326008)(316002)(6916009)(8676002)(66556008)(66476007)(66946007)(54906003)(26005)(6512007)(2616005)(38100700002)(186003)(86362001)(966005)(36756003)(478600001)(6486002)(6506007)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRA5BmOetzxvl9+QlnNypyonrV8ncaL7mJvDrQ2Bj6qf7p86RO7vL94JZvzN?=
 =?us-ascii?Q?zSJtOO0dcm0p/Z/BTmPaV4B1RMmFYxt75Tp5djJGcm9nntsH7rqbkCUfCS3z?=
 =?us-ascii?Q?SeNID29mz+BSM91HvY8rzj5z/KAsXYL+276yYj9UTjdYi9FhGZbvKJKpOXR/?=
 =?us-ascii?Q?hsWfW6p7yym6sqbSK8NHgxGtm3lZT+nj/AK7y9wnUYRyjRQ01ge8j8Nwp78m?=
 =?us-ascii?Q?rhUHY8NKIhli7U47wrWfttt5rbg+9RCrtgWZlPFDAFJl0zYgw5HLLKBCpOKk?=
 =?us-ascii?Q?MJI8JqWnmk53wjuJnusPY/ebBfW0FGqOGLyJd0VcC9iB0ymEky9Xtd005FpZ?=
 =?us-ascii?Q?QzxQY/+wO1xgKFm549XCh8ZV2BLBmYXmRBrREKcqQ1yMM1Skz2ylASTsmmwB?=
 =?us-ascii?Q?B2G6yccK1wQjlIjCrBFRfwOe5LVsMIyRamvAUGi0hPc7ec/H1CkqbuCnzrDe?=
 =?us-ascii?Q?6ZucNiR4ZJ+e6TQ1EAbfibzHaEcO/ts3wrIQbMji2rNfbkFlldWsdsvCGleD?=
 =?us-ascii?Q?i2OqQHbd/Gb2uJVdCuIPl2FMwKbjXth1cZPRzbSNCOqXj1RBWSF5SwC6oNMZ?=
 =?us-ascii?Q?KyVYsNJhWSLNm+Fq5x6wnNfpil8riSYuTgSOQJWFPz/4rsqqV6FC19FJer8x?=
 =?us-ascii?Q?wCmqZvhqBO92Qvlan6Cd/mP85jfHrEn/qfJgiqT+E3vHy8XGA89VAwIyPFM8?=
 =?us-ascii?Q?oi9o8Q8HAAzlfVjDeaXXIO+/qftQX0kO4GDtjNoIOsglMR/F9FyWfHK0yNZw?=
 =?us-ascii?Q?dp+EDwqMRuAmG/7Nv30QNOF9bu0y3dBNOTH14NW3k7Vb1srBqnvrZVrvpw0s?=
 =?us-ascii?Q?zn3s7Ol/GYRPiwjQcZdh0nwYjCYyy0s6PUGdgwZz94pdps7tlqMLAQOFCOrS?=
 =?us-ascii?Q?UmcpWT/+HzgP4r+IiFpdY5tcGJESCOCgk7USw4egjbx8gn3aKRIxnKsVeBy4?=
 =?us-ascii?Q?fwEk5RM4GwODnOS49abr2vl/tgKAtotnyOfQOffgfPTSbXHZajMGyqVbUR3V?=
 =?us-ascii?Q?oM1ljEeCLINdHI44J5duscedf1uv72HiUabcitu6N5gnBvhwGUG464YkrgdF?=
 =?us-ascii?Q?BMzaG6oOHed2A27YdBVJg8les79hlcwggfL5CIR7HI7JBpctdz4WNYK0tnLl?=
 =?us-ascii?Q?QKTydwbILLkxTi0R9r6zJnUQwtZw2LU4xOyxs311+drjn7MaN5meDtAl2Lag?=
 =?us-ascii?Q?ZtMbxPJyefZHJ+zjX4zuTLkDHmRXnFO9Qfl1mGaYywwdB9ZGcPG+/x/nXqzV?=
 =?us-ascii?Q?sSdfFotAvPAMP6zRqJuUE3m+beZcEfcMxFk1TXpgIt7TjR7oJlEHvvkf/Ze4?=
 =?us-ascii?Q?kD0nouLZqqNqH1F4j4tpljzt8K6z+hecItEez72ahTeASu7H8FhBiFXlvEfU?=
 =?us-ascii?Q?COcpFlCq5MuHLOr4Wqmb1CmmCPp6NjJ+JVfFkx1lER73h5EltnoEe2enghwX?=
 =?us-ascii?Q?z3q4feyx0JjK4kZPHXoxaVh8PhbIREl1Sj+uvNmD9wkQMRq7sCfvFfhKEHsc?=
 =?us-ascii?Q?duZm0+vV8TGPIDgRfFdy/vWZkezx4l4+VdruxPNUR47T64a7aVCbxrvKZXWQ?=
 =?us-ascii?Q?Wknx8APNnzlzMypqFtkCs7xkFIyQSfSdnCZFV+0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667fee0c-6cdd-4d58-9b66-08daf3117180
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:49:07.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlQlY9Q0Yi7gfMp2B20Bx6d5QoDYbX9/26oLBHnZVXzhp6hfmGtuTFtbXAbNM2Fs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 10, 2023 at 11:35:59AM +0000, Shameerali Kolothum Thodi wrote:

> Thanks for that. I attempted ARM vSVA support based on your above branch
> and related Qemu branch. With few hacks and additional patches the prototype
> code works well on HiSilicon ARM platform. 

Nice!
 
> Please find the corresponding branches ere,
> https://github.com/hisilicon/kernel-dev/tree/iommufd-v6.1-rc3-nesting-arm-vSVA

We need to have a big think about how the PASID/PRI caps should be
working in VFIO..

The whole PRI thing needs to be its own series and need a careful look

Can you also look at the dirty tracking stuff? I'd really like to see
that done for the huawei vfio live migration driver

Thanks,
Jason
