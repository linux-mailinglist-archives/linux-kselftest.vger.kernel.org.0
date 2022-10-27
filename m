Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B2160FA34
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiJ0ONC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiJ0ONA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 10:13:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0753188127;
        Thu, 27 Oct 2022 07:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaulnkvOnd0quCDAPa9ItCDp4AV+7FFFVGmydEcKp+mFxItcT9lt3by9uAjYx5OQHgzm76P4JCt4bgfpCCAYSdDlGSPpAhf32XvlD+XnMD8T04LrWjeUJwgzV2zpZSHmSKmJNGKjSdiALIJNh/PlyZ1kuHryAFrlgkT9p/6TeHDRMRcQ9y3/PEcmsms/xqgKVa8mGevZFoVIUYrzWLk84NNMG+6MtWnaBhYUt34EH1fHtYMDnt1NP57AP2MgBqmb92ghZ75sX25+95BMZ0NXiyNd36PZCqRRZHr990g9SSvZeXDIl11GHqna+1Ap28zVapVsS9F6uae4wyUifz6oIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECanfhle6RgAcyjpZgyjRoEDgaDEmtf01D96/K3JXK4=;
 b=QPHg/RNLqeHMU0/9NneAwJRU9Kh+PqRzOCa4suRQAvm6rK1n2zWoSkLxzoFIpFbr8ZIlNB+w9p38ooA2EHmYMxfSz3tIdwkgpSSeKzUt5yeAizlzQrTa0knSACAcc3mN7jmuusVAkgkcRJY7hs9GjiumcHShlDH4mixsXcXu4XcOCz4g2r88nDo040vioGlwivl/SxV57+HQjwVIB4oCftZchv7jb+aJGA42hUzq+YT5nmn6TKYDAD9ZPRpqeL5VVztqciXmSVK2IbtCNOfl9OQXGXeS++RrPeYBXRAFC1hnNTpcjrJ/45LCW2jjiuv1ADDV6cEi+SBIWzywfhHV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECanfhle6RgAcyjpZgyjRoEDgaDEmtf01D96/K3JXK4=;
 b=n2WpoeAAq36UHHxuDeaydiKSAIemFi0dmPRgJaN/nqsjK2QqvkqKOfTDp9eYsqLiuUkcMoa93s9mJtb5nPhpO+lYTTxWzFD301hQHX8JNuKhSV0rs+PGkVSCwVs/1BqH+KHl4F21qyPFeOisHlN9/CFMxwxta5Uo6aZaXfohbPtHCnU946X9JAiSCh/PsBNIIuRuw7SxDNaPyRWh9sSTtIfziusgDXdAUlgsowNoMGL2aVL+LeoLMHAcZ5frJt17li79UKTJI8C/CXWnJJe6n73JqdQq3iS5UrDA48d4qBjqY7vTDEKV075Cd5qGZ2IPpI2Y7WlevYXf57Dw2suBEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 14:12:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 14:12:58 +0000
