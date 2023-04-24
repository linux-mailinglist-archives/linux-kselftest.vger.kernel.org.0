Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186F26ED283
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjDXQdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDXQdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 12:33:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFCD8;
        Mon, 24 Apr 2023 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682353999; x=1713889999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tdxTcglTkLls0PQMdEpuG+mTNkVNGNfMaqpLIGLR3X8=;
  b=i9cP5hFMsT+OdW/U95/OOaTaYyf/qT02S99MgvXvSQk8j6h1vlJNUMi5
   Ld2GOP4NU23C8cPLwN28rRng7kFFE2kxjX/2lMn0U/3/xYuJHF7S7CvMY
   Y8L2HMXuc9D1CUKMYDb+cFlQqytDSmzW8Wc7t42MaZ0kPbCuneOUWsS8m
   sxt4whb+rKYifBhBhXcDJdF25/QwjEat9cWoiiJLcV9FOzQxmvCIVJwEa
   o7yWf90ypCawpqQQp/BUZ0J/8K1BqKMJWFixqn+D11AfYh5Xy8fUnEcWx
   7rq8fwN/R1OTodHBUNTCZZDuwULeBoyYWNqxDETdlni7BdDmqmRPHS5h0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="348409473"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="348409473"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="1022775885"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="1022775885"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 24 Apr 2023 09:33:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 09:33:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 09:33:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 09:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDSZMwsGSjHYhJTpPAObhl1atFoc+o8Mk6D+zNTp097GoJ5/My0sukGO+roXAZhtA3Eo1WttaBNSf1VHExKbRt31QXDyr7RanBAGmTJoYG2x6SzoLYPfYYjoac5K9lpskxkHq2bwW+IF9swKETM/3cRfBEPxN6DxFoAV5vP04RGJcjPP7p5Sast9XhA42LkO9B3UaSXZJ3SaPqONopLtbxbDHOKsd3TefcJBJJnvJOZLmAxS1jLXSkt1XfjK6TsLexkZ7xYulamKy2vXVnJzsm+YV0hZwQEpDfU9JU+iMHorbM+9q766sgHSzbo396sTb5+d18OD6t7e6snF4W4/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIykUfEb1DnbYLSBtSKvhhLeSdoCcEhHOfma+pYlgFg=;
 b=YGsntFKxHLyxbTJWkX2RpaUSZQdXttJM3COaosHU0Dbcz/aTAc9Zg0K9gj1110VlCnRhLr27qQpm8kT/u8COEFJUlt3XsITf7XC3PYgGyE78TUXUFRsP6Tj0kVl5tQXF+LqqiEBWXe6jkuxybS89nhJnMvZ0WiU0Lo0YnH+tLrQT+th4XB/MTTpItTmE4tJMh1WSZ2s6FE7SWmxXKdDw3Yo+d6kMTd9dr1UGxehVgd+VZpq2lfjnJ5AeTJhIond3pSvSTSn0DTDEgPNzIZDfiBDSBMUOhJ06kmcWLWxb1do5D9RX7hacTIpcra6nTAnepjV+ycMHVpcmlmo4XhjULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 16:33:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 16:33:00 +0000
