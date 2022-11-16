Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7C62B14A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 03:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKPCat (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 21:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKPCas (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 21:30:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A71629353;
        Tue, 15 Nov 2022 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668565848; x=1700101848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q4qAvnHrqG31qMRXkVeU4p3RgUxPq+15RUMLcdgl9TY=;
  b=ZGUB9iwg2ridFGIjV+SEWBVEmCKxXFIz+HyyaKFee6xnDJeKWG5W1TDd
   N6mNpi5CpexrtnYppvl+e42m8624R8P/qqQJmKJU6Mt25M+sqZTBgDb2n
   zYDJ2LZkk1Z1E6y0dI0BBU83mYFHom+Ne4gHYt+Jf8wodZoFXzt4xZ7Kg
   qXCI/Drfj0oxJwwknd/agPJT9eZEHirzXSME7KYzrqIeTiPaxG8VJqoGj
   0glz9FvUclx6z/CMWyoTw12mg9+gEunA/ibyYA/NvncsxWN6dERJeQz5b
   5fMkrwgkqL+26srvjQSk5yYG1W/PppJMrZSl+swkJ2OncJRnB3f0ByzLg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374559423"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374559423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 18:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="764145857"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="764145857"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2022 18:30:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 18:30:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 18:30:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 18:30:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqfGCR7eSw9kpfYmTQjloSE5sSJ1+NsdvY/XggXpEFcxOgiHGug0aBAl9EODJ/Ogz+Z5k0NZ2427pvNH/Q18rnt1I3aCgrLIwA6pkf+o1Y1Q/lUMvgH9xvSLLeH46bYVvK15cWeqiu7K1eXoocKbbZLRkdyJmBdoM+0JtWbOl9MavpV+YBI56jq4s8Jj31Z1ouxfqDBQgElZAQ2djIjM+77+NIZGHcN9vJE372ZI7QdM84qJ7KBniuoJ+/ULkYLcgLG5UYdvUErryF4XeFdB+6pxMmYNKVYZLBamte93EsjesLPJQlbq+XFCbqOuigMb3PvYwsNuvNT2ZvOJaKt+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VKs/flcCnWOenf4V2UNsfylSxatu6Zt0UU7lBRgvLE=;
 b=dxLvUH05qt2VeFMC4eqqWJ1Xf5bEGu87y6jKau933aX3T01Se5h5j80bWGPXkAeFvSPNg3jRLVm4dohVtvhbH+qAYIsFoQr+znu6uv+NVZZobdDzrbpru/4woHlwF3pklJIZrZnghL0yv2ZIAhkhMcn1git5VYUlDetweUIOigSfGVBSZDZk/O0GVMUTKD5KOMLZXGjhiAQfGVA74oXd7cg4I/wo6ErNMh7NCcADanbtOs5sUeHB+F7GScU9gqaABb8uuejnHkRFW6r3/sFVq8/ZNnK1I1s0ifQNep1T/kPdKV3oMx/fWvB7yo7h/z2M5Ez7Fq//DsBechWTepB3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 02:30:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 02:30:38 +0000
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
Thread-Index: AQHY8wv9weOL8WzpqkSvohFTeBt9pK499F6QgADXp4CAAIydYIAAyJuAgACOkcCAAA/8AIAAICfw
Date:   Wed, 16 Nov 2022 02:30:38 +0000
Message-ID: <BN9PR11MB5276D8FD2991EB987680487F8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KMbyVwS6D505cA@nvidia.com>
 <BN9PR11MB5276CAB38B1691983A20B1D18C049@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3Oqq74bKsQo1YMH@nvidia.com>
 <BN9PR11MB52763671DBCFA976C0038E6A8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3QvrFSqqxcT6I8A@nvidia.com>
In-Reply-To: <Y3QvrFSqqxcT6I8A@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7047:EE_
x-ms-office365-filtering-correlation-id: 420c432f-242a-422a-e337-08dac77a8c7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWxwfBuqhX8COpsy3lQnnmDDduDjzgidgisrXEwzZUXvMYZyEeVhFg2Hg2AuOqkPFmiiUa1gieGx4T+CLu2diQOaqz2ZYVw69xSeOXAvuB5RwwzMTj6WkEq6a3uJfBcuj64VsKdb4KONtWibEl4FKx7qGwz7pT8ZtdVJKH/ZxIfuW8GysUhq+oNUbJ1ch7KKcQHna+mYSuoRUTAGo2J4rYI/Q7oDEbprNAPT085WedfJ0t+NFZSCborZf5PMXgBshpdlI/8mhg10InGHlBUhLVN5wMDfLPSDaKRbr5DI1OmzTcG7cABdeIFjn2OMe6rJmSGTVc0gQPMGfKTBHbZNzlqt9bXu3dC1K3Z7ytvaq3Fp5XkXDmd9XQqYIMGsxVgp+Wk2edKEpIA4zH7bC9CFCwU69qxE9UPg+U5cCB3S7oRfSseipzhS9cDQZ+MH2B69wjJyghhRI6k1CCzQ3qmP0eOnN71FJRzLQRHqvIxMmafcNua2yesYzcJEC2UlrkwM6PZ3eE39jW3B29Hm/hJtMt+Y5UQWGapo8zoYadfohWv/tT8q50ZJ3H7Vwzu8eoDc4+OUndf9Pe1DS7atJNgBddaNS7iFNxN0ZDPRTYOboinEQJZqwMP7Orp0gg4HdeJCqAJP11Kka3tue4zYYwpjw37WDhPErAeFQzY8Z+9iAVANhLyfEbnG5OdKYpiLtFU6Eh277MXAgVE6J5IVn5LoTJ+UPYQpBBR46lr2WbO0lS1Ei3sxqvAV+knK9CO+U0sXZx19WoAFHnvIwBHQ7uGz0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(7696005)(2906002)(4326008)(66556008)(64756008)(66446008)(8676002)(66476007)(316002)(26005)(9686003)(76116006)(38100700002)(7416002)(66946007)(7406005)(8936002)(186003)(6506007)(41300700001)(52536014)(38070700005)(122000001)(86362001)(82960400001)(33656002)(5660300002)(55016003)(478600001)(71200400001)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/bP2MsEM9nJVD13DwmpHaFJp5Feyh7G+aec6xlLh07ioDDcm5Zbc83ZhS3Cg?=
 =?us-ascii?Q?S3E/5Fad9F7ABE2YWOrIr3bzSFhdZIOQqHlG8/3b8vZHYg69iiC2M1rPiBuv?=
 =?us-ascii?Q?46I0puIG8x13wGSIBdktlIXjUvV9qk/iIaw8W7JjGdxEL+06XT7NC0Jy/PK9?=
 =?us-ascii?Q?FgIP5zKGC7hPO4RMrKAsdJ9rcKVMpHaSH23JGy/4a48pKUwgE2w63gi5b3aA?=
 =?us-ascii?Q?1p6zk+t0KRTQp23w5DPpvmvRFCQY8852u4Gh1+SnlbucoRxQYjswXISpVsOt?=
 =?us-ascii?Q?Uwtu/9sC/QfMjVk8PdY0BcXgJmVjesZZvUlZq9i0F9tDtD/tv13303BL1vIY?=
 =?us-ascii?Q?CAYFw8jPlprsfHoWV+0FAnbI7lji3wY6DFXYSN1rprVHpxx12/WtZHTPZGok?=
 =?us-ascii?Q?bRXN25xp3WwCqAloOp72zYYE2ltnFUsEHd1rsPLDlTnYH8gIQkNcHGvu4LkO?=
 =?us-ascii?Q?cCpUKNJaA8e4JmaNjbvoVAcMsg+IES0r4QX44lOSrTDm0gFflorK1zcUT88m?=
 =?us-ascii?Q?F0mkwGv20G4gMB1ofUBGkw+we5nfyTetax0sxNIXroE+1Zkz96dYSyKzwnq+?=
 =?us-ascii?Q?rkf9QgwN7uXaPLKwZLld4PUhQnZWTcxias8HoVlOC8RhcZkMWxtr8w947fre?=
 =?us-ascii?Q?0lTQQx6nfnpiOrh3BhT7OfayUyZJlm0Q+xE94lvM0WRCXlLc3GIXCBEUiIgj?=
 =?us-ascii?Q?9PdFbNUbXveWfpE2GZfpR4EYdAp/wQ55EonTiIHBusRYoIS3JzyA5qiUNRh5?=
 =?us-ascii?Q?3Hcm09Gh6RyFyCat5sKvZj+dAaFj2a7+7eJGxDeLbeAHEfz/irj7dTJQoqhI?=
 =?us-ascii?Q?ao5Dm2TB4A2l2jVTRoNTsr373yGgR4meTzUiPqHNIkkqRn8cw4UxCwOwdg57?=
 =?us-ascii?Q?Pn4F63zg7jl6K6cJNeMdJjrNajKMhPq/kgacBJPyHVaghm8VixGQPCKPQpfR?=
 =?us-ascii?Q?LGO/yHkmFKnoZ+NJFb130ndSgjvATeXgQe61DDMMde0YyacO6YqujplKQhJV?=
 =?us-ascii?Q?ZPG1IyfgAFpb2LOTSK3zYzDB0DtMJ6JF4cRnhlJ3l57hW9UMISdYm0KcC/x1?=
 =?us-ascii?Q?TKLj9EJ/O1AuJOIaUA1mF/USTSsqvBYR6t1mbMp474thhPRzji1gj0YPz9FP?=
 =?us-ascii?Q?2/3I0m0FZORnX37XyvkQkn5a3gUexLIS4CrwPb0DipUuM9blp57KGoxPQhG1?=
 =?us-ascii?Q?3YmR5/Cs2r/LfYSe2XMSOWOgrLN7IMhM1/ImwtNRKKpey3qHJ5/ZGSYlG2RM?=
 =?us-ascii?Q?sDVmu1pmUKElivj2yDQD/ZehzwZqYLDulsI3YVvtiAysoYDBhX0zUUTWByf+?=
 =?us-ascii?Q?70m76cF7dFye6ERjLq5RBmuwcsELiKGUTPYeOHjY0LQNGQ7MG9rH9WfIm9+e?=
 =?us-ascii?Q?MUJ1KDbxn+2exjxsL1826oLGt6GQ6M8w1H+ALMF8ZPrCLcXSs4B7dYZsPyW7?=
 =?us-ascii?Q?wJSOdFSLUUBL4wzRCrUKlZpTb17vY8lwDpQk+w+C0O0l7pq0kDEiid6ecqD5?=
 =?us-ascii?Q?usoeQmtJKeXeXDRKdWGjwciRFw8pZWS+5P6pMXXG6tgMdkQf50EoA2jlkxct?=
 =?us-ascii?Q?JkOw9Ci+egHq+vpVvzDorIIQx7hpxml0YpFatew+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420c432f-242a-422a-e337-08dac77a8c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 02:30:38.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZwEPId9nhZ6boQTYzgYixmhi92VdjQ8KcCJAq+cycVmIYuSDVCVbPVRsHrQd5N/KsRL38kRTi+nphOdyzTsaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 16, 2022 8:33 AM
> > > This is the comment:
> > >
> > > /*
> > >  * This is part of the VFIO compatibility support for VFIO_TYPE1_IOMM=
U.
> > > That
> > >  * mode permits splitting a mapped area up, and then one of the split=
s is
> > >  * unmapped. Doing this normally would cause us to violate our invari=
ant
> of
> > >  * pairing map/unmap. Thus, to support old VFIO compatibility disable
> > > support
> > >  * for batching consecutive PFNs. All PFNs mapped into the iommu are
> done
> > > in
> > >  * PAGE_SIZE units, not larger or smaller.
> > >  */
> > > static int batch_iommu_map_small(struct iommu_domain *domain,
> > > 				 unsigned long iova, phys_addr_t paddr,
> > > 				 size_t size, int prot)
> > >
> >
> > I meant a comment in iopt_calculate_iova_alignment().
>=20
> How about "see batch_iommu_map_small()" ?
>=20

yes, that works.

btw is there a better name to reflect strict PAGE_SIZE only?

disable_large_pages literally implies no >PAGE_SIZE alignment. This is the
confusion easily raised why it also refers to no subpage alignment.
