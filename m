Return-Path: <linux-kselftest+bounces-27395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA6A43079
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 00:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788A63B265F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B2197558;
	Mon, 24 Feb 2025 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFiHF4y5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RBsJp8si"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEB4430;
	Mon, 24 Feb 2025 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438195; cv=fail; b=WWwfG8phAvkCDCpu8Ggv6ayFXwGTMNh2T/JS66sONzbRpSjHbLTqFprXAquUhbDYi94wC9Aj24sER9DQFXpqhdGMycLWZSjER9JPV132fb40+r1ACv34100ITkSpdRHEmVDigvan6jZaiHJOrCL285GDBhr1kF66MEYNhF+jbnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438195; c=relaxed/simple;
	bh=UEk4DF0d8FQ0YoeFFm64s9KfhuCAcp82PH5exTt2jHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XPELoNTJpZjzXw15+ME2FefAMnpjCCTG19kxMYIWqZx6Rq/IseHgMvscWQfXRkNQVhMxaSvCGuA5X0zSjTOUuL8HdSsq2l3Z8UztVmqH3aU5NoBZAyEC63AUnrWVYfvGFumO+QAwwr7nTCKI6eVMytShUTGvFGA+EDHy6xw7pKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bFiHF4y5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RBsJp8si; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OMKO1K031497;
	Mon, 24 Feb 2025 23:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XyZYXPP8T6dEfac3VsvN8i3/b7yr0hEswJB60q7XbMY=; b=
	bFiHF4y5Ie6x46+4N+lJIzt48opaFDUu2hmyO2387M5AzCyN04TDvVep7RfR17P4
	wbTNraUBo2teMjsMdODRhwe6LJ9cXPBfnI6P+eo618j/Rig7bIKQr7cLJqo907cz
	1QUI/4qX6w4i4fxludKirlaRu4rBDJc9bkbvmDTbMGukfLygjEJhrf+UlH/2fDWe
	R/xBXVj9sHYgcOqa7K+IdQfrTuZ92FKt9eZEVYYBpKb9rS0o3hLhosK5oK1xHKer
	s8DbdwNW/Nog+dQ5kc9tGSVX/5mWk6DmmndTYvX4q4WPkRVE6dqWiZalxAMJl0Ij
	6RraVVGEGiNEXGlgVstz/A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t3sd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 23:03:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OLlpQx024302;
	Mon, 24 Feb 2025 23:03:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y518ddqb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 23:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz89Fp7OXnv0spT/Ij5UOVkHL6VJxfFDujNzSUML8uMA/rPSvKlFUm/lfIm/SOpyiOldO023Ap1Mdv1S9sZoPmop3/syXqL/oJ2GBZm7jsre+NPyM7BplSp93IvsgKcPKLGtX27WSJ+lhWL6QqS5WB2QogisxhYJREYOMXGCX5+EeKj7ZcDBbYPkDOsgvlEab3vO0GPf1PU/wJPO2RexE9oZ+jSS0zMM2+0nCeA7IYRkRJIA1JVKVTPc5QqnyJ2rihfcZ/Db4fSnVOAMSZdXrLIkOlwKyES4WRRpwAGtOyx1zpR74XIa9+cU9LwXdl5LY7B5uXLFgQVt/bgknQMc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyZYXPP8T6dEfac3VsvN8i3/b7yr0hEswJB60q7XbMY=;
 b=u7x1pbujYqOOWYqCgMR2K1TNvSQmd2vxj2xOMnzYnK89sOzyIE4iGneMi/HK6n+tWjdnSCnPBU3067jXX+RLGpE4gX0IwMh4DhLYgfYGL+7Cjg1kvWZU3GsaHp5igrPeQc0CmCzLuRTvYPq4sn6PXQkFgBX3idhgtSSruFPQuP6uDdgzNdeRliu/crIShJD7IKtPbtTC3A1E5dRwtPJ5bssgthzd7odxSV/isSqw/iL1T6J0u06QcXpCtDMFj4du7az8q54BOIsiRYz8eNb8X/Kysw0TV0c4xD12zdrrjVmF6by1PDJvBeTa1y4PMuCgvABel7kMSb6LQQXwrVVZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyZYXPP8T6dEfac3VsvN8i3/b7yr0hEswJB60q7XbMY=;
 b=RBsJp8si7RalpmFdQ6ZCMUBgruVwjdGUDBs5TYEzZb4nKiOaPWVR7yYl27v6SaLB0YDYJIvjHYFFnxwd/6YKsJFDSUuQYyx1IuGD7P7A/g21dETHZtB+0bYktlZmbvPod/KAXHMEkZ0u/fqswjOtp5n0UNWT13rKQ3JcSuh6Bns=
