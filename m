Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F056290A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 04:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiKODOM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 22:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKODOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 22:14:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB66B53;
        Mon, 14 Nov 2022 19:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668482050; x=1700018050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x1JSoTWzIc6ir6PaxAUVuR7bgbn8322IL1BzNSfYV3Q=;
  b=fWg37b/IWmHCUn7YdbDpp/mjlCq2Qtq7eBaYnRhq5D5x7CPpKyH86e+c
   WOA3+1dQte5Kq2CULMFKmE3IKX+X5tMmfb/2fPAiLOqOO0kRICfF/06jO
   v8DAw2ICE+5zwWhGdxJK48Ul8ubBEWcAiPu7CivSf04uZphuQVC+kg/Uk
   O5yMCL3SL6rig4GrrdAieNYArQiVM+rX0VaNAPPz3tLTmQZKgnlZixYiA
   a6LIVS6YuGWn7pVbleUgKCBBsJlUCqalLGHO9+JHQ4x8TKQwbbguvVjD/
   FlW0ujz2vKAhod+RC8ojeCXvWDonrMAWuRU0rskuDI3yuom4iSr9QBB2H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299666795"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="299666795"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 19:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707565532"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="707565532"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2022 19:14:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:14:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:14:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 19:14:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 19:14:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipvC26vnfQJ/v9zFBndPyJ5e/sniFbQ9LusrukGlsJj7vhr9/VL3JUeMOHsFRGGznz7qMbdNXe/sS858WzxxL+yfyqSS+RPet13lcowNBtIZf083/5SJzCdO7IyeN4Wi3TNKvbYnEbSY1lKE5mCmVljO/9l/AM+e6v7QovJX5H7I0QjpMAA1kxP5jkULs0Hgfc/t/ABYBghrHXdp4pwCsGqtNU2puAWJ9YHyV+7V0h3KDG6VQKaP8clh+p3SvaUqJm3eNJzCX84JYKo2aHpFEYU5CjYJaZutjnVIQF3KNax/UPSDy/Wg0a2q15jNDTtPE9iZxkAjItkidjfzV7wGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fklqo9HbFI0XPQ7K+9mZWJYaKmpw3nvaKSMtkVtDNI=;
 b=Foo79xiXRmmLVXdcZy3Ehzjqvg+cje2ssqLA/9DGO2fMsbE6Xq0fslRcVoEEy0Ak/GRAxFv8hIXxDRpLRD5Goh6x7thHrJ8Yfs+HnRKdguJpVOrM5Mhntxq/W0XX0Xl9EnUCgNFr7HLV888HZt6+lAuGq6D/GRE65HouBoRRF7BrrSi8oZ3GhTxZe6vRIDyTQq9NNop5DqaDDbsuGubxcPEuASLsItAXLFVvE9w20/90PlBw0J5b7PfccmwZgrXB5AbWsaDfZzJd0MXrG5xDtXEBtEAfBHSgfAhjFMSu+UmpAZaj3pP3rXJJfr7lEicYvr42Ez2WTn1XBlzmYJlqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 03:13:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:13:56 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Chaitanya Kulkarni" <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Topic: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Index: AQHY8wv9weOL8WzpqkSvohFTeBt9pK499F6QgADXp4CAAIydYA==
