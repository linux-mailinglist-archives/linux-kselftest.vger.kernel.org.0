Return-Path: <linux-kselftest+bounces-8472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4B48AB409
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9540EB218D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BC137779;
	Fri, 19 Apr 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFe3Mb1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5D28F0;
	Fri, 19 Apr 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546203; cv=fail; b=qkuwKAsW1mwi/nOScmm/im3fTxs/AHzbES3OpH5TfTQfFdQd4E7xnr1oXLOTfgeLsutvDNRx01fhE56BdAOVPwSqVVF+svRIwK9pTesd0kvvc6fmEsHyBOY9rXjpGVmEzbJZttvVmWse5EbV3cQ5o2+D26AgJVqqRNPPMwYjHP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546203; c=relaxed/simple;
	bh=fOA/IxZGDCHZF2fWyXUwu+P538d91fljPMzyHo0XsRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jaoDZEYVnuMHR6BocfaCprK7/JQRnDX9dP7XWUhoJKAzNUhpHHpFu/1XglTMrYcnKSU0a+DohkO3uYc10jYalG/EuEb6kf5PSZSFxgs60kaYDHOUsApiioRJz8v25dK+Z/2NUxmn9rN8+T3/Gz15e4SltN4d5Zf2xpEcqoRcPnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFe3Mb1A; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546202; x=1745082202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fOA/IxZGDCHZF2fWyXUwu+P538d91fljPMzyHo0XsRc=;
  b=OFe3Mb1A/o8Yw10Cx56aH4l9x7yBGb+xow3nEsH+YO+oAe3TBcEVXRO6
   cUwT0CRMmkxlftkcPYevRtN1ITwPgrpNj4Q+rwU219DDq0oHBuk+Sfm77
   dPpcb9vr3xhBybF5htj531Defioim27ckSqk5szvxo4sISgmuPHE8zoeS
   9oTu1wbTf8NCWvM/tzzNBWsL4tUzhPzJzamzVkbCXeeix1oHqIatHsgpf
   O3zwNwNgAm5Esf7y/B2h8LpNLfXVUfWTfSOmf7+xncuMesp8SSwriIL2O
   y866wlmJVOd9z9ZkwC9i4zp6O73SuZ1+kr4z6P+47P6O3XK77sR8CQi/E
   w==;
X-CSE-ConnectionGUID: SaYCA5RSTM+527Gx0VaQUQ==
X-CSE-MsgGUID: wHAZHph1RpmPtSv/qr9L5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="19765550"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="19765550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:03:04 -0700
X-CSE-ConnectionGUID: QuxL4fDDTjOIfK/2dleV3w==
X-CSE-MsgGUID: pM1ePrjhQWm7RNpsOY9TTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23402493"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 10:03:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 10:03:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 10:03:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqdbSkoWGezj0CRDXE7g6F0jiZtkC74f6IEB+CoguEV8lyCFW5j3K+ioAjxSAZzLD+vkX2tJDafSpUl82yhITxPXv8q0FXS2RJIcYxPpMzJDJGetzvvhNkoe8Sb1Ljm5EqYyFmQAx2W8HqzHpDh1gkWfroVsFYVlgIfWl9r8v7nhFaOyhzug/XkIpTLkgxKZaGGARQS8HUxWo219dNLwsuoSDcAOJObo45YYO78xvTC+ytAwQ3HabsguxfT6T77PkSrC7c0ry2vRzWQwKsDwIttz67iOtdH9uhl+qPlvCTBisI+78WblB0YcJis/7e5N1/AQ/8VhijQ/hSI/a8ZSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+60M3Bc/hTDqQscwIaNclzamv2dGap3HG9AN+n6HHPA=;
 b=Wq+jJLVjtqelzNDhmkZjP/32djjqgeHwb+ilfJBJyfoaTVE0q5RU3HHm8HVCfKaVcr7QyEB7qxieOHZSDdLVtujEXHmjJuu1NpQXXXZjbxoeVLb75v7whpZnmK9P9yS4K4blrAzHfN/JsdcXU1Z/MefA7XikTb64fHZzSehGUmFYiX5ZK4Sn2lz4vb9SCU0lqtLeUSsKf2/wCwENiSMRizTFw5UXLWXPR8y7sFwrE7wJjViyAobYbVdSlVXQr5zczZ7A2+ZUebQrQSckWU8udEu4Ap/Biatci0yyRBP049sVCEtByPdExzW/UrTRoqbd0j/AFdf5Up1SAbgEJgZ9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 17:02:59 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e%5]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 17:02:59 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 08/25] KVM: VMX: Initialize VMCS FRED fields
