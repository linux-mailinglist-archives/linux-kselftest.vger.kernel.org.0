Return-Path: <linux-kselftest+bounces-49345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2075D3A667
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B433230B1B46
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408373590B2;
	Mon, 19 Jan 2026 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AeLCVkil";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GXrhLVn0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2C3590CA;
	Mon, 19 Jan 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820805; cv=fail; b=X/hmahBW1SjNpsGZXX9JLG2UqzJTtpcG1Gs0LfhugufF9h/MHqYBYXg1LBxUsHP+q+GnmmO7s/vnoU5/H3wwu3JUb3GjmRdLsUQFEoT47vGOl519KzYYi/d6V4l5DNaL04gLcqckAg3uf3QnV6sB5YWr2HkBV7XlBxfJJhW9aQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820805; c=relaxed/simple;
	bh=JWBWF2ueEVt5O12KUXksSZY8Lncslrt5+d+mBiL9bdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mS2+Agdv8cIeP5wyXknnX3bmRhlJZW3PIW0s/QN15avKgHgFq+eUop7oIAjxzIXec/JyE1qrxk9JLNID64ZDUkmOhcGZ+v9WAzLJlcbNpA23B3FjZIqcUmkD4Dq1RfhcrssdF10Fj5Ue2jEJZJ5r6yvhE32c7Fs2fyFNCnnDKeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AeLCVkil; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GXrhLVn0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J3IJQi270916;
	Mon, 19 Jan 2026 11:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JWBWF2ueEVt5O12KUX
	ksSZY8Lncslrt5+d+mBiL9bdI=; b=AeLCVkilQcuHEHJI0F81XW94N4r4jw7+VQ
	bGHY5cNzf75rXGR2gwDqiKMdTqaXDwWxybixZ0uF0i2SpfgXbrjB973S8kbEstVn
	kXGa4SCFPCWLLaRiDYABIyb6nZcZ7KooYLW5m6X+1X3hVhVBJ4UOLnRZ3/7C6Bqj
	XgqI5IVye9nGctu7ill8PF38pJe+nGVcrUVQmZ+gbNZ31zl742Xv4px1E4UNcozM
	d/Iu+tHWriv3NhsSYP6O358vgll7abn3UNw0Imzt/kGKqD+C+eqWMccfjC9dzhXk
	681B7m78QET48kvFT+rSbpwnKQ6JDYDOKtcRGJ6Cgwb33GqniADQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypt190-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:06:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J8rkkd037782;
	Mon, 19 Jan 2026 11:06:30 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v87rmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia3QyEsDSUKURUu7Gfvs3PoVxfS39GZSNW3rUaVxh2DsCgeJqWh4wycjBRRyPy7sgM2QeSFrUxDtTpE9lz4lwT/5XHaW970P30vzI+KpNz+9t2cFcidh0vlPFWBAGLGh8qssyaeLWFebJWWJESkxGIcvpVmFl9wAiPls4L9xqmJPnCeeHsIeBuJ5F4F4sxaPYoThG8C7ok4p76LEaw3aZpcQo0FnmtAq9VDmpkukWRrXVoPuqQAfH1RwCLk/bRJH9R0w7f5/qFxhBpaCUWITWQ+AkiCs1bWRC1zDsFD0ySgi6Eu9fPn52w0KHVB+1yB8iM3atTKzEStF2fbXSW4ZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWBWF2ueEVt5O12KUXksSZY8Lncslrt5+d+mBiL9bdI=;
 b=Y8kA6Bv+lfFYS0p0hW9ndSUsOmV4uo0l+s9LitKF+XQkeoL3S7zZdKsONGR6ivrIOskkgr4OMILGOlwjStrSFBQE5At77aq4euPhNaFNkaMUTPgLKEy+pPsUKvbXee3XfhNYkUOMHOWzpctaDHbJPhOgeeHhnDcdR/+UnX7faQPxlt35N/EILb0gHldM7UaHMu1af8MiKVKKiIpmeI/XyKLQ1wKgI3/7KmywQOoJNsa2T2DCrNSN2ZiThhH8N9GG34gMnOv6MA+x36AME5CyVjxduNwa/AgKg21Y2qBzpJAuim3lhzDniY+My3J8PNTyRZ3sGcgD2YK8aaMUoW3jIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWBWF2ueEVt5O12KUXksSZY8Lncslrt5+d+mBiL9bdI=;
 b=GXrhLVn0WCyy1XSiBlPSyrI+F+ZI0YFmzojP30D0x4CYzqgktK1gKlVo8/aLw1B3tbrW1NUs+17N/GTCjpkQiBSbdNfktIwATaH8jJpyyJnWZjNBJrR7Q3eOwPW/9VYJSQio+LtZuyODQWFXsO2KbYmQP3AjgZNs8R5aS5wKr4Y=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CYYPR10MB7649.namprd10.prod.outlook.com (2603:10b6:930:c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:06:27 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 11:06:27 +0000
Date: Mon, 19 Jan 2026 11:06:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
Message-ID: <79d2636a-bb15-4c7f-a633-c4bf408a2bc8@lucifer.local>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <3d2e85ed-f072-4fca-8c22-461b001495c1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2e85ed-f072-4fca-8c22-461b001495c1@kernel.org>
X-ClientProxiedBy: LO0P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CYYPR10MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb28910-60e1-4df6-d10d-08de574acad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3epN4EzQ+DmloE+ZVmS6+Pwg1/c0LYM6MktocO9gRzdP8eBrPXouqrdyF5Fg?=
 =?us-ascii?Q?eNLwKdCJi3T1kLiTfWWz+N6tWptKcEcchoKbdeHIQIaZLwUBCfgo++naLRdS?=
 =?us-ascii?Q?J24ID9t8NYr23Ee7rXCdMiWfyn28q+jn+bR3Q3f7x5mvnhoQtXhithrXy+kh?=
 =?us-ascii?Q?lvxT1+V2nBGv/wxCE2GSX9iKhVq1ye71GzwlCZtaeyYV6oLeNREGNpOCz23v?=
 =?us-ascii?Q?RAdXezxlUDMR66eUX9IkH0dMRYOX8j62XS6+uDsi7jYitcCrQ3hzOXoxlCgo?=
 =?us-ascii?Q?tjbhH4lUhLzQ9W7RlzdUbGnJwnKwZqb78zEPrhhSaW9Ge+jEQkYFxkuMooE0?=
 =?us-ascii?Q?liGPQ0JfcGSdxhwqgARMFwuQrwDuEwNAbeAFyWfTU6wjvOcRh/Qtn7zP8Ke6?=
 =?us-ascii?Q?izMz9Jlp0lbpWKzUYbTbqk4Hdnxx4gG2G9nKsGh3VM18ISlWtlgabamSDkzt?=
 =?us-ascii?Q?/+xDD6yTPk0aDsnCxf2CnvNEEZnV/+sjphttAlDnTeuq44QeVwC+7piru/yr?=
 =?us-ascii?Q?0dq8IkTaOGBqr/qE0EmnhPO61YWqavFX+HtNtoRcImIzKghI2H7W/rrFxIy6?=
 =?us-ascii?Q?7XK50hf9iTLl3c6DO+FP0pQPZjmNr1/Q+UsJiEqOOsyB6NZSlSWXytk35jsE?=
 =?us-ascii?Q?1ZUlnTVmkUFDndFF3WzrZpzlJSVC0xaoiWKUJUshNa1WuWXCVsmrJD/DvWU1?=
 =?us-ascii?Q?D8y9aew4j535PjEJb5pQJg5zU/yuwOPmM5i719sXxfXE8SI1G/3DbzHMBd+Y?=
 =?us-ascii?Q?667EY5E6/CMFCmX5wmsi6aTFxjutJa61ymQZKwPO42isZMyUor5OLR91oHOu?=
 =?us-ascii?Q?KJVpTsB6OU9vDCXPRY+9Tj04bresiPCJ72NGmy0d5tl+OEs3KCM7O6m90GEh?=
 =?us-ascii?Q?nbLlYkzWmOZ/iLInUz3gnmhpv05xfmQ6u3jgkyZbGY4VpatEnLm+1+G4bRYO?=
 =?us-ascii?Q?nyVPS+zEkRQCv9QYny0djViXw68V0u3JGZT8flYcvEvp+dirG0QYcOPTbrKm?=
 =?us-ascii?Q?D3K9pSSTdA2Ck5m9bK2colGl1aIkOi+Foxt8J3/mJy2vqZcp9koKk2yvX28i?=
 =?us-ascii?Q?zQpVt4gjG2tK/nO5JGAHdMFC9rU9mmebi64+ZYUf45rw/esF70lcwSBknSx8?=
 =?us-ascii?Q?XZ/c7il+So6bqRI8PO3mDUMKdLhHpjNcR1ZcNTOdVfuZe1SR6l4J+Co7p7s5?=
 =?us-ascii?Q?zg06jvzwMFA5xUy5yvpFTrJnkgi/OmeZaMAJnihQW33dB1rt6s8TOzHqvuvk?=
 =?us-ascii?Q?PgnoP8JXT/IjEkLgluntFhfBpHei8up9kkvc8+qDwzaMDuKIVYR/qB1n8R+B?=
 =?us-ascii?Q?tCEoFqU9NWAxds0JQ8BU9PDSPHSWWMubFbr87EF7uYz8FeaQdXqEWqBlGj1G?=
 =?us-ascii?Q?M6A3N9JR3+1OLtTOnKKg3OaIgvirqpiPOBo/hljA09Jjo57JBSDOYuh0C48w?=
 =?us-ascii?Q?P+POxE9Gw7D2T8Fopoiy8U4VFgnGgw8ThisvS1NmqAUcwwEzLCkppoqNX+0p?=
 =?us-ascii?Q?eugrczPSdf1p9Xrsy+rC/PN0cc/T7prRCERTlbvGgczPA8vrSa0oj8IPeQvi?=
 =?us-ascii?Q?1be4zZ6RUNRypS8kMSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jd/AhKJHh3JNZLtjWP1pqtQ1ffjhQOgrIVStIf6PynZyCdvO4Z2ipk6aRkHi?=
 =?us-ascii?Q?0oNQPHdkudu5WAZLiDrvJIcAtaULeMJe4CRlzZ0zRilmRLB0Zw8OzhfALyYl?=
 =?us-ascii?Q?o5aC6EDVnp025odGnAt2GDrC+qwlRYZa3G2FQjFAgbV/st4A/SP5Ds/KwlMU?=
 =?us-ascii?Q?KBYvvC4UPA43WnPBMSx7JNv8CJ5iNc8LZ361dN53dY8g3DJBe0aXWiNaWjIC?=
 =?us-ascii?Q?8ll3wC1FiNHu0auo+i/mmJonyArRWkSoaqai8tyxJL/xhRvJb1ku7QZelmY8?=
 =?us-ascii?Q?FmiPpXFgbcBUIjdLc/540pciicCfuWWyji6P3sfkF3pfhQFYg8ArRnIo8nGr?=
 =?us-ascii?Q?FtPoA0N5VDFKQJx0S9V7H7v9oWZV5AVThpqquAc+53zHml/rLzeZOxvRMbBT?=
 =?us-ascii?Q?OGxhOuE6KNQerkk9xlFRvBf1uveRYdWk7+gX7tPsVbIwOoCSwafsL5iaRKLK?=
 =?us-ascii?Q?Hb0uv3720ySma/I3eE+41iPyUAl5PVbQVl8tdY7d2jYayN05bJKxa0VhT1C3?=
 =?us-ascii?Q?w4ZR4d7SVLm1DzMryWKyKtMht/hCXHjYZdGNw1jgxAYld6NO0k/Z2Njm9CPg?=
 =?us-ascii?Q?08UbYizr/Zma6J2kzr7uPVsYTx4OaQbs3A45y+9JOkt5det6qM4lTDDun0A3?=
 =?us-ascii?Q?zpxMtEKC1tO0t7x6cjQUceCHEUQAniVe+GhzieA5gxQN9EtYkuXnJzKAArL7?=
 =?us-ascii?Q?ubPk5qToev8mrKVPLPEZWn6VSapgrJ14G41MBan77xedR+CU/R53VJXwteTC?=
 =?us-ascii?Q?h0aHqqLOFfOnO2Ry62UEnM/RBJ1MKcFwI3qvRybve1nnhhOakpDRZywsZ7t+?=
 =?us-ascii?Q?DADv9be4WMV2DrLTO1N5Jcb8qEDAc1VSvURTdlWAvy8j6eWhY/RF2bmWIOvs?=
 =?us-ascii?Q?Uz8tfbRfS383367nj9h9Xzk/uTJIF6HoDiO/qRJfxKkkOp9gZo7qvfgkC3KP?=
 =?us-ascii?Q?TvfdgV5jR29KjKAOtWJC0877JweL9xGgocuaNbICFzH2I3/vber2VgO6Eh5k?=
 =?us-ascii?Q?UiMcLJNmmmCUea7gqrnxC6sW0T3tZzr4eSSjm9GRBvLanl103Vqyk0bAvPU3?=
 =?us-ascii?Q?69aCdBy8v+vRFVNfhjFPnUrcpvFaFDoy/DIUTifw7GU8mTL7HvW+AnHDhVWg?=
 =?us-ascii?Q?ATgy9GgJXai4w5IOH/RaJo4YOY4UpRxve6SDrklfA7xZrOsMKLBtV3g+xUCE?=
 =?us-ascii?Q?TcikjAg+OphYGhNYqckQdVNifRi396+eLVQXAswq7Ng8NI2/kXnsTcjh1dl5?=
 =?us-ascii?Q?+Mt0C7PxyPyErmxnhUeoJR3DCgbTJiKa8hKKVjqaSmsFK47XXczRLd+BO2JS?=
 =?us-ascii?Q?MO2deFbGG76S6EtAlKhS23Lvs/hadUTxMVUcDaoHlceHA1Bi+jBQzBppmjDe?=
 =?us-ascii?Q?5r2bewx4WcGlqo3sC3zUPdpnP8R9jKJEcwDin+sj0focLy34aXcf/9Y6s5Zc?=
 =?us-ascii?Q?ndZl9DjhK22c0eYAM0FcEZfC34MBEsNTIA2WrgwDhW70UBmL0mXlSxk1WuSm?=
 =?us-ascii?Q?H440dNuxHX228r9Mza+U7NMtBg15O+sRXtxNXe8jBxyaRywufMKEftnCUZvQ?=
 =?us-ascii?Q?Eb4bqOk/6vlVM8o7UCI3CzElnA4noE0DRVeiKpfT4zmorx9+pKNfvFaEpiwy?=
 =?us-ascii?Q?qjWxj69xq2xkaolOWamRvhgFT9QPCZlyKfBmxOamG3ZLyxyhEs5qwhzeojx0?=
 =?us-ascii?Q?jv1Z7iWZM+mLRJCQR/p5+rb6RzTs/8gwdBTEb4xco9CvfM8zUnmiwGlEGmTb?=
 =?us-ascii?Q?E3CTCMF6TertoCj5eZFxY143ZUiv1WM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SaEHQTRfTx8RIblEpG76WHuAMkhUVC/EP8N+fHJqX08xj7cMecGQNYx9My8HoMTfXJWqfVr7aGjtg84lN8hOrzQjtxxSARFu2pzCzBgTPZpneWjHaDKsR71TYEUD/Zj9WLSsHOgnFIHpPcNMO5I3XT+AAiscrRmEkTYtgoRHRa0nSrgV+3EzC4jrbUPUBiwQjvX54nudZ8OgakGAUPTHDZQdRaSoMRXru53DaPm2ZJVI8vNp7FadYUoFC0z/iFYI7AcNBiwhE9WTR/FkdTxuSCigLgw+9C5jpIEYd0/NL+/5/XVa3/YJPG44pczCvkFQxXTf+Oej1Yw42B+DpdiybXudvNzbPEetkzAUPQrGwlEgPhgAulohmqDLCbwuat0qSoIbQB06d0aqhrNRJqYJpEAy9qJge+N6ghwNTE4Bf7P0Ct/KD4q0PcSxFkDrDwhBWkYUv2tQ9jJFIBoADgOR0KSIGusp/NsgdupiLHeZnwPfospE7mZ2M1E1/eNnwLWJ4uzH9i3NBSmgqqY/LIBkQd8ojyLBdBCxoEBiPg3AsHySyqxosVQZbrQDWlMjFbOnQzZdOFpSevwdAhu0gARlFHb9PyzC3zW4ClZ3S5m+6c4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb28910-60e1-4df6-d10d-08de574acad3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:06:27.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T3pwV1K0BeXSpsEEbDtlM8TIkyhOv0rYXBivP2LmZxIx+9lnbX2SikOinAzIBkUT0OUErZdMHz+JWwPuHfPMN/oeuHG3b+aNhBTIpYQTQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MiBTYWx0ZWRfX3DliQHEq0d/a
 DyrIHhfBXgDcc8HiEsYPoqqoDDgySLdlI0xEpmom5wZXAKdXiXWHi9PYMFjnEzzcS+ecxmm+ajW
 +QuGmkHGQXdjEtNkdhuhikZesBlXD4RB9vS050HYzVmVF3I0qvM+7SA1AuGjY7MlMMMg37PS5Ie
 8cAXJAGPITVAXHlwSv9pN7zVKx8EAK9ad6PimUG2K7A1bk+z2XKg0lqE7UdEOOrVoxjkYa9qyTW
 TsOqkK02RF8YwzUSpAgUVLblR38z/8F7HkeZaAk2ALC9fHbi47WJgcCCTEZ34FjE6OdrClguQa1
 NihblX2yS0Z9NoyWbTOZ7Lndzzuq4++C17mux+3qMeIukBnXCWJcmnbM1/ESMOlFe3y25mKE1eX
 rBOslev2K2B+CuMcArS47IlLfegtcmPPi5H7zeG8ue+zlz7fNukmIJdaj0yebdkJPyf2e19SgGf
 xIHAlGofpOueSW11vCw==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696e1036 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7XmmSyV8Pj3IE5G_uLYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _fHB951UYcSekKH--4M9Ku05zmQwNRAZ
X-Proofpoint-GUID: _fHB951UYcSekKH--4M9Ku05zmQwNRAZ

On Mon, Jan 19, 2026 at 11:39:51AM +0100, David Hildenbrand (Red Hat) wrote:
> On
>
> $ uname -r
> 6.18.4-200.fc43.x86_64
>
> I am getting
>
> $ ./va_high_addr_switch
> mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d7000 - OK
> mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7fe7de6d6000 - OK
> mmap(addr_switch_hint, pagesize): 0x7fe7de6d7000 - OK
> mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
> mmap(NULL): 0x7fe7de6d5000 - OK
> mmap(low_addr): 0x40000000 - OK
> mmap(high_addr): 0x7fe7de6d5000 - OK
> mmap(high_addr) again: 0x7fe7de6d3000 - OK
> mmap(high_addr, MAP_FIXED): 0xffffffffffffffff - FAILED
> mmap(-1): 0x7fe7de6d1000 - OK
> mmap(-1) again: 0x7fe7de6cf000 - OK
> mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d0000 - OK
> mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7fe7de6cf000 - OK
> mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7fe7de6cd000 - OK
> mmap(addr_switch_hint, pagesize): 0x7fe7de6cc000 - OK
> mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
>
>
> Are these the same issues you see?

No, that's entirely separate bug it seems :)

Seems to work locally for me on 6.18.3, and also in VM with tip mm-unstable,
strange.

The issue here is with virtual_address_space.c which seems to just to be
generally broken, I couldn't even bisect to a working one, and I really did
try.

Actually hang on, isn't va_high_addr_space already then testing what
virtual_address_space should be testing anyway if it were sensible??

That suggests then that just removing virtual_address_space without
replacement (since this already exists) is the right way (...!)

Thanks, Lorenzo

