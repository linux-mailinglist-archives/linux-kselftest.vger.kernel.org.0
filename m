Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304B49577D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 01:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiAUAtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 19:49:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:5276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbiAUAtB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 19:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642726141; x=1674262141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BOHqE21h944TgZssC+1IUbpfEZ1S13yQSA18fXz5JSM=;
  b=k6a6Mzxz873S03b5FO+dF2f81td4l6o2HmwZfpj4z1mHJEmcChpxIbLS
   /IIIXo0BDs7rG9l4pnLNgDfHfLA+ikbxHYPlJtOX0jQ20nCk0fRePPGrp
   cepNt98JncBb8QYO+tKFDt/QFqTfUwRICpWlMbg4gHpjbGk+XiRyLQDiv
   gC6Kezyz3auh882N/E9cFOSBphP1gKlRS5OUeT3AmOn7T1cuUItRwGXZv
   Dm+RC9ebrjMlmJyWRenNGxspS2rqeC9akYr95raLh3HqvwVTiTyGCUJ6c
   jjXgFLKofPwqJWxt26Y1mdGeLymrHJe1nrnlyFbBfIWecNrMD5JG5/SvN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245743985"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="245743985"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="531218060"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2022 16:49:00 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 16:49:00 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 16:48:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 20 Jan 2022 16:48:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 20 Jan 2022 16:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3izdPPECNdxY2wQwieY2rhaqrpOtdl9I/7RvqD8+ww6hro+Obmex2b9/1eYsX6Z4Mb/kN4a2TWkkLL5K3quilwsU1NxI/fBJmLw0YSqODT9eGCGgoJvTU/Q59Z8jGBKxU0kgOCeyT/JizZm5evql8DnlWCByupG4pkQN7FHYBPWHq9emYav1zXf3ioR7PO6gPuFtqpo3X038OLP9HPDjeH+beksl4erMZG4prJZdLzkpm69dNomnGnADrkzmXsvovMt4DYylSJta+nLHCP5Mae0K9lL5t5a9JbFWYYWYnyMMwAVkcgCpQeIpFJJzv5IQ46IbWmlcyrPpUZQD6cVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Nru5OgOyLGluK70Wn0LUg5ZzXDDfDsgUUA3F7AjJm4=;
 b=fHwNZGu/TyMgqilCkcFYOtL9MV0SNoTf2YejMRiJMS3c+PDvSuT5MYx1tz0mqiOp/O3ODokPlEvxzRuKJWnMUHVDwPrkGdnJZZQkf7IioKE2tiHSvzsBzar1SVuTTg46zfld6/MFRw1PNqDrDMyBsOBCOXvtGnRmSN0o0Tk7BbSTh4xhQIfEu3kj577ozRAoqs/ABm3uYl896PRQxNtn2y+dNRkADk8hC9md+rPDv5H2F+bGaiwLXRlygVW6EYaP18FuXproB+OKLUv1aWHkao0o0Y6DNRzZ/5vempsNrqArtZBET6vHbfAo4Zv+MQdCaE6OsQNeLs2dC2Sskjmebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Fri, 21 Jan 2022 00:48:57 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4909.008; Fri, 21 Jan 2022
 00:48:57 +0000
Message-ID: <22c46f5f-37c8-448a-6fff-2b0ec9d28fa9@intel.com>
Date:   Fri, 21 Jan 2022 01:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RFC 06/10] drm: test-drm_dp_mst_helper: Convert to KUnit
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petri Latvala <petri.latvala@intel.com>,
        Arkadiusz Hiler <arek@hiler.eu>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
 <20220117232259.180459-7-michal.winiarski@intel.com>
 <CAGS_qxo+Jeuoo7QQnEW883bT5z3HJqz2sCX=kzhra3UsEM9xOQ@mail.gmail.com>
