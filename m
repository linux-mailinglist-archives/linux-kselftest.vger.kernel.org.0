Return-Path: <linux-kselftest+bounces-1280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169C6806FC6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BA91F21653
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3B364D2;
	Wed,  6 Dec 2023 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X02SoLil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171EE98;
	Wed,  6 Dec 2023 04:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1X9GZo4p7okWTj3D/UBjUH9ygIEBZy+vQFA//kOj2/gdnwdYQDeOkRz/wECQt3Php0o8XPjDkyCsWxKl6VLKMBSt3ymbJR7Zkqse0odHQFwP2SRzzK4vUVwRrnCQdUbENI9IQlHflmYvf+eshU6kMFWCws9otMRjkkRgmOZvYU3u8PyRem3AprEYxqSggsZ2dFWYUnifYWefSIzAeFQduirMTQnD7i/RwgFIeLgz9nBUCpvrFvHCnEEkkyZH9KazOuzP6oTH23VXYs6/GXwa4MxWYJcxmHBMPvbsdEq+mF9Dtl3ZlJI3tin660iyi4DTJ4LltbnQRv8wJvb5SbpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6Mw31VP4La45FJqujrgkRmGm8Wc7qGYiCF3Vs4iWk4=;
 b=fk/qmNp5Pw54eSm+CBBnrzfjY6/Tzyc4kRh+ThlHDd/Y7ThGI/Jnq5c/iTtRmAeBDP0kK8HpjuxFlmtPdPeW4Ks2vscs4GTgmyFhtEsv8mZXUNDdRlwy6EXs4Naw8n3UiNa/1N9Vy3qBv/VeyFLgt7fjJTctSZSPxqNFzHEVHsEgBEGIvipORr2DMSqZbKXjUUXObIHDTw5YnJLrd6WzdSUbA+RxrPSIpYhUwcZGQaw3Q3WUfoUDRYtRIRHxbLCFd+3Q5yC9giQYWmSkmhnr5nLy179UwwgsgWJ/rDcAXbMAje3mJMV8gwV2dsUnx7NJWmjOqeFWAGl6orUg2lrCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6Mw31VP4La45FJqujrgkRmGm8Wc7qGYiCF3Vs4iWk4=;
 b=X02SoLilFm9UD0Teqe+nLxyOw99GS1REOqLNboavPwSkZof8VOsworAjIGCGOsc2sdwJtpteg1VjL5l8C1UH2/elrhiL7VYnAr5M9XQkjQynlL3cUIqXx0rNtZfBADzyfeab6g8YP2buWJOTb06Exb/Nlq+yWg1dGcXPutaN0uQ6KGN/WIgnmO0hlS0swoZLCINPE00G4sZ9MPFELpYkt3urbxdz1f2wzsivSBpqzEL+/17HO4m36GHH73qToH7IwdjlGpjukvrTBj3Wxy4fgpajF4wvKa5Jm95t4AxBdtSqmSfClfIRTRNU5jWZs6G8GExcn7x7U8dyhaYzwg+3NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 12:32:52 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 12:32:52 +0000
Date: Wed, 6 Dec 2023 14:32:46 +0200
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
Subject: Re: [PATCH net-next 1/9] selftests/net: convert
 test_bridge_backup_port.sh to run it in unique namespace
Message-ID: <ZXBp7leQ7YlZP4N8@shredder>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
 <20231206070801.1691247-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206070801.1691247-2-liuhangbin@gmail.com>
