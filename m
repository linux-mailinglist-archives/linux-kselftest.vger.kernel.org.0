Return-Path: <linux-kselftest+bounces-36713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB153AFB8CF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748631884095
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F792236FC;
	Mon,  7 Jul 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XSInk9hu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A4221F1F;
	Mon,  7 Jul 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906495; cv=fail; b=dz8pknovegRafAwzOwvVEYzqJf9qn0JIZNdKSoHWHSdioq8YJZumq8ct+G4Yk09fyJ5Hu/0VWrjNNXzA0PwXn6YlYo5GpJgBN+Fjs9410GsuI+JgROYDnLvADGau+rZASYEBOTW3S+jnKtcT0iUbL8xXBWKbirlJgfEOIlrDURQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906495; c=relaxed/simple;
	bh=IFy0BGuhFSMjxPg7zfFSeTZb3KkfDevG7mHL4VS9cKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kX6N+FK0shvwE0Fvn3UZuwg5AKq+e7dfYmCZq3ykMfgdEhx/RR1OIneoLbEs8Tpia0NqJ+CmD9q6daWP4ZD2XCu6dwg/MFNaxiDhTwDJJDgr7edbKQzIHILsbPlZ2nmwZpTL9RHRvColgYsUzen53iwIlzdf+eTGmKFUoaxXdY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XSInk9hu; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFANmV1w+bCRxbtg+8z+nDJy2VBs0KZAQC+5kb5lzbJTJBXACTMm+M+y1GbDX6kQjsvkZKv962FceTavgruGWxCpsX6wGmUIuK0s5lWTbKuBn3x38d1E+5wwkNrL5qSLxe0z8vvkpGRQSlWFZIH0uJ1cwDEFmC8ujPxE3ZWpXVRXfwIe+ka8sDxYlRidPRd9E2tnVoeGyN6A4cRwazhzYq8+QKHHkNuG0zs+YtEKYYUpdmV3oblsHVj/BgejCL3HxWDwJUHndbXgKQcSUsa1IB/GUPaTjpukBwdqx/G06TeHD5jsrIbjt8z5qdPcvFw89R3tUe0V2Zjk3Ls70fMpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+roztu8jbiFxmZWqoJW4QDZIVjA8JXdPNfEFhBwxhs=;
 b=YHPfZbQ357dwzOw6QBTFGh7ObqchMrdv4UAi15xZvJZQb/lcqx+1ax8UfPL7oiOXVcwWV2kTr5MAKRweNckV+7IAdh6frlkkJ5szMlddaqnWZrZWek5UARPzEJnfW01yxT8YvPLDFXrGWJgrithuyg6k0AGN/2Aic9RbvpRf1Wy7vfbPpnb7+HbTNVY53UPy+HPQkvDDdF2f8FqZVpOmpfSJQRAGzLfg6yJeGPbZIlM/lnHPD/JUH+d0pqsh3NtYtxBK9W8fKUT3/Cfj1R+7YbjqrHQARG13yEWHSW91iwnfSH3YU5Dt3SQx7RzacA12p1aB4gue0HiPHIbt709D9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+roztu8jbiFxmZWqoJW4QDZIVjA8JXdPNfEFhBwxhs=;
 b=XSInk9huMHf8sc1pSVzJfe1t64dzz74/XJKmyRZ9VUXKg8XfX/lOizMWNfGEzZQbuBResOB09b/TXeDKOQucCXkU2zJrJEkw4alVkku45/28DLz1MDRA7NwFfG90+odSbdnky39lqm6DuWa1kKUEKfm1eXeMGhwEWgJx+kfDe4204qHWBenjKZohDx6Qui/aIVr+2/OGz+ngoBrMP9MB5XWSUBX+cUz5eNxJP37PgjKmRNrK0zgNwCnP5GZlwPBfF/0kG/Cvrz7I6pqd/oiwxKr5eBhbYr1uzVopOXRPyx70k3GsDq8G0ErsGezb9kUwfG66fOFbvD9852KaDTuCRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:41:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 16:41:29 +0000