From:   =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
In-Reply-To: <CAGS_qxo+Jeuoo7QQnEW883bT5z3HJqz2sCX=kzhra3UsEM9xOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0110.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::7) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3677ed5a-a299-420a-dc5a-08d9dc77ce2f
X-MS-TrafficTypeDiagnostic: DM8PR11MB5606:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM8PR11MB56068BA17952A86CE5BE3D78985B9@DM8PR11MB5606.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhYmta2d1AYEHutd5ZlzZ3Xki5brke/N26a8y41RhR80e/Ac11e2Jr/+tS6UlfHz//XTOldpEsCYf+JFQDCKgTIlWIt4bEk+BYhAcw4j4XMFTevxdgqiN+8ehMG7Z7qrSTD+JRxHOrm+Msf3dFd5EJymVbeXbj5RcaD3tjaacjryt/T2ueske0cbohp35iREw4JDDsUI4Q6wexmtzBRODzBnaqJ7MuC60wnUtavtotlwBL9OP6dDpKJb8/6RKiW0aaNsTOYk2aM67cSVK3CcGGt6co/pC3IZXS/AXzOrzkoZIWI8AomMie3cvV28X4GJ8rUjvVWx0a7MjPsLP/u+3RqYc+EqUnjQvGRDKD8rHZY6r1OUd+viVO/jWze4YlNtabZNK0LY84Ej+WmiHv0QqGkGSsNfpIus4Lgk6i1BlpghBaBSrKt+f2VVxqH6LPOgK7wZJXCyPYmdov8Mav/TV904nsIs+yJZv6F6HONLCjRwK/Qy72pZPw+d5Bp95hR9BAdzMR5Z8C0MEbgnxutPs71IbDIX0GdFUzWxLlhkybvaJb/m05PpmaHuALMuSfj+DjPUrAcJIzQXGoxT4jF9lQ5Z+JcySnu8LrHFvFZrN7F//vOMOnIJJk9fGNoxZOdei26g7zBzQMuTda2NtnV/rbqb6neJIeLW21mfg5d1aZko9G+b4hFDEk8GmJALw6iiyErINLBMHMVR7w4jLU6ljUlFns846mLM7+XxhVldBjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(7416002)(508600001)(6666004)(83380400001)(66556008)(31696002)(6486002)(2616005)(6512007)(86362001)(31686004)(186003)(82960400001)(316002)(4326008)(53546011)(6506007)(54906003)(5660300002)(38100700002)(2906002)(36756003)(8936002)(8676002)(6916009)(66476007)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFBBSlI0WnlpMldmeCttY3BLTGRtRFFHeWpkMXdtc2hzd3hUUURXajF3akZh?=
 =?utf-8?B?T1pWRFZBRWpFNWtxM3c0T3kxdzBabjhMQ0dneTNmazVFcHI0b2NTUG1HT2Qy?=
 =?utf-8?B?UkF4RStZV1FEcFErQ25IcTlNS0phYXdpQmJCRkdIa2pMaW5vTVQ1WjVLS0Zi?=
 =?utf-8?B?L3hOZnV5ODJ4MFE4QTNVbHlEdVVuU29DZ1ZvYnp5M0RBWGZzZmNLTWIxb1Ji?=
 =?utf-8?B?dkFZZDU2VU85MldCUjBnREZ4RmdjVmI4YkZuWGdmRzEvcEZaWGhYQ1FKdmFi?=
 =?utf-8?B?OEhBQ3hneXZHYUhMSncvaE5YK2JHTjFTY3ZKWFJ5N29ZekVnM1ljZE1SWTkx?=
 =?utf-8?B?bTkwUTE4QW9BRTBpbEdTYmxla2xXYk43bklJUmwxQk1BakI4WmpiNXN4QzhM?=
 =?utf-8?B?YXkzSHZhVUMvNDIzK0hOZGg5ZUluY3NYQ1pqOFR3eSs3M1VxRlJoNVpSNjl0?=
 =?utf-8?B?NzMwcXpLODl4TEx6cE5TODFLZzA3d3QwQjNkUVBzSThzMG1jYU12RE8zTFhM?=
 =?utf-8?B?QVpOQzdPalBTbDRwRW1rNjFoTVVQcE1xVjJvVnNPdm1zU0pSM3FXbUNHQ2pm?=
 =?utf-8?B?QTduT2VNdWdxZytvM05veXg5STg0SkpyK08xMlhYNC9FSWJjQm1CRThJbHZt?=
 =?utf-8?B?MGhjbC9XL2thZ293TEtaSFQxVjhmbDVxV2lXU3ViUzd6WDdqcDhjTG5tbUcv?=
 =?utf-8?B?Q1MwOXJTYzMvc2dhYXJ3ckR3VzZxQis4WVlpYXFJM1NJcDA1cGFQMVA2V2li?=
 =?utf-8?B?bkR3bUEyUnJqdXplMFVNcEJJWEFrd1FTekFyQjYzZjkvTHcrSC9TRUhJdjdB?=
 =?utf-8?B?OUVZVTR1Tm5zRHBPRDRrUytXYUQ1R1dHQ2kvR0YwK0dhWG00YzFrY09HTjdz?=
 =?utf-8?B?WGg2TS9kNVVLOVNlZGEySWpvRUNVcEJrSEpwbEpWeEgyNVgrOHUyS2xibEZ5?=
 =?utf-8?B?bUdId3VwNDlxWUFXSmRCN1RGbUYvZi9rKy9admZhdnF2dmcxUy9PL0ZKcEtx?=
 =?utf-8?B?TVBTMytzOW9DOCs4WmxvMWdxSGxEUUVzN1J3Q2RmN2EyZjQ0b2M1STczbFQy?=
 =?utf-8?B?QmxHUTRaZE5pR3U1OC9XemRGbmF4UVVnRS95bGd6ZDZCTWZmMWRWN090aEVs?=
 =?utf-8?B?THZpNzlBWE90V2J2TUVlckh6MWttbmNxaldsdndMcE1EMTVkbHNhZEZ1V093?=
 =?utf-8?B?M1NWb2RaZTN3MjJKY0FLVHFhS0dySzc2bEFqUTRxeElSUjRRRllWT1hOTUw0?=
 =?utf-8?B?ZGoyYUZiUXcrZ0FrZjlHYXJGZldLTkJqTGVIVzdJa01mbm5yR0RYZ1c1bHFI?=
 =?utf-8?B?TFNLTE5DY0w0UGFyOW1GU2Q0NWNXOGNYUHhQSnhxZzNVWHlYblAvU3IwSWdQ?=
 =?utf-8?B?UytURHFDSXh6ai9UVURnd3R4NUJBNzM3SXdxQytmSG53VkpLRm9FOUxrcXRU?=
 =?utf-8?B?NmpZVTFzdEpKQkQxeDQ2Y0lsOVlTbDF2VHhiOWZmd2s5T1lMKzExRGt3UHpr?=
 =?utf-8?B?VzdiaXh0V0lxdGExOGhzVEVLVG9qa1R6K0RXZkFzWUthWWhKWktIa3I4Z2xO?=
 =?utf-8?B?b3F4VitLSXlkUjBlbks3Uk8wMUZILzE1a3RTanFuNVl1TVNuaHN4TlhaNG1k?=
 =?utf-8?B?VHo1dTBWaUZmSnRLb2l0M0hIeGU0SVF0eXAwQ3RGOHMrSzQzT09xdVdmQVM1?=
 =?utf-8?B?YnlYTDZOUVJ1aXc0UUFzTkgyYVJrME9hRFMrdERGZmJNMjAzbHBtc2psWGdj?=
 =?utf-8?B?alRpZTZzVXFyNnhRNE4vakxuUElnaEwzMDFnM1VuR0U0SzVlZnB6T1lBZno3?=
 =?utf-8?B?Zm13MG5qb2VocFQxWXNHREVJUG5TanhRM2VSM00wbUJOYTJiR0gxc25DZmJ3?=
 =?utf-8?B?K2cxWWREQ2ZXazJYbFBjNHQvVEJVQWRHaDhBaXR3SXgzOGdXckQrKzNMaE1K?=
 =?utf-8?B?S1VndjBLcTlNTTBEaXhOaXJzWEJRVTh5YmZRbmRBOTFrU1U5ZzRwbGFhTnJF?=
 =?utf-8?B?d0VBcDhtVUlBR0NzcElQQTNCa2JRdUI3RjkyWHd2VUNPMnFEVGxlOUE5dkh5?=
 =?utf-8?B?Z3doKy9DTEVOc2VBbFFCZ20wcGV5cUN0ODJjSDV0bHBady82Z2paVmk5RThG?=
 =?utf-8?B?SDZHVzB2NStySnlmUkZFRnJ5eDRXNVlPVHI5U2c5ejEvL1lQSTNNUWxjd0Ro?=
 =?utf-8?B?QzFiRUd0QnZ0UFZPbmxPRm53NXcyZWk2VXdoYjN5Q0dTaFJsYmora1VsclVy?=
 =?utf-8?B?UEJoaXdHbUZZRzZjbUtvRmlmMWQ1MkFITFJ4ckI4Ry9ERktzWmpCRXh4NHlN?=
 =?utf-8?Q?eLqi8L5EIm/si3QsdR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3677ed5a-a299-420a-dc5a-08d9dc77ce2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 00:48:57.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXmvuIO4Bz1MDVQ9a2+1Ih4KusLuqw25ID64LdctC0A4m4inHaww3WPpe1OV+A+kPAmWnUCFrCfWvE02sise3i9GuGpT6Jg/i1lUzg+WbbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.01.2022 01:28, Daniel Latypov wrote:
