Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9613140F791
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbhIQMgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:36:19 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:62302 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235181AbhIQMgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:36:18 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 08:36:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1631882096; x=1663418096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7vTJ9piDBnhpJSNi1mmfSxL8UrSbxyFOBno8SGmAYNk=;
  b=P82uKOLJlmpTHOBdl+kEkbGc8glZk7mxSB0MO73fvpHPymuZgRsqiQcL
   FBP+zK5uqfGCWO2LTEnVezf+2KC3tdGZECxvJOt4XiIX0aCDt/aZseeoP
   Y4hs7ZbtwgOoZQ/lWQzgVBwFmB8f+KBH3izSFCMpShnELlt9ziCAK4W8+
   6GsSuITJy1ybUI7Qd8we0f94smtkpAhfcJZnAf19SPa/UvitvfcQ7UU0y
   eJeyBkLwfbHToPG2/1biDzmu+td4QHXZyTWgH8VXQTGDYFXzlMDOql2Bj
   7W7VPbisUdkgvypxzLIq0vzdJqY0thR+bKhdMcBhFNns/5OhS+IFYAcEQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="39478440"
X-IronPort-AV: E=Sophos;i="5.85,301,1624287600"; 
   d="scan'208";a="39478440"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 21:27:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAqt3ro2fXr39hq8SbrKDS03S9w7wEJ6LdAxsvET4mLrOMCDekEeFPeYxlSfnGVUk69c731R2Czd2+wLd7OqEDIY3FI6LCrD3zTN1l33TZZmgSR+qXuz6zuwJ0K+glTaD0/DhSkPHjWn+fTAzCdNxpmniDBcVf8yqCAmIVwzJfrd5JWxjEnHOteGJTWRAmxbJRSzVneQ0UuLukTF7FuekUED6djNgWzV1LPLMk9y07qFjG3fyzrDO7kkztf68uRheU8g2O8FSsMloQLBudLlAmVTnlF/BQdxTrhfa/G+Vr592fFQiICrc79Unpm1c5L7gkc2MCxXrPPp8uTLNsyY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EfTsOa7smW3penL8OqESmdgCbvKa6O3+/HYNIWcMPTM=;
 b=PfaMgLvantM163L22RjYEYQ+ah1cV4xzE6xx1YWGv8LQe+14fP7yznzt9hTMlLEUGAk3F+Cnt1bLe8ZYhCMAVkjaw+kI5NNoOBSAkcfW49whqxaPAHCyreN5El90sk/ZoQNGwdix8tMO4/ZX2bAHJ0pXSsGDZ9H/azZIRqHduB6MAlWGph1yquAp9gvf9WgeFngFxkxx+FmYp+IQUXKw3uG8lEehJHIL6QUK04bbmI2SGlePb2NKBV9jFV6+N5KbfuZqce4rhOj5uuzeMc/K/NNuZcqugNdPECUrxWwIP7AkFr19ET346o6WPT8NocTHsbNwKiEqkV+mYvKONDem8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfTsOa7smW3penL8OqESmdgCbvKa6O3+/HYNIWcMPTM=;
 b=PjGUzUE3bZZ25rxzeSdpIOsB/gXzbDHBzr96p/p1lBU7TaivT9TUPgdk55m4qvVkeZ2NuWW1LI06FTEYjol9r25vF6CtDLafSQBsn5t5Pn1PUgqn+NK5+9cJr+RqkwftFsF4ir46J3cGtaL2oqeBEMBAb5jt0W1FpwKJ4Kc4DqY=
