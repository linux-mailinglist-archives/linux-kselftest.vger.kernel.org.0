Return-Path: <linux-kselftest+bounces-49291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537CD3968A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E0A30D2D98
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384434E76E;
	Sun, 18 Jan 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X1WehsN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F346AE6;
	Sun, 18 Jan 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744552; cv=fail; b=ZcUSj77oj+rurU9SdBy+h6zqQiWmGyoeL09BAhSvMnZ688fRGE40MjlK8TS32CJcKpinamcDrrzPNqokXlgOQceH6Gp0/xGGCbcTiypOXeIRkdY3T+piZJNOp2Xq9XRrc2fLKM6mVgiYeXvjWF5AYNM4ARUzqKUEwWfn2tGwjxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744552; c=relaxed/simple;
	bh=vT0E8cAjiB+LEJn2fS7EdWIpe+HrGZfIR0fm4K1iy1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dx9RqBEI54YroTWaUOsOaafM79b7pBiOvACpYTczTVq/VLX0+U3NsSD3L52i87lL0VZw88LrNP9r7HcXZ9wN4Ofq0XYXetroFgWepELtRQbu21oa15UqHT6pNmAUWorr60IROvzjRmeF5kC3p+L1cXMgpJZTaThk1Umk3JbBZeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X1WehsN4; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAek6w06k45Ij2VjhOciVvJCD57n3OpWyD4/GBtRn8Ypy2okBj3HgLukde6f3ljFPk96JA4CJ8AJHjVeBXIi6KAPwLF/M00d8OPTBvRCbbDFKjGrCCjddc+JTycOwQfBZaAND8Kp0unT/E0ySud21uSzfCalKOlP4iKoWN8QRp7zJR6/EgLGmwAl9JSBel+R5G3QHzBTvJD61L6Ss75YshmRS//Tm8iUfX07riINmPgUdnZEeCvBWUs5rPOHS1tt5zw6u695bX8eoUa+1m8m8D609NVjOCSPMA5561rro9rAv8bGuPhEX6H5Hy3UO8UPtV5zfib4/1k+O5JKXnjFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsU2ghLuaruQAcGKhMFnciPVkjov3F5bBlSK2R2xJ+o=;
 b=uHYeEWcsbEAoiVksxw60WvdouwrZueVlaZdgWIwImbHlu3/r2dujEhty3aroX37KDQZG01cVCnm19xgMcHo29IBac8BSIeeJOOpVGEqOEz42JTJP7VjnjPoOdPwupgGB+WPkO+zdmXDhiehCm5fNKQpQO1nq1uPinXXfkoCKpSDyaKJNfYrGCnSUcFl9GonMu9eS4MM7vp7RINlsGEmAHnn1/npI0bSS25Ukjc7Yoh8J1SjquGypMQ3bk6aF+heyWwEHOoQjuArd/30wvBFAN47nvWL7UuXLw8leySUJ9HipPzk4ykl0du3rf1wHMS5uHqV72yvzVipiuiAbigJwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsU2ghLuaruQAcGKhMFnciPVkjov3F5bBlSK2R2xJ+o=;
 b=X1WehsN4eS1bcVlUaYr+s2tHADCNXY8MCW45Mg5JkdxC2DAAj7hO4PQZsW9qqaKUpxw3u+pGEot8ZjKN53KiQZxvGo1XBpE4fwvWAvNaurDjzGHhFWgZoEz1WcqcDdgBL1CJ7flpY9pEsFQ7KswmmP/mKCZeV548wQR+R51TBCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:14 +0000
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
Subject: [RFC PATCH v4 27/38] ntb_netdev: Multi-queue support
Date: Sun, 18 Jan 2026 22:54:29 +0900
Message-ID: <20260118135440.1958279-28-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d350ba5-f3c4-46a0-e6ab-08de5699348d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?//1DaGFumV64TtN3IObQwZDaTwFw58dy1nm8mE2YCFYmjhykaFo9iaEzoxej?=
 =?us-ascii?Q?IHOBU0sYKNwoLiDitOQPkiGRagx8uot7uTHmyI+IeN9SxDWaFC/VBtYmNUKB?=
 =?us-ascii?Q?EmG6/6rjrjRVBLHyyho1EA1Ju/Wh8CtDWoEfJrFIoPdvlfla2HPF/uMBCndq?=
 =?us-ascii?Q?lxHTW1m+0rSclKS66hDuxVy3x6MZLQ5UauBL+TdkvXEHkTU4UJ5zXK60YjaE?=
 =?us-ascii?Q?/xdRw8gsmBLZoZx7NZzPloRduTOg6e8ccGGBz+Gl4IGonwDglMssvKrQcExz?=
 =?us-ascii?Q?DuLUn/1jxmaqTM8iUlXP6s5KVZ04aIOekte5AageFlp4ny/LkznISC8xMseh?=
 =?us-ascii?Q?RYvyPSfGdMIDaza1BZCUJcFYxA1ryAZAsamp2JZ3ikCppRjyTvMaWwnuRS4z?=
 =?us-ascii?Q?vm3SgxYW/+1QIaNTaAyCclqKujwHmcU3z98N/OtC0qt9pXLSJG+ZPbOWf3ND?=
 =?us-ascii?Q?P0K4SpHWL43S+qXd+j/NvufOQGCzQEm04z7hLNY+fiDqHe/BH4nHg5Xhoxa1?=
 =?us-ascii?Q?FzAhQSd2X2zu2CX6I5m45AF1LZ4/eK53+AgOeRXknmQsfMAD+mE7JqfusIoZ?=
 =?us-ascii?Q?mD13xqNp7BfYKcYF1RzXkCegVB/qfRdfnCFVZdOzDMuMBwslyRkDEUK5HNPO?=
 =?us-ascii?Q?cMqjbNWbchFjubm0WEde/LAy/8mV4pf5+yxnKODTJt/IkrjtgOCyNGGu4HxZ?=
 =?us-ascii?Q?namIRlOwYoOYQ/QYkwyBgX8v3yIgDWJG07JFIiGaUsHLc1ftR/Di6wB+qcMG?=
 =?us-ascii?Q?Z1zw5CyY6H7O5ByMH0D23Y4t8IFfH5bx9oPvyDOaVUfL5y1HrWBDi89W/Zf/?=
 =?us-ascii?Q?T/WrTMzufTJ5znkXLm1MstjjxKMEDkcVRJYp7gBgSiTLyb+OA4pjgp3SAaw8?=
 =?us-ascii?Q?GepQ3CDC7sr2dC8SdCR3/vhEUcugSr6oD7jd/ioxBN4HYAkeLef7191vOOc9?=
 =?us-ascii?Q?G8qwldq3SnZC2l7g+RuldaAqVENREUubnnXUCsElSwFIjd1ptzzh3pAQ2Ggx?=
 =?us-ascii?Q?YxCU2dhYf9p1AV2C24BRK3FIiE6Kr5G5Ia8JTLRzo1XBL6Ohu2N2KTROZRG5?=
 =?us-ascii?Q?DFTdKX7Vd1KgJbpHdG0e4VoClLF+wj9ok8Z84fTT/JdgTnIdQWVVpXoq2QXC?=
 =?us-ascii?Q?2YSJLPHeMUnHCxM6Ew1DZaKDUwyHU2RnJ1TBd+livKLcaNzwEMAdYg0DDPKg?=
 =?us-ascii?Q?XTGwWoV/X7dqfL0zaIXm4GxEufZ/xu9nbhXZpwliHmDlyqE7AFL7GjPUbTe3?=
 =?us-ascii?Q?a+Fu8kFV3h/1jfU/G910n1NC+XNu/fLz4EWLhxWjziYQBVshLrnvL4J76vox?=
 =?us-ascii?Q?1Iq62/Cd8qaaXc8jhMYtOjQ+9QO+j9QBK6D20XzZBfaUEmfNYaJf939Q6sR1?=
 =?us-ascii?Q?JPPFz2Z5+XzXa6UUUcqMZN/8qokGWsmKnGJZ/YNKUAhUSQWGNhIr6yLdJRm7?=
 =?us-ascii?Q?Zwz14veoevfKd8/vQ95yPfj8Cz5CYvhL/w76zT9dMEHmjYbKOo97qyilyQfu?=
 =?us-ascii?Q?0Kh/hBIFLCkzaGvWiq3WXAQMp/cSpM1aZMFwgK6VjcwBJGy9AnEpwY3+OI5D?=
 =?us-ascii?Q?jev8KTl3A0bwQ8Mofk+DX/WoCojkTtUF1bS2eW/6zdDzcMxqC0yWGnt8DoY+?=
 =?us-ascii?Q?Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sX4jSrnEX2s/bpl/mkQNgbcFoTvaA/nlKGBQRP2IYt+XCt8M7wtemTX0RpS5?=
 =?us-ascii?Q?MGVUfh69n850/VNRpSak6UvbvASw8L8+sgP3Vh5qsESgHeL+Wpd5TzV/hHTu?=
 =?us-ascii?Q?ewOtkW6KdVVNzAOBFAcgzRU9S6PWCATmoiuejegTbAhDorNr9fF9B3JJTpZY?=
 =?us-ascii?Q?befyG0sOwuPdcUam7QWt+IxBmsVlg7NHTDGqizPQUacCAq8UoVs4eWZgxTNQ?=
 =?us-ascii?Q?QWzpnXF7UUbh/X2ys54N0RnRU5yxE1K2IbcNUdVtO4AIz0rwgNRBdoWUF1lP?=
 =?us-ascii?Q?xqJVhDxhoj8o8LUnG3O5NmjFftq9DKdzW3QtleEg31URjO+DVSLmNFDoAA3B?=
 =?us-ascii?Q?a/uF0SCIUJMMksl7Lmj39fS/sPSvhQU1qsTKo30z99e0jg0N5hRcrW7AzmiV?=
 =?us-ascii?Q?nkLJdSXkXj5D5ejTA2xhPiggfcM8Hy29E4LxcUd/Uatk44cgFMgASYfEQiSS?=
 =?us-ascii?Q?9BIw2nI4N3i8asmrvD2/soKZtNY/UlixD8Ili971PPplaRkIpT5KQ1TcO0yJ?=
 =?us-ascii?Q?wFCKZFw2MeFNGILgiFBjmtJFMrniVEs1Qj3S5oguvCKCnmfNVbNENi7n6Q+y?=
 =?us-ascii?Q?L3Cq3Y63lOtUm9/WoB0BhMawnT/+RIc/kNGAPOh3MSj2KHaB63kRJ4srui4J?=
 =?us-ascii?Q?kKm3Qigfbngqbzh+9F2ZKUt8+70IVQEq1TV9DC7jGyMUe+TUoNmqd3OFNPv5?=
 =?us-ascii?Q?rbUZ2iIzcDoqrQ0XVwy3ZtRl6fjizYf6w7SFc8HQRWpor+JsKKW1BkhuB5K/?=
 =?us-ascii?Q?bsRKrV2cX4hEmM8xVNBObmG6sY2c47sC1NfT4WEb2B0GmL4DeD8hgCtnqo+Z?=
 =?us-ascii?Q?w1Oy/FDo/F66ZwCPQVsiJPLU1VHPgnYb5+GAeG0B1rmEs0Ab12GavIEz+HJ2?=
 =?us-ascii?Q?RrXYQ/quTlFb+M61Ah+kDEMXZ4/BN5pZcOSU4rv03fkZUM1gSgYG7DeedMGI?=
 =?us-ascii?Q?Pn9nfqtDA5LAw7Zpb0dHpiL48wkhi+3cYkoVhBwtMjNILyol89ll3R6QhGDM?=
 =?us-ascii?Q?LTDbTepTg/Sijena8Ko8asRN1uWN5XKgK6NtjLpuMZX63d9eh1tNX3ILwveZ?=
 =?us-ascii?Q?kjbvQu6tOnRF2pbVAyPihUNFsUMNumwY5Ngcid1rM27kzr1Gr+v6WBKO7Zdh?=
 =?us-ascii?Q?uZgz1em9FSiz2WrkAZmlvMy+3B4jTPsh0kzdfIxlWSNYMZ1SK1mRceW2A/jf?=
 =?us-ascii?Q?gFB+rUPSect9I7aiu1H4pdxlscIaCVeYu03V1blROob++kaFUrLl6652F0Ap?=
 =?us-ascii?Q?8P4YMiHEwMP/5lh8+LDt8sPOhrKeqwOtMroxYsMozJXn/e2bhs5e/ku22PBX?=
 =?us-ascii?Q?frNyRjITJ/nCuaUox1ZQsF2dVd8bNB3fpTgQ59eB9GwOdFi1Ob83Kqlf4+TQ?=
 =?us-ascii?Q?vD7RYgj4XKgHs3HSqVtbg+y33xU18H3RZYgtWzgEAWKpWpXktiT2bbmiJ/5n?=
 =?us-ascii?Q?oq0sJfhYumFnZC0EsDuHtSa4IwTTY5m/y2e2hNR6vH2rQoxJGMW/xIYsteja?=
 =?us-ascii?Q?YGXsb/w6/11tExDp47w24Rr0eY7EsfSd38BOQbfQHFoqEqFT15jMmts/1qXG?=
 =?us-ascii?Q?8ELnUtEFGhqDmw46GuwgOBf5fHtDemtbzvOFcIJ0iksOvOwIFf7lUOM1wVAh?=
 =?us-ascii?Q?KNOcD+p+xs2rwtH2voVTt07+RPEArhGYXFIh33IWy7CJ6HVtAb9SNNGR8qrf?=
 =?us-ascii?Q?QgkyKUoHlXtLjbp4X35qY7rkcle5Twrhg4wf+R1ywp9W0dCxstMc3m9/0W4C?=
 =?us-ascii?Q?dxNpLfJMQY9MbXeLxDANuqmJblVW9gnboeiXIYKMVaQAXNy19e1T?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d350ba5-f3c4-46a0-e6ab-08de5699348d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:14.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XJdq5vgLzG0nGU+rzbLdzw1T/4twEGZ1eB+TkmcwAy2tvxbKcf1G51NDrxFsgbHaHYGJarjU8GlhWnJcrtQ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

