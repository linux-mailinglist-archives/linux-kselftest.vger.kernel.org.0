Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB4628929
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 20:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiKNTUF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 14:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNTUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 14:20:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048AF21260;
        Mon, 14 Nov 2022 11:20:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7Vs0kyQQozSab45YBxeJqJ9u1X7BdWj9VFm2ZLxoNPo+qB3aJuw0GddWyw3KpZmWpovs1BlCK/1S3b58qYBa6MGyVBwNY6gmaOjlNClLQhZkT/+uHr3rb+7Qy3ssYrBdlfH4RfrDcb6gJSKbcqhMfedN3jDqRcrrwQ+8wiiSYQtC8ra0ANIQ7jW9y8OExFzv1Ce+yrRm+Bzsz6S+bD/l/CtZgJ5/nFaU+ge2ZQbZNvs9wWBbkownGUx0NQiDfoGNrxheI8bvLPM8V1DMuNrL/K0L1VnBvcVRmfKDASZqOqddW0GWSjp/pe7wgfpdBezrIC37Aye2WYeqpjQKjwT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoZJ3wnMabn02B8hcF/u/273eif/EmrMqad0kxlu5II=;
 b=DNvuo1JJVjkQBImry5nO0fPjMpBOaepQKoG7D5hvBbVmuR+bMoMLNC7qBRqPCHx/fEWyrkMPTpU98mOjxUWlv+UfsFC68U0JvxAHtOTeKeaPU/TX2y4hSIJLg6EyRrasFBf7UdhlDhOLJyBNhONCZeyzMYKPVD2BwUg99NwQO9+aSzkdV/Dap8+zxfX9r+Fesvk2YffwJD+AX2gLCBAh+R8amE+CF7evaYb4J1v573xa0qFOLtrI340B6IDn+v67HI/D+t+Nl9JhwhXad7A/a534wGtphvZ9E+UU905RFCE27r0HT2kNEorLWlNVJ2LqaJsL5D19vBY3CuSiB5jfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoZJ3wnMabn02B8hcF/u/273eif/EmrMqad0kxlu5II=;
 b=ACzg/mS//Upm5C0Si3VyYNQDqq8T8A/76qgGUKnfCkhXK8vi3XsyhN597QkJfkkFL5rTcmlzixm4jr7zz9WOuME350enbH1Ld9Yt+K09b7lVQd7vlApcqaI4WBMA3tDRr5MqqXMibnKYAZbAGh3W+F2U9ceIiXN/cAYqM3RhZGjA/1VuB4zcRCy4Dt5r8ko/bWIlxBB75XmpB/seEYxCz/rRo3L5RVM6Cvw5YP5WYYyvMxFmyFoOPJ3huczFhlXsJqfG9e2mypgtQDegJkfHaDONYyl0PxBduFwQCj8Ao/MOzqUQkJyUOcv0LLNCGLS5xUb1R4S4UTwER+8qA6mr7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 14 Nov
 2022 19:20:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:20:00 +0000
