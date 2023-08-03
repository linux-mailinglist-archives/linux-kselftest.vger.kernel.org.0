Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0C76DCEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 02:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHCAyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 20:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHCAyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 20:54:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A02D5A;
        Wed,  2 Aug 2023 17:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATGjOkVqm3rQTLCinS2t6QmyRhBwnzPmzqiwdU/QpsA5LYkIjGEWm2cpUEZKL7pYytaSfJXWMVO3epFboQKelsYz9vwEyK7NQ24saI20SpjhIWK/OJHE/yAYANeH/yfejcDRr081pl6I/gBsFlQ69w5p7oMrOMDeW/hwZe352hvoUTCYXXZTrgchvcQBBxO6T93hAot+RqRGFfHPyyf4SAjR600VldbfLGthG+sorbFmTkP9ZintGhAzsJx1XUuG7bQA/0LMQDAH4T2OVQ0inISm0s1DchrgLXTy2jVv7HVIvFu8hZYtObozpop7nWLhFzxaaQ7iLlw+fG0kp0H89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9P3W9cEqFBnuh7ZdWHim6sI1BI16haLklkmsLBX9z0=;
 b=ipRUZSVy/LZxV7Ub/RslfDONHhbYi1bDizRr6Kg023d6VrCWAyngzwdwc0Xna1PLL70DJk+b1ZAqqaGE5msgkVJ1lmRzQE7eqvIbtROGfMrf2m03KmxAbWod+sRT1sm9Lwp1ZbSUbjPV4UZbwnlZ5Qu64JtBiAdI0ZqZcX0+vmqK1F9KyTq5xVdC/hIZjTamCEbjQ2zWkt6AlwfQjmiMKEvM07m16OmK2F7itLjPAAtW/lDQ2gqiVVzpooOEZnEf6HGnIHStPsORlVwh7mqOOk7arFPnqqOWoV8T5unteAYOx3SMhH16IHhqZMx7BVzP6NZj3fi534S+CsvA++fppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9P3W9cEqFBnuh7ZdWHim6sI1BI16haLklkmsLBX9z0=;
 b=gU++xw5rm8WO2gAa6xyS8Ye/Qo+dWbmqKKqlEWNqs/DRe5NHuPP8669zFU9h0arOXcVBrKlmT7j8QOzGbhIemds1KamiHZBLybJKOl3tSRX9BOmsbNukv6GDZJggRt73e5zb+sZ1WcDhkN7CkdH3gZHhJVME3mqgYDi1HabHKMjrPyyJIO3WEZXK7w2hCCh6mL42e5GJELp+el0uaXV04oHihzKL8YMiDGj5Kr2PtPkbhLJKXxfoiQyVnZMIq1jxMyLtzo6gGRqwYHp24X/MdpY/Yl4zxk51XEkO1KnsEHofbiahNqEg67uOZ6fRvIcDZ57zfGZMozpI7AZ8Ri+uqw==
