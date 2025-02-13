Return-Path: <linux-kselftest+bounces-26576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D666A34D6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F3A3A4014
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847524290C;
	Thu, 13 Feb 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQ1US/Y6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u3Zkiyyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10887155A4E;
	Thu, 13 Feb 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470753; cv=fail; b=Ge/bGVs38c2UOpdphLNDhGGNfERtABZ5k5hCyVAted7o08jYMkCBN1aXLV84kNGx5p7uvNCmJD0VoDecx+eHRHuvdBsL622I7MLSaQqt3sB0qWyUtNekno9CNG9fw2mUdQJfBvOPd6lcQ0VOk03IBz8/rF5DoIRz+1eZ5vJJ38Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470753; c=relaxed/simple;
	bh=216FTlGR6Ro5xlICY9DBfkH6xsz/f14elnw0o236yn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHdr0ik+l1y74v4CrRF2lZ1gbEAqKk4roFkH4SqqaxJdtmITWAN1EhLVHOtv7YRB9HZ7s0cGEBPTQc4l+yTFj17MBlh9QaS+LT16Vmjo1V4LAljJMBQG5gIaMcwP++hKPr1UkRwJSCRA1AGzO8TDTI9jjjH3jyEl1RKivq9n1to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQ1US/Y6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u3Zkiyyb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfb3f008263;
	Thu, 13 Feb 2025 18:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mGV7kH51otiF6ilrSwLgAIPpo1muCbIiOB1a5NJqoDA=; b=
	RQ1US/Y65KSG2zfEZEa0XCx+9FEP0FfNd5qb605xL+j+JUpO+miWHi8NrjHZRHuQ
	b8t1haVCQeMRhRjqZrB0XQsklGp0XJg7bxkbx+n4Rz7nj/+sHaBFumbFQNX7blAA
	aiHYIrb7DLlRqrPo0RqVNpBq+9XlrmkAQPt1QREVdjQUzE9tQwtYoTkj042W3iLT
	R17gdxtIQLDWmP8hguvGHJXo1Sm3I3T/IpJ9jT+odl+vz9EaC8sFXxtCZl26Coqz
	wlhATxdbEuLDSnGdiUpj/hrI7aLydErCyzUD3v5qQ1DKSRkcWylLx+Rv35t6WWB/
	bO9H0L5Xz71GxfqbxpaXXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tna53s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHG2W1005110;
	Thu, 13 Feb 2025 18:18:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc2ahq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv/pxk3OzWrFAy31lDmOquXC+2an0het7yQy0FbSXwZ2bb1G+EoINDEGZZp7PQ0QpzUNRJW4JksVe0QQMut+dJXvHHbOIz3jx/5dVlKHfxaXVeO85V5gm/Cq+Rr8lw5pelTT5e/WzCGyVuTtjmusyjlcwKqw3BpJXDC2CCxX76HrKl7l8Arh/YYhvCV08xvod3eFCUet4wp63h7IFFeFhb8OYVgJxGQsJesWYTecdt9KXJQWDy4UItEZsW/HYz4rmMzXm/rJC0G0OHVNnbr0V4ObX9HuJnS2fve6cbacoMhxcbiKESGhhJmjV92h1SrJ87aUK6GO/GJNu8scpsss3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGV7kH51otiF6ilrSwLgAIPpo1muCbIiOB1a5NJqoDA=;
 b=wPnCYqrnnr/xsZcS+4SXUWEg2T9xnOOTPK6yXSLeF7aGSCvoZ94YjI+yMyriRVqoAVkIm2lKrfo5E87A8RZqYnnD3PDYAH1a879cum+4/njLFk0fZ8Z4b3NltesjPUcaDzLOGNEmUfPqtntOili4ogvDMz7qMrmN+fYBJNlK+30cu5jUbOLqYy3TyBKAtRk3JnrRjvUfUQD6SxGsxepSdhjT10hTGCJ05bwRwd2qXfG4O2qvVfsDoIq9I+IRvE7ummLTx/Vw+/M1zQTVRrKhYHFSqwzx4D6I89i7pObHspGNkEYj9stJ/YPIYpGSGOabpdkUk3dnt5XL/76VGOTMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGV7kH51otiF6ilrSwLgAIPpo1muCbIiOB1a5NJqoDA=;
 b=u3Zkiyybdp0sNRF3n1LktnrQsOlud9vNOWnDxGfAhtUG1VWd9UTurstP3VGiBLyRjlAKApTJUqy7jpE9eqndHs/InAxAeiwtSA3GHfDcJt41DKukbqCvBNbFIT1gcCKWJeT2mVJiMOUf7gZUYy1Tfj/7NliVyX9gkwV+LSygDKI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:18:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 18:18:37 +0000
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
Subject: [PATCH 2/4] selftests/mm: rename guard-pages to guard-regions
Date: Thu, 13 Feb 2025 18:17:01 +0000
Message-ID: <1c3cd04a3f69b5756b94bda701ac88325a9be18b.1739469950.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0374.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::26) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: a9555629-8099-465e-b52a-08dd4c5ad5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g/1RLdUS7+jetsLVYQOhK3FtWYxgbEXh8jPXcWwH49c0GiY1N210RlUAdDuj?=
 =?us-ascii?Q?qHSjiWbUhiQ99VVuch0M659F7wjczXx5g+cWXV2F1paCQ5spdgrD7EleQRuv?=
 =?us-ascii?Q?4KgOLBya3mvKI1uPOmizwK4rxwgv5seJo7wL4XraolbKleiXsrPY+cljEjw6?=
 =?us-ascii?Q?stCzP8X/rA91eZ6fx3BHU/H2wiqam6fDvX1i7AbmP0ctKJytKtNv04LVctZw?=
 =?us-ascii?Q?OXTZVVcJ7hFl1n3sYMenMqjOUpp0QanOKxgEOik5q2ADiZhf9bMq+TOHJu38?=
 =?us-ascii?Q?pHiRtF98oFpqsvoFDZTxk1PwZJCiRF3s6BMA2FJjziyBSwiEN7Zih0sQ051O?=
 =?us-ascii?Q?Zc8GWij/Ki7q2WBKwKWEePZjxhQq4pfiVgjUaB7HUwO7L6YkJQ1N64tdqlG/?=
 =?us-ascii?Q?7IC4dYtZ/C4JY0DDqw0dIHMG9O8Bq7qFVQBZiFAbGen3Q0EqTLar+6EZaE8k?=
 =?us-ascii?Q?3nJ7DFVMgswxWF0XJjUE4af3Q/qOQwOXPRZrnQKPQvSGEABqGznXybBfLbTF?=
 =?us-ascii?Q?CiAp2RZ2GknQDYoU9yHzr/CTLdIf7leghe3sQXSOlbdQ09azB/bSh6sPyFpH?=
 =?us-ascii?Q?vpZxjY5e958BYYw9utnyt83N0HioixhxRzo5SI5yYDN4ZiqnbUC60zugvRHD?=
 =?us-ascii?Q?f1MsgyWxXYH8fB0/ODGFl+NmzS5UYKzlYKeGhFcXKm4ISVtzmR/5r0oUn+ip?=
 =?us-ascii?Q?AZ0wajIN77seDrDUk4x3m8+q/4LQ2RLZCyzGuj7Y6GaTclN0wcAPxtc3o99K?=
 =?us-ascii?Q?awerk6tki0egKukQlg62GXJmbBTiw6/kx4B7pIZMaTvyTiAd3WVATVz8la0i?=
 =?us-ascii?Q?2eCev4BkkNbND4qK/sRtRRgQKIW+dbi0E1d1dsRm1mk+zyI3/9zBqQzUHtRe?=
 =?us-ascii?Q?qwPXTPllC3Qf7u3+4xHl+KEBqi9XzAQXC7ycLWwYyGd1mLvfrRZQTTJW+Gfr?=
 =?us-ascii?Q?3j8NAs1i2zRJMeeD2gaq5t25lWk1rrHHlxFjzU3wpv0sxKGH2LR5SXMlZncv?=
 =?us-ascii?Q?kx8pUZ+62wlh6skRjQtdf+EVmvuOPuK0H9x/mkeI70q856p+yZ/VFdjtX1Az?=
 =?us-ascii?Q?y62kJhTXZnKI0zqEUIDhI+lEykYdw3MTpZJck/xDT06DRdOpIEpLpfqBIDW2?=
 =?us-ascii?Q?i03RHQb/fD0Cp5EErvpj7soOvyKPWVMSRYSzwZQ+pz+tpViDv8Fd2JckgUWL?=
 =?us-ascii?Q?7EQ1d/bLnulSPvjkKIPfBLsHMNAbYFZ59oshLMh1TC8rdP2e+fNwL/g8zQn0?=
 =?us-ascii?Q?ibpjFLEpU0xqA285F6pOveuhYVTtVVp28Q5qyYuAwQSccAO6wlhciDdGy9EG?=
 =?us-ascii?Q?ce0xq7o3ECPrKWzq9IvXZH7MI9vuaD1XRZQv4lB4vxLRHMc5ybp3AEvfiXTK?=
 =?us-ascii?Q?Ol3KrDKapY5w9qfx98kePixjnSJs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fxmfe4iTVhx6gzKjKmNXWVrO0XS9SDj2Js1CtDedN29vMMP/2Bbz3RkHhkkR?=
 =?us-ascii?Q?odK+rXGeIMclklaAXu+cpLiL1eGoRpk8ct/khW/p4C2SnVtD/ybJ9ifcmRbC?=
 =?us-ascii?Q?9khVyXUTCqKRiSaALskkiLIWZpdVpxpdxHr457pe+F6O0dDglAq/X0ZMhMuC?=
 =?us-ascii?Q?4SZVUTFcjo47lCWxR21gTezmpSSbStnGUApeGzCn9AJasxNa+p+j4xEpMilT?=
 =?us-ascii?Q?1w8p+c+DqLPJpwO5n5OZGsfBiwivURMm6hmVYKy1vLu529aKSV7NTMYbu94q?=
 =?us-ascii?Q?GaswIlMUsMAmNACXGCZ8D+37bKJk4b9aO/5VZC6IMor8wm0c+z2O0Ekis1ti?=
 =?us-ascii?Q?9hHOI3quw9ReXdjj0YFT2JF4zYo/6MbUKoXZwzrBnlndwuAbBpklryZVpSVb?=
 =?us-ascii?Q?2VZLlt2sCcl5PJgwKOQjVuWMqY0ChdAXs1hYQMWSRY6CzmLyIp705gFmtOVB?=
 =?us-ascii?Q?+aanSEjxlzbJSW+hv0AFEfIxN8v/4QWyuXYp5sZlr6+xQXLP/+pQmnyrr5YD?=
 =?us-ascii?Q?luyGaLx8t8B80ZhiDZf6bkPqJbbtqjpTzbgJxNEbkY0/RLVEEVsS38ObsTzC?=
 =?us-ascii?Q?58CN3ZnBI8keFjpeqrb28jRzmBVir1G0QVYS0ZCnEA2/JtlpSbsip/K67c0p?=
 =?us-ascii?Q?keFwEh69zh429YGpHT3Xk1Su9rreVWeYfjK3yeWrElNsUq/os9qZWCLgnV4/?=
 =?us-ascii?Q?qNyCOwDQGJI6kiLMvexOVJV03CFlbdiq/9hjc8fyAkajGFPkHdxMQSelbzHt?=
 =?us-ascii?Q?AtExILrfTTkkOuESWLZvhRX2q4nKXmaSXoYLuIDnrowHLBemmu+lMQdnB11i?=
 =?us-ascii?Q?a5eAfJoi7BWJSNfZlkZiBkjxXWNz2nMnuewwgvfVcsAlHh8JdV/i0Q7sYfz5?=
 =?us-ascii?Q?pb/2w7L7s8aLUmO207QwCC9jqId8aa/ZZTICGZQ87krQ9QUvt0mKvoM6tGKR?=
 =?us-ascii?Q?lRecbZv7VPutmogzRYS1W7hPa1TpIPwTlWD6RaFIsQrfHz6EF2oW1S6ewqvh?=
 =?us-ascii?Q?NnPDG1fRwqIb1famRD+Vb3HqhSK/9QVU7RIhiF3PCH1QYwD+J4VI1qS/73f8?=
 =?us-ascii?Q?EGqtuuvuJHNhSWxV/vLXW5PHZD9qkPz8cfWMFTKr0BRQjdJXsJ9HgqGhjmfQ?=
 =?us-ascii?Q?Y5dL//ERcFL5/nkf/JRM9kqiG9rRXUKtVvF1nyx77rM9CeLwXA7jABVUPGrk?=
 =?us-ascii?Q?u7i6CDqcoSfzPpJ+owjDNOfJXxPTpCust5iM2N2ZStxnbyTYwJTqvOOX1O8P?=
 =?us-ascii?Q?Qaw9TS/hCWPsWKHBTEChHCBnlh4yn5Lz/SvnFKxrKq6GxPV1+AVqb76YPU6T?=
 =?us-ascii?Q?Q56qhC92pbdHJT0O5hyKQGwkbVCOn/T2V3Flmbjwrj/lesiRHb4Qjh4Hkbll?=
 =?us-ascii?Q?YqLfbrwd4XDB+xkhYFt7uNDosUmxs59C/YHDS2UCniZLGVB7WzuHnNg6gF5m?=
 =?us-ascii?Q?AJAg33GKCt+TB8SBLMUfThoSZ6MHf5k84NHKXZayQ7f48uxq3YQV+5yKGoGe?=
 =?us-ascii?Q?8w+j5Rys+6E7UkpltUh8GVCNRU9zEZRPUDQoXR84GUOJg6cSeNnBHJnluUB+?=
 =?us-ascii?Q?/P4+ysQcBxpl+fq3jJ31a/C6haUYR5xzoec2r/ahn/cZSohQE+G4jJRGODMD?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wT6tkNidj7Au6oMcdNn+9Dv+juTFWhOvm6r0sCBVlZZXuh3YuxSNYSNmAfH8wA99pAtbPH1iBCEhXTJ9JCnCAdB0LNE1bfVdnXdOzBabeauvghkQEUPqv3K0B692VopI2lVWUsSsDw38kUwYpHRTfEWX4gU+F99Nc2nQxSFb85X0LqQF+Mrnz+BUjJ4tPFeuzv2RG1QbWp+aY4odzY9Oh4anMDBpd5pZhAeVUCKhWGop563YfRfeMiu2zzLdGOOXKMuHakDThfzSLhdzRSo4R0WMo+lyjDfstU64WCzoh6tB42EDhUG+/Ed2ZLipB8XYk3ErOHu7/0TyGTt1RvEDcw2h5ID/m8E/rXCCrmUbx5ht5QiVh11UuEOd18wxHQoSezKlelzgfDZKL3sgnCrkrz3ZlvqCTjkdekYpvdOn6n/5L7BMQDS1WXOidTXG5KvizZY/PWGgZWaVJVLXrdf5AuiYGUMsbeR8pR1HddMxmsRiEMR1pOyPfjav5N1eokLs09lQpO/UF5h80x50l8a79I5ITbx9sJJStdKxR0IR8crisTYDleLJgD1mAwOOGRi9dDY39D+SiENsG+5HDvFxVOuoavDsGJNUh9A0C+e2Tcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9555629-8099-465e-b52a-08dd4c5ad5ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:18:37.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHMavUg8CSt6gkyD2vHNq+/mEMnBUXgJYYDeCKbQC/etagwob/SwjQ+TBsPh0UpSUq0p8F7/KNVi88q8rQ/ZqhLpxD/Qry+F14C17G6jQUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130130
