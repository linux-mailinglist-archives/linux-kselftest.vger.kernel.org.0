Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44041709FEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjESTeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjESTeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:34:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AFA13D;
        Fri, 19 May 2023 12:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewwuNQzHZigAH8i7qfKZkMMOkSsFV4gF9gH1NVm5qBVohKEebhoTdntX8boYAJIHUYXceLM+c9o8vXESfYV4IFnzBZFvrocMLNiyPZNStKLPMgHJ8RbquL55uh7r8fWg5UVtDhARE4f10aaglJNM5670wvb6/7lvDWMvs8YPT2xqL2zqGjorSgCdp/8ARX29UtQfMXMg6fabvsCWLpzr5/ES20CbdiM8zKp8ZrgNcGAIcnLtBQ8T4Ekdry7s5nEMIt5M1lpqKNhPMGFvskRxWcgU6Oi3HlYNtCjtjFbyYz50U4/aSuhRO7njeIWRe/I1iMV7o2C830l8eVzu3UWqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCTrNbHPeGKYjGCZhmjM0ETp6hzfqsp7aF8dBW9dgvA=;
 b=b9RqY51L7JddKseK5yydfShWytj1BV3ALdymzmoZG0XHt8QOv6zJjnWelf5jcidzVlTTzmeHtjvvM9FjXgdhWjRJ4h0PiamAGjrQny3KTbdSzpE+GMDLEf/ki9Z89HMnKx+knFYLCMC6bTyXLgt2zaWblb4L3xpNxMDFa5j//wH+diWfkIwuKUf98QN61dvTQIrNxZhL/PnbcMCttbjBlBDDjOIx5NbOJ3VvdWgPXedgmN/naK9wX3tiAOgnNYGwm+ABoEtFzfn/ne2hUD+8o7Wfp2GuVduVsciWzbXn15lnK3bB+RQvqRlHc6QYWCZUxekgP4kovUnpiLK1gu3zng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCTrNbHPeGKYjGCZhmjM0ETp6hzfqsp7aF8dBW9dgvA=;
 b=GhKb2sbtAcad4qeRE7UAvpufTbhZq3utTzAtB4e+8Bo7rWqEir8ImtXBL6Arxz5+8/h68lRM49rnrPktjTTwJRoHFKUSBzX1heAfQRHnvXgUaFqTEcKaBOEpSKSG6pivDrKK3zwADEUqmWZ5pLfWIPEV0OopNXRB9k6rRn7rifMR+xrAdOebvI/s1iiEAaNYdr1xysij6GW/cd5QJyIytkQrhwyk2Xap7ifDBrf9PY6sx+OAhr9lN/krgRA66YCcwD3qN/FxcLGEEGGhfcwYnWHFGgDvdjV8meZCxEFYPaD+APY9wuUKrYv124rhlgjVR0pWiK4x22AwMZVLcAgK2g==
Received: from BYAPR11CA0062.namprd11.prod.outlook.com (2603:10b6:a03:80::39)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 19:34:19 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::f) by BYAPR11CA0062.outlook.office365.com
 (2603:10b6:a03:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 19:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.8 via Frontend Transport; Fri, 19 May 2023 19:34:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 12:34:11 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 12:34:11 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 12:34:09 -0700
Date:   Fri, 19 May 2023 12:34:08 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZGfPME8zrxfJ+f8E@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
 <4bb0b861-2b01-746c-88a8-c3d675a3d4f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4bb0b861-2b01-746c-88a8-c3d675a3d4f5@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5397b4-d085-48d0-5dec-08db58a009e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MN108rCrvzJkq+obZwSLg/qIinbgb8OFmoTu5LMUHU+WLp6PF/Vqfo7RcfxEjWd3vVqQrqT8PySzdNpNQV9KZ985qJjFJl+/wK0fne/GkhcDJ1QmJN73npAie0t9z5KEKNKC8jP5BC2n9Fl8BBWuyrZ92yTiubeqzYKiF016YBvUhhjYyXOuAdNTw7SHHjt2Zs2c4Po6jlAg5WLOBH4qC0J6iVXDERGfEan266Gq2h1a1btFYm0O2QFsCKceBjsYoCHQ9t1ENVLuELVX317CY8xN3x1IrlWl8fIdRKw0Em4OsJmIoO0scdXWRYxa9LyBxqEnuFVL7T/D1whLPXiwKgQoqNR3EonD+RO+IVC/gdlCMlVotGcqc+u9rLg1G4g6W/aH2WMYdVkiehFVs4pPM5FyJrieqKewQxAPOaOvRctZ+q489s88qLxYrnsVkcMJjA8n9RHXmxHMkFJWrV4ycRMBVcLnSby+uWaXwA/lOrdDBJh+XB/fHCWKjMEWLrHh61MHEURQpmueLQeLcMNzpY9a1Vdyw4IFP5nAC+9mOlBhhtRVjKSTwo8QrclgJ5xx8sJgWQ7TDjWk4ijjK+ljySsDEhitkz2wRXvb2TjkAvurlsTtLla+FMNrXdPVOwQzF9/9dFVD1Ydf9fhqVgmYNjdWMPGQtRHxUA7LOt/+2IcaQiMe+s/V6E4j7ClCLUi03XjtK05fHk0U/crG7DkT+noHweh9Q1S94QLnuK99QB3Xe7w9XvksnDveEzmD+z25pcLBsOTdUpMlEFfl2DTVCr6lGm0IKkKOX9i69hHIAJE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(47076005)(336012)(426003)(55016003)(40480700001)(26005)(186003)(9686003)(82310400005)(356005)(33716001)(40460700003)(36860700001)(7636003)(86362001)(70206006)(70586007)(2906002)(316002)(6916009)(7416002)(8676002)(8936002)(4326008)(41300700001)(478600001)(5660300002)(54906003)(67856001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 19:34:18.5674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5397b4-d085-48d0-5dec-08db58a009e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 11:08:12AM +0800, Liu, Jingqi wrote:

> > +     /*
> > +      * All drivers support IOMMU_HWPT_TYPE_DEFAULT, so pass it through.
> > +      * For any other hwpt_type, check the ops->domain_alloc_user_data_len
> > +      * presence and its result.
> > +      */
> > +     if (cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT) {
> > +             if (!ops->domain_alloc_user_data_len) {
> > +                     rc = -EOPNOTSUPP;
> > +                     goto out_put_idev;
> > +             }
> > +             klen = ops->domain_alloc_user_data_len(cmd->hwpt_type);
> > +             if (WARN_ON(klen < 0)) {
> > +                     rc = -EINVAL;
> > +                     goto out_put_pt;
> > +             }
> Would it be better if the later check "klen" is moved here ?
>     if (klen) {
>                 [...]
>     }
> If this check fails here, there's no need to execute the code after it.
> If this path is not executed, "klen" is 0, and there's no need to check it.
> Do I understand it right ?

Makes sense. And the klen value isn't really being used. So,
we may likely change it to a bool one. Also, I'm thinking of
forcing a !!cmd->data_len for a non-DEFAULT hwpt_type:

+	if (cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT) {
+		if (!cmd->data_len) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
+		if (!ops->domain_alloc_user_data_len) {
+			rc = -EOPNOTSUPP;
+			goto out_put_pt;
+		}
+		if (!ops->hwpt_type_is_supported(cmd->hwpt_type)) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}

Then, for the latter part, simply:
+	if (cmd->data_len) {
+		// malloc data
+	}

Thanks
Nic
