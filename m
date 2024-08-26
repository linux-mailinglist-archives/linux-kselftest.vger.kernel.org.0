Return-Path: <linux-kselftest+bounces-16269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C490995F04E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4441B1F22440
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6215539F;
	Mon, 26 Aug 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="StoSrrKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DC140E29;
	Mon, 26 Aug 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673689; cv=fail; b=tmRilvMuurw4VqQ3ZanaWvPvVBwKg3Z7IdOAYgn38HyJ7AWCT4xnXNOsUJbkaVxVW/v8lpf8cNpCn9iIBW7BdY11Tqbm65Efq/6y161ALQ0Ykk7QE5ixZv8uxrm9VOTAQMzbcD5DN7eyL/9c5v56FDz7gvO3eykNwPoFToSlKh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673689; c=relaxed/simple;
	bh=lEDqeomfmNcbi1aJt5Quv8FzcBdqwYpmErohvv0t6NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjLQouM/9JUqwM7x3QCbGUd6lMEDgoZgnOUYJQiSon55i/uZE+yAqHFOMM3goDdrTb3EIwYVXi68Ge2FrzFZ5ffK7/4FAMAiVG7Ds5lGD69VDacg8QkjIOKKWnrgt84/vIEbPDlC16ZKdk/ZgfIzxnMpuQWdF5047n1hlECl/5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=StoSrrKr; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZvABLFoPSPiip519eSD6iAPEAuQb95cM74txh2Sm2YaZt7yj7zitMwXTQ2mIhM66RTziCOYvsJWlEaBMAqHOKIsxCF12lJ4WBccNqv1wFHBDxl6poHIHPZOTOb9PfBTptq6EX0T/ZCOOd/Yi9YxyHepDnEj4KZ63Ji2DKTCd35+Ya6EmJxFBYdai0BzY9a4fgk0lTBtOKvSlojoBNjyGVqDt2KrBryXUh0rdgHJEF7VThxZ95mhahMFbxCSZ1U2XTiRgm2fSmNmcPPSI/3oI83VlbeMuTDneSxFytzRxGRHO2JDjQRKtnb6msPoKMoMHmvx0l7vw2HqcJmbIYIgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOrGAlCQLY0uZn8PHdbzqziq8HSKn2UDyw2AhFUmMBc=;
 b=B/NKLZe9cPPT/fbkt0vmYg8ZP/lQdgq97W5xtpkyvy7TAOYiYZ4ZWpJFRJ0XSFLU1liwxUN6pzcQ9xjJleaAMEIg8MXmpO4dp37ELPxZRW0tMzWPQAV8iC0XjCTZn3JKvgiWEn/VsAH2YBvXVeQc9R6/6pMeCeB36SKg7Aic2gSbYmndAnYIvmKq9prqIiVFwQ+fdZikuVjNyg/JSkt4W+avhhQU2tDPfQ+tbTRN4hC2Lfj8blcbJosjbfMtse+QakBwMRm4yn1CpPGUEaXwD+cYbU20pF0AFwGmI2HYzVGY81lyYhBZTel3/3eheEeZt2BDwr2s2SLoknVhT9CSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOrGAlCQLY0uZn8PHdbzqziq8HSKn2UDyw2AhFUmMBc=;
 b=StoSrrKrjv+281cY/nvzQPNyCwMsyjPuB/JNa8dJfUp6GARDn13jwPMjYMcY+zaNSSXbpWKptgJaRStGL/wYRKlB3SIQgjNJJPbRXxy1Zca9n3WNOTiqM3uXmOp7GmbayFov+Q+IEbfdSJ2CaS0FaGaAf0LgwPNuVRG4sEuE9G3a+14mTr1LDhDpEvvenxj/OXEbp6Ks5XG5MotirV6G/UbYtuGqLmL6QkIIhlMG5mppaCPwuhLcCWBI6lnQFLQ0LJ4jXnZs/oDTvlqSD4qyISj50QDZVarAIT74z6uw+flnqBQgIjBn+iZuh9KbvmpY7PWJ1hVsRWJcVtEGjFr6Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:01:23 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:01:23 +0000
Date: Mon, 26 Aug 2024 15:01:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 3/5] selftests: mlxsw: sch_red_core: Use
 defer for stopping traffic
