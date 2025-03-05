Return-Path: <linux-kselftest+bounces-28289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB2A4F6C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 06:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C063A68F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD871D5159;
	Wed,  5 Mar 2025 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O8lj7zPK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="toABFNgM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F086346;
	Wed,  5 Mar 2025 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154295; cv=fail; b=InrVBKIofkeFvx4tiUqPs9WZnRLQNSCcD4indc/wlzKouK15e42K4ThRpGeb1fGfY/VZPwuZKgWdpaCyUdmyonTiDbZG9fjXbGkLqsbu6A3fi4lCOw+VSs+OeETzl6mTMRrhT/Mse7VudZqQp+sgZlHHG/TfHMRocRy7IOuksSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154295; c=relaxed/simple;
	bh=ok+sudaXoz64UB8/wXqRUi7go5fzoZ5Q5OQF1OPrzQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n4kUIpihZCSFK5xFw5DuYC76xIeuUJSLGN1FSw/ikxYjl8gTTO7/4nc7cj21abkXkf0K2nNiFPKuIlOZWHG0XzFD0kiQvI+uQQFa1Dyuh4rilJJo4/FbAHhpuLZjeOFoIr25KHa2AwEkVHHZ8ZXpB6b1Us7iJjijr0SPERDMhss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O8lj7zPK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=toABFNgM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255MtiN004949;
	Wed, 5 Mar 2025 05:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ie1VsSfpxfSO6t1SMV
	y7OxCwfz24OzRMdoLMoxJ75XQ=; b=O8lj7zPKgi8FBgbrcUHejooRD5bwjmBEfn
	RgZYKSxMeq0qhugynI3YF68zURzFG9rqM4BRIBun/GH0ZwOGEFEYozFUzLcBE2K4
	qD8K5xuu9rNv4d8SXxXdk4PtvVZ3MzEAeff3JHplRtF8qpXxzXax1Dj/vcSCMpZL
	NoMAHUsWaqMoM5iRClV2toGOEVHpZoBPR3y7YzGTcnbEx95t3CZcrlOX2DVNy18E
	+JL/4fG2UaAuuG3vcHgA0sUiz+7fQNG3CSE7CsdmPTy0e+6qY32gbU7BxitKAv8e
	nXO6CHJkc9MNbLqX0AU0+B5bkvaXfynXf5QdsDCxuJbC617J8B6A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub76s06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:57:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5252pRlY039757;
	Wed, 5 Mar 2025 05:57:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpamxce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8LzVkz2x9uHrZJUgQB77bMmAbdC9yI2WsvVHA7oBs0nHfhJ27J2C2l9cqmqpXXn4XC8S59kSlGU0jai4N9yc7ya4thtvVwt8H6tNT4UhdIzVUyvf3oCkzXg/wZt0w/ORbDJHs2F0Yq5J4R5KNSm6XX6sGcB3MBnKdLtPAoH+O72Pc6b1C3XWO2MSXKZQInv+Vu9tdh46cGoToO96tKDJAFFH7Fd7al0SaaM+pky3BDguqOEinW01HIM5QrgEyY8Rl8uWQ9xZnFNwR70zhcuAbiwUSj5GlqbX80LqxenUCABlP3iaHqwIcvoo3lAVAOYc17f0JhgqKamzUo/OteDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie1VsSfpxfSO6t1SMVy7OxCwfz24OzRMdoLMoxJ75XQ=;
 b=OzorqHNyVjwFTZXzjbk2oIZSCwqJxIhnL6Zqp8LYOadoFYcx1tRuADRHenS0GZwygCEBG6TzcWfkAUQ7ExA6+Z/z34RF4VP7Ytj4GMn7TGcEUEDPBTnBFW/pWmYUa3Ti0r9nC4IeEs8GNMAa0GiMi0adui1B3+t8m49w45eF6UwpoBBFBSGhK6+k4rnI5xUq4i9jINanYOOYEXFuE+8f9OWp5p6sf0Ucui1iMOnKj4OE++0upSp5MebrceTmoLds8IIY132AQWzGotG2Lrm9YHh/odGk6jK98TT62r++Yo/56pqsRDnFsa9tMgzWm71oD9EgYiw7m/GRbjm/L5ienQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie1VsSfpxfSO6t1SMVy7OxCwfz24OzRMdoLMoxJ75XQ=;
 b=toABFNgMEK7o41tk7MQ1vX5xOUGMf4xvJtcRKlRzydAnHgIeaQkZEK6cwGRhcK/xqmwSGQdaPz2mbdpBDacsg6f/APTAv75/IcjRLUB1PeWL8ECutrbbxbJzsBmYJArGxayQg1wXFfdeFUWusBS5mV6S1PXwq1EF3q5Cie8aKwM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 05:57:22 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 05:57:21 +0000
