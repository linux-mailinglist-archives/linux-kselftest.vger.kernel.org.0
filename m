Return-Path: <linux-kselftest+bounces-2522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8E820028
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF228213B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059F125AD;
	Fri, 29 Dec 2023 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXHeCZXK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7A125A5;
	Fri, 29 Dec 2023 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703863192; x=1735399192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BUEddKaB0Xdk3qAFinHGXxP49al3e5WSi9oCKlU03yk=;
  b=RXHeCZXKtaxk7oCH58gtxC5G8nSczO0qWm1qO2glnE+GjIf1OUCrjpXJ
   wTizXHpEEh1brpdnV3YqPpDycavbn3oP9ltdukVbLd7b5j1NEA4qTJQm1
   4257Y2EdzuKzWwXBPqiYfIvKLgdi/iDVXFOORMp4C4xE81VVFWwdwYLXt
   FwvTs+pkEUgSuiTMpgIRRpcj4smu7GYFnbLkZaDMhyZiCH3NyAvsH6a2O
   5u+Zt57gBwZp8IZp7NrsXMuQFnFyh9mqkoerHYifNezYLzdDaVAWSfn2j
   3qaAdVoU2Mr6qWySHZ4O1g4xpD0HP1v73nqsVNTEGV1rPQd/+CQyNiqFN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3955242"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="3955242"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 07:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="897534824"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="897534824"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 07:19:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 07:19:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 07:19:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 07:19:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kblq6qPKD4Ud9k72YbrjPULEzvdbFsX4vMH8z+K45RS6oAe/BvaknZK/lEzyprMn9eIUunyySaStg+k76KAvW3bVbJZXdgdUmiigWUQOUBYUNHh3oZXOQbt25EF6ARcEcZGGZ7plCMlXU+fCmI1Si5Id9VMONFg2fqkUnCyQo7Oir1YtLAeQuQffJsOtiWjx4qtGcpjco67u3byn2iq7zTEdfx6Sbrj41U56TdhHkSR8Feq11kxC5kwrdh0ao7iOgtYeAuPdWE6J8Sjsg77brdMkLUVbD60qMuUGOdHGTwiMMNbqka9KY764atMQBqQFlmcxfkUju7o1GfoxkrIQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36JCcfaCHWzRxn+g731Tt0+AP3k87SboeO0UEqVPDs8=;
 b=nY8/nnRAzAcM+JZeNk+94pkKSYsswg93x4yPSjfV//Hz+alnmxE43wmfihaY10vR78LuyGHCIPfpci79R+gfEWPxSLO8jkQgYHRrpupVfZVzNNYTDduVOk5uN7tgM6emVK1Em+l1C5ejIfigKRnaZL2H9Sm8cPhPP6w4Yl+vPN4fNH2kaTJ668smi7tdjj0PfjpAUJxOakmJzmGOmPSuPhveV7KG8Rg6US9H5ETEP2dBtiHVnRG5m73TeoB5Y4EU59L+KblW/sJ61yCOmBa0ZVavE/ZVN29i0mRbPwIskAYLYUwIYkgwIip0yS9Zmz/U5u/HCs9UKpI6u8536K25LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 15:19:48 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::ef7b:6435:f727:4d5c]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::ef7b:6435:f727:4d5c%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 15:19:47 +0000
