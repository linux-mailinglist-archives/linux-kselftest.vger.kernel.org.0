Return-Path: <linux-kselftest+bounces-28061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF99A4C422
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D386B3A5CD7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88375156F3C;
	Mon,  3 Mar 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZ5NNvb1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z0NiaO2Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C584D13;
	Mon,  3 Mar 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014122; cv=fail; b=Mwqsn5dNBTsdbBXs47wEiO5Fz9QKS1DqQDcvxIVpaXsllHc9TW/s65dlr+834QeDEBjaZKdmBmgg1jh5C4cxLz5gI+J7kD6M3QQFhrWMJ3E+cM5W7wRfecNfjaPtDaSpeU9qIW2yzSPAIg4TgM77+q+MARPu/T+RhF1ilU78FPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014122; c=relaxed/simple;
	bh=tAm+vfu9byn6ZzAXNPdLdlTudfrN44UE1LI7uVh9P6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxb+4XPwCz5M1TZrBCHA5N2HE2Z6BehWdk6LzTS6EvoRKYGLJKGMPzIeLrxlpBFYVd+IBZo86bC4Xy170KcICnHmsZxq2Y1G8WXRsbzHv33H9UqqN3HAsyPveq/CYIa8f5ufjbb/Rys394aJmWUyXimliVQnrH1BdbyEy0YAh8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZ5NNvb1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z0NiaO2Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tc03022593;
	Mon, 3 Mar 2025 15:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qppct/RLzJVaRGoztg
	l7QerBwLBRe+b+slYq0EwIU+s=; b=CZ5NNvb1jFcSReDOow4pRRn69irWSu5wLp
	8nDo74e0C20w/n/+Cqe/zOD1btnRq7uq14vTBdgPVBeucg4bSdi8VI0ec2MizLsn
	xu9twRqzkx1PnlRNh9EI/S54QuYnfVKXLIqOZvsXm+ZovqJMIYmQ4bGR9G6H2LJW
	qvoAbFOrN1/4FOvYGwiDhaUmgya2bWBQnnfRaGlZ6z8YAz1yzHKfzslJC4HePMBu
	4Yt2385sEwaLd0Si5y2LQVdYo+vO+HWCPk/6IbdK+1E10qHeBXlRuz91No2/VGyd
	K072yFGvV366t4KgCNPty70Rb7OFFDDFMNqBjxoh/CQa7JoSw6yg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hava7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:01:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523Dq7ZP003178;
	Mon, 3 Mar 2025 15:01:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7krmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeL6L+LeYuR0JKR9ufheNjvVH7ZPTP7cvCm85pSffWTnVgRT2PDK6sXvcqz9I2QMbtw0nZus4QufajACCkXdkOaym+omKVQ3Y6tUf6hcudpZr+EIBWAQf01XQCmW8Coc1/Hdd0UmZkCDRhsqbou1gqA58gITsxiewpIie5Gmrb0t+0JcJzdi5BGJWZysHyLFV/dAxMAFWcGlU0SvMRwQHzXTRgn78Mnt7rbhXIUjKG+fq+IR+bqAQmcNAXQMtIDFA55K6FGSQIVtRHuLA9a2g7sOR/rDL+KlZnRPGJGOrMpUzxPG7gBzxrdlHvMRt9pad3c0eVsVWxPv0ICNmLiDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qppct/RLzJVaRGoztgl7QerBwLBRe+b+slYq0EwIU+s=;
 b=rWZ0eTBtVDKRrAqyqTjzmiWH8xPAVxM7MYuc/w5yExxV388PU2OKvZdHqJFxb2kwpTxwfaiG9dOYVyvHf+5bgs5rXwYiRU0JbzPP96CQXEJlbwfvR3VtVsCoWQyaEc3Obu2cr5kJLKz0E1WKQQI0iRpWW4ia326rancIDp1NIg6puHxqOPP/czWmm308QLCGBa8K+DR4I7Hq2zXPbVoEBSDgiKYvlfxbzTOHQ5UgAtUPsHnQN1hopUI91YHTzwdYW17UWc1x51kMspelLhtV2sXq7R5MC7SlX7jVjWsFlfP3/f/32hhVzlxa6P0qSdzVIfrd8R+hpQ9bsLsMnjYUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qppct/RLzJVaRGoztgl7QerBwLBRe+b+slYq0EwIU+s=;
 b=Z0NiaO2Y8rfP5Dtk5QeKYUMD+iqnCzBfqn+tCMADCIrMxxHN6qT0qmofoCSUXqNJwF9WNQR7JVyQF/79YabDOAVW0L9jyhF5rkEj6Y5BNGYaV7MFYCq4O4XfCawbvzrqWBXzBc5Stbf+yxOdHe2LY6+UrTQwzRBnHij64Kjw2bo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 15:00:27 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:00:27 +0000
