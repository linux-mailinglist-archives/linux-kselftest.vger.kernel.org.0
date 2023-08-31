Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29FC78E89D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHaIoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbjHaIoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:44:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729E1A6;
        Thu, 31 Aug 2023 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693471446; x=1725007446;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WiJTQ5Manw+ms9oVyWiuyB4zAd/2oAP27hAkvfpJLEQ=;
  b=WgTXtV6AFT2TlrVqBKuXw3joxztvpGuS5J/5luod/Oct64EX8/fPEgSc
   ku+auyObWr/hKVdWHvTGrGPur8BNYdgc6jdqbugLD7HZFQ8BS1bmaX5mW
   Mq435pE/zCuZvy4eq2UI7cZkSQgQTWA4YArdRvSS0pUwKOEyv7/Ac7y0J
   DIUchqN8biDrj0ZqWTx+UpYqkoq0livbUY7kv7Q2eyks0uofLCjvYEOZo
   EidspL8E95UPMwoqQoz/1eTSJ80uAaT3FIDrxlIA0zqnlTLoOcNWC5LDF
   WkTR3Oz37WzRyt2GKsIjoCjwbtYvXdM/2XPS6cn0G1sIllgZICIzRcSMB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356179756"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="356179756"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="809498419"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="809498419"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 01:44:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 01:44:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 01:44:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 01:44:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkniTGDe06WeiFftr+cjIutmYy2b4lEGXlvByS84pMApPin4RSQoAEznFhE8Jh96kuLNRWHyZIlZ71+4MVQGW++CVs/MrGdsFiFJxpPPSocKa8elLvPVrNabbHDsRxF0Qp+wq+yxo2R3d059zv2NKsuDto+IQBPGRgr54L6B9RAWsCNFuRr40/QivfNWrpQFkGkeQDTkeXvQ9MpjutG/EC29VGjc2+9AU4FomtX0Zwf5XafcaVmCBeZIei+siMxSAhM9cW5I9zGI8KulsZGil9luCvFXRmZI4xJhIMq8MPdTbK4H7T9EA0n1ngeLfjYRSZp/8XTHbfLD/+6F6ap+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft2FrVeTBvQ+k4jq8l5WPDiiHIkqMje8TBI5fGJVC1g=;
 b=c2hkITRfLrCenLwXdFlENp86buh/QAQcAYYWKmeIIZBBO47DByTf3cw+8eu5/yp14lnF0bSjufC+db3XySZMvtgrzTjuv20QyfIrSFzhwkdHFo34MKxInJcK/yWkW4vedLZ4BRUK9oT8FxNOmSCQPHKcivUHdAtihqCF4y0sysq0DwYX0K+OFVUdgrwy3RXdXKezIMXxVxGeRxUAhD9j2UB0fg0ozHuvNxVU9dliwwjeGREucg1h4fmNN52N0ukStOMLPsj7aI/bXK91Fk6wkmIeiJcbVj4kO9FABkVlrI52IVwVffUkPmP+C2NkvEUT18nA9GdxqaCVj38fHjLRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 08:44:04 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 08:44:03 +0000
Date:   Thu, 31 Aug 2023 10:43:52 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <fenghua.yu@intel.com>,
        <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] selftests/resctrl: Move run_benchmark() to a more
 fitting file
