Return-Path: <linux-kselftest+bounces-26575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97CA34D68
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6840C3A2588
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA291241678;
	Thu, 13 Feb 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z3+1UFOO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ASpps0Lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084514AD20;
	Thu, 13 Feb 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470752; cv=fail; b=mky1XgnM0YFi86KpwTEUDLh63yHQZZzsgRfQgNhlcRtGKHQ8H3fhiqiFyglZM6nQZpRJbxRzaAjrFFThDCH4mzIUobsCTvIObxrKS666VC0EGAKVijvaTnnzX4eo8r0TNhDwqMvFPVU8+Zz8o/onIjvwP8i9OVtHs7v0ANHkGrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470752; c=relaxed/simple;
	bh=6r2uEJu8qQhggqq3BPKN5xN2QcI6X1zL+A+QFLZOSWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeQMTlQeG+8UHWmh1yUZc9jY3gZKfRUmC/rbv46XzyDL0O/5/rxGQ7e94Xo4pAj0cdXuqg613495X+ZlmXtvSWdRH/xLoQR43X3jSdhzPWmj01CkuaFOeBe8qFZUeZXqB0e7HfnGJzO67Ftcqif+9ux3gepWlT3vcipF2R8GV3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z3+1UFOO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ASpps0Lt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfXfA027454;
	Thu, 13 Feb 2025 18:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FHZT+6B4eEEKrQiJVYaY3M5f4NGJfj97nMnc72SUNSs=; b=
	Z3+1UFOOfbAwSOTXLxytzwEVKOCclXLIARrPuYWV2Ah8knubqg5k1Cq8jWdgQaiy
	HZCHEh8Bctxwv6ISVNI+uRUcd+eEzqxl0zLA0sMjCbxhTw5tgbtEvVEaODRtdVYV
	cOXs4S2XhpACyMoMVEU5BEeApQBmP+l0kwJTsyDDuHPDEVCc7FAiEM5ND5ydshYE
	i6Vn07PhdOxiW8hycyraJu6g/IOp9wzFtFYNF//N7zlk5HVyyb3JFIp+2A27Kpm7
	KgaTPDbDE7VddCOYLekYpnNIdsvXo9mSZv/NmKnjxv+IHIU6hsGeIb/21tJZhMtG
	u2OxkrYvI16p/D8x7hmoVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qaj5br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHG2W0005110;
	Thu, 13 Feb 2025 18:18:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc2ahq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBatCQxL7+oZZZ8VOuZBN7K1ALSOhr1TGZHenJHRfiRSzjhydAntEH++Ut4Bo924PEGGA2o3ofXQTI+94mwLKcZCVWOwkzo620SjhC5iLv2snlSczQYMHowLi9oYiTs782jqETbqy4cATSsnE8jBHNyTtDmxpoaj19RR7fBS3P7AQbEUGy6j/OeBIB4i4idmBA1W9ZlT4aRrlC5+IxQagrwT0pQfead851cBNvnmAZ5ZdxY8BNF8LHpjPkKTWkC2fzu4EPW4UisVVt8H1zsAp1040n9XGgxyGIqB/qc7CF9kMz+krTVsS9IswO+GbMBfqrw15DAALpHfWHB2Kx40nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHZT+6B4eEEKrQiJVYaY3M5f4NGJfj97nMnc72SUNSs=;
 b=dJoG1MmDKdLsU17WjHJMJLLWuAPqpof1iUekQkwvRf7UVzGi+NU8NFqgBiVTyu2aYQJKlJdOjl4fSpyMavFDz35li7yCYDfPEtmCmYeFm3+4gwQZRfDYT93/isfVeMbIbILQ4dv//qeN0P3IVDvNf6ns68xIYvMI1Y4E4wH6IUe2n7JZVfcWuRFq3O+r0R1PNAg+LSoZVO3stj+6Pkxkw9gi6KUGEyfaOy/K8Eg7CCX6y3zyYX8ilmTaKH2rYz/1x/6YuO/G/7goOwEE0SgrVrPpEZVU7VqRU97GmB22nmvCYRzBHEbdtbdDCOUohlIxmV2gHHcVo1ck9TdX375I2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHZT+6B4eEEKrQiJVYaY3M5f4NGJfj97nMnc72SUNSs=;
 b=ASpps0LtcwjwmIIuRAMPIE+yrxYIeNF3Ib/Lnzubr0t2wYcOAvguuRsFztGStgK4dy+avNY31InCQl+Bad7o8uG5ybbh8/RcIDvWQowMSkfHg6sO25tQlj46eDM60w6AbTOyImI05DAoGN4F0v02aWoj4HlX1oOaJ4XeBnfleuA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:18:34 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 18:18:34 +0000
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
Subject: [PATCH 1/4] mm: allow guard regions in file-backed and read-only mappings
Date: Thu, 13 Feb 2025 18:17:00 +0000
Message-ID: <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 7215fc94-5150-4998-be5e-08dd4c5ad405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njc/wCA/B41T4d6Dx/3/hojGtuBfzMbiLE+MZ+h3tgT3hvfChiaK79Cjo17r?=
 =?us-ascii?Q?kmvjocHYxMw3JFbTFo51fJ62Oy1hRh0ttZE0b2qLhvbLcBDOv9YTnZQMrmFA?=
 =?us-ascii?Q?cjv8d7p78bmAMQbXEFOZe3BAzQGeYQtOjFlMAMj8CgT8DQRLSDnl7HQx+CpY?=
 =?us-ascii?Q?wV693I/Qmw35ViHDSgVmWc4kDRQckVNGfbXlh/VNyXATNl+VtSbSy4nacQ8h?=
 =?us-ascii?Q?UzhUJsGoCnR6iAJCMLIX2aNPpiPfRm02DXtUw2ysGY9XJ7+M3eX0Pr/OZo/E?=
 =?us-ascii?Q?x8hlilxnSC5JyjoRmvS8rA3UFXA5vIFY67EFYuSkIsRI2kj/ktv16PYfdpux?=
 =?us-ascii?Q?udkb6/LetWGsSLhwtftzE1HW1GhPH5PteEKp4zcuLQEZBfcD13WzBGSHdIYj?=
 =?us-ascii?Q?Pq5CXmi7T5GqLz9oKXUa5jI6GDMR9AIhkjBzI7235edpJpumUUWmr/8l0hkj?=
 =?us-ascii?Q?PQ464sKf3mK/LbLXyT5QNMotvq2cNA9+S74eY6Dlpv9YB/RCYhTZxVGb6VTl?=
 =?us-ascii?Q?tbPo2ox44AkvYRYRA72XUSRkuRjD638rF21Bh9xc7hoq0rp6cNWj3DL7ATEy?=
 =?us-ascii?Q?pSv84fPvZoIgAQ7zmOJ22eFOS0qup79X6W5AyT/vbe0wzRsbFu6Romi4w+oE?=
 =?us-ascii?Q?X0gUL4NQS3Fx0Q9wBUEBCJk+CLrBNM0MqHF4PFt5WmPVYgkMD4wwrNMnRVDW?=
 =?us-ascii?Q?yd+uBMwxrpnZbiZCtJRiaE3axQrvaX2slpAZwXNZgWIrTG/YjQEzPh3PrjWL?=
 =?us-ascii?Q?mdvaaMK04jm+lzuwUcaJgdve9M1njwYsvvY+pbJ/mg+QELd6GfnMWZpcF6qu?=
 =?us-ascii?Q?+CZxnUC2jZ9ZUcpk7xeZhHL8okEfQswETIqemjL6O65Vqxj4+QpS6WIaof9e?=
 =?us-ascii?Q?Ajhs9CnXB2ttAUmVDo6xaUKAADZY7faV4o1KwfOEPRAFwJpc5JePmBmTxWVj?=
 =?us-ascii?Q?FwaGSnfK+DNuULfWMr5Os9C2KOzqs52EXEou/Ud4Ts4eGW/nRt6ttzm43Cde?=
 =?us-ascii?Q?HyMkaRoiApBakJAwxs6U8WvndqpGemqeR3akEhvklwwWxgzo3SjBzSgHFs3l?=
 =?us-ascii?Q?SFqEG0fBy6mc6VzcNXpG15KydUJFUekn/Jm8Ot5kjSR2xVXc74hokPBqbROp?=
 =?us-ascii?Q?jyO+Gxh5MAd1cXS82BaTG+0tV5fbD9FtFP3JFFhSg3QpnJrWKI/13Q+P8Ucr?=
 =?us-ascii?Q?sJUoNB3lmZw25grx+ytQXATE6z8UhhMsKM1QsBw5rNME2U8r/0tvcaH9a3Tt?=
 =?us-ascii?Q?5FwYdkI1hIzz2GCFCvYQ89xH+rKfyFgXuGlrJrHqzAIQy/g7L+l4/RZXwFZE?=
 =?us-ascii?Q?BucmCJywsK+gFEBo/kkzxTg8heW4FRk6e8uCijrl2FERwmItFhxWGWgXWOOJ?=
 =?us-ascii?Q?uLKEdOfprSNnPYsWwi7C/tgS9JCN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+DAUquBEiy1J2SJ9+Usfo8iFwxXynbZUyNC2RhbzYXnNiOeN1Dx709IG8tq?=
 =?us-ascii?Q?EjLoKRLd+PMj5oprIUkxTqOCifqNUsi+ahVCS8hqnmf9inm1OXriz+ucDwGg?=
 =?us-ascii?Q?u5bsWhH22VLl1tidtfk1LJnAfAnwXXECKWDANbsEj0sjCPfDkZq5XXufZaVD?=
 =?us-ascii?Q?rI+JDZPfXIevppo/+6u6eqHQo00JhdDztDVOXR5/nOi5SJqKswEzB853QU1H?=
 =?us-ascii?Q?qg4iHxgwkb4tW8OhnNN44t+ZkDSAfb/6sRr/YZQmnG4QY0ALwx4iLPIub1DG?=
 =?us-ascii?Q?C5h6egn7cN//Re6ANGnBD4GdauLZdfQOxbrmjnwiSuneyRdBqVFoGJVsYcPS?=
 =?us-ascii?Q?kDgvg3Y3tC/Vut/L+Qi7EzQK/f85ALAtbqpVZPnPH7/TM+v51mwOxbLJSUdz?=
 =?us-ascii?Q?b83JwkZOlObrqG8fXs9Eq8xpsyGVTyGT9mSoEoOlS+3Td/RncvbHi3T48N8/?=
 =?us-ascii?Q?9iDp54O/G/R2lw/IOgK7eVsZvKurXqO3m8XEVVdq5BJdZgUHJTQw4MbNpD5b?=
 =?us-ascii?Q?HlG26M8bUtn469/9XqGMobfSeIBW8RvFqmaiEhG9ge95wLiuDkBhn5kVJIN1?=
 =?us-ascii?Q?K75I4NSX6cJ/MQTtIUGuUKSKZAiz9eexrBIVyqZebW1NzxDDFuTLKZ4fLl3L?=
 =?us-ascii?Q?pzUpzqZJfXIR/1FZ/qGMoL5KSPHULq8Z9lNeBuNO0Yv6tM6pJxluQNkg3is+?=
 =?us-ascii?Q?sqTquqV+48HinINpkCv3a099S7KqR3FkyMUW7LexIp+35JPgBWUV7zs4Cdo7?=
 =?us-ascii?Q?w3Zd7ap8iHuv5zoxgnXmBqYmK0VUMR8RsTxrNX4ZDxIVvJOoR33e3VbqsA+t?=
 =?us-ascii?Q?URMG/UmS7KTVs5AgcmADORL1BiuKkVUCvAlhLqjkcok3VNwPJBX2S5TZ08Qw?=
 =?us-ascii?Q?gQHdBzUkYDXN7FOl4AyWYSbOcURkYXzWcXdv2/RPf4x9jLQDG9n3VlfJWIPi?=
 =?us-ascii?Q?4zvDp8QkmXPKrU59no5RnMQyuYcx7UpJA+KZQ1ll5j+5A0sqF3OGSRUnltfx?=
 =?us-ascii?Q?S3kZ+DJtPlz0AHU1vdjqQmnEPan1yDugh4F2BOEKXcCcKGAdOqFykgZV1LlI?=
 =?us-ascii?Q?j1YvTc8jBAHM7tStaTfTliZEpxs+mxSjxHw4LOmVtACxQPUI6UuI0Iw7Z0TL?=
 =?us-ascii?Q?2fwHqVo5QcrjxvCXRchRaYnaeO1JNzVBOs+5rVU42DO//LbensnygC412jAR?=
 =?us-ascii?Q?2a8DynbmWWbx8FKnLw+/0E32uL3MG5RIaauCIRYUceKRadcDlKPZj2KYozaL?=
 =?us-ascii?Q?VYB9QYcJfQ4WKK/AjpDGIWRzJzRuq3jJKlhySwAAZ3z9FG6BhgfPtO20ossL?=
 =?us-ascii?Q?6Na5l7AVC5j4VnYLSJsFvo3yQf4NO1iugCFUwxtqDZdYUlyKguT7A2HQ3gf9?=
 =?us-ascii?Q?N3fDnASxLvTDSGLaudgov50Zaz61PplkxjQ6h3ixfxY1BUfaCUkdKyozgW08?=
 =?us-ascii?Q?rJ3eZdi/oacl9m8Y8dX9y7Gi3/lk/PV2geTvnNHHzpSF6u9TSzF/fxXyHY13?=
 =?us-ascii?Q?+tDANiSPuztt5TxgzJ+jOuldido3ixxZ+WB3IOHpVyu7j1fdR1g4rjnEoK5y?=
 =?us-ascii?Q?CiO+nsqk0fNxdexCCG8HC8L0zPJTL3VkLHU1B1XpS28kNnwnaY2G2e8uldar?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iDkLaITbsPDYWfIzFRQmzBMAx937h1Bz4S465H7dAaSgmHLiyM1kpMZViQUbf9652wQWfI5EwBImbpUhoddFNkQMFxAplCpYR1EMPVK995UgMm4NZp0DUUYPQvwlh+E66Ey3sS/xck6fcQDvQpXukNY319TguyHFhjSVPYiAvODcNUz1+wJcaO9y2t++lG6BIL0Lfm4Do2xh056XnFAG5PVglENPwuN5KhOP+SYrQUVusEjm8D8ACGpvYNSy0dkj6J3dUwls3ztCNB3OWVxPYlzUSYhUVEyzHUf53DWBKgWqdss4jtlBFEutLnMGmmmJQN5GxNLta4PwZF16z+6RhpU0z/vd/kv1V6UEQ1ncnEdecT9ubyEL7sCYozSht+cOl2gvvNBR8ks8bpniQzhMNH9pb8VTuHhQGnYKb+c28y9VVJr0KEGJHjqEGS+XfWbHBk6rDD7Tu6cbx0A6iOFUgIQPYBQfAA0793RDIkj+g0Y7JzxK6wCqoJjr8zZJrbJMQZ9DogCitx/zV9Bw3CiSJ2ghE/2ATdgu9J6yd3JjXv5xg9CKmpZT38PoXuwUnWst4HNYuhoGBlCj+JbFjKX4ns1WFoo3l+vtqqDMJ8XZbWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7215fc94-5150-4998-be5e-08dd4c5ad405
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:18:34.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkJKjk56lXAZkWO0V5KXQ2XdPKPJQEPDXtRIt3rBkknLcqJ8Y6dDrug4bkeEcLRgbsSfCqqvWJoqWscoskXw3xoOBSIsFTnhH2UzvwvJwnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130130
X-Proofpoint-GUID: d_cKQjRQc-1B66vucJnoXWFu0EIkOkpF
X-Proofpoint-ORIG-GUID: d_cKQjRQc-1B66vucJnoXWFu0EIkOkpF

There is no reason to disallow guard regions in file-backed mappings -
readahead and fault-around both function correctly in the presence of PTE
markers, equally other operations relating to memory-mapped files function
correctly.

Additionally, read-only mappings if introducing guard-regions, only
restrict the mapping further, which means there is no violation of any
access rights by permitting this to be so.

Removing this restriction allows for read-only mapped files (such as
executable files) correctly which would otherwise not be permitted.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6ecead476a80..e01e93e179a8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 	if (!allow_locked)
 		disallowed |= VM_LOCKED;
 
-	if (!vma_is_anonymous(vma))
-		return false;
-
-	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
-		return false;
-
-	return true;
+	return !(vma->vm_flags & disallowed);
 }
 
 static bool is_guard_pte_marker(pte_t ptent)
-- 
2.48.1


