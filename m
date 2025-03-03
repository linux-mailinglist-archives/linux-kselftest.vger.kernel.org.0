Return-Path: <linux-kselftest+bounces-28226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D95A4E9EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C383B9603
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5429AB13;
	Tue,  4 Mar 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCTL39t/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oE0+4prH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48824C089
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108479; cv=fail; b=lZJRSE9uqWPMVQtrAB6aX2YlNJFQQ1T6bGK1YrSAyfe3L5mBeZJITD1zoO91eAdWQP7bZjVLZp/qjJiORDmWROZ/HkIAll4SvXtqZZzjf25V1iysfKdIQRzat8fqz9AzwuvET0Dmv8657zmSdNOK3ZYu1FxnC7NRepvD9PticVc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108479; c=relaxed/simple;
	bh=61wGiUlvrrWOP2yYgWQY1WMwNypETt1l66Hv4Rsnkvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NC4PAO4m5hmaeHapVssfnwcliyhmhVWCllk7104yvTPbgZRJLJGn/e9EZFOkbnQkUXThsaU9d8wKO/SAo4eUm3Ve3S/csecAny39Gky38pxbmFwroE+go8Exuzg1iInCmO30CQZE+DEHJLRfFSvEEbM/u25HDP0MSzBvE7oMLag=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCTL39t/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oE0+4prH; arc=fail smtp.client-ip=205.220.177.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9CDBF40D1F47
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 20:14:35 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=NCTL39t/;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oE0+4prH
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fSp5Lx9zG04h
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:18:02 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C063A4272F; Tue,  4 Mar 2025 18:17:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCTL39t/;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oE0+4prH
X-Envelope-From: <linux-kernel+bounces-541636-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCTL39t/;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oE0+4prH
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 63E0941BC0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:53:17 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2EDE02DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:53:17 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9242E188C44E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121B20C00C;
	Mon,  3 Mar 2025 11:51:45 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BD1F09B2;
	Mon,  3 Mar 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002699; cv=fail; b=r/pV1xwjpRp/026uyoKtomQMSPzUgpiaT/TZXPiZ3kFJWqE6OYgYoQkzcooywK61HYAiSpem+B9My+xRk5hi/xaz4CNNQ42w/pcCnwqrDbXQVTJoo1+aj0S84X+aYNSgL5gL8RutnRuXMf7V+pnHvKVJV+aE2DUgguR9j+xB5U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002699; c=relaxed/simple;
	bh=61wGiUlvrrWOP2yYgWQY1WMwNypETt1l66Hv4Rsnkvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyM6wDIiik8P7EdZl7YxKJb68vuNozc5yTVn2HJk2TOYb+m4Aq4PWTiO7ttlMJ84SWEO2KgY3552xNNdfUKresMfsRSFJY+Jsi25ECGNQfYn6mZlHfsapoQuqCdGd4GIAxU4qqCz96qLCgiKNn2X2BJeNrkjU2lYf9ztBQIZnqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCTL39t/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oE0+4prH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tfou030074;
	Mon, 3 Mar 2025 11:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=b5arRDOttCje0bFLJo
	vHp/feHPm5ggHhAYeW7QEi+gY=; b=NCTL39t/+HlwS89Y+0evr4BHA1R32LsnSs
	oO76E3MzYlKr7HALMmXpM9SiyVNMWMKmOqUD3nRC/CMgbK5ZCB42x6jOKVmNcK+V
	1FjPtWXJggE1/bOyxm+kz94R+9aX2IJ4RK2zAVTktO4mLboElR4Lt8/FQzpNgwFd
	9gU8uK4z106MDHSMwnNh3sT3xjDLZMoc278b5HrBB+Vt/1ipS3BDRf1BrQt7BE5k
	smEiyvyTgxB3aFdfm/3J7O+yMU8gN87JT7asswda+EE5jx0RsACMK/gaFFiUHnJo
	pleMbmDUVt/AGkQfmrs+nRZzk71RUwmGEOzjRQJbLFWBXYGLa32A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86jfnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:50:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523B0xi4015767;
	Mon, 3 Mar 2025 11:50:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8m7yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCTxGynQWiWNEJB41ZYGsNAvwHCwWk8CWbZBljQ6V3O3Vku2b02c+RVjshfHAeqBGcPsuHC3KaMQcX8Elq/p+In1YZvJewCU2hkmSn1q5oM8Cd43nRiop8Y9b2XASJCMY5wuzvc4Ml2SXJ2W1tVSm75OWoUOxvrzT2LEXZeHXk63ia9iajXmfTBlkQpbpHG7K2Ee1TCUCAtw8qDJBZeLX6SlqQd7LOPgwl7rmZ0hkpvBC770ZgkcI11GKkM5UisUF0Izc5MqjIlD2pRTY0NBU12UheHUMjb5NTLbvY8WSOGkTPzVIJwAP2ug6uHlGE+g9YPojfJEOp8tEKRp2zol7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5arRDOttCje0bFLJovHp/feHPm5ggHhAYeW7QEi+gY=;
 b=MMX9CzB6jbbJYHWKE6YUV1vtGSXHwaVVF5uyasMV56b5ke2e1yct0Le45ytWKmPWUCzr2BdmKnIWKJjPqQGqVSOIiaWRIE1872M/1+QAhGpMSxYEDq9mfqNjT5P4wONCeVM2NXFHCO4ZISpVv0eH9WGd7feIPD5g+/lTvYcQy7TY0ow/IfyiMyt0lU4gQa0fPRhShAXN3jUfVaz0UV2CIJmpQ8ET/cBHnteOstd7yKmlMLU+iQ7B2aLCUAdrQBUwc+Th+0CTLIwT1VVwWq8y72OFDDATja3RCfpENBCaH0N6RGncJqt3JNSam4KsNBW+gaB/B6HV/U7pe3FRZ31B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5arRDOttCje0bFLJovHp/feHPm5ggHhAYeW7QEi+gY=;
 b=oE0+4prHiV1CZ9TGofHJCuwC5a+pUn3C2JZl9XVQSWxHzyyR9ybRkitxMiSgw+rhfBtbHsKlJP8OfsrzyxU38OxpniRGv9zu0NB0eHaFOM05SbVliDtrWoed7Km4KIpYGaXlqfrOEcuK+zx70vzGwP6XeBDbbNSGbxIDC6RmISg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 11:50:30 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:50:30 +0000
