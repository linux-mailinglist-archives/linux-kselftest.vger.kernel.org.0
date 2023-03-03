Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A16A8F1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 03:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCCCQ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 21:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCCCQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 21:16:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D64617C;
        Thu,  2 Mar 2023 18:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677809783; x=1709345783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zcumD9XzWEokIb/LOAuDbgf8Ot54aNBE4FwGl3MaggA=;
  b=CtNB0gD085oPu6t8e8eeNcRa7yvjHUByknCFI+sppc0LL79PnBJF7r25
   zZjr/nrXQ4qdgfphjTRprYoHxSr7OFmfYKiIQzIvezw7pGa2jm/LXbAEN
   aO+mcDIbFfh/2K8NaqV0ERtwOp/8VzPMeCesGukaIBdqNGvFO0m47FHLR
   qEHRvsxwgoWhjiK5XcNrJNy5LFPXnI9Fd2Bl0VEeIoSo11zcAh7v8ZRIn
   qVFbQXaGrX9m7W8QERlW6BpPsMuUYKxBO3FSwIGkRds/bA/qfK1ri+XlC
   WRZZVthGyedQaobscmmZn5rOlzNslV4pSOfevSMpr0ZgtfOwDrcwglsm7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="323223793"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="323223793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 18:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="739334782"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="739334782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2023 18:16:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 18:16:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 18:16:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 18:16:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 18:16:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esCsWcMexNtVDa+qkNyaU3I04fFVYii5sJmyIQqW1r9FdiFeTFexqC9A7E4pi5+c3TvqH+TliJcof/Shds3z3K+SQS6mw4FxSSBvMardVklGF+BQYchtMg9uOM2CJq2ggPmvTisFaMd5MzmxuwWLbKGU30waR2WHtBwely8W3JNBiHl8m/fp0WHR9il1DSsQqN9NcJcy3ec8185zvOmjNGamNf+aEAVW7Pu1nPUid0rFhwa2nLdXWaGrsa2h3xWuP5kVxWo3TXypMHEnjkz5/JLG4fT94JTFb3cDrPTXo0xGlPaH4WkjRC4UBF723wMe9gYQ+1PtHG6yUQc0zkm8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcumD9XzWEokIb/LOAuDbgf8Ot54aNBE4FwGl3MaggA=;
 b=ZudPwkBHs/YR/e1ZaRzgeQdZh0Wt3HTBCHkqXRen4+LZeS2Iuz8HW7LNqbhJRjRr/n5k42eqSPzhhs9xOZw6AsItmRC8n1Wa9livtoU1TRH2n+KoufV10aAd+c70faTzFbRv/dKf18SWm8WMO8VbDINCeWE1yjvpiHvG2UhB9LI5tzB2zjDU44kGL1fDRZHzdGbykLSlQmkKIr/XqMh5c5aVKOsaRCEvNqrBHXrKghV+dXe4eUsS+fi3KAUY0QwhTaoSuI8OndpCrkOMOjuRZWmKAgZcn6R67YgaIBdtr5Rta6Y2kvJC8LotfBeAWeStNmeLg1D5x8Bo3wdfTslb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 02:16:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 02:16:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 04/14] iommufd: Use the iommufd_group to avoid duplicate
 reserved groups and msi setup
Thread-Topic: [PATCH 04/14] iommufd: Use the iommufd_group to avoid duplicate
 reserved groups and msi setup
