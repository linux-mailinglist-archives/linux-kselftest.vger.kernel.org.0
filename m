Return-Path: <linux-kselftest+bounces-29350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCFA67454
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 13:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B10189CA87
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EE20C471;
	Tue, 18 Mar 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rVWrYMeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB5290F;
	Tue, 18 Mar 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302315; cv=fail; b=qLEq3G0ZjMRUqHcpN5Af6aTM/U3BDc1+9j1GWqYGV+LnDQ/d1XAgpuyWA7HFr4s51gmA/6FX49E21jsmE/Hq/eAOFd7AWFNKEOF1wAe8n0dDVj+mBRCRuZE6aDB+eKOKtvheN3LLheQn1L6elTksbJStDyG64Chex4K4teJ64Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302315; c=relaxed/simple;
	bh=5K79aDg9E3vgakKY4ORTNHg6kZnPxL68OvxiyXubYfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQ69k0Mkvxe+Kt7qA6Ywa9VRdsSYQiu+61yplgyXpVyJ1eP66EGs71zrWDjKqzG/cpaZ5k+MJ+9BA/d2yE3OoE7BbjPZeBlfZLcFTNZ2aFu6vAxo7Jal/c8YbGMXgWvTYa3xg1IfdLc8g98uuJ/NtKUdUR6RqzK/EhggVpgrMo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rVWrYMeY; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7drx8yggLQM8eppblx3NHjmv3/ypk38t52lBwQsettfMBkkY8FuA1lulo+c6arl5E4Q2W85SWWcw0MKKfZP3TOOjWiqzgUqpAI2G3BNW7C2vFzdw49JIcHIdbiOb6ilkjuZlGkPmQeT39jqASDhrBXIo/5IJUk+FyPK2PlodK9fHDTzIO2iuWbAjk66fQt3DdGpm2kHOIyLOZxVQvIa5HKm4l1DncasDo6TsN8jASjDUGGVaOdcYP0TT+AG1mYBEtkAUlLkwvBg3ke924aSijxUrQSNyds+2jwAAbCZkTgQgpI0KJNfVnmFHN8kQLfbr368U5iWgdwNx1ubEojqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jksi8tHrnlJaEfu3rIrYngCeJO5E8ax9BgzF0asO/gw=;
 b=I5knE4TZhmftIUO6JYGvnke9IoJGApFIpXscoAK0FbiV52Jt0sXT2ocBCfdZ6Qggs3Bq5A4BWMIYS7tUva1JE4cPOC/cVfIH4IzdgnAth27x48UnwXWb2G37EmCFAmn6h203mur5cfvNwL8Il9hsxuyXsD5lHFvFDMBKGpHnGm0LjUApYy2EMPnHtyXNYoYsF2YpI98K9kbFj0N9VOT+mO+FsLE4kFzvQdavo/Sc8miL3bTlOWg/9aTdKmqUmwLAxjsb1QdKWQQz+KU8kEvgIrZCzIBPXjO23032FwzW/r6+QTMn7uYggqieEjTUSEJXzJ2dK0ZIh+2i6vXG/iG9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jksi8tHrnlJaEfu3rIrYngCeJO5E8ax9BgzF0asO/gw=;
 b=rVWrYMeYNtYWcvA5lDF6+effZDVpf87riaxgUoNTs5bvZ5AQvuQ6QfvuvZQPgF6h14vvmoeihd+IiIZf1JpIHJTb6c5yexdl7tJQkkYW9tkwkyPWj81ahIjok+rnnHKWuzTJm1Yc5EAdiVNnV7y5JwYa1ds4kIKUvEPyRPCjQ9ww/SNKOgLNlUWycwwFtwNWgoGRraDZ74AsY+BZNIF/zD16Ei7vmZUNkNF8XwuWXwitMMUQ//yEYkcZDBaJ8solyLteY6Rk5cx/nmV7gXCUW0wTtjm7fkZhzDuP9UmBRbbXiZsggc6wxYNUyOjXk0w8OS5ygVxmrA6njiDIqt6Heg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9007.eurprd07.prod.outlook.com (2603:10a6:10:3dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:51:47 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:51:47 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>, Olga Albisser <olga@albisser.org>, "Olivier Tilmans
 (Nokia)" <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>,
	Henrik Steen <henrist@henrist.net>
