Return-Path: <linux-kselftest+bounces-8131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF1A8A6AAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5BBB20DA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3312C48E;
	Tue, 16 Apr 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="p4PwFbej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43712C465;
	Tue, 16 Apr 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269923; cv=fail; b=S8ZpXATMTV3vKsWhsakg7/fFcTqOKSCt1jjv7BfgQeuUAMQdcUlx6nAnxkJYZsfs1bNIuyzqE6SpbXtiQy57abj+f+1VwfpzQZoEf1aw3/G8Ah2gw2mNgM9UCzNoBpkVKXxpkvMS8xtAuiWmE6+/uDG5xi2SdipxCNXc7I/v+WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269923; c=relaxed/simple;
	bh=GPkE/SJb68lyAgEHhSekPwGVMWfpx+zYeTihz+61/SI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wi0iY1UDwvAmZQP7tQ9M+5aHiDUJTSJldqzmOS9siNyWWpccrVQ8+KriLg/norPqMG/WsdxuaI48HVW+S9FGtFh9fZZHC5jHrsdKSTCT+Otf3onc9vaWcQGgNguSYkZDA/w2Xh5ol8MeExu+cFXPj0P/v4/uQhYu1U0O0sDEcqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=p4PwFbej; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EftWwHmEqjdO3t2XdYZvCkwY6Xz9hs/dQ2vY/QZ4qxE/2SYyWrRXPJ1IMCDVS6ARIOfJDKrEG+mbDNgMc7NUFmBtfowvjpzbs7rhLoA6xWdk4WyPIz0nKmDRSnKyZqC3UvbpX3wWCmTUkw1MVf+cGDl3SDVJZMKnUMijbOODSCjRM7cSTyON1I+6ZLt4VWNz/XaEa/CJ7pS2qUhCITMGh58SIFE+sEojIzmSdly2urd5CFBSr+wnaDsi7BYTwm8yjn0yV+Alg3J1o4bQw8xMJNnM9ojl65qdmoBsAETrB/qe8awVQYlfejA1GboncIKMyGOR1JYCYsg1aYFyWZHMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huSSah7O2ejmjagcW3rxMebHsAfaYtV6Nh3iQGgc6JE=;
 b=gLoDJODcxnFoEpp7o90hb6GwaWBOyszRV8tKk4HxicgQmU9gUgm6bBJRvF9jW2tJ0kaFo9syjFIaWb+MaNQbfYMf38zRFnxn3Q9NH04pdvYmauszFIjBu88W5XHi43HtVgzSzQPrHXzw6Xc/odmUhsK/F69nC9+FiIcSMXtJCHw0Tw8RaWjLbCUaKB9rINixLDzYIKyQAPY+FJ83AtOFPy7yMoGHbzg3wJmjaSuge3KxyoRk1DEHSXHBD9pw5wvl66wSSnQDrpi+EWAB7RWnHeGWr6u/+1BzJyp1wjiu+rL0ijaT68YO11cJNjeVLjrdyO/dZtq6BR3XmOYLrHPw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huSSah7O2ejmjagcW3rxMebHsAfaYtV6Nh3iQGgc6JE=;
 b=p4PwFbej46OU1czt4Ns1c8U2/v8Q0hANU6FMKkr283ASMsG7dvgSjZwYPa9PvK4rMgoRqXbFoGI7Hq52iZJM+rIDt3hXE7E1Sd4WKXR8E3WniGxPyOPgM+qgIaUKZcQ6ca3nNa28CPgT5ZPRQLj68hZ7hNhtFgFGw2MU9TcfBXHkOpXFe5yvGrEMkbIQESRHcqj6Zygo0wYLyV4p1HozLF37/lJ5DyWF3R3XhJDLAzAUC0sObelIe5I/JtPePo32RH9kHRyrBHassO97M4EiklSTtb04cjTVc0exI9k7+wGjaJTwOLs8iSDauZ0PnJorbrSPX2A5aXXwu7AE9DTvkA==
Received: from DUZP191CA0062.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::25)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:37 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::34) by DUZP191CA0062.outlook.office365.com
 (2603:10a6:10:4fa::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 12:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:18:37 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 16 Apr 2024 12:18:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:24 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:18:24 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 2/5] power: supply: core: Add POWER_SUPPLY_TECHNOLOGY_CAPACITOR