X-ClientProxiedBy: LO4P123CA0140.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 986acfdf-ab2a-4a35-26ad-08dbf657770b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UzHvC6G0qNIcsjMGBUCZqhBC5EgxhxYAMaPfzc+wumr7rjAVD8MDvhWdRIEngtK+F8hrHJjI3UGNj7uM9STd2Dwr21BAHO09DQxXV0P1HzWSuRCwkgY6ZB3BTcx8WH+l+9arGVuWvPJk+HZalq6NDtTx+qT5dVaCB6HaIPKhtI2Ciq7Ao5ascTqe6RphH3Li2vJJ9Yajh5M9oFwezcyh7unCYSkTWYNSFpFLBjA89WOlOwgyphutTZ9bEfI6iU/nLZRSkxid/Gq1s/xOK6rhh4WKfNakguain0FgAfx8dAeXJcpVUnmFn54r49iIivCBplPX5zro9Yd+S1Uk1rDFebOdYIHKoTHI4kPME3T3wgdj1e3KEnXKS689YqtoLcuv3mpog/sBUADdcf3XnJCJUOuX6HlQZa3Cmq0sY5OdBR5CoiHkZ9oagKHK8AtfYnSrcY11Z2uDlR0gG5mIu6jDHB9VNLXIOdD2GfFU31Ijs0WtD60xGfxfTDsM2A9bKdxtztX7s+P4FXSR2BdTgjECJk2dvx6uPKRHN9oozmPn+eQ38vCFCMkKt9f8K0nl5xJP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(6486002)(478600001)(38100700002)(9686003)(66946007)(6512007)(107886003)(6506007)(8676002)(4326008)(2906002)(7416002)(4744005)(54906003)(5660300002)(86362001)(41300700001)(6916009)(66556008)(8936002)(66476007)(316002)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQFuUq74eNchIQzE0HXEjYSxRk8O9bb5DgDFseqcI1ACHIGZo0BHqNi912Vg?=
 =?us-ascii?Q?SCBqL1Yb2DK+XrZG7bpdFuaVPbcc5dfIpt4UNRiYJ+4yqPcY1/g8tO1ZSbUf?=
 =?us-ascii?Q?NqbiT82Jrm0+DIprbjOox+F9iQaL/CRWqFPrqbWjTnmBwrY+hEKIP/1Z7UWW?=
 =?us-ascii?Q?/nM5zZAKUXAWB8dkNOLc4GoPl5yLvFCuvAxkGY+ollqgnyigT1d4ngxif/Er?=
 =?us-ascii?Q?0MpmL8KuFd/S+w9Js3ArSFWpwQXywRV86L1BCvJt2xNNSDPsLPnnkbKLv81s?=
 =?us-ascii?Q?Ws9+c5W4B5DdsUk82uic4Az0cERw/yn5JgUy2O+TBN6U/5UvnCgXPj7vvkwj?=
 =?us-ascii?Q?wIwoPnkxwyIk+RsZXVMlRAsLeEY4hUEbK5vsymEGQtLvXwmSOwCMHIdZx4/v?=
 =?us-ascii?Q?ozJxNiBVbNVasXQ59BnC1IN5V6hf09nNqzrikpgXvNf3UGd7p9rEUAEllTh0?=
 =?us-ascii?Q?Tb30Xlbd3WlRNgpX9XEkMfNhHrIkIk2tQCIeCLq0XzzRAb9t4H+tSPTW8+w+?=
 =?us-ascii?Q?M2Q6VBX97//NS3RcSMR9Vn2DLQ88NWY9S3S80HlCDwChKNXklwlWhOUvpTEn?=
 =?us-ascii?Q?D6/LSWkM7bngCacKmo3Lshoqj9X97iJ4NvcXRZn0f0fEnMJDy/+5tThVrD7U?=
 =?us-ascii?Q?Jp4gGYnBrBzO2W2LzOzo2oo4a8AkvOhsdFeSltYpK+AhFdzo3OgtJUQeM9Sv?=
 =?us-ascii?Q?kH5YY4n6STwxyQaZBUmY27QW/9oIyPflu3L4OcnCTxL7ZX8ARFgkNxLrAxU9?=
 =?us-ascii?Q?855gshFRUPjFC87gap4lfTsz3fSfQfmKoTHZ65/DWuf1aX8b9DfvMeBdasXI?=
 =?us-ascii?Q?uf3zpxSPtBksz6DdB9UwrYUGNz7/W+Na1pQN3OxWKylPEjB2GkWRi+x+eTjV?=
 =?us-ascii?Q?dSixsH0uCmJ1/SoanfEtyLGtbOxEk7Zq9LOggw8m9ZVPJLgn4XteqSVq+pLH?=
 =?us-ascii?Q?zA2NWSFbDlHnACeFlWfJq7j0kRCrJt206SET1Ulc196b3iwUnsq+jEY32el+?=
 =?us-ascii?Q?Pf1lIb07+PO3ptpffCz2sxCOJggOdjUQ474ScgfSxVQbDHOKyvfh21j1SqC0?=
 =?us-ascii?Q?kocI9LwPcQbEeakmc/tCUU38ohRWEEyX9lBdDykUG1vJuS9sqE9mdk+Cmet7?=
 =?us-ascii?Q?mfRz+yZVzXLsuv7175xWG+53LeRK+LyGqNmhP6TkY8uDXeZmG90AvXFt/4TY?=
 =?us-ascii?Q?5734NzHCm7XOUVcaXZ+pun1tGYiG0guTObD29IgFeEyUSeeJhFaU9fyHiQsm?=
 =?us-ascii?Q?bGRVR3d795ZOj9aAdORSD27so8fTfbw8VUJvNemOM9ii4o0SAQi9xf0EU9QS?=
 =?us-ascii?Q?ZdYDYSd8HgHphrTBPDG4/5SLCRiKIt8EjlQMeVeafJtb14ZduhHt3ILy0HHK?=
 =?us-ascii?Q?r0CM3ELf4mxUBsHj/cl5qYaFJHiZb2t+p7Flys9AL4Sk0Id8z6jEl3cY3sA/?=
 =?us-ascii?Q?UWN6zx8YYkMXI+fslcYQ4QJkrWfoVVfQFgdrcFwvZkfMPaVWpjjesCUKgjhQ?=
 =?us-ascii?Q?32BIMFunBWGOrXtF2rEphoDcPRTaZpdoalpxQeggaepRr9SMG3bORMfHsUeV?=
 =?us-ascii?Q?+i+IDGx9oo1FcLedr+iaCTJm0ZtOeAiUomIiMR8u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986acfdf-ab2a-4a35-26ad-08dbf657770b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:32:52.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiDfY2ooAMFgoKF8nVHupZkDLjqKL0gqr1WMn0M9eg2OEWTdKyqO7Dk9L1x9RYMzTq+qLCRXPzkgHHpEuK8+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

On Wed, Dec 06, 2023 at 03:07:53PM +0800, Hangbin Liu wrote:
> There is no h1 h2 actually. Remove it. Here is the test result after
> conversion.
> 
> ]# ./test_bridge_backup_port.sh
> 
> Backup port
> -----------
> TEST: Forwarding out of swp1                                        [ OK ]
> TEST: No forwarding out of vx0                                      [ OK ]
> TEST: swp1 carrier off                                              [ OK ]
> TEST: No forwarding out of swp1                                     [ OK ]
> ...
> Backup nexthop ID - ping
> ------------------------
> TEST: Ping with backup nexthop ID                                   [ OK ]
> TEST: Ping after disabling backup nexthop ID                        [ OK ]
> 
> Backup nexthop ID - torture test
> --------------------------------
> TEST: Torture test                                                  [ OK ]
> 
> Tests passed:  83
> Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

