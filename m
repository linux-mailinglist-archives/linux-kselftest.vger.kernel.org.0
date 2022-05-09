Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7852041B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiEISHe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 14:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiEISFw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 14:05:52 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38C120B1;
        Mon,  9 May 2022 11:01:54 -0700 (PDT)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249HjgCk028417;
        Mon, 9 May 2022 18:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=WQ4jJVq4sZgurB85w6VC0a9SFslK9NaKwc+tYQip6+8=;
 b=dBNYpLKUgP6W8ZxjYhd8aFbcOY6es/ChM0pp09aMfBGJgSQWZ91wY/qoitfmN0ZPUpeq
 C+1+bhBJKVejQxorIvYWVjDsJ6wMv9/AZJoXxInkxklGhn2wUUZKFzupc38X4Tvp0hJ+
 UDJfiqLMGHFPsE67q6x0tyEQfAsrciINuHGpvrI8h5kPuYRofG50RifdefxJWsD+0ffE
 i1X/cWznGf37aQ442Jj9b4al6XjjTfbjn2rFN/VTgWDi408m8g08urn4k1dIqYDnynfn
 L5nSS1pcmPKRPG+lRyzSqOQMuRqinlmM2/mIs54l9R8izOgJwcD5VqgoJ9mnX10p1tm7 PQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3fwfb4t6jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 18:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duhRUeEXJdpm2xPiLfEY0t0ntt39uASfQQpHktgDlHj/zN+7kHv/aWJeQyeeVudVpoL061Kd+fzenmvLv2JuZwdr+WpRqG7GD/A57tsM2q78jPKtBBWlcVenXXJCREXgZs3whgOmi17u0cTufsxgYjT2RCJxaYV+zcnvlXcdpLQXSqkkCpEyciTWXXSFAb+OVNnQLAuml3bC0Sqn5XwtFvZFFtJc9/qkAJW1r46ubxmPuiVxnPqcvUoHmUeWRctZRud9MsUtgJHPsroUfR1g6A6LGCm7qZsxlOshk8PgaX61Djo7WDiFsP1H8FWiPtqh1UF+PtA6tpOblnNncyJQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ4jJVq4sZgurB85w6VC0a9SFslK9NaKwc+tYQip6+8=;
 b=YETTj2A6RennrtSzUrwSc5pDN6BD86BXqEMytqzfWKCOFXagUjyRA3SAqOf2v+i/zkGeyTcUgUw6/NO0GO5YRIZfFKM4K7gxXJ/pQPpVIvnTOSXMRZOHGG57oQm46+CTpTMw36CI0sMX9vIrtmVnN7xLP3baenFnReChlIGyyQl0KdTBWvXWIZME+OdiNmMKVBnjftlUy9OHvTAUpKLQpWdSeE7dT+AFODhGoDLbkiLg3BXOUVKWMKYmcPjaXBoSzNuZULipD0QtAHdU+u6LdVc5W61iN8i2oM0Qg4kTYrS/eCQ9onqpFfwSKgKK1xzZH2FLDVIhfxQuDq7GRH8A1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by DM5PR13MB1708.namprd13.prod.outlook.com (2603:10b6:3:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.12; Mon, 9 May
 2022 18:01:44 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::61c5:661c:f216:e59a]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::61c5:661c:f216:e59a%6]) with mapi id 15.20.5250.012; Mon, 9 May 2022
 18:01:44 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Improve the readability of test results messages in
 cgroup
Thread-Topic: [PATCH] Improve the readability of test results messages in
 cgroup
