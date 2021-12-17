Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9892478C5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhLQNdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 08:33:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:17861 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhLQNdK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 08:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639747990; x=1671283990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQWP8qE7ZOFz/D02z6ONbLIz5ogAsc6GiI0yQSVvwvo=;
  b=hnEVGR3umkoiSMMgXRGWnetgMMtY7ROohHGpT4e14EB5KKPuGL0xs9D9
   6JthWiKOEJmsBcE3FKJwebPWD3dYugWTuG2Tl2xz5KrXp/3HCYMbaL+dT
   7FNp3SH1Xgkxg1FW0hKGIzr/7aoPfaV+h70Q8eXrferXUnh1cV0nfvzra
   MF4balsXY370oVtVT1I5GWSfBt0Dp+m1wFLd+Pfrz23jjiv7klXiX0XOu
   Xq3djpNC527+kaNIo+NiK25BsI9/6xwyp1ax54lM6qN5kopuV19CFNwY0
   ab0IR1EHst5tcoZ/2xrD8q5/mhZfTU6Im4GRpf88eAMrT3ZLel3y3UAdA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239564751"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="239564751"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 05:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="465122554"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2021 05:33:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 05:33:09 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 05:33:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 05:33:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 05:32:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9EnZH3+S5+4v4jkE/3U71S9EypCcpdRODI3kqInlCwiCAYARebr4u/jqB95f1FV96oRW8oyNNXSBiTFBa/QF4BuZstRFx0u9fNol+9pKKhnbbjV5TrrYe3TimJXh9VxzYm0sIykqV5PFVdfwLFkVp4TZVFOhTxb56n/uMbm7LU9c/mm4Z2pphV1c/6uQ4VNqL3JfVnCKhLr7gVLyRqtS3EdEmUTKLflYYM/jYDayYLzBj4iSC7PBIvVdZoa+x/dUfeKqOCHNWdSpH2xtbVhz7ZNj1MCr/CogtlnUoQzA5JFyGMj3U5hDWsBxHlknHYdMZrGctPPuMdpoiymoFblGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UifLcOV0DhgRW6cJYKZ2GPeY8Gtqm6J+HJHmci4bWXo=;
 b=GSeAFcXNKBlugKQwJRsazZhHRMgczg03MzFcMhsxACqtHG1A+LOBhzYVj52B13OKXRCLZ8szrgo3aQlGNQmxROcEaJ65ytTDJ1y1oKMDfU1NXViPgcdTyW4UsO3Y8Swiq1V3jT7U3xK6nwBFW1Zzk8C12hxVraoeEq6mOJ0FTkHjr/1B4IVPU1HMcKCYQrcFLT9Itd8SKK4He6lSAB2C5QWKBayP9CgFnxOjUDkkt2g0oqN0t3sWiE4eRzTtBzktgbyf27NZC7R9YfxDK5kG/wBRWXGQbK2QrHbKzo3lL1urBy94HTuq6ioCumo99fSvuxzBdqqAcTXkRXRv5BnaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN6PR1101MB2353.namprd11.prod.outlook.com (2603:10b6:404:95::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 13:32:30 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 13:32:29 +0000
Message-ID: <f0caf4d9-5e1d-4b85-9d2c-00b65fa97638@intel.com>
Date:   Fri, 17 Dec 2021 14:32:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/2] kselftest: alsa: Factor out check that values meet
 constraints
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        "Jaroslav Kysela" <perex@perex.cz>, Shuah Khan <shuah@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kselftest@vger.kernel.org>
References: <20211217130213.3893415-1-broonie@kernel.org>
 <20211217130213.3893415-2-broonie@kernel.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20211217130213.3893415-2-broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 110fc448-3d17-4a1d-4696-08d9c161ac1f
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2353:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1101MB23539A3F5A147646BBDAE8DBE3789@BN6PR1101MB2353.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubYC+GAwuhPp8cHXscaOrZwUdWtnJLO92Gms5k0bUlTk86WvkENeXoleNXzUc/5zKvZGC+agC2nIRlByDxJRCMbQqDcsd5wrY9D7fwksOB232W4ecg+4lk+nxKV9QRLZ/MvhHFYGgwQPTEoIAay0xZkM5Pvb9y0MgbuFR5vMah1Vgx7J2MsCRSlPZcFzBWrxiGWXPgN+uLR7bMX2UeBe2DzhykByw/C+G0QD2kTueHiwQ6/H8dJ4knelYwVWT/qM3+0Eom6h29IbjMPkaxa8y+wuBkURXVXjwUFkj4vMPhBIpJiHtvm0nC/w3gKux1+xrJ5EIxyryqVm9nH5y7TZunYfaB49qnAGGAyaf/LsuSJLwHGu8n512VbGNHOWqrPYL5B2t/EXXNxxhETO4gPq7TCYKsSMd5PFijStDX0lhbVRq3ksyUYquv/bz9UQoj7dPiVlpVyfeagvDnI6th+UIti/twXSVDkoDnjmvIIpXDADlTajQEX81eK68xw3ltTEvDir28sa6sSuFm5npr+zmmjBor2ZVM7w/MzsoBhV3fbPyIFx67bHYxBZw07wpPnEYVEcPfW6txYLOsBeACZ+bGfG98IOfYQlg7Tw4s+Xz87Hg2+QDueiruCEOGZ/jnMurAh4NQWHDORK99/545ZPABYfggaB2GqIkrno8nZXowXDutN3nx3VdOlFj3ZWbbIDtKvwaJxEBF6OVuE2NwJFPSpKkFQXxJYlGwRCnORxGwf+1vWxO6qYBItSoRW42Dna
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(82960400001)(38100700002)(31696002)(31686004)(5660300002)(26005)(186003)(6506007)(53546011)(4001150100001)(110136005)(66946007)(6666004)(36756003)(44832011)(508600001)(66476007)(66556008)(2616005)(8936002)(86362001)(4326008)(4744005)(316002)(6486002)(2906002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29uSGtNZmJzcis0eVZ6VE9TUzJYSlRrWVNHb1gvclJrNC9IUFNPZjZRZU5z?=
 =?utf-8?B?dTBBbkY4elV6MVN6aVgxY3lOTG4wMWEwWGloZk8zMTB3L3NGOTZUSnQ0Tkpl?=
 =?utf-8?B?RHF1bzdxSXNqdk9INHJIRU01T1BlZExlZlc4MUQyUXNuTE14UW4vS2ZEQ3E1?=
 =?utf-8?B?R3ozWVJFOGVCSGlFRDg2cFlJb1BSdGl5Qk44dDJ3bE9kU0hadXVNQU5vZkJo?=
 =?utf-8?B?SXc3R25vbnU2OFpRL0oxcXhEVGNJSE42Sm05NjJwR1NpU2VNaXBKM0RuWnFE?=
 =?utf-8?B?RUFFK3FOMyt2RGtGT3BpeVl1cFMrMmpIQXlBR3VPaTFXZHR5MDgvR3R4a2g2?=
 =?utf-8?B?c0s4UjZDU0R4QzhqZ0RGK3hkd0RHK1l2MFdOTGNITUNJdzB6bGdlSGd3aGtq?=
 =?utf-8?B?Nk1SNEx5cUw1VzVvcUhvQnp6YURxVTVYVWt2WFBGMkxodllLbmlmWTV2ZkNV?=
 =?utf-8?B?b0M3QmQrd2l5Sy84SU0xMG5xZHBvcnJkVWNBOXJuRHVING9UYWs1VS9WeUpt?=
 =?utf-8?B?dW0zRkwxYWpYYTFqb05aMlg1VDZ4MExYR0kxMm93K2x3cUNoNlNybmN2N1Js?=
 =?utf-8?B?NHpKYUtBQmpiZTVJS1JTQ0lNYjV1ZnpDS2VuTWhhN2J2RFM5N01rWHlmYWs4?=
 =?utf-8?B?YWhkdStjaEp5OCttNWZDNFl4eER3UjRFa2FpT2pCelRjbURhYytnSE51UE55?=
 =?utf-8?B?REttNUlRUXNVd0tUUFZTUVdQRHdPcUN2TDNvcWh6UnMxTG1UTXJ1MnlzQVZs?=
 =?utf-8?B?VFIwL1FKeU9sY0tJdWMxWUlidmFBaTRNRHdiNVNrWEtNSGJBcmFTRWhZMHQz?=
 =?utf-8?B?MHlKbk5SWFV0Ty9GeW9GbE56ditxZE9qOU84QUE3Y0pJMjhTMWw0TnBiMytS?=
 =?utf-8?B?NGo0aG9oWWFnb29EQ3llTU1Vejl3M01odzB3dWVrRkVaWE1xdDZncGQyVFo0?=
 =?utf-8?B?RVg5VmowdXIvV0VSa2IyVEk5SUI5YWNnaERXcys4eElZcnZLSWRTUUlMNUl2?=
 =?utf-8?B?Qm1tc2ZJaXhvUmppMHhLOHJvVERYM0VIdWR0TXlDaExsTHVWM2VCYk5zeUh4?=
 =?utf-8?B?Rm9IQ0tvQ3hWZFlPZzhlaGVHalVaVU1nZ3dXNU5FNXF5MmI0UWd3TzRWZ3hM?=
 =?utf-8?B?dVZMdi9TVmhzNWllZHFRZ1dYaC9TaVB2aFAzZUEvTmF0dDN5THRjQ1NHZVFm?=
 =?utf-8?B?SFpmRWN4L1FDcTdveGNPL1pXa3MxMEp0aDVFQlBMUXVmeFFlRTBaREw3N0ta?=
 =?utf-8?B?RVdOVHFQV1RpMktLOW1YeHFyYllrZ29EcUpSNFpKbzU0aC8xWktRUnBRc3pT?=
 =?utf-8?B?ZFNDYVBOS0dwOTBvTDBpVnVHVnUvSDBQbFNHaW8zdUtQeExqQkNZbDF5WVcz?=
 =?utf-8?B?Y2hxLzdoeU5OMk9ta3E1MGYreE9MU3JRUFRxenV3STVBaFh2RFd3MnRDaWZN?=
 =?utf-8?B?N05vaEFFaDFuaUQvWmI3WmhRMWhVWkE5U3N1c0pacEhBNDlCZTk0eTR0enFO?=
 =?utf-8?B?dE1Ob3hvYnVkQlVJWFE1clgrRG5IU2RhSi8vNXR3eWZneUhtb0FQbjVIUHdr?=
 =?utf-8?B?STQxRGliT0ZyWmxvNzZtMHVndiszYklXbkRMNGNjR2ZtTzdIcDRZREE0VDRU?=
 =?utf-8?B?ZWtOVlhrRVZXZW5Gc2pKSmJPOWYveXpNRFY4NmFlb0dmNFMwUE5HaG1HeTRX?=
 =?utf-8?B?MXFQOGg3UXlIc0xwNjN5N21FaGdLNGY4dzczTFJmbHZlSENzaWgyZEgyVFFL?=
 =?utf-8?B?YjY3YjlMa3dreE93Y2gydmtvdGZiZVhLVDY1Q29jTGE3OFhGK3FlR1k5VHM2?=
 =?utf-8?B?WUNGYWlmWUY3aFo0U3FlY0RFT1BkbzdiREY5cFlEcjU1VFJNYjVucGxIdGcz?=
 =?utf-8?B?TXArUk1GbktSUWR0QzBweU1jemR6a2ZIUWxLY0RrMVVoeGJucTMvTUFiRHo4?=
 =?utf-8?B?bUxEWW05UGxxV21lRlRQK00zdUdpbk9SQWhoaTZwNlZ0V3psMHZ6TW0wRlll?=
 =?utf-8?B?OVRmeXBhQkJzWktHd1NwNXBmUFlPSGxWZHdjbm44RzNIM1dQYlBtMnMxSkdm?=
 =?utf-8?B?cTNYdDJSSkZuL2p6MFBTNzQ0ZFZGQ1l1R0FWVGZMcHJManYvcU5zL2toSFJN?=
 =?utf-8?B?TDBweFM5WllrQVFKWjVmMTEweTc3cHFlcDlEQTBZSVJpSTJGTUkxMUtTN3Bu?=
 =?utf-8?B?QUlxaUYvcG1SUGtNRTZSLzQ1NDdZOVMvUWxUK0VndVgwcW5ja2NlN1NzSFNn?=
 =?utf-8?Q?ejBpx6tsNtQybATX7JjTeA076FdWJDf/58cq9ePU+c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 110fc448-3d17-4a1d-4696-08d9c161ac1f
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:32:29.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98LZGRDGomaEsjbbb1g6A3iO5YCtG2KidNX32qYQbX9/TC0hHK1piAruLU9m3CeWjW3MV7+0p0htyRGqSZzu/LXZSTbtzHhyjkkqsl9CsIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2353
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-12-17 2:02 PM, Mark Brown wrote:
> To simplify the code a bit and allow future reuse factor the checks that
> values we read are valid out of test_ctl_get_value() into a separate
> function which can be reused later. As part of this extend the test to
> check all the values for the control, not just the first one.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

...

> +/*
> + * Check that the provided value meets the constraints for the
> + * provided control.
> + */
> +bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
> +{
> +	int i;
> +	bool valid = true;
> +
> +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++)
> +		if (!ctl_value_index_valid(ctl, val, i))
> +			valid = false;

Correct me I'm wrong, but it seems a 'return false' would suffice. Is 
the continuation of looping still needed once a single check found above 
evaluates to true?


Regards,
Czarek

> +
> +	return valid;
> +}
