Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD246AFFA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 08:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHHaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 02:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHH37 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 02:29:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BD8DCEF;
        Tue,  7 Mar 2023 23:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678260597; x=1709796597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X7QtnGOdnSwtwZULokdqBxEN+W4PW8nsnoiuWEYL50I=;
  b=a8cHoN2dULjMrSIot5r8zeXD6UxiE2zRCCOldWqb/h2LH+kRsCsI6NiY
   8kOv+vgKMED8lQSxktcoPXPQSNekY90UvIxYOJO4e824S4PyD+v65auH/
   J6Z9HWLYYxBMFzX9KK5oiaDCZFp74VI9z6aSAPcz/D3fwJyDGcJVjlPsK
   OR2gE5OoV/3lU5KCU2iZaTJxFj2OIf/rVxixFhdlbbkAvl7HViMYU8Lk2
   HMJwb6Ra2ALbAuGDAFm2xJtJghihMdp0DXSR3RX3wINDUdLTmDCGj2PFw
   UV8hrNwyG70Ud0PL4L3lPvzinjvjAph0BjxfkFxy3nifjKRu8HjVAMZHr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398664498"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="398664498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="765921216"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="765921216"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2023 23:29:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 23:29:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 23:29:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 23:29:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 23:29:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvxryC4A0gpGIrxVjuFazynSfQcND0ZkEvz9uevYCbUSwA4PmzgAG/AIY9bzxslkI/X60/+PbRclWSo1UwEL3yePWrp1P3nJk1lujN+X2GxGj+zdjBG88dxYQcNViBhRn7Is+fCBIYh3X6pJAMHpK0w318WBC9sTemRYt1jZY/Xev1Fiel1vmOu535ZuSILY0P74xtsXtAE/Bv2ipSF5OxyrSrTENywrMuDuvBLWRfHPm1SEou8LVxwWJz/U6E0/NmGqjVoJm1PIFp/wWI2sRbU/PHYdAOPQ+J3PZZmanrl3GtdVMfWR9P8LhYSjRVOKRG9McBBjKvwMvxCZkEpPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAM7GqK4mgJ0eYiIA/+zXc+k84b7Y2V/2Qb2nqN0nxY=;
 b=E9gD3c653SsNxHwW4AIaj8SJyKDEAHWAlg+69lTr0Mfn4+OIYMsjJ2vnZ9V0cwwYmG+X8w2d2xJ2/OlPhOpgjyIMiQxWF7t809JTWYHGIGhdmcNNpoN8obFVdLQS1wB2elc6oIa7aHThvYnyigbEb3tBqxxqRWnc+iEa04REe/S0eAwier4z3B5BJUsIZElJoy6itYzGdmbm3JQabvqVyTRS2nXVUKDkO7Sw50cqOmDQt3p+OxVAkYFzlxukm7winhB6avFDADiGGFmlY05yOhHtdx2V+/yryd9Yc5N+J8nso3Aq52gt+iStMSBmmHIqUw5/3N3XYMtjF5/I6iZ6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 07:29:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 07:29:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZSLAPp+svwc7r8E67jgTrC/2K1K7nJ05ggAcaDICAAGeKoIAAvhmAgAEmR/A=
Date:   Wed, 8 Mar 2023 07:29:36 +0000
Message-ID: <BN9PR11MB5276B72B23AD976C1D50061D8CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAZLgSxd4AuWJSI3@nvidia.com>
 <BN9PR11MB5276F4706574CDA936732E538CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAdB04U96TojE0O6@nvidia.com>
