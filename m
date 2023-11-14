Return-Path: <linux-kselftest+bounces-73-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39FD7EAAA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 07:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDB3B20A8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F40B66C;
	Tue, 14 Nov 2023 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWcBiJgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DE612A;
	Tue, 14 Nov 2023 06:52:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACA2D43;
	Mon, 13 Nov 2023 22:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699944724; x=1731480724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=os8psPEuk7ptMe5/byEeSX9mHlqHXHowYXrxoC+zqRA=;
  b=NWcBiJgx85ChHLhogO0zLWGzBsbmwl7/gnNjmjDAyUe23Tuh187J0YsE
   vs4JxYBB3biS/K0Epq1SEJeG96xthKMrrHwr/pneoREbjV9faTBaJHNSd
   OJBz4R8+ZS4c/gUkeGWPiQRwcuYKowaKj/Xu/V2/ttOz/YNOhKu6fsFOc
   67nPZA+33rV5SJJWt8HvOiFopKpCPTU5ht66Xa3GngwY+AYrkHYe/2mix
   9GH9HQf94x4n2nfmL3j8ZI/vs019PvIAdH/wVX7D3B4FY2HsjveLuRDra
   WmT3oiTBj0C5fwA5V2BwAo8srHodovHQ/gpgfFx79cGlxiiyS0wnOhBnS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="476808198"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="476808198"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 22:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830495445"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830495445"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 22:52:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 22:52:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 22:52:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 22:52:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 22:52:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eglqEqnuxzgTbTv+qCYqatw7la1LbJYB1n36pc30pCQp4mNihwWZNDEoTx+WMw/+UtxjFv/qNbGwpa1YTrhI1aeKKjrE1j9ABe00IitYdQdvSuwLeRqiB35DavpDgppjOXJLLeLBEo9kqOS2btioWUQaoZJEFq+8KfCyDSccxUdLDK5sCGnWIKITt6RPCMaksS2GfgCbTo9RZ5ONCB7wEVBqvJYTBep6sfUXKwOMPSptEREFPlQ7OfSz4hVAPudg0VrFl61lAa3lA13NdZCKfUlks+RIZmaDM8UxlgjfXYHQe+vj4EZ+CWphFI/sPmySxMaU/ttR9UOrVlbuI/sstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt+4qnHNyRhjKmn886Dzj4VTigdBEy5+rYgrb2+wrTk=;
 b=Yqx1r1JhVtrbGMunTBoVD/AsztBkjh27j9ol1VthagEnqROaTYTqe6iAHowZe9Okhv1AANOelgzVO9dhho0vfbqHvf+lOksZDmQmeQjQ8qrjFj7+0+RiFfy9DoJNP7S2LXrLi2h3dpfkybtkYIkn7cjQdk3jarb5rgQIU44Ff827rZ/nRRYt5FNXO+Su+n5jzBbq0TM0T43R7+RBkCENLUIwCdhwBGToVy79tFuJxRa0NkBZJVtGNZoRttZEigci6cIbj7inJOrJ3h0gleuio4WJRJbzS5xZRsMXwRuBGOhPw2fyBXmUpB9P7qy78wx8g2vknqYKOoiHcGL5w8Nsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CH0PR11MB5691.namprd11.prod.outlook.com (2603:10b6:610:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 06:51:59 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 06:51:58 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 08/23] KVM: VMX: Initialize VMCS FRED fields
Thread-Topic: [PATCH v1 08/23] KVM: VMX: Initialize VMCS FRED fields
Thread-Index: AQHaEnYBo7QIXf2yMkSc9/SUosFb0bB3l1MAgAGzI4CAAB2zQA==
Date: Tue, 14 Nov 2023 06:51:58 +0000
Message-ID: <SA1PR11MB6734C3AB47C1CE5F4FC5AE6BA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-9-xin3.li@intel.com> <ZVGSQHdt39vwkeRh@chao-email>
 <SA1PR11MB6734E58758C5611087B5E688A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734E58758C5611087B5E688A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CH0PR11MB5691:EE_