Received: from SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 23:02:20 +0000
Received: from SA2PR10MB4714.namprd10.prod.outlook.com
 ([fe80::11af:3046:4a54:f62d]) by SA2PR10MB4714.namprd10.prod.outlook.com
 ([fe80::11af:3046:4a54:f62d%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 23:02:20 +0000
From: Chris Hyser <chris.hyser@oracle.com>
To: Sinadin Shan <sinadin.shan@oracle.com>,
        Shrikanth Hegde
	<sshegde@linux.ibm.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
Thread-Topic: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
Thread-Index: AQHbhFfpg/VY35ovEEaz8LmiE03uqbNWIRgAgABASYCAAKcjdg==
Date: Mon, 24 Feb 2025 23:02:20 +0000
Message-ID:
 <SA2PR10MB47149CA0B28DBAC122A960E29BC02@SA2PR10MB4714.namprd10.prod.outlook.com>
References: <20250221115750.631990-1-sinadin.shan@oracle.com>
 <20250221115750.631990-3-sinadin.shan@oracle.com>
 <ed7386c2-50f9-4fa0-8a94-fd67ae2bba4f@linux.ibm.com>
 <c5f8d593-e667-4b39-936b-21c5d92f7016@oracle.com>
In-Reply-To: <c5f8d593-e667-4b39-936b-21c5d92f7016@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4714:EE_|DM4PR10MB5989:EE_
x-ms-office365-filtering-correlation-id: 088e09d5-2257-4f61-cdc9-08dd55274adf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2i0WpjdX/RB7syt89o5ONV/5Uks/xceGcJyqMzD07XX6nZ+pw+q7g992Y6?=
 =?iso-8859-1?Q?OD2hTYtINlNJZgnpNd/QblwW8n7dAGWpn9Amuw7EVgz0uLjLcJzf6rulUC?=
 =?iso-8859-1?Q?IjNWDoaegeXopByaioB/XBAv9zVG4WTR9NCWxHEVe84FhisaviFKWHeHvB?=
 =?iso-8859-1?Q?nUaTgYDsYZfan6GfxtZ0EXtx5Vf2i1kQnwEUgi0RCdMI3riBbeSFM7Z27f?=
 =?iso-8859-1?Q?DO+sL3em+ZxAHAOmGchpxszTlMfMxmaWOf9WmACG4MMyRoDcxS4eUa5MtG?=
 =?iso-8859-1?Q?Wby4KktQldG6eMhdChbMMTJGldmASj4gbvsrf0xjIec5aumgRA5SP4oPgU?=
 =?iso-8859-1?Q?keVdvBxgQ51cJo5wpQqAzgYQcBoPzd/d24p2KEeIABa4jwzl9APExjLSh3?=
 =?iso-8859-1?Q?JqK1gocfpG5RYuBLZnZwLD2uq7ViE6QCkxLeJrOdG1Am5ObVHgWWRvkRzm?=
 =?iso-8859-1?Q?77uerAH7BrQG6XpcXk0qcJaKqqywT5cksvbQB4rvJgNv/BIbulwcjkfLnC?=
 =?iso-8859-1?Q?M7hJeTQzs393wdPYTEDalg16yP+DjtlprOSIzWe2sFOStpAScvKJu/moEE?=
 =?iso-8859-1?Q?kaXpPgQ/T/czgHXtKUGQ/+uKnBA7Ws+HifK43+nU13XDZ0j1A2UxT1HoEK?=
 =?iso-8859-1?Q?cwMu708kHyZfbvXvFi5FgFs7AyOTB1PsIJCXUAt/B1AtqYLzSLFc56mjck?=
 =?iso-8859-1?Q?ycPEyrI4OOl9UGrP04B0hu6J1iE4Yc8at5t2+D1LtyKR/H/dNi86RBrRzx?=
 =?iso-8859-1?Q?XwjA4mmTfnwqSZdLQEhY/Nk01ceSL1sAcqimOMjoCk3LbyaiOn4d4H2Z51?=
 =?iso-8859-1?Q?YUGsGdPZsxzITIceqm/KEcton7hidl8H308c3KfDX8qpUW+zVXZnzAQCfS?=
 =?iso-8859-1?Q?08PWXCfeBdjVqNUEBvbjnTCrIFtOrlB/lomgntiQfUNNNR9QNRJWp10DDj?=
 =?iso-8859-1?Q?sXft/EUnjGqBx5D+DMEf3gfKG2yhzp60XvrOTD0BHjf7v6/lO/l8TxvtFu?=
 =?iso-8859-1?Q?bnFcW59HxnGKBUlhriloAp8J+qrkYlheg673dB7vq4gVFDodOs+c+FST7/?=
 =?iso-8859-1?Q?v9FoHkhVBZq1JbuBexLM3GEUbG8UcRPdE76Pva7mEbJEwWMuQ8OABwHxDd?=
 =?iso-8859-1?Q?9/nRgwDdwLfox3tvALj3NegyDbsrPOCCISJ0PMOWZFGQFmf3GDOBxOnER5?=
 =?iso-8859-1?Q?n1i1cxsB3ZNfHr/jgs5xBnO6jufUmC3WqbUgLewZm9ikk4EWq27iPdsD9K?=
 =?iso-8859-1?Q?c9gdoFB2HxtVaN1JogBTiVNlRPryUAlMXE/DI1Goe3HXuvzOzPOX/0EJiP?=
 =?iso-8859-1?Q?sJyzLoa2cZhLewqzrNor3Dx2cRkVv/si3SNQXFpwYiSm+7Cv7T5QaksAcQ?=
 =?iso-8859-1?Q?no2epxbbOe857oarTgjGoN8oXetOUYkybt0+4jAQLIoRKquEJv2/BM72Dd?=
 =?iso-8859-1?Q?XBgsn2DaNWKoJGvKEnArxlei4qin7Ctl4yIaaYGpFpnT8BYfjP3MTWp1yY?=
 =?iso-8859-1?Q?QvzSBRCIhojb2oSHO3g0WR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4714.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1EMKg1sLH/jTxhsDVfgzpR3eV8+xvTkCo+QTt/IxYPwXTQw/D66q6YSfqX?=
 =?iso-8859-1?Q?ZYhI7Z55ULLcu86rS2jjvtsflKTT5/vrr9W0+svqwymxHFfvaTvIlKssQ5?=
 =?iso-8859-1?Q?EjFh82A5BZT6gJylkd+iYI3WGRYEhLOxs82nd9izJ+flYC2LJZVJozpaHg?=
 =?iso-8859-1?Q?hdrylaWw5NHEZWo+mngHUFuaMg/o9A5KoufKf8RHHDMCGzmi0+iI6bYEXr?=
 =?iso-8859-1?Q?Gpv1U9Zj/NAf5M9DUAvZKHwe0PqJBp+4ARhKjYjf8n3yFFU/8EM5sp/iAS?=
 =?iso-8859-1?Q?NXfYQIrJ5rN/4lIf/pvMs/y5jkDipx02DxVTSh2kSL8CkEPr6tURZmrpTx?=
 =?iso-8859-1?Q?hyTM6eQpank9RMHV4Wfv61mVR2H6otMGviM5Ajvc3Yfei+lRfgyWmp2YxX?=
 =?iso-8859-1?Q?Vgspjyt1oYVfnRYc6sG5VyfoJ579CLsH/eA+CEy/UqQQYk/pr1ehFGLQOs?=
 =?iso-8859-1?Q?rhHjQTGNhzc8QMf9OLePwLOSykmZEtYDEQBMUQJJtWsJxq3q+zI+2IMR2a?=
 =?iso-8859-1?Q?1Po5r/cK/bdy0EkDGBn6HxpUVkA/41bY5DF33eysA4SZIgHXKPdiN7JaSe?=
 =?iso-8859-1?Q?3EuyArfziJaVztA+hGMs3Doc0DSykJ4gUx7iMVVHvdUGwz78JodB2A9ZNv?=
 =?iso-8859-1?Q?8/JmBi4U7XLrW3fADdMLWIqkr/hjWBQ/DOuCAtXfaYia7Ol4+VdhyVNIL2?=
 =?iso-8859-1?Q?N5G6uFRluQB+mgHcZlS1gy6jgBOZkLZthpKWMvIeaQkaMCnC4NHTBeRm5a?=
 =?iso-8859-1?Q?8dPEyttWAn9C4T99QyvjXfLZu0CAciQX+biaeE1WfkAHljJCY9o6wv3/o7?=
 =?iso-8859-1?Q?SxGJg9DX6ri2Gr7XM0Y18d6YRPuZV9cP9heHRAJ0iV/gK1KGcASyBnwF0v?=
 =?iso-8859-1?Q?I9BRZ2tXjperOcHo3B+OYA3kaODaenoAXeYw+IFxp6YfDym1JCfzv4up/Q?=
 =?iso-8859-1?Q?yGZL2Dp9YLzd8oQzAhkIOZFzaoLla90zcoB0pfGVcDNfJ2wgBssoKvNR66?=
 =?iso-8859-1?Q?mjmfEMdn8M8Jx0PdXcymbwnKBHvqBPGOoUWpSfbY8DxjHj9BKfr9Tb5VZ5?=
 =?iso-8859-1?Q?INjXfpVVgf2QtLjW/vfX/koBMJ0Qnw4GH7nr9xe+ptZWYJ36dEUCQnXR5n?=
 =?iso-8859-1?Q?mZTcAQprAbORf3RcRKnFjvAsri13BkgmmULZgelOCl1QoDIEIvKXPqdoy4?=
 =?iso-8859-1?Q?pr2g+uZcRRmeoHNgzS5dXZxdE2Jh0epjrMBx+sed/eyr1u4bQvhlvSR2n6?=
 =?iso-8859-1?Q?8SsICBuFF1vGiZahUuuwRussU4IN3uLV/gn3YVoA0iGoD+MySl3OfiY9zi?=
 =?iso-8859-1?Q?L8Lmw52ILvizw44Kp+/dF0N9vSiVHTjwwxcHFhHqTsar/QOR3cxBwE5nJh?=
 =?iso-8859-1?Q?DxJVIVYkX7hvo0VTP+tivAjWSRLQPJ8KAmMClgl4GGiOMo2BOkLTmFYSln?=
 =?iso-8859-1?Q?rSLnKqXlxscLJgs8xpzmdxoWEX2yIOjcbmytXSt8tm4vYsNBKkTtbStM+D?=
 =?iso-8859-1?Q?yrvSg9o/qybrwnVmZcnTGA1RkJFhLsoa7EkNXVq7aiNIAgsQT+drSiWk2L?=
 =?iso-8859-1?Q?0RTYVu3CRJQP+v1QF/d3k3fqgPza00T5OsRusfJM06f7kkNSroeObv5Qsm?=
 =?iso-8859-1?Q?fmzEiCX80+hou9Sgp+2QSL1onDluwFu36E?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0fC+RLWEDYAE90DwzXFDFaedvRBw3rM8FYpnT2kdN9r1Z0AXspxc6rLEBFX6hhFjCr12Bhye3IQ07tJLWmdugog2HgObvQ9I8RQZvhX4tdIEpVApPGLd5JQMTJEUeurnNbwolbEsD1dd+dgY2GiXOZL+yUJrVGTejYIv02wQvUQrJWivyEpBVefRGfyYp1VTmRpeuaz1JcyhmvlEFwm2XTAnQVoEoI6nVoT6uDYHBz6QBF0NUbdj/TfyEj0QQSAIebISoSuhGuXMyuyw4ojz/ijW7oiswqhU3kB1QLX/WZ2c3FxKAxGzzAeUtlkwtdWnkfQJaeSNfJ6faxfcxGRNfdFMAIbo+mGBsjYgU69l2f5+sF70ujjFNLDSPkvh6lIeBjkHGfcsLQAF/n7cMuS83opu7KKNMjmGJKnadTJKJ5KzUIbxjXhiq+lqoMFA8GuMEpXZ88Kr19HtMhmlZoAGosCIOAiE4gbiPHWFFEIjfbJNVP7wOrmcjWUkvypc/MTuRhwTnOrYlDBwsZs4LDTJ0CPRiBABpCHlLd3VDgISwrPhfptGRR3zrS7Z40CpRfj1fbCGtIxsOsDa2lFllVjsIH/emlfPfnCex8lPktwu5fI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4714.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e09d5-2257-4f61-cdc9-08dd55274adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 23:02:20.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mb+rj+HWKOwBK8CEKBy1V2+yySIgazMEUTPtK0lpfSl6GU9H8fkkEUMlkO/KccZ4aeKkEXlG8THf9uVtCSgKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_11,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240146
X-Proofpoint-GUID: 5llDhSydlQDEPMrFswTeElI_QcXZbYT5
X-Proofpoint-ORIG-GUID: 5llDhSydlQDEPMrFswTeElI_QcXZbYT5

>From: Sinadin Shan <sinadin.shan@oracle.com>=0A=
>Sent: Monday, February 24, 2025 7:10 AM=0A=
>To: Shrikanth Hegde; shuah@kernel.org=0A=
>Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; Chris H=
yser=0A=
>Subject: Re: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for syste=
ms with core scheduling disabled=0A=
>=0A=
>On 24-02-2025 01:49 pm, Shrikanth Hegde wrote:=0A=
...=0A=
>> If the self-tests are to be used in development flow, these checks may=
=0A=
>> not be sufficient.=0A=
>=0A=
>Right, this particular case was overlooked. To handle this, the test=0A=
>could take a path to the custom config as an argument. I shall work on=0A=
>getting this fixed.=0A=
=0A=
I was thinking something along the lines of just calling the prctl. =0A=
=0A=
If you call it and SCHED_CORE is not configured, you will get an EINVAL. Un=
fortunately,=0A=
passing other bad values in the other prctl args will also give an EINVAL, =
but if you call it with a=0A=
non-existent PID (say max_pid + 1) it will generate an ESRCH if the code is=
 present.=0A=
=0A=
So something like (and I'd look up the maxpid on the actual system):=0A=
=0A=
int check_core_sched()=0A=
{=0A=
        ret =3D prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, 32769, PIDTYPE_PID,=
                                                                           =
                                                                           =
   =0A=
                         (unsigned long)&cookie);                          =
                                                                           =
                                                                       =0A=
=0A=
        printf("ret =3D %d\n", ret);                                       =
                                                                           =
                                                           =0A=
        perror("Error:\n");     =0A=
}=0A=
=0A=
-chrish=

