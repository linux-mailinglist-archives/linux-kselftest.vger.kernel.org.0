Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CFC77D758
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbjHPBH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbjHPBHb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:07:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4C2117;
        Tue, 15 Aug 2023 18:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiCol0YbXbOxqIrtagup8QJJcoZDb+opJTJLJ2AEBWv60/sFLsK5mEAcOQwyEJagDuK64rQmWIoxqeiaG+aJ96Sp4E8lDeQGDBgwKvgJDPz76qzROElmfDD+NjejPoBmt9MROJ/Y9NlY227NckBFwVsKUTUbvIYqp9OJ8+F2/1hbRZwQUwluoykA3dmlObasaW+jlHZS2BpILzTZwHJ8MgkMl3WtNgzVTvDO6ln2GZRBzHfoZv6W1hzP9yqkldoquc4KQjdLIcxI5cTFKesPHKjKWW24kjP/ULPyjtOEsRaG/kd/29A82nziOvnjNRKXG6YgEnCQL6EygnHm9NY+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO43WMxVwBQOR0GKacWmNXRAkl9yMJTuTfrnYCTuPK8=;
 b=dIAbJBheAswirrN8gEl/zm3TQzsKTK3s/q0iPirtRMJ6rsr5lkNeSD0gHMm9gJZ/t/AWN+o1fn2Z4YR50PgYhZo7iobpsEUIIapd0bu931z+i7v1z1GeOUJOmHSDBdCwFa8SedBRCScU5SabH3mfqS46ewDxbnWI/FaXgY1UTkIv40kUMSmVW/RiGwxBIb+A1rAqyUeOJ59TOHv8Mz19qNOMY2Yi4GgrwmhgNu2gbGSadSfKGtcQmAMOT9BilhgaKrJaCGY1U1+Yaa0ZjuhUIYLd5Qv9FnsDEvPIJhUX/2xmHdcuWUg5ga2mn2PO+grYOw70odPAljAURmAcc13t0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO43WMxVwBQOR0GKacWmNXRAkl9yMJTuTfrnYCTuPK8=;
 b=ru4TvJb+65/ykPvpSP7lxm2cKZsfx/9dIW9wuIVpKQoNND1hPk+8C20yZL0jYCk/bHIUjQnIuq8d67xfGB27iOOzXkQhVuvpqzITk1vVrLUUi87cLlybOqQ4IvKL+jy6FhtWpvO6ZbgfcmFF9RjUL2J4HFq3h3/3wemxGbPvE1GD2yzZarzjbrsYH0/mC7hHc+H49r7Ix6ww/eRErqKbBZcXKCDR2zhGKBNhJr8L58zFCWa5zbFtMcPHSUiLTs+ZnsOy2KduCZvVvv4r/jrfLrxZ/0nW7vrVyVuo3Dq6qNDCLfLcv+tl43zX+5jZzUDMbSevntH4fQ+yg6NRS1/eEQ==
Received: from MW3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:303:2b::14)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:07:27 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::9b) by MW3PR05CA0009.outlook.office365.com
 (2603:10b6:303:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 01:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.52 via Frontend Transport; Wed, 16 Aug 2023 01:07:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 18:07:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 15 Aug
 2023 18:07:10 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 15 Aug 2023 18:07:08 -0700
Date:   Tue, 15 Aug 2023 18:07:07 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNwYxJg0u7jAZRff@Asurada-Nvidia>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuogZV2eEeVwNX4@nvidia.com>
 <ZNu2XWS0BERqykIA@Asurada-Nvidia>
 <ZNvEAWF8ljWHrcws@nvidia.com>
 <ZNvJph2AHKroujFe@Asurada-Nvidia>
 <ZNvKZWcqrjp34zpe@nvidia.com>
 <ZNvKuCFqCCWwIR24@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNvKuCFqCCWwIR24@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dd849b-0a5f-43f6-c91e-08db9df52837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +q0H6H8CeG9rRTA+2IPqAyPMgs7lPK+7wr5zN1GaWSzFu0dI0C28pgp/RqJaVyDUN04BmXZbzx3hrGbFLTghnurkWbSeEyQJ+eSGNjK3TMqzQot7gKcrLlLKTh28wTOczo+xra9pfkS5HtIkVnV8bqc+Ox04lpY0GEMUvesp14MEbG/EPQshdWsx5KlYLgzFBZkDKAwoi5UhCtDvC/HgSjlUyQ5QS0JEXqqJTJxlzdGGZhhH0ehFLm718i4Hx7D/MscMwHkojZTwCrsUMqIdV+AaBuvOGKd8aDjxz4rCqNlmx7uPVduzjZ04CyqF4rsduEETaldzg3KDpn7wBD9+GvZoy68C7Jsi2YmaqOmgcseWQTQMvlo4yJtVtLPLYo04D7AQSZZaR+1VdXRw8KY6Sg/kDI9/XZNprZFoSAN3YTFrdKZv7njuZ32CIlaRUBK2TDWdJIxVX1u+COtAwh8TDRz70RoCR+uGWw6BpwX2r07iDIGpnxnoMEbrJVsztV1/a2YKsm4axeAh7Sy4XR6kfZZTJDWGB0iSMpOJbn3UcYaWhgX7/6hHPAhGHIya5O50viJ/wgLYNl0D9Kd9fRXKv1y7IeS5odI8/K4Lum3fYXmKmwag7L+FxvEPu+JXDFM3sZBWXZ4GNUuvTdGeqpxHailybGodVYxsDdkkNl12JiLGumqyEA4YdAOD5X7E0Uj8pStQBgeqHb9g5W7gWP1VWk3J10d+mCrwV+Lukoqu/24=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(426003)(336012)(316002)(6862004)(6636002)(478600001)(26005)(41300700001)(5660300002)(36860700001)(4326008)(70586007)(55016003)(8676002)(70206006)(54906003)(8936002)(9686003)(47076005)(86362001)(40460700003)(82740400003)(7416002)(7636003)(33716001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:07:26.9256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dd849b-0a5f-43f6-c91e-08db9df52837
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 11:58:04AM -0700, Nicolin Chen wrote:
> On Tue, Aug 15, 2023 at 03:56:37PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 15, 2023 at 11:53:26AM -0700, Nicolin Chen wrote:
> > > > 	ops = dev_iommu_ops(idev->dev);
> > > > 	if (!ops->hw_info) {
> > > > 		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
> > > 
> > > It should be:
> > >  	if (ops->hw_info) {
> > 
> > Hmm, the test suite probably needs some more stuff then too since it
> > passed like that :)
> 
> Ack. I will see what I can do.

It actually reports errors when hw_info is defined (and it would
get an IOMMU_HW_INFO_TYPE_NONE.

#ok 62 iommufd_ioas.two_mock_domain.ioas_area_auto_destroy
# #  RUN           iommufd_ioas.two_mock_domain.get_hw_info ...
# iommufd: iommufd_utils.h:368: _test_cmd_get_hw_info: Assertion `cmd.out_data_type == IOMMU_HW_INFO_TYPE_SELFTEST' failed.
# # get_hw_info: Test terminated by assertion

By removing mock_domain_hw_info() to test the other path, simply
there would be a kernel crash.

So, I think that we are fine.

Thanks
Nicolin
