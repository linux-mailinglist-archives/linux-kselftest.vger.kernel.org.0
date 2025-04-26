Return-Path: <linux-kselftest+bounces-31704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42EA9DB7F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346D74A3AF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74CD1DE2B5;
	Sat, 26 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W92ED+/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77310785;
	Sat, 26 Apr 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678960; cv=fail; b=BuCFXq7C6hdVT8DotcPtIzatLx22sH1TyqxIJPYcO9TYl+wKp6z0UTaZf402dcEyApVYBGSTpjVXv+htkTSWRdaVLWknF6G+qGCX3zVSwsDRzBnPBSFh2DwmtVajGerEWHtb+TYlOxmghL7oDJgwC2xEqEyX+kprHCviULZ7tvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678960; c=relaxed/simple;
	bh=JR9KQCfDylN99ZM82iDJEzuDAlAVftJTKA5V4B8agOk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pMmDxUea3BzRhqAPyh+NlRiuf/X6q3ZPlIfuPSaAEBXgiIp6kUhfmZ4cq3JLX1uqzn4YQyn4k7g7nis/lIDYHIxf9Oy6BKLWFlhTl0trvhFp9yR0FdEV3L+OtQ7S7tihy4tZZrRfk455meQpzMx9MEec7AmAiqGk4BH5/MKAiSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W92ED+/q; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcwO2Au5vrb92iCHfJCYSPhka56q0KbYBfaS4c9x5UY4lVVHiMyBmv+U5ehHlcYXELRNtSOppNJYGzILD+bEsT5wlMiSdhqpBD0tFwjWHWB4VRhewRI2cq0ZnDWACGrHFfDW9QvvkaE9jaFpiMAxGDVqVN6oS0nXqqM19swU5Wyzs0gifYmUGkAO7WTrwwQZhiA7m0fRzZZgFxIMWy17rqTwFNRqQKlde667UmSC7v+rOiDMF5JxYCaoiTDFWl0UyT6yZnCI1PNee/BvAzVjYIbbht6DKj3qiugBQREYGKeEXv8osa2LPjJa6+4eaijcJ6dgXvg2nU5ZFfYUHqi+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP+Oe/YTu7W9xgvXGvtGvPyx+sfyhCObn7NYxw+H6iw=;
 b=rdJTx37dbMWf0hVZVPklXXCaKp9NczqnqcozlOWUPVsE1v7X7+zmWoK2FbaimTEtBcHDNpYeBRxFWQjkSM76BdS6xo85wdi2+CbX0iByzmaJp6nDgLi8nOgdGeeoPlrPU+9NOoRH87VKHTaOzWQKvwIoEcg8sUr4eu9oBFR9XFBrtXhLK5FMnyliYdxsETyNtAguIHDHZcemGO3xEpPzm4oT3vYKU2k2ykWUfDlNK0BULy3tbMrmXhY0f38nytALMBJy/pHWYaXcjUUJU/HrNHSSuCbky1u35XoyXqBxRA6tU3ec4yHdUBE/IHQ4+Mc6AGR9EKLPFItpYaWoC6GyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP+Oe/YTu7W9xgvXGvtGvPyx+sfyhCObn7NYxw+H6iw=;
 b=W92ED+/qHHheEXfisjVb42lQFKisBMy/iyK7hL7kwYKzLoU67sSheL76FsEtHV4yZu5HCMpPddQH8pbZ4AdL3OzM5hb9uLP1wdkRTCSYGFYPigtExf896rTe/FA7TmuAJHQ1eHJgnTyfRKMT0JFbvpnXFraG9jAjZ/AW3F54BWUhlFGbr659li/MtsOzk6YARjyjI7TXk5Yfj10PMbMKq9zKxscV5hAbAkh92uNa89fQgoac7KAwqwAAnRDrZod87FQw1NHXTJfcN3ZmTTaXGo8apaKkgYtYvKUdEZLnmsPSmhLb7vOluI4iQBwch8i/NM9jABmHyuu97cQpcjHZsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9019.eurprd04.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 14:49:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 14:49:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Richie Pearn <richard.pearn@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/4] Fix Felix DSA taprio gates after clock jump