Date: Wed, 5 Mar 2025 05:57:19 +0000
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
Subject: Re: [PATCH v9 1/7] mseal sysmap: kernel config and header change
Message-ID: <544138c0-5668-4a6b-9160-59da95b990f6@lucifer.local>
References: <20250305021711.3867874-1-jeffxu@google.com>
 <20250305021711.3867874-2-jeffxu@google.com>
 <2a42ac63-d7a2-48ae-ae86-568d0fc59d51@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a42ac63-d7a2-48ae-ae86-568d0fc59d51@lucifer.local>
X-ClientProxiedBy: LO4P123CA0518.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d9d298-8ff7-46b8-f151-08dd5baa9858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2AcRIwgs2Kf0Hpdfw6oV3YOONEOXpReMg0jRDZsEc7ay2+9vZiCyTOqEVZFu?=
 =?us-ascii?Q?jD1vDVDqvO555ekQ7kX0OPiDO4Pv1zWUo2US79mR39e9BYJmCIbTmRse6cDv?=
 =?us-ascii?Q?TLFE137l81rEb2qb7Oofurk0tnPKTMF/Igi9DAZLjAS5+aVP7JkKAwEdPSPx?=
 =?us-ascii?Q?kvrRm5KVFzV7/vxrjNbqwmyWlqZgyeNRP8tVtSTsdvdrAAknDePK31X6Ydbx?=
 =?us-ascii?Q?C1TOHPkq5IAlW45fTeYqyi+Yec5iYmWjEg3GlTq4+GcRk7K0cz3SHFGwbNLk?=
 =?us-ascii?Q?W6FTFZlR4MegxHndwchJTfZlqcKfkXcEFT8R2D/VZMJ6gcQYvdMM98Bc27vi?=
 =?us-ascii?Q?/v+RKh2sCsa9suEmK7TujTluxLIs6jX3eHUk0sQ2pQIwQq+laVtvTZY115UA?=
 =?us-ascii?Q?N0TqUZjvzOvUpLBWA+H6j/TD28nk0MTN7X4oWngXA0d3dyRzROekba7U1f4C?=
 =?us-ascii?Q?eayhem69vxoAfefFlBDFFVrgH7I25YAvCE3PFp35bGZn2nr0sJjKYI/K1rO6?=
 =?us-ascii?Q?whUckm/GvRllBPP5Qonh0EpHXeDkHAx6L0ZgwZcmVAPstJnqoQKI25yJ2uou?=
 =?us-ascii?Q?kEbM2wuldT//DncSh2Ps6nkCPkjy7MDk93q/BTW1SZRCfXluQvtDtR4in6Rr?=
 =?us-ascii?Q?SfRXyzgngue3o13FhJPnbO1K9vk4roxfG+SHLDxTSTC9gN4ffjUUqXGRetS8?=
 =?us-ascii?Q?u734j5wEbV/bcZCVYfGIu22LamQUscub8KG9eJGzjjDZ7Y7JNmsjdJOeNlB5?=
 =?us-ascii?Q?p7eBNLRqd7L+exyI6N77M5M0T8Vvee6OZJnM63UYtQISXMqeq2Tofx12Op8s?=
 =?us-ascii?Q?ePWmkQcM5UTDWAsg0lid1mtVMm8QdYG7MTx7sk6GkgkuzyShq8ojD7y3IA2L?=
 =?us-ascii?Q?6lTbRyfDGup7DG6wmeOdE5yR2XY/0ozXgZ3T2ldU1Ab+0DTur3mLoVA3JLC0?=
 =?us-ascii?Q?VpvC07i88S3/GcWPn7LImb+CcXdQPuA63LTmjIbMhB8supxqhHOGDpIq94ZQ?=
 =?us-ascii?Q?Rf5gd7EeI3COudl7NSxAvi8DQkbPn5UVfBVfRLQUr5TP0A/3pIP6eh0VPEIl?=
 =?us-ascii?Q?Ed8FOe2cvJGb29hdICyjNliVF72FVxqQeFhcmsTfg/6EWdgPC8OBzW6gzav5?=
 =?us-ascii?Q?H51jgVnl8EOv/86SxMgG6yxGc7k4FjaJXLH0VMcwwJDcolq7Y3i0J+MzXzYk?=
 =?us-ascii?Q?SJOZ+TvTXQ6Y1xOwHyvFZit76BTY4ZIBW++SF9ADtXOhhGrlJe3gx0PFu7Vs?=
 =?us-ascii?Q?WGwLxhJatvt+izdL1lmeHo8f3v2m/mtb2QfEobLUnvxv1fjhfKw1XV+EfMVn?=
 =?us-ascii?Q?NbJzhq/RASXdOeKtZznH5vugBA8tCOWFqku3OmHrSlSuYXPLx573E+V97kCL?=
 =?us-ascii?Q?GNhEFb6SHQ17SfyplZ5wpV8mLzu6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zl/JzO+ef7RvVOK9ygKFZHAd5b/iU2jrW7nodTpdBPpzgkw77dHzIEKEHrrj?=
 =?us-ascii?Q?ZeYkz/FMVzjUxHIiXcPaFEkqV2HZ+TVkfptgB9u8covAe71Fm1HDjFFvyJAE?=
 =?us-ascii?Q?1FbVT890E/iY1a5xs0W3lCnTokA8jo3lbTCjNosszM5POxSV46Nnum15H67l?=
 =?us-ascii?Q?no+m8F6qiT7QAFH9Bm3Riz3NZaPrGh+xPunhfCqZ8Af0b7BzHmGWY+1TYtbD?=
 =?us-ascii?Q?5VZA8HCn8Qxes9ScGztAf3glxgno1A4rHOKlFLyiCwT8M7rUNh7PxUSYyTlQ?=
 =?us-ascii?Q?734GaW7iCAP5mzFQIZDBJiALrn6Q90I9vw0dky/CDYkZ1Bn6iQLqIGNydLMc?=
 =?us-ascii?Q?BmGzhxRUVUpPUtJ1pJSMaFTYIOZsPB50m+ZJKUPWlQkVDE9iXBwDk0ptuFJ5?=
 =?us-ascii?Q?aDYFtzAjn4Bn8sbQehKjaPxpX7/JBH3MrEtTPSnGEWy+KJqRDL1bd7AG29PS?=
 =?us-ascii?Q?PfotwECsKbbjr7NGX0wpcMycwpKRBCugvPIohgNcL5erZ83Ms8xXqjLNDpop?=
 =?us-ascii?Q?D782OHKZSuMO7tAx694NIgDTHDCL6D+W5WtNgnszhTGL3s7jYs0UuuAx/sRf?=
 =?us-ascii?Q?C/Sgu3ECvAhhD2mUoZL9qyuRtsum+awxFrfHPNFo8JL+2uutX72zTyReT7tg?=
 =?us-ascii?Q?W2Gsf2ePzehzueTGAsBtZ3saIuk/yRkOD82fWxQWUnYqjGR3colAVMOxDRmP?=
 =?us-ascii?Q?QR99Ns4CXHnFKXf6UlGKi4UnRZJtLhjs9DhR/Mc64Qt23GbZ1Occ4LNRnO/Y?=
 =?us-ascii?Q?VYEZk1qcVy27KJAGUJa2nLiB1ZmHjYMkwk+MAmF5hUYHYnAD82gvZc+ZzcK5?=
 =?us-ascii?Q?1rPa1DAhgQrkQjmt0jMAOuxkYR4CFUv5Z8887hV11CGaEbev2mWfx6QCVAvp?=
 =?us-ascii?Q?xDlerpU69Kyq3bMm2QIdugIlCc0iwfPxjX/6qs+tStqLtvGWfHxRCQyaH5hz?=
 =?us-ascii?Q?44nF+w13kiWZ4tjKawXT0dsCnvA+3f+OM3m1K7L5x8WeNQJBOE1gYRH2E6Cm?=
 =?us-ascii?Q?pF/Hbx2ep70sTzts9hTK9r/zSeCYZoRVdPF8r4rw1nhBfSBRaUZ5ogmHfIS3?=
 =?us-ascii?Q?vm0ooDZDNA6Q8DyCDSlsOqGBu0dFE/ThoNexfufn61YnRSZxoFqJv0hndyPO?=
 =?us-ascii?Q?B5Dx6xub+mhphXlf3fPbhyP8Em543ocLTqKIP4XZNWMjE4EkH94cWvC1ksPn?=
 =?us-ascii?Q?F2AyNR7mX9zMPsqVZkq1VTXUaSLyi2puV/GkUfK8jRa1Vydoh8mgoDeUB9sq?=
 =?us-ascii?Q?fJV1vbC/8zFo+ew67kTlMy6oVhI0VvbMzBBl9MiiCV5uT9STp06Mc/a/uYg1?=
 =?us-ascii?Q?bXihie4kO/s4+Pt/0rPMhaJlk3+PvEtGUwAjoIXM92coaTEY8yx3QBy5vkSL?=
 =?us-ascii?Q?OOOlYMazZ5+HpbT1bePMoBqmvqOpn4N3Y4iuXZy+ixbMXVL6eiVOGz3ClEyh?=
 =?us-ascii?Q?GIDBZ8iB2sqewcEqyvn2AcZBQAq600LQMuAQ5fpmCZot38Pdc0XIXhX6gOji?=
 =?us-ascii?Q?0Rha/X/p8+Gh2HiTv6hQHhJqhfsrZjF3hsmyqK26n1sL606oRGiWzomgjeFc?=
 =?us-ascii?Q?aaZXjeKujaZF49+tp/dl2+MpKaB39kztnycJQEfYLV4/dS/9sEa0Jt6HdTNg?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2dSSC9eZXBpVU2IrBWNow24P866oDNpIvGtN7NJusK1++A5P5ADwGtwKeqUMMOLRGrkTtLSl3tzKO68mOq3Wgo9EvaUlmFewrzZOjb6qGMPvzo8GlpZ6byUDnaD75bNBC18QT0Iu6nsgS7vyUKIiUgSYB3azY3qRQukBJ3Pop3etjR8WLFPdjLiu6fgpGdCm81koaWj+76hKtLf0RNerMaGYGY1mgHUOPBv2n2Sex/it5qEKJbFgSHYzJmv73UZT1JhKKyHpcfuDFFX5P/rjDJaLw3I9vrVVuSUKmRsfN8wXDviMb3Ly7gQ3rmcYP0mqexYKXpzpoYstUugK3g1v5zqb5m074CYS0qzqjWMhs7Lt6XM3EJx8ppCNKVpNJCzkB5Dzg29y0nClHLEUtBkGNBEMeA0rZTJzwslPt3FY3yHzBvt+UZKlZx+eS4R7J+hk1oL7SRkx60FX9gH9d/KtBUP8Mwb/xT59XrhTCFxAr9Co/rX4v22PImijFJYj3plwpZSddxZ3ltIfZbp3X/rNj4OvDaO3mHtKHQmd66j1m+NgGKYD6N65hNwWCINDFcqkjaB4c0QU0T8Er3rO/YOFWai9nZ0zE7c+ZFSe3NwIfOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d9d298-8ff7-46b8-f151-08dd5baa9858
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:57:21.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmysNqUnHrmMWmv52DJJCphqeML3PQKp2eVCTaH2IsxN4S517SxVuhkydLha4i6J0aAKdJ52COIDgzLkTlca26/5tLAKtyEfrzl/DA3twR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050045
X-Proofpoint-GUID: qadNgajGpCc6pMKj9TCgkj6OhpHTp4RK
X-Proofpoint-ORIG-GUID: qadNgajGpCc6pMKj9TCgkj6OhpHTp4RK

