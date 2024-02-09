Return-Path: <linux-kselftest+bounces-4473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756584FD79
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2111F2479C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5486AF7;
	Fri,  9 Feb 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1tloqyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65454F86;
	Fri,  9 Feb 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510066; cv=fail; b=b5c/fSXPCKvMX6eDICJmlnwyr83jpAaaK44lex6fN2BK2VBv7UmUVVyUS4i4VKwkPqb+vNfK+YLvjxGMIJfhy0BOGDvVtUeYaDDn1E8qyWtt659bEsTZJg7QV0pBsucjLyvFAizCkY+Y6Eu03IajGNQCv6XD6GrBjSndD7dZfPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510066; c=relaxed/simple;
	bh=P6kIoHCX0FKYobQNL2+cC1sOGWmYipJs0TVjXZJgFlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F35R7sWu8iGA7hvzRPf3mm78Hr70iIBVK+q1HFtzoBlx1LkFLrg3l5UP+s8e4G/XJj+mAFz+O4lcOAOSfJR3egBS0ECiQbpqd8UxaogO+xssO7q1Mx6aEwBQ0IkryFtbH/GYZ0+d0gR4bsLd3qSbB+nFzrNAL+CfISMTAPuCf6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1tloqyw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707510065; x=1739046065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P6kIoHCX0FKYobQNL2+cC1sOGWmYipJs0TVjXZJgFlg=;
  b=X1tloqyw2SPfmPmE+wkCylfd8wkNVkJOFGeYaS9/MGpOtpdsFOOk7lZ2
   FjmWBJOCfY+R9wvCOHbL60X2LlvQp4xo+/kU2dxCcZvH/03a8Myqfs+FG
   fJUW69O/YXYJ44A4hJwKG7OCfTJG7AeKK6JyDojURhcaallI3IB2E8tS3
   wPAbflESdyYfdtWFZPL3ys4fBS9NS7NMTvhRS9DTIQq6sWEyLQb3DzhJG
   jzUG8v6XXoxY63oHuqp1bKvCNWsr7xLBO8RkyeT6amOI+UTp0KyXSfpfa
   ZAhinhuhPvpxkun0OOJh3iIsSRWoR8skoJq6ssMaNmJh5iAEn5VU1xnVS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12224914"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12224914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="39464916"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:21:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:21:03 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:21:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:21:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:21:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEoNZq+vA1pz2fu+oGaXvQtjjCMcmf0y9RCzArrD/MaDOy5zrPF4sbLwGIIO0vic4o8iHmGbzXp6dKrYz8+pfg2CjjpDxe37vVGsjtMkFVskwctAuDj83B5W+KrWHpsrjEugBmIQQQD9bpoI528rPFd9v4UH/FQu/IQOMsFEWjB4eUzuDBDptF5i+ia3CvJyE4dyWRZQZ4D+ce7EmCssvijWgJ9SurFBXWXso00bPLiGwlBzAWAFvRCaLEeXCMLOcZsNU4qDvbGJPYoSKionWWQ04LgN5+ZVTFpefckUQ69IUEFgZeMvRhFQu47Tw5owVXVLfDvIb/Cu0mxv+81R/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6kIoHCX0FKYobQNL2+cC1sOGWmYipJs0TVjXZJgFlg=;
 b=fsMItm1gQ924Ltb+42AzGAIZicYMC6RcEmVouMMF/cFft3odVJegKFil8ukcI+Rc0eHRFW4THgVKH8Tj1KAZS0jgjpp6FF0tfKLzrDxii9jv9x7/ueBLWoNjBH3/i3G9OpUb+wd0gIsucmBxyMZHqIjo5JYO+U0LcFezPAzVHJmA/vmWquNJVXCsHyJWXNDxkgsmCzeKxn4oiUGHAhBrXpOKJoLmU7/kySKvrHBVz4qlnoiW6Aamu0yf9lMxQvvqLho+lgy1PrdjlM1gqNgU/CqtWtMj2OBPgLURohhSy4q8/AZY7JbsTIJQQ7AFkr6pziB2IJAkleb3izt5z8lL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4702.namprd11.prod.outlook.com (2603:10b6:806:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 20:21:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 20:21:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "david@redhat.com" <david@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v5 3/7] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Thread-Topic: [PATCH RFT v5 3/7] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Thread-Index: AQHaVjTKaGoXyX/py06CN6CsG60BhLECfpQA
