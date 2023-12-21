Return-Path: <linux-kselftest+bounces-2299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B180F81BAAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCE1F214CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FF53A18;
	Thu, 21 Dec 2023 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Or29DBYv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D11539EA;
	Thu, 21 Dec 2023 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4GNZSlsYlOlHDyuOeUN1w7W3MBZX2CQYDYefq1O+GG/9loyyOoWLcD20YAZgOHoVQRaXLp/wA2sLKhZn/qHWXiU2u1KnU9yh4yxaluDbky7nNitEB91c+lRJGj1YkiegaIwnX2kFAi7Si2Rug7eC7H29f84uE6g97dRNDzF7zjDilspBbzxs+sHe3kf5VFDf+FrqmyFyytGjZPLrtLy9VPDD7Nht/jlQW+CsiDxMTrKc30jsogzS4Es9Jab3EpRCggv1kHJJxIRDbBwI3hVp49sza3yTQbdkUGDnhDvrMLP7wwdiRs1lXS/1nWU+5GqGE+TeV72PXsqUCZxivDYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8RacpBiT+l7FpBNqT9HS0eotUvqnNAQNT8Hs8Ytc5E=;
 b=WibYmurw026b9bXqvTRpRo+iI7UD/taJfmzq4+kmOX1KJy05C2Uv/X769JunyASur+ucp8cZ0hiREYWIlg8Xir95edum/T8dsfHlEXRIZoDvc1pqeVP2vhveBQwTORRD6/LxA9WcZ6PER2mATWizEM8Lqq4sfRB0cgnRRr4vLUrQqB9+d7x2A+ZiJ2/iFyf5ELBaQNLb7m+deJFW/8Hw5hHcqOxeVkluc7wKlzED5UTU57v5vBlDW7yAtzIYK6jSWV+OHr3m5Dl91qBdrMYu8rhqXf7UWNwSYx60ogzbvD2f61X1kNQY7TDLpOnMIOvNm64Cd9Gk+p9eOtQ7/Ks2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8RacpBiT+l7FpBNqT9HS0eotUvqnNAQNT8Hs8Ytc5E=;
 b=Or29DBYvMEfJV3Z/qVSGOgqSGUVCkkic63pXYYFHsY7JNHRA953dQDUxi2roI87AqjJw1uVdHWqJ6fA9P8RCfa2aEoSp53b8tHky3L5msYhR6J7go4Yw/G9YYH8UP4O9a5PgYntIsOQsYBQ6xpBtd1u9QjZxblcUBchDnyNR3/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB9978.eurprd04.prod.outlook.com (2603:10a6:800:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:25:10 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 15:25:10 +0000
Date: Thu, 21 Dec 2023 17:25:06 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 02/10] selftests: forwarding: ethtool_mm:
 fall back to aggregate if device does not report pMAC stats
Message-ID: <20231221152506.yk4mlhyv2zkv57gc@skbuf>
References: <20231219105805.80617-1-rogerq@kernel.org>
 <20231219105805.80617-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219105805.80617-3-rogerq@kernel.org>
