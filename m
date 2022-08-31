Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9FB5A7BAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHaKtz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHaKtx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 06:49:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3F646E;
        Wed, 31 Aug 2022 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661942991; x=1693478991;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jjR8M7HxCRAG1lPIRX8h7AISPvLtmNtbtROo6f/MTrI=;
  b=ZwVUNBv3ZAHNhGViqUwYhgp8ky/JZ26wgvXxZn9wGLY5I6nI1S7ihxsl
   I0Sir0jzMeiOXfcj4s+MQRGxwJnuSJz49tsYrXnWMe0/8jQY1OJ2HHEaO
   JUpSZ452ocguOCT73WZKQwl0xK0WgX2Pnsg6ODXO2R+QXZMJlQfA9zac8
   lfa4zwVixvNmM9RRx8xxFCjPgqBswoZtY5k0bIWQdqsTwS3SeSm7uHpv4
   DdFCwcGjubZ2uP8F56c340uPoEH65heMw+4e/S9mKS3nbaYdeVezZkQf8
   TzO6P027qH6w7hRDJEAr70Std1d2G3nnJDZt3uXKLvoiBBBMbyBd3aCMz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275823990"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="275823990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 03:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="645194604"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2022 03:49:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 03:49:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 03:49:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 03:49:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 03:49:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Efb6pyRwhDHosGRApz8f9xvaz5DHnFoYuV0GyEgwnDTCDOld81EAUrJCyeoJaX4WGabIIpeac7WZUSZ6kyONQFVC9Xy/Y0UWaIsRfhvnjDct9Zjmqu9whk4z27CdzeKYT4x/3LlZvDXrPfgsJefOL87yYpQRd3oce/0p+73XV+jkNWpyLOly4vhfbirma8tJCsJny6ZUGo7BWI0ruLVFGvgPWD6W9y/1LePYcqhFs0VBC2ux6lPSGNVmJWpIw/AwAXsM/nlmCMREma7OYXfeWhk50FW44iXKO7Bm8+mm8zC13Uj6O4pXVRiNbU/Jz/gBh23f14TJ3xlrPaCchZvVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrrtLZQAQ+/fwtXZg5xxcSeLtCPITtTiK2Lozt9OwUU=;
 b=hX2OFulbYJI1wi0T8Pk1T1+ZVCpLnV8xfANZBEesE+GCLr7pZKXpB6ot0yCg48JEYUzhVKJfn2thxggk++h74YAuLAIp1BqMS9QZcW8Xs7wgv32tTCqbzTUhmf1XNlnPSgEKSunHPZ0ctYMXKJhZhXyPRjaySC/I6NCmKdRiZw+RLl0QzE7gvKNMYaXnqJDiOiK7v/rS80ORCnNgmONaWnJANC1q5HZODl3coM8IyK0UlFg+puKRzbxR/3E6+ttVx8vduo1NGa41hJYVWu10mXxwC+FxyizZKAMeX9tawFUpqUf1Vr0eXFSRVTEHsDkrVlHCNnq6jwT9ds062J31xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB3996.namprd11.prod.outlook.com (2603:10b6:5:196::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Wed, 31 Aug 2022 10:49:49 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e%9]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 10:49:48 +0000
Date:   Wed, 31 Aug 2022 12:49:41 +0200
From:   =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To:     =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>
CC:     Isabella Basso <isabbasso@riseup.net>, <magalilemes00@gmail.com>,
        <tales.aparecida@gmail.com>, <mwen@igalia.com>,
        <andrealmeid@riseup.net>, <siqueirajordao@riseup.net>,
        Trevor Woerner <twoerner@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        David Gow <davidgow@google.com>, <brendanhiggins@google.com>,
        Arthur Grillo <arthur.grillo@usp.br>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/tests: Split drm_framebuffer_create_test into
 parameterized tests
