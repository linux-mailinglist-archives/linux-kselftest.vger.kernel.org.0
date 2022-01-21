Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADEE495B78
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 09:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379265AbiAUIAB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 03:00:01 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:24953 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379221AbiAUH76 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 02:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642751998; x=1674287998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XtEtuEDOkt3mx/J38kmPdTtIHNer1qpbZZG0IxAUfvE=;
  b=JUliiPLg0FbWYBmw336SrGKZybxqNN/GH+TckMDpuCwMksyM/s+/fwrK
   sgLrh3y/BU6TQG5UG3BiWPze1qTsT/CfRzR77fzzvbZ0s0+DlFPRzKrRq
   UuFOWMCcoaI6Z1R5DLaS8FU/0Ad6XTSTxmLrMJi8ZR7VKO2J3fhiyvj3a
   e1gLl8sUSWLxJwHqBabUhrinmpuga/M5Az4JL8qj+ECCAL3/1o88fym6b
   8Z+PCGL2cbya99mCFufoVWqW1dLVs717nLpfDcV4Ox9WTDLqgDm+TxSS3
   QeZVtIuatFCG5j+nxBOP2qMvA7bwBgTpO1WLn5XJYwTXhO1kV7k9y4H5h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="56197956"
X-IronPort-AV: E=Sophos;i="5.88,304,1635174000"; 
   d="scan'208";a="56197956"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:59:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0VzwibTyYHKNlP9eX9dWparWv91FdH+gdNWUq/IBBaOjIdBzFsIjSsUA588JaYGcW9bX/XJTDZu81TnIRaFEnpwX5r+TWU13mOJhJgapGLC3NmIjUc92mgqPyZ+M/seZlogwVkIX3sgLfFS+bGYqgnot53g2DB4ZoqoJoApgxwVotmoIW4cA8UYJzANRA4afnD83ZPjKV/CW6v5wNBMmI0e9nUg1Ddc9kA0uYKYcHgw2F+l+oGdBjXg0f66zHjTNtGOCsQq4RFNz8Nil6o0MHQq8jZQ23RAsXajIK9pHQIzX/GuB/uN7tN5mFMdI0OxY9vrJX4vglGkN6E9daHkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OTAwDOdHyr4/7uuQIIhwXZGotUmfcvU538QkA7g1KE=;
 b=LcgyKwtxxtgYyyCiNa4jyoLac2QLul6hWpxbEIdCR+DvLdxXWzXEE4/KXJ9coFzokygivsBmyX8yGoQAoKC1HTgFUHC6DCd5KNJSimbJ1EazCKozn6yww4wIs5YTArl9YJ3aMTLalVoFeOCJpmxQIwmqZ94zJz7WaIys4Fia8pGPQ/dtoCAViDlMb08zbg02tDK01OIsJO5AR19ini+tHp/FwVjHMW4k6JuqbbotbRspwreAuuXkKJXLTgX2kTbmih2yQtdNW+NuVHtfE/KDL/nnunu140VASQEOlEQ4viyJDVQDXwDAla8iCVwUWo+S0ApDwbfvvMwBH53UOEtBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OTAwDOdHyr4/7uuQIIhwXZGotUmfcvU538QkA7g1KE=;
 b=FW5vyCoA9zqqJm4bK0mvgrS2NEdIii6p8tJa41nbR46B6Kc2HeEhZlWstI39BIGrXIzDPfqYA5W+icCQgQhvn0QqJ0F6mNBni5Igo0vxZSlchIu7dYfS5GaXTlO9eZtoa6NfHpRT9fLJC1k+nmBo/mlObXOYgNxz0qJaxgKYsuA=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB6505.jpnprd01.prod.outlook.com (2603:1096:400:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:59:38 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%5]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 07:59:38 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] selftests/resctrl: Change default limited time to
 120 seconds for resctrl_tests
Thread-Topic: [PATCH v2 4/5] selftests/resctrl: Change default limited time to
 120 seconds for resctrl_tests