In eDMA-backed mode (when using ntb_transport_edma), NTB transport can
scale throughput across multiple queue pairs without being constrained
by scarce BAR/memory window space used for data-plane buffers. It
contrasts with the default ntb_transport, where even with a single queue
pair, only up to 15 in-flight descriptors fit in a 1 MiB MW.

Teach ntb_netdev to allocate multiple ntb_transport queue pairs and
expose them as a multi-queue net_device.

With this patch, up to N queue pairs are created, where N is chosen as
follows:

  - By default, N is num_online_cpus(), to give each CPU its own queue.
  - If the ntb_num_queues module parameter is non-zero, it overrides the
    default and requests that many queues.
  - In both cases the requested value is capped at a fixed upper bound
    to avoid unbounded allocations, and by the number of queue pairs
    actually available from ntb_transport.

If only one queue pair can be created (or ntb_num_queues=1 is set), the
driver effectively falls back to the previous single-queue behavior.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 341 ++++++++++++++++++++++++++++-----------
 1 file changed, 243 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..fc300db66ef7 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -53,6 +53,8 @@
 #include <linux/pci.h>
 #include <linux/ntb.h>
 #include <linux/ntb_transport.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 
 #define NTB_NETDEV_VER	"0.7"
 
@@ -70,26 +72,84 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
+/*
+ * Upper bound on how many queue pairs we will try to create even if
+ * ntb_num_queues or num_online_cpus() is very large. This is an
+ * arbitrary safety cap to avoid unbounded allocations.
+ */
+#define NTB_NETDEV_MAX_QUEUES  64
+
+/*
+ * ntb_num_queues == 0 (default) means:
+ *   - use num_online_cpus() as the desired queue count, capped by
+ *     NTB_NETDEV_MAX_QUEUES.
+ * ntb_num_queues > 0:
+ *   - try to create exactly ntb_num_queues queue pairs (again capped
+ *     by NTB_NETDEV_MAX_QUEUES), but fall back to the number of queue
+ *     pairs actually available from ntb_transport.
+ */
+static unsigned int ntb_num_queues;
+module_param(ntb_num_queues, uint, 0644);
+MODULE_PARM_DESC(ntb_num_queues,
+		 "Number of NTB netdev queue pairs to use (0 = per-CPU)");
+
+struct ntb_netdev;
+
+struct ntb_netdev_queue {
+	struct ntb_netdev *ntdev;
+	struct ntb_transport_qp *qp;
+	struct timer_list tx_timer;
+	u16 qid;
+};
+
 struct ntb_netdev {
 	struct pci_dev *pdev;
 	struct net_device *ndev;
-	struct ntb_transport_qp *qp;
-	struct timer_list tx_timer;
+	unsigned int num_queues;
+	struct ntb_netdev_queue *queues;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
 #define	NTB_RXQ_SIZE		100
 
+static unsigned int ntb_netdev_default_queues(void)
+{
+	unsigned int n;
+
+	if (ntb_num_queues)
+		n = ntb_num_queues;
+	else
+		n = num_online_cpus();
+
+	if (!n)
+		n = 1;
+
+	if (n > NTB_NETDEV_MAX_QUEUES)
+		n = NTB_NETDEV_MAX_QUEUES;
+
+	return n;
+}
+
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
-	struct net_device *ndev = data;
-	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
+	bool any_up = false;
+	unsigned int i;
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
-		   ntb_transport_link_query(dev->qp));
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
 
 	if (link_is_up) {
-		if (ntb_transport_link_query(dev->qp))
+		for (i = 0; i < dev->num_queues; i++) {
+			if (ntb_transport_link_query(dev->queues[i].qp)) {
+				any_up = true;
+				break;
+			}
+		}
+
+		if (any_up)
 			netif_carrier_on(ndev);
 	} else {
 		netif_carrier_off(ndev);
@@ -99,7 +159,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
 	int rc;
 
@@ -135,7 +197,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 enqueue_again:
-	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
+	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,
+				      ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
 		ndev->stats.rx_errors++;
@@ -143,42 +206,37 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 }
 
