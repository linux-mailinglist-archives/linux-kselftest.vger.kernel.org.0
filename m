Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61676AE169
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 14:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCGNx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 08:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCGNxj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 08:53:39 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA615BCB9;
        Tue,  7 Mar 2023 05:53:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bzwj6FXmN+ZeL4d4BHEHY3uA97rczG4yu9yhJCBJNDOgr0jU9Z+u3XC9xdqCKYtkEp/4hXf4sEHjesPrYGbsCSYxZ+j/k2j6yxTfhui4h4de5xZ2Ps6XzjQvAMxS9XCPU40sSKIND+hs3VBmvNbxnOQ0Le4nJfg97hwVyHpz33YR04T2kMQbXgIn5T9m8Q6hW75afXCqpQluxXiNvvB2Kyqr4WF2t7OEty7NMkpdcgI4/Td0y3Gdm8hi24IFi9BQlxymZXTlZN47TcH853LFhBVfmW5dCQXbJk+jPqfyuSoK32PlnZ2rXddnIRE1xcYyMUiTKq/PhpQc+9yTGZZsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlH2Z1l5qXYt6ETr2rFpHDUc02/rVRhAIuHVgS048A8=;
 b=gzb9RxlsvgBZ0KHHAujjTV03O0L1qZ3nnH48r28dh86up3H14xGDaOp6a2sjaoGQmEc5rMhBBa++B7CECwo/bYeoerYcqwl2CCAgMXdX/7QdxLRJBAIjMT4W5E72bOTbFw6QkyJf3RueoN+nizxWIVnEx8aBRKwAwu7KUDqhky8PiOsMKymPjRI6QU96PcLKEQaT+Oxn1++dPN2pSkF/KK0BBNn4A5IaI2RjrVmx7TvBZUJwAG12gxGT0BrM3G/AOhACzhF1Xe1w/+62eYiR+TSXh2Cwa3xy9EQvnsqYU/PtMGePGpVgdHAW35oK52AvIA/sow8uFLEwIjIiyMit9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlH2Z1l5qXYt6ETr2rFpHDUc02/rVRhAIuHVgS048A8=;
 b=FO6AuUjTOocalkLDvaBABCs+3KGgUIuUX7/LOxrksbTBlJ5wAAPUzC2ord+CI+R09kAtuCKNkVkOYl6dd9zoRrWNEas83BxFJy1ztQnKWHpL2xDLWZGeR5ztELcrrKFM1sMufyP2wMS81euVqlSXIEqlaHcWAV0ywVSYfWxeODtyJxo/+HftH/264P1X4zhFI7gFSTbGL5mF2iE/fwe776117nYVjokwcle6o8aFfnrXa99G9zwSzWTmNu01Bkgsl7Aq8n0/95Rx3oU4f1GTuNsSrc1mQAX3aKL/lI5T3YtZoMTqKUJt9P338FYQERavzIFdbHlbJfbgZDv/ZYi6VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 13:53:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 13:53:24 +0000