Thread-Index: AQHX8AjEtZc9yygZX0KivH3QhJQEQqxW0CaAgBaIipA=
Date:   Fri, 21 Jan 2022 07:59:38 +0000
Message-ID: <TYAPR01MB63301CABB489B1A764A9E8718B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-5-tan.shaopeng@jp.fujitsu.com>
 <c8fd3125-b61c-8182-d7af-0f7a85eba345@intel.com>
In-Reply-To: <c8fd3125-b61c-8182-d7af-0f7a85eba345@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-21T07:56:22Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d011c83c-e3b2-4665-9965-52c9be36e71f;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2cfbb65-6703-4f69-3174-08d9dcb3f8e9
x-ms-traffictypediagnostic: TYAPR01MB6505:EE_
x-microsoft-antispam-prvs: <TYAPR01MB65057C6D6D4CE9906E4368AB8B5B9@TYAPR01MB6505.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gX7l7uFDe1OSXx4mqY/PzYLMSTKUJDVG4ewFvKd3PfIGkLU7ZtWCFLxG5zfcap8mjuCbFSTnFApdJB16PUF5hligYopIZsUUwstvZQTB2RW8skOTa5wjLCQu3QOjKXH73YVVvieU3YLgI8Pd6AvsA5++z7cQHU567HLJb1MjG41S1Qozwe9vfh0UDF/yvRIuHTlvl3rfTB0yaX1AqopBbFtUSydpa9Yi3DFzjGRFOelSobDl+0qva93STGx4AAKYmLF/R6chnv+bE1bcPHz65U+Yc1v7t0xB/2T76HncX7PxJ/rT14sWTKsbp3pBm/yU1Z6n6HXZP0aWFtGNJEWdqzutax/gkR3c2k1SDSz+ZKmN2ye4t21Olql2DIs/fN91QDfSgfbJuqsT8OIkg0Fqe/S7FQMthZATZcoHmJmUQmDc4alLLu0IVFUVtMFqwiSc0qyRd19sS/vOQ4GaGL+giNkm+NCthemBO6EPQ01V5Fn9S9Lx4UO9TIMY5tHd5uDJBI2cSpztNKz/4VPgQekPglTBpBQn9B0X4TpnKbT265JWhAZRINAYKmmJ8Bz1aPZaApRAKhbQzy6qHSveOyWCg/SKBlgSOOSxPKCO+fePM4anVr0io9pcoa1Rg+df/46g8O1BdWq7SlZXAWec/arWhTvBJDOzbcps9jnkOrkgoktvFn1GNnpReq0OkyjYdwe/6G4vOgva4pxmugBOfwsrEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(26005)(6506007)(53546011)(4326008)(9686003)(5660300002)(38100700002)(8676002)(38070700005)(86362001)(508600001)(186003)(33656002)(52536014)(8936002)(7696005)(66476007)(64756008)(66946007)(83380400001)(76116006)(122000001)(66446008)(71200400001)(110136005)(316002)(54906003)(66556008)(2906002)(55016003)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cGFjMHh1QXAvM29WUWQzSU1jeWVkOTZFL3F5OTB4QldQbW55d2xQSVE2?=
 =?iso-2022-jp?B?UFZkZjZwTmJ4WmNvdTdnc2c4UTVkdkFoamJXbDRPc0g0SEtNMEZ6cUNh?=
 =?iso-2022-jp?B?aUUxcU5hbTVkUXBvVnRERXNNcUlxOGVZVjMwNndMaWg3Yy9zL0dhTmE2?=
 =?iso-2022-jp?B?byt0NVhaOTM3ZDRaRzJvTGQ1MDF4aGxQWjJERG5QbURBVzE2TGVoZkdO?=
 =?iso-2022-jp?B?RlBESXREUEdnUUY2RUF6VTFVQkcxZUs3VEk3T1ZSTE1LcStNNmU0T1FD?=
 =?iso-2022-jp?B?Q2F2N3Fndi90V0NFT05rRG4wc2drTXpzYkVjQ1BxeWtDUGhOUnBEeHd1?=
 =?iso-2022-jp?B?M2ovMzVZUmxvZUZ5c0cxT1pzOWx0UmdLbnR1eWRDdjVZbTc1MXl2R3gx?=
 =?iso-2022-jp?B?eEZielRXRGtaWEhHMHYxT3E5dEdnZlYrVng5RjFDNHlYYlFjTFVhdEtC?=
 =?iso-2022-jp?B?MlNMek1HcUg3bXNNSDh0WklpWmpBcUF1aUJ6eEVhYUxCb000cGJxZDAw?=
 =?iso-2022-jp?B?QlNSWll5LzI1SUY5MFlFWEJjaEVHbEYvRG9UMGhUdTU3Skw0Y2gvcDJ6?=
 =?iso-2022-jp?B?NXprZ0ZxRTBiaHNaS0dKNTljbGg1S3lkaUdKaVFNZksraS9UY05KMWF4?=
 =?iso-2022-jp?B?bXBwekNBdUJ5MFNIZFRjbjRLRlhBK2ZpMzhlcjBCUXQrZEt0bUdURE5z?=
 =?iso-2022-jp?B?RTdmdmtIbHBpbjNjU2Z2UVAxUlFnY1ZkRGhDMm1VMDI3cS9tcVA2ZW9V?=
 =?iso-2022-jp?B?eGU4Q0cvSXdhK29vWjY0eS9RUnJCUFNLa2VoMzFCQ1JaTzJlQnIzN0ox?=
 =?iso-2022-jp?B?RHFmTis3T2lJck5maUhDM2g3VWZVL085eXkyK3czYzlGT1J4Q0JQMFh2?=
 =?iso-2022-jp?B?eWxXYmV4OWJmL044cnNDeURwTWQwQ053RTN4MTA1c081RnJ4d2ovVWFk?=
 =?iso-2022-jp?B?dE9SSENNOEdvRG16aUF2T3FYSXJrai9QSEJac1ZFQXNmSVRxMW02dWVl?=
 =?iso-2022-jp?B?ZS9wbGVLVjViazI0Sk5UcGVsMmFWRnpYQjRwcTlKRVhaL0pCYUFuRGdH?=
 =?iso-2022-jp?B?Q1V5UHllZE0xRG5MdDdOZWx0bjBBVlcyT3hTR2NsT1V5cCttVm9ubTJP?=
 =?iso-2022-jp?B?ejdsMkpvdlU1VFV1d3p6b3F6bDlieHMxTml4UVlsVUIzdWhGMzJVTHhI?=
 =?iso-2022-jp?B?NWhHZ0VJSW5MdUI4RG01YzA5OUFzeDEzcSt0MGxzdUFqL3dnMlhGR2Nq?=
 =?iso-2022-jp?B?M1ZaSlQ4LzEwbHFjZTVXZHRvZ1ZaVW5RNmcvZ1cwL2F0K1UwSHhPZERw?=
 =?iso-2022-jp?B?Q0tSRzZkOXlZYUorU0s2cUR3a1hDUGFkL1kwL3RsUG1GeVdmS1ZJTHk3?=
 =?iso-2022-jp?B?aWcwZ3ErdkswTXBiSisrTDEwMGFGV3VnSytIVFBWaEVxRmozRGJuY2g5?=
 =?iso-2022-jp?B?YmFtdEI4ZlIyMDhPcVd0VDYzNDFmR05HOXFDN3IySFZvbmJ0MTAweG5r?=
 =?iso-2022-jp?B?Qk93bjJIdnBhdUVMOEtwc2ptRHFpYTIxRUNNaXJRRGU1QlRYbU9VNk5h?=
 =?iso-2022-jp?B?UnU5MmhQTE5mRkFKRldqc2dwb1BaNHJodnJaVGk4UGtPMnVmSXRTSVZM?=
 =?iso-2022-jp?B?dEd2ZjhWcGFGS0I3Nlo2T3VNVUJ0bldDYWhhTFlVR0hxVWRIeXVmd1RB?=
 =?iso-2022-jp?B?UklaeUJ5bklIQkRvQVVYc1E3QnkyejlYQTVnVm1EL0RkbjMwYU42UlBY?=
 =?iso-2022-jp?B?TkNnS2JZeTY1Q3liTDhnWS9ZZDNvbWZDU2IxSmR3OW5Hd3RPZnp1YUY5?=
 =?iso-2022-jp?B?RC9TVEEzakY2QmlsZWxyd081azAyK0p4WlRPaXJXUmNGU3VwSlJSb1l0?=
 =?iso-2022-jp?B?Y1VQMVQ1aUxPUzFuTFpzcXBoK0k5c3Z4dUNpYU5lK1hDbjdvT054cjd4?=
 =?iso-2022-jp?B?eVFwaU96SEhBVWNzZkxxc1ZwU3FaNW1nZ05QOXFla1poWDlHNU1OL0lH?=
 =?iso-2022-jp?B?aFo4N0FBVXpZenJqdS83M3h0b0lJdFMrTGFsbHpFWTdLSkZGNWpsUXJ4?=
 =?iso-2022-jp?B?NlUzeFNycW9YSm1GbDdHblZNaGQ4dFNGaEN6RFdTSHp2clc1OGlCQThm?=
 =?iso-2022-jp?B?UGN2bVNjaDF6bFRJdjJRdzlRNi9uRTFuc0tZWDB4NnU1Y1lhZi83TXBu?=
 =?iso-2022-jp?B?U0trY3plcXhXTWJNbXdQamFjQzlaQUw1c0xDNzFzT082RVg1VktKc1Vw?=
 =?iso-2022-jp?B?aEFNcmFGa3RmNUpWdkhIRHl1eklYU3g0YVZXbldPVkRMZVkzMFZodmVp?=
 =?iso-2022-jp?B?NXZjOEFKOUxyN2t3U3AzWFZQZjVaTnV0cDF5SVFlSUwvSENqMkt3SWdY?=
 =?iso-2022-jp?B?OU5tWFJVUFFmOWtaSmR4NUlFNVUxclpTdTRiN2tGeDJqY1loWEFkMFMr?=
 =?iso-2022-jp?B?Q3NxNWNBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cfbb65-6703-4f69-3174-08d9dcb3f8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 07:59:38.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83qcWzaqKExq6Jt9RW+bife7Gm4PQnr4ZCvmx5WteipXLv2P3n83Jkl/Xc690JAZkSx8NAy031Hffe/lZhP85wWVkDhenU3q5cky2gfUm3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6505
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

