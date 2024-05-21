Return-Path: <linux-kselftest+bounces-10479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB078CB1D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DB228390D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692B1B299;
	Tue, 21 May 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I9UaNuw4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q98msB5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F511C2BD;
	Tue, 21 May 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307261; cv=fail; b=TNil7L9/kcTs+a33Pc6otI9fflxVUH0vzzRvbrlLyq6CGhZ18R+hNEXptvgop/JSipjLtLqeROnqtHVS3N/zakQhevVM1LEqi0+vHKnaIOG8tWVzsqX7NNAdbukaNUj4T+C3fEVhJRoO1SOwowvIJAR85sRqryMie0wJGd1KJa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307261; c=relaxed/simple;
	bh=t6rpv2Vi/8JyQhyD270F+ouhKsKuLPLU0FY06aIfRUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n0xCKm0QoeKGaeyIQ6lgicZsp9YdN1KxiJtKaEBmjoOJoioKV12B8jsQK0NMItqelwpuNOtO9Q9T3iDfihBkHlai1pqyHPtmcJbb+iJtCQoHcC5vEu50F//rUtfF0suIEOPGExQsb6BYmGEi7vilO2MJgqcBEViKISJw5rcWCts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I9UaNuw4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q98msB5I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCxoDB031024;
	Tue, 21 May 2024 16:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=REzzY++oygIGIlVs9RSTuwXtCtqlfhEHi3WoTWf0A7k=;
 b=I9UaNuw4ZMXUWCxHU5/M3Rvxzw1mnmjX0LmH31ZCMA2zrTAp9NyqB7JL/584cGyGDoxC
 UFvur1meyzE8s3VCnijVkWrK2F6T2v6R9O8ZC7xfOcvlSjGvtVV3qtvrhFQ87ctMc6aH
 EHj9pYEcxYkJevKtme9kt4u+JdzL1tsJJG4OeyYM1RToy2QfwCTFQE9ic01qXVD5eYzl
 GCudryXjmQ5RhN/8SkD24uvZhTRZKIAOEE5JztrNeat7SLdnqbmxB5Y8yh4bFo9l1Y0W
 /KdEkz5ORIae6OXd1w+rERG9iScGri2QaWsVpnY7zFbO6PM0r+qD+Ho+63tRxWVrfz2b mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv5svn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 16:00:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LFl0YV036050;
	Tue, 21 May 2024 16:00:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7xcf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 16:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6K4T3ChenJje2qnVOAu6M0vWmA1eQNy9TJnPER32eVbNNxOX92QeocAyqQUhp8dfA1Mo7r/OZ4Rkf0UBfObdoHCFk2YFpY7BeZsVe6XRx0fEzKmmqYS2TzSbobBXUrpk9WmF4KeWjWy7WmZETkXd12FVtNSxalksoukqXnO6SYeH3xnlQldpfTk/V2Kyzn4lNHd0Hsjx2Qz2lrAyAV/HL8PkiMLviTbxAoKEV8ueS3eLP4MdOGoWi8EWgPrI4RyzT6jnO834JLoBX0hA/AdkPy4tUsl4VRyOQLgXrgTYixcFmqNYPzyjkIbdv0oZ4NOLf1rnjQ9Sdj2eNM0hne1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REzzY++oygIGIlVs9RSTuwXtCtqlfhEHi3WoTWf0A7k=;
 b=l9UyQ+Dq6CBuseiiShyOZG+ky10egp3SIdEtwCmLB0nmEdwAKcHj70tXXHGxSYrDeiipcQHJZr8vYP+Co7McXlvhtjXKP50cfY3gGW1R1FksvWHBP1gtlcW21yE9tVxkHqImApFKOulpEXpPwQnaBlzytNyjtmn3vfTU/pSTrUcUm6NIx3UraXOxr/Ib1p9xfYaw33EsNAltm8JdhUUrg8UH5Que8da64PMTnQ3rP2V2rXtR4/G0Z7B9jhP4+mJclWdyL2OSq01KOMWaWKxd16/yX7dhW/vbLqAVcXt9uFtNxek5yfDP254ccrUWxwx3K3vC0zmgB661ZNg5CWFDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REzzY++oygIGIlVs9RSTuwXtCtqlfhEHi3WoTWf0A7k=;
 b=q98msB5InKak6uTneLNxNGZaQGWsuuLLuDg8yFUDW/pfEdmU6Gn9cU6KR3wbXJ5L0E6gsRSLzUdwpACbD/rxkJorERqYK3hxOL6GG+Ag+lJWWP7UAGZUKp+MILYemkekptO2Od2UEIcHZJgek//J2zPta9hz+NPqEamIqGiPazU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7363.namprd10.prod.outlook.com (2603:10b6:8:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 16:00:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:00:21 +0000
