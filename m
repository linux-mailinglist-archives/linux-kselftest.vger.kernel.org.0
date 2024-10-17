Return-Path: <linux-kselftest+bounces-19933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13329A1D4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71920288B3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660661D3653;
	Thu, 17 Oct 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jrxUHUxD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ng08O+vd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267521D079F;
	Thu, 17 Oct 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154152; cv=fail; b=ZHROOKWJlx1JAh4BYAda924VD8a+A3Q6kEssuO1Vn3J8TNQvK8Wz7LtprGcK5YCk4MX7cOGcb+EfZDPi8Y62/Me+3nY/oM/oyVBaXAAUXEnorLqBefoeL6HL02mqk28sjhURPjCcKAS+VwATHSg9D7Rye7ZC6qtJ5/8H4mGC93U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154152; c=relaxed/simple;
	bh=kzT/8UbiuxFeX3+PdMqEgGPkZGGVzg0yd3CAHfSKZMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RdWT36evALswVDGuGbcxNLD4XzP/mJY/PxdN0sEQiwDWBDGTsvk8MsCZeK0mDQxRNY6qR07HvvJUV8aTGOlxX1O1OS21vj3nkJxupY2zfPwadOskxi8v9yC/rBXHFMfd+QLtNA5iKpMSnM/nb5YFGwXHlIUo7yrHM3ztCqzpQJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jrxUHUxD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ng08O+vd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fdqp015341;
	Thu, 17 Oct 2024 08:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/A6jqSxp1qie4vEJou
	tK3dg2Y57cG+lOdccl8er3S10=; b=jrxUHUxDe+u8BZAXIS5i7G1scBSJBoeiC7
	BDahs1CEqFCW3Sr2XKFh2orIlTlr1a10j8PjyI06MmcDM+hexV8sfwy3fetmJlJT
	jjyDu03IEc+UhjSYrJQz6xoxpYK1Jy7KDxjuGrgs7T+lJI8/SUe/dFxnN3MyxLk+
	1YKib3Q46IsxmNcRqH7qao+Eii2HmH1eL9XNKl8HKdejUPTIKuRaRk4Aa4/PWK/T
	jVV18r/We2uyl0bC5gDOVgfTKtF+rNPYNDWPBTXld0r/0e9yBzF2rE7arh0EpHet
	rdpjhgpjTzL3LB283qlJ8fOV3usTjpHS26YlP5CNKD+5aTP+HDLA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt5rr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:35:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8F0sd026389;
	Thu, 17 Oct 2024 08:35:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9wtdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe0WeF26UFzlueTJXqzEVNSigWPUvSsC+hX6zOat8IwCcLcnRYnguCJ2OwKf/UJe7ghrZwGg4rjiCO5niUhFnvVpUzm4Y2qrU/d9drIw0hbO3545biET2yLHUSCa7Ab/S/TdyFhXK+Hs++/mZVRvK+fi8WKrsiEL+MVwqzB355ugpOaLtrVOfjtLH0qCGycHIrVB4SW6js+aDstLv4XarohqsQGIyln9llguTmNYMoUU1ynBkgWK/TTxLO94Ot2bU3Qko79jaqlcDo9fLvFn5OPCn5UNImR8hDYnPU4d1GbdIwdsO4RmLFH1BU0B0cR/4/N5ZdvPrans1Y0W7H/7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A6jqSxp1qie4vEJoutK3dg2Y57cG+lOdccl8er3S10=;
 b=cJ4tdE/LL2sWcCEOxbBlmz73Qau2XkK0b+5ffsmyFdsqpe1VtI36MvXqPValr5IXlex1ZARc0NhnSx23sFiWTRDS+VMhzEPDU/83UFZfdwkzagb2wn+rlvkZaedwDlKmrVo5oxA4EsVzwz7lakQErv97j9t1E0bPbIfAADL6q2e+zgvqB4qQbtcoeGNil3YnJCInsH9ppDAIx0OU976swgH+0q2Ry1kO4prdlxm+9j+KiVhj8N1cjXgqE9kuc8I4/jsEtoTmqilPlgkH7qgfao3Jlr5ffaON9n4LByBdh+mw8x2KIeqcsl3/s7Xj6BB4XiruHHqLzitMawe9M+RT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A6jqSxp1qie4vEJoutK3dg2Y57cG+lOdccl8er3S10=;
 b=Ng08O+vdzZK4fkK/b0CjUih5ZJVmEE0+VGFlMZKXFjmmguNtp187/9KVw2tuva5waqzGWrCLbozNyb0+o7x7hik3kZbmu4aLsy413UaP87BZE7nWCBnarHbv1nrpQp0UPsRKfyFve/aFqFDKXfHO9kobDuRUwcIItJNbsfPFaQg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6260.namprd10.prod.outlook.com (2603:10b6:208:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:35:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 08:35:19 +0000
Date: Thu, 17 Oct 2024 09:35:15 +0100
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
        surenb@google.com, merimus@google.com, rdunlap@infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftest/mseal: Add tests for madvise fixes
Message-ID: <8fde3b26-c37a-4ec3-9cf8-2663347081f2@lucifer.local>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
 <20241017005105.3047458-3-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005105.3047458-3-jeffxu@chromium.org>
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a212a5-8ac3-4b16-fe03-08dcee86a212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5554RBcKM5pLdc526c2WXpQbDeHUwG20PcV+ZB0bUsXyePHHZlumnTQUfuo?=
 =?us-ascii?Q?XDkmaY0F8fojQEk77tm7lBjyExqvUD1n5LrzD7fAM1Wr8ePg08fWBZErmNi5?=
 =?us-ascii?Q?KuzLYCXHSxb67U2pFPj8gdpbi87NRf8wE6d4jNHyLMtmaNutkXl+ZYSr2lM3?=
 =?us-ascii?Q?4p0ICWkR8zjo+ucZzlSYJ6KQHco0KfXnD3yyEWTS8hxi2n1lrv7dDjGCftdT?=
 =?us-ascii?Q?BqktupWnnA8YL+n+1f8+x5Z0XJtND9NvodI6EP61OnvvsuwX6bO3ItjzzuIt?=
 =?us-ascii?Q?0vvXtWMp3+TBM1E7NMJ+H+wOsYjhxhfFOqxAiO4eFxNtVidpz74mo4ZjDdav?=
 =?us-ascii?Q?UaKpeLGRG7XK/UiELJ0qHn+qUEZ3K7T+yfS64H3FVLxCp130acnrfiUAkeZ9?=
 =?us-ascii?Q?4X+rpJ6S3rBYTKgb0kYnT/vp4qc6ggsDGPbapdLi006SfX4cGkN8Wdsc8qnq?=
 =?us-ascii?Q?+4x4ju9xG1DJ6lMUODf9BvrHsZeXNG+lC8WcRTjhV5awbFRxWmuNyQBwCX/i?=
 =?us-ascii?Q?UyyewXbVTVdFlRzfcv+C9GCnCwofBI5GLxEQlRM+RFXx3VC9argEz5qLXJyE?=
 =?us-ascii?Q?gr8tpSqsQjnJYWXiMSc0Czd59CgAMGwcJ0aZxVjfASEl0NluV579wllaKhSP?=
 =?us-ascii?Q?JhLKAQi2mrypL89ZlE3wqNsRZCLmOG/6aeTfWNiGuf3W87008GI6Qhi2QzOc?=
 =?us-ascii?Q?JZXhJe2PeJ8Syr8An5HxHBovNKkZZI+y29d+/iAojBl8JMsJ0FyP517i3oPX?=
 =?us-ascii?Q?tmkD3d/PwuxiB7z2w1CkP05dUIF/PnZlr123Hv7xVAevXDYHt4WJdoq50T70?=
 =?us-ascii?Q?u+zTjzwmR9MXMJr2uRbcYzS6ybakt/xGHzVo3lr8IXGMf7fYvFXUHyGrONBp?=
 =?us-ascii?Q?r6ZS4KyS1CKVSJ4Rb2+0zNgYP1OPhmZ+r3Xc9Ct2ZjnluYWppRFD4YldZX6x?=
 =?us-ascii?Q?O0EqB1/rcwnuc2IHzLcl+e3DTe1Ut1RWsXB+gbphPzc8rXl6/X4Yox3gqaCu?=
 =?us-ascii?Q?gC6ZMhlCmclv3L1p/+E43yFedQ7idEaBLihpAcXwkGhtSfzefR6GgI6FW//+?=
 =?us-ascii?Q?dKeAVL+yx5ipdFYRc854PmvvjzRGXWE0sE+GK1R/SysFsn/n5nZgRqIbeyEA?=
 =?us-ascii?Q?WtyXzy6YZ3wLaJDFWYm7DMnd/kJA5uASIvTBSJxkG1xNWER5m4OlQcKkXaYo?=
 =?us-ascii?Q?b3tlNhGPC/EQxEJWJjRfH/nqTWzqRuOF7nXhfM4l9FdHC8SHfUiihGUpLPy0?=
 =?us-ascii?Q?zYhk8GT5yqmlIZ5ldpZApPCj4JgBLRPBy1RM5j8dNJBzgU8DTqY84fNxajey?=
 =?us-ascii?Q?hvKoKnOEhw3Euy74PE0+96bo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JZIS4a5rL2M+D8aWPPQupqBXkb7QEYUocYgo9Fs3I1uOcHJKe08ZCTEXNvt?=
 =?us-ascii?Q?4CiWJRKLgZ12zuFCgi60Qr07acCFATro0yFC88rTZ4XF4OoJPlo7tNL5rD9N?=
 =?us-ascii?Q?r/gPw7P6VEzf1HHYSUNW68H0RUxtz1xEwcHUg0ZBF2MMArnH8RFKZaefCuDh?=
 =?us-ascii?Q?m3izUHtOEbPYfZvgxJu/WTC2AxOLfbljjin0PoE/PdUpPD/tIVhJAHHzbX48?=
 =?us-ascii?Q?KSoHf0wdYSO/npos4Gb78oSLD3QFziS/hdSV636/tdzMNtbNVyRSMFOPy2jT?=
 =?us-ascii?Q?MFT+N0m1yeUjrkJA124E1r71m5QG+NWaCPS0GAkZ05W8tIIppmrEhbECdvqj?=
 =?us-ascii?Q?Pd998aoex0CNkcSi9z/3SqTlFkzQtPNIlb2e6jVkuj1UuJtrz18pCBZjFLfG?=
 =?us-ascii?Q?MFC6WjA9tURiANzKaMnW5eZboVz45GlIdFFx8gVs50vcUCBEgIPVOh+4ykIw?=
 =?us-ascii?Q?pkDP+R7aKUYny6QOzuUb3eJUdAqV69ahEWKhLjBAJWBLoyn1nntxq0Fw1MHc?=
 =?us-ascii?Q?753e5NPxgHu4CbBiSGULcZRwQoelXZeC1j905Mg+geLvXAkX0GOBdPzaoaKO?=
 =?us-ascii?Q?HCKvkOOfR2RkvIht7q1OBDo7CX8Qz9wInWl10QwR/Rjl+6ZhYms7dqu/DO0Z?=
 =?us-ascii?Q?kWaRRuoy1v4IGNkzMtdDaqv7pcZ/uii4eGkMUxOdNPEkvM9OplI/LjWPvNmY?=
 =?us-ascii?Q?Oew1ZM2VS7GdhOuL9MgJdghnREO+1h4i5q3vOKi34KnD332mIxlqTqDmP7+Y?=
 =?us-ascii?Q?HKyMXB4GASVHYJrVUr9wvNFppGDGYlsnFnMxYUqjyUZcfD+Vrdz6NldeSg/l?=
 =?us-ascii?Q?MkjKvaTabC/VCwhRr5w1G/NduA4Mrz6L7MZnXqK37h2Gc70Yx2nKcFu11D/V?=
 =?us-ascii?Q?3wUgoGh3+Wki8wRUTijHqmMBrlWEhKxqvf1SPrIS8jIn060E9VqXWkUgwl2y?=
 =?us-ascii?Q?aXji6Rqk7zx54CXioC72HLwdcNJ7GixD5Ynu2pEsOPCJlwOg9x56kuF4Ro7C?=
 =?us-ascii?Q?gAz+KEz2/B6Kji339qBcwoX5OLuuQS19hajX3aqzCFFEKrECwtmroYQl951x?=
 =?us-ascii?Q?4hXus5TO38yNnHO43KgSP/lwHGPDE8GXNnPU9sEpLdXkocXRP+MfM/gbFS8G?=
 =?us-ascii?Q?2qmBeoc7O/OgM78R+vJVNaqeDsfb1eUgrSG9nxb3nK5qP2SKMI8R6r9+PLHI?=
 =?us-ascii?Q?BMB/+0BfW0EsnMMoDrIewHdg7yWDyeew3YZ+wRKKdHzIfOx88x0e9qpK/w+u?=
 =?us-ascii?Q?EWBCtfzZ2vg9a0E62UJ3H/UJFiZZt+OXD3vNY2fUlA9TJLfT1ZkQ1nuioz+7?=
 =?us-ascii?Q?560RBK1Xcu+NCFVJM23sKsI3Rm0cSP2zDW86ryikJbFXECAXkSjPiUmX2Aiv?=
 =?us-ascii?Q?7MO12zyR0erst9WVY7AhyXn7CRkA4YaBB5A5f9gVFXfg/HmFxPqSo/dwKqUU?=
 =?us-ascii?Q?/GKcqvApNAefNW3mFXEDJW0qjVmWqIPz+GV6vokYHcKoKmC4k6xM582WFZJL?=
 =?us-ascii?Q?YX5NG447S2xpYMMNoxOs5YMwo8cOlxhRSAEgYHQZ5iNROzataJ/yHBsj0Btg?=
 =?us-ascii?Q?lUNMnSxHq/zhg8IPzRpjxinfPqRBSSO9Rx+P8/YOJ5I+9OKyZh3FzMYI7tWC?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YnUBgkIfVkQ40AynQCl04dIPjMFXo//LjG3b6MPEWfqeX2nZugE/6qWOeSGvb267+MyYvYpCp0d/nTBfaEIPLeUpRxP+K7h015S4GQzNJTmqtHMG51jQcR5txSEiYE7VEcBfGktWI2u5EF6jpVmy44saKeHwXf4itLlO0UzBEHnDkTyi53h4I/jw13ummGdXizIUzCWA1G39CMUI51WL+x65r7XPq7s0D6NLgXqdvCc5iqNxCf8VNxmKG9W+Acd90iDs602KETgrvx3zbJMuwoDnGr1PdViE0ib6zdtdcYKD3hewnMHAzkUWOn121mSYpm2VzVbdcK/G22m2n3+WyrsLr4FMihZga0Dlgt/caEVj6sH+Q/4vFmLsCHAk4XGKBRhcLwG1dnv3m4GDMV6QKrHaUbX7A4SIGCucYhWLA/5+ZlEtEqyFCLB/kZ4J/NJcgJju5H2mSq3OY5jrpcFbQNFjG/fgTqsDoa8a3sW/17L6fth+xx/dAkMNc4UPaS8DSt16qdXnu6huc8bX+8gBEhFbqYPO3YIh9/T8glotiUDN5kVev/Dezk7c9va98mCV2xxCpiOTDLE3JID3RbtYonAYyr/b/oU82hdKCA+CA1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a212a5-8ac3-4b16-fe03-08dcee86a212
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:35:19.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsXTvBiSMZ481zXpyLA1AjDyq9UIRTYfhN24bspm/S2ypZA/ov/G12Hm/hGiwKlzuhGSXIQtxAlAACoh7Tq0fMMwtmzDyGXWbrn6srzTUu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170057
X-Proofpoint-GUID: comPq_Y43NqrOxr_LumCxGJOBc0XbK8b
X-Proofpoint-ORIG-GUID: comPq_Y43NqrOxr_LumCxGJOBc0XbK8b

On Thu, Oct 17, 2024 at 12:51:05AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Testcase for "Two fixes for madvise(MADV_DONTNEED) when sealed"
>
> test_seal_madvise_prot_none
>   shall not block when mapping is PROT_NONE
>
> test_madvise_filebacked_writable
>   shall not block writeable private filebacked mapping.
>
> test_madvise_filebacked_was_writable - shall block.
>   shall block read-only private filebacked mapping which
>   was previously writable.
>
> Fixes: 8be7258aad44 ("mseal: add mseal syscall")
> Cc: <stable@vger.kernel.org> # 6.11.y: 67203f3f2a63: selftests/mm: add mseal test for no-discard madvise
> Cc: <stable@vger.kernel.org> # 6.11.y: f28bdd1b17ec: selftests/mm: add more mseal traversal tests
> Cc: <stable@vger.kernel.org> # 6.11.y
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 118 +++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 01675c412b2a..fa74dbe4a684 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1728,7 +1728,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
>  		FAIL_TEST_IF_FALSE(!ret);
>  	}
>
> -	/* sealing doesn't apply for file backed mapping. */
> +	/* read-only private file-backed mapping, allow always */
>  	ret = sys_madvise(ptr, size, MADV_DONTNEED);
>  	FAIL_TEST_IF_FALSE(!ret);
>
> @@ -1864,6 +1864,111 @@ static void test_seal_madvise_nodiscard(bool seal)
>  	REPORT_TEST_PASS();
>  }
>

