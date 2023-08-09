Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55DC776551
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjHIQpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHIQpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 12:45:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F41FD2;
        Wed,  9 Aug 2023 09:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyVEWcsQjM5b7rV0Bbl8p9oYbaWvA3i0xMM1kUJg2aNc+1h8KKZ1nkoD+EuIEbfG7gg/382jZKm6z3F8C+fGWU0xdd5ErZc/EBzLKtNlkJm/6Wxk9rG8UUrVWxLypeDycb0UoQ+2djUpdTbUkt66SMKgio/kBXHmgwzKEb7QAMdEQ/BM2NeTPwT4yDn4iiO/+NapI64qBxfHpG4XQs7toWocWa8w5z+kPK3KXf4MRfggla/FUiHpQSnLCN3T8ZTr+RVMICuQ7MTj47UDuwF0svBE2O6S9Ek0qwVZelpDL3iesYITRnWpjl7KPfHmG5JE7epCKbYvZCFtT0SSnpPFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxZozp1nhUVcgpCJEBM68/EQGkOv2qrwnS2UoeDTxwA=;
 b=ZumMAQh+8xQkLIaSfHLnRkQ2Eyd9BqbWo2DTDr4ohYCv7CGMVbg0CvDJ3ffu3ujrEWpCijljz/2hSy3wJZTDilpHjOUEloMBYPj1i11bZtRdl4X6ecbgKUnOhKiZe4PXNvElLc5LejI7u3sViDEFsyrkcdDKaEmYvY10NIMUNePV+qI6V3wdD42/RpVUglIvaaTsABOGfaGPhrJM+XP4K1CRCKbuKHxj+XW50Dq1EOq9hl/GYONrsbiV3+JxgQRCoPVKeR4rf5bhB3TY5gdkjIc7Rhh3Pz7DvW7nzzc8MRHNnO/ZvHsGvjdeBJ1NU/E/j6ELlDQRPn7bEwCR/8EI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxZozp1nhUVcgpCJEBM68/EQGkOv2qrwnS2UoeDTxwA=;
 b=T4x6kNNSMpIB0VWGriHLXDbQlVZ5ibOP/mLvegCnWJH/KBL13ku9l2aRbXszYSxEUY2tohFNPtsB4Hh93Qr8Qh9YDVFxXK8QVSNd/UM/+8TMf7+f1wTOVhOLXB4S6qHEupdERb50pRLtd+l4E0uPV6NydsGIzCRqWKFlxboyUFDNhF7sg+uDzw8V6pw/kxz3W4jyXvd/Kp5vdaIleA7/4o/Zudn42WSA5hyJY5hxae02ESuOW6lAqis9V2dkUqLwv87itgHnTF8jhWf1Q1qDkhD+oSmBp03pIUly4q5YvxsLLWEa8npelYrNmfUL+k3FkKJ6Bqpq60/5VG8Tz7FStQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 16:45:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:45:43 +0000