X-Proofpoint-GUID: HSyxD-JS8OUgl_sxPgnrQ15Iqt0E89ls
X-Proofpoint-ORIG-GUID: HSyxD-JS8OUgl_sxPgnrQ15Iqt0E89ls

The feature formerly referred to as guard pages is more correctly referred
to as 'guard regions', as in fact no pages are ever allocated in the
process of installing the regions.

To avoid confusion, rename the tests accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore         |  2 +-
 tools/testing/selftests/mm/Makefile           |  2 +-
 .../mm/{guard-pages.c => guard-regions.c}     | 42 +++++++++----------
 3 files changed, 23 insertions(+), 23 deletions(-)
 rename tools/testing/selftests/mm/{guard-pages.c => guard-regions.c} (98%)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 121000c28c10..c5241b193db8 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -57,4 +57,4 @@ droppable
 hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
-guard-pages
+guard-regions
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 63ce39d024bb..8270895039d1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -97,7 +97,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
-TEST_GEN_FILES += guard-pages
+TEST_GEN_FILES += guard-regions
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-regions.c
similarity index 98%
rename from tools/testing/selftests/mm/guard-pages.c
rename to tools/testing/selftests/mm/guard-regions.c
index ece37212a8a2..7a41cf9ffbdf 100644
--- a/tools/testing/selftests/mm/guard-pages.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -107,12 +107,12 @@ static bool try_read_write_buf(char *ptr)
 	return try_read_buf(ptr) && try_write_buf(ptr);
 }
 
