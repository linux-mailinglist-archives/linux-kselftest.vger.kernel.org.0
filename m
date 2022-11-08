Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1816210E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 13:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiKHMh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 07:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKHMh0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 07:37:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5012A9D;
        Tue,  8 Nov 2022 04:37:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkBLEpZvAMdDgdD99Aj0JEyZ70258zCryRcY5MY9Ip2ovvx3ob9QryA1BY6476WAvjt+UsItq3MbVh0uWiS84DM+La6mMLXBEuJysFF29C1L2dhWJXBRdUBejJXrs4h0me6YFd5vPDMz7O1H7lcfNCeOoVILgF+g0J6h6JTDa0SE+nb/cUMpMJNffx4CNOXY5vQ+HWf9T2r6x5Oz7IL+uITUKV/RM7iskEz3GDmHasN4pfFKxYJL0NsZgYOj0msRjmftXxanzaN0v9tMW/JCTkjG0ZHc8DUoxNDeJAKTzfzGABRJVczyTDSJP9R4+5etolyB19v/VEdUcAK8tU3Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmLbqIV1CGl8w3/jy6oWcVavbFxikL7gMwI8DoORtis=;
 b=hnrMzDK7HT37bA1eHNY6HkGilGlprUZ/VKMSDx6eS83RCBDCpL2IXPKJ+nlN69Km8i4wkfE8qZDyGhH/zKJJvb3v0ShMCXDYpUU13/S/QLoqCx0zhSIR+ej+d+rw/YHVl/kU3/Whv9OeQoJfKFplzc/kEHDIClGe5X5eeCx7BlZv1dKm79ChF85J6mhdCZoUQ6JNzCQOzOSlFMX2wibM6iVdTr1MgnGpupBn7EzFxP+1v5w0RDwo6FIZCTcX8VWXHZDmB1SnHuadYCSIm2U6Fe5d4+iKmhwhCzN+1Y99WvhK17Cra4lLXHTML13vQu+vUxIWe1/RBWprx6r6UNHFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmLbqIV1CGl8w3/jy6oWcVavbFxikL7gMwI8DoORtis=;
 b=fxqA3Wxn/7GR1EP2N9rawrS6jxGg02xor77yMZOtbvkvkqsoQzU62Q76nilJmCvbQzoJkB30A6Uv/bFxJv76w/LQSW88J0TutGTI77HTVjSwC78H1nxwE5sNbcEtOzcA8gN5mwptKh9vYoJPqLa41q3+CiJ9G5dyp1gLWjFIIoOGtLqk2HkOjt7Xcy6/mUlA936xIEhe9pMR46k90l0qhwnqsrHfDXnxKGEew88/BaG7CJ5NT9VSO7rPxOJu7Dqp9446nhkoZIAa3rxzSEe2GGDbe14ISXELlX9TQ0O22W0wHvk9RqXbwXULpLHnIOudtD2MkgANalMCz4XKHRFLrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 12:37:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 12:37:23 +0000
