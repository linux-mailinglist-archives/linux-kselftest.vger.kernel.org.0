Return-Path: <linux-kselftest+bounces-3901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D09844B08
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1BD2943F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF83A8D2;
	Wed, 31 Jan 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="m2BuDSDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E43A29F;
	Wed, 31 Jan 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739805; cv=fail; b=RbE9O5TutDOYu5X2NnwCsgbQasQeDBMr7YWuMTkZQb9XbVL75ygUjc/LNYTDjWYK+vZAz6sIn/huOVaJTvAP4uQK4FoVVAddJzzOqJmSUDcQ8fy9FU3QSa1habQ6Ay2W9Uix+3OO14CdITYhoimZqk8xIWARW7H0DXu/B3FeLD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739805; c=relaxed/simple;
	bh=3tHtwgVMROSVqvLAEobLm8SgJFQIWJMVGOwWJ5WuWLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgKz2pND58TVl7X/SLYAziTeQASHHITWDkD5IOQWi6Hp68Pfr07gm1TenUcm9z5Zgj25Fi0fnr8K3dxpDsNaiEZLP4DStPNiVm+C/foFe9g0BGvGsDkEhWIWIUTRBoqnuq6mnXY8jOd5qepOt2zVMQ8jzp406YoQD1TvuWxq4Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=m2BuDSDA; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VMMeGC001993;
	Wed, 31 Jan 2024 22:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=3tHtwgVMROSVqvLAEobLm8SgJFQIWJMVGOwWJ5WuWLM=;
 b=m2BuDSDAo/XH6LjVrqh5W0AFD/QnnDmjwgv6kAzipmcYf9LRoLr0OKVIo48es/SWBix9
 entxG/viHKYXjs62xQnG2lvbwUb8Wr8sNXY8DkjJ0m+cOFrqL1cl2DDKpDBY9q3jtBwc
 iqncjpIri7Ms71ae9Bj/uSW/e8807t9dlIkLdRyWXzK9DzvSuFKuhE64+kDzdu6nNjl/
 SfCAhVMiUiH5k9+cBb4GgZJX8f+OdsU9YrS7YjKcqHoqFyv46RkVqorUYQutXYGO0SGg
 WP2nTtu78wp8PHKPIjcj+OdRZE94Qx22dk/6wh8o3ildt2DmPfkj/11ufsTztsbyBxvA jQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vvrg1cst6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 22:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjF8ejx4un/e7TlB/KLjcNs15GCj7J6KTUtfIs0JwT35Ih1gxyDnQ4fzPmCYlJ8FxSa8av/iDKdqyw7ivENnr8M+IZvRe31qPt4F3OlreE0QxXiff+IGSqXuMVf0QGQY1ZOQoFh4HuC8zuhKhpu8afa3SInVBIOjXYWVQkLupiFz57aXS33MkgSyWwxPj8YA62h2kUq3HX0/9nk2hPlqPGmQ30B3pAft0zeul6ODjD4vhRWR2H+QKJkt3//YGqfVsRxhNEAK43X10fojrG7OFfnX5gM5rTajbMN3PR83x9iRR7+mPaVQc82GWag5WtXidTDExLeKCPa5ITA8QnSRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tHtwgVMROSVqvLAEobLm8SgJFQIWJMVGOwWJ5WuWLM=;
 b=BNJUegwyZP+ibw7ogSV06dfLYM3vKytJI7enYYYYf/jOPasQbiXcuvXLQEIDvQc98+PQOR2vd8zDt+0sV3R6soTvkjTSnMcP7zYG2D+h2ZQs5yLmaiqDZji2g90SwrIhJtIqhNAXi1OOIe2NXBJnieuV4fv5WazfyZUBNjh3Mz1BtLjRXbychm4C4cEVzFRY5gtUAMvpGZJMnoBL0FDSe+L6fAQDyfZ/326vFn9lcth5FKll6YtTiC5wZDfP/R648O3IMSRXcOIcPrbuDPRe5VmHRlocsbebrBUHn9HGORJbF/RXBLFQY8nrRdwp3lQU1EmSRvJCoXIlckI7IqBBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by CO3PR13MB5749.namprd13.prod.outlook.com (2603:10b6:303:177::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 22:22:34 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 22:22:34 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Rae Moar <rmoar@google.com>,
        "frowand.list@gmail.com"
	<frowand.list@gmail.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "dlatypov@google.com" <dlatypov@google.com>
CC: "tytso@google.com" <tytso@google.com>,
        "gustavo.padovan@collabora.com"
	<gustavo.padovan@collabora.com>,
        "ricardo.canuelo@collabora.com"
	<ricardo.canuelo@collabora.com>,
        "guillaume.tucker@collabora.com"
	<guillaume.tucker@collabora.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [KTAP V2 PATCH v2] ktap_v2: add test metadata
Thread-Topic: [KTAP V2 PATCH v2] ktap_v2: add test metadata
Thread-Index: AQHaUKU3UizaEXTiD0W5Zadi9PydxbD0hUxg
Date: Wed, 31 Jan 2024 22:22:33 +0000
Message-ID: 
 <SA3PR13MB63728D82B285DD69266AADDEFD7C2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240126221426.4173112-1-rmoar@google.com>
In-Reply-To: <20240126221426.4173112-1-rmoar@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|CO3PR13MB5749:EE_
x-ms-office365-filtering-correlation-id: 1621191a-0981-432c-ffb9-08dc22ab1f5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6ctA37gHESHb+r/6RQpe75/+6A6/vH30UTWiHceE6n4IcUTSEFRgXJ86wxO6Rq5hfT21WY3mWlb3ZmvJwjvQi+6zRUlFlsjm6VlvFXuRt/gGhfw7/HbfcDGgY92JP75LuL3eaz++W6YQ6IxDKKHYskGfQBIUaJO+xcE7995CObOz2m3l6EXEAZul3QaRSXs1xdOzwoiFbhXS9IxboM583evGLEmIs8q0G+dliU47MKxBe4vOr1DH0ehYHmnA5q4NttZGrbXJ5O/A2H5F3kUrVdxRZhZOdu0iGU6lc606XL0aFQuZecEPckMWqxQ5etho9vuJlKUxm7rvW9xBLWb33NX0CSzkDSFKDuC5rTMmvifvjskYRWNX9X6SXiDLzidTrrrQoEauYU4sdQ9baCY3731qQ3uRCSs+il9TOOva5hjyHuKlPCCT7g91J+WwZxJQhZZlugs8daTipzHnL+A5UIZOKtG3F3DZbzO+PBduKBQI/orHWhXeIkSI1Gh8UeQFjyzE0RquhBsUrsl6Aloqz50109W8EPHTK8T2BXchWQPdZm6I46UVoABOffjJIfRyUYdPb0rFugeg8iFLegagJ1WmjiiFQT3y5DMbiAbNpuzygU805aI8ZB2H0VjeL297rPQaYHXc8w3dWYEAhHZhZQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(26005)(55016003)(41300700001)(66556008)(82960400001)(38070700009)(316002)(66446008)(66476007)(54906003)(478600001)(71200400001)(966005)(83380400001)(6506007)(9686003)(7696005)(64756008)(38100700002)(122000001)(66946007)(7416002)(5660300002)(110136005)(8676002)(2906002)(33656002)(86362001)(76116006)(4326008)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dXJnclVVMmF5TWFmbHEwQ0kwSVcyOXFmejJJOGoxdGJ6Wm5HU0cyRnJIOGlx?=
 =?utf-8?B?T1NjNjVBQmZkL3RCZ2o1cVA4QXJEbklEUGwvWDhJSnp3SElFbTRSOEpYc0U0?=
 =?utf-8?B?RktWcWRTU200c0RQMG1qUDhHRXN0ZEdBWlhnM2xyK3lVVGRvaEltTDlFZlla?=
 =?utf-8?B?S0tXVGdpa0JGL1cybEM1akwvRU11NHhmaTIvVUJPZEtvRWFjaC9GalBDWGl6?=
 =?utf-8?B?TWY5di9jY1FuaXBUQU0yNXJhWmpiOGRtT3M1am9UMnhJR1Bob3F6NElDSkw0?=
 =?utf-8?B?bGJ4dWlWa3V5UUhtWlVKendYYmFtdlFuOHdDYVlGbE82a2dxbEE1MEZjMzFG?=
 =?utf-8?B?bUkvWUFtREVpa0N1RVJEZUwzRnU5S0FUMmFWREQ3ZFNBRXhrMEJNUVFBazFV?=
 =?utf-8?B?eVRlMUJ6alNjSzVra1k1Rmx3NDhTUG9XTmpBZkdBTk5SeWhPVEJ3eE9lcjh2?=
 =?utf-8?B?RTRFZERaNEp6Z3FhYWNEYXVWQTR2Z2t5VlVmNFFVWWY4bW15RDRLT3FpMlJ3?=
 =?utf-8?B?ZnlpZWlOMDlYZFdvQ0tROXR1c21TUE9IZjYySUJoTUc4VjJzYkdqSTBtRXU3?=
 =?utf-8?B?TDVxOG1kNkppSDYyRWhGd2J5MnJaL0pkM3hpRFlRcHhnbU4yVTZvc2hLNFI3?=
 =?utf-8?B?S25WWmJzNTlCSGNuem9PWmM0UmxHbnhQN3dpalRVa1NleW1JM1NXbE94NG9a?=
 =?utf-8?B?QTQ0Smd4MkkvMTlFQmoraWo2YXF1R0pHREo2dDR2UEdXLzI5N2t2VmQrT285?=
 =?utf-8?B?Y1ZKMnJqWklKYW9Ib1lxMUJhU1BxNzVOUUpuSk9LS0swd05ZOFJFTGtLdHVi?=
 =?utf-8?B?V2pJUTI4bVcxMVluUVg2TWhXTXVzVVpMSkh3Y21oK2VPQThseE1uQ2cvaVVr?=
 =?utf-8?B?TGp6WHJzdG5tYnBBeXo3aVRYR042eGFBOU9DczlkbXF1OGVZdDYyMkpscVA2?=
 =?utf-8?B?SmV6amxpbjkzZW1Hb1Y1RlpTZURweTkrVVV3Z2ZYMXc3Ynhad0tOYmRoaCsz?=
 =?utf-8?B?OUgydU00cHV0OTZoeTBYemJNanFHMTNRaU5JZ3orbHlHdUErSlJXN1k0S2lq?=
 =?utf-8?B?eWNjdFRXR1Y0RGR4M3FhVWdCdTUyRWtQUzVxdkUrRzdnZGRZUWpjbWg4eXZD?=
 =?utf-8?B?VWNVa1psYTlKVzJ3czlTQTFwRGZEQjFZNzlVc04xMzVrS0R0S3NRZ3JGZlJk?=
 =?utf-8?B?MSt3dUxvS215ZEVjKzgzdUVjZlI3UGRqcThlN3ZnOXVDakl1Z0IrS3pQOUhu?=
 =?utf-8?B?TUpzTnJsY2dTZEZ4OW9hN1RpVTdBdzVjeVRsMEpRT2NFSlJYbFpLeWNHQWJs?=
 =?utf-8?B?TzA0RGlnend2RGRxeGJkb242QTI0bVg5OVFDamNENlNldHZXQ245ejBCY05C?=
 =?utf-8?B?K01pN0JFWkpyRWRpK3lkQmxGdGkyWWQ0dUxvNXlxMHBWK05pZzIxTG0wUFp3?=
 =?utf-8?B?bGgzZGNOTHcxdzduRmFnWTdCNU5EelJPdkZ2b0pGSGZoUjRrY3RycTU1RHlT?=
 =?utf-8?B?cE1COHlMaDZJNyt2aE4xQWpaUzlGNEQ5Qi82djU0bXBDdHI3cmtJMFNqWWdC?=
 =?utf-8?B?VDJXRWh1amxzVGhxU3ZtSzF1b0ZlSDZ4cHpjb2xuVzlHWEp0WXlBTmJnbEsx?=
 =?utf-8?B?ZnRSSUpzcjNYU2xVYXovQlRid1BYK21PTS9TcC9nV21lZUM3ellEWXAzL1FH?=
 =?utf-8?B?Z2xGSkM3NkJLVmVjRkRSb0p5WEVwTDJ2dUR0RUtpZlRFZkkxSkNBNTFmbVJQ?=
 =?utf-8?B?Y0JvOW5EWXVrRStvcS9XaU55ZXVKVmxkSnoxaUhSZnZpSlhaS1pMYVpDNjBR?=
 =?utf-8?B?elNHdzBEL3RhL0poQkJlRDc1emV5YlJ3ZUF3TFF4Y0Nxellnb1M4WGJrRXJM?=
 =?utf-8?B?MEZTcEoxblM1M3BZeW1iWlp6L044WlBZZENOdGE5ekVhTENweWhxV1puSEtQ?=
 =?utf-8?B?Wi9XcnpGd2ozWUVTY3I5S3loRE5jaFVRbVM0Q0N1UDFHOElZaVRSck1adXVh?=
 =?utf-8?B?Y3FrWEN0ckdVUjRlNTVSbTNqTjZuWDYvVXR2TmFBcXlLZGFOVEFYR2JRRXRM?=
 =?utf-8?B?Q1RuVWNsNHhDOUI4WmRKeEJhNksyZGIra3VCVTVTM3VoQkUwY2xORlByVlFM?=
 =?utf-8?Q?fFus=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XATTz4G1j4KkBN5heWxeewpmNsDSQnOYdOZd2yn/zTfTSQNDWlCuCUdYIwD0IvMvCRAAdLCyH7o/HpP2yOhuV3Q8fFwSpArUISi3Y4D49JlaTXiqAm3H66uAerYXsg4vN3NaLA+1jKs5zIEAX4rxKT3Pr4STNbbnUvUSY8OnsypWZn9WsC+bfUx/WprfTSo++u28jG8spNOz3ABQMVK4mWJRq16+2IXBoLmA0Jr5s34RRJuuixGKoDRgbcDLV+a6aVlgpkrDLThK/zDT6IQsP5mC6UARmXIae8gz8TVxk+ZF+Gjpe5Dg3UDG4mpSXniZXUnRCi1kWkskVuFeKwpWZWb3585VhP+keUpudv3C8FFTdkiYP2kdQigxMVsVJD5M72dBpmwy/5t2rQfNxZnDgAdZXuenkOIz9fY9jPeJOt0C50tqwcPGFRRw/mLWsbfBK39XT0CXp33PJcmhDDmq+0dfnZLHNXGiXMXNQUeTI2WAaQGqFWrC98ZmuCLDPAD57It20Lu1pQkOvu53n3aNXXw5W66N2/nLgI1jA7E94XUUELai91MLL6DV/1p8VbW8AhGD48HtsATliu9i8cpob+a8iBmrYMuQ5HSSgJlH3UY6skkrVZVpP3yl6sCAsChh
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1621191a-0981-432c-ffb9-08dc22ab1f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 22:22:34.0214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4GuIVzd9utaay0ri3gk7wHxHv29xGURnqpUsNbPNIBTaNmsC3QzVdW/3eajBraYrI42mLcoLutjA3ktUhl/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5749
X-Proofpoint-GUID: cvQzqzKqdLnZykFy5J3OQQjbqcUEzcT7
X-Proofpoint-ORIG-GUID: cvQzqzKqdLnZykFy5J3OQQjbqcUEzcT7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: cvQzqzKqdLnZykFy5J3OQQjbqcUEzcT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFlIE1vYXIgPHJtb2Fy
QGdvb2dsZS5jb20+DQo+IEFkZCBzcGVjaWZpY2F0aW9uIGZvciB0ZXN0IG1ldGFkYXRhIHRvIHRo
ZSBLVEFQIHYyIHNwZWMuDQo+IA0KPiBLVEFQIHYxIG9ubHkgc3BlY2lmaWVzIHRoZSBvdXRwdXQg
Zm9ybWF0IG9mIHZlcnkgYmFzaWMgdGVzdCBpbmZvcm1hdGlvbjoNCj4gdGVzdCByZXN1bHQgYW5k
IHRlc3QgbmFtZS4gQW55IGFkZGl0aW9uYWwgdGVzdCBpbmZvcm1hdGlvbiBlaXRoZXIgZ2V0cw0K
PiBhZGRlZCB0byBnZW5lcmFsIGRpYWdub3N0aWMgZGF0YSBvciBpcyBub3QgaW5jbHVkZWQgaW4g
dGhlIG91dHB1dCBhdCBhbGwuDQo+IA0KPiBUaGUgcHVycG9zZSBvZiBLVEFQIG1ldGFkYXRhIGlz
IHRvIGNyZWF0ZSBhIGZyYW1ld29yayB0byBpbmNsdWRlIGFuZA0KPiBlYXNpbHkgaWRlbnRpZnkg
YWRkaXRpb25hbCBpbXBvcnRhbnQgdGVzdCBpbmZvcm1hdGlvbiBpbiBLVEFQLg0KPiANCj4gS1RB
UCBtZXRhZGF0YSBjb3VsZCBpbmNsdWRlIGFueSB0ZXN0IGluZm9ybWF0aW9uIHRoYXQgaXMgcGVy
dGluZW50IGZvcg0KPiB1c2VyIGludGVyYWN0aW9uIGJlZm9yZSBvciBhZnRlciB0aGUgcnVubmlu
ZyBvZiB0aGUgdGVzdC4gRm9yIGV4YW1wbGUsDQo+IHRoZSB0ZXN0IGZpbGUgcGF0aCBvciB0aGUg
dGVzdCBzcGVlZC4NCj4gDQo+IFNpbmNlIHRoaXMgaW5jbHVkZXMgYSBsYXJnZSB2YXJpZXR5IG9m
IGluZm9ybWF0aW9uLCB0aGlzIHNwZWNpZmljYXRpb24NCj4gd2lsbCByZWNvZ25pemUgbm90YWJs
ZSB0eXBlcyBvZiBLVEFQIG1ldGFkYXRhIHRvIGVuc3VyZSBjb25zaXN0ZW50IGZvcm1hdA0KPiBh
Y3Jvc3MgdGVzdCBmcmFtZXdvcmtzLiBTZWUgdGhlIGZ1bGwgbGlzdCBvZiB0eXBlcyBpbiB0aGUg
c3BlY2lmaWNhdGlvbi4NCj4gDQo+IEV4YW1wbGUgb2YgS1RBUCBNZXRhZGF0YToNCj4gDQo+ICBL
VEFQIHZlcnNpb24gMg0KPiAgIyBrdGFwX3Rlc3Q6IG1haW4NCj4gICMga3RhcF9hcmNoOiB1bWwN
Cj4gIDEuLjENCj4gICAgICBLVEFQIHZlcnNpb24gMg0KPiAgICAgICMga3RhcF90ZXN0OiBzdWl0
ZV8xDQo+ICAgICAgIyBrdGFwX3N1YnN5c3RlbTogZXhhbXBsZQ0KPiAgICAgICMga3RhcF90ZXN0
X2ZpbGU6IGxpYi90ZXN0LmMNCj4gICAgICAxLi4yDQo+ICAgICAgb2sgMSB0ZXN0XzENCj4gICAg
ICAjIGt0YXBfdGVzdDogdGVzdF8yDQo+ICAgICAgIyBrdGFwX3NwZWVkOiB2ZXJ5X3Nsb3cNCj4g
ICAgICAjIGN1c3RvbV9pc19mbGFreTogdHJ1ZQ0KPiAgICAgIG9rIDIgdGVzdF8yDQo+ICBvayAx
IHRlc3Rfc3VpdGUNCj4gDQo+IFRoZSBjaGFuZ2VzIHRvIHRoZSBLVEFQIHNwZWNpZmljYXRpb24g
b3V0bGluZSB0aGUgZm9ybWF0LCBsb2NhdGlvbiwgYW5kDQo+IGRpZmZlcmVudCB0eXBlcyBvZiBt
ZXRhZGF0YS4NCj4gDQo+IEhlcmUgaXMgYSBsaW5rIHRvIGEgdmVyc2lvbiBvZiB0aGUgS1VuaXQg
cGFyc2VyIHRoYXQgaXMgYWJsZSB0byBwYXJzZSB0ZXN0DQo+IG1ldGFkYXRhIGxpbmVzIGZvciBL
VEFQIHZlcnNpb24gMi4gTm90ZSB0aGlzIGluY2x1ZGVzIHRlc3QgbWV0YWRhdGENCj4gbGluZXMg
Zm9yIHRoZSBtYWluIGxldmVsIG9mIEtUQVAuDQo+IA0KPiBMaW5rOiBodHRwczovL2t1bml0LXJl
dmlldy5nb29nbGVzb3VyY2UuY29tL2MvbGludXgvKy81ODg5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBSYWUgTW9hciA8cm1vYXJAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2Rl
di10b29scy9rdGFwLnJzdCB8IDE2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTU5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3RhcC5yc3QgYi9Eb2N1bWVu
dGF0aW9uL2Rldi10b29scy9rdGFwLnJzdA0KPiBpbmRleCBmZjc3ZjRhYWE2ZWYuLjQ0ODBlYWY1
YmJjMyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3RhcC5yc3QNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3RhcC5yc3QNCj4gQEAgLTE3LDE5ICsxNywy
MCBAQCBLVEFQIHRlc3QgcmVzdWx0cyBkZXNjcmliZSBhIHNlcmllcyBvZiB0ZXN0cyAod2hpY2gg
bWF5IGJlIG5lc3RlZDogaS5lLiwgdGVzdA0KPiAgY2FuIGhhdmUgc3VidGVzdHMpLCBlYWNoIG9m
IHdoaWNoIGNhbiBjb250YWluIGJvdGggZGlhZ25vc3RpYyBkYXRhIC0tIGUuZy4sIGxvZw0KPiAg
bGluZXMgLS0gYW5kIGEgZmluYWwgcmVzdWx0LiBUaGUgdGVzdCBzdHJ1Y3R1cmUgYW5kIHJlc3Vs
dHMgYXJlDQo+ICBtYWNoaW5lLXJlYWRhYmxlLCB3aGVyZWFzIHRoZSBkaWFnbm9zdGljIGRhdGEg
aXMgdW5zdHJ1Y3R1cmVkIGFuZCBpcyB0aGVyZSB0bw0KPiAtYWlkIGh1bWFuIGRlYnVnZ2luZy4N
Cj4gK2FpZCBodW1hbiBkZWJ1Z2dpbmcuIE9uZSBleGNlcHRpb24gdG8gdGhpcyBpcyB0ZXN0IG1l
dGFkYXRhIGxpbmVzIC0gYSB0eXBlDQo+ICtvZiBkaWFnbm9zdGljIGxpbmVzLiBUZXN0IG1ldGFk
YXRhIGlzIHVzZWQgdG8gaWRlbnRpZnkgaW1wb3J0YW50IHN1cHBsZW1lbnRhbA0KPiArdGVzdCBp
bmZvcm1hdGlvbiBhbmQgY2FuIGJlIG1hY2hpbmUtcmVhZGFibGUuDQo+IA0KPiAgS1RBUCBvdXRw
dXQgaXMgYnVpbHQgZnJvbSBmb3VyIGRpZmZlcmVudCB0eXBlcyBvZiBsaW5lczoNCj4gIC0gVmVy
c2lvbiBsaW5lcw0KPiAgLSBQbGFuIGxpbmVzDQo+ICAtIFRlc3QgY2FzZSByZXN1bHQgbGluZXMN
Cj4gLS0gRGlhZ25vc3RpYyBsaW5lcw0KPiArLSBEaWFnbm9zdGljIGxpbmVzIChpbmNsdWRpbmcg
dGVzdCBtZXRhZGF0YSkNCj4gDQo+ICBJbiBnZW5lcmFsLCB2YWxpZCBLVEFQIG91dHB1dCBzaG91
bGQgYWxzbyBmb3JtIHZhbGlkIFRBUCBvdXRwdXQsIGJ1dCBzb21lDQo+ICBpbmZvcm1hdGlvbiwg
aW4gcGFydGljdWxhciBuZXN0ZWQgdGVzdCByZXN1bHRzLCBtYXkgYmUgbG9zdC4gQWxzbyBub3Rl
IHRoYXQNCj4gIHRoZXJlIGlzIGEgc3RhZ25hbnQgZHJhZnQgc3BlY2lmaWNhdGlvbiBmb3IgVEFQ
MTQsIEtUQVAgZGl2ZXJnZXMgZnJvbSB0aGlzIGluDQo+IC1hIGNvdXBsZSBvZiBwbGFjZXMgKG5v
dGFibHkgdGhlICJTdWJ0ZXN0IiBoZWFkZXIpLCB3aGljaCBhcmUgZGVzY3JpYmVkIHdoZXJlDQo+
IC1yZWxldmFudCBsYXRlciBpbiB0aGlzIGRvY3VtZW50Lg0KPiArYSBjb3VwbGUgb2YgcGxhY2Vz
LCB3aGljaCBhcmUgZGVzY3JpYmVkIHdoZXJlIHJlbGV2YW50IGxhdGVyIGluIHRoaXMgZG9jdW1l
bnQuDQo+IA0KPiAgVmVyc2lvbiBsaW5lcw0KPiAgLS0tLS0tLS0tLS0tLQ0KPiBAQCAtMTY2LDYg
KzE2NywxNTQgQEAgZXZlbiBpZiB0aGV5IGRvIG5vdCBzdGFydCB3aXRoIGEgIiMiOiB0aGlzIGlz
IHRvIGNhcHR1cmUgYW55IG90aGVyIHVzZWZ1bA0KPiAga2VybmVsIG91dHB1dCB3aGljaCBtYXkg
aGVscCBkZWJ1ZyB0aGUgdGVzdC4gSXQgaXMgbmV2ZXJ0aGVsZXNzIHJlY29tbWVuZGVkDQo+ICB0
aGF0IHRlc3RzIGFsd2F5cyBwcmVmaXggYW55IGRpYWdub3N0aWMgb3V0cHV0IHRoZXkgaGF2ZSB3
aXRoIGEgIiMiIGNoYXJhY3Rlci4NCj4gDQo+ICtLVEFQIG1ldGFkYXRhIGxpbmVzDQo+ICstLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK0tUQVAgbWV0YWRhdGEgbGluZXMgYXJlIGEgc3Vic2V0
IG9mIGRpYWdub3N0aWMgbGluZXMgdGhhdCBhcmUgdXNlZCB0byBpbmNsdWRlDQo+ICthbmQgZWFz
aWx5IGlkZW50aWZ5IGltcG9ydGFudCBzdXBwbGVtZW50YWwgdGVzdCBpbmZvcm1hdGlvbiBpbiBL
VEFQLg0KPiArDQo+ICsuLiBjb2RlLWJsb2NrOjogbm9uZQ0KPiArDQo+ICsJIyA8cHJlZml4Pl88
bWV0YWRhdGEgdHlwZT46IDxtZXRhZGF0YSB2YWx1ZT4NCj4gKw0KPiArVGhlIDxwcmVmaXg+IGlu
ZGljYXRlcyB3aGVyZSB0byBmaW5kIHRoZSBzcGVjaWZpY2F0aW9uIGZvciB0aGUgdHlwZSBvZg0K
PiArbWV0YWRhdGEuIFRoZSBtZXRhZGF0YSB0eXBlcyBsaXN0ZWQgYmVsb3cgdXNlIHRoZSBwcmVm
aXggImt0YXAiIChTZWUgVHlwZXMgb2YNCj4gK0tUQVAgTWV0YWRhdGEpLg0KPiArDQo+ICtUeXBl
cyB0aGF0IGFyZSBpbnN0ZWFkIHNwZWNpZmllZCBieSBhbiBpbmRpdmlkdWFsIHRlc3QgZnJhbWV3
b3JrIHVzZSB0aGUNCj4gK2ZyYW1ld29yayBuYW1lIGFzIHRoZSBwcmVmaXguIEZvciBleGFtcGxl
LCBhIG1ldGFkYXRhIHR5cGUgZG9jdW1lbnRlZCBieSB0aGUNCj4gK2tzZWxmdGVzdCBzcGVjaWZp
Y2F0aW9uIHdvdWxkIHVzZSB0aGUgcHJlZml4ICJrc2VsZnRlc3QiLiBBbnkgbWV0YWRhdGEgdHlw
ZQ0KPiArdGhhdCBpcyBub3QgbGlzdGVkIGluIGEgc3BlY2lmaWNhdGlvbiBtdXN0IHVzZSB0aGUg
cHJlZml4ICJjdXN0b20iLiBOb3RlIHRoZQ0KPiArcHJlZml4IG11c3Qgbm90IGluY2x1ZGUgc3Bh
Y2VzIG9yIHRoZSBjaGFyYWN0ZXJzICI6IiBvciAiXyIuDQo+ICsNCj4gK1RoZSBmb3JtYXQgb2Yg
PG1ldGFkYXRhIHR5cGU+IGFuZCA8dmFsdWU+IHZhcmllcyBiYXNlZCBvbiB0aGUgdHlwZS4gU2Vl
IHRoZQ0KPiAraW5kaXZpZHVhbCBzcGVjaWZpY2F0aW9uLiBGb3IgImN1c3RvbSIgdHlwZXMgdGhl
IDxtZXRhZGF0YSB0eXBlPiBjYW4gYmUgYW55DQo+ICtzdHJpbmcgZXhjbHVkaW5nICI6Iiwgc3Bh
Y2VzLCBvciBuZXdsaW5lIGNoYXJhY3RlcnMgYW5kIHRoZSA8dmFsdWU+IGNhbiBiZSBhbnkNCj4g
K3N0cmluZy4NCj4gKw0KPiArKipMb2NhdGlvbjoqKg0KPiArDQo+ICtUaGUgZmlyc3QgS1RBUCBt
ZXRhZGF0YSBlbnRyeSBmb3IgYSB0ZXN0IG11c3QgYmUgIiMga3RhcF90ZXN0OiA8dGVzdCBuYW1l
PiIsDQo+ICt3aGljaCBhY3RzIGFzIGEgaGVhZGVyIHRvIGFzc29jaWF0ZSBtZXRhZGF0YSB3aXRo
IHRoZSBjb3JyZWN0IHRlc3QuDQo+ICsNCj4gK0ZvciB0ZXN0IGNhc2VzLCB0aGUgbG9jYXRpb24g
b2YgdGhlIG1ldGFkYXRhIGlzIGJldHdlZW4gdGhlIHByaW9yIHRlc3QgcmVzdWx0DQo+ICtsaW5l
IGFuZCB0aGUgY3VycmVudCB0ZXN0IHJlc3VsdCBsaW5lLiBGb3IgdGVzdCBzdWl0ZXMsIHRoZSBs
b2NhdGlvbiBvZiB0aGUNCj4gK21ldGFkYXRhIGlzIGJldHdlZW4gdGhlIHN1aXRlJ3MgdmVyc2lv
biBsaW5lIGFuZCB0ZXN0IHBsYW4gbGluZS4gU2VlIHRoZQ0KPiArZXhhbXBsZSBiZWxvdy4NCj4g
Kw0KPiArS1RBUCBtZXRhZGF0YSBmb3IgYSB0ZXN0IGRvZXMgbm90IG5lZWQgdG8gYmUgY29udGln
dW91cy4gRm9yIGV4YW1wbGUsIGEga2VybmVsDQo+ICt3YXJuaW5nIG9yIG90aGVyIGRpYWdub3N0
aWMgb3V0cHV0IGNvdWxkIGludGVycnVwdCBtZXRhZGF0YSBsaW5lcy4gSG93ZXZlciwgaXQNCj4g
K2lzIHJlY29tbWVuZGVkIHRvIGtlZXAgYSB0ZXN0J3MgbWV0YWRhdGEgbGluZXMgdG9nZXRoZXIg
d2hlbiBwb3NzaWJsZSwgYXMgdGhpcw0KPiAraW1wcm92ZXMgcmVhZGFiaWxpdHkuDQo+ICsNCj4g
KyoqSGVyZSBpcyBhbiBleGFtcGxlIG9mIHVzaW5nIEtUQVAgbWV0YWRhdGE6KioNCj4gKw0KPiAr
OjoNCj4gKw0KPiArICAgICAgICBLVEFQIHZlcnNpb24gMg0KPiArICAgICAgICAjIGt0YXBfdGVz
dDogbWFpbg0KPiArICAgICAgICAjIGt0YXBfYXJjaDogdW1sDQo+ICsgICAgICAgIDEuLjENCj4g
KyAgICAgICAgICBLVEFQIHZlcnNpb24gMg0KPiArICAgICAgICAgICMga3RhcF90ZXN0OiBzdWl0
ZV8xDQo+ICsgICAgICAgICAgIyBrdGFwX3N1YnN5c3RlbTogZXhhbXBsZQ0KPiArICAgICAgICAg
ICMga3RhcF90ZXN0X2ZpbGU6IGxpYi90ZXN0LmMNCj4gKyAgICAgICAgICAxLi4yDQo+ICsgICAg
ICAgICAgb2sgMSB0ZXN0XzENCj4gKyAgICAgICAgICAjIGt0YXBfdGVzdDogdGVzdF8yDQo+ICsg
ICAgICAgICAgIyBrdGFwX3NwZWVkOiB2ZXJ5X3Nsb3cNCj4gKyAgICAgICAgICAjIGN1c3RvbV9p
c19mbGFreTogdHJ1ZQ0KPiArICAgICAgICAgIG9rIDIgdGVzdF8yDQo+ICsgICAgICAgICMgc3Vp
dGVfMSBwYXNzZWQNCj4gKyAgICAgICAgb2sgMSBzdWl0ZV8xDQo+ICsNCj4gK0luIHRoaXMgZXhh
bXBsZSwgdGhlIHRlc3RzIGFyZSBydW5uaW5nIG9uIFVNTC4gVGhlIHRlc3Qgc3VpdGUgInN1aXRl
XzEiIGlzIHBhcnQNCj4gK29mIHRoZSBzdWJzeXN0ZW0gImV4YW1wbGUiIGFuZCBiZWxvbmdzIHRv
IHRoZSBmaWxlICJsaWIvZXhhbXBsZV90ZXN0LmMiLiBJdCBoYXMNClVubGVzcyBJJ20gbWlzc2lu
ZyBzb21ldGhpbmcsIHRoZSBmaWxlIGlzIHNwZWNpZmllZCBpbiB0aGUgZXhhbXBsZSBhYm92ZSBh
cw0KbGlzdC90ZXN0LmMsIG5vdCAibGliL2V4YW1wbGVfdGVzdC5jIi4NCg0KT3RoZXIgdGhhbiB0
aGF0LCB0aGUgZG9jdW1lbnRhdGlvbiBsb29rcyBmaW5lIHRvIG1lLg0KIC0tIFRpbQ0KDQoNCg==