Date:   Wed, 9 Aug 2023 13:45:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v6 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Message-ID: <ZNPCtPTcHvITt6fk@nvidia.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808153510.4170-5-yi.l.liu@intel.com>
X-ClientProxiedBy: BY5PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: b6314e2b-53d8-4534-f243-08db98f81239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izzIonfL68biS8FFrPiWL6e9YeicOZ+pjihsXe53rr5e0SYHPFOirXLvEubei7gBnFtCyzLSdX/YnzZWxhzrApNBce+H9wbr/wbFT9I7+ffXin598n/TQbZjZvXeCBNf7kff4yBUGgVF1Cv0o9JLSBLDxKFLgUr8m/JP2JaJT00JgnP/AaG+94+POYCBx94a7JDTh+pusrOe30/5sSuXWiHFgHCIdrRZigRpjPg1NFy6dzc2VUoaBlyXRLQeipduztwbFGz3jr8+O5IVKZp/q0kjoLkoGV90u/hmkrL8PxhWn8q5qIdhAYYA+5ZQi8JSTnP1conNMddhJhXmeTWQXBrhJtJMfOrXOPGybwSjJ7IUXzFCmH4Mq+IOGveYRniWZ7GxsiLQ0SDpcuoLQnw7hAFA0TdL3ay5w6UOtp3c/OFdP86Ylcq/SbmG0GX895LqHkfkEKPDThzn2RTrOL6ZKIGQzSclZ/h+d1jAm/+NCCFX1m8XwQxZS6eaG/ZzgQ57UCpT9JnDOWo1rEpOS9BFc3xb5plmOWfOZOMCxTwxyuOeGI+EIYgBAsFn4FyE7DMN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(186006)(1800799006)(4326008)(6916009)(66556008)(86362001)(66476007)(36756003)(7416002)(8676002)(8936002)(4744005)(5660300002)(2906002)(316002)(66946007)(41300700001)(38100700002)(2616005)(6486002)(478600001)(6512007)(83380400001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlnMOEjR/0UzauwMeZdSbDGbZ96wwkyguPQklqqUcWZZvJCcXJ3xdrn9GCRJ?=
 =?us-ascii?Q?L3RhQ+oQNMj/6Ey2ldASTc8kJSrjS0LMUtg698OAY1IBSzU+PGPtIVSBHnxS?=
 =?us-ascii?Q?ySDdy1ZzQflvxKq0vJtzgGgWTfwXhrarmsfhiilUNUlxWkGSo7306JQvwH8D?=
 =?us-ascii?Q?avBRmD4Ir+AQ04vnWifVECctRw+9i76ZvAPXwEAgQf2hfG4FcLB7uC5/Y6So?=
 =?us-ascii?Q?H5uyafUYK4diVwpdo3CVpzPsk/lFl+2FQHnjRVEZjiNmkqeKuvwqIIyVBG6e?=
 =?us-ascii?Q?jUYp7Aw56fGGXZYQzo4/tRO0ysSMgV7B05dbZ5fkRq9O6dLlDyu86vJm+w1J?=
 =?us-ascii?Q?DfZ/ywXCKhASxfMpFLUGKAOEbSRoxFUXACApvuGehkjVH0+WQ7k2aOYMVqv+?=
 =?us-ascii?Q?WvH+SHtuEC4UsMEXo0n9WqaArSk4G+lmdsq8cbziVQLlsfENOEDSejalXGMb?=
 =?us-ascii?Q?m17yA5oh6i7oISmkUVxRvdSkny9rvzsfHLrwWAtOsC2NnU+TQMFg2exv/hnX?=
 =?us-ascii?Q?XvOvyUZJ3OGwpzdrJctpmZxSMPmrV1j2i96RlQOT111j+ahVVDGsDZieujxB?=
 =?us-ascii?Q?bkCfBb83VcNWjxfty9o1LBH0ru1TdWoWQRuGlwvk9MpJJQarxt1LdHkN5+Mr?=
 =?us-ascii?Q?6zyQmYGOCssgM2cgijRDSV6GulQhqgQcYrrnJ4hlVdT+CMjWvnN0FgYG8aVd?=
 =?us-ascii?Q?he0rATKtjVrnUAQ/2gPbC80Bk2dMbC9Fc5hYOol+SipSi1W7izm3/06JoIxl?=
 =?us-ascii?Q?xN6qByVQ3pfx6x56R9ABGZl+ea3PLbEuIjGDuwev41p2zjnAil0EkLEMhHY1?=
 =?us-ascii?Q?MRXyytythukIVWmq/w2jbsxUCCoezVnGE2aMBZb4YsegQna0M061xaIuEGuR?=
 =?us-ascii?Q?ywJMlgOcByPVUQqhf781/8xzjw3Cdyy6zQLZcROeQHgRTIVmWB/cVHDBBCk1?=
 =?us-ascii?Q?DahNnHmtBTvJ53wTjbAwNj9FykPzWRuGVbqVPYPLJSeyPDFzw9XMWyfcT89V?=
 =?us-ascii?Q?6FeKLwzXdhvlRkQpgr7tZjvBofbVDboNNpyeeIVmWbgmlGZRToijMnhYPBaA?=
 =?us-ascii?Q?MTKNlX7mfyyvo/UaFpDDEnB1BCoDwC2Q8Sn58oOncSgKYeeYsrF3USAGg+Px?=
 =?us-ascii?Q?Ur5CVETDF47R2lEmLmVrsjsQWLuvfsud5Zsfwegj42Kf6erxeGhWhTZBFBt3?=
 =?us-ascii?Q?yJs29vIR4kuWp3Owr9rgrnnFvXrMFVsZ7Y/AnuC5CC2H96WoAZh/Mkwr6xdN?=
 =?us-ascii?Q?N9VnJSMtES6V0ytVdp78Fi8iwt3J0QpRBxgTy2NvcXg5xPydcG7jW5ouJjwa?=
 =?us-ascii?Q?rI0dykcP96iLiHLHht597xQtuXbvEILSlXzBIpI240FvtEoCmDyEmNI5fucg?=
 =?us-ascii?Q?J6SRYUJV+rwXa2XS8t3I6CMw9gWmb/iESRUYv/GeUWBN/usMTSQoAMV51A/S?=
 =?us-ascii?Q?HXhOZhQP6XW8W8u9lAyJCl3CKinW5VH++7z5BltalQcYnvZklDVF0DYjOWhD?=
 =?us-ascii?Q?v1V6bOe+T+6pyhMLrV25dI58gW+RJatd/sAlPju2A/gvf3zLH9FnBmZY6SCd?=
 =?us-ascii?Q?FHCuJmLnIdEuQwHmfxKUH++UarT/kUpJ/GDs1Y9C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6314e2b-53d8-4534-f243-08db98f81239
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:45:43.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeWFG4Ae+p5zGdUkgfgTAENuFstPlAhJr/TWB6bSNRv/rbQp6p01Bi/zNpIU45Gv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 08:35:10AM -0700, Yi Liu wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add a mock_domain_hw_info function and an iommu_test_hw_info data
> structure. This allows to test the IOMMU_GET_HW_INFO ioctl passing
> the test_reg value for the mock_dev.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h          |  9 +++++++
>  drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++-
>  tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
>  4 files changed, 67 insertions(+), 1 deletion(-)

Don't forget to add it to fail_nth

Jason