Received: from SJ0PR05CA0178.namprd05.prod.outlook.com (2603:10b6:a03:339::33)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 00:53:49 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::b1) by SJ0PR05CA0178.outlook.office365.com
 (2603:10b6:a03:339::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.14 via Frontend
 Transport; Thu, 3 Aug 2023 00:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Thu, 3 Aug 2023 00:53:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 17:53:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 17:53:42 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 17:53:41 -0700
Date:   Wed, 2 Aug 2023 17:53:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZMr6lJpRDNZsvSm/@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
 <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe0IQksFgV6yKTB@nvidia.com>
 <ZMrp0ofsx8M6fT/S@Asurada-Nvidia>
 <ZMrqEAOh82SBvyaq@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMrqEAOh82SBvyaq@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: aed14420-8684-4708-109d-08db93bc18fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +j6W/Ydz8H/IPes4dLa/SEdf1Xxd6hZM7Az88huw35iYbgMonoSEwg0BeBK0VMQmOn3nM/NMOLQLtG10CO+m/tRWWmczCvv1zbMCEbyCrZhLsXMhZkxuIrW8bb6AcWRJhZgH95EQvfLAZliLw91KA8b2Y1HSdRzMfTEq4DurI2263bqmG+kBCKHIKoE+BU1CfO99qn61MwvGADWHGXMl3Me1ayBflf55bfS9RwUFYT9Zxkd+qv/Fo/jtmOZo/bs2tWWioGc4HuU115POr/V79vZmQwRFnRAZQrj+7BrbcN//vWLdrctGZJ/CRSscUWVT7/jScrn1Ig9laHg3NaYvN/x5Dv6MMmrxXUqcKAVKPPA8SjPxamrpOjWAuFfPHcSJgdrELrqA/+RPT5qGL6XrBtbVd4+h5XMlk1HS0GWtiHfbvm2GyDKxh+EGywG9i0SPYz55G96Aav2vw8Xt5ANiNm7AxRKlDzmQQd3eVYL5m1RE8sNd7z2TjABgbuBfJpw5YjRZhucH50KzIBrJ9U4B/G+w2r1OSyII2kDqFsMziuuL+Wu9CSoQk8jsL0uN+CV/48lspCgeh6taayec+LualkVecAdM/Rf5+QrCeROf8UNsovZngMiIoM4T0KY3lJAgN14d5EZmwe8dFpVffSy94QSQCZlvR0iOt8ivz7EqI4Y8uS2w5wvmfvFWXuiWu0SK2Y4YwYLHe/M3kfdWEEcl/y+2xBxgSbZa33Skv5qcZOs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(26005)(186003)(83380400001)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6636002)(5660300002)(7416002)(6862004)(41300700001)(8676002)(8936002)(9686003)(478600001)(54906003)(40480700001)(55016003)(356005)(7636003)(82740400003)(33716001)(86362001)(66899021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:53:48.4401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed14420-8684-4708-109d-08db93bc18fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 08:43:12PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 02, 2023 at 04:42:10PM -0700, Nicolin Chen wrote:
> > On Mon, Jul 31, 2023 at 10:16:17AM -0300, Jason Gunthorpe wrote:
> >  
> > > > Ideally expanding uAPI structure size should come with new flag bits.
> > > 
> > > Flags or some kind of 'zero is the same behavior as a smaller struct'
> > > scheme.
> > > 
> > > This patch is doing the zero option:
> > > 
> > >  	__u32 __reserved;
> > > +	__u32 hwpt_type;
> > > +	__u32 data_len;
> > > +	__aligned_u64 data_uptr;
> > >  };
> > > 
> > > hwpt_type == 0 means default type
> > > data_len == 0 means no data
> > > data_uptr is ignored (zero is safe)
> > > 
> > > So there is no need to change it
> > 
> > TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects a
> > -EINVAL error code from "if (ucmd.user_size < op->min_size)" check
> > in the iommufd_fops_ioctl(). This has been working when min_size is
> > exactly the size of the structure.
> > 
> > When the size of the structure becomes larger than min_size, i.e.
> > the passing size above is larger than min_size, it bypasses that
> > min_size sanity and goes down to an ioctl handler with a potential
> > risk. And actually, the size range can be [min_size, struct_size),
> > making it harder for us to sanitize with the existing code.
> > 
> > I wonder what's the generic way of sanitizing this case? And, it
> > seems that TEST_LENGTH needs some rework to test min_size only?
> 
> Yes, it should technically test using offsetof and a matching set of
> struct members.

OK. I copied 3 lines for offsetofend from the kernel and did this:
--------------------------------------------------------------------------
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6b075a68b928..a15a475c1243 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -86,12 +86,13 @@ TEST_F(iommufd, cmd_fail)

 TEST_F(iommufd, cmd_length)
 {
-#define TEST_LENGTH(_struct, _ioctl)                                     \
+#define TEST_LENGTH(_struct, _ioctl, _last)                              \
        {                                                                \
+               size_t min_size = offsetofend(struct _struct, _last);    \
                struct {                                                 \
                        struct _struct cmd;                              \
                        uint8_t extra;                                   \
-               } cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
+               } cmd = { .cmd = { .size = min_size - 1 },               \
                          .extra = UINT8_MAX };                          \
                int old_errno;                                           \
                int rc;                                                  \
--------------------------------------------------------------------------

Any misaligned size within the range of [min_size, struct_size) still
doesn't have a coverage though. Is this something that we have to let
it fail with a potential risk?

Thanks
Nic
