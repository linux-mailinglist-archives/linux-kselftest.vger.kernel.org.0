Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6104360E79B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiJZSq5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiJZSq4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 14:46:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D962B7F4D;
        Wed, 26 Oct 2022 11:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J49TSxb8nK+6swWScrucYIz/vaZKy2nl/I2DY6qlP6nBuuyb6YhilUTuae2JyJApAQdPJ+mN0Fgdv9ltGlIaSf0ijHVzo1S94NgkRb1pDbzZhBGZ3ktjzYvbftfH9OVm/0qd/fDgAa9L+SIZ266vff4lbDY7qdhNB1Fa7ToqRQfk3l7CciqaLbs0+Cc0zzmpwb+8my+qOecc34iTpg3zbXJjfkqP7MLVxrMbIRbcNuJ7JfxEFiziWYSSawrYO244gxnlBAijIZm4bc9tsN07UHZLWRGhVstRIw6tQb+IEMSa8wrtX5K/SWK5Sl1vA+G86uplG5Y2p//laSral6hsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN/VOE7OOWZ1MdP03KCPKUztW/RWtNVzFlmJ2qseu2c=;
 b=GFvB34umPQ6klSB+FL2Za5pAQ/E9xg53nLIdXqJghv2foS+gK2zUZmD07Ywze4InGekLAEOGaMEjioahjXhjU7Cd8wD3Eupc4gaxqy0fWVtuEcyMBBD29gMoZmbTK80Nd87qHBeU2dhrQd9buzb0VLYez64G5eIpAp3ASyAjlOrRlnIBvWrFoxmcxLv2dLKcxI0JF4XTMWkFHxMskV1dVlOBGTTCi/oBFd8wRI85vGgaG/UImF72u/SaIEXd61c0HoVOGPzNbWYbWoTHRbnC2RGdWsLMdJeHIgQO1H53RsgGNN+04guuCqzkPYbENJyyV4lkBQmenSXqC2Y/l4V1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN/VOE7OOWZ1MdP03KCPKUztW/RWtNVzFlmJ2qseu2c=;
 b=dxX87Fj366FIh+EDmowSphppOwhhxU6SCpNiBDxMM6HhkdeMAMtat0/pWoA0v2PeKJeKpd82Ux0R2wMS2K8QW3XeylmkUcEXb5MP4xUz/9mZ+pTNsa5Ub7Ll/tFK/bZtLu+9QaRyWNw7yM8Pta13qa+mKPJNS3jeDxKFQQA3YwQ5JqDBqbgNKenlMgpS/lJ+RQ7D76MtOSQfu3+B1Uo1CSG8DJPeYW8bmothxAGpolYN/q4duILzS+pSo2pMdVHVPzXqpyWd6H1P/drNfSkfZ/p1SxlDb2KRTN/DG1UvEnDybQGHcJSCPV0vc4/ELLSHRafTa04JGjjabIRU4eNkIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 18:46:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 18:46:51 +0000
