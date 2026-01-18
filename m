Return-Path: <linux-kselftest+bounces-49264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C98D39594
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC1473009840
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9268D3321C2;
	Sun, 18 Jan 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="s06hGpWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46269331A46;
	Sun, 18 Jan 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744500; cv=fail; b=BEi8gpEA6LGlA94+bwJ46D6wL6Y25d75LrjxTNLUMNDk4dDmPUqi3P1E764Vj+RQArjp53M9qB3ynXyvxmX9auhJzIOtNOsF5cv6/OMzKi26Yggah+D3JaN0yrD6+8OK1eDrFNRG+7U5lboTT8fOPqSLgbRbLaN/S+GcEE1R15c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744500; c=relaxed/simple;
	bh=GlHPsGDXIRt41HBfHybMFnrB6iE4W1vLHDJppT61CIU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VNweVPODMK+gTa8lapHOpWHEHQei2oLv2kf2dIkojxzQsovaDC50eM4jX345KkMo9AJ4gQI+aeYHIjx/XKcRe6Leseai5DY0wzL1GNWdeuYjkVrJqDiA3YJav1CC6rZyOzWeISzmBpJQTz7haLIW5NrCMR93O6Rr5Z5MrbUY8dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=s06hGpWr; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA3JP3TeWlJL40BBmmJ8Cj4B/X9SmQ3Gcz8JKX9dYDbRr1CkbgTdg+dXQMqpHvhizUECui7584pN+azVJu3jiZhY4OzYIpVpbnMFmqusO4WSinBLKkPZEPk6nZCSKFvgwGG7hUMQvsbHHLhKuyNW+ZaU10bXCb+1dRE+lHq9bNrmEL2vp6FRpgjHNGuEAQO8XdS7YQ26Qbg2NFfJm1LQm33c5hDcq2AX8z6C1KJ3LVWML4ex/MLlpQvByJz0UbDEo6dKX2laPjzikmGwpHLcKJS7cObf5tV56gPb/qT4eGUHWgoGvUKV6mdh5EBY0wTI9nd3S0hru9dOR9kJN+/cBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQC3ub6Ro9ZPjKdMuT70HcnHsi273XsFyfS8/gaOug8=;
 b=Y0WddouAQOAd0OWWFnIqdXS1+i7hEt0Qh38cXyxu1T4wZS8fr5FxSl9XhPo8ZK1guA2nSeFv6uOKojbgQgCBA5iB1nxhsGbuty5ioRZ9/UgVktrH1ARUBQvVyCX/SI/maGN3joGUUWyIZjScgOFbtJ01sVD4GyFg7CGWn4Cxd4HJXeE/twtIQ7IJhOvdhPCsZ1wcM8H1kOmrA78mwJOJT+KBMlhab65p6pAQLvxxPIjsjuL1+YB1+RkPwqw9uXgKYTgs8+Wkk/m9EqFrlKAheqyrY1R+pJasVdwIXnffM+wXyoOPb/i4A0VujN7facSKAm+9Kyb+2iozyuUPHq7cIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQC3ub6Ro9ZPjKdMuT70HcnHsi273XsFyfS8/gaOug8=;
 b=s06hGpWrvQFFkosf+vgXCeX0GN6tSeclmKLBLhZ12IQwsumiiEu5ozbDU41us+C4Re0szCK30I7A2I39px9hUq5bQSCBmT3hKzmHkON0jkV4lGNz9nDXuxyOtCvR9zcJ5VM+b6IoJc1FPhRp5X5HtGo0kf5Fgl+v68ZDLOzgHyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:51 +0000
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
Subject: [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
Date: Sun, 18 Jan 2026 22:54:02 +0900
Message-ID: <20260118135440.1958279-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f27a52-7d35-4d45-a4be-08de569926d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6wM8e+zRtxtIRY17eL3IggBn3jXWSTMmvakbRKEMjyqis2f9P0RabzCuXQ3?=
 =?us-ascii?Q?/0g4GyA2PQmYK2ViyqdRubOCTmpVm1hQxPoYm0PadvyK5SQMo5W7V6no8bCs?=
 =?us-ascii?Q?z87p9SSLwS5E2X3OUYBQhb71sTT6FD1ss9VYkwbP2ED0o8lkwjuAOx5eYRYm?=
 =?us-ascii?Q?R9bFPl0BLjtvcHGkuFHDNL7vaDfFQEQx0wR457UG2DvosfrMkgFjlr+rKvQL?=
 =?us-ascii?Q?Gpag3SonMUfny4YoHz/NsiAVgIacNSTfixCddSW9tZ/bqsutdh9hG4YYXh8E?=
 =?us-ascii?Q?6VUGnpV0PC1wiQnfFYkV+O7BTZfX/ko1hQi6JwsbYDTgS5y3efPTh6fPZrfP?=
 =?us-ascii?Q?09+/3VqGxQaMMrqIEqY+EOS5dvm52hfQeHLUBZkWQrGoj3myHg8ae1dcbyfb?=
 =?us-ascii?Q?xvKcswTornX2GjypgO2fMZKK1zqAmQDJImVa4czbgCuBlPT2Bf/Rs+A1NKVC?=
 =?us-ascii?Q?D4ETIo/6k4dTjC2s2/AwM1CB4tlECUbC3IHNaRh+ql9pWZK1LSYxuDUC47An?=
 =?us-ascii?Q?W2lBlOZmDQqGo4zdOoftfHOFss0g9sO29mkksg3a2iMANdmD783xa9G3UBsu?=
 =?us-ascii?Q?4vuAY22bigGWHTa0uZFRcAZqGw/zbEtq5uhopPQ7XS/RdeR5MR1CW+EfJUyX?=
 =?us-ascii?Q?1VJzl+oNpZZBQcrlTS8eOHa8WZuSg/rG9/9476YG8Q15VIpJnihaQL1qvk4e?=
 =?us-ascii?Q?o8nBJaEkmWlhPCuqrPvkjA78vRU21XitY9O8yEO6Fl9UErdej8ujXVy7TYm1?=
 =?us-ascii?Q?Nb/maf5cOpB0j/StJfEFBIHqtDoJf7w4KGJ74JCbK/Zl9IrqXkafGqf8zhqO?=
 =?us-ascii?Q?R5MHGf2oBSeNDfkp4eIe3BDaYg/Ud+4/ZwW1utCRMMe5aZ/n+0v0i4GqJ02i?=
 =?us-ascii?Q?rz6IeWjb53qvN4EWDnEQ3C/yRREp9wujslmHI4E152RbiD+223cTf/BamiMm?=
 =?us-ascii?Q?di3Y0F8pz3zYLAoSbbooJOmj6640TxxPZ0v9XDF06gm0ecqNxNudx4lz2RRX?=
 =?us-ascii?Q?ystN3DP4VFqEpJTzOKHhQYVSA1GzvKpK+G0v0Pz+kaSE8Yck508HQkO2VYdi?=
 =?us-ascii?Q?XtF2TSiwT9F0sP0QM2lAgiJgZo+xs+2gfTCBvCvv5ZmobrQR7+2zXbHIqbct?=
 =?us-ascii?Q?mqZlkoPuxOnBg2B/GhPsOe0IpkMtCvr+UPeXDezSZQfCg6DNI8Yx4bvvUbll?=
 =?us-ascii?Q?uA31QiI8E3DrxW8ihTbnazmP6j3jQwnxbBa77yMeABpp4p+yaKV35aF6U138?=
 =?us-ascii?Q?Wr7Fd84alvXaitzfyV8RECfk6E9zTuvicTgyppSMUgAqQB3ra1rgUU/u7uY8?=
 =?us-ascii?Q?PZ1JQtxjrRxAVXhTADExwQxg8IDctNV4XOmrh6kh23x2pykOSA3nQxw+2H9d?=
 =?us-ascii?Q?FwTpIfXYBglma96VC/l9S8m4bRcClvWl0K23p8B4Db7W4aPSEWfCnFp/memO?=
 =?us-ascii?Q?qJ9REPmfhaL9pI1JBimi1ZpsbxJEbnIB73cDcsG11cVo7u+BriQBE58LlpyS?=
 =?us-ascii?Q?QjfurQvIiSOR5V8dDfCRuXRYH5SC0tKzypO2lxKQGTW+vP2e3Q4wPbg7xK5S?=
 =?us-ascii?Q?2ezg+8NKi9c/v/X1/ODbE/AgvbUdmXJzecTiqHoyYJySxQMfClsiFYC56lYA?=
 =?us-ascii?Q?1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(13003099007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVttaJh6GuIFZEqm5iklhWjiPdV+iekxe9cIcsu/Cn7+HhZymVZy5JebSykl?=
 =?us-ascii?Q?vecGUy8TbBgrAHzI3VQNymBDAUWvLfc9Zmkry0N2c+eX80vi2Si+YgEyNJDd?=
 =?us-ascii?Q?Dw51665R3SLCy/UEkM3JcwnzrGHFCt8FTfvG2wux0Vtt2crvA1vwxoAWd5xf?=
 =?us-ascii?Q?fMAm4F+HnBJfTj/RRi2Fm6X+wFQvaKObh9aVt6THgJb+YWxFUdvjr8OG9/qD?=
 =?us-ascii?Q?5EPm/EfHQ3g0Ta16DJX8dNhpUmp6A3JeHSKBka8U1Gphgk/bwRmiwG7ZnAgX?=
 =?us-ascii?Q?ZzzkCNPTB9K3yRFUdy6vd7+SSFNoi67AHuee4WxwBR9fzQV//qm2oMRNqGf5?=
 =?us-ascii?Q?LPF/2CjbiUEqNZ8clh3ZZ/n1hX5lC9CAafg9OD8F1GW2JX8WQik3E8zaXiHS?=
 =?us-ascii?Q?yZo6IXFAB51XQN1OQTg0ZMf8FiqUzrb29hFUeEDnc06XuLMCjowyzfQRsisL?=
 =?us-ascii?Q?W+g+ipIid0v/ga/MQMyHKI3g+ogfR8+LwftWcSes2noXuQKp9huTJrv1OnBu?=
 =?us-ascii?Q?I+pjVLnm+fVpK+ItCf3hHm3oI60IS8r0iNQDOxakVXuiGPSx+VbT6mGdzG7Q?=
 =?us-ascii?Q?SaIUDocTuZz7yyRUzckbbQTvWG02hJj1ur3R7b6lAQSRhxgVo+17giFi1SBi?=
 =?us-ascii?Q?qkoN+gLiB5QWzmNHepPttJer9YI4c9Rpv+yU+HsAiIf8o31U8EMP69JBVvxG?=
 =?us-ascii?Q?AoPlOFvHAmSvJmOxVWxkNRbcCeq+Thlt6LEwH/+X8D/wGORGjijFGDlc4j37?=
 =?us-ascii?Q?34WLx9IKG7WWUuCQE9VcZ3xKTBJtIN84pvmQTdmH1WTUYyIAYV+633rQOZFY?=
 =?us-ascii?Q?joER/8eU0NVp+L/deVjkDKT8Tv0tHDiJNhqqLmXrx3SznCD0fzIUG+BETKd+?=
 =?us-ascii?Q?doTimgy1dXUQ9vnfaiN833gpeMy7wCjZ+14l7q/PUm852df4GBfQ0zSS6Pzf?=
 =?us-ascii?Q?oZJtioVFsSmJi4FeHJ8WnnbOHD2MNdkg3ULDovKhqn54wQmcTEPUZRFvQHfr?=
 =?us-ascii?Q?UwlcfUNr0+CO8WvSYe/yYSIqFGNn6qJFoZ9v1hRLGZSx6NwRl4eDIRltLu1f?=
 =?us-ascii?Q?mHsacbRcN6ju7NpVSQMweHti+CvgFZmyCNU5GW0GmKX26IGb1FWo3Ow0axu9?=
 =?us-ascii?Q?bYnDqD1xA85KoyEpKvinIXhkuRDxwB4+av8TsuhK8xwutLNAdamDZzz8rk4Q?=
 =?us-ascii?Q?WCAwjmNBQvy102Svaf/qm83LSAGEKkwrYqtkL6zssaSaMFu0lWyEWG7T/n5o?=
 =?us-ascii?Q?fdJ9QV79uBUFp7kHlFoUyUgtc3cQCL0gTATZt6mZ8YCoJLWea2ZE2y5UsbaW?=
 =?us-ascii?Q?rx9qWGKimu6ZblOEyFxXj+kd1ngd994sHpPdd2k57bxm2u9Acww8mTFynsgt?=
 =?us-ascii?Q?GPfaKqiCcxZzGgqxOFQ87ESzxDu0xEt1d4ZHNpf7giD3TGI4tc3pVJ/Q/N7n?=
 =?us-ascii?Q?RdR3yck6kN4d+hWKF2la2KVD3132fLgq3FgQQ89JSPHOA6/IlplQE3TK7Q6J?=
 =?us-ascii?Q?KBszrRZ5zFaOHgVVrfWIdKZQTSFiV8VesA2McF97OsxQYQ+PCStxuDJPvuYD?=
 =?us-ascii?Q?BdmRpqtb3GbD5+PS4wxQHIgU0PfdgZHj8qUhLzK/1zNAWeBQMdta5/S2magI?=
 =?us-ascii?Q?gp7n5c7/WBMvA+9E8dhbtYt6DA5p3Qk73n4hGOn+w9jyBAbY3UfNvfHdBfbn?=
 =?us-ascii?Q?t2HMNL/s3OGYw2Crkmuz1NhgRom3cfv1jdWF5JrOduNvu4d1jYUcPa6S14WT?=
 =?us-ascii?Q?4z+24TX2Pqbo19OTtGq0EOxjd4GCkt/eMX4QuCEjSmFDp4nV8MSl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f27a52-7d35-4d45-a4be-08de569926d5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:51.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnXw4Q0J8a8tBQIkMJ1NkR8djHpfBlUZhdyWb0ktflJk5yS2JD4NDmI+BU18fjA0ZuvEPR1sCDw8iCvklhNc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Hi,

This is RFC v4 of the NTB/PCI/dmaengine series that introduces an
optional NTB transport variant where payload data is moved by a PCI
embedded-DMA engine (eDMA) residing on the endpoint side.

The primary target is Synopsys DesignWare PCIe endpoint controllers that
integrate a DesignWare eDMA instance (dw-edma). In the remote
embedded-DMA mode, payload is transferred by DMA directly between the
two systems' memory, and NTB Memory Windows are used primarily for
control/metadata and for exposing the endpoint eDMA resources (register
window + linked-list rings) to the host.

Compared to the existing cpu/dma memcpy-based implementation, this
approach avoids window-backed payload rings and the associated extra
copies, and it is less sensitive to scarce MW space. This also enables
scaling out to multiple queue pairs, which is particularly beneficial
for ntb_netdev. On R-Car S4, preliminary iperf3 results show 10~20x
throughput improvement. Latency improvements are also observed.

RFC history:
  RFC v3: https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
  RFC v2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
  RFC v1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/

Parts of RFC v3 series have already been split out and posted separately
(see "Kernel base / dependencies" section below). However, feedback on
the remaining parts led to substantial restructuring and code changes,
so I am sending an RFC v4 as a refreshed version of the full series.

RFC v4 is still a large, cross-subsystem series. At this RFC stage,
I am sending the full picture in a single set to make it easier to
review the overall direction and architecture. Once the direction is
agreed upon and no further large restructuring appears necessary, I will stop
posting the new RFC-tagged revisions and continue development on
separate threads, split by sub-topic.

Many thanks for all the reviews and feedback from multiple perspectives.


Software architecture overview (RFC v4)
=======================================

A major change in RFC v4 is the software layering and module split.

The existing memcpy-based transport and the new remote embedded-DMA
transport are implemented as two independent NTB client drivers on top
of a shared core library:

                       +--------------------+
                       | ntb_transport_core |
                       +--------------------+
                           ^            ^
                           |            |
        ntb_transport -----+            +----- ntb_transport_edma
       (cpu/dma memcpy)                   (remote embedded DMA transfer)
                                                       |
                                                       v
                                                 +-----------+
                                                 |  ntb_edma |
                                                 +-----------+
                                                       ^
                                                       |
                                               +----------------+
                                               |                |
                                          ntb_dw_edma         [...]

Key points:
  * ntb_transport_core provides the queue-pair abstraction used by upper
    layer clients (e.g. ntb_netdev).
  * ntb_transport is the legacy shared-memory transport client (CPU/DMA
    memcpy).
  * ntb_transport_edma is the remote embedded-DMA transport client.
  * ntb_transport_edma relies on an ntb_edma backend registry.
    This RFC provides an initial DesignWare backend (ntb_dw_edma).
  * Transport selection is per-NTB device via the standard
    driver_override mechanism. To enable that, this RFC adds
    driver_override support to ntb_bus. This allows mixing transports
    across multiple NTB ports and provides an explicit fallback path to
    the legacy transport.

So, if ntb_transport / ntb_transport_edma are built as loadable modules,
you can just run modprobe ntb_transport as before and the original cpu/dma
memcpy-based implementation will be active. If they are built-in, whether
ntb_transport or ntb_transport_edma are bound by default depends on
initcall order. Regarding how to switch the driver, please see Patch 34
("Documentation: driver-api: ntb: Document remote embedded-DMA transport")
for details.


Data flow overview (remote embedded-DMA transport)
==================================================

At a high level:
  * One MW is reserved as an "eDMA window". The endpoint exposes the
    eDMA register block plus LL descriptor rings through that window, so
    the peer can ioremap it and drive DMA reads remotely.
  * Remaining MWs carry only small control-plane rings used to exchange
    buffer addresses and completion information.
  * For RC->EP traffic, the RC drives endpoint DMA read channels through
    the peer-visible eDMA window.
  * For EP->RC traffic, the endpoint uses its local DMA write channels.

The following figures illustrate the data flow when ntb_netdev sits on
top of the transport:

     Figure 1. RC->EP traffic via ntb_netdev + ntb_transport_edma
                   backed by ntb_edma/ntb_dw_edma

             EP                                   RC
          phys addr                            phys addr
            space                                space
             +-+                                  +-+
             | |                                  | |
             | |                ||                | |
             +-+-----.          ||                | |
    EDMA REG | |      \     [A] ||                | |
             +-+----.  '---+-+  ||                | |
             | |     \     | |<---------[0-a]----------
             +-+-----------| |<----------[2]----------.
     EDMA LL | |           | |  ||                | | :
             | |           | |  ||                | | :
             +-+-----------+-+  ||  [B]           | | :
             | |                ||  ++            | | :
          ---------[0-b]----------->||----------------'
             | |            ++  ||  ||            | |
             | |            ||  ||  ++            | |
             | |            ||<----------[4]-----------
             | |            ++  ||                | |
             | |           [C]  ||                | |
          .--|#|<------------------------[3]------|#|<-.
          :  |#|                ||                |#|  :
         [5] | |                ||                | | [1]
          :  | |                ||                | |  :
          '->|#|                                  |#|--'
             |#|                                  |#|
             | |                                  | |

     Figure 2. EP->RC traffic via ntb_netdev + ntb_transport_edma
                  backed by ntb_edma/ntb_dw_edma

             EP                                   RC
          phys addr                            phys addr
            space                                space
             +-+                                  +-+
             | |                                  | |
             | |                ||                | |
             +-+                ||                | |
    EDMA REG | |                ||                | |
             +-+                ||                | |
    ^        | |                ||                | |
    :        +-+                ||                | |
    : EDMA LL| |                ||                | |
    :        | |                ||                | |
    :        +-+                ||  [C]           | |
    :        | |                ||  ++            | |
    :     -----------[4]----------->||            | |
    :        | |            ++  ||  ||            | |
    :        | |            ||  ||  ++            | |
    '----------------[2]-----||<--------[0-b]-----------
             | |            ++  ||                | |
             | |           [B]  ||                | |
          .->|#|--------[3]---------------------->|#|--.
          :  |#|                ||                |#|  :
         [1] | |                ||                | | [5]
          :  | |                ||                | |  :
          '--|#|                                  |#|<-'
             |#|                                  |#|
             | |                                  | |

    0-a. configure remote embedded DMA (program endpoint DMA registers)
    0-b. DMA-map and publish destination address (DAR)
    1.   network stack builds skb (copy from application/user memory)
    2.   consume DAR, DMA-map source address (SAR) and kick DMA transfer
    3.   DMA transfer (payload moves between RC/EP memory)
    4.   consume completion (commit)
    5.   network stack delivers data to application/user memory

    [A]: Dedicated MW that aggregates DMA regs and LL (peer ioremaps it)
    [B]: Control-plane ring buffer for "produce"
    [C]: Control-plane ring buffer for "consume"


Kernel base / dependencies
==========================

This series is based on:

  - next-20260114 (commit b775e489bec7)

plus the following seven unmerged patch series or standalone patches:

  - [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
    https://lore.kernel.org/all/20251202072348.2752371-1-den@valinux.co.jp/

  - [PATCH v2 0/2] NTB: ntb_transport: debugfs cleanups
    https://lore.kernel.org/all/20260107042458.1987818-1-den@valinux.co.jp/

  - [PATCH v3 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
    https://lore.kernel.org/all/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/

  - [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
    https://lore.kernel.org/all/20260115084928.55701-1-den@valinux.co.jp/

  - [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
    https://lore.kernel.org/all/20260105075606.1253697-1-den@valinux.co.jp/

  - [PATCH] dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr interrupts
    https://lore.kernel.org/all/20260105075904.1254012-1-den@valinux.co.jp/

  - [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
    https://lore.kernel.org/imx/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
    (only this single commit is cherry-picked from the series)


Patch layout
============

  1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
     register/LL windows, IRQ routing control, etc.)

     Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
     Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
     Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
     Patch 04 : dmaengine: dw-edma: Add notify-only channels support
     Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region

  2. NTB EPF/core + vNTB prep (mwN_offset + versioning, MSI vector
     management, new ntb_dev_ops helpers, driver_override, vntb glue)

     Patch 06 : NTB: epf: Add mwN_offset support and config region versioning
     Patch 07 : NTB: epf: Reserve a subset of MSI vectors for non-NTB users
     Patch 08 : NTB: epf: Provide db_vector_count/db_vector_mask callbacks
     Patch 09 : NTB: core: Add mw_set_trans_ranges() for subrange programming
     Patch 10 : NTB: core: Add .get_private_data() to ntb_dev_ops
     Patch 11 : NTB: core: Add .get_dma_dev() to ntb_dev_ops
     Patch 12 : NTB: core: Add driver_override support for NTB devices
     Patch 13 : PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
     Patch 14 : PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
     Patch 15 : PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()

  3. ntb_transport refactor/modularization and backend infrastructure

     Patch 16 : NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
     Patch 17 : NTB: ntb_transport: Dynamically determine qp count
     Patch 18 : NTB: ntb_transport: Use ntb_get_dma_dev()
     Patch 19 : NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
     Patch 20 : NTB: ntb_transport: Move internal types to ntb_transport_internal.h
     Patch 21 : NTB: ntb_transport: Export common helpers for modularization
     Patch 22 : NTB: ntb_transport: Split core library and default NTB client
     Patch 23 : NTB: ntb_transport: Add transport backend infrastructure
     Patch 24 : NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation

  4. ntb_edma backend registry + DesignWare backend + transport client

     Patch 25 : NTB: hw: Add remote eDMA backend registry and DesignWare backend
     Patch 26 : NTB: ntb_transport: Add remote embedded-DMA transport client

  5. ntb_netdev multi-queue support

     Patch 27 : ntb_netdev: Multi-queue support

  6. Renesas R-Car S4 enablement (IOMMU, DTs, quirks)

     Patch 28 : iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
     Patch 29 : iommu: ipmmu-vmsa: Add support for reserved regions
     Patch 30 : arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe eDMA
     Patch 31 : NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
     Patch 32 : NTB: epf: Add an additional memory window (MW2) barno mapping on Renesas R-Car

  7. Documentation updates

     Patch 33 : Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset usage
     Patch 34 : Documentation: driver-api: ntb: Document remote embedded-DMA transport

  8. pci-epf-test / pci_endpoint_test / kselftest coverage for remote eDMA

     Patch 35 : PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
     Patch 36 : PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
     Patch 37 : misc: pci_endpoint_test: Add remote eDMA transfer test mode
     Patch 38 : selftests: pci_endpoint: Add remote eDMA transfer coverage


Tested on
=========

* 2x Renesas R-Car S4 Spider (RC<->EP connected with OCuLink cable)
* Kernel base as described above


Performance notes
=================

The primary motivation remains improving throughput/latency for ntb_transport
users (typically ntb_netdev). On R-Car S4, the earlier prototype (RFC v3)
showed roughly 10-20x throughput improvement in preliminary iperf3 tests and
lower ping RTT. I have not yet re-measured after the v4 refactor and
module split.


Changelog
=========

RFCv3->RFCv4 changes:
  - Major refactor of the transport layering:
    - Introduce ntb_transport_core as a shared library module.
    - Split the legacy shared-memory transport client (ntb_transport) and the
      remote embedded-DMA transport client (ntb_transport_edma).
    - Add driver_override support for ntb_bus and use it for per-port transport
      selection.
  - Introduce a vendor-agnostic remote embedded-DMA backend registry (ntb_edma)
    and add the initial DesignWare backend (ntb_dw_edma).
  - Rebase to next-20260114 and move several prerequisite/fixup patchsets into
    separate threads (listed above), including BAR subrange mapping support and
    dw-edma fixes.
  - Add PCI endpoint test coverage for the remote embedded-DMA path:
    - extend pci-epf-test / pci_endpoint_test
    - add a kselftest variant to exercise remote-eDMA transfers
    Note: to keep the changes as small as possible, I added a few #ifdefs
    in the main test code. Feedback on whether/how/to what extent this
    should be split into separate modules would be appreciated.
  - Expand documentation (Documentation/driver-api/ntb.rst) to describe transport
    variants, the new module structure, and the remote embedded-DMA data flow.
  - Addressed other feedbacks from the RFC v3 thread.

RFCv2->RFCv3 changes:
  - Architecture
    - Have EP side use its local write channels, while leaving RC side to
      use remote read channels.
    - Abstraction/HW-specific stuff encapsulation improved.
  - Added control/config region versioning for the vNTB/EPF control region
    so that mismatched RC/EP kernels fail early instead of silently using an
    incompatible layout.
  - Reworked BAR subrange / multi-region mapping support:
    - Dropped the v2 approach that added new inbound mapping ops in the EPC
      core.
    - Introduced `struct pci_epf_bar.submap` and extended DesignWare EP to
      support BAR subrange inbound mapping via Address Match Mode IB iATU.
    - pci-epf-vntb now provides a subrange mapping hint to the EPC driver
      when offsets are used.
  - Changed .get_pci_epc() to .get_private_data()
  - Dropped two commits from RFC v2 that should be submitted separately:
    (1) ntb_transport debugfs seq_file conversion
    (2) DWC EP outbound iATU MSI mapping/cache fix (will be re-posted separately)
  - Added documentation updates.
  - Addressed assorted review nits from the RFC v2 thread (naming/structure).

RFCv1->RFCv2 changes:
  - Architecture
    - Drop the generic interrupt backend + DW eDMA test-interrupt backend
      approach and instead adopt the remote eDMA-backed ntb_transport mode
      proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
      mapping (Address Match Mode) infrastructure from RFC v1 is largely
      kept, with only minor refinements and code motion where necessary
      to fit the new transport-mode design.
  - For Patch 01
    - Rework the array_index_nospec() conversion to address review
      comments on "[RFC PATCH 01/25]".

RFCv3: https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
RFCv2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/

Thank you for reviewing,


Koichiro Den (38):
  dmaengine: dw-edma: Export helper to get integrated register window
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Poll completion when local IRQ handling is
    disabled
  dmaengine: dw-edma: Add notify-only channels support
  dmaengine: dw-edma: Add a helper to query linked-list region
  NTB: epf: Add mwN_offset support and config region versioning
  NTB: epf: Reserve a subset of MSI vectors for non-NTB users
  NTB: epf: Provide db_vector_count/db_vector_mask callbacks
  NTB: core: Add mw_set_trans_ranges() for subrange programming
  NTB: core: Add .get_private_data() to ntb_dev_ops
  NTB: core: Add .get_dma_dev() to ntb_dev_ops
  NTB: core: Add driver_override support for NTB devices
  PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
  PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
  PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
  NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
  NTB: ntb_transport: Dynamically determine qp count
  NTB: ntb_transport: Use ntb_get_dma_dev()
  NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
  NTB: ntb_transport: Move internal types to ntb_transport_internal.h
  NTB: ntb_transport: Export common helpers for modularization
  NTB: ntb_transport: Split core library and default NTB client
  NTB: ntb_transport: Add transport backend infrastructure
  NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation
  NTB: hw: Add remote eDMA backend registry and DesignWare backend
  NTB: ntb_transport: Add remote embedded-DMA transport client
  ntb_netdev: Multi-queue support
  iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
  iommu: ipmmu-vmsa: Add support for reserved regions
  arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
    eDMA
  NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
  NTB: epf: Add an additional memory window (MW2) barno mapping on
    Renesas R-Car
  Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
    usage
  Documentation: driver-api: ntb: Document remote embedded-DMA transport
  PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
  PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
  misc: pci_endpoint_test: Add remote eDMA transfer test mode
  selftests: pci_endpoint: Add remote eDMA transfer coverage

 Documentation/PCI/endpoint/pci-vntb-howto.rst |   19 +-
 Documentation/driver-api/ntb.rst              |  193 ++
 arch/arm64/boot/dts/renesas/Makefile          |    2 +
 .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   37 +
 .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
 drivers/dma/dw-edma/dw-edma-core.c            |  207 +-
 drivers/dma/dw-edma/dw-edma-core.h            |   10 +
 drivers/dma/dw-edma/dw-edma-v0-core.c         |   26 +-
 drivers/iommu/ipmmu-vmsa.c                    |    7 +-
 drivers/misc/pci_endpoint_test.c              |  633 +++++
 drivers/net/ntb_netdev.c                      |  341 ++-
 drivers/ntb/Kconfig                           |   13 +
 drivers/ntb/Makefile                          |    2 +
 drivers/ntb/core.c                            |   68 +
 drivers/ntb/hw/Kconfig                        |    1 +
 drivers/ntb/hw/Makefile                       |    1 +
 drivers/ntb/hw/edma/Kconfig                   |   28 +
 drivers/ntb/hw/edma/Makefile                  |    5 +
 drivers/ntb/hw/edma/backend.c                 |   87 +
 drivers/ntb/hw/edma/backend.h                 |  102 +
 drivers/ntb/hw/edma/ntb_dw_edma.c             |  977 +++++++
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  199 +-
 drivers/ntb/ntb_transport.c                   | 2458 +---------------
 drivers/ntb/ntb_transport_core.c              | 2523 +++++++++++++++++
 drivers/ntb/ntb_transport_edma.c              | 1110 ++++++++
 drivers/ntb/ntb_transport_internal.h          |  261 ++
 drivers/pci/controller/dwc/pcie-designware.c  |   26 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  497 +++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  380 ++-
 include/linux/dma/edma.h                      |  106 +
 include/linux/ntb.h                           |   88 +
 include/uapi/linux/pcitest.h                  |    3 +-
 .../pci_endpoint/pci_endpoint_test.c          |   17 +
 33 files changed, 7855 insertions(+), 2624 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
 create mode 100644 drivers/ntb/hw/edma/Kconfig
 create mode 100644 drivers/ntb/hw/edma/Makefile
 create mode 100644 drivers/ntb/hw/edma/backend.c
 create mode 100644 drivers/ntb/hw/edma/backend.h
 create mode 100644 drivers/ntb/hw/edma/ntb_dw_edma.c
 create mode 100644 drivers/ntb/ntb_transport_core.c
 create mode 100644 drivers/ntb/ntb_transport_edma.c
 create mode 100644 drivers/ntb/ntb_transport_internal.h

-- 
2.51.0


