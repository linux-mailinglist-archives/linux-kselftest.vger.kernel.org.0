Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E354BF2FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 08:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiBVH7S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 02:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBVH7P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 02:59:15 -0500
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 23:58:49 PST
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325A1480D0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Feb 2022 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1645516730; x=1677052730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hxf+pz4tUi+RZgmZbCi/iUHfDtfPp88IPs2NyJpkJYw=;
  b=m5YVVNcyAxaE6zMbazRObiOf0Of3Cb7UK0/cSpDEHW9tu2cgZFStYDS4
   RUZ0bZewsKAaxYONvKziXe68rxMdAkuaxdAxRXMyI5srggu2kGyoEJ7FC
   aomF/bh9FYRaLtGxoW0t4q5OzgXY3qV25/DUbMt/Cf0YFCEq2p5ySao6e
   8Iwvck2v1qIkwu2Sk+oihsSoZrXbqn4FsmHue08nOKSUIZ4ACzQeYyLiu
   WJlCuCgx0TKhB+7EibZd2BFheDcN1KM6yip0QhRrtz/i/XBfMXlMtHyFn
   MbAkNf1K8ifOwMsaMzHKRGHl97429yizPtNn2Gp9jyy+asgYEk/aRY3E5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="50208839"
X-IronPort-AV: E=Sophos;i="5.88,387,1635174000"; 
   d="scan'208";a="50208839"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:55:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlaYNx8RAPdowG2GpsNTxTGbzuKFkp9npk3PystKfjjJ62E7DmMzLscU6lSsjCAZ+UUb3gCyKRwlnU8qQzvGTTC1VZ4u3DiCdYlFnDDzyhmmC0suzQ8mnN1gX7fcSgvxL3ufO6gw2zCw1xUV9qfuW8sllIOcBF7z8Uo5dZAsMC4hA4pHyaQCLIDOLiEpEo7BMGD3DTlEjGSmjepTC0vH3L4p26h8RO2QeWg1tbMcqtHNGYMLwNnnPHHva8ikv9Ghlcxe7tBHVnzRlTq8sBx9gq8io52KDBLdqWZ/Wb84ouo+wroxFqbyVh63NLKCfzBv5fUYu/0qqRLLZkvv8VCUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYTP6jDoh8hnlEXABe+TFh6mgsMHrOS4F0ZMOTS3Aao=;
 b=h92/IXX3KJu2gQ/UojuSRkThv2+hygxfUpfnAVZfyuGX/IJA2mY7wp6C7RWHh9wH9TbX9D+P3j4HvuoAVZeU15BSX0r3j28/Lx+7EerL+I4mzQZixr8a52LVvhUeccmnWZTiQxpF9yq+d4naT3zjBja0sQjsXodYpNwStteMZvbYyyN1DPSrfxyerMuDMGz40D6LhmXWLNUljdYWnNmWClbOorw/tSTOZ3lo+3zAqw3gXfsIwQSVM3Wf2eg1rljnWZhilLlVxcelBvqWaf7lgznejsEu4lycqhE4iIFx1qY97sqJwmCbwN/FiLTEs5Z48056/d/Vlz68hEeThDddEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYTP6jDoh8hnlEXABe+TFh6mgsMHrOS4F0ZMOTS3Aao=;
 b=cVQjEvGm6HK6v1QLq4Vsf71wrAGC8t7uyR2dG2xMmHR0ha3FxkMwe9QmRN5kCcQNjqOL7yKWnY4XJWoPkHH/KXRpmBa72Js8mKjsnbiOEBykjHzKtsw/BBDZGkL7zi34LIA0W0nD4RcFxTeNVlzCNwilp2F6WYnDg2Jo9N+LScE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB10119.jpnprd01.prod.outlook.com (2603:1096:400:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 07:55:28 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%8]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 07:55:28 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Shuah Khan' <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Topic: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Index: AQHYItzk2ZSlsGQE1kGaxUOyn+5ZpayZxhMAgAV2X6A=
Date:   Tue, 22 Feb 2022 07:55:28 +0000
Message-ID: <TYAPR01MB63302321D2A50D9A690993AF8B3B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
 <1bbc4049-2c08-39be-d82b-9d98ee663e72@linuxfoundation.org>
