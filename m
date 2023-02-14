Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226BE6955A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBNA7t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBNA7r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:59:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057861A962;
        Mon, 13 Feb 2023 16:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676336385; x=1707872385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gmqNBEhWe1lARTGVo4ehrKvM2XJMV2fquCh9sHETlQg=;
  b=CflPCvdNNyq++9/618vK0cejiORAkN6e2wCHvZB7vFRFwzWP6GN0y/Qd
   QGnupnqOOcYYXIbdGxcBg7x5T6NSBd+xmnrB9hBLHeo9uY+EKM83JlFLl
   qoISTHV0OIin9HuQoBFPae0e9wrRe/O6VynUaS0DkEP4KTtWsB8EbqFOq
   ribHVXr5qQqAZqsw785Ya50yM+s0NYR8ufiaYfA8caHFROUog8AwMzzIN
   m5z+xInRmkbWujhpGA8SbKO+fY0Ywev6Mpbvhgr1Pw4V1VvzHlfjIbIJC
   kYLXIvBb4QCvGllKHHLlZYZItVv1iu4JqNsxnem7UU2e64a3WzyqdodHf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319074340"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319074340"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 16:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757794480"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="757794480"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2023 16:59:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 16:59:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 16:59:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 16:59:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IekL2qR9X0Z4ZzB3qhkIvfIrdx4lmntdI0nkeS0FO0ln+DoAIhONuJt4dBmwfvmBjDLUqG+sIZuBle0uxKRvM2aRiBmwvRdxx/eLPpRzfXlHgh2xSh6q243Foga9Jh4XUkm4PVQA4znbR03csQ1aI9cVfGmphCeMIY/odEuKeS6sHJGD3LEDOe1ZRoKJcu8bNf9bs7zJCw1gpde7LO/WsKFyuZDK2sx+YtYWXgHg1v03nXbIEvqyLkyUI002T8KJHRTXwEzFzoDmyMH5/Ua/GhG301oeiUq0miqBzsL01ClL8SOjFgc3uBfnJnZbsDkiTQ38JjnqS+ljO29teVw4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awAX35vb8moHQ8XbM/PX+yJvyiijP8v6olbBSbm/Yf4=;
 b=P0P9gqZjbl/3Q7F7tzjHCamKQ6eAf0Fb/XVh5YpPEFXBiezaXPnJ840JvO8CMjYd+dVbfG9IbpAXAu96WlCgz2eT1iOkel+S92WTbXUxGkRI/svn33T6f23/RBQMKcsSbrHChWXRS17LeKu2iAgDMx46B08AqKwkvqKtS1c8lPepmAiRTrILpKbkj+54L+xM6ttqECQcXojR12oRINK40itTPM/1gtltvjk+Ll9Z3bIQ0pmyLLAQxIMIavzIW6lNvrnOoepBjb9h57+ZV4mzIBt3/Ubfsx2RJ21VQwxq8tIvrzhvFk+ci1BrFq0lORGlYKSHCG4BJ/DeXpySpITHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 00:59:40 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 00:59:40 +0000
