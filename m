Return-Path: <linux-kselftest+bounces-16676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA69643F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A46B28748A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F219414E;
	Thu, 29 Aug 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJ86xS3a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SflvtTAw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EC19413D;
	Thu, 29 Aug 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933411; cv=fail; b=D+aXuNaMRPhsM3uoQ7E1zNUFijAsyJ6nG8iCizPKr5b6q0Fm7nTwNG+2tclvlEpEew/7rX1k5wDM/RwuA3lt5bnCwlI8FIH//Amd1YKuO0lY4TxYouzmZopeyZFZA04Mb6w3OUYaECipaBRIgS535ksYK61Ll8+lPErQNCa45kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933411; c=relaxed/simple;
	bh=aC/zDqKjsnok9LfYo2+HN4GGpDtoStHMRYNgoJWU4uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POERwLHqlW6zMmU8fEX34IpBTmhF0kHtm3b90DrEyxm1vb07m4Comp5bd7Vgwh0SqwVMpMQwsJfc/sTwtmwKbkb4WmZQoaU4hlLVrgo1XpaGEY5C0Nbm0WSFuEnHpCP5Yop1XdkwdL6pnj+KfbLCL2tlXDH05ebnNpu+BhIf1c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TJ86xS3a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SflvtTAw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBi1tJ023801;
	Thu, 29 Aug 2024 12:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SxkGLs0ISRqMpgw
	QcmzC/6cIPpFbS6k1TclKte2+nNM=; b=TJ86xS3aPtjfZIG92MtvQk/ZTc6VlQx
	Vdozrps08FJf2ChNfm64tgKshEd7g0LvQQv6rfd2H+44qWBKHnAhKKBEpoYp8/PD
	w0B7/bmPzH3SC+eFojdijEFgiOrJSFrB5QQ5xeIw0hOSbAUq4RH7e3cD/Q1gBN50
	t9DyDcXWkjZfMPn+8ybdq5xlmiv+pgA6MgfVgK1cZpYmc0oR6b1qhriPUGfnzV3E
	Aa12S8PMibBP0qZs8R+5zOB6dlWpoFCMp8BEbGOTK3ymD9lJusnxdn8nI93rSdNJ
	i1S0qwjpwz2X7xOQjNvYGCFJNq7GDVhd1kReWV+n5507VBRSHyJs7EQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41arbt01h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 12:09:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBdj9D017602;
	Thu, 29 Aug 2024 12:09:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5v1grp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 12:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0N6WxGTlJIFZmb7vJoQI4xOB+scVgu6cqsGHpOFWbT/NteWkE79vJD9UVKkize8rjH7b6IJ/GGfTGEkUYgyA0bX6W3phBVCI4R4SIurnRjdVzzNRjZcDfnDmtzW0MzIDzA7hD5Ns0+Ct1toRbtX2FQNV8WOSrcZxbisZ+l4ETRqjSYLJY6YwvADOkH00s7AGYH+5UPEBaGKeoGRvAegTthJbi2zR4qGswlwePSPEzCL6z0+Xnwp7yWVQa02F86okJAFMxUWsNi/9JbAoG1yZxANl+f+Lb5/bBd9OWkv8umdA2FYIpoAv6WtsRGrFZnPy6x60etO7mEV9JiExhN+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxkGLs0ISRqMpgwQcmzC/6cIPpFbS6k1TclKte2+nNM=;
 b=ayvqoa+L68PaArYdGUCQOTUOg75RpDc7JMPAAaGAl9xOresLGUPKOXtaaIDz50GF/DUfxWEYn5w6nN3mxknexJ+Kf8YWXgc74kK+njxhA1yFV856bRQAt/d2yYdItKMq1sKd9b8a5mK23lqj3H0z5lolUHzcme3yheCHUb7EO9apYQerz8aC20b/BO9F0eUo5fAOvvO6foGZQnjR1tEQHksMbuZxbv6RIJP51PU8juZics/BzMdXKqYc/qugqJ9CEH5Vof4le1um7L4d8Yxdya6OueSGB1bA8tZDAv/C8ccLjH4hFfkEuX9fu52mtfYCuwfBlWL6H47HN5MHRZsvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxkGLs0ISRqMpgwQcmzC/6cIPpFbS6k1TclKte2+nNM=;
 b=SflvtTAwcmyH6iEf1CvEHEwvRbAXTXkmmRpSZYExUAy2UcOAI4FRvhRLEgVjU4wQgQsA7ddtHuPIhI1wytx1PLPGXRdjjTFdo/AVKbtGwNyH5pS2usM6tmID/beF4CDidjTvEQP6sAgkKMdBzV4+LYDWcWWxWhECWxynMpnUmPI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 12:09:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 12:09:44 +0000
