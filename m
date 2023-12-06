Return-Path: <linux-kselftest+bounces-1287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8928070DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421F11C20627
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FAA381BB;
	Wed,  6 Dec 2023 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LORqIX60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA0ED4F;
	Wed,  6 Dec 2023 05:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUmY+mlRDWSG7GvbyX4koYTAO9S5n8ku1Q6rGY8vSQbIU6US2kbxHkRAQPhttZ/2k/bJjcGTqcCG1/CVajuuVWl5tBq6+QfbiDjU92HwRFCTVD9bGKdxylkQ4lrqwSie6PkyBGw6/lthrXMDMnCLc2nf0isEZGF1XlcAZqH4Qs0HzVokFFXKPSHS3Tm69huDqqcd0E/QsU7nsMjkn4vCeeeAj1QZSICRUzkfsSxpw1pHPb//FEsgJKRp9tjfqTj3w1LmYHoWk+hNA3oqhypQij3dTc74uP/+6/IxHbiLG0Yl0cIVP5mnq8sp2Zs/LnAA2Zc3uHz+NE7CM8zBcRhqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRH345Mu1IAEa2mdwTksRm7Dx/pN1WadSY7vG4cHpjA=;
 b=jjT7OOKDT1u8TRfd3j1ul/AuQ8g+Qv84if0xcfmByLMy8+q59hlFL09oQkpt1kAzvfm6Xsooyb1GqRFT2j3Mo44sGMYTOUqYzr/d22H0QJkqVxpYxdKTGw02sKz4HKiNyNdouyW/zp2+9fdYvaGYtdM1SCaFB/XHEbmzCxdpBG/S3gAAx2VyDx1CIclcmnyXiwaOhjNcf1vWKG76rHgMHZdKZr2uOfKwYJyDGPChyJto7Y1KugH9bPwRVgZO8MuFV/ZF91AvFiVVF2vxUfxqjJWj1nOqIyxm1YjpVLFIUESgX6ulMWIY5aPyxrjkG3ZBkojktXFGQND+8/VpvP+UAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRH345Mu1IAEa2mdwTksRm7Dx/pN1WadSY7vG4cHpjA=;
 b=LORqIX60ULplzalQ+KgSzUmJyHOa0iZBNRKi078OFQCWp6hP2MdtoReEleiUTt5XlrLA7k0qaQwQJ20dZ6fc6xET4mQM34lciLRZ2rjaZnshajGTs4gtycQLZiP4SCJPAkCmUhoIi0xZuZLa9SIM7+UgzZluKDDkpTGPq+qjmtnO8nL3i3+roqKu7OmTfQZ/2xQ+ZMvBT0ape99CS5E4Ua92rGy3hd4hGqYrMntCEdsLqP8bXshX/i1bzjwEe92UDZJuT6fSvsCS1uzW2iRg7KlplhGIcuA6j2iaGTUDZRN3cOyw/rRTl9cuUP+sI0s3Ff6Yk6rzNdHqzrhyBJKa5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 13:27:21 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 13:27:20 +0000
Date: Wed, 6 Dec 2023 15:27:14 +0200
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
Subject: Re: [PATCH net-next 5/9] selftests/net: convert
 test_vxlan_under_vrf.sh to run it in unique namespace