Date: Mon, 3 Mar 2025 10:00:18 -0500
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
Subject: Re: [PATCH v8 2/7] selftests: x86: test_mremap_vdso: skip if vdso is
 msealed
Message-ID: <fguxud5s5lmobsaf5mxbxpc7xodbncetchgs4cghfqobtxwjvi@mwfvomn6cyk2>
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
 <20250303050921.3033083-3-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-3-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 054a844f-22af-403a-9a08-08dd5a64208e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VYlCTv2LdewfSm2Q92CHq5uVUVTww9yiHypgubPFlL6AmHVweImMxMmBI6nl?=
 =?us-ascii?Q?/7vs4wElRE/9T8QO4bz6pexvivkF9Bfc8RZfTNVk94pmXYGucHYnOTjLHe8i?=
 =?us-ascii?Q?LZXjwsxK2hrWpxqEPKAqY8xp+ot96TEIBRULn6wYztkhlCLari21K0xE+dbr?=
 =?us-ascii?Q?prRGujcVgtus+texD0OXOhEJwdrVqIejg7UJXbdzvKRdOykGF2/TaRoQ+R6U?=
 =?us-ascii?Q?zX2tfnqlX0hhfg9Pk4ob4IpMXlQsqiDmZNHPRcNLWESHkNCwN/QC2ZI51Fjt?=
 =?us-ascii?Q?3oVc6C9KmIfT5WSxdqfwHgzZVQDQZ1DhvbVyDLysQ7PlaulSMWuAeeA6ebtv?=
 =?us-ascii?Q?61/E8OhoqJVK55PPyFswpT/OXfacMjeSt0loxNMrjyWHVI9T9uqqzKpAhvmV?=
 =?us-ascii?Q?LQQwm8pY8/Bt+Un/IaJq4BI8wLgkWFWZZx4obKs5UvzsMeXP1LV8Uh/V8/He?=
 =?us-ascii?Q?LTeG/3/wDJmIrnAVG0rcrhbCqJphew2TN9rRp1SZPARO8tkq9yN9TDs58SOQ?=
 =?us-ascii?Q?HOJ3H+QypBaL7jr37/hMXYM6ECQ0jLvUNmIIvtEyXG/JdDHa0i5Fks9Gmem2?=
 =?us-ascii?Q?65P7CVoc+bwBc8yhSRMfD0WERnbbNIWWOi9QKShu7yghtGmDclG2M3Mv6gl5?=
 =?us-ascii?Q?sx9QpBZG2A2kVVXvfgJfF4wrRLiXm62IKyUa2ghes4MmXCGG2i4zUA1eOKsT?=
 =?us-ascii?Q?H6GrOnnoOYiirjsKD9U6AV5+QuWKHn5wi33rcSnO9DtJ9frkALNQu7k41fEm?=
 =?us-ascii?Q?t5QDxjq5M6eJ8E4vub7OT5gmii7tUWAoUCK/ticYtrHzHQWp4Cw7xpmnNBjU?=
 =?us-ascii?Q?SdDOeN6O/FoAQUFC+6zxo8UaOb3fROciiH0o0D9ETBe/t9XfGQz9X88hFgCK?=
 =?us-ascii?Q?IyjM5+pN97ba6pRexmYkbAm4NpVZDrr2KgzLWiT92aODknXJ+zj7aMIrEB0g?=
 =?us-ascii?Q?vHscFC5s6pPw7EFs/dpMpftmuCRDSlzuPMTW63zJobeJUXkP3igcNJMUimnR?=
 =?us-ascii?Q?DRMBFpryXz4PEAB7WOUfY5+mzCRXb4N/elJPK4T/uMSA+hyQSCX1jXq8Wrtq?=
 =?us-ascii?Q?aL5V+zbELGiPBflUQCcVl+x4s3LYBMj+UqNe9vfccTzr0uoo2m1gTLwbw1In?=
 =?us-ascii?Q?IYUKlw7u0vzREXgyqNWDNag50Dt1NdYZMq0KbVlKP0YWzmGs7lR97t1NNLIX?=
 =?us-ascii?Q?CqaThewUzJzX4e+HGdAlNZIwRWDQMgsdx1USNigq3ISzcqB2VynQMSCSsLiD?=
 =?us-ascii?Q?6+XWtTp3A4vMA7TPTSIMtOku6QZninGy6HfT0hFv63hO4f50/svK8wedjWaG?=
 =?us-ascii?Q?4FUSchg4slC8HfY+LfFnA4KosLlMZ0seuhjqPLfqOhV9jxZlkWErGzTmOlyg?=
 =?us-ascii?Q?HykbUZE/jggtzDGhrOZub7PeYskn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5sf4ndf9pYEV7E4EQhbTUoPQHTbwrVbYwsKbpnE1VK6VnAKKj4RMjbsJ5s/7?=
 =?us-ascii?Q?KcnusK0p4akrTfMEzNLVeV+7xG6ca1sbVAvncwFEXUGziYFlUbS1amrVfy51?=
 =?us-ascii?Q?7TEFyaO8z3qcGtb6uvb/dfTGGGbzWfag/iyk+Yja8XQqPXhetJfCuObgJb42?=
 =?us-ascii?Q?AXHiIdUmsZ/jNhWauBk9gIDHtF/uyirIK1Ruwr12hTVTzkWSwSkOd4a5tIo0?=
 =?us-ascii?Q?WRtYe7U8OdbAWdyomEDUlvOeOnloAfSSKKAZ7sITx7h9rPqdn49e3PZMn3qI?=
 =?us-ascii?Q?SfAvlPsrxnHctwOevQJiiJ5LxHoOOW3a3cZalbHgXeK7K+U6zp2VrskWpL0K?=
 =?us-ascii?Q?UcGyC8ZHxvuK4E7AH5p67/GZ/KePM4g1hzLif3+mxjkkuUHjW7u0/JT3MieA?=
 =?us-ascii?Q?cIhf9L+bPe3JTX9Yu7uwiuhjOhJgCyGxmiovwNPSRBWCIkl0yFUWX4fSO1Sl?=
 =?us-ascii?Q?Ad14UHmu8jixLTK1lk9Az0K30/XMob+TIS9NTDYGeU+lfhD+QazCTkkgjdTg?=
 =?us-ascii?Q?Y7wF681MwwaSPZtf5p37s5NZTNWe3InN4Z3gazaiqgUKkinlsjnQF851P2a8?=
 =?us-ascii?Q?wYTM9IArXF6RulgSglpBAvSyqlnTZnzoZkANNfLEZxpgrNTx6cF5xpzXZLZA?=
 =?us-ascii?Q?KE6HAdUnXjoHnVZg2vY9bi9MHGgasFfbcT0ndIRpPghhu4kBnO/MdC12MQ0G?=
 =?us-ascii?Q?v5GH33Yq9VtjqlL0Ua/2OC6+15fQLvN314kLKcmS2E5rBwF+pn9KgZzMXGme?=
 =?us-ascii?Q?AdZ/VVxooEKliIYLItRfdnR+CDL6oNPQUImiXDGgg+KaP9z6/DcS7jhTYaK5?=
 =?us-ascii?Q?0Wym5EjdNNiYe8ZZVZ2JtZk76SkjSmIzJfGr/74gE+NowQmEXwWubAd1Fco1?=
 =?us-ascii?Q?PKHMozBpubaOigZWWt1gTqkSH81jpP4mJe8tjubF0ydHaHpOpKtlxp0HZ0r8?=
 =?us-ascii?Q?h8rqBqh2o0Pq3aAkajmxXcGJNhja3X601PuLqoTKqXtyveSJiB5mvYUm8yyr?=
 =?us-ascii?Q?3ZvvLHx4FtKRjILHGJwBMI/WZqm/coGLPyP/CMs+ewv/2qxY9MJEVIs+xLni?=
 =?us-ascii?Q?l/xmjqKaFOHMzcd7pDhOKC9s6YNBux1YzEF8ybrntApuDGdNT6pHCOofobbI?=
 =?us-ascii?Q?mWVgsyRwieEm64Qyg+wyTj7d9qMsu2Cgq7gnGOZidK96OynH+TetoUFse/0X?=
 =?us-ascii?Q?ySq5EZo41Aua+/HOE26mKadbBchqQdoLPTACPaajwWhtahYnHZ5r5GXIT61g?=
 =?us-ascii?Q?Ug6HgZ5hnVOPDaoxDu9vtrIhu3/e5C26qBocylNNzZM9pkvMeLcnkCW6wNMd?=
 =?us-ascii?Q?+VQiDbiGDHZGxwIpkZ3yJfmk/Ihy6OOp0KNyP6tABXjTDtJUEHCQKXTHY46q?=
 =?us-ascii?Q?tkKG9Bo3hUAwj5GrOFSVlN+FsRefSSqFpPhz+O28QMF9XcgaND6/NuydS7ZK?=
 =?us-ascii?Q?ms+NVuFhxnwWKuC1wLAQQWkSX8ts6kEDuQ4JoNnyS3bK47OLv7oI4DbBqh/C?=
 =?us-ascii?Q?1GgXpBXZh/vYKzGK+Ln6bmR+3KI3WXz6Yobi1rLE56NoLpOBi7dvh1+qH1Er?=
 =?us-ascii?Q?NV/OymFh3Uzu031UIAxBp/zWzpRYnWIGGIvXO5Tr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P2kIj3GNU8b27q91KP0mSmf1un0tvs7vQ2sSqqbSTRIy2vWb5NTgCKAIQrHCp6hM0U0kyo6WdPr9XSwBaWY9nwloqjseoG4IhcoYZ5uDpBiLFHpB0iFqAE9+1X/cbkZ/I3bu+q/BfH/v6mCDD4hovPu0OAHbaiyahDBTVuLpQOJ5GySKDTXsg+NOVcfO0+bMJZ84Hmlu6nG47lFl5qc4gwbMMUe8aTQjFlmN51g8sLKYWp6Cz3AnsnfJxzo5Xbv/PaZZ3MESKnFrQzyJRDh9kxd9i8K3x4N2ljEqra7P1jiGTO/2IHSex9gZRdsTVKFYyz61nYVEZw6WN/QRTdZ8TEcA2Zq43PQqb0DXsD7Nuisap/fVCsy9lBIuIocHIojLRstDqEuL1AWxpLK9yzNx6Ld/L0Z4/bNZ8xeViV8XbeWmq2GHfDwfgPOW/wjvHMnFvry/b0Oau7JCgMCPW2P7E6Qquy0lSB6n/cpfoubZhtCA7+ys4m0sCb4fQQwyWGkf9IgLaUrAwZLc/SxUV9EBPqWdya3upzXQi31dGOxmPGKxzBVKDfKNiUbM9+frt/zEx7ygqJTbe9zvym9nYRpvISnEVNlLJe1hzxSJmUuP0mI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054a844f-22af-403a-9a08-08dd5a64208e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:00:26.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bP8LSQrhZjdFeQXpNEHSO3FmokjSaSM5oAsxEf/0yjOVZ7ViPsg5Kd2SuLt8m1dZvxfC31/wF+N14f5rUbBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030115
