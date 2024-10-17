Return-Path: <linux-kselftest+bounces-19948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0139A1EF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D681C208D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEE21DA10B;
	Thu, 17 Oct 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5bD5r9Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jWpJj2iU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24E1DA0E3;
	Thu, 17 Oct 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158577; cv=fail; b=uMtVwTWZcgdhk+Orb/tCZi2mhRTMuGaMgdPHzlORKhXPAe4xLVxcka1M/3IP9j8RMKSe+Zj+DMZk/psN07BvZCARJdD4abuhsarEw5lx2oEBdjHPqqdKeRyCI2qTxACDcb0gLSAvtcBs4p+srBV9yATZArgFAQMBEdd6GhB0hls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158577; c=relaxed/simple;
	bh=TR7oaHddaM4hR+A6EhaXJl8dpEkqp+w+E8cqcoUSY3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QIg4xjyhIHcPufEd+dvSboIBVFIwTsu5HSpV84tWlwj2CzzFXH1fJX1eybyoPHotV3MLksa1I/ZhjzNm+Sn7aGASUxQ8A/QTr25jU5OHbl7wQAtaUru/AiEAZyaWcj0eb2PitI8pB1IbXZoCFyGkMehyH3rA6qcjzj4VhamI2ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c5bD5r9Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jWpJj2iU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9MdGs032077;
	Thu, 17 Oct 2024 09:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=44JE7gfRwOgIKtvlMs
	FJPyltqAN1uVkOE8rzA0xBM00=; b=c5bD5r9Z37ZKFBms/Wt721CMM75F2s+PTX
	tlV9dejlXHMVzcuZdBotVAY240V/1xLGM5hBTyASBrLrasuM8EeaN/2vK1T5PrXw
	/LCKLLaNCYDtvIfNwzB7suqKcK7N1XXheSR2iwTYJk4K31jGTVU89MdlFEGs30qF
	oNw2Nfou4OpGAuo6yJsAy/mCrAxMPlQDCG3DJd+Wi7BSNgjBns0lg0Lq4XuK1bjP
	+XfmvNRQKNvMJye4DeqfvaIUoZRv4CvtskFb9F+0SefqrUlyUL4PQcSk4AiiQpJQ
	6hgQPROvsoIuhwRVkqGMMTdGoBwLGRHNxBpnJE3UgVP+Vx/EECFg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcnh3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:48:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8pidL019423;
	Thu, 17 Oct 2024 09:48:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fja020h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEJHPsmfMmSBqxzsPNBZU/zRV3PDetmWTqQdJ23sTK37I5oWrY3QFCC6/vwJp/xx6yZ0MvCT8NsFsmh0gMcABxQGPspqsvSSHMZ51aldrzlARBT/u6+gFce9hmggbGqN+JGKpNObHamcnMFNH9+oe/cm7HjYKJvbL8BfOjCONaHV/czXmKvWuPOMa+/bYRWtNwKhjYMq2A8M84MbVVXMh8fMpbaBUaqcqzvTS/+YOKj2i8lo3mbP2maypEbk3K6emVWhoZDagUCyDWwByuZCzxrM2ITo/Jh6xIbTvNBA4l6kilhgxUw1tHnt/RTtN74oRyidst8hWzN7HCwNYxhJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44JE7gfRwOgIKtvlMsFJPyltqAN1uVkOE8rzA0xBM00=;
 b=jUOeMGvkPphhjC342417u/yBt6geoWCR0/wZIGAk97SeAhX/abakOzXVrDIDLtwz0HWgcl0uhZvNzw+EzEXwdV7GYbjODSo7O4HTm9vVuYFLH2N62dRcA++nEDoj6CsXPynwjaZeOVVjLU6Psg8KmtWgguP+w/Q1yf6m7oXq0peKJG0dDKrSZhireUrW1iQh2FqFf9K8FchsbFvcyJvlOrmAJaCDPlBMi8gskIfHWCwp8b3t+KVyC5ASB9qI5bVrFHujTRr/BBKJVa7/xEujGJUMKsEPVlWTZhEBVkElguaoOX2sBxLhL9YhGK/DfdjNd933HFHhZ4wUF5Rqsl59Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44JE7gfRwOgIKtvlMsFJPyltqAN1uVkOE8rzA0xBM00=;
 b=jWpJj2iUIAI4Z53YLbTS6UYgF4tYZ0fnk2afB0CZqE4368QfQQzHWT/xVIK5VDBQitSJrk6jQL4iQYbRetbJBgXCyoJcjjqDnOd5zh0vRX7DsVBKMg5ahvsQy/NAAmVhStP1HLvPe5kiwGe7txsP9AMKh5YDmJEu/e9qW4kM5lw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4489.namprd10.prod.outlook.com (2603:10b6:806:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:48:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 09:48:37 +0000
Date: Thu, 17 Oct 2024 10:48:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        corbet@lwn.net, Liam.Howlett@oracle.com, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
        pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
        willy@infradead.org, gregkh@linuxfoundation.org, deraadt@openbsd.org,
        surenb@google.com, merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <7053a505-be80-48d0-8b5d-7ce52ba56c3a@lucifer.local>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
 <ac11e4c4-a1df-4d39-b7d1-ed9ebd65cd16@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac11e4c4-a1df-4d39-b7d1-ed9ebd65cd16@lucifer.local>
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b34ca8-d912-446c-bcda-08dcee90dfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxChOQnuZ5Pew+JwJDFs3ub/e0lCS1fkGBrrdmndo7K+ZhMArn4O0ESIUj6b?=
 =?us-ascii?Q?V1/1LP9xfeiLBsKIQKRC+4yd9d2OVgBbFgnjkaLVcdvOh9tbzzfcJ/DS7qli?=
 =?us-ascii?Q?ZirtkPyBHwIv01+hDQl2MpwkRwf+uN9DGacvnNeevXTQ4peCFY3lp1Zo2BxO?=
 =?us-ascii?Q?gAEQwWSLjw8kuYSP5IHT+CyPX02G5GZNxbDEswpGvCeUVpl/1bFekcqqRceD?=
 =?us-ascii?Q?EpYZnmSES9yjV1c0h23JgUrYj5l+2sOahG3rVa6G6/7SF8dhZXPHofLsBSij?=
 =?us-ascii?Q?ikiRu759a5M9wl/Q93a07cDk+H2lwFKwZVDdi26G3ImLbxfQaAS9RMrk7Gfj?=
 =?us-ascii?Q?KafQWp9XCcIRfp4QpTXCACGn8pM5JGuUXesJm2ZukrUFUHG0AEEahiFiMP+j?=
 =?us-ascii?Q?V9SgszsdD4iaL0r3YrIhlYvH3lpo7PO4uXuwsHNIHLKR2lseY7R06qEAopJR?=
 =?us-ascii?Q?3tHsPnbn6QpGgDsFhzGaIsKMO2bq7kS3QroXT/Xqafi1GSnJTXe+lvTwNsMY?=
 =?us-ascii?Q?clVTHDsZkH+wg3LlIw1e8ePUWE2W5B+BpU6J6mMbo7KKijahRHP3fcxvaF7S?=
 =?us-ascii?Q?zjgfCX4KbCyfmSPeDzUqmIYXYEk0fJSUoggt85TMKCjr8J4PAc1s7sHmex1x?=
 =?us-ascii?Q?5DptrrBJUMhx4RCgMZIC6zqqn3qICIJ5mbuO+p+5fjA1MYZkElajXL2iKlbN?=
 =?us-ascii?Q?jpRaHDANjeL3QlY/n8UG7X3qEncqpLd6HyTviIO+sP8plaPuZ9lOjgnuemh6?=
 =?us-ascii?Q?o91LRAiGMcI9CEFCZQkrjwcOewd2cvweGdapJ7FAwzKxFIgMbyGQxDayFVw4?=
 =?us-ascii?Q?khWqYD172b4UBWDwigIE3zV+A5z/i+GVmkzKlnhG2xTsT56U3bY8L80ZQtb2?=
 =?us-ascii?Q?/4O8/uZYLA5rwZsmqFfffx8VAjKORao6L093Pl5MmHTKtIA8PDqYj3ZFGw4g?=
 =?us-ascii?Q?ip+IjbrIbgliMagdQ8QMXGOxSicaDve+PGVw/77QDGVrn+idP7g6EQKBeQxP?=
 =?us-ascii?Q?DkKofnE8E7WCK7H9XTixH5ICgqZ3shv7V2vjXYvbgpAs0U7yCEQaUsLieMcj?=
 =?us-ascii?Q?dxUzM8FQ7W5naO3xhFZ/H6gDnwrs996fctqXSwyX/NkV/Wm7ZHve1xQRiWT+?=
 =?us-ascii?Q?O4hPKmzl1MrcrNJwsEfl7z3Z54obZFpkxdjvriGgZNVSMlegMVEAKbbLlyzw?=
 =?us-ascii?Q?I12giWLXqhEJG4CjeUS630z6aTp+TYI+UKrjkBDgsUazgFhbbntObkyh02Hn?=
 =?us-ascii?Q?JoMTXTihW58G6BPBjkYO4XZN+jJfugX/7kbJ3/5dv+wC9Gp9e+MysQygjv0L?=
 =?us-ascii?Q?jZnkE4HNPTNfWnH/lD1HFjnf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+VtGYx4D2TI9zjiMLJUiWGQmscr3XW/eFpBXhGpX/L0bSWp/rHVfKvsy91R?=
 =?us-ascii?Q?h8lrxm83vRlnDe7gguNuYEh25qHI2Cl635eREJxkudfUvYfF35PuEfY9TDrd?=
 =?us-ascii?Q?aYOFWPMMrs0mfG5KK8lvr9Ov784HFnDk9uyDCc4XTYzCuGUmvgSmwo8QP0xi?=
 =?us-ascii?Q?Bpu1NWEelnZNdz+KCH9Fn+LGaBi8jr9cC6OiJEDEY2zUK+2QGzgs8EdoJ4Kj?=
 =?us-ascii?Q?vAtTuJz/eGqgbm0LdC3D8pCCxNm0oftsTmmpvCkKJ+HbHjLNRBoBWI0IaMtx?=
 =?us-ascii?Q?tTIAxS2AD2N/ULXW/QiCeiwGjH3YwDBszhImHyslWGq/TF/R8Sk4gBcOU3RO?=
 =?us-ascii?Q?TluAvh9ssJx0D7kDqBeMO56JfxR8CPEVjqs29sUzCZqdwX/wAF+xFttbPnnd?=
 =?us-ascii?Q?aglv5lFN3rTA8LDa+ubax/d7PXRvKFvJVxeIr4QJKUENDi7aX8cUiS0As0Ey?=
 =?us-ascii?Q?88cHchj0FH+glOzPKgropTdaVrzV1M4zoEXiNk+YbdnIk+C5kFad95+eu39c?=
 =?us-ascii?Q?jgQ1HHTmS7oXTu7oC0ZdwCaoE7HxRp5/aBRJmBN34y145uhTc7CxiOeMMhpB?=
 =?us-ascii?Q?1IpWhYt3EMkt0MmWoq8fOcqD/tqnEe0SeBObigS5l2jey8NPgMUvevalWQm1?=
 =?us-ascii?Q?7ZJA3coJHQoallOHImf0LQH/1TrAo6T6L7oxCmBa2F5JJ2mSs0/Kf21FvYka?=
 =?us-ascii?Q?6v31SG4l4zNMiEORdRKIhBcrab0bMIEvLJHhqJwi6rexMTfqOhxe43QItKTb?=
 =?us-ascii?Q?wonMHsaNLs7LF7s4stb0zXsME/lXfL4/WzLcdiU9jd0P6PlYQOOvuXYYW1/t?=
 =?us-ascii?Q?ItXRMU/zZmYrvSnCuVasnXsMKYMXj1fdFTH4QXImKW1ZJHhVnpkZtCKgQGuF?=
 =?us-ascii?Q?PrGT3QgEo9OBHdHhCs4+j36xcAAK0cHAUU4gk3+7OoXDgUmgKPUq0I5UhQuf?=
 =?us-ascii?Q?CWhD8LjYZPW4r50YWKfeyZMB1V6R9s0cWBndCpJYGew+0hyFAW19VT60RGgf?=
 =?us-ascii?Q?2LdBkGWogl4NlUPMO5SHd84O9QED9R/cNBKhsp2yNtnSc23v5sYLgjqR9Qxl?=
 =?us-ascii?Q?VCQHqqTAV+BGZnPBMPgvWTqVuJiK48PS6NZFGe2aHeJl9gVsPID2HzsUSzzO?=
 =?us-ascii?Q?2DGm8rH1bLsGn6qLGFyIu8I8mGD5vohHwEQIAjDp7GTv1TFHyxemr3ZhMiFL?=
 =?us-ascii?Q?cXIBvNJNAzhk1EvQ+5V51yDSfzE1bOgwxQu0LE3E8o1H8nJoJD6W0UaTLoty?=
 =?us-ascii?Q?EWQC76ukY2HpicxZ5uLPluwlT+MaAGoxsOtQ9yY9nY2to6fOtIDN5BapyQAy?=
 =?us-ascii?Q?StyhXlecohXOLvL4zVRagNJk5TXk6XO67B79geJDIqFaliJkL3vlrt0HVI67?=
 =?us-ascii?Q?SIjuRND6YzWd7kz8mqiszQdK74rVWuMUlTyIo+EH32h8AmfKiqsYVhts1XjN?=
 =?us-ascii?Q?yOrVpb8joJ9JSK5upxwgdGvPv1L24PFpQs5+Gg3NfKM8c3zDmrm4JdS7eyB5?=
 =?us-ascii?Q?Rvgu/h6VUDxng4b66wvEMuP1P/zR5IO8e7dsIYA+2GHZ0mb2qOR+jBE+hmbp?=
 =?us-ascii?Q?mURlGzYtMt5kKxrqdXH9CKTaMVHxwV7MNzK8N+JfrB9BJ5qzuN3O4AZPVvoK?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7lXsrLA6nBDi/RipYcDb4Ih32gWKPknUsK3ANYn9rYfUChI+bMQ9AEwujyqF/gqyzmXq5Hk/8Csj8KIiRWDPuMWCzIekzOj6dRtGLeZkp1Tro1cpt3HsMzUkR8+mVnq28SQPVvZxO6jvN9OqE0iCjx0ZS8fbaPw8RPjRF08up1SqstmfwYxQ67I49drzU/iSuJ9PQQ77J6w41Eg1frKTk0TIfJNyDFDjltMvGDA8QdZck8ADvYZCN3aS+NJcF4iIAwZYXhbpOKkhYhSJlt0lgsoZqFabWJ1uoKIWH7to7aFQx5e7T+vpXcjNwSlARcj495acAibCk2q0GVlwYzMcJ8OwlUhYuD0N9QTrf0Y805DPvWPL804xUU+4DQ1UWhDc6dI9jklLVsQcuWDnsixERgMWIzmIMyfoxGPsNfuloHGs7eKioIW3iYy8GXiRyi8IROUHiAlt9djkDKGTgR2zrI5VH2mlt2nJkFJlWivVuU2u+f5mNnwWlrtYUyAIlItxOnxOdQ7oJ9SMY6i1B5Bbgc/fELSLedHYVy0y9Pyk9yhDNnEBx5gb+Qw9AmfhCD98/snwodGBTeQs5WkjZiwaNSXFC0dy+WW8Nbv17P6yjPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b34ca8-d912-446c-bcda-08dcee90dfd1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:48:37.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oxIqaabwcvu8rOkdef/pvjCQABEcn6HExJaKwI6xshpSFfQYV60+cN6d5n0Y23EB5ttTQsZ+gW9kPuGZEGKfaG2+kab9zUnYiZzPucFHPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=751 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170066
X-Proofpoint-GUID: f79cmjQDIgQ8npJkOaebE-gE1yY8lFcX
X-Proofpoint-ORIG-GUID: f79cmjQDIgQ8npJkOaebE-gE1yY8lFcX

On Thu, Oct 17, 2024 at 10:46:10AM +0100, Lorenzo Stoakes wrote:
[snip]

> Anyway, let's try to decode (please take this as input as to how you should
> try to communicate these things):
>
>
> So we start with a VMA like this:
>
> 012345678901
> xxxxxxxxxxxx
>
> We then seal the middle, starting at offset 4:
>
> 012345678901
> xxxx****xxxx
>
> This sets the VM_SEALED flag in the middle and splits VMAs resulting in 3
> VMAs.
>
> We then attempt to unmap 4 pages from offset 2, but this fails, as
> expected.
>
> 012345678901
> xxxx****xxxx
>   |--| fail
>
> We then attempt to unmap 4 pages from offset 6, but this fails, as
> expected.
>
> 012345678901
> xxxx****xxxx
>       |--| fail
>
> At each stage we should observe 4 VMAs.

CORRECTION: 3 VMAs.

[snip]