Message-ID: <20220831104941.doc75juindcm5mcl@nostramo.hardline.pl>
References: <20220830211603.191734-1-mairacanal@riseup.net>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830211603.191734-1-mairacanal@riseup.net>
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28df23b4-9a0e-437b-2f74-08da8b3e8650
X-MS-TrafficTypeDiagnostic: DM6PR11MB3996:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NY1kqs/vVudugLuITOe5+qME+2SsJgWsSjjACao5akk6egu8kIkBdkYOTcJ1gek/P2e0WWStSPkfPBEAjzbSEGl/Ujux3+g/1i/NESAWmfz3e24qiJozhEumAzsqJfbSgRGe2JZTpHuuMR8KQn3IsQJQxPzeESQW/R8r2LWn/uq/+wfMvXBkdcPL3fHAJtsctH+NGSbStKdovRUNfo8xzc0oKFLNheQVX8XHFuXY1kSxN9dUQ28S5YEjUcEQalzzm71LMyYtzKdMi12tovUzN14mElBOBVNjICInTOaDMLX0FMP8TybgpbQR/ms4ODjZWWNCKdkn+Ug3SHOdZRbhBxczGecqyhKDNFqgJURa/W/cN79VxBvGacsX3+UGrKTCRaubpmagwgSzLA6cvhBsh/AEyJbfmjyhjGsTmUF97aQtT+3oXrqW0xCHZOSYPYoeWnKnZ1Q5UrATePusc807YZiAAc+XJC29qVSqoKXS4iJZ8LNLKT1tHEXom7cs2ky+eBhqLv0wD+4vq3hCEeN9jF4ELNP9McBPPOID8v7oDjRWCBCZkKW9BfJjMN/YIKSs28wX28hGlfNg85CISrdjN8+7oojNETXuAoaDVQw12nbks1gPZEYfhgdmbpdNLA2di3A/Z/49BVqZoyf9F12099TSF6p7LXZxpUUOhhHxE2GTdfduvHvHQyswXgW2coN2kyosZjt2LA70mCIUhaoQ5GoBfzwAZS3uAg8wcjotUS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(366004)(396003)(136003)(4326008)(8676002)(2906002)(66476007)(7416002)(66946007)(66556008)(6506007)(8936002)(6512007)(6666004)(478600001)(54906003)(316002)(26005)(6916009)(966005)(6486002)(9686003)(41300700001)(186003)(1076003)(83380400001)(38100700002)(5660300002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJyTFJObWdCTWZ4L3NIdGRzUlVMT2t1MVAyRjRZM2orWWtXQUc0ZXo5NDZk?=
 =?utf-8?B?bXJJbWtjdnVYUFFxNVJ4bXppUnVFWHc1REFOVjhkZTllazYrZmlvK0doRHdt?=
 =?utf-8?B?ckpXNmR5UWo1bndnNjBlMU9vQm1EajhGcEtNQlBaMFQwZ1lRaU5UTUFaVjNV?=
 =?utf-8?B?QU81eG5KZVhmYTJCb3FGUzFhZ0VyZ3JJWDZEbWNHRHg0bVYxL2NZOHk2d1Vo?=
 =?utf-8?B?Z2YxQmdjWTdkNEx6T1RFSExjZU9xWmFvakdVejY0cWZzbzdHa3gyZUY0azJv?=
 =?utf-8?B?cjlHM0ljNGZXSEJ3dk96aDFwY0tsZFFlNndKNk5TL2JJUFVRZzM3V1gzZzZw?=
 =?utf-8?B?WXU4TDRmak9VTy93Y3d2cFhFN1lQVnJPUFhqUFNFQVhrVXh1cWJmOEk1ODFP?=
 =?utf-8?B?dWk2bFNTUWhGRzE0RTc1MC9ManZzRkQxWHhXR0hRNkQyQStvd3RDSHZ3Y2t5?=
 =?utf-8?B?aDUzelhEQkZGeExLTTgzUE00UFladW5lRnp0OFMzWlIzakhwVHdkVnJyellO?=
 =?utf-8?B?cnZpQi9EWTVvS2gzdE1vZEZSMko0YnNzVERXTmo3cWpFOFBrM0RZZVpSYjhC?=
 =?utf-8?B?VVRjNmtCY2djSGxPSzYwQmh4cHNKQjl6a1duL3YvbG50bDJmYVREcnkwOURE?=
 =?utf-8?B?dGViL0x6SlVIUnlGYzJXYmZyWWdxcVR2Yk9oUHROdllNa1lGRUFjdW5mMVQ5?=
 =?utf-8?B?NldZWjBMZFRFQ3BGZGJvajYxTWxPbS9ZQlU1N2c2aHVzVFBwR0dyL1JZdzBr?=
 =?utf-8?B?TG1yUnE0U0U5djBycWh4WCtHd0I5dCs4ejJYZmwxMkZXaS9xcWpab3ZQUDRK?=
 =?utf-8?B?aCtOVThpWDNqSVl1MkxpSWg4M0VFYXFsTXdmRmcyNmMyT1poVXlhSmR0UXcy?=
 =?utf-8?B?KzdrcVBkSzg3citwWS9iVnVvN0k1OUJTOWw4YkhpMGZMNDMxN1I0Qk5NaThX?=
 =?utf-8?B?d25scTg4ZFVOWXV1aFF1eFdJZTR1WDlWTnFKcFJjZnZnZHVRNkExQUlPdExN?=
 =?utf-8?B?Vi9kNDAwRmh2VDZ3VTlGMTBodlZvdTNPUWtaUlROT1RDRzUrSE9aUDNSaWtp?=
 =?utf-8?B?M2FHYnNQU2haTFVJTHBBV3BSZjIzdjdrS3M3QUtQcWllQjVMdXdiMXlSOE1J?=
 =?utf-8?B?VUVMSFQrOUJFejlKUU5GS09iZHhQc3h2eG9JcE9sNzBWa1Fwc0g2WlExdjZh?=
 =?utf-8?B?S1RSMWRpZzVCZytkaE1DUFQ4TnJFaHFmS1I5eW9ObTVQZGx2L3NmcGp5RGRu?=
 =?utf-8?B?Z3E3RGwwaVQ1eENWbjYyL2xQTDl5SHR5QzNRaTYrR0tpcUxtK05TTDVFRmZQ?=
 =?utf-8?B?K2p0MzFNWE1iMFh3V0tVYjZkWjhla2Z2V0RoYWkxTVdmb1Znbis2Qzd4bWdy?=
 =?utf-8?B?SXNDY2N0Q1YyZ1FQT3dQZUZCVUVxUVVUK1VKSGkxRW1wb0RHdmhVZWJ6a0lV?=
 =?utf-8?B?azl2aTVDaGM4OXFybzh2dFZtWVFmZWZqM3F1S25odHhnM3V5RlpXS3hTMzls?=
 =?utf-8?B?L2tMdGZ5NlNBTFhrTWtqbXNuMXNQb3grbUpkM0R5T0YrcGM3ZzF5a1FRMXNZ?=
 =?utf-8?B?MkdmSUdkRlNhNGxKazhjbmVHdTVtZzltVU5yamMvcDB3Tk5McDZhMGtPakFC?=
 =?utf-8?B?SXYreWxZUVlCaUZzNEFCTlNzZGJaZmdjc2pJaUQwTlI1M09RL3RBVUFrdUF4?=
 =?utf-8?B?NFJ3eG1oUkJPMTNJL3pCSnNScnlzRE8xUEZKeE1BZ3B1dGc0L0s2cFJ1UVhD?=
 =?utf-8?B?d3JkM3BQUWg3Vy84QTMwVUFaNmU5eC94d0V5ckNtVkdqb1Q5MlZEUWtiNXhO?=
 =?utf-8?B?ZTAxOEVoZ0VoV2RGMVZWNURoU1Z5ZEVseXNGZks2OU1oTGoyTERSL3RKR2lX?=
 =?utf-8?B?YkJleTNiTzlFeW52SmhnTllUSk5CVE9BT21sUWZYR1VCREYzc2JuSmxqcU9Q?=
 =?utf-8?B?MnpScnQydGw2WStqWmwvMlVBMElhTDl6SE1BS080Nm94OU5YSEdQeU11NVZN?=
 =?utf-8?B?ekNZdnA1d3AwelhkZFJUeTl4ZEpKMkh5NWxCZlhCQW5UTlcrZWVuYSs1a2RV?=
 =?utf-8?B?TUdEbXl5T2ZiL21CbnFPTWp2YTU0cXo5Wk41bVlpbm12eVVVc3kwWGUySkJQ?=
 =?utf-8?B?MjBhdUdmallSRVcyTnlQeUtiMGNkb0VyZjNPQXJBWkJVZWlHTW8xU0k5QjRI?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28df23b4-9a0e-437b-2f74-08da8b3e8650
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 10:49:48.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXGWuphzuJvGZ4RtAljYO1y3HeLcFqxe8JUYkmxFnq/4BjaGzSZhw6LK+UQk6srJj2ky6x0o9TWTRjn8TNPqNf8AeCRw9bau1/c0M0SW3Ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3996
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 06:16:02PM -0300, Maíra Canal wrote:
> The igt_check_drm_framebuffer_create is based on a loop that executes
> tests for all createbuffer_tests test cases. This could be better
> represented by parameterized tests, provided by KUnit.
> 
> So, convert the igt_check_drm_framebuffer_create test into parameterized tests.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Now that we have separate testcases, we may also want to consider using .init
for mock_drm_device instead of a global
(see:
https://lore.kernel.org/dri-devel/20220117232259.180459-5-michal.winiarski@intel.com/
for reference)

Either way:
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>

-Michał

> ---
>  drivers/gpu/drm/tests/drm_framebuffer_test.c | 23 +++++++++-----------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_framebuffer_test.c b/drivers/gpu/drm/tests/drm_framebuffer_test.c
> index ec7a08ba4056..3e46fd9f6615 100644
> --- a/drivers/gpu/drm/tests/drm_framebuffer_test.c
> +++ b/drivers/gpu/drm/tests/drm_framebuffer_test.c
> @@ -25,7 +25,7 @@ struct drm_framebuffer_test {
>  	const char *name;
>  };
