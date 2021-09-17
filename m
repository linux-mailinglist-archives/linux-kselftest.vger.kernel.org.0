Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B840F4DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhIQJgq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 05:36:46 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:45089 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241087AbhIQJgq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 05:36:46 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 05:36:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1631871325; x=1663407325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDSNqdpz1anJsJuQCIp9CIHufbqppxQHWws4z0ul0Xk=;
  b=Z/sbwrrrLg0kePtsdnNthFK+PH1haV7GfenAk7P5+Q9LmdrUtX4AKfl7
   omqKFZPpMe1kJ6fERCtAIIORW051IAZKlZ1c3q6L/zC60HrY0YM/qpuVa
   OIZpSMbjN+vKUnHyuVAIpjD9k02+7W9CfsxChMlHJUoHnohQwGaJxelnQ
   xj4D3CRRZ6AUtfO9lm3KBshxtDzo0aeQdQDYxnL0V2JZ+WmZ5lwuz7JBY
   CkxJDqTabI6S8pqOI5YMon0kXlMO/agK3qDkhYTEZD2m0bBF7k62tSsio
   GzN9TuEyeEZm14E7spVrA5ja6waUPDK+IsDOeooImjylr/Sc5Qw9oX7lG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="39339518"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; 
   d="scan'208";a="39339518"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 18:28:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmBaQGcTSKUSfamG/4cDeE/grDO4uOd2R09Ow4pjUDhw8xh1XCnhf7ytYRNhVGx53rD1fodgdfKlunTexvY5gUFXNdK0/0pUyt6jHm5f5eHakRH9O6I7q40scPNftQMx0UW45kpohZRsB/TDuA3yj8+bGUb5i08rV6ErFyzDg6r5l1Xk5FiICcvdar9u4ihvOiY0gcx0DX17/W8BLcxPxtVWj7I9IAcxu/2WgaNz2IlaDMgxn2IubW5PS8wnILou5ftjwHO9b/ZLc/4SKCCeCgDOHrKgr5r2Kgg6rNd/PlvbcUj5bw4nRSwGdU0ob8ZcWbF3z6k8sip9Wv9D6KKVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tfDm2DzrR3Kl/k/6c+uxVG7qWSmwTyDUlOAj9wIBfvA=;
 b=LLWw9RZnnBidMiBjWPDFW71sgcrXwOurQNqDd7bWimQd0Bc3UysJL3bLU7r7KPP2+Mg48Wdv/6hkx/TMdtge46IZy3ktxXZRmo4dzNF3FMVaJQ0PPSgVusL2OUHUi1/6bUHLSmEx0A6zE//Fr7aZjIImpdNWj5QpRq6MpItkTr77TDFarkTwVFNSnXqAvPw7DLJEqT1V4iJ5YA+xGzMiXI73dhuG91gGHNemviWm7tIDDiEHW7e3Zv9PhIoUJk0owI0Y4GyD6WpR1nnJgbqbeUk4wznaqtqJ/P0YGGuNI5vOVuwSOkqfvGph14Ekpsx4U2sA1UrzxeoI8ahLrcZEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfDm2DzrR3Kl/k/6c+uxVG7qWSmwTyDUlOAj9wIBfvA=;
 b=n+Nd+vNpfOG466UmcmBbBNPaMbyIsYygvLCFL+DmrKH/p2oa0ZoVub+moZ8kyKsBSzUTO+/tmKY76B8VIbROACf5GOPDzP4Sczywn63+w98ZBUD74TRUtOtXADkcnvi63HOITUMn0jlDehxn25Y2tnDfUD3qRkgWVNEGoBmUSsM=
