Return-Path: <linux-kselftest+bounces-28064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01528A4C43B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D553A9A1A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69873214229;
	Mon,  3 Mar 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ca0hTlA2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="py9MEdPH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A7214227;
	Mon,  3 Mar 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014397; cv=fail; b=PXdt+yXP3V6PZ/HzHsOgYS3YYZ2PIZTqPj/z20qeLkrJVYbXus03lJ8j04de0RrZyf9Sr5muV9YtYKJ/ZhaIRyT+sfBoYmOe88YoHv/RysjAoeDHMsguc0zjP/8xadYa2yXX/uIA1LI+Ji184HphDu/zUVncTUhjm6yIT15DFl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014397; c=relaxed/simple;
	bh=RKWW8+/1gpTCM240U3oQuQ5MMXn+fi/dez9sP1l+Y2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8BL+QX8Z048nqyjzlmyKSuLDUgsN35uP6t86XmxA+x4Zaq19SKXL8G5UfsyXCI96Q8CRgrUDLFhSGc9zS6ds9jfVzDwtiez/p1ati70pSBIqHPTtBgSXsbPoLVkwpLz9tm3EXfrWo5sGMD9hAs1n04IRTWjwuImnkm+sBpxmkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ca0hTlA2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=py9MEdPH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237uDMK008103;
	Mon, 3 Mar 2025 15:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=D+aoD8jmeMobV+lEmb
	h32JZPs9zy0DOa4vdEWAVYqmw=; b=ca0hTlA2PbNGcDgi3bZB1sFOwS3mvggK6k
	F+rYHBcbUHCmz0r/nDbGmHf9Rm/b0yHPuIpbAOX1TwM8mfdBgIou7WmEuRT3Kiiq
	mi73I7AOAWSV51La66N9jTKfswVU/zBrRmhkEI1qwwQpCJun0/uZ8Kpm7HILVK0b
	duvI5l0bRbnzbfurq+zG6G+FhGz9eiltbFcA0BD4GZ65lwLHEqYM8dZc5cFXy7qn
	7xVK5TTHs7V1xBHyppwIfidFdR8hFq0shelJ2yn5On5N0bPxc/SVVsWQhHnT81/b
	8zQ/6EaqxpBg85U7ZfgSC4DTOcYAoyensrJLWK/tGLFjSUSph6NQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub72uws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:05:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523E0SIk015768;
	Mon, 3 Mar 2025 15:05:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8uafy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV2pgdM6m+UiEAAv4svpUQ84NyoTKH+1n3rvtaZX6pAXvnUbEqpncw/5CtPyKWvIXgzGjEdEvzBU1VZ46gsjZHUa3Zjz5QkIRAOi2inAW4kWaxsLfY6YSq49QSd6KtN2ZeORcY38OVTOo4sFx2ytMfs2rxWPJcErWDD3V23oejqQMbbW/elD5oHsYc12wIQcACN7lYjjvRfS4rWicsVGd0m75PJYKkWOvhZMO3SgZQGLHnan4UvExiNAQu0HYnD0na4kLdk6y0KkW+NFoOpOGiaAb8nETkPGaCNU0wUq/ApAk5Wja2GdID/gn7kqQbJ7dLImBFxS+lLS35xrheOMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+aoD8jmeMobV+lEmbh32JZPs9zy0DOa4vdEWAVYqmw=;
 b=JTMe6TwdSLoxXfgzmiNmaDGssRffk/bV2IyuRpmEYr9G4eZkl9+wlTgzP46Lwsi/Hy6IvkLbctgdljd3RjlOcICkSoDJ+cki14F8OxiwSlBqDrpyum7XrnLNuorQzu+JJRbN63t09xXa5JnerUR95szPQKsB3aXLSpcvCJlwsUComafhWcqmnybczzyanvtuZ9hYomfpxqOvmLEldvdbY0/gm48LhZk7vUeH2eX4PFqu0ajpWhNRJoNShN8bXCmC4ydgBHYnNoHn6H10i4YmuYrrxXKITZg1svE7xN+X6dITnlES9BupgwSvzK6RFvJa5Lk/PrIZ+PIxGSx202G+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+aoD8jmeMobV+lEmbh32JZPs9zy0DOa4vdEWAVYqmw=;
 b=py9MEdPHtYszPJhr8x+HiAUlq4h7gRgQG5BiCbSUGR03AXa0XZoaTWkPux60XdqY9c8DXOQefAp5G0N3K35MTiu36rLRb9LhjVPR60plLYv68yS+FeCJkJYOnqhg3bWQs4HE6LhXshQwZMGLq4TAmDRqO0kjdVXSEsREsBWFipY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 15:05:32 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:05:32 +0000
