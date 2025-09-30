Return-Path: <linux-kselftest+bounces-42622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141DABAC5FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B251927064
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC12F533A;
	Tue, 30 Sep 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="pa25DMFT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013080.outbound.protection.outlook.com [52.103.33.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80882853F1;
	Tue, 30 Sep 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226234; cv=fail; b=VgKX1BDOglaN49sNZ1lC7+U688wO0kmBczGBzdr3ec6drOvXklIevf+z8Z9WEza9tjpceHkqf8jmeu8L48beZ5jpq7Ro6tsbL+A8jmyUzjoPucwqJE0Z+vLxdeYJjqGuvH07uwfUVB19OB2rvjdB7s3k7BwarLZzCwhJ50dtTwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226234; c=relaxed/simple;
	bh=MlcV48drCrF91p+fYxmv7x7AZ7NElwp8c9ZnFmhxcwc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WV2IQILiAC4RFXtEpUQgsdu8H0AqcsIyFiNZrK3uBbmmLz745/X+ClYRPG/c1MAF7RbyYyF1WephIpzbVTAEju7NA/zdPJ0WMpjN1yFEwoRj2hNOB8mIfyQWARNb+rMuQUR+45K6Udow6qeruhwTvkKUpdX7DVd1OKW5iEuuxzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=pa25DMFT; arc=fail smtp.client-ip=52.103.33.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6Cy6H4muorEj0Wxrskgzi13KGdoazaa65eqhl51aH/1oCrTgNBlXBz/zJ0xGcxcUWUlJx6jnoNEdxb43Z2SHds11dERR54qY6Agj1sLvR2svEQ5I0hEJBhAP8DDRi2WDFmnLn+icaSJqLLurDwVxF5+4VBjMtyyy4zMVw3kD60T9TpC02t9uJpED6TdNlYCaJ8vQ6opZbMEEIwHO4JDLA3LQ/OJ47liL6ecL2LnmTRtiFgC+jYj87V5xyr229L130Wu7Yo1lHbKGwvjN84CZp8//EKEC/wWRkQEGi89eTWUPW44EUbVA1Gg0TqxHm7q8Eta6ByhHMUzY6TNKfeqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9lQFLoS0N8Q++E76fA6tXTQUK33lLUbA3h4oT8sN6Q=;
 b=w2O5+3YuW5ONArpmEiWqLM9mLJpbpPmf1Y5ds1hKFnG23qbf/GWIsqSkLvWp+7zETAiIizZMhE4B9HKsDIM3rNAsiE8++kYnxy+pUUb0tPaW3vbpEXW6jiYfpKBGdRAotMfH2XyiTSJaDvnZ5ft68wtQjFNWADbjKSHEynLj4H3ma8V6FHmCTivSJTDsC3RNX2p7EbPdcWXGsqVU8X4uVkr+8EGzihFCL+3qgWbaHz3f/7dblyTWF1iGsRPHkX561Uv+Pc+okE6JlJeZZEUOxds4++l6LJrxH0aPl6WDJAs7nTEyTmYGm9FBDKFSWL4OU+453TfrgvKf+5PabTWHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9lQFLoS0N8Q++E76fA6tXTQUK33lLUbA3h4oT8sN6Q=;
 b=pa25DMFTi6brVQC6MhAT9gaibqJ6Rl0NTulsTA5JamXSGcnq1xiKej/ZUTF5sp+g1Nrk8w4KsN7vHJXlh5OKe+YsLvWc5Z5yO6aIVL/rf+bqLjKfQoUuMpxgyqya+pzOrmn8EhfsTVSyquSg13SSAihgQnylLWIbCr/uw6gVvGFM3wHMkdzneNhIgZ02vglLkVzifKuaRG1eVZQtEPijsTSUiqQ3pxzsneXWatyKC4iY0hoAzzmZdjcOwpSZwo8BXg7cGL/GIZFngHS2fauRM4j6/xMqN9lA+lN0ii3NknTbuHScslgRlRIwcFO1ltGCwR4D8M/2K4js3PNx8BxAjw==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by DB9PR02MB8394.eurprd02.prod.outlook.com (2603:10a6:10:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:57:09 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1%3]) with mapi id 15.20.9160.013; Tue, 30 Sep 2025
 09:57:09 +0000