Date:   Tue, 7 Mar 2023 09:53:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZAdB04U96TojE0O6@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAZLgSxd4AuWJSI3@nvidia.com>
 <BN9PR11MB5276F4706574CDA936732E538CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F4706574CDA936732E538CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0044.prod.exchangelabs.com
 (2603:10b6:208:25::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 200bc3c7-1aaa-42f2-d36d-08db1f1351b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtS6SR1eIbhg5Hh9Lh52VEIkSJTQhRGZbapbJtxlNF9i23iXQYHNJSRj8/3xZMw5jRFZT6zagzgGKvTDfnGaGPkumvwGjZ+SOeubUOuMN7pEm0IiTo4AmeYGpOI17XzReVATF4C57Eq7B/V5YGB6dyI6UJ/BynBM7p/P6RSh1tde1piUsw+DqmhFlIqaPQeUuDPvnJ0F6UhnTP6QJcp6Q8Vu2rVKlvw2r1Thf4MkZcZ5gPDLU0UUczaYfQ1BhAQMLX5rq/r3Bo1WIvSpu3iXb+m6Ar2GmNWrvl2hVHi9Kox5+9Gssglm5DG0w/Q/HfyMhUe8HHU6Gv7O3cJgGt0/fI0LCkz30ucxp417YTJB6OKq7oT3HtXD0OPUHLZTM0qmMi5vuGPI0mfQ3RHQ/NgGwlFa7aZltIoGTDtzS8+sL3IS58ItKtPV5tYwlhTV0TdYqCG+ErMWtJTJQYHZWpnBpbA7O4o784BuDRVknL87hqUQ0aAYUtINFMPXBsw107dLxxOt0NF6G+f5b7G5B6CbD57OQALMieu2R6zEYSBwfUVJ+BEEJQ+3r13XCVwPTC57P4ohWf3AtL4dqPt49b60MYHOmPmz6284gQUcVD8ULa2f0GYTuzyRc4cJh/1ewKSbzmSsj+ibZ2KeIDDSWqv5eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199018)(2906002)(5660300002)(8936002)(41300700001)(4326008)(66946007)(6916009)(66556008)(66476007)(83380400001)(8676002)(316002)(54906003)(478600001)(6486002)(6512007)(6506007)(2616005)(86362001)(186003)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1969l+7WDxLZEBU5Pj8qGf4mbv7gh9qTQ8uzHDppUdgw9aHJ812fDFzRX030?=
 =?us-ascii?Q?HNTFvqzeMUSIo4F0xDN6tJovTghjSEoVhxaJXRcb7tip4EYEEC37vChH61zC?=
 =?us-ascii?Q?IJFNBh4N4CONm1ZLXnbkv+3/wGpUGQCyea+xsQtJ9YifNJ9Ez9JJzQ34Bv8J?=
 =?us-ascii?Q?+Gara0QP3bKeIG7ni/KAshWhoc7EJhyFFHuRvGCUiv6cIvljDEqRh2Aebi1R?=
 =?us-ascii?Q?Il1XdWfCCAnacRnkeo+y1PbzAn/HFQxgq72zWgsqhWhrxfzEp7fV3KlKjcD+?=
 =?us-ascii?Q?iJI3QCJIhjNcFsBrDHXyo4uc5sBpR17WR6jMImm4rJFRe9e741LsR2uGulnR?=
 =?us-ascii?Q?G7W3t02eioDGzro+8dlQ4h2NWrqc4dZEsr2gdJrqxQ60/uttd0hl5X42KE/L?=
 =?us-ascii?Q?3wZZdR+TXGWF02STEPF9Y7hTZiRrw+WvlBSPwDXpOUzIlY1YHVPar7qaQ3QB?=
 =?us-ascii?Q?Mn7vHuWNDufwc+2A9GYlWjoKE+c33QdXlsYDKOwDJnL3yGtSa2a29+cu0Lyh?=
 =?us-ascii?Q?F8vFp710NX857/TcniIdcaAZaVfhPd0X9vkzpjvusvDYK6I9V9kzFrRmEKlm?=
 =?us-ascii?Q?d1hHzfETXym7KPltmO10aE5VTxEB+NrrVisszS8JEgQlouDoatYHVhAF9gDc?=
 =?us-ascii?Q?sAiMWLaN7tyA4zJpkJTCAOZA+hNsnfwXWG2XYqWGJ38cTvwtKgv2itX/XUlb?=
 =?us-ascii?Q?L395NWK5GHSa9Q+jHwmgf6j74ZXssK09lcH5SfyrpsdS9Hcw/IGs1UjhYK4P?=
 =?us-ascii?Q?TygHDIURRfvp5IhwFBTUh08Sj3SJY+SBHT8LXRZxhSABWjt8j3O9ERHhiu0B?=
 =?us-ascii?Q?jiVwdwypopKFzJm84lc5dcz5/7andpufjoKgGy9zYXGVKK3G1qQ58IRljgd4?=
 =?us-ascii?Q?N26WEc+x/5CcGsAOmnTbgAXNpEhrR5E976xpaQXkQpwieXQvQ7fONMwPJlha?=
 =?us-ascii?Q?599LH8Y2YWhYK5bmXfKxQhmXSBKbjWFiLGM9P5/2esR+piikSXfrThn14d0E?=
 =?us-ascii?Q?+u5O1i8axXuhRCbW2QEDROoX/4j5Z4WQEWqlihR5peCQ5nrLfRj2hD+iKwcJ?=
 =?us-ascii?Q?xOTas5rtb/rKNySUlS+OcsoTskW493sT9vO40p2CToG2ys9D6EzdxQLMYGJa?=
 =?us-ascii?Q?N50wp5XD6ULhQuwUpsS1wTBPzLrZBT/MRF6wda3N69+vny6w+maS+aHHiNv5?=
 =?us-ascii?Q?T2JGNfOodKPurMEDmiSPcjYrYMhy2LDzR6rsPiQctnxNr+AsR5zYaqeTDdS0?=
 =?us-ascii?Q?/dprwIR6RHprbG+/OCFvmAofiExB01Fz74R0Jmn1a/OC1uF/4jn/9d/ooysE?=
 =?us-ascii?Q?Ogstuh4cijsMUb/eHg/03MITlTxsOiWbQ+vJbpk4G0VMHCqMPHykpoQrTtxM?=
 =?us-ascii?Q?a3ffnyhhyMcCyygykC/ZrvpjES4tfRBKzDk1pTRBVWILiUjuWrv+W4+KnMgU?=
 =?us-ascii?Q?ghd/Fr9zGBJt9OywVPsKTzML/1Gax5Gg4Gv4Ic+yO27+AGwEZ0QpE5tvAr1v?=
 =?us-ascii?Q?rBi8f31JpGpQtp1CB9yWk6Clf7OIV6T9c9qaPl+g6ZTYYdlliV3gZyBzaPD/?=
 =?us-ascii?Q?xA1jNC/RV/yhNjQDold0akg9fo60cMgBS4kQzYXm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200bc3c7-1aaa-42f2-d36d-08db1f1351b8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:53:24.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrvJKEOyrBt5AfudRC9P2BSePBPvfIHG/pC/+K4thR0Dr98PkUMCmfSdqN7bPCjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 07, 2023 at 02:38:47AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 7, 2023 4:22 AM
> > 
> > On Thu, Mar 02, 2023 at 08:01:00AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Saturday, February 25, 2023 8:28 AM
> > > >
> > > > +struct iommufd_hw_pagetable *
> > > > +iommufd_hw_pagetable_detach(struct iommufd_device *idev)
> > > >  {
> > > > -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
> > > > +	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
> > > > +
> > > > +	lockdep_assert_held(&idev->igroup->lock);
> > > > +
> > > > +	idev->igroup->devices--;
> > > > +	if (!idev->igroup->devices) {
> > > >  		iommu_detach_group(hwpt->domain, idev->igroup->group);
> > > > +		idev->igroup->hwpt = NULL;
> > >
> > > hwpt->obj.users should be decremented here instead of leaving it
> > > in iommufd_device_detach().
> > 
> > It is like this because eventually we can't call
> > iommufd_object_destroy_user() while holding the locks.
> > 
> > So the lowest function returns the hwpt up the call chain and once
> > everything is unlocked then it calls iommufd_hw_pagetable_put()
> 
> but don't we have unbalanced refcnt poke?

Yes, the refcount should be incremented for every attached device

Jason
