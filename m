Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22EF780036
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355462AbjHQVzx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355490AbjHQVzo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 17:55:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112626BE;
        Thu, 17 Aug 2023 14:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFAO8v1V4RXosIcSIYHDkLk5MqjEI0XKBA1s/v5zDFMjlQB6nHRdSPFwysQBAp+UbO0qQLMkSsc9Lflb8jW/BxN3X7HhZd2xfRePOz0sWIVxg5Ks3z6iOLlzMw0KRMg1BEfJyR8QA/Ekd3kUbmLNZ02uFTIs85ZcxyEVrhmwlL3YN8QzChYF44cZmi3hCaSI1o0r3uapCqANCMnM8pDV1/xW+5blU1Qv24wfF0isyQI9Qjn+PScQaYaiKWAsS1/EhxaljaWpaMkqrVzZlokvcTP8D15Z6q+IBOh+LZw74OejrBjMC+7h7/riQQ8Bn0iv6I6dwI4Wc0ZxS2W+NnNSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWn6MXLlLduHjbSiq6t70c0a612YIQzaPw7L9b6vT2Q=;
 b=kq0yEH+JBt8mpfmFpRmOuA+23MO98LwVdsSBzr/ztIngj6Jxej4kzE4fnQnBAEfz9HGoyeNSB10/tq2Nnkllml+o2MXtLahJV06/0bb2SzAhIuVXk0Fn/3O1AXJfdjmbEaPoNYih17rxpizIgbp9XQmoh76NZ5oPYK6HgzSVP1pj6whkONJclNJafZMmYM8TZRi05C5ZnhOacXLKpRfcZpQrCkkeohuVQ5wAWuX6+jFewb6VCMQFC9/IUI8sMRFdUdIx5Fkg2vmX7PZ2M2hI9P8PmhVtkzfbIEZrjZRY45vkQA4JNn9dBFNmKe8plYv/k9ZuvvnUFuF3v3grH2DvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWn6MXLlLduHjbSiq6t70c0a612YIQzaPw7L9b6vT2Q=;
 b=hwrkHjRp4k/Ce0AuDUaYFEewSPPbIKuvse6VqiuebVuXlg8HWwQuABRki4wB2w8bt+JSyPJ6TEWdwXa6KeN4QaeEQiDUtvVbPjTdaoppwAhI8L5ewBkjw0hkHT3+v5KH1u1JdshF1ok+hFg8XNNtJttNQ9v39v8jcatUZf0HJNkAxpbAz4vl7wBgBYUq0rph0QfpUHK1PkHJTy7YKXjLmQ2RgK+/zS8GBl8vrvh38fqZmMOHbb2YA6fJNU7xxUTLGg7l+wzPYJOVEdzqOVI+fYy1ly4NO1SAjCxm8JfjNTbV6jfEmlq6JdLz4AAuc9irzgmMNrrSXTKRwl7D5MzIPQ==
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 21:55:41 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::9b) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.19 via Frontend
 Transport; Thu, 17 Aug 2023 21:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 21:55:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 14:55:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 17 Aug 2023 14:55:29 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 14:55:28 -0700
Date:   Thu, 17 Aug 2023 14:55:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v8 2/5] iommu: Add new iommu op to get iommu hardware
 information
Message-ID: <ZN6XTwll2U7Zti2P@Asurada-Nvidia>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-3-yi.l.liu@intel.com>
 <BN9PR11MB52761250777AECADCF77D88F8C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761250777AECADCF77D88F8C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: a58e00fb-b3f3-4a2c-d17b-08db9f6cb2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYWDwp0WpV8gfdYDb5apYH6rxHR7/VzLVevEnZy1cZ+fnJxKmKlfOsV6FiVnpgMecK56XK3R9Vzv5pIB+r9NX1yOjqXHSni7kRAlZicDcLh5DWxsAuYw6dudZ6mypKJvKcw3h6w8FSGaedNFo1VhRuspzEmqBG4gNMrj7gRCr2wje3erKyo5yCsbdERLt/ol7B4tjeFIvTF+96fgD2wyeZoNiaaFIi1C1F3DqKmCuqX0PHMNaDVTTiG0ypo4ZKLIqHTuSyj3nFw0nyWiwMPc1ReuxXgz/3fuqiecZdXb81Aumu/7YgHgAY5g8v/vS/Xa/7+kpFa//DU5jedwBNyCGH/T2ONEP+kV92GPPZnRnHWk0/rOay1MdnWvkL97fnQQnxRxSbh6Pu4CGutSM/YlCSEjBziNqqAcPPcdWIUDu129bsZdsrQDi0iOuOyWugmG0Lm7Abn/gdrrE2RyZ6EvN47u0vgEQQaN4bQYP9OXbTJNTPNpEVwS8zBQPQJkVjcFIEGUB+28EJ9UE7ORPFpmLrJrm7hN5D4cYGT+EYbsqwB+9+Xb6chHvaTIXswA0tG3DpHg3eCQ0hLcFqfpN/HYAQN4sDvE+UNxNOAr6Cqa5qNY43imsw/U8gqJ/MCWDEQt+STI5psUqF/95JIhIc9HmgfPiQViN/vEe+ndh6PoFCppuWgVPIg8xhwvOqzvi9mzF/enB8DJANOLI9e686eSDgyDsgAGuCAVBEKaqhFNc7eLb8ktuyjwOZ+sij988F/m
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(33716001)(82740400003)(356005)(7636003)(40480700001)(55016003)(5660300002)(70586007)(478600001)(70206006)(54906003)(6916009)(316002)(26005)(9686003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(7416002)(83380400001)(426003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 21:55:40.6122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58e00fb-b3f3-4a2c-d17b-08db9f6cb2bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 07:24:44AM +0000, Tian, Kevin wrote:
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Wednesday, August 16, 2023 8:14 PM
> >
> > Different IOMMU hardware would have different hardware information. So
> > the
> > information reported differs as well. To let the external user understand
> > the difference. enum iommu_hw_info_type is defined. For the iommu
> 
> s/difference. enum/difference, enum/
> 
> > + * @hw_info: IOMMU hardware information. The type of the returned data
> > is
> > + *           marked by the output type of this op. Type is one of
> > + *           enum iommu_hw_info_type defined in
> > include/uapi/linux/iommufd.h.
> > + *           The drivers that support this op should define a unique type
> > + *           in include/uapi/linux/iommufd.h. The data buffer returned by this
> > + *           op is allocated in the IOMMU driver and the caller should free it
> > + *           after use. Return the data buffer if success, or ERR_PTR on
> > + *           failure.
> 
> simplified as:
> 
>  @hw_info: report iommu hardware information. The data buffer returned by
>            this op is allocated in the iommu driver and freed by the caller
>            after use. The information type is one of enum iommu_hw_info_type
>            defined in include/uapi/linux/iommufd.h.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Done. Thanks!
