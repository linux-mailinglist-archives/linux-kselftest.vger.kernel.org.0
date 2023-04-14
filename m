Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062F76E2968
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjDNRaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjDNR3x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 13:29:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AEAAF2F;
        Fri, 14 Apr 2023 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681493380; x=1713029380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UQ1NauNH+w0ddFjE1+hKiv3TFuNpE0tdYYkD5JupQmk=;
  b=g3fFvw767DTcnCb0X7+obNGokubOMayCIaSVSdOqNtzohno1s4pOG2W5
   SVVe6B7yOrr22qpHy0JjwLPWFYT5hWeuTFnvCinIIHMdPLeSOvs+6SPqV
   5GrPSMJqJAnqnw3d52HJ2w8deJIGFw5sG6TpW3LUJDvCjyXqErcJ2Euow
   iAKDpdUQ7jBcHBsB1huNJMxSw1n7J+zMOk3D7zZi1uvkkdXNtzHMT14s7
   OksYFjGaDbv9XAt7moifQ1GpvdA57O5tScC+ZpCsNxjHXTPWzPBhKoj2d
   nVMxfzQGzqIha0Vcxxk3QKl8c7F1AObeTsTGiGRNBRAaxTvOTxgCTsZeI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="372388450"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="372388450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="720357838"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="720357838"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2023 10:29:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:29:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:29:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 10:29:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 10:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfhiiMmYOZsxw5XReK0zqUqH7FVmU1wfvC0/VxPF+ghPwwpXQ+qDVE69vaxYxuBrPH8Y7/IFHpgH+ymW3vttnu7bQzxVFTaXuETdsUsUVW0X4itdFDYPDOhFh8H14uEY6u1lWNgCimHSRcuSf0j6R/0JXe5SjL6E8P//R/Btr8+W606yirHbn75HMK5SzPJr3XE0bH5DCwrL3l6g+S9uvkdtq582pix1C7/ROOD/RgWBzBZEhaC3H5DyaHDf0XTXOqpY2jnStfo4qdCfwo7rTjOigAuSLUFdftiMMjqCLOpQJ6p7e8FXgdlSESui4oVT2rmxWF8YD3d1Dm41PioGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS5jpyuaYjpEtc4Inr3Zd7WQorAlPwz+nIv8V43E6CA=;
 b=b+aX7wgA20XYHx7iPJ1SA+jMDFWaAya4LRbh5uFPe/tZhIWClbzwcmJ4Dky+HO9tYwn2/pj/bvHNCsk5IeOEVqhT7mowUhSXbB7RMV3DztNATnLz3pNYyPp/38aI+n2ckZaUbegGlpekrdP149C9ImsWrVYEwdNMtcFJA6JktLeoVTHcnmjCrJovla+eBIPpPCI5VM/sF7CUGLOR951URaaTTlEqgU2l2eu7BuCM0a8+Hf2GU0AY2WlskVP5tav6lica1UQQgcHB1qMx1K9GhNKyEW/rvd+KeOncCN4kuIwv1gYtBKziSoAuzfWZlZrUNEYG6Bk0ln+OudYiLVFWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 17:29:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 17:29:36 +0000
