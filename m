Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3626497A01
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 09:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiAXIHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 03:07:15 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:52729 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242055AbiAXIHO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 03:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643011635; x=1674547635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uuRPq1+t1/fQg7WeNOHxldcxhBR1wXCyp/EPzk/sowI=;
  b=W/RoHsLfWvWFTc6AhyKZlK9Uzq7QkMFZsbzJS2irlFzgg/aUJgDVahfl
   8BheZz0r66qO4NznOKgG6THev6l6kXzqPkmTCMJV2oZTmyQSir/UPhhkN
   cDzeWSxmnADOgHZA1TJGtQZi/R48C3P9o8KJJpPAepmVvX2nqCYDq07Je
   f8FSxyb6s8ObxVHngsuo8eepQjZaE2vLe538/BJjY5F7RYD7GUNC6r0hH
   9q+cMs92+GBQnUklpFF5vtS6dG4WgqDudk7LV+iFMePI2zNZoUb1Dxy1z
   65T/tUifAGgOi6AF8ba9FvlmOTZOMNT/iHTxWNGoHggl+cvDLu7GO60RP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="48042695"
X-IronPort-AV: E=Sophos;i="5.88,311,1635174000"; 
   d="scan'208";a="48042695"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:07:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gquFZ6+gAqjx7KzJRk+5XiudPMnfwU3En3ahIqCxxhdMCLpRE2v/TbOQkyllBK/UtUxL02jbCy5U0xwo9Fjw0Jh/aGvEiLts5b5HZ9csIZdslR18tcZ5QkSN8pWS/pTLKxcKlSIXJujatIR1P+PuoEZ/vB8AECiGBUDyZTKwju1DDPo1itw29jg1LkM/fDkIZnWAgYdWEMo1/W6P5J95eXwC3mpFHELq7ODwFa32jPYegIoQr+Uwvi6NHwOE9mRbh6EGMa/AHeeSbVQjeR2CJo3BDiydXNKhZCRzBfjnJ4YWjZGVmmNe2v6cVvmgGRunTWP87Yridi/vJDJD0JWPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YVCMPlSNZqSslTmflY3hQW0JuShiizFMwTZz1982CI=;
 b=MgRSmyAFdjfnzmCOUiBYrQ3alMNJZlgxpEZwwf8S/Fq7o2p7ZjbcY6coNJFeN/6vNeK1Dnz5t4xpyAbRCzYqHQYGjFyCp3X2yk6fdYNYHgVZRAhbecW1an3+AtVcjMj0segUyspApwSDgSTM0I6yMJkAslwKmM8QVwTN4gczsu8iTHqFh2lSENnGGaOkQbQIhdHR0vv3KZuGaS+JEJ0MaUKXmv1yE0TBvdw1C5VKZf7mg3Rg3TU8VrTczRfJcrd5BfK4r2Js1jNqf+9M22sEENcvJ/DUKI0TZ5BA3QG8EVA5NNpnhVhFqUH1VVc/RQ7dUgKLU0N/P5WjqBVzz4qFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YVCMPlSNZqSslTmflY3hQW0JuShiizFMwTZz1982CI=;
 b=jtsfmTqNMCg8S6jKHO25U7XR5klmlBCl38v+PwjWKcwQsZEOvgx8OUcNCFEs/oSE7catNgzay6ITsX8KxqJmHZV4ZFQ2ND0GKuMtsPOhUElT+uKBtVZ6pRRyJI8DlYMDA5E9AIft6Uhz/O+MHZmkD6/zyc88shILLUJaOvg5Xmk=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB2123.jpnprd01.prod.outlook.com (2603:1096:404:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 08:07:08 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:07:08 +0000
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
Thread-Index: AQHX8AjEtZc9yygZX0KivH3QhJQEQqxW0CaAgBaIipCAAKpkAIAEDoqA
Date:   Mon, 24 Jan 2022 08:07:08 +0000
Message-ID: <TYAPR01MB6330667D087361CE452672D58B5E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-5-tan.shaopeng@jp.fujitsu.com>
 <c8fd3125-b61c-8182-d7af-0f7a85eba345@intel.com>
 <TYAPR01MB63301CABB489B1A764A9E8718B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <db556fff-90f5-a513-e823-db33b121f3e0@intel.com>
In-Reply-To: <db556fff-90f5-a513-e823-db33b121f3e0@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-24T08:03:17Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=45be6fc3-5705-4427-86e7-cff02447f11a;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7331261-5625-4d75-295b-08d9df1084aa
x-ms-traffictypediagnostic: TY2PR01MB2123:EE_
x-microsoft-antispam-prvs: <TY2PR01MB21239EFCC8DBB8DBD6166D798B5E9@TY2PR01MB2123.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOwGc/I/FdoFR0IUG3e4YZS4H+GOr362+ETft716M5rG0O8rOrB8SZ6R08LBojFQNtEj+RILEKOF+xyEs91H64psCF9kuO0cjbOxHyOqdeemx3555gJ0R2XK/7ikmJG6AIjdXj390YT/2KuF9F0zlmBEKO2H1lC7ADrfftsHk9w3/QdG8ZPi9VCxAQelcqbveEDVGAqNGwdmrjb9m0H9w8mH1hGY4t27KASYUXhmj+2tgT+tX8w89/OLLmT7ErAYSUEfFqcZW92hxECpFT9gEdfmh47P5ES+BRmP+HcC6syUYFJTrLhu4akUpNJtZxjl4iHYA5ujoIGFote+NZS4uDlFv4tJXmjYvsh1f0QLDFYvFh52Q1RVcRwT6wUQOUpZaCpkcTb+Tz2gZEHlyHGjEVQNjPOA4VrS/ZUp7aqhNovOGzOCsO16wfTbv+xgFxPHdIbF8d72y+kT/0dSUOVSUI/KK3lHnKbARdpe1mT5apgF4MrY+AEperQ8d5qLTfuAIYweN8yrV5jEyWODI4jErjk5+e/AgYNlt3Rvdkj3OSu+qBjoA9PG6vOyYpqyfCGhZFR0lGnITY923BI680LoyV4VUVugdnsX2yfTIv23/2uf3wPmdgp/M1UWh8gVvhEu1oSY+tKF5p1KAqE1DB0nkShkyAtbhxBZayavubFEqD0o6Nb26ZqmaDxsTgF5mVwgRJA09B5hJIac96M5dMpyLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(71200400001)(38070700005)(82960400001)(85182001)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(53546011)(6506007)(26005)(2906002)(186003)(508600001)(38100700002)(122000001)(83380400001)(52536014)(54906003)(7696005)(5660300002)(9686003)(4326008)(76116006)(86362001)(8936002)(55016003)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Ym42ME8rci9JclRkUkVrYkc4cFVobTBQclRBeWVjbm5VYTNXYUtYeGs3?=
 =?iso-2022-jp?B?eFZtMHVUWWJkVy9weU9kY0dXdkRBVWtvMnBVWWNyUXNobE9sVVE2d3Qx?=
 =?iso-2022-jp?B?SGIxWTE2Qi84SXcvYkhJZytxeTNnK252N2ZlVHB0Vm9RK3RWMzlGNUNm?=
 =?iso-2022-jp?B?a01tMnhybFZRMXBZOVdjTnBYUE5IOHFFc3dKRDNyMThpOXQ2MEplTm13?=
 =?iso-2022-jp?B?ZVNOODBlV09ZQWFhNlZHWGV5ck5UbWMweTRlUmJaUEsrMUZrQ2N3WmpF?=
 =?iso-2022-jp?B?UTJwbE1iUGZZNmNjY0VHRTcyUkdvQTA3aDhXSkpWNUU3eGxYYXdqL3A3?=
 =?iso-2022-jp?B?WThNWk1JV1NHdmJ1WmcyRXdTaXJDZm5SbUlsU0hyb3Q2bGVIT0E0Y0Yr?=
 =?iso-2022-jp?B?VkwrTTJ1R3VycFBaSGJVcE9McDRkaFFOOUxKY2g2elA0NGZldXRGN3lu?=
 =?iso-2022-jp?B?YTV1Qml1eXVST1lrMGo4MDNWZWtSWlVhMUhtTVREbnBJcUlEWHZIU0RT?=
 =?iso-2022-jp?B?UDRRWVVGbmY1Skl1eG9UY2VKT0ViMXg1MzJFTGM1TWJkcjRMMGRsdWVj?=
 =?iso-2022-jp?B?STNuYWlRZ2l0TjNlOVpBeFRpUXk4dnVscCtYZk9IY1llWjFXd0U4UGV0?=
 =?iso-2022-jp?B?aEYvNW5BRWFRNWt0ZTdQdm9iMit3TmNyOHk5MnVCY0JiV0RpV044N3lD?=
 =?iso-2022-jp?B?Z0Nqa1lvWTcxOGNnMTVvbHBVbWc5dEtnNG5xUEw4WGh2cjIzdVVoalhT?=
 =?iso-2022-jp?B?TmtjWnRZL3VMZUtuN0pJUEtEbjJUakVJS0RCWUl2WFlwUmdYQ3J3eHFO?=
 =?iso-2022-jp?B?V255QVFvUWE5UjBBTW1IQ0xuZHZ0bnBiWGl3c3hwbkVlMytkTEticmJy?=
 =?iso-2022-jp?B?MlhGVTBWaHVuemdGRVNXelRxSnlEZGlQb2Y3ZkptWWVjWmt6MFVGREVE?=
 =?iso-2022-jp?B?N0VhN3MvUVpRbjZZRWZnaUtUemUyUG4rMjNVSmVaSU5qTnVIU21WTms4?=
 =?iso-2022-jp?B?Q1pxdEd1Q0NiMXFvYVUwRGhyako0SFdGUmdtREdsNzRrZytWMXZxcm5K?=
 =?iso-2022-jp?B?OTdnamRnMDJpWThVVEIxNTE4TWZVekVhMlN5MnpROUFQUy9LRjQ5TFJE?=
 =?iso-2022-jp?B?N2I0QlhkbjF4NjdnRnlzUmNITFUyb0Q2WHI5aTV2MnJnQjJuSlNFQTQx?=
 =?iso-2022-jp?B?Z0JmUG91aGkzZjlVbURQa0RjOG53SXdCZWNkOTNKb2pKUkV2RTkxc2Rh?=
 =?iso-2022-jp?B?RUs4cmtYTnF3NUhOMERacmpuN2tuNXIvUGF0aXFRS2FVOGpyTkFvQzR5?=
 =?iso-2022-jp?B?Z0xHejFCRk5lQVFrRHFIejNJOEsvQ1pFMWsrVFdnRVByTXVTZFE4ZlBl?=
 =?iso-2022-jp?B?dXY4OGt1MUw1dXE0RFlLWC8za2QvQ3A4eUl4dTZUOXhnUTMxeGZpTTBE?=
 =?iso-2022-jp?B?dXhyanNYRFRKZzUvbTVicjlGTWxyaC80MlZ6Sk9aTFdRa2RtWWdmQzQ3?=
 =?iso-2022-jp?B?N0J3NFZuazdmb3gzY3Iya3AzWDQwRHpNazJpaXJXU0dvaHVWWXIvckt1?=
 =?iso-2022-jp?B?RlZhWm15RzdDM0NoZjR1d2RCUjRGdEh2TGQ0WU40ckhHZEI0dTVFQ29P?=
 =?iso-2022-jp?B?M0ZEc3Z0L0I3aTFkSWJKNmszbUtyRXNIaG1BRUV4VlcrN05Ba0pZcnU5?=
 =?iso-2022-jp?B?YWpmYmpOV0hiSHR5SFhuUklHakoveW56S3MyRFNzNHpudE9UWXRkblRw?=
 =?iso-2022-jp?B?NyswTHdGbThsQUJsMXJaa2V5Tm5DcUJlM05GcStKNzltbXJSbVFjK1BD?=
 =?iso-2022-jp?B?UW9ZcVZpdWdTdytjem9zcnd6MDYzMUxIcnhBaTNFK0h0d2swSDNrRzlK?=
 =?iso-2022-jp?B?VU9hSmdScFdpNzcxdjhGditDSS9sUEh1eWcydS9EOFYxRFJuM21tWUJt?=
 =?iso-2022-jp?B?MnBxWjdJNTJNbCtqY3NPQ2RNeVU0MXNpNFhCSFNsMkY1anNHUzREaFd4?=
 =?iso-2022-jp?B?ZGk4Z1pFOEVUU1RWYWhlYkRTcEhXemEyZlVNdThyT1Roa1JLTXRvVmRR?=
 =?iso-2022-jp?B?cUdaSWtxUUlZMkp6cHM3NG5BbUovRU5vOUtNQ0cydCtZZGpVdU12R1ky?=
 =?iso-2022-jp?B?T0JWd0hvWXZlTFVtUjdyelVtSCt0ejJHYXRURGJCV1ptVUtIZ2p6dCsw?=
 =?iso-2022-jp?B?eFdwZG5jYmtjYTV2ZmhpRDlhUzBJOFRweWJReWhEcXd3dU9ERCtUdTAx?=
 =?iso-2022-jp?B?QWVGYUlkYUZjaEIvKzNwOHVZSjY3d1M5bUpOdXVoV3llVy9CeVE5YWRZ?=
 =?iso-2022-jp?B?K2Z1QlFGSndvaDFqN0dKcTBJSGNYWUhhck8xWHpLUEtRMUVNSGVLbGhy?=
 =?iso-2022-jp?B?VVowNThwTGdONzVtL2p2ZFl0dnNvVys4Vjh1WVUvaXE1TFlaNnVvTzhx?=
 =?iso-2022-jp?B?enJ5cTVRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7331261-5625-4d75-295b-08d9df1084aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 08:07:08.7225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQonOEVRHGPDV4OTmL4Eq67veg9gcABk14xzpT/qzv8dYxsQCKg6DbbZziVaU7i9Va/z+wMtWLL76eqiG7uShgR3LXH2TL8QjTkQwhQNNmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2123
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

> On 1/20/2022 11:59 PM, tan.shaopeng@fujitsu.com wrote:
> > Hi Reinette,
> >
> >> On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> >>> This commit changed the default limited time(45s) to 120 seconds for
> >>
> >> (This commit)
> >>
> >>> resctrl_tests by adding "setting" file.  Since 45 seconds may not be
> >>> enough on some machine environments.
> >>
> >> This sounds very imprecise when you say "may not be enough". From
> >> what I understand you have already encountered systems where this is
> >> not enough so you have established that 45 seconds is too short. The
> >> next question is, how was 120 seconds determined and how do you know i=
t
> will be enough?
> >
> > It took about 68 seconds in my environment (Intel(R) Xeon(R) Gold 6254 =
CPU
> @ 3.10GHz).
> > This test accesses a fixed size(250M) memory by default settings which
> > is used when run in kselftest framework.
> > I think that the execution time does not change significantly in differ=
ent
> environments.
> > So, I roughly doubled the execution time and get 120s, which I set to t=
he
> limited time.
> > I think it is enough for any environments.
> > If 120s are also not enough, user can freely set the limited time by "s=
etting"
> file.
> >
>=20
> How about something like:
>=20
> When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
> selftests fail
> due to timeout after exceeding the default time limit of 45 seconds. On t=
his
> system
> the test takes about 68 seconds. Since the failing test by default access=
es a
> fixed
> size of memory the execution time should not vary significantly between
> different
> environment. A new default of 120 seconds should be sufficient yet easy t=
o
> customize
> with the introduction of the "settings" file for reference.

Thanks for your feedback.=20
I will use it for commit log in next version.

Best regards,
Tan Shaopeng
