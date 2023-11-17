Return-Path: <linux-kselftest+bounces-260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209237EF7EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182CB1C20944
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34743AB0;
	Fri, 17 Nov 2023 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Iz3/WjCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2029.outbound.protection.outlook.com [40.92.89.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9CAD5D;
	Fri, 17 Nov 2023 11:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKUwi4ki6e0aaaWxLlSh1j3SGVIEHIHBJi+BrGHGcOj6XcKnZ95w4Wrcvk79Ef8uTcMWI3IUkN/1hK1YVeTM2mJU9HC4mwCxNb11e85gCse9URuW4XlIIp21JlZflGfo/KG5ANMHmEfcK5kfW0n2JUgeFsian1fn+H9MvzwvzWwLY3xvjoKmEA5PjAuXddkBlsUeiON0F9Huix6ocxb32WCRfWWEcfd93n321NVuY4U6J0wX4AFXaCp/JRSQoNnUnSnFpFBnSc0ooGxxHUD6ffIaQG8DCf3dgvL3MHZotJpwMugQzYBThQQWZurkg2DEHrvG9OsXPhbootInXQzDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7vtm5M+DrnHxDLH1kSsteR4p+8R9btkNm9QT0DIVUA=;
 b=KJhlK/yaeiM9NjkdME7ILi+xajng0fdA+94vGJpiePT7cGxy9GDeGGed5hj6dU8JNoQkVHaDzPSXQDymgbtNQQdP67uaUypiL3BGVO5neTbkHQjujJ+VtFjUfP8YJT2yA1GfjknFzmAFABOs2uqpDIa3EXb+fan9Fj8gPXgd6E6lnMZMntlGRKzQwriNTTT1lp51d6psaqhsm1vWmQXqbKo/TzVLZLsWpTDl7tX/OGh0M161IG8AoAWYONumjMQzRZlZXrj+bX3DWg356zz4FzQtP7M3d+ktP2RgGBsxc4smHcKoABjVlKa3xFZl8UvmzM5N2+EUM86+ScwySBFjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7vtm5M+DrnHxDLH1kSsteR4p+8R9btkNm9QT0DIVUA=;
 b=Iz3/WjCInj1BxgdRsW2XFTV0MzWcQhStEevv6E+V75iDnKpz2Yk0iDljYw9N7txWXyxOG5f2elN6Tcmdd+Uul8xhYtvl6pSreNbvzPRFJnCqUgVHb5i8nobOn3s2UQGVCtFFm9cKZkBJeAJHV2KBHNSEJmIDMzWAlop7P9ud8uP47UyUs+JpdWbNWAfv8/+b2woNAvg3BFBtfiBy62iIyi/4CrM+KC5i96x2DShPmzNelshCUhaQ0FusozLU0EMa2HB0m5k3zj2h5QJ1fAuGbnlI7O2iWrZG/lrA0irsX86pVIfgJ2CC2NoZlzMCZK92mjr8yf1A2Phd6gFY5ntqqw==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB6520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 19:37:26 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.025; Fri, 17 Nov 2023
 19:37:26 +0000
Date: Sat, 18 Nov 2023 01:07:02 +0530
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Update multiple prog_tests
 to use ASSERT_ macros
Message-ID:
 <GV1PR10MB656347ACF4A078EAC2677797E8B7A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <CAEf4Bza4fejyKRCdcq0WwrvZ-p8JbMq0MPQB_BGzaxPGHT2EoQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza4fejyKRCdcq0WwrvZ-p8JbMq0MPQB_BGzaxPGHT2EoQ@mail.gmail.com>
X-TMN: [IgT1M9sFBSBG7EozLlGnd2SqZnGdBRVN]
X-ClientProxiedBy: JN3P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::13)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231117193702.GA158015@nmj-network>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 9196034b-9dcc-4876-9dd4-08dbe7a4a039
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Ly7ewqE2Uu8M0j3frmYtYTf91oGABZjMv5T8WJyTR3jdANCU5W+1zhf5w0+IeVh25xFJ4OZBJZneZyj9E/2x4/GpG+zYtpynR9bd4/fL4UnJyLfvyAwk9jAW1UIpddeYXebCWI/mr2FtAMfQjknHh0XemDKTe4pv175XHpjoylCieXBQ9OTHmKSSzqH+R1I9XsvMIhi8svalWUqGsWaCG22bJGflsm/LoOmaR11LvqmW4sCtIDLNluGYLpyjLxrfWSzNC2G1cSSTWlOsIjjdZk5QK6Dt/+U4Ga4hnLa3/mGxEaOKPc4trcmSVT1wfCqaIHdjIfKZLXIEVNaVW5S3SpdEupv+87n4B5zUgOyLmLcFgIHlh2P9FPn1LnrWm8/L5Xp08Tc6eGVvc+lO9uJehOC/yFCKR8PJjWPTV2+8f52TUwZteQPhx7kTSv9jXKe3eKIPjP9vB9nwYxgt8AVqRKs3S2gYKAW8mkdd2DPhZNf5e8JBFg9TDPkZZKqlUNtCKCYTqwzU1Yf4oB1hG1ZYpMNipOC+/fvBRtD9u+/1R93QeMfSndlwyzhX2X+bNJk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ypphGV1dwvqPMsuJriQ40SGbjBUY/zBAPnx5UlZ+s2a8jxvw8OKzZKCYxSF?=
 =?us-ascii?Q?WmE1YX/dp4U1YQQCIv6JD9OzlpSDMX4KfVbY/c7rs0v4kZDLPj5XLWpGRYAr?=
 =?us-ascii?Q?o3rzESkojp6sbZ2PF9AJ9/3718Sar6YFkfN8DUuu0KqElWZSZBxopD/dJ7zq?=
 =?us-ascii?Q?Nl+2/1li2nAo5HbCcMMvgbO32GW+O7sHJA+IKdqgaLp2q5pWWBLiP2EjbvSJ?=
 =?us-ascii?Q?Jg4767fByd1NCe6n42SnsXN2i0n1gqqfISwq33iNketQa4X6aoaA70NhJrUQ?=
 =?us-ascii?Q?PmDn+LLeOgqLlbwFSeSWC+BGnNQUp3n/eYEg0QOKzR0aDtuGOcyW57djT5mk?=
 =?us-ascii?Q?S1F+wUfkf9A7KPnJCsIVsfDGY5zXHs0x+Br8xkTAXhqBa0TrDwZfX3dNeeQ1?=
 =?us-ascii?Q?gmaJX/yoevODHxw1usd5vOeIwRS2bjAaZzc1XT8tHPPxvBaeyZOU+di1SZEa?=
 =?us-ascii?Q?FvrtjUx0hnwTS1LfE5oi7SCQ7thu75diBBP6YT8lZ/qB3rowixQnEPOYco3a?=
 =?us-ascii?Q?f+8OqQe5asHGTKbrOle5BH6VH0N3fr3VVc4QNqJse0AUZ4Yk/NpFnCN3cFPp?=
 =?us-ascii?Q?LVkIgfDG9bEomAlc9G7vDPaw2amE8AaFWaGTQ4h+m5wQ26+o/J8nt+yeQNP0?=
 =?us-ascii?Q?9xn+KJPvIKBFFL9BIhfbL04+J1M7lAhoPE13M4/sBdoC3Pn+77Utqx/Np/R1?=
 =?us-ascii?Q?lxWQByuJqJglq0uockM3WyGuGFXtRY0HhxxhoOCk+EZh7CnRbkt37xI13vUf?=
 =?us-ascii?Q?puiZMXHGXSiU+IxQW2X09YFkI55Tw1wo4Hu20nu3tvGmRbD0GTpPUAJ5Zv5p?=
 =?us-ascii?Q?bwaZPRvOgmnss9wy3x7BCI4dliYtWnGbSPPRZgqd3W9l/zI79ZifQ7qr6rrS?=
 =?us-ascii?Q?K/ol62MRRLs4ZiiBM5tvbbuxAErn94U5gcsQu7Goe0Q2tRjc1UfpCKVS6HOp?=
 =?us-ascii?Q?Zq/Fugvx6JspI7aCDKEIxZkvmP/Q/E6+KOAk2QesuN1Y3NMu1o31nVUbRRfa?=
 =?us-ascii?Q?9bifPKXjrj8s5Nt4PgQT1H2G356XasbdWpW29RzEKXA168E/8uNr4B/KCiGW?=
 =?us-ascii?Q?UNEimtrpdhKZ2zqynqjGpeyC3RWIBBT+yPWPSygW6VS9hM0aKLb0vREu65Ko?=
 =?us-ascii?Q?A1DQbE7PtutniyrP8DSe6i6Vao3e4Zqx90gLHOJY3Sd/XiBsaVTKIxXf1hb+?=
 =?us-ascii?Q?5ZhS0bcL1hdSccziNIC2SFfCzxR8Y4wlmldezFIkJjnmE5hZjgK+PKgMZ8w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9196034b-9dcc-4876-9dd4-08dbe7a4a039
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:37:26.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6520

Hello Andrii,
On Fri, Nov 17, 2023 at 12:18:40PM -0500, Andrii Nakryiko wrote:
> 
> It seems like you introduced a few failures in selftests, please take
> a look at [0] and fix them, thanks!
> 
Thank you for letting me know. I will see what's wrong
and submit a v2 ASAP.

Thanks,
Yuran Pereira

