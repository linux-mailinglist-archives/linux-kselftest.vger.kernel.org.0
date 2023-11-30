Return-Path: <linux-kselftest+bounces-884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076277FE9CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 08:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AD41C208B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09B1F934;
	Thu, 30 Nov 2023 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0tYby8M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413CB9;
	Wed, 29 Nov 2023 23:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701329826; x=1732865826;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZLRD2g4+hhO5Ac6CGajAiZWddf/aBATh8jUVmV0Ys5M=;
  b=W0tYby8MFWZitCW5NGuuF3dhHGh5/3+JfNBZ3SHue4M85cXlSLZHrjoN
   Fn0MhCmRB57ADV1NmEljRlNLCp0nTx1MbhSFvXpLelxMihy/gnfb7tqdD
   5rp4q+PtkrbayADBQKNBIxGRXLpLUjHV+cbQlS/npj5cnz/14weJIgmCD
   1Y3iTYtLvgjRJtfOwQzGFfETQp2CRGttAGnrm207iviLjsG2OM3djL4qo
   13W6cEhw7o3SnWSNlnPT2TPilUkoY72JkweApbt7MIjb1XqvOM/aNGhzt
   4KHsmYcyJfaw+fP8uAj63K0OoxvNj9/9/97/T67h+XNUC5DMPojsdl8g2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="393027169"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="393027169"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 23:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892726966"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="892726966"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 23:37:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 23:37:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 23:37:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 23:37:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjZCFdIqwrCkx2RgwaP+IvfgrSbFMrwoSMtMGJ4cr8UggqLdlL+amp7JmcD6xsTyi7TZ4IysaKpkg+pobh3s1gcTNleeDDzj5RNRwLpH2nLfpOXqneKHr0ncGZkUJVtpFDlt4pSa3OgnKDVBpovnVBmIem+BBrR0nKG4+fEgsMkrJCUolfY1G1jeISB5wuC/SQmX5Xx3pp6rRnXDb/388tK5PVXqA0Kn+CaUTRMktWiccbqspvi5zFNjvHbiFzR0y/Ohkfn7A7zk0PRr6mYat7ZafslN/r13JNPeoz/ysJv9msY5qOMJ7Y+YP1Ga9mcbeCl3TMK7NqxGUKgMxWEThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7W/bf00DYhasKWPvMA8NGNNmRVQ+RTD4jJ4dZYLB40=;
 b=Zg6AsVlBwbh67thJFCf9qbyvgp3QQPm0gfe7AIv95QOYJS165wxRzQgKRKA4HjvaXKpNBFMW1U1huj8e4apagDLG70spT/SodgMAK4tjAHB23vZj8uPs6L4ZudNL4YX2TCkW2zA/h4pHeawygnX+gYxFslPt0/p0THU85GPqfRjDJ1s4T6Z6Zf0EnueZD/x5szl3HcFmSiz4GdNi+mukShg6A17M9axO7IZYembAVS9dQ+Nl/aIomfkmrr3sUdSrqI78WH4lR+Ro2TWlfMeYPxALoDWZ3NzLlfl0nJSgfy1wWzmnof0eDqh/7DGfE9eksHRe39KX7R9f3SgCVfcWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 07:36:57 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 07:36:57 +0000
Date: Thu, 30 Nov 2023 08:36:52 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Reinette Chatre <reinette.chatre@intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 26/26] selftests/resctrl: Add test groups and name L3
 CAT test L3_CAT
