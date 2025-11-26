Return-Path: <linux-kselftest+bounces-46518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C3C8A98A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A957A4E47EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35733031B;
	Wed, 26 Nov 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FUz2Uqpo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TypWHlxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173F330B15;
	Wed, 26 Nov 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170387; cv=fail; b=VSSpnBIFsOf8ecn2HAPICwA5GGQLN5eKZzq8Z7UC0mNe76eFB7MojYLk9zSlaO1Ps99NyE4NkyBsjNPm7CsItqDeKicR96e60dNDveXKIRfLC/A9vOyni86XAkpgJWzFge5mtfoWMnhK01JO8n7Ni+FDCKRnhW265kGbTK0i4Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170387; c=relaxed/simple;
	bh=6ft0iRufNRQlGhsLlzMcek4Z3XzeKq680VYvEKybU7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bmY2gTeSV6ZXj+meBGqJ7eS+0ZwoiqkXhO3nMCwsbGGTAb5XVdKFE/VUn5QCHh2DuZmPSlhy9xqHtyRTlF2wLLHT0//CfemiBdeKl8zEM6nbqKduOgY1NBvLIASX0Rh5HuQWkCGeMDIApSXOMGdekUNIK/vzyOttwR9ig5rLZPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FUz2Uqpo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TypWHlxd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQEuJJO2490204;
	Wed, 26 Nov 2025 15:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=R42FIAkLGdR1K1BQo5
	C7P2o8fVDmpFXXGaAxZTw+YXA=; b=FUz2Uqpom7rjzQVgPUwJ/VJ8XgP7YnduSe
	Hwrmw3afFfUAmelaNh0fux4+JmxGHd035aGHkBOQUc+VORZ3i+KuUGV9Fh4VPrPf
	JVxSXTtLfat5nZVrbtRwCE5HwYjX+h1RHhlRfnk6707hN360rVFiLPJP7BgcN5Ac
	onEm9poLCulG/6KEds8IVDegHXARwbX9caePuy2TM8Y2mDxZdZxxMi86o7tYo79D
	UrcdCpcPH/rdIP/Aoxn2Ov1Kt8yakWS/grCP0sE5sS31n8sAjw46WAptAia+7gil
	fPCwlVvL5MUrsUTZ7pZz1ObiRmG7vmTZxa3VaGYXzKZHa/3QEeYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak811vbkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:19:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQEK5o0029761;
	Wed, 26 Nov 2025 15:19:14 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3menbpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBz8NrOsx1fkj62ldrBnmRRhZXJOOkHHexCVIcPpfSMLezQhHqsQ6xyuKG94KyVjiOPKgepphJFOeiLloZ6sHh8mlf9cdB2seZJ1/dmDSdwmGTywQHb6SLX0EXwc+CTAbfvyG5MdC27R5pzQl3LbynmVE+paZwb0286N/i0mIr5hTKiBcreK4Y68DIJO1USbKf+D9SlhNJCo7kqFw/lnHSrQhE4OddbfW1+52JPI5j3wQ/8g//SN+64GjoxkGIWNHsFaGYhdW6UUDzjID1hSf3eeMNZpUcLEqbdR6BR58OPwakemp6nLTRuQoJmMs83Ca9cTNmi9GOCGnVXqxM2Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R42FIAkLGdR1K1BQo5C7P2o8fVDmpFXXGaAxZTw+YXA=;
 b=stmINL9Xe3PwCqUdCfE/wIYMUxBitwv6dEbRwCEgv4LCY21fWbkvEgGji/XkgTOjEhKedFanGakO0EtBcAz0RfFTe1jTkknobqu/1OVKiQunAd66/qjjNtDoyfxAonAoPWnWHYukUDSaEFRMC2S9p81ABJesHpW8rJbiBUEGLkbaj7MuGhxrnDt8IXZ9mrYDQFoDPFn7Die4nMwIk/wehWJJXiZ4qE4xEhWb5hHUKq/3xPzx1qbnRAxOcFpdPJjZ+6A+AFCPcktPdwWnEEaHuZ2KfH7MbiLzv2H82JbMp+5VGn49Ujv9aOrnZDs5C0fGCn4CWaC3XFFEXzVvaSKI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R42FIAkLGdR1K1BQo5C7P2o8fVDmpFXXGaAxZTw+YXA=;
 b=TypWHlxdaiRKnQHnWfeJdSdnLDDGo3GrhkDDCw8pmgI3yQTuHBxsXtmD+TK+9r/1SCr8xLo9475KdYuzFZ7fGvfIasJqagupiw+DG3hXr/J8lDVkiQEgTuxbkpBzNsZyLZpIxBg7CLwz1JCPLdShf3IjtDLNDxWIaoQLdxdHPWQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 15:19:12 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:19:12 +0000