Received: from TYCPR01MB6993.jpnprd01.prod.outlook.com (2603:1096:400:bc::7)
 by TYCPR01MB7060.jpnprd01.prod.outlook.com (2603:1096:400:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 12:27:38 +0000
Received: from TYCPR01MB6993.jpnprd01.prod.outlook.com
 ([fe80::cca1:a260:15e8:aa6c]) by TYCPR01MB6993.jpnprd01.prod.outlook.com
 ([fe80::cca1:a260:15e8:aa6c%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 12:27:38 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Mark Brown' <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] selftests: arm64: Verify that all possible vector
 lengths are handled
Thread-Topic: [PATCH v2 4/4] selftests: arm64: Verify that all possible vector
 lengths are handled
Thread-Index: AQHXq7z9KCMJ4Gf4JkKrgK/yaJqS9quoJisg
Date:   Fri, 17 Sep 2021 12:26:26 +0000
Deferred-Delivery: Fri, 17 Sep 2021 12:27:25 +0000
Message-ID: <TYCPR01MB6993276DACEF056EA5634F7FE5DD9@TYCPR01MB6993.jpnprd01.prod.outlook.com>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210917120855.13858-5-broonie@kernel.org>
In-Reply-To: <20210917120855.13858-5-broonie@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20180424-NoSave-enc
x-shieldmailcheckermailid: 7d803ef13b79439fa2a76db2847f5998
x-securitypolicycheck: OK by SHieldMailChecker v2.5.7
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-17T12:23:30Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=e4f63e8f-00f6-469a-a7d6-90dcd66b178a;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a7126f-ed9e-473c-b3b2-08d979d68952
x-ms-traffictypediagnostic: TYCPR01MB7060:
x-microsoft-antispam-prvs: <TYCPR01MB7060D24F43872EC89F1A4453E5DD9@TYCPR01MB7060.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcZXKiGriflpfsCtv+L3PjJOPWfQ+H0ttulNtw7/ZnQB/YrzA0M491uADqOM/u08ZSu4RAUrSsw3et2KA8SnLA7QjOPh1BGr3OCXO1j35O8P60UrlCQwcDYKVfN0l8kiv/ZxNte4fR0685I6uW5+gDdfgpbB06Aqo4EWfmAcwoydt/mFlJ6xPI1LvQ9blwSTM1ZVBw4u6zj1CNbaXZKG9UYf3KzO5Kfx4Z5D6x+m+BTeFH9cmWvFZMXzlK8Hvt+qNt3oyWSgrHZFL/krD6TrtwgE6hVbZLm1QPhWnqhqV64INeraNBmLwFitBswROt52uCNa2uC0G5AIJ/ac7OMRCsZEfgcGuHrmROQbGbUW8WkweMbutWlaq+LwDoPJ6T0mlcx8bg7JcpakrnPreFGmHBzFsZMig2KDjQXn+ydZFNmJeeozPKcKMEi3/Gn2tVK298devWLopRtV61mBlgP8do182NgedR2Alp7DBu5yrYbmuj7PYoJY47iTzI7ltrwq7daoGhV+g9+ZL8J5kjx8R5zKiWhz36CGdksXzLlnkTeUO0iY0lzvPZA4qb0HigcIXRhYDc42++ySEh0CzgbRqCmzoGWUHWUWwFoFR1w3SJiwG5wiPBjL1MV3iwiEdsSkr/xb+XlkhmIRtQqNfxM78o//8jlbRoRi4S6HmCQzlQeB/qG6JlexO0w8AA8KAwxvoJkE2BzJq1iNmIDDtzfxmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(86362001)(8936002)(8676002)(4326008)(110136005)(54906003)(55016002)(2906002)(26005)(38100700002)(478600001)(122000001)(9686003)(7696005)(15650500001)(316002)(186003)(6506007)(66556008)(66446008)(66476007)(64756008)(66946007)(52536014)(5660300002)(83380400001)(33656002)(85182001)(76116006)(6666004)(71200400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aFc4T0haK253Q1hMZ3E1VlloQXM5TSs5M1lmdlFCYk00SkNyTEk4RXo4?=
 =?iso-2022-jp?B?QmNiTmZTNlF2aEwrUDZNbTlWUWxKNUhFK1FpL3BXUGRJR0lDd0R4UXA4?=
 =?iso-2022-jp?B?ZFdETDNRU2x2VUtFeU9hZ1VuS1hadWtRQW1VOVdVaW1EWFhtdjNKdE1X?=
 =?iso-2022-jp?B?VnNqOEpIdVRKY1ZyRTg4b1FaQXhqcVVMcnFicHkwWTFQQjhNOGZLME1r?=
 =?iso-2022-jp?B?WGRJNmYwMkRLREtYMkVpWERWbll1cVZ0ODUyUGpVVVNOYkhXc0E2VjRJ?=
 =?iso-2022-jp?B?dFlZZUZSWGQ2S0IzSzJpVTNOeXdaTlhxUVRJaWJYU1NWQnlQb2ZjOVBF?=
 =?iso-2022-jp?B?TVBCUlRQeHpCTVg1TkhsSitYWHhDbVk1dllaOS9xaTNCNWY1dWZVazZw?=
 =?iso-2022-jp?B?dEdHZDUvUDI1RE1Vai9SaEtOTWRDZjlhSUZBbjU0RWU3aG1NWlo1N0M2?=
 =?iso-2022-jp?B?NGlmMXdEZy9rdSt2cmsvVjJsMXZSRy9Hb3hvSHIwaG1tZ1N6b1lXRlNz?=
 =?iso-2022-jp?B?OXNCRUUyMU5XSlovQ0VZeERKSzA0dDBmNCt0dUtDcUNraldoU2xrM0ZU?=
 =?iso-2022-jp?B?ZE1tLzA1MEFET0podENQZzN4MU4wNFcyM1J2UkkvclF3RXYxT0JiNHBP?=
 =?iso-2022-jp?B?MkUwVFJYb2hFSUpMM1ZiZEQxdFhPWGQ1SFRGRU8wbGVmODRzaFB2TEgr?=
 =?iso-2022-jp?B?clYxSHI4UmhRZ2oyYjZqYXcxUkJuc01abWlWQXIrYWtCamVUcENsMHdN?=
 =?iso-2022-jp?B?b1d0VkVDOUJoTEt1bFRMckhoYmF0UkxiQmcxZ2U1RXhDMnc2YlVzU0xQ?=
 =?iso-2022-jp?B?L1lDU3NCaW9BWkVZS1NYeWRzT1dKUE9xV2Z6K0xsNXR0SlBYMUFMYU5H?=
 =?iso-2022-jp?B?Yk1EbHpEcVUwS0NUTnIxNjQ0Q2ExUGhXYWQvTmdXUWVBVFZuRG5rMStD?=
 =?iso-2022-jp?B?b1RDK05xeDh0VlhaWkZPaW1GWXdQNnlTbzBQOXJ5bHA0V1hOOEYzK3I5?=
 =?iso-2022-jp?B?QkxBVGU2RXRBTzN0YXYzUTcya0M1QWFYNlpIYzh2azFBQW9nQVFocitS?=
 =?iso-2022-jp?B?YWpVSDBNQUwrellhL2lZMnFUSkY5Tmc2bkF0RnVVYWk4dlZxVGZqZW1w?=
 =?iso-2022-jp?B?ajd3L0hQRm8zQW1aQVIyUUZldTcyb254WjBWcEhzL1dZSENoT095bmZQ?=
 =?iso-2022-jp?B?Y1JlVW9FajZzSEdoZ1BjSnd0WjY0NHY2M3RTL2h6RlB3eU1tV3U1d1pO?=
 =?iso-2022-jp?B?Sll6MUJ5bUtPVGxUMWN2QUhGWFNPeU9rK21oWlVhMEJSRlpzMU9HY04y?=
 =?iso-2022-jp?B?YTRFWWgyc3ZtRGp5Zy9SRDdqOEUvSkVDUzIvamIwclV2UTFqRzZueU1o?=
 =?iso-2022-jp?B?ckh4K3BIY1VpT25lWm9LOUk5RmdWU2QvZFJEZGU3Z0JzY2JReXVkZEdv?=
 =?iso-2022-jp?B?VU5TMFNRNVcxMjAwRGZoWGM4cW9kb0VlOHlFc1ZoZk1YUFBxczVvMEov?=
 =?iso-2022-jp?B?dmJlT3JITHdQeFlkNERucFJKSnhsRFkwZFVqYWRGbVJMajFJRUNkaUMy?=
 =?iso-2022-jp?B?bWdoNzJ0UGlQYVk5Q3k2UDZId1pzOHBlOE5Vd0p1THVxWU5KNzl3YTZ1?=
 =?iso-2022-jp?B?UjFzc1pNeU5PVTV1RFNwZkdVQWd0K1Y0VzdsM3g4ZDZPUUJUMHhkbEZt?=
 =?iso-2022-jp?B?THJFU0VtWDcrdGx4UVNPN3JGK01MdWVYSDd0ejJ5dEh6OUltcHFyK3Y3?=
 =?iso-2022-jp?B?U3M1b211dG9NMlVJMmRiQ0wra0pWSUQ0TkI4Mm1BNFBJRTJ3eWpsRnRr?=
 =?iso-2022-jp?B?MjVPOGxrcWNSZ3pNWk95emJIU0VPcFJ1djM5TENHSWhkWVhWUHNXQ0po?=
 =?iso-2022-jp?B?S3JUS21jTEMxQmhNQ0drR3hrUUxGUnlvWjJvZkh3U2JwTHFiMjJkdGNp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a7126f-ed9e-473c-b3b2-08d979d68952
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 12:27:38.2152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fECyevx0j1tYUZNF6WPmJ4xYfsvuo832xhmQ1/WkGYJQplu75rCKpItaP01lEfNbxgIWCcApORk5/oM4aN4GZ/hYFaO1IPx3N7876b4BTqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7060
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reviewed-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>

Thanks,
Misono

> Subject: [PATCH v2 4/4] selftests: arm64: Verify that all possible vector=
 lengths
> are handled
>=20
> As part of the enumeration interface for setting vector lengths it is val=
id
> to set vector lengths not supported in the system, these will be rounded =
to
> a supported vector length and returned from the prctl(). Add a test which
> exercises this for every valid vector length and makes sure that the retu=
rn
> value is as expected and that this is reflected in the actual system stat=
e.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/vec-syscfg.c | 71
> +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>=20
> diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c
> b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> index 9d6ac843e651..de11cd2f5d79 100644
> --- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> @@ -540,6 +540,76 @@ static void prctl_set_onexec(struct vec_data *data)
>  	file_write_integer(data->default_vl_file, data->default_vl);
>  }
>=20
> +/* For each VQ verify that setting via prctl() does the right thing */
> +static void prctl_set_all_vqs(struct vec_data *data)
> +{
> +	int ret, vq, vl, new_vl;
> +	int errors =3D 0;
> +
> +	for (vq =3D SVE_VQ_MIN; vq <=3D SVE_VQ_MAX; vq++) {
> +		vl =3D sve_vl_from_vq(vq);
> +
> +		/* Attempt to set the VL */
> +		ret =3D prctl(data->prctl_set, vl);
> +		if (ret < 0) {
> +			errors++;
> +			ksft_print_msg("%s prctl set failed for %d: %d
> (%s)\n",
> +				       data->name, vl,
> +				       errno, strerror(errno));
> +			continue;
> +		}
> +
> +		new_vl =3D ret & PR_SVE_VL_LEN_MASK;
> +
> +		/* Check that we actually have the reported new VL */
> +		if (data->rdvl() !=3D new_vl) {
> +			ksft_print_msg("Set %s VL %d but RDVL
> reports %d\n",
> +				       data->name, new_vl, data->rdvl());
> +			errors++;
> +		}
> +
> +		/* Was that the VL we asked for? */
> +		if (new_vl =3D=3D vl)
> +			continue;
> +
> +		/* Should round up to the minimum VL if below it */
> +		if (vl < data->min_vl) {
> +			if (new_vl !=3D data->min_vl) {
> +				ksft_print_msg("%s VL %d returned %d not
> minimum %d\n",
> +					       data->name, vl, new_vl,
> +					       data->min_vl);
> +				errors++;
> +			}
> +
> +			continue;
> +		}
> +
> +		/* Should round down to maximum VL if above it */
> +		if (vl > data->max_vl) {
> +			if (new_vl !=3D data->max_vl) {
> +				ksft_print_msg("%s VL %d returned %d not
> maximum %d\n",
> +					       data->name, vl, new_vl,
> +					       data->max_vl);
> +				errors++;
> +			}
> +
> +			continue;
> +		}
> +
> +		/* Otherwise we should've rounded down */
> +		if (!(new_vl < vl)) {
> +			ksft_print_msg("%s VL %d returned %d, did not round
> down\n",
> +				       data->name, vl, new_vl);
> +			errors++;
> +
> +			continue;
> +		}
> +	}
> +
> +	ksft_test_result(errors =3D=3D 0, "%s prctl() set all VLs, %d errors\n"=
,
> +			 data->name, errors);
> +}
> +
>  typedef void (*test_type)(struct vec_data *);
>=20
>  static const test_type tests[] =3D {
> @@ -557,6 +627,7 @@ static const test_type tests[] =3D {
>  	prctl_set_no_child,
>  	prctl_set_for_child,
>  	prctl_set_onexec,
> +	prctl_set_all_vqs,
>  };
>=20
>  int main(void)
> --
> 2.20.1

