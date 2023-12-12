Return-Path: <linux-kselftest+bounces-1634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA7380E14D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1376C1C216D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367C138E;
	Tue, 12 Dec 2023 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkjKBnl1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D31D6;
	Mon, 11 Dec 2023 18:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702347382; x=1733883382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tnQzK8omLFr00y6USNr4GI8/YoYRJu+8FpMKS8Thd5I=;
  b=OkjKBnl1aBVYdxkgb1Ka4MaEa+pADX9h1b4ejAU3SpaCYP9tc2S0QUfQ
   XyzaTtTXDQBWSlBFS680JSMojYXjjJPjC2u7/JKmC7mRoB+WgxMj6uMB1
   /MPJmwNPfns2HbQ2R5CTJJTDjQnhCO7Yd0pV3ex6ea1JQ9/ueB9oUeg/M
   IpE8YRqpzoC9ZopSvOV/b5sDpjG1aYH7+w20SWDMYBWFBzZjIp9gGu1ix
   Etwk6zdNa4JBrOK1deODKmXmZ2QxyI947jmoUIpc9BWYrae8aVXUy3DBw
   hO712NMDZeliHMG/sP1UDi6wf+8eLTtLBPbzP5ViPbn3V+HwGzfQSmh7m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8107853"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="8107853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946581865"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="946581865"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 18:16:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 18:16:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 18:16:19 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 18:16:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0tADcEAoyVuEaUxIydx7KcGrjFpzCgIKFieaQgU5DdgkF8Rbca3lgrDcua7TzF1NljxKD5LNq0HNwMvtRU1f+IFp8dig9TZ9G/uqUIwFepjK7RZbiMbGfnJ6kFgPB09A3udzNJ0c7+Y1xtk3tIAunLzwWVCx54tZlnTVjlqIfWvKPEDh1zagbeGdzWhEcW6p1MENf67z05Cgh66tujqyRpTqKKJIhIzI8wjt8D5YBHl9IhXH6jAYi7ChR/PTaGu28oh17QLdNnapCaoP4HysAlHy0QdVElPoReqRsufYL9/fibmAoyniqpEifKmJyDS7v3nocDebkHW4KeG+dxyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMtkO0YlhLJoeSRr1IVZDkwWXC7lL8BRgCb6Iijt5Es=;
 b=kLbiRYGdk6S94VeahyC+FTPTpn3GEIJMAOnRLqIaJH5bDkuzjLhLN6UlsNddUjv6iwWMKj0f6TY0pXEUg7tEXCZ5WyGML2Fbbm/vkkKKmJFjRe7as0uDJKb2U0NimzxO3THRnPgJ1eM18bKJgApwea72ZKKWM1tUPrfil1O0jZXKI9n/fKw22MosMPZgc0zUk3rfZRxKyctxCZIRp47JnBdUk7MA5FIdo9/vPYaOuP3F1jc71F9fS/y0+h2UzvFCqBVhANgChfmbyE0swY6PJGHoir4qnDvXIZoOBJKuEJUp+lYe36FdqbMrshEsAdzXXFtCctimGIhWdYIdCuukLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 02:16:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 02:16:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2EKyfzMrBBEWzcc+IDcJP4bCkdsqAgACIdDA=
Date: Tue, 12 Dec 2023 02:16:17 +0000
Message-ID: <BN9PR11MB5276DD7A14E938973DDEBEC18C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
	<20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