-static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
-				      struct ntb_transport_qp *qp, int size)
+static int ntb_netdev_maybe_stop_tx(struct ntb_netdev_queue *q, int size)
 {
-	struct ntb_netdev *dev = netdev_priv(netdev);
+	struct net_device *ndev = q->ntdev->ndev;
+
+	if (ntb_transport_tx_free_entry(q->qp) >= size)
+		return 0;
+
+	netif_stop_subqueue(ndev, q->qid);
 
-	netif_stop_queue(netdev);
 	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
 	 * since the queue was last started.
 	 */
 	smp_mb();
 
-	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (likely(ntb_transport_tx_free_entry(q->qp) < size)) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 		return -EBUSY;
 	}
 
-	netif_start_queue(netdev);
-	return 0;
-}
-
-static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
-				    struct ntb_transport_qp *qp, int size)
-{
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
-		return 0;
+	netif_wake_subqueue(ndev, q->qid);
 
-	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+	return 0;
 }
 
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -194,13 +252,12 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
@@ -208,16 +265,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	u16 qid = skb_get_queue_mapping(skb);
+	struct ntb_netdev_queue *q;
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	if (unlikely(!dev->num_queues))
+		goto err;
+
+	if (unlikely(qid >= dev->num_queues))
+		qid = qid % dev->num_queues;
 
