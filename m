Return-Path: <linux-kselftest+bounces-3742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11D8421B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 11:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2593DB29C7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045F65BC9;
	Tue, 30 Jan 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="4SpROWlw";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="hDVA+daS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFD66B25;
	Tue, 30 Jan 2024 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611194; cv=fail; b=oDhdTOpaiU6Y2aWDYu+vjU1Kdll3H7MjRVfohsi1Ig4xdhI78Q2SeT/yB/cdqMkYr+sF0LOGbodIxQbKgdlTFYgyx1Nk1cUZw52tamoVBSYeSrXojewHhQiVDM5LXy3QRp+cWz7CpEwUyytuela6UN+3SJNC/Iz0f4YbJT8DX6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611194; c=relaxed/simple;
	bh=gT+mykw0A6J4UHCY9490XGK14k5J1LC752VfrhidBsI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q1s39vSXH6HZj4KqpMvSRgqw7FmdSrPeI5mK9XyFOyLK3rIQQigTJpl2R3TLouMKijtrPEiUiiAZbjdlqTIKaTb6d1XHvDkVR90msysbglViMmaOujsKNJEWnW9ooeOCzrZn4RnYPVdq1tf+DZ/EXN1EBz3ft7a2dKuGq71lwtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=4SpROWlw; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=hDVA+daS; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U6Db8R032053;
	Tue, 30 Jan 2024 11:12:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=12052020; bh=gT+mykw0
	A6J4UHCY9490XGK14k5J1LC752VfrhidBsI=; b=4SpROWlwsUJUpdtBlM2C+0M7
	kIhCaCoJBE2yZjDqXSIm4PAITSo2UzSWAk38s4nXe8NLg/vZXKNgQuUc6CX4RU2P
	9ucw1lfgZyK9OHOtuSwuIMrmutSTJ+nhJ/r08ps+rTQOQHFe2EWKPymlGvwARSlL
	XclLKOAAd6Ey5R7i2lDnZv7KODV0FvRfiyuOYD09n8k7wAr3zQ+MeHsHWen2DUFj
	Z0usimbO2PnWeG0oUs1yXoF3ImNRGYrYXbs2j+wMZMuSlNR1ldlBX1V84r4kZ9ux
	8oj9UWOfg/vuUiQB2Lxxx4y1Gb0AwSE4oKCtR/ijj8TiF7bQ2kvfWsoFA2DRSQ==
Received: from mail.beijerelectronics.com ([195.67.87.131])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3vvq2ck0xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:12:21 +0100 (CET)
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Tue, 30 Jan 2024 11:12:20 +0100
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.233)
 by EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Tue, 30 Jan 2024 11:12:20 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3G8DYy11ujb0BiMzvU3aQsKonDapB8cKHuOG0UafyXdaoXlJsNXCeZBGdMGor4ONMPUQD7LY0OtCRPwBEIP2rUnZlhBhspY15Qh4F4OISwadpYAP7oBPdDEGRuB2VIZFPHZ4c76ROtb43VpJ91pR46a/P1vMYM323UJSncAarlVW1uVT61Drjm1domcKsvQA/9Pq3zfbVC7CoENZe72EBLzmcUY/GCS2G1F4s7C+vd//aILfqZcfjKj71ON0B1cVt/jZQ0/rtcEzFFC2uqUu3fUn7WR6fe9YxK5/v9uzmDHyq4ZlqIdySiLS1eg783Xk8AZOkgLl9eL1EYbH8wiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT+mykw0A6J4UHCY9490XGK14k5J1LC752VfrhidBsI=;
 b=iRjJQ3HlaWpSobbsyAuBNirsRbBXx4HUVDNBV3oGklqC+BeWHdTeR1Gq8IcHoYl1Vy4CbjsCkbKMg22qzztNz/2dNMwnWfBfFECXi+gmKVn7N2AEnuy7o0uDu9zyrduNFvvasiRjgMfJ+UMXrrKm90poDAANzGoFpT5T+s4I+L8MyEBbn45jsa79IUwF6EtP9NqbJ9qfXzZdgQExCe/Qnn+FcujiGd9HKqeJiAK1ui6b2bIbOszB7PwEDjsd5NH49odYwCJpqTnkWUperdE/0ljRqSM4LARC4eiy479jGhYqSFmYHW/5lRTkdzv5MphX+FelcOreflCTG4XqMTJM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT+mykw0A6J4UHCY9490XGK14k5J1LC752VfrhidBsI=;
 b=hDVA+daS4Zog4ZqA+Oucuc1WCmOrJ9ykOyoa8avZWp4Y7wxGt5I9wixkK2uuWpB1a3hXEmCPD8h5eQ9rh9BhP7ivv+9Ly3B4g4Pxf+LP6k4Ul4ZR8DSPfB0XQpZB8uc/Gb5kxMbd4KXTDII6X/IbqIg3TZ7SNeKsN1/2Wr8vRu0=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by PAXP192MB1168.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 10:12:18 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::f1b7:52d5:fa2e:39e1]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::f1b7:52d5:fa2e:39e1%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 10:12:18 +0000