Date: Tue, 21 May 2024 12:00:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org,
        jannh@google.com, sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        usama.anjum@collabora.com, corbet@lwn.net, surenb@google.com,
        merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <khduyf47rifr5bmswkbju6l5itldhqaksjasvnkfhg4ig3ngdc@a4c2csfsdeqz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	corbet@lwn.net, surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	pedro.falcato@gmail.com, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	deraadt@openbsd.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
 <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com>
 <3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5ntgk5a2rx@jkccjg5mbqqh>
 <CABi2SkVLqE7WD2MTYpksxA3+BfLLzjibHeJy9saYFvM-GRFy-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkVLqE7WD2MTYpksxA3+BfLLzjibHeJy9saYFvM-GRFy-w@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0383.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: ff62126f-b038-4fe5-e858-08dc79af1e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a25FeGJBOWZPQmFlRWEyREJpdjhRbWw2V2IrTkpUSVQwUDFLSWkwZUNMaCtW?=
 =?utf-8?B?anMyRVR6L1VLNWhhejdLdkVZKzRMeEdoK1ptWHRHcS9KZ2xtQjNhQ1JNMGdk?=
 =?utf-8?B?L2dqeWp6OEVsNEFsWlZKUmZ0N2N1ODVVajRlTzBzREVJRHArM3cxOURJcit5?=
 =?utf-8?B?bUMzT2p6NXZPWG9GUFJ0WDNFcXcyYTMvWkRxUHlXMnlxdGRySzlVMXZwQjln?=
 =?utf-8?B?N2dDa2IrUTdodWJVdmJjaGkyZGgvTHZNemN6V2pMZm1ILzBhUnJuMHFFdTF3?=
 =?utf-8?B?VzFMZUUzV1YzMGlpRFhORXdGTUVNQ1ZRSFlveC9zbExuNEZabE1kbzY2UUxj?=
 =?utf-8?B?M1VKTFV3NE5MQWJLaFVZSVhMTEhFRDNsNlJTY1h3VFQ4Nk5MODN6eDNuaVFj?=
 =?utf-8?B?VktsZmNRblhtdExEcHh0d25TNFNhZHBjdTRFemtrUUdMK1FwUDhTNVNrd3ly?=
 =?utf-8?B?MzI3Zmk5ZnQ4bEovTURBc2w1ZXZ4bGJFeTIwNlB4WFl6NFRNMEg4bWtSMWp6?=
 =?utf-8?B?SVBqNmFzL0N3RVpHTDBFMy8wbk9sS3JLQkNrSTh1TDYwQVBHMzk4N2xCQkxu?=
 =?utf-8?B?TjZDclRTaGdCTXdFeTV0SkY1ZUJ5QldJUlUycmlVeGRUSDdxMEZ5VHRpQXVV?=
 =?utf-8?B?SnBRWlYxSThBRkFsa2s2VVlOQ25ZbTY5Y2U2cjRlTUNCT2NINTlUd0hueGpj?=
 =?utf-8?B?dFd3c0Y1RENqMkYxV25MWFNGVDE0VHJEU3JXQjg0VHc3NFNsM3VhYnJCeUc0?=
 =?utf-8?B?WWk1alZ4ZVdtbG8wS3dhc1JSQklEUy9KSUkzMFpweXdQZFBISG5YYmtSa09w?=
 =?utf-8?B?OXZ2Zys3NkhZdUtIUmJpVmtaaGVmQ001WDRpdk11NXB3YWxQVk1LOWxhY0pO?=
 =?utf-8?B?YkRXbkdXelM4UXpEM0pENnRDQjhwVHlod0NkRTgrT3RyU2h2Q2dDMWFWOWg3?=
 =?utf-8?B?U2VWQ0ltOTRTUmQ4K2ZTK281cUZsTlZ6NnN0NEZiV2g3TG5CblR0bGgzSi9s?=
 =?utf-8?B?UzN2Ty9mU1Q2eVJjckxxS0ZpRWo3UDgxYVdBUzE4YkQ4dmdGNThUbUJxOUZs?=
 =?utf-8?B?STBab1hlbFJkTmpTNnJ2TXpCL1ozb3ZNc0s2dWFzMjJoTzRJZGtoeWVITWty?=
 =?utf-8?B?SWg1aVoyc2JIcWRuV09KTXRBK0FMQlExbml4eG9rSTdKZWgwU29CaTFZQ1hF?=
 =?utf-8?B?aWgrMTBZN1VHNlJ3OVpGZ2pDZ3IrTkJ5bnZoQXM1QlN2ajBlSU1JcjIyaGc4?=
 =?utf-8?B?SXFSS3owb3NvYU9YQnc0dld3OEcxOGxVMjBmRUFSTG9xZzNDT2pOaUluam83?=
 =?utf-8?B?QVZVRW5mano3ci9lNjk1V0l2UTliVDYwZG5EY3NNcTEyd1BPTDVORXZoZUk4?=
 =?utf-8?B?WmFNTVV4aTQ4ZWxhT09WU0NpdnFNNXhjelB2YkZVNkgxenc4M21WY09ZOE1a?=
 =?utf-8?B?VlpIK1lLS1RNTXphemQ2Q0YxTmNVNnpPdXdvbTlHd0lOQTJyeldOSkpBZ3Zx?=
 =?utf-8?B?S2p2d2JERklxczF1S0lDWUhBOHRuUlBVaUxmcjBuUE10YXEySmpvWFo0TUJK?=
 =?utf-8?B?VHN1b3AzazVEYWx2VkR5VVdzN3VWMVBZM29ValkrYVVYaXI2cGVKWlhHWmJ6?=
 =?utf-8?B?aXFPdS9ZdWFzUlVORERLcHRodG56bXViL2s2L0JNT3BSQnlOcDcvN08xWHZW?=
 =?utf-8?B?cnlPMGFHY3F4YXpsdGxuQmNLSzJuYytoQVpyTDZaRU1ta2VxSnhieFpBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUxTaEVQMTA0U28wOGI5djE1ejlnK0svUE1wOUJWSVJJU2p1bnN5aEQ1N0Yz?=
 =?utf-8?B?L01TYjhRc0p0dUtMb3NQSkNXOFY1NjRVSVBtVDRaMnh3U2drN2h0ZytIamVE?=
 =?utf-8?B?VENZTUZWN1NTdExnYWFPVks5Y3VQdkJDaUErNkIzSXZmTGx0a2R3NkxBcERa?=
 =?utf-8?B?RWhlZFdSb1pZUGhFYTR3MVU0ZjNBRGZLSGlNdEw1dHNXcmxMZ1dJNVhKZ0Zt?=
 =?utf-8?B?MWtrdUJjN3ZJTElmVytNSEhRR2tXbytHdkdydDFuY2VNUFpKcXcwTDE4d1dP?=
 =?utf-8?B?R2NEd0xVYzRObjA1alRKcXJpS1V0SVRQL1dQejQ3b1RYbkNVOGs5MnNRTXRG?=
 =?utf-8?B?TUFrcTBTcWV2YUJPbDd0d1hyYkY2cllVOG9pbDg0aWlncDJtVjRkTnFxRGNT?=
 =?utf-8?B?SlYyS2hoMlJRUjFpR1VvRnBVaTFDZVJDTnVzRFd1QXdlTHhhK3JGWnhVV1da?=
 =?utf-8?B?a1hBSkxmWDRVSTRRNUVQbkxTOUhocjZLQUpNVmN5VlhJUDd3VkhabG4xRFZn?=
 =?utf-8?B?MUxZTWlJd21rcGgyclFGU1VQZW1nYWU3Yy9FN3N5ODJlYWo5RXNQRUhJTVRR?=
 =?utf-8?B?MFQyTmt1WFdiMllyVXpIYitSaDRKamhFcDBwcWtwc0JERVpwRXV5c083TUJH?=
 =?utf-8?B?SVFRNCs4M1lxSjZvUzFEWjQ4NlBGY1NNUE9HcnY0b0JnaytDVERPZ2c3bXp2?=
 =?utf-8?B?VStjYlJkaDEzZmlvUExxTUhROVFtcjFCV1NTaFF6Vi9hVk5vVVQ0bVNSLytT?=
 =?utf-8?B?WjVSSTJ4UE5BdW1LaDZQaFBOTTd5WStabnBmdWxyMjRPK0gzazZRMVUxRVhG?=
 =?utf-8?B?eGZ5Q3hGbURoaEE4Y3VKNDZPVzdna21jMFVDVmdaTDJ6Y2FXL2cyb1VmVUFC?=
 =?utf-8?B?dkhqM3pnb0tMN0lYOW40Qks2TmszV1pGTzdwSkdzMTA5aEllVGdCUjZUQlVp?=
 =?utf-8?B?RGx3OWNqVzNpQldoOEdCaFBCWkxYSndBWDNmR3N1VlBtMEdteGdJT2lKazY5?=
 =?utf-8?B?M0d0TjJSQWpKNXE2MjlXL25yY1RvOFRGN1ljdDF3V0I1YU5JbHE5NEZ3UjJx?=
 =?utf-8?B?aURzSWZXbXZETWdOMi9VU0RJNVAxZUNEdEEwRjg1bStKQmpvMGp5U1FLWWpw?=
 =?utf-8?B?eE44L0IvVk5FV3lJeDRlemF2SW03WEVnaWtzZkRnMWkzdGVTNXBSeEhaTzJZ?=
 =?utf-8?B?cmVUdm5zQmJpdzQ5Zloyd2dQUVgwVnlnV2NtbGhkdkRUd3JEYXRBN2swZE5P?=
 =?utf-8?B?Q1ZMY2oxdzl4NEZIejhjM0M0ajhSNVZDaFZzajZTTGFpVjR6S0lHazV0aG9k?=
 =?utf-8?B?MS8vdU1RWEdWbDNWaWNla3V1QzhtUE9CSDdDUEdHSWtPa3piNEVZSzhKZWFw?=
 =?utf-8?B?M0hwUVZNdjFXS3pwcmNQWTR1ckN4WCtpeXVsV2VyZ1o0WmdTbGM0MDI2VVlv?=
 =?utf-8?B?SC9jNitZNnEyN2JhT1dmVkJWbzVpZjhLUjZKZWFVY3Y4WmdmNm9lakh0eGcw?=
 =?utf-8?B?WTVEQTZ6d29DcmcyYmZyTlVhT1lTZ0cwWmw0R2VqNkExMndHWVVjN1BmdytL?=
 =?utf-8?B?YkJNdTMzT2VhVU5rR3Qya09uK0gvamZiUGgrTjZhTUZreU4zZGhsaGlhaUZt?=
 =?utf-8?B?TUZyVWhEWXVDN0VpOXYzTTRpb2FYcDVVN0xRYjB3Rmo5ZWRPTEtkb09UTDZE?=
 =?utf-8?B?cmFwL2cvbjVHZG1WZ0RMQ2ZVRHJTOEJkS0t3cDVzeDVUNUdLWGd1a2MrZFVw?=
 =?utf-8?B?eWFGSTRDeWxQZFpVeFN0b0lkaG1CZXVhWHU3M095L3QwbVJPNGJYaXdtZUF4?=
 =?utf-8?B?Q0xKb0c5czVNeTVLdmFtZHBYRU1pTEpCNSsyNCs3amV5N1I1L1AvL2dScmRn?=
 =?utf-8?B?a0tWWElSZUttS2M0T2R3R29DRFpOcnFoUVNCVWZ4aUdVU0Z5ZDErbUljb2lK?=
 =?utf-8?B?dHN4YnpzOUFSSFZ3OE10VzExMGNBUmdTcUN2Zi9MQU9HQ2JaQjEvcmpaRjk4?=
 =?utf-8?B?cklQTXhqYjNLZ1RQbE52dys5cFdHeEtVZ1BYRktiTjBaUERxLzZHaDh2eVBC?=
 =?utf-8?B?dGR5RnM3ek1uRk9aMFpVcllCMENWaXVkWDgxVUdxdUZwaGJaVEhPRUZZWHdl?=
 =?utf-8?Q?g4Qg+hZ5qQuLGZt2sBQN0uOQ5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZftWA/wSpn/JVVAIYK5IstEW4uPgM/B2Ym2gAiEjmItcs0LkXVmTp1S4zCK6KD6z8wbGBKetS2Ze3s2yxAcMPz8wjhLBR9axeXnJ38HlCLuyTLjC4ifn+vRMp10ZZXWGUvdExpi45cfYr8SIWSQj7LASx9443/hJO7J91Nv5RC40bgIxZDoVR/0V7c7AR8/laPnTiPNrlteC7jwUq9vpCo5DJbsvGuftPVZaqbQD+exYPeXFl6nANLNuB2KEdSvrcBe3qp3WYFfbfz8/QET75d9JlS9W41HuQ+KTHRV7Y7wZKESNmnoJfCIFiCt77I3AxWcKKMiVwHUoXBOW6tcbjkBQzomdt3mYGCEiDDpKp7bCgBOYVmAsBj4PLsK3TRKXs3vcv5O8R43vUJsCfAsaEDTUiUrj11uGY3G+lZ2gfmCX8S7BOYi5PuajD8nDiDheQVrEqOyq1oARiryFupoiCf+/HsPXBDcROyN3xhA3AR8Cym/kXmY7VeUlzb3HNwYPDgNdm58NPEz11PymreRYvrXXYE+0FyVGK15s1+9cOmS/xc/Gh89Seh0aw2n35xzEyMyuxqnFrOE7XknH64roikPF3Y685KhKxk/sXGiiOfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff62126f-b038-4fe5-e858-08dc79af1e40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:00:21.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXKE4ziVyJ5TfuHsGtlEX8Nu5LDjFhnE94we0opjUkUhWOfevcUnNAXF9ObHFYahHcDMbOoLGvgF7ANwTfOfcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210121
