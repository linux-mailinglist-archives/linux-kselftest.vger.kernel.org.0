Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE11E63E6C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 01:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLAAz4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 19:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLAAzt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 19:55:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E708DBFD;
        Wed, 30 Nov 2022 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669856148; x=1701392148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ntL2cHTL2zanK1cjiGm6xGKBls/3eHeW85KlSz3B3JU=;
  b=bBxFje7biHqON9/3n3lYy3SixiucGS6zn7oOsU3pyrcWxC9pR/llTQaz
   Y6S+kPn4elJfHWpDNp6pKsySH80BqMG5tMbpBO/+gsr9IIAzJy87e2pvz
   AWkdyZw/7DdgXVaoKfnhD0Uq6XSrSYBnDTkeI/JWQlLUd3n9JXkzARskU
   X59wWc1mEzLhqmnWixhuYMf3Ql4V5XLlXZqQHq9NFWV9G14aCxCvxU8rO
   H+B3PpxJ0jJuJBQbELIbMJ2cdL5+w062d9Fhp4kO0IbGfeAFMCCm6N5sy
   rLzdzN49yXoNHYPaqCbko7zQj0DW5lasyuO3F/cYZuDULciI829VObQ13
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342478567"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="342478567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="818840703"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="818840703"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2022 16:55:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 16:55:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 16:55:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 16:55:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 16:55:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzQZwEwkZLAf926MSEG8sJaint7/eIia2su0OyBxCLVIsF6368Suk0Chmgu2SFgzShStD8GbOAFjfuuPY2vipyzeNqZc6GDDKLdUFIWtHumwN4f8E+mHLw4iUcmeEoy03Pp/izfiiKCDMIst3np9thlWZU3PSXoz0ai2Q+BBwIAhYUfGVAmSipR7e7PaYFFyklRbz9Xy9vXbjl6rcXBkUR0xDKlOpKrY0JkmCxOQTU2tqPl/7tKvMgIbc8CLoMfhFGhgReHw+pAshxV6t+CAUw4Vx7q+DznEaqJcBtJC2sRf5PYsNpdlklrfMqpEKCJ6ZsFLn0eu3Fi6diY5x2kutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NivyM1bnvDtQG3qtYdBrXqb5TI2zeGZtidosEVo3vuY=;
 b=fc0QeW+RL3fCIHzPrvr74EapCzY4FP31oJR/2/mMeqLSA1NxAtjc+uO1aKnZW4XENvfoT3Xfcct2ZZziLzCKp6nBeXWi1fTlOjPa5BUaYWcelQBsbYuukdJQGkfl4zqng1sxpuSQaHL2bR5qFz9ZBIQm9MeWOzwWAY6aSRvIQ/H65A2wYH7uU7XOWI/Z2FyvSg/f0yWaJVp5MByTCPFB3cG3qlWymxDGTSlEq6SiSZBRQLzap2KJslzvHvnbru20ngTwKqhl/XScgrJZGCzSjeY3Cy2VZQF5277v8p7BRDx+Or82X8FXjsmnZ+RBCtEtH10htl9dQplzXOdv/MIjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Thu, 1 Dec
 2022 00:55:45 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:55:45 +0000
