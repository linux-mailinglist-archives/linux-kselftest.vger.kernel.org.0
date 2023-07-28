Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAD766410
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjG1GVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjG1GVf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:21:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B13A84;
        Thu, 27 Jul 2023 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690525285; x=1722061285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ssi/D5+PmJeo42VoKYLcRNlCXXAReykabokkZZS9IQQ=;
  b=VRv5hPvLvpOgy+la3GdxXN2D04W31neigyD5E5mY00dJr3dId9vbtG8q
   jKlfuDBtGC9izCLe6K3KXbaw5/bTCDNUJbGfdcd+bkxFGvJmeek3UPvbz
   5Zfv+h/TCgvQo5SiQUfqxQIIc0DCUE+ad2Qp2sOy/OyAVAYqlfeKixB5g
   +oXh20cz6KPUeiati4TIOfhL7xvH34Cxq7YLAcpJ/6rzzbxYMdhsGX+jg
   A3tgkV/eItsMApArtvs/EIH9FatJb9Z3OYcOC+hEHLe1T8IljsAhym6ok
   CX1KvUrqKrWZooBxT1ePpiJNV3ymKKWZ9Yg6rR4l5G3pHv1/n2TB07qRS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454880690"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454880690"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 23:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727350987"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="727350987"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2023 23:21:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 23:21:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 23:21:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 23:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOOaWztaJCccgPj9dcZ6gcFChhq49XjgRcsw5lxgy+kmxb9fNqgJKjAMnx5yRLcEqEj10rJVley1pu3kePJJypwqxQEkDCXOtxoSTs9+AqkfUeWk2Na+7w++E4VQhnktbBSLKZGoCc+Mxyw857gX0nUcescXhJ4itcJL9yCbj7+Txyn61N4f69628pYJGqZzF+vjHg60s6FokhHSUxI60azSnLQnn47RzHR97nNgE1E9xbBi+rjRxo25GmHmnaw4ih6K8KZqaF5rs2T7QFAZlFhJcDCpi8bvs1RqC7dsAIkz521aIu2ilTLIl/Yv2UN3xiNciEUr9C9mfEQPy+7Dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssi/D5+PmJeo42VoKYLcRNlCXXAReykabokkZZS9IQQ=;
 b=BDlyjK7AhtFnNjcZ+3fdgAL/Epn9Elwo9pKdUwY2wWF5uwVfS8r3sVCmHaSgXJoIYBxu2pF7Fhk2uVR+PllqpPQSdskY2rJwVY/osOlqIUhKfuqKojYe5ZP6aTkAceR5zKJ5ArcFSOCtET/PJ2O4MkKzANApKxGOGm2FCWmwb5ZPd/26lxzOzhbXTM/0gD93UXnpQ81b/Z3dmzEJGyQ5otAd5S06A/RgojtJvhIcIMX2o8elLUbF3BJpsyPsEmeHpRn7Se3iVlcOQmSapWH3/wH0JtlB1k1px/Mal1Z568Y9rThDZ+A4wGfsmBOw9sfMLlYdpZ+hHSZRX8uA7fqkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:20:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 06:20:56 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
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
Subject: RE: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Thread-Topic: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Thread-Index: AQHZvme4Wz9PfkBkx0y7nT6tapgWUK/MHpWAgABqOQCAAC5lgIAAOKCAgACX8oCAAHWfAIAAkFtwgAARhACAABT/MA==
Date:   Fri, 28 Jul 2023 06:20:56 +0000
Message-ID: <BN9PR11MB52764347180F8166910819FB8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com> <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com> <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
 <ZMJc9elDILpHaKP6@nvidia.com> <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
 <BN9PR11MB527691E9B421682C7B88AFD68C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMNHarPX7yA+VTdT@Asurada-Nvidia>