Date:   Tue, 8 Nov 2022 08:37:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
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
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 16/17] iommufd: Add some fault injection points
Message-ID: <Y2pNga51NQEJA4CW@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <16-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2oEZgY6UmIDb4RP@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2oEZgY6UmIDb4RP@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR1501CA0004.namprd15.prod.outlook.com
 (2603:10b6:207:17::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: fed8e5bd-aade-43b7-1d26-08dac185fbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmef1JZ7RKRTXiSYh6jJ5humiwSeNrGI7ZPqKETFFKMlraZNIk1mLbZGbilXV99NiFMH+JGQk983Npfe+NQ9fbFe17oGYP1lW7tk2GpRxglbf53Ny73zKn77sLb/PXdndHFHQqMIwfw00sz5xUVmg4dOIUrM7SSX8CbnPsOvnonnz6fGpV0VmCpskNbRKU8XLHIAgHnV+jDnOChbhRvCT8RatIdGbXwz8rytopuSCdrbaDnuJZG7f0TKOKuW+xjCaKY4Rul8vhHG+RcLMGbQssOzssOJnM+ysyp+sjEw93PqPRwxs5JtRo7u0DHV/m73ucT+20kRgZGFkzfRP0EJvUENN6hEocltF+0KdypPJ3GkkO2n4d6X+82DVG3Ol5eP/fOmlsRxdGi03x3Y5jptBvxSG9SAIeyjEMBGiQ0JI7wzNewfio+HGGSCqZtPXyFEqy+gmo9mHlk+/YjqkmQa/hVB8gZZAYgyEf/YTsIjssoyuJkPRI1k2SRiOcbxng12MX9nID8atw3OVOXxTKtv2iF8lbFMXGaLbZYpC8bNZ4UC5x6IyKF5ZDcESImdm3tRzr73AbnH2/qCd9QbBRzNANx4pcPHpt1k7I/Oku1SiY7i2CHp+KeT93I62wQ1QeyxBcd8+/acMDUr+HV5BTR3ELMgDl3vEeNNBPRQ2ert1qHUmaQoTN5YkF44tu6DNAjI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(83380400001)(2906002)(66946007)(36756003)(66556008)(4326008)(8676002)(66476007)(41300700001)(86362001)(316002)(54906003)(6636002)(37006003)(38100700002)(6862004)(2616005)(6512007)(7406005)(7416002)(5660300002)(8936002)(26005)(4744005)(186003)(6506007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DTF7+0+qUlseOE2+cmzYpXa+c0XGAvyX4uH+VfYMBr0IKkTCtIFFYmC0Xu8?=
 =?us-ascii?Q?zXvMGCaWh1ZBHsayzoK/P7V+K7V1ulmt6qIp68XpUzKY0+7rZCnJhzkLSBux?=
 =?us-ascii?Q?VGLcrLpW/AWRhE9Z8iX7lso5o3MtV7bwKLSVle7WE9eLW42GU/Y12Am9lAlH?=
 =?us-ascii?Q?VDLS8lcmbnQQhakIeM2ur/dROzbXN33ODv8tUGDRba4PT17C4aQj5nDsJetJ?=
 =?us-ascii?Q?LtsCjBJ0oqqXcIKOAfO0nLZvEa5gmCFkNQQ2KRAQC17ckJrZInDGqIqwi9NJ?=
 =?us-ascii?Q?YgxXjEuggrT5xYQeBDaOX/TX5b1Y8Um4F0jJyhgNWB1ckcD0Sffh4vlV6MLV?=
 =?us-ascii?Q?Fr47iUvSBuBFA+W1Mw1R+2CNe3eNSnH35Jce18cmhaiPkkYqzFNPxH8yp54g?=
 =?us-ascii?Q?ZknbFX8XyEDIB7M04kxkZMEpIvPZhd+zrJzhB7yxHsKONjf3tJMLUeZhmHUs?=
 =?us-ascii?Q?O/ByocuO38d8GwXz4VinR10gE5BjSj4T9NPNyEp6nzrgDx8mWw4nyPTb05M/?=
 =?us-ascii?Q?lVch4IbWJ/52kKSbNXAToK4P0KDxzgC/cvCIn3If8Aoqro3cb9ueFlZp07kl?=
 =?us-ascii?Q?e9KBf8gaBMD8KEkYVvEftISoATOOU8ff/t6c1fC0fDUgRT8sadvNMss7bvgU?=
 =?us-ascii?Q?Vr6AB+wCYY5hzLPXPCe4ZflZ/bUxtn/MwtVmO6911fphi6W9Ra9t876vaE0l?=
 =?us-ascii?Q?L/K7RZHDxcE8V/AvZT/cImiupkiDkwf/Cs3zsAcoif+mEj8PF23J9rqdiEAq?=
 =?us-ascii?Q?EyLuZlOQtx05mEB2TtjGVrsP9lLTNBk67QCWB8CNhTCTWkJS5Z2WUWxA2ctY?=
 =?us-ascii?Q?MoW1vv2x/ynnWos/CuEzXqYpA+80F+iTnHS7LfnLbVou3EEew6Ypk10b23l+?=
 =?us-ascii?Q?G0/cfxnZhnu4hNjNK7g2KQeFgszoc7TQVZF1d8T9OJnwoPWpu5acd8ZncPDr?=
 =?us-ascii?Q?O1SMYViL20flXbysSO8ecLPihy/6bZxdWy3oUZQf95znMej3tEJegzlwRlaD?=
 =?us-ascii?Q?TSeudfC7sWJYTxzWohgRdAbS+9my50fIMM4qCvxNShzhJAvjmljKyf5GiRc8?=
 =?us-ascii?Q?uV55L32cadrDozqTpofdvnhk7KeFIAbc41bDecpxjyRJDcIV1tJvZD2U2qkD?=
 =?us-ascii?Q?DjlhbUsVR+sNWsR9NvtSv9IMSfKtCOKKMDHXkXVjD8rIZXOoFsVsz/UTDHJQ?=
 =?us-ascii?Q?oOGQEtE6IHptZC6oaOpNU9qRiqdezPtrwsZyfC3rQZRVjsZiDyKWdv5+a9Py?=
 =?us-ascii?Q?Zq79k/kHhlQG7P3XLYJxtZ8s+uLxzMx5+BOlCdFzulSkkyszuk8PBlt0hkWo?=
 =?us-ascii?Q?he6KdtKiCigaBWiDjkeEQfVTzi86MsU0ap6pMPpUNkJXaAf6+pQJ7UU6Vsgw?=
 =?us-ascii?Q?sadgkqK90CJfe1eo3Qk/sc9cWpcpzovv3C9PfNJenEDiYxepG8wMqmwnYeLm?=
 =?us-ascii?Q?AHEVKIRavPuhnJ1VazNAJ8i7I38LGzhP95BVe98bIziON5Syap5MctUAZIO1?=
 =?us-ascii?Q?v1ZW/xxwo3FbHcpl8gv8dm9x+LmFU00rrw6FxJbPXEx35dMX6lMi4mQ+nyPr?=
 =?us-ascii?Q?RCf1giB0QxArF2Ix5yw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed8e5bd-aade-43b7-1d26-08dac185fbfe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 12:37:23.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB8O39n4oZErTpMQNFniXRPTnetQmaiOiRvfa39aG0vKa9pws4rph61+xumsMyFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 11:25:26PM -0800, Nicolin Chen wrote:
> On Mon, Nov 07, 2022 at 08:49:09PM -0400, Jason Gunthorpe wrote:
>  
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> 
> > @@ -489,6 +494,15 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
> >  
> >  		xas_lock(&xas);
> >  		while (pages != end_pages) {
> > +			/* xarray does not participate in fault injection */
> > +			if (pages == half_pages && iommufd_should_fail()) {
> > +				xas_set_err(&xas, -EINVAL);
> > +				xas_unlock(&xas);
> > +				/* aka xas_destroy() */
> > +				xas_nomem(&xas, GFP_KERNEL);
> > +				goto err_clear;
> 
> Coverity reports an "unchecked return value" at xas_nomem()...
> 
> > +err_clear:
> >  	if (xas_error(&xas)) {
> 
> ...yet, I think we should be fine since we do xas_error here?

Yes, in this flow xas_nomem() always returns false and there is no
reason to check it. Just Coverity noise

Jason