Date: Fri, 9 Feb 2024 20:21:00 +0000
Message-ID: <0fb0629e627ee3d4113792e9af2de7a0af9a86fd.camel@intel.com>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
	 <20240203-clone3-shadow-stack-v5-3-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-3-322c69598e4b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: e31c7d92-b5de-43d3-674c-08dc29aca203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlzoF1v9Ll70VDPZdhLuWNutM2ofTISgIySMDkuJ9JIgA49QrmwIfcQvvMydhXqBGvENYpsAdr44+L6UlDcV1C4fhrtNDW5+Ej8ehnvz6PcervaOxFWErQJ2ClvOnPlaIlqsjJ//5ecStWG6MNZ/3ZyCuEh2rPC0aLo/y3fUWMJ3vyqRTj9I8gYBgieAHmNolcqVjiNdEPaAyo4jeu1U82ASZf9aHw9DwQJBZ/gDwxpGPFQGf2gdMar2d5DyaiIteVlNLXIXMH109SQIqTh95IbMrXW+LZXIsworHQMq77yAnAnfKzRqoWbZ1vOPjSi8T6a14Sa+ZrihNPwSF8zd3mqFCHx8qIgOlCf4iTWGsR9sOREncfdm3OaRKeJD0y3Y6CVD8emBzUwgO/uL8es3uBomjlTliZHE1YVOtMtSVHlL4W2Pmyyw4oVNM+w1loKtXV0abiothOB3UjF8tuIOfsaT/IT1NOGx3y2WiTsuspVmgIFG2fOcYBVViCUAMpQrAaQ7HnQvIuiUlZXqyv+TS4UoECMA7BA2GkHKpGHZbAu7LMau48BhGfE5i6sck5x6i+q69y+ONpA13f5+6TdR1rcQ0UNRtBB04FY2LYPkmTwL5NLb8XsXtkzOLJCpZY4lQ6+5TBi/NYTQb/pT2Ev1gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82960400001)(38100700002)(86362001)(122000001)(5660300002)(4744005)(7406005)(7416002)(2906002)(6486002)(478600001)(6506007)(6512007)(26005)(2616005)(41300700001)(38070700009)(36756003)(921011)(8936002)(4326008)(316002)(54906003)(64756008)(110136005)(66476007)(66446008)(76116006)(71200400001)(66556008)(66946007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWhjemVWZ1paVzEveUNDcDNWVG4vR3Y3SkxBVE5PZ3NyK24yc1h4TFpKTEhE?=
 =?utf-8?B?czBmdGJLVkJyc2pVRDE1QjdtUStGZDNDS3d1blllYUJTOWl4ZERWdElKR1Vz?=
 =?utf-8?B?TWc3VlZVblh2dGh4RjBGcDRXa2lwclFMaXE0cTk5OEYzTElkRHkvblhrdUdv?=
 =?utf-8?B?NDFKa3dXWDRCRERTQmp4QWFxRnJQeitPbmIyRTFmelc5NWl6NmNDbThTT1Vw?=
 =?utf-8?B?czBuSmlLYno1bXd5WkJoZHZ3QXgzODR2MnJqcUNQT0hOSW00TXlXQ3VNS0JZ?=
 =?utf-8?B?OXgwR092cTUvOEJtbURZZjArZW5hbEpwcHV5Q3hzeGtNYkV4L3hNNmo5eUUy?=
 =?utf-8?B?c0E5VkhRZ21EcVhIeWpkUWRQMnNteHlFZ1FWWER6aEk0U1VDdXpsL1l4OFVQ?=
 =?utf-8?B?TUR6R2E2YnNpSGhKekY5YmM2MVhhSnR3NWV1amxINC9WcU5OUWNIdTZKbHlZ?=
 =?utf-8?B?MVBVMEpIQi9xVTJzNnBuNXA4d3BXdjZhVlpOM1dWZGoxMFNodDlRUmQ1ZndM?=
 =?utf-8?B?cEx1TDA2eElyMWdsQm9sVmd2aWsyaiszTWtqTUxNTXQwandQMGFvU2p2aW52?=
 =?utf-8?B?VzJHZWhJdEd6MUM1R0pIMzZWbU5mSkRjMFI2QUlNVTUxeTh5QUF2V2FuMWpk?=
 =?utf-8?B?UkdOeTMyVzlFU0VNSWdTSTBTTnVPeU00RDNsOTV3Qk90bXhxTXRGUmwrT2g1?=
 =?utf-8?B?dXNqT2twTDJDcWxhUFdjY05seGJPcXNESGhsSFVDZFNzMDhLWWtEZkpjTk9h?=
 =?utf-8?B?UHdHRGFGZVZRNnVpOUU2eW1vcUVhbWJIbjMzU1hIdVBmV0ZQb1hJamlTVDBB?=
 =?utf-8?B?VVVXbEdvRUJpQ3M0cjNOUFNaRmdWWEltcGdORXFReEFZNFN5RUFvU0RQSWNi?=
 =?utf-8?B?OG94Z0tIZVRNc0VOOGdTRllDUXArOVFFRHl0QkRvQTBNbExrZk52UVpSN1l6?=
 =?utf-8?B?MnBjRGJGcUJYcmM4SWI2b3djaXZLYlVBUCtqTDRpZldHcGY2TGRNeFQ0R29I?=
 =?utf-8?B?ZUZRaHRDU3FwUUM5OXNUOTEyYUdNTWRxalF5OHBKNi9aSGl1NTdjUDNwYTBw?=
 =?utf-8?B?Q3RoNkE4U0wxaE5JMTRjVWRNeVBoRi9VY1lobkM2bTVuS2Rmemcra3QyaHZz?=
 =?utf-8?B?b1kzYzcvSXVqWVgvY3lmNTB1Wit1bTRJRUNaZHBYMUR4K2pCd0krU2pWQk5O?=
 =?utf-8?B?ck1pQ1JBbncybWo5RTd6MGtLcENkU1RVbU1ZSkVqdXRnbDgyZjhvcTVQbUtx?=
 =?utf-8?B?eG13cUZTUC9hU2F4T05YMS9aTld0NmRaTWl1TUp5bUliSW9SMWNsNnFsTGkz?=
 =?utf-8?B?eG95dUpDTGk1eE5tci92NjhtTXVwRlVHUk55OVlJV3BVbGVXdTREMHNBcmFE?=
 =?utf-8?B?NzhrelM1cmY5YWVZWkk2RWZPZzJ1V3JnOUp2Y3RpL2Z5dHU3czFlVmVjZWRM?=
 =?utf-8?B?clFpWE91aDhtMkJESVJFWGNZaEd2c2wrVTMwRXp6dW9NZmcvRGRCY1AwZUFG?=
 =?utf-8?B?RUo2eTBTc0haT2YrUW84dldvSDlPcDl4d3Z1dWZ3cFNyZFJIQ2lFWnJlNFNa?=
 =?utf-8?B?Z2ltQ1FtcmRZZzhtRDJBWWNjcG1SUUh3L0V0dFVrYmVuZUpuY2FFS3RBUHF1?=
 =?utf-8?B?TS9POUJTeGljWnlmTXdRZ0QwdkVRVFlQTXpacmdiSFFZK0dZODdnSk1wMVRB?=
 =?utf-8?B?NUpqbEhVZ1dWd1BzVllVU3NLZ2U3b0V3OXhLUHQ1UGxwRlVnSWR2VmI3dUJi?=
 =?utf-8?B?QWdaT0JpMXpqOEZyejZ1K3RtcTgzcVNnb2IrZFBZZWdsaExCZHJXbVJRZFJm?=
 =?utf-8?B?Zkt0Yzc2cndEWlZIeEdKS2JVNytrN2JmbFhzOTExMmppd3l4bzEwK3RxelU0?=
 =?utf-8?B?UEVwNXRyNGZoaEtPK25Ta3ZST2pYK2krMlhyR2hEMVE4dEdueG5jNjBydDVH?=
 =?utf-8?B?dThYZjh4QWR3RGRlMXNUM1R3dXNvOWxpK2lLZjVZNjErU0xldVdxZmRoOWor?=
 =?utf-8?B?ckl2QUFZQ2tGbS8vT2h5ZGV2SmVNS2VvWE9aWEZSd2tGRlozR29HUnRlTDZN?=
 =?utf-8?B?SDIwZFh0NHNnaUhxaFJ0L25JWi9BeGtBZFdVbUI3T3pUTXcxdUlOenF1QThI?=
 =?utf-8?B?TWRtc2RzQzBtbjk5SVZrVmU4OFNJT0l1bWhEczlNWnJ2UnpJSHRsbC9NYmti?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02488A3BF4722C45B174D9B46192CE3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31c7d92-b5de-43d3-674c-08dc29aca203
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:21:00.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxFD73M/lFj48z/4QjaXu4uOwr62gtLVbNfkvpGl7b6Wih/N3DXJ1y5+EHHysbCCfJoirqW5zrifV93gxfaP1H1HBVBeys1uxfRmzNZSsZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAyLTAzIGF0IDAwOjA0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBT
aW5jZSBtdWx0aXBsZSBhcmNoaXRlY3R1cmVzIGhhdmUgc3VwcG9ydCBmb3Igc2hhZG93IHN0YWNr
cyBhbmQgd2UNCj4gbmVlZCB0bw0KPiBzZWxlY3Qgc3VwcG9ydCBmb3IgdGhpcyBmZWF0dXJlIGlu
IHNldmVyYWwgcGxhY2VzIGluIHRoZSBnZW5lcmljIGNvZGUNCj4gcHJvdmlkZSBhIGdlbmVyaWMg
Y29uZmlnIG9wdGlvbiB0aGF0IHRoZSBhcmNoaXRlY3R1cmVzIGNhbiBzZWxlY3QuDQo+IA0KPiBT
dWdnZXN0ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiBBY2tl
ZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sg
RWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg0K

