Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8773D7C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 08:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFZGdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 02:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZGdK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 02:33:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0BBA8;
        Sun, 25 Jun 2023 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687761189; x=1719297189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O8CmLEgTjztZ85ZgYYU4svxTQlQZKyN9c8xe9Oap71M=;
  b=E6ctwweO0KvBCAJmVU2dOnyVfekNNcP6LTJ4qevQFVSsmNEMLLTl09lr
   jL82BZ4krpdhrH1ikct6NTN01bX/Be9x3Am4hKORrciHydw1GTLl+sZew
   PhMVvbLr9KMZIU8kA1t3dm/lEKllHL16TUEc/PPOygF0iISpWnetK6NDX
   o3wzDP2sc010UqqYSPG4mwTOZfSTCM/nrzLoxQzoGv7IAlVeW/TrJjAKw
   T30Jjj4s1EfSkg7W3flZYNYGWqx7X92fDjvDqdgOjh2gDQwP112IOdNAT
   zWkdkOstDqu2cz4Llw9nkZwOQWvf86Y8U/qT754TzPnn4msf11ygnwoWp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364638312"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="364638312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 23:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="719228899"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="719228899"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2023 23:32:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 23:32:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 23:32:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 23:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaboVwBoVctbFTjs9dna863jxk98NgZolMByio12TubT4KETrB8U9CEDFNTNxj7oYN8uRXiEYMsxBeUVXTzSM7WPqKKCGil1G1epvX54dQBdqNNMzayUFo4kctX8ddpG7pnqCQpX3tJDQNmjhrIFkIQnlebgtGllbV+GYRBzacO9VDNJgGYLz8aLg66LDCBiWh74N/PTL9ekHF5cm9Lc5gDptqGqgr9u8fuAOclrkd4hW6ttaGM8EwuYuc1164q1xNp0XhCBuskJjcyzsLRAM7J5wMt+NFfVOhQT6DenWjFfvSJsSi6eOz75PSuKNSB5UGN1FDpfnL1fw8BD0uCR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8CmLEgTjztZ85ZgYYU4svxTQlQZKyN9c8xe9Oap71M=;
 b=bVCnbTJnAAdahEcsBzJEcRPaiUonko7k2Piei1Iob0n+yulLbL9mHPxEjgd4pxw5sjDIfnLPu0p30jEBxhFIdScybLKl0jGw5iMvXVGM+YwbtBA6LH5UJSyOZmsSCF7AN++zEb/G328a3Kx1k1SZgCsxEnh4t5EtgEmJ3+tCy5k1To75a/zJ3RUP/UhHCTq6OS/E/E/8eB0mhhH96JRVqpVd3PWpzXBxZItCvb+S4vSjbXjIx98QBBM1ZHgdYMf/DSLH396bXzoQk3OufBJoqQUXSgND/YRX2zb7Ck5LDXlUXBchC7Clsuet3gZCPehiQGqr8ZpHmE+hBd1BHjlY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 06:32:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 06:32:39 +0000
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
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOwgADAhgCAARBZAIAAdf0AgAd8YcA=
Date:   Mon, 26 Jun 2023 06:32:39 +0000
Message-ID: <BN9PR11MB52767763FF245EC5820A6B728C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJLnTt/lCyTYBm7G@nvidia.com>
In-Reply-To: <ZJLnTt/lCyTYBm7G@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4987:EE_
x-ms-office365-filtering-correlation-id: 1d162002-7443-424f-3428-08db760f2397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eneswDqfVgqXb1h2oD+E3EL+gneqB77+BrZdlhkdZXRHL3RXLyiI6taVnZJuW5/+x+8LIlZ/f6jpFGznrFrDKwI0QbRUqDLqoOuhscieGqykZ2ZvsloCOH5ZFGWKxEIrgLvGkJn5+sF4i6vWWl1NVebOid42ERq+CKPw9il29o1Q/5/ltco8H/dDo3GqF3pAI5b+TCxZsmEbQ98eFwf5kHhOarlt2VA9LsvgBx/Gb7YpGib5NdCUW6Ak2+uJjbAscDRzIRt+E4Kvhv9b0uL4JBsUX61bWYIKu4nsAoLDNHN71Xs9Ih2g09z3/au2YRAiIXZtj1ZNsnu34hjC5zP/nU3WwLhEMywkDJqtp/2CF+p38hMWWuvBScJuem30xLy9ad81XMhxRMzXGVrsfoCqGFOg7vRzvpPpO53Hn9Ss5YneIZ/7P6evtMAGaLYBPqi4DbA5+r12GUfXtWBUf7Nz19tjGxOlhhY+HGKwq6uDB10KQToRIySFkbxIsNwyufXG2N05i1b+ANGQ3VGkTHB1jNkUf8TbjVDKPF2ZQ85zuXp8AU9Z+iqq66Nhzh4zkpEbEvzXemcKQ9pdwwfkDXX7AtGA7Rqsw24ublLRih+e7M44FovhpTjJQ+CFY9F0fpUb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(33656002)(5660300002)(52536014)(7416002)(6916009)(86362001)(8936002)(8676002)(41300700001)(66556008)(64756008)(66476007)(38070700005)(76116006)(4326008)(38100700002)(122000001)(316002)(66946007)(55016003)(82960400001)(9686003)(6506007)(26005)(186003)(66446008)(2906002)(7696005)(71200400001)(54906003)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rhkqy48euPcFZ69nXjTQ1FTQolRCar9i5Sj/93LkG7M8ZIBJ1hyRffPC95Sc?=
 =?us-ascii?Q?QUQWAtJW+O0+UsJnUfJ258BemH2dGDybVpGO+BMAlf6NoTiZqTts5SRGOKcg?=
 =?us-ascii?Q?eCdOBEzbFv+d9DwfJF6vPGsAF+TrUcQpU0OKaR1N2tfjZOlZmnhIJWxvycgJ?=
 =?us-ascii?Q?Wjzsz2jynPjKEjjgrNvAUBqLSBpJB9Ju1XialGCORdltqEzFL1eawIkPoSxA?=
 =?us-ascii?Q?CKklS7sS7lk3zmISEy181biHOjiuhtUA20mZguXHVbL0SOiCT0/sIgNNpB/K?=
 =?us-ascii?Q?RQu1fdfO3OLGcxf/ToUg7X6Hj8KhTk1eWs/4J29Fx2HA/cGl97xEwIozUfMl?=
 =?us-ascii?Q?1xd2ArkQt3wfXjC2lqdg3xtdZV7RIH7wZ4YOR0zcKcnbBueT/Qy9Zgz9AlIF?=
 =?us-ascii?Q?3Tv4gC+mnts19tVFEmRmgO89NqO4ooDCypggpCJnQ5svCUBdCJKvBY+NS31W?=
 =?us-ascii?Q?KT70P6UYZA2YiaaMe2nO8QhVB783oYgq2Nvr4mDn3onwYIFY1wwzPTpF9K6S?=
 =?us-ascii?Q?GYdE3UPLi1shJf8e9D/9m5JOuCSOfgCbcVJ2K8CHNPMeCdZLXqRjnHMI8+Rl?=
 =?us-ascii?Q?CClhfBJp3STvKYjqxqjGgEu411RYW3rX9QdklSXPz7Qj7X7Q+CNnsQ71U+Nj?=
 =?us-ascii?Q?d0iwnZpgaE35VwRfPxwIkIoXjZYWkNwROX8yn/UeuRP/NxNfwjQDYG8Owv5v?=
 =?us-ascii?Q?ixtsUkZvoEIabN0vD3NJryUB4f6gCK8hYowEBcqpZJDJ8n/Mdouo6QrbQNyM?=
 =?us-ascii?Q?2ktFQdhAvTt6OieswQ6VezJIxh7PsdALjbovrVGZ73ueuJa2t069cNHQqR9c?=
 =?us-ascii?Q?NqZcalxl7EMQl0L/w3n47E5k///Ca+yok/2RrJxX+QSt1KBgPz+83vOVsD4S?=
 =?us-ascii?Q?dPPeRMCTU3WLMJ8h3FaBNOz8Uan2bkYOgxsjJsW+IkbA330DaU3n92IbqmFu?=
 =?us-ascii?Q?H0/QHSl0mM5xZUqgawJvb73duQp67TcWntbn7pG+akKl8DqcXJuOwrtY4Nkk?=
 =?us-ascii?Q?Bop8f9wKLeGQH68hO6UqYP4Ds96Q7eYDloUBX7GNt/kqLffSKefNhIXggaVZ?=
 =?us-ascii?Q?7gLWbst7gAqv3K3hPm9nr1Tep6SB2lW+k4ArcH1OgFsTo8jcsxTd+bMvXRyC?=
 =?us-ascii?Q?rjGtB/tmQhZZAD0mT/QJGdw+vLZeV55oA0WXl7nV88u2gih6OqozqTL+sqCn?=
 =?us-ascii?Q?ayu3IYoWOdKF5AagnmeCbbB9aB+yUbhHtsvJFzBG+at5DeKgEjGF4yrCJfEV?=
 =?us-ascii?Q?xdsuU8V6mp+QTTnz79bx5V1Nsxdyory7P4jUoVTbg3XoDG6gwusG5ljzNGc+?=
 =?us-ascii?Q?gkgnocKwV6D2qObuXgwo3xQXoarzPc9Ld7ifF3OSIU2VCdX+Z7WqIQAaHxUZ?=
 =?us-ascii?Q?S1ESh2yxzL50F8UCKlH98PQ3lOWW3MTNgn5TOJhcGZW0eP6Db1SBYh06B9NS?=
 =?us-ascii?Q?x4qDfFbGvRTrMXTp5F53zvuGYpRbfauONw6z3C3yFjKbOEc4rPTUtRLeqoIc?=
 =?us-ascii?Q?n4Du7ZVqSRu08SYLJnWe+NA25FtJmmLEbLF4RXurBFXcTCj95z6nFJ4L5cpW?=
 =?us-ascii?Q?9+NqUlkT0wIeES4icxpsw/pC5+e/vDj043r9ogQn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d162002-7443-424f-3428-08db760f2397
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 06:32:39.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUOu7DEFHbkcLbHI76Dth1+gY0Bye+trt5GdqtholDdnrTgZ/AY3qOOqJFddcadLaK7PsoUZx1ZCh2zqUWRsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, June 21, 2023 8:05 PM
>=20
> On Wed, Jun 21, 2023 at 06:02:21AM +0000, Tian, Kevin wrote:
> > > > My understanding of ARM SMMU is that from host p.o.v. the CD is the
> > > > S1 in the nested configuration. 'identity' is one configuration in =
the CD
> > > > then it's in the business of nesting.
> > >
> > > I think it is the same. A CD doesn't come into the picture until the
> > > guest installs a CD pointing STE. Until that time the S2 is being use=
d
> > > as identity.
> > >
> > > It sounds like the same basic flow.
> >
> > After a CD table is installed in a STE I assume the SMMU still allows t=
o
> > configure an individual CD entry as identity? e.g. while vSVA is enable=
d
> > on a device the guest can continue to keep CD#0 as identity when the
> > default domain of the device is set as 'passthrough'. In this case the
> > IOAS still needs to gain reserved regions even though S2 is not directl=
y
> > attached from host p.o.v.
>=20
> In any nesting configuration the hypervisor cannot directly restrict
> what IOVA the guest will use. The VM could make a normal nest and try
> to use unusable IOVA. Identity is not really special.

Sure. What I talked is the end result e.g. after the user explicitly reques=
ts
to load reserved regions into an IOAS.

>=20
> The VMM should construct the guest memory map so that an identity
> iommu_domain can meet the reserved requirements - it needs to do this
> anyhow for the initial boot part. It shouuld try to forward the
> reserved regions to the guest via ACPI/etc.

Yes.

>=20
> Being able to explicitly load reserved regions into an IOAS seems like
> a useful way to help construct this.
>=20

And it's correct in concept because the IOAS is 'implicitly' accessed by
the device when the guest domain is identity in this case.
