Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0458B6AF5F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjCGTmV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 14:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjCGTlp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 14:41:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D8AD010;
        Tue,  7 Mar 2023 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678217327; x=1709753327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o5x4qVav8xPaeplG5M/+TO1baMp4gRCSsS9rn7nwblY=;
  b=Y4KMuI/NggJ+9y9AOuGybwAByMVkIfxAXC6bvxwcU3pa1oOMVa+2m/yr
   s4uK/o6pw+0WFD9IHte5gBwvzL+37sJNYnDG2WeZSv0HLObrgaFyf1W15
   uYPhh8y3N65KiYkxXzjbfjESS7xmumwFXS6X9TJ6s2UR5jIDXRzLo68Te
   s+ssImBrLktbCMWmGxwA7v3ZY1zDl5dXK6+BisBVpuPzdDgndZTzo6sW4
   eK+XRNSGjLcJ7W8IpSdtvEX3+1wnbauFUP+pK+GwVJq1neOTONNS4HXqp
   LehqzymYhhp7R91UM9ut2lshVPqdr1xWFpUk82CcoirZb29P/MGb9PSDG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319779720"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="319779720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819889816"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="819889816"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 11:28:46 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 11:28:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 11:28:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 11:28:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqx2ckziUb5u73xLmdc8p/GUpA8Hwfc5+g8mTRHmI4cv+uDrQ5ze2XjwYiy2kaZdk0iyN6eY76KEE5TP1+nhtouFuZ0MgTaB/4nEhJO6cXhBMqJgFdyTF0eyw60ThpN9YGR8Fplr+PNTBk2eXVTaGosMRKn1sZ2GzSGhhmbMWtRkqA2bk28V2GvY6Rf2xQhCN+Wfb+ZGXPf8YmjNufQzjutrA2wUAetVA6Q0vb56wmh9H3pXsnsTLX+5tsrzliyXdYrl254uTrYiA7LqjC4qabAEi8968F+FOGZsphuuqb8SppNeovOjgSHM4NNhfIfbII+4aYPxrKkqELfe6BPjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5b/uwk2KQFamXRGMywffoyYxUMTw0DhrANUfCiOebs=;
 b=P2xURpqGGYliyBZWUWUHEInrAu7U1O8AqaHxe9iYmPNMJq6xvSzbxuRL2gOJ1VNHMNilYip2jhSCaOPz5vLmUMfEhaUnZD8W17bFaaLzparsclhy6WEiomsnD/Y9sRtV8Sg1O9tFgMf0JFE5M32c/r/c/iOccjwZydhWjP6/5zvoIIKEx822jddcN0lURkwhxU8x+fcI1gVs62P3hs4YhZQpe9Ct9Y2frNGGL+76rBagVLZJXZx5pG4HV45OQVmXtO3WjQ4qseU3Q1Rimyq8X+e9RZqMFo0HsquJcQ0blFuRb8fY6j41h2z5HBeN367LqCZlAvwmO0JpspwNnZHNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 19:28:43 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 19:28:42 +0000