Date: Wed, 26 Nov 2025 10:19:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH v2 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Message-ID: <q6k7ukgwmne6kaitupkf2cv5dlmr62qoedne7mzknbjdivpr6i@gah5trw4eqiy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, James Houghton <jthoughton@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Xu <peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David Hildenbrand (Red Hat)" <david@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-4-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125183840.2368510-4-rppt@kernel.org>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d32e015-f799-4554-646c-08de2cff274b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5b1sjUxitceq2Z8/ktvrmoQgUfQULa4qa0jWS+KYEVqec0zRFQjomfMTId3g?=
 =?us-ascii?Q?qIPshNMwQJtPk4dG3Enf7YdRcLX3xSLvIyIWh7COUmpdZMx3/hmTJVJ5z20E?=
 =?us-ascii?Q?ZUZLclwaRFEoG7moBwz4ekuURrUHcvzDUIroLk5mKfreI+mJFyEzNuW6hioe?=
 =?us-ascii?Q?iZ5k0cBospw7oPMiCsQWm+PnS99v7zhxZfpkeRsbp01Xkl2EmoPSTNhsJHOM?=
 =?us-ascii?Q?xt5h85q+/RV0ANbXkXovMCGfDYczTg0mijpHtjWLgL/4urxwV0WFk51m5ixk?=
 =?us-ascii?Q?NrOolo6cfzHtx3DlZz9kzLOnpmcDYI47dzHhn64NMk7z86OoCeBUGk9Csgzc?=
 =?us-ascii?Q?ZVUQeVMLZtX6KMTBqUuiXXrDooeOFeDPTbcKMwulwgA/TtzsB3r5WqmWnx2z?=
 =?us-ascii?Q?fN3B/BtG0qOxyPZ5V841m4x1Hgo9dcJ6lqxdZyIqA4Uczz1NTRsvWLMwj7xH?=
 =?us-ascii?Q?wzOkaNjGdBltHJRRfzTvu9y45OGGWg7A2a/EF0GRe+Y9oAKx0mYZ+WpHDo5/?=
 =?us-ascii?Q?qmH/4SVUCWkU1dIcgdE87cb64OP+QYZ+Ed+leKwscL17NTTAt+9LbME0BCBr?=
 =?us-ascii?Q?ubQenqi4YWobpUE3FXpRqHa3IhKAQ6KMhppzMkgW9cfKZVQCABci+VdnAXGe?=
 =?us-ascii?Q?u0Mwm5n0Qk+BhLuDTWP79BLJfce0CM0WElbNpdwrl9NI7rRxNDIYf4oL3BDo?=
 =?us-ascii?Q?KDO3BWxjL/L3I7tVG+lnIEahtcUQZtLYe0ldcU1CCSW16LmE7lXpdunpc0tb?=
 =?us-ascii?Q?SFOqvkSbfFx6wece9jOkx0OSvmxYGJDqTbwVDL2IisT9p52Zl3jyoNnPn6fi?=
 =?us-ascii?Q?rWqYygV9MiyIcq5hxKbMsO3c+ozTNiE4gYBQc0BpLh+9duloY9V/RC2gMmff?=
 =?us-ascii?Q?Dey5js6SdPcClt1Y+C4hTXTkEwe9vh3eUS3RbObYSuqEibRXBWbt0GqMUBcz?=
 =?us-ascii?Q?WTLoyoJPBgXqSft72lO5kFlzgKlcnlJlSIKTzRCnMn2yLR/gkRAJEPKcYEAa?=
 =?us-ascii?Q?R5y31p8Sfeuv2JJdT0hye82YXFv0pg3PSwebL4HnP1AsjpEyk335/bfjtXQO?=
 =?us-ascii?Q?nHNSS5p3WGKjO8gmYFIDBg1JhFGhBeTCFeiuWAz0KnXJ0/WSBAc2TUMFknHp?=
 =?us-ascii?Q?1guoc1pQrgVt/m6jm2ssuootvHYXaeq7ubwIeXF0NHTs9qGGeyYhOw1HKkvv?=
 =?us-ascii?Q?/52qHc/4R3UKLhUHCZYj95mLPajyisk/grEZyh7HvpIQlnRJYWjpbQ5/OXbp?=
 =?us-ascii?Q?DLzDjLwkxFwneSQ/3bcrhQKzv3LzwsyWtzgcCu9Va8VtklHKZlh/fuPlt8hA?=
 =?us-ascii?Q?y7pCwef/ye8Xb0JZyC0mdLbDd8LfcfXOfFw5m+XJc0GGkY7e+M2tWktmFQYR?=
 =?us-ascii?Q?zbr5/SYQuStztHiN7og1FeZx2poViFQ6CUQo7ysm6wD5MuXbUAtSt08OSuqw?=
 =?us-ascii?Q?ynLMmNo1LzeFzfaAZ4+og2JTeD/CXkFS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfFDiYBJ55dyByBZMQv2CKlkoS4zxkgG3CjbwrD7qz4qUz057n9YrKUXRA3N?=
 =?us-ascii?Q?LIHw9z612dXQYkX6MyzE3Fzi5OyU4+QRmsxmMZpMt8q7kxSzNTBKzdHoiPvj?=
 =?us-ascii?Q?oAQ4jZPt+xv6rLIEu4O7mbcHUDgUq0YeviODAZ8c7e0LgV15eyDf4YQNowww?=
 =?us-ascii?Q?CP5V7SEXTIp18Bo5/VCCDeCJQN8Lj52LUnesr7xsa9ASCGEbQQMdxff4njhM?=
 =?us-ascii?Q?dIF3y0iJs9enJWR8ajDYlohgjzgT2bBgutFncy0Pg//80Buhg2Oy638he4lJ?=
 =?us-ascii?Q?4ip7SkXmo8dw5uMut5K68Ur3sCln2ybSrBjD6IwK9I3d8WLDRCu0OM19NzB4?=
 =?us-ascii?Q?g4snmOzLwY5Xkt6OIBijpPDo1+9Jrh/XG3RA/1Xd6cxuMnYblIcU/lHdpUL9?=
 =?us-ascii?Q?57UVPL+mctF1Z6YXXP2WzZL7zACT4nlKzp7KjFiVMNmbuVaFJgY/ArBKx1Vs?=
 =?us-ascii?Q?Znw1QvtGAscOeQaZ3OBMsZhPIJfULZGdsVXqG+A98M35QIXEtQ/oXvfg6/WS?=
 =?us-ascii?Q?wGz5u2XoXCsTk4PPNOooHh750eoOYTqxHXsItWUUvnPGlctoNW+thcRbMma2?=
 =?us-ascii?Q?pY260PBjVc4bFEAj/jnuSUkTIAZ7btyEvzgA+FKjEg2qXC59XrDgBqL/1iN+?=
 =?us-ascii?Q?e7iYlYvNnNPPfx2c3QTuh4QKSUan2IjpWj/I1NJXau3seSWB9hs5PZi9iuk7?=
 =?us-ascii?Q?Yp5FLv+9tyNoM8+vGw5NRaH/4Osh5ue0q48NcOFErvgGWpBDv0DrsE9zhPXH?=
 =?us-ascii?Q?AZpvDPAVBtDdfVlYWRIphIBdmtp3oKnWU8/0Ut4D/hvtIVueCfAIv1gOogO4?=
 =?us-ascii?Q?yZqm67TxAQoSZbc1jiajSMLCyvxgAQica65KZ49uoTGUa3X+kAsCO9DoOhml?=
 =?us-ascii?Q?tCyrwI83x44zT9dNUirH66NME7RPF39pCuTofxD/DjN1bUCXP9E1n0kPJgdX?=
 =?us-ascii?Q?M7YojJsbH4vu/k79t05iiwbcSXxcdGTyawbm7qKpsFDz6gtIDb0lrmizgPuy?=
 =?us-ascii?Q?lF3s9bb5v7eTAJM0SlLL9ojn8/FNOfX5+fj7zq9gUcLvINMbg41TsvtWUovy?=
 =?us-ascii?Q?fu/YQB/hwFdcLlS+XRIEoDNpjmOCvEzBUb/z8/MSPVD8IE2w+JiXGG1KfHL0?=
 =?us-ascii?Q?Bg3cI9ge8NhWvYQsPAn+z+sDjA8ez/AHcOMBqLtQD6czzO4Faji2Jj3qQSCs?=
 =?us-ascii?Q?pbVbzqCaUkcY3KJjZ8mvRZzRi18aNuihTf+CIR4dP0cw3lsK080sb63ZSOTR?=
 =?us-ascii?Q?4FEq09twh4uGwKo0NLCYiVfG5FFLb8qChrJ2hFhmQdSfbqTvL+MetXkRYAh5?=
 =?us-ascii?Q?/Oi5lAL+xXb1ygVwSP795L9fD9sWOEZBH5KrNqjObgmDYIU6xFJpOgft2Edd?=
 =?us-ascii?Q?THKZcIE6+Q5HUcEYtNYUe15AB/a3UvLpyvTHC0UhzaXN957/o3RuvBm7KMHt?=
 =?us-ascii?Q?5dCZzt1KMrWiO04VIITQriScuBDIIxOtIBQ9/aS2W3HvS6L/fEIa+G8YXehx?=
 =?us-ascii?Q?pQLnROiknjb18aY/DFMyKrdGjCA9f33FY8vV3qdPHKvdR8Qswd/sPNp8AFwf?=
 =?us-ascii?Q?7819I+ymA0lNHJ4bnYQIz9e+rIr2c7mSq9XWMBXV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCGU8Kr0MoH8WxKbMZSwmrb0mZNDrxoEe6sehzEuRkKxTuIbdHcPHR2ACclLL9JDPBe9V1GCQTJUU7FWajahB3E/+vwa/aoFo7GnnQAEsr8jKX9clNK82sz1Xn27RT+iHNE/7dtx7vwUz3vki0vFqBgc1PW3okvuCaErQLt7yby4fKyFW9xcEcFvhs+L18Nit1QdhOQVi8hsqW8HgyFHw4wY33+HmN+Jd7Z/WZMnscppFrTGYl+GrWe686Yj/nZehYPfO0VuZsi3H4+VjnQ+ixgoMkJ0AC90s4rC7u8R9byVt3pRE3tIJPqQG+mNkrk1s7WbG1svS6UUt89gz41zk0Cpv021PmN0Cx1Vm6PYQRB/mi8ZYIc5AtXSw4bjYOC3v4fKjPpLbV7pr/RpT2zRkv1UBdaI5IutjaWCgGUmYtwoNS763k7UyaCO/Bnv91ffV6JcW2ki+hKCareYZ0QLTKgHa96nIjPgQjbPjjQvIkb+3h0CEqnVe4mRDbn+yZktFSMX2gMI4xUcnDuEWnO28S3S9DsKeJQKtz6QVrhO0Mx3OyjAQUGwIRzMyTgo/Io5OZJ5qnpNJ4by1KEygSVeDrRxRoroedDVsB/WvMM24tA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d32e015-f799-4554-646c-08de2cff274b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:19:12.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAIoC4uq/tAUAiwuCBRReMdDae1KzFfDorGNfd1ZByBGcp8/9437dJry+HDE6H6K8fUv3wJxOBrv3ax810TJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEyNSBTYWx0ZWRfX8SR9qJsRvpwj
 74fzamr09pGnBUH1EQJh4CfELrvNNM5m1PJ/9TS3nXxxGqrkV/iQRMtGtVIVHjOigbY1HAnZ1zG
 SkuHWVfvwt3KPQ64Eq1dXBpsGr4jhxeA4Pa8Gztpp1/7XbXC2p5eA8yzGaFnEtYWohK10GCXwY7
 CG7VCNvh6bss8wCfTs49AToUkVPu6dY9b+MjVCNZShWIaJariKqE6SIcsi8/zQQiTGRWhbOyCFa
 qWdyrQ/Unb66exwaYurccEUBHg87Y90i4ZFcMIsZrQP1GAM7MUdmkny7vf1djDeszr5uuUlXAKD
 Laqv4WErL+DqytaAf+4WUrwcv2Ikbnby5rhM1TCn1UjWCPpIClf7QKNXEofThdg/JZky/7rvbM7
 kcUQC5RpYu2X9B/YCOFScRba+slm0cXsKCz80Vybq6WWxIeTNnc=
