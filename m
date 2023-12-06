Return-Path: <linux-kselftest+bounces-1285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22F807076
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 14:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36AA28176F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46513714E;
	Wed,  6 Dec 2023 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFtiiD5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886AAD3;
	Wed,  6 Dec 2023 05:00:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuRmP1RF3zT7iakkju2+7CFbVY0El6eqVN5zVNLX4vmVm6T4RPm+IVe+JhZ19VZRXSKJSZCFbUcXYpRK4AcujVt3ZfnUuV4P628NkQtvnwMj6Q5Efoe95yQrNyLhYCGF2pKHFcJs1tHEXGHcBsTS3cMpsLOcR1riM4awASX/JcZWu+IUqE7/VvHpSROP1XI2QSH8wdrvi79VLUXy1WEJm2ku9xPqCP7Vi1KF3ICV1+v/sjYo14tkmTgDZ7OhelKHIGncnH6y8bT5XeQAqerIvk+IFb1iXmGQL0QkaNgXYEez528s10vLpbR7QN6t9iAiSMgsAeoconsylAtaYUisVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ahszf3fFN+01v282ZyU7MlDk8NqwghTukHIzOZ41GQ=;
 b=AFEXTZVXdBO847PgndqNqnoJs9VIW+vwX6gREd7STgrGsmpT84L8OdSGgmLT9AxCAbuJqrxWN6GtTJH4a2BgzZf7Wl0M2KB3guZx8LVOK5o+uDpE7X+qRQB1QtJB73c+4J3roIlo7PsPws1aGlWQQ50UWGqFCI7DbTgKKZ8RjD4HduYR4q2G5dYda3bRmo60KWkaVt1rjrFU+bZqNN9MtYY8eUq499OQKhJYJ72kYFUPKs00sUMs1DMCU5X5xw5fNx6aZCCgIuuA0/aEDz/fTUpFYY79RjMTsAvbFKpnfBl/yChD71bdI2QC3oLZmsFvUjf1fMogYrOuFnzDVdzrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ahszf3fFN+01v282ZyU7MlDk8NqwghTukHIzOZ41GQ=;
 b=iFtiiD5hSxtkQhL7lSM3E5v2ZBeEXN6CqCSzpwWpGAhJQ8GBJDl2lq94ba4JZtd4HUNlhTMsta1kFKm36Ud6yQcwS3/y4/2wPwWQ7u9dhTlj+JzEn9jcmKRDu0Aj6skdyCddE0H3WpYXTR658QCnnw+ZyextFSc8xGS/miXhDDtgBmtc0M/mVG364AyjKH2KxCUk9uUasGrSmpS4iykC9efmCcNfgYjt11uroSi5tirJ0rIqykPihpMsNuc+3RVbrm+V/uYx4GZLo3dO3h2ImuAZHTIIhC0z1Dy+9otj8I2BSnS5oM1dH1id9E8Y9liDKdGkbt6cmMxTRHZoZ45Mtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 13:00:56 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 13:00:56 +0000
Date: Wed, 6 Dec 2023 15:00:52 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH net-next 4/9] selftests/net: convert
 test_vxlan_nolocalbypass.sh to run it in unique namespace
