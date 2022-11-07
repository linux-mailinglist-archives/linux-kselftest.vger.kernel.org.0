Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0A61F5FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 15:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiKGO27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 09:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiKGO2i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 09:28:38 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA11C911;
        Mon,  7 Nov 2022 06:23:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQghGN0947YBpU9wPDzUa6d0BhySGeI37hM7wOSz5iCk6PSEhW7BNIK6J9HuzPnOuc28/4HaBB/7kEo4uT+SbumM4+0Tw4VLcdH+9Li4y/46FggbtQMJmzvRgJoclA30ce8t0xMQ/a2vh01d7+F8epTozBIWkuVk37604+0yaGu1jCFjoFyoK+Kn3wZURq7Fhz3H6WDRtHJzhQWVMFgiItmXBAFuFSX7D8nyiT5wgzemzrjOdKlOhVcdzXesDKSNGtU0Yo4TRri3s4kM6Qs0jvk9A71hpy3MSlQetFNZvF0bAYBG9jaDfkLcOunTlLLnBt9kqQa8RTfCT4iZlwe8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iieIGrB8POddMmXi7tlqRy2ObyL/nStOwlal7Ch2mM0=;
 b=Md8Cn6VQzSjUYal2Ttet6/D2vYnC33ZQlZyYCsJjNv01XCDKhhjKSouVFEtHewBggMWRBX/4L5V3IaPtRjadgZXte4orDD7mKl8xQR68OJpdUtvJUeLSDNKNZ9SW47ckuozp3H3eXMUptfqIRc7AJXUoSOu09ZkQYjl/pez9DJG8bZWhXFVW4KGmDnJcngqQA0L1/Lypd7BUpAnILt8DFl8gUhQ61FIZnOSFanmWfAfx5QDdHI89PWSw3ex3FQq09tcrE1debm2Gm4Um14sVNZTq7twKeFrcEx+x5sUVVgQes0Dh88EnyZ2TXsP1N/YI46pt2ynOzqxInvWB4PiFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iieIGrB8POddMmXi7tlqRy2ObyL/nStOwlal7Ch2mM0=;
 b=IqhqBJiClJRjFnLsEdBlOaBCgFsQximMPeWvDIQRFaNmzxQnyX/J6k/uyEGjpfXeWh1PhZVWbHOiM5MNQFaSAHsDwU0Rw35FDhHmRRDtooTz+Q3Cf1yvPWEe4s5MiSUSG0v5u6M8c5x2Bi9JJT0LlkvsRsdEtoe3evec+z5lbiREbN7VA1WXKmMubJIjeIyU+0hJ/43d3mqpxs29XDjRr3rkbXPwxq7NC5bYqKMV9Et50sBVHLBnPbqfH+aidoh+flAiaesNN1vzZUBAkTAISsWnx7XsJlro61XJ01DfMU2onVa2J5JrFPmnayRYYObliMvGJ20xl70wmx6Udxdg7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:23:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:23:43 +0000
