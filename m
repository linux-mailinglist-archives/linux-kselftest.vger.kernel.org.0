Return-Path: <linux-kselftest+bounces-27976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD415A4B0B5
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C8B1894F99
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8F51D5CC4;
	Sun,  2 Mar 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+5xYrMl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LMVGcyX3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F38192D96;
	Sun,  2 Mar 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740904558; cv=fail; b=nYSe0+GTkV74OA1b2Z2cS8lrDSiRF1K3nhj2bVqIh27w65PGHL+UFbrBZWuJL5ZrUgpNmAjaKA5vJBty2b3T+Tf+NyqqpMD/HwmmYGMqkeR5lr74v/Xa0MlpoBHeQM7UQkI7RAgbq1F+qq1yZkAIAmthjn4g6Wwa0LZiGMJiFLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740904558; c=relaxed/simple;
	bh=/9ph/BR/m//FNOE9pnVhDPmYV02dg+EiUS+0yDBqJxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UqwtLWLqBTg3eJI/sX6dq50llcJ6mdx4WHNvINAbr/HBjxQO1U2ylAvnttp6YBJvUZNxlVFEA5rHTAp7h0jtCXyjZtaqyhk1eWAXLOiM+5H+cCk7iQlYPPwdtsuaMzNjlJQZbXyyDDZpRaP5Gctk/e9zRP3HcTxXCg15XeHXrzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V+5xYrMl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LMVGcyX3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5227SbiO027081;
	Sun, 2 Mar 2025 08:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/9ph/BR/m//FNOE9pn
	VhDPmYV02dg+EiUS+0yDBqJxc=; b=V+5xYrMlXfm8p4R87niBjuWhxPqT26Sfcl
	QWH09FfFYKSFGvzZ45caqULQrKk2+cKbu9tx6EK17dHWr1Mid3GDpANi4xD/CHBZ
	bPvi/I3rR4dqCAmmDUOIAz+9nbu+HQ1YnMLhuGjH8hnslXKM/a4bo7D9cIc2jOCH
	8LKzkCldhhFCypBI2N5OilXRggFTLpmesl88kOZFvMB+p/HGpgOpXm7FeJiKt+2i
	hmrW5eM3A9MWcH4Pll/57S1f4bXvuFReMjCrhzMHtP3v+ZMWV6BCRxB3tN1WwxcC
	B7DvyLFHAFdP5Bo1B0y8M7u8jGTDDwzwsuugHfevFB/o9rgXal7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wh27k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Mar 2025 08:35:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52258esu003130;
	Sun, 2 Mar 2025 08:35:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp6cxdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Mar 2025 08:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzgnzR8e6jZA7AcXOc7tgg3F0cH/U9tY4EmaTZX/tLLuvrwzcBf/XVcgdY5zMNResJwOEWuE+oEdNtUHcvX84i1pkdlCACbtHnRN4Qe03zZhu1R6nl5Egvqj5XXSdzn75NenNTDHzKvviku39ZDKOBP01zHLTmly/YLTZ+tHfdLZeCs+q39t7AYj9acuZk0ntYMgr+xQ2d57nFuvNxVQZSKiIysjkfe2r8m7tqaKTfiYZc+ZzqTPb7W0D1WjD7hmZSV7QzN0UV/joL7SVo9eIV0K4JWCekY31bG+mbzFKZO/eHZL1F6YxsUY9TPpXUzcwahyBnhz0XEY4dMehLakyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ph/BR/m//FNOE9pnVhDPmYV02dg+EiUS+0yDBqJxc=;
 b=kHaWUsKa+oLbRuaQc/IDjM6JcXGEDcXrRGlfMOb95bTUC0BbdeCWyEK5lwvuUgRyhRbFdcZqL/oc1YnhZ3C6a6vy4FfeHw5JeuKOgLKgKZkX/sOBltMAWhtUPSupgD2z0X75/WqhhxOOh1z8L8BZFuWlTlHJjU7/q6jf0mPaxq0UbzOg9D2VXKb8jth4hcBhoIO9NKog2TU9lc1oyiQ0DW7rU/bKpuuNAmlCUk7/Q7H4nO4301X9jzKLQs0XMr7sVdAE0iJuBti+8CkK5nKFvohf6iGUahCFaekyhnLnE7M/JL/JYLokIVUvF6XPqx9wBwDWMAd6gcaYS+I4N9uK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9ph/BR/m//FNOE9pnVhDPmYV02dg+EiUS+0yDBqJxc=;
 b=LMVGcyX3gWH6+fKXYisz9zp9ekL9xFxycMBh8+SHlk9UOkZ6FJ+S4ZBm6cpqbbM1yy3k8/BKvOxd8xVZsj/h9ZIIwY90EVAeNH3a/i5NQfllDAHIZOQ0+WbHVlOHd4c8yxpKwt6M6OjGqCnabTn1AYJyY2RgcJrVlgZmE4AWY8I=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 08:35:19 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 08:35:19 +0000
