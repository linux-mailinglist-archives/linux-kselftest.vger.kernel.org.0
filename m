Return-Path: <linux-kselftest+bounces-2079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B032814C92
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9271B2346C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EC3A8ED;
	Fri, 15 Dec 2023 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YOZXlTPv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D33FE2A;
	Fri, 15 Dec 2023 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl7cVZX6xA0yITMMGB0Hd1PtQDozqqUw/z9lnjhAFf/Y9vBNcJC/oCqDYGqpUXzTLsiWvAtNVabUiLXEr47niMaAMC2GGeyKkpyp7KybsKS1WXhQ5qpI2CdTG9hNvbEAvVHd/lCOohcWxk/DeeUw3ZFBflmobXAj2x+X/OPPPm57LK8m/cS5CYGqf4I7goITtYjb957l0QWHXNqcZSni7uzy//gNIaOERQb+FggeKB95NidM06/8/Wi4rh4QNDPPtt0bt/nNBuv8B8RpyFyDpHxM4ZcWehJ6yZHxXhGlZdzjYILp/jXBCwlAcuCvfS0xDvaR2JAWa7HuRtrQFl9NiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/kqCaitJx4dBDXXC8u8LZ1aFE/q4rt68gjBvQO1h3g=;
 b=Tr/6jKo69XCXaS+QKp+yrLgIYBY6s52k0GjHnpxmhrBAfypT9ZOnp1sElA4+bBUAylSTqQJf9X8JHu+vSFBmODJyxJI2o99EH1mQgFC2suU2axVmXvbpmDLJttN7PY3o1f1sF+G4nPyyPg2c7SBXAyAmnFx8nQBMHiVryiyiE6AzSFZ7uAnxfOR6GDOgxYYrIb1kqyASi4mR8AFgqjWCjERjXu4iP/r/eLl5hi/OqvheBR+Mz8XQMycg0R376kw1zI3gTM9CPT9lyBS4iqXr1b5/pfBI1Xg/GtDuN4SzyEBfDrvx1JpgevRzlO7oMtuaTR8yBXJujprC2407WFa31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/kqCaitJx4dBDXXC8u8LZ1aFE/q4rt68gjBvQO1h3g=;
 b=YOZXlTPvtfJIfhslcIjRcy0hPvqDnQV06hVUQNxGS0atXD/twLvsJ+6EoOEDM8OzAvqmtyRlSXdEuRboug/fsoAEEbIxXynuFKDfBGu+X5WU7bSS5FbHAUkNPG7qD6pVcNPsUY51/RxWxFgMA1AxlOcO//FyT95tfP7k7oTuAgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:10:50 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 16:10:48 +0000
Date: Fri, 15 Dec 2023 18:10:44 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 04/10] net: ethernet: am65-cpsw: Rename
 TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