X-Proofpoint-GUID: bkRj6WecD12vOjUjwczaa_NPwtUcjomX
X-Proofpoint-ORIG-GUID: bkRj6WecD12vOjUjwczaa_NPwtUcjomX


TL;DR for Andrew (and to save his page down key):

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


* Jeff Xu <jeffxu@chromium.org> [240515 20:59]:
> On Wed, May 15, 2024 at 3:19=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Jeff Xu <jeffxu@chromium.org> [240515 13:18]:
> > ...
> >
> > > The current mseal patch does up-front checking in two different situa=
tions:
> > > 1 when applying mseal()
> > >    Checking for unallocated memory in the given memory range.
> > >
> > > 2 When checking mseal flag during mprotect/unmap/remap/mmap
> > >   Checking mseal flag is placed ahead of the main business logic, and
> > > treated the same as input arguments check.
> > >
> > > > Either we are planning to clean this up and do what we can up-front=
, or
> > > > just move the mseal check with the rest.  Otherwise we are making a
> > > > larger mess with more technical dept for a single user, and I think=
 this
> > > > is not an acceptable trade-off.
> > > >
> > > The sealing use case  is different  from regular mm API and this
> > > didn't create additional technical debt.  Please allow me to explain
> > > those separately.
> > >
> > > The main use case and threat model is that an attacker exploits a
> > > vulnerability and has arbitrary write access to the process, and can
> > > manipulate some arguments to syscalls from some threads. Placing the
> > > checking of mseal flag ahead of mprotect main business logic is
> > > stricter compared with doing it in-place. It is meant to be harder fo=
r
> > > the attacker, e.g. blocking the  opportunistically attempt of munmap
> > > by modifying the size argument.
> >
> > If you can manipulate some arguments to syscalls, couldn't it avoid
> > having the VMA mseal'ed?
> >
> The mm sealing can be applied in advance. This type of approach is
> common in sandboxer, e.g. setup restrictive environments in advance.

