Return-Path: <linux-kselftest+bounces-1222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CAD80645D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D7F1F20FF0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 01:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5110220E0;
	Wed,  6 Dec 2023 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgkTpFxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434FD48;
	Tue,  5 Dec 2023 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701827227; x=1733363227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6olkwAqewhqmDmB56+f11r2gmERqP4C34VpihS8GKbA=;
  b=BgkTpFxeQec5h3gRtpH+SyaQWpq+YD9Gxkl0tyw7CPG/J1T75CeqREtH
   yFaRG3nRpZTONZ5dxudEaxFPaMQ0vBiR9OGzSLKKSUMtCYPyKd3MiVgz0
   vePbp8GVCKdFot0W4WsTc5oR7wd4E8OogquWq8GVe3NhffklATjpwrdER
   uTQFzDfA9V12KQ/jvvq2055DdghKs1NadLWLkCBv+3pxFprMX9mhg4mOI
   MsUflWFEZk65pzgOCFXFJUkGJRbe6y1CRDsmYMKG1oz0wI67eiS32KZkb
   Kyo6krD0+5opYeamoUV8a27vgKDsYocc66xk1ipHGfVGeP2N5G+F5Fwdu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396780282"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="396780282"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944471392"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944471392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:47:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:47:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:47:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:47:03 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfg3K016uf+DM8w1OeHZPWYNduk4da6Z/F3dD+ZxYdad1CwPN8Zs1us1nkHhO0vPhowjYVxgUqOYuUBA6QXq+GLu4MUoN3WWfL0cvjTPKBcVuBFjtOW1MsBoUw7KmHcgpoUs3PH06EDIRmN76b4Suci31Ri9kyyJKyM8XNIz/Kez1CGara7F3rMm2TARBAR+HK3qLJ98Mf4ZglKVAGvwJWVfaZrjNSIuUDBtxQSlySUBpBrMOIbqzBQxDwqv8/g0z+9zDv/lYrSJYpnUU6OANfKdRHaDXiYk23+zf9cQi7YDpdN9nL/6CvCMejp1b4Y2UaA58nd5XJHpnfwPssdl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Usx8obpBAYtL4DLam1dHKEwJddiaZ+QX2Zp7TNsKVc=;
 b=OuqbqK/Te/e+R+jHAbLzvpKJgr7eb06ZWWfwuTUfRm+FVXwQ4bQa+qskaGDeOC+kH3MYpb8jpDRDzetKJag4BlMB/rbADDlsykSFcTb1rCJAE0UtN0VXIF6DnOeLRIVE4lTd2Gya61nhbJuntAbtUEbleVj0TGPOQqgvi7OxH9RVYP7nPJ/SveFlMJooQvf0VMUK+r1zJ8o1d0lTZg5uJ90DT/uU/pb2qgMw73YPyc/q8qhXx7CCp4wdvgosCRONEWei3X10n5Z+rJu2/B2/p+Y4vSPBaXjKheb0JciX9vf/pKJAgno87KEDfh2m9lSUozDCAwtdhNYm2cY2G4bk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 01:47:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:47:00 +0000
