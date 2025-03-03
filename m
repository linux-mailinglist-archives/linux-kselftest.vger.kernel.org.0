Return-Path: <linux-kselftest+bounces-28063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB6A4C435
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D42189634E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4C8213E6F;
	Mon,  3 Mar 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QWdKMsn7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uipGeLf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBC156F5E;
	Mon,  3 Mar 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014390; cv=fail; b=Ii2KHkPc5lc+k+8Fb5FpovgaUtE/25o6neVF26UisPfv7+FJwV/8fhR4s1ABMyeWOPuwYJXVZcLMy+BYAfahmEaAusKoSTuklZ/r6GKsfrzGvBStBidVDOuETHH1FvI4aFPdiWLzQAwAlfzYgZWlgGQF3iJNqmZWasPBZ2lmPHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014390; c=relaxed/simple;
	bh=zzl2v8cIg1UyRZp8TfTktXxN2/8zWrQs4fyCEmPqjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IliJz1jMRatNK+9s45GmAOst3LYhVudf9zk/rmzOqzRblpzvA5oAPt+MPo/1wKWTT7nk9Dhh9fHMhwoLGJG3QZDMzW/x7lOCCmNT05pCdVvDjBwpH0i/4HVsnt21h5VuyWhJg5ki1Frls4dY0vOQhT1ZT0IpIbzciqNA59wNrSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QWdKMsn7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uipGeLf0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237thYI022629;
	Mon, 3 Mar 2025 15:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qdMHTPVq72FptlquK1
	bOJ7wQs1YxHjpQzgc54nyDIpE=; b=QWdKMsn71+veP3l6t8QPLBR5BVBNfCYmc1
	1T7UrCwXc8BmK1tGhmq6E9LbAaCJerzJQJLUBEI+u4kOyEdowh9XJKhw0z+m3J69
	iN22R9LIuBrj/LmxEbhsA5lN4jxGStf55Lv9gGEEXrF2IRGR0yCBzALxmI7DHJd2
	kYJ7G8NPkpbsRm2tIAwPNT7r+83WrnahyY/gIz61LgxgVsXfq0Min4h58c6TmFmI
	7v3xsp5VVpy5g3L0r0jM+LAS9pyMLsTFF9FtC87nl7ANWEDe9hZQ/KQIv/quxmEo
	ctwWY6aNU9n1+RgCvo5J0t3IM7GNtTD1kmK3kkQhcT9DiCFEasqA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8havna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:04:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523F2GIF015762;
	Mon, 3 Mar 2025 15:04:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8u93g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV/XoIqbBILsxy7gb485nSLR9QHxJ0I2cZ4FDojkPjjZuoLDykRYDc1Ag+eyEsTuyquRpFK8BbhBebivPnDGvjhQzLhLtFIBqfHaQCun+J6uNHYAr4uYtNiOiaDhsG97xFEEqGjAhYKxDiyEvSVje8BKBYqHzoPZA5C5Rc6JITsgFe0uaDkWXJ1r0QhIYxScakOUBZeTqJtczhzaP3jQROSrFGE6BB6/qyOC68wwmfvDWujSEzFKbFiD5+WHKIYGMXyYCihPKBaaOVZPH81dDxx7pQu6Oproxb5Bdibus9X481LWpRpdU56yZjsv8V7djfm+1guVdBA6f49o8UiFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdMHTPVq72FptlquK1bOJ7wQs1YxHjpQzgc54nyDIpE=;
 b=xSj+j+i9PgmWKYyqTPosYOtBA1FS14ONoG7xl+xQ42SgWawqWvoAivSiRvoqm9fwWQQ5bZnKLd1iQFx2Qo23x8MU/R+l4IrnhygC4AZ0p0JyXOq2ZS0w6jFu2C+ErodGdW5FBl4an/yAlKCgFP0QdXq1HjHIl+hd3R3Vyn6urCBF/60lNZ78qHB9ArOkNRNdDLJyjYTHJMOeANmy/a0RQ1ZXb7NBWB/COBL1S36cIZrNRiZPtBSeVlTSMEL/Sm6ZO1hGCpjuLKlT33ktd82dgwxwoXHX7wmdHoC4uTcvw2j083ANXkgyss5NH0OYJ/Ht9YCGA0UBAemNVZkr3oUBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdMHTPVq72FptlquK1bOJ7wQs1YxHjpQzgc54nyDIpE=;
 b=uipGeLf0Z0gWUeclcHtVkrIb+lqOWyC/WZbNgFd4hd/cz+AUh0jmxRw0c2/ynPJagQzkjjumPnNf2U9wJ3Y9chUPVWwV83Mv64BBkZEohF4p3mEvJ5H4Dt+f0lGO7q97mf35hPEYELjcayv/Gi59T2MpaaN3MI34Ffy6XQW4dlg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA3PR10MB6951.namprd10.prod.outlook.com (2603:10b6:806:304::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:04:34 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:04:34 +0000
Date: Mon, 3 Mar 2025 10:04:27 -0500
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
Subject: Re: [PATCH v8 4/7] mseal sysmap: enable arm64
Message-ID: <7kyhmcesdskq63w5jfmerpizagh23jh56lr43wnx5l475st3an@g7xkurbjh4pv>
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
 <20250303050921.3033083-5-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-5-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0374.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA3PR10MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dd892c-b613-4acc-8da0-08dd5a64b517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgneBQrqyB2EmJIubocZNLCW1AsUVOiLzcU6yLlt1oS/zoVtp0PFNfB5G92d?=
 =?us-ascii?Q?h9lL4mnliesxvEhxZHYlKjN1PrZ7wv4UVDRl2cK0TShJJ6dLc50bkzEg4LFI?=
 =?us-ascii?Q?mGzI66HwhifnjWCSGuGT4xf/WkPBkceYv6YbfPvvRaHd3y6pmVF73Z0Hc3fx?=
 =?us-ascii?Q?rkwgBH3QKfyehCi4sieobx3XjR8b4AL0d01TFenPxB137kioYnOoXccDeuuk?=
 =?us-ascii?Q?cHOe5jLERcwuvKWclfzipc7u5e3ZlnU1JHT6MW0AVyQB+SOLC5wbhT+WLN8g?=
 =?us-ascii?Q?dAgVKoI7C3+457y1Fo9A4af+YxW/PIGly3LlmRpaKIQMYI/Tv6DNi8jPt5Tx?=
 =?us-ascii?Q?ykVhHYwY4CHNY2QdppMwYJSOP0FXefhswU08TuD/w+9/e7Ly85XDETpZNsYB?=
 =?us-ascii?Q?+Z92U0H6NaM0aOc8BpvVI7oK5+pUom92l5Q6fayVtMfLfEIMoXwV9ktySp96?=
 =?us-ascii?Q?0NgQ6ZIAdD3iNZIvtD9OyUaUAfSk+Jqk30AAMMcSqWBdBXiQMQ8sBY8JLUzv?=
 =?us-ascii?Q?MeJ2jXkjGKRC/Ql/h+rMOlHEhX/O97TdGLBpEhAkTE8ppriy83yuhKTtdX//?=
 =?us-ascii?Q?9AFQYQ7sVTu45E/pSUNWFzCtM3xB5eca9QEsMFVz65acsbb5YGkpKkIN4KfC?=
 =?us-ascii?Q?RS2PRpX7xSPAcdW2kIEa0GQcrIRL79LI7G64yPVQcZHF+vdum2ASOy0FgZis?=
 =?us-ascii?Q?zo4D0AAwO1McmGtW9oKfRE3sMY9ePf6WjOhHmAcTMSj2P649Ss0T9MCwzkN1?=
 =?us-ascii?Q?hp4pOaOzUqNEYLUksX1rXsyfygz72Nq5A24C3s1AKn6q64scGWxNo1ncfD3+?=
 =?us-ascii?Q?HAyyEms8oVcgA0NHPwUr2bOuTipga5B/onFW6khMlQYy5y03pL3Q2UMpleok?=
 =?us-ascii?Q?Uwkk5K7B+5yh36tQ/HKG0CS5qGuu+reNI0gUBTM6E4t3F3jJYcxRrqR7CgEG?=
 =?us-ascii?Q?qlzxROc8gtzjbvbN5bCDA38RFPKFMs2LNwoNhO+46GSK2TbuFUhQwecYEm+I?=
 =?us-ascii?Q?315q30Ys8Ill9Pzb26eXyIEq2ZWXfiYNHnXBcUhFBwAuK/iKsZy1Mvv3QCZH?=
 =?us-ascii?Q?4bbBAaarKRqD9DKi9H3B5eLqZNHEZ6akKM9XLwUUjphKJ5hOyMwlG+xDihKH?=
 =?us-ascii?Q?sKolb/XGRE13ec6dMdvXZKuQlcd801mS9+sYe2fHSMr4QuoklFxYCkvGSchS?=
 =?us-ascii?Q?FwpBfMlQ4ewQzqXdVUXk2j/ThYNjwhwE4FD4kMe29L2NlcxaW5y+woqFHAI0?=
 =?us-ascii?Q?4uYkEjlvYt9fqebioVaxXAsxDoDr6P0d6RjTrn1BA7bJIMG6OuRedsI2eZva?=
 =?us-ascii?Q?4FU7a1HErlsDYxaKEhUHJKvoEG/KXzMTD5dXsYZQitji/n+9vu6iIR4G5ZFp?=
 =?us-ascii?Q?i0m6QRog6YJRdjX1TCyI6d3df0du?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?We+cUr2msrzN9NEXmVhSV663FW4py1uU0Nt9YU5fUcw5xkDsuVSGluY7JZcZ?=
 =?us-ascii?Q?ZLAKm+wabC4NnWa1OLCFKq61grzWgIdo6HFMwM6tcDfptoLuH2au74joJ1DY?=
 =?us-ascii?Q?rp+iRARWlJtd7vmitsuL+cwgxGiElBcOzvsfio/aA3l+A+iWwRtKGwbCgPFq?=
 =?us-ascii?Q?pHaJD5X2vIziyqoj7oFhLVG9JkPhsQODCEer6+FDC3ojAAVJNg9CxbDYzx/m?=
 =?us-ascii?Q?+rywDmQTpIDik9t9ZgIGSL1fUCUI+W7YUyvy2NPISNkVPiHcROH2MflynMIh?=
 =?us-ascii?Q?MAgHe/qM06bSCJdyeEemm8ybuffGa+UvWk/iCybzlj35CBZywhrFU1qH7Kf5?=
 =?us-ascii?Q?TwB6tsCVzwzCogV98Wl5/R12sLjRudIFPfXeu10Stm9Ubenp0YGkmh4qR3Ma?=
 =?us-ascii?Q?9IvAspXRqlhzlVxEWQcHuoyFPMxuLjko+P08D4+sotrIUEBMc/NUx8yHUSbn?=
 =?us-ascii?Q?mLdAGHsPN37DcKD2zKa8fw1QIh25muqQlYpSWIU47Y2QtjeY/cNceGmKOX55?=
 =?us-ascii?Q?xbjG02NQPLYYONLJR8AX9HX+6Ntm2if618tTy8y5XQxsp+kf3WtqjlYMMW8t?=
 =?us-ascii?Q?2kK0pv9klEsLCv1RcWnqbvTPLMwQOZXSfXWkHqh/VfnJIozJKdySuWdyGZz+?=
 =?us-ascii?Q?uQfk0A2we4SE/+fqgJtXIVziRCTpmzUlYzBTgkHjuXawk3x4FY6XOSJHQ2fs?=
 =?us-ascii?Q?SjzHPQ7zcKPyhyB3hDPlDwwlrD3fxsyx5ie6RgW8NZJVqWPfJ7O7V1hKXMTi?=
 =?us-ascii?Q?VOsDevxi3ipgQd8+JXdGWlCb1at0JpAip6EE0XVKPUiMvnXKAQUz7XtSB8a+?=
 =?us-ascii?Q?B+WBBo9oP2BYoP1Bpqr6GHnE5lZNmr7sq5v2bJmQhQ6sK/ru3GvC3qHZ+DCm?=
 =?us-ascii?Q?YI96NS02JP5b22WxKofd5yox2Lp/tyBepDAoFE/0b8zhbJZ2n9JwePDvcY67?=
 =?us-ascii?Q?qxRlfUowFxSv7RP1qroPIOGxIJ1RaHfJjY/UD7vzwRlu8M1Y1yOW+1kvBlmT?=
 =?us-ascii?Q?wBCVINwoTXXfoosaVCOFLxZathgW1OD5f3xXz15lf3nOAeBViZnl8chFujEr?=
 =?us-ascii?Q?YIp0jlpalRrRUagTdjrSfnWAUmcXsgSN2Qqpi6zfCib51AZqmSh7DJ7aVdv3?=
 =?us-ascii?Q?7rKMA+UmD8OAw3wfuP737gORPXCPFJ461POB2lZJG+EQMSUjj2HubBC9bINR?=
 =?us-ascii?Q?E1nNdoR6z77/xVmEne1inzN7zAcRn3D1RdsVFdrlp1LGnPPSeDtNFjTyvQU7?=
 =?us-ascii?Q?4t+fwo6RT8VxU16p4irMNfWuL8WK/XJUZE1f9YDJElIuXUIvTZaWvsCf0aqu?=
 =?us-ascii?Q?4RSVHTNLSu0Q+pFYIAqdf8WnF+mMYEmDX+nsTxT2bpalPHpCh4s1etQna5FL?=
 =?us-ascii?Q?rZ+MGc0kRwD6mQEQ14iLzeZesnbQX2ZNFZiDdLa6LEp++TYdL5ba98RdbqA/?=
 =?us-ascii?Q?EFgrx0/hjgXnFVcHj+Tlx/uOw7Whc7lnaakeVukC3x9oq/GR0ISkEqLm7mkM?=
 =?us-ascii?Q?omhr3oQE20JWrokScp907g7SlIygIPXpbzQIRlK9U113zoPQ9zd7CHDTvv1p?=
 =?us-ascii?Q?GPhfoZgjEv5ob4ofglBCAlZ/vDQ3cFlUx9vrn0in?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SwPn2ANxlhbigxM0J7l7tC4M9327VITj2GPiT4gTk+BrvAbFQoBmeG5+e9OzOjksL8nrKMgz5gIcOFHYwIdnzL++8jeEVEBNJi8CAk/wCHkoD7+ZmzLDPPN9YAhlGk6CkAPuua+w1Di6qxekuoCJu2k3nWrLBeF8lXYWrRrRxeugEPbnORsqYG9LAhvr3U+IqVNryjULlmuy7362rcYbomNusM4aj/JUudQa87C3XgwMpW/xE+yHomMtBlJTAuMcGHHrY2IZEqHwWu5TAeGhnE82g4h7ioDGQZUyZywzz3jiyUagQB2XUY14qeVHrLQtUptLkKoO+Fhsie4wWkpKUkl355Du67VWlSOzjQJBftTECF4rrOyZfji21+dvswaLBk+rJovPW8AO2q+G6jDUwxzVbVd+Z84wSoG5yHYdrXaE3Oi7f8f8HUVqeCC5nHH3X5g/uLJejFvgM6Jse6hJwVl4RdezhBWOoUGFdzkm7nbQzChtrmD2IMoPA+Kf8G1XdWS1v0keYByxmIaQOqh7C5LBRhtutMf/QspabeRWIg0cAYmMIU1XLdeN5BgUjYUddBKCwsUO4wc9wDq9juJSm+PJtFSXvxbnD5V17SALsj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd892c-b613-4acc-8da0-08dd5a64b517
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:04:33.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rleKiDqR6y1i2zx8al9cW4gKqeFCt8UMvgSBxpSF21dkiTR1KzPHJkmqIR48BxKBKoNWbqWY34JQUZMgw8F7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030115
X-Proofpoint-GUID: -lYMskG3AyZt0aDsJoRT1p9pIJkY9QQZ
X-Proofpoint-ORIG-GUID: -lYMskG3AyZt0aDsJoRT1p9pIJkY9QQZ

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> the vdso, vvar, and compat-mode vectors and sigpage mappings.
> 
> Production release testing passes on Android and Chrome OS.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> ---
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/kernel/vdso.c | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..282d6cb13cfb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -38,6 +38,7 @@ config ARM64
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_MEM_ENCRYPT
> +	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index e8ed8e5b713b..69d2b5ceb092 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -198,7 +198,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	}
>  
>  	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_PFNMAP,
> +				       VM_READ|VM_MAYREAD|VM_PFNMAP|
> +				       VM_SEALED_SYSMAP,
>  				       &vvar_map);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -210,7 +211,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	mm->context.vdso = (void *)vdso_base;
>  	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
>  				       VM_READ|VM_EXEC|gp_flags|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +				       VM_SEALED_SYSMAP,
>  				       vdso_info[abi].cm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -336,7 +338,8 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>  	 */
>  	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
>  				       VM_READ | VM_EXEC |
> -				       VM_MAYREAD | VM_MAYEXEC,
> +				       VM_MAYREAD | VM_MAYEXEC |
> +				       VM_SEALED_SYSMAP,
>  				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
>  
>  	return PTR_ERR_OR_ZERO(ret);
> @@ -359,7 +362,8 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
>  	 */
>  	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
>  				       VM_READ | VM_EXEC | VM_MAYREAD |
> -				       VM_MAYWRITE | VM_MAYEXEC,
> +				       VM_MAYWRITE | VM_MAYEXEC |
> +				       VM_SEALED_SYSMAP,
>  				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
>  	if (IS_ERR(ret))
>  		goto out;
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

