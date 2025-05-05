Return-Path: <linux-kselftest+bounces-32327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB8AA8FA2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967973B29A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993A1F8EFA;
	Mon,  5 May 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BL3urNKH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C33194A44;
	Mon,  5 May 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437521; cv=fail; b=P8OSo/JDGYpYWI5MeTFXsBWB6BwSwfXhoby8zef5XhXwHZhpEZD/2Or5k2UDDHn1J5P/MdVyqlemheTMDxGq5p1Q7AMK9C1kKYn+mOFPGKIc82TyfFFaGx+5NqkF1QaawlAtZ+PSSahLolQJqFyiXNipPfxVHYWQWlHqFdcMxiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437521; c=relaxed/simple;
	bh=mfxXO/8ulOXpNc5BX5lGaE5rKGenzPgCRAz84S2Gz34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rzK2ehTTKWtfK17AFEC3R9aNMH6lL2GP9oXcu5ETjJMsTP8q/TNyk54YHi5j4MuDBY2LK//PZ1iyY+J6vcosa3ewKZnVX3KizrOsmj0B1hUKblyMO0lclsTHDjQn9C4bOrM33wkkHGFlUvY6ffMDfMbNMPyOY+YjFSB9/47E6zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BL3urNKH; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9FsojTGv0hS8J8Sov/vHJ1s6FfUQ6GWHJ11qKT1d+F8Jc0im9oPWbJLhhrg0GitW0aGv+JdKL0HaaN91I/BB3vpUCXM0LWv41xtIdv0FAlHhjC9Ud1DoKR5Y+PSud5nbck+YygIh8aBRojC2W3ODy3dRbsy1KGWfzfzGhPDoSAFTi/6fe3U/YweBwpBVd5dRvjitPr30BAmL5p4hLj1X8mBL8xszt+SVZjgyTbUxuLA74qpCVyuk0+kolGY5R8T+zs3bAq4PRbXAM7meRbwq3wEzlAGtnQ89h/qA9MJvwOp9OicP3xcdyYQepBtMix7xAWT/Fe0L/CnhrhNqZ/oEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgd8QTPsJEexFLIkx9OE5FMRtlzRgbnKQwvvu1NLg8g=;
 b=KwI488x6Lgp7uJ4B0UgXvVFBSiLu3l4QZvvM+8P/Wr+KiFgGWqjBohd9n1Mr2Z7GiH7deA4lwP+FzLp3dRDt4eezqX2CBfOMx7OFoPxP3ILH5ksXm2vecDokL0bEGj+7t+PvRBw8bHbB1UBqP/4yGpkush/jfb8CExYP2wWTS824n/5vltpS2HES752K2pMF3O203JiIk+/Y3IRxxy1awrYnvWZPAUz/M7zaRlC6RuJxyqjSSbtQIXQNKo3hx2wa4Pe3F9t6cycJAmzgLvaqKvqPE1xkHjZC7XW6MY23J+43hhTKAiVZIa4lK1mUkR6reUXiD1EpBTV31cBgbJJ1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgd8QTPsJEexFLIkx9OE5FMRtlzRgbnKQwvvu1NLg8g=;
 b=BL3urNKHr86+1W59JfWeq70z/oVdz0tJvAT21dGf6e5bab9HSuaeK5t733V1UkK0uDyng+Guczhkh6F/qX0gOY4tvlRQE8ltENCEYyI6ajBLQjNIqVQbrS8T5WRtC4UFT8KEzyljAXVNiOWKXoOiQhO3tYjKBVQinW7LkmqAGTcqqNgGTRscBGKpwDnHe2ZvfRQJhfHKsonHownxZBDE/WwbGed9GMl+oKVkLDIfrrG8B+xsDBLMJjraD5gStGc2ZMHVWAjddrpSHaViyfhjdND3o/uN99YwPcidXiJfqsbdDX1/oJhABpD3e0L7HcvdETjrLHrHfIVOJPMWwV5dog==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB9732.eurprd07.prod.outlook.com (2603:10a6:800:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 09:31:53 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 09:31:53 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHbts+Mke/s+BQEcEGH2K9LqlvrXLO65t6AgAgu8CCAALu8EA==
Date: Mon, 5 May 2025 09:31:53 +0000
Message-ID:
 <PAXPR07MB7984EA61072148D407FEBCF2A38E2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
 <20250426172025.9459-2-chia-yu.chang@nokia-bell-labs.com>
 <CAD4GDZxPrgfMFLTG4Mc1VK0hM5ODP2tTFF771EhMzWnbC8BwaQ@mail.gmail.com>
 <PAXPR07MB79842877B8262B919848AE85A38F2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To:
 <PAXPR07MB79842877B8262B919848AE85A38F2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB9732:EE_
x-ms-office365-filtering-correlation-id: b3ac9cdc-6919-4e6b-b5ee-08dd8bb7aba7
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kECcK1FMlZbPdGjuDlyL2bits/h7D+JD5jiCvvS6uEAufggFWqdaYqvEjOKq?=
 =?us-ascii?Q?RCBvsODKQ99bZ5f8f3mvmRVBEPfRsGK8W5ZGLvfwktkWcB6T7PK8ESf5bcju?=
 =?us-ascii?Q?zXekmylDWmlnRSdjN77CMS3qHFo06fJb14TWmKYuhzyf9AJDtc+seploKPWy?=
 =?us-ascii?Q?VoCB9lFlStrgFUmBwGW9brHauytbu5utnpKvYjuLNrdzoTpZMeM6RFaL9JbS?=
 =?us-ascii?Q?vPoujg4C1RrcBn3GcYJMdhoDsxpMfxmY0xJbl6OVmghelmYfRs42PjKj4Kjz?=
 =?us-ascii?Q?0FYGtwKdv/N3Jq+oyAenkcikAY10VbxW0dRg41nx2Q/NUpzuetGF+9H1N8al?=
 =?us-ascii?Q?DDkzRlYvS58Q1h5gHcFhaYmwcWfiRXwevS3o1lt7k46/eZ6JGdZ/8nUvfi1z?=
 =?us-ascii?Q?H1cRCikVjhIeZwB28SLMLrdOTsJJrVzx3yqOrxfVp+rCdtI3fpMTDj0MjTu8?=
 =?us-ascii?Q?9MlnPjXPsIajJ5sc7GV3j/Asc8l7ZU/Q788rr+JeozTA1tB3ds0abMDO2ijk?=
 =?us-ascii?Q?O3xt8r61npIaCCA0MJo7iCdhGWiMRZry2IeUcl/BMeYXe86v//+b0LY4tC7V?=
 =?us-ascii?Q?2IjmsfDkdtCMap6YiaUnzU0qx1ODE+fsTNpmNyZJz+x4ZRIs2l2G9ucbTvux?=
 =?us-ascii?Q?GdDsy2qMMfQ9oYNJr/QtJFGxPUrp7mP+T1u4IVxZSwjv2z09RD+ZwQ3gAmvk?=
 =?us-ascii?Q?69GkA2HTTlXmN3vkSGe3mU6xdZHi91BuA42Fs372M+LKfTHJiFkSA2lzEQO1?=
 =?us-ascii?Q?Iu13pQ1s17uPw9wC6KK+28nPCtIAHyiWN8F46qPjmGt0p/EBdxB2ARVLCkPl?=
 =?us-ascii?Q?EqfEsba3CUAcFXNZIW5jMVSmNuQheQWs8V5RlPKWWSwly4vswz7GXNollcqT?=
 =?us-ascii?Q?iF4Wf+ZHp/qCnd06zP1/kGWrI455loZ39vSrqmV9j/c48wcv3Et6EaXjYOrW?=
 =?us-ascii?Q?vwYLQfX5x5mbxGPfGP+YM+jzjhdfwMtjamsLeqNGZYCUR1oE1bmxkHi/Ij4W?=
 =?us-ascii?Q?a0hfENrPTfvVbU+m7XH7+LErDzvnGH7GWQIzM0uWojwAvdoYtk8h6RJjvHGQ?=
 =?us-ascii?Q?vGBUl1SP2pmlljgifZ0yMNreFhcItPg4yoCiSFmDq65YVYBnH10fG8TFe+5L?=
 =?us-ascii?Q?RlriOFpw4HMGWsDe14uJP4JgTVqVmjhqv0rKK4menNSI/Y1vuM7aWuIJIpTp?=
 =?us-ascii?Q?zsAI8JLEEwhoxVhekYn71SoBP1IH1P/unogCXw6lKycoI/7NdKOc9KgRw8cT?=
 =?us-ascii?Q?gTep8d8uedrjKBpxILD1QB29fJOiFeuf7QYWlMaZPMWXO+By+StwCrsS7TXu?=
 =?us-ascii?Q?w+6zQIN5o7cPu6o2076ndCcR63odU0UQfW4Py37WiljK6KT9L4OTpO3WC900?=
 =?us-ascii?Q?BC4x77vbbfO42wclLl9fp3MSwI9RYF5VcKrs3xVWMoLGa9naG/aAQbnU1OJL?=
 =?us-ascii?Q?YbRN2YDi7dIsk64rvESn1zOk5RZXZHPVPVFa9oB4QcKNrI34uSYRdUbcQ6MA?=
 =?us-ascii?Q?UqjaBTGbNy+la2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cAI1rxqbxIUWWcbRvNSw6Qlvpez6doCdjQILQyhL5ADgKbdJh65JiFtc0YOS?=
 =?us-ascii?Q?qC+dNVVd4lbaEZp7QLEsClESqaVVQ4qDqF5wwzIaTXPeOLysaHsB/OJGoDVF?=
 =?us-ascii?Q?Vydy8nTygKJUXi1SBLFzjSXSYg8azby9jE8dsbnwltpRpRzM2tzN4TWvgq2l?=
 =?us-ascii?Q?+19YywZdMdBL6U0iDhOWf1A/++9rKA589AaUwQB7unNoe42qF55hbPVEpy0P?=
 =?us-ascii?Q?aA48XPG5t+V0oNKBefAVlKg/xpdb+OTtkBWWuIj29bOGGQSszSzBY9jt3kk7?=
 =?us-ascii?Q?5Li+NKv/rIz0F6HVzXZ/jVne20rzE/rQb30KHF+NbOVhQX8UAHIpKCQg/U9U?=
 =?us-ascii?Q?mJOD5rxU5QKMqhwUSj0wLogU/iLBX9R8k/U01fq6MzqDEzhOAIWPBGPUTwQ+?=
 =?us-ascii?Q?HuRg11WDOs/PTN+WHj2FGT6WdxeeIV0Uu5eJOJO+B9QkA20A+E6gfEykMXaz?=
 =?us-ascii?Q?zt/QdIuPGQLbMIh0f5rt52NRxgCKhYyx+C12byGYG27Dpx7Q48n6rbzrtLnt?=
 =?us-ascii?Q?8IDo1gkGxf3lB3z4lSvfQpDwFL0TSRl2umkTKEwutFpSH7d6Yw7d0v8RsNGW?=
 =?us-ascii?Q?x/eL1RVdFXlgnzJ9Ez+NkHp/32GE8LzJERLSMoAxsRKjj2U24B4MLNRIi8rW?=
 =?us-ascii?Q?rKFZ1Ok8SI4MqijLtvc6E8LZQfV1sH9X7iL8FI21DSJXecNieAeuawwk25JY?=
 =?us-ascii?Q?737TxCI9jqan6O/+Xb7OdnFma3v8uy4wMNxb8ZBq31eyfLSy7k4mmgReYEb/?=
 =?us-ascii?Q?QPBUDnh25k6ykYfP1MRUVFmkLLhAl5mZmCcL/91UAt7pxDpRvn6dGgwknajC?=
 =?us-ascii?Q?LCbQv1WT1j8CxhdFuBdGqxsiJpHlujZ2NrFWKDnr3Y4VHnOTf2P/lSjsTiWr?=
 =?us-ascii?Q?APj8C0UteYxGzxBitdm+juO81Sgigxy4Q/sK/6zyWmIWkmZ++q25piFo4iBQ?=
 =?us-ascii?Q?d/QL3ZOGTVJ1vVqGF+FvLNtmxa+FicHzLDuTctZ2vIExQtEsfevOZdiP5v+D?=
 =?us-ascii?Q?rgG3koVdxgQ+anDLYL8Dxla7OYG06diQrdfV5oJWxWFQLl4k8nPWeGnW/9vt?=
 =?us-ascii?Q?+JHt8IIWQkqima3XybfzK4WQqyp+EKwWkF4IXcTg/UKqJuMm3SjvvK+qEyIR?=
 =?us-ascii?Q?lfaUazSCGxegQRXJl1lMAU8fvZsXHceZD2Rxa3M9wBuruxjMZukw/Z+6LrOr?=
 =?us-ascii?Q?nqRYVZN3bqziw/hkjmAbNPS0D6M1NsXo0m8O0ycmifuEEFAH00hlD29rftJC?=
 =?us-ascii?Q?R3OuqTqk8/rH1Rnt4NaFrm+Gqvpt4N5XrpKXfDb4dyyE/C2puNnhEvsZ0KBb?=
 =?us-ascii?Q?VZsi7rSJOWp59XmpNb8EQX6TTW+/02quLrs4Vx7+gUO0UwOOCAKBGR+yA6Bz?=
 =?us-ascii?Q?OIo5TxuP1/SaToMF9jv9QSJBG5rDih9ndUnB+cSebut/osOEpbXYcnajy7C+?=
 =?us-ascii?Q?ZvteNslV064IY11qUSXbfN63q8Jn8WXpjIqTC5PlNrqJJdNkXouqRUUoAHCR?=
 =?us-ascii?Q?WSzHzFnRbAkUvml5jkSQoOHnFch3ZqX7jcOba2gyCLn3yJp1X24eZDQf8myh?=
 =?us-ascii?Q?sGmgCx4FBD61aVAU86RLy4fId7IBzaw9NPQukle6NsEo5iJ8br3mSzvXD0rR?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ac9cdc-6919-4e6b-b5ee-08dd8bb7aba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 09:31:53.1089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKB+sCkJ14bwwFW9f/gSk6BUHYyD3M94CJKo5EvIuiLkHmQ+8w+P25Izh3EKQCgc69FtfIhECmozgl/XPDbrA8R0xtLddXP6OtE/5a5daoFK7XazFwYOcUHMwzHbcjXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9732

> -----Original Message-----
> From: Chia-Yu Chang (Nokia)=20
> Sent: Monday, May 5, 2025 12:14 AM
> To: Donald Hunter <donald.hunter@gmail.com>
> Cc: xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com; pabe=
ni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaze=
t@google.com; horms@kernel.org; andrew+netdev@lunn.ch; ast@fiberby.net; liu=
hangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@ke=
rnel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@=
nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@=
ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gm=
x.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Subject: RE: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
> > -----Original Message-----
> > From: Donald Hunter <donald.hunter@gmail.com>
> > Sent: Tuesday, April 29, 2025 7:15 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com;=20
> > pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org;=20
> > stephen@networkplumber.org; xiyou.wangcong@gmail.com;=20
> > jiri@resnulli.us; davem@davemloft.net; edumazet@google.com;=20
> > horms@kernel.org; andrew+netdev@lunn.ch; ast@fiberby.net;=20
> > liuhangbin@gmail.com; shuah@kernel.org;=20
> > linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com;=20
> > Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>;=20
> > g.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.com;=20
> > mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at;=20
> > Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> > Subject: Re: [PATCH v13 net-next 1/5] Documentation: netlink: specs:=20
> > tc: Add DualPI2 specification
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > On Sat, 26 Apr 2025 at 18:20, <chia-yu.chang@nokia-bell-labs.com> wrote=
:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Introduce the specification of tc qdisc DualPI2 stats and=20
> > > attributes, which is the reference implementation of IETF RFC9332=20
> > > DualQ Coupled AQM
> > > (https://datatracker.ietf.org/doc/html/rfc9332) providing two=20
> > > different
> > > queues: low latency queue (L-queue) and classic queue (C-queue).
> >=20
> > General comment is that this does not work. Please test it like this:
> >=20
> > sudo tc qdisc add dev eth0 handle 1: root dualpi2 ./tools/net/ynl/pyynl=
/cli.py \
> >     --spec Documentation/netlink/specs/tc.yaml --dump getqdisc
> >=20
> > Consider moving this patch to the end of the series so that it can be t=
ested against the implementation patches.
>=20
> Hi Donald,
>=20
> 	Thanks for the tip, but I had an issue using the above script.
> 	It seems it expected either 4B or 8B payload, but several parameters use=
d in dualpi2 are uint8, e.g., coupling.
> 	Or it is suggested to replace all u8 to u32, e.g., like what has been do=
ne in fq_codel?
> =09
> Error decoding 'coupling' from 'tc-dualpi2-attrs'
> Error decoding 'options' from 'tc-attrs'
> Traceback (most recent call last):
>   File "/home/anc/net-next-github/net-next/./tools/net/ynl/pyynl/cli.py",=
 line 160, in <module>
>     main()
>   File "/home/anc/net-next-github/net-next/./tools/net/ynl/pyynl/cli.py",=
 line 141, in main
>     reply =3D ynl.dump(args.dump, attrs)
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 1088, in dump
>     return self._op(method, vals, dump=3DTrue)
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 1082, in _op
>     return self._ops(ops)[0]
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 1069, in _ops
>     rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_set.name)
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 775, in _decode
>     decoded =3D self._decode_sub_msg(attr, attr_spec, search_attrs)
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 726, in _decode_sub_msg
>     subdict =3D self._decode(NlAttrs(attr.raw, offset), msg_format.attr_s=
et)
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 759, in _decode
>     decoded =3D attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_ord=
er)
>   File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py=
", line 151, in as_auto_scalar
>     raise Exception(f"Auto-scalar len payload be 4 or 8 bytes, got {len(s=
elf.raw)}")
> Exception: Auto-scalar len payload be 4 or 8 bytes, got 1
> =09
>=20
> Chia-Yu
>=20

