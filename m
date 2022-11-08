Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E7620909
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 06:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKHFtG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 00:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKHFtE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 00:49:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7C2B623;
        Mon,  7 Nov 2022 21:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/HIjW7cXflqhLVnDbWr2suh3Y6BXCgAPq8ORJlsYDe4gIIhDsjIoqjr19lojE9q8LHzh/0kzMEYWPIXmLC4qPkUuEjAOcXIbiT+Wn/vNx1qBWQispFCh6YxtFftaTG9lulnCG/Q/yfeBcvVImJIHKTc6nyXW10ZQHrI0U/LajBuuHZ2MWHc/SRmncv0k2+jrN/50OkMURfYk48Imn5ut0dh5q7/kF3YqQyw2KjUUpubF/NqkZHQaklrPIK2U5fejbWKNhbrj61UAt9gQ2op9G+op752Y+k9HjfhM5GgIkJXMkoDs8lOo09G81BRpJBbWPMFKbyD1Nnn1HH0ZuuuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eB75dOmandimjEGrxhFcGUifEQ94vIACgHQdCRNjTg=;
 b=S/B6iX+Nmo9L8kmmzc5jHXhf0LGs4cj1WNOM52xDlEcmCekuB0zFh0/D0horhbAetfIYs7eDOtNbMS3X+5nNzwkpaytrQV7iCtb1AqWaZoMEkxXnq6mwrsFthoYZa1dZRb+7V06+E7geByGQn+iFdkw/10Wm2Z5vqId5feSAs0iR3fGMVoBVPF8MZT4NGvBqHM5xwF+3LHx5gdxoPyTduB6D2OC/qvmK0Fra+WWtZrreG/Ywc9ZnxgLjhNO8/rw3x49C+m1VG9tVuPRT0/dSxIb8mxxlINHyHkYGCvpv5Xg864Vvd9U/3h160JGpP/6dx+1LOfhNJh9J9X5KYJ2OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eB75dOmandimjEGrxhFcGUifEQ94vIACgHQdCRNjTg=;
 b=EPXmVGT9O4SM6mmZ5qO4+Mj5xGprZZsLmxozR36cQHbchPEOm3y+RmisleoDa/CLOYEoT4Ch6LlZuA9TaIWfV5rkQvab1ZliSYFZmVb9lk8RfPb/KXWTLyEHzqqz7q9K1D9k40E8VUmWyuVAuSWVwtW8uEx7OCn12jfjT1LkO6UOJn0wcN4UruLDO+wTc1Dd+3mWuDxxFYgP9pEJm1kQNRKJFrB3UxWMvufLQKW7pjyz2FWrsiSMR84e7JZmKuoBMJYlL4KONz/dQtx8Gqvde0p1wNEpTgd0fE21N9qcU0Xpo/rr34Q/Itwkgfl4ErWkG8lnugKokKRdmMk9YkYT1w==
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 05:48:50 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::c8) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2 via Frontend
 Transport; Tue, 8 Nov 2022 05:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 05:48:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 21:48:38 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 21:48:37 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 21:48:34 -0800