Date: Mon, 3 Mar 2025 10:05:26 -0500
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
        mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v8 6/7] mseal sysmap: update mseal.rst
Message-ID: <rsb7p65sv6e3tbhresv2ebj2aqiz57wedaz46ndp3jnd476qgn@yvedccpo57bu>
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
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-7-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-7-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 442a6603-31d9-4c52-b294-08dd5a64d81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fChHZJaAlhpAPd2zg33F2QYILGoEZlFSwA9vLHPyZ12yvTtkiMwe2m6wUL4P?=
 =?us-ascii?Q?nrDvlkD70/kDVtIRahIUw5atk7FbTi3hnkBOutEeivdIVI0QIdnNBLq+Ku8t?=
 =?us-ascii?Q?WPnBN1rDhFdFsDVlSI68A5MP2hdDaPVSrnuaD5wff5VGuf5iVAjXViZVWxAJ?=
 =?us-ascii?Q?usBc+HujQZoIrpaqU9DikLWbWLIhgxpWXJVAiDNsgmggnU/gjbv4fbhkTquR?=
 =?us-ascii?Q?WraW/+GTJN8rtDgOVcb0dPeWNGguREjPsvKZxm0+L9rAXS481+d5oMAPS6vK?=
 =?us-ascii?Q?3PDxCyy6fHFgF79SdVfR0+yxNOcjnmJKD1p9cXWYBcPksZ6cWzx+4waO4wzp?=
 =?us-ascii?Q?cmyzLot2+NOFYnif8C4gWOsYU8eF7X6HUPkeWt2FKIS5BrYrOkECdFTxcS9U?=
 =?us-ascii?Q?7fpUw9t7PD/AdaONHNkf9+LPow4u/x+BcImB2qugYmtdn513MyWz2mq+X86r?=
 =?us-ascii?Q?Jjlj+xfhGk0f0c38NqERfJ7zkRtibNCKLdjx8UxqpfN259I5IkfFTNoScR3Y?=
 =?us-ascii?Q?mOY3d1HuDPbuTlfnkP+wGL8mupqQK2EViUirOPEvTuCzW82sRIf+SN9vSDPu?=
 =?us-ascii?Q?GAlB9FG6EMrQdMjUZL/QkkcbMvY8aOtCoKZxP2BpSFJ34U8N+V/bzru1Pfpr?=
 =?us-ascii?Q?6GgFiZfgGrT3ed9r69kjX7OLHO467sj/Ow8veeEoqb8xBXgMXtz8MD6nTjL9?=
 =?us-ascii?Q?n8TEKM3rkjbaFesaN5aH0vmoJtLPafJwtnma/Ta9Lnr0PTUxZlCffbN5hsIf?=
 =?us-ascii?Q?UgjK5jSngdCqQcnEzsKZwEjwjTIL7VoBqjcdsWRk9+DKthQbY4NC+0Jo+me4?=
 =?us-ascii?Q?SGXrJuO5pngmAVO9dV4hY8G3Zk808zquiZUqwdSlv9Hfwi217GhRqxBf3gHN?=
 =?us-ascii?Q?WJGqV2n4nAEW6p5F9bsx1CJuxR5Q9ETsFecCXQidxCzXaD0pv8tmqkwJbxmq?=
 =?us-ascii?Q?38KCDbynYvMUDu3bXBYiqDAzrMa/yNGfxxbmAraRZvjrUTq7gVes5JDBbLfU?=
 =?us-ascii?Q?RedPXENXlatkQgbG6R2jD3ZiVnIYIVKEIvHo8YhZnJsuW7SGk/SfL3+Rqm/A?=
 =?us-ascii?Q?+RMWS1CzYrN1Frpexz5Z7hED6QYMXW4Aold7ynVXtLIs+YI/MGRPOz0o5wW0?=
 =?us-ascii?Q?1qdm5HhWo7rAvOgWLEObB0oRaAj6srMJKfC3W4VZzZt6VwBAdnz9xFF3KS0W?=
 =?us-ascii?Q?WoFSjaq5lmbD9zda0tNcy2g+SmTpOaMUgKoHsfnOCMSxNWM4WajAYXRCKDou?=
 =?us-ascii?Q?fodKxMU1Ha36461ScKPRWFRjZLJT8b/G9zse/mqxFmS3E/pyQsGXZCc7mgYl?=
 =?us-ascii?Q?eIZS6xFDfAon8qkWAYvEpHtGoxWZ5WpsP2KQCoFbuZt21REE2Duzfd9XE8z+?=
 =?us-ascii?Q?MroG0PwIs7RqUm/IO5wsdLiRGKF4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?68RZc/Upuj0lNGzNW3QkuVFowFPPdiRZDzADOhri6iaJVBBu4a/n3/U9Uw4D?=
 =?us-ascii?Q?d8zC6mIyQT3QdDbxizcaRJd1Aw9ESU4exWZ+z6XKG5nYAJ/r0NMYSqQ7GzFf?=
 =?us-ascii?Q?DucE2mQTXSzijqJ5hxK/rhXZlSu5euxsqDCa8cGaLRziD6kzuVXqLzW3a0G6?=
 =?us-ascii?Q?YYpA/+L1vz+6wWFDgx9TK/WMi8MbL3SfaDF9aTl9UKXrr1grFIc1wQFLdSGy?=
 =?us-ascii?Q?lM7aOSxzPHuuE2zPoyG0FVLa1czsE9ahzHYiJUgMaEmMm4JVhP2GVSVc/qNF?=
 =?us-ascii?Q?2RZ8bz0x72wyYv6pWThkPi2MghMlOVgLlUG2waiIHPqvaKzK0ZsVia0W1UJ3?=
 =?us-ascii?Q?0XfQ0qxVX54UC4teWXekFt143V0qHMhGbOYUu/hAhS1lLLb06WQ930RkK7t+?=
 =?us-ascii?Q?UpG0LCFt/E0m3vQ2Gr6ybUKajYdK7q74n50x1ILZic+WJ0JaggVAl0bQXa/T?=
 =?us-ascii?Q?jg7d4X1PCFWGfZc2qPyToyjenfzpC2EIgMLyuz/JX83OgP7GyuDrbAkOE9x4?=
 =?us-ascii?Q?nwVY9VE9cnxcqRVfKIj42JJvXOBWuXiycq63aO0fK+uVHAIzCDW01I9jCms5?=
 =?us-ascii?Q?yG1uO75qY/24Vvvx8GUFp6RvF76HGvUELWozTRWvcWRjiTQItj+2JPatldK0?=
 =?us-ascii?Q?2qHDH+OLha+/5vEZUOW8L4QQvML2FKBBgB1FG78GdoylQfVwmwS7qwMgS8Wz?=
 =?us-ascii?Q?Vo+srUPRmjDvaXb8AwlE2+re0zRwMqJQ5wMzczdJ1dCnecxedw+8Zo1JfVGz?=
 =?us-ascii?Q?9u00Ww0usKmt3cB3fBNeY6HgWIa++CIKLGVFs+BhyPBUP41T4zTeRH91uA/j?=
 =?us-ascii?Q?e5ns/BQ82cm7zFQ4rvGys3Bgt1Q6FpNmVwtTc0CdcwpKUQ9Hu8MmBn5pB4qG?=
 =?us-ascii?Q?FShqOzvYAFnC1xtU2RghyLYdBAQx4DUb7zaGS+KDQVNRcjz8km/mGn5hQpkk?=
 =?us-ascii?Q?nkeINRwrRU1wOO0kcbfYc3Ieu7Q7tE4wfp7vex/f0nH0fZDc2kDewjmEkAuk?=
 =?us-ascii?Q?bbvQgq3o6tcmwE5u2XLc0Z9PRFZHPntqlzHcAjLL6WVTKlQhP0b4NJlJdV6D?=
 =?us-ascii?Q?OW4BBjQ+TCY1Gtdxrm4gPHp/jd04PGDapFDfePH6Dm+VyUD2PD8MAHuXdif9?=
 =?us-ascii?Q?NKHyWCqttkWeWQgsVVHNktxJXCdPTiJGlIVjATGCLA9pzkXEzhJmM/0pHyRP?=
 =?us-ascii?Q?R5N6N+NXoryJeNnzbozr8L9KYCSH3B2pWycg6y6Oej2FzH3OjkAofNC/K0Zd?=
 =?us-ascii?Q?5rVRAf2vLxIg+oB+k1q/URZNqnZiN0aCvLCAm1AaaTHuk1SEwAJ1vMzIEjhj?=
 =?us-ascii?Q?EZ7d3vbXbShYyKosWCnA5zXg5mLTunO48AhuskhfsqmHaNMqhGqwgbz3zCXZ?=
 =?us-ascii?Q?NWZSzUPYYFo15+Set/IIVbtMBIIdqQ/JTpTjNHMYfsaGW5SE8rsu6mxtMBqG?=
 =?us-ascii?Q?ROb3EjsEcWCYtPfIjfoNAFtnXRlr5F8KtwuCeoq0/+H5GXevZWQQ09yS9rV1?=
 =?us-ascii?Q?3nvxmp4HysmQv5xawv5Kfc+b/jOKm8wr14wqYLE+S1CX4F80saIkctn6oFS8?=
 =?us-ascii?Q?6tm5qgwBFP00olYXTv6jcEoWAoal7rSebGl225Du?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8odp8kB4B/yiauxpdJOPMQ4XQQZMCT1R3YH57k4UpqLjxZNaKGwxDSz9lmDKvOUdqQquRvZhdAnhLFonYX3PVR2vUS6rIIUZPJrHpk5XBnzijkFn4U7cQ3V7Ug1xbf4vT9m4zzdeNaoVywyacVJ4FcEUe/WWvyTwHN60BvHIGLVY1fGYsE/7pq3ucEUry4bqike5lFlpmnpC5XTps7xKPG9ln8RREl1nLFlAov7HSmF/kfiHCJkbpeBtG2ajEq3EClomNLLT/MAhTvvWAxnzaPIm9L1ShmR1CsrxWLVMnUSqZ+ROADPX9UfmZS0K3LmK1h9AxivsvXR+xUbJU4ZI65KGKW48w76uTJFlnF3H2i0THyckTYHL+fGOnE6TEnGU/BD1fglHB+8PZWTdRtkniQ+b3pX1InDzopRR9YyHgdymi0sPyZeSioptB6fuJJgBzrNLI33paTxLrYgb6I3If8M8hPsNvRlmNdnM22Z2mqFnb3iWw9Y3CmL2GQi5AxiCRccPyEtJNvj7IAlORU2tPLQLJFUfmQYz6rdBkBIxkvaXCEeh1cyvBaZrrgCggRglMv08QMZw5XH/UU4+aPNu/wGNfj3tsmlazv4sdeIjck0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442a6603-31d9-4c52-b294-08dd5a64d81f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:05:32.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/NAaN61B5dU2PgV7IdgJ5GL8yTQ0XaYQcpARuESBCjgJV7r2EtDSYmLEOYpS33dcajle7zQZjMPsz/2+utngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030115