Date:   Mon, 14 Nov 2022 15:19:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v4 8/17] iommufd: Algorithms for PFN storage
Message-ID: <Y3KU32D6BVuyz1Lz@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc0b717-357d-4d6f-4dab-08dac6753992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPenxn4h/j3wl/+xmS1lmmC9bobw5PxlNCuUaUN28FGPazMzoinIal+taqXKKtDEzkNAD4ZHRfPKtH960/J10uC3IMyWixMFf34sLy9JRKhkTaLy+5MsydzgYM1vRkQB/t8K6yIYkjLmuIdV6VJHTL5F7s7DAH7Po2sAVvOUGvPudoScxB/cif32F8jVtEV8WdwL6QmKmv5EfB3lLLZ2fbkHaDii3RXh0US63ggr5K9XC3Mfqj8/kru62B16yNv7PZHJmPP95P0Yhgm1bIxUgPSNgblv1oZecheXmekYSh7QiAnfVFnnfSPvDvklzDG1F4W5vU7lppeQKWBzZHORPpCGqUgluR+e0Jh46CwhB+yilfMDDF2wbn10ets3OV2UVTYa6rlUOkDzXNmav+BsLfblsKqXeEO++JX33U3C+Fx2lVZWXxcJPWEaco4ykzdwi0w26hGXBdjpvlRPowZrHltMBrpB4SGcKHNteVHLiSUOpQXM+ao4OyR4sjrbRCXlvJwxArlZhvb3qKhZkdrWWLMvJJZkRBcJtXAFTbMdOylwT4p3npWlVzDzxcZKdLvuVFpsV2yQcJi4d66QIQ04f6eC55SLFpmVEaxIVsLWSuEDx/+nRr0ZCxoVsDPqb1arwnqPhz125Q6WokKBVrzF9mZ0qD3ZGTA6XXEWgerZs5eM7eGZ49KdLNKwWlbarr+gQ6nScFgzBDIuk3X9aTtobwlLgh7dZhChKUV9lYIum4SAYt8AitSQgJmbCCrdCqxt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(86362001)(36756003)(5660300002)(186003)(8936002)(110136005)(2906002)(4744005)(7406005)(7416002)(83380400001)(38100700002)(921005)(2616005)(54906003)(4326008)(66476007)(66556008)(66946007)(8676002)(6486002)(478600001)(316002)(6506007)(41300700001)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?juSAq2URbg0adoPHif8W1a0CDPc3mcZa/WnxMuRJF1mZz9ikIG6A1OSjD9pJ?=
 =?us-ascii?Q?A8GXL6wgRo4TAAP1gGUu7APVr7RdZ/L0GRTDSlFgpKI1CFmrDd1E9sfrmYEY?=
 =?us-ascii?Q?o2SaHnnu2XpfDkivnwJ+X1BsmYLMnm+3vb2RE0baMFWygv1mbTUWuaFImhQb?=
 =?us-ascii?Q?uI3pjKr4By87wdDnE3uVaoTdabau0llpH5jRepIOhah36SgA1NcPnvdTFeHA?=
 =?us-ascii?Q?oUhXiJ+1BU4AR/Gv3jtG2HlmeL5v6dUKlV8PUXj7c39HuoHJk8KVNHtEARRJ?=
 =?us-ascii?Q?PA5eU7ghiAYb9VnpFryQsoIUEZm+Yvc0/hIiHpDuzZSu4ibGne1IDVYEoFEn?=
 =?us-ascii?Q?cTxxNtJX7chNHtsHkdXjQvtYSjE8vZ9ViFMn3GZuLv4Aya7OPr6yn3u92XhU?=
 =?us-ascii?Q?QZ9b+zv+kL8iU7FnwK0j7//fCO+SExoQrpi5yQNeClIT2goTNHzIB/wyIKGa?=
 =?us-ascii?Q?cVodS+BwdysPbQdKfGKQKmVNdfJiHYbmKDAhPZcfrlhUYWSoj9P725rZ99mk?=
 =?us-ascii?Q?FIMeaCS6Tv+bAbJtpZroyTZrngtsOb67d2s0/eTGyo/e1IEtIz7q9U3QGi0T?=
 =?us-ascii?Q?Rgfn+krx6m+GBEJh624q5EveqPFurc6QwNTDhJ0OCN0S+qJY+T+0+2Qbf2hh?=
 =?us-ascii?Q?THSaR9PEefVAX9zJZ8yaNZaUJWcoCQt6jQns6I6By4jQrW6eDj+SNVesNnTq?=
 =?us-ascii?Q?P5P6U3u3hQf5Zz0Ij6oabNZrMGRiaMMrRAter0wWaXPCS2TFLQ6h6NZaz5E+?=
 =?us-ascii?Q?6gNYKebkWQ/2IC6m9vvHhDCgh3X6a8p99QE3POBeuZw1iuR6Z1jjXODN+qWF?=
 =?us-ascii?Q?RlblvdzfE+TmJBys21sRNsznj9gyoej1T2TYqy6pyViFYtZ73LsB+YJeRmeh?=
 =?us-ascii?Q?XgaK7rCjcLiHCGm+1FV952k2pI4ID2HD0WAHBLf/L6c8q19g0451+MOlDEow?=
 =?us-ascii?Q?EofsKgdzMraFxDOUdH5SIM/GmtjUh0fb4BSLOdzmnUxbl13XEQRYyzG6fvm2?=
 =?us-ascii?Q?hecz0x9Q+BnH+DUWwPfDqu911s/d97WRtDHDSvy+YUxuZun1d3lOzfXepXW3?=
 =?us-ascii?Q?WvjvAxls6AzMjt6wJ9RX5T4n0vstqGtMFLH3+BGUf34hW/PRxMkvV7dOtZYq?=
 =?us-ascii?Q?qSvSg03m/6tfrC9o7hS1dVfOPvZA+mS/trtgofjNT6H6PXUxFKW6nofBK2Jw?=
 =?us-ascii?Q?f7f/3BOUE7yDtMuu49pU3dTbdfkgybropL32c4OxG1Rib7wgedMlhEeIH9cm?=
 =?us-ascii?Q?SgnDv9yQ/+gXOyIaqbpFHXE0S6xYh+iqzN5y4biIEoFYJv5un+lv+p/ZXABO?=
 =?us-ascii?Q?6YmeRnqT8BvL0TYtZ5Y28xH8nV42Ig59e3NM4NAmTtp/jHu0gK3GT2bCZP0q?=
 =?us-ascii?Q?jJhUWvYXmOXHm6xS7+nr3B78TGyi7iUGGQ0lpOArP24+lIPfJJJXiBr2/HRl?=
 =?us-ascii?Q?O/uZrAPPmm8g+aFbQgPfjgiK7niEcDSM/BnPsxMEyK+SJfIDV8l1CL0G4dry?=
 =?us-ascii?Q?w435FlBQQX657JunR0cnDCFG5DJRXgQrF1dXpGW/fHLH8GoDHi178d6XGG2c?=
 =?us-ascii?Q?2pKONOChEPbSQIt2MiQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc0b717-357d-4d6f-4dab-08dac6753992
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 19:20:00.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlcK9L6mFqiN7FzOStnvuwvsTEvXoCFX6vQCg/vSLgmoHbEb50it/O93Uq79ljgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 08:49:01PM -0400, Jason Gunthorpe wrote:

> +/*
> + * Each interval represents an active iopt_access_pages(), it acts as an
> + * interval lock that keeps the PFNs pinned and stored in the xarray.
> + */
> +struct iopt_pages_access {
> +	struct interval_tree_node node;
> +	refcount_t refcount;

I noticed this is never used unlocked, everything holds the
pages->mutex for the pages that holds the node in its itree

So this is just an unsigned int, we don't need that atomic.

Jason
