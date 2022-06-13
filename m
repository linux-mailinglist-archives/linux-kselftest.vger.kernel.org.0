Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693B754A246
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 00:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiFMWtR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWtP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 18:49:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF93121B;
        Mon, 13 Jun 2022 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655160553; x=1686696553;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c0Nu7zmbgOfZ6os748hsNHhjt7hWIrwvsvJvi+oScNo=;
  b=BT7cg0ua6i3sj12LJKBEuTSXrTK5IofqZoo6+uue+4VW6yz8Fgs1296d
   1YkOBpNo7KGHT0RgBBqI3NyLtsZJlg0ns2WJAEcLEdO1G9xBf01V2N3vH
   1L4ng+5gK4fmwxX1s/VqfFwIoAhL/RMasz4y+6Zrqgltzci4BRZimVd5G
   c+zOEtrg51biiDoQppM7BWgX7rQB+7IJkqkN+MsLK79jc0B+Tbvrgn6+d
   I0cYtLH7ageC3Lv8xlA0Lvrs6aRsNp1FOmRaSNHq0fLD4XCc8W4p7kjH3
   MbN60aD/xGo71NTEL0rd5R8Xfhb3JZwxKlb13X9PF7X9kP+ueFeJaCWzr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261470436"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="261470436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="712215590"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2022 15:49:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:49:04 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:49:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 15:49:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 15:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeGQifwoxsj3kZx2pLei0IZetFsVGu30m8XnvvHBUokjQXVKKnXnz2veLdOwUxNdyHz91BkjbtFewlpysTGg+1cjTNUy62IDbF7ZOpWDmqrPpp2A10ApvAi6eGiIPgLM2xw4+kqjFdvgBJOF+pTtT7QUx/5jxrfb122uTjyfml/PfA3m/uoskK5AeWWdC0AyPkYM9j6F/ELWk2/++uCQtThyfLNlB8lRb/xPBzEvp3X4YaRa7+ZKuXiXbEFCkSVAF6wYZK7+vmtk/lSghUiu5iVGJAyQoryTXfU6GPMt/QB1XO5XlhVzncxLisQLWh545vT0JWYYLRdRCwSppspwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV7OtwJOcryd6HENj2hlm4j6DsoF1nF9iQADpf5kNT8=;
 b=URoBuiMA3s6u56mlJsgLIvfI+sl60UQRKtHIDAl9BHCpiJiPGUlAKSF+c6rwJaoo490R4wRUMoks1QNH+qLH34Fe3SGiAZ5mzAMM2wqJIbvei86Yqjjr0nXXrJdEro7vJj3SqqLraAuxHXT31pNMqsKirRzqwUO99ggSvu/vB37Y5v1sCzuQlAKudPu/cf3u0mWYJsSB++JrCiL2yX+NZCnP3f1qsMgD/+ywXnMa9yvyVkstg9OV0SoV4DL15UiMphYCk46fYPZ/YldomOEfCo0vIlA8TdIkcZOQq7d8SYbyOYpsEeTYyvxvrCLqJzbqt6GNLDELRFMbeLivG7Lrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN6PR11MB2944.namprd11.prod.outlook.com (2603:10b6:805:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 22:48:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:48:58 +0000
Message-ID: <86c1b1fe-0dca-ce26-874e-aa83e3c77e6e@intel.com>
Date:   Mon, 13 Jun 2022 15:48:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 2/6] testing/pkeys: Don't use uninitialized variable
Content-Language: en-US
To:     <ira.weiny@intel.com>, <linux-api@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        <x86@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-3-ira.weiny@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20220610233533.3649584-3-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62fffc41-0e53-43ef-8062-08da4d8ee6c4
X-MS-TrafficTypeDiagnostic: SN6PR11MB2944:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB29441FB84FE1EB693A696D6DE5AB9@SN6PR11MB2944.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWBeoKqMXCJLDNBZNJ1dqNPHYvPmhjvVHgs8mLmypr2jbmIeP2o2vtE/up3SeSSeu8/028ahIPpXY9YmE3j4tlRT0zrchRWTr12R2qVdm/WveH9zp9l8uyvm7zhamepppUseqAiYGvUCb26m4zaGZL8dzshSKm57R1C3etGLXdi5ueryTAqTf6COivOlMqEOwuUDUUXeR8VOI0KEZ4U41DBqjD8GjCxIZtmSZS4sS9p3U0x9HkUW5nUO70y0eXl2mRhHJy/FUpZRdxRUL/gyJ/3DKiJa13F3aTeEiKlaEKpe3erQYzVXh8hz/b6rw/cwFM6eCBiYTlUojAVWqgh6kDIqqNSSnyaWpKeJA7K/gDjb2WUJx6UdmuHE3KwAbLOX1rQYwaZtmrRqm8WBAPQjL5G2VqR+rqkS1GvVdAEqhL+xM9hPDnyRh8Xv0xMPo4k+dBjsdy9tu7yXhlCCR+ri6+e7sBi7I1Vg++Sg6oT+nJ6xN9UF9DtRkYmzpGo7M9CkhUITg/bVzo3Vqu6GApXo3uuNEC9tJNb/Bh/4Mwrb0Ox23DosuN3ZptPJrNsqfeyGMwRFwptWL3TWHMQWmdrcsDNhdzK1Wv6WLzJxJWjx7whf7FAbfzGT5tWRGNzS0ULrPCOuK5yvTVjIe7Ui1EGZVVPT5V+kuELk8HJh7o+cSoQVCmf0jrKUSuhPIaP6V3P1v/SlMttZFtsJOhD0C3IwUfQrpsoDF0w91HBQd/9HWtxzTyzcHXo5j4LSHt44t/6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(5660300002)(2906002)(86362001)(82960400001)(38100700002)(316002)(6506007)(54906003)(53546011)(26005)(6512007)(44832011)(6486002)(4326008)(66476007)(8676002)(66556008)(66946007)(2616005)(186003)(31696002)(508600001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZSaVZUcmFFUWtSeXlFQXVMbVNXcGx4UU14akNNWnd2RXNzVFdiYlp5WE0z?=
 =?utf-8?B?ZWw3ZzkvaTVRZ1p4WnhWSE56WUVrcnpvSHNKdEFVQnYyQ2NZQnBzTjhBRVh1?=
 =?utf-8?B?a1Q5ejZKRXBEc3E5QnhpSXg3TFpHNVRqeGQ2b3JucUNyKzFGSlNtTFp6WldD?=
 =?utf-8?B?UnZVTmEwWjk3bm5NelVPZjFoYU1sZFF2VENCRUg2YlpaZE9kQURCbEd1dHQx?=
 =?utf-8?B?dHZXbk5kQmMwMm84WFkrb0Z6bENKTFk3QVpzNzc3OXFPcHJHclJnaEZvekxJ?=
 =?utf-8?B?ai9tUXJsZkRPdGIxdHBHSVNIVndTQ0NLK0h5UHVCQWx3SEVaL2grR1ZNVU8v?=
 =?utf-8?B?d3RxZFI0UVcvT3BPay9NZjdyV25UZmNkQ24rRktXakYwd0REVi9iQ0t3VnMr?=
 =?utf-8?B?QjlXSkR4Tk5qRnJXWm9KRHpOZWNTOG1YL2NFdE4vYzZldXVJNUU3ZHdleVF6?=
 =?utf-8?B?Q3VmczFzTmFpUldyRmhVYW5SZVZjdnJ1WjJ2Y3RjWUdESDRNbUtoMVQ4VlBL?=
 =?utf-8?B?cXYvbmhPMENsNC8zRDlRRnFOMjdSNGxqV0xOSUpGeXZRdUJqU2I4TjUya2tp?=
 =?utf-8?B?WjMzZ2hvMmExOFB3dEdBSzZ5VmJhUXRUT0liRjhRMmtDVDhRZm5FQTlHQ2dL?=
 =?utf-8?B?aDJzT21kVjFPYWlzZ3d3QmE0MUV5eW1jdGJyK1lhOGJGeWdzekJJWDFPSHdB?=
 =?utf-8?B?R2piYkNZMnAvN2p1SG5OeFhXQTVtSDFocE1nNE9RMEtDcEJySnNFbkU2VzFD?=
 =?utf-8?B?TWI2NGNaajMrOEtJYU9BSzhFRHh0M3piaFZkVmg1ZHgxVUxYWDJxYjVyOW1m?=
 =?utf-8?B?UEF2Y1dDbEJmMEs0VDh5UVFybUdTSzVidUYvQldFNFJyemI2NUtjWTN1VXM0?=
 =?utf-8?B?UE1RM0JwZGVETzNBZXQ0TjFOdW16R0w2NGJUQUJ5M0N5RVIvRFBadmU3enl4?=
 =?utf-8?B?U3BScm5OTmdKcWZOMVZQMFN2d2RpeWl6VjdvWm1mMXg4a0RsR2taUDVpaXZS?=
 =?utf-8?B?UVdyQ3JtRzB1bUZiQlNtS1JuSXd2eDhnZGlEbnJzdWZCVWxoQkp3QWlNa3Nh?=
 =?utf-8?B?MzJmdVQrVXpKNXJxYm9DYTFjeUpkLzBTYmNpVlpDaFRwODBWUjRmWERmVHN3?=
 =?utf-8?B?eUhKNlNaV1ZLU1l5bGpMMk5DcUZ3ZFdmM1dwUVZiK3h6MzJaTlEwZGFXekhJ?=
 =?utf-8?B?d0lFeHdqUzNra1J0TXZZQzBBRzBZQUNHUjN2WVRqYmJJRE9jWm81eGdpSHAv?=
 =?utf-8?B?dlVWd0FTSFE3MThja3lNdEhSZkR5eW1vQU11VEEwMnVTTjFGRFZmRDNsOEt3?=
 =?utf-8?B?Qk5vbVZhTXlxWnhUNzZNcks1N3Vkcm84eU03TEhnZW9oWVVhR1dKNUlYYVJ3?=
 =?utf-8?B?VDdlRy9ISTFtbTQxTXU2WTZRNi9qeTVLWVJaR3RVckUxVTRLaDVUb2xGQUY2?=
 =?utf-8?B?QklFdVZld3FYNk94MUVjS29rbnVlRUhYUU5tc0dQVXZadHJTSTB2VXRLVkdo?=
 =?utf-8?B?a2JKR212RVc2Ly8yR0picURKQTdVUytjcHNYY2luUVpPT0dXdlZPVFEzRnpL?=
 =?utf-8?B?a2ZnQklqS3VNNm9iS0NhZElZSDZvQ2xJMGErdFRzb1BoZ0haU3Q0RVQwQkg3?=
 =?utf-8?B?eFBRbXAzU3J2Nk82NjIvQldITUl5U1JMYktQUi8vV3NCY1Vxc2lwUkZHV25H?=
 =?utf-8?B?ZXUveFhSN2Rud1VZN0JVSVVTa245TUx1MHdJRGU4NEo2ZlNTcDBwVmV5VEoy?=
 =?utf-8?B?YndZQXN0ZUZKQjdHaUFxdTdrRkY3bDJ5eFFFNVJLTnI5YzBpSjlyc1MvSmJQ?=
 =?utf-8?B?TlRQd3V1ZnplVWtJelg3M1pwTGFETnFudFZ1SVpKOXlwQ1FFN21wRk5PNHcz?=
 =?utf-8?B?d2JTQXllajh0MmdNd1Y4YXBzV1FqcklFdGtQR3B1TEx4cm1MRnkwNXdFVFZ2?=
 =?utf-8?B?K1NoSDhkYk5kMUlCYlh6aUZpcjBWU1I0R3ROK25tRmxaWlpHTnAzMzc0d0wz?=
 =?utf-8?B?V3dJSk9uelFYOUZEb20vNXFJRGNnK09rZ0tpTzBac0FwdGxuVk45MzI4ZTRv?=
 =?utf-8?B?a2NzOHhVaEVLMXExSnNHTzhjMDdFWTBQMzg2YWNMWDErUWttam10ZVMzb25S?=
 =?utf-8?B?M2ZEZ0tJZFVHSkJIcXVYY3RrUFJEQzVWbnRReitxczZZUHZyakZiemNBaGk0?=
 =?utf-8?B?am85SXZQUG5FcE5VN1BQOWIxN0lvY01oaHZKRUFFa015amIzNjJTS1V6OFow?=
 =?utf-8?B?L0xjMzJ0WmRyNFQ5dmJVV2czekJvQkJSbTRHYktBcEtScDFvSUtIRkNZWmt4?=
 =?utf-8?B?Ry9RRExwSHhNNzhSNVdQL2RsQ0VyMkZ6b0lONFpoWUNLOFZwVWhxS0l2NThM?=
 =?utf-8?Q?NHDwXg6jAwJ7isaE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fffc41-0e53-43ef-8062-08da4d8ee6c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:48:58.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtomSMUwSO+jHBtFyjqj9HySN7Vl/n4ymb2oPVbx3CYGmXzLBPbEIZb+tvpu0H23RnaKtXkMut2hVXcs+8BOBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/2022 4:35 PM, ira.weiny@intel.com wrote:
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index d0183c381859..43e47de19c0d 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -1225,9 +1225,9 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
>   		int new_pkey;
>   		dprintf1("%s() alloc loop: %d\n", __func__, i);
>   		new_pkey = alloc_pkey();
> -		dprintf4("%s()::%d, err: %d pkey_reg: 0x%016llx"
> +		dprintf4("%s()::%d, errno: %d pkey_reg: 0x%016llx"

What is errno referring to over here? There are a few things happening 
in alloc_pkey(). I guess it would show the latest error that happened. 
Does errno need to be set to 0 before the call?

Also, would it be useful to print the return value (new_pkey) from 
alloc_pkey() here?

>   				" shadow: 0x%016llx\n",
> -				__func__, __LINE__, err, __read_pkey_reg(),
> +				__func__, __LINE__, errno, __read_pkey_reg(),
>   				shadow_pkey_reg);
>   		read_pkey_reg(); /* for shadow checking */
>   		dprintf2("%s() errno: %d ENOSPC: %d\n", __func__, errno, ENOSPC);

Sohil