Message-ID: <v6bjvvjofvgly4k2jzvikr43mjz3ugzic2umlobjlkzchqmww3@sbw5xz6rbd4r>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
 <e527be8b871212823ff83f3800b6eecc2a75e455.1693213468.git.maciej.wieczor-retman@intel.com>
 <16eccb6b-a968-c6ee-dfb3-221ed8ec023c@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16eccb6b-a968-c6ee-dfb3-221ed8ec023c@intel.com>
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d299cf-8df3-460a-c437-08dba9fe6dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVqvgdcB29e7D84g1hFLhMwUwN0z5CHlTGYyrkRsvj64UwnjCTx+GYJ3HRM9DAPIs8i0HWe3Y3CufWs3dE45WS3DIO6rywGEZG5gdVhkdQU+cCP/taq8u3JtL7mbLj1banWbvzaIr2X9ZLisCUK5nBsDIv4IZY073NDZ5hEfHUM9ve1efoa+RF5Pn1i3rkwof0SN7kl+U3beMcaj+gmK7nqqTBBbF8BpfrrmOqmFCzMMarjyrxtPnUE4dIimZb5Z2aWWan1RcNqYsIvatk0sGCEwf2h77kWqnnKKNyfuWhS7BdRS9c2FvpYMWE/oIyfbk8LY5RBwS4G2diJYCpyM5Q0ymyxNmNEnGC/dji/rdAjg+gDO4BIxw+KRNCVi7eMENNjw+0RpFoCFnVOShER1yz0DPa74c88fru19cR2ALRvXI93mbPag1IkxakZrNL5Ax9F50yuhOsnHViTurnbHLGOPTKqSe2x63Y/yB40S8hBlUM+oGqxxCt4Vrn+Bvz4p5aJ2M726DyzXpQ2cNPNMvoLEl/grIts5WK3p9Gjg+djIr9KLVuLZU9ZAXvr2d6C3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(186009)(1800799009)(451199024)(2906002)(66899024)(82960400001)(83380400001)(38100700002)(53546011)(6486002)(6506007)(6636002)(316002)(66946007)(66476007)(66556008)(6666004)(41300700001)(9686003)(6512007)(478600001)(33716001)(86362001)(26005)(5660300002)(4326008)(8676002)(8936002)(6862004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mWP3NTzwr9esGuMDc9leTvZAChAkiiJLy21kjusyUt35eKo+PbBUbCZcEp?=
 =?iso-8859-1?Q?6PhyOxDfXLAjdoG1RfeW5iOWv0pWTk1U1yYJFEOw1erZ+H34wYV/T0dc4r?=
 =?iso-8859-1?Q?6nQQzulIywIqpi+gDUTDQ7nlnFdQEBKsSCniB+n6s5umKJWIn9LY/da0Vj?=
 =?iso-8859-1?Q?mUDq0BU5LPyTo8idsXxBwX4jnZnbjgY69nfXuNHOl0xRnGASbV0vBrNE2t?=
 =?iso-8859-1?Q?A7O1oiAbOG4VmhPqlsW6TJBYubkZlz69FFPrXdAEd7Mohv9vnDCELq1aBV?=
 =?iso-8859-1?Q?NM9gQVZhCsdQiRM/mniXKCon/ZeBI/dKUxJrM36GU7M6j0iF4pX4cSeMRk?=
 =?iso-8859-1?Q?OiW5Rf+WeStDjTaGqSxwIiVW3wD/gPerNejLBzL0OXYqhj4XZho38ecb0E?=
 =?iso-8859-1?Q?BlOk2eAfHg+AGvP8dSskX8wC2NEaYnAYTqUZ72OR8qu0Iyl+ig8a3LV+HO?=
 =?iso-8859-1?Q?T2W6VJdd42L9XJ0hZ+l1KQUrXSQeNBjzxAnuWYfqGQaSie8rTExRjlblbA?=
 =?iso-8859-1?Q?pNdSvq3WnPbmk0DdEj1lpkKRcJyzbWKFiAVXuzlZzP3M+rF0VlbqlZiJEJ?=
 =?iso-8859-1?Q?UFx4Y/2Nqt13ncVpLZNBCKX/ZACtikTcosLcSX5Ipa9CLCyNNznxHB5Jpq?=
 =?iso-8859-1?Q?XegvBIVZ4RynhbE9HdgJQZEdIKYMwtkFGvj19KsD2bR1EDl1GzXE6MTziZ?=
 =?iso-8859-1?Q?LlS9MEdVxpc1uxEHFf2Ep/u/6uA/+gsWc3NLgYYX/g8BFwYu2OFCQ3z5yH?=
 =?iso-8859-1?Q?x0d6wFHqWfiH2CBdTLUNpot3Tg2iq6Y2h043EfZngBibpqbQZ28Je7ovT/?=
 =?iso-8859-1?Q?3GlYkdQSkR2rM7znm7G/u3DTg4vnUPW+guKwrdJ51cwaOsiB6js1J//aN6?=
 =?iso-8859-1?Q?5O0JaSvtbiJkZYndxtnxOGSfnFOgzj60xwDKsQraN5Wp8sygSZflDmSRgB?=
 =?iso-8859-1?Q?FenWXMQkXXb9LYEesNjDpGVOLygdwf0cJVCKZiurJii35Xz8n+hR2o4xh8?=
 =?iso-8859-1?Q?uF2Upyy5UrqChxSsGWsw5F3Wyiv4La7fDs135gyyE0Dz8KiPM0tzhJLPdm?=
 =?iso-8859-1?Q?o7SdVhUmBBiy21tPsSbK0UTFjKQObOKkddz19rgOj4VuF2ENcpPbGmjdAq?=
 =?iso-8859-1?Q?hEgr7SwqAMxzF6Lat50zECJ9HE53ivLK19LyvKrer/u2iN/3gJSBNzyAWp?=
 =?iso-8859-1?Q?nJGoYrXt65xRPB5D8tXyGD2/LBtldzzepnyJOBUe1uAjrWu0reeQiggwRq?=
 =?iso-8859-1?Q?bnif8US2v5+lQaV7LWqV7JzOPwUOXvWMMKjZp7wbLC/+zwl1HcOSwC5ofB?=
 =?iso-8859-1?Q?FT9Xa5TmCeJuifEqPt16i08QHRYyFr+GdMRjcpFDAQyAreBEaVgy/Su+GQ?=
 =?iso-8859-1?Q?PsGM+4v/aK8DmZduB8UycyDoXRdCTF3d/j283zSyxjwnLMiFpmmq4SegZE?=
 =?iso-8859-1?Q?mEa3YnfnMa1c7VxwZsHtbrKOheF/EyYrzm0ebTDp2ahujIeeu3Cal+3YOZ?=
 =?iso-8859-1?Q?PeZuyFzlEJe/W+i6yeMKZ9aNfMdwH5aR6yQjdqf9hYSAvDpZFG2Yh6igtY?=
 =?iso-8859-1?Q?p0659fTnwMNhOFYarABCiTBWz0wgrWG6TmmfflMGPwZ3iFV9v+btTRfeLr?=
 =?iso-8859-1?Q?A3RlcQ2Sl7Y0c4HV2cfGvrqh5i8s1Sw8IA1MNqJJTOOfFx4FA7vpQbJyjy?=
 =?iso-8859-1?Q?YgOMMSadx+zVJwnSlzc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d299cf-8df3-460a-c437-08dba9fe6dae
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:44:03.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iJ6D1mZ0/Tu++g1m6cO0uflCyxWPPHeoHENkkGUQguU9EJ+0yMWWgtPB0zI0UVZZLZxt0j33rFcAUdfJQ6wQl3hAuYuzR3F8RO5J8PpTDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 2023-08-30 at 13:51:29 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 8/28/2023 2:56 AM, Wieczor-Retman, Maciej wrote:
>> Resctrlfs.c file contains mostly functions that interact in some way
>> with resctrl FS entries while functions inside resctrl_val.c deal with
>> measurements and benchmarking.
>> 
>> Run_benchmark() function is located in resctrlfs.c file even though it's
>> purpose is not interacting with the resctrl FS but to execute cache
>> checking logic.
>
>It looks like your editor may be automatically capitalize first words
>of sentences like Resctrlfs.c and Run_benchmark() above.

I'll fix it.

>Also please note that when using () to indicate a function it is not
>necessary to say it is a function. For example above can just be:
>"run_benchmark() is located ..." ... similarly you can just say
>"resctrlfs.c contains ...".

Thanks for the tip, will apply it from now on.

>> 
>> Move run_benchmark() to resctrl_val.c just before resctrl_val() function
>> that makes use of run_benchmark().
>> 
>> Remove return comment from kernel-doc since the function is type void.
>> 
>> Changelog v2:
>> - Add dots at the end of patch msg sentences.
>> - Remove "Return: void" from run_benchmark() kernel-doc comment.
>> 
>
>same comment about changelog.

It'll be fixed next time.

>> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++++++++++
>>  tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
>>  2 files changed, 50 insertions(+), 52 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index f0f6c5f6e98b..5c8dc0a7bab9 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -621,6 +621,56 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
>> + *		   in specified signal. Direct benchmark stdio to /dev/null.
>> + * @signum:	signal number
>> + * @info:	signal info
>> + * @ucontext:	user context in signal handling
>> + */
>> +void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>
>Can run_benchmark() now be made static and its declaration removed from
>the header file?

Thanks for noticing. Yes, from my side it seems turning it into static
is okay. I tried it out on Ilpo's branches that I know he's currently
working on and there were no errors either.

-- 
Kind regards
Maciej Wieczór-Retman
