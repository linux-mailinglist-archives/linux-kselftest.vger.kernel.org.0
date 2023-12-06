Return-Path: <linux-kselftest+bounces-1284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232F807064
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B6B20CBA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8336B13;
	Wed,  6 Dec 2023 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVBjHPjJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D13D49;
	Wed,  6 Dec 2023 04:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aevrT92Ggi58r0pMc1dL1OrrtEGjKeGoEPfHyoNeg20hCezdcSy4blZvs0hdpPmS5O0OtUxtCOXqSTRY7NmZmRfspc86perzRJovLYJQuvQusqpBE9zcluT3xXGDvySb/vbyYVPWASMr2jEgd5qxUzs56EdGkNAS5DagWcwnm8ChuCxmFiyL8EqpWlgmNBLG8El9Loj4uFbXe75sfH6RrIJEalgkyq9OYYUOZjMGW+Kp7t4iMQ4Yh2seskWoXjo2O8PAZVKCDkAdZf+ojwENNk1uo7ZDKusb/u1Do2oZE0T2hvAuTdszF+Ok7gkWRSTnjfdEruHWp3Aamvfe1mz2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Npce6RNcsmD6NXLam0zzoPlleM8iV21uDsnxSgGhOwI=;
 b=oe/M9qbosXb6nfQ4rCFOz8n3RxxVC/UqgU9tCBpG7RX0q3lxy2yEzPS062luNasrAZoyqMfiHfm/WtR/eZsE8Sr+oshbyPpAcKjuo8KqhNGiMFLrVejZKUc/TA1Z+fY/wUZMMa3WVWng7Q3klMHJB3Xjrzo0LAJZfqk7+jVfpyEE73lHLTu5EFXn72G/2gU6br/ezBaydULdYso/uawLxmQqaUZVmtY1RfPqMEx07JI4DiN0THEP+XXoucJQYuFk2UbJx+1SMIzjoRsXGZJ8sDVArIBRceg5icgBFKHRIOwmlKPRa4GAAgmY0Nj1AWtCxLWlFZNlNRx2fH8bVssfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npce6RNcsmD6NXLam0zzoPlleM8iV21uDsnxSgGhOwI=;
 b=cVBjHPjJpuT1lGTJr4UNuE7DiclX79X0W2hAY3bUHQawSHNO2fULwb4KwtNJrCzpKhZqQAd/7ELW/LQVItXarOC5XXXrUukFqQPq9Mw706hrVgDX0y+oj1ldOx+t9bXDfuCnVUZ6F24sSdNoHVPA3fbiPgzELC6Mci/46wNAOm7H9pC05OhEvgTU3J4Hv/Bwo0HU/TQWaIV4ARIL4scO0mDdbqEBIk+YaJA196twGqVKYjNrvYlQJXlDl8Pz5ky0+FwE7ylGhIFfFgbnWeStWbzJr7pvu7DEDJ0ILWSd88lJhRjCKGBdz5FT9kwu/QSqRAbgPivD5wfhJpBC9IpNuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 12:58:18 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 12:58:18 +0000
Date: Wed, 6 Dec 2023 14:58:14 +0200
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
Subject: Re: [PATCH net-next 3/9] selftests/net: convert test_vxlan_mdb.sh to
 run it in unique namespace
Message-ID: <ZXBv5uH3iwIAAUOU@shredder>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
 <20231206070801.1691247-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206070801.1691247-4-liuhangbin@gmail.com>