X-Proofpoint-GUID: IlnzvQBgGWw8xwlE5J5FkHpIkIJZw2gN
X-Proofpoint-ORIG-GUID: IlnzvQBgGWw8xwlE5J5FkHpIkIJZw2gN

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add code to detect if the vdso is memory sealed, skip the test
> if it is.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> ---
>  .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
> index d53959e03593..94bee6e0c813 100644
> --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> @@ -14,6 +14,7 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <stdbool.h>
>  
>  #include <sys/mman.h>
>  #include <sys/auxv.h>
> @@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
>  
>  }
>  
> +#define VDSO_NAME "[vdso]"
> +#define VMFLAGS "VmFlags:"
> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool vdso_sealed(FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +	bool has_vdso = false;
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, VDSO_NAME))
> +			has_vdso = true;
> +
> +		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  int main(int argc, char **argv, char **envp)
>  {
>  	pid_t child;
> +	FILE *maps;
>  
>  	ksft_print_header();
>  	ksft_set_plan(1);
>  
> +	maps = fopen("/proc/self/smaps", "r");
> +	if (!maps) {
> +		ksft_test_result_skip(
> +			"Could not open /proc/self/smaps, errno=%d\n",
> +			 errno);
> +
> +		return 0;
> +	}
> +
> +	if (vdso_sealed(maps)) {
> +		ksft_test_result_skip("vdso is sealed\n");
> +		return 0;
> +	}
> +
> +	fclose(maps);
> +
>  	child = fork();
>  	if (child == -1)
>  		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