Date: Mon, 3 Mar 2025 11:50:28 +0000
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
        mike.rapoport@gmail.com, Jeff Xu <jeffxu@google.com>
Subject: Re: [PATCH v8 0/7] mseal system mappings
Message-ID: <1e84edef-03c4-4544-81c1-1006bc9beee0@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
X-ClientProxiedBy: LNXP265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: c100fd93-321c-49e2-6fcf-08dd5a4998a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QADLHrohZ0omegx0mqnlBxf7Y7QNBnaP7NxgjV7rRwwYZq3MJUhLrBw7NECM?=
 =?us-ascii?Q?7tclvKNcEnj7idsD7/Eg5PW3RrGKsicm7e1k03N0leGZz99yRP8bxAaly4WD?=
 =?us-ascii?Q?PalzpTwaMRlxXK4OGX1aSkHZXsJ9zA7AWiJ8Z6n4GI1ew4eD09L/3sb3xhKa?=
 =?us-ascii?Q?MM2YRuKglhst4BDegxYdORUkvtR+QfzhGCvgX211Q9x/ZpDUQuBIE5jHq7T7?=
 =?us-ascii?Q?raj6c9VfBN51QQSeJgeD2lvx5mAoHmcfQzvYw9KB38dSG2u6FF2njR/g87t7?=
 =?us-ascii?Q?KOCcndaYL1fL0ya8CJPfOpG7+LsjH+4ZWHc4SYyqZhXpsU+SrL+5faURlcB6?=
 =?us-ascii?Q?Eu3os+iuXWrBomScHustCLsGZcXQQqKXjsKZ7/2ph9cYzm66noD/ryrKtMWR?=
 =?us-ascii?Q?LjlRieIutrX77R5kqlYLfCacgu2Vjcc8EBVsNZz5o3tWG0gbDp684u1PFQvx?=
 =?us-ascii?Q?yG1Rb+NNZG6UrFel8pboDqGeIYtuoZN1lQdLsGrMNlM9yxoA7uvTi3sa9M/X?=
 =?us-ascii?Q?hcllt2U3SZLrhnyj6tyL29wAisOHZuyjwfj67DyIoyKdQHe7eS5k4TiE3+Hl?=
 =?us-ascii?Q?o/9x1jp/t8Xwi3QuyAMaVEdJGu61/miG9yC8qzh1ba8VSJkPVc3LhSo0wgSm?=
 =?us-ascii?Q?mxVrHrN6qFSJEkYWFfoowFs45GTn0DIDg2ouxtbWdOpE2afIJPm7N3GnyXB4?=
 =?us-ascii?Q?AWTXhdo4SfbQ6KdRVEbdZxDDycQQzfo4tnmmsf8DpE3VZf2lbcolA/DrqTl4?=
 =?us-ascii?Q?JF9OsBJVHY2xHTYEo+WP5bLBKgendWSj2yomSZ0YScIA4DN8Ip9MpOOL5izN?=
 =?us-ascii?Q?bZcJQRW3Awk2Hs7Xf9Wv5OoGbHK3lUIDzj15+9CxCclEvLkJRMbKjOip8WVS?=
 =?us-ascii?Q?+0dQ+IM1SLzZyHfaEUICzF8R32M41DkIGXA70xy1HaiXh1lj71qofYdCVlI1?=
 =?us-ascii?Q?XzGt08ezjhHR0crHh3AvE4J1DZaU/47pSiISgvov6OLICBFua4arXXsgXGn4?=
 =?us-ascii?Q?wfRPKsCiAP4kwRgDxtcfE1xDXF8NFI/qzdYocL7ECl36udADFHi1IHdlcrZB?=
 =?us-ascii?Q?hrVjXeAq2vTFo8MGl8iun2J8SG8O/TcH7PUoOgqE1ETK4aVnrHdJiRb3TEQu?=
 =?us-ascii?Q?TE1fQxz7E19r0jiq6gEUeT3m/HleeOOHjKkB793aMVlIyJdcBTBmva8AcQHR?=
 =?us-ascii?Q?iNYYLkXvWTdizp/yK84LKLYKbHA4mWtUqahv5ZryRoVAETbjRoQj9iK0F0Su?=
 =?us-ascii?Q?TVe3yNwEYj6z9LizPdhf8Uu3aV+4V+EGOTprT5flQwMb9emQZwMG5wmw73bo?=
 =?us-ascii?Q?c/bWA+RlKSvGfSA8IdhHkFYa/k5S5PYuCB8wfe5sv0wuAFTGKAU+S7Hx4yrA?=
 =?us-ascii?Q?3pHdigB6Uby0/CJhyAH1sqrQR0UM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4NQWs7Ra3jjrYD2/SJVKvupTkyzWuwUuo3L66chsok8DcWHcr7iv3FB0uFV?=
 =?us-ascii?Q?PTiVEB7aPcSJWatz4s403kh/pElDwH+JJzeZ82CnjsBVUWwO95LRafD4s385?=
 =?us-ascii?Q?TFlt1bHwaAbwArP8zugWmChVPE5WF6fyFIGPExTEMHpssPgWjR5yRKelr6KO?=
 =?us-ascii?Q?BJzFzyZJ2VQ3T/3fG4ArMTbWnfR8TltemV9YNoWgQWtizy8bNqQ7WjdWEdjk?=
 =?us-ascii?Q?3+36jMx+ZxztWtQHlrCbPCbcoI6pdP3xBQUe0RRGySeT/XALr/sQl2ydMpGB?=
 =?us-ascii?Q?pZwa2hZ2buKjaSxQwdcC0F89qQZuvVsM51T0zXcUsWflt6Iq1c76k36UDB14?=
 =?us-ascii?Q?TECC1ZO3JRstssCAShIQkYXXmrNn44h9+P0Irsq7i4gsHo8S39iIUALg5FNg?=
 =?us-ascii?Q?z3KOyDmFopdHQXBFkY/0B1Z1Z4hmCNgwhOjptY7CdYiJQPoyPxpqI61hR8CG?=
 =?us-ascii?Q?dWR5cB9n0jhiZVmm9wMq7G91+nFSr2MB/FB+hNQzXDheOOki6s+DPZS5OxB2?=
 =?us-ascii?Q?L/9cUheA63qcqh+mKrZZPrrWxyEOy8jUx2TZP8o0T0xTxCfIrZViwDqt3wSn?=
 =?us-ascii?Q?nsgQgDC1We8fhbejJlDT+KrOpGl8doKr5rv6k/WvnYlnpSz7Bgnm/ucXDzap?=
 =?us-ascii?Q?U7tfsphkesc1alQnmgzs13HWutU10J6Jx3VQDVZZxj6KDnVY/v7vgt79V2fo?=
 =?us-ascii?Q?gBuH2N7diLwd/zAFJSTDUub87RuZpAG96dZjMF7gxCPneGxi0dftvK0GqqW5?=
 =?us-ascii?Q?Acw6DZ5xxRlFHlFqoZ3ixRAhbYTIn9c9pSmHTe6zbnkpkTUdPPIDTxv6wnQA?=
 =?us-ascii?Q?A75g/h+xF0vAJrBnqO+Jrnl3W5RS8DXySd/UHjKXEZHyxiDq94V7cHDh9Xno?=
 =?us-ascii?Q?1PkshgpNe90vanlvHKEhsO+Em20buWkiok8oFUYQTQlAjcAf7FBHX+0rD08v?=
 =?us-ascii?Q?6WJYGN2QjepIpHJdMkTL86HPl3Yv0xV4LM4JyhTfrtLo+tHTvptR13S7TMGc?=
 =?us-ascii?Q?Xdp0yjJGk2LAIGfesZxMPUopOG5Hp5V62keL0wPABpOhCZcTU85ez0k60d4U?=
 =?us-ascii?Q?PA5fQfHltj6cD/K1qY6JWJzpwiYQAEXk+Zr/ho8Yjgj95Ad82J9zoVxwm2nt?=
 =?us-ascii?Q?wZYuARkAIx5hsm+EPpuhHPQXfx+ji4/p4oCrxJSQiLmPT2zt0/VpOJipXouT?=
 =?us-ascii?Q?yYjo1/MLul16Bvh7EnkYtiZ2a/j8TKUnTjOUCQq6LMOkrLS+JM3aksGJ1uwQ?=
 =?us-ascii?Q?trjq0HrCerfX1AwQUGhiodCBsiT7Pk63ZeV6VmidFQtBu77dfo+fAbm7proa?=
 =?us-ascii?Q?Q0l8AuV6RvcRh+/vpkdj/yiEbs0BAf/9OZgd84y3NziOwQW1v3fjmIiujR25?=
 =?us-ascii?Q?EnISbkCacjDsDreSxHiHICPkGCvkeYBb0+iCRwTWmWjZkTS5rpKgcMr2ApOm?=
 =?us-ascii?Q?osVkxQUFPxe3Fyz/0OTQ1PG+1dIWKT8/d7dIP6kB7cPRTld6lngWKnIuoSDq?=
 =?us-ascii?Q?BMAWWZvFryPj114W1Bde1C+COHOTOIftiz0s3w4DFUFwzHoecsfOmNbIT/Oe?=
 =?us-ascii?Q?Uq5AS5zzuC8xJe3oj6vPKhOpoU3t7u7XtrZj5WKzW+mxeoQ6ibiZQKOVBDRC?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IwfRUyuscAAuQvXGIwLLCqEAnU+2tGMGO0AiAiXlMweBqrHy2zF2/Xk4xsHswEwdTDp9FMyKrU+UaMnt2oiET0zwIUZuTDYtwdQE4to9Reuc+WhXxnUhaINGRC5UYAdiDTUVfUZGC3jhwkzyPGq/ga3qVB3qfOppoEg8fIi18vPPZNOrkyXRu8pTtr8slIMejIpVw6DE/BrBzuHu3fmVyyerVzhuTtxpqMJSASSRYlX5uvb3XZycmpf16LZZBv+79d8N+9dRtxk/BZSZJ6dnpazrNFc7wQs+tKzoye66XpBBnZ30G2pzHpHv0evr0AP0Wd17jUEkWN3oxVHXCH/kTP2ABekQxkgEhgo39ITdIhcPR0PbiktnD4VUxd+Dpe5zaCxPq887vpAg4EokqOuANwASRwZVQRnjSXI0nJcXBN7qHGcCQQAALpYcoXtM9BY1troUM3Wn57VIP0Nrjo3njTtx+rIdeg2FOIMgwcf0Hz5xP+FHPf7RgHozyJsuFCqN9wBK4AfCvXITRjR+4bMtcmFRCGPfReB+C1rcGvu4ECYZCuV+pUxdYHuMi/a+JhCfJpVOGrScsS2ocsn61B4lmw7xBwnV+fk23PMMuVnb+qc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c100fd93-321c-49e2-6fcf-08dd5a4998a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:50:29.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIqWX3B5TyqdlUsX7CMPrDs5tpHy0jLZYuL3KCb6hjKhjjfOkuJk9o0DZ2Y2YikFAVm61D/bepugeT4S/LvK1DLl1gR29dcHKVBUJQ7Cq+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030091