In-Reply-To: <1bbc4049-2c08-39be-d82b-9d98ee663e72@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-02-22T07:52:06Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a964f082-3c59-4c37-9314-2e3e077f62e8;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8586735f-b36b-438b-f599-08d9f5d8b12b
x-ms-traffictypediagnostic: TYCPR01MB10119:EE_
x-microsoft-antispam-prvs: <TYCPR01MB10119D934E7CA13AC6C93D1E18B3B9@TYCPR01MB10119.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ueQiQfPSllUB1bzI4WdNbayLx9scK93YFt+C81GvePl7sqtZCSpUyfAnEwQnPRUb7ny1c8qI32zNUMfCfy9RO71TIVgHOmk+OFqVSVyiNZXliCZsW71LVFd/uLQB1ZLG4PVJW1cPgdU7iNKf+B4ECFEuJOhYoOGuLmuXW5TqZMFVuuhdin+QE1zSSffuUIys7r57a7109sg18I6/xvtvQ5ijAXGWKyFvbWGN3mi9/NPB6R6wKYyh68urJ+hA5FzVdS/gHmqRWzgczLdITD78XS5fIlRjt4ZF5fTey0lQBsYpJVSUQvVW8JrK0raelFyu0ef5Fz8iD4tk8e0vUZ1lWoPU74yUNV200cF2oId8NSQuxgQ3FuHKw8L3znFDV3YzqutpSjzNulXulJ+BVUZHNmYijEWbCQCA2vEv3pT9iUhoW7tCzi3msl0czbrHKCa++LNcwvAASi1D7QhZAtsridJLVQE4L7vM3nZ/Jw5bWTGDhLw5+z4m8S3Gxn/GWcturhtj9RjDR+SmQsdQMRO+s+L2x5D5n6D6waUGOpqBGihIzxqK3P3bj5vxktrrsIUj+QQHq9wMSG/lLpfv79WUHPgI8LO8UBFC+bR/gVcz0hoWauaizFzoOOVzVdkjOS6LT/jbpZRglHgb4A9DC2uOb+wu073ZBpbggaytCrNNww/3S7DvLLV+44YKLAFim9SbwjbE6tUhnwUfbxFnfcxGyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(508600001)(85182001)(4326008)(5660300002)(66556008)(76116006)(316002)(66946007)(6506007)(66446008)(64756008)(66476007)(110136005)(9686003)(966005)(83380400001)(26005)(186003)(33656002)(71200400001)(8676002)(52536014)(8936002)(55016003)(38100700002)(82960400001)(2906002)(122000001)(53546011)(54906003)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QVZhNDdmRTFDZ0E2L0lnM3lDYmtSRnJNOTdhZ2V2YTFNN2JQaGgwd1Ny?=
 =?iso-2022-jp?B?WlRweXFzMzAxQXEyY3hmemZFOWY4VzhlMjhUQ1RSVFUzWE1aYmJKbVdp?=
 =?iso-2022-jp?B?Y3Z3cnR3YzJYcWswd1VCbnQzWHVEazcwOXNtZWtaUWVqTndkY3pyYnMw?=
 =?iso-2022-jp?B?ZjlWb2wzTUJPNzNlNFJKNVFlVldYWUpGT1dCczEwNWluNW1adldOOHlj?=
 =?iso-2022-jp?B?Z1JoMXRzdHcxUWNWL0NCY2pwQ2pUd1VqbFR6LzJjekRhcWRseThQRmxO?=
 =?iso-2022-jp?B?bXFmTWNSZ1Q3OWUzbjZmdW9la2tCNFNGb1RZRVRYVUcxT05QWlp3UFRB?=
 =?iso-2022-jp?B?NWlFT3dWZXBhTVpCRU1PeXdSUlNrWTNLSWF0SC9DVGYzVVNnUng5TnZV?=
 =?iso-2022-jp?B?NWQxOWZHalVRV1pVbWh1ZlI1OXpBQTZxWTlZbzFUVmJrZEYxdFc1UTM5?=
 =?iso-2022-jp?B?bzZiUmR6N2hHY0RJUEUzb0ZBSTdia3FHZHFsZ055bWkvSHF4QkV3SFM5?=
 =?iso-2022-jp?B?RDQzOWlILzhRZHQ1cEVtbXQ4QlprRWtCTGNya1JGVnRidWFuRE93L1Fr?=
 =?iso-2022-jp?B?TnpDUjQwMXZRMUVXRGMvT0ZmTFgvN21YeUVWWDRybnNGcFo3ZGFTdVI4?=
 =?iso-2022-jp?B?WWxwa0V3T29jbnE5aGtRZnNZNkQxYjFTMHlhQzI4YzhIZ3l3bzBYbkE0?=
 =?iso-2022-jp?B?cjlidEZTU0NFdzlzMzN5bGJFL3I0NDhMa3Q3SHdROXBmQ2g2Z0dDVmVh?=
 =?iso-2022-jp?B?Q2hOTjdIeGtOK1c1UW91WnpQeGN4RDlEdE1waWdkSUs5WGs1djBtRU5C?=
 =?iso-2022-jp?B?ajYrSkVXeTZKUGVJMGVENnhZVHlESXdxTVRUSzJILzBaMUZpbGlDVXVm?=
 =?iso-2022-jp?B?V3hoaERlRTZFS1V5Q0NSQXF3VnN3aVV5REFsUlVwb245ZDNwTk1mZ3hh?=
 =?iso-2022-jp?B?NklidXpHWSsycGpVU2FDdktFNHhZeFZQMjRTYzlteGhJSUkydWFza1pi?=
 =?iso-2022-jp?B?eXZFMFZZMkkwZjBJQWdyYUltTldlMytKdjZlNVNNNXBsV2hHVXNZODlK?=
 =?iso-2022-jp?B?TVBQTnhBR1VkZzN6dmFOcFRIWEhkNmhKUlpmTnBwQjQ3dTlNMkgxd3Vx?=
 =?iso-2022-jp?B?bXh0ZEJndGNvN3lBWFJ0SU5ZWTZaMVhhVFFvWTVqYWxhRjNHL084eDB0?=
 =?iso-2022-jp?B?RFFWc21nbzNzMFVMMmpuQ1FBakJscVUvN0ZVUFNIWk1XMnFLaGhwMUVt?=
 =?iso-2022-jp?B?WFZUOFlNeGcwU0p3QlZxT0FNVDdxdm5BaDI5UlU4c0h4d2hQaVpzcWdH?=
 =?iso-2022-jp?B?TjA2dThhbDF2N0hRY3lDME16ZHV5YW80TllrdEdrUE1SdVR3a3E0cW1h?=
 =?iso-2022-jp?B?TzZKVlRUU0RiaW96TlI1SVhPSnR6VkI4VjByQ1Fob3BWOTIvVTVCSmRy?=
 =?iso-2022-jp?B?bE9TSWFZUUMwUkF3dXU3b1d5V1NRT0tDYXQrcnNOOGpCNnAwVFZjTXFj?=
 =?iso-2022-jp?B?TjBSRDZDYktDRkFLQW1KREExZzZ1VW8zVEduZUVOTDNvY0hCbkM2aDhK?=
 =?iso-2022-jp?B?Y2txMGhXZVMyZll1TVY1NmJZNllFV1FYSmFFRi9NYWhKdHdtbjBjcEZP?=
 =?iso-2022-jp?B?ODdTNnZRMWxqdHQ1RWVQdDdRN0dzNTIvbkVTTGJBQ1F4QytOZW02SU1r?=
 =?iso-2022-jp?B?Kzl4VDFaczhTQ3pIclBZcGpLUEErWkV2RTljRFpOK1FkN0poMHJ1R0VX?=
 =?iso-2022-jp?B?c0pIamhuZmx4N3FueVRIWXlrdUFqbnBPeUkwMEVEQTZLMFlKK1YxdDhu?=
 =?iso-2022-jp?B?THZLTzVyeWQ0VU92eDlaMnBSaisrd1BKL2tzVitpUldwS0EwcUtYUWtW?=
 =?iso-2022-jp?B?OXVza2I5OCt3QVN6ZVFrYis3ODdiaEg4bWJSOHc5cFBOZ2dWQkZwOWtp?=
 =?iso-2022-jp?B?VnkvcXRSY3VKU2lWN0JweXdLd0xZYyt2ZzR3U1NOeFdNOVNaYWN3cTBr?=
 =?iso-2022-jp?B?VjdEbUluU0t2L2tIejlEKy9ta1JQeW9UQjRDZjNaRk9lbHhETWVpK0Zn?=
 =?iso-2022-jp?B?UVJtR1NIQ0Jqbm5zeFkxOE9UcU1aZXNicGpWWDFuOWprMzZHcm1SUDFt?=
 =?iso-2022-jp?B?cFFHK1NNWmdLdFpCRFlyRUtQcGJNL3J6ekRBWlFxU1FGbGlRYW9MUmY2?=
 =?iso-2022-jp?B?UGZhVjdqQ2JTcG1FQUVZNUxuNnArQ2FBR3FtQnVucklsNjkxYVVrT0Nr?=
 =?iso-2022-jp?B?K2pzOFMvQlRjVzNNTGF2MEZWbHVLdTJMTkJIT2o2U25wRHV5Tmd0Y2pw?=
 =?iso-2022-jp?B?N0ZRQ0lsbWFDdXh4ZFpiVCt2WEhNRnh3VC9tVmw3NFBkTHlLc25hWlc2?=
 =?iso-2022-jp?B?dEgwU2l2ZTlMcWVaMXBvNTdmUDg4WUlxY0FKWUloNlQ5MXdiNENWRmFj?=
 =?iso-2022-jp?B?UGhLN0F3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8586735f-b36b-438b-f599-08d9f5d8b12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 07:55:28.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/0PhHxioZfws/luwPDrJZuWU9hO3AK7UppkIgYqiwr1bdbF9bx1Z3TkxpQe39MniACeMNCOKXNfyMD2NUcxHvEXFECbnAJHHZOnB1YEdZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10119
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Khan,

> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> > In kselftest framework, all tests can be build/run at a time, and a
> > sub test also can be build/run individually. As follows:
> > $ make -C tools/testing/selftests run_tests $ make -C
> > tools/testing/selftests TARGETS=3Dptrace run_tests
> >
> > However, resctrl_tests cannot be run using kselftest framework, users
> > have to change directory to tools/testing/selftests/resctrl/, run
> > "make" to build executable file "resctrl_tests", and run "sudo
> > ./resctrl_tests" to execute the test.
> >
> > To build/run resctrl_tests using kselftest framework.
> > Modify tools/testing/selftests/Makefile and
> > tools/testing/selftests/resctrl/Makefile.
> >
> > Even after this change, users can still build/run resctrl_tests
> > without using framework as before.
> >
> > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > ---
> > Some important feedbacks from v1&v2 are addressed as follows:
> >
> > - The changelog mentions that changes were made to the resctrl
> >    selftest Makefile but it does not describe what the change accomplis=
h
> >    or why they are needed.
> >    =3D> By changing the Makefile, resctrl_tests can use kselftest
> >       framework like other sub tests. I described this in changelog.
> >
> > - The changelog did not describe how a user may use the kselftest
> >    framework to run the resctrl tests nor the requested information
> >    on how existing workflows are impacted.
> >    =3D> I described how to build/run resctrl_tests with kselftest frame=
work,
> >       and described the existing workflows are not impacted that users =
can
> >       build/run resctrl_tests without using kselftest framework as befo=
re.
> >
> > - tools/testing/selftests/resctrl/README should be updated.
> >    =3D> I separate the update of README to a new patch.[patch v3 3/5]
> >
> > - Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
> >    why is "SRCS" no longer sufficient?
> >    =3D> I referred to other Makefiles, and found "SRCS" is better
> >       than "EXTRA_SOURCES". So, I updated it to use "SRCS".
> >
> >   tools/testing/selftests/Makefile         |  1 +
> >   tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
> >   2 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/testing/selftests/Makefile
> > b/tools/testing/selftests/Makefile
> > index c852eb40c4f7..7df397c6893c 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -51,6 +51,7 @@ TARGETS +=3D proc
> >   TARGETS +=3D pstore
> >   TARGETS +=3D ptrace
> >   TARGETS +=3D openat2
> > +TARGETS +=3D resctrl
> >   TARGETS +=3D rlimits
> >   TARGETS +=3D rseq
> >   TARGETS +=3D rtc
> > diff --git a/tools/testing/selftests/resctrl/Makefile
> > b/tools/testing/selftests/resctrl/Makefile
> > index 6bcee2ec91a9..de26638540ba 100644
> > --- a/tools/testing/selftests/resctrl/Makefile
> > +++ b/tools/testing/selftests/resctrl/Makefile
> > @@ -1,17 +1,9 @@
> > -CC =3D $(CROSS_COMPILE)gcc
> > -CFLAGS =3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2 -SRCS=3D$(wildcard *.c)
> > -OBJS=3D$(SRCS:.c=3D.o)
> > +CFLAGS +=3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> >
> > -all: resctrl_tests
> > +TEST_GEN_PROGS :=3D resctrl_tests
> > +SRCS :=3D $(wildcard *.c)
> >
> > -$(OBJS): $(SRCS)
> > -	$(CC) $(CFLAGS) -c $(SRCS)
> > +all: $(TEST_GEN_PROGS)
> >
> > -resctrl_tests: $(OBJS)
> > -	$(CC) $(CFLAGS) -o $@ $^
> > -
> > -.PHONY: clean
> > -
> > -clean:
> > -	$(RM) $(OBJS) resctrl_tests
> > +$(TEST_GEN_PROGS): $(SRCS)
>=20
> This patch breaks the test build - the below use-cases fail
>=20
> make kselftest-all TARGETS=3Dresctrl
> make -C  tools/testing/selftests/ TARGETS=3Dresctrl
>=20
> Also a simple make in tools/testing/selftests/resctr

Thanks for your feedbacks.
I applied these patches to the source below and built=20
resctrl_tests successfully using above use-cases on x86/arm machine.
(1)
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 Tag: v5.16
(2)
 https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 Tag: next-20220217

Could you tell me which kernel source you used to build
and what error message you got?

Best regards,=20
Tan Shaopeng