Again you're doing things in these tests that have come up again and agin in
review, and so at some point as a reviewer you just have to stop until the
review-ee starts listening.

Either provide an utterly profound justification for:

	FAIL_TEST_IF_FALSE(<negation>)

Or stop doing.

Either provide an utterly profound justification for:

	(void *)-1 vs. MAP_FAILED

Or stop doing it.

I simply won't review/accept your test code until you do.

Thanks.

> +static void test_seal_madvise_prot_none(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	ret = sys_mprotect(ptr + page_size, page_size, PROT_NONE);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	if (seal) {
> +		ret = seal_single_address(ptr + page_size, page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* madvise(DONTNEED) should pass on PROT_NONE sealed VMA */
> +	ret = sys_madvise(ptr + page_size, page_size, MADV_DONTNEED);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +static void test_madvise_filebacked_writable(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	int fd;
> +	unsigned long mapflags = MAP_PRIVATE;
> +
> +	fd = memfd_create("test", 0);
> +	FAIL_TEST_IF_FALSE(fd > 0);
> +
> +	ret = fallocate(fd, 0, 0, size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	ptr = mmap(NULL, size, PROT_READ|PROT_WRITE, mapflags, fd, 0);
> +	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* sealing doesn't apply for writeable file-backed mapping. */
> +	ret = sys_madvise(ptr, size, MADV_DONTNEED);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	ret = sys_munmap(ptr, size);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +	close(fd);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +static void test_madvise_filebacked_was_writable(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	int fd;
> +	unsigned long mapflags = MAP_PRIVATE;
> +
> +	fd = memfd_create("test", 0);
> +	FAIL_TEST_IF_FALSE(fd > 0);
> +
> +	ret = fallocate(fd, 0, 0, size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	ptr = mmap(NULL, size, PROT_READ|PROT_WRITE, mapflags, fd, 0);
> +	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
> +
> +	ret = sys_mprotect(ptr, size, PROT_READ);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* read-only file-backed mapping, was writable. */
> +	ret = sys_madvise(ptr, size, MADV_DONTNEED);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	ret = sys_munmap(ptr, size);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +	close(fd);
> +
> +	REPORT_TEST_PASS();
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	bool test_seal = seal_support();
> @@ -1876,7 +1981,7 @@ int main(int argc, char **argv)
>  	if (!pkey_supported())
>  		ksft_print_msg("PKEY not supported\n");
>
> -	ksft_set_plan(88);
> +	ksft_set_plan(94);
>
>  	test_seal_addseal();
>  	test_seal_unmapped_start();
> @@ -1985,5 +2090,14 @@ int main(int argc, char **argv)
>  	test_seal_discard_ro_anon_on_pkey(false);
>  	test_seal_discard_ro_anon_on_pkey(true);
>
> +	test_seal_madvise_prot_none(false);
> +	test_seal_madvise_prot_none(true);
> +
> +	test_madvise_filebacked_writable(false);
> +	test_madvise_filebacked_writable(true);
> +
> +	test_madvise_filebacked_was_writable(false);
> +	test_madvise_filebacked_was_writable(true);
> +
>  	ksft_finished();
>  }
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