In-Reply-To: <ZAdB04U96TojE0O6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7129:EE_
x-ms-office365-filtering-correlation-id: ce988016-0215-47be-d016-08db1fa6deb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWJYry6PEe3Gwwl9D424q94oWbObnf6EFfGbbK+rnEvK/MCJ7nQ/94O8Oew4nEh3irObcKrsAmUVNOQJq4wQ0KDeZa2dSmFJcSlTmuB8td6B/+KU5aDmwNMvCicKhlUjmBfIvnuVFse9Z+bth5E8Y+Sv767GNRq/UdQY0cTGE+fjB09DZyn+sZHr8ePflgdpISrTxcPjKq6wLA7osUkzkA4sAGlNDyEmLmpjEk92zVR6lWx1n2spXHJOkUvT8In0OYlKf13AtRVtQRQdFJrVl7Y4vCaDJ1Nm7hCF9rSwxoFDTr/wb6ZaBGf+ir5uIWBG+hTK5cos5D8SZlp+V7cNjeEz0FPWMZbkCiLKubjjfIRAH+CHTwZ/7BPqc0f+PXZMo+O7HzHOxGCqDZjb70yLwJlKbDIpNOf5UbMWWwFgvE/QNZW9Wa5RKvUrIYpsQnoUqCzma0e841KK706VtWma89e7d+FvPQ5CGE4aoaYVCeEZc55CLKy6xklteo28ZgFYRliJ4LkOEi3UbUNYYloAESPluxrtmODesv82i/sM7UNxUD9NxnhUaJvoLFU1NFVIlt7/gygwaTIQb1h9jkANPRHdiJawix8r/3JQr8GFQIf7mBibYIDN4NXhHF+apnQZVDZdDSIpaZJ7lGEj/N5HFPmh7bv6AZ9wwujRkjwCtw7WKiRH2yUWfLUchqte8nTZWv/v5wh9iEsxhxxrtG33wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199018)(107886003)(9686003)(33656002)(86362001)(186003)(6506007)(26005)(55016003)(5660300002)(52536014)(64756008)(8936002)(122000001)(82960400001)(2906002)(4326008)(66476007)(66556008)(66446008)(6916009)(8676002)(76116006)(66946007)(478600001)(41300700001)(7696005)(71200400001)(83380400001)(316002)(38100700002)(38070700005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V4lrCkCT+Ikt+jkDWaCG5GX32sPKGt4vuA8YY6YR3RbN2GzyE76BmKHzCCky?=
 =?us-ascii?Q?j5XrdFjh7y2XpP4O4DFvPPLeC06E6jGO7OASQaF/Z+OLZJ2jAM5xuAYwiOTS?=
 =?us-ascii?Q?SpByaGyvMG4sgX904THU7YKE2IsIw/3IsMq/7pzNeq4twc5wyfynv+u8Isig?=
 =?us-ascii?Q?ufSIJ9DRkw5duY0Blw1fXnTBSLdnrDlj4ztVG/UlW1F1Y27zQ39Nq4OgsK6e?=
 =?us-ascii?Q?JN9WHLrxJdk2Uvkzp/+pipiZ+/PRVJ6GTd7d41qnuPwvnSZM6ulHN5nhoL2a?=
 =?us-ascii?Q?kB2SSkoeqa5epOlaT3aYD9Vaez/SuS8X89gLRJivK88M0krSi4Gtv9hl+glC?=
 =?us-ascii?Q?gkVNYNMFIIL24AoOkOr0MpOxAJ6ng5jkSPTAViBOv59J6EIkb0qm9wA5E8kk?=
 =?us-ascii?Q?cpRLc/LPbHYm5NmvR9pA9MFqYAcQ2fQG74ehdz6eNsmVtZJs2H2TLRhzWMTN?=
 =?us-ascii?Q?+wGM139ZAH8pdpxsfOEWumRjGLr0Rm6f6UDK6XWDVuYgnBIVdtDS1lkWhQ4V?=
 =?us-ascii?Q?wFL+BKubJ4QZp7VCpz34dHkCFbqmZIt2oWtkJNJX5y0+ac/biyB+oNkdfZE2?=
 =?us-ascii?Q?XGMtTcSb6g24yANKqk8lMHh+Y8po5i+4CHcHUQeXjuAWcYCL+aonrPXOgbgz?=
 =?us-ascii?Q?6lXWfR9C6pZbV71WKKzIbQn2lY+CkcOEUYbk6NI9ivUQI84OcopKuk2ETRcU?=
 =?us-ascii?Q?+XJr/wbKkhVkqlno/ghQD3ssOHWXOSfKD49GLo7D8sl6JuANaC2PRsbYjMS+?=
 =?us-ascii?Q?6l2igqD70uPNRVFLoQWQaQbZ3CwktGi1JOy19DnbPyrEoG1+0WieVne75wvE?=
 =?us-ascii?Q?faZ35KpChc8jAz3l70uGBDobYs7Ez6vcFVaXpcIBofbsVO8UhbkDjQyNT9y0?=
 =?us-ascii?Q?f4goIiVNtmLBJdPIdXi/TbHRQsUr+/ALSDOgWtv2Y77PxdoOBHm7TkeA8t/S?=
 =?us-ascii?Q?/Xp2hbGlYFo0LJOp3rOD4kCbuq3KSu7tO3+eF6dq+kuEgjG9QICUkmUez3vT?=
 =?us-ascii?Q?1/1FpFignaUCoEjg50xHW9iKWHdm7NF6guRvrAPO/wBPLJ7ki3YIf19fuskE?=
 =?us-ascii?Q?YgWkTiXGBNVEEYLRevPO4e6aImEuuQt+/n2kUrw+ek0m2bQXUE1/UJzC5gJJ?=
 =?us-ascii?Q?XKTZZ/TtBfYXwivftwAW/oeklIqf4JshN2WLjlrXW/MLSwHY9ztkr2YSe5Sh?=
 =?us-ascii?Q?FAt5B8nGiUXd97Aj6jxHGSfxkgGx9OJuIgb5785BLjtL9aRcAPSIHeSFENBG?=
 =?us-ascii?Q?gl2I6KhXQ81hDVNEyfi4xOHo+89KUa9RZWxfCpfqPdimvUrTMMjiFgyj/OaD?=
 =?us-ascii?Q?7cLwQlmXc120tMKlDBec3sOD++AZ4jIz3h6grzL19fyomv8MaTDFT9XKafD0?=
 =?us-ascii?Q?MVnnDC0kgsvyjXydkXH0BIkTbwzG0aULDxSaaaoQe3ODr07AXOrC0GrdigD/?=
 =?us-ascii?Q?+Vy4zni6fEhE0s+aXf+zp6W179ZFCT2Yn1nNzBi2UIcBLsQ+EuqcHSahouse?=
 =?us-ascii?Q?tHigXB4NLp9PCrLsF5ZwVpAw+2NvuH4lQXh8Z3IRbjoGzq91i11VjGLnuO9/?=
 =?us-ascii?Q?cTBHwZaNVVVFE4BHYjbJQe5H6461mzDJOKHP2AVK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce988016-0215-47be-d016-08db1fa6deb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 07:29:36.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnj1eZJo3BjL5fXWvAd4RTIr92eJLJzipmIPVIvQ7lIPVR6K+mxgiu4c5ZRrhpdGOVq4GeOYay/PGjKnN+MCOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 7, 2023 9:53 PM
>=20
> On Tue, Mar 07, 2023 at 02:38:47AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, March 7, 2023 4:22 AM
> > >
> > > On Thu, Mar 02, 2023 at 08:01:00AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Saturday, February 25, 2023 8:28 AM
> > > > >
> > > > > +struct iommufd_hw_pagetable *
> > > > > +iommufd_hw_pagetable_detach(struct iommufd_device *idev)
> > > > >  {
> > > > > -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
> > > > > +	struct iommufd_hw_pagetable *hwpt =3D idev->igroup->hwpt;
> > > > > +
> > > > > +	lockdep_assert_held(&idev->igroup->lock);
> > > > > +
> > > > > +	idev->igroup->devices--;
> > > > > +	if (!idev->igroup->devices) {
> > > > >  		iommu_detach_group(hwpt->domain, idev->igroup->group);
> > > > > +		idev->igroup->hwpt =3D NULL;
> > > >
> > > > hwpt->obj.users should be decremented here instead of leaving it
> > > > in iommufd_device_detach().
> > >
> > > It is like this because eventually we can't call
> > > iommufd_object_destroy_user() while holding the locks.
> > >
> > > So the lowest function returns the hwpt up the call chain and once
> > > everything is unlocked then it calls iommufd_hw_pagetable_put()
> >
> > but don't we have unbalanced refcnt poke?
>=20
> Yes, the refcount should be incremented for every attached device
>=20

per device or per group?

Now it's igroup tracking attached hwpt and each device holds a reference
on the igroup. Then why do we want to further poke the refcnt per attached
device?

sounds it's still clearer to increment it at first device attach and decrem=
ent
at last device detach.
