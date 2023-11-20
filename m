Return-Path: <linux-kselftest+bounces-284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D85767F0D50
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D371B20FF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC91DF41;
	Mon, 20 Nov 2023 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4r0cUBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A84B9;
	Mon, 20 Nov 2023 00:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700468212; x=1732004212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nmarBsxG5NKkdhayYn4K9VsVkn7w4NTztMAXS4yLut8=;
  b=L4r0cUBpiaICiz0IicliW4+5baPDU83Qt8OlR3jiqTVLThUABWYz9uYB
   tJkYrUSecLMQ8PYu1afjjCuJGpS2bhydBpiivSTC1USy6wTbUbqE1qedA
   4MVOZv3Nl03n1HZEXCgOGyOHQh37Ph3KjhbTu5H8ji64fIz07hJINnYm9
   N9WA8d/dq7zJSsNlWtGVfEoLuRELDIg6dE6O8SKGir4raO+/liLlE3B40
   aMpvHVkLnbBKXOiRgaM70GOTECNsx2dw2SkSgYvvlctSRvxgWVzzM2XYS
   xkXrE1y5aU5vtEHgaQYG0tJ3o4O6+3B6krTa4Jaf1/MdXOj+0dM2xL0CG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13125970"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13125970"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="716147886"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="716147886"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:16:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:16:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:16:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:16:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcutVo5abgOxaaDMfBS/nCzLgs+RIAMZGm6WT2Jux4aZtlZHlCBHGfrsYHFRQeBEgbeUxX04gXhjNxyZ2228+9azNdtiEXosahANCSzzUHWrz3gxNzjlWHWrxoYBeCoq7FdhaN/BBriyO+MACHvtJPTLaJF8CfjhEyQop+V4Tx2MlQpO0tv1KR9IFvUiTQIqPhtCH6jhpLBISqqJFRiDuvW9g5W1SnMNXy9vTp28faPiVa9uf6CwEAXJR/Ayu/t06RnaldGuuIanV70FODcL3K8e4lTbLp0a40cYOe101WKRAblmDZLOKp2GJV9y9ayCCxYQ9xQX3ixxS9shLEMgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VYsoHXtvDPyrLty/dqdW44fiYMS/KR6g605C5Qyw5k=;
 b=WHHvM4DTYzdVXNQDpgH53VZwA6Qk2W7krJ/3bYVz0QVQAjKzx3ZckppqHQr4Hlk92W2ybYRkvRgOVl12h/h8T+bVeq2GhgPSJdtRkHe4oHjGHC9Orjq8goEfWjtu7vk6911luLdGBLkLsP8lylq/QSOyKpvewrw2MY9GEJV1S5kUrdeLb9ESGFSmwj3mkUxB73m/QPsYdily3rxWgXrj3cs3egiilemQst9u5XYLisfu3AS/ExGAUf8vRM+PF+UPz8WjN0E3V6jng95Ph6UFk7aAjniJ5hnYylmD93/vEmNLXU7HLyHtDeY/1R63S9vLzjdMb/I+Iv3YPoGglTzEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM3PR11MB8672.namprd11.prod.outlook.com (2603:10b6:0:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 08:16:48 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 08:16:48 +0000
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
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Thread-Topic: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Thread-Index: AQHaEnYZT2abIZhNcUyoZ5A/RVnRc7B4D5WAgAEtDsCAAFANgIAAotQwgAIX7gCABp+2UA==
Date: Mon, 20 Nov 2023 08:16:48 +0000
Message-ID: <SA1PR11MB6734CCE019A5BFC5BF8CF6F3A8B4A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-13-xin3.li@intel.com> <ZVH3IUsfvzuPaj6L@chao-email>
 <SA1PR11MB6734B2389911D76A4B95319AA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVM203KI5D3o+ksS@chao-email>
 <SA1PR11MB6734FAD33CAC432ABB5EF7D5A8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVV/Rso4Rs4Hf8Df@chao-email>
In-Reply-To: <ZVV/Rso4Rs4Hf8Df@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM3PR11MB8672:EE_
x-ms-office365-filtering-correlation-id: a2e9c579-a377-4ff4-fa2f-08dbe9a10ace
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVgGiNxmc5yIEwwiyCknJe363MrhqPdMZC68TeE0zS7twQCDXoE2z8we82Ku9NaDQWX+4XafbhRuA4+tN+Y7FG8Ca5AuFwTJmrogiX7a6QzYEu1zsY2onLne0yfAbKogk358pcB2tS5M1CevBjT0jWW9x22X23Cm2PaqOdA9uM6Y/dL7TErFgr428ptoltsehOmeLwLNOhwGmNNQx6STcQ/x4+aqwsfiOZY2G73aVGacxiFE4pRWkmnyOq8lCAa8EPTkq8AqjVzDleuGrppbsbbUGsPO7f6UFZ0bndjh1Z1ynjq6QaLWX5aYi/+PHOOrAULlNWRWvk+o5x2TsG7apTfUetUHDf51I5GdXA+aXP9TR85sAPAVjnuLDR66HPl9YPE0tcVo3KidT70lzm9Mx/J3o0V4H7paGdXLdv90xc/UX+qgm86LDbuJLEsAclUvHLyqDz4iBbxZUVs6scwhtFImVG8ZS/sF3q/VidicVJt1YBu8z+N3GDCpN8uAJ4uVNesk6Mqxom7e0HTu4bYXoOzY6+5rG4cZaz189I9940im776UmVEkH9xfmEbJ6pGETWuGTgW8WW+dMF/M1MEfu30jrb/y+axxmwMAvStUiS65pWNVBj/GI0dGgzYAoKvQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4744005)(2906002)(33656002)(52536014)(4326008)(6862004)(8676002)(8936002)(5660300002)(38100700002)(86362001)(7416002)(38070700009)(41300700001)(9686003)(55016003)(26005)(71200400001)(6506007)(7696005)(82960400001)(122000001)(478600001)(66556008)(66946007)(66476007)(54906003)(64756008)(66446008)(76116006)(6636002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6RIrS/50OkUHy9FhRsdxW90AJw5NQv893STc3VDTdlvvMASIvvvBLvf4v/k?=
 =?us-ascii?Q?3YXWT/6YC5fMBxzsGmykn873FuPH9m0ki73plc26JuhJn/tsFyy6WAoXP/r7?=
 =?us-ascii?Q?jHjGiTdr1RQF8aebXBrC/qS17bcLLvqCM0hLN1ABevzM329sVRhh7i3wK587?=
 =?us-ascii?Q?aCzo1jSzEo31TrJEkA7PwzXTnPk0DMlZECqGdSpt9/VgNVn6FGR/YxaJAh76?=
 =?us-ascii?Q?P1iR8KmAy+Vb4AKLb5wfe1GfJP2s8aI4HwlBAz1cIb3O7du5tGDFMPcpv8rU?=
 =?us-ascii?Q?KjQtT1XxglYfqlvTOpK6Ri2iuqITLRs+Ri6v1P8EOMIssJP2PVEqFZsBMINS?=
 =?us-ascii?Q?sccxmvFnEJQQUquHFt2Ff8WYmy5s3XUi6657s0HfOrlt1T0V8oqOwmSBxChV?=
 =?us-ascii?Q?WxswugS9n71076/Lss0dg7G0eF3W17nWZubjet1NPRcqAn4Zv/O0Gm3xD9Ww?=
 =?us-ascii?Q?84iubZnlbsQMNiuBxOQOBKW1HAb0yQieYNuDnHLpSXK5wED3YRyV7ZTGf5j/?=
 =?us-ascii?Q?glaZDyST9gL5H49uwr8Qoq5vATS0opUQCV38M9U+GMnXCMjNvrGksNrIw5Ms?=
 =?us-ascii?Q?Vj1Ck8wu0cWyO5nhkIbeAbQmEz9g4XOm1//DMMmvqwW2a0pooi061uh7r057?=
 =?us-ascii?Q?zbpxhCfyjHN0H/ic5uNTfZqRw7b8K3uxaRMYQXiKnYBtm4UYXxIv9QfrQSE0?=
 =?us-ascii?Q?ynPOXb1IbcP/fIcGMNa2WyCzPqqYZ6cAhawBBqa5klvTWSAHi20b6bLw63Ia?=
 =?us-ascii?Q?vdWsWunr9DiwWctqD4MDp7VMnjZX/9x0NbK7CwYwvF8LEANXrMfByAHztpZZ?=
 =?us-ascii?Q?sS3epIyDq2aHLMDMej6mzx7fP6Ui0rgkE7PL0NWLriIaL6FGpHGAttgSqRI4?=
 =?us-ascii?Q?VqlNQOsYQS8GaDUzJH7nTA5MkLkoZUHZ+erx/0Wgx1/BdHOTc7Y3Tot49lgc?=
 =?us-ascii?Q?5zeT1HOKTUIXqalZf57Li1kznSjE6RI5rhC7BFLlCz5A05JNgcJVqZD8aubL?=
 =?us-ascii?Q?O0IL8e4CsHLkplRKoUpRJDCuxNQWAxr8h4zpBjr+nJ2MPg+sbWXFjAQVlp4d?=
 =?us-ascii?Q?GCsTAHlBj2sdXo985GJOgvO/5CdKE1X9YqwZZfIwIctDts2vhKtco2CEC0mH?=
 =?us-ascii?Q?VOlYU8ohYpreFPLHLlW+QQlWaGC+0evYAGOU5VrTmIvx3U8KEztfusUp6pDE?=
 =?us-ascii?Q?S4nlArBdKVG3ibj9vXihPR/lZo9cmxC0LVj4ROh61SFYk4XIZj8ApfM7Sd1E?=
 =?us-ascii?Q?OM0UTFnteOewIeg9uxIHk32xWjiXKRjOWkIvTOZlsfeZeL2AGApbQZ2AFynh?=
 =?us-ascii?Q?s6UZDLpyjr0nkz7/8Z000UDS2BzVvBQ/qOhx+T+13VTd7Kei86/MY3pTr/6s?=
 =?us-ascii?Q?tFg63bDjiIP9MA++kvGkLX2RSN8i7ikTEAEUZsW/nGh1Vdrh1SANKvi4iJjU?=
 =?us-ascii?Q?gm+3rNDzix82skZWac5G0g8VSQZH1D/Yyh1lsyz3G/YOZkCAMMRQuSR/jUQL?=
 =?us-ascii?Q?YMdAJVIgKP8uNLfVnlz9gGBTU3wwjLEOD9xmdrjm9QjAn3cL9B3W1hMAoMKA?=
 =?us-ascii?Q?tZFDggRCkrdnPtGawcg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e9c579-a377-4ff4-fa2f-08dbe9a10ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:16:48.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJuqDatnr1+J6RHa3EFjKgvTRALU6P/QXmgRZrjkqXIsfcKmmvYBsrXo+df8BALhQe2Ts+xP85ZyuFeBtN0ZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com

> >> IIUC, L1 KVM can inject a nested exception whose vector isn't #DB, or
> >> #NM or #PF with a non-zero event_data to L2.
> >
> >No, this is not allowed.
>=20
> How do you interpret the last sentence:
>=20
> 	Section 5.2.1 specifies the event data that FRED event delivery of
> 	certain events saves on the stack. When FRED event delivery is used
> 	for an event injected by VM entry, the event data saved is the value
> 	of the injected-event-data field in the VMCS. This value is used
> 	instead of what is specified in Section 5.2.1 and is done for __ALL__
> 	injected events using FRED event delivery

To me, it means FRED event injection during VM entry simply pushes the
value in the injected-event-data field of the VMCS as event data.  But
the event data definition should comply with Section 5.2.1.  It is a
forward compatibility issue otherwise.