Date:   Mon, 7 Nov 2022 21:48:32 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        <kvm@vger.kernel.org>, "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Keqian Zhu" <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 15/17] iommufd: Add a selftest
Message-ID: <Y2ntsDi4RSLtUVKm@Asurada-Nvidia>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dc1d63-6ac6-466a-45f5-08dac14ce93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY9/2Pq/KSGaLtPqfA+qytD9hPjW7b8nSINWBjAb/q1plT4kQppYPFPCfTu2jh1IjRi8PAtUVBYBDQcEW0N67shB/dPmDgwY9WB8ewEhoTxgomfAWD8u8Bo7dPyORCjKKFomyuj9TTBgksWvxs45agjr8PHCisG3MluoBEkled90MQvUboam6BJ7L6Sq87QQiF54bD72oXwnxJhGfVFD8IDj8Ah29MVf+Cl5bNbOBooscWQxhIskUi/SQY4zkVYW7wPrfPVNAfpQDg4zoGhAxy1mLvaB7icP0ly5MuI5hwnRDYvmJ069fy6xzH0S6eLoh50+/fNSP2BbDbrIneiNtKU5Dt/KhL9xsJ23c51ZlvgNII75NLnEPxWVK9YjqA+C1ItgsUOf7dkgoNNHawVaZtR1Lvnnryj7XACAaLZyVvOKdo1X4KAFnbfSNmvzlAX35rJw1odarUoMf6lRapUGSdajHWAeefBHevgdHKb9QXWHBE8HyM+TQohydc1ThHKNtepcZHvfi+uAmKDeS2PT+nrZOCIc2WfBoxrMKu1E0UWlkejesItZ7qG9QeFicqWxCYQA6N7AUL+B0MMJCixqh40nKZsW+4KzR67MjTwSPJ945UD7DUBnRSNDMls+gWT2Mp8OC6YYITSWnqFbi/2HY04oWbjn32lAvY0u8B1LDVm5csYk/Yylr+7R/C8Un6+tUszOeq7oQcdGLPb0rYmNR94LMYeVWEw6zHLd1UM7UthSuhvqtsFHNuzPlEuBXzXzCwBfQ99udhEbw1Is7xk6lA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(40480700001)(55016003)(9686003)(8936002)(6862004)(336012)(26005)(5660300002)(426003)(2906002)(478600001)(186003)(47076005)(7406005)(7416002)(4326008)(33716001)(82740400003)(7636003)(356005)(8676002)(70206006)(70586007)(83380400001)(36860700001)(86362001)(40460700003)(82310400005)(316002)(6636002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 05:48:49.9631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dc1d63-6ac6-466a-45f5-08dac14ce93e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 08:49:08PM -0400, Jason Gunthorpe wrote:

> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c

> +TEST_F(iommufd, cmd_length)
> +{
> +#define TEST_LENGTH(_struct, _ioctl)                                     \
> +	{                                                                \
> +		struct {                                                 \
> +			struct _struct cmd;                              \
> +			uint8_t extra;                                   \
> +		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
> +			  .extra = UINT8_MAX };                          \
> +		int old_errno;                                           \
> +		int rc;                                                  \
> +									 \
> +		EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, _ioctl, &cmd)); \

I guess it should be EINVAL corresponding to updated kernel code?

> +TEST_F(iommufd, cmd_ex_fail)
> +{
> +	struct {
> +		struct iommu_destroy cmd;
> +		__u64 future;
> +	} cmd = { .cmd = { .size = sizeof(cmd), .id = 0 } };
> +
> +	/* object id is invalid and command is longer */
> +	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> +	/* future area is non-zero */
> +	cmd.future = 1;
> +	EXPECT_ERRNO(E2BIG, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> +	/* Original command "works" */
> +	cmd.cmd.size = sizeof(cmd.cmd);
> +	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> +	/* Short command fails */
> +	cmd.cmd.size = sizeof(cmd.cmd) - 1;
> +	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_DESTROY, &cmd));

Ditto

> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c

> +static void fail_nth_first(struct __test_metadata *_metadata,
> +			   struct fail_nth_state *nth_state)
> +{
> +	char buf[300];
> +
> +	snprintf(buf, sizeof(buf), "/proc/self/task/%u/fail-nth", gettid());

Not sure what's missing, I have a build error at gettid. Copying
a solution from tools/perf/jvmti/jvmti_agent.c file, can fix with:
------------------------------
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 99eaa9f32e0b..7704b3a754d3 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -19,6 +19,7 @@
 
 #define __EXPORTED_HEADERS__
 #include <linux/vfio.h>
+#include <syscall.h> /* for gettid() */
 
 #include "iommufd_utils.h"
 
@@ -84,6 +85,13 @@ struct fail_nth_state {
        unsigned int iteration;
 };
 
+#ifndef HAVE_GETTID
+static inline pid_t gettid(void)
+{
+       return (pid_t)syscall(__NR_gettid);
+}
+#endif
+
 static void fail_nth_first(struct __test_metadata *_metadata,
                           struct fail_nth_state *nth_state)
 {
------------------------------
