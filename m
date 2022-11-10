Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370C26247A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 17:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiKJQym (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiKJQyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 11:54:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86A22296;
        Thu, 10 Nov 2022 08:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5lkpbdIhpnlkvDX5mStyX0fBlcn3d5LSVr8M+dxYBDpC0zThTHZwpOn/nSIZHNefnjtwiECiLThK/XjWfekHW/2jFIGzwoAEDkl4vljcNTU6nglOstIpzgwg1zfa1auVFLjRgPEJp86IvT3YOVj9yI5cKgVHGkQigxFPU3t3KzSaDcVfEqOYEtwITjNhAmAZoyP81sxse0MEPMKVbEMo0T4vSw2WI5AW8jXY+Am5R+veqXhunAdUzgCNYO5y2cwc5cG7DWwU8UNBosNxx6k4SwRTR+gvzY36DpAwOFPjo5J+hJP0NfRVApPJW2xW+jh1ymalrLOSX8BGfVyPDX5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrrZWZU6FbMwGAp0zUwc1YwU9yX3ebzjFEAhB6dLDHE=;
 b=S9t7EvQSgCQufGH7W+jG0PJ4FihKYt57ig626+NfZUdQV6acewqaQCAGlAlxgY8qBaiqQcj4Yek0pjhnIVd0IQjy6imeePrTHY3dLdfT4UMFdhZdtkPV5OcZDLiZblldd1O948YPQ1HZcKre7Rmh1pZ4umhga7bcTF8ZwfR1n7gxMPLjBy/1mBSYaGCRDJqKFdhQjtPOoEy/mmRWc1Dyea8KoThOyHOtdzXMaa1GA/ImqPIeI5knGFUiTlrmWLn+YvFz0jg/RumlGfzDZTxdShoMyNvXE9QBoA5bTJdxA8+9KN/2GXq6Ya7Ug+At9N5WnhKU0bXFH2MBaZ/wLotvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrrZWZU6FbMwGAp0zUwc1YwU9yX3ebzjFEAhB6dLDHE=;
 b=j9kJ236b1S8pdlZJppX8dmRIfnYC3nkbiTu5pftWJLXMNeoVazXUvACuzqiw6J3f9NYH9rKWeDXwq30VOtkE06NfgXPmUaWjhkdHOfDJ2isVDjWW26Hzm099lAuEc7gBlwpOYaBTZIptmDUcaTkXfWZH8D0vn0EU64ZoVMZzH7XlIBLywTtO1k6VM7kJ5ohma6rIZDO3unwfdTeawhzVTEee2pLzeLs9DjJBqv8+CoG+3pUFDW2DuzR+Km4+fBaLH38AylnHjJEzn2apIevwkE+ibt0xn///b7nokK/Xn+yFejSrOfLxm4fpgT6JH/2mCwag44fXJ3dl/FgjsgblWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 16:54:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 16:54:34 +0000
Date:   Thu, 10 Nov 2022 12:54:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org,
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
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y20syTS/BUzPdu/i@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me>
 <87v8nmhnkl.fsf@meer.lwn.net>
 <Y20QotPsxivvV53l@nvidia.com>
 <87r0yahmlg.fsf@meer.lwn.net>
 <Y20XhjH96k4x7qdx@nvidia.com>
 <87mt8yhlqr.fsf@meer.lwn.net>
 <Y20Y9Jlp3vG8x27a@nvidia.com>
 <87iljmhknj.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iljmhknj.fsf@meer.lwn.net>
X-ClientProxiedBy: BL0PR02CA0103.namprd02.prod.outlook.com
 (2603:10b6:208:51::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 360eb242-d9e6-436c-f0c0-08dac33c3e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwxmx1iXsZM2P9JOzKyKtzHaybCdg4a23beaDXgfhbOe59qIlSy47xFt10c38aM7Rqnrh4c3g3Er5Nn1BUVCpB0FED8Dw5Er3Py1pJrUM5IzZjo1eRt+v5YcZcl6AiMVy6LzX78jiO9ghZ9pmzBfbtFAs/h1Nhic9JI6Wyv0XoFpZpzSacqnpC1kq0D6j1RyRtJebrYmTT4l20ytFM3CKsA3tBfPNS9apCme3E8ILhUqABXFDcef+9KrEkU/9/YzY0Z9BX8p+WhqGA6qC4jn8PBdShY63DKXKk8S6KMPCV0sDF3+YNwpMWRNWZL8vaGhbMvO9FXm93ALu/hQcSRUSNjVdr1Cy7VHadwLCFu4Ukjefqle1nQa2uElm+H+K8az3rYhbC3dN/5vrWiWe7YeEi9Em1jCg03YKnN9aHe/1qEt4kZfzNAhNVi3Dq79sZVdJxfV01TO1Bg/1q8hUp17UqtX36i5lDWbgPWino/s7b3eJpV2XJveMDfbulP9wji6EPQtDImq4dDii9l5KBZAEiJbdqYaVvLvdn+A/cndcH53uEBboHnbC2J2xL+myq75ngKQAUKZORhCrhvIZDVh76fR6TyGwTwmbHIH40XcDk8B8Egz7Ux/hCN9Me3cLOsTEgFifu0qJMF97b+vPQkQjcFUMwH0fCd/KGjvevRf2p4FCfdo3nBFiRPyU0Idbwse
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(316002)(6916009)(54906003)(2616005)(41300700001)(4744005)(5660300002)(7406005)(186003)(7416002)(86362001)(2906002)(6506007)(66476007)(66556008)(66946007)(4326008)(6512007)(8676002)(26005)(36756003)(8936002)(478600001)(6486002)(66899015)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdKpjsLOzgrJweAdI8yhSjX6izTEQjJlPgMw32X9prbwsgM2BbeSyKFPNmpI?=
 =?us-ascii?Q?OoNUuRqqIaMyzSnCHnkePegLZN4yii+lLYZWRS0uQ8dNovy9ya7d42cx5tlT?=
 =?us-ascii?Q?66RBK7LPIUPuPR115yZYz2pVyrfDdcS3DWZfOQzngGFA0wLBBG2f3lXYGgNr?=
 =?us-ascii?Q?2aiMXuXxgqL8i2kW9q4GcfFG596CN4YhzUqCWZ3V7T54sUEqw2kD85X+NSKT?=
 =?us-ascii?Q?OX+oZrYn1YSqx74x97xy30CJBDM8E3VzFFdY+QN0wIVAIUuKiUqhnx+qxC/J?=
 =?us-ascii?Q?NVMXYFFQwMxSHvlqWOUB/I1oWA8W/vWZWLC8RNNX3pBDBGDZMa/VUB3MXP+k?=
 =?us-ascii?Q?MHDavhd+AhbMjVor0cESTmu9YcJN9tWgbON0ESNPFosTMeFnoTNe/wzMFoiD?=
 =?us-ascii?Q?GODykfpfEEx0LsffMpnA8Wn0SXTAfLYV8y3LYjyh4PFiqQDzXl6vuf/CQiN/?=
 =?us-ascii?Q?R65Acm8C8NbpxhFjNd1H5kCKywHxekyoa+js1pNy8/wA0JyAGOkJ34SOMNp+?=
 =?us-ascii?Q?dJQxYviG0hsNPTg6InkotTDTobx2+0cRk7xPCJJV52dhGQNUEQyyl/b8CZUj?=
 =?us-ascii?Q?Qs8P0AKey6e99xyD4D5NImRcoAN/YrflMYV31iTZKpe8xxXqgBJ7vehYJgF2?=
 =?us-ascii?Q?/cB3yRfecBvsFDhK5u10EYlpvH/UXWXV6G1b5VAAbBy8HsVt83ZHhSaKQCVh?=
 =?us-ascii?Q?DXP4e8i9eO9A6+jBuTd2mBL8zdZZFnLwsYuj52r1aN4do7paMMhmyFCFucmN?=
 =?us-ascii?Q?yVc4CDAamOjESTEKbUEs30FlEw2SkYtmwfBCKQ5FPOsff9ERLllRnlD0oM0I?=
 =?us-ascii?Q?oJi0PV1KckleHBdPciEThdyRlLo3Q00d7jXmCOgYiYSRN503cQQr+w9y4hn1?=
 =?us-ascii?Q?Y4ibFewGTYPEqyWuVm80EMNMl5Ghm3Lu3dg5ifesFPbZX+gvCSHLnUjnCQMF?=
 =?us-ascii?Q?B1uealH4znnJTf5MDgNSgS27yV7ZB4KoMIhCX6AojkFhV0HIFYPmHx7g/826?=
 =?us-ascii?Q?WSzSyThQN1WEWiBUDle32w+NkeXaCPKisl8I9D5YbP4Y69636Vr0TLmIY+2X?=
 =?us-ascii?Q?wcJ1oF/TACfzv/PE2gD3c1qNbii16iA51o8BmJZ7WZSqLvt73K1lef/edlUy?=
 =?us-ascii?Q?3zv7QNJ2shGTFh23SVgZGzN3WKqgQquew/1qeKbCxqQxE0/s8xkIXaghyyQm?=
 =?us-ascii?Q?oHS9avFEW6DRehuelzPrjLBVR+0/y2HuAOFzeWKKtTlpgb8cNkjOg3evl92l?=
 =?us-ascii?Q?qvPDSis2TZqQuILy5uhv5UhA+ao3yr+EjoyidAEHLI/JHSXqTV9olULhG2Tv?=
 =?us-ascii?Q?u4ptBkUzmWaR96KEbcw4CAqRMCM+jDsvQ6XddqIp9Kwc6E2ypOuyrzSZ7AX6?=
 =?us-ascii?Q?njff+qt6gTzUr6j4gzNEsNNE9drl2QLDZ/qj2PD42AYHG5Hd/BjkPI3NPFru?=
 =?us-ascii?Q?XEYyFJ7ZSoLyNNqFQsSwMfWliEi04Uzdp8KmcygX5hnbZK6GGa9GvGhB8Ahi?=
 =?us-ascii?Q?dYU2lOYKePzYz395wURR2OPaariEPEpzwG0dsUtJu0kj7sJR1g61C8kcg6aS?=
 =?us-ascii?Q?iTHaa+cI4jykR4SkaVc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360eb242-d9e6-436c-f0c0-08dac33c3e81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 16:54:34.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCTv8Tm8aHz7unUKyCYXkIPepOdo94/TOH35QO4mAEnbTgb/xjiTNVXGr4RtDY46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 10, 2022 at 08:52:16AM -0700, Jonathan Corbet wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> >> Single is nicer but it's not worth a great deal of angst; nothing we do
> >> is going to turn kernel-doc into a thing of beauty :)
> >
> > I will leave it be then because it is a bit tricky to tell if the new
> > regex breaks anything, and the first three attempts to create it
> > didn't work at all...
> 
> That's fine.  If you want to keep it as part of your series feel free to
> add:
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks, I'll keep it together since nothing else needs this right now

Jason
