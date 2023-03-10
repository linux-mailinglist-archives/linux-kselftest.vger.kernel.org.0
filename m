Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5F6B55C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 00:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjCJXis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 18:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCJXip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 18:38:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9736FFF1;
        Fri, 10 Mar 2023 15:38:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPNRcd9RaSLq/7CzBuln7KQuYWGwP+K4nz2zUTalQeH453asEUXS1VFf3yV0OeJDy8RjAYuSOrmxgnvK5kO37xXSYf3aIPneR3JzbaBiMw58xODXUoeBpeSXJKpb31vW2pEAmfyj2rv1eXYIhh4ZKv4UXL1TlExa2yN3Q6S2Io4CQ/pJ77pOvwVT80Sy+9V1Ch9cqhFAeS6vE/mUx4uZUDz2SxgAoAkkdfw2WpQGe0cGc2mwtktwR0eygfZQHWHAFHAFJEkouq/QXDFrKxNhLkKr1o9NZtM93x8U2YXgAdmFP3RqRGshAo6Fh6oTmky6ckFrEFOPnNRfT07w7DVJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp/MwoUT0vlw7634ZwEn9UtLRhAs0deBGAYT1ckvUS0=;
 b=Jf7XlI9c1AHCM1AHfvfdKbBpUCupyvePVNuVbeFFnbpdHBL0sAnD73XBeL+0c8+3rE48NKf73LKQI2b4pFh3PMHa1RPqibfZEmcAnBNLgRyliHHSZp+1zhb2863pcG4NOruU28nwlPhEj0PPdO0qtXAc0i4cdEJlezQhc/a32n9a47hiRwRRculIxoiIKzBUPZDJ7bTgXRktUMYZ0DEudQsDsCjQ/MVYMedc/ZWt/nUrrk3muERVsTlGl7OaNwhoky54Q/oF9we4GDG8wiVbXprVZKdo8saGqB5T7OfQU0TdZe7Bp1YLT0YLSYHHPY6igbDO9PghD4fqzCNNl+WzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp/MwoUT0vlw7634ZwEn9UtLRhAs0deBGAYT1ckvUS0=;
 b=EpQq5JzA9LR2OML8tzqVUiK86E4nmZLhD+szhuNnixqhH3h8tiJsnKN8Jnz6DfBHdwSbuEy+YOIISPufpaB1pJfvHd5GlYZ/upqWDJrPkBLSAeroDFVQpZF/JcA60iY+j73TQx/urrHiBqSSh3tlBApnzf1Ca1f5PTC6zaUfvlSC1tE447I0kbO+YOhMj/pcgeGnU3fzwXuATfjjL2Lt39EkzmO/G40jMvyOvFANkl9rAvaYMfg5SJ+sIeDJvJ8mvSIiKA7xZhpt9H4mQEsYfi9T8Rca+i8r3XUnphjgb4sXk/usLrM5OQaMU1vxmMcECjc5ra6waI/FHImC1Gzz7g==
Received: from DM6PR07CA0058.namprd07.prod.outlook.com (2603:10b6:5:74::35) by
 CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 23:38:41 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::40) by DM6PR07CA0058.outlook.office365.com
 (2603:10b6:5:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 23:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 23:38:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 15:38:30 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 15:38:30 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 15:38:29 -0800
Date:   Fri, 10 Mar 2023 15:38:28 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: Re: [PATCH v4 5/5] vfio: Support IO page table replacement
Message-ID: <ZAu/dHzS+ZcLfOHY@Asurada-Nvidia>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <600343ffb282ff3bed5eb98a9255c0084d01a859.1678284812.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F7F917F76DDC0D9186DD8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F7F917F76DDC0D9186DD8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5e5d1c-84df-4437-f696-08db21c094cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwHnFVkhjy48cgDqEWaBep09iNPXtzkxzaJ0hQ/xTWIEZMVosMFU1LjcNwWVMOEmhEzKi+GTVz6xkoq5NQHRm83LlxNBrBQQNR1/dI+ibEu7TzSElvS6MYvgGNgXP5IAUNrip9dunKAUl9LeqspkVt+d7yIaFeArMZjxSCMTc9IFmdVEjLJhI0ew30587c28TxAFWBYqzjzVIu3OttZSx+h8gVZAkh0IDIEGJusCRqNXqfago/FgR6l7Pukvy8gnJSLlYWp13uPsDiUae2l4Of8OAQhwY4NyoYKRQZciH3/5t7hr4EEmU1fnuWX9Rup7Tu1fcKh5ocB1T2YH796tOGctjCuOqiskkKvf56jLWCudhOS20aFlZAKqVMzuo0LeTjWMykSbX7zNGMAFug3++JPU5K9+Tsnq/sg+dN0/ZHIrZD8VGPZe3n3GU0PktEQmK2e9BKgwyhl4F2xxfxCqh8YBG1leiZd8/g6S4iEJ2P3EEyfk9+SKeajPAHV6ipvR76rZ+pfke99cPRuXQq501bYQxPu9+E85h8/wPVR0OtazOSmLKLBAp20SRtCfaeWnrf0PikQOjEfbrooWtHVoVohLXWaGLdgAvgTTwmg65EMfRQZQzFNKw5Iyyl1fhx//AnBp7aPkCmZvLq4w4YeD4viaQNSLEe7ceuFUp33ebymxbfhnivfSr4/0ImUL81gHQxoG2VS6ANyV5eluAc7XiIMTWRepUQTFHb81mwZA94qFczlgV/SLjVaXxM5NsjUY
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(336012)(426003)(478600001)(83380400001)(82310400005)(47076005)(70586007)(40460700003)(86362001)(40480700001)(356005)(82740400003)(4326008)(7636003)(6916009)(70206006)(316002)(8676002)(55016003)(5660300002)(7416002)(2906002)(4744005)(8936002)(41300700001)(26005)(9686003)(186003)(36860700001)(54906003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 23:38:41.5589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e5d1c-84df-4437-f696-08db21c094cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 11:53:56AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, March 8, 2023 10:26 PM
> >
> > Now both the physical path and the emulated path should support an IO
> > page
> > table replacement.
> >
> > Call iommufd_device_replace() when vdev->iommufd_attached is true.
> >
> 
> why is replace enabled only in physical path in this patch?

The emulated pathway does not call iommufd_device_attach() but
iommufd_access_set_ioas() in the other patch, which internally
takes care of the replacement for the access pointer.

Thanks
Nic
