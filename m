Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABB765BA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjG0SsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjG0SsF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 14:48:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122619BF;
        Thu, 27 Jul 2023 11:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTf/4GMXOwFwemAqpHY+w/jXXEgTW8SX2oG4ML+NM/8+YIgmxSMTKmPmqpz+1TGa8LgmBY+FUA94tPVCYvjL58n+1DpkCwxWnJe+bUhGxyWj/ntJScSFaTP8BX7L71E4R3lPKkvfWal5xoQUSJy7WWJAHpfKarATet2WOyts1mAsZSyu0OJXod7unbA+0t9HJa6huv9ZO7zSKS3AKK1vJAOKsZ9aDmjpKeSCZfd+r1O9iKj3qcvCU5XXrAqOqYtZJurJc8w9UMiRB0z4xPYOqvfIF0deao0jPfrlCobDLjb2sfECJ5pP/Z6SYzOdcT88wkZ99jLiu3RYqKeXxWAZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUA4cqdattcKG88D6+HIEJThMwIy/+V6TxlWcXMUVeI=;
 b=DHHPJD1AYhSpjOI6DoDCdtqW1FNWNgQNemKRkWb8b+tIvvgZei+XPlPhNDsu7S/+zbQS1GsKcr4l0FBVs3aIAOKCIlR68E+frRxqLhraaTCx6I99ZMLVtVHAIh2M0jJZkUXrb+I12zA7bqISZDgx1yznXEWW5tw5AuVqBfiV3N63G7nAMBAOzh6HOhnYUzW+WTswpbPUTua5RLGyv/DcIjaU1UYGIJtq5Ua0IUF9PMEL4CiLSWhmxYmo6+6A4Mp8GVGZVo5Zb4zRm2wn5BsU2vQOrtNUcISOHdz18EIeNj3By1HNCCIOGCdipPc9dugPjhclLyi+PCuUN9wffOb7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUA4cqdattcKG88D6+HIEJThMwIy/+V6TxlWcXMUVeI=;
 b=t5RpHZHv7XEdwoc8Hqgsp1jbWOKeCOQ9b5ENVTTpJf0b02fbfWeXXvpnoEab9UQMUf9zdV+CfJ8hqfP0YxzzONE8Aj2knbaXT1M9DmtR+UtM3R6GZ/aas8XHOJusKWi2GIkHMvw6WQC9nAb3Z4tldko8OQNYvy9u6a3wnxWwLbTI6DeDyO/5MTdXU9FkF1NctxOgvFAMkLtG9iowXsZTbhaHIV0xfzUu2WpzhixW271p4+TLHZafQWSSksRCYeYI+l/anGCAYhQx0hS5DP0cdmy+eHqvFFjbZNmj+XPhykh1a3KnquytDJ5Fgk7OhpDFOgruaYqLpAuUjq0J9hYlMw==
Received: from MW4PR04CA0082.namprd04.prod.outlook.com (2603:10b6:303:6b::27)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:47:44 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::45) by MW4PR04CA0082.outlook.office365.com
 (2603:10b6:303:6b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 18:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:47:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 11:47:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 11:47:34 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 11:47:33 -0700
Date:   Thu, 27 Jul 2023 11:47:32 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: Re: [PATCH v9 3/6] iommufd: Add iommufd_access_change_ioas helper
Message-ID: <ZMK7xNR+PaBek+Ou@Asurada-Nvidia>
References: <cover.1690440730.git.nicolinc@nvidia.com>
 <5d7d275ff12c1c991ac80392b19f1ebf5214177d.1690440730.git.nicolinc@nvidia.com>
 <ZMKB0XrtGIvR3lzB@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMKB0XrtGIvR3lzB@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e41b4f-b4a2-4139-f0c3-08db8ed1f719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IxtQtVHZ9n3we05HBPYam4bQqBaRMkAT/+/7m94U+T7uoJg95sDXjUL0/TX9spE3/qsftA7VUZZmczGUM9u4jFrX/KD7PrtiRLwV19apqVtVfPi8HcLCLBlpfYeWACpUWR9FneQ/gewsYVCZJy4FrNXwQXhCKOKPrBszCMreySIVxz2tZhyIf0m81HHbyEPMqOF1957hd+FoTtwxo+2QbYo53V7T4vyKMxyQfCIP6TDFiaBlgR1OWVlC7FceeLlgg60+c2rPN9zSmLGuFVZUjPWuCcfb0oDa1/9dsaml5tI5/4IIQORP2lDUtjBsF/5cHl7CrQlRCTu6EClmz7XLNq6PNPkw6VYTnKWn+n463prLgaJByYNzHg5m9RxFfKq2uFU8JMRskKncYITcOWaklXfsQnfoMd1ijMSgm99MFvijIKegquFGCDRl43e0352nmLzM14JAE/n9EIKqSiloBjbdmiaQMZIXL9Vhi/k6deFqEv4t+sZYJrGfDt6WDWDHx8VCwrRYivh/+u8st+d3Re22eEFNJ76ZfVIoSWuz41wsie5mhaapQFbV0x4QtiseGTnwgfOrEU3AoqH+yTzLsZsqrLEg9nT0cH5DCKfUGvPl1IZm+S3lPYMy+oBuf+qxoT8N1bdyx8pCbEGyWENlQulCATKPyuqF3lkB0kIZCpeSvmj2c+od69KjWU2+NohFRIUfaGptcsmtawFjRNhpHKsh7VNWfWJ9X9Tn3ZGWfY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(36860700001)(6862004)(8676002)(5660300002)(83380400001)(47076005)(336012)(186003)(26005)(86362001)(33716001)(8936002)(7416002)(4326008)(6636002)(316002)(70206006)(41300700001)(9686003)(478600001)(356005)(82740400003)(70586007)(426003)(54906003)(40480700001)(2906002)(40460700003)(7636003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:47:44.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e41b4f-b4a2-4139-f0c3-08db8ed1f719
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 11:40:17AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 12:23:08AM -0700, Nicolin Chen wrote:

> > +	if (new_ioas) {
> > +		rc = iopt_add_access(&new_ioas->iopt, access);
> > +		if (rc) {
> > +			iommufd_put_object(&new_ioas->obj);
> > +			access->ioas = cur_ioas;
> > +			return rc;
> > +		}
> > +		iommufd_ref_to_users(&new_ioas->obj);
> 
> Kevin's suggestion to just open code the refcount_inc here

Will replace this iommufd_ref_to_users with a refcount_inc in v10.

> And have a wrapper func that does:
> 
> iommufd_access_change_ioas_id(struct iommufd_access *access, u32 id)
> {
> 	struct iommufd_ioas *ioas = iommufd_get_ioas(ictx, ioas_id);
> 	int rc;
> 
> 	if (IS_ERR(ioas))
> 		return PTR_ERR(ioas);
> 	rc = iommufd_access_change_ioas(access, ioas);
> 	iommufd_put_object(&ioas->obj);
> 	return rc;
> }
> 
> Does looks cleaner

I see. So we can drop iommufd_put_object(&new_ioas->obj) in
iommufd_access_change_ioas().

> Then we delete iommufd_ref_to_users() as there are no users (once all
> the branches are merged).

Ack.

Nicolin