Date:   Tue, 15 Nov 2022 03:13:56 +0000
Message-ID: <BN9PR11MB5276CAB38B1691983A20B1D18C049@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KMbyVwS6D505cA@nvidia.com>
In-Reply-To: <Y3KMbyVwS6D505cA@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6150:EE_
x-ms-office365-filtering-correlation-id: 19a7d83e-76ab-4973-8f96-08dac6b76e74
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RDVjHN8Ai8wlV1+IyP4DTxsbt2dCV41z0V/51Xfxy9hHtsHqjzjHwI93MpFhh/MUpfxKaJ/4gzSV7vQoQ3/BsraRlWUr1Ga4x0h9VpV+7kygmHFLTyTlD2ej05CEJ67RRBpG+2Yl6qQnNfrCmSa9xBDajmMS/IJSdDzQTaqpDd0HiXPaBWHNPQxnFhRbkC6WCccVE9HwAOYZey5SQmgDcLrBsWF87xlaaWi321ZJDyzzgOfLZs76m8aOuDGw9/tt5AFJf5EHsaJw6/TCdAP6Eg5uuO07tEz5hrVht0rDobludIl3aD6eTQilHXEpqjdSWUsUh4X6nBmZvBkjBUBMp3kZ2xUMshC8dEkMlvr/yfK+ooSzhkukaD06SspwdOuBB96gMcmlaiE3x5N8Z/1nItPBELLFKQISeVpplVZrN6LN/yY1zzThnN9R0gXrdhvchzCxYl1teuhlWc0azErM3+ZK8EWtPnKzsaj+rgEIWBZZ82VkwmMSOFXqZgJa5bt2tDOkQvFdguAxp753TBGR+lUdQR+bWIYeuuTWHPhoJxm0IlYNCGHIiASWZsbdVfaE+TGq91rKzF/JIhqhHGzmNQ+S+zQ2QDdJeQw2uq1xG1mq3LZ5yeMMoI740lTGFbvhg9yG87c6olgzVqkD8f+QTZb0BZ6PME1cYA+Og1UkM9pwNH5bpNIWYL/j79h08BR/uXEaL7rjMh5L9Bqrjk0MAouWs3pffJQ73/oDBWVH06XtCHzBFuuT0PJXWTKdFOtu78PSDMVYf2Yif42jJ6ZEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(82960400001)(9686003)(26005)(122000001)(316002)(86362001)(55016003)(83380400001)(4326008)(33656002)(2906002)(8936002)(38100700002)(66556008)(41300700001)(8676002)(66446008)(64756008)(66946007)(52536014)(5660300002)(76116006)(7406005)(186003)(7416002)(66476007)(71200400001)(478600001)(6506007)(7696005)(6916009)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?joGLyGFfSswgAyz7BzZnfaotXe9+CNgXkA7VBQVtkSW5Dgu2K5Qv3fhZ+zBY?=
 =?us-ascii?Q?LLHbnSh324gBkGSdnyKDJqQ39WZ1xENVbuaGSUbEQCv8mbOch56wttNhbVaL?=
 =?us-ascii?Q?wDQZaaW1OugtBEgE/gl9DeYBUYG2pNLbbanDQZS8zgFVsQgvBRouWJzmwHzb?=
 =?us-ascii?Q?wQXelP4kSvEhn3QDDtES4ThopPFsnicF4LnF1nw7/zbQgzk4zv4N3sZuWkqs?=
 =?us-ascii?Q?n+V8/Y6P//Ott0J9ad4nUQlfShs/+cD6oGhQX00Hd9Bv59E4CQxIMfirzIZK?=
 =?us-ascii?Q?pJWbd/nAL1usL+nnwQoFO1XFtcaookTGgfDGi/vs7VDm4zDn/2eg6WGCbLg/?=
 =?us-ascii?Q?FiMWW4SukeUh70howPh+Av9NSQsSWeu52MoCmKeMXW3tUglPPFLObDV93mll?=
 =?us-ascii?Q?0eIdhyV3DLHei2G9ThFZ/E9bJH6uHVpVxT3hkga3A8DPTa91aOZYr+Vi/wtS?=
 =?us-ascii?Q?08Ag9CL/oj1DTXDl98VRMjL/HOZjlv7RUM5UyAZcVC9lphZsaBEnFV2E4s78?=
 =?us-ascii?Q?gLb8uZri28w2Ooqct21y9UKeyYGb6khy+/I/YZnkpbl9cGhXnG7NI1lxleri?=
 =?us-ascii?Q?spVBCELQs6mwdu4ITY2DM9K2e4oqAtRR16PjSYOCVM73YVDvF8doZYhSO26X?=
 =?us-ascii?Q?EuajfghuVhReVeYYLazl6FWqDpIs/G+NiifL1vpu6B8YtCjj346yBIiHWQOs?=
 =?us-ascii?Q?KfTzZw+DRhG1alTapT6+kymoefB+TdfdIdYsDVc/bSe0prAmb/y3LlkGvOwM?=
 =?us-ascii?Q?rxSydHTjanTHkgiAOXF7CzAQeqKbuScTZlpbk28bXEL8sDkBiADe8SyPo9E+?=
 =?us-ascii?Q?Uj9hpuNRnQiIS1KBZ1N5lM5PVCs9TEtEZ/2O5uZ2WiYLtMQj9QLXzHgnfKct?=
 =?us-ascii?Q?MHfPXxGZ8oBB3yp4JkNWdELLHm7EG1qNfixPeFBTNwl2KT4IcGETEX7AHPlY?=
 =?us-ascii?Q?ZSx8hEDHIqVLwJX85cROHA31WEFSphK4F9fnjBjyrTi5ykUSlItraF3lnfxX?=
 =?us-ascii?Q?Ms/ND3+PZ/6xce46if5Wm/5MYCRt5d4GtRwrgMV4IhqhqLXAhVxtWC7FRcSh?=
 =?us-ascii?Q?qQ9e2rQjXP+TRS6Sz8EPDKclfEuXheDI4B/q0E2oIAiFQ8it8UugE0006+lO?=
 =?us-ascii?Q?yo0xPkOS2MDE1yLX8eECjxHIB5Tx9Ma3PtpS2kps6ng8wazNuLgTCXmkK7iH?=
 =?us-ascii?Q?/cEsR+BeDUYItI+K1xKhHpIP1hVEOqnfEmBONwutSWZbDbJyaoLJ0HBEulTe?=
 =?us-ascii?Q?MR2fy7dzbfbOo6tT5VTcyiq+wA6hYl6yTl/KL0c86DO9fanMW7TYuN5tde0P?=
 =?us-ascii?Q?DM4j/Kh13R6UoRcgOeUqJe2wwTyalejgHetvujKYe3KVO2eBFCsvPfepoV2L?=
 =?us-ascii?Q?i8FHc/vrFwGvunvDc/L1kflDXxrl213xMCHpac9ua9pYWvlGkj+lxavkvrgg?=
 =?us-ascii?Q?EuZhfktYtH8BNPGGIebJ/eIHBQZI/4fzuoeEdf9i5Ymn8a/gUV8bV5/9LWMO?=
 =?us-ascii?Q?QzbqWqIDN/xeUTfgHFn5hlGU3DRS8Unc9A/jW6KKdgxrHtWQr1HsazHw+Rq+?=
 =?us-ascii?Q?wGnQJBGaFYhQjJ5vgVwQREdXDyZPE1nvpdT+ofe3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a7d83e-76ab-4973-8f96-08dac6b76e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:13:56.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qK/ssQEP0xaT3kH7VFh2VNQGq2qNWlysuFZ04ZV7j6j25R1cu+zZPlYv0fzRtu+p5qSGusyr1FKWmv/KoltpmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 15, 2022 2:44 AM