Date:   Wed, 26 Oct 2022 15:46:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v3 9/15] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y1mAmivnEyQCMwO9@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b7dc55-69f0-47ff-0658-08dab7827201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkOVNlb93KzYciqujqQC4nKi634vmucVeyz28St+qIYgy3l/Q2kKH/wL0yZHEQO75R0d2qsGAa1tudaO1aiL7tyyp4Jqx079Oa+yhx4xE0g3h9Ojiqjtj4KIwPXFp2yNr4s3tNnYv1MZrMBtrcsFhdsJoXnTDtBGBBPNdhfmgIhQ+lgC2hWOnz2SIifcFaohxU0GyvjRFRcPK8zX7E6x5agO7bvbgQFM/5sze28IOuF7EgyD9sb61hKLOUN19TnID/Z6jO08tyT2yj4zlYCk08sWVbuH06G4b2GFfZaPxtoDA+46XVGgER18IDeMpxSgQHDZ1WgWEkF2lKsEFgPIX/m5iuJV4QpswX+1fRNA1GvC0KMCYz8uYb/0KplHsdOxVl27wznEZLCaPX/VTb+5nZjHwz0L9dy4QSPHQstKiuVjqIJh/DpjJNF/YAgcgCOdlx6oWbF+2i/SNg6Nupaj75bmGjJR7iwHZfTZFFC/IeSKc+JDvSLzhZFDpskwJ7Q1FOrvQKmf7/vkQmRTVFQIOcN3Zs19/Itr8wpXRS7zWROPjaQ2GChH/pBt9B3wiEkKmfPCuVCeIhalrwlyDU32bZMtLwksbZvdj1e/AMEfReOP0JCO/RttGZtQVb4TV8NMnFBbsaFL3PQtv33o0cBMb770doKbBstKNrOrn0Z+XTNPRKbmjgBaH2b3chD9YmLypnxr/z84ixjL07esoBvmvWFG3vvxraVryjrDquMAdKmNrtluflvWQEua2V4w5FEZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(921005)(8676002)(36756003)(86362001)(41300700001)(26005)(66946007)(6512007)(4326008)(66476007)(66556008)(7416002)(7406005)(2616005)(5660300002)(4744005)(8936002)(478600001)(6486002)(54906003)(110136005)(316002)(38100700002)(6506007)(2906002)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5C2jDPpHx6/xb6kt74wXVMB0PT2KWZj84fYVLdr3uxxurJg7hDICEsLvxOw?=
 =?us-ascii?Q?U0sTPRIPAqzWm9W/+zMQkXKUw35Jhb0ruWmktClElhfCSs+W6gF5zySsop15?=
 =?us-ascii?Q?mt7R2PgQ5ajMOO5WgQpJnzZSU2bEW+GKaaaTvO9hojqS1mGkxQIdxnq9nlci?=
 =?us-ascii?Q?7eI3oKB2A24GBxRbg6TLv3Ersoi1/TsqkW1lr7lwv2rDJYTIgwQXHzAclu+O?=
 =?us-ascii?Q?8BaNFQp4FpfnXxoZbim3NWnYPsgrE+mQHL7UY+rbQVdbKvrL7qTMCOYDGAMf?=
 =?us-ascii?Q?bHrVz2wnHqWpvtMmX3gqsG8zC5Th0OyNgfFQpOfznxO/rg7tZs5f5uBU4gbz?=
 =?us-ascii?Q?f9hUdfqm7DKvEgYH2SJ2lF/1wCfxhEpXvp2jcc0syn9oiKC9ntGVH6WpDPcI?=
 =?us-ascii?Q?6tK4WuvjburgWoLgfpTt84+vmCb6aTX6pq1qADWNnpTImpulT9BQbJEP9EKY?=
 =?us-ascii?Q?RZkYomHXBSv1J0FQ7DWcXpRJgeOYpryQSPSSsO9owG5oy/raMP6mEl17i3s/?=
 =?us-ascii?Q?mC8KE5VhG1sk69DR2p9SRzBk0mA3IO30n9yBbUOfnxGj0xH7J33nqwnFYk9D?=
 =?us-ascii?Q?Gat4ZaNQgwk3FmspZPmAwIbJ+aleODfFyv5Ms103Es8MMCmbnYPQjYU2DUKw?=
 =?us-ascii?Q?rmW0aI8EB4SdYo432NOjqz0dpiY/arWMk77fn1sN4VXcaEXyUdm49CZqjjFR?=
 =?us-ascii?Q?6Inu36zp9zbIYxJ5KLKihcNPzfQoQrbRtZdAtQ+ZChhTXJzyy69yGqvRV6qu?=
 =?us-ascii?Q?IbxjlOEdaPnabaYqGGMDw1Jal3+nYeclxVeKmEaEY/JC55pMK1OcvpqNu72y?=
 =?us-ascii?Q?pNsSqq7qVctaQRJHoUf5GaglVvfCfWICL8vHDm6t1mQzK0nRSU9rYz6bME9U?=
 =?us-ascii?Q?yuARbFeC29bplawVzZE4c9oeMNe6RfQUyxQ38ZLEgCTxLG+IcMs4HZ4CJ7c3?=
 =?us-ascii?Q?mBjLCvcA3bvpaV6o/rUGBkFoJv2/fbEcTqdt9DlIXmP/lN9fAI22rjNQmPU9?=
 =?us-ascii?Q?r2bv2i8bRv345rEwghOWw0myaSlvkpP51t6nRdr8fdS1JS2UW71TuqhtAaQh?=
 =?us-ascii?Q?FRAJ01SJx/UblK2IHRA9SKVpNQ1Tkk6eRtOH2A+2Petpu2hEnhhTxPLF+up7?=
 =?us-ascii?Q?/yDuM8MM7JRXL7x8+z2jjM82HznubKezw/uLy148lZSz3ZLCbSbxWM2NiQS+?=
 =?us-ascii?Q?sqKGxy7b+s6t6sC+oBXMn2hl1ghtSJwrm/+6Y3mftSaJ34Hr1/wzV2vwAxc2?=
 =?us-ascii?Q?sLkrgX4bs706OtKEFKadlLP6BdqbBQjpWq59PGFghQENJPZO0YID4wHkw/7w?=
 =?us-ascii?Q?beBuyfm9qv/4v21+aswYpOqw4I5zlIwJot+R0leuNSI6j4cL1ky/PQBau2fR?=
 =?us-ascii?Q?Aspta6odLUGyVStmEcbjJswnXuLBabf2YzqH4IsS22M6Mfd7e24SRvbp+xfM?=
 =?us-ascii?Q?LDZtlJTBSPq5tAbYutydXJSnWvG9D6Yfnq0t74QBcZVcc554LUoLsXX33TAm?=
 =?us-ascii?Q?YrqzJXGvvWd9jEDCB9QfSDsctYrbofNkp/54EnIWJnnA9hojQVfw1NkkCPIS?=
 =?us-ascii?Q?TzqWbGdwBBkQ1LlPDO4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b7dc55-69f0-47ff-0658-08dab7827201
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 18:46:51.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mCSQLuKm/N3VJtlGuSWEoPyydaX4iyLBgC8pTeTilqB1LQRCn8L0vPMC9bFH7RV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:18PM -0300, Jason Gunthorpe wrote:

> +int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
> +{
> +	return iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
> +}

syzkaller indirectly noticed that unmap all of an empty IOAS returns
ENOENT, it makes more sense it should succeed:

-       return iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
+       int rc;
+
+       rc = iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
+       /* If the IOVAs are empty then unmap all succeeds */
+       if (rc == -ENOENT)
+               return 0;
+       return rc;

Plus a selftest to cover it

Jason
