Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0637DF918
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjKBRqe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjKBRqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:46:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812D131;
        Thu,  2 Nov 2023 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947186; x=1730483186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hdZeCzoPGPX9daNOri96gJ5Hbo0FDfbf5t4cwRncJmw=;
  b=FK+TDdywxLNaXlLJQxtHjS3uWjNnMzqArB9BspBy8HXph1lg/kDukj5n
   3CKNE4Za0fBiVSYe/24IgHHIr/Ua12aOYTseazOdEjh7jp87AZjmHC93O
   m2XvlbxFJVbS0lQbGXZx162ZwKpm9BnHrj3ajtCTsRiCoa8qoF+4nRLeb
   YypWDqDHQQBF8sMP62L0uuoVNId3Ar2/NF6Yhwj1elkMrlDhr6F8FCZqz
   Q2216xOpqzZYI+vppmGsOfmGQJ22D6UlP54BUQ3TVYNAIay2ngi8YSPHl
   cwWhOB2QCrKv/9XVcFzslVkpukDdojFFSUePooBIc1DThjNOMyLc3ivQp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="455257538"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="455257538"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="761349346"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="761349346"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:46:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:46:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:46:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlZjmQMVK1zpnTB4dRb3Jnjj8CKLsZYu2V+y4FvcBEMBTyO8ZHSaD598DwlyCgxv7HKKrPtZI3BAZamSz9Smh632R/OLjfYdic6aqWTe0gtqVqQhnVxo5Et7pJoX/dNWNNlgnbgsf5N06Pi2OySfg5D7HSLyZTgG9zbDSMpmSUD8oH1JuLsNDvWC+r6Xlj2RX+avvmPeXI5Lh3t9V6BAe0KlvS0HKpzU8wfNgAT3v0cVAYjw7A40pFwDc/8HhtIdxfnyiiEAq8c2VsvjNAOGGnSZppO2s4Gif7XOX+FD6J8QsqOvIhutG6X/Zai6DDW16Cl1xyhhm4rlFB9zdulhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxBigg/kZklnbdU/AcRVxv1bgMB2NnidDVeqk/uIKvo=;
 b=Is86zeYkVLx1mKqFhOruet/Tq3AufTAoX6/tMeOLcwm/uGxeM52RNIJD265+Aab8ILUaf7Y7YB5r6dwFpHiqxVR7O0GjadmGS/fEb5c0MGxdhOqvkejhlt0YHU4e/kswlQQ4ozEfaBmkumImTVFzrwTd8qgv7uVznLPxuLh40mr3ckSQ4+qCU7Ha3UVmVfgLiEkxcu6nl5XQEn86rZnG9YF2GwQqN3TgdWT7npQajGOwfZbcuTZ77CPc5kTlii14Caz4GF53nEFJVP6e0Jk0QRrtJZiX95INb9ThfpXqO9z3yHXj7WRaCYXXqQYNqXLWKmdOFkERKAVKSmftjE9kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:46:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:46:23 +0000
