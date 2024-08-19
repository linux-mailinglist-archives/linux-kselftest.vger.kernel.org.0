Return-Path: <linux-kselftest+bounces-15720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA39575AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7963C1F22C56
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC2158858;
	Mon, 19 Aug 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hN3Q491D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TwMpkIKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DF15622E;
	Mon, 19 Aug 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099565; cv=fail; b=nx+f4YhD3nT6/IDz9krhlVtg6yYFO5J2zulVv2w6WG0fURnpsSp5KDtFcKvt6y0YjBMkhkGE2dwbUZ1iccUO6ZLMerW4ZSw4fSiefJQCbh/lHMigg6fuzqO3Ujy8QYMXLm2bJJYMoZLT5oqzP26nZY2uXsYpvHU2PidCXbuxh3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099565; c=relaxed/simple;
	bh=lX/TzH4/QafPFGGxo51ul1J5Ag58ppzaU1w28VOvGZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ad2SjeXSbSQczkxcFbdrbFj9m/K/EUf50e0GdrRLkPAvIhZnLWghRr3XPfnLWgDMNxm/1MaYdY2RZFBbKrpWLXRzokC2g+8Zb2H6mz96SVMRQp0tvm6dopJmsI7JPDDL9yFrRyImURMSO08nDsICsuNV6g+r4Ktxm36g3+GL8uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hN3Q491D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TwMpkIKb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKBTgn026715;
	Mon, 19 Aug 2024 20:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Y0vJbaHtiujT9qw
	a0Z/2q1chZDJcYmodwzIOI3dvYaY=; b=hN3Q491DhwOx2R+qiygwTgLK05MkTGl
	CAS1kaIcPqgq2QS5d9QDnJol36R/XUjefyYBxLiANfY2fhmJ2owjPbijNJXkTp5Y
	OTcoRr+oGK43G7l52+UIgboggBYZ02KOhmZS7Cdy7wWYZEnhxd/450+JpyZJGlku
	y80Gh4l2HGtYKapgNtT6obcfxFcgFfzNsyOyyzg5Kx8INAMYr5LXwFNu6psm1EV1
	gqp7Gv3jXlUh67k1A1PT8KiDdWXRfS6TsQpCqv6xE6gNuDB33kAmxLYth/4DwMpN
	4/j6USfEnG71PvrTnl7ftK+EvueIogmO5tGXFdaj+TV9849hXAsmsOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dbjm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:32:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJn4Ke037711;
	Mon, 19 Aug 2024 20:32:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h5sm3mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/u4cq+tTo86M1omRHBDZoiUHUn8NzvIHGHiSlnPf6WvBnHCB+RCesdMNP6jDsHINySr1witspzZW30SDD0DsHTw9qMIwwOGTYNFdmAceSh+3O8A1IKHHVm1xXOW/LdQMzkeind9amZPA+kKeeBiZ7an7eTZX5OCXpVsULLO1nxpwqhQ94uhbcA63kKb2v/x0x6kfnsNKWgjfrGU3B2SIeYzQ0bETuOMMkUeX1x9RRu1XLDJH4JwEVw7dR0lEmCLYKDKD2UvPSi4ZFk4YFXssM/C8pWyoyNkSYCz/iqOpX53zGShtfvVunSeYJFEx82DULmEIERNwkGyaRvVBLFttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0vJbaHtiujT9qwa0Z/2q1chZDJcYmodwzIOI3dvYaY=;
 b=f7VABAzL90yCxojq6GlDCgsMEyKN+fZ0jreBd5tEDasbGtqDacD0X/3Q6OtXTIiw3X+nKmnLHzhfjkDoNoksLLyskHLtCfLeAyYmGvNy81UJeIugS9g4jfXY1xIEhihT3GgEV/QzO2tLLabzHMEVxoa1iVcb524V9LwOOdR2jLSnSQsJdfGV+Ad7X8eOl9t96oQZSldLzlwL8KJnBAmVnB0+Bv6NDocg4tGyVWwL5gY5ML+pzCjV3hCy5u3kE1sV6Xcdk7Hnk1fZmUSx1UoYJ8TgirowmTE7vhBrV7JjfscW4IRWxHQX/Vm+Bwf9HDXgp5/gfLe/B6IwGAmiQwzHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0vJbaHtiujT9qwa0Z/2q1chZDJcYmodwzIOI3dvYaY=;
 b=TwMpkIKbw3NFvaHfYgRwQXL7DcmMXjILTn04YhgDix25wYbjTJNGA4XCcNbrPmDjOulroiu2ji/n1slnyt7Ci7eUhV+dypDQALeRFCsliPpcP+HY0WapKOD28Ry2+pNsc0LqnIveu+wJHNdRmEryr3G+tUO3D76xtFjtOPXsZAY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB7001.namprd10.prod.outlook.com (2603:10b6:806:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 20:32:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 20:32:23 +0000
Date: Mon, 19 Aug 2024 16:32:21 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jeffxu@chromium.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 5/7] mseal: Replace can_modify_mm_madv with a vma
 variant