Date: Mon, 7 Jul 2025 12:41:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Message-ID: <aGv4slE8/kmxHvlU@lizhi-Precision-Tower-5810>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
 <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
 <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
 <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: AM0PR10CA0043.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 8126c07f-50c3-4958-c945-08ddbd751f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zi84eVd0b3Nub2Q2R0QvbUoxN1F5by9pcC9aeHNGTHZvZlpUcVZQUXVxaTZD?=
 =?utf-8?B?cWVCaWVYazlGSThRWmFQZGF1dmZCM2ZMOEg4bGppNzJ5M0d5a3FiQU43T3BM?=
 =?utf-8?B?YVduMTF1TE1YZ3lrdGVlNjRROWtXb0FBdUIzd1B4SFpOdFhzQUZIbkh6WHBG?=
 =?utf-8?B?K1Bobkc2SHBNd1BjZ3loZ3NmaGxLNXYzTDRoSHlzczZSTTVwMDJTMFFnYTlt?=
 =?utf-8?B?TSs3NTRwR0dDc3RHUDFlcjJBeTIyR2RnWlVKR2dwR1lYdWlZRmNJZ0h5Rlg5?=
 =?utf-8?B?Y2ZoZ3ZwUzZzMFFKR3BNTXRUNGN0T3JmMlZpeGRSYzJ6T2RwQVJwT1EvZE9n?=
 =?utf-8?B?YjY2a0htVEVPTldYa1lYdmRQSCtFR296UDl4MkJpZXhCbzZVRUZVMkMyMCtp?=
 =?utf-8?B?OS9oaHhBcndpSHdvUHJrQUNjbXoxbk9JUmJUZmFKUFliVmdvaHl3YjNoV3di?=
 =?utf-8?B?cmcyUVhGTWRmNEJFZHVQbi9CNVQ4RHN2bFNDM0NqSUFNNTVKSzIwWTRwb240?=
 =?utf-8?B?K0dPVU80bjJSTEtILzhhMW1nckVaa2lpUExqYWFXU3VacGkxQ3FaUm1jNHpv?=
 =?utf-8?B?M3ZEZ2pDQmpKdlF4UFg5a00rV0ZnbVdBV3g3dStFcWUrZGgxbmpNbGhDZzJz?=
 =?utf-8?B?OXlnTnNwWTBScGI0UTlCdnRKY0FkYS9kYkN4bitMckJQbW1abmJoc1dGNFNr?=
 =?utf-8?B?QjNWVDJ4K3kxeGtSNWJqdTViVi9CaUNnZEdEd2RuZmZGR3NrRHNOQk1lTElY?=
 =?utf-8?B?NFZFU3ZiM2hZWXBIY1p1VW10STNmUlJVc21lK2ZGbmErNi82b2NiUThrbXlt?=
 =?utf-8?B?amUxc3FoelR1Z2t1SUQ4dWcrT0xoTU9jemZNTHlYZ2hGQUdzWk1uT091UmpM?=
 =?utf-8?B?czlJVjBvRm1IbkFaQ0t4SE93UnNNbGFOWlVTd2RyajVJaVJpQzBRdGpsdUQ3?=
 =?utf-8?B?b3pIR3I1VGJxS0MwK2dLUW5TTmFQaXBYRWZGbG1lZXgxY2xEVjhmOFhkM1k3?=
 =?utf-8?B?RVdyS01Vd2orY25iUkovNjNKcmNoRzBCWE0xWE5wZW5VZnhDbXhyazZnWGtX?=
 =?utf-8?B?N1dBcjh1V3FyMzV0QTVYS3loblZUOWNXcW9qUG95SDhjc2ZoU0wrUTU0RVdl?=
 =?utf-8?B?NmF0ZnhtMjhWcGtsazRKK2ZBZS8xejBSRktqRHlYUmU0Tlp0OUlGUjhUOVlJ?=
 =?utf-8?B?QkpMRFlyNlp0OTJ6dFN3ZVRXM21seXJJVjU4U0hPaDJpaXRvMWNMK0U3WlVt?=
 =?utf-8?B?ZkkxNEFQYmdzSjJpSEVsc1VpQWMvcWlWV25oV3FvOElVTlJrMkQ5REpOTEg1?=
 =?utf-8?B?ZWZzNEZaQ0lPZzVtTW9lNVlSUjU5cm9iRjRGUGliaTBhUXlCTWFleXFWbFdL?=
 =?utf-8?B?TW1wekFua3Yzc05UNlVqTTBYRWN0REhvUGRLWFBucHBlNm1FblNpMkNlM09N?=
 =?utf-8?B?S1VUQTAwL2NKeFhTNDFIYWhLcXpFZjhoWkE0dm8vNFVFdFpUUnJBZDlIYXNx?=
 =?utf-8?B?L0lRSmJyVEFDOTRReFQrUDJTR0c0OXhYZ3NadnlScmJWUitONUNJZU02RmZr?=
 =?utf-8?B?VWgvQUpqQUJhcTNFSitIQTZGaEZmTlhuWS81ekRhQlNYSHdZbXRwcFZVbFdP?=
 =?utf-8?B?aDZCZFA2QzhVTnVPcEVVUmxqbUNhUENQK3JVSFZCM0ZGS1loeTRuZnV3OUZF?=
 =?utf-8?B?SXVIZUNMd2tKQUZqNHpwZ29YRC94K1RiSmFmTjBVaHMxNUdkWXF6Zk81WldW?=
 =?utf-8?B?OUJPZnJmR0o4QUNUS0tsV2s2ZkhZY005YkNrc0IxL3ZDZE9nS1pqM2l4MnBX?=
 =?utf-8?B?QU01NHc0ZjhsSzhta09Pc3NZSjZGclYwTm5QL3BqVWdlUGV0eGVoTmVjUVF3?=
 =?utf-8?B?cFZ4RExtbTFXZjdCQ000Z1lHSXBlQ2VrSkRDMHN5U0FJckRrRFhSQjNkYWtK?=
 =?utf-8?B?STBNa0hWVXBLbEgzaktPT0lveEx1YTE1cElHL0dlN2JVWkR2VXI4K3BTWHRK?=
 =?utf-8?B?Z3daOEQyN3VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXd5b25kUEh5ZlRGSEg0WFdaMVBabzZQMkw1RnQzenBGeEU5bHRKMEY3dWdz?=
 =?utf-8?B?dGxDV3I5NDJ0WjRVOUNibFJ2TFFyYUNINDg2a29SM0czWDg4eDZVODBuNHhm?=
 =?utf-8?B?SGhNd284MFBtRTVVYTlvU25CYmt4UnJFcUNOa0piYzRxdmtKdjVrcDFVVnZa?=
 =?utf-8?B?L3d1VnZTODIyZlZDbjRtYjU2eTNCajVIYWFpNk9lTWI0UlZ6bW1mR1l6dHhY?=
 =?utf-8?B?V29DS29KMTI5NjNQckRpT3YyVlIydGdpTWpjaVdXMGpGQzQ1RSsyTVVFOWU4?=
 =?utf-8?B?Ym9iNUhLYytmeWZjcHlUM1lGTXNRakxraEdmaHNxNE1aNUVnK0tpa2VMbzlw?=
 =?utf-8?B?R1FISEtqSW5mYUQ3dnRrNXNpbVIvS1kzRTV6cDhoWFFyeXN2cHZsaWJzdnB2?=
 =?utf-8?B?aGxkNnJGd1pjdjBURFRBYVlWUW9oYTZrbVNjRTlKanJzS1pZTTZjOXk2ZHc4?=
 =?utf-8?B?R0wyM1ArVEVVYjFUVC9XUTRwb3lnb1BPYVhXenNNd2ExYVJLbk9WaHFLVlJq?=
 =?utf-8?B?WU5aVE1DQkFhc0ZWZ2tYdDRpR05rU2xPVXczVXh6TWRlUHRZY3VWL21GSjc1?=
 =?utf-8?B?MkQ2RS9FTjRzTVhsbmNMQ2F1d0JvYUlkdmdBUTJKODZ0d3RKcUxEb3BRZVp3?=
 =?utf-8?B?THVheHczU0FPQ0ZSWjNPRDdiTEFPTnh5aTg3blZmZ2NlYmgvbUgrckpXY3JP?=
 =?utf-8?B?U0JaRW1CbU0vbHlvVS94d0l0cXZEMzcxVmdFbFBmbUsySlhkbHUwbWtoZ1d5?=
 =?utf-8?B?UDJoZGdkU1FoVmYva2grUEVQMHRLYjdhMHNyY2JOOTB0ajkreFBGbWNqV3NO?=
 =?utf-8?B?OFp5RjdDSlpvY0t1Rmp4TkpxR0ovR29qWndhRDR0OXJzd3hmZ3VRRUd3WVJE?=
 =?utf-8?B?V0N0K2R5K0wyTkR4RFRadlNha1kzTnhHZ0NFVFZzYlpHRlQrZXR2a1pQQ09s?=
 =?utf-8?B?ay9NUEw0MWJvVEFFUWZSMzVjdzN0ZEc3Mld0UDlwV3dHcjA3ME1KZWZRWmkx?=
 =?utf-8?B?a3ZzY0NPTVdLQmJlWTZLTURVQ2RQRDhZelVkTW5xa3dQcVBFVkkzRmFsV1N5?=
 =?utf-8?B?U3Z0bVBhRGNHSCsrbzY0SmlidTdGaklhbVBoaWZKSEtaZ3JYUTNtRi9INUtC?=
 =?utf-8?B?ZmdHMUpKWmpLRjduenZJRFJoSkgrOFhleCtIek1DZkdMbVdJQ3RLK2VOb0hN?=
 =?utf-8?B?YlBlSU5seDJmMk1teStETFBnY3JWL0ZOdFZGOG1HWDVEUkxSeDJxUWxxbDJo?=
 =?utf-8?B?d1hsaHlaVkppK29TYjNxZ3lna2JZRk1hLzlMNW00M2NFaUgvbzIwVm5kSitQ?=
 =?utf-8?B?dmR1cURCN1AzcllqTGw4YmJpYVY0bDhPczI5WVBzMUZ5eWlJMmcrVnJ0a3RM?=
 =?utf-8?B?cU9XZzlHcGpsZHYzcU1tU1p4ZlplaXNvRXZyZlNaQTRYR0pGUks3dmpkZEcr?=
 =?utf-8?B?c2xZeWlYRThlZHZjV2FNVDVTYTY2SkJaY3orT2Z5ZGpXZGRpNC9qM1FIM1Vh?=
 =?utf-8?B?MjAyY01zRk9vRW1aVmZEMGpuUytXSkdoZ3p0ak5LMnhwWWJSQ2RUdUJNQ2lv?=
 =?utf-8?B?QUhQRzA5NkFybTd6YS9xTERQOUVFVTJrS0lzVkNEdWtCRFlCU0JQOFQ1QUk0?=
 =?utf-8?B?dGxnTUVwaFNjbm90eTRXWmFzM2ZqMmdBNHlBRFZoK3lHL3BOYW5lRmFZcjlL?=
 =?utf-8?B?RzRzczcrL0loUW14bHFEWmFaWWJ1ZEJIODVUTlRVOEJrVTcvMkdlbDE3anZY?=
 =?utf-8?B?emhMaTI0NHB2U05iTnEvd2hzajRreGp0SlFQdWl5eHQ2YStGSjU5MjBZZFhD?=
 =?utf-8?B?MlNuWFRjRG8zbFYyQi85SXhDbGZxWEJjVWNjMC91YW9Wait5V09hUmdsc1J6?=
 =?utf-8?B?WS9YdFhWaTY3VHFERGRDeVNSa1NwRjdXK1NVWWVRcmRmMnpZR3NDTHAxazJl?=
 =?utf-8?B?cFpSWUd0Tmp4a1lWeSsyV1NRckdkU3dra0xmNjlibjB3OElEN2lZcUVMdmg4?=
 =?utf-8?B?RTg5Z0VLN2srRWdjSXplNmt6WUt4ZzR2TU1uWWxrdEhFZ2FiV1FKcnZRTjhn?=
 =?utf-8?B?b3Bsam1TYzZoTHdOVXlXOWkyaDA2UUZlb29teFR6R3VyNmpRcHQ2eW5jZWsz?=
 =?utf-8?Q?9CbA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8126c07f-50c3-4958-c945-08ddbd751f89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:41:29.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkZyXp1H6TKh20WNAtGTiaBTco6hW7nu8OvDcorUmZWuDGGCnnlfxBKQXnAV4AkhbbP2aS1MUkBFDL+wcsH+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526

