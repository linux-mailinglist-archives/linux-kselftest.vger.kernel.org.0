Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17C766346
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjG1Enm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjG1Enl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:43:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460126AB;
        Thu, 27 Jul 2023 21:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It9lP6VZFFXgM4WsSrn9++1wn8VtCcQARJg2QLD0xGdi4bSzniX/dIR0Cd1ICpHI556Lvo/5MdVrGrj3uMStKQE84TMXL0LE1OW+UFuyqzfoIIDNidYDEdUGaROIz90xAsa1Ww3QHRuCtPYdLx/WZs3X/lUP9zdcaWo4DhJUVNybHdM0Sa++F4NKzokpTMRIMyGwyZbVr5WzKn0rXjNbx09x9XFVD6gLZxfPWBRVuJ/hmM5/49771UaU4XD00hc9NYfSkAA4v+phEuiLJwDGBonxjOrT6ejJuswNGvun3GHf1nEBHRhFwzC8JQJrPGnrrZp+nclvc5X7LNblDts0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NhEvVdPKj9QOAoyCVHAAnN1UDNgq59jycPnW8E2CIM=;
 b=cJOHzbzYCuD5TDDPsHcE0wj7k1YkCHId9yF4x4YKsQGsdQabKkE/+LWvkzCEf/9B0ONh+tq9JCrxOKCgcpMS2AWzk/usDHnvrfesl3S0CsmK+KQe6tH+9eGb/u7dsXwo3Ji247E3Uh0IEHTsYx46myj6qTOnypNczftIRGxj4rHHTeUgFsidvBEwrLTkP7M7aR+OQ79dCs1lmteMxYr6NOYK41hDe1tOsguBnbfobB5zMQyrEugDQFwvG2MvARQRK0US5D2IHtwzBM8Sl3koOpcreNZLEZ2tKVzeFhEtSrsIKkXYGjtAHHd6YSn8T1GCwUbVWgbOZIa+C8jNdAJPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NhEvVdPKj9QOAoyCVHAAnN1UDNgq59jycPnW8E2CIM=;
 b=gu5lrj1mD92yQtAYy7ZTC4phAOLA7Qg9thLOZaUTQW27QAJnorb7a+d4v+HDdUApiSO8PKc21D8ErJIRVAVWcFCsJgUOtpJTGRJoAgzIYo+ICGKfkJpcQFsW08JC3k11hEzzh+2lVP2qS+ZSoOozvkk88Lqbwp2f/uqY0xuFmJBP03QPUTXVlaQYsQdel7lUZGzneD2fmqhhM3OUMQV34kPVHp75Gk/kwq91LCVaaETFjRI6pTOvuArny5RzA9Bmu1VbtWc38vPEl87DSFA6Tq/+OMGJE2k9Mx1KvHpbtsHXErxXVoPzB2cqQx6v5vmWeSUPkrHtKBg91dNxPmkn1w==
Received: from DM6PR06CA0029.namprd06.prod.outlook.com (2603:10b6:5:120::42)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:43:37 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::4d) by DM6PR06CA0029.outlook.office365.com
 (2603:10b6:5:120::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 04:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 04:43:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 21:43:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 21:43:24 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 21:43:23 -0700
Date:   Thu, 27 Jul 2023 21:43:22 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMNHarPX7yA+VTdT@Asurada-Nvidia>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
 <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
 <ZMJc9elDILpHaKP6@nvidia.com>
 <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
 <BN9PR11MB527691E9B421682C7B88AFD68C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527691E9B421682C7B88AFD68C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: da390abc-e290-4c28-17f1-08db8f253542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWgVNMaF6sIJd3GcsiApUmKFjh6567zDibDlv1xjh34d+AwM+RA1HSEcsWJfiZDSiZQUb98qQADLELXKtT/nrZ5E1VnzAjN0LNasShMi/WaGSY0KAh+ymKs6xmL0TE0cFav9ZbJweKl/e9sQsii9NagF4lMosh0v0ZgW/47x3QpV4W2hSA0iiq7XyltYSI9fa5hw/d0dWcBOhPB876HxfBQTJplF4JuUOknbPtiBHpNjc03OxGLQER2OU+fhcCmxLSqb0h8edBXl3Uy5tMUeb87QHpt8xAXaRnY6At759V5Ijy9Q1WjnTyP7hX8BAHW83uTfzzIhJHjyEUTxtuyRxu6umrgQF9NeoxORHBXEMLoYuoh6ggTzLpy8Evr48GT4Wzy5TpANWgLjtTNP5F1h0WwKXFCQEZpM9JtndPygFMXUh0pM1Zq4/WTMbKRIlwjdgcfssdN5eX7PD2s61uSEWBHwBRRZybv3BZxeHbdp9s5sI4DQayvSg79Y13v0OVDABO/owCPepiNy/5f12sE8VsGNyKFtW3v0rIW+c66IfPO6ErT00k5Hxi+2ow3IKz0vbiQgYif53swG2Q9iSxa5E5u7zlMS7gQPO7ZmHaNErFQKGwx52Z5xU48sZ8zMAaU+XBuR+OMGGQZk9tbuyAyFODBpqlhPpwo0NpX7a3PW+6SSi/1F5KuJ75/6LiqtRZbMCj8l0VJryCMx2JQSqfY4zcY9957w4MjvsNxfRb+iCiVZ2hXzwDBNa0zSKC1zIR6a4iVTwJxjb5eRwMT9vJfuGA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(54906003)(2906002)(7636003)(40460700003)(478600001)(82740400003)(7416002)(316002)(8936002)(8676002)(5660300002)(41300700001)(55016003)(356005)(40480700001)(4326008)(70206006)(6916009)(70586007)(336012)(186003)(33716001)(86362001)(26005)(36860700001)(47076005)(426003)(83380400001)(9686003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 04:43:37.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da390abc-e290-4c28-17f1-08db8f253542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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

On Fri, Jul 28, 2023 at 03:45:39AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, July 28, 2023 3:04 AM
> >
> > On Thu, Jul 27, 2023 at 09:03:01AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jul 26, 2023 at 07:59:11PM -0700, Nicolin Chen wrote:
> > >
> > > > I just realized that either my v8 or your version calls unmap()
> > > > first at the entire cur_ioas. So, there seems to be no point in
> > > > doing that fallback re-add routine since the cur_ioas isn't the
> > > > same, which I don't feel quite right...
> > >
> > > The point is to restore the access back to how it should be on failure
> > > so future use of the accesss still does the right thing.
> > >
> > > We already have built into this a certain non-atomicity for mdevs,
> > > they can see a pin failure during replace if they race an access
> > > during this unmap window. This is similar to the real HW iommu's
> > > without atomic replace.
> >
> > I was concerned about, after the replace, mdev losing all the
> > mappings due to the unmap() call, which means the fallback is
> > not really a status quo. Do you mean that they could pin those
> > lost mappings back?
> 
> None of mdev drivers does that.
> 
> but we need think about the actual usage. I don't think the user
> can request ioas change w/o actually reconfiguring the mdev
> device. Presumably the latter could lead to reconstructure of pinned
> pages.

I can understand that the user should reconfigure the IOAS on
success. Yet, should we expect it to reconfigure on a failure
also?

Thanks!
Nic