Message-ID: <cc22ef3a-31fe-d6b0-fb68-fcf61965cedb@intel.com>
Date:   Mon, 13 Feb 2023 16:59:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 3/4] selftests/resctrl: Change name from CBM_MASK_PATH to
 INFO_PATH
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
 <20230208094026.22529-4-ilpo.jarvinen@linux.intel.com>
 <2078baac-27ea-096-3a13-b88fe10aa78@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2078baac-27ea-096-3a13-b88fe10aa78@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7430b531-2401-41e1-50cf-08db0e26c010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pijGM5SEvXF5Kg6EskaGUiZsF45b9sZpLNcZYgkrEPNUiozZs+yg7WZWHi0qmisOIRswAedc8R2p7A2uq/Uy7JtY7XaJmjkNvrCUidIKty5qBh2W7NA0T1apNZqLqtM0dBtHXqNdtf5KBipW9BGn3UvUIBkHjSWOn+oBd8JZjt7vruTzU98Vpm7CztLwUojhTWB8m7Yz6tABHKglN15kaeU5zJi5IZbm+QwctJJWUBL/6Mi9DNvnewaU233DjKRAeFFnCWw5NJg9SlUziejH/CKx72EvfDiu0SwjBucGNDXWqNFdFLs9lNvuHNIdZCC2SX4d1o9MgyNlinMDYkr249ovdVOkmlfWH3CcTTOroWgQBHhYmI2xQkJ0pv3jdLn6X/hfQFd3OgBKO9Hiqq6EUmDyLJG5ay6MXCc5WZvvyRvfX2ESipbJfiVq4vQ7cyypzGOns0GcwqLlZxLJUNnSEjbyatMZ6flZVOMXn2lIk1vaLkwzwvAWz/kWkBU9didTCbGpDyIgZoXXczi2SRaYKWn3xJwjtqCQ+kqtNweqyQr8Nkri9/UdVGCClhh5ZPgmAspv1vHKdy6Sk3WBpj68hOBAKEYxRyM7Vm2YCFM3jMXxe9a3f/s6+700QGk8mPt/cQgb97PwKR8/SOuaREvVgB/ghtk7wK15aJl/LoN7yOEynKozp/ZRxN5suBQbhhSKWEbbYWopLa17Ko1U1rEs5kri1lzLdMfDKsSKuHH6pUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(316002)(8676002)(2616005)(86362001)(82960400001)(31696002)(53546011)(54906003)(38100700002)(6666004)(478600001)(36756003)(186003)(26005)(6512007)(6486002)(5660300002)(31686004)(41300700001)(8936002)(6506007)(2906002)(4744005)(44832011)(66476007)(66556008)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpTZFdDV0M3QnhKNVoxc0NDRTJHQityaXFPRzlZc01VSTM5bVFmZU5vYjNj?=
 =?utf-8?B?eXFDN3lSN1k5SUtGZEhxemx3a2hIaitudXlScnh5VU1OZ2tSMzF2NU8ydTVS?=
 =?utf-8?B?SmpYQUsyYS9reUxBaVo2aGVuZkJDQUpwK1Z5d2FpMGhrc2U5YU1sMjJlbU9Q?=
 =?utf-8?B?cEVCU3RuWG1OcnRMQ251VE4zZ2dBWWtDZFdLQ0FTSWdOK3dCbjdJc1U5OXN4?=
 =?utf-8?B?Q1NWUUtMSDBDblJMdlFubXRMRENXOHk3ZnZ6aGd0eUdycUcwdDY4bEp0NEkr?=
 =?utf-8?B?dlo0RTRoRlpJQUhTY1JlMXkzb045RmJRR3pWcS9rU2xZQWlIdER6SUh1Vkhx?=
 =?utf-8?B?NXFsUUxnUE1EN25OTW9pOVcvTndWZXE0eWo5QVBOeURSc1dXci9wOWw5ZFAr?=
 =?utf-8?B?b0ROR0NRbThHaE5RTVJLMDR1ZWx6TWd1MkFreVM3cHlmSXhMVDVwZGFVam5x?=
 =?utf-8?B?MERjMm8yRWN4QU5mL3dOTXd2WkhiWXFJVnc5Sm5EL2VNNi9LOUo0T0MrWS9O?=
 =?utf-8?B?Q1FmRDFXUlpaTEdEQ3BVTTdXQkRvZlRDZ2dsVEs1eXpsWkNReGlOVzVRVjE3?=
 =?utf-8?B?eVgrZGFCcHRQK09kZGpwdW83ZEFGcmJIY0hxcGVvaitnelFjWU50NWJQVFh6?=
 =?utf-8?B?ZGJvN1Qwc05GS1QwTlRDdHJMb1B1bjNNMCt0UGwrbllBK0t3ZCtEWFZlaVRH?=
 =?utf-8?B?dzNwQ2QyeVF0ZXJvUW4xWGZYWGcvMnRJSUdQRlluV2lqeXpXR0hjUk01Q0Nn?=
 =?utf-8?B?aldDYXBCVWxQVW90ZXBXNzFCb1piUlNNejY3OE9rU3VDQ2lDUDZ2aHdzOGlM?=
 =?utf-8?B?S05qN29UaURsczUxSDBaN0xieGk4MDZwbTRONW9ITWsvcXRBRnBIbDYxRDd1?=
 =?utf-8?B?ZzBFNkdIQ0UwbEJnaU95bDh3U3RRdnNoREp4aWgvMzAxVFJQOVJvU0tBOERv?=
 =?utf-8?B?azBZY1BOZ3pyeXR6SUwyUnVuaCtDcHVvZkhDdS9uenZSRG5Ya1g5QitnS0tv?=
 =?utf-8?B?bW9JN2g5R0YzTGlOd0RDOGR0aEpnclY0ZEx1OUNGMGN1WG92dEE0amhubHdp?=
 =?utf-8?B?YmlKM0VyMTlDVkdxL3JiQUNrS1k4NnJEc0xhTlVsUjdRazVUQlQ3dTVrN2lL?=
 =?utf-8?B?dTJjdFFKb3dsK0lmTXpzZDNpZ0hWdHVSQ0l5N04vODJoc1pIWWZ5WXh1ZC92?=
 =?utf-8?B?bjA0Z3IraTZ2YW1SWWcraThQSytFNDhLWUxkVU5EaUNlaE1GaHk4S0Y2ei9G?=
 =?utf-8?B?SEx2V21GM2lFUUE5WTJzS2F0T2xEZ1cxejFmUUdYY0RSMHVYMktMRGhTV3NJ?=
 =?utf-8?B?SVZHb1dDdzRMWUdGU1krdlVvMkNZNFVNVDZZbHljYkl6ZHlyekJCK3czQUZw?=
 =?utf-8?B?WTVFVElhb2ZadDlvNUlEVEZmWE9RZHdkVVVQM0hqazBXeVhCQkIyWDFPamNn?=
 =?utf-8?B?Tk9QZmlybGtEYmRiMmhhOFoycVVvcHJmWWVtbm55SG1vWmpQdFloMFVJYmJW?=
 =?utf-8?B?UG10OUMxdTdPRG5paUIwUE1iWnVWUFRKdDhjRjgrZWZLNWhvL29vakJhWkVH?=
 =?utf-8?B?eUNEMmtxNm1OelVjQjEyalRQVGdPbjAxdHFKdFBLMzdqeDhnZlZTUWtnbm1r?=
 =?utf-8?B?cU1LaUxRVFFsRHdkY05XRU45WVVuTVA3ZXZ3eGdpcU00UWtid1ZHTXZvNTNp?=
 =?utf-8?B?Y0VZNFBTK2VZeVpUZGlzRzdLNW43SGZJY3VtNThOczFxek9sR0dZdlo0OWd5?=
 =?utf-8?B?VEk3NzZBNmk1aldiZkpreUVyR3VnckdpNlNseUdGQTBTdE9IK2N5b0pYcURp?=
 =?utf-8?B?SCs0cEdHcDVuelVtbEFkQjJ5ZUFMQzVnQnlIdldiR293cElVNTdVaUtuV1Ur?=
 =?utf-8?B?OGxwaGM3TVAxbnNrMzdsb04rUzF1Q0xNL2FLcGIwOFd6UWxYLzlISHlWQWdR?=
 =?utf-8?B?RXkvVm5mekVSVWgrWHlhdzRJVVdGMXNFOFFPVHo0Uy9lazdoUm4zbERjcFdT?=
 =?utf-8?B?N0QzdFA4cW45WmViYkJrck5PVjZFK1VGSjdQNzY4Uml2Ri9hOUVkODVCVzhX?=
 =?utf-8?B?cUdBR2pQZDhaYjJCc0paTWp4ZzMwVzNtV1BlcWcrdTk4eHp6T25PeDJqNVYr?=
 =?utf-8?B?SVljVTR1V1VORjRyNytwMWx5eEFYL3pZMWQ2aXh5QTU2UlFUOVNxK3A5cldV?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7430b531-2401-41e1-50cf-08db0e26c010
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 00:59:39.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MX0376h1YzR4+SdyPVFaUzgQ/0v/jyXLFqzR6kr/47O79mBu0rYLYpcHPMpbvhBX+pxIJ1a8E9tooXhorX6M2WGkQqp5cQ4SA2SycT0ZGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
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

Hi Ilpo,

On 2/8/2023 6:04 AM, Ilpo Järvinen wrote:
> On Wed, 8 Feb 2023, Ilpo Järvinen wrote:
> 
>> From: "Signed-off-by: Fenghua Yu" <fenghua.yu@intel.com>
> I seem to have managed to do a little copy paste error there. I can 
> resubmit the series if needed.

Yes please.

> 
> -- i.
>> CBM_MASK_PATH is actually the path to resctrl/info, so change the macro
>> name to correctly indicate what it represents.
>>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Missing your Signed-off-by?


Reinette
