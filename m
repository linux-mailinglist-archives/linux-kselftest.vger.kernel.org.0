Return-Path: <linux-kselftest+bounces-49294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE6D396D5
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B593063F43
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857C34EF07;
	Sun, 18 Jan 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H2hjcK/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021096.outbound.protection.outlook.com [52.101.125.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962334EEEA;
	Sun, 18 Jan 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744555; cv=fail; b=rNFUwwkgUX+GpFCz8DeHeemMQkSjA6DaGoXBn4b7ZGEWTk+TUPvX8cV6nX1IQrztXGY/I0id91U85FXXmnF5GCFOot0FWKNUSBfAMZHS1C11EsONbr5Fd+Onbo22Z8Xh+OSfUgKrnVEr3qL41lr2HbU3qxGZFmvNCIUXY2moyKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744555; c=relaxed/simple;
	bh=7y01TviDYCFP/OTuFTh5SMbzmrAUj1Yo4q84GVIFXEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i97fN+5mnL5nDOB/vyrN/TillBm4L0pk7D82V+Ehls/V9rZ8DXnEIKaUEuoe3EGow72ncvo/Sic+byhESJMnirQuW/oAN0nQtcVJrMSBb3VirFr2ZU1MpKfls1K8zXK3pVOho+Z8kMN5GnXjH9X8KcbkZA5L+xQOR4m5l7blbYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H2hjcK/Z; arc=fail smtp.client-ip=52.101.125.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7WW0xAJWa6ygS/Eg3sHkvMOytcgkCXaOOXVXKsmk29tFf1T4sH7MsKHh6IePMYNrsj7I/03Xwan7dYv3KL02E9GMn12VUlNgqoakZPeBPQhHyCC35xBdzE9yYRXYgfDEHRDWfdRoYALnWG+5p/WDeF1cz5xygJVjmefqTrSqs9gqHRtNEuv5nUFEmmxGpastyyr9kUzL9GkYb33lZZKdmINkB+LWnCaD98X9BclmUnJaZKbQWp0Lp5rsLmEOqQp4mJGaWNcK8UYrFCepg1lczjEZhnO505ddwmadmL0DNov51W/uRlJEh42y57uAs8orbcpEUlFWaNPi5HZ077QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SZni+m8Up+trZkWVtYU2nXw/H2fvWLTQUnEPIEJoK4=;
 b=icTwZVwnJZIhopqWYFmEgLATQY5jto08X3TWuRhGf4ZUN1rrognFeEUwCFcbK8SpeJjBFdjcSRg4Ro826fsNmyig9fbYq01V+UhNitx8vhWM051tIvhKO6132LiC29wEztg23nLpZLzHLrdnLQKpB+NRDkPuN7oyRM2nhUNMgtApYmGIhT8bicBY9ojFTF9kx9QwIgcP/WkyB34crZ3qYz15QarJ169MYHFpFYyhgCzTBeHWlpuDAbkrKfYnTEmOTjiqERUL9XnKOM9+QgxHxVSI8YgCv0W2ZYQtVk+884M1BWgT58gHka8EiK5iMkJ+qtV+2TvgZtteGvOCGgQdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SZni+m8Up+trZkWVtYU2nXw/H2fvWLTQUnEPIEJoK4=;
 b=H2hjcK/Z6IFVVfKcePn/BM0rHXFIY/rjHMIWqYTjwvI0IyMXN9BgYSzZEvLO/aQERPIxI2cfW+/DRHP/3LBRghVjOoeToLYpiecslume1BmvFj0U0r/MD3XkxXvUOZRdYjilcutxsem+moEB6x+PYVEtDa8MiIULn7XtevY9bx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:16 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	cassel@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	robh@kernel.org,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: [RFC PATCH v4 29/38] iommu: ipmmu-vmsa: Add support for reserved regions
Date: Sun, 18 Jan 2026 22:54:31 +0900
Message-ID: <20260118135440.1958279-30-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcc252a-52a2-4e59-78de-08de56993573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w23mPTbalfR4cPXaI+g+pWknc29rmsAZM5xHRF1eLJsUtrIYXJyXaJBlpf73?=
 =?us-ascii?Q?iv4ls1AIqF3iYpVqJ6WHVUuKwMt3t8gJxjWmXpPBzKtWfUCKdwaiJCJJwArF?=
 =?us-ascii?Q?nH1oQo7cZAC8q/BW26qjw2AaTZgtSz3Gal8hcFNbqR0p81Lvxe77HChHSaHB?=
 =?us-ascii?Q?H9hCY7L27iJ03k5M20ljo1YhlrKvnurlFDN7QO9FXFTxf+JooqY+pcaHXES4?=
 =?us-ascii?Q?8BBpr1h87qtT+aESXQZHyTjziTyZIRIHyUkaYvyRTcsvJr0FeQmc30aLKDv2?=
 =?us-ascii?Q?A75Xoo8ulbUS3m06bFE7FvU9ABYlaxQKjpkn+dJnXr6XI/TkDxWIGrNr8NIp?=
 =?us-ascii?Q?7ClnPu6RCEgBkzEGHYmb15e6uahxhV53b5DXbwThZKcp9ZRGIqQ2JHmoIehG?=
 =?us-ascii?Q?cOInmfEce3kPtfVDTkVe63leJ//vJ9kVtxdW4Q62S99aSWo2TBkcPDA7FiP5?=
 =?us-ascii?Q?3749yxoNfqbPHC91r+M9ERt477VPVoNMwUBiGFzlSRf4q87LzFTGqIE01tqe?=
 =?us-ascii?Q?fhlqLLAM8J1A+yRrsjiQZ0Bk+onwVcpkUj7S7htCs8+yUL4Yqz3W/0nQ2wAi?=
 =?us-ascii?Q?qIQN6pqkH8rXQHfF97qoYZT8Kz6fhyFhiCQjxiz5WeNEBmrbuMkTes5oLBoR?=
 =?us-ascii?Q?pqEIA0X2WBlZHgLdFzX1JZR7/TYPY7b2EbRpOEshTHm+scmTEIgV+IfQRNcF?=
 =?us-ascii?Q?WPKDxuILa4Z93k9TuCaMOnXBXGNMdyoP1OE2GcMKe6aFfaZL/RYIWAUjOJ1g?=
 =?us-ascii?Q?gCzZAPmBdVQp78Yx11hwsbixEs+kGSBDXdNfw5n8Aj3ymi3+7eIIJE0BZzw6?=
 =?us-ascii?Q?x1Qqy9IxjInGS4BeUEVdiXaQ6gT8PWwZ4GPqA/Ol468kYUNvJOHywNw8yuD3?=
 =?us-ascii?Q?ze6k1tAC4gtWr7m2ENXAfDit+qoV3U+096LMeK99QgYFFqfExa1PNuuw+uWa?=
 =?us-ascii?Q?ou5pFg28PZqfAXVKYuasxb8KDI38ybOHcZbkXq0hLwWG8qz+uSVuRJk5ouV0?=
 =?us-ascii?Q?V7TJ7UYeXvTpNReahp+/O0+8rFLycBW6xS+UtdPS3uodnXT3mxVdUAuqml4S?=
 =?us-ascii?Q?65pP+JmWsicPUxGcRal2c+9+hjDYZhsbBkNXy+chLGaIG3K54BgJpesuHJeu?=
 =?us-ascii?Q?AfoawbTw7kjJ+xuEtkMFIrKFyTCTe3qOSgeA8HCpHXF4S2R76XMh9fMUPJU+?=
 =?us-ascii?Q?FnJ8GnHuq1iq+mevmmhSKgnz/Z2eRnw5uMgQ2V8/l+IZZiYqYnd9ZZI8cTvZ?=
 =?us-ascii?Q?FvDse30C8JIhEhQAVxCQ9RBzXbBMp10et8zVLSjY16+1EyTPSPlaaIvk8RVs?=
 =?us-ascii?Q?cdrND3TXNFJzlwbaWoiq0AdosqosDSPrLrceCziMsA0mYHrO9XdUrfafMlSq?=
 =?us-ascii?Q?xccBZhX7ORWUYTNP+PD2uBFZZFbJRelVX0M4oURcwrr87Xhjh7IovOgHVaKz?=
 =?us-ascii?Q?wqtQIfe+jo/uIrQeaqCvbizF6zyufwgCGH+IIOAMJY7ko6q86kyb69u9GOin?=
 =?us-ascii?Q?sVzRrYvcFGG1VupVQI8l6JKHxa7eaLqst8MJTfKr/oeJls07j8mwi4ekaZbx?=
 =?us-ascii?Q?Xulz4MSNphfwTVRCxKjHAaX8Y8fmiX+Gw5V5iS/sUgBfGvk6r9+ApzpzFSqf?=
 =?us-ascii?Q?CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxge6SyLlGOXtcv0Otc1+2bozzPBZmfGD1Nni8wrj+m7aNn645F5fLI65cfd?=
 =?us-ascii?Q?/3gyy3lq+L72ZgEIGdRmkEoQL0z5LVhPQhWYkmCmTLLSoeATs/liMX1RGSPG?=
 =?us-ascii?Q?PgAJVNIsUGWzW1k/vpsc46/XcWFs7fSIjXj/PFCAICyea6yhF3+HKadKjAw1?=
 =?us-ascii?Q?hzheTw39gZy7pSKKBJI5EBdwhDlsUMHTtymT5fs+3Eqn4tJiPutqp/JuaVIU?=
 =?us-ascii?Q?rxRLJ/gIZdwzOzGy1uWuPYknbFK8NBu2Oh9H7UsHLWR4ygsuycjPbY7ekxfL?=
 =?us-ascii?Q?Lxuf1+3T/HR6RA3TMeJ15Jdt1jBNwsX9uthT5znmgotKzKjtFQDH13PfBFhX?=
 =?us-ascii?Q?FDS/7zw+aB9aDFbZCPA2ZdZBlBWI+IryL+V2oKEwYwquV7xgdOB3hBJ5xLLF?=
 =?us-ascii?Q?BzrHBgPeRuPvPbFU16s+XHSdD0UYx865kEaDLi/LXLoLu3+Ca0Rurlr1h4VI?=
 =?us-ascii?Q?JXr56kKWV0Fwv3jtcOi3vUI2ZG1i7mXwCLBLOA3YLY4QppFDfZ8jGtyXm3w/?=
 =?us-ascii?Q?cvJB9jXYiLxzwqIzUJWqqz1SHedKVFA1kr+yQoKkqBzhnwyRnVoPrabKDbRh?=
 =?us-ascii?Q?mCnam9d7dLqR/xrhbyA6U6kQtLI0AkwIy3+6VwNaXGBDTK8kh22k+xdT0lXC?=
 =?us-ascii?Q?ZdS7+193tHvEgKBU1B7PTos8i8zWImzmGAfxb22DjCoNm2fMdP02bX8Pqa2e?=
 =?us-ascii?Q?65Ed11prEf4dJCShRoAyiIvj1KWT4k4mN2tKalbqGIQEHv+qW5Xu0G68CkTs?=
 =?us-ascii?Q?oyZIgx6r+q5XLZ37AjAQ85X5WSQ/zJKsQAKdSMiJWWeWcjjGct1eZRv9yDzj?=
 =?us-ascii?Q?JjTZpHRMW+SuH/4FPqbvxY2g25r9bpAbCZOLQgOGu/OEACH0HET07FHjm4+q?=
 =?us-ascii?Q?a/bUIXAgmtW/AzZLAr9TPiAAydglwufyE6yPtl2kk/mKk46R/2dsumk04g1t?=
 =?us-ascii?Q?3jV22w53XGPChOLG/bm91yFZXvbrGkKuPLbzfGGHvzhgC+3CauOLJlC9jXdo?=
 =?us-ascii?Q?6lkMtS5QuHgR9T8ZjTxHOy64zlwoBFiGMhFDQYGbaaIgmK1itNA2o2rvTIJL?=
 =?us-ascii?Q?E0cbDXM5i4pSFtqCrUHPSQlIS1SY0RKyeqbmrlR0Zou/6Bf5pnlDDwovUibJ?=
 =?us-ascii?Q?yVpyViB6kLHPo+nEZYzk5DAWMdPWPaelarVq3ci5Cwtdk4Kp7NgVdpc0jVUX?=
 =?us-ascii?Q?6YtBUp7e1EpjpYOiPPA69fZVGRCdkmFDglDWDWfwBsP/vKkilQZNKzy39+z2?=
 =?us-ascii?Q?im7hXb6hwqdWL3YssXOE2ZhJPgMSBPkt6/OC7Gwabg8BParN2NKryZMUHhe+?=
 =?us-ascii?Q?cDP7K9H+j8J7E+Mt8GTUy6JBGSUmXPgR53jeNh9eJ6PhSFJJzjOURY066lQn?=
 =?us-ascii?Q?cvSbpWhZT5hs6+1WAHbO7YMbEtMG8uhRIEZOaDE+sRvjUL9vB6V8wYOlM8qg?=
 =?us-ascii?Q?KTLei2TRDkdzM4OHqSM+3YxjdYYqYO+UnYq6aW7Eg09qtRahOobLJROohngP?=
 =?us-ascii?Q?KGwnrVLJqfvFCXbq3sBl9VtyOYhH/MGu3cTT5+SHzn+N04lohppYhVpu9zXA?=
 =?us-ascii?Q?Z8bB3SbZvvC6ryc/z6Yu8mmKjCnjn2Im/hzwuZARTi9wKxmYl96S3iWhGIPj?=
 =?us-ascii?Q?nj0JHsyrQJCpsYCLcQeWbz8RHQ+rj5Gu8WuNkN2m1o830MsptPlqFW24hhCb?=
 =?us-ascii?Q?Q/WKhLseVMKo4+l2N70VzDc9IlDGpoJ+n59E6AGIODdGHGqjGOxfuNuY/rDu?=
 =?us-ascii?Q?DTtG97BCAYoNSZicda0t8S8hdYx5wLaJvl5nYxPsl3TPClsnYwIU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc252a-52a2-4e59-78de-08de56993573
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:16.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cocNALiHSXtBDyNiBeCA2OdQ+9jxihsm21H58BV1jgi40OTJb3OsWOhXGGc/zMEd/kiGj8CAQ2NLLaBTbhG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Add support for reserved regions using iommu_dma_get_resv_regions().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 724d67ad5ef2..4a89d95db0f8 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
+#include "dma-iommu.h"
+
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
 #else
@@ -888,6 +890,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.of_xlate = ipmmu_of_xlate,
+	.get_resv_regions = iommu_dma_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
-- 
2.51.0