Date: Tue, 16 Apr 2024 14:18:15 +0200
Message-ID: <20240416121818.543896-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416121818.543896-1-mike.looijmans@topic.nl>
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.846cb2ab-fcec-478e-9752-6c7d0b6a347c@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7230:EE_|DU6PEPF0000A7E0:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 99117eea-c7f9-4182-67bd-08dc5e0f57e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 dgcVdLfinpNWs1sA3GCkU88kefiPU39E630OZoGqilCTqdhhz8a4Sj8e2q8b2J7SQDwC63CIJlyo/SkU+/Q3r9BJkj/mwfpi46f4A3CHPhTGHwuD7TG+4ikRq4ZuJd4nFKc1tBa6nd/uYjfauhv/ce6JI5oIVFWe3qnJzs3kCbWaGVtZF8AH/G+PVhh/LutV1IiGetmgAGxArygvhug1YsmvdCHMjPDfntyypZizy+voJ6LBTJyA2ZJXFkCP0BFnFrbyV5CpxNM3QmdKYhgZRB5w77msSusiAUnwx99UMmW0XMFNlBGo9bJrjdPfxGWL6v0duYTC8/lj1LGKG2FI+CQlDFEwUD5uLVzdMLPrULLIctSz9ySZEMVenwUlQ2YGMPwtQujU8BTCzO8+tNAl4B9Gy0lyJPFrTMqwrLto/rGMqJpWByXyizixMY4Maw43YvkhCC7pmaCjPt4fzA/E7rl6m1v7M4f1282UGoOp+1tqGE03mgvs8TTOBa/bk7b/cZTtkOkUeBjkQ+WRaExpV0KTY/WRhWYMSKrJdfbi0mtSiZplpYmXyR09k9SmYfcG3jIi9q8Jpql+eQwk0z+3P3Np8NJtuahCPSdosPVd6QZp1VUnITzVsh9uwT1kjjAXXorhKQWZSLSq2Z9uO3URb4Kq0cBNSyCl24/zU8gQXG0hs8RR0e/jf7ZLDectDgxfrLRI2c1qsYxeMnEgrkyNU4QK3ZrR11qwF4XmtEt2neo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-CodeTwo-MessageID: 82f740c8-9228-48ca-96e8-58ee7cc842a9.20240416121832@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3f097a2b-5709-4376-536a-08dc5e0f5063
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1fO6FbyFRKV2FymO3q50+SGRLrrMNrY40J6L2ZjiIDbAg/Pp4SNY2PnZ/GEtt+GgN+7MwZVLwKmQsRi8RnfF01fT5+PJBkwPR/UiSE5c4nRFY1czrSvj1zz9DhPbLRK9OHFviWo+sXREC2CB6IjRcvL+AjQdMxKeJ8AN1Wd3tVehqjWwlRkF2enazfJcB2ZdN+t4coX95twmHbpoqnfv0LBA/wZzK2A52DsQAQX4YZb+TPe5GQjvy/4croH17o4y5N8hfO/rlaQrM//7E00FKClRCAEDSoVNm5GWWYlE74rVAuQB7bTDYJAnCRNvy4NgsbsMY3VVH1OmTLWjekseJPPXJvfGVp8Hs09psYkmCcgJtoKt0kvALYRsNwb5CnC02h+UHTEwt7Y4dsHeIboJqBImHXEu+r1GnRnFB8KCX4AE8D6/rxCIRQecUOIRmORRIdt7rAvD35Ahfbk9LpGlQtb9D+p9juGgjs1s9Uwwn6lN8Y54CzrlgpGbhZm25DHCycV2laN9gOEArM1wpOLpOS3hRdNgBM1swkpZEiKv1ii/MxzsRdX3ASHL+xc7RrfbBj/gnWSAWOYFbkDHZnwEwayn6KxFz9MF77OP4ylmMIteDpf6fbdJD/qFgo13rxJeTnf8u2oSnI6dGDUNynla02sL6Dod6gOj3v9o0lIusySaIvpmBSdb3iFmbIWMxsg997TjbAWIzKHPNu8Sh+3pnw==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:18:37.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99117eea-c7f9-4182-67bd-08dc5e0f57e4
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

Another technology to store energy is a (super)capacitor.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

(no changes since v1)

 Documentation/ABI/testing/sysfs-class-power                     | 2 +-
 drivers/power/supply/power_supply_core.c                        | 2 ++
 drivers/power/supply/power_supply_sysfs.c                       | 1 +
 include/linux/power_supply.h                                    | 1 +
 .../selftests/power_supply/test_power_supply_properties.sh      | 2 +-
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/AB=
I/testing/sysfs-class-power
index 7c81f0a25a48..1f6a04a17c81 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -488,7 +488,7 @@ Description:
=20
 		Valid values:
 			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
-			      "NiCd", "LiMn"
+			      "NiCd", "LiMn", "Capacitor"
=20
=20
 What:		/sys/class/power_supply/<supply_name>/voltage_avg,
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index fefe938c9342..6d1327e16ff6 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -686,6 +686,8 @@ int power_supply_get_battery_info(struct power_supply *=
psy,
 			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiFe;
 		else if (!strcmp("lithium-ion-manganese-oxide", value))
 			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn;
+		else if (!strcmp("capacitor", value))
+			info->technology =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR;
 		else
 			dev_warn(&psy->dev, "%s unknown battery type\n", value);
 	}
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supp=
ly/power_supply_sysfs.c
index 0d2c3724d0bc..9d8540ce1f7e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -119,6 +119,7 @@ static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[=
] =3D {
 	[POWER_SUPPLY_TECHNOLOGY_LiFe]		=3D "LiFe",
 	[POWER_SUPPLY_TECHNOLOGY_NiCd]		=3D "NiCd",
 	[POWER_SUPPLY_TECHNOLOGY_LiMn]		=3D "LiMn",
+	[POWER_SUPPLY_TECHNOLOGY_CAPACITOR]	=3D "Capacitor",
 };
=20
 static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] =3D {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8e5705a56b85..af5a4e700881 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -78,6 +78,7 @@ enum {
 	POWER_SUPPLY_TECHNOLOGY_LiFe,
 	POWER_SUPPLY_TECHNOLOGY_NiCd,
 	POWER_SUPPLY_TECHNOLOGY_LiMn,
+	POWER_SUPPLY_TECHNOLOGY_CAPACITOR,
 };
=20
 enum {
diff --git a/tools/testing/selftests/power_supply/test_power_supply_propert=
ies.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.=
sh
index df272dfe1d2a..75f801eb86af 100755
--- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -74,7 +74,7 @@ for DEVNAME in $supplies; do
 	test_sysfs_prop_optional model_name
 	test_sysfs_prop_optional manufacturer
 	test_sysfs_prop_optional serial_number
-	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-po=
ly","LiFe","NiCd","LiMn"
+	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-po=
ly","LiFe","NiCd","LiMn","Capacitor"
=20
 	test_sysfs_prop_optional cycle_count
=20
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