-	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
+	q = &dev->queues[qid];
+
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
 	/* check for next submit */
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
 
 	return NETDEV_TX_OK;
 
@@ -229,80 +296,103 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
-	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
+	struct ntb_netdev_queue *q = container_of(t, struct ntb_netdev_queue, tx_timer);
+	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
 
-	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (ntb_transport_tx_free_entry(q->qp) < tx_stop) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
-		/* Make sure anybody stopping the queue after this sees the new
+		/*
+		 * Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int rc, i, len;
-
-	/* Add some empty rx bufs */
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-		if (!skb) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	int rc = 0, i, len;
+	unsigned int q;
 
-		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
-		if (rc) {
-			dev_kfree_skb(skb);
-			goto err;
+	/* Add some empty rx bufs for each queue */
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		for (i = 0; i < NTB_RXQ_SIZE; i++) {
+			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+			if (!skb) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+						      ndev->mtu + ETH_HLEN);
+			if (rc) {
+				dev_kfree_skb(skb);
+				goto err;
+			}
 		}
-	}
 
-	timer_setup(&dev->tx_timer, ntb_netdev_tx_timer, 0);
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
+	}
 
 	netif_carrier_off(ndev);
-	ntb_transport_link_up(dev->qp);
-	netif_start_queue(ndev);
+
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
+
+	netif_tx_start_all_queues(ndev);
 
 	return 0;
 
 err:
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 	return rc;
 }
 
 static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