Message-ID: <d6mgudxhuayw2px2u7pusiaow4svgwjalkqr63alxljxvvexw3@un3f7twryoqn>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-5-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-5-d8d2e037df30@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: efd2693d-782f-4371-4183-08dcc08e0820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRCGoyv3iXBNdyO2bgE1B61nLQp60zyOkWh0VavRbTfA3tA87ot3RYb4PFHd?=
 =?us-ascii?Q?tDdgYzOydFDU3iXRod7siNz3jIuEb8DOB6FPnMfQnf8DT19Te5rmNBOpUcST?=
 =?us-ascii?Q?Yxb7jxXDp9l/yGSEvVYoa7GgxzDcUlxqdOcUxlVdC/84jQDMdRlvfkZig2iE?=
 =?us-ascii?Q?c7NObSaiLL+3fo7/P5BnvNSkmeW6nzG8Fs12hBXTjyBNfMImdoQw318Gae3f?=
 =?us-ascii?Q?DKRvA0nwd3xFNidklh8XkTx2oeIUFHxJk7Roix4KejvMm+2p9dFEtatN5vs1?=
 =?us-ascii?Q?aZLXM3dPjpj31NNLknV+mwp/5ZcZKp62An2vPE8FqpWZ9sw1UFaAx9CGZLH4?=
 =?us-ascii?Q?w50ctGkEF0lR/xK+i9PrVGmoj7Os+c9JzUXTrgKaSAGVxA/KVYaFTQqZhArx?=
 =?us-ascii?Q?UFhAzIwSM/8YMCLAtvclBxOzbk2/wzvsuzX4CeMiW7iX5zVThF+i6DtK880u?=
 =?us-ascii?Q?Nvzx6iURijas/1j1WLY5lvU6trUOQr0RyCNcpQp7qNZ1gfa84NCxE2dvGm/3?=
 =?us-ascii?Q?jUGUM53CFu/jaVxbutgr3bslbxKeoj1xxNfD6RRVn5IeBuPVRDK/pvhnBigl?=
 =?us-ascii?Q?onssekBtvMJrjoQO2Dopok4zTw8B2xO81GyM3FatRXd8wcAPT6be7CeZ7ZcY?=
 =?us-ascii?Q?ckWLJdSPB+/y1hnmRb/oWXboI4yNHCvlUNBmyLNXzqsOS7LbebQwwUJhFjwQ?=
 =?us-ascii?Q?Ux3K66qGwCQmM++MCA9o83er7hUcMjCntyr25NBz75bdZMdrNHNZI5P29ZAP?=
 =?us-ascii?Q?vRo5qc0A2fO5kA+t2HiR/TJTw+RDtyhK09Wf774kjauDRB4kSs6hpBz63xWf?=
 =?us-ascii?Q?5xk0rDxbjPLA6j8G/KehlGlrAN0UISjD2ewymTkDHwlKihidESioIOEqoN0d?=
 =?us-ascii?Q?2b1MHxOKdWnCDoABcxkEea95v9bO9lkQ4WZ+uQdMl3Qn49v9yFw4XHQ2NNId?=
 =?us-ascii?Q?FruCJJLO4wTsoHqAhX8pEvvKYTlvXpVtyyKIcZ9mXn0RRzOx/1pYr2gTB5um?=
 =?us-ascii?Q?Q07Sy8cZlV5Wo+jtLY7wOUEyABLFCo4sjv8O7H4sfgyfOeYJcJVFOII9n/Rt?=
 =?us-ascii?Q?dPDMTtPFJNreI3aBAg039Isa27dkH64/kZMnHb6/fLuHn6fbwhUt8dT2hV85?=
 =?us-ascii?Q?byjJp+wMz0gpm/H7nwLvNrV32Hu6LglmraWI4Z108ew6MqvwFOLAw2u8XuI6?=
 =?us-ascii?Q?Snugg8Ol/gAOky5+QthmJ1L/ZqG/l8OoSzuwCmnMmAhtHi5z7PYJmINpjm70?=
 =?us-ascii?Q?8iDq9ngSiMiYaiW6gLrjSTFOZYBIfrEr6kpL5Hmag7g/LhJy0UxXRET/a33E?=
 =?us-ascii?Q?qflymI6vbdpXn9NYgALN0WtJ5/Rn7Th6NcWeS2OfUbb72A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpNXd9CetEugTx2CiuqftzVdQSkJw1Vg0Wjl/UtNOKEb6dYh4VZ3lcukAsRr?=
 =?us-ascii?Q?LocyMzJQXtK51kKb37t+QgJi/ie/potTyWcg+oMwILSk4bnA5oq86kzi+79P?=
 =?us-ascii?Q?jrLu/W0wAZqTsIQuP9xto4T9vWe7l1HBXY0Wu8XDpqm45NaYcV4tfIKLKioQ?=
 =?us-ascii?Q?O72HYlj4LzZshzD7F9IaygLTpvegMDGwSOnjqJXiCmiFsYhe4EvykzmUahuW?=
 =?us-ascii?Q?l6fFRXLIAKd0CYU8hqiJ8gJzKQ4C0A6cCVIEGk3TlixeddhfWaw+Rj/m5soU?=
 =?us-ascii?Q?/jhb+14xn5AUIDI82+bvcnNFzFJsy2Yh9e6pcqDjTpLjCGdllJp20cib3bdg?=
 =?us-ascii?Q?JpRBCK211jzGtgHHV90PC39bFugylQE1xu3F98NcUxBx1ZHU3xDCtkuzgqAg?=
 =?us-ascii?Q?xgDYnEzjK1VSbIWmrcJxzNEl7xwfcZZtfElKvc1/frc8v4EobErIuDCIR9zA?=
 =?us-ascii?Q?7Jy0sfln5TsR9gNKdXn3XyYySTf+OPb75oITdS+yLj94hWIe7NVJDqwzchvx?=
 =?us-ascii?Q?op+xTW88pHKE5l0im8ASGwAnAfJa+Bzn8FuHwYTRAHrZfp9GCDDk1A7P4oQl?=
 =?us-ascii?Q?+JTpOzOtwDrACl/QjV7yVkNbCwpIG4at7AMnbkEVESiXqJq374awteoxHwZD?=
 =?us-ascii?Q?gfXLqxeoA9QxSPivl3qJN3HuzftAH4PFmjPo5Tqr+0kAOkcCBxloC/qN/do0?=
 =?us-ascii?Q?MIQnqXMpQd7YutNEN+R3nMgi1TjiPCkFUYFUtKqEGHiUUZRblVOS/OJkZ1Jl?=
 =?us-ascii?Q?g2vd/uq2OXkAwmHzb3cSPdzQd0hGg+jYTxE5NSlVq3r1Inw43j2jVvtpFQlW?=
 =?us-ascii?Q?pGOUaYeMB+FiqbuIETS2PydJrW6Knv3u6lZX9S8gZXGhaSHDAuiG7DXHx8eX?=
 =?us-ascii?Q?mao+3tNn/dGw5FqX/1VSqA3vsKLltClgZYNzEEh7a7DI9DH8muwoZzvg7hRa?=
 =?us-ascii?Q?1UwUtENBVlT1hwV44X/6S0ZKapZnbts+OU2qQaDersiFlu/Dn2xG0NGunm7g?=
 =?us-ascii?Q?hu4SyNfHom8V06bzcrXcHoUr1p1kY5SKeJiK6csAvBUL1sSO/R4Id7BHSEZc?=
 =?us-ascii?Q?l03hA2jkD4O717Tggs4YDuDVCKlR9TisjECJnOE/JpOPgVE5lqL+PxEAhe36?=
 =?us-ascii?Q?f8Pw8noBIJJGngOdc9EwXdng6V4kkyqfDLX1BHeZbdcn+/cogYAUTuC0pZUp?=
 =?us-ascii?Q?WZz/FzkPHUMCzFYtdM2qQnF7+kbeLsrPE0T8r7RwR1DY8JoLafnmCbWE2sdd?=
 =?us-ascii?Q?4WTh/ugUAVX1DEv6alLxXN9CKqy6YVnaW/Gxq20JQoBIJtERcucVLlDtuQYP?=
 =?us-ascii?Q?9Sjs5joH3KVBOHFLMqTjXNfuXygzcvXdVnVJJT6JV+DY5/bN8NPuuPdOQ2R5?=
 =?us-ascii?Q?gZ0IYGnZls9qA69Sp12muyA+F6xAEiug+P7VpOD6RBB/0Sk4DJfnslmA8hRF?=
 =?us-ascii?Q?HllkD5xiz1iBJ5ijkajdKU9V29j0NHkgLms13/x8gAZUzEA5hHVF4UlA6VCc?=
 =?us-ascii?Q?2TnJYY0Rc6TUH/+tzQTF0/x5IxE/k20aFwNHieKw6KNp5TuBgVUztDbQDxJ+?=
 =?us-ascii?Q?u8qLeR+WdY+qE/QhIYJrMWrs1UHv+c6YjcoravyO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2FvD9tCQxLseg7VZmkFu5ONV3i77vyCwmYDT20P6mI3kT2NKW/C5pzXuxRoEjErf1eKqzGPj7N1EVPiP+THgIAP44LWwg3qVq597vTSa1mHyL9kwFmU8l2mhXDrcE2Q9KfP96P0jUhkdnQUQ3JcfpDVoJ2lgyfah6czxOp95wyI/9kQkgCgKsbtPjeE1vMcKPh/3/HcydhEKlJs8uB7LcgvxTTmEqNljUvj/wX9NVv0ILd1vl57GGCdofiy9dkN4d39rer8TQqtVDMKvB7SSv6AoZuAgoI9lNpyXf8f4TJS1jmGsjJhUCPDKSEs087bW51GtJ5D3gZPZdn8r3a8w3zs6UYAkovVmCwV1aLVwG51ybYSS43aaJ5pMQmoe9ZPW9MB2wQkCM8Vs5gbuKSXY8B6iNK5gedELhmX+ZHKYHRYRehvB1U4PjgdHD80GWFi1WDNucllGjHnQF90DqhBPFW7TWfcc4fizAkBX/z3L/SvSPDU7S//8WtADpZeAojcvutLLo/tJRIV4GUlNKSzNzQ+AA51aoYLVIgGr86o/p6F4DkWI87cnd7Dn+sTaTHOcJ/QGfmFzBg0YRk4vaTvgr/B0DKs6Gtki5TTqPCK4YJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd2693d-782f-4371-4183-08dcc08e0820
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:32:23.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJBd4LJDkGSNIt+/tw1CT6Y0Yyx8pPXJNv2bWzxacH2sfcqbsy50a9FjuxTxD21etlrpzkDgplRxr0s1vSIMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=621 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190139
X-Proofpoint-GUID: 2r8emv_JLM2-5iCc_rPhYnQpLdxZvD9W
X-Proofpoint-ORIG-GUID: 2r8emv_JLM2-5iCc_rPhYnQpLdxZvD9W