-FIXTURE(guard_pages)
+FIXTURE(guard_regions)
 {
 	unsigned long page_size;
 };
 
-FIXTURE_SETUP(guard_pages)
+FIXTURE_SETUP(guard_regions)
 {
 	struct sigaction act = {
 		.sa_handler = &handle_fatal,
@@ -126,7 +126,7 @@ FIXTURE_SETUP(guard_pages)
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
 };
 
-FIXTURE_TEARDOWN(guard_pages)
+FIXTURE_TEARDOWN(guard_regions)
 {
 	struct sigaction act = {
 		.sa_handler = SIG_DFL,
@@ -137,7 +137,7 @@ FIXTURE_TEARDOWN(guard_pages)
 	sigaction(SIGSEGV, &act, NULL);
 }
 
-TEST_F(guard_pages, basic)
+TEST_F(guard_regions, basic)
 {
 	const unsigned long NUM_PAGES = 10;
 	const unsigned long page_size = self->page_size;
@@ -231,7 +231,7 @@ TEST_F(guard_pages, basic)
 }
 
 /* Assert that operations applied across multiple VMAs work as expected. */
-TEST_F(guard_pages, multi_vma)
+TEST_F(guard_regions, multi_vma)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
@@ -367,7 +367,7 @@ TEST_F(guard_pages, multi_vma)
  * Assert that batched operations performed using process_madvise() work as
  * expected.
  */
-TEST_F(guard_pages, process_madvise)
+TEST_F(guard_regions, process_madvise)
 {
 	const unsigned long page_size = self->page_size;
 	pid_t pid = getpid();
@@ -467,7 +467,7 @@ TEST_F(guard_pages, process_madvise)
 }
 
 /* Assert that unmapping ranges does not leave guard markers behind. */
-TEST_F(guard_pages, munmap)
+TEST_F(guard_regions, munmap)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr, *ptr_new1, *ptr_new2;
@@ -505,7 +505,7 @@ TEST_F(guard_pages, munmap)
 }
 
 /* Assert that mprotect() operations have no bearing on guard markers. */
-TEST_F(guard_pages, mprotect)
+TEST_F(guard_regions, mprotect)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -553,7 +553,7 @@ TEST_F(guard_pages, mprotect)
 }
 
 /* Split and merge VMAs and make sure guard pages still behave. */