Thread-Index: AQHZSLAO9s9EoxaOzE2w9MkhlKiB967nKSTwgABR5gCAAN/GUA==
Date:   Fri, 3 Mar 2023 02:16:19 +0000
Message-ID: <BN9PR11MB527659F5D95A4F05C9A7247D8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <4-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276499B820C0250B4364AC98CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZACcqDj9lgbOayDP@nvidia.com>
In-Reply-To: <ZACcqDj9lgbOayDP@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6010:EE_
x-ms-office365-filtering-correlation-id: f20e4873-9f90-4abc-f4d1-08db1b8d46b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqI5IiCMs0OmBBBCoIODNt9Jcw5kstwkTxqOSwKOoQqWzU7TWq+tSWHTMAtzLGylREWBAO0Q+dZ8ibNQiziH0y2StBP1NEt5F/rTlSX4ryhxLKsLaUiSDCnm0RvErbVX1li1SvSwtaThcjoPxSxHe/z6gDs8idXfsQ3xFNjIjgGxIpDwXBMQz8goe34TkDsWg/nz8opOpXrC5jkPi5rTUu3F8FQuIvBEOnv6aDsKC6EHvUUsqV4vXEaaryDbApqIiTW/NInIIdqB1R1pUb2Uj5TUGujIxahEAEgWTqC6mwMgCgrI5EFKKd/lw0FAlqfmC4HiU+bI0lpqsUP28ImIibbSuQqjCDSPfevnzlIUHCFOB2uPWgMVV1lIlMrA0JPmwtCUQ/NetygcAuPV4pE+AqnQI0CIVUtpAtapQik/WgJ4HmPzqMx+NzE9uXDFZ1SubBPOW4BdxstGXTFQfIO8jicc8H2zClH92HSUnRc06x8Uf1RAJ7MrKPTbtB1YEqB0U8kKf5tJdjD+xzGesuOcs+9TnpZfWaktMjcofqar40eS9bquX76T1TBUQCE43sgMZA7vDaTeMGhhGon8au5ydii3vHqx6XTIh2gzC0vX72Pi+UAaLKlXyTjMddrDM9CfwGMh82LWMU2oP/e73DxhA5S0M2Kzbt0U0EFMKKMprVN7zc73+oo+9uyiie2EaIO0nfE9A02C3ilASWGj9sTEAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(316002)(55016003)(54906003)(33656002)(86362001)(107886003)(38070700005)(6506007)(478600001)(9686003)(122000001)(26005)(82960400001)(38100700002)(186003)(8936002)(71200400001)(7696005)(52536014)(5660300002)(4744005)(2906002)(66556008)(66946007)(41300700001)(64756008)(66446008)(8676002)(4326008)(6916009)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dj5TY6HVUfjJOu4d7FsSFo2cybgJZwKIGNd81eg4Ms84uHtUSbic6PbFM//l?=
 =?us-ascii?Q?2VCZ0wnQch87gcOocDKIz9ooEIwJk/j2M+5jy/9QswX7W4e4epr298um0b8r?=
 =?us-ascii?Q?OULiB9m4I4eJXGAV0HCvS/9CtMZqOV1usWaQrtBzH86bWwGReqkNt15J7Zh9?=
 =?us-ascii?Q?a83J/CYB34uz3JN47JOmdUMKmDEdF5/cXFiD3fcnOgZ6nUrmIxorag1gpjUv?=
 =?us-ascii?Q?0DFa2mBurtYvu8/jyQMopScC55pm5jJD52x3yOBvCpWov7uU6FsU5Jl/fqCP?=
 =?us-ascii?Q?iZnYPAPTzdm32C8SfpZhAVXN/PcoXYkyZ+O1wOgypB6iq63zXyCy7CpYMrgV?=
 =?us-ascii?Q?4SHLbVBH57ui5Dh0iLoWS2u+tr6sIBsK7z970NzLFrimtmIDB/tAt1WOeQDA?=
 =?us-ascii?Q?DLF7k6LaTRGxXCta+btCnrE94bB0p23Q/2gcbzGh/liDWe/D4xXvrPFVJaAS?=
 =?us-ascii?Q?+dhHrZ5mQDA09aDc9jYOHyqpSHHL2ew26aI+x/gPKxnTjgo1RcehuGzqMbDZ?=
 =?us-ascii?Q?D7Sdz6xXMJMReBvQ/5KV9RYo9Zb1+GNAgyrwSyftn1gbUMEgp9j12mZ+7HIn?=
 =?us-ascii?Q?alZpio6O8UaCQRzt3YBG6qkuTRZXs6w4AaaDc1kxTHHKv0Vpa3VVyKBTKAPF?=
 =?us-ascii?Q?x0PkS9vPXn2W8I+1s3qMflu6CvDV4moFJ3ByaWeLjPEgzbRI5cczBCfUS7RH?=
 =?us-ascii?Q?+ir9NM4l39nActxg4ZuwadxCgu6YUEPqljcQqkvC8JOHVytzaLyBhg/VXQsB?=
 =?us-ascii?Q?uia+KV0ROcgEjOEEhmMuUhbnQ4wTMHyPNkewYHJ3O3ErpNyHcutaCjKbcI6F?=
 =?us-ascii?Q?OPFjw05P3ZK02x2Zi/VYM7TUNRK+nEHY2pp4SSy7VqGhTykEYF1iJQmw9fOc?=
 =?us-ascii?Q?jLA4w7Mo3eB+Kq1zltwEg/s9KBJerotfAN8wXi6gRUt0lYjwQmONH14OUoef?=
 =?us-ascii?Q?XY/qCB4PxMaW69Y2veW+xhLrjhtw1IfwYzAoxdSdsrZn2AAo6vbTgR7ZBBg8?=
 =?us-ascii?Q?4X70L1Syv0SwvIPTnxzO+h3CthpFqf5kcWE2Pdk+qnDT75+bfZTLlnY8Fv8/?=
 =?us-ascii?Q?+bdkRj1YMhZ6mVw4WJaGAGZDrEjVtTU6Yfv81RiVSnJxG1tyCucxLfyjccAg?=
 =?us-ascii?Q?gN6YkCDxuJsuJwxmRhJ0MesjvMr4etoPxRGS33rNNLAqo1fCdExauflADVuT?=
 =?us-ascii?Q?6rEOMEJbFNRISFCEP2vFN10a7JVe3K1i9nxngMf+a1bXkltjdeWHZzBv0gJ1?=
 =?us-ascii?Q?TNtbWL9F3fDpFNRiZ/+2MPdnyLHPJKTHis036szuuSyEEhWC2FvPUJo8VY+d?=
 =?us-ascii?Q?sy3LTYLQVCSpYR9GQ3bUpozMsa/2Yu6GnEsJZpDfcDvI4zuUuBU9BXxA+Dam?=
 =?us-ascii?Q?1MPuMTQD0IYoyInsUvZ8gCEtQbFf43wI4gx5GDhkjY+MlZd74kIYfR60UzC4?=
 =?us-ascii?Q?/xzet16gjds8wLFxEdXjOSkdpJyk1rVSaFW0cmJwRj8kkGM4JFHn3yPP5dyZ?=
 =?us-ascii?Q?xapBCz7B2NfIgdvgdd911BT6Re0EDuyhVcKox+FW7yQdMWBymqmA3qAqnfXl?=
 =?us-ascii?Q?1JllLQ8n7zBUzZWLHq3sayJcjHUD+P9z3juo1MDL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20e4873-9f90-4abc-f4d1-08db1b8d46b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 02:16:19.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9wCz1HcC1GhMUO/zsRUs6blfaPJP9B9eUv2bU8N7nlXUxihYvkuoL9kdBGsnd3xt1x/tVX4jTwWwODOUHch5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6010
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
> Sent: Thursday, March 2, 2023 8:55 PM
>=20
> On Thu, Mar 02, 2023 at 08:06:27AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, February 25, 2023 8:28 AM
> > >
> > > These items only needs to be done once per group, not once per device=
.
> The
> > > once per device was a way to make the device list work. Since we are
> > > abandoning this we can optimize things a bit.
> > >
> >
> > Are we sure that a device hot-plugged into the group won't increase the
> > list of reserved IOVA ranges?
> >
> > Currently iommu_get_group_resv_regions() queries reserved regions per
> > device and then merge them into the specified list.
>=20
> So, maybe we should export the device API from the core code and use
> it here instead of this group stuff. We don't need the core code to
> merge each device together for us anyhow.
>=20

Yes, that'd be clearer in this context.