Date:   Thu, 27 Oct 2022 11:12:57 -0300
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
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y1qR6Zxdmuk+ME5z@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:208:239::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: a964c2d0-2ae9-4c54-36df-08dab825594f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYkVHSz3BIefSK10r8xgx2LUXDQ1Ay3YYE1To07WP5KHDKCqAtkETHw+qS1TwsRSEBhbRSSecOGlGbQeOG2HhkolX5dn9S1QJ9R8HnnCJfi/FeBu65/zlUbLLdhdqcb18TbnkleDfXT6PyqAShSutqKPB6z08aPRIAGmPYaLB9e59MmqGnwDAJ5t7z4peAiADdFKLrbYbNvMPE+z0Q3HPdoaPRRcjCHAch/GQRqu4txUvxXzk0Di74YABNQNzPVtZJwXUbM8QYid69H6pfq6pTAAskkH6PRMJ8PNSTgKTTRIcAs0wEsV+UlkW/+TuIzJpBAle5H/fqnw0sYVMrsowiAWNrW0dQFJTYZgralStwGjpEQlv7MZ6Kcvzxct3XLvChkpoa9zUVv4GuO6TvM2Pn9Wb8GjpHuRo5BatmDFSVrUBbmA4CzcHEk2MI19lAuEhqrVmFWm+L6F2cKbqYIUWv30QpdaIbfWEIEB+4L6BDonjkmuIT04UxW9GMda5mkivAbjsHOxAfDDp2NWj2LrF0s+AAWJ7LK6gAxHNRIbCxdVV7sCQgxDRTLXJpSRn1k4D4sob7XmI+/9TENLhftu7kH6WRTPq/gKCfWvGnVWAUufgZlK4DduMYOjkwfPP/LKlk0c5MbdtB9OTeO6wq1xL3wWinHx9Usayy582DfjDJTl5SP7pRLCX3Xg4W4+hlQ+FQJKEsGWGlFQCfxlx6YSDcYChlz3PRgQfHPX94I81w6LXFjP9SFWWyB2O6KAghQ8viu59dL6CfwGJhJ4IpZj4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(478600001)(7416002)(6486002)(921005)(316002)(38100700002)(54906003)(36756003)(4326008)(8676002)(66556008)(26005)(66476007)(6506007)(66946007)(110136005)(5660300002)(41300700001)(6512007)(7406005)(8936002)(4744005)(2616005)(83380400001)(2906002)(186003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtqgAKkO5S8HlbFPx/6S69bg9T2c/+0pyhQHZjIBjPG/pABDS2HXgYryqx0Z?=
 =?us-ascii?Q?vlqWZRdmUrzEPUGgBP1QRRuLR5X6eFki/7PCfIjzzMlGkF3uDLtpsfyKZ4ia?=
 =?us-ascii?Q?WFSnkwLgIb9zqE0qSUFBk2GmFkCAyAh3nJsmxafNySemeTU1hrP8iBYRccpu?=
 =?us-ascii?Q?7A26ksTNac9Orzrt+P0GUjdFDYyuTeM4hyiVz5i5s41S0JG4rfJeNpLq8DSq?=
 =?us-ascii?Q?NJIeJ1mML8xYnD8poOvLc2EVPpgTdbc5WI+BSewWR8nN4QSMXhunzrPZWExH?=
 =?us-ascii?Q?RZO5ZAZVK6GRAyEHzZRVLVmxkIWR0cK7IwOLafDdzTSqXoF2XpqlcNHGC+a6?=
 =?us-ascii?Q?eABzt16VokohqYLiAhzV/CfgJPsw2swAuACoqXbUr1FrROLL5pmb1gMIKEYL?=
 =?us-ascii?Q?4r4dyejqrHZb5MnQqRYzLh/xSJd62jhMh/cVKF3hbuEWm8/zKm51QSwXXQ+D?=
 =?us-ascii?Q?zr38Ycmi63vwgQphSDWXNTlmx3lyq6oUmKWwBVnFl/SoaE6UllsFXL/KNYoi?=
 =?us-ascii?Q?8wZRd0m8m3K/hATsSmRDXkdztsNmW5HPIkMxdFvYBZWL+1ZRergcthvmLIvV?=
 =?us-ascii?Q?CSgplzMpZSdM7G+Ra7S4jkHPkJ+ozEKlNYGZbCc6fcN+maz1oB4DDgX+4yIZ?=
 =?us-ascii?Q?HNm88PtKetpBsCuGZtxJ0vQM6mjIC/vNy/oTDG+rLHIa6S0Fl5AdQ1/h/8xd?=
 =?us-ascii?Q?DVdIBhq3qF9X1vt+ZcXaRBT4DZmS2ckILTKS8Pku8TdGsBLRCcY++0hNIg0V?=
 =?us-ascii?Q?vAHR51xDUpwNPsSz4WdEfjyBirAFYBMhgBJ+T0jyGA1l0WVu8/6M1AXG6spm?=
 =?us-ascii?Q?+uqAvBNajWUJbeLtxS81OlUHzCOcx7HiAt6rjv7lkM95KmrNGQPz72OllSju?=
 =?us-ascii?Q?XDCx+0FAjIrNmqW9xpRNS4HdqzSDEEzuPTTina6t5/oSXPV6IK6Dc7T2Cg81?=
 =?us-ascii?Q?9dAf7gratvr1tBKQCCyCwlgHRTe42vduN9CV8uyS9VZCRchztXKi7uXYI1yZ?=
 =?us-ascii?Q?HxFaMzSQTCXs19T+T5TRHeWucnLOEob3urCAqkyI9Rqz6YIaAceaEcMq9Xwd?=
 =?us-ascii?Q?81X1y/u/jC60dBAi2yL7C4//l4rVlqpzm2L/byKet3+Ce38OEg4xmhA+bR2e?=
 =?us-ascii?Q?IMit4oYARk8Nm8BO/4znSy+MP/1m+AG5UjSIWZpmWVUY7b6O3jKuRV8MxGzT?=
 =?us-ascii?Q?Upcg9+/6tjr8Lt7Ilr6y0gAvDteKy4aMQFdEHQIaovy0TlHYd2PJk+14CGam?=
 =?us-ascii?Q?mbgp4ZL05S8y8QISXR+y5EpJnnR9VvWN2SAwkS/r7Iw1PQomHehTc6glquxv?=
 =?us-ascii?Q?2SJc5la+1MbtjeRIw+4ae8YcVM+Qf5JFAfDwu5AyWm3xX1cfqbm5fFttB4eL?=
 =?us-ascii?Q?10zYPIu0zM18Nfd6SAN+es8HLGXZ21hnwUFjnkhJaxSBs+3mOs7RiU3JlBb+?=
 =?us-ascii?Q?f+yMuKo0GepJ6a8SJdKwJmllXu3AaUfVW/29nIkwH0fxzpq8Ef7BKoTuaTJV?=
 =?us-ascii?Q?y7d0a6hpYwdVn7eeeld5ANCaystAtfZRpsbmBiGPjn04QbTaxMSvwnlEHDcF?=
 =?us-ascii?Q?rdFlxdRiaHS58AN57ow=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a964c2d0-2ae9-4c54-36df-08dab825594f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 14:12:58.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfqzGQx2EUtI4qjR5LlqU56GfSS/1i46hFtB/f0kQw0CRR1Hd2L6dvvVeDnore66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +	down_read(&ioas->iopt.iova_rwsem);
> +	info.flags = VFIO_IOMMU_INFO_PGSIZES;
> +	info.iova_pgsizes = iommufd_get_pagesizes(ioas);
> +	info.cap_offset = 0;

The iommufd_get_pagesizes() obtains the domains_rwsem and cannot be
called under the iova_rwsem due to lock odering.

The test suite already covers this, but it turns out my test
environment had lockdep disabled since it hits a Intel iommu lockdep
splat on boot starting in v6.1-rc1 :\ Syzkaller found it because it
runs the VM with different options and avoids the boot splat.

@@ -371,11 +371,11 @@ static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
        if (IS_ERR(ioas))
                return PTR_ERR(ioas);
 
-       down_read(&ioas->iopt.iova_rwsem);
        info.flags = VFIO_IOMMU_INFO_PGSIZES;
        info.iova_pgsizes = iommufd_get_pagesizes(ioas);
        info.cap_offset = 0;
 
+       down_read(&ioas->iopt.iova_rwsem);
        total_cap_size = sizeof(info);
        for (i = 0; i != ARRAY_SIZE(fill_fns); i++) {
                int cap_size;

Jason
