Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515FC797B38
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbjIGSJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbjIGSJT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 14:09:19 -0400
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 11:08:52 PDT
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8558ACC
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Sep 2023 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1694110132; x=1725646132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UsUcLQSxnxBatuGT2hewxAjv8m9YIV6KN/z1+Nn7bnk=;
  b=CDbZT41qYDshw9fuyRiYSFigYDrYfPNSf4SG8gdK+6hm2b0V0Q7bCQ/l
   5qjTfdBxZk5uSNWAsD/bfhyILYc8Jl2BGzXUU+gr5wUFIlcA+EuN64rJh
   AVZu+Ey3CQtftkEha4BPj05tTNCBuVtX9fJRlQ8U5Mny/qPZIqX5kpCLh
   E7MgIzJisCFIzikdKdmQ3OPSvR0kbvcja8+nxy0C7OuftNjDc/sPh8SI0
   QfN/GkgTpvh9GdZfQ+c386lupU9C9KlEDC9VILCrzpHppiwFE7JYqubWc
   abI//K+5Jgw6JR3ne3LOV+pXVM0pHeqf8IJsscY+8Op99RzEgcvpWPUDL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="94641062"
X-IronPort-AV: E=Sophos;i="6.02,234,1688396400"; 
   d="scan'208";a="94641062"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 17:42:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOxQCqRUhc6Cv9OIlGLTgPUlPB4wR7PQhg57ZP/F9oTSsJqmplYfIEa/TtwkiIZRxo6FBapy/ZqAmAckDPKBdw/2a/raX4UMqo/3xhDjBXVq3NzupIXVEpxCYBZwoFGhxU3Q/FkDJiWWtQNOnYeemzdKj6yQ1f4rjhHQKGI0VKQhY9D4zIi6YomxmDqPEfhmrhv8UCseReSQ3EnHtz8UGH+iAtNx/jODWrM6Imm7dDaLzfleMGL7NoFJxIgQep3dOHEIIvJtxqjRmFBZl8ah0s3GgQMZr7TB7a+LwvCYMHbob7XtKVXhkDD67UaaOyLyEWb0lNwrHBJl2LVRwmqXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsUcLQSxnxBatuGT2hewxAjv8m9YIV6KN/z1+Nn7bnk=;
 b=mUh48qcvqC8DLEWq51eYq5CmTy9yKM410apv+A9udJzt8DS/vReWbKQZYTTnZ3MnEsJ2ZwNHowoM0ns0mM83gJ+1BGaJ98LqDmAJm30BeJ4yVuSsieFCeXhyBezI59Z8o+o7ABAsKIIqDzJJpn9rSdaMT74pjWir+vudDnKNxZ8x4+zQ3FxREn0+iSIzMmYDZuN6CgMdD9PKoebxc8hxxbD2SwuBlrjxlYP8dS4fazszfn/8UQStI/m6PbSD2C3iK6rJsu4RuI+mUjmmc1QFv2moVuNuUWqcHl/jb8REzGte98XGJ+NhMJipjHv1f9pqNsdpIVZ5/x++WXWAMSN6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB10165.jpnprd01.prod.outlook.com (2603:1096:400:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 08:42:43 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 08:42:43 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        =?utf-8?B?TWFjaWVqIFdpZWN6w7NyLVJldG1hbg==?= 
        <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/8] selftests/resctrl: Rework benchmark command
 handling
Thread-Topic: [PATCH v5 0/8] selftests/resctrl: Rework benchmark command
 handling