Message-ID: <ZXB2sjJzzWujrOkG@shredder>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
 <20231206070801.1691247-6-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206070801.1691247-6-liuhangbin@gmail.com>
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: a119e721-13ec-41b4-885a-08dbf65f12e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ze2O2i+QFuCxWNAMT5srJMihENXWuxG86425PO8z1vNnyXqarXpY6juRcSc9QqlhUL39n/Fv66w1lwIuetdddFf+8GqvJBUaNej2Dcwv6nCHeqkWZ3Cl2Xlbw/YkOjRpdUzvG4ZDliH6TKYF8dANn3ZJRoRegXSvzGKQJiVMKBFCvN680i74MHLGzDUmtvmrTGCjSizfI/YVUenArYHbgz0n4NkxvaBhYfz4WMabmR6zvDC5r+HzvwPbUYwlRzzGdwK6oo6KKTvJNuymqQx2uaKhrpocHKc78vtuR3Mvbx02GjPk+YbD+p6sMCkAt/I1UjLYxfnn0ByClr5fdLTs+ov6qQOc2do3Zy8Mx0xOP8l/7TN/80ndacDM4hhXZfUZJPpnvIzdgro/jvY0cKECaxKK52HiLj8R38i/jTg/WMwjvED7iHG9NkI1CfHQE0tx96QPmUm99VZKqG3b8iNPazrGXfCR73iO/5QmL83H3IP0FqBRhwyQNPRiDUfgWb/QO+E0QhpsGqALs7g65YPsPvC8DNVDp2yEwQgBi+vjMORFsb1kbAgc6FCBppRv8zjt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6512007)(9686003)(6506007)(6486002)(6666004)(478600001)(54906003)(66946007)(66556008)(66476007)(316002)(26005)(107886003)(4326008)(6916009)(8676002)(8936002)(5660300002)(7416002)(2906002)(41300700001)(86362001)(33716001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXTbCJUgD5603Ed3QqYO6Yaw8HqQfDHF6ohhfDi2w90aHCjQBR+7IU5YXBeE?=
 =?us-ascii?Q?RRhSa58vkvzAhfsahxYom/e/iybdKnNIO3N5cRgI2TLpQ7CnLq6CKFCkuOZ0?=
 =?us-ascii?Q?JtJkO7Qdamd10VQu+b0gBlNRmRNGs77/POY5LDJTYqRrv4IKGfBKYd6AamCn?=
 =?us-ascii?Q?VoGEmBhKMj8+itJJSOO8BVYl2UB8SSv+4L0zgaUsJax3xkxEhY4UU1UBdeeg?=
 =?us-ascii?Q?j30BEkTEwMaRGN845/2+V80Vgrf2/dKFWPq+HX6JvDNtu4dKmfhDTSaDhKTO?=
 =?us-ascii?Q?VPGrZ49NYlyqhG4XLtPXLkMxjxvbrDV1ODL4fGBiv1sg+/tiz0DQ1pixCuZ3?=
 =?us-ascii?Q?fe3INpcGBA37d0vQtzeK5GyxJc0HpqTxQU0+czr5WA0dlmUZsWtGXildnNtl?=
 =?us-ascii?Q?/f4vRuoyuBSkxC2hnh4NHdDEUMa45hUyeYXzU/lDARH+nr056avnbxC1Dulh?=
 =?us-ascii?Q?BqklSw6R3v991LeCS11IbK2JCDl/FzhOh7m+jkupio2mDVOmTXNIOm5faVcr?=
 =?us-ascii?Q?yZeyqbXcybI7/jjvZL3QhJpL/Lmu4OTi3yVDvCHMRDRngCN6BWAgroqO0uqf?=
 =?us-ascii?Q?yGYSJ2FaG/mgvKwMr8yt1njYME/Cwa+aDphi1j0VTvlo5/fyztZ3FuB2xtk4?=
 =?us-ascii?Q?CVYbTaK0n/+dH9F5t80Me5X4KK8+61iioz1pAy4fhGYYKOL9+V/6at0OgKPo?=
 =?us-ascii?Q?a6nMBIsiqhxHGr/mGXYjpivz83ZDAlnewVZt2kS5qAKtYq/qhF4Wl6lCk2vh?=
 =?us-ascii?Q?5jrWx+l+KNe1MWI+2uB5TJx3xkQIL9X0XM6glVBHblxkN04EmmnoU6ycCSp2?=
 =?us-ascii?Q?GFJspt4HygMzMM+MTxKRAVV1NJnUHdzQ+xcWtpBlT0dMor/6DZL8hi/C0Ki+?=
 =?us-ascii?Q?ufumoRg/LpWyJWD6DZQegW5fvtAWyaRHiLjCjdmf7EmMCCjJTQlaN0q/I+j7?=
 =?us-ascii?Q?+2J/MP62F+7RMoDAwitYOo/ajcqfaOpAR8HxLDkfv4OxZwE1gEIqQRkAC4yw?=
 =?us-ascii?Q?WynqbxyKdq1H7xpR3rNttiUG/gMCx9/4Lw8EKzXT6fST51yooUXTYpBzqU47?=
 =?us-ascii?Q?vsSL9KgBRZvdfILHTLQ0SqoxxY1SS8w5Y1/myOhOLQaDzZ0DKeATolQu9SBA?=
 =?us-ascii?Q?p1SLSGwsZQJUmz4QG5XufUa5wXZ6NUMNwxsw1/KmXMYYV5cwHhC94qPtUsLh?=
 =?us-ascii?Q?klZ4quZB2Tr6o4UdhBFvWeiSbxal/WuZEUwnBL1jL92g2lm2qUt3ZlQsFtR8?=
 =?us-ascii?Q?2Cq21InHzbMqGAsaBLWS0cgH4T+HdTkVn7DuZfA0W2QI2sAzUJbNn6nby5P7?=
 =?us-ascii?Q?Nk9bSRd2ZguNShKNgSNy25VhcKLjfBCf/1zjAGS3NO9gGhAzq09kEPtBScDu?=
 =?us-ascii?Q?MYUWc0CJU4RzYCfGQYx5jXgru6QlbgIsm8Q74kzchu6BAXGzs2Wem6MElH2y?=
 =?us-ascii?Q?NbSoZS8Ygis/o9kDwM7Scg2s0j4qRl6WxVTHX53dWcJ0FgIBR+SsixbGoSdV?=
 =?us-ascii?Q?6zSAGF72L7nkC7xPCNBRbdaROwA2jwP4fFOeBsbVKhrXgUEEzkGbCUgdiQBp?=
 =?us-ascii?Q?iohhNMkm2SO+4KC4BP0PotdCJF8f2frCnfdOXcS+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a119e721-13ec-41b4-885a-08dbf65f12e6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 13:27:20.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mmmfXmYmLuTBCHa68DgfnA0Chh6CQUKUeh9u2kfnuKApcR/PpWIavalsNQRuRh5mO9nMVM6wPndDkhIYhQn+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

On Wed, Dec 06, 2023 at 03:07:57PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
> ]# ./test_vxlan_under_vrf.sh
> Checking HV connectivity                                           [ OK ]
> Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
> Check VM connectivity through VXLAN (underlay in a VRF)            [ OK ]
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