Date: Sat, 26 Apr 2025 17:48:54 +0300
Message-ID: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:802:2::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 7692d4b7-ef69-44ef-5612-08dd84d181b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ype95zCgvv5KkmAlhbcyTFPeEQHcizN7pv3gCB2uGurQmOIBPCtXiFIoyZAP?=
 =?us-ascii?Q?jnd+vDMV0XhnYiqfVuhYGP6NkHQmDkFeEzwU/e8YMrq0JjRV0wM/zREIzkRk?=
 =?us-ascii?Q?3ogYIi7HO97VqbCzMHUjEjVz9uoZJZrtad03gVCjgNgaKCLox5OHHP1Tg6fR?=
 =?us-ascii?Q?XjJ3XgHM7dYoqRZZ1dn2ud2VQ5rRXT+DJzAj7cn0xS38HvLJynowd1To/cXg?=
 =?us-ascii?Q?DJJiKRzZDq/QjJ5IxqakJszJwdjmHOvSPYwS708+LyFk7mzlrKhTLKnhGcmW?=
 =?us-ascii?Q?Zf1/07udBhozVUBTc11/zRxUGpsbJEQUha9xOALSXVmTYuAIa1VRTMZOrDEG?=
 =?us-ascii?Q?2qSXMbH2RVWyZ90/+afeelEuhp60Md8EKzKvicQnjiV4n+ZPHNJxo/YGab+P?=
 =?us-ascii?Q?MulkgKxjAVhAb7+Ydtwe4Jrm3w2YRRBH9eX+rK8TnMfgdzZx1YVY7ysP+UXG?=
 =?us-ascii?Q?rKPxM2qMCUYorNRfwDm7UN2eTuLvAs/zkX3Jkb1V/6JqupLpyRHwh50aUQv1?=
 =?us-ascii?Q?ziDFTzPejYpRwbd3kATkQ+qXEI8oJwoWqpwIs9AmE+Dk7fkmpoRdlObloYvi?=
 =?us-ascii?Q?f/vvHqwWlkalTnif6ePcPrONHlGkRQDCCdVJ1wG2Z57cdKX57HZFptsojTFF?=
 =?us-ascii?Q?uvxFNxEDyFsM0qXzY4XGNUJkM4rP1qyD7PTeRW+8G0sXl+7npT6mKPdFBbqR?=
 =?us-ascii?Q?CVOT5rFmeuzM+5c57z8MvRfEEyyRu11gLQbmOFn6KB2DSZy+lyah/FOWORe+?=
 =?us-ascii?Q?m8nZKl0KsknW8TPH2S7pt+3PPm6QqeMbofAkaPvF9S0et1SGFV0F0JDgnexI?=
 =?us-ascii?Q?j9tZT8R7/1ePhcmoKJxsY2rPerqg+d2GPH+JLJaTiC104qLgE7432NWfbuUa?=
 =?us-ascii?Q?SwCbcQWXoyPRJn5x++3RJ08XVXPAq0HshzFPIzhszdK6powswz6VkrVh0M0H?=
 =?us-ascii?Q?QgnXc9+lIdVAbhs93xF+VV3ETji6rsjyij5QrqV0B3zjJLd5rSozZao/XIIp?=
 =?us-ascii?Q?dM6Oe46swkJ69EuGxZjsiiUaZepQCKPWeMzIYw8tK9Q7UGHN2uaDo7836jzs?=
 =?us-ascii?Q?DlLA2dfDQcAc9FR7FoWVDZ11JX0PzAI5Vb9/OrKQ4iTvLNSW5QBLPMn+oqWT?=
 =?us-ascii?Q?XKeQgKiSVNz05Fmq7Cl0AeztxhLDw4gFHEiiAs+IYEJRENN37Wji19JHpfnu?=
 =?us-ascii?Q?E6BtJ5Z/Ih8LWAX/OnqYlMU0nBZH3pHSQUH9CU1s4fEgAAoVQSJokaNS9ae+?=
 =?us-ascii?Q?kSp8UPVOZBghzjmn5N47w4SVsaKbpfPQgxVxEJ8ZRexhVWE4so6rkDqE5i92?=
 =?us-ascii?Q?PJVIOsXn5N5qfpbNpznJ7hra8aTRJmlpnrn+y1MblB67mYAKDb6CNQJvu6WP?=
 =?us-ascii?Q?Zf6VY7SqNYWRZZ5HQ0PLec70b8Uc3Zw+qnP16Rb0L8Nrx7qGaYWzwDKNO3aS?=
 =?us-ascii?Q?zXGOh29aE4eQ7CSak3PWzD0R8kRsTiT73OjJJALHvnJmW5Xr4RV2Z9FHMZlg?=
 =?us-ascii?Q?4vXUtJX96uEkdMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bzv26m8VJOnUJWCIBWrkp/yt6gvLkdIUiZJkpwN3bDYBC1wUKJa0p1LQBV7p?=
 =?us-ascii?Q?2bNgNsb/Iv95pw7uMcBOHmUipJKiaYZ8tc57FYEvy5wAFEDnle9VzgdoxJ6x?=
 =?us-ascii?Q?6GmZumGvT7GvoLOk8XDAItQkBRG3QASfXHBWofNDhjFnNKSmzI+MXui7G02R?=
 =?us-ascii?Q?a2uRALmY05R1UKJtxyKS/9p76DjZeGcnBU4PlI6LjXwmnx+XJIARyccVrBN5?=
 =?us-ascii?Q?tujoi946safYkbNbal/Pndrrh5yByizMtRuOtozJcklOx3t9aubg/etQZZX0?=
 =?us-ascii?Q?qbCaoIXrDgHEJT8b2n+ydsIw7eE95ezvtlZcWgqFHf+ct7/bBQw3MN1a/348?=
 =?us-ascii?Q?9DO+CiwVWrX1F1zHe75Mdf3f8LOUi4+8RHnSWTtn4WEHpacFggCbx0WeiOEm?=
 =?us-ascii?Q?p79j7OqJjJ6FNstIvQwEiuZVuUuLvl1go1GgHLvHR7zNnOMKcRRLelFaZI4S?=
 =?us-ascii?Q?S3zCM8Di/irjQNbNrHcnMBWoAqPoeeJXGgEnEgn5ZGA22DE/6bIMG3dEoN1C?=
 =?us-ascii?Q?5+Kwfx4skFhRXAiT07IcawCN2VjwJg+P8uHy2i9k5HkmCWKJQe31/9vAb2IW?=
 =?us-ascii?Q?+72phJnBSSz8JhGSW3IvgonhIngKCvtuPqsDbAhhaS47z4naRkfUash5KoQR?=
 =?us-ascii?Q?2adsJ8cbuo8sPiFYkUDspAAkXsoRAmIIpZprTv3xrxSc9Bs62hGIpQBkGCNp?=
 =?us-ascii?Q?9zHmDTnMfUTtH1WRaif5dGs6DcsnrEN3W0tO50bcGRbhqHoInZGz1B2tkArn?=
 =?us-ascii?Q?GRY+vgbtjg2onHuAYZsJkIzqrNHUyits6EQTVTJ0HW+r3nFMLg+8r6aX0A3P?=
 =?us-ascii?Q?q2MWwScUoOo+0gIe4HnvjmefsoTZDiHqQnaFm3bov2Lc3rtno4jFllpgwJD/?=
 =?us-ascii?Q?xN0rIYcwskhGFlxDcrmRWkC44tkp4rlbu7XHqvq/NUPQJpglP22QYcrmfFho?=
 =?us-ascii?Q?HYSOttSeN+vLyaX5OT6w/38tdE7BW2Czxeyn72a/KtTZDWFSYfFTiyYDUpXo?=
 =?us-ascii?Q?2s4BJkdAWe02suNpdPQdyvCsyRxkqScZa8b5eJYlwYxq2caGHxIklx5bJ7AR?=
 =?us-ascii?Q?1WsVCZBJQEvnREx0oV5NtPeCdnlzYFea+mX47AXoqcSCJu+L3GlYzgkkz/Id?=
 =?us-ascii?Q?Yblg/NNGVxxuraGtMYlzOusVcksCKJg9biiE7W114egHHNwjCDBNBnzavQUw?=
 =?us-ascii?Q?FKHlMt+xEAC5dGcobOJgJ7WRLW/KnQ9QRADQxm85VyNmpG5CeXfwbochA8XX?=
 =?us-ascii?Q?2t4jSc5kZikRUTMLOzqqzCkzQYEYzHXAbhtjXvRtXo7i98xSnZmcdoI4SgVr?=
 =?us-ascii?Q?iqGx7Fpx44iUMRkOk2w8VoMCfyc71mfS7e0fGP/XXjhNdf+sScgZTA1qYFox?=
 =?us-ascii?Q?05omSj8/lW7552FKdpRVKLZAEucNhl0Zt8QRnyOQ73l1VvvIFN1Ar4D3q3Fb?=
 =?us-ascii?Q?x78F1AqdJe1+J17X96bDgMjFZZCS7WM7WqkmTN6zY1l3fzmzgXU9ZaWtWj3+?=
 =?us-ascii?Q?y1bRaKjqKwwq636DDoHd5uyZK/Ykl0x94RHYQGjWNosTh6SBW45EfgZ8o9UB?=
 =?us-ascii?Q?aiDW8ODDnHwA5/OZ02F2AQBFGq6kAEL4xXssDnjKP+veQtfOa9mzMguqCcTc?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7692d4b7-ef69-44ef-5612-08dd84d181b5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 14:49:11.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjaDDa3xEXgMeo9fLZWsfzltqPFchlLdAbbPVQ0tQhpX9gGbC7UVd29PI5BExmGDWNfkKYC1Sh7WknauPtjENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9019