Message-ID: <ZXBwhNKlvnTdLX6q@shredder>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
 <20231206070801.1691247-5-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206070801.1691247-5-liuhangbin@gmail.com>
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: b87bdc47-85ca-41a6-206b-08dbf65b6309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CGXSp62jJ+3vXOVoTpijspGVoSoSKY/MpjfVuL78Cs5UWNsX8C6PAVZ9WCIMimewvZM4+d2ZAeWGmrdvG17ggd3CtikymcYz97uK3xsH+frAuXpQXPSpZk0Ug0P97p+b01fSTCGgcaAgoFbuVfs2JtcID8pGxP8FyDq9SY/0QeTsbycB9Yw9bYwtXAedDMUZHZwFCXyP67lNZ8ZC+az5n8DALQVHizxpiCC/K6et66fuJWZmDOIq7eh/3mUWug4lJdjyAIgQfiP3puIblGCnclDiDgrnKD2/rpbV8Gtxc2P+5hxoKg1JB9bSeRg8RO+ia/UIMzlXGNPGh6lC25hkFRIhWN9HNn/cWw2gqVsB3xpvH4ppYlQaXidUOxaIGtl0p8w+2h71CkLrShcyX/q7L1clE1E8W4RHO+PSBmHPsk3X/iZX48+xeUgE+i9wBGi2zM5G/6D0CURE5k604Y2Gu2bYNSe7wiJVt//P7kJsNwF3MzhkTQ6rif7a2EleKY2kzmvoQNluoNp2SxkZMRevWe9MQq4+lpARDBTQCKD4tvNoMxsAZBwkO2JkDJYpaOj3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6486002)(478600001)(6666004)(6506007)(107886003)(26005)(6512007)(9686003)(86362001)(5660300002)(8936002)(38100700002)(8676002)(4326008)(4744005)(2906002)(41300700001)(316002)(7416002)(66556008)(66946007)(66476007)(54906003)(6916009)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CJ1dNFwzISIfQuvVL7mibLcqWePKKZhSmbuJYKIc3lRnGIax6A+h07NaUbg?=
 =?us-ascii?Q?ybogPMLbqXTriEt6uXKXsoaj05MQSD0AGMi8uE/R4ASOIza9Mby/afl8wDOU?=
 =?us-ascii?Q?QGXs8ydtX2mLYvrmnKCdfnOnIBYIE34UUdHCFOueqrr3IUvObpAI1K+JUBjP?=
 =?us-ascii?Q?n6LgczkzYkgkXH1CK8kiaGS11kMzLAr5udYCS2Zxhi3gO8ObGyGuWMyHwRby?=
 =?us-ascii?Q?Z1qAGrppepVTd4Grn+lqfa01Py8ynJkpFVP/XIfkfnY5OXUMRCM9uSfMKmnx?=
 =?us-ascii?Q?IAjtkrF2tO/AZ3gj3vTLD6UA0C3YfQTZmTiOuKoAOTvc15LPI2fdkJKh/WMf?=
 =?us-ascii?Q?JPDy11Os+TZD3UTgTPhbRIYyg98+lGRMPpAamxVghJeYD5N4592AMfpJDJ0a?=
 =?us-ascii?Q?WhkbwgiydeeV2Jkxg+1YtYWOKrzb6k6PhT2mId7nMOD5Wy/UBh6tp1NRNz8s?=
 =?us-ascii?Q?XoqwrfXdntJS3HAqCeotJqPxJY4EOxdym8bjF2fZDIdq84+5qgEWnmMVGWXD?=
 =?us-ascii?Q?yspP0vxyJmaycxyjMFh1FQzu4N/D0ChcNua1iDwQcrJdMU9Gr/+XNaUjdsYK?=
 =?us-ascii?Q?KyFbwxK3LHd09PGIF3HFxJSdw2Tr8N+MtXW6SiRgT+qr9qfBk1yCpTSUkkEr?=
 =?us-ascii?Q?4IpclRSLPtG3o1WLFG88rPLKY5gyuI24Rra22PGUJFlY/sgXrSzUL3GCrOK5?=
 =?us-ascii?Q?rQIpt+753leabe+XsdAPRtBagtpusOABQF1mkCaA2V/WxNleluo0GbcbBCHK?=
 =?us-ascii?Q?WAsZFE1IIyyoyagNczI0fMx5OZDg3BRm+unwormA7AkuUxKJy6mv8xeI7fzL?=
 =?us-ascii?Q?HVwaa7Fnraept81+HWJHDfseyL6ngN1Uv36Xypif/TqzN8cbhVUv2obdTYsO?=
 =?us-ascii?Q?xn+8Vigt1+nCTriJ7CJ1tkRhNPQYA2IWCL7aGUWGYvfOxZ8UvblV/z67J7r8?=
 =?us-ascii?Q?Z9MZ7RaKQsa4+F0derOejqeCdWS0PYPTfiBKSN2dhkjqsoDZZwK0xtj/CI/N?=
 =?us-ascii?Q?DoHtDGbksD5ysjLmV5spXQPOSYNZ7AgIBmogw2NB0eoN+aT9EPo1u0d50QvJ?=
 =?us-ascii?Q?8Egm9q545YCeB3steVNjM0A10pdbmPwJ0993pRz+zGpfPl1pSlMbOvwtxy96?=
 =?us-ascii?Q?WBOBgdMkOOAbBacJS9fCQu26Xcl+wilmXjXT87E4yUyKvGstmknwJdHqv2eg?=
 =?us-ascii?Q?J4ZIQOk6BHVBQ7X5Oe3Z1QKC3UkE+ERVC5QAQtD6ggDVK4nlLQAu49Hi8A3m?=
 =?us-ascii?Q?2DPYx7xjb0Zuz0ovMzLkHUEbWTzDcD67oHzKn8Ir6heTyCvOMlFNNL/a7A3w?=
 =?us-ascii?Q?nkbs47nchC6dLCaja9H2ap7QlPI0rvzQjJqIV2BVJIU/KiKJa33fiYABYHVf?=
 =?us-ascii?Q?r2Kx8ctpXwzCRKsZRRCrCoadmFzzP6fOcva1bCNCiK3YGG7bAMPG+Q1H9xM3?=
 =?us-ascii?Q?yWSx+ZD8jm5lTD0EEcXHfl3A/wHo/jv2hm03Lh42nQ3i9vgmSnDBVaAXxSBc?=
 =?us-ascii?Q?x/YfJUqZsMlE6V0AuHuCtqe+tnQ0Gm6nhAcbrzXABvYdy7XJVKT69muIhfLk?=
 =?us-ascii?Q?GXr/VGaMUQHbBqGDMxujg3aHZKr5E+2dodFDiEwn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87bdc47-85ca-41a6-206b-08dbf65b6309
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 13:00:56.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zisxp9QbL9I9om8EtNt1pnFCXx5pNQr68FDOM0rhLFz0JtqqH/wYrDYwLh5MXcrbYCPn35t++4odHDfY+U3CgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

On Wed, Dec 06, 2023 at 03:07:56PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
> ]# ./test_vxlan_nolocalbypass.sh
> TEST: localbypass enabled                                           [ OK ]
> TEST: Packet received by local VXLAN device - localbypass           [ OK ]
> TEST: localbypass disabled                                          [ OK ]
> TEST: Packet not received by local VXLAN device - nolocalbypass     [ OK ]
> TEST: localbypass enabled                                           [ OK ]
> TEST: Packet received by local VXLAN device - localbypass           [ OK ]
> 
> Tests passed:   6
> Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