Subject: RE: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Topic: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Index: AQHblomz65WqQmgTSEiGQj+R5VbIwrN3V1SAgAGCnHA=
Date: Tue, 18 Mar 2025 12:51:47 +0000
Message-ID:
 <PAXPR07MB7984DC2DA693FD00EABC0392A3DE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
 <20250317064053.4fe8425b@hermes.local>
In-Reply-To: <20250317064053.4fe8425b@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9007:EE_
x-ms-office365-filtering-correlation-id: bec8af8a-a025-4d80-e066-08dd661ba4e5
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gCzhtRIVc1Hp6sh/kyO5FqOseNit/b3yCzvqfnt/c5hMRR6cVASkSgx7PzBd?=
 =?us-ascii?Q?2use1+z+a/fACb/J6DEaYNhbBkRxqOTDdeDhdaY+CCr8L3fTX3PEN1TDsTi2?=
 =?us-ascii?Q?1nlYURGlVxQDCljpuhx8/RqzJ7lgvNxY0+boeQVmR28LuTUEsJOlG8ap4jM9?=
 =?us-ascii?Q?QEgXYZMEa80LFnIyVaxF55SJUnmlhM/Fr28GJMFxyfQ7EHmteGJUIrt4C3WP?=
 =?us-ascii?Q?gNOs4mcor2ng0s4PAKn3/pkSm3RPfDKFWZTob1ZusWnrVkwZrtOZtVQyuB+Y?=
 =?us-ascii?Q?Eu1sLST7vLV6N6mOOTvh477lo1Cr1L76iYrJHg3YuFeqdeiEQjT5Y3+1QtFb?=
 =?us-ascii?Q?Ox/6ClQhlXcgGcVks+COOEfb4njykeVo6lXZF8V3KxkRoDkP0WIfEISXMrXU?=
 =?us-ascii?Q?p10ZVnHMUkMGNzrLuhqRXRP+aB6MCSb9A2J1m0gIPcNDewy2SqF2DFNffnhM?=
 =?us-ascii?Q?NiZkDobdpgc+sZiMpCBLwQjAqTZYEI7XJzRvdfryFSkHJ1tF0wJCvOoVKSgE?=
 =?us-ascii?Q?/NHXt74/EU0CTHnn4VbdURu7Kx0w9ghwU6Nl3VzKtcC90s8a66CllP9DzpQf?=
 =?us-ascii?Q?Qm1SjLQUHXp+BYo+4fPUKLxUKeLRB91L9GNAZLQRDBZsqxTE3qdaH1mjRXd3?=
 =?us-ascii?Q?tZTu4fYI7+KCyjqqQ9zvfw5OHAWAV3CMkDn52BDgrVcEhUESQ4I6jq+9no7o?=
 =?us-ascii?Q?LINwrEygqnQIuvYd2ygcmTpk4OGtz93AC5cd+SPOXRofrSA3RAZ8+ymDYb3E?=
 =?us-ascii?Q?D7y2m2BMNLJcDA1Rlw1tqvUBJ/beh5yM7rKC0Bin8FlzpPgyx+K6JGHXC5SS?=
 =?us-ascii?Q?E4Bh+Lzn4AC8Kal5uZG3zIJPDHqGpxOUDamSQGnZCEcwY9oMxLK2iHPYAEpT?=
 =?us-ascii?Q?TDpp2EuYeKQnWzeeKgfBZpyMo3fQpD3tbcLmxB5quhQbyymfA9ya363SVgoN?=
 =?us-ascii?Q?PJOr0TR3zzwG1YbmnapXt6fe7L9qMDG3qDFQ2zWQ26K0LKa66kATyQDhg17s?=
 =?us-ascii?Q?I38M9Sv9x9fLETQJLdMKdxZ7M8N5mCQpqV/sq2cE8vMmlY8Hhh5XlCPzXd1/?=
 =?us-ascii?Q?EqCP7SDuvahp64Yk+P9BMO0ZrRbVyoyWfBlYntaRc/M4lj25Zk5ESvCEikuu?=
 =?us-ascii?Q?R/rZuWkFJj5k3EpUDxTekTD82hYJaTJrAFlaU6qEQpx831roX5rv3DvHHjn5?=
 =?us-ascii?Q?05wJMe4qF65uQvStQ77Y9I/RMiYowrH+1CE4zQmOQgeicK471AJ0R0tdi1rz?=
 =?us-ascii?Q?AtpBNxNF02PZnvsD111Lo5K9p+BBuwb22mOu7CYzEfPnDozxscDXJQ5eChns?=
 =?us-ascii?Q?JNCrjMwvdDM4TJwaS1cTr9PP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RUiYHyXru/VMItytmgwZYsL66gQDBrJgCMdCvuO3T5ULc1NKk5zOzzqk7C1i?=
 =?us-ascii?Q?p0RqZg6CZbbBPNvbyIc643P98wzQxY7ddROYOl3wet8SaZMwV0WPiA9uOuDn?=
 =?us-ascii?Q?Uovsg2AXxghqkMW8DZMLodsSksqximdbYflfTI472X7vGKa8gQgfYNdjKK7W?=
 =?us-ascii?Q?vaQ4nGdspsZdh/YpavkyeAQqhyPCwmp+2G3B/B49JPvwbSMyf5aG98crccKN?=
 =?us-ascii?Q?McnLveBWtiCyj4rv/NkrY/vrvt1uTjcbuiC5MLANqoWO1HSEj2EniNAedNFE?=
 =?us-ascii?Q?jYH83SVhUfbVDZ4kb98WZBOfcXdwXudPVyHLz4mVZ5g0fsAKr9iMdm5h3gnR?=
 =?us-ascii?Q?KI4ty4WHmbvf48gURlU2ii/IB/oTXtmX82MEIMGyUxjK3upfGK5ufQu9xrkF?=
 =?us-ascii?Q?kR3ghxNhl6uHLW1t7vjwrYcu/AaeUKgLqGaX2/dUOSy3848oITbA7X1aR4sy?=
 =?us-ascii?Q?kzmAvuPzyW6x0HipSFzUTF+bD7rY1zDCJ1INEHcBdS4LQUCBt7xYbvai8swD?=
 =?us-ascii?Q?GwYg2GQKt3DJmDGjW+4VTG51iwxZhPqWrsNlJ2WtK3yFeoTVXtKWyKhomkz+?=
 =?us-ascii?Q?QKJuT35xY3U5Zl/H5VmpbjBqWhgf/7riiHibCvTyqKwopWAc4RVEkSoR43Au?=
 =?us-ascii?Q?fpRT/O3y7QKRXp8gwykU4u4KzsUDw+Y34nv2wBk8rPzguM4zujQDLcFai68V?=
 =?us-ascii?Q?yAh7uEDpAkhs/OWOj2ATZ2zB0i00CHMzPunQxtH227IBm/UJSRSzq6kNFwp/?=
 =?us-ascii?Q?tGB6BUJVs5/sLtiNAURl47Y7gjHN88c3epqRPdUU7XaBrE1v9miP38GabUnd?=
 =?us-ascii?Q?sHsjSS88uL5ogfoiU8V8OLyWCnomk9xDSxLJoK+rXBlgqUXJH3a/S/tyE1rp?=
 =?us-ascii?Q?6ZxBjIFJUwXujkbtJFVQ+l4Jip7/DsPLnQVpaOLdNWd23j1hix1puzR9khHq?=
 =?us-ascii?Q?79KheIZZh9aBQPnyO/13Yh8RfRzdSstPL/xW0kRegeTOOxfw+p+VWz2R6mdt?=
 =?us-ascii?Q?62VWsG3Fj9bpqhD4Z27n1OixTHy8fIMZxT90W1gv7jk7Q11UDQge9M5y3eBP?=
 =?us-ascii?Q?b0i70BNCZmE4qPIgpH0a4RnWRah9czjXv5/PP4VZKLeBuVnmNzhXXkcqTixI?=
 =?us-ascii?Q?W2Ov5HI1OuzzF5zlrvTzlkvGGfJPqugKtTPHnG+fRzyS6aExf9fGhxykzpIY?=
 =?us-ascii?Q?fqFkKnBtSqIQQ3dJxybPEGvL/er+gXmsKt0TLgLb2ekA/5I9zGQbn5AoSKin?=
 =?us-ascii?Q?x4nB8AGVRYhyV1Firy5ry9yszD6TlXpoGv7h3utkk6lZBmSP1LYteiIvcYn/?=
 =?us-ascii?Q?snTnHDtfvv07Qw3fcm3TfEpyb9Ighx6REUIgxyajsB/OjY7LB609ub/7+8ie?=
 =?us-ascii?Q?n1DmKOShNHyVUrXirVzFLTRmiJoZIrm0k0189utfj3+LWF9kLacjDCvIRlKW?=
 =?us-ascii?Q?yxDuUl/RdF7AAAxInmtrWjIR+8zq5gqPvGLs+mqG13na3ABZfVz8H93W98ud?=
 =?us-ascii?Q?xfxm9eAiL8dmSk3f67Cw8RGtvog8949hlbOKF0n03X3sjG0LUs+XFQeLGi3F?=
 =?us-ascii?Q?s2BFL99EdsfKBqPvztexr8reRtTcYQK0QcGfhmUcaqCAmSYjYOBtd5hT70SK?=
 =?us-ascii?Q?mwWYDSg8KmtDbPlquaffzLk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bec8af8a-a025-4d80-e066-08dd661ba4e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:51:47.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAXthO8mNjlCEdkih2MtWJrA2RtR3wz8ZwHwcWgOgPMERnuomG4lI9Ym6Agfc4GZXN1OlTKOn/qaWnCufZi+sUmY1sOJK9wQPId84kpN+I64vpNDDkJs9wG8b+uM2Ee5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9007