Received: from TYCPR01MB6993.jpnprd01.prod.outlook.com (2603:1096:400:bc::7)
 by TYCPR01MB5742.jpnprd01.prod.outlook.com (2603:1096:400:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 09:28:08 +0000
Received: from TYCPR01MB6993.jpnprd01.prod.outlook.com
 ([fe80::cca1:a260:15e8:aa6c]) by TYCPR01MB6993.jpnprd01.prod.outlook.com
 ([fe80::cca1:a260:15e8:aa6c%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 09:28:08 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Mark Brown' <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v1 4/4] selftests: arm64: Verify that all possible vector
 lengths are handled
Thread-Topic: [PATCH v1 4/4] selftests: arm64: Verify that all possible vector
 lengths are handled
Thread-Index: AQHXqJ2vPu8WVfDyZE+RV5s2KolytKun9sqQ
Date:   Fri, 17 Sep 2021 09:27:04 +0000
Deferred-Delivery: Fri, 17 Sep 2021 09:28:03 +0000
Message-ID: <TYCPR01MB69937F4D2E0C9542ADB18194E5DD9@TYCPR01MB6993.jpnprd01.prod.outlook.com>
References: <20210913123711.51274-1-broonie@kernel.org>
 <20210913123711.51274-5-broonie@kernel.org>
In-Reply-To: <20210913123711.51274-5-broonie@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20180424-NoSave-enc
x-shieldmailcheckermailid: 8cd68940b545429b88eb91fd93987bde
x-securitypolicycheck: OK by SHieldMailChecker v2.5.7
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-17T09:11:36Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=59539e1e-995e-4e2f-a9e5-51d7f86072af;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a27c67c7-7e62-463d-0a7f-08d979bd75d3
x-ms-traffictypediagnostic: TYCPR01MB5742:
x-microsoft-antispam-prvs: <TYCPR01MB5742357974B535E335D5F86BE5DD9@TYCPR01MB5742.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5aYVC0ZbUCfjQYU5/6nGqq+t5oQLbtLeEGv5VEx3+T63PnaDgXTDs7KIU51XBW8TeyFnJU+9Ap9eUv5Wlyps72clW1wIwR+ThsWbLKCr+CEzFTOd5qKJdArThRYYbCp49sGfPyvsUt7ChlYZfrsMaLaw/7KrNePzOhUmxs+R/w5geeJTur3A1Wu6xOoF/7IrkrqimAxhMjJHUuvUBFrNEfsee14YbEhlKOtmVrdxYiHXBlxMaZYQ6Y5LnJ4uUsW5jA8oEw9wWjSR5tw14kO0pdt6Hp8GprM3W/qVsebEzI/EwSTB277Op+Oo7HDsySlO36gUzSfLwfQEs63kGJFH1i4o/sqCa24HMleY9f9D7Aky7ijKkqZZLJlPO2kEv1ff460bUrh35g4d9YGsA8kNu5KW+O5YmN2QIlJy81xrxDt60oCFmAXykzTE8dPcB6ilyyuw4GZObMOSh8Tj2MP3zQ8WSv7X4CR0vni2ok7uJ80b2t8yZHqzOaP9BFuPVP5uYD+qaPkr0v+06+gGFjl1KggzmCxY/1GGCQ6Ra318/+X0vdDDMDICH37ICdhgQACuMQSQ15bSCg+8VjdUD72BbH7riTyjJYFfCBxXgG9oLKCYUgIvbe1zCi8ibz+ePJ0uNbSp5m/lV+Yhprae4W/XsQptWLdM+ip8HCX8ZlbLtHBJYB1GqJF6lilAvtWszb08F3UYfbhtBYscDi3hDhTlJuSRRSwuaYY7B7YptfKCDP6HSj2F92wL3MEwKw6zIi7OEToEQPtZXl70sRsweMTZao3+2tzQ4i8fHmLrMI/0OOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(55016002)(71200400001)(508600001)(6666004)(26005)(966005)(5660300002)(9686003)(66946007)(76116006)(66446008)(66476007)(186003)(64756008)(66556008)(85182001)(15650500001)(4326008)(2906002)(86362001)(38100700002)(122000001)(316002)(38070700005)(8936002)(8676002)(54906003)(83380400001)(110136005)(7696005)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?S05iN1pweWhqN0dyaVprdm0yeFd0c3NndXhsSnZWT0lKaXJzLzFxMGEx?=
 =?iso-2022-jp?B?N01ZbEJEYlZzeVlxWDlTSUNLaEJvQ3hxYlh6OSsxTmxVRldZaFFoanBL?=
 =?iso-2022-jp?B?UkFjemwrdE9SS0lnOGdBMm10dWZqZzZLbWtFOEt3Q2RtZWJBMXRyY2Vn?=
 =?iso-2022-jp?B?RnJwNEVMM0ZFbWVWTTRqMkVDUmY4ZzhOeVB0QXNPcSt2MHpmc095bThF?=
 =?iso-2022-jp?B?RlZiQ2lMbnh6d3JwSFRJc2g3dk9hM2xRbHFybzRmak5ZOGV1bUhlM29L?=
 =?iso-2022-jp?B?Rmp0V1NacXZMdW84M05pcDVYRi9BemVFZExxMnN2ckFjQ3VHTk9SVnIr?=
 =?iso-2022-jp?B?UmYra2pEcm04c05iUXZpMHp6ZmsvZ3RrRzFRWUdLUStqSFoxcWtXOGpW?=
 =?iso-2022-jp?B?SGFEQ2NjNE1XTnhRTjJoU0FuVVFVVWhmdGt1YkpjZG5YeFI1ME9EeDZr?=
 =?iso-2022-jp?B?QWI1NFFHdSt2WTUyZjJoam5LZytnWkRTem00VEZjWWVrTTNRQ01SVkl0?=
 =?iso-2022-jp?B?aEZjb1lDSDUreG82eHVuMEhMQnhDS3NXYVM4OHg0bnUxK3NwWmtKeERa?=
 =?iso-2022-jp?B?ZU5tSEw1a1F6d2krcTFwTHVXVUJReGt4RENiVUJuMUZrczlrTDJiODkx?=
 =?iso-2022-jp?B?UklMWnRYKzN0VGwreER5Q3YxUDY0RFlVVE4vc0pybXp2S21LbklLQzJ3?=
 =?iso-2022-jp?B?UkpGRmZaLzc0enFoeUhtbk93WjFGWkROMy9TWnlydDNaL0FEcURXMnpa?=
 =?iso-2022-jp?B?VUQ2c1hFOFNmcUpPYnp4YVNwUjQxSnAxNjdFcTVVdGliRmViR3dGZ0do?=
 =?iso-2022-jp?B?RnF6aE5UVEwwNEM3bEJ3WXljSTFsbCs3RklUa0I2aG85NTBMTUMyRDdq?=
 =?iso-2022-jp?B?YUUxYWJSMzJoblVLck41Y3Q2bEtMd2xPTUhIaWxUbXNBaUR4RVlpQ0kv?=
 =?iso-2022-jp?B?TmF0S29pOUdrcXRKMWlIZmtuRkw5OXQxTzc3WkRxNDBmRGRZeXA1dVVG?=
 =?iso-2022-jp?B?bThoSjc5cUduTkV6QkJmQzlQWmFrRmpRdDFWTnJscmxJS3pUNS9TNTZD?=
 =?iso-2022-jp?B?RllxMWlYa0lZbVp2Y2h1cnhxTlRIS244azBjY0N0eG9Cemw2RUpzbVVZ?=
 =?iso-2022-jp?B?TVFRSThoNW5zUXlubnM3NHlmOUptZ3d2NXFJR2QwWSthN1NscUR2R1lM?=
 =?iso-2022-jp?B?bEV6WTBZUmxwaWpwVW1aLzNLVW04Ujl4VjRNcHdMOG1vb3h3TWFhenVM?=
 =?iso-2022-jp?B?V2FvOEhsaUFiditTVXY5eUZ4V0c5YTcwd2Q0ZnRGY3lNYzBuYXNCcTdI?=
 =?iso-2022-jp?B?SE1zQUg4OFdUNUVpbmZWNXZoTjhuV3ZJZHJjdFl3aHB0ei9HZUdJK1dk?=
 =?iso-2022-jp?B?VUJSdTJicGpxSjE0VXF0Z0tRTXppekgwS3pjRzVYOG1FZ0JHZlgyWG05?=
 =?iso-2022-jp?B?d1BYaGExdzdLcDlVZEdXN25BWWRvOFBITVpZUll5RWJJT1hjeGo2aG56?=
 =?iso-2022-jp?B?Q3RucFN6Z3BNTGJZREorOVlOaEtGN2x3RWZXNUpHTnZ3QmlMaHZTYnNI?=
 =?iso-2022-jp?B?Kzd5U1puUmlSbkoyUEd1SWkvYmdPZnRJQ2dmS0FheUhvWnozaW5OWWdH?=
 =?iso-2022-jp?B?eVFDRDhVcnIxN3VCTVpQYmZGQ211eU8rK3VjVDFxY2plY2ZnUVNXQVVV?=
 =?iso-2022-jp?B?enRjQkVyaDhrRks4b1diWWZwQ1ZEMzNtaUhJd08yZnovSW1QR2tIb1JD?=
 =?iso-2022-jp?B?WDZiTXJxN0xLenNMdzJmMTJ5Z0lVZVNSSUxObitXMEZOdTFxZmY0UGdi?=
 =?iso-2022-jp?B?Z0hGVk0yYnFJbWtEeG1IRjRPUmpJSGZGcE9Xb21HejltNEwrMzByQVBO?=
 =?iso-2022-jp?B?dWhDSk54Ty9xRDNuZ3Y1Y3k1REozMHBQTDkraSt3UzBTZW5WRzFzb282?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27c67c7-7e62-463d-0a7f-08d979bd75d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 09:28:08.0866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KZmZapsAdyJZnaATAHaDSMdXvv7qZfBeqt1CCJHG9XoNt7sx9y06Ka9Dt4xagKgLOQgZwqnbonxAF2gbTBAFXcm3G4xT/WJgvpAnD2zXWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5742
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
>  tools/testing/selftests/arm64/fp/vec-syscfg.c | 76
> +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>=20
> diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c
> b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> index 9d6ac843e651..61e9704e03fe 100644
> --- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> @@ -540,6 +540,81 @@ static void prctl_set_onexec(struct vec_data *data)
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

Hello,

Since (new_vl < vl) is expected here:
> +		/* Otherwise we should've rounded down */
> +		if (!(new_vl < vl)) {
> +			ksft_print_msg("%s VL %d returned %d, did not round
> down\n",
> +				       data->name, vl, new_vl);
> +			errors++;
> +
> +			continue;
> +		}

I think following two lines should be removed:
> +
> +		/* We should've hit one of the other cases... */
> +		ksft_print_msg("%s VL %d returned %d test logic failure\n",
> +			       data->name, vl, new_vl);
> +		errors++;

Actually I tried to run these sve tests update on A64FX and got the above e=
rror:

  # # SVE VL 48 returned 32 test logic failure

but returning 32 is expected behavior as A64FX's supported VL lens are 16, =
32, 64.

Thanks,
Misono

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
> @@ -557,6 +632,7 @@ static const test_type tests[] =3D {
>  	prctl_set_no_child,
>  	prctl_set_for_child,
>  	prctl_set_onexec,
> +	prctl_set_all_vqs,
>  };
>=20
>  int main(void)
> --
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