In-Reply-To: <20231211110345.1b4526c6.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4817:EE_
x-ms-office365-filtering-correlation-id: be49b604-8e1d-4c35-04db-08dbfab852a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Vu8UBJ9QYbYxcUqbhRhN1RcJnR7CfmIz0a0aYWEgyhFjiXyDcVID1ipFSezNpc5UgtjU+Uqc6ZAtXU1KBJJAuHg4T5Au2wpxVYtJVNU1qwbGwS6ZKZvU6JNn8tOPp5a8mOEPpmH52zSZz7bgcz9Htsm02Fa6s48fRo+PndFb9KEL9Z0nlkIQWsB2IEhvNveb9lSFpa5UKoWWMvIqPLc1IPZfxtMrb95cTebrKutNlgSIEj/l6Re6CJM6kt63BDIX5vhEhlJl5hTvEAQSGFp8JPWuWaQb6Wcjs1sUgz0NHgoXPwAguU3sIpGMNfrUo/4CXnm7nuZz1/unusqLGlCjF67bUNzcjSy50n3yxyIwXUCc70dN2mnAItrObmaaldyHw2PuqsIjul/vSYLzhQTQJ+5xu/pD4MCcIU6ov/lndrRYw20KEoV0FM8r/LdmaIeSGWi8d5kCwe8v0jfMV89hXI03yyBerHue06vXZ9ZEX9Do6tc5HaOnJM7RwlBjgsp3/v7kLtuYvwZCLO3KCY3n/38gUSPjfvSl3sDrioN7k9iEUI/mvuRzJvBzt9cVIk+S1YcVxuSXjkH9iafMP5opQDh47jpkv64BejLvbGIzRUk+9tAni7qUDgoIGjab3Lj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(38070700009)(5660300002)(7416002)(2906002)(9686003)(6506007)(7696005)(71200400001)(478600001)(64756008)(33656002)(122000001)(38100700002)(55016003)(82960400001)(26005)(8936002)(86362001)(4326008)(66476007)(54906003)(66446008)(66556008)(76116006)(316002)(110136005)(6636002)(8676002)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IGNHUMVoJikSoGOxjoFU6R+SxG6R6kDraTelirCZ2ga6nl1zf/ERQ/IzhUUP?=
 =?us-ascii?Q?3Z/Ya0Dmnz3SqsdGq+kZTAGebfKNbScv7nQfv6HQlVif9mmZdTWZiuFgV4Tb?=
 =?us-ascii?Q?MouzHNK0NRhkKsCSOWM9q5U6cMhyi/OClPFyQglqsuEZShCS6+UTJcdg2H82?=
 =?us-ascii?Q?/ycM+oZR94ibbxHcT8BTvCsIGn0YAp87CeORXBP5ffgbA8pcLMSZYMiHwbfm?=
 =?us-ascii?Q?h+XWJfpMwfwqz2Z/lE8KDvghZixqlI9L3glWA7h/+cotgC7Aut6kJ6PWKNWO?=
 =?us-ascii?Q?jmyT7gEkPc252ZbBZKViulTZ3443PxaNbCpirlfYsP9DvqmXZD6QpWLTCU7Y?=
 =?us-ascii?Q?ShvHwNIDWWeMCWbj3t4R78TFpv/6O5xF14LBMAC5UnYGjyvVfCcAYRyzMpSo?=
 =?us-ascii?Q?rUUW0fQJ5GweWqOE8VFZTpQ3fw+3YZkS+2vbzhPcUTgbpQyaXYB+DBj+2fmb?=
 =?us-ascii?Q?rykI4baPbChecnzuMWoq0879GRXW7HL5dW1d3A6mDpf4pZdJRBjEEcY3ycxJ?=
 =?us-ascii?Q?c1n4HqvkpOAb7AIJlIQOrhejw9PF1qiEpNWCAduGFTPtUqFyw17ML2Tzbv3W?=
 =?us-ascii?Q?1n+kexKrj3U7OQEbJeVehrxueujy41XjMYHkFZ+3QRvr9MCuRdt4+B6LqdaY?=
 =?us-ascii?Q?ndbe1N60bAsCVMcwoLNE0da6Ldl9YY9GP7fCzEnmdnjvYRo94iKk/9OHPkaB?=
 =?us-ascii?Q?MqQOWfP5clMnOqRnVcyDAmAOfUADOgf3ssZAMMlbFKg0IZohbftiUcc5t+ky?=
 =?us-ascii?Q?HFSGspz/XpIMG/4RLfE9Yz+3mPnr324d95ZbQCKlsPJYqW+UtdgEjd9B+wsW?=
 =?us-ascii?Q?WQfqKwSjcQ9xOPXIxK9CF6luDD+Qoh8RCc5e7zuMF90FmmMTTtQYE2eER17W?=
 =?us-ascii?Q?lfAX7NbRWT27OaYAkNG3OBtjgJ44GKWoXBZKpOU3htErWXJyNZ/bLOPAGjEO?=
 =?us-ascii?Q?57rLqhNuLDwnWBWG8SXUBJOh7AJnxK9KSp7+f23o/0szpPgdcioVpsYFIjjV?=
 =?us-ascii?Q?3uSWh+eqpPhunwk2k48OqKiCQpb7CBzMpZPn4VuBVSg4iQwsXF9jR9tubM6b?=
 =?us-ascii?Q?nRg5mzVZ+i3PatZi80VfdFc+jDT9LP8aXKDLO2vZl+kZkk2kZuNc0TRCGEb9?=
 =?us-ascii?Q?QPeReo6zeUFBzqzz53hy2cM+UTd8Y1ZV20k9zMrvYCdqniukUVluM8KCbZZw?=
 =?us-ascii?Q?bVdcXkcmktFUpvQuURf2GppnG7Ge4PsZZWZsicrpahAH+QyX0okcTI67BcOK?=
 =?us-ascii?Q?Y0dhgRE5tbEScYTIEjR1W7W3UcM2OE19+7YQT4ikk64EQr8oP+7f+u6ZH+kd?=
 =?us-ascii?Q?DvYEIAwIClFVNER5yaBb/ggZok8UCcK4gQaq5xKrYsfM1h0mWOeVq5CCE5s6?=
 =?us-ascii?Q?vQkd5CA4DXlkCumvzNLVxm+ZuSJuT7Zu7ujYv4o9oG3Mgd3qa0k0+tGygtWp?=
 =?us-ascii?Q?kHYug4fkigTmi3Gd/6tFN+fcQmcesDoswnN/ZTeWQkN8xhEzUDLh7Tf/ZvcB?=
 =?us-ascii?Q?FserOp7Yl0v5zBiZDPX9yFCQYnqoORahafxmeb13CcDPMFdu0I2SXyG0QvHy?=
 =?us-ascii?Q?fPLSw8Do/TtWfhD1VeVuKmuObthnSsjCLIV4DeTb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be49b604-8e1d-4c35-04db-08dbfab852a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 02:16:17.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vtRiQZzVl5jxja6SFXbwmhTfuxcsFjGvIEyyhPsothjCJ+a9xAokfF36lA443NPeqERZgnq+D3WOIBlsWazSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Tuesday, December 12, 2023 2:04 AM
