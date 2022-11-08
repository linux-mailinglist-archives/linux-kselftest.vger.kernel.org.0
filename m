Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D3620A21
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 08:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiKHHZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 02:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHHZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 02:25:46 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2233ED7;
        Mon,  7 Nov 2022 23:25:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMOHzgJWCYwKtAmPb+5eUSvix917QxD9rgJu61r+0kejuluKZ/Xd2J5dVsOH2YUKyQwW9MBt6aW3at/H1MIUGYul9KLPaKiL7jLyO2RJCc8XR2fQXzlDc5n1EEFjkFkQR1RPb9XBa55HCqk8Hj2Hv2gCzF2cj4Shr2mYuiYX3CHYZto74rNI0u+xap0fSBIjB7c/0gwmIGZmro/Qn6pKgK4Ff32S0vT7UIPaJ9JLFC0VXNJU7iGjHo0wNMGudqlXwGIG2gogiZfkmwSpPIpPTR3kFEhkoJfacTZi1a1dzVUlJZzMNx6sijF3ai1b7Ky/lg8UVlCgjEUeP6UNJc7qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buEEKkH+NleZlKWBYBk+tbpXj3uKLBJs0wv54gSjpyA=;
 b=hWmubGBYnhSh0+SrNZtszQR9nq9LiuAfpZyTyWEqrK6/gMOPeuQY+j+UZeDEUknMiVkgXvrxo6T50oIxHOzq0yRlWSqfqs3vtP+mmlrNcKXiavGkMWiv03INDPfZRR1TZGij9fXl0M5BE+3mq8MjGL/QsxIHgZpAVdvgt1Rqa5A5P03KzvCR+D5nRj6gng+Du7QcI55yXglys+WIdyJluTkLfvi2fD+AnPvwhb8uihq/fhwYTB6uhWZ/zQf119/4oxskGkoOUtrouG/o19mibyLENJrr2EdO5L/1y9tFYdCu1RjO1az+2/ws6bSz1Xezt6WQdLIncBxoHeEv2IQXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buEEKkH+NleZlKWBYBk+tbpXj3uKLBJs0wv54gSjpyA=;
 b=INVJV5yTzFYfZKVKa1f3FZsnWIxyOB68KwF0/jex/jcKhm+KV4o7anSa9vQRRNayRwtLSOghTXvz1s/wtaEJaNLaVEX1DnRclMmzftmwd5ICLyANIZmR5p9WPkd4FCY+o6wHh9I0fCKuI9rpkUSRhcA8zikIvOpmXwomQ+gdpldrvUcuMLKN2GX8RhAv8hpv3Q3F+shsuq4p4gFE0IQowrIfHqSc9uKYhPnyjuo0lyRYCURPNfsLXk36jo16KFivQWbWZ5lIGu+DVKvSkVtYqlGyf2R/MLIwl1SSZq6nRbqLcaXTS9SW2xFNaH+90l91XvDmlYeuc4IytuFmie5FnA==
Received: from DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23) by
 IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:25:43 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::d3) by DS7P222CA0006.outlook.office365.com
 (2603:10b6:8:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Tue, 8 Nov 2022 07:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 07:25:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 23:25:30 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 23:25:29 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 23:25:28 -0800
Date:   Mon, 7 Nov 2022 23:25:26 -0800
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
Subject: Re: [PATCH v4 16/17] iommufd: Add some fault injection points
Message-ID: <Y2oEZgY6UmIDb4RP@Asurada-Nvidia>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <16-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 18253cbe-733f-4475-1acd-08dac15a71d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uq8adAzRtw4LjUTDZRxkNXJzNrPOKfmfDSs5pZLDsEBbIZ04Ejhe1TihrTPXPupbeh0pN9mgxJYv1oo+ZuC6hHaUIKBGDJ4PUiEiMIGfbsco+PNon4G52YWPdqnHHQYGqalKpuMMRCzMZcM4JTFMZaRAieGODGykidmOELGLXxwrB1TffOF+bGo1CM6jtArxygXw2qS/yys5qyh8aLVlGrI1/JOaM0xGvJ/duoHwyIwoPajsmhmdNxqLrmhddvg1jWTAZmKZ9eYtwd9diU3ddFMY1NcZlhkc8GffqxRr6w0eX04pkoyd9NE0GZYcAE8kbJccrBZCAudw5YcRIcF+tEUlKCU6IHgbUArI+/3S/7pBZlswFFLRVlaYn8r73GiaHIrCL9WT40im6ftiTOFsWhLboxkBhut+O+BdPKoPJjsa6whjSSpV0nld1YTXjiWGBIBTq5FPSAylHdxOq5St9h7TZq9OryAsXvTU+L68xTE6t/yeLjP7e04Eh8TuHorSsfqqLSjQMmfFiD4dYzYs3zUB4k2EB68l1vHoZWRz76zlyDd+arZ/xihrIlE0Q+gUTswMnZNKg7LPKAMfyYE4RpEvuP+gRo/CKhbhDXdZtC65r1AxhnMg9RsqSGNKU4QUgSNknYsd4/ir1byUJzniR0l5ovN8stJPF2dXMbHTNxn26YTrDUMOFT6C1jyZIT7JyhCRuJ7+ihb1dMR3kayBeQ30SVA0v3ELQwR8JZ/8MiUEdCQ4yjDop6IiMOwh1wv7StZXj+tIigzV+Nd+UwIq8Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(426003)(336012)(83380400001)(47076005)(82740400003)(356005)(7636003)(186003)(36860700001)(2906002)(7406005)(7416002)(4744005)(8936002)(6862004)(40480700001)(5660300002)(86362001)(33716001)(82310400005)(55016003)(478600001)(26005)(9686003)(70206006)(40460700003)(8676002)(316002)(41300700001)(70586007)(6636002)(4326008)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 07:25:42.6080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18253cbe-733f-4475-1acd-08dac15a71d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 08:49:09PM -0400, Jason Gunthorpe wrote:
 
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c

> @@ -489,6 +494,15 @@ static int pages_to_xarray(struct xarray *xa, unsigned long start_index,
>  
>  		xas_lock(&xas);
>  		while (pages != end_pages) {
> +			/* xarray does not participate in fault injection */
> +			if (pages == half_pages && iommufd_should_fail()) {
> +				xas_set_err(&xas, -EINVAL);
> +				xas_unlock(&xas);
> +				/* aka xas_destroy() */
> +				xas_nomem(&xas, GFP_KERNEL);
> +				goto err_clear;

Coverity reports an "unchecked return value" at xas_nomem()...

> +err_clear:
>  	if (xas_error(&xas)) {

...yet, I think we should be fine since we do xas_error here?
