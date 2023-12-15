Return-Path: <linux-kselftest+bounces-2081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B182C814CB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB51F234DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D53C466;
	Fri, 15 Dec 2023 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mKRgnA61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD53BB30;
	Fri, 15 Dec 2023 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxduouIPGL+yD9l+81btz+/sTN8+rfqStUB8S+98R92qKOQYpfNTw7AtV40zEgD6xl4OTGcYX6ouVV0K5yh031Z2FLTA5H+adVtJS3Epnc2t3ZeFHzqKfvYfB5KZuapwrBLfXipWU/qBBI6k8dedk1koXasfokfNjBUvhfQBo7iVBod+5H6B7PaHh1vCJW+HNVIE6jnUCgvTY4m2qlbBctjs71kBigvtevvbMbsEX+9Bh+l8NVX4VvjN4wnjzdyNvoBKXFbpUpPKY0eBJ6ZKQVm5Oi2kMAi+U6mOXSGQTsKSYRGKo2RGWs6Td93W9Vf3vuXxoMQ5lC2L7KWS2ck4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMJ6UtA7IBt/3joQR1ksu4sIx8mPJEt2r2xf5QaWCV8=;
 b=FuarGSKGjnplFdhviq7cHmG7U8B8Rs4t/ymmCKNd+WnEAknRMA61exqhZcAB6YiTjXW3vwyhnI1m5dust0x248ghP6IvAnlBW5koHKFuD0Olk0UW1LXazxfijlfXp/AuwGe6Rbp9c/gLz/5sOfSw78r0GWBnQ7tLp2brabILzCVdDmvwVXl7rrGzlNhcyFPz22PUguEmgc9UanMWNIwwtBxfWdLk8GEu0FCf451ArOXLq85jhj1WXW4GgFytZJu7lBo9Rch7LV6PREdusC+lDGeUkjJUrQzi89sLOe5WFTGOUOOWsXYoSbYwP0+d6h4O/gBXnwgWfc2YTjjSvCS1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMJ6UtA7IBt/3joQR1ksu4sIx8mPJEt2r2xf5QaWCV8=;
 b=mKRgnA61nvEh6bPVvtByhuGp53OSUGXXDaX8TMb2ak/egz7Rr9VZMEFoMUyb4Yk+qeJc1Fdz5Ii01Fh+T6GKzniDw5KWkUu95TNkomgGJs9pSeE93bz21hxuUvLz4G0U3GKeNwQIYr0Nj2LDhwHZNw75On0T0SWPSXfFSLBoKOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:13:56 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 16:13:56 +0000
Date: Fri, 15 Dec 2023 18:13:52 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 05/10] net: ethernet: am65-cpsw: cleanup
 TAPRIO handling