Message-ID: <912e8ffa-364c-1ca2-6bb7-803902a3fd6e@intel.com>
Date: Fri, 29 Dec 2023 16:19:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Content-Language: en-US
To: Yujie Liu <yujie.liu@intel.com>, <netdev@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>, kernel test robot <oliver.sang@intel.com>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231229131931.3961150-1-yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 69989f9d-9146-449f-7b25-08dc08819821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfAjbhxcDz4Alm66aA0f6Ggb8PL38Eg+865+vo6HjL5a7X9QSQ8mO/EjwMuhYofvCe0RV5ZEs7LAuqPfvx66Rh0XXv0tTVYIKwPWZQeAaXUFDanPrgEKiWiDSNztaloLj4Zxl60iSk5cXa+u2JSLjsj+j2A9Q7C8NfV5enu1FeSWg2cn9Q7JKsXme6weF5Kd/Wo75fIZl+qYQ5LMdmw5oxxWa/0Te08Oko4bxltreoGuSXRbvC3BmTB0zB1iM4p3in8oyVFhS24Y5sGrNucKP+liQicxvmT6OOdblXqlVtwXDS1EcudaisvO/rMkyEqK9JXiNrcOI6+VdX3ETnCiUDLoyOfHbs8HzCATkNVEA7qAqiNEcWJD16GBjZYrdzVFxOWpfltDcZBlVzsgS6UKRg9WvZNCn876hR8lEO+25yCGaVRF8ouUCtV3chpqXdqWq/08RxwAxIHxgulWVZBIzLgKbhWgyEMbyyFZnNlk262UBbys0tcvyufblsqsf1suYA0ZX/sZff0R83BVC2j2M/8U0D5v3qZmhoq9SruQeDzRrXn9VDMxpZIOLLGstTrxpkxQFVwH+wjSDUaFR4GSU9NZZ0pV8VH8l54m7RsSvC7QvoptAXbmyslve+ov2wtJy32Jin14ptAgoA9+rVmdTA70EUKhG3JKBYhcEqdbrknReDBHkZEs1W7I5nrOIrLc35S/D9L0HM9Xj6sIi9FPVDIqj1jstvWxPlRw4dxtmAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(53546011)(6512007)(6506007)(478600001)(110136005)(54906003)(82960400001)(966005)(66556008)(66476007)(86362001)(107886003)(6486002)(36756003)(31686004)(26005)(6666004)(66946007)(316002)(31696002)(83380400001)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJtak9aaTB2SU43TVFXc29KOXF6ZVNKVlJDZmN0TllzMWE3dmczNVM5QlUy?=
 =?utf-8?B?VElsdWJKSml6RXc5TlRoV2hRQ3AzZVlLU1c3ckw3TzYyVkIrS3U2L21tNXV4?=
 =?utf-8?B?SkJGRnZSemhIQjVGMWNHMWdWbzlJcVN5T3owRThMSmZrOUVzRTNKTm5xdGxN?=
 =?utf-8?B?U2loc0ZWYTJveCt4SnlhR01NeDUvbXZtTEFWbVpZTVNHYmovNzVrNzFwcWRZ?=
 =?utf-8?B?ZVlUMGJHcmM3NitKZzhQUUYxUFowUDk4dXNKK09UVzB0cUpLeWJHZVJLNXY0?=
 =?utf-8?B?M1JmZVhPNzVMbUFZV2ZGbEF0TlRIZ2xnS2J6bnU3RHJLcGNRY0l0czVRZXM4?=
 =?utf-8?B?Y0lFdXIvVnZCZVRKQUp1TC9wc1ZYSEloVTRZc1JuczdlenJER21QbFF5V01K?=
 =?utf-8?B?SnBFQ2JHa1FSODkxUFJJdEk4N29NYlVkWU1kSStNa3ZIODZtUmdBNzcza1VM?=
 =?utf-8?B?Y29sNExTQ1lMUE9vZ0MzSnBrbG1ZZ1E1OFJNOVlXRUI3SktRbWhSMmVid3FV?=
 =?utf-8?B?bW9NUVk1TDlyQ0lUTXA2WFZDOXR0cDBKVEx1YWtWU29HLzl4T2JaUGR3SjAv?=
 =?utf-8?B?UUFFTS9BVXY4UVovdC9SK3JrdnZhSXVEUlVLVFJqZG5yYVh3UnU3bVNNTXFr?=
 =?utf-8?B?a2ZwQUxFUnJIM2liMk83NTdUWVVpYi8rZzg0OU5TMVVvNUZJcFIvM01MRjM4?=
 =?utf-8?B?UzJydFQ1b3JhU3E1TURuNUs1YWpocmNVTytJRS8ySjFnZ3V3eThPMExvK3ZZ?=
 =?utf-8?B?cjF3bkxwUE5xalhibStKbllKQUl2R2N4c3VmdS84a2FoMzhFOU8zQWhpSXBa?=
 =?utf-8?B?QndpN3ZDR1d3bHhBSU8zZXVRT3BlRC83Sm9vbFRiTGpTQk1oZzc2cVNSWlBF?=
 =?utf-8?B?RXNqemM1RzIvZEhVK050OGJWRjFWYVdhRDV6ejlrdGxUbHU0TW5IQ2xDWGdG?=
 =?utf-8?B?aUF1M3pDSG94YTdvU0JOU2VwYnpjeGpUeU03S3BiMkZJQ0l3ZnV5amY0OXF2?=
 =?utf-8?B?dE4wMzhzMTlZbkMxZlZXWWdHcmIzbTFiMkhHVW0wMHErQTlkT01JVGFkeGpH?=
 =?utf-8?B?UmR5NTFxb2k5bzNtOVIvQU1sdXJzZmwrekFMdzRweFRLY2EzVlhKNERNdU84?=
 =?utf-8?B?REZKWG4zRU56SHpnVjhMbTZsZ09qWXdqZGdrcTZlQWNNNWo1cUVZUTRta2xq?=
 =?utf-8?B?ZHplRjZoVzVzZ1pCdURrRURaQ2hIdldIcUNsNXVHdUZYWVdrd0dMVWxUUDFt?=
 =?utf-8?B?amZ6K01rK3prQmVBdnNsaHFueGxuSmxoODdMVG9URVVES1NibzFKaHdjNzF0?=
 =?utf-8?B?dmtreXhMSy9Fbm1xaDRqM20remVrOThlLytrK2R4a3ZBb1VTMzBWb3IrRjFF?=
 =?utf-8?B?SHRadUp6OVhLQXlsZldiRnVuMk8rVTFDbnlnaUw5bUh6bFdVcTlvYVR6OWpj?=
 =?utf-8?B?MW9TSzd1UERRdmxsZE4vc1hUb0hEOWRpV3pnc1p4MjNlbytIVFdyanlzY2tS?=
 =?utf-8?B?NWg4SkxiOEJDZlpwdlFoREcwbDdiUHJFZmN1aFVqUGQwOFRjSWRTcnZlSWRS?=
 =?utf-8?B?cGhPdzgrUkcxUHBkZlJzMUxHRllBdjMreEJvOHBQQVdpV3NjNXI0NTlqZytY?=
 =?utf-8?B?cklLOVptRWNlSFc1SW5mdkQwMjY5WDNYYjlrV0VDcFRKNjZrNWpzSFUyZXFz?=
 =?utf-8?B?RkJGdUVHeDFUbGRaRWlVdDB5TG54aFZQaXFsS3o0cjkralFVS3hhdlo0aDZ5?=
 =?utf-8?B?bWx4THZqZFZPQ3huNjhOeDc1bmNraGtEM0RWN014NzNJVEp1Wi8raTI2ZjBs?=
 =?utf-8?B?b3FCS20zNjlQa05QYXJIdWVyQ0UrekZKYXFRdkF4MnpNazlpeDFGT0RpQ24v?=
 =?utf-8?B?aTJNcFhxai9vOHNPTTBabm9DT3VyV2hhd1BidW40WGMvb2dPcnk0QXRGZWpZ?=
 =?utf-8?B?aUZhSkRqTDF0aGhhbTNmQWhpSDhCOFdJVmtTNnpYVmZ3SkxWcHRad2g2UGFi?=
 =?utf-8?B?a0czU01qd0QvNC9LQldkdEVVOE1XdXZoM0tHNm9COFB6RDh0WE5VcEpTbEVC?=
 =?utf-8?B?dDZyV2tvYUF2b2RjZHB3TjQxK2F2dzdCWFZDQ1laTG00dUQvZGpiVldRcXhW?=
 =?utf-8?B?VGY2MnZjeFpHZHdpcUNPWUhISGltMFFEZHdnMk0yMXJxaWt1aUJhVGlhTEcx?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69989f9d-9146-449f-7b25-08dc08819821
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 15:19:47.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8kAa/ef40+FUWGyxO0PPQUnh2L8Xd9ys0LXs5ILF5UAM2ucj0b6E4EUk2CELcUg5Cms8A74RYIGu9KiQ8w014VZWiwls5yIicUy5ucG2p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
X-OriginatorOrg: intel.com

On 12/29/23 14:19, Yujie Liu wrote:
> The patch set [1] added a general lib.sh in net selftests, and converted
> several test scripts to source the lib.sh.
> 
> unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> have a /bin/sh shebang which may point to various shells in different
> distributions, but "source" is only available in some of them. For
> example, "source" is a built-it function in bash, but it cannot be
> used in dash.
> 
> Refer to other scripts that were converted together, simply change the
> shebang to bash to fix the following issues when the default /bin/sh
> points to other shells.
> 

(snip)

> 
> Link: https://lore.kernel.org/all/20231202020110.362433-1-liuhangbin@gmail.com/ [1]
> Link: https://lore.kernel.org/all/20231219094856.1740079-1-liuhangbin@gmail.com/ [2]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

I would recommend use of shellcheck in the future, it will catch this
particular bug, with following warning:
SC3046: In POSIX sh, 'source' in place of '.' is undefined.

Being specific, and requiring bash looks fine for me.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