I manage to resolve this issue by replacing uint into u32/u8, i.e., it reve=
rts the change suggested in v12.

And now the dualpi2 qdisc can be successfully produced.

{'family': 0,
  'handle': 65536,
  'hw-offload': 0,
  'ifindex': 2,
  'info': 17,
  'kind': 'dualpi2',
  'options': {'alpha': 40,
              'beta': 818,
              'c-protection': 10,
              'coupling': 2,
              'drop-early': 'drop-dequeue',
              'drop-overload': 'drop',
              'ecn-mask': 'l4s-ect',
              'limit': 10000,
              'memory-limit': 30280000,
              'min-qlen-step': 0,
              'split-gso': 'split-gso',
              'step-packets': True,
              'step-thresh': 10,
              'target': 15000,
              'tupdate': 16000},
  'parent': 4294967295,
  'stats': {'backlog': 0,
            'bps': 0,
            'bytes': 0,
            'drops': 0,
            'overlimits': 0,
            'packets': 0,
            'pps': 0,
            'qlen': 0},
  'stats2': {'app': {'credit': -121120,
                     'delay-c': 0,
                     'delay-l': 0,
                     'ecn-mark': 0,
                     'max-memory-used': 0,
                     'maxq': 0,
                     'memory-limit': 30280000,
                     'memory-used': 0,
                     'pkts-in-c': 0,
                     'pkts-in-l': 0,
                     'prob': 0,
                     'step-mark': 0},
             'basic': {'bytes': 0, 'packets': 0},
             'queue': {'backlog': 0,
                       'drops': 0,
                       'overlimits': 0,
                       'qlen': 0,
                       'requeues': 0}},
  'xstats': {'credit': -121120,
             'delay-c': 0,
             'delay-l': 0,
             'ecn-mark': 0,
             'max-memory-used': 0,
             'maxq': 0,
             'memory-limit': 30280000,
             'memory-used': 0,
             'pkts-in-c': 0,
             'pkts-in-l': 0,
             'prob': 0,
             'step-mark': 0}},

> > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > ---
> > >  Documentation/netlink/specs/tc.yaml | 166
> > > ++++++++++++++++++++++++++++
> > >  1 file changed, 166 insertions(+)
> > >
> > > diff --git a/Documentation/netlink/specs/tc.yaml
> > > b/Documentation/netlink/specs/tc.yaml
> > > index aacccea5dfe4..9eaab15cc216 100644
> > > --- a/Documentation/netlink/specs/tc.yaml
> > > +++ b/Documentation/netlink/specs/tc.yaml
> > > @@ -51,6 +51,31 @@ definitions:
> > >        - tundf
> > >        - tunoam
> > >        - tuncrit
> > > +  -
> > > +    name: tc-dualpi2-drop-overload-flags
> > > +    type: flags
> > > +    entries:
> > > +      - drop
> > > +      - overflow
> >=20
> > These enums need to be defined as part of the UAPI in pkt_sched.h and t=
his file needs to be in sync with those definitions.
> >=20
> > This enum seems to contradict the comment in sch_dualpi2.c:
> >=20
> > bool drop_overload; /* Drop (1) on overload, or overflow (0) */
> >=20
> > > +  -
> > > +    name: tc-dualpi2-drop-early-flags
> > > +    type: flags
> > > +    entries:
> > > +      - drop-enqueue
> > > +      - drop-dequeue
> >=20
> > Also contradicts comment in sch_dualpi2.c:
> >=20
> > bool drop_early; /* Drop at enqueue instead of dequeue if true */
> >=20
> > > +  -
> > > +    name: tc-dualpi2-ecn-mask-flags
> > > +    type: flags
> > > +    entries:
> > > +      - l4s-ect
> > > +      - any-ect
> > > +      - none
> > > +  -
> > > +    name: tc-dualpi2-credit-queue-flags
> > > +    type: flags
> > > +    entries:
> > > +      - C-queue
> > > +      - L-queue
> > >    -
> > >      name: tc-stats
> > >      type: struct
> > > @@ -816,6 +841,64 @@ definitions:
> > >        -
> > >          name: drop-overmemory
> > >          type: u32
> > > +  -
> > > +    name: tc-dualpi2-xstats
> > > +    type: struct
> > > +    members:
> > > +      -
> > > +        name: prob
> > > +        type: u32
> > > +        doc: Current probability
> > > +      -
> > > +        name: delay-c
> > > +        type: u32
> > > +        doc: Current C-queue delay in microseconds
> > > +      -
> > > +        name: delay-l
> > > +        type: u32
> > > +        doc: Current L-queue delay in microseconds
> > > +      -
> > > +        name: pkts-in-c
> > > +        type: u32
> > > +        doc: Number of packets enqueued in the C-queue
> > > +      -
> > > +        name: pkts-in-l
> > > +        type: u32
> > > +        doc: Number of packets enqueued in the L-queue
> > > +      -
> > > +        name: maxq
> > > +        type: u32
> > > +        doc: Maximum number of packets seen by the DualPI2
> > > +      -
> > > +        name: ecn-mark
> > > +        type: u32
> > > +        doc: All packets marked with ecn
> > > +      -
> > > +        name: step-mark
> > > +        type: u32
> > > +        doc: Only packets marked with ecn due to L-queue step AQM
> > > +      -
> > > +        name: credit
> > > +        type: s32
> > > +        doc: Current credit value for WRR
> >=20
> > The credit member is declared in the wrong place here. The struct membe=
rs must match those from struct tc_dualpi2_xstats, in exactly the same orde=
r.
> >=20
> > > +      -
> > > +        name: credit-queue
> > > +        type: u8
> > > +        doc: Current credit queue
> > > +        enum: tc-dualpi2-credit-queue-flags
> > > +        enum-as-flags: true
> >=20
> > The credit-queue member does not exist in struct tc_dualpi2_xstats so s=
hould be removed from here.
> >=20
> > > +      -
> > > +        name: memory-used
> > > +        type: u32
> > > +        doc: Memory used in bytes by the DualPI2
> > > +      -
> > > +        name: max-memory-used
> > > +        type: u32
> > > +        doc: Maximum memory used in bytes by the DualPI2
> > > +      -
> > > +        name: memory-limit
> > > +        type: u32
> > > +        doc: Memory limit in bytes
> > >    -
> > >      name: tc-fq-pie-xstats
> > >      type: struct
> > > @@ -2299,6 +2382,83 @@ attribute-sets:
> > >        -
> > >          name: quantum
> > >          type: u32
> > > +  -
> > > +    name: tc-dualpi2-attrs
> > > +    attributes:
> > > +      -
> > > +        name: limit
> > > +        type: uint
> > > +        doc: Limit of total number of packets in queue
> > > +      -
> > > +        name: memlimit
> >=20
> > The convention used in YNL specs is to use the same naming as the enum=
=20
> > definition from the header, with the prefix stripped off. For this=20
> > attribute that would be TCA_DUALPI2_MEMORY_LIMIT -> memory-limit
> >=20
> > > +        type: uint
> > > +        doc: Memory limit of total number of packets in queue
> > > +      -
> > > +        name: target
> > > +        type: uint
> > > +        doc: Classic target delay in microseconds
> > > +      -
> > > +        name: tupdate
> > > +        type: uint
> > > +        doc: Drop probability update interval time in microseconds
> > > +      -
> > > +        name: alpha
> > > +        type: uint
> > > +        doc: Integral gain factor in Hz for PI controller
> > > +      -
> > > +        name: beta
> > > +        type: uint
> > > +        doc: Proportional gain factor in Hz for PI controller
> > > +      -
> > > +        name: step-thresh
> > > +        type: uint
> > > +        doc: L4S step marking threshold (see also step-packets)
> > > +      -
> > > +        name: step-packets
> > > +        type: flag
> > > +        doc: L4S Step marking threshold unit in packets (otherwise i=
s in microseconds)
> > > +      -
> > > +        name: min-qlen-step
> > > +        type: uint
> > > +        doc: Packets enqueued to the L-queue can apply the step thre=
shold when the queue length of L-queue is larger than this value. (0 is rec=
ommended)
> > > +      -
> > > +        name: coupling-factor
> >=20
> > The definition is TCA_DUALPI2_COUPLING so either this should be "coupli=
ng" or the enum name should be expanded.
> >=20
> > > +        type: uint
> > > +        doc: Probability coupling factor between Classic and L4S (2 =
is recommended)
> > > +      -
> > > +        name: overload
> >=20
> > The definition is TCA_DUALPI2_DROP_OVERLOAD so this should be "drop-ove=
rload"
> >=20
> > > +        type: uint
> > > +        doc: Control the overload strategy (drop to preserve latency=
 or let the queue overflow)
