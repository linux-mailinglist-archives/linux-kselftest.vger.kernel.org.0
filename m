Return-Path: <linux-kselftest+bounces-28067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C849BA4C4DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77EF7A960F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399B21507C;
	Mon,  3 Mar 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fIXzjh8D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="afZA8oLY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428502147F4;
	Mon,  3 Mar 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015159; cv=fail; b=uZGiLOPWa4Gtg5QBWObvN02GX9fvS1UxUXhzdgoCIa6MedQVU/DvZkyPCsFLRM+jQ2g1kEcY+S7vzM9ubZ3EyiFAyxi5PRT5duP6trCPQ/Bxl9ijINYmVXfFoj1FBSMFUBZ/p7LkEj+ZgwCQXKgKZYHNuK5GHfoDTpEvQfS9Pmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015159; c=relaxed/simple;
	bh=KTyfp0OyyPCnDLDsywhpvI27B8eOGKCvrWgxIgqLQ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKEvLWtjwALf6qt0pECS2enKL0HdL03noim8mE9xfm2p27kLPYKabEAx50jFqimNG7UEbosp4hFZVzaiHWf3edPF4JuN87ZigVtxyCrOQyBHhjSQsro/+wchVdUJriuSbNRhTchaZHOnq5DRKz9v1q7jk2QLf57fcp9K7AOx+eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fIXzjh8D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=afZA8oLY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tg9Y026452;
	Mon, 3 Mar 2025 15:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=YjUFeOk144W6IfMByt
	8Cm4LXViw6pFSugVUAPEjKA8Q=; b=fIXzjh8D7hle8BG9JwmQUJ8IYXjEyw3jHb
	6uthuFkm51m20iLEAx+wrZRdymbmU4tMUJDqxLALfG0BmHAMfLtnzXlBJQvr2cKz
	PnxtLhIHIU2Qt4tAs/uZyiLOdLz98GfpSRbH2PC2NSeq+Vt2BWvuRtcGh2V9uLgN
	RSaGpk6ZylFJG+0kT71JpHAZnqWAhI613JBOt3QChYJXG6L+tSeK+ZbNhjhsWrzw
	qL+5bDxkI9Xe7LanOtPN0vJbTW7i35TmmAAA8sdARR5hsEsJsaWM5ipvIVCkfiwf
	9WHoZ+94+R9NgqFXnTM+TEffnmOW/18SvL8nZwp6dumj9at94VHA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qawng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:18:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523EYMHh040445;
	Mon, 3 Mar 2025 15:02:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpduv2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFBRlR1WXGUWS9KBlhKt7FewRIDXHHiDozjzuGAfdr6URAjS4geE8sn5Vypz7Zm6Hr0XPGz6hRIUkwy7/HIIGScbWwz+NqMC4xpRUFjVg5NHrKmXfCG2buGx9nakXOAECu3COfo7M+tgOEH5gJX3Fh9DebDIuxcFVBC2r/YEEG0MWzLvgjyBCYw3rW/vvdHT+3joa04RTqKBVgW6PM+JsKT7Hz/MtO4CAFUadmGsGXMUU7WEwi98IQlFDyq8SiWSlkJyEkHozPbwmFcUk53blAKHCl5PViC4gKDwHyocOU78gkxCFHeZ8XJrvqWxiJsk7ombHcvljFkiiWPRNnpMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjUFeOk144W6IfMByt8Cm4LXViw6pFSugVUAPEjKA8Q=;
 b=dbbPUK2ns3II9mqrUSYUeD3Il/Kxw8PuBOowRaCpei0h2mxZp8FDCa0m2Wp9lKKVpVS4eOde8lduDGEjpMmCK9NTYwyzUqrM0rEELhNxDPUDh0nGUa/Q5zCT9haA/Am+5DxG6NVqys+olX4k0zyRe/J4HyYT4KLUy9NzAXigDyVHKwgq7kZGk0PJICjptVG/yO4JOXIrSRlCfTpN1jRbgpatC5V+LE3w05QAoAIjRtYTljFCdhgBehxWuObOZTCK3YLnF/c/Gj3uVUGiKe56read1W916PJWi5nZdAfg9Eg2BJpYOFiMTJ6Raxz4VKISMrG2Rx1TcvlyWBS5proGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjUFeOk144W6IfMByt8Cm4LXViw6pFSugVUAPEjKA8Q=;
 b=afZA8oLYeJd7eGW5YgKNe8w84U1Zk6wepvEy4HPuMzqHAAVbWvezTS6ndz4BTYLmYnoPI+bhieSP7qmCzcq9zbI5NBVSoT6upzoUnnDnIJ38Gk6Wa9MaXiId+2l7cXOJu1uQDsuYE3E59/tqOkeU8tAKjk5kz5sp/2JUS1rHThM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 15:02:07 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:02:07 +0000