From: David Binderman <dcb314@hotmail.com>
To: "mic@digikod.net" <mic@digikod.net>, "gnoack@google.com"
	<gnoack@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: linux-6.17/tools/testing/selftests/landlock/fs_test.c:5631: Test for
 pointer < 0 ?
Thread-Topic: linux-6.17/tools/testing/selftests/landlock/fs_test.c:5631: Test
 for pointer < 0 ?
Thread-Index: AQHcMe9e3zKSXSb3ZkGRzpwSx6EO7w==
Date: Tue, 30 Sep 2025 09:57:09 +0000
Message-ID:
 <VI1PR02MB395245DCA7CA4B6DEA15F1ED9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|DB9PR02MB8394:EE_
x-ms-office365-filtering-correlation-id: f2859f4b-c13c-496b-1b1b-08de0007b88a
x-ms-exchange-slblob-mailprops:
 gMiuAN0LASJErQlHnJTyv53e9/qVxipOC2B/vOl1oUuFWa1AWqHcIwS/OCqkqB/z2nfS7xtCT4M70wxPF4FJUju3zVHA6S6BT1uHFItDMTtMWNt72Ml6mRh5aNPaxfLWxPCDE3nUq3ZpDa1ysAlp69ex5NwM07qt0OWetN8LEknfVJA5w7Tgm12j0ifZ6LuiMpEDDNQk/POtWIFuzBSYpRofx105SQPD+lj78cn6qxAhxr/wx3sDyd9YARaSuvmjzsi4UTHLzoJsWaiZnKBPGY8ZsjGpKWLZLO0ETar/Gm8y7s2whEy0Ez6tO8OdV09v5aJhbs5MegeIr1XjOKGfx1oEq4A21kp6zmpVLBWXozWp8o29xOPi6qqbWsBcxCMreq1fimKcJ5jdlE4goff6UJt36ukwD6XRPwD5Tf0RNb21zil4a41jC7QAnNvD5E9sPxHxvQWvFQud/F7T5G/rZaffOnaUUmSobNlMWAyuolsKjj14yWQE0jYXogvAd8kJkElBCOX/v1htSc9tvk3SMuR63/+tUMP2D0BO7AaJkqQQJVHVjGBC6fKk6zqlzlbK8MRSAhyP7mEHBq/jYnF8RfllqCAo0H0yElQmxUu6ni/pRnCyLlepsMywQGeMu1BXqfRRMgyWz7TOJ9EYpwwP/qeipdKORzPrwxKFPImntNkV+eJ2BPWHxo80yjP6wya5xFOpqcjBC8xC9/xLFy9SvA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|15080799012|461199028|31061999003|41001999006|15030799006|19110799012|8062599012|8060799015|40105399003|53005399003|440099028|3412199025|102099032|21999032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?flLjrfyDflR+uohu6QG7mrjHv1SQ1laEZBV5W8CpXnldm8nYfZhdcZR1iW?=
 =?iso-8859-1?Q?nUSHco7UCkaSrBgvCs6vj1zOnzqu2FcTUGrayR1g68yZM1hPDwpE8Y93Qs?=
 =?iso-8859-1?Q?t5OExEJjvaFpQCRI9I34qDQkOik7zGt0yql73Xen/7CWQ96TQaOa+iWiRr?=
 =?iso-8859-1?Q?8TZUIOtE7zJnoI4thk96RX9oIcA3khw8IqMzPlBuzHdoW+Qx/DygPSO7xO?=
 =?iso-8859-1?Q?t5Kg/VphIYrNmXSu8pRSXdxIrFtB8qBaPlO7N04DQHAjQkiraGj3xREzXD?=
 =?iso-8859-1?Q?qXLv8aIGc37n6cOcWCxrvpG05z6rFojsupR5CKveQx+MOCSqhN1zxOZM92?=
 =?iso-8859-1?Q?hiS6s880jpknmBfk6I24pSu+D0tmgAxXDdv6QaVqX0+tqxKquoQtmZO9wj?=
 =?iso-8859-1?Q?HUwkUbm9g5sTtPEDWF4LKxqyiRz+gGdfkaziGOQsIyW9/qzuJhLNY+5ZDG?=
 =?iso-8859-1?Q?OeWzt2mFLcev90DGcMHQrrcy7NVvR7izMCNzJX2yszaWTprsTcvpv3mcNE?=
 =?iso-8859-1?Q?A2B9R3IG6IVkCEOJgLCICESr3257Q50fKUIdbyz19ZIugve21RVMz9wS3N?=
 =?iso-8859-1?Q?LB71vILI1KFoTxBlkrRhkZjbRF10wY+N5MOXYFJeRxr++p0ENvpH9v+lSi?=
 =?iso-8859-1?Q?G1HLsdThlVTWdxNvnOfdtXXv3Uc2eGQpZW3uDH2HeGyQ3UlLb+xlE/CXKv?=
 =?iso-8859-1?Q?kNeo3VsWB3WmUgZOG29Gm6b8XkmpjqRVPMMn8l3WbnzKRkRJIfx/wD0dNR?=
 =?iso-8859-1?Q?JEZurodHS83WS/uao4kaBxleJWuyNwFCZWlwG0aml6EDQB221zN+fZAhFW?=
 =?iso-8859-1?Q?pJr26WDukDext3P1FodWB15hIEHqehmfL1bQFLQ2D6ZQVld9IHcM6V30Xs?=
 =?iso-8859-1?Q?nYk2jgMg6G17oR0U944rCdJNyrOE4ixunCDatSAt0lQhIdWtwmjardTA8w?=
 =?iso-8859-1?Q?9vgneIU8Mj5sKbazAMtLU+tcN8beGSoUVN+aFmaQJyzHjhvx+w81vHkT/s?=
 =?iso-8859-1?Q?hPCSijoaZqo18qaGRdShcERR1hEMvLhmxkVu5lsFwthtHQbGxRee94pY67?=
 =?iso-8859-1?Q?lLNaSvFbqLiT2RChmbXOTRXAUyW1ebc8oezMLGZmNTOEPtkZtsPwoIxMmC?=
 =?iso-8859-1?Q?HiOkGaHOuOC0GfZsjf7zwQ9ZSbIhjFATes8znQs47MeeZcBLjSXVXSZ/5Y?=
 =?iso-8859-1?Q?haXI1tX6x+h4bD5rYWwgyyKs8S2W0ZUyNN/IrzqjV4wfmbZgcqn1rjeiBS?=
 =?iso-8859-1?Q?jFCIZ/Iz7clTK7RNhk1QAjYhj3OvkknsPsc2VR0jeA88gLV+dX1ZdHv9fR?=
 =?iso-8859-1?Q?t3b4tqmFniJbZKVrqPoONjuMkg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EzJe71Nu24u7uHAF5CP5eJv4zH0s3fRHt415WmP+nMegvUlJqRF9vDeqgr?=
 =?iso-8859-1?Q?pRBujFgylXkfBA6vdiP8KeW1/erx8Qz7/lD3OE6xncIZg59HufBEXenTrR?=
 =?iso-8859-1?Q?J6YbCzHyGNW8zanHTMEN7rWKzRwv/B734OyY5AVj62azucJbC3dXEf982W?=
 =?iso-8859-1?Q?KhhhcYZMQc7/ppQtX2XSeEn7sVys6sfWB6LpUTO6ITcx8gGaXJm+L0YqLD?=
 =?iso-8859-1?Q?oiw0MX0+J6jRR0n90YsH9e3HtdaQWxPrQafGQ58ZEuIN+C/1yi8KAe5VAP?=
 =?iso-8859-1?Q?Y/549Q0WujWE1pu41aoexSF8asMJYnZ/9EXKoQzqKZweEfqsoiX+FoXMeZ?=
 =?iso-8859-1?Q?ZssPZW/vpRUr+/t2PC4GthVFykXfO7qKkut9Cs1i30r0JChzDertvCXQwn?=
 =?iso-8859-1?Q?l2W2OJuj1fHJeor37rsc5iukjWkWE08tXYuHBq0CLPHSW27MAdYujn08mI?=
 =?iso-8859-1?Q?gSjA7jCmEpQ+o0ppwsrKwMvtsPpO4zxXpmU0WVF2+GR4CLR2STQv42/kQS?=
 =?iso-8859-1?Q?Mh8C0UYewlmZrAWHgrh0FdRmcYFHDr/41Fv9yZxUUXNuNwyowKGtYmW5fv?=
 =?iso-8859-1?Q?31KIO7yNwfan6aFSW+Wh09qpF2D/oJa+BOROcEDrwcyeWZs2no2fCdGZrd?=
 =?iso-8859-1?Q?QF1OOHucqeZ+i+pnxY3jRFcHW9l6B+UqhzA+k+MW2sbRW1zgAUwVhcOWjw?=
 =?iso-8859-1?Q?qK9npcl/rbLhlfCx8AWTTTSNrLOmkpm+BwQSBDxG0T0dIDA/W2EnUoMwED?=
 =?iso-8859-1?Q?ifrcaEl+7/c33O7N+wF0bTRQCEjY1EbQgNp3OaAAHHtXQPQIW1sNQUXZ0k?=
 =?iso-8859-1?Q?PRZyNhrJlmkNWpxwyfJlH44yhvrJZWjX9LRo8SByA6qq/Vj7Qp0csrzMnT?=
 =?iso-8859-1?Q?JVIXfe6DT0h96R6vpsRVJLrwJJ7bRDBGOksOstFcn3ftsC05x+6AIQIQk7?=
 =?iso-8859-1?Q?sqLTZXhmPBxSmcyC97M78dgr57D3f+/I0DizMqbb5COBYBIImWiCapsxUp?=
 =?iso-8859-1?Q?4VhAUgb5V8VCRpCeV2WyGOpP8/uwp/SthAYH+2AnGwGO39bi/Yc+wDFOQd?=
 =?iso-8859-1?Q?G903q9dSG2nRYdRz3pinbPYn5s0tweJW34LCB4yTpWVtpaGM39W/k3Zbg7?=
 =?iso-8859-1?Q?Y2JIOjP7WprOhIHGoGeaVVJGTnDoPRfTiLisXeK9Ajjfvsdm6Li4OXdlBJ?=
 =?iso-8859-1?Q?jHM014+bNv1ep8SAilXADbfqKWMRBWEYD48GhRS/kEqBMafy5cokGyOMMN?=
 =?iso-8859-1?Q?hQOBBOsFNZrUBh5wC1cA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f2859f4b-c13c-496b-1b1b-08de0007b88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 09:57:09.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8394

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.17/tools/testing/selftests/landlock/fs_test.c:5631:23: style: A poi=
nter can not be negative so it is either pointless or an error to check if =
it is. [pointerLessThanZero]=0A=
=0A=
Source code is=0A=
=0A=
=A0 =A0 if (log_match_cursor < 0)=0A=
=A0 =A0 =A0 =A0 return (long long)log_match_cursor;=0A=
=0A=
but=0A=
=0A=
    char *log_match_cursor =3D log_match;=0A=
=0A=
Suggest remove code.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

