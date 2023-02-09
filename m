Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9298A68FDAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 04:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBIDDE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 22:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjBIDC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 22:02:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8F524E;
        Wed,  8 Feb 2023 18:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675911552; x=1707447552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k4z3IuX7q2jUYWOIBWE9fUyuVVLGgF+peYVe9eK9/kw=;
  b=X4KqSZJfXnVsA4XoH2EbO093gDRlGWy3BcIpsN69WfFGoLxbcgKBKVfa
   a9Adf3C1lUHgAIdUbVKWBXUFMkotvYzuohB5o+TlNrympuHzjM05LE9k4
   iwbU/PmgO10KF1fXSAHQqPaigHfTvWcEgYz5PfxWrLiv0nlGT/Qm3MFnf
   UAV3pTPA+IjsluSTw7lRuQqiJKTwpfctizwEOoQDHKW7zXPbSUndcNgoW
   JtTwqp6zyZJEXWntcvzUPkaEoMX2CHZtErVFwxvdVk71MwEyEx5Rx+9Ht
   ytIJVY92dh6Gss8/9hBr80OjQBc2xMFcenwtB8Po4qtvN3AOTD1bP3HuN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309644971"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309644971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667479386"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667479386"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2023 18:59:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:59:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:59:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:59:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9LYm62JkoOAfXYSDM31WkzjJmlpcZVIb4+Ho+/Z/ddUCTu6S90GyDOhJ/PpsMZE8WMeXA76FrLo54YwJUF5GnSk3RbtIF7g7lE59ilBJprNNtazoj+qC/ME8WKS8l5dddoB3Dqjoc9JgAHBixmYwpwH9IFrhWWgbycaZLbP65p+FJqB9juH4Qg6/GzveIW9U0KOQAWiFw4Ynyoq25XFrk0zkQb7hxaYXQcRGj/Vg4wEoenlB15phHIbtEGwkkJ0j3So21ibBrz1FaDpOLeT5DPp/OSl5jyNCXGjjVSz6yGQib1lm3ja+pgtpiJICVWaBE6RJI62RI8IWN9inQPnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4z3IuX7q2jUYWOIBWE9fUyuVVLGgF+peYVe9eK9/kw=;
 b=gIoSFMuEFBcDPV+V8tUm6mNC9h2uyrywsq0cM2DTRwv2RUuGXjGZec79t9tA3K2y7DrrGDznfE32JaS+qMjkJQRwHA3IrwZTsDqxYz+69NPyyfVc0xoNsEphgiySdRCZtSizzkTf1E3XjyBRGL+2lPaZJFZMLhgHE+yjMbnQT7RdFf6UTd3j6XYmTSLO++WHy9W4yDsP2iX13IUcJgMsy4cMVHKTQdy51O6oF63GjRS6cwDRgF+vY41fvlCNUEcu3MtS5Icz1jAGjKd8VmGqAcwTUjpxuXTXgVSESFpRaIjVfyosnVnGW0hIQVBtrARbNLN7JHw7VCTXXY4P0IC7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Thu, 9 Feb
 2023 02:59:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:59:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 04/10] iommufd/selftest: Add
 IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Thread-Topic: [PATCH v2 04/10] iommufd/selftest: Add
 IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Thread-Index: AQHZOzoMVLLG2WIXj0anI85COJGE2a7F7m2w