X-Proofpoint-ORIG-GUID: vZzt4krU8EkhoRyYmuHOKC6OeS0EKLS2
X-Proofpoint-GUID: vZzt4krU8EkhoRyYmuHOKC6OeS0EKLS2
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fSp5Lx9zG04h
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713176.0063@p0yE8Ai13rHThEq5gK4iEQ
X-ITU-MailScanner-SpamCheck: not spam

Great nice descriptions thanks!

On Mon, Mar 03, 2025 at 05:09:14AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> This is V8 version, addressing comments from V7, without code logic
> change.
>
> -------------------------------------------------------------------
> As discussed during mseal() upstream process [1], mseal() protects
> the VMAs of a given virtual memory range against modifications, such
> as the read/write (RW) and no-execute (NX) bits. For complete
> descriptions of memory sealing, please see mseal.rst [2].
>
> The mseal() is useful to mitigate memory corruption issues where a
> corrupted pointer is passed to a memory management system. For
> example, such an attacker primitive can break control-flow integrity
> guarantees since read-only memory that is supposed to be trusted can
> become writable or .text pages can get remapped.
>
> The system mappings are readonly only, memory sealing can protect
> them from ever changing to writable or unmmap/remapped as different
> attributes.
>
> System mappings such as vdso, vvar, vvar_vclock,
> vectors (arm compact-mode), sigpage (arm compact-mode),
> are created by the kernel during program initialization, and could
> be sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [3]. It could be sealed from creation.
>
> The vsyscall on x86-64 uses a special address (0xffffffffff600000),
> which is outside the mm managed range. This means mprotect, munmap, and
> mremap won't work on the vsyscall. Since sealing doesn't enhance
> the vsyscall's security, it is skipped in this patch. If we ever seal
> the vsyscall, it is probably only for decorative purpose, i.e. showing
> the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the system mappings during restore operations. UML(User Mode Linux)
> and gVisor, rr are also known to change the vdso/vvar mappings.
> Consequently, this feature cannot be universally enabled across all
> systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.
>
> To support mseal of system mappings, architectures must define
> CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS and update their special
> mappings calls to pass mseal flag. Additionally, architectures must
> confirm they do not unmap/remap system mappings during the process
> lifetime. The existence of this flag for an architecture implies that
> it does not require the remapping of thest system mappings during
> process lifetime, so sealing these mappings is safe from a kernel
> perspective.
>
> This version covers x86-64 and arm64 archiecture as minimum viable feature.
>
> While no specific CPU hardware features are required for enable this
> feature on an archiecture, memory sealing requires a 64-bit kernel. Other
> architectures can choose whether or not to adopt this feature. Currently,
> I'm not aware of any instances in the kernel code that actively
> munmap/mremap a system mapping without a request from userspace. The PPC
> does call munmap when _install_special_mapping fails for vdso; however,
> it's uncertain if this will ever fail for PPC - this needs to be
> investigated by PPC in the future [4]. The UML kernel can add this support
> when KUnit tests require it [5].
>
> In this version, we've improved the handling of system mapping sealing from
> previous versions, instead of modifying the _install_special_mapping
> function itself, which would affect all architectures, we now call
> _install_special_mapping with a sealing flag only within the specific
> architecture that requires it. This targeted approach offers two key
> advantages: 1) It limits the code change's impact to the necessary
> architectures, and 2) It aligns with the software architecture by keeping
> the core memory management within the mm layer, while delegating the
> decision of sealing system mappings to the individual architecture, which
> is particularly relevant since 32-bit architectures never require sealing.
>
> Prior to this patch series, we explored sealing special mappings from
> userspace using glibc's dynamic linker. This approach revealed several
> issues:
> - The PT_LOAD header may report an incorrect length for vdso, (smaller
>   than its actual size). The dynamic linker, which relies on PT_LOAD
>   information to determine mapping size, would then split and partially
>   seal the vdso mapping. Since each architecture has its own vdso/vvar
>   code, fixing this in the kernel would require going through each
>   archiecture. Our initial goal was to enable sealing readonly mappings,
>   e.g. .text, across all architectures, sealing vdso from kernel since
>   creation appears to be simpler than sealing vdso at glibc.
> - The [vvar] mapping header only contains address information, not length
>   information. Similar issues might exist for other special mappings.
> - Mappings like uprobe are not covered by the dynamic linker,
>   and there is no effective solution for them.
>
> This feature's security enhancements will benefit ChromeOS, Android,
> and other high security systems.
>
> Testing:
> This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
> - Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
>   i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
> - Passing various automation tests (e.g. pre-checkin) on ChromeOS and
>   Android to ensure the sealing doesn't affect the functionality of
>   Chromebook and Android phone.
>
> I also tested the feature on Ubuntu on x86-64:
> - With config disabled, vdso/vvar is not sealed,
> - with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
>   normal operations such as browsing the web, open/edit doc are OK.
>
> Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
> Link: Documentation/userspace-api/mseal.rst [2]
> Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]
> Link: https://lore.kernel.org/all/CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com/ [4]
> Link: https://lore.kernel.org/all/202502251035.239B85A93@keescook/ [5]
>
> -------------------------------------------
> History:
>
> V8:
>   - Change ARCH_SUPPORTS_MSEAL_X to ARCH_SUPPORTS_MSEAL_X (Liam R. Howlett)
>   - Update comments in Kconfig and mseal.rst (Lorenzo Stoakes, Liam R. Howlett)
>   - Change patch header perfix to "mseal sysmap" (Lorenzo Stoakes)
>   - Remove "vm_flags =" (Kees Cook, Liam R. Howlett,  Oleg Nesterov)
>   - Drop uml architecture (Lorenzo Stoakes, Kees Cook)
>   - Add a selftest to verify system mappings are sealed (Lorenzo Stoakes)
>
> V7:
>   https://lore.kernel.org/all/20250224225246.3712295-1-jeffxu@google.com/
>   - Remove cover letter from the first patch (Liam R. Howlett)
>   - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
>   - logging and fclose() in selftest (Liam R. Howlett)
>
> V6:
>   https://lore.kernel.org/all/20250224174513.3600914-1-jeffxu@google.com/
>   - mseal.rst: fix a typo (Randy Dunlap)
>   - security/Kconfig: add rr into note (Liam R. Howlett)
>   - remove mseal_system_mappings() and use macro instead (Liam R. Howlett)
>   - mseal.rst: add incompatible userland software (Lorenzo Stoakes)
>   - remove RFC from title (Kees Cook)
>
> V5
>   https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.com/
>   - Remove kernel cmd line (Lorenzo Stoakes)
>   - Add test info (Lorenzo Stoakes)
>   - Add threat model info (Lorenzo Stoakes)
>   - Fix x86 selftest: test_mremap_vdso
>   - Restrict code change to ARM64/x86-64/UM arch only.
>   - Add userprocess.h to include seal_system_mapping().
>   - Remove sealing vsyscall.
>   - Split the patch.
>
> V4:
>   https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/
>   - ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
>   - test info (Lorenzo Stoakes)
>   - Update  mseal.rst (Liam R. Howlett)
>   - Update test_mremap_vdso.c (Liam R. Howlett)
>   - Misc. style, comments, doc update (Liam R. Howlett)
>
> V3:
>   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
>   - Revert uprobe to v1 logic (Oleg Nesterov)
>   - use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
>   - Move kernel cmd line from fs/exec.c to mm/mseal.c and
>     misc. (Liam R. Howlett)
>
> V2:
>   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
>   - Seal uprobe always (Oleg Nesterov)
>   - Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
>   - Rebase to linux_main
>
> V1:
>  - https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
>
> --------------------------------------------------
>
>
> Jeff Xu (7):
>   mseal sysmap: kernel config and header change
>   selftests: x86: test_mremap_vdso: skip if vdso is msealed
>   mseal sysmap: enable x86-64
>   mseal sysmap: enable arm64
>   mseal sysmap: uprobe mapping
>   mseal sysmap: update mseal.rst
>   selftest: test system mappings are sealed.
>
>  Documentation/userspace-api/mseal.rst         |  20 ++++
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/kernel/vdso.c                      |  12 +-
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/entry/vdso/vma.c                     |   7 +-
>  include/linux/mm.h                            |  10 ++
>  init/Kconfig                                  |  22 ++++
>  kernel/events/uprobes.c                       |   3 +-
>  security/Kconfig                              |  21 ++++
>  .../mseal_system_mappings/.gitignore          |   2 +
>  .../selftests/mseal_system_mappings/Makefile  |   6 +
>  .../selftests/mseal_system_mappings/config    |   1 +
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
>  .../testing/selftests/x86/test_mremap_vdso.c  |  43 +++++++
>  14 files changed, 254 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/config
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>
> --
> 2.48.1.711.g2feabab25a-goog
>


