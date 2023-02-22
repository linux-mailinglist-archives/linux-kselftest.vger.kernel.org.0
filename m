Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4269FD55
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBVVCs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBVVCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:47 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831E244A1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3xhv3GAsDEkTV3F65xMIGc9bu5vX0bhkRM1SfYugDM12u4JemqZU3QYtY8Pl0B5j7WuraTdbdcgdthS803Zi2//IffmIW6MQbK/ipG87XShiZzZmOX5U36T+2rjxxmXxXOq19QRy+rBLoNIMjxqxIYCxmmYtM3zkNXuLffnwilSxCUcD2oyXMlVAiURIQ52hxPure8VoieyuVC60z756yylQUsx3xerYKi84XZB/wY4szf7kpX7ig9J3jbfl9LLpbxZSaquEyNRdhbOUcpo0iA/7YCV/eHpMPP8QzDoKFmcZv7/u9XleP+rK/ybyc02PTrz9W6h0FR2jSvgmU7KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xLbaPPoXrC5BHkxxXBQcdeotQMHGm+J17RJ6BKFOpk=;
 b=j0zqRI5qwwI63/MT5lnRdtRqFbSG7RgmQITLEicwbF3nB2xAbSbjY65CUZwqqthvXjba53JnzJJMy6II8Kr4837/HyyieGz/vaB0Dw8B9WTsn1yHEphCUOtLhChwNJye+dzct6l5LKeptaeiQVVFeBx0m/9YAoScDkIv7PWKMgoo4mKERoJQHie73bN/JpMoEMa6vSdzE76mdH+B1Rl0S09JoBESIXL9aSuoJFKmjx6P18mPsjxOzXrMK6A8r/XILQess1vei+bmz98OY6T0hGtkUn6F7Ype9/wypI+4U41nR7d1LGQfVs+lhGSgICiCu12JbWD3a7QlcBMgqDS5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xLbaPPoXrC5BHkxxXBQcdeotQMHGm+J17RJ6BKFOpk=;
 b=MvQDLoBnPtb0o7FQxj06UbZCAUFYoblWnewkjjVhaeffZvm80kzZK15uFGHQxQ7zXDubb2F7FW7MOIqaMOAAYW64fnYKN6GCFrEgByS+yju12Yde/0Ig4Z5BoN73j3m4EdPmdccwjfBzZbRGeM8/eTTBqJQWcSCShgwbvvQYMMBHKR8TI5kL7zZAKQb3NabW8zR7w1nifRSXVJa8K4JAEAPnVRto9mEapiIuijTFyA8Food0dVy7fsg+46kjxY/txoKNNVz5ndJunO6Z0wNKsup5RhEAvhpI7aK4wIVw9n7R6oukn64JsMuJqS71C9UwOBrEKw4nwPt6kPB+8qwm+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 2/7] iommufd: Add iommufd_lock_obj() around the auto-domains hwpts
