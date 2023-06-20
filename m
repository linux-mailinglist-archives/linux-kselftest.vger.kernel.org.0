Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271B73613B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 03:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFTBnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFTBns (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 21:43:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5510124;
        Mon, 19 Jun 2023 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687225427; x=1718761427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q44ogXCoEr0kY2bJ5DhpyESGe0Y8GlS1blIbO9GclHo=;
  b=PdQbwta41mxd6Jm3JwntrVd2EtPB2iqtdZd60WCxYc4cmrmBm4ODf9Nm
   xFoLdgYX/oeqjjH7vSymTO6dV+EeoE9Fduo87zmJLnXqjY21GFAPkWVbO
   xnnNmYQZVMVZdfruXttMuE2vnZ3mH4x4SdezQN1i1ajOXbgkFyix/CjVu
   3DLVsZUZUV+cTRp0xh2DkWZ/uS3yZ045hdT+sEaIL0SCXNoKracHR0Lk2
   i4Sd8Fm0LsS1wdcNnr6n7WRNh5v/RBAzQRueSJbayw9fXA/fHbnwVyvc/
   L96Dgq4OaRNo3lFQdAWrSA2VK7FJmKxhiD8CClbhaI+2NSC0QE8kEm1nu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="340083529"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="340083529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 18:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="960585513"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="960585513"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2023 18:43:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 18:43:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 18:43:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 18:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCf1M0/PsbWrSSy1k025bvp4AgIh5GQVD8/jILe1P8H/+yHFZLVh/YH9qZVt8gO0RCngZhjSdelXkieIOC7g9KaUPlaN66Oo0gIODVGmPjK0+NdSE/HiAMebU3LKCUAOvZtsBiu+I6zqjOEm626ThZBKi3aR8LZW+e/ZxGdogWSHl+HhFakbepa2+NLdAXSDysy4yFHPEirCUXyluYSqB0pdGBylgBONqD0XcHncLatYp3Grc56VkDQ2H4VPjN601QgDje67b32pO0YrNsiCHTFv+qQUlo8fz6V475Ivu4Qb2UKaiJvyJJndmQ+768X3Rlcl4Zo9qA5banN/K8QwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly/+w8CgKd4Q3lamohXvESocWDOx+WLuCgAt0x6/VZI=;
 b=SBfTw3QnN348M1f/7iYajk4YgLeY7WKcRlKXnDnj8kgB8RC8GZCd40kvEE40kvdFvJO6il8X12PnMRdl4CVLRVtlQ75Z67CB1GXSlAA3nCMfg2peeT+TekJJoPXIlPA5FN90N7s4aiRlkKIJyfLCFSrAIHpOGhPpj096hBsNE0Gw+MvpI/opDGX8Cf8MnqwmRTdoYk1qFu2qYigPsqpeRoARijF7mp07VNQadiSy8VI4WA+a3XiDH/l9wVRaKjMa1T2aakcEEV/bfvDUjeq9IYCOX4ValZIESPoPKKnH76PsCIDQBj0aDPYRZXU6JJ+ewkdSXvyZSTG529C2Y00tzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:43:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 01:43:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOw
Date:   Tue, 20 Jun 2023 01:43:42 +0000
Message-ID: <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
In-Reply-To: <ZJBL8QLLBiwRsUSI@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6963:EE_
x-ms-office365-filtering-correlation-id: d379b77e-b02d-414b-130b-08db712fc785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xh3HR/IW7hiaWajoGrIpDrGR84Ueku7A9qfvtpx4jq0HjqxfFjZoIUGD45X3YxgU+jJHVgr+qisD35ZYqqiuMKWQuvv/qq6AUgvXXhLTNGbgxg4XS1a8G0lQFzghzEIqIvPccHop3t05Dls9IKWvuA+xBsXJa829tIWKMzo0m1ryRy2iad0hz75/RS54VB2rhKye3JbE1Tnsf0Ys7JbvgFYNQjHq6yXxUH0aaT1OC5qLlfwASpKsQBA7sSWXxQaP6/GR+dRxltcuw+PogrwxCv3PCkrxzyiuX/iRm17ScJ3UUmqyqovI0SMywAuKF2ZRrJuLilpgjTPuvN4tKHIuSd6nvrap/yrgYKG+wWE4Y1XTPpOmcXbcgysDqAWbuAchosVAGLH7lCzd4ecoDSewjyeZEG0nvw+fS9jM7pBmnsgfeZYb50r0c175FayqqdS49e0K6y0pyMeyGqFu1+/625wZaSD3IPyoTXlxkZ0eSWKMmeTijzpQZpEkDYBhTnYFxDyDzMarj0L7mQWCMyTu1g0H/ax96SsTcReOKuiLp6mRJFxtsWlmJo+BUT/vOVwMwRahI+/kuBKYrGVlzPEWIZ4qEyYEulqiGagT6D7yFnS9nmC9gQUMSGIUamKnnoGF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(7416002)(66946007)(8936002)(8676002)(76116006)(66446008)(66476007)(66556008)(64756008)(38070700005)(52536014)(26005)(186003)(6506007)(9686003)(82960400001)(83380400001)(41300700001)(38100700002)(5660300002)(4326008)(6916009)(316002)(54906003)(7696005)(55016003)(478600001)(2906002)(33656002)(122000001)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SXkA9I5w1Ec/McYsK4xAlB+qUG3zid3CKkZBzduAeCmTzaRaB3yQohjquviW?=
 =?us-ascii?Q?QHw9VoWHITkPTrW/WLWfYixCB1W5r2YHs7Wg2cbrNMxi05F11+PIwI7lAjZC?=
 =?us-ascii?Q?PhRS42KdMh7PkMOlwTxE3G+ywm+nsSDIogMkrnQT0VGLOCiUAelBneE17xAE?=
 =?us-ascii?Q?6A6SKWWjEH7jaj3HrJw17TZg33Bd5BiCWeratL4Viu0lIWMQTtsmpq3EXxTU?=
 =?us-ascii?Q?257yAxahHP9ESyysUZwPCEuDeaM4S4k7kPjl79fW1wQeLWTxptHemLRCtO9J?=
 =?us-ascii?Q?qI12sLPFRYlLCq78xjnUm1CgBXPD+PcU/qqh4oQAelWCvQZPxt/WTKwhVy65?=
 =?us-ascii?Q?tNlI+p2YmO/C3UXQ9CT6UgoYVzPqYMsqcGBgBD+/jafxCr7Ijwfm6SBGNKyK?=
 =?us-ascii?Q?1MYGsFVgcZhUs46Svj7YsrcLzmBPI3B6kqWckEbfdo4OQBi5pptvapD6hD1V?=
 =?us-ascii?Q?UMiN4coQ1iY5CHUXOyy94g4yw0T1KpySHldmtuy3sypPnNl4Efzu+wBrAMdD?=
 =?us-ascii?Q?G+HjXPc+BlmY4cl5Bebgyl1wdEOkPtAjQ8MmobzvSXR5LD1Cv6gufmBtcvgd?=
 =?us-ascii?Q?P/PHMpPUToiGHaPhTDDV7racrbZhXlQUzR4m2fQicZfjpsAtrbYiyBRbfbMq?=
 =?us-ascii?Q?p6T6XDFVSe02tjM6PQJ0SLpjyZ2LCKsp0sh4PQjZImpDG0IN/6HNUAa3VUHE?=
 =?us-ascii?Q?zIVa0manNL6hdLie6GWvc+FPcgr7R9zByhbZaovMnCQn8cWXwqJsaonlpscN?=
 =?us-ascii?Q?nnjLxlRmhSBOx1xXo8KARQ4TLBnJGlcoJDECPVw38EtwnCmbBZthJNOYlt0k?=
 =?us-ascii?Q?LyykeEtANkOgbI2klmivviG5RDkD0UHvGyMNji1Sp2WGLRVqXB0gk4OunXph?=
 =?us-ascii?Q?8rbzNy2g6xoq3luQDsJ0B/5qo8e/FWGcOnGYhsIOz3nCf7GLCPQophKwMrpv?=
 =?us-ascii?Q?j1Crr8dN1XATwUa2u/UXzNYJm4nuFLgHhmG6YdPY0zge/lGWoCNmJYhZfTXA?=
 =?us-ascii?Q?MwRK0Gw0EbZU6fdLNOHMkVLzaeAj3ZelWfpTTEmXqWOvvEPMUFBNLHOBPIhF?=
 =?us-ascii?Q?5E6Kp32P3Ugf0eduF7eE2OMYyz056D5mv2lYrjg66aNDzIJGDGTNiEYiJQV2?=
 =?us-ascii?Q?wAJQVyeR7PGGpd/o5HCl2xpwhVEX39JZw7aa3qyT1Cx1N28Uh9em2qsuzZh0?=
 =?us-ascii?Q?gnjJtWp/xbqg7TTOU+totlarOEwaTuJv4KHLLNUIP4cnlf2vmantxkBw+Sk1?=
 =?us-ascii?Q?Fc1N/lxzsPR8I9lnVv2vi8+Y7sjXUzYnLASI9Pc88ZfWo7XVUn8sHrxiHOm4?=
 =?us-ascii?Q?dFfxI4m4wA6MfyN8heSjyMYw7aYZizCW5/GEPGYuoAuQnY69FYGATR3T7xXd?=
 =?us-ascii?Q?nCvGjEvg5Yn9qvBrz2sK0sUfi5c+rLvqtXbw9o/dNbilnPTiPqivWeni934N?=
 =?us-ascii?Q?uXj1uv/rEn4T+Sk6gTN8bQsuizC5TfLHlmhKDr446PU6h/PznWIGZF449ONx?=
 =?us-ascii?Q?116Ll/2Hck8o/xPBwwPxogenFoi73icd25UXvrjTzhBkGMQcON3ni0pBjMQD?=
 =?us-ascii?Q?4XMFy3zSCTb3SVR7M73ovx4zbdSsx9YWjFjgvKdV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d379b77e-b02d-414b-130b-08db712fc785
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 01:43:42.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPu2UYg0chTWy4JEWK5eVOyPcZp+BNym0YeTcxMQluPbTWwUx+jMECZvDd8bh6tx3ooBvt1G/YHcV+l0Eb3y1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, June 19, 2023 8:37 PM
>=20
> On Fri, Jun 16, 2023 at 02:43:13AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, June 6, 2023 10:18 PM
> > >
> > > > > > It's not necessarily to add reserved regions to the IOAS of the=
 parent
> > > > > > hwpt since the device doesn't access that address space after i=
t's
> > > > > > attached to stage-1. The parent is used only for address transl=
ation
> > > > > > in the iommu side.
> > > > >
> > > > > But if we don't put them in the IOAS of the parent there is no wa=
y for
> > > > > userspace to learn what they are to forward to the VM ?
> > > >
> > > > emmm I wonder whether that is the right interface to report
> > > > per-device reserved regions.
> > >
> > > The iommu driver needs to report different reserved regions for the S=
1
> > > and S2 iommu_domains,
> >
> > I can see the difference between RID and RID+PASID, but not sure whethe=
r
> > it's a actual requirement regarding to attached domain.
>=20
> No, it isn't RID or RID+PASID here
>=20
> The S2 has a different set of reserved regsions than the S1 because
> the S2's IOVA does not appear on the bus.
>=20
> So the S2's reserved regions are entirely an artifact of how the IOMMU
> HW itself works when nesting.
>=20
> We can probably get by with some documented slightly messy rules that
> the reserved_regions only applies to directly RID attached domains. S2
> and PASID attachments always have no reserved spaces.
>=20
> > When talking about RID-based nesting alone, ARM needs to add reserved
> > regions to the parent IOAS as identity is a valid S1 mode in nesting.
>=20
> No, definately not. The S2 has no reserved regions because it is an
> internal IOVA, and we should not abuse that.
>=20
> Reflecting the requirements for an identity map is something all iommu
> HW needs to handle, we should figure out how to do that properly.

I wonder whether we have argued passed each other.

This series adds reserved regions to S2. I challenged the necessity as
S2 is not directly accessed by the device.

Then you replied that doing so still made sense to support identity S1.

But now looks you also agree that reserved regions should not be=20
added to S2 except supporting identity S1 needs more thought?

>=20
> > But for Intel RID nesting excludes identity (which becomes a direct
> > attach to S2) so the reserved regions apply to S1 instead of the parent=
 IOAS.
>=20
> IIRC all the HW models will assign their S2's as a RID attached "S1"
> during boot time to emulate "no translation"?

I'm not sure what it means...

>=20
> They all need to learn what the allowed identiy mapping is so that the
> VMM can construct a compatible guest address space, independently of
> any IOAS restrictions.
>=20

Intel VT-d supports 4 configurations:
  - passthrough (i.e. identity mapped)
  - S1 only
  - S2 only
  - nested

'S2 only' is used when vIOMMU is configured in passthrough.

'nested' is used when vIOMMU is configured in 'S1 only'.

So in any case 'identity' is not a business of nesting in the VT-d context.

My understanding of ARM SMMU is that from host p.o.v. the CD is the
S1 in the nested configuration. 'identity' is one configuration in the CD
then it's in the business of nesting.

My preference was that ALLOC_HWPT allows vIOMMU to opt whether
reserved regions of dev_id should be added to the IOAS of the parent
S2 hwpt.