>=20
> On Mon, Nov 14, 2022 at 07:28:47AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, November 8, 2022 8:49 AM
> > >
> > > +
> > > +/*
> > > + * Automatically find a block of IOVA that is not being used and not
> reserved.
> > > + * Does not return a 0 IOVA even if it is valid.
> >
> > what is the problem with 0? should this be documented in uAPI?
>=20
> 0 is commonly used as an errant value for uninitialized things. We
> don't automatically map it into a process mm because it can cause
> security problems if we don't trap a bogus 0/NULL pointer reference.
>=20
> The same logic applies here too, the allocator should not return 0 to
> reserve it as an unmapped IOVA page to catch bugs.

CPU doesn't reference IOVA. Where do such bugs exist?

>=20
> I don't think it needs to be documented

this again causes a subtle difference between automatic allocation
and fixed iova. If we really think address 0 is something related
to bug, then why is it allowed with fixed iova?

>=20
> > > +		if (!__alloc_iova_check_used(&allowed_span, length,
> > > +					     iova_alignment, page_offset))
> > > +			continue;
> > > +
> > > +		interval_tree_for_each_span(&area_span, &iopt->area_itree,
> > > +					    allowed_span.start_used,
> > > +					    allowed_span.last_used) {
> > > +			if (!__alloc_iova_check_hole(&area_span, length,
> > > +						     iova_alignment,
> > > +						     page_offset))
> > > +				continue;
> > > +
> > > +			interval_tree_for_each_span(&reserved_span,
> > > +						    &iopt->reserved_itree,
> > > +						    area_span.start_used,
> > > +						    area_span.last_used) {
> > > +				if (!__alloc_iova_check_hole(
> > > +					    &reserved_span, length,
> > > +					    iova_alignment, page_offset))
> > > +					continue;
> >
> > this could be simplified by double span.
>=20
> It is subtly not compatible, the double span looks for used areas.
> This is looking for a used area in the allowed_itree, a hole in the
> area_itree, and a hole in the reserved_itree.

the inner two loops can be replaced by double span, since both
are skipping used areas.

>=20
> I don't think IOVA allocation should be a fast path so it is not worth
> alot of effort to micro-optimize this.

but I'm not insisting on changing them now. It's trivial.

> > > +	if (iopt->disable_large_pages)
> > > +		new_iova_alignment =3D PAGE_SIZE;
> > > +	else
> > > +		new_iova_alignment =3D 1;
> >
> > I didn't understand why we start searching alignment from a
> > smaller value when large pages is enabled. what is the
> > connection here?
>=20
> 'disable_large_pages' is a tiny bit misnamed, what it really does is
> ensure that every iommu_map call is exactly PAGE_SIZE, not more (large
> pages) and not less (what this is protecting against).
>=20
> So if a domain has less than PAGE_SIZE we upgrade to
> PAGE_SIZE. Otherwise we allow using the lowest possible alignment.
>=20
> This allows userspace to always work in PAGE_SIZE units without fear
> of problems, eg with sub-page-size units becoming weird or something.

above are good stuff in a comment.

>=20
> > > +	interval_tree_remove(&area->node, &iopt->area_itree);
> > > +	rc =3D iopt_insert_area(iopt, lhs, area->pages, start_iova,
> > > +			      iopt_area_start_byte(area, start_iova),
> > > +			      (new_start - 1) - start_iova + 1,
> > > +			      area->iommu_prot);
> > > +	if (WARN_ON(rc))
> > > +		goto err_insert;
> > > +
> > > +	rc =3D iopt_insert_area(iopt, rhs, area->pages, new_start,
> > > +			      iopt_area_start_byte(area, new_start),
> > > +			      last_iova - new_start + 1, area->iommu_prot);
> > > +	if (WARN_ON(rc))
> > > +		goto err_remove_lhs;
> > > +
> > > +	lhs->storage_domain =3D area->storage_domain;
> > > +	lhs->num_accesses =3D area->num_accesses;
> > > +	lhs->pages =3D area->pages;
> > > +	rhs->storage_domain =3D area->storage_domain;
> > > +	rhs->num_accesses =3D area->num_accesses;
> >
> > if an access only spans one side, is it correct to have both split side=
s
> > keep the access number?
>=20
> Er, this is acatually completely broken, woops. A removal of an access
> will trigger a WARN_ON since the access_itree element is very likely
> no longer correct.
>=20
> Ah.. So the only use case here is unmapping and you can't unmap
> something that has an access established, except in some pathalogical
> case where the access does not intersect with what is being mapped.
>=20
> There is no way to tell which iopt_pages_access are connected to which
> areas, so without spending some memory this can't be fixed up. I think
> it is not a real issue as mdev plus this ancient VFIO interface is
> probably not something that exists in the real world..
>=20
> +       /*
> +        * Splitting is not permitted if an access exists, we don't track=
 enough
> +        * information to split existing accesses.
> +        */
> +       if (area->num_accesses) {
> +               rc =3D -EINVAL;
> +               goto err_unlock;
> +       }
> +
> @@ -1041,10 +1050,8 @@ static int iopt_area_split(struct iopt_area *area,
> unsigned long iova)
>                 goto err_remove_lhs;
>=20
>         lhs->storage_domain =3D area->storage_domain;
> -       lhs->num_accesses =3D area->num_accesses;
>         lhs->pages =3D area->pages;
>         rhs->storage_domain =3D area->storage_domain;
> -       rhs->num_accesses =3D area->num_accesses;
>         rhs->pages =3D area->pages;
>         kref_get(&rhs->pages->kref);
>         kfree(area);
>=20

this change makes sense to me