Date: Sun, 2 Mar 2025 08:35:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 2/4] selftests/mm: rename guard-pages to guard-regions
Message-ID: <13426c71-d069-4407-9340-b227ff8b8736@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <1c3cd04a3f69b5756b94bda701ac88325a9be18b.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3cd04a3f69b5756b94bda701ac88325a9be18b.1739469950.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 527fe2d2-3fc7-417b-bebe-08dd59652a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsSZ7IdpCGM0vd68KV9IdewWUVnVvru3unqj8QKn5EB1C+bhucoymZM9gMBK?=
 =?us-ascii?Q?kSu9FCahTip6G2qJSc+Av2c5N4vrTvXlENUdqvD1Pu4AfVUJjzh6m7GQu27T?=
 =?us-ascii?Q?9g/Ij5ISK9L+EYWfNTg55r3GyWVzYaY/TbV9vjQ++QF/hYTuwGVmBkYqfhwQ?=
 =?us-ascii?Q?8395VFnvv0T8y4yAc1CosgmXe8Mu+hCuAQVrh8mknS3P3gLC8/CWcAj2yDYK?=
 =?us-ascii?Q?9gJQbXK5ldlJyflFkNNvHnp7EhQl9908dxtHIcsOcUK+P7ww1GVh8UxAy534?=
 =?us-ascii?Q?PQg6mIJMTSFZqb1iQZ3ETnABk0V+Jtfe5ecJZDYnANIKQ66DbqvYqMqFEOs+?=
 =?us-ascii?Q?P7CrJycCMaBrYfX/mFyESjqquhnThyUXSQV4ZcQnbs+KRegZ8PIj7SF56042?=
 =?us-ascii?Q?X7ORcXj+L1CILptpiGKKdoxt/hemC6QqeNsrH41csGKLUZSMAIKBgQbepdIV?=
 =?us-ascii?Q?YfARhxzlsj+JDtngjhfS85gNluh3EZP577HBSE/5cIm2pwM8LZtrL0YvgEQL?=
 =?us-ascii?Q?FXG45CRhzpeP3mvEoYxUuiF4VfvgYEWNcr9HfpbSyu2bmKDVMvwlhS5Z2+Qm?=
 =?us-ascii?Q?jOLYoE7x3QJabtj+unDP55l0uX83coIZ5YlsLyh8ViEnbxgga3dt6FvMZfXQ?=
 =?us-ascii?Q?rvjkiCGOkipxarp8Ah3JyjMebRQX3DzaR6lxC0+VFz72ufOB3dz3b73bKmbH?=
 =?us-ascii?Q?tEMqAc9afPGvmQmTkggNvf2jslIsyZSAU1J//LzznocZ/ejHVuGkrVsfWML0?=
 =?us-ascii?Q?5vBWOk0z0T7sWsm/qyacM/KZOKJRRYJDyERs8qJhm4+iDPhXrTRMZ+2Wp1Nq?=
 =?us-ascii?Q?pb9ZPydHRwD4drLXzv1O7jQaUwNZlUuHcShRbWNSZVC4kFo8kAMIjyLOUXH2?=
 =?us-ascii?Q?VggQRTrwTLqJW+LZ8OmE62kNw+duOrqFLtrzbl4RzUFWUvt/d40rc31e2KoT?=
 =?us-ascii?Q?6vuTf8LrDfUoFsuatqfDHOQ9ylt7hp7hZtY/VJhflw/JoL2cX8jdJdPG6nmQ?=
 =?us-ascii?Q?0Lm4RKWlCxAq3xp7CpbY6qocEDLLQNjtEItotHmwGUIgKl8iIk9I6CkYexgm?=
 =?us-ascii?Q?IGsAIIgewGeVARDDFE/vX/AusZT0QNWMSCnrsGyWPJLuQooaVyWOjC0EvhwZ?=
 =?us-ascii?Q?rzhvrXDd9ZFD8ZOB3MezzqQjEjO07AhVhrXQdWMHSKLs4ePGwQd2sYiOMcxD?=
 =?us-ascii?Q?uaJJwE7ZN8nADn+zb+tMO2RthM9T/IR+gyw2gziRhQGFtG9uc8HaiaaK2n+7?=
 =?us-ascii?Q?UoLIM0EC350n/VqdJHrkbVwDKj3jdDrta8r+120dVS1e46n9U2NoZwYAuXlV?=
 =?us-ascii?Q?rXEd0wExDOV2y5TczD9EsgB5ziNueFTW4sJzeyTbpdKknSpo+3rwS3dlTM+j?=
 =?us-ascii?Q?VOZxfs4eqIAWWn9WQd3g4LxKVTgs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+C35vJwwAmtTB+mt7Ke4DRbxjZytRFDX98qTiUQfFY5qRIqO264s8rs9cnR?=
 =?us-ascii?Q?fRsOKisZWSnfQK3sMBo7ubao5MNGO86y9mQ0gAwufe/96uYGnKCrG11kdkQc?=
 =?us-ascii?Q?e4QATtTXdMaMGhbGG9faRkXCMJAQI6f6rSxx8gyuO216rUzkGqWfx4SBTCBs?=
 =?us-ascii?Q?QkXy7C4ZAe3l2pD885DFYT+U28BnDpw0RqqiGdchv8L2fsY0g1YWDTqHE/XJ?=
 =?us-ascii?Q?afSqotRfHwAkUIDI9zPLUwc06TaDlYPtACNlRmEPV7XlTSKB0WolrieJbCWy?=
 =?us-ascii?Q?jgcFtP9liG2rlaRfLYVRBgyeN9b0ZlfhBNlLKMvrIdUIlKAoblVKwVvCfAAr?=
 =?us-ascii?Q?YgI8gvcA+cxHILMdm2FQqjMWDlJiv6i4gy6nU9+v3eFHdDH81SZnm8flwRXv?=
 =?us-ascii?Q?McBLueHKKHQnWh5Kgg850+d8Afq2rQ4JNrXcR3R5z66CpP38g1ztnfTsT8f+?=
 =?us-ascii?Q?WtHKzBGbTBtDBv1ij9ARNkqbP9L7ig7Rf8HKyvsbUS7Lrf1uke1qfoe7rSC6?=
 =?us-ascii?Q?6gRqURDY4InhfIR9znmf+a7J/7zyqqRRH5QYtEfHXXrboE5AMsIoWiS0TTUB?=
 =?us-ascii?Q?h0fvt4hfWSo4HQZWz6i7WcW4yPwizFSpcqG80YUvJ0rJaT4RiQ2Prv2+/2oN?=
 =?us-ascii?Q?Vf6L/PTzYBWMtrDguWlnb/ru6eaakPD1z8RvEcmAZjQPAOvDFyZXnbUPJFon?=
 =?us-ascii?Q?OlIeSID42WX7SCJKdfmVv6ADSt40bw0ACHqyWKG2qidQtDgFmxzCuwFkcuoz?=
 =?us-ascii?Q?VU+DWAU0HIcCoRRXyxqS27PtKhtaa1wMuPo6gyu6MMltissRbY64n8nNLC61?=
 =?us-ascii?Q?wVgcwQoL0cyVJp/RY9ngqsrxCyVf1I3tpRLXElj29mOipyCD5OGTFs6Zmqto?=
 =?us-ascii?Q?OuqkVo7F5FTFT7c4xW/uZ3zW4f2rymPYLJlvPpvOMyi3mm/3svXGWlYv5nTU?=
 =?us-ascii?Q?vJQes+vrdR6XKxki9vUUYnz+tMQYqIwVWLjTdF8PVCUZ+fJIU1MrEfStWSPb?=
 =?us-ascii?Q?zEDEhx6WAa0GBcEFc/3MscfVvzBNQtBTCkXDIxiS4AWJ57h/bx7CQ/2Mrk18?=
 =?us-ascii?Q?jVBAxL2prfcvRAe10/44ccjIx0pn4cvcYMYEjm8NaO/O7e86s3cRE00TLndT?=
 =?us-ascii?Q?vGDJLWX/lRxgg8NnfNCEho/qLlhI9IJoqnVAqc5CfKYEUtR0UofTTbjAdBYt?=
 =?us-ascii?Q?4nBf4XFhpOKOZJEZnq8gUUiFMPNU2G7cUmH7lMOrbZ+bi2Egg6+KAMQfAspo?=
 =?us-ascii?Q?okHbl4EsY9L8aABn37jEeVA24/rPgKfe6YHGWoJ5T3icqlHzNm7A9eAo/skw?=
 =?us-ascii?Q?f2buRcdOB+n/1l+CqQkWKqDIJYk2OtxXGEdSkAtLwywshA8nuQn1yCVn7ypG?=
 =?us-ascii?Q?ekMohvvRkPit6AFxSwYpQDAZw+VRGY0Sl4p/zpqa65+D3/ikXuDPgBmDF8/f?=
 =?us-ascii?Q?F8T+Rjg86s9NS6OD00NWq+upTtV3dLiBGJNuv89bzVIsoPWzWEDBV+kRuq4Z?=
 =?us-ascii?Q?+TEScKPT6Fyvt3BxoptgZxr12zOmcabQhhsGFcBWum99fl6wpzrGEu7okA/d?=
 =?us-ascii?Q?ZITcAagSxJ9aLM2IKLLNzu5tRHqu/NXVOvn8K5oRQpe0tdcEcbAsrjv0rERv?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fLBXeh9Gs7aywZZCAmYooWoV4gsz8t3aSs6I8uQyxgWzYZpMKES7zZJFITxKP83YAh3NMsNxry0WR5VQPDJdc21R7GhXH0CkkG1VMPDt9jUDs2CCYOOEsiuKEo+UAl7d7eqA7UI6DEQJoxSG9RAdVDlImVpImx2ZMNBny6WMicanou6Yt3YqbwAMRs/K42yJwwaB77Xg+WpzXEXy/zD4Lwk74cq48fc0vuWCYlwxedBUBYU8nN51tW4pNTkzrLfbPn07q1FoeCZqthhScw/fkBULRX9f7gxPQUtZVtl5YyY7yiY5XzQfTMGCVIZVmGcU2lgbsorVrMz9aOLwLNBtXVrygl88AacRRbTqs7FBdWlgbgfUq27apzjgNYFMve4kPjW7I112a7Le0ic3NVWnQF6ahjrUnp+/JNYz8i6PbO55T+xhTm5EPUYcNbe2fFWLnuJrSSeVVvXJZV2yH5U7eIGEhloOz+xjQCY7TocGHQ/FkYfQJJqIufm8tn+ouMFH8VanBV+Aciu6MF8fF4vvLHx/YHhHbRbdJXk8nLg4fqtT9XT4CA42zDOnXZNr4qYU1pMy+vwBOk5nxvx0nMqveFaGSbs2YfpaHmvLHrT+js0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527fe2d2-3fc7-417b-bebe-08dd59652a49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 08:35:19.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu195XyHvK/Mx6AmAvyYwau3woxSyY257hftoZDUpyGi/hZgIY704sbhG96vwS64kACdix8yCPp+7uSfO+N7ee0Rg9ItId2zPZenQkkAWTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503020067
X-Proofpoint-ORIG-GUID: WesJc84dWbhtl179xTzvQm2RNI_DAiau
X-Proofpoint-GUID: WesJc84dWbhtl179xTzvQm2RNI_DAiau

On Thu, Feb 13, 2025 at 06:17:01PM +0000, Lorenzo Stoakes wrote:
> The feature formerly referred to as guard pages is more correctly referred
> to as 'guard regions', as in fact no pages are ever allocated in the
> process of installing the regions.
>
> To avoid confusion, rename the tests accordingly.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Hi Andrew, apologies I realise I missed updating run_vmtests.sh here, mea culpa.

Quick fix-patch enclosed, thanks!

----8<----
From 1b9a2d1fad165f9b7dd327a9e369e16c87661e9b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sun, 2 Mar 2025 08:31:57 +0000
Subject: [PATCH] tools/selftests: fix guard regions invocation

---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index fe3606de37f9..55d4453793eb 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -404,7 +404,7 @@ CATEGORY="mremap" run_test ./mremap_dontunmap
 CATEGORY="hmm" run_test bash ./test_hmm.sh smoke

 # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
-CATEGORY="madv_guard" run_test ./guard-pages
+CATEGORY="madv_guard" run_test ./guard-regions

 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
--
2.48.1