+	unsigned int q;
 	int len;
 
-	ntb_transport_link_down(dev->qp);
+	netif_tx_stop_all_queues(ndev);
+
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		ntb_transport_link_down(queue->qp);
 
-	timer_delete_sync(&dev->tx_timer);
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
 
+		timer_delete_sync(&queue->tx_timer);
+	}
 	return 0;
 }
 
 static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int len, rc;
+	unsigned int q, i;
+	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->qp) - ETH_HLEN)
+	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -311,41 +401,54 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* Bring down the link and dispose of posted rx entries */
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_down(dev->queues[q].qp);
 
 	if (ndev->mtu < new_mtu) {
-		int i;
-
-		for (i = 0; (skb = ntb_transport_rx_remove(dev->qp, &len)); i++)
-			dev_kfree_skb(skb);
+		for (q = 0; q < dev->num_queues; q++) {
+			queue = &dev->queues[q];
 
-		for (; i; i--) {
-			skb = netdev_alloc_skb(ndev, new_mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-						      new_mtu + ETH_HLEN);
-			if (rc) {
+			for (i = 0;
+			     (skb = ntb_transport_rx_remove(queue->qp, &len));
+			     i++)
 				dev_kfree_skb(skb);
-				goto err;
+
+			for (; i; i--) {
+				skb = netdev_alloc_skb(ndev,
+						       new_mtu + ETH_HLEN);
+				if (!skb) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				rc = ntb_transport_rx_enqueue(queue->qp, skb,
+							      skb->data,
+							      new_mtu +
+							      ETH_HLEN);
+				if (rc) {
+					dev_kfree_skb(skb);
+					goto err;
+				}
 			}
 		}
 	}
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
-	ntb_transport_link_up(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
 
 	return 0;
 
 err:
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		ntb_transport_link_down(queue->qp);
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
 	return rc;
@@ -404,6 +507,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
+	unsigned int q, desired_queues;
 	int rc;
 
 	ntb = dev_ntb(client_dev->parent);
@@ -411,7 +515,9 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!pdev)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(*dev));
+	desired_queues = ntb_netdev_default_queues();
+
+	ndev = alloc_etherdev_mq(sizeof(*dev), desired_queues);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -420,6 +526,15 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
+	dev->num_queues = 0;
+
+	dev->queues = kcalloc(desired_queues, sizeof(*dev->queues),
+			      GFP_KERNEL);
+	if (!dev->queues) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -436,26 +551,51 @@ static int ntb_netdev_probe(struct device *client_dev)
 	ndev->min_mtu = 0;
 	ndev->max_mtu = ETH_MAX_MTU;
 
-	dev->qp = ntb_transport_create_queue(ndev, client_dev,
-					     &ntb_netdev_handlers);
-	if (!dev->qp) {
+	for (q = 0; q < desired_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp)
+			break;
+
+		dev->num_queues++;
+	}
+
+	if (!dev->num_queues) {
 		rc = -EIO;
-		goto err;
+		goto err_free_queues;
 	}
 
-	ndev->mtu = ntb_transport_max_size(dev->qp) - ETH_HLEN;
+	rc = netif_set_real_num_tx_queues(ndev, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	rc = netif_set_real_num_rx_queues(ndev, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
 
 	rc = register_netdev(ndev);
 	if (rc)
-		goto err1;
+		goto err_free_qps;
 
 	dev_set_drvdata(client_dev, ndev);
-	dev_info(&pdev->dev, "%s created\n", ndev->name);
+	dev_info(&pdev->dev, "%s created with %u queue pairs\n",
+		 ndev->name, dev->num_queues);
 	return 0;
 
-err1:
-	ntb_transport_free_queue(dev->qp);
-err:
+err_free_qps:
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+err_free_queues:
+	kfree(dev->queues);
+
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -464,9 +604,14 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
+
 
 	unregister_netdev(ndev);
-	ntb_transport_free_queue(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+	kfree(dev->queues);
 	free_netdev(ndev);
 }
 
-- 
2.51.0