On Wed, Mar 05, 2025 at 05:54:24AM +0000, Lorenzo Stoakes wrote:
> On Wed, Mar 05, 2025 at 02:17:05AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide infrastructure to mseal system mappings. Establish
> > two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> > macro for future patches.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Reviewed-by: Kees Cook <kees@kernel.org>
>
> Umm... I reviewed this too? :) unless you made substantial changes here
> (doesn't appear so), please do propagate tags for each revision :>)
>
> Anyway, FWIW:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>

(you also forgot to propagate Liam's tag here)

> > ---
> >  include/linux/mm.h | 10 ++++++++++
> >  init/Kconfig       | 22 ++++++++++++++++++++++
> >  security/Kconfig   | 21 +++++++++++++++++++++
> >  3 files changed, 53 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b1068ddcbb7..8b800941678d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >
> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +#define VM_SEALED_SYSMAP	VM_SEALED
> > +#else
> > +#define VM_SEALED_SYSMAP	VM_NONE
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..7f67d8942a09 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >  	bool
> >
> > +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +	bool
> > +	help
> > +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +	  A 64-bit kernel is required for the memory sealing feature.
> > +	  No specific hardware features from the CPU are needed.
> > +
> > +	  To enable this feature, the architecture needs to update their
> > +	  special mappings calls to include the sealing flag and confirm
> > +	  that it doesn't unmap/remap system mappings during the life
> > +	  time of the process. The existence of this flag for an architecture
> > +	  implies that it does not require the remapping of the system
> > +	  mappings during process lifetime, so sealing these mappings is safe
> > +	  from a kernel perspective.
> > +
> > +	  After the architecture enables this, a distribution can set
> > +	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> > +
> > +	  For complete descriptions of memory sealing, please see
> > +	  Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >  	bool
> >  	help
> > diff --git a/security/Kconfig b/security/Kconfig
> > index f10dbf15c294..a914a02df27e 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config MSEAL_SYSTEM_MAPPINGS
> > +	bool "mseal system mappings"
> > +	depends on 64BIT
> > +	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +	depends on !CHECKPOINT_RESTORE
> > +	help
> > +	  Apply mseal on system mappings.
> > +	  The system mappings includes vdso, vvar, vvar_vclock,
> > +	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
> > +
> > +	  A 64-bit kernel is required for the memory sealing feature.
> > +	  No specific hardware features from the CPU are needed.
> > +
> > +	  WARNING: This feature breaks programs which rely on relocating
> > +	  or unmapping system mappings. Known broken software at the time
> > +	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> > +	  this config can't be enabled universally.
> > +
> > +	  For complete descriptions of memory sealing, please see
> > +	  Documentation/userspace-api/mseal.rst
> > +
> >  config SECURITY
> >  	bool "Enable different security models"
> >  	depends on SYSFS
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

