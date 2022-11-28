Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D963AE9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 18:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiK1RN2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 12:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiK1RN1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 12:13:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9498C1181D;
        Mon, 28 Nov 2022 09:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669655605; x=1701191605;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GTYZKx/eBPMCglWT8LNFhSQ53726a/7ee+WCaKMqCPw=;
  b=LZxa+oOK8UjuZ3JtAQRmguKWC+sRwPKz20L+ivD4bwH8GK27zBzjfERp
   XrY0CojF9Ll3cPDyKWnO0gTExP4g2qIBdMAtgBGkUhvWx4wp2ALeabAN3
   05hk4m5BerxhtJwhiCpxq0lFZYEjbTj311fvd2+JkXoo1DpWztvt7vSeo
   ssDq2EJhUSN+ErjYmpfddwXGEvBxVcZzMVl7HbZe3e1tezD6LfCw8qV4r
   YCPMNJy6EoPMM0mAygAFec2HXnybA4rWGiuLmAer2hUIkO3FIF6WxTn2d
   uE+RMXDMreCWgggl+/oXcwsOBv5tu698OXAopJi5KlTLux1q3cZECVV3+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="302477106"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="302477106"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712044384"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="712044384"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 09:11:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 09:11:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 09:11:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 09:11:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 09:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ugnd4VmsgniCA82wjibA25i8CHnlzGtYrYDj8EW8oOMouCtiYgOXUVs616LzFf0Vp21KJt+jZk2Bir37B6d429Haz0K5VRWR5Sho+l5OKyWDHooYoizdW/PJBCvQrZjENounLktu/EZPcfRhTqi0RWuNWYdeSlElE0xKEETh7kdHp4+o/gvjjX7RvxvlzK6/sygGxLW28m0amr4+5R/BwFlAP+v7In04QB4VIMYNi6c83Jg6Hgds4NY44/uiClDhTfwKGgSLbCWsYb3FJPqTiAxqxMNxZGfplNFzj5U36MAX4wa1VNh0u2jnlMWfnJ65jGR3xgcUnWFA3Qp3coBEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVdS79+BFZM5MXDfVnuVn2e/ek/sZKf1L5phcJSw6lU=;
 b=a/fuHg+CoZEpINQ7+0ROn1sv22W3/Yrqk4Q4joNj15B453WEOqxnECczG40FKE98uHXshw0LvjLB5oQVPak0/Z4Dy3+1eqoZsDTylDLHHHK3jqsm/m/xLr634ZWi3mybAVQbK8jIHaH9OpaoqjHM4WE1BXfMVre1WvAjN+LW7+0nLdz3+aaQU+IGjBPUhAHtdFny+J8OAcL6uY01y8ptps0C0GW7ZXWOCK9U/R1EZJj2tnqTLju6aey82gU6EaoYTZWTUPJfVBJvoBPWdg+U+Kf1vwtMqpqoCOotcf7TpVMcwV5U3bekbLqGl2f0FhsKQZTipmvbRQr0Zv+lkLHHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 17:11:18 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5857.023; Mon, 28 Nov
 2022 17:11:18 +0000