Date:   Wed, 22 Feb 2023 17:02:35 -0400
Message-Id: <2-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:208:120::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 3589ed71-8a98-4d7f-33c4-08db15182361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S53LXgIWMZ8d9MPX856DkA3ae0oDOaoPCr1HoQ+s1YuwDDCpjcoKmNXuh5Ced6NSDFrahvXFxCCSDq4PTvEM5/KIp97IjJczjOyRjU3+BwHITZrcrv45uDgHCfMMAX+pRZhQBGdk7DW6l68NTAwUtkKZBD90t8MhwFOb1ysf1QjjrT9XTlR5wS5uPjKw3dxDLbG07MA2Lox25A+Tja58uUxJV/MthrYCV+UYxfNkTlmRf2OSWzPp7yAGD4dhma3XgU7KehcOB8uX5j/BWfA29P/QlQUgxM/z+2BYlXHrhKfiSIUycp2jg1nUz+4zB7QVVJrfzlttSefEQU2k1vuM8pzTFGrLNS+I4Gg5ObeDUTLiNw9bVGakIw7pzpcOd2cKqQyuCEFn5hKEX1pGvGlG4XlnwMnR+2zSoVTSlHievIfCiHfwAV8k/DWDBkbD8LTnucF1RDPjbRDHfo8Yq4FeNbuxMGDxaA05lub8WVaic7GQwmyAIZGAy+yDpbY8RlsAslfpd2MVcUuv2SkFtlrOn1mS19pmqFQtlLCyJp1GcJ1uKTz5fTNiCuNpaVTm1j9VkV+mShfddGtUZCosBuUO53CWJ9sdkc+cqnE86khN/gUcDaCpnKoVuJUErV/z+uZ6kEdRHGCOukFiXtyFOVsZtjkrv0tdDzA6I68Kk91SkShPJfRBgmB7qo2eiO9ld9+zQlfnSFyNm/EEaJxzG/K+eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(316002)(5660300002)(36756003)(66556008)(8676002)(6512007)(66476007)(26005)(186003)(4326008)(8936002)(2616005)(41300700001)(54906003)(66946007)(478600001)(6666004)(6506007)(110136005)(38100700002)(4744005)(83380400001)(2906002)(6486002)(4216001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLmiyL+CUBYgvARFy+4j3Org3P78oS+J06TeTsGUDHSGt/yem5hoRM/RGym2?=
 =?us-ascii?Q?Z7CPjneCzq8j84Lhd+/46e+rju35ganV47ZcZmCcSUfMjL7bX8bO6QxCfsCi?=
 =?us-ascii?Q?4gkF3/YeCIm1mDihLXaeAMGmSaPpUZNDMrFj0CPgO6kQLGMqOFFlYOBLXX+O?=
 =?us-ascii?Q?LBST+gVM3HvWB42YJTqBv6/MrpGnlbrsKP0KaI6GSqndb5/6KPWmJIAJPUUH?=
 =?us-ascii?Q?AE0N+74tTOui7pRS01rTGchKX4/YtsGMj52fsDhoTz5bKA1xtzkBBYwMlBZO?=
 =?us-ascii?Q?SjmB0AkWs9u/s74JVxqpD6dCCpfbw2bA1DV39KGU67DS4wah9cVw9H5qeSd7?=
 =?us-ascii?Q?AwK6JwKgXiJ3sd3vyET9BIq9LagijP8qejkPKquYpiscoCMXyQwOxN3p8/2M?=
 =?us-ascii?Q?MCvhHwo5YIP3pmlOBM+ZM44z0AQhyNkDkP87vsxrL7H2in7+Gc911j06ATZF?=
 =?us-ascii?Q?zA+hNgr2q7lPeLe15J82xF54ljJxaqq1yQ2ueUaOdULDAO2ToWrnDRs1H1oh?=
 =?us-ascii?Q?bCgo40YsU/wr3GbSsmuEypttVtZHwU0PyQHjs/LlCOm4HidCsgMFtAoL6aiE?=
 =?us-ascii?Q?2uZ1SklKkZ1WYbse5i7O8n6cWbxagA0DH49kgWvZP9HM5oJ1SPoVlBrcafzi?=
 =?us-ascii?Q?SSxYGKexsEnhdyGaQyFIY2mBsf6WdTdbcE74C2m1LttCCcKJB5sTMytCRtpX?=
 =?us-ascii?Q?YziWYRUdkLwa/e9B14QL9WNu6IoLJkFELqcobJVn+vEKIBORoGvNNywG6DoB?=
 =?us-ascii?Q?3jtclT0/TN0e3QggpcDnydG1UGJN1+zRTcqHg9g6EvUBPaooYYvI79LcmIwk?=
 =?us-ascii?Q?HscmPbq7eqRbe3mlDBUfvKJaT5IkWbjaGiAnZ/qwQOikHnjCcMIxK65joQo1?=
 =?us-ascii?Q?pffmrmaIlAD+qCPVe9aVNojvAWDdcG9KvSr/x/wQ6gZ4BDFJ3Ds7dhHklUFi?=
 =?us-ascii?Q?GHlu57BRAFGXqpqC4H9FOR/y5/UmGzRPMzgXSv4C1l4o+diccBDLvNecglQ3?=
 =?us-ascii?Q?OFxjYk1QhJ4VVtQ/no31OcbMlqoSEHAjEsjbyFD+MNXiYZ6OcCEF2MKqMHuw?=
 =?us-ascii?Q?Vu1I3BTjjqnWrMfqEiiJiQ4W00aTA4WrCCz+VDjp6hx7H4Woj7d0KVe0Ua7d?=
 =?us-ascii?Q?bksq/lgQ5cSfUPHnOJ1b7hhHaEhh6Vc4A6IDV+uimdJmPMPiQFAQVR86S5Ii?=
 =?us-ascii?Q?oy7BkdZbBv4jIRuOiCbyPvw6j40E0cF4IVqikO6Uc5UXcWg99al0OGw1FRLa?=
 =?us-ascii?Q?5u25cNGETuFUMtB4GSlVYVzZ3YxT0KHT3gqCIb6u9onh63Fe20cAV8Tmn2Wo?=
 =?us-ascii?Q?xBAv9yuawIUCIBjsd1gUubKMTnHfKttGkFv/FWutP69JleJELgzcWq+vxuDR?=
 =?us-ascii?Q?98a/KeS6eGjEINUMKvNRGGHHqvoLzINEalLH8zO1jD4XnGT3Cu1c4M99whGz?=
 =?us-ascii?Q?A7uCBHDW50T0hnyH+MFvxaBiimXDQrUVQIf1lnNZo+Ayh34HU+XT1VFNqZfm?=
 =?us-ascii?Q?Kp+HoD1K6ucRmQ2Izh8ordN5lwgWLTGje1LiiM8FM1Yil8gzmWAAD0armNDp?=
 =?us-ascii?Q?/u/yEBe1pSRJW1j9qkFsNzUWo0xmHUsKVKx0JsqD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3589ed71-8a98-4d7f-33c4-08db15182361
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:42.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns0LK5x1O4AHSXUQxCOMi15WSt20vOiuoqiJIscmiK8ZLUqACWr0cRv0OTk/6tcQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A later patch will require this locking - currently under the ioas mutex
the hwpt can not have a 0 reference and be on the list.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dcfaf6567420e0..0a80ff7b2e0d79 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -282,7 +282,10 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		if (!hwpt->auto_domain)
 			continue;
 
+		if (!iommufd_lock_obj(&hwpt->obj))
+			continue;
 		rc = iommufd_device_do_attach(idev, hwpt);
+		iommufd_put_object(&hwpt->obj);
 
 		/*
 		 * -EINVAL means the domain is incompatible with the device.
-- 
2.39.1