> On Mon, Jan 17, 2022 at 3:24 PM Michał Winiarski
> <michal.winiarski@intel.com> wrote:
>>
>> igt_dp_mst_calc_pbn_mode was converted one-to-one,
>> igt_dp_mst_sideband_msg_req_decode was refactored to parameterized test.
>>
>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>> ---
>>   drivers/gpu/drm/selftests/Makefile            |   3 +-
>>   .../gpu/drm/selftests/drm_modeset_selftests.h |   2 -
>>   .../drm/selftests/test-drm_dp_mst_helper.c    | 502 ++++++++++++------
>>   .../drm/selftests/test-drm_modeset_common.h   |   2 -
>>   4 files changed, 330 insertions(+), 179 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
>> index 35f2f40dbaf3..77e37eebf099 100644
>> --- a/drivers/gpu/drm/selftests/Makefile
>> +++ b/drivers/gpu/drm/selftests/Makefile
>> @@ -1,7 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   test-drm_modeset-$(CONFIG_DRM_DEBUG_SELFTEST) := \
>>                        test-drm_modeset_common.o \
>> -                     test-drm_dp_mst_helper.o \
>>                        test-drm_rect.o
>>
>>   obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
>> @@ -9,4 +8,4 @@ obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o
>>   obj-$(CONFIG_DRM_KUNIT_TEST) := \
>>          test-drm_cmdline_parser.o test-drm_plane_helper.o \
>>          test-drm_format.o test-drm_framebuffer.o \
>> -       test-drm_damage_helper.o
>> +       test-drm_damage_helper.o test-drm_dp_mst_helper.o
>> diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
>> index b6a6dba66b64..630770d30aba 100644
>> --- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
>> +++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
>> @@ -10,5 +10,3 @@ selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
>>   selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
>>   selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
>>   selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
>> -selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
>> -selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
>> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
>> index 6b4759ed6bfd..d0719f3c5a42 100644
>> --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
>> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
>> @@ -3,54 +3,97 @@
>>    * Test cases for for the DRM DP MST helpers
>>    */
>>
>> -#define PREFIX_STR "[drm_dp_mst_helper]"
>> -
>> +#include <kunit/test.h>
>>   #include <linux/random.h>
>>
>>   #include <drm/drm_dp_mst_helper.h>
>>   #include <drm/drm_print.h>
>>
>>   #include "../drm_dp_mst_topology_internal.h"
>> -#include "test-drm_modeset_common.h"
>>
>> -int igt_dp_mst_calc_pbn_mode(void *ignored)
>> +struct dp_mst_calc_pbn_mode_test {
>> +       int rate;
>> +       int bpp;
>> +       int expected;
>> +       bool dsc;
>> +};
>> +
>> +static void dp_mst_calc_pbn_mode(struct kunit *test)
>>   {
>> -       int pbn, i;
>> -       const struct {
>> -               int rate;
>> -               int bpp;
>> -               int expected;
>> -               bool dsc;
>> -       } test_params[] = {
>> -               { 154000, 30, 689, false },
>> -               { 234000, 30, 1047, false },
>> -               { 297000, 24, 1063, false },
>> -               { 332880, 24, 50, true },
>> -               { 324540, 24, 49, true },
>> -       };
>> +       const struct dp_mst_calc_pbn_mode_test *params = test->param_value;
>> +       int pbn;
>>
>> -       for (i = 0; i < ARRAY_SIZE(test_params); i++) {
>> -               pbn = drm_dp_calc_pbn_mode(test_params[i].rate,
>> -                                          test_params[i].bpp,
>> -                                          test_params[i].dsc);
>> -               FAIL(pbn != test_params[i].expected,
>> -                    "Expected PBN %d for clock %d bpp %d, got %d\n",
>> -                    test_params[i].expected, test_params[i].rate,
>> -                    test_params[i].bpp, pbn);
>> -       }
>> +       pbn = drm_dp_calc_pbn_mode(params->rate,
>> +                                  params->bpp,
>> +                                  params->dsc);
>> +
>> +       KUNIT_EXPECT_EQ(test, pbn, params->expected);
>> +}
>>
>> -       return 0;
>> +static const struct dp_mst_calc_pbn_mode_test dp_mst_calc_pbn_mode_tests[] = {
>> +       {
>> +               .rate = 154000,
>> +               .bpp = 30,
>> +               .expected = 689,
>> +               .dsc = false,
>> +       },
>> +       {
>> +               .rate = 234000,
>> +               .bpp = 30,
>> +               .expected = 1047,
>> +               .dsc = false,
>> +       },
>> +       {
>> +               .rate = 297000,
>> +               .bpp = 24,
>> +               .expected = 1063,
>> +               .dsc = false,
>> +       },
>> +       {
>> +               .rate = 332880,
>> +               .bpp = 24,
>> +               .expected = 50,
>> +               .dsc = true,
>> +       },
>> +       {
>> +               .rate = 324540,
>> +               .bpp = 24,
>> +               .expected = 49,
>> +               .dsc = true,
>> +       },
>> +};
>> +
>> +static void dp_mst_calc_pbn_mode_desc(const struct dp_mst_calc_pbn_mode_test *t,
>> +                                     char *desc)
>> +{
>> +       sprintf(desc, "rate = %d, bpp = %d, dsc = %s",
>> +               t->rate, t->bpp, t->dsc ? "true" : "false");
>>   }
>>
>> -static bool
>> -sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
>> -                      const struct drm_dp_sideband_msg_req_body *out)
>> +KUNIT_ARRAY_PARAM(dp_mst_calc_pbn_mode, dp_mst_calc_pbn_mode_tests, dp_mst_calc_pbn_mode_desc);
>> +
>> +static void
>> +drm_dp_mst_helper_printfn(struct drm_printer *p, struct va_format *vaf)
>> +{
>> +       struct kunit *test = p->arg;
>> +
>> +       kunit_err(test, "%pV", vaf);
>> +}
>> +
>> +static void
>> +expect_sideband_msg_req_equal(struct kunit *test,
>> +                             const struct drm_dp_sideband_msg_req_body *in,
>> +                             const struct drm_dp_sideband_msg_req_body *out)
>>   {
>>          const struct drm_dp_remote_i2c_read_tx *txin, *txout;
>> +       struct drm_printer p = {
>> +               .printfn = drm_dp_mst_helper_printfn,
>> +               .arg = test
>> +       };
>>          int i;
>>
>>          if (in->req_type != out->req_type)
>> -               return false;
>> +               goto fail;
> 
> Briefly skimming over this code, it looks like it'd be simpler to have
> this function remain unchanged.
> There's only the one caller.
> It could take on the responsibility of creating the drm_printer and
> redirect the printfn to kunit_err, afaik.
> 
> Passing in `test` would be useful if we were generating custom error
> messages for each of the `return false` lines, which I assume was the
> original motivation for doing so?
> But looking at this, I'd agree it seems like too much work.

Yes, that was the original motivation, but eventually I went back to the 
original code, leaving drm_printer behind.
I agree - I'll leave the function intact.

> 
> Tangent:
> It might have been easier to do that if the kunit assertions returned pass/fail.
> E.g. instead of having to do
> 
> if (!<long-condition>) {
>    KUNIT_FAIL("<long-condition> not met");
>    return;
> }
> 
> if we could do
> 
> if(!KUNIT_EXPECT_TRUE(long-condition))
>    return;
> 
> or if there was a new macro type
> 
> KUNIT_EXPECT_RET_TRUE(long-condition); // like ASSERT, but just return
> from this func on failure

This would simplify a bunch of other tests as well.
On the other hand - EXPECT_TRUE returning a value is not something I 
would expect :)