Thanks, this detail slipped my mind.

>=20
> > Again I don't care where the check goes - but having it happen alone is
> > pointless.
> >
> > >
> > > The legit app code won't call mprotect/munmap on sealed memory.  It i=
s
> > > irrelevant for both precheck and in-place check approaches, from a
> > > legit app code point of view.
> >
> > So let's do them together.
> >
> For the user case I describe in the threat-model, precheck is a better
> approach. Legit code doesn't care.

This is the case for other checks as well, but they're all done
together.

>=20
> > ...
> >
> > > About tech debt, code-wise , placing pre-check ahead of the main
> > > business logic of mprotect/munmap APIs, reduces the size of code
> > > change, and is easy to carry from release to release, or backporting.
> >
> > It sounds like the other changes to the looping code in recent kernels
> > is going to mess up the backporting if we do this with the rest of the
> > checks.
> >
> What other changes do you refer to ?
>=20
> I backported V9 to 5.10 when I ran the performance test on your
> request, and the backporting to 5.10 is relatively straight forward,
> the mseal flag check is placed after input arguments check and before
> the main business logic.
>=20

The changes to the later looping code would complicate your backport.
94d7d9233951 ("mm: abstract the vma_merge()/split_vma() pattern for
mprotect() et al."), for example.

> > >
> > > But let's compare  the alternatives - doing it in-place without prech=
eck.
> > > - munmap
> > > munmap calls arch_unmap(mm, start, end) ahead of main business logic,
> > > the checking of sealing flags would need to be architect specific. In
> > > addition, if arch_unmap return fails due to sealing, the code should
> > > still proceed, till the main business logic fails again.
> >
> > You are going to mseal the vdso?
> >
> How is that relevant ?

This is generally what arch_unmap() is checking, that's why I was
wondering if it would be affected.

> To answer your question: I don't know at this moment.
> The initial scope of libc change is sealing the RO/RX part during elf
> loading.e.g. .text and .RELO

Right, this is for chrome in your usecase.

>=20
> > >
> > > - mremap/mmap
> > > The check of sealing would be scattered, e.g. checking the src addres=
s
> > > range in-place, dest arrange in-place, unmap in-place, etc. The code
> > > is complex and prone to error.
> > >
> > > -mprotect/madvice
> > > Easy to change to in-place.
> > >
> > > - mseal
> > > mseal() check unallocated memory in the given memory range in the
> > > pre-check. Easy to change to in-place (same as mprotect)
> > >
> > > The situation in munmap and mremap/mmap make in-place checks less des=
irable imo.
> > >
> > > > Considering the benchmarks that were provided, performance argument=
s
> > > > seem like they are not a concern.
> > > >
> > > Yes. Performance is not a factor in making a design choice on this.
> > >
> > > > I want to know if we are planning to sort and move existing checks =
if we
> > > > proceed with this change?
> > > >
> > > I would argue that we should not change the existing mm code. mseal i=
s
> > > new and no backward compatible problem. That is not the case for
> > > mprotect and other mm api. E.g. if we were to change mprotect to add =
a
> > > precheck for memory gap, some badly written application might break.
> >
> > This is a weak argument. Your new function may break these badly writte=
n
> > applications *if* gcc adds support.  If you're not checking the return
> > type then it doesn't really matter - the application will run into
> > issues rather quickly anyways.  The only thing that you could argue is
> > the speed - but you've proven that false.
> >
> The point I raised here is that there is a risk to modify  mm API's
> established behavior. Kernel doesn't usually make this kind of
> behavior change.

Sure, but we have security checks happening later and they can fail 1/2
way through.  Although, depending on the 1/2 success is an application
bug and means the application is not portable.  This was my main reason
for requesting this check be placed with the rest, as we are now
treating mseal() as a special case among even security features.

Some of the existing checks add unnecessary complications to keep them
together, unfortunately.  Your addition of a loop prior to making the
changes means we can probably simplify some of these checks by
generalizing the loop in future patches.

>=20
> mm sealing is a new functionality, I think applications will need to
> opt in , e.g. allow dynamic linker to seal .text.
>=20
> > >
> > > The 'atomic' approach is also really difficult to enforce to the whol=
e
> > > MM area, mseal() doesn't claim it is atomic. Most regular mm API migh=
t
> > > go deeper in mm data structure to update page tables and HW, etc. The
> > > rollback in handling those error cases, and performance cost. I'm not
> > > sure if the benefit is worth the cost. However, atomicity is another
> > > topic to discuss unrelated to mm sealing.  The current design of mm
> > > sealing is due to its use case and practical coding reason.
> >
> > "best effort" is what I'm saying.  It's actually not really difficult t=
o
> > do atomic, but no one cares besides Theo.
> >
> OK, if you strongly believe in 'atomic' or 'best effort atomic',
> whatever it is, consider sending a patch and getting feedback from the
> community ?

Sounds good.  This will probably happen over time.

>=20
> > How hard is it to put userfaultfd into your loop and avoid having that
> > horrible userfaulfd in munmap?  For years people see horrible failure
> > paths and just dump in a huge comment saying "but it's okay because it'=
s
> > probably not going to happen".  But now we're putting this test up
> > front, and doing it alone - Why?
> >
> As a summary of why:
> - The use case: it makes it harder for attackers to modify memory
> opportunistically.
> - Code: Less and simpler code change.

Fair enough.  Thank you for providing the arguments for each up-front
check vs embedding them. I didn't want to hold up your feature for so
long and I appreciate you taking the time to respond to my questions on
your decisions.  Apologies for kicking the hornets nest on this one.

I think, in the future, we can use your forward loop to clean up some of
the design decisions of the past - ideally by choice and not by CVE
forced changes.  Hopefully having both pre and inter-loop checks won't
mean one will be missed when altering these code paths.

Thanks,
Liam

