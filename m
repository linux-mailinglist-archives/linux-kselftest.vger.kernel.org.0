Return-Path: <linux-kselftest+bounces-4472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5F84FD70
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE681F24603
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64B126F0C;
	Fri,  9 Feb 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVQ9HGrC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A884A42;
	Fri,  9 Feb 2024 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509928; cv=fail; b=ChoJCasGqLvoAby+Umls5RIMr8NOWwKUS+foBYPFj8OBiEZMVBLnmoeXiO5piuWL+3PRu9Y9s6rbR6Tzp0Z/5yx86VfdfdlGdlmCA4eU+DK2SkQF1UO05s9gm5BGw/yCyB8DwUAOL9z81OXhCwSdGIwtYEzyX2EPqQcUjbQxxS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509928; c=relaxed/simple;
	bh=9sQIEDLzbyHd8/zyvKX6vc9nGHZG1nQh7pTGMlPKqAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WEXjWC8b5Pr0xYBNfPj9n47hO6egrMIhowYGT1KK+15XTHfS9fHo0+CX5GVf1u6Pbx8OvedNCwHFMuMkz2jvOcDjohfYMwDU9YWMWhm3KBu+Z2Ze4+t++7/Olb+vjJq+/LcA/JOWf5qqzVYWgejsYht0zOhQ/xphZvF2ElFr5Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVQ9HGrC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707509927; x=1739045927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9sQIEDLzbyHd8/zyvKX6vc9nGHZG1nQh7pTGMlPKqAc=;
  b=PVQ9HGrCEZCv4WGKv99lBaXGYgtvMS9v0luZPiXsc3taMFoq9QQSWHyI
   vcQC6Xl48EAnTJJ6drTRwjr5iFxvd7QfSVP+2YXb06a8Mrobm2DiacAY6
   Q1kQSvC1a8zdFhnALkUzd9EnORuqjTXGwjSqeRtBrz131GR1KV4UL4fml
   Ha8biARsVI73htQ1Vpq7DMRhqXugM3VWrapTXjbAZ+fqQUhJR7g+rJtY7
   p4A+zmhCqcKtEWbJtDsAr3ABUVX9do2UHrWS2uRpJPKNVf3SRl8HyAPnj
   /qOXczkigs0QbBXOfykfXH8MkxtF8RCpoMxSZhNQHrKn1u4/h2LZJR7b5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1374356"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1374356"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="33109365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:18:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:18:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:18:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDy6xtvgFu7IBmCSFDac1r5Go2P3ssOwn0G/padGUNjzIQ2K5L6HGkEWkocVf2uQXw2IQXSRS/DWE9mvRkl3hFfmO/CbAbMB6dw5Letqf8/08L3pp28ysTFan0JEximxxXe8M9lrwVfdIZreuomjV5527pB3uIZbAonYPI3ebp3lXIfW8OVTtJhye7m8cUqHdeYJHY2q5btGa27rcp47dtYrdoNAL+8MyoatW/z6QI510R60Lg+BPxcmpjoq+h9rLcg+sjJLi3Ag9JQ4S14BnseL8PNUkwzNC/EutnkXP0iCs3/exAo8ZbGLUX52lTOulML83oBFzGtPfo8iMVRXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sQIEDLzbyHd8/zyvKX6vc9nGHZG1nQh7pTGMlPKqAc=;
 b=hrAjhR/IxWkiWOJc1QFUFAdg9p/FqDodNmotn/WiLRLwr8LazsomImJ18/h6ZiaPYPB+Iyr9nHizw9BI2ABjinG+QYnS9af2yHZyQ67OUp5rDxVqbd3w3XDKhAyqEiYfWBwEi2BWPe2Uxki1KVGZRQUgwoY8ox36iE+GCMgDhIImkbn8x+r8V/0AW6/3L5GvLx5fOCUiQXlQzwapK4pnblQgfgrVSHB6wZON1XwrRgPxFlpz+6vBL96WIuYWcs630+0PHs2B5xYcQevpsYn+SHzmqKPvsEQqJcVTHbFS+UqGwwvSsx2B+FzTR7RMQXw4QvubQVEpKdcMB5WGZIn0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 20:18:44 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 20:18:44 +0000
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
Subject: Re: [PATCH RFT v5 0/7] fork: Support shadow stacks in clone3()
Thread-Topic: [PATCH RFT v5 0/7] fork: Support shadow stacks in clone3()
Thread-Index: AQHaVjS2xsjXwLkeP0aW3XwqIao1ErECffGA
Date: Fri, 9 Feb 2024 20:18:43 +0000
Message-ID: <325ad22d278d85e6ea6a91691c5715b6b65dab09.camel@intel.com>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: d3750ea1-2401-4c1b-41e4-08dc29ac5064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLUayrCHAr/8ayYlZRtaeXUL2uGP5NcOkFI1MtodmljxP76CLIvAEJCuZ+B7tvxmiUIn9jr/7D3ahFUmT/pxpni34+C/WR8EE4GmewMVYdWVobA0WxIw7k5mk5ytmamw7ctYbc77cwfbBQH0sTI6S9KX8aoft6xsQ/XgJwRS/lpfLV2Yo4t/nrgEBYj1x9Kn03NG3VajwnhmifGj2aweTjn9NSeItLuCEnyr3wRIFvyhkbl1/UDL6FAIHONHshwEAR6MIShvXT/UWEpTz4GF0afzlmLwRipauQX3HCEbxDcvfLwpNaM1dD3pxiV4fCMItZ+ZlIziTbpEuE7CSwgP0gYXyD47PflmTPg7cM97eeip1h7+n8bGCnwvt0bBzi1R4MbtHmnJcyN8VzGvrhOsT2Pim1prVWV7w0ZOoULHroNkZ5W5MDlU7uPtJ3eDBYgU/xUuIHxmi3qoSPHeZlQ6fVhakEg0BPHD2mj0s/AiNQ8AWPQygT/CYXo2ocWlWTNlt5wP9PZux4kpIaMpKK6L3jFwP+uo6W9UaY9ov2CB426RxlF7kVW/zISiMar4RAlR6lVvBZrNP4ExeQ/p+hVYOBVedRqWgFJbHRu77IPDCD9/gSqTkx56xebCcJ/HObfI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6486002)(6512007)(478600001)(26005)(41300700001)(2616005)(2906002)(7406005)(7416002)(4744005)(110136005)(54906003)(64756008)(316002)(76116006)(66946007)(71200400001)(66556008)(66476007)(66446008)(8936002)(4326008)(5660300002)(38070700009)(8676002)(921011)(36756003)(122000001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzgrRTRHUEJNMTJYcnkzYk1SM2JyQy9pbGt0ZFpWRmwrVGtjY0FiSmFtdVdL?=
 =?utf-8?B?SEQ3MWI2STd4MU1JUUR2bGM1WUlsT0VlOGpmcEgrVVRJbnFUbjBhOW1iVU9Y?=
 =?utf-8?B?a2xURmFIQ0tRUVNOcEY0a0NuUFh4WERrblNrcG80bjVpTnE3c1NLNXN6V09Q?=
 =?utf-8?B?YU1BeUJkUk1ZcHl2WXhmZlJmNmNMMWlmZFVjeXEzUGlDSGNqUHJxZFlwQWZ6?=
 =?utf-8?B?Zjd1Z3BpczR1Z01IOEFXeWhVTUtuanVvNzlNWk5CRzdOUlJFejI5Qk5WRkFH?=
 =?utf-8?B?d3QvS0VsV1ZveWZpQjVPM0djSUFnNms0b3VwZjNFaSt3bjRXOXFDcXpPWFN0?=
 =?utf-8?B?YVVnS3pLZTFVSUF0bTFIQ0d2ZmVSbUFiV2VvRnFORjYrdEtpU1Z4SVEwU1p1?=
 =?utf-8?B?TDYwbkdBeU5Dc1Mxb3UrRWRtTTFVWi9pRHJlY090Mk90TngwM0JiRXZPSmI0?=
 =?utf-8?B?cGg5ajdxeFFXdndzSkdlTUZCbVl4QjREOWRsdjJPYVBjVm9tU0IrSlk4ak0v?=
 =?utf-8?B?bFJnQXZ3QkVOQ1JuQVc3Z1k1L2todFd1eUhucXp0Ym1VOUJ5K2VXLzY4R3JQ?=
 =?utf-8?B?d2RzZWloT1E5QXF4cE5ZU3EyTGVmVGlWMnRURy9aQzhNL25VaklBdUtCVjli?=
 =?utf-8?B?ZUw5TnQ0MDMyNi85ekx0SkF3UGtjLzJWYmNzMkVaR1kwckpoMmFDbUMwSXo5?=
 =?utf-8?B?MXlHUVl6Y1JQNDBsR25oT3crMkZURTJwM2VIOFZqcEI5RmEvdGQzaTdKQk05?=
 =?utf-8?B?VUN5Qm9URWtCV3NmUzh3TFhMYWZxdEE1cnJ6aXJqeHg2RXRyV1VSQWE4bm5E?=
 =?utf-8?B?d054UVpITjdoL25HWEwyU245WEc1R1JYSUk1TVJLcG04Z2VzT3luRDVrcGtr?=
 =?utf-8?B?aE9oRFo0WU9kemQ2TkM3cS9IdnpDSkoraEhndEc2T3JDWHBNV0tHakJrOE1W?=
 =?utf-8?B?eTVXaXdjOTNwS1N1dnNtVFpPTHVYT0xGOGs1cXVCSmY5ZGlGV204Mm5kdFRs?=
 =?utf-8?B?NHRzVEw0RmpLQm1ybzZGQkx3R2YySDJFK2t4dFNROXRKek1VMGp4ODBIYnF6?=
 =?utf-8?B?R1VvTWdhell6Q25kK2drbURQQXFhZWs5WUl0cmdMNnk4Qkl6b1dPaE5KcXR1?=
 =?utf-8?B?QzUvUW9nbWQwVFJCMHRzVjM1ZlUwQXlRL3V1YmFJRU5hcWpHVFRHZGlkNXFQ?=
 =?utf-8?B?QU1sUDBjY1NzSWt3bzhVNjc0RFpSclMwRW5Ra2NwRmJtRXkranViZTFVUGpZ?=
 =?utf-8?B?QzIyY3oyRXVoUTFaSEpya3dkeGdzdHBZUDJzaDhlcEVpYTI3aXgyLzFZTDJF?=
 =?utf-8?B?bWZXcGhneTA4UDJPalIrUWtuU3ZydUlPRmpwNTFkS0I0MCtuSEVOMFkxdTBu?=
 =?utf-8?B?OTJHbkVYRS93b3dkaktKekQzVURZMUQwNWNjTmdFREZKZ2R4TXhHbVVTQ1k4?=
 =?utf-8?B?K0thRDZlVlN6OWxZdDQxWlVEeS9YTnRQVVdOOFpuOXplR2dXa3RlRnFoUWlH?=
 =?utf-8?B?Q1dUUmFIRWdtbS9CMmV6RU1LRWdQNlZ0Q0NiRFhqZlRmdy9vcXY0OFJRTmhY?=
 =?utf-8?B?YkdDcm9CUUVLK2JMRkVzZmY5MmhjVnpNLzBwOFRCa3BURVlyUTVxYVJ5OWMx?=
 =?utf-8?B?WWVqeHJjTGw4TmRJdnkyMEdycER0Q0NhMnFJakt1MW1hU1BQOEpud2NMQ1Bm?=
 =?utf-8?B?clVyZitlQjlQVW1rVHBLdVcrN0doTjNSV1ExUkwxcURBZVlFZGVKWk4zdHBx?=
 =?utf-8?B?M2p1NHZ6c3Nya2EwMEJTV29iYVV2QzBqQ0h1RTNJV1daL2JLbVZBK2hCZ0hl?=
 =?utf-8?B?WXRSd2pMcWFOTTM2UjN2K2x4SmNqRWJ3aHBoYTQ1Mzl0UG8weHZpeUpETm9u?=
 =?utf-8?B?QWl2RnJBZ250RmdGYkdVUkdLKzNBSkdBZjBsYVkzWGtHSlFmdVlqU2RPM2tm?=
 =?utf-8?B?blJWY0l4VVI1OU4vMk5YTHowQ2dDeWthTGYxcndsUEhnOEw2U1dOM3dGcWVG?=
 =?utf-8?B?QUxibWp2M25BWVhDUnhIekxIbEhFSjRWTHdQZGV3cVR3dG1DU1BHOTVXby9t?=
 =?utf-8?B?a2ZyNkNtREdCMzlSa0ExdzJtT011cnJaMU56VWlCVkhJb0NydjVpRlNBOWNr?=
 =?utf-8?B?S1l0OGNXNTd4Vlg2WTNZdEYrQmlmUXh2OEdmNUtvd1BEVGJ0aHA1djZNWEY1?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D62D88D88C2DA40AA6E62ACD003D422@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3750ea1-2401-4c1b-41e4-08dc29ac5064
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:18:43.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjWf+Lzs9lkGGNZfMqX3fh4UVpO4RoUa1fJx+jKSRcHqiKlWGJ1w+lbnoxER5qcrHPlG5mcPtmFyxJ1AT4nLpkQoNkOSayQVvs6E2nMA0L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAyLTAzIGF0IDAwOjA0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBQ
bGVhc2Ugbm90ZSB0aGF0IHRoZSB4ODYgcG9ydGlvbnMgb2YgdGhpcyBjb2RlIGFyZSBidWlsZCB0
ZXN0ZWQgb25seSwNCj4gSQ0KPiBkb24ndCBhcHBlYXIgdG8gaGF2ZSBhIHN5c3RlbSB0aGF0IGNh
biBydW4gQ0VUIGF2YWlibGUgdG8gbWUsIEkgaGF2ZQ0KPiBkb25lIHRlc3Rpbmcgd2l0aCBhbiBp
bnRlZ3JhdGlvbiBpbnRvIG15IHBlbmRpbmcgd29yayBmb3IgR0NTLsKgIFRoZXJlDQo+IGlzDQo+
IHNvbWUgcG9zc2liaWxpdHkgdGhhdCB0aGUgYXJtNjQgaW1wbGVtZW50YXRpb24gbWF5IHJlcXVp
cmUgdGhlIHVzZSBvZg0KPiBjbG9uZTMoKSBhbmQgZXhwbGljaXQgdXNlcnNwYWNlIGFsbG9jYXRp
b24gb2Ygc2hhZG93IHN0YWNrcywgdGhpcyBpcw0KPiBzdGlsbCB1bmRlciBkaXNjdXNzaW9uLg0K
DQpJdCBhbGwgcGFzc2VkIGZvciBtZSBvbiB0aGUgeDg2IHNpZGUuDQo=