Thanks!
-Michał

> 
> 
>>
>>          switch (in->req_type) {
>>          /*
>> @@ -65,7 +108,7 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
>>                      IN.num_transactions != OUT.num_transactions ||
>>                      IN.port_number != OUT.port_number ||
>>                      IN.read_i2c_device_id != OUT.read_i2c_device_id)
>> -                       return false;
>> +                       goto fail;
>>
>>                  for (i = 0; i < IN.num_transactions; i++) {
>>                          txin = &IN.transactions[i];
>> @@ -76,11 +119,11 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
>>                              txin->num_bytes != txout->num_bytes ||
>>                              txin->i2c_transaction_delay !=
>>                              txout->i2c_transaction_delay)
>> -                               return false;
>> +                               goto fail;
>>
>>                          if (memcmp(txin->bytes, txout->bytes,
>>                                     txin->num_bytes) != 0)
>> -                               return false;
>> +                               goto fail;
>>                  }
>>                  break;
>>   #undef IN
>> @@ -92,9 +135,12 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
>>                  if (IN.dpcd_address != OUT.dpcd_address ||
>>                      IN.num_bytes != OUT.num_bytes ||
>>                      IN.port_number != OUT.port_number)
>> -                       return false;
>> +                       goto fail;
>>
>> -               return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
>> +               if (memcmp(IN.bytes, OUT.bytes, IN.num_bytes) != 0)
>> +                       goto fail;
>> +
>> +               break;
>>   #undef IN
>>   #undef OUT
>>
>> @@ -104,55 +150,65 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
>>                  if (IN.port_number != OUT.port_number ||
>>                      IN.write_i2c_device_id != OUT.write_i2c_device_id ||
>>                      IN.num_bytes != OUT.num_bytes)
>> -                       return false;
>> +                       goto fail;
>>
>> -               return memcmp(IN.bytes, OUT.bytes, IN.num_bytes) == 0;
>> +               if (memcmp(IN.bytes, OUT.bytes, IN.num_bytes) != 0)
>> +                       goto fail;
>> +
>> +               break;
>>   #undef IN
>>   #undef OUT
>>
>>          default:
>> -               return memcmp(in, out, sizeof(*in)) == 0;
>> +               if (memcmp(in, out, sizeof(*in)) != 0)
>> +                       goto fail;
>>          }
>>
>> -       return true;
>> +       return;
>> +
>> +fail:
>> +       drm_printf(&p, "Expected:\n");
>> +       drm_dp_dump_sideband_msg_req_body(in, 1, &p);
>> +       drm_printf(&p, "Got:\n");
>> +       drm_dp_dump_sideband_msg_req_body(out, 1, &p);
>> +       KUNIT_FAIL(test, "Encode/decode failed");
>> +}
>> +
>> +struct dp_mst_sideband_msg_req_decode_test {
>> +       const struct drm_dp_sideband_msg_req_body req;
>> +       const struct drm_dp_sideband_msg_req_body
>> +               (*f)(const struct drm_dp_sideband_msg_req_body *in);
>> +};
>> +
>> +const struct drm_dp_sideband_msg_req_body
>> +param_to_dp_mst_sideband_msg_req_body(const struct dp_mst_sideband_msg_req_decode_test *t)
>> +{
>> +       if (t->f)
>> +               return t->f(&t->req);
>> +
>> +       return t->req;
>>   }
>>
>> -static bool
>> -sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
>> +static void dp_mst_sideband_msg_req_decode(struct kunit *test)
>>   {
>> +       const struct drm_dp_sideband_msg_req_body in =
>> +               param_to_dp_mst_sideband_msg_req_body(test->param_value);
>>          struct drm_dp_sideband_msg_req_body *out;
>> -       struct drm_printer p = drm_err_printer(PREFIX_STR);
>>          struct drm_dp_sideband_msg_tx *txmsg;
>> -       int i, ret;
>> -       bool result = true;
>> -
>> -       out = kzalloc(sizeof(*out), GFP_KERNEL);
>> -       if (!out)
>> -               return false;
>> -
>> -       txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>> -       if (!txmsg)
>> -               return false;
>> -
>> -       drm_dp_encode_sideband_req(in, txmsg);
>> -       ret = drm_dp_decode_sideband_req(txmsg, out);
>> -       if (ret < 0) {
>> -               drm_printf(&p, "Failed to decode sideband request: %d\n",
>> -                          ret);
>> -               result = false;
>> -               goto out;
>> -       }
>> +       int i;
>>
>> -       if (!sideband_msg_req_equal(in, out)) {
>> -               drm_printf(&p, "Encode/decode failed, expected:\n");
>> -               drm_dp_dump_sideband_msg_req_body(in, 1, &p);
>> -               drm_printf(&p, "Got:\n");
>> -               drm_dp_dump_sideband_msg_req_body(out, 1, &p);
>> -               result = false;
>> -               goto out;
>> -       }
>> +       out = kunit_kzalloc(test, sizeof(*out), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out);
>>
>> -       switch (in->req_type) {
>> +       txmsg = kunit_kzalloc(test, sizeof(*txmsg), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, txmsg);
>> +
>> +       drm_dp_encode_sideband_req(&in, txmsg);
>> +       KUNIT_ASSERT_EQ(test, drm_dp_decode_sideband_req(txmsg, out), 0);
>> +
>> +       expect_sideband_msg_req_equal(test, &in, out);
>> +
>> +       switch (in.req_type) {
>>          case DP_REMOTE_DPCD_WRITE:
>>                  kfree(out->u.dpcd_write.bytes);
>>                  break;
>> @@ -164,110 +220,210 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
>>                  kfree(out->u.i2c_write.bytes);
>>                  break;
>>          }
>> -
>> -       /* Clear everything but the req_type for the input */
>> -       memset(&in->u, 0, sizeof(in->u));
>> -
>> -out:
>> -       kfree(out);
>> -       kfree(txmsg);
>> -       return result;
>>   }
>>
>> -int igt_dp_mst_sideband_msg_req_decode(void *unused)
>> +static u8 data[] = { 0xff, 0x0, 0xdd };
>> +
>> +const struct drm_dp_sideband_msg_req_body
>> +random_dp_query_enc_client_id(const struct drm_dp_sideband_msg_req_body *in)
>>   {
>> -       struct drm_dp_sideband_msg_req_body in = { 0 };
>> -       u8 data[] = { 0xff, 0x0, 0xdd };
>> -       int i;
>> +       struct drm_dp_query_stream_enc_status enc_status = { };
>>
>> -#define DO_TEST() FAIL_ON(!sideband_msg_req_encode_decode(&in))
>> -
>> -       in.req_type = DP_ENUM_PATH_RESOURCES;
>> -       in.u.port_num.port_number = 5;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_POWER_UP_PHY;
>> -       in.u.port_num.port_number = 5;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_POWER_DOWN_PHY;
>> -       in.u.port_num.port_number = 5;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_ALLOCATE_PAYLOAD;
>> -       in.u.allocate_payload.number_sdp_streams = 3;
>> -       for (i = 0; i < in.u.allocate_payload.number_sdp_streams; i++)
>> -               in.u.allocate_payload.sdp_stream_sink[i] = i + 1;
>> -       DO_TEST();
>> -       in.u.allocate_payload.port_number = 0xf;
>> -       DO_TEST();
>> -       in.u.allocate_payload.vcpi = 0x7f;
>> -       DO_TEST();
>> -       in.u.allocate_payload.pbn = U16_MAX;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_QUERY_PAYLOAD;
>> -       in.u.query_payload.port_number = 0xf;
>> -       DO_TEST();
>> -       in.u.query_payload.vcpi = 0x7f;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_REMOTE_DPCD_READ;
>> -       in.u.dpcd_read.port_number = 0xf;
>> -       DO_TEST();
>> -       in.u.dpcd_read.dpcd_address = 0xfedcb;
>> -       DO_TEST();
>> -       in.u.dpcd_read.num_bytes = U8_MAX;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_REMOTE_DPCD_WRITE;
>> -       in.u.dpcd_write.port_number = 0xf;
>> -       DO_TEST();
>> -       in.u.dpcd_write.dpcd_address = 0xfedcb;
>> -       DO_TEST();
>> -       in.u.dpcd_write.num_bytes = ARRAY_SIZE(data);
>> -       in.u.dpcd_write.bytes = data;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_REMOTE_I2C_READ;
>> -       in.u.i2c_read.port_number = 0xf;
>> -       DO_TEST();
>> -       in.u.i2c_read.read_i2c_device_id = 0x7f;
>> -       DO_TEST();
>> -       in.u.i2c_read.num_transactions = 3;
>> -       in.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3;
>> -       for (i = 0; i < in.u.i2c_read.num_transactions; i++) {
>> -               in.u.i2c_read.transactions[i].bytes = data;
>> -               in.u.i2c_read.transactions[i].num_bytes = ARRAY_SIZE(data);
>> -               in.u.i2c_read.transactions[i].i2c_dev_id = 0x7f & ~i;
>> -               in.u.i2c_read.transactions[i].i2c_transaction_delay = 0xf & ~i;
>> -       }
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_REMOTE_I2C_WRITE;
>> -       in.u.i2c_write.port_number = 0xf;
>> -       DO_TEST();
>> -       in.u.i2c_write.write_i2c_device_id = 0x7f;
>> -       DO_TEST();
>> -       in.u.i2c_write.num_bytes = ARRAY_SIZE(data);
>> -       in.u.i2c_write.bytes = data;
>> -       DO_TEST();
>> -
>> -       in.req_type = DP_QUERY_STREAM_ENC_STATUS;
>> -       in.u.enc_status.stream_id = 1;
>> -       DO_TEST();
>> -       get_random_bytes(in.u.enc_status.client_id,
>> -                        sizeof(in.u.enc_status.client_id));
>> -       DO_TEST();
>> -       in.u.enc_status.stream_event = 3;
>> -       DO_TEST();
>> -       in.u.enc_status.valid_stream_event = 0;
>> -       DO_TEST();
>> -       in.u.enc_status.stream_behavior = 3;
>> -       DO_TEST();
>> -       in.u.enc_status.valid_stream_behavior = 1;
>> -       DO_TEST();
>> -
>> -#undef DO_TEST
>> -       return 0;
>> +       get_random_bytes(enc_status.client_id, sizeof(enc_status.client_id));
>> +
>> +       return (const struct drm_dp_sideband_msg_req_body) { .req_type = in->req_type,
>> +                                                            .u.enc_status = enc_status
>> +       };
>>   }
>> +
>> +static const struct dp_mst_sideband_msg_req_decode_test dp_msg_sideband_msg_req_decode_tests[] = {
>> +       {
>> +               .req = {
>> +                       .req_type = DP_ENUM_PATH_RESOURCES,
>> +                       .u.port_num.port_number = 5,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_POWER_UP_PHY,
>> +                       .u.port_num.port_number = 5,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_POWER_DOWN_PHY,
>> +                       .u.port_num.port_number = 5,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_ALLOCATE_PAYLOAD,
>> +                       .u.allocate_payload.number_sdp_streams = 3,
>> +                       .u.allocate_payload.sdp_stream_sink = { 1, 2, 3 },
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_ALLOCATE_PAYLOAD,
>> +                       .u.allocate_payload.port_number = 0xf,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_ALLOCATE_PAYLOAD,
>> +                       .u.allocate_payload.vcpi = 0x7f,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_ALLOCATE_PAYLOAD,
>> +                       .u.allocate_payload.pbn = U16_MAX,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_PAYLOAD,
>> +                       .u.query_payload.port_number = 0xf,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_PAYLOAD,
>> +                       .u.query_payload.vcpi = 0x7f,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_DPCD_READ,
>> +                       .u.dpcd_read.port_number = 0xf,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_DPCD_READ,
>> +                       .u.dpcd_read.dpcd_address = 0xfedcb,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_DPCD_READ,
>> +                       .u.dpcd_read.num_bytes = U8_MAX,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_DPCD_WRITE,
>> +                       .u.dpcd_write.port_number = 0xf,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_DPCD_WRITE,
>> +                       .u.dpcd_write.dpcd_address = 0xfedcb,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_DPCD_WRITE,
>> +                       .u.dpcd_write.num_bytes = ARRAY_SIZE(data),
>> +                       .u.dpcd_write.bytes = data,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_I2C_READ,
>> +                       .u.i2c_read.port_number = 0xf,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_I2C_READ,
>> +                       .u.i2c_read.read_i2c_device_id = 0x7f,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_I2C_READ,
>> +                       .u.i2c_read.num_transactions = 3,
>> +                       .u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3,
>> +                       .u.i2c_read.transactions = {
>> +                               { .bytes = data, .num_bytes = ARRAY_SIZE(data),
>> +                                 .i2c_dev_id = 0x7f, .i2c_transaction_delay = 0xf, },
>> +                               { .bytes = data, .num_bytes = ARRAY_SIZE(data),
>> +                                 .i2c_dev_id = 0x7e, .i2c_transaction_delay = 0xe, },
>> +                               { .bytes = data, .num_bytes = ARRAY_SIZE(data),
>> +                                 .i2c_dev_id = 0x7d, .i2c_transaction_delay = 0xd, },
>> +                       },
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_I2C_WRITE,
>> +                       .u.i2c_write.port_number = 0xf,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_I2C_WRITE,
>> +                       .u.i2c_write.write_i2c_device_id = 0x7f,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_REMOTE_I2C_WRITE,
>> +                       .u.i2c_write.num_bytes = ARRAY_SIZE(data),
>> +                       .u.i2c_write.bytes = data,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_STREAM_ENC_STATUS,
>> +                       .u.enc_status.stream_id = 1,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_STREAM_ENC_STATUS,
>> +               },
>> +               .f = random_dp_query_enc_client_id,
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_STREAM_ENC_STATUS,
>> +                       .u.enc_status.stream_event = 3,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_STREAM_ENC_STATUS,
>> +                       .u.enc_status.valid_stream_event = 0,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_STREAM_ENC_STATUS,
>> +                       .u.enc_status.stream_behavior = 3,
>> +               },
>> +       },
>> +       {
>> +               .req = {
>> +                       .req_type = DP_QUERY_STREAM_ENC_STATUS,
>> +                       .u.enc_status.valid_stream_behavior = 1,
>> +               },
>> +       },
>> +};
>> +
>> +KUNIT_ARRAY_PARAM(dp_mst_sideband_msg_req, dp_msg_sideband_msg_req_decode_tests, NULL);
>> +
>> +static struct kunit_case drm_dp_mst_helper_tests[] = {
>> +       KUNIT_CASE_PARAM(dp_mst_calc_pbn_mode, dp_mst_calc_pbn_mode_gen_params),
>> +       KUNIT_CASE_PARAM(dp_mst_sideband_msg_req_decode, dp_mst_sideband_msg_req_gen_params),
>> +       {}
>> +};
>> +
>> +static struct kunit_suite drm_dp_mst_helper_test_suite = {
>> +       .name = "drm_dp_mst_helper_tests",
>> +       .test_cases = drm_dp_mst_helper_tests,
>> +};
>> +
>> +kunit_test_suite(drm_dp_mst_helper_test_suite);
>> diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
>> index 1501d99aee2f..c7cc5edc65f1 100644
>> --- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
>> +++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
>> @@ -20,7 +20,5 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
>>   int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
>>   int igt_drm_rect_clip_scaled_clipped(void *ignored);
>>   int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
>> -int igt_dp_mst_calc_pbn_mode(void *ignored);
>> -int igt_dp_mst_sideband_msg_req_decode(void *ignored);
>>
>>   #endif
>> --
>> 2.34.1
>>