Date: Mon, 3 Mar 2025 10:02:00 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 1/7] mseal sysmap: kernel config and header change
Message-ID: <maamck3gjqjikefwlubtzg4ymaa6vh47hlxqqn4v23gqwl2tli@t372meccgycq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-2-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0378.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 9374c640-0c6e-4f94-9ad1-08dd5a645daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5NZkWYBMqQ7GaNKCwVLZqEC93MA+TPwYNnWuES6exBbJGUfwat68ibi3vSc?=
 =?us-ascii?Q?mL7vWzHS7bfQxDImSMgh6T5DE8UqN4y47s7Z5kdwhMvrTpv72UyfNrFT6trE?=
 =?us-ascii?Q?n++VdjewOEvZRTeOGN9l4JV1B4HcFGdeYicNSrz9CERk1AHnTa/oIVl/7oA0?=
 =?us-ascii?Q?ne8bXJe6+pOgXfqYX1rS0S7ImNkIgUN00NdPYNxNM0ulDfbE1J++BFB7zIdk?=
 =?us-ascii?Q?xUsTGKkkyuk+WjBwqWogk14o+fk1FwvnADeaavHTo93WQWkd3dWtvT7/sAvv?=
 =?us-ascii?Q?qkfHzFgsK0ekPWnwAAipxuRZWZJnQ6yGt7zgGlNvxuRxG4bqlpRGufPqIoNH?=
 =?us-ascii?Q?Ej+cBbKgMXS9V0b96xajACnVX41mKTWABgdA6ymzpXizIBvFlzmCYvx5nLqW?=
 =?us-ascii?Q?XrbPYmh1YBS/XLDAb/BENsitbiX1MYjRwVJrrBiCapCWAwlZO/Xr46tlby4q?=
 =?us-ascii?Q?tLLKNwY6Ejc42fqHOeS2QK2s8So5NhrCksMBIPCg12GOyMRFbXf6yBKeC6ch?=
 =?us-ascii?Q?hta8Yr8R/Gj+8B1F5ExdJ6WOX+iR+F2ONM8Bxd0iulM7Rn5eNaiT4o/UG5jT?=
 =?us-ascii?Q?CoQadyGkreNVducSAfzXD8Z6oxYjBFF76v0LEqZGoatnPVmcA8bUXEPLCsEN?=
 =?us-ascii?Q?MUWNVhPbU66MGDtWyOhyAlED911k0/k+Xq4c0RteW/GwUn/ee55+2wOy9sUQ?=
 =?us-ascii?Q?PhFLmwnc0QIxmsjUOiRpmjGJMX4NMWGHtgCX42oQzYwjiVvzDqpS331aouNn?=
 =?us-ascii?Q?STFYhInJ9zZxHjB3IxBnuLz7kYpMqxrMWVVEVwghaHRwA5ZBs9/PeCEUYSIY?=
 =?us-ascii?Q?gVwl5Jn6Xhgb6/Hh+uNZtxNU3lXoXGQZXV25AU0SNeq+bIGSOLQBVCKe1YU6?=
 =?us-ascii?Q?0BElOUlc+Cgh759p41Wq6fyPBt+mW5qUKMnWHrMUsekbtX4aKTL7JJzLQOpi?=
 =?us-ascii?Q?kop8YketkQkn2myKTp/3KqxsbOchnimqfEvPrzo/gMVGlZrfhpewfCMhoMVx?=
 =?us-ascii?Q?WDu8hGs8FC+/AMXeG+9KiVVIVzO89J0MqxsqGnSnej/BhDs3vq8uRpeUtrVs?=
 =?us-ascii?Q?vJ0o4h0iCV50aCpnY+QTcPhGEJEGVWQgR2PyocjmpiuJdmN3XnO/GeaYi7iu?=
 =?us-ascii?Q?YdaTpf+lPidK1WFvtH2ajeL/4ZokcJBLLUFJdRdMILsecoyxD1h6qDzsIp2+?=
 =?us-ascii?Q?sJsyHcwwNqWWPPfO5hhv4azlQorYnkv+2xZOTbZzUd9Ev3vWiw0z14ayzIJt?=
 =?us-ascii?Q?A9NMW00EbJhshVH20hxus7/HROp26mc1RsPu1eaXn+q3INNaS+VrsnZDhpR0?=
 =?us-ascii?Q?6nphz50dkr+SU+Q7xshMxdX5Vj3FuTL8PoQGq9UX504Co8EUOxrMfG5r4kpy?=
 =?us-ascii?Q?CqCLkSGIo5hUtzNw2IBjZDKcxCwf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ok6+TZ9U8jaHWM9CaFWMhMyCA5tfnd0yhPXvVDE5pZyuQ0gvCLvCIAyN+c04?=
 =?us-ascii?Q?JvmZwWGhokZCrmYuP7zGVv5kqK7blq06axb8+MIEgKkMOyIlQDqQIwIuUXYJ?=
 =?us-ascii?Q?RATIsmyEMrCAq4avV7tCGpf4FFu2c0TmCdkwCNe3tBcVU7zF3wDd6Gc+HEQh?=
 =?us-ascii?Q?2cSl8hTgfYZ4mVr+5jSqBqR2T92/EikreylHynYleWtgEKfpUXRzsTaFYdBp?=
 =?us-ascii?Q?g4xCuQimjxThgcsPW3LC+XrPNalz3kxcTiB8vB0lM9+suNpx7t40iyJCPEZd?=
 =?us-ascii?Q?iDiRi0uWm8dYGGX4XEcWCDoXtvLgHIce20W9eOyaZwKTr8n/XICNi8Bb6UVf?=
 =?us-ascii?Q?Er3tMU7HCkSTj0jTXNjUbt+9Xu6EBDEa/dAwG/Or1pDJO2nlHh9Wo0oj8Z89?=
 =?us-ascii?Q?LwaczxE3t/TsGaOA/wGL+0ygshX75lTTdieHYPV7dV/VIf4ZumLoSZppL5e4?=
 =?us-ascii?Q?LgkIX/GJyef7SEcVqTq3vmnxtLqIflJqBiaeR0ZnKt6ZNYz4cfrXgqKlQzS5?=
 =?us-ascii?Q?tDQNqZLYNZnZB7sOBQDuIfOfTD/1TeouqKqJ1EpdWd13UPclYWArGAhkhTVR?=
 =?us-ascii?Q?4LYBAHWUEbZAgXF2rMzySEITiVc4bT66yMofp+bw3kXzAOYyI/010MvOoKES?=
 =?us-ascii?Q?HGuwV1VW5QZphmC2FYerU4U+z8g1aQwE+baVo0FrIOwoBvSGYebHT5DLAKxO?=
 =?us-ascii?Q?BQ8gtfPuHwUJpHtUYXJiymsc1RvWn3cuOtjwYyfnvju2IjBICxvFRk1fZdsX?=
 =?us-ascii?Q?eOpk4CLDIXaSoU+ihmorlUBjLm00cgMneg0bGwNgx//O6/ItuBj5sd2OKpin?=
 =?us-ascii?Q?FRzdm+4NgI3abBmNJjVgXpERmLf7yJEfnqpzgiQ1neG1A0doOBasViJE0UTB?=
 =?us-ascii?Q?UKqgNzJFxhjKPqWzSjDw+NbGtUsQItdyb9+ID9E7TtMW/wgugyhZUahw4sca?=
 =?us-ascii?Q?dJi0e9IJyVDfKByY9WvdfhrcypJyttKk9BGA3yTtlBU97rIYlcrJEkCMDadh?=
 =?us-ascii?Q?ZQxNmrybM2kZmhSbU9M7OFuR/9aD/wvUwWxKzmvLF5rlPh3SQ9t5JoAHkC2O?=
 =?us-ascii?Q?aycvE88B6iamH4gy+zRkpRE/TUP1ymt3Szt/db08Syegp/SMm4CFTJ05zyY7?=
 =?us-ascii?Q?ofqYFsjfpeynFbhEo9yixzD+vRU/Q4qVSlVQACv46ywvR+27Tw7nvhYjR8l3?=
 =?us-ascii?Q?yTRGn6ruF5qLQiURVepnBvBLls50lbDyjLrunS5Up2N5+EsufuB8ZOz+21Nm?=
 =?us-ascii?Q?T4/cFSpCwRVVamugPBAM0OKGVoWY5Bfz8pZI9e+YVfru38kwPcOHuVoey78A?=
 =?us-ascii?Q?Tu3178AUu6gRfRlckWnfgQlNvEFMYHWeA8rQf3uN3387N2g3Z8A3IuGVBgCZ?=
 =?us-ascii?Q?ESYskA7MwKnjeMR36JYgp5Op2algEiqt8PZ9/yIv558vzsrjG2QAggacdb7H?=
 =?us-ascii?Q?NFRv0/rKkNcYQvTCJn2SIHmteMUbS4moib5QP/hlbgJ6vnxK6Vuc+4CGa2cD?=
 =?us-ascii?Q?pAYrB1sp/XokWMhCIMOGFgWgaZs9+GpDXNtD7iIcBAb5ayPIbLB+eWXkY9GN?=
 =?us-ascii?Q?N5T5nS6CR+n2JUL0Wxc+tbV6Dzglvcf6e5dLUrCB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xLG6TE1O56KajXFlnQCq3Ti34vskybLjg4GZnX76rPe5PQZ5sN+zKGGmPJ5HWno1ELl26x/12EhZJlLYzxfC4YPPMKJcYbILZ7huUqyGDjE0muNeuXBTeJynAQZd45t0YVQewyguYn0+xA1i2/01yaFEFC2BN2daMSPjmrrEYw0dTUlHzaC+wnj+07i+dqmg+3Hkw0VW2aF3jUaFU9zhcaer2FV/67WFH5Br3Zce7JZzdGHz7WC7fyd6wsObZSdKAc7oM8BZUt2iOdVFV+ecY7/IOm9yiLc8ZNvHgLTXPNlZlyBygwG39wMAK6m81c/UwEqJ4DwC+xDqpRLZ4Bm+I3dsNRnUp2//Y6If3VJyniWfMwGDB3gxqPvnQ7vT7J4yeUYwAQjBpGuVW6Z2Z/yxJTHEqMoKZEpvheG5Q82cO2Q0hg8UCP/zhUNZaQ7Lj8aSY4zv6K7t5YlzcemNLWbMIjZbYZgI2r20jFWC4xbedIopnVdyr7ruwIv9vkDAyh65mHQliqXyrEvHr55TTKCIEwdIc/Yn5EmWn174ylZO2dIpWFJEgDnNG1/hgQ/yqL/LHX9CC1FQibmKfoAQKl3aRQKj64lhDGmwYr7fOl94uAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9374c640-0c6e-4f94-9ad1-08dd5a645daa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:02:07.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4SfDozNAlx0JhaR0nPr51efrayDmXGGKE1AkKE2Xfgnt7FcJNG1nBzvRyd1XCSNl1ZwLKRPBx6Wd5M1DzMRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030115