x-ms-office365-filtering-correlation-id: d6656ba6-38a5-484a-bcd2-08dbe4de3277
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUutaYPmgb55GAIJj8nf+QHzf7A11YIVz556ZuO/iJyPig5uSWyNVTLaaJoZ5ZcRbr2uAcYvYPZ97UV2SawtqGMJSKVnf2ogbiEwJGkXRU5LePi9HA6hWaunh26ZnFbq1K80Qc63yzFWwFz0biRz6pmlMEW3MUuc/w0EJmQe/WxMc8dBex8ma4G0Owk7koW77nKKTiij4SmfE0oosL7GhVrQn7DRK0Egra7FmrInX8+Rzav9vyk3bmzowKeM0s0zTmgPS6IoI13P4GJwgoMkhk5+N8MrpPM0wLREWUmlb2yAUPtANZ0Lwho4wNxpnjVFShTvNmfay0DWrZnNsiGadiw4TwCegfvgjETi8B3loNjmiizVDGzfQXyZQR0/8pHp734VAhR21NeBAbhG1e73UPOlZO79tfGWylFDT2xKZXAdIJrEZUiZN3LG61C13L16LOk+dLUY51Qq86I8KSIlwaaoTMX4+PYN9TAjIvMdv0D8LrpmB7hs4A03XuZTlFjLUxgp60w9WLOjLN7TtksbGmFqj1AzzMfq0NeOgF8/xNEgps6a0/NQOU7qOFHjyg6bTFA9FhadcrtPzHcj8lFN+HzKOFJovqn5nZhrJah+oDXshynu67KerxqCP1p18h+0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7696005)(71200400001)(6506007)(26005)(9686003)(2940100002)(83380400001)(6862004)(4326008)(5660300002)(8936002)(8676002)(52536014)(4744005)(2906002)(41300700001)(7416002)(478600001)(316002)(6636002)(64756008)(54906003)(66476007)(66556008)(66946007)(66446008)(76116006)(86362001)(122000001)(33656002)(82960400001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYxj1XV9n1mUfbqzzsLIzLSmY1ngHdlz4ekLFxhLV0QVHKOVoQB+mztuIjUm?=
 =?us-ascii?Q?05FSZN9cegJC+Sh+qwkNPz9Nr6B/TEc9SZz90DRINjqpG9/j6TXO79axDbmI?=
 =?us-ascii?Q?sZdcrMfxWNAqa1HUTQBfgo8PXjPaOdp6lac/AQvLSR77PziOVYMrIi08jqRa?=
 =?us-ascii?Q?khLqJXlGDAy9jZQcwIWUa8N1ECQFIjNlVgJ9+y5jtc1IAprAsVohIVVc4zZR?=
 =?us-ascii?Q?tk74mxBHpeVHNaVJh0282yoSvPim5C3nMDi86jP+hbWQ+qY2XOaiRaRo9gDG?=
 =?us-ascii?Q?ymj/Cxai5aEsK8IZ4OWfi5Y59tG/b4tNxl+IIRC8oX9Qf99mdyAcZsW1vnIA?=
 =?us-ascii?Q?03R0FtyuoCsG7iGTt9/fsXal4GB7++DXfD7VCYjZaNSKpFTFCmPiBw00rQPM?=
 =?us-ascii?Q?XtGXWALuB/zDCQi3khpjQabSGxhHVpcj2CXFzKyO/l4Iqw7IhNLr7X4Y71ud?=
 =?us-ascii?Q?AljrA/7uEiofpuNmKER8Tmz4mBlhBb7D53bCmTVB3O0DQhZ5W3lVa+5mzHHi?=
 =?us-ascii?Q?p9UaszkcP84VuJ/OZuh3arcgoy0ylXd2q7FQaIhxmbGAF+Ep+hzKg2SOhAK5?=
 =?us-ascii?Q?MgsxJ+gVFIm6A9Z/jJyCdUpzQVVWsmcIW0NGxp4GlTgHRHOsUHduhs9MNu5U?=
 =?us-ascii?Q?hOx0MF/H+deYIz4T8DaldNR7q/UGuGCPTJ41AfiqCrjEID+IDi9QqPYDBHIP?=
 =?us-ascii?Q?fYO/hapBG5zEP/192FjDSHgJSWO0w+g898YpsHL7X0q9WQ+b7jYlTanM1f/M?=
 =?us-ascii?Q?LHP4G3Lb1aMFpj4ZQIsC7ydZtXLcBvzUHfzpHTo7hkF0VKc2Qv2yzBaQaJjW?=
 =?us-ascii?Q?GnrztYF2SfpBgVBqfGCTO46sKHCVX7DZERYFMJ5jBIgNLpXudiET6B6+b+0y?=
 =?us-ascii?Q?6ofWFXtB5za9OkHHxnKJSKTH61tJutwgP6+tOKxWS2GKu8PcCWMYMQZl6Zyh?=
 =?us-ascii?Q?RZqUF4LuRmKbwQvRFe38bFYdWbo8srEiYpebUU8zTLVQQThEudt3ow1XeFe0?=
 =?us-ascii?Q?VCX412xwZC1+f90kIR2X9tFoMy3rNHKyqoO7lr20qM1bzjtAoIgeSCMmAeJA?=
 =?us-ascii?Q?5zfvU4wcpTre1dVaaQs2fIhDyoCSxkCrH4UbMWkGRrCn5iBPOauXfJ+9aCub?=
 =?us-ascii?Q?H3G02ZDLQ1lang0Y7d96DmYT/dwDvOcfrxoklT453o1Mvvzg/+NYS92RcNQb?=
 =?us-ascii?Q?EYbmPb9IpyGbWEaZtTYNmp+cYCb2R3gQRpaJtq7T/mptymYvh5mGb+L2aTMS?=
 =?us-ascii?Q?0Hkhg+ISNRO3FRv5LI3dhvV+c+2h4zmKyX5IOUHJf/e8p23vj58YnvWxzDCb?=
 =?us-ascii?Q?9Uxv/0OIObd9eAh/uWZdVg9+rLK9m+hvNVncfwvgTGM/usZp7izxwjdRatqw?=
 =?us-ascii?Q?7gxw7szAefWKtmb6Wy5xKExSyAGemvAujyHrgrhICYebLZtchqpTGwAnpTlL?=
 =?us-ascii?Q?q/pU48Ma1Ur4Y0IVt3KPfHwgNKe/TtR5RTkAF2wth+XrrPD8WF/9Tbglu5kZ?=
 =?us-ascii?Q?8lQs9BSMXXSv6WCkgE6GzZSpuZf201W0gu9k5hFXYZwEo4MLGkuxAheexxdX?=
 =?us-ascii?Q?rKfFVpXWKv1VT48St9yDxdy03RaDYCqUkL6efUm1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6656ba6-38a5-484a-bcd2-08dbe4de3277
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 06:51:58.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqPGYzLznATO2kj73TE1lc9dVBKw0xzToYppKR/4MuewQqhI6FZlOrAj7pk3LQSKIeGesd86UbOQeUHpjkMc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5691
X-OriginatorOrg: intel.com

>=20
> > >+			vmcs_write64(HOST_IA32_FRED_RSP1,
> > read_msr(MSR_IA32_FRED_RSP1));
> > >+			vmcs_write64(HOST_IA32_FRED_RSP2,
> > read_msr(MSR_IA32_FRED_RSP2));
> > >+			vmcs_write64(HOST_IA32_FRED_RSP3,
> > read_msr(MSR_IA32_FRED_RSP3));
> > >+			vmcs_write64(HOST_IA32_FRED_SSP1,
> > read_msr(MSR_IA32_FRED_SSP1));
> > >+			vmcs_write64(HOST_IA32_FRED_SSP2,
> > read_msr(MSR_IA32_FRED_SSP2));
> > >+			vmcs_write64(HOST_IA32_FRED_SSP3,
> > read_msr(MSR_IA32_FRED_SSP3));
> > >+		}
> > >+#endif
> >
> > why is this hunk enclosed in #ifdef CONFIG_X86_64 while the one below i=
sn't?
>=20
> As if the compiler doesn't complain, I should NOT add it.

I think I don't need to add CONFIG_X86_64 for the above, but somehow
this was left over.  Let me double check.