Message-ID: <101c0235-c354-43b1-afc2-1332bd8b453a@intel.com>
Date: Tue, 5 Dec 2023 17:46:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
Content-Language: en-US
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Stephane Eranian
	<eranian@google.com>, James Morse <james.morse@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com>
 <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
 <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com>
 <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
 <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com>
 <CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com>
 <e4a77e0c-a31c-429b-9de9-3cadd704ca34@intel.com>
 <CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:303:85::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 414b12e0-072a-4512-1c73-08dbf5fd3cac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZwNaJvQifPuQbTEdBNSxDnqvfGW4dt6Lw0kGYH50uYRBEbH4sk+in1ZdjfX7L4j5oaXfQAhNf7RlZR/nJkBy6i/vP/QxEbRxzxtQglBTCC7VIpQaob3x84a4QKPegDYxnBjhyKmh+IqU0nw58AXCqEKnKldvvhwHy8uF3mXhYIrirtnHrmJosMRgeYRBJwVcaBYnMLkaaLQiT0SjbcgakC4pnDeJD4PehaLDAwCBO3fUbXEL7sd/mPkT9u1B7OfqHEaJnxQgPf2vyrXDz54t5LD7Dl6XNoe0w3+Xe2JGDip7bT3nrMQ4SM0QorPsblJ9O0PPKbADSWXg7WA6a2TVKnqIAWKyT6NuI8Q1mBrZ7ZTz+5VnXnNW0wK5BnHB9z60yqf6IwbXhtWqmKEStD2Jx55W9i9foQnk915kcKtdplhS1tWcsa6+wHoCtAtG/VCyx1RgXbNUemnF6UzBoIlsldOyclujRk6uqXnIvlJHhJ6o0pU0MfsRbse++2Z/Oj7O5r5lCO0/Wpan9qwk2X4GmcY2Z/hSjf03xQJm/G8KqkIsFfunXJzMGWTAfWOqPpXVEJwuSp+u3n/6sivQ358lZq4NTjNYjhf+7Zh1cTn+BuRkdBbSb0LfKaosb4BDlLlZsgRDJACp0gxnqfVFxFpDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6512007)(2616005)(53546011)(6506007)(83380400001)(66899024)(26005)(31696002)(44832011)(41300700001)(36756003)(86362001)(4326008)(8936002)(2906002)(8676002)(5660300002)(7416002)(66476007)(66556008)(54906003)(6916009)(66946007)(316002)(6666004)(6486002)(966005)(478600001)(82960400001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVOOEx1RUE0M000RFJWZzNkOEphMFhSOVM5MlE5KzJMOW4zelRxMTZyMjhW?=
 =?utf-8?B?UlM2UlptaDBrcDllSWxEU3dzbjl2UUNxd1RQVnRSc2R3RkNXY1hYRE1TOU5z?=
 =?utf-8?B?SFRTb0JkRElONHpjK0h1dTBweEZtY0JwTzF3TTlSbjVDL3VPM2NPRjU2L2pW?=
 =?utf-8?B?R240dUVXNVo2dTYzVW9wbnlseis4SEhRcHF4bE5sWTNKenU0TGxiOWN2TXhM?=
 =?utf-8?B?dkhhb3VWSzlrb2N1NFVhSWVONnArMEI2eUNuZ0ZJNUpGNVh6Y3JrdnNsLzNa?=
 =?utf-8?B?UFBPT1hMZVZuSEhmaDhIcVBwaUZCaWpBdkRLRnFRN0dhZ2RXSEttSE5La1h5?=
 =?utf-8?B?M2dXaG9NSUU3WlhLRnU3ZHRQa0pzSngvd3oyeGhRLzA4NjYxN0JJT2pTTHpq?=
 =?utf-8?B?TUxYSm8zdndjNEpmWlMxd201dkxZUjZZc0JmQlBFU0t0WTBGNzFRQ1QzUHJ1?=
 =?utf-8?B?dFdWeTdnZzdUaFJRTFIxbGtHT1pyVlh6OHJ4VzZlTWl0RTB4encrTThWRlJ2?=
 =?utf-8?B?WkF4bnNUaEdxMGhYbnJyYkd4ZUxyajl5RGVjbG9jRlMrVkgrRDdxR040SGFi?=
 =?utf-8?B?bzBiVFN6YnViWmJRL3JXaUQvTlNObGIxNHhKazJ5MjRTYm9PMk1MVFB3eUJG?=
 =?utf-8?B?bnU0aVA4RDdtSmlmL2R2V2paQVk2M1hueTJKRFVjbEVBT2tLQStCNDMvemVE?=
 =?utf-8?B?T3phcE0yakNaejEzZnZwcHhvM04rV3pWczJ4aWZiUm5aS2xzajJFSkk5OXd5?=
 =?utf-8?B?djVtZHhJbFVldFdWTWtwUUJOVFQwS09wdXM5UERhM0ljcitCOGJpcW4zZGhC?=
 =?utf-8?B?akYvdkc2d0gwbll6U0l4VVNXSVZadE5zaUpLWWpOS1hiN1E2aFNVVUc2VTZY?=
 =?utf-8?B?RHc4NFhRUGhZTHZFVVNwVTdpeTE3c2VRcm9sN1NMa0FNZXFCdzZFZ3hBcHZL?=
 =?utf-8?B?NS9jWW9WREJFT0tQUUFiTHBobG5XQzNoa1EzaEdldmlXSTdmQ0JJQWZmeWVz?=
 =?utf-8?B?UU85Z09PV2VNSjZJWktBTDh5ckJjRUhSeFQwRlpkRWl5WEhLYmdTK3VaNXJX?=
 =?utf-8?B?T283cituVGxpNmtBVXpRbytLc1B1dXhKRFgydzROYTZnaVhvYlVWUkpOdlpW?=
 =?utf-8?B?Q09Tcm9ZNGJyR0ZCWEhndms2TG5ORFVMNy9lUHBEMTdVZEt2MmFkTGFqRUZ3?=
 =?utf-8?B?UTB5NTZuOUlYWExuYW8rNmdUMDkydE5tazVBcEFJZGRvRTYyV1dMRFFMa3ZS?=
 =?utf-8?B?SW1YeG9Bck5VdkRDRzFzU3dxRWlpKzRBL1g4MVFGRWJJT2NieWd0SnBJTWw2?=
 =?utf-8?B?ZW5uU1Z3Vk1KQ0xnQURocyt4N0VlaUU3TEN3L085QkNITmkvcHNqYXEveDYz?=
 =?utf-8?B?UGZHaGl6SXBQdzZQWVdjQjUyTE9NTVFTTitFYTgybXBLZmpZUXpoWEtBWU5V?=
 =?utf-8?B?R0lJQWYrcU1MVFJJRTFnK3JDQmF4ZFRac1JuMzE1RU5mNTdGLzRVbFcvU09E?=
 =?utf-8?B?RFBXMk0yT0cyVmxHVytCRTZkbnpyTU1RZFQ2aStGZ05nSkUrRDRISXdjMVIr?=
 =?utf-8?B?U01HYmgxK3hBWjMxZHp3anRjVVkya0VWWEUrRnk2NlUyc3ZGSy9MVEp2Z0Nu?=
 =?utf-8?B?Y1B4N1hHSEpzN2MvTzMxckhHUXh1U1RXVENoWEJxajhTcy9pMC9ONEQzVEts?=
 =?utf-8?B?eUM1RWYveTIvUWZyK01tNVRQVk9KSXdON050YnQ2c1pUSk1CVTJSTXJRT0lP?=
 =?utf-8?B?ditiWDlJeUpobXNaOFRydEZPUk9TSVVrU0YzWVhtL1kvS2g1OHdUbUQ4TGtC?=
 =?utf-8?B?ZjhpbWw4eHNTSUgyVHJXQnBpeW5sRmQvMlVzVEE4V0UwNXpCdDRDSFFuSmxh?=
 =?utf-8?B?S3hmQjNWeU9PRUFxbXl2bEE2TSt6Y1J4MFIrbXU4WHZvVUxPRVhVVnRNaUFS?=
 =?utf-8?B?Z3dpZktRcWorWXFFYmtobmZDb2Z0RlZZSVc3dStFeEJuRXpHM1BoVmFYVDBz?=
 =?utf-8?B?a3kwcldFOGVPcEFKa2pWTWxiNlBVY2NUQ093aXoyWVh3Umgza3pTc1RuQ3hK?=
 =?utf-8?B?L282d291VVdsc1dyRlozZVhDc2taMGI0SFN4WGI4WjMrdXNESFdwdUx1aVB2?=
 =?utf-8?B?aFdQTTlHVTFOZHN2RHdaR05nVmFFTVdnemVveVFQTkpNSWhSM05YTllmTnVW?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 414b12e0-072a-4512-1c73-08dbf5fd3cac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:46:59.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpvVTKokX5VA3PJt4Za6zpetgpQmqgLWkFpiAqD/P78i2vaOQT/AVtC97USG0nCCEz/dUj/xinm8ZD1gpoAOCa8np7nOfUCrb4k+o0Oj+bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
X-OriginatorOrg: intel.com

Hi Peter,

On 12/5/2023 4:33 PM, Peter Newman wrote:
> On Tue, Dec 5, 2023 at 1:57 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 12/1/2023 12:56 PM, Peter Newman wrote:
>>> On Tue, May 16, 2023 at 5:06 PM Reinette Chatre
>>>> I think it may be optimistic to view this as a replacement of a PQR write.
>>>> As you point out, that requires that a CPU switches between tasks with the
>>>> same CLOSID. You demonstrate that resctrl already contributes a significant
>>>> delay to __switch_to - this work will increase that much more, it has to
>>>> be clear about this impact and motivate that it is acceptable.
>>>
>>> We were operating under the assumption that if the overhead wasn't
>>> acceptable, we would have heard complaints about it by now, but we
>>> ultimately learned that this feature wasn't deployed as much as we had
>>> originally thought on AMD hardware and that the overhead does need to
>>> be addressed.
>>>
>>> I am interested in your opinion on two options I'm exploring to
>>> mitigate the overhead, both of which depend on an API like the one
>>> Babu recently proposed for the AMD ABMC feature [1], where a new file
>>> interface will allow the user to indicate which mon_groups are
>>> actively being measured. I will refer to this as "assigned" for now,
>>> as that's the current proposal.
>>>
>>> The first is likely the simpler approach: only read MBM event counters
>>> which have been marked as "assigned" in the filesystem to avoid paying
>>> the context switch cost on tasks in groups which are not actively
>>> being measured. In our use case, we calculate memory bandwidth on
>>> every group every few minutes by reading the counters twice, 5 seconds
>>> apart. We would just need counters read during this 5-second window.
>>
>> I assume that tasks within a monitoring group can be scheduled on any
>> CPU and from the cover letter of this work I understand that only an
>> RMID assigned to a processor can be guaranteed to be tracked by hardware.
>>
>> Are you proposing for this option that you keep this "soft RMID" approach
>> with CPUs  permanently assigned a "hard RMID" but only update the counts for a
>> "soft RMID" that is "assigned"?
> 
> Yes
> 
>> I think that means that the context
>> switch cost for the monitored group would increase even more than with the
>> implementation in this series since the counters need to be read on context
>> switch in as well as context switch out.
>>
>> If I understand correctly then only one monitoring group can be measured
>> at a time. If such a measurement takes 5 seconds then theoretically 12 groups
>> can be measured in one minute. It may be possible to create many more
>> monitoring groups than this. Would it be possible to reach monitoring
>> goals in your environment?
> 
> We actually measure all of the groups at the same time, so thinking
> about this more, the proposed ABMC fix isn't actually a great fit: the
> user would have to assign all groups individually when a global
> setting would have been fine.
> 
> Ignoring any present-day resctrl interfaces, what we minimally need is...
> 
> 1. global "start measurement", which enables a
> read-counters-on-context switch flag, and broadcasts an IPI to all
> CPUs to read their current count
> 2. wait 5 seconds
> 3. global "end measurement", to IPI all CPUs again for final counts
> and clear the flag from step 1
> 
> Then the user could read at their leisure all the (frozen) event
> counts from memory until the next measurement begins.
> 
> In our case, if we're measuring as often as 5 seconds for every
> minute, that will already be a 12x aggregate reduction in overhead,
> which would be worthwhile enough.

The "con" here would be that during those 5 seconds (which I assume would be
controlled via user space so potentially shorter or longer) all tasks in the
system is expected to have significant (but yet to be measured) impact
on context switch delay.
I expect the overflow handler should only be run during the measurement
timeframe, to not defeat the "at their leisure" reading of counters.

>>> The second involves avoiding the situation where a hardware counter
>>> could be deallocated: Determine the number of simultaneous RMIDs
>>> supported, reduce the effective number of RMIDs available to that
>>> number. Use the default RMID (0) for all "unassigned" monitoring
>>
>> hmmm ... so on the one side there is "only the RMID within the PQR
>> register can be guaranteed to be tracked by hardware" and on the
>> other side there is "A given implementation may have insufficient
>> hardware to simultaneously track the bandwidth for all RMID values
>> that the hardware supports."
>>
>> From the above there seems to be something in the middle where
>> some subset of the RMID values supported by hardware can be used
>> to simultaneously track bandwidth? How can it be determined
>> what this number of RMID values is?
> 
> In the context of AMD, we could use the smallest number of CPUs in any
> L3 domain as a lower bound of the number of counters.

Could you please elaborate on this? (With the numbers of CPUs nowadays this
may be many RMIDs, perhaps even more than what ABMC supports.)

I am missing something here since it is not obvious to me how this lower
bound is determined. Let's assume that there are as many monitor groups
(and thus as many assigned RMIDs) as there are CPUs in a L3 domain.
Each monitor group may have many tasks. It can be expected that at any
moment in time only a subset of assigned RMIDs are assigned to CPUs
via the CPUs' PQR registers. Of those RMIDs that are not assigned to
CPUs, how can it be certain that they continue to be tracked by hardware?

> If the number is actually higher, it's not too difficult to probe at
> runtime. The technique used by the test script[1] reliably identifies
> the number of counters, but some experimentation would be needed to
> see how quickly the hardware will repurpose a counter, as the script
> today is using way too long of a workload for the kernel to be
> invoking.
> 
> Maybe a reasonable compromise would be to initialize the HW counter
> estimate at the CPUs-per-domain value and add a file node to let the
> user increase it if they have better information. The worst that can
> happen is the present-day behavior.
> 
>>
>>> groups and report "Unavailable" on all counter reads (and address the
>>> default monitoring group's counts being unreliable). When assigned,
>>> attempt to allocate one of the remaining, usable RMIDs to that group.
>>> It would only be possible to assign all event counters (local, total,
>>> occupancy) at the same time. Using this approach, we would no longer
>>> be able to measure all groups at the same time, but this is something
>>> we would already be accepting when using the AMD ABMC feature.
>>
>> It may be possible to turn this into a "fake"/"software" ABMC feature,
>> which I expect needs to be renamed to move it away from a hardware
>> specific feature to something that better reflects how user interacts
>> with system and how the system responds.
> 
> Given the similarities in monitoring with ABMC and MPAM, I would want
> to see the interface generalized anyways.
> 
> 
>>
>>>
>>> While the second feature is a lot more disruptive at the filesystem
>>> layer, it does eliminate the added context switch overhead. Also, it
>>
>> Which changes to filesystem layer are you anticipating?
> 
> Roughly speaking...
> 
> 1. The proposed "assign" interface would have to become more indirect
> to avoid understanding how assign could be implemented on various
> platforms.

It is almost starting to sound like we could learn from the tracing
interface where individual events can be enabled/disabled ... with several
events potentially enabled with an "enable" done higher in hierarchy, perhaps
even globally to support the first approach ...

> 2. RMID management would have to change, because this would introduce
> the option where creating monitoring groups no longer allocates an
> RMID. It may be cleaner for the
> filesystem to just track whether a group has allocated monitoring
> resources or not and let a lower layer understand what the resources
> actually are. (and in the default mode, groups can only be created
> with pre-allocated resources)

This matches my understanding of what MPAM would need.

> If I get the impression that this is the better approach, I'll build a
> prototype on top of the ABMC patches to see how it would go.
> 
> So far it seems only the second approach (software ABMC) really ties
> in with Babu's work.
> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/all/20230421141723.2405942-2-peternewman@google.com/

Reinette