X-Proofpoint-ORIG-GUID: 9ncvAZsx8oTPlxNOhT0WZGiN6RSU6k3D
X-Proofpoint-GUID: 9ncvAZsx8oTPlxNOhT0WZGiN6RSU6k3D

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide infrastructure to mseal system mappings. Establish
> two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> macro for future patches.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> ---
>  include/linux/mm.h | 10 ++++++++++
>  init/Kconfig       | 22 ++++++++++++++++++++++
>  security/Kconfig   | 21 +++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..8b800941678d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  
> +
> +/*
> + * mseal of userspace process's system mappings.
> + */
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +#define VM_SEALED_SYSMAP	VM_SEALED
> +#else
> +#define VM_SEALED_SYSMAP	VM_NONE
> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..c90dd8778993 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>  
> +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  special mappings calls to include the sealing flag and confirm
> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. The existence of this flag for an architecture
> +	  implies that it does not require the remapping of thest system
> +	  mappings during process lifetime, so sealing these mappings is safe
> +	  from a kernel perspective.
> +
> +	  After the architecture enables this, a distribution can set
> +	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c294..5311f4a6786c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
>  
>  endchoice
>  
> +config MSEAL_SYSTEM_MAPPINGS
> +	bool "mseal system mappings"
> +	depends on 64BIT
> +	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Apply mseal on system mappings.
> +	  The system mappings includes vdso, vvar, vvar_vclock,
> +	  vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  WARNING: This feature breaks programs which rely on relocating
> +	  or unmapping system mappings. Known broken software at the time
> +	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> +	  this config can't be enabled universally.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

