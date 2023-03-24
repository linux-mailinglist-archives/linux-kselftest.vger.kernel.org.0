Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0AC6C82C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXRCt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjCXRCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 13:02:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C61E3A0;
        Fri, 24 Mar 2023 10:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEfsuiwTdUY7SiE9eVM8IIIp4KzHKHO74fNiDhvbE1HOrxx3UucVJcho3lh6TQpR33Pe8x65aEj2k2la7d8eCn1CluRIUj0WcSPFQTTlxGDcBFnip1hzCRw56YoEU/erToevs1kTruPz3BftkwweYE6/8dMEKditwAlAMjE9aAX4CSnRiCIDG3JWM/I9Yk0uH9nD8QciKDT7Wr8jaIcU2LNFwxpz0fuPnkOfWsU7lp49/XT7BjUVM1u5GWNNeL2V50YTyZIu1unoMJfWE06mj7VDtXPJbEdbgo/EzM67PH1DsJ1bFqT8v2EWS9xW/U5fs81x+v+FAAm3qY17Lx7UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9PQCHWDHdGkLou1UviUd8lskvK6zdaVw5DvphFLPzk=;
 b=QyHSFK5LXCXqcpP7yf4eVomloZroe35xZJ1Ag24+JnhXzw/N+30aW5VcELnk/qAD+BF7j1E1idLJirmYss9avenO8kNjSn1slUfCg3qlxZXlyIWVUhE2N6k3uql70OIXjcgv6Y/hvbHqhYnfxsjGzJqpIf7PeOOAxPI7DNuLdSjLJTi5wLqhdJoQ5JW/FNQHI2nc5HsoO+ZoKak+v9ETyA46fTzyK2XWTVg2MiWJNwnWvBVB1DJzD9OU31JLQ4I7GWoMyFJX2N8RxRHp6NrsAwwepAM8kUqzVW988WXlZvyZRIAdg77fAfaYWJeXp/r1blK9L+5cSf53U4FQ3QRd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9PQCHWDHdGkLou1UviUd8lskvK6zdaVw5DvphFLPzk=;
 b=EhJFIP0dg3iF+1b4rdN7FbfjeCxgc34qd6x1FU0qyyI3bUFm9/W++VjGErrn1b/PM5GpIGcx1MuJ52RGAJRyiwyeLfzCMyFWV/Q2BM8rLdTAVglBXs2KxGRMzskAmQ3IfTxILqelHRZE2r335KhzbOMEB2rzT189Pfd5SDKB/2kdqK5n8GxvodlNX+ln7WgzgBsQU//gUGrx+jeYD8jXUSjqT2o84ZZNgHVO7bxi+zp2Gu9uSFGOQomPfYEEiBRDAFBiTMsVarAI8Fkc/2luNjwsZ/KdSHmJooo+txcCRf+35gnkyipxwcYab4MSaUw3EUxwpv5SVi00mbbvIhwJfQ==
Received: from BN7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:408:34::29)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:02:45 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::38) by BN7PR06CA0052.outlook.office365.com
 (2603:10b6:408:34::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 17:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Fri, 24 Mar 2023 17:02:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 10:02:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 24 Mar
 2023 10:02:29 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 24 Mar 2023 10:02:28 -0700
Date:   Fri, 24 Mar 2023 10:02:27 -0700
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
Subject: Re: [PATCH v5 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZB3Xo576l33OH/S/@Asurada-Nvidia>
References: <cover.1679559476.git.nicolinc@nvidia.com>
 <2c3fa7a21373ee10af7cc9f8c370945a08341930.1679559476.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E7E2BA88DD54DC5EE99A8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E7E2BA88DD54DC5EE99A8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abbd983-d4c5-4670-79ac-08db2c8996bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyvl2AaPF8Z5eyCnJMV0FOcEpLWN1OTjoujhpDjPtdZ0S6bNpwlI7RNRv+K2fJbqRiwqfJKmKfzelxKiw8RwWh6RZPJvUQ2cRozNq7gDrY7/IYZCDXBdaN6pn6EALC2RhwUg2m93mIw/osWYoGto4YPY7WGwPFRqluTHhFyfBREwWBjO89zWuj51uf1HVA8a5q9JkdN7CLtM6uKLbe91c6w6yWZNa3DuxNFbwY77fQOjAfVK+DwHa3e4QrcVs7jqt7XsbysAx8PzTiMtY/uI70e9C46tmzO4DoEJgvPgUFQLPjPf779oJTVhAw5TVAuBClziNRJSFwz8BeSuxITIsQBImHWa6/T7vkuoEFPoHwTXBgOTCSec12JWbvdhIqwI7HRBU6tipUsE+b0O2/sD7ISUGpLVa0dD8kdcPjOHG3ZsiitFibes6QqCCJZ6Tyks/3Cfzg2QBpdzYCP2uXZgYhfJmruE3B7qX1ure8o+IzJdYru7AmVnsAO8cMEOyXOeMfgVr2byYqJrqqtRc/NO6fLSoQ69JzTsdQkOlxzMbCCnSWRDxEyqJYO+wV7wSLIW0atZ2E3z1jSo0IbO2eTO2UCAY8LyzsvIh05BAFROypd/JHj8Ev1mTPaBDc6SWs8GevfhmOmRVkjpS3OoFOm+bc513tFGkEcm9ltnR7+t2kTs6Rkc4cgO++8FtY4LFarH56irJpVv15yVoP2pYHAE9A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(7416002)(186003)(8676002)(8936002)(5660300002)(54906003)(478600001)(70206006)(4326008)(6916009)(86362001)(41300700001)(47076005)(26005)(356005)(9686003)(82740400003)(7636003)(40480700001)(336012)(426003)(83380400001)(316002)(2906002)(70586007)(82310400005)(55016003)(33716001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:02:45.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abbd983-d4c5-4670-79ac-08db2c8996bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 03:02:46AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, March 23, 2023 4:33 PM
> >
> > +int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
> > +{
> > +     struct iommufd_ioas *new_ioas;
> > +
> > +     mutex_lock(&access->ioas_lock);
> > +     if (!access->ioas) {
> >               mutex_unlock(&access->ioas_lock);
> > -             iommufd_put_object(obj);
> > -             return rc;
> > +             return -ENOENT;
> > +     }
> > +     if (access->ioas->obj.id == ioas_id) {
> > +             mutex_unlock(&access->ioas_lock);
> > +             return 0;
> >       }
> > -     iommufd_ref_to_users(obj);
> >
> > +     new_ioas = iommufd_access_change_pt(access, ioas_id);
> > +     if (IS_ERR(new_ioas)) {
> > +             mutex_unlock(&access->ioas_lock);
> > +             return PTR_ERR(new_ioas);
> > +     }
> > +     __iommufd_access_detach(access);
> >       access->ioas = new_ioas;
> >       access->ioas_unpin = new_ioas;
> 
> Above three lines can be moved into iommufd_access_change_pt():
> 
>         If (access->ioas)
>                 __iommufd_access_detach(access);
>         access->ioas = new_ioas;
>         access->ioas_unpin = new_ioas;
> 
> Then both attach/replace can end by calling the common function.

OK. Will do that in v6.

Thanks
Nicolin