> From: Stephen Hemminger <stephen@networkplumber.org>=20
> Sent: Monday, March 17, 2025 2:41 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: netdev@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@m=
ojatatu.com; kuba@kernel.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; d=
avem@davemloft.net; edumazet@google.com; horms@kernel.org; andrew+netdev@lu=
nn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shua=
h@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@goo=
gle.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g=
.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.com; mirja.kue=
hlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@c=
omcast.com; vidhi_goel <vidhi_goel@apple.com>; Olga Albisser <olga@albisser=
.org>; Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com>; Bob Briscoe <re=
search@bobbriscoe.net>; Henrik Steen <henrist@henrist.net>
> Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler modul=
e
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sun, 16 Mar 2025 16:39:17 +0100
> chia-yu.chang@nokia-bell-labs.com wrote:
>=20
> > +static int try_get_percentage(int *val, const char *arg, int base) {
> > +     long res;
> > +     char *ptr;
> > +
> > +     if (!arg || !*arg)
> > +             return -1;
> > +     res =3D strtol(arg, &ptr, base);
> > +     if (!ptr || ptr =3D=3D arg || (*ptr && strcmp(ptr, "%")))
> > +             return -1;
> > +     if (res =3D=3D ULONG_MAX && errno =3D=3D ERANGE)
> > +             return -1;
> > +     if (res < 0 || res > 100)
> > +             return -1;
> > +
> > +     *val =3D res;
> > +     return 0;
> > +}
> > +
>=20
> I wonder if dualpi2 and netem could share some code on handling scaled pe=
rcentage values.

Thanks for the feedback, and I would reuse "parse_percent" in tc/tc_util.c =
in the next version.

Since the scaling factor of percentage in netem is to UINT32_MAX, while in =
dualpi2 is between 0 to 100.