X-ClientProxiedBy: AM4PR0302CA0011.eurprd03.prod.outlook.com
 (2603:10a6:205:2::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 2177f6c5-f9f6-4662-9f32-08dc023904dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fJSf8KvhWgSqZbZDvgjmDgLogzpFdF/coYPOkOyn4QvIvgaCGeUJQFlASBUUL/w68J3eDmxvaeHJ3NyU8/JuGnyO1cMZOm6YD/5kCdj7RymxJRttO7l2Ch0a0/+O6Jhd2FSYnWdDoVaJFUHG3BmCJE4EDFQNjNOMDQ/6uYOFZ9GZe9/wWE4EcEm9fjOQIUpv3JS8l+qpMYiiqHUfA3Qp3aNI5Ls1a7nTFfid+ZGUEbkTrg9/Hl4jsoS6qYSAxKeqoam1CdyykkzsHSzR8YMaCjEoiKYOrrRnVc1hAJxW/NDJmqIrzwxiJSpG+pbbhyiK21WIO2xRWRFKTtnmIJJoeWQeXy5W6U8QP6V4t8idpbAqtpV7jxPaYiWop11UiBePXIAWG6bvY+rHBpBqHjtGRWCg1YbiPmbdFOTmaz+Q//aIlBeHfm8aXEongAQlmuPe0p9hhEVFBewQbNhqX5NAjPY4c50HMWGSN26PG7vqCGsNk+yRZTYooe61orkFr2ttUruJdDtetrXEKn6imrNsxr/1+Kd4TZURAvy51F08oy+iWT1ZzFSGEEKxfDOyH3ct
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(9686003)(26005)(6512007)(6666004)(1076003)(6506007)(86362001)(38100700002)(7416002)(4326008)(8936002)(8676002)(41300700001)(44832011)(66946007)(6916009)(66476007)(5660300002)(66556008)(6486002)(4744005)(2906002)(316002)(33716001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9nBfiQb5SdiqBuBQyZ+49/SaDkVfhtuKjMZynn3NuuViR3o6/KxdFNwGZlH?=
 =?us-ascii?Q?3ThzdqFQ9su7TIboj5E6L0B2meAsi4As2Jjycvqm9FpBtU6wnLxz01bEIJCE?=
 =?us-ascii?Q?3GHwqXIF3g2DaOC+I5ud9dFx+ssXxBrHFvjd3x4Jc2eorvLhnBgKz/6xhQ38?=
 =?us-ascii?Q?OgViPOIJ8qOv8T8yHqUF5y/nejZ74PRfa9j2+MQEw28OrQ0HUiJSGYTaf/RO?=
 =?us-ascii?Q?xyVXcMjV9FxbYTpcA19J1qdwuhdAg23vM/VccFRBodDxv/g4dhUOKIXtrDGb?=
 =?us-ascii?Q?J01ZW7oqaXQ0IJJLkzWEF2lHImHEA3RtaZHaWExCZ1KkomuomwqoTECNRJiS?=
 =?us-ascii?Q?UD/fh6Og04mbpWMgFqUklhQWxsRZjHtacgEsV+H0Tss433RB2CCA5WEXKbNC?=
 =?us-ascii?Q?Hzpa9FbfpSr24F0j+f/W0DeNJfFKL/AR+HkG4MTRGpRz2exRcKwXz7aiYIpN?=
 =?us-ascii?Q?m5Jfcd0Lux16TY78jZDFhfIBAX7uEIb94x7X1U6KaTQZAaQV+siTIffsSsrz?=
 =?us-ascii?Q?0lEaaQPuNCVFKHcKVPLc/fDXMJP6ldxVuh38oVXworQ+lXkg4ZAeUi674Nl3?=
 =?us-ascii?Q?sDrjbdOEafed74zCCeBbfrHWE0fIZY6Mq4mEwYj3UIsFiiOCA4nftsT3YFi1?=
 =?us-ascii?Q?BnmRhbsFgKr+0NULNGQMMANnBwT9hug2yN84S+kraXFh40jifTUjPcMx5K+F?=
 =?us-ascii?Q?0s5PyskKET/ZxVFuTJU/UvAM6W3xtJnVtnHIiJpDDcQy8dtA61A1Emzlm7W4?=
 =?us-ascii?Q?7lSag9s6+wylgcG6Y0VcWQpe3FSwOE89uRDkkwPOTElVDiVzTXQA8l67zwcY?=
 =?us-ascii?Q?2zqZwaytACi/o1w6SUXWag9SvozII7/vpvq6nzwczcGHqFeuL/khouEXTuZH?=
 =?us-ascii?Q?eATryqnJpxg23VOLqoU4ppGTEJ+w/fU+cO8604AEgJPbmdGHvOW/ICny05vR?=
 =?us-ascii?Q?fCnxydOP5UDTya02yl+bVntCN5snVHfJiKj45+JNQOXTKWPAutxk0+MY0Jlt?=
 =?us-ascii?Q?F/Y8vN5D94rj82Ah8DrC5vYQbQjetHb8e/119C4U6c00yqQJ7SVGCfwHLfbD?=
 =?us-ascii?Q?+9T2/MZuZltelgood8EASmyNqh+H9zpfYch39Fmj/7JF3UwLmeheg/oqWi+K?=
 =?us-ascii?Q?QKHuwEqOP32xLqg31mW3gH/LT8TqVlJnM1o+Z88R2rrThny6TP8uSPMnjeE9?=
 =?us-ascii?Q?adtOWBKBd/BQngTaOE/vCAY3Yup96nqHQaIibUOCeZKz/UL1pnegeuBqqDi+?=
 =?us-ascii?Q?P2+bKlc1RBe33tWnch+/W0BrvA2ZfBTmlJH6SqbgL+FvxzeSgkP7qKAa0jZp?=
 =?us-ascii?Q?tZvz0bMijXM780jqN/y8BOJS8E5CyWkK0fiRQ3HQz6uso4Ft2TZIrnHQzSHY?=
 =?us-ascii?Q?8MzFxMgiXLy29tCWBh3R8c9yy/xgDRG+uzKnGmwGg29Lho9tJHO2Z1+bsn42?=
 =?us-ascii?Q?5A04yoOj8His5iXMrMCOaA/KlMXIKyH68r7+JzsIYYFaWVSCLNE4u7gCVJTX?=
 =?us-ascii?Q?xzDlWDhAGlbw9rVRnxxlJtO/umbk9uTQzwVLVpv6JAEN0RXsZ4sBs2a38Lbv?=
 =?us-ascii?Q?Ik2vINT7b0FDXkF94Zp8YTufAk3JWsp07Hq2qW923usTZ/APpvqeedvTRM3Z?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2177f6c5-f9f6-4662-9f32-08dc023904dd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:25:09.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiWbGrw+F0uS/ML55C+JrHKwud8rAmc6ZkzHHbrPsBbJdPd1uIumlTWSKgeqsWW1qGSi/R+MZGzkI2Q1a8w8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9978

On Tue, Dec 19, 2023 at 12:57:57PM +0200, Roger Quadros wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Some devices do not support individual 'pmac' and 'emac' stats.
> For such devices, resort to 'aggregate' stats.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