Message-ID: <1e948a35-b450-444f-ac1d-5bded729422a@intel.com>
Date:   Thu, 2 Nov 2023 10:46:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] selftests/resctrl: Split fill_buf to allow tests
 finer-grained control
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbcdc35-a8c8-4147-ce4f-08dbdbcba11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAUyiDET4RxampB2v9EFh4LYtqE55gzDig8W1Pl5qCFh6R4lWxWZmLiUHHzTx2s8rVKhNePGOrI22BNWfyuNHlJ0Ugs/49YaL1WlBxd/9DuHD6Ijou6606sEk5ibiWS76QGuDA90mJ0RUC1XCG04fow5i9Tdy8aGdDjnit5tt5/BNLZx6N+2PPa/MF9BkjIrb7TOkA+KjD7uTspHfp/QZI1uy0hRYxpAbD/k/plpcwEWmc2RxcATLdnyl1cLkYxiiHAbD64//L2winbpjNDqKxdv1F41CFI4a1hmbEb+v7gBfvRDgq5nBR6dLsoDTczM5aDHdw172TlWR0i/c3P/WqIvS8H4lFIZMke4s26tYyi6NXb+uY8xY+47Ya3RLtwGhRRIu4e1B2zy9tSqcQoIAyhKflNSREVd44XTJcHUVjIytqCstk0N2Qnzh/vv7Yjllrn/rA3ttnG5Q6LH/zPvulFl+jGbiH6jb7l8TrM2Q9jfbg2cFmoJyRIKY7ukRfacBnBdq2tbwdz6JnVooc9uGzQUc4TczIOmpmPeUpEFHl9c1crkIbYC85ur6JM2xn6W/Jp8b3YIFJC3CQyWuIbq2uBqBEQS9WmL5e18CUehiekxTy0fnRBq4+ZTMEFQOzKXbUrmTwdNGfN6IdZhRVIH5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(6506007)(53546011)(31686004)(38100700002)(66899024)(82960400001)(2616005)(6512007)(31696002)(41300700001)(86362001)(2906002)(4744005)(36756003)(316002)(5660300002)(4326008)(8936002)(44832011)(8676002)(66946007)(66556008)(66476007)(110136005)(6636002)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NQZ1QzVkRBZnFQQTVuUDVpWHFHQ1p2bmVMVzVabEJ2Ly85WHExcUFOczFP?=
 =?utf-8?B?UUROK3NGa2FlRVBOZGN2ZmNndFc1ajJWU0dQQzdaVDFVRk55cFQyVHJXeHYv?=
 =?utf-8?B?c292TDBqRGFyOUI1eC92d3crdUUvbGYrWTJQVElwZENZT05qckJTa1pjMG9o?=
 =?utf-8?B?c3p3U2dubjFvRThLZGNpbHd1OWFYNUsrV3lZNGgzbVhYNW83TUhlK0FHd0hH?=
 =?utf-8?B?U1lYcnlMMUo1ZW5nTmJNdG1Cd1dKRnRDNWlENVhHZGxFNDR3NmR2eGczNTll?=
 =?utf-8?B?bUxDOWZoYTl0SXRoUVo5YSsyaDhIYmUwODd2bC83TW5hUnRpUUFNSzlTRkpO?=
 =?utf-8?B?RDU5TDBTU0JUcWdseEw1WVhFbmNMTDNPWnlESjZLQlhFNEx4R3p1S2o3QlAx?=
 =?utf-8?B?MDdzSFNxdlRkRFVGNnZpL21INWFQYStXVEFHU0hkWXU1R2szVEhVVGtNUHZ4?=
 =?utf-8?B?dXMza1RkQm4zOTJNN0dJVlgyeDhUdUx4NndRTEFGNk4wTm9JcUNZV3dkL2M4?=
 =?utf-8?B?Snp4Ry93MDhUcC85cHllcDJpcUNYdHJMNU5EYmlCRnArb1BYZSs0VjRwcEEv?=
 =?utf-8?B?VnJEd1B4OHBaa2toZWIxT3dIUGVtWExSM2c2WXQrazNtbFE0RGxQQlptNm93?=
 =?utf-8?B?ZGs3ejlVdVVOTFQ5ZjRjY3ErTjVrWVluS2JCcHo1dTIwUHhES2ZOM1RtLy9D?=
 =?utf-8?B?ZGszYTJxUFpmNC93N3ZFMk1CNm1mOUJOVU1IZ051ZHN1RlFaZkVHSzkwUHdI?=
 =?utf-8?B?RW53N0d5eVhKUHp0aDlPZE9TUmNSQm5Nd2FodWtSR0tEYjF4UXNHQ2ZqeXJz?=
 =?utf-8?B?cnV0OElxRjRuVVUzNUVoc3ZUQ3RUVGhYTW1LQjFJZ1h1ZzFDU2hOZTdCTFlx?=
 =?utf-8?B?RkFEb3gvelh6SzFoQk9FL3VuaGxzZllRVTVlYUpJa21SVTRIN1IrdHE5cnpj?=
 =?utf-8?B?N0g0WE00alMwclc0UWQ3SVF1dFBjOWxHaGVzMEcxYzYvbFZ2dVpxalYydjlP?=
 =?utf-8?B?Y3J6SHpSZUlJTkRlNmdKcVpmTzdSTk53MDcyVFkrNjRxOVkrKzgwblJwSmFj?=
 =?utf-8?B?QkVVd0F2U1RjbENpVlZWbUhGRXB4dnRseXpzN2JkbmRKdzRNOVFyOE4xM1JN?=
 =?utf-8?B?T1JwWm1iQ3BIaWJMbVp4enRmeEtuOEowc3lXVytjR1o4SVpMaHZzci8vc2Qy?=
 =?utf-8?B?M3hMdk1pUjgra2IvS3orSkJXRWRIc1Z2cmVQZWVvU2NIRml1cWJZeGxRUTVz?=
 =?utf-8?B?Q1dZVnRWQmxHaWZERHJQVEtRMkE4TUphWWFQb1ZoMDBDdndtamJaMUYwaTdu?=
 =?utf-8?B?QUwwaEIzU2pBMkFwUXJkbXdVQ0YveHBhRlp4S2duOE52VVhTODNKUUN1Ni9P?=
 =?utf-8?B?eTUvN2QrNndzVnhBeFZBK3VwK3JaN283QnpEZHpKYXJBQ2hqSFlnOE9BTDY0?=
 =?utf-8?B?MjNLQWpnSlV3WWYzcGZsVjVjU3g1WFR4SThrY2FtaW53K3FEUlIyTGxMdDBS?=
 =?utf-8?B?OWhFY21QYVIzNkxtT3d5K3RDTm5HRkJRc25kYUxwai9aQ04vWDRPNm0vK0FQ?=
 =?utf-8?B?djJsTHdnbjYvMUFWS2xkbnFEdFV6N24vZ2tUc1RvZ1NxOGVEQjF1RDloZnJp?=
 =?utf-8?B?UVZMaEhEcXB5aHRtSStrNU5KVEF6bEdZZlRHajRRQ0hscmJTYXhINDZIQkdN?=
 =?utf-8?B?bEFSQVBJWFUya3F1eEx0SVlRZWxYYnZXMU5TL2I4MWJiS3E5eEt1RzFXaEJ6?=
 =?utf-8?B?LzVZaFdwMThiOGpROXpHbDhqTzd1V1k2RVczcENuMWQwS2Y3bEdOZmVBbDc4?=
 =?utf-8?B?UVc1aHFPdndZMVY4eWFVbkZQQURjNFhtUDJwZ3BTbDBvNDBnbGFCKytnaTE5?=
 =?utf-8?B?QnJ5cXo0TUdQWXcwTzVFQ1BsamZ6eWJINFkzT1VnZGNUNlBxVWpta2xHWkxN?=
 =?utf-8?B?UEl1ditDdHlaYVNTUFZZV0t6S2lkQkNDS1kvWnhHcFFqaEMzMEswNUI3aHNi?=
 =?utf-8?B?VUtXcGRnVExGM25NZzVIQlV0QmZhYVRYRysvd09STWl3dUtUaDkvOXNleTlk?=
 =?utf-8?B?ejJCdW1MbkVtZTVIWWo2Q3FOZ2d0ZGJJRHNIeVFIQkw1endscTFCSXlEUGR0?=
 =?utf-8?B?L05LOTVoSENON2x6bWtYWXBDVlB0SnhGQlM3aXhKY3dzc3RSb0Y5R1dDZTVQ?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbcdc35-a8c8-4147-ce4f-08dbdbcba11f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:46:23.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g72c/9sYyQ/xsDyYtL4OMvJNwkpQxB47PuJLvX+/VN1QMr3JkDk6Bn06JF+eE6ZwM18Y1WLhtHWetZf5Sk5sgJrhdZLgx4NwLofAYPkydEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> MBM, MBA and CMT test cases use run_fill_buf() to loop indefinitely
> around the buffer. CAT test case is different and doesn't want to loop
> around the buffer continuously.

Please do not that the changelog starts by describing issue with
run_fill_buf() (that does not appear in patch) and then switches to
describe solution for fill_cache() below.

> 
> Split fill_cache() so that both the use cases are easier to control by
> creating separate functions for buffer allocation and looping around
> the buffer. Make those functions available for tests. The new interface
> is based on returning/passing pointers instead of the startptr global
> pointer variable that can now be removed. The deallocation can use
> free() directly.

Seems like startptr removal has been done already:
5e3e4f1a03f0 ("selftests/resctrl: Remove unnecessary startptr global from fill_buf") 

Reinette