-TEST_F(guard_pages, split_merge)
+TEST_F(guard_regions, split_merge)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr, *ptr_new;
@@ -684,7 +684,7 @@ TEST_F(guard_pages, split_merge)
 }
 
 /* Assert that MADV_DONTNEED does not remove guard markers. */
-TEST_F(guard_pages, dontneed)
+TEST_F(guard_regions, dontneed)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -737,7 +737,7 @@ TEST_F(guard_pages, dontneed)
 }
 
 /* Assert that mlock()'ed pages work correctly with guard markers. */
-TEST_F(guard_pages, mlock)
+TEST_F(guard_regions, mlock)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -810,7 +810,7 @@ TEST_F(guard_pages, mlock)
  *
  * - Moving a mapping alone should retain markers as they are.
  */
-TEST_F(guard_pages, mremap_move)
+TEST_F(guard_regions, mremap_move)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr, *ptr_new;
@@ -857,7 +857,7 @@ TEST_F(guard_pages, mremap_move)
  * will have to remove guard pages manually to fix up (they'd have to do the
  * same if it were a PROT_NONE mapping).
  */
-TEST_F(guard_pages, mremap_expand)
+TEST_F(guard_regions, mremap_expand)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr, *ptr_new;
@@ -920,7 +920,7 @@ TEST_F(guard_pages, mremap_expand)
  * if the user were using a PROT_NONE mapping they'd have to manually fix this
  * up also so this is OK.
  */