* Pedro Falcato <pedro.falcato@gmail.com> [240816 20:18]:
> Replace can_modify_mm_madv() with a single vma variant, and associated
> checks in madvise.
> 
> While we're at it, also invert the order of checks in:
>  if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma))
> 
> Checking if we can modify the vma itself (through vm_flags) is
> certainly cheaper than is_ro_anon() due to arch_vma_access_permitted()
> looking at e.g pkeys registers (with extra branches) in some
> architectures.
> 
> This patch allows for partial madvise success when finding a sealed VMA,
> which historically has been allowed in Linux.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/internal.h |  2 --
>  mm/madvise.c  | 13 +++----------
>  mm/mseal.c    | 17 ++++-------------
>  mm/vma.h      |  7 +++++++
>  4 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index ca422aede342..1db320650539 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h:q!
> @@ -1363,8 +1363,6 @@ static inline int can_do_mseal(unsigned long flags)
>  
>  bool can_modify_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end);
> -bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> -		unsigned long end, int behavior);
>  #else
>  static inline int can_do_mseal(unsigned long flags)
>  {
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 89089d84f8df..4e64770be16c 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1031,6 +1031,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  	struct anon_vma_name *anon_name;
>  	unsigned long new_flags = vma->vm_flags;
>  
> +	if (unlikely(!can_modify_vma_madv(vma, behavior)))
> +		return -EPERM;
> +
>  	switch (behavior) {
>  	case MADV_REMOVE:
>  		return madvise_remove(vma, prev, start, end);
> @@ -1448,15 +1451,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	start = untagged_addr_remote(mm, start);
>  	end = start + len;
>  
> -	/*
> -	 * Check if the address range is sealed for do_madvise().
> -	 * can_modify_mm_madv assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm_madv(mm, start, end, behavior))) {
> -		error = -EPERM;
> -		goto out;
> -	}
> -
>  	blk_start_plug(&plug);
>  	switch (behavior) {
>  	case MADV_POPULATE_READ:
> @@ -1470,7 +1464,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	}
>  	blk_finish_plug(&plug);
>  
> -out:
>  	if (write)
>  		mmap_write_unlock(mm);
>  	else
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 2170e2139ca0..fdd1666344fa 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -75,24 +75,15 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
>  }
>  
>  /*
> - * Check if the vmas of a memory range are allowed to be modified by madvise.
> - * the memory ranger can have a gap (unallocated memory).
> - * return true, if it is allowed.
> + * Check if a vma is allowed to be modified by madvise.
>   */
> -bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long end,
> -		int behavior)
> +bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
>  {
> -	struct vm_area_struct *vma;
> -
> -	VMA_ITERATOR(vmi, mm, start);
> -
>  	if (!is_madv_discard(behavior))
>  		return true;
>  
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end)
> -		if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma)))
> -			return false;
> +	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> +		return false;
>  
>  	/* Allow by default. */
>  	return true;
> diff --git a/mm/vma.h b/mm/vma.h
> index e979015cc7fc..da31d0f62157 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -380,6 +380,8 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  	return true;
>  }
>  
> +bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
> +
>  #else
>  
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
> @@ -387,6 +389,11 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  	return true;
>  }
>  
> +static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
> +{
> +	return true;
> +}
> +
>  #endif
>  
>  #endif	/* __MM_VMA_H */
> 
> -- 
> 2.46.0
> 

