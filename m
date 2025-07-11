Return-Path: <linux-kselftest+bounces-37075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19357B016E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 10:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F41CA1C59
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09793205E3B;
	Fri, 11 Jul 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/zB8L+4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D/Sp0URj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CE7DA6C;
	Fri, 11 Jul 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224022; cv=fail; b=KWStIUJNynv2J4k6bSXfypKwJgh9lGe6zgWzAq8L96O+lxprgs46oX7rDKaV8vG53ABst1fvu9nMlWcrYMRJYNqyOLEVtPYJ751UzQxOaO0YgFdnpbX1Chh30/cawLF/uf498WxGP6vR9U6CF6zjnWEBys3KmHzivtGRm/E9c74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224022; c=relaxed/simple;
	bh=n6v7DJbe2r65KFz+9kZazXIW2g+XcRyJG76FwZdx5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n2Xx6Rfy0jTzbd4ZoS0HDWGfAj9dxEGrePYOxRBo13RTOMWS9EhVDOmdVb8clTsh/mZXnHA9yQQa54329hqkCn6YxDlo/UiSw7SRAGyP3TuUeGGyyv0VrWipr3m735W+jHfLNYdfITjIs9NKoGseFZyHRqoVPCZ4M+gvJnjMYuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/zB8L+4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D/Sp0URj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B6fjju005227;
	Fri, 11 Jul 2025 08:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=266x7Bm0HMo/W8K4GK
	bv4AXBP9OP32D+gRGIM9JLl5I=; b=L/zB8L+4IxeJkEwbrZUUQAf9Vt710WS8iC
	kutG4BEiODaf46R2V5lw0X0e583N2cH1eclUAxjwiLnkynEO8QW4EYG4nqNpL/fI
	MAN40qlA4sJSk/TgmNh19GK6tyOh7vpDjMRKDFDMsBPeMWX97r8SJ7OJ4HkTUqb6
	89O64D3fD2OZif2G1wDrkad7CHc0F4Bk6UWDgXEpTEsK/ytX5xH+b/csXSl3SCQd
	tKhl2gBCtgciYunGnESD5J6V82kfu4Zw574eijTWtbSXfSH7OAqErwRn9v64492z
	cpD+KtGZLJT7x4OUXYw+OgdzeEjVe/vIUJbWoE7Rc+4yO+NR+hHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47twjmr77y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:53:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7qUad023658;
	Fri, 11 Jul 2025 08:53:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdjcry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiwQUgs+0Ek+iPUOeiPT9eaWcb5FQHJNFjGSiEDOWRoDNND8Q/I2SSAFc7szTaoc/kMhoEzJzqzMpvtCh3Z5MqrX56RSzb3NP/1I4qA1aCDf9r62pe+V6GZ61ImWQD4wZaluAD9b3MerJbgF5YnD2GJEy+qaOlTXELa6lCAO2MfxGkhiSbxxhlc9pNAzZZwJ1Q2QoVcqbehY+uRy+Ku3fU/uv+xcZ80kyOpXa891oHOOi4xneW7FtmToleXYlME0mcwivJvbxeO0c2p7JVFNcs++Jqye+ErQgHWXV7a6oSspI1n7R/ZefXLGNdKH/4xDE9rcLjwRD4BoSgrSfHFCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=266x7Bm0HMo/W8K4GKbv4AXBP9OP32D+gRGIM9JLl5I=;
 b=SgABnsgsonW2qUIwTdArJB8hwA5xIoxBR7mct+w8ablZWNCxMqKW//SPyijkdoFCe0YRn2AIT0OHwg3lqsdNr9Qdr4kf9da5fYhpC6AVD+Q0EnlUrmUY/N+Pbzd3GZS4/dm9IGDf2vZPRcFB/gs0wvc2E3wGyqYtfvFxYBkkrado4PzkuJGTwmsZ4/kA9LvirUdwveAHsWBcUgAzaWDNe6Tci5YmxQBxXmEmx9m4bemqct77uIO0Pq8DP6cr+3oTm1gOI6pGxdy1Y/5C1PEbI3fXXojOV9kBoUCxzkyu2W2GGGZ3PmxxFlnkNW7XnqmTM02pfdK+7kNlStauC9lACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=266x7Bm0HMo/W8K4GKbv4AXBP9OP32D+gRGIM9JLl5I=;
 b=D/Sp0URjmw7KOlY2YQzcfNhM0oSSElK2PCALv0eDT9I7lYw3bSzc40ksz5fay/QXKXAihVrmjqxCRQBDbF/r08ASRwmeJrtK4TJuEy+jSG8FmrhMMP8gzEKYXj92oYeghjpfUmrSHlsakIHZqs3PW6vAQoXpKdl4zL97j2i6teU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7335.namprd10.prod.outlook.com (2603:10b6:208:3d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 08:53:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 08:53:12 +0000
Date: Fri, 11 Jul 2025 09:53:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org, ziy@nvidia.com,
        david@redhat.com, sj@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
        jannh@google.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
        vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <569270da-8827-4a3c-84db-91f715ef5c22@lucifer.local>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
 <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
 <aHDHQzzbtgCh6Ox3@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDHQzzbtgCh6Ox3@finisterre.sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 11031882-3196-4e42-d388-08ddc0585e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jA4cJmaJ6U1rVsrO6RYuxTehyngoSN/wkqS+3hCiVwNSc04aDQxNi2kX9Iz?=
 =?us-ascii?Q?UooGt4ffH+8jfXpjd1Ta7pO3LXh1Pf980dRIyO6i7bv5SNuuM+sRAgEgV+dz?=
 =?us-ascii?Q?Z1TQgOvQBAnt5BrX6kkw9WTuYAHxa6zqf87t4kv/oprzOEBFH8tbGOEdRVOK?=
 =?us-ascii?Q?1Q9F19gRha0nXyf+jSKYL1xsjAnD3DrrSbjLCPKtZOK6kfPCk4K4vCE5pEqZ?=
 =?us-ascii?Q?fP2luA1IRWaf3t6oSkTTJ9qo5qO7e/7Los9Wg+Vy3zKsYU2wrjgYqhCjRE1m?=
 =?us-ascii?Q?SZGRhOTo/n3DZ5g9NcZ3ifApNBTOmUmefAKdvagAW8hHlNaNJcSXj2KC3SyT?=
 =?us-ascii?Q?wECmtlGhFbiXzC6D6R4PthxcFvB4ZwFZ0AoFxY29d9uw4naP42SiIS2ZKy0r?=
 =?us-ascii?Q?Bc0qaIKZKNLj5cWBnE9tZvTOkxzLH+i8y8ZQnzr+pDQ/Pf2Z6qgH77FM4U8x?=
 =?us-ascii?Q?2Mo6qCpv7ihoO11mrArR7dSXRsQwYYIpQGFpufY+7zC5TUbDsp5asyoZu2X/?=
 =?us-ascii?Q?PVRHA25ppmxmr7EPMTpX53kVgH3vLNSIVy748eFPa8bR5GbZRs4jB3LnilJ5?=
 =?us-ascii?Q?pMmWn8j7YUJNvtsSSbn6V90NN7XfmzBxhjcgOMnjpmdPLu6jDdn9HxX8VOeT?=
 =?us-ascii?Q?/3xyOXHgXz6alMTHk+2zEUN+yKepYsIrXKsQt+QEiPcJSKkcdIkBHEbOUnNp?=
 =?us-ascii?Q?baH7acEdOWcMrzAFLi/gRLpaILizjCn/GI8O3K+xWEb7YcXgWcCQhgW9EwD6?=
 =?us-ascii?Q?HBmXbO74jr5oZ1VO8rvUo3/uV1N0pOZ/MFuq9Pd4eMEQfM0Tw0zO+lHcbYbP?=
 =?us-ascii?Q?Zlcyc7G1tGvRQ2Kkwwfqm3htPI5G2N6+tkXMplHFVBZV+B4mHDegYLHNqPWp?=
 =?us-ascii?Q?Rp0Ta3ucIH6jKKFAAv1yqE12EUyBHx/oPLoAnAISei0t8tXXAvV5PA3ezTL6?=
 =?us-ascii?Q?hW/XJ6BJ153plJzrE+qrLRBCEoff8d7xDgCUbbYTZtyrEm8ItXuKpJvyzi7O?=
 =?us-ascii?Q?QMxiy1RJQZj/UXXdJuUct0omP1UxpxewPQ4OmH2e1ie8vLnH90FZcYOYTk3Y?=
 =?us-ascii?Q?xhxNzIMOCdqvtWM4gmvc69SvUzZCyCgKDYY59SQKI6JhmNPvJB347EWrWjY8?=
 =?us-ascii?Q?nYY1PgrUzvQdI2uHaGwTG52hLc4rgTD7SI+7mXdJ2D3eh74nbiopW4NzBdE4?=
 =?us-ascii?Q?F7yoPUNgCxRJ3sJGmHJFtVsa8CfNRyzt80v1d+SLr+D4BP/e6MjnIWN6hYhk?=
 =?us-ascii?Q?/rbIwlJs1jerw1hUSWlXfQYRRHpA474tPsu1E7t4vPTyJBw8ne3K9+bdYPw/?=
 =?us-ascii?Q?+Si4K9jV8CrRrXuMdQFuXTI0RfkbkramtmeFMZlsQ7Ldy1GSZec+7wn1PnxO?=
 =?us-ascii?Q?GuU9Z+A4OIS4aoCecvoni0MbGAEchmKyfBE/M7l3imArwr1QQ35vcSrX8gFg?=
 =?us-ascii?Q?w1rC+EFux98=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0ybpBbcyBeAAR4BulZ40UP//o3I2S0nnsj98TlX8X0q6/CYPaesQhe7c9od?=
 =?us-ascii?Q?/Li0feWbIMPxoMc1cLTCpnsFflRFky97mh99YK4ubS8cSo6Cc6EPc08+8Cj5?=
 =?us-ascii?Q?9+vqGeJGUrS1n2oyJphzOXhyAxuBMT6wBj7GwCVq6YsYXfdhUEBu5C4V4Gee?=
 =?us-ascii?Q?ta1PgIqg83MWYtdKfL6QQ5s0fCCXb71G3kvqDYzxFFq/fVl0dA1Gph11onXk?=
 =?us-ascii?Q?dmjO+gRCA5zhlkIF6WwEuFezn8T5gmELEDlxTJIgJUw6AjNkcY837JQNmcia?=
 =?us-ascii?Q?JmMgfNH6RjgSieZZPpzPi8pZaElzfVA8kgci0D05u4uNaq3Pe9ibRMPTL5JA?=
 =?us-ascii?Q?Hw2AhQVtdPGUg9UpigoUX1IcTmZEluwvPWQ1xiICHqWQkVRvjKBdh/5SgD8Z?=
 =?us-ascii?Q?MepYPBBbSDt5I7MoThyi66skUi6fvCjFvgWJNVviM20TV9HYa2E4rrubj14G?=
 =?us-ascii?Q?lJ46et9l7uLg4DJqwu73FMQRDrLiv47XAHiMe1LarpGMsekQmyq5dGmfZe/V?=
 =?us-ascii?Q?mDtaIsI0ufFUCmCx1faxbHZ6S1uLobwjhoNg29qlCJtNlhfCx8lSlCPAeAKr?=
 =?us-ascii?Q?13czYtv9Fvdf6CmdhxZZYbXlPlyWIzeW13dfRM3+ovqdT6B3z1UhkeOCuSIj?=
 =?us-ascii?Q?+0FwfsA6PKZEHB+R0y2JdJUDBSf4hNWxLpsC81nJpZD2uR7ac/oYmeBiy47D?=
 =?us-ascii?Q?Iedxw+PXeOMuRbNunFTIftkJAJ1tqAt/VMb3CAquZTYZBB+6ApBVpNn213qf?=
 =?us-ascii?Q?WdjR8VoETRukHfc12wUOpYScxF/TRSrIt7t6H7ZCLqv2o17Yi4BCycgWxIi4?=
 =?us-ascii?Q?FUokBL6Wk9q/F7diKROGSpOJmrbZEYNVdd9ZYwHPziT0KCy1KUEP9uBwQ3r0?=
 =?us-ascii?Q?a1dfis3VfdJW6Q9bV9aqE+q43zvMMp3mgv9QnXIEvKjZyytcUFANCroBWwQL?=
 =?us-ascii?Q?E6QJu54pMpGCqcMoIxkqrbx8Y/lhTvOPcdpLCdvN7NvBnSBhuk+PrVxdjT7y?=
 =?us-ascii?Q?nbo6voVCxNpoiPPeoLeOMsc2366t4osT1Sl2ovk2HYfFlFrQ5GcFIWljlKOa?=
 =?us-ascii?Q?xeFioZxN6YUQ0RxZtPMb34P96IH42iy8OBRX8S+GBY0wOA1a9jnDCX7JDwxt?=
 =?us-ascii?Q?k4l+jLVGoAlT7czKa3FcDBuYG+AVOFxm3DN3RiOoGMzEmyZb1+a9Oxr2V6mF?=
 =?us-ascii?Q?t6tnBqyBDRbDnO6oY37/8c86Rv6e+JF0cubMjGj1SHTStp0u6hVyVcR1R7/R?=
 =?us-ascii?Q?bORibPg+iJLToUwMtCRVnsI2lC+Olnrskesw3zjnJeE7DhumVVHrUJi94ASC?=
 =?us-ascii?Q?E50ByLzq9Ewgn3HFrupJ3tOGNARkQUt1N9iEZXsYUqF4PNv9zmQ0cehstgSl?=
 =?us-ascii?Q?prtqpXBS72zO3isR2H4X+1rdnEmqshVaTpXcXLMRp+ChynhWlH98N0GYMbKA?=
 =?us-ascii?Q?onazc7ns6yhorA7OF8TLPw5caJ5D3sGwEj/D+vvgmNf3QKU7xSPRU5bclgLa?=
 =?us-ascii?Q?y2DMLmVNm8ALQcR0Ot4Nwez8ZmQLuS+HmOtnvfgPsEKt9hQs8+Sa29ZtZ1U2?=
 =?us-ascii?Q?eWqMUOmcjJhS+wmD+gtmR74yXHJKjvCjCX7XFe2KtflpBw33Icuu5NEjSSi/?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VyPHYwvOQknTAePsjuMtOxtML0ogY0kpbrK+IE/BVeDXE5bKBRg3iojqtxiLp5DbVx2BKLgzQehj2W2/Q7WuwKR3mMqArDsZaECVBNQLwaK8c74YE4HAInH0aDu6HcAJ9S5LWGSLP7j7XLrPldQL1VdtdBSKqRSpkjBj1Gcu3/yOXXAmWAp4M+uOOFNfdrpvakPbikXkRoyqlgCzl+9yns2IlVt5FzlH6uhWq1QN0BMfKkW2EmR2zZBu0IroTXLiBcnuTvn/x9yWNG7B2Ekay9OCGKpmFiWUtwwj1Jk7WU2P7POtiwGy1GfjgC+lPwbu3jHbqIG3qYqKKMr0tnvUkGgRihfHoWL191n1mrR89WbVoAJoJV09l+vVvIhI8qKyPcIFlRZbvtV9lWToydGk0B3K1X6t68RpZ9gP9xSm7EfAfMeMEhVtPY0/3+j5ESojkuuUWKoernmjkdupnetZY38NbuODqiNCGdjI5TjY161VF8bbp8J51LoOw/NJoQWAlnZNoK9NjzfHi96Ok8kwo/RQmrUJbbRR6v+s5TbPdqbdqw+8+HdTrPH3WafxNUuib86126+YmuALBJ7dER8CZtrrlNrmgRsP0A/AbTCDIdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11031882-3196-4e42-d388-08ddc0585e50
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:53:12.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STJ3dcSXyeXfIFut8zAImi6DU0eEBXm3uFtoy3TbeqenprJTQVAxhcteh31AHrj0ymvhlgj+qNE3C8T8nrUA9APmDKGmmVT8lem4P7WjrBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=917 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110061
X-Proofpoint-ORIG-GUID: cwvZonUVC1hrhDOBMIvCZlnefIhnrXgX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2MiBTYWx0ZWRfX/+fA/NXsYw9B vEuucRdoam6vVgRjhWVkHABk1/tU2v9MZdEJDR3MhMM+j3865EOhevWY0KPgH7+3Bl7m+PPVyCF 6KKBxPl/0FrwtzYXMreC/JWVKh/z2559m4EaaUuGoJgwklgKYdEwik7VF+ZW9mm40R8xy6/SH8Z
 z0+Gfaj66mZNiU+3z0+joYi8lI7a+dbcXf0PQTEdno2Kt8NbocoDEiS2HI8GISm41c7vTpSg3wF UJVjIHBzofxMxF8g6Iq8ryU0WMSjP0UAawQHkfh+to0NTBRQQgKFFzgeTeRPRXBnCennQrQyR8m 70LLq16UBDHWdADKSP9yLnP4lBlmqbF5oG005tjEg0k6Ox2+vN0t5SztMaBy6VdXmjprxu9ITuK
 4GK/AV2lLGO0dZ+bFB08sCb6+NjE/FKuyKzgr3w0s8U5kRM6HhHGkN4pZyS7xYGClZWUT8QS
X-Proofpoint-GUID: cwvZonUVC1hrhDOBMIvCZlnefIhnrXgX
X-Authority-Analysis: v=2.4 cv=ENYG00ZC c=1 sm=1 tr=0 ts=6870d0fc b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=_MKdkRokn-AsN3mCN5QA:9 a=CjuIK1q_8ugA:10

On Fri, Jul 11, 2025 at 09:11:47AM +0100, Mark Brown wrote:
> On Thu, Jul 10, 2025 at 05:57:23PM +0100, Lorenzo Stoakes wrote:
> > On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:
>
> > > +#include <linux/pidfd.h>
>
> > However, the pidfd tests already have a stub in so you can alternatively
> > use:
>
> > #include "../pidfd/pidfd.h"
>
> > As is done in guard-regions.c.
>
> One thing to watch out for with peering into the private header files of
> other selftests is that it's a routine source of build and sometimes
> runtime failures, people have a tendency to update one selftest without
> thinking that other selftests might be peering at their code.  The cross
> tree aspect can make it painful to deal with the resulting issues.

I take it from the lack of reported issues this hasn't happened in reality.