-TEST_F(guard_pages, mremap_shrink)
+TEST_F(guard_regions, mremap_shrink)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -984,7 +984,7 @@ TEST_F(guard_pages, mremap_shrink)
  * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
  * retain guard pages.
  */
-TEST_F(guard_pages, fork)
+TEST_F(guard_regions, fork)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -1039,7 +1039,7 @@ TEST_F(guard_pages, fork)
  * Assert expected behaviour after we fork populated ranges of anonymous memory
  * and then guard and unguard the range.
  */
-TEST_F(guard_pages, fork_cow)
+TEST_F(guard_regions, fork_cow)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -1110,7 +1110,7 @@ TEST_F(guard_pages, fork_cow)
  * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
  * behave as expected.
  */
-TEST_F(guard_pages, fork_wipeonfork)
+TEST_F(guard_regions, fork_wipeonfork)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -1160,7 +1160,7 @@ TEST_F(guard_pages, fork_wipeonfork)
 }
 
 /* Ensure that MADV_FREE retains guard entries as expected. */
-TEST_F(guard_pages, lazyfree)
+TEST_F(guard_regions, lazyfree)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -1196,7 +1196,7 @@ TEST_F(guard_pages, lazyfree)
 }
 
 /* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
-TEST_F(guard_pages, populate)
+TEST_F(guard_regions, populate)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -1222,7 +1222,7 @@ TEST_F(guard_pages, populate)
 }
 
 /* Ensure that MADV_COLD, MADV_PAGEOUT do not remove guard markers. */
-TEST_F(guard_pages, cold_pageout)
+TEST_F(guard_regions, cold_pageout)
 {
 	const unsigned long page_size = self->page_size;
 	char *ptr;
@@ -1268,7 +1268,7 @@ TEST_F(guard_pages, cold_pageout)
 }
 
 /* Ensure that guard pages do not break userfaultd. */
-TEST_F(guard_pages, uffd)
+TEST_F(guard_regions, uffd)
 {
 	const unsigned long page_size = self->page_size;
 	int uffd;
-- 
2.48.1