On Wed, Jul 02, 2025 at 11:19:36AM -0400, Frank Li wrote:
> On Wed, Jul 02, 2025 at 08:25:17PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 02, 2025 at 10:40:53AM GMT, Frank Li wrote:
> > > On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > > > > Set device ID as 'vfunc_no << 3 | func_no' and use
> > > > > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > > > > device.
> > > > >
> > > > > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > > > > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > > > > functions use the EPC's device node, but they should use the EPF one.
> > > > > For multiple function drivers, IOMMU/MSI should be different for each
> > > > > function driver.
> > > > >
> > > >
> > > > We don't define OF node for any function, so device_set_of_node_from_dev() also
> > > > ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
> > >
> > > In mfd devices, children devices reuse parent's of_node
> > > drivers/gpio/gpio-adp5585.c
> > > drivers/input/keyboard/adp5589-keys.c
> > > drivers/pwm/pwm-adp5585.c
> > >
> > > multi EPF should be similar to create multi children devices of mfd.
> > >
> >
> > No, they are not similar. MFD are real physical devices, but EPFs are (so far)
> > software based entities.
> >
> > > > I don't understand.
> > >
> > > >
> > > > > If multiple function devices share the same EPC device, there will be
> > > > > no isolation between them. Setting the ID and 'of_node' prepares for
> > > > > proper support.
> > >
> > > Only share the same of_node.
> > >
> > > Actually pci host bridge have similar situation, all pci ep devices reuse
> > > bridge's of node. framework use rid to distringuish it. EPF can use device::id
> > > to do similar things.
> > >
> > > Actually iommu face the similar problem. So far, there are not EP device enable
> > > iommu yet, because it needs special mapping.
> > >
> > > Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
> > > information to each children. But when I see adp5585 case, I think direct
> > > use parent's of_node should be simple and good enough.
> > >
> > > In future, I suggest add children dt binding for it. For example: EPF provide
> > > a mailbox interface. how other dts node to refer to this mailbox's phandle?
> > >
> >
> > As I said above, EPFs are not real devices. There is currently only one
> > exception, MHI, which is backed by a hardware entity. So we cannot add
> > devicetree nodes for EPF, unless each EPF is a hardware entity.
>
> But how resolve this problem, if a DT device need phandle to a EPF? anyway
> this is off topic. let go back this doorbell.
>
> It needs an of_node for EPF device, I tried many method before.
>
> Create dymatic of_node for it? MSI framework still go through to parent
> of_node to get such information. not big differnece as my view.

Actually, DMA have simular issues, just 'workaround' it now.

pci_epf_test_read() {
	...
	struct device *dma_dev = epf->epc->dev.parent;
	...
	dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
                                                       DMA_FROM_DEVICE);
					^^^ [1]
	...
}

[1] here direct use epc->dev.parent's of node implicy. If IOMMU enable,
two EPF will share one IOMMU space without isolation. If add of_node(may
dyamatic create one). we should resolve this problem by use epf device
here. Difference EPF will use difference IOMMU space like MSI.

Frank

>
> Frank
>
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்

