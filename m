Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8647250AE7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443755AbiDVDc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 23:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 23:32:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F841627;
        Thu, 21 Apr 2022 20:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650598178; x=1682134178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HqHVP2+7XFOxleCWJ3cTqRh0ANQUM4Xdr9csnWWO+Ic=;
  b=iZ4vJ8sQuMKaeq9+3v2QAMSmOOkhV/rACv0/zN6w5h///bB5lEH9qc+Y
   tSL+2tvimjDrlB1hk6vH28OiOUQZEAy1aSz/IkGRfAd2z5MRKfQsVZ/tv
   cGaVxq/UMqCJtoLVZU1g4Mqb9LKUfqGEW6Csg9vpB7ALHKboieqCPS2Dm
   s7KwGZn24WSilN+XbDm3wwqI0Qt2zeQ+roZYBWX4LANhprCzqiYGx5jMV
   IznH8YhGvk3+rSHdlJyLHg62wtY5fZDdPNVmBUM1QC/H3taxisoEfNaIf
   BeVn9CZcaAUNOFfhHOm0pxr3bNIlpoaEcldvlBZEhgaN3WR9KrUyRfiPm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264725497"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264725497"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="805803230"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2022 20:29:38 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:29:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 20:29:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 20:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlSY5LfsnLZTdCiwPOtTnTq5Khw3YmojtDCczB6L8sP6Eg8CpA8/CKcF8ok+JSGvzhBn+dXasdPhWomJsB3vvQYhhPQmwVeqoFt8yUW1P25ek8889jBhKbwfeBTknayduHOoWyosYCr+JKOvtCCm+UYWNJJblVV4TAQW5m/HysZkPq1v0r6IZoLF+bROOvSugO27kQE+JQfzZdiZPj4QNfkT9FnYrWKcb61kw3yS+gUgleWA1+9Cp5jrDwxyYj/gsbT1mF6/PnvMFeVtyZ7gY3PBJeCTFy8zTuo7cMXo4vnvpz5/aYxmyi/co/8KI37K9BDV0UgTApYa222x1KdjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbhM9WlB1ueatN+DgszMoSlJVh5HvIz262X7r9AWAY4=;
 b=Stzcl5Kpg02Yg2rgiT1XiLJVv6RLeP4BXcKkfK7DBrOWrFfMMezXdYWHc/S/GYqNkXpOgy7/++3PPwnS30ByR+aUCRpHLQmCmkBtJjLflBT82GGke4Pcpxmj+SFbJReYrtSWBugZoDdXHpUDnx0Mdf1bbvK+TtZq5iVYLZ9cDSLDC4JGQ9526JfIMUqnjryYndgm9e9HoXUgjrL9UrxA/pGlaT6pYrX6w6A459vPwQZBwQ2OIjYDtDdMsgaJrzS1D0sGmgJVFnQiQvvAnw19Zqgpb51mYUu0V7QAgp6aRZ3b5bKBzsiUVMUhQOhzkmi+KEWLPBWQm5n2pg7TgsyuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB4237.namprd11.prod.outlook.com (2603:10b6:208:195::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 03:29:36 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 03:29:36 +0000
Message-ID: <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
Date:   Thu, 21 Apr 2022 20:29:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shanahan, Mark" <mark.shanahan@intel.com>
CC:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
 <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
 <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
 <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
 <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54700f42-7ed6-4f06-e123-08da241052fc
X-MS-TrafficTypeDiagnostic: MN2PR11MB4237:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB423764160458AEEABD2A19EAF8F79@MN2PR11MB4237.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMWDPtxeQmzY9a4SvX/zaRU+B2yzL0NOGe3oGkEjjxKkEEFbGm7qvL+GRXxQIG1cLi8uqrjQ7F19HGG6WonJDtCv0UeHty8WkAkUkBQTYQvPxqMjq8CZMYTIk8C+QeLGHTxhoSjcSS5/IeeQ7ldkfjVu2NJHyQ1lrdBzNzF7E7UB1WZUbT6UH55TIRxNoW8eBDM3zI+9MxyA/IMK8W7FBQGHTSP/B8LDs1DTQ1ru4bNpHiqVTJcERJQZIJZfbveZabp7SxyzshTVW+D7G4F/3gulO06JOBuIk4pa6L5cXhhee45toOZ3HKBDtVFRnHIoqV8Nyld974A7euCNXx3SMaoKQHl5Vf3obrgXZOgHGW2NwJy1Pv+eFK9qx9HW1FCXE6yf3c6qoLDjcKFKhW+B+V/QDxPZkYMxLIcm1KECk3Kf/Pq58hF2B2n1qX02N5cw+2CYCgZq5CgcWDhjYHfgRcakHX5Cicded8ytXXcq9JKM7emKF9AxQpP1BK+Hw4iI7aUCaUmUmawQLwJouw+/B3arZjcrgIaZBy5fXTEwCcO5DOopIonHI+prD3jVRb51aTJUzQD4i87zqHiFnKKNQMicrpoQCInWeZR3V6qbmcaQfU6kTmMKS5wQfpTxkEOaKMNaibEnjxvqrH54r+CMNTNF3dkr/xJu4iuQHRr7kq/QPGTAHshPpd52Vie4qIp+/vjrESqZ6WtoUtuuWZAltOkqR//c3yiVQmIGH0UHqpmsh8ELpRPXSFaYZsq8AG2Suc514uyD2feQJ48bOrOZBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(86362001)(186003)(31696002)(44832011)(508600001)(316002)(36756003)(8676002)(4326008)(110136005)(54906003)(6636002)(66556008)(66476007)(31686004)(66946007)(5660300002)(38100700002)(6506007)(7416002)(8936002)(6486002)(82960400001)(26005)(6512007)(53546011)(921005)(83380400001)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2J4TktmN0hkWmwrMnV2ZlBPUXhJaktiTXo5K3lYdzdnUTVrbEJzVnMvYkd1?=
 =?utf-8?B?bmJLN05CRHlKbXh6TDRXUmI1T05BTDlsaTlPVkdlY3NwUUZPZ01Fc0xiaEVx?=
 =?utf-8?B?cmpNbStaTVIxMTVZRDhOU1RiaFhLLzEwSXNaVm9ZRjk3WGtmZXpNUVQvSkN4?=
 =?utf-8?B?TDEzT1h2bVR3WWpBdVhGSHRWdGFwdGpGYS90Qk9qbE8yTVBwVTdmcFdCeERa?=
 =?utf-8?B?UHdkS2hqblhWajE1L3pXd1ZnQVA4MTQ4aWdGMVZzV3BYb2tNb204UHVCREVG?=
 =?utf-8?B?RXFDVjlqcFNZOWszRVlTbTdyN01EZWlZVWo5T3NDQUtFVTBMNy9SU3pnQVdZ?=
 =?utf-8?B?b3ZMUXhtanpjdWM4TkhCbWgxVXpabFEvdTRFRlFIWVlPTzlIWFRtT2ZMcnYz?=
 =?utf-8?B?S2xJaVZ4SnIrR1djZFBRKzBsbTE4SzVZN25ieUxiQnF2cXJhN09uVXpXZDl1?=
 =?utf-8?B?NHIyNHVFTmY1NzdHcTBKbmtYcCtEOTF4YytoYTRkVUJKU0VacFd2eVdyeEZK?=
 =?utf-8?B?aU41Q0w4Qnl2bFYwOC9BUmVwM1lodWFpVHNUN3RpcEh0YlhnUWpZaUxQMGhH?=
 =?utf-8?B?N3J4REVDc2d2WVg1UEhvYTc3MFA5eTdYRmx2VzY2Y3F1eGk0OW44UVQ3U1JM?=
 =?utf-8?B?bk1Wb0tZUitQLzlGT1BFSmhBRURON01QdzZJQ0FadmNlNUVxZ2dlWVJXS29s?=
 =?utf-8?B?bGpoSDRQeXAxdXRHRFRsckRML1d3TEk1RTBkWlNSRVJzYm9kZFNpYVNET2V4?=
 =?utf-8?B?dXlLK2R4a2JHVmtpSUhmRXlVQmZqdktXZ1FqUnJjbXgvV0NsYWhNV29aSlhP?=
 =?utf-8?B?Ylo0dXB4Tzg5VFFFUU90b0FiMVY1anlRV09hRTZ2N3FXNVI0RFcrR1JiTHVo?=
 =?utf-8?B?TXA1eVVDU1Jtb2FKYWNuSjNkVjNWVnA5NWduSEorcy9kR3c2eVpLcmdCaXBv?=
 =?utf-8?B?SWxvczBWWGpsdXUzN3RhUThENlJNWUNrOXZZTkg0b1d5UzluMDhkSWh5Nlk2?=
 =?utf-8?B?SkNTMnZQR1J5ak5sVy93V2Q2REFoZWhjTm0waVFvRnFHR0o2OW1FenF2OW5D?=
 =?utf-8?B?bFh5SnIwcFRyMlI5blQ5TjlObFE4S0FtOXR5ZnkwT0pQb1NGT2RzY0FYR0VL?=
 =?utf-8?B?allXc0d4S3dITTQ4MktLOGV6ZGhvQnRtTlZJbmNUbGkvRHk4VFd0aEt3MFBY?=
 =?utf-8?B?b1hJNkFQQ2RQdHRTYTlESWZiTHc0QlMrL3FyODhLL0t0NitxOHhSZ0lLeXds?=
 =?utf-8?B?RUQxS0NaZWUxZHI1NXFmRnRaTnFncHZyazI1MkJjcWlUbHZoWUNuNkYwaHFr?=
 =?utf-8?B?WittUFhEbnIrTUxybFVoTFdJTWdaa3h0TFY1cVMrRkppZzBLVzRBcFQyYS9Q?=
 =?utf-8?B?MEg5ZU5rREZDeVRnVDIzbVk1SGhNTzBYeGhkeXIxYmZFdlpvYWF6NllIY2d6?=
 =?utf-8?B?bm5kekg0NytiQjBsRDNPUlIybmVPUDAwdHRHcVpPZVlVeTF2NXZuOFB2T0sr?=
 =?utf-8?B?T1F6V3QxYys3eTF3TVdnNWZqWC9MdTBhTTd2VW5pVHVEdFNWWlFjdGR1dU5D?=
 =?utf-8?B?NlZkZDJPWDFZWUZsRm1tWWZqWm5KdjBLL3pTVTBRdFBkQzFoVnlyODIvQlRS?=
 =?utf-8?B?c2VTSHZGM01SSWYrQ1owYU80aEIweTZRbFZ6b1JPUUlwd2ZiWEV2ZGltMXdM?=
 =?utf-8?B?ank5dUtOMFJ5alUyQWhGYlBEMWVaQ2gyeE4vYXFCVEZSY29MWlUxOWdkM2Zm?=
 =?utf-8?B?UUN5S1gza0l3bUw2bXZxamF3QkRZMXYzd3BCYUpKNDZnbGEzRHhDdjV4NDlK?=
 =?utf-8?B?bVpEL3Bvc3htaHZ3Vy9mYlZFSktBcXlSamczTHJlbW1vU0ZHMEc0ZG5vNmJi?=
 =?utf-8?B?RVdWYzI3VGMyN3JWWlVVMzFNdjlOVmg3N21oNVN4Lyt5Wm1vZkZ1bGFVNjJt?=
 =?utf-8?B?Rk5UZnpGTEdVS216NXkvVFg5MVdDZTVlN2VJb3o5d1p6SUdUenZ4cG9BMVpp?=
 =?utf-8?B?Y1lSTzdkUm1qeWRvRXZBSUQ5Q042ZDZuNXpmVGxZQ2srTjJkMjhUcmRjZTd2?=
 =?utf-8?B?NW1pNXVFUmpJeXFEcGUrdEpwZzk4MjFxQ09VcFpKUzRJQUo5d3ZYNTNScU9C?=
 =?utf-8?B?U1Y2S2Q0L094K1dQai9pWmF1QVE2ajFueGQ1VjIwZzErSU5wbjBEUEpqNVBO?=
 =?utf-8?B?TmtJWHZpNFpnSW1xQjJyVW9FYXFpd0dmcVI5WkwwNDM1cU1SeDEwTzVUUjVX?=
 =?utf-8?B?ZmxZbFNqelQvbS9qSkQwcjRqZnlJWGFQRHE2cnBsOHdqdFk5Mk9XYmJzeUtK?=
 =?utf-8?B?aStpemdTdjB4RnN1U01iZXg5VmwzcGFqVS9MUnM2QlQ5U0dEa2E5Sk5jYWxE?=
 =?utf-8?Q?e5xwsKyw8ABaZYNU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54700f42-7ed6-4f06-e123-08da241052fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 03:29:35.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/R4XfwzU+WBbA1AcQtcG0bUCSFKpzoIHyOKBf7azmSgEcC+mQYgMwUyjF9NeVUdA6DLomX+ZVkRO8LqnHKzsopJWNlLcuj6N7sNc4g2WTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4237
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vijay and Mark,

On 4/21/2022 4:46 PM, Dhanraj, Vijay wrote:
> Hi All,
> 
> I evaluated V4 patch changes with Gramine and ran into an issue when trying to set EPC page permission to PROT_NONE. It looks like with V3 patch series a change was introduced which requires kernel to have at least R permission when calling RESTRICT IOCTL. This change was done under the assumption that EPCM requires at least R permission for EMODPE/EACCEPT to succeed. But when testing with V2 version, EACCEPT worked fine with page permission set to PROT_NONE. 
> 
> Thanks to @Shanahan, Mark for confirming that EPCM does not need to have R value to allow EACCEPT or EMODPE. Given this, can we please revert this change?
> 

Thank you very much for pointing this out. I can revert the change
to what was done in V2 where the only check is to ensure that W requires R.
This is a requirement of EMODPR. Could you please check if this snippet
results in things working for you again?

---8<---
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83674d054c13..7c7c8a61196e 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -855,12 +855,8 @@ static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
 	if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
 		return -EINVAL;
 
-	/*
-	 * Read access is required for the enclave to be able to use the page.
-	 * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT] require
-	 * read access.
-	 */
-	if (!(params.permissions & SGX_SECINFO_R))
+	if ((params.permissions & SGX_SECINFO_W) &&
+	    !(params.permissions & SGX_SECINFO_R))
 		return -EINVAL;
 
 	if (params.result || params.count)
-- 


Thank you very much

Reinette