> On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> > This commit changed the default limited time(45s) to 120 seconds for
>=20
> (This commit)
>=20
> > resctrl_tests by adding "setting" file.  Since 45 seconds may not be
> > enough on some machine environments.
>=20
> This sounds very imprecise when you say "may not be enough". From what I
> understand you have already encountered systems where this is not enough =
so
> you have established that 45 seconds is too short. The next question is, =
how
> was 120 seconds determined and how do you know it will be enough?

It took about 68 seconds in my environment (Intel(R) Xeon(R) Gold 6254 CPU =
@ 3.10GHz).=20
This test accesses a fixed size(250M) memory by default settings=20
which is used when run in kselftest framework.=20
I think that the execution time does not change significantly in different =
environments.
So, I roughly doubled the execution time and get 120s, which I set to the l=
imited time.=20
I think it is enough for any environments.
If 120s are also not enough, user can freely set the limited time by "setti=
ng" file.

Thanks for your feedback of this patch series,
I will correct them in a few days.

> > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > ---
> >  tools/testing/selftests/resctrl/settings | 1 +
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 tools/testing/selftests/resctrl/settings
> >
> > diff --git a/tools/testing/selftests/resctrl/settings
> > b/tools/testing/selftests/resctrl/settings
> > new file mode 100644
> > index 000000000000..6091b45d226b
> > --- /dev/null
> > +++ b/tools/testing/selftests/resctrl/settings
> > @@ -0,0 +1 @@
> > +timeout=3D120

Best regards,
Tan Shaopeng