Thread-Index: AQHYYiSLo0wFxL08EkONA6qXlRS1b60W16Qw
Date:   Mon, 9 May 2022 18:01:44 +0000
Message-ID: <BYAPR13MB2503AAB5BF9098DE9AF3FC1EFDC69@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20220507150046.109741-1-gautammenghani201@gmail.com>
In-Reply-To: <20220507150046.109741-1-gautammenghani201@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e98809-4fe6-46b4-51fd-08da31e5fa7b
x-ms-traffictypediagnostic: DM5PR13MB1708:EE_
x-microsoft-antispam-prvs: <DM5PR13MB1708005F318152617EDF04ABFDC69@DM5PR13MB1708.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8AxDGVuO+UlcwTfa7os0TjpYG7tDs/mbo4gA997Z5wF6o5uwjb4LxTAdHkMr3E6Ddj8AJMgmabHcR6VvVkYqUe75LXdvLwBtEaChoF9UEwdOwA4BDr247E1egFtHPAx7jyRyYGU8muv5wHbGR7MD903UDR+gwdOahMvFEmPfTHsUpOR/zebq7qtUSU7FBDw0r5/5FBKRjsv120QpUyITmsdvmYlVIk5sWxY22r9ikQWqhcK1gA+RX57g5VrfKd7UzjqPR2xtsUE+LOia71z3FDc5EzFtND40c22lX+OwOU/qD1k9Ux8uJ12Icrc8Y6JHb8PGk+Qb6liTqzEfE2WD3qZxbtPT94ChKrcmOFeBwNXjnrnzigcAhMAUCdOkvb/dwOe42+l0/UMuZYb4joCDnrq0yoWNjOtEppPN/rIWXYhv3HxgioDCy3EdWh4G/AZRoBX+4z744jYvy35+VtYj41PxmjS6a/N0EEOKe07Kc9esYmSSFNJGzlM+CMb6Q1GTHmmA6d3qN3dbrq4rERxusL66/xIf1mvj17yFKPiPihCZPc027DxCrt5/Vz5DYcI1UcEBSnvFOOvSaNFgJcqUUOFUI4ztMrrweyciAszQYBenYBAHKt5Wt0CKUEZLiPh2iPq3G09aA2vBYxEwhjWb+W8aAS+MoTUmapQzngN5NyEhUmuOgVCzJ4bNTZAtcsFn5PRpCISP/HxL13xO6OOwknJ5TjAW6Q6xtdICHa1ndsSBHOBGWDNkmNHpNHvFRCEU7MsoBTkb9Up2mvtIsoaJUXRmx/rtxlC0Ps0en3ZeiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(71200400001)(52536014)(8936002)(15650500001)(76116006)(508600001)(8676002)(66476007)(66556008)(66446008)(33656002)(66946007)(64756008)(2906002)(83380400001)(7696005)(54906003)(82960400001)(110136005)(6506007)(122000001)(186003)(26005)(9686003)(5660300002)(966005)(316002)(86362001)(38070700005)(38100700002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vL1eCEfAQTiCngOMadZCDQg56IxR/CHZJSnETBDHhQVhYhfeJPoYP/1woZNw?=
 =?us-ascii?Q?NSX/uzEr1H/tKFm1wD8Lp6xqHyDgzGvhTCt/TOinScYIQIKAhwRaotWwNsnx?=
 =?us-ascii?Q?Zys6kkv/FsgF1V9e5qWTeKijeeuZadhhBgMX3DCtOBsSs9m04pFfqsCyLhXc?=
 =?us-ascii?Q?9bmUj0FYGsS+BOafGuaQpT9FxOy+wS4hk79fwvobYKKafFJ94pM960BpmEXe?=
 =?us-ascii?Q?gDvMlF2UZj0afxx9UvH1cPchZYwYqJO3nAHJ9yFcjlAeSboInRtNDHefmQ9v?=
 =?us-ascii?Q?SkmPMkoeViWp2Wiu6IXUl5aRmuLI3UFiVSSZuQu+VYq6r0WQezGyOVOQJ1Ks?=
 =?us-ascii?Q?T0voynGd1gbp9ie4g+xZccQOQN98SSeD/1yr7kzQCTqWRBMLsPbb5XuyQEnL?=
 =?us-ascii?Q?jayhk9/tMI91Zi2c9cqBxnU0Qky+Zqjykpys8mjZtOZX3FtcBmw8WDG4YexZ?=
 =?us-ascii?Q?LpI5Icczhgb1lFgsM5MnXmDrG2qK/+ojNxtCaRE9YIJz2jT7qdwlltgW84Nq?=
 =?us-ascii?Q?yHc6bG1uSuObdthGuul83y3D+ZL3cb407WRytuSckWdgGCHuHU1WKD7h6DWu?=
 =?us-ascii?Q?nCRGqUoF7T6DobQuuoA2Pmuk3gkaDt17OzjHfBI4WDlb8gVStHRkHzPiO1lP?=
 =?us-ascii?Q?6f1A/scRP/BUI7xyfqgG+NMjdNhbJoqepCInC0uYJzgYxkt6fxUwiIO7YmJK?=
 =?us-ascii?Q?z+/aNLrkJfEduXVyYs0IFmrFtqnmjCoauW7r/SOWhGWMG46FGkH29UST2W6L?=
 =?us-ascii?Q?wpqp23RL1jz1zjhAEjjecJxWGn5wAVAgXqQXrAjK+In790Xdcf2CIJkhr8NJ?=
 =?us-ascii?Q?4osZRyjHzS+bVR/u9k0uum/2qHfB1b4/FHXhAXoSsQRz8TkOaKHho3varOcy?=
 =?us-ascii?Q?tW+PihYWBxiGrJRzcABoQPr4Hu6dFVX8jdzw7J4q6oof0TIn5TO5+ubKzpyg?=
 =?us-ascii?Q?fLt6NZoFLPvgerhRwr2lx9U223LQBb3wNDZgAN7NNfK8WBt5Fnz3gPQUCJrz?=
 =?us-ascii?Q?dKydwlyLSWlNeP4Xvyi5W2IEbadzRXt/cFgVllqhQeDEJxwFoT3x0OOaiGKF?=
 =?us-ascii?Q?eW2d16ZT2/VvX/6M8bXvswAmHPvRKMcgqUdoILHHYfuIXm8ZTBRdDDIB3E5s?=
 =?us-ascii?Q?Fbn19s3DXAQZxr83wh8qmo2uGWUeqx8Co3r9l9ZkE4MLG8sXk6uj8/PHJR6P?=
 =?us-ascii?Q?OCgzLjg6Gfir8BSMj6bkTFwVXVFsdLIUU2SMnIIZjIx94yM4EiDdwYTiG4WQ?=
 =?us-ascii?Q?JdiyI1VlVRAKzj9i77/wFV2ILeRmRmZ84yvw5wtZdHWRjPTPhzeZlBYSdYtL?=
 =?us-ascii?Q?Lp271GFnso5VE+/MQ2trR5ufyt0HUoeS0cygqQshIR1BQtwXVltqWe0Z3Ba2?=
 =?us-ascii?Q?0Z7MJtilJMZLIEsffjbVaVTNpBdknCU73Hv8nsQh1GWhE5G916+lDzd/LEFv?=
 =?us-ascii?Q?QEN7Kqq0/+0TLFHddcnpyZdVmTV4WHxXELnQCmcLMIFkxV1afOHRzQYD2cYY?=
 =?us-ascii?Q?D4aI91YBP7ahb7r10lfcQtXuxcPW3YqYw2BOoYDByoQ1hMxX/wcWDbTEp0t/?=
 =?us-ascii?Q?PyaU2B7HaZVEF0Ia7L/XxYnZPO/gp9mcONfEepccKvohNd3wQQFVEn7JNztF?=
 =?us-ascii?Q?Go3VYPkuRPEJoPd1dxwxeUjQG8dXmO1nzjY0SIv19+TBUcKA0gs1CaZjaIBt?=
 =?us-ascii?Q?lxDQHwrx/9NupC6Itdm4CFOHBZtakDm21Q1R4dZet1nySd4K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e98809-4fe6-46b4-51fd-08da31e5fa7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 18:01:44.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYxO5QSp/IuuOsprGBB+A1f8n3YBGiZNRv+2WbL65Xgf4tZjZnOJZcK727yg6ybhYp+nHye41NgV5tgglveUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1708
X-Proofpoint-GUID: qsr8Dw3XnGwDeypeZ-OsaMEJjgFra9ea
X-Proofpoint-ORIG-GUID: qsr8Dw3XnGwDeypeZ-OsaMEJjgFra9ea
X-Sony-Outbound-GUID: qsr8Dw3XnGwDeypeZ-OsaMEJjgFra9ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_05,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Gautam Menghani <gautammenghani201@gmail.com>
>=20
> Improve the readability of status messages that indicate whether the
> kselftest passed or failed.
>=20
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/kselftest.h         | 12 ++++++------
>  tools/testing/selftests/kselftest/runner.sh | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index b8f248018174..a38f20f376b3 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -137,7 +137,7 @@ static inline void ksft_test_result_pass(const char *=
msg, ...)
>  	ksft_cnt.ksft_pass++;
>=20
>  	va_start(args, msg);
> -	printf("ok %d ", ksft_test_num());
> +	printf("Test %d ok - ", ksft_test_num());

The output for each test case is formatted according
to the KTAP protocol, which is documented here:
https://github.com/torvalds/linux/blob/master/Documentation/dev-tools/ktap.=
rst

The testcase result lines must start with either "ok" or "not ok", and have
specific syntax to be compatible with automated testing tools (both interna=
l
and external to the kernel source).

This change breaks the output format.

Sorry, but NAK from me.
 -- Tim

>  	errno =3D saved_errno;
>  	vprintf(msg, args);
>  	va_end(args);
> @@ -151,7 +151,7 @@ static inline void ksft_test_result_fail(const char *=
msg, ...)
>  	ksft_cnt.ksft_fail++;
>=20
>  	va_start(args, msg);
> -	printf("not ok %d ", ksft_test_num());
> +	printf("Test %d not ok - ", ksft_test_num());
>  	errno =3D saved_errno;
>  	vprintf(msg, args);
>  	va_end(args);
> @@ -177,7 +177,7 @@ static inline void ksft_test_result_xfail(const char =
*msg, ...)
>  	ksft_cnt.ksft_xfail++;
>=20
>  	va_start(args, msg);
> -	printf("ok %d # XFAIL ", ksft_test_num());
> +	printf("Test %d ok # XFAIL ", ksft_test_num());
>  	errno =3D saved_errno;
>  	vprintf(msg, args);
>  	va_end(args);
> @@ -191,7 +191,7 @@ static inline void ksft_test_result_skip(const char *=
msg, ...)
>  	ksft_cnt.ksft_xskip++;
>=20
>  	va_start(args, msg);
> -	printf("ok %d # SKIP ", ksft_test_num());
> +	printf("Test %d ok # SKIP ", ksft_test_num());
>  	errno =3D saved_errno;
>  	vprintf(msg, args);
>  	va_end(args);
> @@ -206,7 +206,7 @@ static inline void ksft_test_result_error(const char =
*msg, ...)
>  	ksft_cnt.ksft_error++;
>=20
>  	va_start(args, msg);
> -	printf("not ok %d # error ", ksft_test_num());
> +	printf("Test %d not ok # error ", ksft_test_num());
>  	errno =3D saved_errno;
>  	vprintf(msg, args);
>  	va_end(args);
> @@ -287,7 +287,7 @@ static inline int ksft_exit_skip(const char *msg, ...=
)
>  	 */
>  	if (ksft_plan || ksft_test_num()) {
>  		ksft_cnt.ksft_xskip++;
> -		printf("ok %d # SKIP ", 1 + ksft_test_num());
> +		printf("Test %d ok # SKIP ", 1 + ksft_test_num());
>  	} else {
>  		printf("1..0 # SKIP ");
>  	}
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/=
selftests/kselftest/runner.sh
> index 294619ade49f..6d95a1e96ea8 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -94,7 +94,7 @@ run_one()
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -e "$TEST" ]; then
>  		echo "# Warning: file $TEST is missing!"
> -		echo "not ok $test_num $TEST_HDR_MSG"
> +		echo "Test $test_num not ok - $TEST_HDR_MSG"
>  	else
>  		eval kselftest_cmd_args=3D"\$${kselftest_cmd_args_ref:-}"
>  		cmd=3D"./$BASENAME_TEST $kselftest_cmd_args"
> @@ -106,7 +106,7 @@ run_one()
>  				interpreter=3D$(head -n 1 "$TEST" | cut -c 3-)
>  				cmd=3D"$interpreter ./$BASENAME_TEST"
>  			else
> -				echo "not ok $test_num $TEST_HDR_MSG"
> +				echo "Test $test_num not ok - $TEST_HDR_MSG"
>  				return
>  			fi
>  		fi
> @@ -114,15 +114,15 @@ run_one()
>  		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
>  			(read xs; exit $xs)) 4>>"$logfile" &&
> -		echo "ok $test_num $TEST_HDR_MSG") ||
> +		echo "Test $test_num ok - $TEST_HDR_MSG") ||
>  		(rc=3D$?;	\
>  		if [ $rc -eq $skip_rc ]; then	\
> -			echo "ok $test_num $TEST_HDR_MSG # SKIP"
> +			echo "Test $test_num ok - $TEST_HDR_MSG # SKIP"
>  		elif [ $rc -eq $timeout_rc ]; then \
>  			echo "#"
> -			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout sec=
onds"
> +			echo "Test $test_num not ok - $TEST_HDR_MSG # TIMEOUT $kselftest_time=
out seconds"
>  		else
> -			echo "not ok $test_num $TEST_HDR_MSG # exit=3D$rc"
> +			echo "Test $test_num not ok - $TEST_HDR_MSG # exit=3D$rc"
>  		fi)
>  		cd - >/dev/null
>  	fi
> --
> 2.25.1