Message-ID: <7a760f74-6a0b-49ad-225a-f9f0d995fdd5@intel.com>
Date:   Mon, 24 Apr 2023 09:32:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/24] selftests/resctrl: Split run_fill_buf() to
 alloc, work, and dealloc helpers
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-11-ilpo.jarvinen@linux.intel.com>
 <8d6f94e6-4d51-5b96-2a74-2417ffcc0b51@intel.com>
 <a38cba17-77c3-3f81-d4c9-fca839a46444@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a38cba17-77c3-3f81-d4c9-fca839a46444@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c81bed-837a-4872-0194-08db44e1917c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2jCcF0uYjtUAL5uDJLA2jnQkgUk2sRofQlVSbl5DbHg1OXGLube13Fx2/qY5k9J9jIuFt8ZsF0Ah+i8kfwJLJthE18ciecXEfu6gugOj6K4cSyQYKqC5F8z7x8fpwTTQwV5EbAv/bkS6Spx/Uq+RJO21BANh2uM2yABTxMb8Z1RYZ4N6+3HD1VMBKkQx+G+fU5TV61ju+URx5dQ+li9LQ9SLGWAujlGh6FpKh//I4+X60NcpzNheZ5r9/iw3EiMvFt+dIqO5D8VSqbyv0Rgbcjn3F4EMmdtfcIK3RjixVcxx6q1Bd/eawcJZlMqwInZxtuFO61gU1OENrBqQuH3Q2I8cz4fUV1yGLMtXtabzmGvNhocwGa83isLDiqw7Sv016iraMrzoUEs4onfefPnsFiIPUcsQ2H5CNosQ3Sdm82nqjXlkqMqHfIJY0AugnAFClooUwMjyox9TL47yXMAI94eAs4d9/V8ETw1rHSLZiAo4V+aS+VyUumJBe2u2BqIs1uOZHzbUQcx+ECcaqik8obQNTKBaWzxCemZD2ZgGd0ow0NKIJ/hULnaPV0enGz0LrM+xTwQYBOWBrqJDLyLCCOoKAkJUmq0ZcyVkGLItWg0wK1JvdvzgXoEaIaRAcstpDLr75byGs8pXrgDy5APtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(186003)(82960400001)(38100700002)(66946007)(31696002)(478600001)(86362001)(6916009)(66556008)(66476007)(31686004)(8936002)(8676002)(54906003)(44832011)(5660300002)(6486002)(41300700001)(2906002)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExZZDhJdTdpT1pLVTk0WWtOZVlNMWFQY0pjdGI1amhWWEkrWW01RWZJNkc4?=
 =?utf-8?B?SExhdnZLbm5TZGRwamhkaUMrVzRYbURlY3RjQTFEb291MmRTZm9SK1Rla0ox?=
 =?utf-8?B?V2xCQWVNQWY3bEs4NzZuWm9KSU44eFlSR3Vzc2dVeUE2emRyUTZkaGw2YlFP?=
 =?utf-8?B?UjVIVWI0eWlRZ21TNmFXcW1XWHVHb0ZMcEtBNGcrRlNxZUkxVlZNTk9kVGxY?=
 =?utf-8?B?SkhadlQvWFh0bjhYOFhZWnpaYytLN0pWV2U2SW1xenJWOXo2YmlIQkd4UDJr?=
 =?utf-8?B?Y2hYK3lQNzVuQTdHTk53T283Z3diTFdmOXZUcngzU0RsYnhiRWJkM25aM2pS?=
 =?utf-8?B?SzRrK3I1dDFsL0daajd4Q1UrME5KOXNkcjZYZ0Vjc3RtcEJRVEMrRmZIUFZ0?=
 =?utf-8?B?V0VOdHZ2SWlBcS9wZkZsS2prd2N5ZDYwVEpJQ0IvaHNqQ3luRTlQUjQxY2pj?=
 =?utf-8?B?YzFwUWI3TmUzUnFRczJJWHpjdzNQSnVPTVNyQiszTjNucXR0UXp4di9rMHRQ?=
 =?utf-8?B?YmN0c3pCSEFrejI2dVljV1ZnTGx2TmxiY2xkUThiQzRHR0dqL21oVWpDTEtu?=
 =?utf-8?B?b0tDQWdGaFB1SUVnS0RXZWZMUGJTUlJsQmx5Z0FxNEIyMlVHUHh3ZDZ6S29o?=
 =?utf-8?B?YkNHeGpJc0dWekdvYXJSTnBRTjFsVUZoMnRxNUgyOFhjY3JoTjRtUytnQkxa?=
 =?utf-8?B?ZnFIcm1SdUZLZTVidG5Mc2xwM3I3T0xFUkVrbWZ5MkFJb09pc1paSEhCSzNR?=
 =?utf-8?B?QVBDenBSQ0xERTk4NVV4Q0xKbzNjT0h1WVpydFIvVUhOWHRObGdHV3hCL29s?=
 =?utf-8?B?REVQSDd4ckZPVVN2dWlKVzJRS0VEZHdHZVUzRzdReE9QK3I0WmN2aXZBb01J?=
 =?utf-8?B?cnc5a3VDREVURU1DamQ4RHo2U1RKS2hvNmpYMzlCOWExdTJGVFhjV3RDQWFn?=
 =?utf-8?B?UWlOU2lDbXhsR2lSdzMrb2t3YkNaWUZGcnlIYnVscW9oNU5CR2N3QnVRaTZE?=
 =?utf-8?B?YkY0Q2hOV0tzWHQxelc3Visrb1RlMGpENEJGWTB5VlQzbll1d2dRN1kzWEpV?=
 =?utf-8?B?M3hkNlNLODNyM1RiYkZNR0hUcDE2d3I1azVJejlVZ1FSNzhGbURlcU9yZnda?=
 =?utf-8?B?UGQ5MXpQRnlaOXpMMjdJK2JscGh2YVFxcmdYZ002TXlmTEE5SU1JeVgwaU5D?=
 =?utf-8?B?eXBld0FiOU5QZWowQzloeEZ1ZTlWbXFhR1puM1dtSnhkY3VOUW1abDFkNWpt?=
 =?utf-8?B?dlNoK3lYMnJOVmxEL2QvRmc3SnlvUTRyU0lUK3VBc1FFRk43b1VINm5lZHBo?=
 =?utf-8?B?aWxNR1hXWE1UOCszU0V0Z21Hb2F3K3V4WmlKYjlPY09kWVg4Tnplei9jUkpr?=
 =?utf-8?B?QWdLSGkwVjFxK01QSWxyUkZYRFl6NGZSMkh6WTRwaU13UGZmK0pRdWdPNWFv?=
 =?utf-8?B?c1ZpTjRiZkFQMHJuNmNlMGNUMkVuekk4NmVIVHdDb0cwZ3JiOFBwRlUvMTV4?=
 =?utf-8?B?blBqY1FFUFFleCtGV2locDZyNzdNTE1iZUE2ZVlTOGt4TUxLbG0zS0lOblda?=
 =?utf-8?B?dkg2TzhaUWV3R2RZUDRDUGhpdE1nTmVWcGtRUm9relhFTkxVSC9xNmxaeDVv?=
 =?utf-8?B?VFJnaUFXRGJTRGdvaWIwMlhveWM3ajE3Z3NzSHZ1OFpGeUE1UEttVU8xaGZM?=
 =?utf-8?B?Q1JicUlvWEJ4TWhZUjFPejVjR01xd2FxNWJ6WmF3QllqZVhaT2k3SjJUWm4v?=
 =?utf-8?B?TXpHZ3JKR1hoSUJ3aFVuOTQ0ZFc3MTBZMlh0eHRaK3VXZnM3QjBFSTFReGFT?=
 =?utf-8?B?K1loQ0JNK2RoL2FWNWQ1RzdXQkFSbG1BTlNUTmhyZ0NvQ3k2V0prVUpaYW0y?=
 =?utf-8?B?RU91ZE1ocitrK0hnMnZpZU5XSnRuSXJMaUY5UUlvSlNFTmtQZGtsK29raVBw?=
 =?utf-8?B?WTRHdXFNaTZrQkgwVm1CRTd2R0txUVZHbVAxUVZ4UkloL2FEZlZZTGt4Z0du?=
 =?utf-8?B?RGx5alU2aVRMQXp3VTRzbUlYOW1IQTM4Q05DMVIwRlI3MjhIQ0xYeTRwaExK?=
 =?utf-8?B?T0EzZ3p0c1NWMWx1TFg2Zm1jSW40VzlENzZZN3VpYzR4dU92VVF5WDJIUmQ4?=
 =?utf-8?B?eWNJT1p2YzFWangycW5aS1U4UjQrbVQ4V05saHRjOHYvcEN3NHd2bUcxaDBP?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c81bed-837a-4872-0194-08db44e1917c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 16:33:00.4130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJTCuzxSzzMKItxBJ6FixMY/7ipT7MYLFoE2mcC2iwbcUFxoOyHvjfDvDGjA+uq4mGT/jEgl9sBZQ6hPB8oTCRs3uVATV01fN3txnudMLqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/24/2023 9:01 AM, Ilpo Järvinen wrote:
> On Fri, 21 Apr 2023, Reinette Chatre wrote:
>> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
>>>

...

>>>  static void sb(void)
>>>  {
>>>  #if defined(__i386) || defined(__x86_64)
>>> @@ -138,36 +143,53 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
>>>  	return 0;
>>>  }
>>>  
>>> -static int
>>> -fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
>>> +int alloc_buffer(unsigned long long buf_size, int memflush)
>>>  {
>>
>> This can be an allocation function that returns a pointer to
>> allocated buffer, NULL if error.
>>
>>> -	unsigned char *start_ptr, *end_ptr;
>>> -	int ret;
>>> +	unsigned char *start_ptr;
>>>  
>>>  	start_ptr = malloc_and_init_memory(buf_size);
>>>  	if (!start_ptr)
>>>  		return -1;
>>>  
>>>  	startptr = start_ptr;
>>> -	end_ptr = start_ptr + buf_size;
>>>  
>>>  	/* Flush the memory before using to avoid "cache hot pages" effect */
>>>  	if (memflush)
>>>  		mem_flush(start_ptr, buf_size);
>>>  
>>> +	return 0;
>>> +}
>>> +
>>> +int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
>>> +{
>>> +	unsigned char *end_ptr;
>>> +	int ret;
>>> +
>>> +	end_ptr = startptr + buf_size;
>>>  	if (op == 0)
>>> -		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
>>> +		ret = fill_cache_read(startptr, end_ptr, resctrl_val);
>>>  	else
>>> -		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
>>> +		ret = fill_cache_write(startptr, end_ptr, resctrl_val);
>>>  
>>> -	if (ret) {
>>> +	if (ret)
>>>  		printf("\n Error in fill cache read/write...\n");
>>> -		return -1;
>>> -	}
>>>  
>>> -	free(startptr);
>>> +	return ret;
>>> +}
>>>  
>>
>> This seems like an unnecessary level of abstraction to me. Could
>> callers not just call fill_cache_read()/fill_cache_write() directly?
>> I think doing so will make tests easier to understand. Looking ahead
>> at how cat_val() turns out in the final patch I do think a call
>> to fill_cache_read() is easier to follow than this abstraction.
> 
> Passing a custom benchmark command with -b would lose some functionality 
> if this abstraction is removed. CAT test could make a direct call though 
> as it doesn't care about the benchmark command.
> 
> How useful that -b functionality is for selftesting is somewhat 
> questionable though.

I do not think we are speaking about the same thing here. I think that
use_buffer() is unnecessary. fill_cache() can just call fill_cache_read()
or fill_cache_write() directly, depending on the op value. Could you please
elaborate how that impacts the custom benchmark?

Looking ahead at patch 24/24: "selftests/resctrl: Rewrite Cache Allocation
Technology (CAT) test" I feel more strongly that use_buffer() is unnecessary
since it adds an unnecessary layer and makes it harder to see what the test
does.  

Reinette