>=20
> On Sun, 26 Nov 2023 22:39:09 -0800
> Yi Liu <yi.l.liu@intel.com> wrote:
>=20
> > This reports the PASID capability data to userspace via
> VFIO_DEVICE_FEATURE,
> > hence userspace could probe PASID capability by it. This is a bit diffe=
rent
> > with other capabilities which are reported to userspace when the user
> reads
> > the device's PCI configuration space. There are two reasons for this.
> >
> >  - First, Qemu by default exposes all available PCI capabilities in vfi=
o-pci
> >    config space to the guest as read-only, so adding PASID capability i=
n the
> >    vfio-pci config space will make it exposed to the guest automaticall=
y while
> >    an old Qemu doesn't really support it.
>=20
> Shouldn't we also be working on hiding the PASID capability in QEMU
> ASAP?  This feature only allows QEMU to know PASID control is actually
> available, not the guest.  Maybe we're hoping this is really only used
> by VFs where there's no capability currently exposed to the guest?

We expect this to be used by both PF/VF. It doesn't make sense to have
separate interfaces between them.

I'm not aware of that the PASID capability has been exported today. So
yes we should fix QEMU asap. and also remove the line exposing it
in vfio_pci_config.c.

>=20
> >  - Second, PASID capability does not exit on VFs (instead shares the ca=
p of
>=20
> s/exit/exist/
>=20
> >    the PF). Creating a virtual PASID capability in vfio-pci config spac=
e needs
> >    to find a hole to place it, but doing so may require device specific
> >    knowledge to avoid potential conflict with device specific registers=
 like
> >    hiden bits in VF config space. It's simpler by moving this burden to=
 the
> >    VMM instead of maintaining a quirk system in the kernel.
>=20
> This feels a bit like an incomplete solution though and we might
> already posses device specific knowledge in the form of a variant
> driver.  Should this feature structure include a flag + field that
> could serve to generically indicate to the VMM a location for
> implementing the PASID capability?  The default core implementation
> might fill this only for PFs where clearly an emualted PASID capability
> can overlap the physical capability.  Thanks,
>=20

make sense