In-Reply-To: <ZMNHarPX7yA+VTdT@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: 8e6017cb-2b39-4796-7c4f-08db8f32cd77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5rIxP0GOL2e0QzsavnMPywOJE4r5DzE1MkxYJr8+adtD3yCyRZmacErIxTB/kZhsfrQiFykjw7rmmv8pxObCWEIRuRpxwk/FvQWaxQXU12fZTKFglFlSzpr8Oov3488JFYug+qOAnheeGmAFeWwmux8f0pM3QL3AkoBTqu2LUwN0Y7QcNwYWXi6UaJxAaNBSTWG50mZsMIfF8JMGuTIXF7BK2VSyM+D+1QQ0VdF8TSwL24YXWbIaCSb5rKCLS8BPiaMt+0E3tPIBGMjTAnclpL9CTCyib1cfrHJnOtPxJ3JTq0XoRUJCk9VLKwEmz4eoisIVqsQccxBylFJH4wcYZp/jlXIyzfJstyLVNkriFA+lCbhwQILNVNMtPULJtiiwhThe7DhJgKjbcMVarpz+FyB9+oAdUPwdGxAnVWNysS0VBY5XcijwVdMP55DGBG6px3n1S6uV5Nf2gGAQ0gJL8h/g56SuoUh1dt57sFk7wgZKeNdNkBXsFOMF+29FRveHxcVSNe8cDX3XC5eJMHbM7GePFRMWeP8M5WSDqhoNfif+uISYcPybA5v11LfgDMqxV0MbcQ8V4KPP7k86IcrZvjVEDWKLdafsJ/8tWS1A9C3gaRlRL7Ok+hNu7oFuZtEp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(5660300002)(41300700001)(26005)(71200400001)(38100700002)(9686003)(86362001)(478600001)(4326008)(6916009)(8676002)(8936002)(76116006)(66946007)(66556008)(316002)(66446008)(186003)(66476007)(33656002)(64756008)(6506007)(122000001)(2906002)(83380400001)(54906003)(82960400001)(52536014)(7416002)(55016003)(38070700005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tGrYaNzkzqhKslifxib+KEi04F3EM335cNygrCeqtHcCXM8zy69fiKLyE+eB?=
 =?us-ascii?Q?ETYx2s+EYJGDy+QIOyLPbEQQfb3KuvC/DXAyyt3k/n9g9/soWrgrTTD+TZMd?=
 =?us-ascii?Q?FDHMq/AVrZMeW9UgYapwIitKYfIpexMCg9Ub2bGl78MgRUJMBnNawOBJTIPj?=
 =?us-ascii?Q?D0RVrIUEdxGjxoPe09gMmvmYMG5nTJJUPkvo2jyjnpmOfx0uXrsdI24HwOH3?=
 =?us-ascii?Q?XHkEVaaqH3lcWr3O22YrY2nMSskXKOWknIcBkoTrFf8RrAG8cPgxWuTZwHAS?=
 =?us-ascii?Q?JSDZDxfJzx0jQPQUXBeySENYtSthPMdc+79+wVohaJ+EWq+ylmBfx/DUhsWZ?=
 =?us-ascii?Q?otEw+rMQ6burQsEb3egXzFvBECuL65Hphdvb5v/N+9yBsNTrsvJp8FTQ9n5G?=
 =?us-ascii?Q?BNVreXRkwMnVzBU3hD37ffAYQ487kFWtCTbjohINW0y/9gwHK6FLWp30LBqk?=
 =?us-ascii?Q?l4RFqglEKXHQwdBbApYnQEr68of5AzlnwcrFgtHUFnI+nxGIzNOlpEdCi/qk?=
 =?us-ascii?Q?7QN4iSBXzdzkPx1aICM+oZbIGBDZyGbVC/FW3FdgReRVMfXLIrwhEz4iIVXr?=
 =?us-ascii?Q?OD+QeosKbQ6DiOINh0Buf7oLrMLI7PAF4Ed14taA+h2ajGnRiZSO1BbsLNO6?=
 =?us-ascii?Q?dZFMTm3DTFT9M0uNQQKFs1T3SFkREg7cyT0A1SyqOAYOHtIvMS5qF39GojF0?=
 =?us-ascii?Q?Q8btE8O5Kc6bP0UWDZnUB7ya/JIG9851RHBeoh5NhSlgry81TlReKoF3V1kA?=
 =?us-ascii?Q?r8C8z+169l1UHc3hZZp66TD1S9HLHBPS70RZznk8TSgtAMnMtkg6rRAQc5bj?=
 =?us-ascii?Q?f4vn+geRXrsaz/RtDDypEqwuLta+hv45Fj6UQlclGCktehdr0mckB2eQ7FR0?=
 =?us-ascii?Q?6KdEnVehUY5Z4Vl0DshIH5VCxXmu6tBk3zcoEFPY2Xo8T0y44la/fYp6WHNO?=
 =?us-ascii?Q?pycjSds1V46O6x1k7U6Olnp7GIc8aA8jVOZq0moRhzFuoBJfFkcLnoSKc6qs?=
 =?us-ascii?Q?nVq5aubPad8lB3cwAL6ihQvwFIMcr0aT0pn+KtudtGDW4gPrqKgFUj+3AXOs?=
 =?us-ascii?Q?LF8SOVTDSiLvWU13OSGIKFyxD2g5Xm+yC+U4woyQw6snEJqMfGp6XP7NQo51?=
 =?us-ascii?Q?3toJS9FEwSV2sYWguNr+cS3T0WEUFFycuyhX/5QRxh28gPxBJ7N8nmib2aOI?=
 =?us-ascii?Q?xbQ+wkce1QN3Wvy8Cz30NKX+95DUkU3EwACb9WlFts7w3lZHYGeWGrKomfkI?=
 =?us-ascii?Q?xIi+t2pH+j+cfKu5FbcVvWpycTfZjeRMlrmhbG3VPU4lzFddiJ90lwTTr3us?=
 =?us-ascii?Q?+qf5JKFXyOxWG6X3g8xDdMFOBdwIIGHo77pwm/Icq8nzPVfszLDgfoYX8WOw?=
 =?us-ascii?Q?3Py2IAaNh7SIe073bU/fSaOuFXfIBlMbNmJAl7xK3RYL/QqhV1bqO6Iu/2rr?=
 =?us-ascii?Q?fa5z8HUW6tmEPah5SzgpHsnayrnH7h6iDNfI6q5JerHMuqxVSY+u2iye4xAq?=
 =?us-ascii?Q?1NUCUnV43dQwEANM8MvGnpEdoMXG0QFP7to0GHez6qgSHw8h8txa8g/Rjo6u?=
 =?us-ascii?Q?5U863XZEEAbOhzoqBtwL+oSzP8AkqMJ3nYMX78GF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6017cb-2b39-4796-7c4f-08db8f32cd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 06:20:56.1025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nk5N//OhUIRlHmS3J7PrI2JReaekxEpxhCrMwq/x0WuLJZ43IoqlJ8Wu7OOp46OfU+O1hLzmYkfNvyISyASZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 28, 2023 12:43 PM
>=20
> On Fri, Jul 28, 2023 at 03:45:39AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, July 28, 2023 3:04 AM
> > >
> > > On Thu, Jul 27, 2023 at 09:03:01AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Jul 26, 2023 at 07:59:11PM -0700, Nicolin Chen wrote:
> > > >
> > > > > I just realized that either my v8 or your version calls unmap()
> > > > > first at the entire cur_ioas. So, there seems to be no point in
> > > > > doing that fallback re-add routine since the cur_ioas isn't the
> > > > > same, which I don't feel quite right...
> > > >
> > > > The point is to restore the access back to how it should be on fail=
ure
> > > > so future use of the accesss still does the right thing.
> > > >
> > > > We already have built into this a certain non-atomicity for mdevs,
> > > > they can see a pin failure during replace if they race an access
> > > > during this unmap window. This is similar to the real HW iommu's
> > > > without atomic replace.
> > >
> > > I was concerned about, after the replace, mdev losing all the
> > > mappings due to the unmap() call, which means the fallback is
> > > not really a status quo. Do you mean that they could pin those
> > > lost mappings back?
> >
> > None of mdev drivers does that.
> >
> > but we need think about the actual usage. I don't think the user
> > can request ioas change w/o actually reconfiguring the mdev
> > device. Presumably the latter could lead to reconstructure of pinned
> > pages.
>=20
> I can understand that the user should reconfigure the IOAS on
> success. Yet, should we expect it to reconfigure on a failure
> also?
>=20

I thought the user will likely stop the device before changing IOAS
and then re-enable device DMA afterwards. If that is the typical
flow then no matter this replace request succeeds or fails the
re-enabling sequence should lead to the addition of pinned pages
back to the current IOAS.

But this does imply inconsistent behavior between success and failure.
Not sure whether it's worth a fix e.g. introducing another notifier for
mdev drivers to re-pin...
