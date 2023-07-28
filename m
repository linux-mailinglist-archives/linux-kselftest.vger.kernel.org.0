Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9376634B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjG1Eos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjG1Eof (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:44:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FA3A92;
        Thu, 27 Jul 2023 21:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZV8b+dQK94sf3ur23uyFm3gLwYVKEJeUqaLAscTqGfsHa6GmtasAPu/O25GDnvHMZYE/oHFMsgYp7ZZ0e7zzxr+eeFyirqRwteteSGRrjux+Jwq5VfyIB6GjIpxhNUqylaML2b6jhdn35CQTyIBj5uX65bI5u2VjYNYlYgDBtX9ASj/wqkJ3Qdzl36sYilW0ImveaqCba2JIr5xmdpJPK5SnhHcxhJO1mBmZEsP6dguxAJzpV0ZeAAj0o8683RL9bsVkwltG80eBaeEY31kIICnEZllj1faaGAX0S/1OZSiKkbN8Db8R8sj7A/h0hX+06ZP9RHa2P6J91DtF5tlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO+HdEFRgc+fGIm0mnRjW78mYR10GWTU281tj5iX7rM=;
 b=ABNtpHGLWUF7v9XXYaP77N2C4b3Qj90MjW0DRb/LoXQLpFGplHnJ4sx9FEwaQvwesHzSIRt1elcHpoz2Luu+dtkSvurF0Vse5iZJfJyDRA7QWGcH1/LP2uJbgWwMd/wQIhRF1GC4gQeYAY386nUlj8rd7o/UeMgc7Z2apgRnifwzNV55pOaX11FOjohOAskrcozwPKvIaLXYf/cHQ8RaEwYlHc5m2hn5qOwaxDU0gRngEgC1ca2yuGOOgyWHj1cfSBqdArusl99rVLM1Bf4YXQhZHcCXyoWR+5v9dgKSw6/CGpX96a5lIuNgoihve1gMKV7iuD9L+Sd6LbAGC2LDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO+HdEFRgc+fGIm0mnRjW78mYR10GWTU281tj5iX7rM=;
 b=frWQjZK9ckHV0AouQ4zU/AFzEhL6mLTg3Y9LxAVMgeouhcRqlFAPZrCPLWvg+aFRjfnz/wmLOV3ixuZdkG+r6X/1nJRLjcC6L9hd1nNTOkiveJVGHzCVx18UhImmG3r5MmuyMnZQVdtGuEK1bYu0MVk7r3fo9q0QDVPcT99xI64n51nbSQQ0waQ+QXCV4OatRJAs16SGM0r+d82gDBkNi2lbXBHRiduu6m6v4Zp0AG5I24YLqU+ZkX6gvG9FItc9dJFi3zFH/A8c2ENZ+NU4l0ZrgZ8YPJ3b2xxy+HZvv/lHnOVR6Py52R0oIGNG/cCJhxXcWUXxEy9Wi82lP3/WaQ==
Received: from CYZPR05CA0038.namprd05.prod.outlook.com (2603:10b6:930:a3::29)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:44:24 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::6f) by CYZPR05CA0038.outlook.office365.com
 (2603:10b6:930:a3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Fri, 28 Jul 2023 04:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 04:44:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 21:44:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 21:44:16 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 21:44:16 -0700
Date:   Thu, 27 Jul 2023 21:44:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: Re: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id)
 helpers
Message-ID: <ZMNHnmydMM1zExZW@Asurada-Nvidia>
References: <cover.1690488745.git.nicolinc@nvidia.com>
 <ad75a1f7f0b4d5b6d35238b4ae7b41db1410110c.1690488745.git.nicolinc@nvidia.com>
 <BN9PR11MB527660F2932964A47396D1E88C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMNF5vTTp2IRMsWH@Asurada-Nvidia>
 <BN9PR11MB5276C3F296F27696AFD92D0F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C3F296F27696AFD92D0F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: cd70e105-c776-4a02-9c3b-08db8f255151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1wUtZkaja0CxmVv7lFDspaD0pihNxFGIvNEvfL0zFI05yy4WYAD/VVSrIsQsB9GhUN354rbyyjyON+kIydHQhHe+CBc0TLJRTCShf0fMKjGM5CWTGPc1sh5xca5TizDzpLnnakMggPk9S7frzTw3rpc2MNuf68CRx+w5Uq8UHRA6fc6Xvm8wzm+OVya1Czk5PmTUA2bvJ+CwrHqbceLEfyqD329s+iUSKLS/ysyb+kMnsEutV5h9MvAkgEFLaR1O5vATDPLnQslO3yuVQhDo6MZdV2gRLRPjLzC6ZpMME9ohZSogcgDo9i+FWvUjE+p850BQyDIbPKeCFT3XLGhcvqOwy9Y+zD8U06ubzIvC8oYwSx5rkyQ716w/ezYGMY49uyO2avYerBzyxplHr+nWYgTf62/5SvX9UXYc5Yhlclh1iuNpIFM6mE8w+ClRIFrK2pW9NCkTaiioOsOAPYjVgUi6S60PqefmtpZn4PxnMc2/7xxZK4Lt8ph+O106XgTFfPt+P/3pc1cTbmpT2E38elnJ/gwob9fhyENLFlYSOzg8IotxhesXItUwpdqQ50fJl8sh7MxuYdOmN5lUHsoFpue38voj8ySST0j2hXYi0UL9rvRw+lbew8hvYq1tX6mn5IpIEPbuw2gS6CseksU6PcCMg40chU2CEFwXnAcu19k5PlwHyB8BUJVXgBLDyjJIbDQzzqFrvsdSj62fAlH+e/DBeSLv/nB0urKP1qi47N1o91PoWjZ60cyiuKMf+3b
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(86362001)(7416002)(33716001)(2906002)(40460700003)(40480700001)(55016003)(426003)(47076005)(83380400001)(186003)(36860700001)(336012)(26005)(9686003)(7636003)(478600001)(356005)(54906003)(4326008)(82740400003)(6916009)(8936002)(70586007)(316002)(70206006)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 04:44:24.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd70e105-c776-4a02-9c3b-08db8f255151
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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

On Fri, Jul 28, 2023 at 04:41:18AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, July 28, 2023 12:37 PM
> >
> > On Fri, Jul 28, 2023 at 04:23:03AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, July 28, 2023 4:25 AM
> > > >
> > > > +static int iommufd_access_change_ioas(struct iommufd_access *access,
> > > > +                                   struct iommufd_ioas *new_ioas)
> > > > +{
> > > > +     u32 iopt_access_list_id = access->iopt_access_list_id;
> > > > +     struct iommufd_ioas *cur_ioas = access->ioas;
> > > > +     int rc;
> > > > +
> > > > +     lockdep_assert_held(&access->ioas_lock);
> > > > +
> > > > +     /* We are racing with a concurrent detach, bail */
> > > > +     if (cur_ioas != access->ioas_unpin)
> > > > +             return -EBUSY;
> > > > +
> > > > +     if (IS_ERR(new_ioas))
> > > > +             return PTR_ERR(new_ioas);
> > >
> > > iommufd_access_change_ioas_id() already checks errors.
> >
> > I've thought about that: given that iommufd_access_change_ioas
> > is a standalone API, though it's not used anywhere else at the
> > moment, it might be safer to have this check again. Otherwise,
> > we would need a line of comments saying that "caller must make
> > sure that the input new_ioas is not holding an error code" or
> > so?
> >
> 
> I don't think it's a common practice for the caller to pass in
> an error pointer when it already knows it's an error...

OK. I will just drop it then.