Richie Pearn presented a reproducible situation where traffic would get
blocked on the NXP LS1028A switch if a certain taprio schedule was
applied, and stepping the PTP clock would take place. The latter event
is an expected initial occurrence, but also at runtime, for example when
transitioning from one grandmaster to another.

The issue is completely described in patch 1/4, which also contains
the fix, but it has left me with some doubts regarding the need for
vsc9959_tas_clock_adjust() in general.

In order to prove to myself that vsc9959_tas_clock_adjust() is needed in
general, I have written a selftest for the tc-taprio data path in patch
4/4. On the LS1028A, we can clearly see the following failures without
that function:

INFO: Forcing a backward clock jump
TEST: ping                                                          [FAIL]
INFO: Setting up taprio after PTP
TEST: In band with gate                                             [FAIL]
        Reception of 100 packets failed
TEST: Out of band with gate                                         [FAIL]
        Reception of 100 packets failed

As for testing my fix from patch 1/4, that was quite a bit more complex
to do automatically. In fact, I couldn't find any other schedule that
would fail to be updated by vsc9959_tas_clock_adjust() as cleanly as
the schedule from Richie, so I've added that specific schedule as the
test_clock_jump_backward() test.

The test ordering is also (unfortunately) very strategic. Running the
selftest to the end dirties the GCL RAM, and when running
test_clock_jump_backward() once again, the GCL entries won't be all
zeroes as they were the first time around. They will contain bits and
pieces of old schedules, making it very challenging to make it fail.

Thus, test_clock_jump_backward() is the first in the test suite, and
without patch 1/4, it is only supposed to fail the _first_ time when
running after a clean boot.

Vladimir Oltean (4):
  net: dsa: felix: fix broken taprio gate states after clock jump
  selftests: net: tsn_lib: create common helper for counting received
    packets
  selftests: net: tsn_lib: add window_size argument to isochron_do()
  selftests: net: tc_taprio: new test

 drivers/net/dsa/ocelot/felix_vsc9959.c        |   5 +-
 .../selftests/drivers/net/dsa/tc_taprio.sh    |   1 +
 .../selftests/drivers/net/ocelot/psfp.sh      |   8 +-
 .../selftests/net/forwarding/tc_taprio.sh     | 421 ++++++++++++++++++
 .../selftests/net/forwarding/tsn_lib.sh       |  26 ++
 5 files changed, 454 insertions(+), 7 deletions(-)
 create mode 120000 tools/testing/selftests/drivers/net/dsa/tc_taprio.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_taprio.sh

-- 
2.43.0