Date:   Mon, 7 Nov 2022 10:23:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <Y2kU7SCtOntzSfMh@nvidia.com>
References: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <2d2b467b-da07-2b96-27c9-569b727dd8c9@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2b467b-da07-2b96-27c9-569b727dd8c9@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfc9a2d-22e6-476f-e0e6-08dac0cbac43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWIUxur0ZUhukr3nn+1bCF32L1j5TbTRfHMALo8ZQ8jWEk88TpYUThAM/vd5Z46HJmPoFy0/D55v50ieSGIOApjm3qPvOIvdcuMB4A7lq5D4TIDBkjxX/Skd7N/WNTVbZyNyUdpNnXyhfIO5cHsSUOqTC1TXjShmW4ce3LCVHZn+I9B69j4PG8N3U3Yt+pL/TMuCXBZdC2D8O+NoShzkfGjQwZ3LamQFqHsGpUkg6lGTE7ngw4pvcFokTo9LlX1gb3ZKMJma85bLRSKQdO6/6a6/q5WggL+wz3WtMBfYYxyEtXdM2xCpIHhsHKearw+Z+pHiHwlYdnTNl8QBp8V/UIWQv76cG0Cn277f4XCJr7GIwDD5BV0dF+JVRAwA5MsYUSZ/JJW1xplqrhOQfJymLx7sNDwOiaAwBJXPsDjuoGHZSvc2X7VVtjWT3XUn81Gf1jKU6r/5fIzOeLujXf76iggdHuOpgZZc+/fqgpfaYE83GafzaSRsTWP7mqBNzXSo4BGQxkSKe5k3wACZTTWjTBzRYSdVQXkfGQb/stlNiLHJtvFF1S15Kx/pmKwzo5qCh9sei1MJlL0G0h7ObDL80u/aijVQVdLJw4YuPGnXx6RrkldfvWV+EXoj6BIbUvTEYMq102xgDFhgZ69p7pGFdWW4Psl0TQycOP0/Yqhk/TKmR+BonnRSBMfZi9mkbFNlib0gnULaEe9WrI+GmJacrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36756003)(86362001)(2616005)(83380400001)(4744005)(2906002)(6512007)(6506007)(186003)(38100700002)(26005)(66476007)(66556008)(66946007)(8676002)(4326008)(7406005)(6916009)(54906003)(478600001)(316002)(7416002)(8936002)(6486002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBt9C94LodtP2pukomrd+aTCUhZFRUMd5e6xe4Ywnrupa+tEupfYwHfxFSlM?=
 =?us-ascii?Q?bGcAw8o9IKR0+3zjN6K5+xyyOSskyXcqDkZULepyK1O7ll3pGHRX+PQyeGz5?=
 =?us-ascii?Q?5hxn5q2bfxXKAn/jtVl4Gpz5UwDfUEK6DnDxtXKYoUn1Qt9VkaP970DXfyHM?=
 =?us-ascii?Q?1IPvkLFTnZusCdb7m2O7+WVfaEnLu+EePBcCm3MLfzgB+Db3kT8M3di3w0Q1?=
 =?us-ascii?Q?cwvWtZQGDXChouVm7gsykWO4wj195axSzwLAFnj+7nF2cr5MSzCILMH+/Lfz?=
 =?us-ascii?Q?xJDmU0WnUynBlJRZeUQFdjrPjgE5573zmzB0PKw/eGZgAjSxKWER480KhLq/?=
 =?us-ascii?Q?VR/pB2EBLIU54NGDhU/TkjhIUZS4Y4HtPEwaieVWJ1vXaNgdxm3TgU0e8fLF?=
 =?us-ascii?Q?aqu0dhtgYBlsDx2xB3FttyHEerBsukLRebclwS5hh1meRVA5QJ+Dy4FliB//?=
 =?us-ascii?Q?3VT/TWopFKqkz7tVbGsrQUg6CInrPNY31gxxOaY0lAl0ELSZCPSeOGZe4v94?=
 =?us-ascii?Q?JDnYbSwYUbUgmQUfW6UfL+5gRSHx3tc1AyC0qlUqXtGpceWlMNqbIDazT06S?=
 =?us-ascii?Q?a/IVzOx36SGVPRP7VH8TGajFvzb8kgtLdZBtZOe9TUP+zYMywZinr0HnsRiG?=
 =?us-ascii?Q?TdSOd6HSIh/ZtI6rRGW2tMZxHVMci0bkp7WRd2aGhplGIlhZLmOEfSF17G82?=
 =?us-ascii?Q?HkZUnPqtgfH9LKZm8615FkI0fdmGD7Fb5NfigCBTmtyLJUESBCBC7lCMVKl2?=
 =?us-ascii?Q?biIyxVGnFO2L7Vi2uHaAw15UTzfdWfbCF+mB3DpDWkE5RvSz8/Y75mVv0LLT?=
 =?us-ascii?Q?4bWMvCV2Px7Ust452o1aRB8AjHDGhqNX9zOU3l1ocgTtm0UmxjfDT0I5OEI5?=
 =?us-ascii?Q?A5bcQt81c3WbbabLjLE5OxLRp1UtohpFbFZJTREeWXNgNsYrZMN4UcOPxJgq?=
 =?us-ascii?Q?vIVqtRz6b6I4FLUEOtPzrKN20xK+7t+GXRIdZLQiDQX//up/Cz7Z692hJolR?=
 =?us-ascii?Q?2WG1ckOfsxTSl5+hugrE1gXcj2gJwsDMJ7V/1LgLqej8KdDeiker+0T46BoK?=
 =?us-ascii?Q?mrpNrlSLAqkM5RZESDTbyYHgbLtvUMDyW3Jlpzbiwo9TPM5huZBo6SSfcVAz?=
 =?us-ascii?Q?/5eOturc9aKpam07o9wC+jbMyBdRdrFsTjJFmRp/urANp190/OaNn/kj3qYL?=
 =?us-ascii?Q?3VushSp2hIXXlDR8rGS4Vi4ytQDFuYxYVrfmtoiIKR+CalDseEPS9NJduOgp?=
 =?us-ascii?Q?g8IVWV3DxLwwqs4zE2Mp+90Ro53hiYeq5D8S+0XpYZMKkB9nFaGLRGgN9NkI?=
 =?us-ascii?Q?ylmuR96Az7u3tQvM5QgbXE2Qvcl9JX6KLG0bI0xE72xef+kizBOT5y51SY2D?=
 =?us-ascii?Q?/wbKnQgaHEJh16njTfgc1UsFL5zWl3+KcAQgDsKD8b4iS4yjcaFJ1W8wPza6?=
 =?us-ascii?Q?YpplDkng9Pz80eo3OPZy9/zpah0mxigtjcoAfBFF9y5Ew1azLGCvdXCG9Jvq?=
 =?us-ascii?Q?eDJkzRR7TNThY4nuziYXk+i7/VwJaGdMuEPgQtfwcdrL1TF+Zaj6mjIcMGIY?=
 =?us-ascii?Q?pXHk9L2r3qm6kM5Fyso=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfc9a2d-22e6-476f-e0e6-08dac0cbac43
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:23:43.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M77OoOxg2cPGZPDY/fVw1EyLcChnQWDcW0x0PR7dDPWrXGn85usoEbA49YF4z2JW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 05, 2022 at 08:07:24AM +0800, Baolu Lu wrote:

> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iommu/iommufd/vfio_compat.c:294:17: sparse: sparse: cast removes
> address space '__user' of expression
> 
> vim +/__user +294 drivers/iommu/iommufd/vfio_compat.c
> 
>    288	
>    289	static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
>    290					 struct vfio_info_cap_header __user *cur,
>    291					 size_t avail)
>    292	{
>    293		struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
>  > 294			container_of(cur,
>    295				     struct vfio_iommu_type1_info_cap_iova_range __user,
>    296				     header);

I think this is correct as-written. Sparse is flagging the casting
inside container_of. I don't think ti is worth trying to fix

Jason