Date: Thu, 29 Aug 2024 13:09:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        pedro.falcato@gmail.com, rientjes@google.com, keescook@chromium.org,
        Liam Howlett <liam.howlett@oracle.com>, vbabka@suse.cz
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
Message-ID: <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
References: <20240828225522.684774-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828225522.684774-1-jeffxu@chromium.org>
X-ClientProxiedBy: LO4P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d9da77-abf3-4eb9-7c79-08dcc8237847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYowgGbuJLQuRWVOWYT+7Gvi5fut8Z9DbFggMuhxSto62/eWuhtKoyqYbaV1?=
 =?us-ascii?Q?bcpIBKHAeqfsbsjloS3v3wg5/4CIQXISuxSouiG20TG5D5W2bqWo0jG/ruo4?=
 =?us-ascii?Q?3aLyQjgnBVXawFNkkbS0z54ozlnrV10KQ6Kp9ikVnbMXsfovy4OkoQhWB1hX?=
 =?us-ascii?Q?OgPkdZtZ2e1LLKDKLakZtHzrY4f5JDE5R0zPKu0RchnIaj8fJ7ztZrqQ32rG?=
 =?us-ascii?Q?FxbrzeSZ7Q3JaRfG3HM59Dd24Dce8j4SW5Q9fYwsKYuOQTurus5n588VDneu?=
 =?us-ascii?Q?nRZhLLvaP41L7t2QLA6zWBGLh4asyHS19g6iJx4kLyHZSo0s3L4tJ5CsHUOk?=
 =?us-ascii?Q?gz/e9jXcJnNAtQpOKlZWCgn1J8qwzpMVaDhMP+RO663zy4w2GvafHLiTsIQ4?=
 =?us-ascii?Q?mZ5gBjHKzaiwBbY/Z3ZQ/1ZtCl81PQRWtdIj9+U/OmbtwXh0heKmfLo43u63?=
 =?us-ascii?Q?HElTebMtBKXeM6n3SMJVcSoZMFdwSSmlpRdX88BnSrohn6kThBW0gAnBm5km?=
 =?us-ascii?Q?7Fbq77RFHILq/hE+sKPli97xwwChugPYIqt6k7WjO5gHpw9QhXYIJbqNljYo?=
 =?us-ascii?Q?QKnXq3HUetVrnyA9MEWG6qVH3eF4T/7/lgIbqMs2bokJVUsZEWK64QlVOlFd?=
 =?us-ascii?Q?PdgbjZxIJJYGamYaeldZwX/CsrRzbTb7C9XvOqCz2zS18H1econSq3QD9esZ?=
 =?us-ascii?Q?a1id3vbU4rDfUFl22Fabi11PeJeilYkrRag/UiBczmaeaMUxOhsWXfhqr/gF?=
 =?us-ascii?Q?WsF5B613F6oxifA8zHpWF6qMaMrmBl8peRya6wrPxxEf5tPVTtE0g2fv7gmF?=
 =?us-ascii?Q?rDryHQH8iiebXlkQzQt9YCLJfxyPxdF9+myuPGcNlP448Jj08Xp7r3xVmsBE?=
 =?us-ascii?Q?4yr2WZQMbBQL6C28EC9jrcAx75UfGsUrPbSoZAPwlYDA6oB3xOI4WKLYQhA9?=
 =?us-ascii?Q?9JoGhfw5H6uNByP5K/oizqj+pxbAkov7ZAc7SmPiFtAacvt6fN/BDIMUjj1e?=
 =?us-ascii?Q?qxiVsf99WVA3M1tHAUCJIg8jvFqQqKLd7uuWYiEI4T/qcv2kwXRXN6IdLV+c?=
 =?us-ascii?Q?eMJT4Cd0nIWMUeL1YIJp+nQ0ArHkcIQU3VM4MCfOwkSh0xOuc6pX3zq3oNwN?=
 =?us-ascii?Q?jtY5QMPS8Q8MyS2XQ6RFuCcn2SF+4KMe0+3f/isIXGnu+YgNa6Yln4iLHKqJ?=
 =?us-ascii?Q?I5kW+PWvF+ADtrCRYnZMZ5DDMwuXFREYhTF0dxaQ53IMM8pfznthNTmxRx1D?=
 =?us-ascii?Q?FUxG4trplXEgUXHU45sH2A2721R1HRRTlF2NLEqOb0uNIsv+mBNDfKpTNOvJ?=
 =?us-ascii?Q?reg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CU3KL/nJY97QdzHa5PHS1Cgwxm95sNR38SXLb/QHKrtHT6moYgwSDjr67NNt?=
 =?us-ascii?Q?jNoAcB+Ivp8GBOQ+INIdQPmMnmLvjojyVky29cG9YfKToxJ/pY61vr4LOkVI?=
 =?us-ascii?Q?+nApsCcxlYYsWTigkIOd0bgOo6ioLHlLeC57wxlpTqUOKnLB/F/LweVbTGqC?=
 =?us-ascii?Q?we4xDaKwRyT26AJEiqs4O7QeMdWmxtNpodfZEwJxtwSZPZGW1Yhvd/4jvRiZ?=
 =?us-ascii?Q?4q29o8RxF5w7USgZ9Ncj6b7y/LhRaF2x1Mz0RZfW3ig4bZEaGEok5vpl9kYA?=
 =?us-ascii?Q?zNIkAp8m/eP/BIKs/NONfQ9rGC/C8+XUgwxtIk5Hrm+L7bgSpfxvZLluxnIa?=
 =?us-ascii?Q?HScnTqpy5uSlCulYvkYoW6cJcaRIkoou624B4arWJqHbD+wgjEGoFt78njbm?=
 =?us-ascii?Q?X9yug2ksaS+nRMFnmbgcHonSuSFobT5PVW29CjvdBjSRbxOoPEw+B3bNBLSR?=
 =?us-ascii?Q?vCXCJmQOFB7WRQUKsvbvDvLhDuSSKI8XWGaBPMEZU10NHizCay9QPq0HuhLd?=
 =?us-ascii?Q?TiPa9rizqKYjoARATsCeQXKIJq83DT4hSRNvmOw8K29k+a7gLc/UuYCkMGkM?=
 =?us-ascii?Q?c0pd9FIKS5TOCs7PcBU4Nnj2Zk9+9NneH0B7V35kOVFSSisnDdHQby7Db9JK?=
 =?us-ascii?Q?+cXJK8TBnDAvk+eG8G2PzBTqWOcmKlO7W0RWlFLFC/wodju6sMTEUDQxy0jn?=
 =?us-ascii?Q?9rZtJGzgfBfWfsWO1IJZaMOO4TmfsLW3BT+/zbpmgGdyUCDtXTFWXFaPG44M?=
 =?us-ascii?Q?B0F1DUkUzZwlrJDZ/XvUozukSDi9RTekgwhCEz0PIPdDcjJVuGahyN6WY1C0?=
 =?us-ascii?Q?v2hVr3Pm+eYUOaoqiGxcwTP0+pI2RSNdGiNnc54t8itzFfNzKiVYjVl1QNC1?=
 =?us-ascii?Q?lMbwmc9Ni2wTpzw/ntcwvz1uRRdm7MiO8Jp2QxXJ6EtE9w4+4avE3+nXMpxP?=
 =?us-ascii?Q?g+FeY64/EEG6s1fQWFikKT+e4b7wSMTHVvqO/tXrDOYXaHScQMfNSWZXLeEy?=
 =?us-ascii?Q?a5ZLpFCr8DSpDWzIsnWNdUhFdzLpRxkV1Lume9Cslxc6v6G4/TZQdaVhasfV?=
 =?us-ascii?Q?R3gv7168j5e7ltC92tYUuc0IJQ8nnCdO/hfyP4FcZgeEdhNE1l/2UpBzkPd6?=
 =?us-ascii?Q?h8jDq1enLEKrx4UD70zpVzFu9tVM2Th5mXARO9UO8N+CKkUHr5QPxsG/3Apg?=
 =?us-ascii?Q?fRlGJAmt+lXu8Zoe+kYFrbvFwNp+3nghQejuYoNRjmWgleo/m31skxq6ETiG?=
 =?us-ascii?Q?Nhj0Q/8UqGl6HDokXoqn/+74so92vnk05nvO3mLwUNsbodFzjU9lseGplSBr?=
 =?us-ascii?Q?qITOgd9pKt/xmEEtwFzRqbDFIRcO7gDyHpvOqr4eRyNxKbsMwI+6z99xmmCc?=
 =?us-ascii?Q?/+kNOEE/YOo+bK57JIjUqJ9XBcZDYF/GyPiex6dnVkRkrboctbGN5EgIE8iz?=
 =?us-ascii?Q?5MkgG4Wr4aTQIxilRhGD1l/rMa20ZXHtnBn2WA+iRODpvYyGQuW8E3blPrxX?=
 =?us-ascii?Q?Ht0YHaK522kDEMvVfuPfP4ur1nCruzRjP3ws3KFgB6TnkXjm7ou6alCsZP+M?=
 =?us-ascii?Q?QPTDJF8GoHJLzVnjVifAZrbOtA/Uf9KEfCgjn2H1h0uEK5VJVG+CoS7UpqUZ?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nwUXsBy+UVVIprIzgfgSTNa6/m+cL5GrsxsuDk3j1SvKeoREg9b52I75RSd2+67kLUiOHAqiKdJAQxY37qU91Ub0x84dc9d0dFrwoHsSjEE8/yuIaRDo7fG30FY1Kvs7H8oBz7a3PPq9Lrd9Kwa7YVNfuUHm7oiwbTpleHXFIYEkArereafLjk41w4ZlfX3IZK3tlk/l1MobiObW6ReIUwii7EYSv+VCVzAB/Rw2hV+2/GdNv0t8zmZP13q9BVJmiT9+bGARq8dnE8908UPQh4tLWnhkZtbmNg1foZariHvpEt3hQMRPJYxpahsKG4/XSjAKiHr90RfDtldUXkB17FG241yndwb8ghVchQdPpilzZIDA3VLsoUwIJS70IQnVl0RU8egNAguWi12jGWc13BGL2BqMMLiFL10e3K4g4J9N8M1qGuaRcyOVYUtNmM2U+X4yivbVGkwrWVIPwvwcR6XT0wuNUV8ETIddcIvTJC4AIs9xpwBOzWhVu9S7jxdy9BiN3zSNkqPNholM831tDNzhlsEMs1wx1Fi0VCCZBWNOMAj4IqPtUTKjZMy9Y3pXWpqOZBwpwVKmZBjpvhSOT/Cec6jSl7yQuXn6xDGucuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d9da77-abf3-4eb9-7c79-08dcc8237847
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:09:44.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj7bEj5T22v6Cujxjsq/goQ7qqF7RYQQVht6yhpWDjoF00vKdGGNmETbbMV2ger89h03jNM8k6rzA5NoqHRFJXWREKq8MFs3Ly9BNtbp8/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290086
X-Proofpoint-ORIG-GUID: WB-Yqv6KzkBGz79yjjZRVWC43n59on8G
X-Proofpoint-GUID: WB-Yqv6KzkBGz79yjjZRVWC43n59on8G

Jeff... come on now.

Please cc- the reviewers of mm/mmap.c on these patches - that's me,
Vlastimil and Liam. Same for mm/vma.c, mm/vma.h, mm/vma_internal.h.

And it seems like it should be pretty obvious you should cc- Liam when it's
quite literally his code you're changing!

Relevant section from MAINTAINERS:

MEMORY MAPPING
M:	Andrew Morton <akpm@linux-foundation.org>
R:	Liam R. Howlett <Liam.Howlett@oracle.com>
R:	Vlastimil Babka <vbabka@suse.cz>
R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
L:	linux-mm@kvack.org
S:	Maintained
W:	http://www.linux-mm.org
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
F:	mm/mmap.c

On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> mmap(MAP_FIXED) should return EPERM when memory is sealed.
>
> Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_vma")
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/mmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 80d70ed099cf..0cd0c0ef03c7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1386,7 +1386,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
> -		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> +		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> +		if (error == -EPERM)
> +			return -EPERM;
> +		if (error)
>  			return -ENOMEM;

Can't we just return the error here?

This is one for Liam, but I'm ostensibly in favour, this does seem valid!

>
>  		vmg.next = vms.next;
> --
> 2.46.0.295.g3b9ea8a38a-goog
>