Message-ID: <217b7959-facc-1028-19be-1040898a705c@intel.com>
Date:   Wed, 30 Nov 2022 16:55:39 -0800
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
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
 <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21)
 To DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: bdde4a17-e9d9-461c-bc51-08dad336c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZ8oCu+982zfu2Y1su91qts8ZgNaMzpsevngmsstxQkbaZ49cD53aeGzsDRmQb0SsERuwnZRbJdjpYPVsIerlv/MmPe7wlv2pJcW5Y0p0MZafTyVPobPu86Mtd2qDikAcroeZygb6q8XDuJMVSIxwOBd28pmzCdplSzZX5Lp7P+WEKiCb5E2fD7tGNSvo68tb5Mfja+KKGwwatweSsTeOQ6pr1bK/LtZ1y8M8E9B8f4gTW/QDjsJgu3n4+zZWIOvhDwvo3JfU8S1WKGcNpC6AtCZPQuuvqEwmlb/mADQUm0HmDEPnbq7Iu+LZgKAu5UliGxqXu9VRovovSITlxOikX0tqYUj5tBfiUT2M2T7PpT4KH3DNYox2BLkYRdCuuZgxW8YYtrjixGqU61RK0l9htWCHJqyIhq6Un1IyezGLcfn5hdDpxzT2P4O3+YZfHS4TLRAd4m7PAfE9f6rPCfAhLj3Xi86WClLZZZsHno5G8dz41DpZlNXhgRfN5ZtRS8IYfuopeny9nkdtW09RwlIl3TDHvtAlg1UvDvAyKWMEwtawyYHY+UFHPWCxECAlBK8wWD6qzO5hGAS7cSwMeEKuegpCDK+jU49xWNN6BZPAHjEj+BY3dgtZkRXLyknsoXcm29kIWbuxta+Aso312SZprZbSQPqSpX0zPI/Gjz5Jkl89PGKf//xWBSFF6HuBqJibklZFAZQ9Wu/1BVlywz18Srp5/j/spSSyWhnAfExfkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(36756003)(82960400001)(38100700002)(83380400001)(107886003)(6512007)(6666004)(2906002)(66556008)(316002)(86362001)(26005)(31696002)(66946007)(4326008)(66476007)(5660300002)(8676002)(41300700001)(2616005)(6506007)(54906003)(4744005)(8936002)(53546011)(110136005)(6486002)(31686004)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpud20raTFzTHp3U0x0ZXF4Vy9QdUE3RGxaNXZCSVcyRUh6REl6YTlTZzN4?=
 =?utf-8?B?b1B3S2Jkb0lGaGZuOFhYdzdKS3NMZG02OHAxT1E4TnVxUDh5cUd4dkRaTEVr?=
 =?utf-8?B?dUhFOVZsM0YxaEdiWkIvTm9HU1RJL01vQXR3Zm83NGQwcVpoZUVRU0tUVzdU?=
 =?utf-8?B?WDVMSlByMTdoNGZpTGkvTDg3WlpBTmVpMFJyWWpUdStpbTUzSjk1TEZJcHYy?=
 =?utf-8?B?MDE0SEtwMTdxMVdoNTR0TTdMaFBiNVNsRmNQTW9UVFlGT2p6K3pHSWRnTGNP?=
 =?utf-8?B?MGI3ZHpBdGpBQWNuZHhMbVY3Yjl1cFlNSEliSmJ6b01UYyt6R2FSZUNkOW9h?=
 =?utf-8?B?dXp1d1dkVTJRVTIvY2pXQXlGTC9LTU40alBGeU53ZmZkMDNQVVUxWnRxYW5O?=
 =?utf-8?B?K0JJd0QwUzY0UjE1TWtuTFNYNkduZ3lwNTNUYTlzaGRDbTU3SGpLVEtBL1BL?=
 =?utf-8?B?UDFTMFdWNUpuNjQxdm5QckhnV2U5dlh6MTlFMzRISGNzbVlWSnJTRkVRZnlE?=
 =?utf-8?B?UitsenlHOEFVVG9NclV1VVdXMCtGRnI5c0syMW1zSUpDUHVNUzJCYmJmVWlz?=
 =?utf-8?B?QTdIY0JzN0dTMDQwZEtvalkzVnZzSC94QlZaL1dmR2MySmVlVDJNTmZrcERF?=
 =?utf-8?B?QUw5MkVxdkJZQmtpeHo4Z3RwY1c4YlRrUkMvd294N2tDUE9BVHc5U2w0aDht?=
 =?utf-8?B?bWxua25USUZRVzNBM2JNK1U2Ym5Rdms5N3pyNTNYQjZ2T3lvYkcraU0yeXJh?=
 =?utf-8?B?ZC9iaWRZMXRGSTR3RnFEaE10WkhSbWNITW9QTUZnS1BtNUxpRndNS0ZlRG80?=
 =?utf-8?B?MEc4WSs1amF6SHZYNGc0dkkveVQ1amY5ZjhQWS9wT0l1T1RNNkhWZVRHOHdK?=
 =?utf-8?B?cXZUWTJnMU9IWUN3MURoTHB2RWNaV2ticitGQkRKc0JtZDA2ZUptT0h3Y1pv?=
 =?utf-8?B?eEozUFpicjd4NU9iNHJDU1QyUFIwekVLWW8wSHk4QjZHTXJBQStuYkVvTWFZ?=
 =?utf-8?B?UWdmRmpuS05VaFpIck56UmxQeE9waiszcXRGQjN1aDlURTBZR2VzOU1LZ3dy?=
 =?utf-8?B?K2hVZU5QMStTd29aMzZWdGV4dE9rRXp3MjhZQWRIMTFDanlLb3R4a2poK0Zq?=
 =?utf-8?B?TDdQemh3Y3VuZEZGRldTeTBNcS9ub2t5aUVNeUJNOG9XZTM2UTh3T1UxZ2d4?=
 =?utf-8?B?TndHQTVBSGpib3hrQ1QrcTJNNllrOFlxOTdKL1dFUVYvOFI1d0cxMFpuNnFO?=
 =?utf-8?B?dHJ6cVlxWE5QdlhRRDdyUE1SVlVJMS9nUHZEM0RTRGZJZjBibUkzeDA3Y0Qx?=
 =?utf-8?B?Ukcvc1FGS0M0UkZvNUQvUHdMOUlKcThuT2gzRzJ6THJyZFMwbHFxVDBXb2hk?=
 =?utf-8?B?RE5FNDZ3ODRlMVpEeXQzZnZXYkt5Wk15T0Via0ZnWlpXNHFHVlRiNmxkYzdG?=
 =?utf-8?B?YUF1LzdjN3B4c3BodjFacDUyNHBjem9SZlZPOGsrY01WRWdKYXByYzd2REFl?=
 =?utf-8?B?M1h0MGN0c0tacDZRN3JNNXFhc1kzNkFsS2JSM2pBY1o5ZytQZlRFeEc1SlZ4?=
 =?utf-8?B?SkxmUmxSbXpWSkFZQkFkZkNMeE9pK0txcnJaQXlTV1BEUWZXaXNRSmNyb1hL?=
 =?utf-8?B?Um5wVjhnVko3a1pRbWRIREZRcDVRL25CbjlCZnprUm9LMGVvYlZhdWs4UEdH?=
 =?utf-8?B?dGxFMFdFV1AranY0dlYzcnh0NkZ6N2M0NkJzRndpUTlpQmlNRS8yNko5dTNS?=
 =?utf-8?B?ZVJNSEgwVHZ5NUt2bjhMQjJ4MWhvaW1lcmczNm1KYnl5RTJkdnhBbzQ0REtK?=
 =?utf-8?B?SVRJU0kydjlBb0toejh3VFpldVFXQkxFKytvWEZ2UHlQYXpxQVVpU0pjZjhm?=
 =?utf-8?B?b0FwMksvbzl1SWtRM2luTmh0MjQ1bjk0UFVJaG4wTGQ0NUhjU2N0bVdhdXhM?=
 =?utf-8?B?NzA1dlc4Ym5OWC8vVGo2WXhsZDExa0FJTFBublNHd2hOWjhzRk1LakoxTkF1?=
 =?utf-8?B?YXlvZGgrdXJBUWZlcUQvMnN0TUpqQWh2Ukd0SERvbnphalB6WSt2ZW5MbmNo?=
 =?utf-8?B?MFRCbWFlTHc4dlBLVnRkSUJmTGNEWTUrK2dmZ01CWEpYVUltUTBDcUFwRmhr?=
 =?utf-8?B?UlR0VFJ6bHNuMFM2NE5VSjNHeU05ZlBGT0pQbDZidGFDTWdWTjk2VkdKVlZt?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdde4a17-e9d9-461c-bc51-08dad336c726
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:55:45.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvoUnkTtnY6Gp0eMu8TXKkHRFXOj6Au5GMugQpq4agxMJBOVtHQRDsI38Qhr4Bal7gZtOij87o+i8Qxx96Gn2j/rOCggYACdW53zzQqV+WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/30/22 16:42, Zhou, Jie2X wrote:
> hi Russ,
>
>>> Are you sure you have the proper kernel code loaded with the test
>>> firmware code that creates this sysfs file?  Without that, this test
>>> will not work.
>> Nevertheless, the error message you reported in your first email indicates
>> that the test_firmware device may not be present. Did you verify that the running
>> system reports the expected configs? What does the following command show?
> ~# zgrep CONFIG_TEST_FIRMWARE /proc/config.gz
> CONFIG_TEST_FIRMWARE=y

How much of this path exists on your machine?

/sys/devices/virtual/misc/test_firmware/trigger_request

And is there anything in the dmesg output that indicates a failure associated with
the test_firmware device?

- Russ

>
> best regards,

