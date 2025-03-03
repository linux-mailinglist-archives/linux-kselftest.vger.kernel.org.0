Return-Path: <linux-kselftest+bounces-28032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64563A4BFBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BF73A9F99
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A120CCD0;
	Mon,  3 Mar 2025 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Al/PxxZx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oliclbF8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCB2036F9;
	Mon,  3 Mar 2025 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003079; cv=fail; b=RWKddsKLCOX2vNcx7Jz94cluDQg1ad4mQtUrMD3GeTTa1G3tp/1f/QTMmn5Li3rk9SSe8C3D7HhvH/EjcZ96NYcocqf8O2oVIei2gO90+Rdhc9hw7pA93ytmSOHCryxeDW7hUYvvKsvB5d15FAUvTiqqA43cu7su+L9tW3CNOXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003079; c=relaxed/simple;
	bh=9WOcdShl8XhTSe5iYU9s+iBskm3aBmknBA0CAhRXyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZX1mNTyEhv0hURwkuIIG9LR+gfSR7lG7g8Bp3WbNyBqEKytUDIY8So7BN0cPDEmS9YA0PYCUy1j77cqGdlbhcada+cJ7EKbcGhd5IuE/dQpa0WKb0wmUI73I8owEFsMK29haumLW7kumaycj2h/zzuJugIwYP84L9Ri8HP1kWH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Al/PxxZx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oliclbF8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tdHi022601;
	Mon, 3 Mar 2025 11:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=z6ni8+wOmy73ctTLY+
	BMsv5uiiXC47WIMmAWzfvoSqs=; b=Al/PxxZxPuKn9k8FfUPRWb3vK3nRnAMDKb
	OSabNC6mpDsU0tISrz3lLrOQLAG//lsMLbDTqdBe/OajI8191QhGtT2xIwmgITdf
	xr7LFADc+SxhOJ7A1bqkMFn05qsg9gsj7GZVKwTTcysOUBD7R0LMuydqrfyRVueh
	kh4SJdCxujEkWsnnes19kmxqv7dDjpRY4fS2oqUJGXynPGSt8OLXkCF8pUKWsu6W
	XlSxvuGVfx6AtEw2zrtu0mYGBKMi+XFUFSryOz0Dma/PRsf1/9F9gEP22z9W34yj
	585Unl4qqwhXT5AHsdrnnzC3wBgalqPvsO7VT13KpdlwuFo9zcSw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hag7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:57:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523BnX8T003106;
	Mon, 3 Mar 2025 11:57:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7d050-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:57:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RppjF7H8Ptjk3MS+8rwk9b9nJxh1mjGJDc2tuc+46wwt01a48/NeyS6ooZ8bp+uSRMJxB3Si9wijc6cgE7tWH8z74mT9TmihKJloMQvb0MfqMV/IMIUOjT7iaWgIFSGUJtJE7vZ05RXwT+gmjVB60ZvWi8bZHuz5LSQMqvM9v/bcon2tK+lHMrm0FR/NARZ0beyhjNvwM0OVh3dUFlGnGdYZ/HocycGbIsgGm3qAYzjd8z0cZ9Md41tTM1VsUVyIfly5YBw7U3wXP2WX0u8iT/GzHWaJYLHyxlzgJ9Perx76zax2tsDz+aGl3h2RS9IvzNPQVGo416fBztDsXyYzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6ni8+wOmy73ctTLY+BMsv5uiiXC47WIMmAWzfvoSqs=;
 b=hNGDVkxzbH0m8+p94SiOBzgg5M0zYJGhDyoEF7iG7Aq99o5sSwclAWYCIeQwA1B7Xo5qncjJqzhNmSV+ytI/UTCRz8DsiaeR/r5DV1tzUwbq0tWcx7TmuFHMQVGs+9/QJNZofJm3vlEkBiNedYzdXiBOmoh4C+yzgyjaDTP0Mo5VvisoK2lac1HXbv6DmN7NF2CJbONvTLDk6GkMZHAEKu2iIkRYYj+PXz6jM5RKRzwFX6DSPliksHAWmMESfauReEbxxLZMZOLtDskqHf7Fs6mRaH/1mVWSoMhdFJ/jCCxZONqea9aOhY0aSPXjpCUAC1IU0PlxeDNaMAP4K4rUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6ni8+wOmy73ctTLY+BMsv5uiiXC47WIMmAWzfvoSqs=;
 b=oliclbF8Ni6HwU80Kz7sfMD11WTIdUrfDgRnr/ZfngL88bW8RmQhodw6c4VW9yIK7aaRofejXNzjz+62Uw/SCKM7NIjomyejZjik+LAgzwSy08kNFUVBezkVwm7n8F9IX1O2Zxajzrwg5cUeQ4KyxxwJqDACS7ZF9RPDkKgEumA=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Mon, 3 Mar
 2025 11:57:12 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:57:12 +0000