X-ClientProxiedBy: LO2P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::36) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|BN9PR12MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5a64ca-7300-4c55-c35f-08dbf65b048f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5znY6QXp5nv5SEJVPE7oKnyfcXDx3XFHbnv98H7Jom3DrDRZZ/qr+RAuxwGUwm6pBxkCmEmZ9kXtH1Ah+eo9AQuy8jfHh7Rl5n+XHvSfQVOt15nPZk0VhLahyiKaKMKlarp7Hf5e2QYlTb6W8rnXYt50IiQnBLpkJ5LEuzRPucVI64p7z1QKEDI5HXW5FeSfJLjikQZPJcaOLLKR9UfP/S3vabk4pjvRuhmxgwkseuAP03C4tZYAccVox1TetL7vXwuwydDX+ok/g7hmAt1mVZSZi8rZAMy26uZReWsAgzNx17j9VNiId5v0qon6wac5BMrp21blTwEKr4Ajv9qscsPkshkFw/DyLEdDIQps/9e214xQ93I2zW4QUnKeq1K0wYyeJ6adXwq4Arnrgo8GHj+aHoxWP7/8gr4sD5gqv+GnrwodQVyeVRV8gYyVZqCQ7eAZxIYSD8KK8+nr5c4J+bLHnG/Rmg/8B0iyOD+IHP62+gl4Uy7XNxA4Tm3a4Xs0qfX8vB5dDzvupNevD3dIprvjKVU9rXllISr6/wShAk5NLJBHP21Ur082fEqPh/+c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6506007)(9686003)(6512007)(26005)(33716001)(54906003)(66476007)(6916009)(66556008)(66946007)(316002)(38100700002)(107886003)(6666004)(478600001)(6486002)(4326008)(8936002)(8676002)(86362001)(4744005)(5660300002)(7416002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nsdyeHYVx0OW/kITjmAlKNhFHP5Htlq/SpUAhYd+/04j6kVQ0yLQqnbkB8FJ?=
 =?us-ascii?Q?NCeEec3ws5rb4qwNTGO34T5Tu1U+pHIUFPSuEvPIjbZVWNUtQsFa3cs5zNv2?=
 =?us-ascii?Q?et9CscFyhuYXMQn8QKhnTruibpgGVsBD0Dyn3f3ZhwmgbyYUh+Oj6UvSIulx?=
 =?us-ascii?Q?rDrIrKSkpUmDufGpuhLRh8T3J/0qEfaveVwV3ODJRyZPFy7ZSjycc0v59T33?=
 =?us-ascii?Q?1IpgxRpGUF0mshcva2HsPSms3ilNBxhsGEn9r9ynpFfORRAuh3G+iJj65+yY?=
 =?us-ascii?Q?v+zFHPpsx5D5uBfnu+W2QmZyiwPX+9yp3awsTuowMh/qt2lKMdzrFeYlv0y8?=
 =?us-ascii?Q?HdGXRCjt+pU27qDeTepOp2TAJZ0gj3y1p7zscQU0XGZD2q/AOZX0C3RM3VPj?=
 =?us-ascii?Q?abTVV19qewwe/Eg3fskUmLvZJvXxScsroaVaI4WnyVDR3W5pfaGmjM1+ZS3m?=
 =?us-ascii?Q?KH60bkXWTAuzkaddx5a/sQVZRSk/deFMLS+0gKWqw6Sl529Dm20AhDa5WgU1?=
 =?us-ascii?Q?eT5oGvLKdfAspgLWn9d1MFqKYQaW8C/SvYig7ptECcImmhuSuBrYPnQNDLAI?=
 =?us-ascii?Q?te26jBRP7iWnSDandtIK9yS8zUdTN9d26UyvvBQvBtqpJV87CGjuiC0hKU7f?=
 =?us-ascii?Q?KDcpLNJGnsc6MDvYA0Zb7hvSOs9GrQ4Pmbt6r0iCHakFREFz2yb35g2WaSOy?=
 =?us-ascii?Q?HeIF1CHjk9cNojaEnKonQXCaPcH6TF1oC7R0ToSDgJIsL1wmZkC7AtpPJJZc?=
 =?us-ascii?Q?VCBdyxpThdoSv2R76CZkogS7xUNJGKLEPR2ZGxRDsND+nFE7UkAmICUiErEr?=
 =?us-ascii?Q?PgkUrHfx+0KuX88swSpgMXWIV15M3SbwE8oo3XdKuVwckV+Hc77FtB4vrwyO?=
 =?us-ascii?Q?42ZefGb1UqsXJlfxyxxIs1Z7QCv/b2tYa0fha2CQwr1aqXpx1YArT136dIVb?=
 =?us-ascii?Q?kDiE9TsntGT35PeL7kwBncOJHXqiZ2wZ+JJQKZZ7hrUwkClWmnpTGuAiCC5U?=
 =?us-ascii?Q?ssqjMBvQdAp8/jJtHYb5hmwfr3M+uD4F5xU3lk28sy0ee3vR4G4/rQqGHSkz?=
 =?us-ascii?Q?AT9B0X9pKuOU3nAj/LNHioe5xUG1/RU5Xe2wIZTk7hys2fF4/PHxxq8azruV?=
 =?us-ascii?Q?RfkiGTK7zY466EBMgUDBbX6gIgKlT29dLWtFDtZvk/ZG/hx1BmAXPfQvXUqw?=
 =?us-ascii?Q?oVkSr+TFSeq0Wdx259yMVulyjuAxVRe67rIA3AvfDkyAdkCqD3kxf7RYS4U6?=
 =?us-ascii?Q?1NomW7d7LkEdtQ51EdBJbKzbaMOz1WiTfawpL3vvKxg1e5AqxJ9OHfQEMH0c?=
 =?us-ascii?Q?wUxuwsQYCzlNRbnegCioJm7NOMqp/JyRQ8bh7MKYowNM8AfRj2jOwFzYTiFa?=
 =?us-ascii?Q?6sSOlBD/uC1VSGnI2f5N3PeBMxIDlzmzrSQCXy4Ke8X+7xoVVqDZbMrtvWLh?=
 =?us-ascii?Q?48M7FBhw6Go6lVgnC0Q9q71BaOr+nbnNHB87IUAiFQIUNkWS1XazuB7nWbs5?=
 =?us-ascii?Q?UesAc/TdvuwrKE/SylPZtLea4q7ij4L91TjPDNZaXXNI/Gc6Zn3OMRfrxrog?=
 =?us-ascii?Q?vJXcNJeq5xuXAJyTP6oqcJ/WzpjRclwn8IhmEH9h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5a64ca-7300-4c55-c35f-08dbf65b048f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:58:18.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtYyTD+tN4iu/JoOnO4WulAA+v91cfqS+lWE+A8NETGKJA1LacaywdjQ9DRT6ek/D75LrKo20OfIRftz61KKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381

On Wed, Dec 06, 2023 at 03:07:55PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
> ]# ./test_vxlan_mdb.sh
> 
> Control path: Basic (*, G) operations - IPv4 overlay / IPv4 underlay
> --------------------------------------------------------------------
> TEST: MDB entry addition                                            [ OK ]
> 
> ...
> 
> Data path: MDB torture test - IPv6 overlay / IPv6 underlay
> ----------------------------------------------------------
> TEST: Torture test                                                  [ OK ]
> 
> Tests passed: 620
> Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