Date:   Thu, 9 Feb 2023 02:59:08 +0000
Message-ID: <BN9PR11MB5276E7A8C8A68AFE6CA4758B8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <c1f31b7fa35a33af41478e39acd9dad81ef7aa3a.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <c1f31b7fa35a33af41478e39acd9dad81ef7aa3a.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6123:EE_
x-ms-office365-filtering-correlation-id: e08442c7-f130-4609-e388-08db0a499d3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UXo3X0pvmjnaktaBoKHjS3Jj5bDOxngirY9D3MsiomJP9jmwyUQVSS6XW0dkDUdoaCnbn14SVGpEPF4iqq9b2PK2l7fviGh4K1nzc5EeJYXL0zo84hyyDJXzs20NSOcOzlLlOROvREhpguqjWGWmiNvRl4FYG+Wk8+4liBo1OwiZjVyBua1llNYHfRWHtCvren4nfmRhe5vtN6WzSwBvrTW80BoDwSEk32fFTxtI0e8IzfCyOa3QQpaW+b6z5dFo/GEULMpihiMtxe9poZSyPgJ0fdM7QGX2840/OmfIEVzBRAP4a2dlLeT1gamSKX5uzNjKHiv8QGkuFyhCegW/FbsNprpudlo8nP4NQhA8eaB9JAkw23pGi9cnBnw5amZuLT5+CkwACwzCONZKim8CuWCovxLGtcLtL9I03e0KCjJ4UDrWFKCJIIGf6u9l6Hmg+Vk7ZaYl2CTCzMc/0hzVBRwWe0w3pM/+UzzpwAP4Tf++rYdtg8xSIxWCuAX1KMCBGSWlzyPvD9Ks2Gd/dC58sTPstCuFdd+4b4xaZM2IrbyF6W/fdoHhHnApejL5BdImGnZxensiMIiLeqCET+HVJFDbv7Nm4r+RThAdE/pfp60dHX2c7hAgBOkr5lqJlHgEkrBT8NgOsyyQZjxJYOBjAI/2rxmb+S/VMTfdClY1XQUJVEOXR7Gzwgono5eSvF8kTGnsfZgrd+Wqnl4CebUcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(86362001)(38070700005)(5660300002)(7416002)(122000001)(41300700001)(38100700002)(2906002)(8936002)(82960400001)(52536014)(66446008)(66946007)(4326008)(66556008)(76116006)(66476007)(64756008)(558084003)(8676002)(83380400001)(110136005)(316002)(54906003)(71200400001)(55016003)(6506007)(9686003)(7696005)(33656002)(26005)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7B79j9gP6o1c8ns4K+UUCmpPMFPquuGJMBlURstee+5GlykC/75B3wec2U32?=
 =?us-ascii?Q?1Sd6B1Qxbtrg9r6NL/bP+39fV5aRtri0tCysoLv4+tdX/MWsCZtmH0s71FOI?=
 =?us-ascii?Q?Gs2VSxsJ3YFvpZbWOzvmIFlrLysM3l6Hv4WdQ470ARQ+CKH2keEZIL4hY6kL?=
 =?us-ascii?Q?G/OaLwSnkad3UpWKE3r6nnFhc5Re4AHgnNJLydMNAdue0JDADpNLQ5i0szQg?=
 =?us-ascii?Q?xrHEXesljCFMR+lgdUV24aZ9OHfrdWkG6b3EqLcFmmgC+KOWE048QRAEl7NV?=
 =?us-ascii?Q?+LkQpA6jI28pK0GNpcKrg+T9h7oTvo85andA0GN7/+jr6EoB44cbH61Us6Tm?=
 =?us-ascii?Q?qcXFVV8wgn1MOUDD78lqcNx8XZ5qNUsst2zTPuoOr5TSWtKxOT6eTbduJEW7?=
 =?us-ascii?Q?b4TIliVCOkBNuilAjUcxka7+QmNHcyv7l2ffnaIffXp2bDsAs1867BtraIfO?=
 =?us-ascii?Q?U3HpHgZfQBgLY4hEkltln+PWlIEtSlBZ/yZJTUXNsJ5tDvjpgbaX+tiMbgsL?=
 =?us-ascii?Q?NkJ+vTbHMo9p9c5N8NOGygaEyFrokr8U4QgCbYCk01fu3UlyP64L2zhU7XEu?=
 =?us-ascii?Q?B4Q08oAc2Ru96kyeRItddccjXbvgYn686dISxQi8NqrUjdcU6eKDc/7z1UeJ?=
 =?us-ascii?Q?uz8OrPcCJm72CWig8dxoj3nV/iyk/E3tmtMtfduXS2lSdp8lcPDib7tsukV7?=
 =?us-ascii?Q?AlR5re+hAPLIKVhIk7BKB5+c9xCrxXSMZVi+4y8RMyWSuegO53d8KNCjLz20?=
 =?us-ascii?Q?sXRsdE+HgLlSC6G1qZAFtRghOLIQ2XDMamZo+FJFxXgcQ2mBlbpwi7uYdLgo?=
 =?us-ascii?Q?ONF4sTxoxZ6/09vm0aMACDulirTAsPlVFgT1yzfrBwAso/uZ6j/fV/Xlb6FN?=
 =?us-ascii?Q?xeLpVqjLfnjKcpOVZM4qerPiDHdga6gweHddVDydwSAgpcgrdbAHD1rqNI6Z?=
 =?us-ascii?Q?gkOvSnBL6kjJZyAGVUva8kxjKxG81LyVRlpg4ntMiYaceA7oKsmcr2DZkq1G?=
 =?us-ascii?Q?BZbDqqUQhLpBnG9lPFQX0uw/UeJyBy3Q+bHqzyceeblt9+TdBa5XoNfrFgWE?=
 =?us-ascii?Q?BXy9N5SXoEuoBo4M5ueumQBEbBKzNNfin60prKjFROtNTdz0fzPAyvqeLp6r?=
 =?us-ascii?Q?Fl/vgYjdgJd9lDj8qM0qb4uyPtZDy8GmIMgcPhOAjiHLXZkfUa2lhyAFDaGN?=
 =?us-ascii?Q?oNOMyIquKeuh9ee5dEq9ER9oQINClKnL4c710eZLkU9q1rpCSf40fJWBnNym?=
 =?us-ascii?Q?tBO+D23sf8BTHo1EvP7Jj+SHKMk27GTT4BWu5dz8LU4BYIIO7frKKOcdPmVF?=
 =?us-ascii?Q?zE0I2ovDtSeFawZRaasZczPXUr/7NLR5ZjuaVmzXTzgvLY32DqPe7CYQ7jdP?=
 =?us-ascii?Q?dI0D8sl4YlH1AFSPgf6QJiCvgQReADud8RZcsLOJ8INxQJ4C+tLCedTQTLhL?=
 =?us-ascii?Q?4sLyHe9n6XzCZehfeOWT4J86Qx2u4EMR4LYQMLP1+PUbDTMptvg8vfFSQX2N?=
 =?us-ascii?Q?7ezsrMOEFoLG1Bqjv7xflaecyQs6BX2vtc6kco3927gQM9FX+YxdzpnXU6To?=
 =?us-ascii?Q?f5Q4BL25EyD2ksUF4f2Ock7p/PaqOEJ1Jm3gNjTt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08442c7-f130-4609-e388-08db0a499d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:59:08.9270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLOL/13RCi9sPEE0YGb40Mc5efWFbMhJ1mQsxsk976mhVtzS3xCQ6ZGzqFXDKt7NdEvw2h/hVYAwUVDgjeGAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> Add a new IOMMU_TEST_OP_ACCESS_SET_IOAS to allow setting access->ioas
> individually, corresponding to the iommufd_access_set_ioas() helper.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