Message-ID: <20231215161352.27pz5aaatgb4vfyr@skbuf>
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-6-rogerq@kernel.org>
 <20231215132048.43727-6-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132048.43727-6-rogerq@kernel.org>
 <20231215132048.43727-6-rogerq@kernel.org>
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d4f3f4-11bc-4dbe-a2db-08dbfd88d6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WlY5jNIiPrLiXKAZlGRiSznOBRLP7uFUJcBs87qMrAPZqfnBtJsItor45+RO0excldlua52C3zcETtdA7lMlxY0Wn41ExYlFAsm78ppuS0wuM/tnp9hlkqHnfaUkaTZ8Hap2VoAgQIKw05lemrfGHIP4CLnALW1BfiA9Alrcijdt6XLb3COXyEb7MTUxLbDS6KaeYzp4ixz1Pl4GcAdlKHsU4sgcOrDxIYECjnmY1ifMkUejFqr6SlyOMS1VA4W2q8bSPhZFOZcVTSSzx6cUTOnogZ/bflbDTje/SKlEG3d51U8x5T2UgSL9ObOCPWbFoWt54M08XXTTEXHOmwsaYkp1+JJl1rlhUaAZmJyvWJxLGCsgWqO8Iv0Sq5JUzRu/EX+TnocORJ+zEBbEEH3vSHBy1jD2VH06qO3HZAPa+Sm5Xy0RR2+TPcbLbn+FiZI9wz6mHb4y799nn3iPZRC00eBONhBqWytX2/uyiJv7eMR0bRXGc0DiqI/Sy8DtlgUmmkihtrb8bqsidPU5C+HoCa3mdlMl4y2C1d5TC0+zFrIGEIGtRph61ZGBSP0c6mFC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(33716001)(66946007)(6916009)(6666004)(6486002)(66476007)(66556008)(478600001)(44832011)(86362001)(5660300002)(7416002)(316002)(8936002)(8676002)(4326008)(83380400001)(6512007)(9686003)(6506007)(26005)(1076003)(41300700001)(4744005)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MD8/ID+nqJnIv/gjZLR3HrKzm9DKCCbyTjrrhdElZiQbxansTrUOh3SZSU/G?=
 =?us-ascii?Q?AYr4BtOQFl3H+KjBH8kV3KOCqfUXLV9mg/RNlQzqBpydvx2Ligs4AstWVxfM?=
 =?us-ascii?Q?mMWg0djPBC1X5GWTpix/wrXJoXeYW1I3I499HFDFDcXcVCo+4Imd1ChBVFex?=
 =?us-ascii?Q?OdjcTNj6rwx0jOR5Cckr1JBEAcrqCNnpnNA1gOjqTIrcNZjEiD2YMZinVMgw?=
 =?us-ascii?Q?XMe6wPS/NIB816v2ptUfoRl7LxDf8qsUWGEFJaJVLOlztIrSAjktXJNWp2U8?=
 =?us-ascii?Q?7vguyC7B0Ypc8r515FrPcL9w+BfEfwh+8uWF9XXdTz0FvqzrIbT2uz3BTaPX?=
 =?us-ascii?Q?GKgBSC8S6ya5+jbRvHAud9LgQcpNOs3Y6DiHKH/UYBOmjf5r+LneEgl91Ncy?=
 =?us-ascii?Q?XbW9vBpfkBLnGRbNAnQV1VagtGHcoH01VzAsoZed4zvYSL1kIPTRLr0WbxC2?=
 =?us-ascii?Q?wyF1x1Zuq8w18FHx1oFbqI9Q6JYUe4PCJn64fFPJarTVwpZXknheyx9rQoH/?=
 =?us-ascii?Q?2NV6d6lNtnzkB5fAlIWbyVKFCUpX75AivCfhfylcMn7+OmHUwmJ3bidQfZg9?=
 =?us-ascii?Q?ep3RF76wfdQgdXtH1l0bcSnTm0FDHEzGaUDvjyrBVHGgTCfAeKeHoMOrhe7Z?=
 =?us-ascii?Q?F1SnQSm6l4rb7ZC/1Vtd3XKdqONI7vXwWZkEzJ+IT6UcQ7cw2iqejjjOrtk0?=
 =?us-ascii?Q?vYFEMqNDJkI0/5VW4FRsMajCQ08eCFQ0IGlLlxAydj37i6B+GVLKKsG/o3ZN?=
 =?us-ascii?Q?vSZL5oiD4jTuwZKwhJQ3xh6nBzu+BKejPQTV+LmVETKBGP0OJZt1GnjUaiXE?=
 =?us-ascii?Q?SMgWI0fiv8rIV+aJca43t/xeyN2C1rWwo11Z9K7t64t+fpkfCSWaaVCxtN8G?=
 =?us-ascii?Q?bhbacZYX5Cb4liQxqqPHzm4BjHqpScPMmTEfL8/Pisji2jXrrvXevoehtWx1?=
 =?us-ascii?Q?CKrRtby4wFZjj4iH/nVxxVNK508F6jQoiHWe6BwNVEi+mM4DykEWnjLi3nFO?=
 =?us-ascii?Q?TyOPo7UMTxQTnxHJOV+SqMhtJD4IHkk9NYTkMYnKwx+TZY1HrfQwOTPzgOvZ?=
 =?us-ascii?Q?V3h+jg6v0bL0Nr3YReKgNwXLtDMPpDVQuMU++U6RZd5wWEw1+ic1K4pDKVnF?=
 =?us-ascii?Q?j9pb62dD0O2p3+5rXlUdFB0lWbLmd+OlM6VIPyqAf+YavLR5s/k/03COJErV?=
 =?us-ascii?Q?sKzcOZR7xKz4Ox2EO6diSl7TKCPbG3SVCeC7kHF171Q/a/eocnlrDuxaTDl/?=
 =?us-ascii?Q?YDdDtblyLHClDDzUnsp8pQZjyMNj6j0mqmqm0+ngnOUdznWf4QJUTlXz057v?=
 =?us-ascii?Q?E5xt6aLYsKkYoSRqtm1SA1jfQwoMm8qMZZbAKHcVSVgHGtrHDwTz8ZQipMH8?=
 =?us-ascii?Q?qQcW8etUAZEgkCyRQCBazbhLcrKeZdMD+j6FuUpFPUmhgqNg0Tlr+b2TunwL?=
 =?us-ascii?Q?ijY28LGjWkflpWahU7CRsqL4lQCA9Qv8qbwnowh0eCBOs1AzEIh8hswCe9KW?=
 =?us-ascii?Q?qfcIS6AkuodV1SzQ4e5jZIoYW2JdBfyyuHbY4ySD88DqDeocJMyy4tZrJN5n?=
 =?us-ascii?Q?HogfoVMqmrt4fj0tu7v0tqZm2s2CmFbERFl+2cZSAq0AqTUFqXCJr1V/cip3?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d4f3f4-11bc-4dbe-a2db-08dbfd88d6a1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:13:56.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDNEtaJA3HwFwId0Y5i4yIyrmZgl2parDy/OT5yUoPljoczJBoaZmUHuRxMeKFgRCA2hj7z39gjIaFIwjvnWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653

On Fri, Dec 15, 2023 at 03:20:43PM +0200, Roger Quadros wrote:
> Handle offloading commands using switch-case in
> am65_cpsw_setup_taprio().
> 
> Move checks to am65_cpsw_taprio_replace().
> 
> Use NL_SET_ERR_MSG_MOD for error messages.
> Change error message from "Failed to set cycle time extension"
> to "cycle time extension not supported"
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

