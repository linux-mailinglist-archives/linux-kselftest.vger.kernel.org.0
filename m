Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41C63DC02
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 18:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiK3RdM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiK3RdK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 12:33:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697EA1C93B;
        Wed, 30 Nov 2022 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669829589; x=1701365589;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eFZz6Tc1stSee1OajKF2RnsA+6iida4yOtGY7xiRU8U=;
  b=XZLvn/l9+Vmpy5/mV2wz+fiaGMZZ5CgircdD5N5R1cjcvXnLyBI/2WI2
   TuQeKXsxItha/SqOy+jRRDWDeGtv6NwhdY9FloGKQD66lcq1kkU1IfOv+
   VxgysJW6bRKcwKv8LOQUFMqXjvDg9/XDcvjBaoOIozofCSnr+2jAmqgXw
   UHEcoLlaNFr6rKjtOeTSqRRgS9embTGmTBRFoq31tcxmYGtdX0cOKcVpx
   aojfM+kMD8uDB/MMjEp5ygLKm5tnD9G0Bgcl8C8fEVcpG0cMvdjAhZgOj
   GvBlEKUlbp1Z1nll+fRG1biotSPoHtxKV+DdyDa/Vc7navlWPuvhR9vX4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314154979"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="314154979"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 09:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="889373087"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="889373087"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2022 09:33:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 09:33:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 09:33:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 09:33:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 09:33:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Kz3J6rxNlFcpt9D88196dm8mUt1oXjMyuXtcZth0JQmTBeFBtWNBfzsVwx7uIlKeGEPYEzTYyp49FhEJdrI+AcDxxwfpNyEdMoeD5fWw13mtNESJBdhyID73LEOk61EFNap5AfSkkt5rO4BbScGo/18ab/7PUDeogJat6s2MWD2mVgI3i20wnXJcummaPZ4g5am9odWG/fCfOY3JL8U55Le61Ib09gUwmMoMnLWTlFRB9AaqSE0il+pEeRB0To+9YkNNzD1wv+VsppoIyOXzShVs3AHHZqNc19gvC8ZN3SiV17pgcjC5gZOPygq9Zo7dtt7QH1pe/3fXZlezONPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPISiW88B7EGaheWCsa8GXGPnNP+lbZ3/NHZ0xCqXdA=;
 b=MNHVyja0SH4rK/jX9BhEaPFV2w06skUtUP5QL3fGIvQsIrt7Ih5TH1l+DXUNtK6z7dpraVZUy2a2ql+iWSqUyIuiiCw0zsC4+9u9e0K1G+jbTgStn4zqJ0nDrsZOxx12pgjqbofVBpnA4GE/j710uwL2E8m8RWIwwfNd/S2ABH5fk2CRvpUu1ob+2ipY0xrNwo0d7h2j2ZgnHNk0h7Y2Y/adRMqqfSEOubTMFAnPF9AEPx/fIXSVoU4bqIOBYlsfQ724tDOqEJjLwZq2LSmdqlKHnfmtz46/Y9BDP+PLY9FW6hAEHQ1o9w9X5G9nwEy3WwOYoH9jLzsatD3yAombBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SA1PR11MB5875.namprd11.prod.outlook.com (2603:10b6:806:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 17:32:57 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 17:32:57 +0000
Message-ID: <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
Date:   Wed, 30 Nov 2022 09:32:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: fw_fallback.sh test failed in Debian 11
Content-Language: en-US
To:     "Zhou, Jie2X" <jie2x.zhou@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|SA1PR11MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b96fc0-fc0e-46a0-ce5f-08dad2f8ebb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMZnZVZzscUAhE2Pqq1CEowiszKJALFVn2SJA+Gsao5G1BStO/o78msY/iBF2YXyxsYQ1CMF7UM7lruAhlOlgFjacdJx7Vi078RthyCEMDYVGNnVNYCowMjp64zDxLz4tIra1mf9oKeP/UDhUPMrAmse2qrc3VxInadJXkbmn3Ga6b7I+lIsr/D4W6PjWcOHb3W8pZQQ1QqsH2ZpGWdZDjb2Cg0R33v0fSCya9/5W2qsGo4QV7LkO4RLQHLrrMzuNWmn5AvKZVz/OPXrwy0KYWO41Me3chCrVxjdMrxpd3HaPBTqSM8hJoXEi+ih+MdQSYBAT1NDLKnETSpuzbDi4BIZo7ID5L4K9GYqEd7HkH1WarHiRHzBDrv3qh5IxZGeJzrU8WlwF+/CimYSpusvxJkgsXjGWIqOwBT40No9FrdqSiPeiESb5XqWsPWmqtLCtfFuqgjWGckWIvBR/TRJT5DP+xGADv0jUC9GlURwHU95KOcklhfSBK0biw0w6gRrj5UUN/5wUilvfQRmi6ge1xhx6lm58LO7zKS8n/l5n/0cnRdUQbCj2UxonBcs2dxTB/RX0K6JhIxyC0S8kuX7s+QHGbkRvDalSoN8zeUMxKrf44abggk8QkbefnsHWGXId95LkUUmv5p3u23iHKDGJ/p15oC0VLevBXRZQ3qnr1Fnl5v3Z7MLcPd7ml94AOl1/pXy8JapPNO/4O5iG9tO2N5O2LCV2/j/HyzFuM5LdsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(53546011)(6506007)(316002)(66556008)(26005)(6512007)(478600001)(6486002)(54906003)(110136005)(4326008)(66946007)(8676002)(66476007)(6666004)(107886003)(31686004)(4744005)(8936002)(41300700001)(5660300002)(36756003)(83380400001)(2906002)(186003)(2616005)(82960400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9HRG8zWGx4WTY0Y3RLM3dBQlJkVnI4b1dkcWlwQXU0VVAybUg5b05CUmhI?=
 =?utf-8?B?Y3lyWVNIOWIvS1FlYkw1OFo0RU9uenRMR2xlNW5EZWdSZkFaSEFiTzZyR0JZ?=
 =?utf-8?B?RkxMNXNOUHl4QTA3Y3ZxbEZmYUlaK1pENGVuc01tMVR2ZGwxRUgwOGMyTW5k?=
 =?utf-8?B?bEFLMTJuTUcxOEhIeG4yUHAvemljRTBQcmdVcnFabklSc2xQcEw0eFgyNFVO?=
 =?utf-8?B?TnBvcXVEVmNIbmZEWEd3ZEUyKzJTclFFem83SCsydXlpZFdaU0g1cmN3dlFi?=
 =?utf-8?B?S09uaHFuZHI0Ti8wUHFVNU42dENEU0c2ZXZGMXVFalhEUXJxOVVFSTNnMHRG?=
 =?utf-8?B?bUNQRHZRUDM4bTNGWlptblozTTNWMU02Lzh0eUpIb0JFODErWXYzaDlQOFl2?=
 =?utf-8?B?c1NiV3Vkb1JhaS9xbzAvcDZpcmtJQ090cVRtMklkODR1eGsxZ0dKTnlZR01w?=
 =?utf-8?B?dGh3bVFFdk9iUUw5ZTZDUkdPaDM2Y0w2eDZDdGlmMHVLSUVrcEpSUDF3aDk4?=
 =?utf-8?B?Q1N5UUU1L3N6UG5yOVBnVUdVZ0o1SXFCWTdBaEwxanJPdnlVQjNma1kxTlNU?=
 =?utf-8?B?b0s1ay9yakdaKzB5Y2d6YWJ3WnNTS2FVbWQ5bGZBQTJTUmZzcjJheHVMeTFC?=
 =?utf-8?B?SjZrTUpOU0FrUHl4YWE3OEtIamNrdk5tZERBd1BvRUZDdjhtSjltR1h2VW1T?=
 =?utf-8?B?Z3kyQStDTHJPVnluSmx5WnRGK01pYVJxcUpSNEdqZUNBN2o1NEJUNDZWZWRX?=
 =?utf-8?B?ZUVSdm9JYU1lWlZBbzcvam05TWhkQkIwMk1XanNqdm0rZXFlMlpURmpZVVlx?=
 =?utf-8?B?WGM3ZjR5YWlUa01oVHJwU1BtKzBmcTNnbHlnT1BHN0N1bmVrT21yUWdJM3Yv?=
 =?utf-8?B?czVJUWhrYUNPZUJMcGtma3BqNUpra00zalJCUE1ySHRDa0tUeFJzRGFBNkNG?=
 =?utf-8?B?SVcwODIrQllTb0ErTWpHbFkxNHJ4SFVVZGZCeW5LSEZMVDFCZ2lYdjJqdXdI?=
 =?utf-8?B?YXpZcGc5L2pGMFFZT3pmd0FnUjNtTjQ4OElmaUJwckVwRWNFWjNZV2EzZHVN?=
 =?utf-8?B?eXVmbzJwYXhZNStWSHBOanBKZ3JtODRUSERHMXhERHNEODJocVZyWGtma3ZD?=
 =?utf-8?B?a2xlaDFrWWIwdXdnTm1SWXFIU0xic1pneFdvRW1yeTdnRkFpUy9UK3AvdFBB?=
 =?utf-8?B?R3RBblA0dlIwVTAzdUgrWk1iVWovWEptV1VKUUtqbGU4L3g1NWpDMVAvRm5o?=
 =?utf-8?B?SGM3cEFndmg4TVRON3laT1NjQVJFcU1Lem5DNWFlYW84SVdkUnlScnpIaFhH?=
 =?utf-8?B?ZXFYYnd4c0ZGelBRUktwQUxqK0diNVh3OGtqRHVwTC9jY1FBR1BLWlp4U1VN?=
 =?utf-8?B?VnZaK1MzRWlvdU1ieGtqODhLNUhad1drdDFheU1IQ25RRi82MEQ4akZLQlA1?=
 =?utf-8?B?bmlPOTYvN05nVTl2eGZuVHA0S2s1MTA0OUw5S0VLZ3hWOFVGWktaWmJCcTly?=
 =?utf-8?B?QWVSUmxkcC85dVRrQjNvM2V0OTRoN3h2WGJzbTBrdndjODlLUHRhUDlQbTE4?=
 =?utf-8?B?UE5TTzdYMVFnLy8yYk1oVElPNXNtYXdXS29KZUZxWjRJVitFeVN5eVdpeWRF?=
 =?utf-8?B?dTROTlFGeGRkWVAwQmJGL2hLTTlNTFh0UWtFdzJPZ2FLejVUSXlKVW9FZzNH?=
 =?utf-8?B?ZWNQNHZuVC96NUdlaWVnNVlwR01ieDJEcUl4Y3BUV3dJdHU2QldPOVBhRWZK?=
 =?utf-8?B?c2tmMXBzaGsra20xOFp1UVI4c3VyM3M3RGRzVzZCQmlyU3hmamhVSWI0V3ho?=
 =?utf-8?B?VHVGVk1qWElldmNTZkN2TGxmcVRZaUJodnNyeUJxVXpSNTR6NU9JZmp1cUFo?=
 =?utf-8?B?UUp0cjVEcE1KTjZOeWs4RXBOeU9PYVpOSEFyeDRlYURIU29qc0JZVUlQd2hR?=
 =?utf-8?B?K0Q5cEhpWFd2dWV6ci9La1F1Vk1vNm1JUFdsODIzSlVwblJ4bWMrOTQ0M28z?=
 =?utf-8?B?bVRKNXhCdWNnSWdscWNwYlFYZG5PNXFvenVNN255UDM2U0dEUTZlQVcxS1dw?=
 =?utf-8?B?U2FqdFhnYjlBZEhjS3hqUVhlOTFvdUNsYS9NbW5CMWFIekVGV3hSdit5V0hM?=
 =?utf-8?B?dWZLNFY1WU1kbWtSTjZPV1JCYURIYy9PbFB5TkEwOTg4dzdpM0hyOUNHSHpr?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b96fc0-fc0e-46a0-ce5f-08dad2f8ebb9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 17:32:57.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3xeTORiAnLMh8kWdV5ffKfEZ1qn33xsJX8UwE34mw9pYE2Mx+z5+RO1h1dH/GM08gNN66gzuTZfQbeO/UvvXqD8I/zl1gUsi59q16sGj4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5875
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/29/22 21:59, Zhou, Jie2X wrote:
> hi,
>
>> Are you sure you have the proper kernel code loaded with the test
>> firmware code that creates this sysfs file?  Without that, this test
>> will not work.
> I checked following config options, and they all enabled.
>
> tools/testing/selftests/firmware/config
> CONFIG_TEST_FIRMWARE=y
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_FW_UPLOAD=y
>
> best regards,

Nevertheless, the error message you reported in your first email indicates
that the test_firmware device may not be present. Did you verify that the running
system reports the expected configs? What does the following command show?

zgrep CONFIG_TEST_FIRMWARE /proc/config.gz

- Russ