> > > +        enum: tc-dualpi2-drop-overload-flags
> > > +        enum-as-flags: true
> > > +      -
> > > +        name: drop-early
> > > +        type: uint
> > > +        doc: Decide where the Classic packets are PI-based dropped o=
r marked
> > > +        enum: tc-dualpi2-drop-early-flags
> > > +        enum-as-flags: true
> > > +      -
> > > +        name: classic-protection
> >=20
> > Also does not match the eum definition. Should the enum name be expande=
d?
> >=20
> > > +        type: uint
> > > +        doc: Classic WRR weight in percentage (from 0 to 100)
> > > +      -
> > > +        name: ecn-mask
> > > +        type: uint
> > > +        doc: Configure the L-queue ECN classifier
> > > +        enum: tc-dualpi2-ecn-mask-flags
> > > +        enum-as-flags: true
> > > +      -
> > > +        name: split-gso
> > > +        type: flag
> > > +        doc: Split aggregated skb or not
> > > +      -
> > > +        name: max-rtt
> >=20
> > Does not exist in the DUALPI2 enum so should be removed.
> >=20
> > > +        type: uint
> > > +        doc: The maximum expected RTT of the traffic that is control=
led by DualPI2 in usec
> > > +      -
> > > +        name: typical-rtt
> >=20
> > Also does not exist in the DUALPI2 enum so should be removed.
> >=20
> > > +        type: uint
> > > +        doc: The typical base RTT of the traffic that is controlled=
=20
> > > + by DualPI2 in usec
> > >    -
> > >      name: tc-ematch-attrs
> > >      attributes:
> > > @@ -3679,6 +3839,9 @@ sub-messages:
> > >        -
> > >          value: drr
> > >          attribute-set: tc-drr-attrs
> > > +      -
> > > +        value: dualpi2
> > > +        attribute-set: tc-dualpi2-attrs
> > >        -
> > >          value: etf
> > >          attribute-set: tc-etf-attrs @@ -3846,6 +4009,9 @@=20
> > > sub-messages:
> > >        -
> > >          value: codel
> > >          fixed-header: tc-codel-xstats
> > > +      -
> > > +        value: dualpi2
> > > +        fixed-header: tc-dualpi2-xstats
> > >        -
> > >          value: fq
> > >          fixed-header: tc-fq-qd-stats
> > > --
> > > 2.34.1
> > >