Message-ID: <f2e644cd-bd5f-c22b-4906-9f8baf31104f@intel.com>
Date:   Fri, 14 Apr 2023 10:29:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH] selftests/resctrl: Fix incorrect error return on test
 complete
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <tan.shaopeng@jp.fujitsu.com>,
        <fenghua.yu@intel.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <37df0986015ecedec9a0244bdb0aa7c073bfe714.1681490161.git.reinette.chatre@intel.com>
 <ed27df52-969c-3d07-7c1d-2dc1566cc850@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ed27df52-969c-3d07-7c1d-2dc1566cc850@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af342cd-e369-4ee7-4034-08db3d0dd10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzPp72TGZ8Jg6nWNMSfvqIdI/k9bI8g6Jv9ovjrRm/yqR3ld9PGuDinDuN0mb/VtpPxc/qnyODpBA3fw9XvttE01xo0kxUFInFF054z3Jd986+/JQcmW3KnCdTWndYk/dl9jxEa2Tbt0R/FV4xA4TYCbIQjKenRjQo1Uzck0GZU+z2+cp0tiUyTAoKK4EFdTYcLgyu4SEwBFFj4NhG8ZZsbaP6bW0VXBbTH+6rt91m9IWTyETFY4Ac4/LrX9lmoj4TI1e1g8Y+DgnQJB+wF+t49luhALTj3YHrYYOLLRiqeYOmNQDOngsl69C2eqOUO6dK9pSo4mkSZoI3/ihVisOgpYLdO1VvGCOMi7iGn15jLZpeM6lOoKm8g7OrAjlMfx0XbkmnslJACbZ/udDNNtajpLJvMQkziRtwuhuHGl10wBY8UmO3N1mMFytRWa4r+lm2lqlTZ2zwUgr5v4n7rpQbpJai6zBNglymFxQ+cLMTJSoeZVJyNF4j29X+sKFF2o4hpMhPFhXkqgUx1+CBm17spHA6WcK8MgtKB04HREjkt4nXXIQ6zBA5HrO72z3ZlawJfOeeXkGYhWl77xyPgV2JxRSfKB8IucgRRUpLeTiGl1i9MJ2ZDLHmEK5IPBlCsEzxzyyeICyMS1tyblg7ziqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(558084003)(316002)(53546011)(6506007)(6512007)(38100700002)(6486002)(86362001)(186003)(6666004)(31696002)(26005)(2616005)(66556008)(82960400001)(66476007)(66946007)(36756003)(4326008)(41300700001)(8936002)(8676002)(5660300002)(2906002)(31686004)(44832011)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJUTUdLS3ozNlJMYVA5SURUWnU3aXZYMGduWkZ3TmR0a3A4QzI3WEkxZ3E4?=
 =?utf-8?B?NUk2NFV1MEZBa25RT0hORDJQTWRRaEZXdkFOMWRCQnc0NitPSWtPTzdzV2F3?=
 =?utf-8?B?MENFVFFZcTRZS2N5dFc2Ni9vOXJ6dmZNY0F3RStPWlNNdzRlVkMwTTYxaTcx?=
 =?utf-8?B?Q0VPSjYzUGRZdnBtWndobWZJdWxxNWFEcEF5Qk41RFhLYlgwaE9KdDJXSytP?=
 =?utf-8?B?dG4vVE9jTG52OGh2UFltVi9qTTc0aERJSkNsNkRTbEZ5N0R4anY5aXpBV1l2?=
 =?utf-8?B?WDUydkVQK0lzNmFEd082Q2ZDVS90ZEJleldTVGtxYXY2NEQwL2JmOVgwUEY3?=
 =?utf-8?B?U0E2SXkwR0U3ekwxU0c1RlRMMEFKYlpGM0lpYjBXOFc2OW5TS0todDBzcTV1?=
 =?utf-8?B?VlUwaVdSNHZDbHBRTUlCcXpKR2hwNWtvbDAxd2tDeEdyMDBTc2wwZ0E4RW5i?=
 =?utf-8?B?U1BQUjhMUkNJTnk2TFcraU1HbVJBMm80MUljSVJ1V2VpaE1sSnQ3ODVSbmZk?=
 =?utf-8?B?MFo0THNXTjZ4WUNVRUhuS0gvcFNERlV0cm5qTDhkdmZDT3MwYlU1b3Q0V1NU?=
 =?utf-8?B?K254U3pwMkQxZWVHTWNQVVYxbGFNZ2ZRbFlDRVBOVGdJRllmTk15YnNVT0pH?=
 =?utf-8?B?QlVGSTBYYzdMTE9ocG5obU0vOHE5dEFpa1lEM2N3T1k1T2NXRHJTL3ZXZTV1?=
 =?utf-8?B?S3NMbURwbS9ONGJuc2hBZitLSUlvc24zRkxyUFFSV3g2ZzlsdVNFWDh6RGVT?=
 =?utf-8?B?M3J1VER0TTA4YkpUWjdTcEdFMXZaS2FkS3ZaMWtVYVVhai9PYmtHVTdhTENn?=
 =?utf-8?B?SW4xc1VYczZRUG1ia25nNTVzV1EwV2lyTFIvRlJRck9abGx5Sk5jbmlJZ0kr?=
 =?utf-8?B?eklmMjFMM05rNkRGdjB4L052cTc4QzBzcnJxWFEwdmxOYnBzZnNQTjRweXhr?=
 =?utf-8?B?ZHVsYjJFV0pLNDJlMExSMDVVNVpsZm1hS3JnV2EzYUtyWEtiUmxwK0poaUFC?=
 =?utf-8?B?T2hDNG9nWUthTEhMVmZNVHNGeEZoOVRYWmE4bWdLMUhtSHJZYStUNDRJNkxX?=
 =?utf-8?B?U01NajlsNjJiV05STlJieTRpeEFYYzJnbEwySjRaZmVTVG5rNlVsT1FHeGRq?=
 =?utf-8?B?b0JMWnhxRXhVTlFRb1dnY1BsOUNSUTBKM3pEdEFiMm5TRGEvRUN4L3kxOVps?=
 =?utf-8?B?TThVSnRESTlhK29UMWpjVnZYeWdrQ3R1Y0lxVE83cGZTOXc1UzgyckU0bWwv?=
 =?utf-8?B?aHBHY2RmbEVCaHJzajRFTll0Q0wvcVpMTFBNMlBxb2JlSmdnY0RIYzRma0I0?=
 =?utf-8?B?dDBMNzlnT1FuWk1nc3ViTnJsQ2lIbVR1L1h3VjdBZEd1SE93eDQyZWlzd0VX?=
 =?utf-8?B?WU1XKzBRcWdMR0ZIbkt0ek9BZDVTakhILzZsM0xMYTB2ZlV4ODJEV0VsNTF4?=
 =?utf-8?B?ek9rSzJtQUZ1cnpxTFpiMTlobXA0THRnam5Kbm16LzZFQjdLZ3hnbFJBd2pv?=
 =?utf-8?B?QVBXbldHSWxhWXp2RGFseXdiNVJ6NWsrM1lXS2VvS2h3L1JXU0QvWk9KY3RE?=
 =?utf-8?B?cndZMnpub29MMWg0cmxyKzBNTkg3alo1a2tSeGRuNkMxaHNoUUtMWG5GVDV0?=
 =?utf-8?B?UXZsekNmZmZEbFZpVEFSUllHTjU5VmJ5UmYzR2dFbWJLdFJCcVFlbDhHa0VG?=
 =?utf-8?B?SUxWRGdNckgvblBPQytuV29GNkx2S3hNbndqRHpXTjhvSHZkNUcvQUYwT3Rw?=
 =?utf-8?B?TGJsTG43ZlB6cTFLMHJESXhqanozRGpiQkxGcGNlT0NSdlBLMjh2T1M4Sjhh?=
 =?utf-8?B?aTRmNys4TWZjN3Nsc3Z4b1ZlU3lQc0hUem5rQ1ZRMTNJTTFmUWU5SkNnVjhs?=
 =?utf-8?B?REZzT1AwVVB4Rkpid0t2T01saVYwUWlLZC9lTzVCcWJEQUs3YjVaNXNVa0Fy?=
 =?utf-8?B?RlNxeUx0bFozYmI0TXBwNm5xOUQ1RE9lWFllRFo5SFBNcEcxSDF5V2xoTzF0?=
 =?utf-8?B?VU4zNFUyeWErMVJJeGdyWURKSXdic2JraUhvblZkQTMxWmYyYlE4S0N3QTRp?=
 =?utf-8?B?cEwvcm1NK3lENFpyVTM5TTE5Rit6QTZoZWViV3YyK3ZxYkRPNmw5VEd3aC9l?=
 =?utf-8?B?VU85TkVuVjdWSUg4bzhrVU95bjhxVHl2VnZsTmtkbEV1dFZYN1NScEppTndI?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af342cd-e369-4ee7-4034-08db3d0dd10a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 17:29:35.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GukKIPqp1BSEI7idl5jsNI30twHoSnzsOqHRDeNYXBNUQ8EQMotiO1xaqLq7LMCSndKG5sKTPr/RRZGi43QpRfF8XhTuPLf5mYaDh907rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/14/2023 10:16 AM, Shuah Khan wrote:
> 
> No worries. This is now applied on top of others to linux-kselftest
> net.

Thank you very much Shuah.

Reinette