Message-ID: <50a96bb9-113a-cb06-919c-f544f6b59493@intel.com>
Date:   Tue, 7 Mar 2023 11:28:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: selftests: sigaltstack: sas # exit=1 - # Bail out! SP is not on
 sigaltstack - on clang build
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, <linux-api@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Len Brown" <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|IA1PR11MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: cd43c213-df25-4fe9-0440-08db1f422944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3q29H5CGQhtPyUtHVeIQqlvwmSlnuFy13yQt847rSE92Ke28pV1qwDmpL3/ULvsNmJdtWB/e1CqhaqrdWdO5l3OYbGYpjMpWLPRGHxrOOVxFRQAutV5em0jxFYs0vPcGFJqJHs6EnVGhz0hnDFHTp3VFq58cNcoxKkBrvJvVzCVU0FhO6rlTT1J8dlFLqjfNyvTISpxSxWCeE7Brsz6NzE+e0T5/mswWxezC6SnHwDhczlqJ6SQ/qk3+FZ5Qa7au2sZvLqgB3yHHN+ZVN+lsLu7/JJdxFn5ZLw1wwZ5dW8pU1aYBCsKlfG9990Ie4Zo1kv5tkyNt0R2nZb+tNIRZ5ML7dMWuabkUOofneXT6AwGEGLJYAIPx2ZdDCehBOIAYuPWc6hVAWQjPyCLV//OWEczHAqvWkLRkjZlW/csvO7BCqUM3k4KhjXtHduXnsG6zWXVMFI+mJKkpj4GqakX5AL8DrkwzCYgcNp7LQnLBnhTr09dqzDn/maJy/wJV9nXgnmaiBUIr6Vr4xLauVrXtyCDjn41TSa8UD8vbAar/tddUDpjX8Rwg/0hW8Ry6pqphWL9Dym4KL6Zyl/7e8DLveGvO1W8nWMUyGiciFFBTwAIMOVzmi4jhP8SQa5KkHkw026eKBObbqxqHwleCCr9L/0MiT85Lwbmf+33lR92dNuQEY+PGsRoDFaUT4lpBrZgfW6jVgNc3J4mMmB89bm5ltiIsMip/1l7M3+v/PO8KOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199018)(66556008)(66476007)(66946007)(4326008)(8676002)(2616005)(6666004)(31696002)(36756003)(6486002)(7416002)(5660300002)(316002)(86362001)(83380400001)(110136005)(54906003)(8936002)(478600001)(38100700002)(186003)(2906002)(82960400001)(41300700001)(31686004)(6506007)(53546011)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dwL1dnVDV3MmZNQXM1ZFVEK2s1RmxXQW55dnZzR3dwZjh3T1hraHJNRXdN?=
 =?utf-8?B?UkpqTE5ibjkreUdldktZRDk1ejkyOVVrU1B0ZVZNd3k4U20zNEdKTUJaRUo2?=
 =?utf-8?B?ZHhlY2g5WkQweWxLclFjSjI2SXRDSCt4N0dvTVVJL0xtY2Iwa29lVGkvQ2I0?=
 =?utf-8?B?RndLN2NxV2t1Sko4cXczNWZIQzVpbDZYOTJzNEVaUWNhb0dMOG1KL21NMEN4?=
 =?utf-8?B?MmI2UENIdHl5WFRXZFJPeWtHTUJQSWhJSEVwc0s2dWg4ZG9oL3ZiaUZ2WW50?=
 =?utf-8?B?UllleXVGTXNKZ3JRNEE5MklXQjdpc3dHczE4TnZyYVZQNGpMUFV0OHI1eVdI?=
 =?utf-8?B?M3ZYdGV2WHlMRWpLd2hnaG85OTR1V0FUazh0RGlKNHh3c1hQYVM1M1FwaEFv?=
 =?utf-8?B?Wm5lNGZadUJaQUhMczlYK2FPREFNWUZxRTIrekE3czFJYzNqMFNsazEyQm03?=
 =?utf-8?B?elp4UnQ2bm5pMnBpdmxrcytlbVZyUkc5WTZFNTh6TXRUR2VoV0k3ejFrbzd5?=
 =?utf-8?B?U2UrckJPNkp6aWhvNW82cEN2L0l5U3QwT2ZGTWszQXhkbzdqVnJteWU5UVI0?=
 =?utf-8?B?by9aVlNYeFk0cm0yTnQwZTZOYURIVzc1bTV1MEF4N0hzMWlldXZkd3IzVUd5?=
 =?utf-8?B?NC9NS0VYNFJFNVF1ckVESHJyaG41T2UzNTRObzB3N2JCakJQOGcvLzV4TW1l?=
 =?utf-8?B?VUtBMWFNbnZrNkQ1d0x5RnRxdE1QdytoRzlhS3pSVUFMTlV3VGZQYmJoNGVV?=
 =?utf-8?B?SUo5ZEFZZ09ZOXJwWmM5dUJBQ0o5ZnVmcm1UajF0b1Q3c3JZdWVaN3dKRmNj?=
 =?utf-8?B?NTB3Rzc0Qkh3cjExaE52QSt1eG9xWVF6L2VEaUhHQjBkMVNmNWgvN24xTTR2?=
 =?utf-8?B?WmpPSnQvUEdNWGlGQ3FzV2gyakJZM04zL0NKa3JLMDBxZzNCcUo1V2s5VDBw?=
 =?utf-8?B?elFpZTcrbFdGcUJ4OTZMY21IeStNbjJvQVlOcGF2QTdueld5bEJ5d1QvOWw0?=
 =?utf-8?B?UjhRNnZ5eXBkSGFZMFkwQXZuQnVlSzJQUG03ZG5HS2xRZmFjOG5VVU9HRk53?=
 =?utf-8?B?NTZwUmtBRFlROFJGRHV4NWZWazZuaURqYlBuM2tkWHlFU0ZZdmFwZTg3N2tj?=
 =?utf-8?B?TG9ab1BGcjRhVkIxZlBCVE5JbmJoamdGMEJ4aGxCL25Sd1cxaTc3MkVJY201?=
 =?utf-8?B?dlRhck83emVDeXJDREszQS9FblU3TlJBSnYrSk5tY1JYZVNjcFdPOGhvUUlI?=
 =?utf-8?B?Z0RsaWx4b3QrS0N5Tk0vUkRPQW5aZFFuUWpHQm9DcFdHYjJZOXBIZUN3SExo?=
 =?utf-8?B?S1NONjRQLzg0emV2REV0Y0ZrY2pERXpRZ0ZEajVtM1p6bnVXSjB1WWlZc3JD?=
 =?utf-8?B?Z0xBbGFKeHpGUnRSWTlZL1owcWFrZ3NlNUtHcWpHSHV5aUhUZEpIYzFabXlq?=
 =?utf-8?B?cXU0d3NsODRHYzAvU3hDSUtaWlYvcGpzMkpYdEVLNC9zZG9QN2oxNmIwOE9Y?=
 =?utf-8?B?OHNwVnZlclYxVXpaZ2JDQUJwL09wTkR1NjVwdzhNLzAxYkR2aG1wYW84N3Vv?=
 =?utf-8?B?eU5Ed2pKeW5IWm1vZjhLRCtZV0FqUVpiS1N6a2xBZXk3RnRTeitoZ1pIWDFR?=
 =?utf-8?B?T1pZUGJHb29xRTlrWjJ0ODh6YXVIWjBTM3RCbkRFUCtmb21lS0JFeFBxZjMz?=
 =?utf-8?B?a2x1QmpldUZ2U1R2ajF3RGYxUGVGNTdFUi9VMDFCWWhUVHB0dURKUm9HTXZS?=
 =?utf-8?B?RVJPeWpXSVZLQ2p0dEVrUGNpSHhOdlBXRysrSWtIeFBQMlg1R25CLzZYdHhQ?=
 =?utf-8?B?ejJMWHh3OXNYdmlBT2RqcS9FVVlBMEhoWm5DbndDcnVsaEZSdWYrUmkrME1y?=
 =?utf-8?B?QmRUenYwTFFCVWsrcitPdTZMeDQ4b2J0eDVOeTFHMGJWODZRVFpXSCtuYUxa?=
 =?utf-8?B?WXd0VFdyVjVpeFY5cVhVcHhjVDlBS2k4azUya2k2WTQycHBmclNqY0NJWlNW?=
 =?utf-8?B?MnIzSHNsTVRKWjc5TUx6Wkp5cGtDaUZaVllmMFFRUmhmbklCTXZ2RUlDeHht?=
 =?utf-8?B?YkVscWJUdDBnRnBISnpkQWVTY3lISGZoYlVYM1ZZV2Z4M3M4ZEdlZzkxWU9v?=
 =?utf-8?B?eTVRNDBhZ0tZaUJib3BiREdaQmhXOU1xa3pXRDk1cWMxS3RSb0tPU3o4Mzlh?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd43c213-df25-4fe9-0440-08db1f422944
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 19:28:42.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20LyCwNNnXo0lkyQJ0JR58p4lOUgQ4jwu7iETayLF2lUBva5F9KnPnTuNEu+0vWG/OTxKyb/25r+8FUJit6ABya2Pjjo0Bm/YReG5vy/TEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/6/2023 10:57 PM, Naresh Kamboju wrote:
> kselftest: sigaltstack built with clang-16 getting failed but passed with
> gcc-12 build. Please find more details about test logs on clang-16 and
> gcc-12 and steps to reproduce locally on your machine by using tuxrun.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ----------
> 
> Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian clang
> version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
> Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
> ...
> kselftest: Running tests in sigaltstack
> TAP version 13
> 1..1
> # selftests: sigaltstack: sas
> # # [NOTE] the stack size is 21104
> # TAP version 13
> # 1..3
> # ok 1 Initial sigaltstack state was SS_DISABLE
> # Bail out! SP is not on sigaltstack
> # # Planned tests != run tests (3 != 1)
> # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: sigaltstack: sas # exit=1
<snip>

> Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> for Debian) 2.40) #1 SMP PREEMPT @1678159736
> ...
> kselftest: Running tests in sigaltstack
> TAP version 13
> 1..1
> # selftests: sigaltstack: sas
> # # [NOTE] the stack size is 50080
> # TAP version 13
> # 1..3
> # ok 1 Initial sigaltstack state was SS_DISABLE
> # # [RUN] signal USR1
> # ok 2 sigaltstack is disabled in sighandler
> # # [RUN] switched to user ctx
> # # [RUN] signal USR2
> # # [OK] Stack preserved
> # ok 3 sigaltstack is still SS_AUTODISARM after signal
> # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: sigaltstack: sas

At glance, the log shows the altstack size difference between LLVM and GCC.

But, when I tried with the LLVM that I have,

     $ clang --version
     clang version 13.0.0 ...

it failed only with this compiler:

     $ rm sas;clang -o sas sas.c;./sas
     # [NOTE]        the stack size is 8192
     TAP version 13
     1..3
     ok 1 Initial sigaltstack state was SS_DISABLE
     Bail out! SP is not on sigaltstack
     # Planned tests != run tests (3 != 1)
     # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

     $ rm sas;gcc -o sas sas.c;./sas
     # [NOTE]        the stack size is 8192
     TAP version 13
     1..3
     ok 1 Initial sigaltstack state was SS_DISABLE
     # [RUN] signal USR1
     ok 2 sigaltstack is disabled in sighandler
     # [RUN] switched to user ctx
     # [RUN] signal USR2
     # [OK]  Stack preserved
     ok 3 sigaltstack is still SS_AUTODISARM after signal
     # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

The same is true with some old versions -- e.g. the one that came with 
commit 0c49ad415512 ("tools/testing/selftests/sigaltstack/sas.c: improve 
output of sigaltstack testcase"):

     $ rm sas;clang -o sas sas.c;./sas
     [OK]    Initial sigaltstack state was SS_DISABLE
     [FAIL]  SP is not on sigaltstack

     $ rm sas;gcc -o sas sas.c;./sas
     [OK]    Initial sigaltstack state was SS_DISABLE
     [RUN]   signal USR1
     [OK]    sigaltstack is disabled in sighandler
     [RUN]   switched to user ctx
     [RUN]   signal USR2
     [OK]    Stack preserved
     [OK]    sigaltstack is still SS_AUTODISARM after signal
     [OK]    Test passed

So, this test failure appears to have been there for a while. I think 
the LLVM folks need to take a look at it.

Thanks,
Chang