Message-ID: <ba5a9ef2-b4ca-5c90-cc03-2296586455a6@intel.com>
Date:   Mon, 28 Nov 2022 09:11:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
 <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb9b58c-09ca-4848-dbe0-08dad1639078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQFOp0Mei9Lf9UwIC8JWscLtalEqLYrrmbOfa6XWn4gRICbv4T3zJTYu7Zj0Z545QMWxA4AWOx4/K0QOrCBjWAe1BiQP5tV8vFkuo8r4vT9sUfHdesd8pSEZ3y6mzroaoRUItVv3+hOGNrU+9cXa/zSB9YVi4frsgWP0BWqVRU0Gky7BgIvCijTAeZIbf10MIXEkHVY3zQdbS73bDyf2JK+J6DM2Rxkf6Ct5FEjK/LAoS8VlbVwnFtS8gq7inl9Bb0e98QWG5HRpjPpGO9hHCzc+VyhzhYnSGfYFzbUUev08MPpJCKLwlZDgA0yfGrPLTWPimVTdFFafE2CIYtbYA74eOzorrF4miw5Ckx8HSkSRrrhymyUhH6iY8/1czYPxSAgH4w90mofP+lK33yIo8iu4NF7p7CIKfng99b5JDOtcFaJhPfUheKMdScOUGA+ftoLLxICaEf3/r1SkUD5gcGyGJ2ihXBPMFBwFfUFeV4LNguigQ9OWMWyV97o5VVjoBDGjQhpTca44rvHd6sv7sjGkh3dG9fkL8bZHboSiNKynNjdrCBnt+PYaUYK507N6CZ0HgFw1s5chGAaSRCTj0CvvnsLoTwccdrhcQjiJK6BCjR6O2RvJfI5tM5Gs26PJzKnIOvb1h2ozTPjmUFlKzDYmGfUA9elo+3yI2STucyOtxNdUSBSUje0B797CPQwrqlyTMRdznomLugHXB1rUpiGZTvZoG5h6nh0sCsVg34I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(44832011)(5660300002)(8936002)(4326008)(2906002)(6666004)(186003)(66556008)(66946007)(53546011)(83380400001)(66476007)(41300700001)(26005)(86362001)(316002)(6512007)(2616005)(31696002)(8676002)(54906003)(6506007)(36756003)(110136005)(478600001)(38100700002)(6486002)(31686004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZqMGRjWEllUFZNTS9ha3RHUGQ1cm9SRS9lekRzbWxSanMvMEpwaHRLb2M0?=
 =?utf-8?B?dFNwV3pwSzNhbWIwaXFqUS9qMEFNU0xCM2c4QXNRUnE0N3E0WDBTZEQ3Tjh4?=
 =?utf-8?B?dG1iZGg2YnJ4TGF4QlhXNktwd0dRejM2d2RrWWpzQUJuMDdlbEsvUEcycGRP?=
 =?utf-8?B?dkZEbUZMbXhkckM4MDJKV29VSVpQaDYvWkNyOGhNOXBXTzF3amFGZTZGV1N1?=
 =?utf-8?B?RjE3WU1kakNxN0xmNEdYTUl5bXphUWFBSy9pQXpROFNaVDByclA2SHliTk5t?=
 =?utf-8?B?eEtmbTRXNjJlcFVzRy9SbXFpN3ZXa0NJTWJCWndFWjZJRXpwL2dEcDdSS0VF?=
 =?utf-8?B?cUZQUWRBRm1nbG92aDVIV2JoZUQxQUZxcjJKWWVJRkhqdXRVSlk3enFBMG42?=
 =?utf-8?B?TVlsUm1tT3pzYUI4Q0VHeXJsVi9ZNW11YVh5YlZGT2duWlM5YTlHMVNhbHFa?=
 =?utf-8?B?LzE3MUNXVEt1R0JkOTkvYjR3K1hXNXBsUXliUmRzUkpQQTJRYkYvZGRIdjFt?=
 =?utf-8?B?WkFOdm9xWmNsR1VVYjZTUWs1Nk56NmJmOXBKdTVnYmJtZW1jdHFLVU9UZWdi?=
 =?utf-8?B?eVZZb09kZEs5N2tNNVNBNVB4dktvVEpCU3NBemJSZlVLNGcyRzRFRTJPbFho?=
 =?utf-8?B?TWNWRXg2aERocjhGOFd0dUxNc1dWdnBNWXBQTDN4WFhTWTNsVEJhVk1YYStK?=
 =?utf-8?B?R0ZnTkozLzFDeGtVMkhBLzl5N2h5R09hbXptQkU1eTJ5SzlIQUU3b2wyWWVM?=
 =?utf-8?B?azdhSnZjdXRJTWQ5VUxuL3N5b0NOZHRBTG1VeWgyVGVFMWQvNDIvWS9IR0kr?=
 =?utf-8?B?Z2lPclh4MTVaTkpQT016b0c5WjFKbzRyY0c1QzYyZ1RmLzhSYnUyMGpBbkxD?=
 =?utf-8?B?SEZNdWZYcERPUXpOUE5TcEtGSnVhREUzVjR6N25SN3ppUzJlbDhJd2Z3cXFH?=
 =?utf-8?B?azNoVkRpQXFlQWZrSDZFbUxWdzREWmFPSFpqTVlWalBEUzJsb3B1QWUvNjli?=
 =?utf-8?B?UnE4Wk5LdGxLd1YwZHhVR3VaVEJKYXJudS9YRUx5TnBnTjRLU3ZXR094UTR4?=
 =?utf-8?B?Y3RMSElMOVl0dWI1TGYzSWtKdGVBZHF6RTc5VzBvQWRVOHB4ZEJnaWRJbWp2?=
 =?utf-8?B?Q1A5c2QrNytjV2JhVEQvTG5zSTQvVFcxNllMSzB5Wi9ZSVpFM1BGdjNwb3k5?=
 =?utf-8?B?ajliTGdGdTdrZ2Y5Rkd1Q2ZOUEJQcHdNbytZYlVib29UMW90YXB1Rld5eXlL?=
 =?utf-8?B?UG8yWXdHYWxOZlJEWDc2TFROcHphT0IyMEZjZW00MmdtNHBRNm5WN0ZYSTF5?=
 =?utf-8?B?VFJzZ09JZWFjMjZqV0FHSlFpNHF3YUxGQ1lvRmx1WjlpY05ZcDBNbUVBY1VU?=
 =?utf-8?B?TzJ2WHVPZDVlaWVyWlRNeU5lcWpRbDRZd1NFTUVFTzlUMFpmUDZWcUhRTVZz?=
 =?utf-8?B?U05kVTd2aHUzWTNOQzFhU0t6RjBwVHpYa1V3R0tYZERtS0NUOEJ5ZjIzMmgy?=
 =?utf-8?B?K2dlMmZ4b29EU3hFQkpCTmdFUFljZStKRGg3dDRzY0UzSzNsMnJyWG1DZVAr?=
 =?utf-8?B?WlhoeTZzRkRML0kweFFTVjBWVWNiK0c3YUhpMUt3MXF3WEd3ODN4NDQrY2VY?=
 =?utf-8?B?eXNjUXNIRzViUzJybkpUMUR5OXdtTjkwTXJLckVSeWpoWDNrSHdBbkZZRDRh?=
 =?utf-8?B?Y2hGRDM3Nkt4TXNSODlGY0dkQ01NejdhZlRCdXlFUEpQWUx2OUhsdkJ5UXdl?=
 =?utf-8?B?RkF1NmNDUGFwbWYxcTlPRTd3dUtLbjRDTW9tTU5IK2pXOHhYQTAzeTUrU0lW?=
 =?utf-8?B?OGRIbVdZamg4QmE2cUpRTlp4WnlFWGE3RWtwZ3VWcXc5RWlsTVpTRDlkRExr?=
 =?utf-8?B?dXJ5NWlhNVFrM25HOGg2MnpRVmlhRGFGWDduNDNCTDRmSjhJZnlNanJ3Z3BN?=
 =?utf-8?B?THBaN1FzV040TUZRSG1iNjBKaWFwKzlrRGVLQ25pVTNWSDdiNkM1ejlmWE8x?=
 =?utf-8?B?a1NzR0xmaU9VeGg5MzFicVFiVWVNYTd4N00raHNsMHo3NjZxMVkxRlJQVitr?=
 =?utf-8?B?Q0czd2hyanRrck1Xdi9yN3hKNC8xaUF4ZHd1UkhVYnYrbzVwRlAxTzYzMUFq?=
 =?utf-8?B?MEhGY3VGSys1QzlHU0IrYWFZUXM2MTFXdlBIUllIVzVaL2FuZzdUemNXVmta?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb9b58c-09ca-4848-dbe0-08dad1639078
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:11:18.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cryx8gb6Aq/JoHVWHN8FgbmFL7g7WgPOdFQnj2+czm4vbN1Me+3BBQvw+2xqjQlUs/D+gvfX8UPpEIEcWha11DZj9/PzHVrjZQkxvpJgork=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/24/2022 12:17 AM, Shaopeng Tan (Fujitsu) wrote:
> Hi Reinette,
> 
>> On 11/16/2022 5:05 PM, Shaopeng Tan wrote:
>>> After creating a child process with fork() in CAT test, if there is
>>> an error occurs or such as a SIGINT signal is received, the parent
>>> process will be terminated immediately, but the child process will not
>>> be killed and also umount_resctrlfs() will not be called.
>>>
>>> Add a signal handler like other tests to kill child process, umount
>>> resctrlfs, cleanup result files, etc. if an error occurs in parent
>>> process. To use ctrlc_handler() of other tests to kill child
>>> process(bm_pid), using global bm_pid instead of local bm_pid.
>>>
>>> Wait for child process to be killed if an error occurs in child process.
>>>
>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>> ---
>>>  tools/testing/selftests/resctrl/cat_test.c | 30
>> ++++++++++++++--------
>>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c
>> b/tools/testing/selftests/resctrl/cat_test.c
>>> index 6a8306b0a109..1f8f5cf94e95 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -100,10 +100,10 @@ void cat_test_cleanup(void)
>>>
>>>  int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  {
>>> +	struct sigaction sigact;
>>>  	unsigned long l_mask, l_mask_1;
>>>  	int ret, pipefd[2], sibling_cpu_no;
>>>  	char pipe_message;
>>> -	pid_t bm_pid;
>>>
>>>  	cache_size = 0;
>>>
>>> @@ -181,17 +181,25 @@ int cat_perf_miss_val(int cpu_no, int n, char
>> *cache_type)
>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>  		param.num_of_runs = 0;
>>>  		param.cpu_no = sibling_cpu_no;
>>> +	} else {
>>> +		/*
>>> +		 * Register CTRL-C handler for parent, as it has to kill
>>> +		 * child process before exiting
>>> +		 */
>>> +		sigact.sa_sigaction = ctrlc_handler;
>>> +		sigemptyset(&sigact.sa_mask);
>>> +		sigact.sa_flags = SA_SIGINFO;
>>> +		if (sigaction(SIGINT, &sigact, NULL) ||
>>> +		    sigaction(SIGTERM, &sigact, NULL) ||
>>> +		    sigaction(SIGHUP, &sigact, NULL))
>>> +			perror("# sigaction");
>>
>> Why keep going at this point?
>>
>> I tried this change but I was not able to trigger ctrlc_handler(). It
> 
> I tested this change using kselftest framework,
> In this case, the timeout command sent a SIGTERM signal,
> and then ctrlc_handler() was triggered.
> Since the handling of SIGINT and SIGHUP signals is overridden in run_fill_buf(), 
> ctrl_handler() may be called if ctrl-c is received.

I tested this by running "resctrl_tests -t cat" and when doing so
this change does not behave as described.


>> seems that the handler is changed soon after (see cat_val()->run_fill_buf())
>> and ctrl_handler() (note the subtle name difference) is run instead when
>> a SIGINT is received. The value of ctrl_handler() is not clear to me though,
>> and it could even be argued that it is broken because it starts with
>> free(startptr) and startptr would likely already be free'd at this point
>> without resetting its value to NULL.
>>
>> From what I understand ctrl_handler() and its installation from
>> run_fill_buf() could be removed so that it does not override what is being
>> done with this change. Otherwise, from what I can tell, this new handler
>> will never run.
> 
> I think removing ctrl_handler() is fine. 
> In CAT test, it overrides ctrlc_handler().
> In other tests(CMT,MBA,MBM), the child process used ctrl_handler() to cleanup itself,

Is that explicit cleanup required? All I can see is free(startptr) and that pointer
would usually be invalid as I mentioned earlier. If the process crashes while
running fill_cache() and thus not get a chance to run free(startptr) then
the OS would release the memory, no?

> but the parent process cleanup the child process with ctrlc_handler() properly.
> Also, avoid using signal().
>  fill_buf.c：run_fill_buf()
>  201         /* set up ctrl-c handler */
>  202         if (signal(SIGINT, ctrl_handler) == SIG_ERR)
>  203                 printf("Failed to catch SIGINT!\n");
> 
> I removed ctrl_handler() and ran resctrl_tests with and without the kselftest framework.
> There is no problem.

Thank you. I only used the CAT test when I found the issue.

Reinette