Thread-Topic: [PATCH v2 08/25] KVM: VMX: Initialize VMCS FRED fields
Thread-Index: AQHaWfAGYi3jnyVfhUO4UU7qBPwTVbFwEDkAgAAvQkA=
Date: Fri, 19 Apr 2024 17:02:59 +0000
Message-ID: <SA1PR11MB67343F4567F769E3262A27F9A80D2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-9-xin3.li@intel.com> <ZiJ5LrjddiLticvR@chao-email>
In-Reply-To: <ZiJ5LrjddiLticvR@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH0PR11MB7470:EE_
x-ms-office365-filtering-correlation-id: d95399a1-cb8a-4500-e509-08dc60929104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?JsgskFLFCnXvv5AFQN23Zupic2B/ZdSxzcMhGYJD85Fcf2tm92w+tCpxeDc6?=
 =?us-ascii?Q?GS7e9dyyTDYg/HJq/b6+Asso0b33Yaf5PKr+ztmfi2EyhTkGhihY1dgq716k?=
 =?us-ascii?Q?wQAODhJA9e/IiyJom8mjXtD7dpqN6/nhuBwg4szYH537SehZMnPdGXoY1wqb?=
 =?us-ascii?Q?HqnArdpVT2tYv7kqDHqtfQnvoemxhr3WsHTQmpMFSs19+jk3HEXVnurNeh/I?=
 =?us-ascii?Q?IVjMvbfpdgtKAqAIfkUpE4ZRVUl65qKcxy4x0Ci2yhFcy0Wb0E6C+m2gDWGD?=
 =?us-ascii?Q?Xov0YXWc1P69oYZaZFyjhShAg7152YDkx56vRNtRLxMSwpKFpLpi8V5jKu/k?=
 =?us-ascii?Q?F2vU/VSWgrAeCiFNn/wkoo9Rj/aCN/2X32sf97e81NfYsNDtUiI+ivtr6OKH?=
 =?us-ascii?Q?oqcDItrTeql1mlrBv3SD+aB83YjCWHIg8avWfW+FGEo8Pfccz8gddwBNzqoT?=
 =?us-ascii?Q?KeA9wSWrsVsd7dxi6cfStDVIj/cFwZYui2I64AFuH07himwBkGeGsBv+oOHy?=
 =?us-ascii?Q?nMe2m8OQlSE3OVgkys2qZBdgQncrdJFReGprRNKg4nXPMIvGRz9eB0eHcFjQ?=
 =?us-ascii?Q?0xJ6+m6zyV9MiZC/MEiRfu4XYSXDELkbRsSCh4NSEqItmdKE3mY1n3Rt1am0?=
 =?us-ascii?Q?mo2c1F5CBwt3w6QguTwSUF1p0jGmg5dwrNXMEQBrSr0GE+h2vmzUzQWBOHpN?=
 =?us-ascii?Q?NjcemneVB6yIzGLV0ROgWD8JLeKvUnZO/GvL4eUped8FF0Wf18Z3mmPsD9/j?=
 =?us-ascii?Q?ioc6h7poPJXnAyfCSd9074ZBr3pANTQP08FizvKtPP+GxETH87NC6JHjg/KR?=
 =?us-ascii?Q?jyqAp3jstBdL9WOucb4gtB0UgM81DRt2Nf6/OsMQ+mxQw1aZuVxNTkVDpzhv?=
 =?us-ascii?Q?M8GTh9zMJICULN5Bb19n86vBYcSMB58+i3ue46dYZ3hlsESv41g7EUZ6Q02H?=
 =?us-ascii?Q?bkFPyVCerY+jjGRVHw4E/+nqrhHUhioIaVOHfFuV7bztgwP7gMZHHlcVsq79?=
 =?us-ascii?Q?lPpPye5FwapVg3BP72l8JW3xUjrOpj+eKmzuWbSjmA6S1YfDlkEjrkW9gWhz?=
 =?us-ascii?Q?Hr9aSoQuL3xBnna2q+hnRd0vF1g012D0NGfs5M89it5Z76ZTnef6iS+Ve9+E?=
 =?us-ascii?Q?rnFyW+psAT76oo7Ctk+iRV/EDQCeey3S5TxW5nU1BbpVc2Ar84OyNs4PPKpL?=
 =?us-ascii?Q?vNKp2cDD//lRSYCbkOSNO2ZQAW388ejxVIq/kHOpOvWA310BD0UywnCmWXxx?=
 =?us-ascii?Q?OnO95vHTJA/2tCLF2zB39dJLJqdy7fyNV42zRh2W1DTI8kMDZ3l5QL9bd/mx?=
 =?us-ascii?Q?7T6NETL2hiNdBjpYr5tqUdAS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7A0HnII6GAZeYvSiNkOyFAdq3cZ+EAxcqSB0xNXRbgV3SBy3Bz+zsJLubew0?=
 =?us-ascii?Q?I48tCwcMVIPLhu8O0d8765nRJp7Om1EtUW+X6SJh98PcSvM8PPmUNEWf4vaL?=
 =?us-ascii?Q?9G8hRUdjmcwd4ioLokFCZWi+YKw7PViDj9hpM2si35gJP0wdWfCOzqf6lqiz?=
 =?us-ascii?Q?bsfRCp2yqaPtXhdU456oAtIhQOws7/1nHT91kai0SOedznm1Hnlsw5vco08W?=
 =?us-ascii?Q?2OfxhQH4EAInTmpVG1VqYYxUYYrlnSxW9/2w5JoCrDKu9Ofe8V8kHQ1cpCL2?=
 =?us-ascii?Q?GrUeJCulOUV2+JgkuQLrYt8SeqKZk7w4e+C4kKumO+y4oNS8CU99X0WbFn6I?=
 =?us-ascii?Q?Cda925P11RvpToV+kXypHJytGKpm5eay4LteMM9ev+yjPaL820twi2ZiiPw5?=
 =?us-ascii?Q?3lkI0Capls1r1rj1w4YbUUN+QPak1Z/1cd/RA6f29yoPE2u8KzajM/HfQhkN?=
 =?us-ascii?Q?3pdoyhewvSkdpdkNhlqqrMaBK0CWLiWO01Gq77MpFwrBYSTntp0GBzg/+gLK?=
 =?us-ascii?Q?P11YURU0JfTqhgMNEZUBYmErOrJVY9o1ruEALnLuc7M95SRPh4496F8UxebF?=
 =?us-ascii?Q?8ZH1dzGKUILYNZGheSTDw7q1KOioscWEYqEeTzebgoLhlpkqtF+nekQD7Ajg?=
 =?us-ascii?Q?oTUpjaHtj17kcW/FNeJiCXDl0NaBjChIEzWutwYBBfUe+erXJ6CWGnp06/z7?=
 =?us-ascii?Q?xG1OwNI4QSpXjQhzt5wLlh58ozdbJwGNGvQ6ozs9shwt/j2yV/7Z1BELkKNB?=
 =?us-ascii?Q?cgVjhVHWEctir5CLb6P17UUbyJcpqXyUDO1Vw536i2WBud2Jqy1tX0eJ8xir?=
 =?us-ascii?Q?U5Slqx0ptjOkq6rhz3+JHus02WJlK3OpB2gnsxvZ5f/uenKFXMthk/M7HVg0?=
 =?us-ascii?Q?PSEdRLeMcxWEnm4B/LZCAOFaat9U1uWKVvQZCwjQxQi/JnN2+6pNomWNxsRb?=
 =?us-ascii?Q?TjMx3+CO8tVAX2XH6ThqwQB8ac8bq8G5ELPzcg0pg8AdYN6DniB3yJYlrckn?=
 =?us-ascii?Q?hAzmLtczY4qRc4dZSnsh5yu9zWp0uiblYg1vOPAv9TsUAtP7ya4Epj8AniRW?=
 =?us-ascii?Q?YQkrd4Z93JhTa2SowM0rQ1lhubotnkpIpCGs5NXKCubjJwhiey8perVuqdbZ?=
 =?us-ascii?Q?MTSrwikZWx5c+MUYDV1zVavGYVHl04JheJkE+lDks2GoAiDiB0VFVwzme2xC?=
 =?us-ascii?Q?BczpBuEjTkdb/AzlpTBfKbctGWdcBkYFXXM9yGHDd7aH6EGCqqiqN6E/6r4F?=
 =?us-ascii?Q?4uExHE3y9HlCP4VdAhsJxg9BO5+d80s3SI+5K/VgTvvNRVpex/5KQnSEgGaM?=
 =?us-ascii?Q?ypB0ePbn6XdU/nGPGQcIoyU+A489UOHksOTqOF8uZk/dMQGg9K7hHjCd68Vn?=
 =?us-ascii?Q?3eGFXMAztw+L+gAyzsdm6YXelC599qDQRngKJFTz/j5Y5xStARjrxsJL+vR/?=
 =?us-ascii?Q?vUEn9pDfrtaY4UwtiXcWTeL3LQQlxeY/OWdn+/8MLHpOF4iZ0osu1A/sZU05?=
 =?us-ascii?Q?xtOdHEZj5Itoxudocwmo6UtPAqDi+0YI2F4zsLXRV7ZGxfVzpSa41tYQShA2?=
 =?us-ascii?Q?VEYUT3drtXGrRUGWUeapqsKtCl8UMmxK70k0CeHn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d95399a1-cb8a-4500-e509-08dc60929104
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 17:02:59.4048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24sJlHVj365fWFWPDv1dJdUELlWnWLAdhfiLOafRq35d3ERdRJ0V2eVYsinlLmJ9pCB/GuxWDHYw06AWSmGYzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com

> >+#ifdef CONFIG_X86_64
>=20
> is this #ifdeffery neccesary?

Yes, otherwise build fails on 32 bit.

>=20
> I assume kvm_cpu_cap_has(X86_FEATURE_FRED) is always false
> for !CONFIG_X86_64.
> Looks most of FRED changes in core kernel don't have such #ifdeffery.

Because it's not a compile time false, instead false from runtime.

>=20
> >+		/* Per-CPU FRED MSRs */
>=20
> Please explain why these six MSRs are updated here and why only they are =
updated in
> this comment.

The explanation is kind of implicit "per-CPU", I will make it more explicit=
.=09

Thanks!
    Xin