Date: Mon, 3 Mar 2025 11:57:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
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
Message-ID: <b7f22fb4-d8dd-48e7-9b12-3a26dc645513@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-7-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-7-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcd6add-7db8-48c4-b088-08dd5a4a8895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMHWAJM0QbtVLIaaHO+1fog7bfdL8Y5smjlSgnphFALw4Wwe7iwg6sQBRQdi?=
 =?us-ascii?Q?DVfK4ZWXKfu1qj1vg0Vk2iQuScXeOs3Q2KtHMr+L6bXiCRhbgvl3asztIkB+?=
 =?us-ascii?Q?IwoS5On8Wz84949auDfoB0U7ptedaNgTcEL0hPDKBG17ceEQ7XXq6BX7HaR+?=
 =?us-ascii?Q?02fuE5wFkq4VkyRHB/w/bHrMNyTBi3swfveenJrCMoWS1eu5LD2MQv2oj502?=
 =?us-ascii?Q?WBo7VtNsuFXtPBNAiPUuPt7hgb8jIimZRaAPakSy8s4fCewuR/s1Dv23Izt5?=
 =?us-ascii?Q?vhRTOwShFgTbbqsa04BI/o2QjVmfuZLg2tAQNlCo4iAllIojl/1IpW53FgO8?=
 =?us-ascii?Q?RLvxWACuhzj6p/cOAgSzvIaQwkDTzWeced5hR6amfzmA7Kmaf57bQ9ShB+SI?=
 =?us-ascii?Q?yBiYd20uJXxneIwInEEz8OfngT/hccPOCI5mrDNAPw7IJxaU0TE58zZ7zSaI?=
 =?us-ascii?Q?zOBIb8NC5cUo1YEDLlk1lKfz6b2G7KvZ1AdNJSecs3GWna7NexRMXitWntlK?=
 =?us-ascii?Q?UgExgARHG/gwfXa5g+SbxkDwXaroUmEGOJqbNGigeHJloX4E5RU+9jsrQtVe?=
 =?us-ascii?Q?KUxO83rQ4R5hZcPlrMF+Fcx0hHDaWa27T1kpyEgfx7hLuFX7TIeFMKf2itDo?=
 =?us-ascii?Q?xAg7a1ytPagEhaAzhQnopJuJi+mlc7td3XEzJsV6fAn+IdU5DgrqXsbzTWa2?=
 =?us-ascii?Q?DSNqVgtAVnSsZVcUwWx440kl75yzZNumLKJbCD/2GFu6AMIymcMazDyCef8F?=
 =?us-ascii?Q?5fmDR8RLupXtj96xLxGIkAmrI7kmZSK0aN9IujGuLltIhi8OXmxqTQ9+KvaA?=
 =?us-ascii?Q?hlANFOCxfqC7kOwt+QaQGFOyTir810zRr7132ardk+qMtPdbxxYP171K6OW+?=
 =?us-ascii?Q?AJOwowInuczP9LRD6FHtTOBr/K55NmLxX3ZfNG9PV1rU3kihLjjCul0J/Ejb?=
 =?us-ascii?Q?hfz/VvXgUnuBkQ2Wg+D6xYx4Qvk1A75cl6GjgTMg3ZE1NaP4iQleQ2WW8S6t?=
 =?us-ascii?Q?hn2GAiYMr5qTBsgnEizhSX1pr9HsIHhpPrr+Sbw9+VCjBjIIHDrVEmO/jr+e?=
 =?us-ascii?Q?VqAgKm1jMQ/TPX3UvCxqtW5aonP8FXLIoey9ebH8mA9Mp9ZXtZLxSslHp0C8?=
 =?us-ascii?Q?UQL8eQgswnL/HZ8e0YQLC2mvgIulM8abuoDWXfwNq9Fptz7FVDMtnGzf8TaM?=
 =?us-ascii?Q?tPP1LKrH0uc1hnaRyKxUgj3+QrVTiwONzz/1co1ZGYvwnAYrFQjANaPgLS5A?=
 =?us-ascii?Q?L81qyH2uSJYaMMwuzdSwnrUMrJb2l5PyeMpZZ5Y+CaO/G4ihfm07o6er8CUP?=
 =?us-ascii?Q?TkDXn0uWqUkitlQP8yBP6DpFFyYscTN1X5RN4er87DoJyHEUeHCXTasMmOWM?=
 =?us-ascii?Q?6W2ZM/sj1kOBi+sRA5DAOjVYVJvM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPD+s/0clUaIlDu5lDeKU4mPc3qxuxpiWsi6JLOw4NvP/IgSdPgF8AR1ur+8?=
 =?us-ascii?Q?MoT1h/ajI0CJQwzhk0KG/IkXMeWMGYoDYra5yxKrtyeVeydzunDc0+SBuXwY?=
 =?us-ascii?Q?2sgwEL3bBF/dwZah7OEp0xdis5EHByZrNNHtcodZVM4oUsRPMRfJAtfUtsN5?=
 =?us-ascii?Q?Cyj49Us7BGsyLbWrPxsSs/0uY+ASxVNxEwnQEpw3594cjkFgsilNDbQFVaQC?=
 =?us-ascii?Q?8R5Rd/Eg/8UpL9p8BSUFmNKAXFN/ouKIB2ycV4uyeA8a1yaDLpZ6TfmW5qJN?=
 =?us-ascii?Q?zraDuC7Q9aJWgJxNs+ZV5gLZL2rCRTCeKjvAvdsjVs6kPsAKBvAog1Rdd7LB?=
 =?us-ascii?Q?ZFGtiecs3Ssh5YuIYZhQqPLCGHvs6zl/4VA0ydu2CfRiGQ78doZlBIQDj3TV?=
 =?us-ascii?Q?Ca7ZG7sRtTLz+0/+axcmzIp7rpU4AKdIKxGYMcYH8e092ucIRkDoeXvLO8xU?=
 =?us-ascii?Q?pPfI6/iv7QozCjrz99m8rRTh2XFEp6pJT6bQs1uIP9cU3ZogKa3J2Puyzxea?=
 =?us-ascii?Q?jmhom+rvh4QlhvcoHZo9tOEViyNkoGcFeUMFp4to5mw3S2Dgg7ORDi6I9UnG?=
 =?us-ascii?Q?poAF/BFqABjASj7QhiKaLHnNqsaqw3weL5rJg2OEwG14122vwDH7CvJeANSz?=
 =?us-ascii?Q?hqH1QjhtqYsR+mtNXY16/qzUsTX8cs9Wiz6dIuIRLybuE26mC0N1AOJVrwIq?=
 =?us-ascii?Q?WbUHXOuW/bnPRm0hsqM4gAlKYO7NP6Gx69isEGQvTPGMOU0ic4E9t3nHhNnL?=
 =?us-ascii?Q?seZ/fR9+zqxgUKIkKwadkcp3R7ZvjoMAJM92xi5ywHmbaIFo+UytezJDrNHX?=
 =?us-ascii?Q?caQAa1MrOrHI7anLFsJ5AZ1F9HMA4YO82C9P69MJ9QemfG1HZNTzLeCfZZqy?=
 =?us-ascii?Q?kuJ377bXA3vAae/nM7eaHPQZ+kqsKVUYaF4ww0WiSftVDJFkY7EC4SCIGfEJ?=
 =?us-ascii?Q?+DbTnFg5l+u3IwJ1gcHCWNMlFw7Q7TZ+hoYbpZp5Cnp/zZ9OesVSnfqVWqmO?=
 =?us-ascii?Q?U/+/cw+NH1xjQieUBM6A0LcaVgd7UvZkCOzv9G904RQz7mVxjtz1TYDdZGNo?=
 =?us-ascii?Q?7tSki2iESfiecrpmZmCp6emfYIrjXl16fcIhU1srdT13gXKltD+i+N8m8uDt?=
 =?us-ascii?Q?Wde6vKlg/pGEo2gNNBXCNNSVxVHY8N/2ML8EcXRX1JVRzCw83l5X1NOCBBqR?=
 =?us-ascii?Q?ccsDldcgk1uVEnmojBCRJZV2PXxqC/CvEhHP5eFqH/iF2wFHWpuqYdwp/6UI?=
 =?us-ascii?Q?1O9dcBUL8fDPMxU2RAzgbnBbidR4u4eO+V36tVJJCgLjZ04GmgNLGeBjw1o3?=
 =?us-ascii?Q?aY2CYSt1uq2ogS950QgV1vU/8lx23MzdqEVGy6h0IqMO49nXhWczrTEStxh1?=
 =?us-ascii?Q?/mF35qBwjSEN+1GCtsEoadvXpeFfhWTZsrvnwTrmtcvq6LqANF3OF8ewebig?=
 =?us-ascii?Q?WdCZNEyEmZGhbax2Lv9VS/dJDtosBDAG+ajwiysH0bDzIZykgwtkPepE7DMZ?=
 =?us-ascii?Q?BuMw9k1stEM4aqY4Pbca0jRUoJzoompc8C43ZAzgGkFoDL7hJgJZNN/FUQQ5?=
 =?us-ascii?Q?1BMAxzGx6wGijirh0ix+SGbnHDm5yrayw05Xzp4VNRQyGOol24Xdmevqum8I?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dOdICuJWE7xHsheyhKlxvi+pzdScIC/qT6eJd1EfF9tTs/GYlE4S3zrQwp4ZRRoIGB0Pfy3IvfTbBktgpeqBqMwaFhi+5tzpEy5tYxcVcbisM3zvWbXRls8M/N19HMHJ5s78DDe1x7NdTrYbAhskS9YNQxs/NE4WBbEDhhiPdshl2Hya3r5Ng2PqOBeApxP1VKxnkq16A0Is0wTuZyHLTbSpO6TsR3gRlE8jYf0FMIzFobzZnbhlxgEYuk5+KceuiBJbzIzc6kHVIK7ca3Os7mVg3yE4gIyEzG/ZGTAVEZOMqstxBxbnLTWfxCukSuSnY6SssHptp4ck2/Ljn85dBZNaAv7Rasy/Z350IueK2qgWokgwJuhdR5znztwIo1bOdSLmcLFYS9EFscZZqV4k/6a38SjgfbcYrsL1iIY5yA7rDXtDEj/v0ETAgccScm9NLbHcTtr7WWFOpqkW06QekZtyMpwmv9/gxKEMbEZN5ABjWgNi7QPn07lWSi3JEGv2Cdt8sz5zbCFicbF18+dj9Ooiz6txeBFIoSrfdDMtu39q3qDZ1XyYPN3VL5OULYFxguuzdLG77hy9VVS3CZah5CASyv86I5JabcbQcUAEbgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcd6add-7db8-48c4-b088-08dd5a4a8895
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:57:12.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OktfPU3shKP/9N+oOABl/+MBd52csh6WOlIxJtjfmeqYfFt2W6z2yQHGE5Uw6OdPD2sZcJshJeyreB/tnol/JEBCl3meIBSuB2vQ/u787k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030092
X-Proofpoint-GUID: KGFRVbNDMopX24Gh0uLkXe9n0GgNxGCC
X-Proofpoint-ORIG-GUID: KGFRVbNDMopX24Gh0uLkXe9n0GgNxGCC

On Mon, Mar 03, 2025 at 05:09:20AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Update memory sealing documentation to include details about system
> mappings.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Kees Cook <kees@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

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

Perfect, thanks!

> +
>  When not to use mseal
>  =====================
>  Applications can apply sealing to any virtual memory region from userspace,
> --
> 2.48.1.711.g2feabab25a-goog
>

