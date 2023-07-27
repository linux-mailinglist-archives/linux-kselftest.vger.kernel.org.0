Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6BB7648EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjG0Hjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjG0HjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:39:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DF126A4;
        Thu, 27 Jul 2023 00:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0LEeds9BsQQqrHfs/Dbz5jo8JL/QcbrE1VijLQvRMwBm7AplhqrX6zCERTqO2ymtwIs0WSBr3HfQwBBUUJi6j0lb0M/cKNvkHcoyn8hdLXj6yX1ij8yIw3dzezK5OT+zTrsZ5eD28t8aAUuMhfTdhCU+/LuEa30gQ90i4WOXzFICBStbBoGdieT70ZFsJLpGHRGVe7Bp7YTfyfG79nBI33nrEXf+bxQ4XL7/NKU9j1eUbmYgpOo58AxLCeG/LEG0NIliXA8Y62ZSgIZ3l4q56VoUQrkV+yCk6nX23NA/lfRrmL10a8U6M+xVonK3mrdA+QU2nqj7LoBM25YsAGAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4CMFcaQCMjFClKLk4ZoSeN2oWqn9dHUHEDvVNU6P2o=;
 b=Bh1yFYGRrBazacONz7kcFsiIk66agj+2LkoLEkJQWuZJaCkmWV3Tpc0zDsoCsQwu/EotcauJSE6ui0fjWXTh6aCwzwLTH8jqiJGQ2d1TYoz6nXZX/wRVShM+47Jyt7EpMJKW3pb1S14Bdmun3sgrUZtGoUZVc4SI1WkdF2kRJZoeAIsUQ8q0D/wfaKPbntbAgkpsCzzbZWurrDuL275TrKzx2V+fIAVZlrh7u8/C6S2xg+X2AmIxnaDadr2uF/vw8cvDHnBaJt5qLoLRqLyBJ+N0/NnU6BYGX/oFklbEnPSszLgDKOT9CtNMwNlTzNfGiJBEjb9E14UPDl4VNInKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4CMFcaQCMjFClKLk4ZoSeN2oWqn9dHUHEDvVNU6P2o=;
 b=uQuI/UWjAP69KanB7ZcVR8ri4kgbJevKQ5VpMSDrNJmbF0cyDOzxbFASTwI4ZpUoBy3uRkUUBC+D2lIavB6gTpRym61Yv2qmHEYEoZofytjtPIu6HEDbOriNLVy5hzL6WNk//wGezpWKzkb1ACQ6HiaK+V7maVH8JRdnxhGsSWft/qMn9/B93zcG6qxrP+ZtdK9kbpfQfA7y6CBlCxdPQbTfuo5OcJzWBXELVdkzmAIoF+qTVaLGc/kJYUNRU9xcY28VALvZ5uqWQqEhO2olwjJIcxx/nppdeX7URw+c1hd4HhOnMZqvxn4RmkaGmnD9Y7nI2BX2If/qB59j/rfeFw==
Received: from BN0PR04CA0143.namprd04.prod.outlook.com (2603:10b6:408:ed::28)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:30:44 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::14) by BN0PR04CA0143.outlook.office365.com
 (2603:10b6:408:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:30:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:30:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:30:26 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:30:25 -0700
Date:   Thu, 27 Jul 2023 00:30:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <alex.williamson@redhat.com>,
        <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMIdEMED6ExVo/Qr@Asurada-Nvidia>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
 <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c66ba6d-8ab9-4e37-022b-08db8e7362ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcSivRLNR6LgzGRufPRnI7+JlGM5i9Q674GqqgYgKbm9TTTlegr5qZjKOlxGmFWdgJVszTgGOa0EBNnDR84RRjT/oRPXRwi9YWLtxpj+QfZjsVijBUiCdY7eiJTF4IZIBTTO+W/LdoGhtOT8P9acsWFqNmCiOt3vBuKet4/JUxxjUtYPpnnNCsm24y3CYWoBbyKxoh4am+Tokb5eAt+GY3LSgNz/UrJVruAp+gbQWn0X1QtZ371b459KaFfjCAnLtol2A19GRFX1qvZ/IQnwwHXWNQEdeSbz1PA81ne8KStTQ7MzTLNexjb5jeRiI2BSDhT1HX8TnBpYPcothXXqfYXgMZsn3z67vayueVBiQOrVCaCr4drkLk+DIUz7VOk2q114RM1U3OCJnnLUAukqUa35s48a7S48uYrjtOiQEYFVio1gfSR0/ScuvuEqAMzo8tFa2jEnkuT6rTavrHLLoQpENOwcsaviMinlR9Ls/O8vdi8bTUD2wo23PcNZBPtp1vXlX2E01LK/KL/+nw06vRMEWWV0AK/ZtXObO8+xWRr1MrmrocsjBh8ykoU/nK3IOjqYHCz0JwQxoA6xu929A1N5CYJQt0135q3KFgqqsQL9HzSRpAhw8ONqhUvjA+xEvwGKIT8488oUXnUh+AhyW0VsrxphMTThU3Y8MhVLutkUcwoL13FY9uSSZcxNZIoCxvwN+qayEzdWHqStqtq+vCpHvTYv2I5gelG2o5TLxrw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(82740400003)(7636003)(356005)(47076005)(186003)(336012)(83380400001)(2906002)(36860700001)(26005)(426003)(55016003)(54906003)(40460700003)(8676002)(8936002)(7416002)(41300700001)(5660300002)(86362001)(6862004)(478600001)(70206006)(9686003)(70586007)(4326008)(33716001)(40480700001)(316002)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:30:43.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c66ba6d-8ab9-4e37-022b-08db8e7362ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 07:59:17PM -0700, Nicolin Chen wrote:
 
> > > > +	if (new_ioas) {
> > > > +		rc = iopt_add_access(&new_ioas->iopt, access);
> > > > +		if (rc) {
> > > > +			iommufd_put_object(&new_ioas->obj);
> > > > +			access->ioas = cur_ioas;
> > > > +			return rc;
> > > > +		}
> > > > +		iommufd_ref_to_users(&new_ioas->obj);
> > > > +	}
> > > > +
> > > > +	access->ioas = new_ioas;
> > > > +	access->ioas_unpin = new_ioas;
> > > >  	iopt_remove_access(&cur_ioas->iopt, access);
> > > 
> > > There was a bug in my earlier version, having the same flow by
> > > calling iopt_add_access() prior to iopt_remove_access(). But,
> > > doing that would override the access->iopt_access_list_id and
> > > it would then get unset by the following iopt_remove_access().
> > 
> > Ah, I was wondering about that order but didn't check it.
> > 
> > Maybe we just need to pass the ID into iopt_remove_access and keep the
> > right version on the stack.
> > 
> > > So, I came up with this version calling an iopt_remove_access()
> > > prior to iopt_add_access(), which requires an add-back the old
> > > ioas upon an failure at iopt_add_access(new_ioas).
> > 
> > That is also sort of reasonable if the refcounting is organized like
> > this does.
> 
> I just realized that either my v8 or your version calls unmap()
> first at the entire cur_ioas. So, there seems to be no point in
> doing that fallback re-add routine since the cur_ioas isn't the
> same, which I don't feel quite right...
> 
> Perhaps we should pass the ID into iopt_add/remove_access like
> you said above. And then we attach the new_ioas, piror to the
> detach the cur_ioas?

I sent v9 having the iopt_remove_access trick, so we can do an
iopt_remove_access only upon success. Let's continue there.

Thanks
Nic