Message-ID: <20231215161044.nz5alrnc6pktrezs@skbuf>
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-5-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132048.43727-5-rogerq@kernel.org>
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: c818ffa1-1737-4a72-43e8-08dbfd8866a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lAohHC4kdxi8BLT1IJJlnZ5VVFHzL6IKFFpVuGFunUfLV+KeGpALHcnmI9TE95esLYwLiFbq712or7ZKB/5dwDsd7518Rjsj6+fBVC/OefhaXxORPmW6QqwPZUi/bNb2mSMKCZRivigTuaiuA3vctZBZ7arF6uzBAqYbogSPaaeRkEgpnWcI+NE9A+z0nroxPrh8ZOj0r+XQSO9uNLVBTw6y9/nTD3BtG6UDIvY7/kmavnevxvMRgkF1Y+quOXzlQ351ynMjkmsAeLp0Ub8L7pLpaRA70lC+f9Sm/BI3n8FD/OFGEdC/nnMfiX9oEwLdH634EbaMB6rz+W4PWqg6PwwzWbMJiU05E3HwXTKX1HQG8jxBWBgnC5u1F/3TwgsaiHKX9YfQ8zVkA/RxQb9mpnX7FItuYBG68cjMUgqLLhclfpeuuqcNxPgBPFx0a7YPkcUI9i1Yu89ratrm9u7CiPJgsSvg8Y3UZSSUKYC4X8NRvTGUPq0xTeiqVbzRQ+g4WrFA1wHSVgN0fwX2jjWDpIltKaMS9aX6JX0C75fGvIkjq1IHQYxMUeec4mAxdG9X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(26005)(1076003)(86362001)(6506007)(9686003)(6666004)(6512007)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(4744005)(2906002)(7416002)(8936002)(4326008)(44832011)(8676002)(5660300002)(33716001)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAItwVqWi+i1XitWoFhSfY5m4cuFK9TjxqtD/5x05Fgy0OZTmZ/dTw9UtZj0?=
 =?us-ascii?Q?dagHFFqu20ZWSOheOHyVVmMA0fvuv302zrg/9OoXxEkui6rFfl+fz5Z5kYly?=
 =?us-ascii?Q?pd7IqpmLMgG2AILWfJ7HFWWNsFVyT0TWH3N5A0E7msmV7p5ky9gC3VTi9/1Y?=
 =?us-ascii?Q?4FeOlxVyuhd3scB5rMWl3oX2Tr/ddJe0rpqS4K+YDLJYEnZf37eIzWVx+6/F?=
 =?us-ascii?Q?WGTNTGYpSNvVH3Q3hoOu+btUqX9tL+rEMohv5ZHJVN9C367JNmKQP+bvliYK?=
 =?us-ascii?Q?KcbfZnBYWv85s3+gXWLGFzmS9zS1nAFxzFI3nmKA2znaXaG+JyR3qG1KIxiJ?=
 =?us-ascii?Q?PF0aflcbW5snLdbKwkXtqawGPt8jjwaFQePFQZWxocrMgl1FeNpSAXRW1AvC?=
 =?us-ascii?Q?Nx8uE59CDIxqWItwZ19Kxek4ZRvuh06XiuA1TPN6kDO0kiO2bf9jolnFEUP7?=
 =?us-ascii?Q?xvwOdDoA+i5xpIV+E53CymlRz6apij4kFhYMHgwrdiJg3OIBu3CdqnGi9WYz?=
 =?us-ascii?Q?TeslwSeB4xtf6dGCYAfs3vcZ01AO1+1bxDvT3P4Mx2kudcG0zRlVC9rDVPUX?=
 =?us-ascii?Q?n3QUCs+mk4CylMj9tqhp+70hclx7fUaspYc0W6mzOkGy18U0w8OJZzWbBJvD?=
 =?us-ascii?Q?bsc/Gi0TckWtgXzapxCfmaAx5v1bmL6/e5V589/jHt2I8T73OLbpXr+MZR7H?=
 =?us-ascii?Q?Z9moYmBkUpi3VowzkIn9FXU9cs/18br8wIS2QzO4t4fp+HkZb0ZZEi2KLHCl?=
 =?us-ascii?Q?EKWnA4KNJsNogzG4THA0w0pm4NRbJ0FQaepm1hAoC0Qi4yVA0w4Hqo1Sdic0?=
 =?us-ascii?Q?KniMBpGbH0ppH7tQ+UqHZIsVzkZdKOLvD+8MW/Mr8qzw76w0YqhVCljCtoLv?=
 =?us-ascii?Q?4AJtANWKnx5R7ibkOMlVpVVgsKnNZbRufJSwcU5UGQLdDO0nOoFUt+BaMaK6?=
 =?us-ascii?Q?eb+65xfPIt/kNVlwvZHHIoeUBuGFl6UlQiZHBIOKOU6Q4ZoHkhtX20lA6xu2?=
 =?us-ascii?Q?lrLdD2G8KkmzDpZs8gllsqy2k+ZLeRugp0JoBSP4WQRJPrk9h3vAhNDlHeWX?=
 =?us-ascii?Q?WeNpWKo3fNb8+HAzTQOE/CrCLf6dx2cBNaYlXK7lKo5ElsWRCXLZnIU7/Ul9?=
 =?us-ascii?Q?RZLByFA7qwNcPHG/ddPZVN9KceInGYLbjxeWh5I9q51tbcP4A3CMWiNP9RMS?=
 =?us-ascii?Q?F261oorEQmLxQGaEslRJPPI+qUrXE0trl4oA6otsIp+z/5sxv3rRjfraOd16?=
 =?us-ascii?Q?aAuLsO33iYCqqFemKFw7KFWwjTjuZdhYeIfQ3D+Y//Z/hpXbAMWv5QPzRRnJ?=
 =?us-ascii?Q?Gw3Iuk+p7aGQJCkKXEcRW45XjkmXm8LS7Qlnm0rjyD9y6m7cmic/orAky70A?=
 =?us-ascii?Q?IzRrX3KVXEquLq83i3fQjlU8sbKGA6EWuZg1fz0dT0k2XGaFp98CJYvKak81?=
 =?us-ascii?Q?llJZl7mDP+823J5eKF04B9Pmv+RvTx0Q0N6Qoq6iPuDfEHNMQW67gsZ7PpfE?=
 =?us-ascii?Q?slW40yyboWfRRno7M6Iayrxw/hlVNK2PP4c0CjRVCqx2LKi+y3VCgqMZw4Bi?=
 =?us-ascii?Q?+nCxWerCNDt2lmgeCQsegLQf7iCkFOSW2SXcijdtRo5nLSrlkVuiZZe+kd10?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c818ffa1-1737-4a72-43e8-08dbfd8866a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:10:48.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcgbYtzIWz45d1l4BmI/nvw85oSJe8d+1ZU3I+v3+dJZJXPhgw+XLvk03DSaSjxxRX2gdF3OAqSJ6syFWbx9VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

On Fri, Dec 15, 2023 at 03:20:42PM +0200, Roger Quadros wrote:
> We will use this Kconfig option to not only enable TAS/EST offload
> but also other QoS features like Multiqueue priority descriptors
> and MAC-Merge/Frame Preemption. TI_AM65_CPSW_QOS seems a more
> appropriate Kconfig option name than TI_AM65_CPSW_TAS.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