Message-ID: <Zsxuh3WR3qrOWzaq@shredder.mtl.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <6dc79e54a02623f0f2bb11533be1dc230ddcecec.1724324945.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc79e54a02623f0f2bb11533be1dc230ddcecec.1724324945.git.petrm@nvidia.com>
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: c024c6e0-cfb2-4da6-dd5a-08dcc5c6ce29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VP9mtG0yJHZsppZrF9IMna22aVk6npb2hsJzw9K2tTjJQ+X1GSzSo1qqgxL?=
 =?us-ascii?Q?RQ5ue7jauh61K1UYW8ldB6O9JuhwY1jQUfrRNL/WwnkUjM7MqA/n41x3reeQ?=
 =?us-ascii?Q?7/6UChpAaDWJZSLq9hsGDZLjplieDgQ17jzuMrW9rZQ2+AQp9+4RS9xJJR4i?=
 =?us-ascii?Q?KRrlmeZAw/JbLvocK9hxGGBQ88IDq+WeKupVelUAqs/kLK55Fj7CPZlxnQsE?=
 =?us-ascii?Q?C5pVf5wRhBcB4691o0vtzEftUxu3uGNu5OWTYZDPpC4RLT7JgEIlqKM18V5k?=
 =?us-ascii?Q?22L3qdQ/SFU2SWL+b+/AYU9VllN2XWdsfn//OTBK7EgJ5ekwDkdnGMkH3/vx?=
 =?us-ascii?Q?Ohz6VL+imGbqVp74/ZzEzltdt0an7d2Wxi1byGJJPEbWyxEnBlgiqZT497RO?=
 =?us-ascii?Q?848kZS/svm6LioXvNLfqAyUn0CYSbxTu5as+QKN9z4NpqpMyLmbwkHggmvmT?=
 =?us-ascii?Q?fv9G6kqKgq+HEX1uAfFIaNp3mzmZtW5EhIXw501O2ZagJhPJJY/ebHywsOGA?=
 =?us-ascii?Q?9IL5HcsKlFXn/SLC6QyGvvgHkOSHXMlz8NPfNsQDH7d07nR0nGA+Jk2nSpql?=
 =?us-ascii?Q?OSvn86UPXsbC5xEhMrcfllRPDn8aLz+SO/fblU5zIlwaKzkMFaMXY4dO+DAy?=
 =?us-ascii?Q?HV7f7ddq7XsHeFLygtgyTr0Jx37zL2EzWi5Fb7m/dp5wpCR13qCG0jCT2NYo?=
 =?us-ascii?Q?65JM/T54ptenAzYY2k+ZP7r5Latbgla23t4/urobV4JaFcUYvXwI9GqAUOdp?=
 =?us-ascii?Q?YtgYEURzUT8E/+8kZ6gaEcSPx4S6/m6Il4AfPEBmH1L5lnYKcLcm9CzR2/N/?=
 =?us-ascii?Q?BVq2ulobMCYAoPA93q4haUcxhSIcrBVHFl6V1PY2/UPwZ0xmfXZlXV4gNmB+?=
 =?us-ascii?Q?y0c1verUjk1bb/IE/9S8wzb8aDQ4yhNAeOERWDEGXhnMUS2/PhpOvQqb8UtC?=
 =?us-ascii?Q?fibh1J4om+sKZzIcI24Vd54jPbUY95KcS2i2dVa9weFbNhvP9J4BgCpTdPbk?=
 =?us-ascii?Q?GoAo2I9WbSb1H5+vMXBkxWdRT65QsdTvirNWTb7zJwEZwQaapiproeU5OzFi?=
 =?us-ascii?Q?o5xgfpdqbatCGr6Z38vTIOCnKz/SJXjDBTq+lIuOyY5DWtRNfIwM2TdGKDaj?=
 =?us-ascii?Q?LlRTpBbP1btJk/DCTUctnVdKEdJz1SjHWbqUP1l4DRwRfkF92lWjJhxiKxvA?=
 =?us-ascii?Q?wX7Vwl6+fkGdxEo06zgR6Ta3kNKFrdxEToyF2TyS/A3DnUEedfMSwDxmR/kZ?=
 =?us-ascii?Q?d2emkSYMSYm9vr5K4ObzyT8HpqUZbfG3PGmbEnzhPgULoI7G9/hoS8P63igg?=
 =?us-ascii?Q?dWY3qyYItYBDNs3/wKAZSTLeuFnpyILD2cTUO3VZQgtiUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V5tUaFKd4PUUM+TfAxwCQxyoLjNvdXueFJA4WfpM9ovTz9JBTmlxSeJLgI4G?=
 =?us-ascii?Q?rxAzZk3BRz42fizhKUTkRU99GxZiorjt05XDSqWaUCw18c9gcM5/pc3dzGZf?=
 =?us-ascii?Q?J3vCYwCl96kMjAZe/GnC8gT+8QEXDgVaQz9CjThmUXuypoGhhTWdPP1Hn72g?=
 =?us-ascii?Q?FTDCEAFq4H0RbN6vHaqqVplgpCieDvluIWHprll15RxhJfJbBTI8XPrcOLlY?=
 =?us-ascii?Q?JwBuP0JkeFqamUxgqjKUU+YA3T89VJydU2NfPWozy+SdBd3sxqKGv9Pjjf9a?=
 =?us-ascii?Q?0z3Xn/zgV7r6hfQaXAOeG+XRggttuQV9giT/ScNQlbig2zGetqUnanEeqECc?=
 =?us-ascii?Q?oouum9ueDdm3rgUaqm1Gmm+toJjeRbPXbgwUVqJ/cbhRWMqfzgV7RCDWPc3Z?=
 =?us-ascii?Q?1fj1IgqLWe7A/mGjl3BQ2DAYr595KFOT/4y8v1J36XVe9OY/uv21EAwArPE6?=
 =?us-ascii?Q?0onMq2DolTPkpC41i0n1+kEGwUSomsR70H2ge56pWk1XuAgv5gi25LvQpCxI?=
 =?us-ascii?Q?JL6QOBVC6sYCganfKc9yd0vcm/IqKB9MLz/NHWt2K8LJoB7It1rZWLJVZ5xf?=
 =?us-ascii?Q?NE4dX/2u6sz6w+aEPUX3v5RjF+ebtUiVRWP59DZPhE2Qsty5teHObsykp2e8?=
 =?us-ascii?Q?fS+QOvfaE/TNsEYprt6ykgs88Msin5nEhaFiEWO53dZnCi2rJ0TZZ/fGhamU?=
 =?us-ascii?Q?7nUIBaSjm42i4bpgIRwXLg0Q8IPvhzI1jVnum8Zsi3F6K0pitWr9dkI+a7Ln?=
 =?us-ascii?Q?ckolxh1ns4xCp5zptP6L+sZb+YYdIL6gUWyi9uO80ssyzLsUp8Fudhtd3g4T?=
 =?us-ascii?Q?JOP/+C7QXsz9LckO0dYkk860iWUBA4dJl6vf2RZlwQ0fl9PV+5LojOCnPKrQ?=
 =?us-ascii?Q?r0/zRG75olKZScXuz2xtyOYHz6+4o3JsGEPGZ+fOQlAdUjmzN3a0CjzXf7U/?=
 =?us-ascii?Q?nnV/GcuD+j6xh0/GGRMS0x82e2dh/gZrOY1YZijGIpOH2qzt4R0Fb1KQveqg?=
 =?us-ascii?Q?BZIsi/GTragmFEQVJ2XJGkLlj01d9xN1cc8nKhgaNd5q/2O4+OGb+pImX/Lf?=
 =?us-ascii?Q?F/wGL9dAVJ+8L+GpGzc0SwVSgtlcEG5OLSrXfIf7ejSrSMEvOHQzBFV7NAeH?=
 =?us-ascii?Q?rf2f5kkv0wI+PA+fBW2kAtvGYoc0KINbmmtjBRw4xnqJ4UfNKWOEOBuKSfyF?=
 =?us-ascii?Q?rLz3cdc129qfMD/cRE3pf5W1L7pwMg61EBotvkt07LF7Hkhx1omnskCj+Koq?=
 =?us-ascii?Q?T8bhYH95WOIwF/dorbETWWBhRMIRgFxreWmibrut21K0L1xns0GpRy2urO9k?=
 =?us-ascii?Q?NgiGLYE+PlHKreqVGFFWkh8fiwbzR/gRebbl0JY2R53Qjsnrx42MtOlSv/XO?=
 =?us-ascii?Q?69yuCQN1+N37QumqBc1Cgm0iBnJWYX1bWJE6S93mG8Blyxc/Km12v3J5Q5E9?=
 =?us-ascii?Q?juNzDp/brAiNhe5ExvfgVokSHwb6hXdKUmlE9TPcf9sioe85a3fzAxcXaCnM?=
 =?us-ascii?Q?WZefbDGQ1/i6bCnwB0YEHVoRdtKiN7ztoRswVtSd52F0ubWGFjSfLU4RgKX7?=
 =?us-ascii?Q?a922lnWf3maGULpXaLGgoD8oFmt13sUlLTI0wRu2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c024c6e0-cfb2-4da6-dd5a-08dcc5c6ce29
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:01:23.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c8nIN/XChXEtnAq1Yb7o+XKeST1CsgToWeQsC2TwM5mX0huBH3JJEld7hpo2E7hbr0mqnxc6PLa6mW5RBmlqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Thu, Aug 22, 2024 at 03:49:42PM +0200, Petr Machata wrote:
> Tests interrupted part-way through leave behind a running mausezahn. Use
> defer to schedule a traffic stop after traffic is started. Mark the
> functions that run traffic as defer-scoped, such that the traffic is
> stopped right after the function returns.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