X-Proofpoint-GUID: wIDhnoAN8c-kM1pgqczDQnwqKBEuSLT9
X-Proofpoint-ORIG-GUID: wIDhnoAN8c-kM1pgqczDQnwqKBEuSLT9

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Update memory sealing documentation to include details about system
> mappings.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Kees Cook <kees@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  Documentation/userspace-api/mseal.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 41102f74c5e2..76e10938302a 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -130,6 +130,26 @@ Use cases
>  
>  - Chrome browser: protect some security sensitive data structures.
>  
> +- System mappings:
> +  The system mappings are created by the kernel and includes vdso, vvar,
> +  vvar_vclock, vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.
> +
> +  Those system mappings are readonly only or execute only, memory sealing can
> +  protect them from ever changing to writable or unmmap/remapped as different
> +  attributes. This is useful to mitigate memory corruption issues where a
> +  corrupted pointer is passed to a memory management system.
> +
> +  If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
> +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
> +  architecture.
> +
> +  The following architectures currently support this feature: x86-64 and arm64.
> +
> +  WARNING: This feature breaks programs which rely on relocating
> +  or unmapping system mappings. Known broken software at the time
> +  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> +  this config can't be enabled universally.
> +
>  When not to use mseal
>  =====================
>  Applications can apply sealing to any virtual memory region from userspace,
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