Thread-Index: AQHZ3xW8aBJs0UC0TUSqKk7DuTmCqbAPD2Mg
Date:   Thu, 7 Sep 2023 08:42:43 +0000
Message-ID: <TYAPR01MB6330F3BF29FCF14C0C8C780B8BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YjRmMTZlYzctZDYwNy00NmEwLThjZTAtMDYzODY3NWYy?=
 =?utf-8?B?NDkyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0wN1QwODozOToxM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 06ffb588832d4d14b215b1b2fc8a9763
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB10165:EE_
x-ms-office365-filtering-correlation-id: 1c8bc334-2826-42eb-062b-08dbaf7e6718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYCtyE1KE4HJ2kocdgXf/eMsBQ1F9edUDvGbDb1NVBFC4/XIRakt7bzDWz8ArkUaMM2/dvZmRb+HUGAUAUUFr+x7LLsVdtQAAXCQRBvEb3n/HBYUK3fPtaeQohUv05Ibz/km0JKvF/EXGDfbjUZ/rye6acjcVmXAEG0vxEQLO1uTxF81mt34II4XvwrepG+ueT8SHHO2dFkPiwVulSCt/aQS3kl4JtykAdMdUJNNXz3DaYJepZRZTlk9FE5QAq7yj5BXh6nRDgLLBFTeqAHzQJjpI1QZcWYIcSDapL2IavhywRh1IU4KHNIV4cHK3AmakMvEHaty3YvesdE7gBhQbwKdWP8gcbSD+FAVcxAdG2Lw7g14aNJi3oEWxL2D1Kjw3okjsKPubzjnZNmsYxYsAFqwO3BNdIfRUYCs/yb/kXKEjVsEgZa3l/vpyV91itEvXkjOe431U+GgHUKuOdkOgckX1QKDbc/7Dmy7kUnyksXzukRNGs3IC6EOdkQ16fVGwXlqgjbXTMasxy0eMnneoXfg+hY9Gk8TvrYlsSIBsEkoUa/0Tr/nfwMoK38jNQaEEk9gzFmx0k7pV/UwMXYIw6rcb9Xes1M/lKwLFXe+JA2/1hX5SJ8SmU5Lfz2DZMrUfDCAT84Ns8KYMFbvpGILSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(1800799009)(186009)(1590799021)(451199024)(2906002)(1580799018)(55016003)(26005)(86362001)(71200400001)(478600001)(9686003)(6506007)(85182001)(7696005)(33656002)(38070700005)(82960400001)(558084003)(38100700002)(122000001)(8936002)(316002)(8676002)(5660300002)(41300700001)(4326008)(52536014)(54906003)(66476007)(66556008)(64756008)(66446008)(110136005)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDVPcUxzWFdGSDdaZ1NzZENteSs1YTRMYzd1RGFoWXRqSEdHNGpoQmNjWFQ5?=
 =?utf-8?B?ejF1YW9ZTFA3WDBLOW0rUENtNzlQQXN4ZWY1a2FPYmFHQyswS1I1cktGc3Uz?=
 =?utf-8?B?bnp5YnpuOFVtMzVlU3duNEFCcUNyZW5YL3dWQjZvQmdzdWJWKzBVb1VrbjQ1?=
 =?utf-8?B?d3pSbkZFenBvN05hNmVhWHVGSnh6ZXN0WXZ0RVFlRURsa1dEWFF0STlIOTV3?=
 =?utf-8?B?Y1ppR1J3b2N1azhwenVqR3l2bUd0SWtYREIzRkQrWlBxVXMydVBRRXZ6cGpD?=
 =?utf-8?B?Q1R4dWZ5cHNDU1cycFdtbFZFVW1UR3hBYmtrSndKYXFkL202TFVFanRYWFQ5?=
 =?utf-8?B?Ui9FdVVPMU0yODZDVlhlMVhFMVY4bWx3UE0vbXZLbHJuODc0N1l4dlZUUmNM?=
 =?utf-8?B?YktBSEZrQ2EyNGMrcWdSdlpZR29YSlpCbW04cFpVL2xabk5wZ1NGTlRodXJj?=
 =?utf-8?B?V0xtLytNaGVCSFVmbTFrL1dhMWY2UEduV3J0VjNWT3hLaGN5WGNpdEtQYk9k?=
 =?utf-8?B?SXp4VEROaTdoUjhqTDJ1OVVQMEZGQU1oaVE0SGJoRjNtRmtTVENCQndDY3Nk?=
 =?utf-8?B?bG1zK01JL0ltVXFQNisxZFZTWFJVQk1EcFcxdC9makcxVDlQdk52ZnlUZ1Bn?=
 =?utf-8?B?U25qM1dpb1dlR3EzbTNkN2JRWmJOZlRvTjB6MlZMQ1FUUGNzVWdRSU9Obkk4?=
 =?utf-8?B?MHFaUTU0dFVwbVhCUzZRbUMwajlQZTJLTXJrN0JBbmlXTlZlVFNYWXY4NlNC?=
 =?utf-8?B?cjJUZHkzWEtMOUpad3FWY1pWL1NQUDBnSldpQTlTUHRWaVMrOXRFZXlSYWE2?=
 =?utf-8?B?L0pueUtQaXpBZmZtc0ZFR2xxTVl3bXIvUVNieDc3emJFOUwvMHVUMUR4Q1VD?=
 =?utf-8?B?KzFMUHhXWUtqWm1XY1FSMmcrV1JPY2d5R0UwbzFPcmh1UUExdTR6V1Q5aDdp?=
 =?utf-8?B?SFhtR2E4b0xXaW5OSFI5cGNpaXJ2N0V5bU1XTzhGMDNDSEk1NDV0TFI5Y1ky?=
 =?utf-8?B?alo1L2lDOVUzOTdpUTgvMDVVbldVaHZ5ZTdzTnBocVBQQWhKZ3ViSWh4T1Bo?=
 =?utf-8?B?WFl1TXFsVVdvZWlGYkxSdFE5VDloNS9IZ2JQb3JKVmNwQmlRWDhaUzJJdE4w?=
 =?utf-8?B?bGhuSWJyb284VStDTXVtRmNPbHF2T2dOVXYwNTZRdGJQOUVMSE5hUHRyNGUy?=
 =?utf-8?B?Si8rZHBvSjQ1dk1nRVZwU1FSMEtBdk9CU3dzMndINHViR1dKYXJBOWVFV1Fk?=
 =?utf-8?B?YmozUHhHMGVvbXlYVHpLa3paS1E1NXZlS1VhZjd5SisyN1dIb01IaDY1VHZQ?=
 =?utf-8?B?ZmhBV1VyUmVCd2hZbnJyTENNSzNBNmcyNkxsTHVRald4bld1azVOQlAzKzIw?=
 =?utf-8?B?bUNVQTAxYlZFUHFuODFPd3A0djIyLzhHeFBteFQvM2UzbloyV0REdGxWNkJI?=
 =?utf-8?B?OTZqRWhFNDVDMTdmd01LbDZ4cC9ac1ZUSmxHQnJ2bzk3bjVldXdrK3VFTmVz?=
 =?utf-8?B?emlwMG5HWnlkdDVzREg4MjhXbXpqekFMRk40Z1VxU1pIckRPQWpWcG03TGVO?=
 =?utf-8?B?WGc4TnhrUXFlRXhTVjM1NjQ4em9zNk5aZjN6TCtFN1c0Y2tUUkEwL25DYVhR?=
 =?utf-8?B?N2ZjL2orWWU0WXAwMWJZUlBxdzJNOUVtYW5VNlBEalJFN3Zra3pOai9wdU94?=
 =?utf-8?B?YmlybE5NVlgwR2cxcGo0TFlGT0hBOEwyVjR2RElNc2krZXNOQ3ZiTysxTGpI?=
 =?utf-8?B?V0V4ZHcxYjR6dDdxZ1BSaml3MUU0ZW5kaVZRZzRGYUt0ZGNkNWZLaXdIeEww?=
 =?utf-8?B?R2NUVFliVTg3cXlzcDdKUnY3eVpzaWtsWTZURGd1eHI1S3gvVHNPMFRaWTM5?=
 =?utf-8?B?bjl6MFJlYWVWTnBOMTVRNXM2Y3BNaHQwYkFyR0lKalJORUE5OUNyb0x5YUV5?=
 =?utf-8?B?RG9PTmRDSGNZOUE2am9Ed1FranFBYm1DVzF2Z1p0UHlxY2ZYcXBBQWlrZzd0?=
 =?utf-8?B?aXFXNkVGNkxYUnBZYzZNZVZUQmtEYWVZamxJSCt3TDNxY3ozUHlhNm1vTXZz?=
 =?utf-8?B?OTZWYnJ3QW5WU3dGNURwSVM2WDVqMEI2Q1ZtQnpia1pSa1RUZDBOditROTJG?=
 =?utf-8?B?T21rUGNmdTIrVmd1MHVJWnlhZGQyWG1MamNiVGhsdXRidnFFQWgyWFZaYUFi?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2VBaXhZeUNxV3BhdStRVnVuaXFyVHNMQXpMZkt5WUZJVE4vOHRPMk8xTUNT?=
 =?utf-8?B?MWhlcjF4UVVYcDhOdEhGazFFYVRuVzQyV3Q3TUNEeUl4Y0RvTEVlaGhZN3M5?=
 =?utf-8?B?NjlaejJPbmRENXpVeWNEb1dHY1pXTjF0eWpkT3dQZVFNaW0wNU1yL0s4TWg4?=
 =?utf-8?B?TmtwR3NZcG8yMjg3Zk81M29GUWt0c3VBVlBaSXF0QWNLY0dBWlFmOHJCU1I2?=
 =?utf-8?B?b1M1eVhsbXdtYlB2TWRRRk9URzh6NmU2RmhVK3FXYWM0Nng2QUo3UGs1aHc5?=
 =?utf-8?B?aWZ2VW9Xa3FnOUxnWHlIY2x6dlZ0aGVqK3M2K05GOUEyNFNoZFFVVFAxUkFJ?=
 =?utf-8?B?OUtycEI0bjZaMStRUnFmbG1rMUtaV1I4NzM4ZEhKY1R6V0pmakxUaWVlaHNB?=
 =?utf-8?B?NlZOYVR6TnhrOXhJcWNVWStveDUwT3JnZnpackgyUEdDalFYekxuY0Z6cFcw?=
 =?utf-8?B?MUZZN2xxbjh1RGtaRjJ4YXRzeG9BSEsyTEFFbmExcFZHZG5DNlpyN01pUHls?=
 =?utf-8?B?YnVZUnJxUTRFRFE5emgxWmdyK3R2bXlMNjh4djB4NzNoSEhoUnc2TWJ6UFBR?=
 =?utf-8?B?ZWtDcnpPeXVKVW42dC9ZRE1PaU5TM2graWVSbWFBY0lGK1JkRmtCTW9iL2lE?=
 =?utf-8?B?aStUT0lYVENQR29lYVZhVTEyTWJPeUw1Uzg0THQzSEIyMXNOUU5zN1c4OFhj?=
 =?utf-8?B?L2loK05OMUNlZ0FYeG02eTBvMERiN1pxbHM3SENrUS8xT25XVmV0c0Qrc0xo?=
 =?utf-8?B?b2xwUVVieitNNTZIMW1BSk1GKzYyWlhCZm4yOVZIMmdzc2lKL3RYSHZpczEv?=
 =?utf-8?B?MVdGdzRNNnRPZXZhQnVUM3doMzVtTTAxQmZNcHI0ZEM0bkI0elJlQ0lhNFlj?=
 =?utf-8?B?RS9ZWC8wNlc1WnFHRnNldlZDRDdDSERpdVFucTdxS3lKMEV2Qzc5d1hDbGNW?=
 =?utf-8?B?TzdPeVh4VWxyQUZWcGpWalZPa052am81OHEzV1F1WWdXdGhhSDlsUVNkblRZ?=
 =?utf-8?B?b3h3THlQNE5MNDFpcjI5NG9NLzVuQ3h4d1BubXJRTHNqdFFWMlkzckNhYTJt?=
 =?utf-8?B?TjVUTGw1S1hEUzhBYk1iMmx5V1hiYlYrVlFWNGxZdXJOa2prc1hCOUJQSVlh?=
 =?utf-8?B?KzdEaERZV085ZW11ci81SGxWd1I3OFU0bTM0ZHpzQlp3OTFIaUJNOTcycmJ5?=
 =?utf-8?B?T1dtZ2hHVEwvQ3ZjMEltL09NZUdON0J3Q2k1NktVc0N0RDF3ZG9iVTRZZFo1?=
 =?utf-8?Q?KbrP8jaADgjF2Ra?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8bc334-2826-42eb-062b-08dbaf7e6718
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 08:42:43.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZI0+Xb+xn8yt1cMmHn7RLIO9D1ytWdxaAddhj9tV8VDHtT7b54BdAMhKskqSUKV6/Gwr1MBssSytE5K7tTgH33i3Q+ar8u0sGWzg9Lrvz2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10165
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGVsbG8gSWxwbywNCg0KSSByYW4gdGhpcyBzZWxmdGVzdHMgc2V0IG9uIEludGVsKFIpIFhlb24o
UikgR29sZCA2MjU0LCANCnRoZXJlIGlzIG5vIHByb2JsZW0uDQoNCjxSZXZpZXdlZC1ieTp0YW4u
c2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo8VGVzdGVkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWpp
dHN1LmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KU2hhb3BlbmcgVEFODQoNCg0K