Message-ID: <cgp77jx2dpijdmdroqh3g2ykgrupny4wpjmkkustzd23anzodx@ejdkjduafxos>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-27-ilpo.jarvinen@linux.intel.com>
 <2787018d-9661-4169-9571-a4016691cfa6@intel.com>
 <ca49fc8f-f9f7-138f-ff2f-60f754525df7@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca49fc8f-f9f7-138f-ff2f-60f754525df7@linux.intel.com>
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA3PR11MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e90e6f7-6562-4e01-31b2-08dbf1772155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+Z6mPJX8jONmXlKSRcHbDqdKHEZcn8WoD1cU5V1hpUNGVGfBJj1vRZTOSpe32HD+PwOeltvzDE8fl0JL3nJk1fVJ3G9sITZ3/EHi1A2VFN4LM8weWteTuB9YYW02xwt8r7etCuM+EEOr6UVqGUJqJRrQP7NyfomiMxWsssiDJLjqbLwExHaVQ1EePds14z/EmfYtMlwf9CQUWPNIVceHS23vGPhyr5g0ry+XG5u8XpeoeM7rOhsPrJ9hWkZgO15gw1E1vYQqSuodlRC15S2kJfAwZjwXbqtNh4EYbL10q7ahzL++x7kO93Z3LvZ5hwyiU4AXWTDn20wuQkiSN8Mcu6kB7eq341qf7fLyC6be6HA6I7dfLMQvrGAjMnk8V6xZAYV9QSU3W0WWNWt31JEYWmsgSLTipeI0z/0r4i/LI7W1arC+U0KU4mdg9CTdMmSIGMguuR36vtYYLzco+ueA5g6UY6DZ0jBFkPk1YiNW9Y2GXQGmU9UVU4UnJHMCFcBGc11fY55dJRE5lkITuCHkTFsTJE1vy98RwFLVDxAORritq0BmsVsFA7ssygrRCh3mmEOWvlsuWNzG92vMc8H8SCc1zHI0ncLta0DkElHfUOI+1IshfF9AqRnZrlPItCmNBPor64Neyy9hLeoYc7fiWGVqL3Upasudu78m+J68oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(66556008)(316002)(66574015)(6486002)(53546011)(66476007)(54906003)(6916009)(6506007)(478600001)(9686003)(6512007)(82960400001)(83380400001)(86362001)(38100700002)(33716001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(4001150100001)(202311291699003)(6666004)(26005)(2906002)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2tIfEU1t2sYwHZ6j2ZEepXOWcIyodwKAnfmZoJCABIN96AQdPadi3qEf4K?=
 =?iso-8859-1?Q?vZVpK9r4vN39w7OLvfOGB2jkL8tTQoJ4n3qEkKNZclKpVmw5l25YpTlSw4?=
 =?iso-8859-1?Q?i3EL1BlfYcRAoiTEZqQ2dms7rFI5uQvbBBKTMdFzrpqeKCDaHMM278gHEm?=
 =?iso-8859-1?Q?v/pMJwd8lpafdILTQXOUHyX74aW1IgIPPx1L807Ldvcl1j6bRuy/5AfPR6?=
 =?iso-8859-1?Q?Cy+nLSJ2Mn7xHqE7TptoPlI5o8jPpdhPRM2+uSoGFfOAfZU+htQTRoyz8j?=
 =?iso-8859-1?Q?u/pif7RF3j+FNDPst9VkM+LidNyk6R4YjzL+Yg1rO/hWKzKGJ2g4G7arLP?=
 =?iso-8859-1?Q?lXWTFqQD0KDWNtJJ0VAFKnEGdsdT+WnNZqXyXPjjfVWpaIf2JN8rZCE8ug?=
 =?iso-8859-1?Q?JvXNWp1AgKeUCTtFB9d78QD1NeYXmZu7vHKYV1Rqd0N6nawiB8wjr9KmHz?=
 =?iso-8859-1?Q?1qQka00MeoPAGS45UgXK84Kko5vgniVm5phEZo7wB7irT7NoffiC+ffOwk?=
 =?iso-8859-1?Q?t5dhTIBUDdn2r8G9SJm8sm9V5tbVv6N2fSnKHu4kbOzTPJ2SRnCijS3GoA?=
 =?iso-8859-1?Q?3rupRdaVoRbufQnNFsn2/ZJI77dT0Q+O/iYTCxNa0+5BzwIUoR6R9/tcbP?=
 =?iso-8859-1?Q?tzZNZsqFXYnvG1rd3kOMuucRqQyr6aOdTzZ5ITz+oHf76PvobQts5Gxc5j?=
 =?iso-8859-1?Q?HShXGOJt0owObNJEgWqDMQtHqilsth+EF3zF3vWZzAuWBeO6CEWgZWFn36?=
 =?iso-8859-1?Q?RAvLPMvMLAN954Npe95kVgScJbjCHUSB2sGx0HqmGFB5vYjUtN0HQuwfQr?=
 =?iso-8859-1?Q?G6ZTrJftyiDeDFiAFrK4jfWRv3Px9eO5ekqZisGZtV8QRswR+IBUwti7bv?=
 =?iso-8859-1?Q?FnbSuGWVL64DwiLGHZAmL4ZhIFtgeIuaxNw+z8RmppM2yGZno3ufCKxHre?=
 =?iso-8859-1?Q?9OBu4P6vY9vNkz1kiU2tbHf6O5wyptbms+uq0JgNLfYwyrnTCJuPR8zMzy?=
 =?iso-8859-1?Q?13aRrMZ7RV5Af9OgvIncy+zpWftIhMP3KIHQHASw+Lr50TONUj+Ngi/NMS?=
 =?iso-8859-1?Q?QHsaKmeDrtEDf3iRUodrLqPYN+wVvg7Yfop1N8mWE3HEf1epwdFzv3tKoq?=
 =?iso-8859-1?Q?asE/OXGLD0s0YE22WUWId3kOVZGGgFqDUBme5NlCYqvc3amihQ6XrRJG/V?=
 =?iso-8859-1?Q?rEgFONalekFkLYi1x78ty5k6FNeZPgJWjrOBVF5rlOoYRx+sbECKXuA96N?=
 =?iso-8859-1?Q?+RdA/rD2twQkn0psvOJO3NKupkDjDenZdg7ZEifzbI11ARxStjxzGU+TEd?=
 =?iso-8859-1?Q?wgLmwqmuWWLrJkEgVaSz/74DlRaPLf9qDd0MLr+qXm+w6UsvKIBkfB+0Ef?=
 =?iso-8859-1?Q?dghzXBoEm5kG5VhVysGHyEvbZU93Wj3OabcaddKgPFHr3RlohKu266Tm8T?=
 =?iso-8859-1?Q?eDAQFtuMNvjaCdHm3lWFbMT2ys1DcnY8LlvSePlbgivMOC7RkyCphsM5+R?=
 =?iso-8859-1?Q?oxDxTCZhsWcCBRVIe9ZbNcYIyJaMfpp6+zsnX4IGf7kMzAJiy7ClZskerm?=
 =?iso-8859-1?Q?j1mUQfvkSbEx6LOLOtxtwPukqbZrg10bXL36aNbKLnuyiqpBjzWV6YsvL7?=
 =?iso-8859-1?Q?cWP9yERZwx4qK+mokt6Gz61jMtFxI8SkHU0P+n2Dt+3TVLsqJpUG3pGzyJ?=
 =?iso-8859-1?Q?mPzmGFPBntzG9+3PJ84=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e90e6f7-6562-4e01-31b2-08dbf1772155
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 07:36:56.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4we3n8m3Ji23ixoRpXtkQhMpFoy0kpoJd3Hgi6UyoMkDXJS01mvS4VpXfPeJHrk50E+CBum8wFop22zqMiFFfHJmhyE1zPxcGy0iaglIjpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com

On 2023-11-29 at 13:11:44 +0200, Ilpo Järvinen wrote:
>On Tue, 28 Nov 2023, Reinette Chatre wrote:
>> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
>> > To select test to run -t parameter can be used. However, -t cat
>> > currently maps to L3 CAT test which is confusing after more CAT related
>> > tests are added.
>> > 
>> > Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
>> > group will enable all CAT related tests.
>> > 
>> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> > ---
>> 
>> Could you please defer this patch to accompany the series that
>> introduces other CAT related tests?
>
>Can be done but it implies Maciej non-continuous CAT test series would 
>still be blocked by the lack of this feature which is why I included it 
>here.
>
>But perhaps Maciej wants to take this patch and submit it as a part of his 
>series. Maciej, are you okay with that change of patch ownership?
>

Sure, I'll try to send a new version of my series on monday and I'll add this
patch there.

-- 
Kind regards
Maciej Wieczór-Retman