X-Proofpoint-GUID: tmnN5hkoG5oBAIGyCtZxhU2g630SbVOu
X-Proofpoint-ORIG-GUID: tmnN5hkoG5oBAIGyCtZxhU2g630SbVOu
X-Authority-Analysis: v=2.4 cv=KKpXzVFo c=1 sm=1 tr=0 ts=69271a73 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=LGixd4EU0KPlbEVDNxoA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099

* Mike Rapoport <rppt@kernel.org> [251125 13:39]:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When a VMA is registered with userfaulfd in minor mode, its ->fault()
> method should check if a folio exists in the page cache and if yes
> ->fault() should call handle_userfault(VM_UFFD_MISSING).
> 
> Instead of calling handle_userfault() directly from a specific ->fault()
> implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
> notify the core page fault handler that it should call
> handle_userfaultfd(VM_UFFD_MISSING) to complete a page fault.
> 
> Replace a call to handle_userfault(VM_UFFD_MISSING) in shmem and use the
> new VM_FAULT_UFFD_MINOR there instead.
> 
> For configurations that don't enable CONFIG_USERFAULTFD,
> VM_FAULT_UFFD_MINOR is set to 0.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Same nit as David, but the rest looks good.

> ---
>  include/linux/mm_types.h | 10 +++++++++-
>  mm/memory.c              |  2 ++
>  mm/shmem.c               |  2 +-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 90e5790c318f..df71b057111b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1523,6 +1523,8 @@ typedef __bitwise unsigned int vm_fault_t;
>   *				fsync() to complete (for synchronous page faults
>   *				in DAX)
>   * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
> + * @VM_FAULT_UFFD_MINOR:	->fault did not modify page tables and needs
> + *				handle_userfault(VM_UFFD_MINOR) to complete
>   * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
>   *
>   */
> @@ -1540,6 +1542,11 @@ enum vm_fault_reason {
>  	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
>  	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
>  	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> +#ifdef CONFIG_USERFAULTFD
> +	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x008000,
> +#else
> +	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x000000,
> +#endif
>  	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
>  };
>  
> @@ -1564,7 +1571,8 @@ enum vm_fault_reason {
>  	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
>  	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
>  	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
> -	{ VM_FAULT_COMPLETED,           "COMPLETED" }
> +	{ VM_FAULT_COMPLETED,           "COMPLETED" },	\
> +	{ VM_FAULT_UFFD_MINOR,		"UFFD_MINOR" },	\
>  
>  struct vm_special_mapping {
>  	const char *name;	/* The name, e.g. "[vdso]". */
> diff --git a/mm/memory.c b/mm/memory.c
> index b59ae7ce42eb..94acbac8cefb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5279,6 +5279,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	}
>  
>  	ret = vma->vm_ops->fault(vmf);
> +	if (unlikely(ret & VM_FAULT_UFFD_MINOR))
> +		return handle_userfault(vmf, VM_UFFD_MINOR);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
>  			    VM_FAULT_DONE_COW)))

I have the same concern as David here with adding instructions to the
faults that are not UFFD_MINOR.. I suspect the compiler will remove the
statement completely when UFFD is disabled (and thus ret & 0 in the
check), but it might be worth looking at this closer in the case where
uffd is enabled?  It won't be as clean looking but might make the
assembly better.

>  		return ret;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e16c7c8c3e1e..a9a31c0b5979 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2461,7 +2461,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	if (folio && vma && userfaultfd_minor(vma)) {
>  		if (!xa_is_value(folio))
>  			folio_put(folio);
> -		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> +		*fault_type = VM_FAULT_UFFD_MINOR;
>  		return 0;
>  	}
>  
> -- 
> 2.50.1
> 