From: Matthias May <Matthias.May@westermo.com>
To: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matthias May <Matthias.May@westermo.com>
Subject: [PATCH net-next] selftests: net: add missing config for GENEVE
Thread-Topic: [PATCH net-next] selftests: net: add missing config for GENEVE
Thread-Index: AQHaU2TOWj8kZ0pbL0S72Tlve6fkGw==
Date: Tue, 30 Jan 2024 10:12:18 +0000
Message-ID: <20240130101157.196006-1-matthias.may@westermo.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P192MB1388:EE_|PAXP192MB1168:EE_
x-ms-office365-filtering-correlation-id: a8650639-e497-46ce-d97b-08dc217bf0fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7vZnGo2ucjoxKu+d9+QQmNeaKQ9rBFE7VxJjBm62MGeGmExAra1u5LvFqyOKlIf7JJamZJGRNDppkSXcMoTwPS2DjYafltgQEUzLdi8+j820+BUoljWl8AhzFJUuG/lU8ndAP0T5VxVqR5pGRfOHfxYdOMvJfYEaXNJiZ0jzfZ+d+ecKTYVHNvBvWLpddkKtv4K4/UlAIYFLd0m+zZaTKE9yz0xfy7SVmNFeqsaClzQzc4Qozhjl8ukypn+wMJtHfnZXIKLWZXW3r1bPwlegFJawsUVW/G5lanlfHdUPFUjIMw2PAzwShfB5q2e21fG7/DhQgUNUxn3Zhf+ela2qOmSQB4Er8dSzDROW6WwnMU0z7F+06vDAjhb239mzQEKWHsJw51+KSbbHGJoR9fE9mzfwiTm62QSQ92Zv7fC8wY70hL0twiMPcF87v7C8IumtCfNw3zbqEhTBAxVekyAZ3g3Dg/9xzyZvFEfQyJxT7Ur46Krh3bFq22Dhsd+q0HhrkSRILGHn44EoA/GkOxM4V0Mq1Y2kIHV4wyeN3Pt02zGorD8Ec0hKqhmHIxx7ZtrGmLpqblLWmS3T1M4JJoN5/Za/dU/lz/2WY+0LknV9Bzn4JNDVM9DVC0bTMlks1FsF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(2906002)(107886003)(1076003)(6506007)(64756008)(71200400001)(5660300002)(6512007)(2616005)(66476007)(66946007)(6486002)(110136005)(76116006)(8676002)(8936002)(4326008)(316002)(4744005)(66556008)(66446008)(26005)(122000001)(38100700002)(478600001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hnaozibKPVOY5Ug8GPY56lum0aDJS/48ysoOV8tx9eyfjg7XwJ/5vcUhU9?=
 =?iso-8859-1?Q?HNHCWqwJdLfXcUv/ZmPUaaPxUejNGxvSPRMCb9lNIA/smQ8CdtLks8ahgW?=
 =?iso-8859-1?Q?INs03BwR6AgapZ5LoeeviasaC8zPTzQkFi7niLFOOLGVGs7ig6+RU7cm61?=
 =?iso-8859-1?Q?v7krABRnLqfuyxxrj4+o5QQmAEmEIjJ8U/w3uMelYQUMqv/eD74m/hSulH?=
 =?iso-8859-1?Q?Rpzk73SbDC0IGm8SOKnAAJdiJ+JyCOeIO0bwWx6uJXY33VOrM29IkXYjfQ?=
 =?iso-8859-1?Q?HxEUTXPNlM8PoUrHO5j/yJzR2W1dTMWgcqwIq2DF15947rv4By/rVj4JgM?=
 =?iso-8859-1?Q?FkBTw0xa3DVGxwYmyYNFMZA8AdLHVarpUNftRk/y6igzdqsA6cLVQhMJo4?=
 =?iso-8859-1?Q?a+7JoJYjK3Oq/BCRxfUEkMrqvZtxYzcuLFbGZWaxZ58/5VHgvAYJ5fQrzS?=
 =?iso-8859-1?Q?PcT/ULp8p6oQm0v4JDOyiHNj82/q4cFY4xt8yjCosxcHWZsfKFhb3u7jxz?=
 =?iso-8859-1?Q?ByRhHQ1CX2lHcfw/UdyO3bUevEQqr0ZKGNSiS/kG4OENa6xmEWAHjAeJNO?=
 =?iso-8859-1?Q?uwfSjAQ9+tWZevOzNsb4313hSaC/l3yK0kYCMW47ixVILSkgbfm8a3h4nX?=
 =?iso-8859-1?Q?v65vetfQ8t3yqNJ1WRqrFF0SYtuMcwZ9IfN29ZsS4sn4Jgml5ISwvOMS//?=
 =?iso-8859-1?Q?uECoLc8ecCgtFA8seHnR/LjxtRYsmXBEJ6TUTKUdK4sEMef2dnTfNke56Z?=
 =?iso-8859-1?Q?5p4GutcpUloaB+yvROOLD6gw1L2FYwn0KddZKhD9jPqMIMvBDt+2QHDnK6?=
 =?iso-8859-1?Q?Vm0hOu1xtG3fhiQGsyCWcFuR7hO23BBsNoZ8UmGzy2t39KoR+sgg/F8gBL?=
 =?iso-8859-1?Q?iIB3ydbPelaHHm+vFqPgQUIY+EuUN+0ifLjDdDmUsq7WcR62iDDRA10oja?=
 =?iso-8859-1?Q?nErpqsJvIymVQ6o8voOz3qkUI8qKCdcEE1EBOaf/TtunUoHSTJQZgoaGMQ?=
 =?iso-8859-1?Q?H9yokmQuh5JiOXniL1Zg1nkB/LVIsqj/IZZz0OwRHGCQQGe8nMbbig+4vQ?=
 =?iso-8859-1?Q?Um+N6h+hz1CRTmSuVIP564jgMc853/SD12e3gwARJh6oXzzVzUOVFTEiZ9?=
 =?iso-8859-1?Q?Avw3AHCrxgO35quupBimVknZbJrsmXcSkRNMPb9mzDqyjmZL/Zp/2q+iR9?=
 =?iso-8859-1?Q?ihcTo/q6Fosoog/Lmne90VOVpj0NUg2j8WTgkzp+ZLrBPMHwelGg146O5r?=
 =?iso-8859-1?Q?6NZBOot7R54z+jRfP0j95dX0gO9u0MmleJQQEitTCiFBnncBCobMH/0zYf?=
 =?iso-8859-1?Q?I+LdhfzcqEcRu4sb+8sIp7vIPYAZOoWrwB3qy9053sBfSKETrIeUWiqMQn?=
 =?iso-8859-1?Q?0RPF8bpX+yDGH9vQ7KvV/kB9fWKLcplxLrppkawr28vrmNYwVl3W5qeZFh?=
 =?iso-8859-1?Q?kjyL1WUAV3NoHhTtJYOHwZ9uEEwXAFYA7hZLOrWthQ4MdDjssMUULN8NrB?=
 =?iso-8859-1?Q?ix4U+R9ISPewj/hPGjCpqp6eFfZUnu4BFPs1YFXY/J0SUEe5AssK4Y0Fk5?=
 =?iso-8859-1?Q?iv9VJ/2/w27VjmZe0j/t8+TpWGnQHd1iP3GnTfiiH8jFQa9V6R8AdOPJ1B?=
 =?iso-8859-1?Q?193sPxFn9L81QDVt/p+EOZRT7W6r4lDoap?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8650639-e497-46ce-d97b-08dc217bf0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 10:12:18.7266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zm9l1YP7aErW5Uev5NxuROgvTjfZeuJ7gZP2hpmHT3rD6aWCB8pdrmH5ggjWtrUWvV7am7Hvq1PGCgO2ZfIT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1168
X-OrganizationHeadersPreserved: PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-GUID: V2ZDgzUHueQdlI4ZAnBfvyfKVoxLRTV5
X-Proofpoint-ORIG-GUID: V2ZDgzUHueQdlI4ZAnBfvyfKVoxLRTV5

l2_tos_ttl_inherit.sh verifies the inheritance of tos and ttl
for GRETAP, VXLAN and GENEVE.
Before testing it checks if the required module is available
and if not skips the tests accordingly.
Currently only GRETAP and VXLAN are tested because the GENEVE
module is missing.

Signed-off-by: Matthias May <matthias.may@westermo.com>
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/n=
et/config
index 19ff75051660..8d79c024bebf 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -76,6 +76,7 @@ CONFIG_CRYPTO_SM4_GENERIC=3Dy
 CONFIG_AMT=3Dm
 CONFIG_TUN=3Dy
 CONFIG_VXLAN=3Dm
+CONFIG_GENEVE=3Dm
 CONFIG_IP_SCTP=3Dm
 CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
 CONFIG_CRYPTO_ARIA=3Dy
--=20
2.39.2

