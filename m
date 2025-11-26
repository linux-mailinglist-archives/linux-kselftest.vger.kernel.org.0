Return-Path: <linux-kselftest+bounces-46519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E15C8A9A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C265342F56
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E73314B8;
	Wed, 26 Nov 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/QDx2Tj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TEq4yzwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAC1F8AC5;
	Wed, 26 Nov 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170568; cv=fail; b=QGqToTh0MILWSr/3FdPV+szTQrQuTTc9UQd8UsFiQShij+G7UWLwIykZedgOk5Ol+QZdzdhVn+xmZHeA8R81r298ejkNizbcX+Dly0I+UR7cxKcFWFWLSfCAjqZJWjG4dkn/Wa6B/4yF9Ebxz7d8TLCvggvLKft4yrK8rr8Lxr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170568; c=relaxed/simple;
	bh=R9T+Uom49TR/P3ci0Bs3wHhaB+P0s7M2vDwpmPr94Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=db1HFh1oTlGdHy3LGbNgdfKE9zv4dRtBsX6weGr0bDtnWn4ujYHgerXC/vNgLXMUFIXoMOyjz6XUbfhuDjU+Tgp/FkguGHVFeqvN3gEapJVF5h1gLHbNL0is8mZzF52S6XDylF06wM/PxWNGKr7+vqJ7DcxMKV8aw6Ey2E8GxQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b/QDx2Tj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TEq4yzwT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQEuCoZ2463592;
	Wed, 26 Nov 2025 15:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BuefghzGGqRGDy525C
	QBV3aYGbHdDw7QQci0p8gvqsA=; b=b/QDx2Tjy8IkauW6ZE1fUIvN5WX3tFwU4e
	1tkge3Fe956XoY1YNgBE3EffTFEPQcBOwOiZUhb8GbyBUKB1e3LO5jmfzG9SaKbH
	LQQdefht+PlQGl1H3odfuuLiObnSLgdRONFLPTAWs5O7mWkaSNqPDNz88/ncGYOp
	BqmGG/Ff8pKDA6357MStMI4C5f+rR+Qyxu9E8TYwMgV5cs37V/4cCIAPbfp8TlA2
	a3eVMSgKN9nssEuKmVxSAdhWWQwISyN8UijZaKoACzpJ3u5vK5dC2N03jfpPaZ8w
	qZUut+yo17x+6kDwj3SLYy264HbgU+Uvz7WWH02bPhunvP17QjIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkmj6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:22:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQEhFGx018874;
	Wed, 26 Nov 2025 15:22:23 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mb4523-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clIq2B+XcYnEa9iHQQ6waPTZ+9hj0QtaYl4DT8KdfF5m1MP3fPlHYM+noxi6IgAo2Sl6DV7LqyypmDgc5dksLvbi4+Z9NxWWcMr2HJinl/wdGgRbJG/6U0lnjqLqnpXlwXneMghOXxRRQSphM9K7N3ylLfEUiA+cih1txzYfh7FovhkY0CMAapLboDxj2BShfDXmDZckGht+t6+zNbOdAZ7711mQr9Qayo6Vpgib7Tc8TUwfei2XOfRyAhdSfSxhKyMts4vY+/1FF9oMtVKi4FW6+kBShg25pBM5EBD1tE3rif2/kDS74FKp6ajHE8qWgvnLo/I/jjjvyEeTYYg/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuefghzGGqRGDy525CQBV3aYGbHdDw7QQci0p8gvqsA=;
 b=iP21px/xvWdMN8LpcISSikKv7FOXQfxhPbHUf5naKYr/t0frU9bcd5FePLqj9OUT4G4qZsmyQfVBK9Qk7m44xHpoEEjO1QNqgBGSVw7Rnp3grXlprP9sKBJ0eK0lvyMQBIe31rBTNW2Ky5qyuGiiyZL3zsMmx9hqL44VxWjlAsD3CHUk5Vf3nNq8PR3ibJkdpKTwQztqWxLg41Gof390RuYAQae7gRnT84ApMhDFBtF2ooISQI4SHTADAjyuCFtPYlD/dWzlXHjhHpMBDmUNGpBBpVBdW+kbfwDz7/52zUA9EqaHYFaa4p6GAw1P9kEaTXYbwwrEDFHkkKji1GDfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuefghzGGqRGDy525CQBV3aYGbHdDw7QQci0p8gvqsA=;
 b=TEq4yzwTHD5RXi62z28kE0SqweX973HlJwj3BgCxdW/CTGJ76x3fx+OpZ1LIKBJtJcN73SLO3Z3Ezs57KdkDhCxWEhEw0Ht/UaHbsEVlswzaLi/GavVhV/+XuF0y2AlJKj/I62CFecHSuipxXRsDEP1w5HcDxZYG3bHFOdxYu6o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 15:22:21 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:22:20 +0000
Date: Wed, 26 Nov 2025 10:22:16 -0500
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
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
Message-ID: <4pjmnp7rvgftqg2l3icju2sduqfwun53ugbkw2pabbegpshvu4@uto2h4so2rgs>
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
	linux-kselftest@vger.kernel.org
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-5-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125183840.2368510-5-rppt@kernel.org>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 361be666-8cdd-4869-480d-08de2cff97c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WDPg8sQJiPrVSKVjtYoJxQzLs69aa1o9D6vcBk3nflD8uYbyc85flxj/Ysy3?=
 =?us-ascii?Q?haIegFBo/qJZ5rX8EeWU0+qZ0fgXtjkLC1659Yrswzqs5IyYoQU7rUNbscVi?=
 =?us-ascii?Q?70l1UHS8z7yt+rVN/2pKnN3/EYmt3fuGalc1oNzh1HrO1EnESZjqeq0WOp5m?=
 =?us-ascii?Q?ZZzMNaXp8nFv3n7v7jCb/QC+3VzqWf7A79vgMxHV4eqb0LgsuNOckeHuZucb?=
 =?us-ascii?Q?r3zPzFmTju9RCxxAJScPQI497bzgnzRunO75TxMuj1GLBkO31oeooJ5ViC/V?=
 =?us-ascii?Q?guMqmxZwHbG1w0I5eoc8WHz4noXxVr4NKMPHT0gaiV2B/NypBp6d/a8lBvHN?=
 =?us-ascii?Q?vBaVI6MqPuAhNBRD03v3fruUd1/eYNKUVQX4RbGkFv6jQKtefZ3oXdDj0fMS?=
 =?us-ascii?Q?5SxBBX8JQ2/I7cFqTLSPopjOaRhwbzAWJaDnzTcVr0iYC3tXLdTl4rXe9juT?=
 =?us-ascii?Q?UGFVo8cQV++dlHxzQuOKLh1xfET0biOhVnYFffYkrkFrq5HhxgAzYepkneMp?=
 =?us-ascii?Q?HxI48rovk5mpydbKiwiCEVf/mrohZIxl/8tb35jMSBWPGTAF+NTjc9sQpbOz?=
 =?us-ascii?Q?y3gsS7NlCkZaaDQ9UIareQH2cEvi9pxvu4BgrBtUXlzatjE61urcySoW0zf5?=
 =?us-ascii?Q?uRDhiAc3j1gN3gugSGe9zbAnCTTUv/TMvPDCGZ9UoRJ92jdNm65bQYsoflIP?=
 =?us-ascii?Q?pHs5935fqK6mYMP74/q2tXCIkdPRQr0lVb2BKQg6oRVkK6n+o7COZmzGRjLx?=
 =?us-ascii?Q?hDMKQJrZtjBTqDP3ZPX439O7snoELhkYDF3LqhrcZVqIhx4kjNSYTApYqfJy?=
 =?us-ascii?Q?8miSbDhQs6ZObqOzXNsWmPnNPMWYtWzl8steq4POAe2fcHm1qKJaVKxyKpQa?=
 =?us-ascii?Q?/qNaqLxlWw9DFcX5Gx4Fumd/C/8YHtFWSECNr6JF3UbTD9zX6udAjjAzCXGs?=
 =?us-ascii?Q?lpKlf7nllgOi7wdSEv6irXh7eh/7t0TeXemNu49p9mFyidfjk+mPoFfDoIrA?=
 =?us-ascii?Q?VwLLWFrRo0k7OOz9dWUW8j8kTULxbV55pbPO1pz2YvuskjPN6iDi8WxaVA7i?=
 =?us-ascii?Q?qd3Mh9+rpAwlvxtt5tLxe8UCa8VeT07gDaYgFfrE81GPhXGuwktL099Xl/D8?=
 =?us-ascii?Q?DZiGjKyIq9jGMe1lfsQ+hp3ki4R+xfjDWDvfO+Vv2Vdep5BKRE5THcpCYq3g?=
 =?us-ascii?Q?bsQhpisRMSGoBkYDuA8mOgwAIdl/cip1tDIN6zOBQZpGKtmjOYiU+7m2LAZV?=
 =?us-ascii?Q?70/3S97x6di1dmrR2iaiOc7HZdYd2iLLWFe3lzg0ozeEM7CFMM88Mf5LWdIi?=
 =?us-ascii?Q?so+8jBCNwQubH7hfzKs18j48Zjflsml+JPYyXVEymtWB/U+8BLVKu/6kJf29?=
 =?us-ascii?Q?ylnxc4SVH/+eVqW7DL9ALX7MKeJeeXiznr/apEiw3VQHEHKdjyAGP2n7o7Sy?=
 =?us-ascii?Q?HGlZKPNt8wPbb/qg7r/bDwbXaD0SueQk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqsVIiKmRvjL0nkjVy+QaL1aR7M5ZeBj3/qZXtxOqniIxxtGkBziBqTHz4/w?=
 =?us-ascii?Q?vp6XNjQn/PFaAxIT6P0OlklB/j1o/PZW3yED8VlqQaWcA2wF7viyknmaNytc?=
 =?us-ascii?Q?QujhMAq05OFliR/ZqDFEtjEzYteptqWDqcC2lXtBpzZlNjB3oc4tH3ERQL5T?=
 =?us-ascii?Q?fDpunWcpopSZxRoQpndscVLQznEEjb4ysv3cCrsXT72gqB5C1aR2Ed0WgBEZ?=
 =?us-ascii?Q?yZjCUUIn7dw/XPCaHW5UJubl6z+kwrUDmqO6FqrvYmq03NknT9vA4sBvXH1V?=
 =?us-ascii?Q?5LTefE6oLj2qL588/Es+QrIuc/a2hfv5DI63sNO2drbekhEgksPxVTnKttmp?=
 =?us-ascii?Q?b/ocHfhVbnhVUTB92ZOy7TRc+38cEmlX5oC6Pji2jRbP2CHOksvZ66F5hXQf?=
 =?us-ascii?Q?fR59EY7RJdWz36GIbldt3IDXB9pgNEtz1/GVLz5Cb0C2kiAVgX7zwqN9f5wm?=
 =?us-ascii?Q?ECf/EXZmOAxMWrsW6v2lnZftXau16pQ2n9bYThL1s6iKNMkvbc26fIBErzMX?=
 =?us-ascii?Q?o+ZlAslMkA06YfxTV8JrhdzWGq9wdORBx1IjchmK5MwoDygIzpP9fQWXMVSD?=
 =?us-ascii?Q?bzFjhwfippnLrQ9PlMprbcPtfpUx3/gJxHgv1otYlR57EpDnOjyczOPjy10X?=
 =?us-ascii?Q?npDzLRg49/ci8Z97V1UCpLNyfVdq4DR9BD9LTMOLPy68t6bMDgK/pD2HL+ls?=
 =?us-ascii?Q?TgCzampGVrFbRuKiFd1Vof4Z0JKEOnLql/ctKlwzpeghRn75silWxE66HUlt?=
 =?us-ascii?Q?hfUARcUPUnR6Tr/joYptOrdYJKdKpYI7fqX/BrTRXRoFSA5FKpkd6hcUnEgN?=
 =?us-ascii?Q?61JVKgPgNsK/NTOXvTmK4soLLgF1wXPO9ni3G3068us3Bl+cgjnSnu+IM4Yh?=
 =?us-ascii?Q?ALsWOadA0opVBhAp4VZB98iMt5AyJ4gU84JTVxuaUz+4OivzYTfBqX47KKA7?=
 =?us-ascii?Q?pCo3g76ypHhyyEX8segp3fQJIjbntDS9kTpcuj+AjhV4dhAvFEQ6U5uqMWxI?=
 =?us-ascii?Q?IrJ2j8JX+0xyNhNU5ZNqb+mUFYkjK20j7FQMrrDo8LPjlnX4S2kNpiRJqq1t?=
 =?us-ascii?Q?5WBPYPjH8UTcXH5lxmWY5ACdtDdY3mPjblQxANnceKTwFDTNoDImvYJPwcqO?=
 =?us-ascii?Q?xE2XOd0o3TvHzWOHgUX3GAkYkYl4nqlGvpzV9kxcshLDbzy0iUNA9Q5kF8sB?=
 =?us-ascii?Q?1poZbI6MOIDFXmqDbAZc7TyscrK8Au5FelzApWI3K/jslybSc5CYQXDyw0tG?=
 =?us-ascii?Q?o66otqmDJD+t+jQaEh/TcjfF6Z0NLeOvq3kM4UFANVd5TrohLTGrBBoiTCAE?=
 =?us-ascii?Q?2iLPyZPqMMEc9/8CVK7ujAUmu5Q55MiaZblA5lo11vJDSHa40HoqJbZ8krz1?=
 =?us-ascii?Q?/z1FvNb2yMX1hN+qrXAwXqoOmDEsx98SVpYwk5Me1NtKtB0+c2g/xZeJaJe7?=
 =?us-ascii?Q?ZragH8jmaQWWh7epqKSkqnBDu4kO94q0fyBqELkNcH7+djdJaB4DvnryapQ8?=
 =?us-ascii?Q?vN7djZjipbqZ9C1eJlLujSujKqsNYfJldc2lna5lUpl7/PXPZS04rEpvPvi6?=
 =?us-ascii?Q?B2MuDmrZpyOEm4lUHXu0y9XGfY1qYtGC6NmhELxt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NS60t1y+bpHMtqbuojaurJPy1Ant/1Fnmz5J8M2Jk2GaRSGxLPrj8CxXZ1XBvuoewAVKQeucjTqvL/BYpdyVcoVXYdRNXdz6zNclVskgNrUZV2zUqxSRGxnG9kO8ijTYv0CKrAd9cqYH0P2pr0Z0rCobjInmZNgEWNgGi8ryktK2Hk9jSLbWM13g0x4wkJuOQ1HRNHP4OH1UjTqYQdclPH+v7HWT/hKeKZj4xK4QtfC5cXU4g8SW2FbiKS/CJOmtKixUkD5yLZ2lm8h0oKMATzySaV4e9qURzBJm4JUmoIW4y5rMkRHHlLBoit6O1CSN0fjg16J826r8BcosleIYIS2f3SyyfMsyUbchWDR6T39/qiCkMlYdGomu33DW1ADSi/U7kLNreMjlmi6Ch+PBJHa9sBFl/6NkFbzB4LLOIiLIyc+XGkz2FKvjq1WogH2WTx7ylZaCle+dvFxc2HXuo9iUh6azGk+hcayoDX/TVIYpTq5gDLGXYasBwTssx7p9WTbST73u0Nfv3CDym1OV6VY2wl/kxkbSqthj4LxAzX1NaGX7jl3A+lxI4RD3u7nH+iVXAfV73PTeo+RiF6SvHcGPjkrytdyesDQxcc8g0Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361be666-8cdd-4869-480d-08de2cff97c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:22:20.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oduTkOBofeymtkPie0r8NeZhAFqpH8GQU9dyrbMDnqhNGC2V94bEPibT9LYqM/t+AS/M3B1QYytz8uneZ+axLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260125
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=69271b30 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=G_F5KXMsGXWNx_v0snEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEyNiBTYWx0ZWRfX8d2ZHXxEmUQ2
 BpQTOMsaFtwKLtQoBo/ax7Sld4uHAU+0OPKqCJcz+H/LYK5oVJ1fiO+HMC0M5ygja9u7oqKSvd5
 UN0VxDz5N2BIRvMExwCIyG7CJ7XFD7qEAEQSbUjMdDVbM6kZFm/UwisffTj8RNHI7ty0oFNRW27
 zf7RPEOO2LnTNgkpyJggEiWLHd7O1RT7sDeSJnG+4+6zs5ETM1rpBRDvNyvbwm8oRY28tpbSW3x
 +u4xBGe3FjzsP59v6kpj5ZOsY83o7CRaelEbeshUMV40cqMW796dV150wjM6Fe8jpMoc1cAxkF6
 9n3baRlPdVTlIzM0h7h4Xg/3MIKkaAwFuXwSInKS8AUONjepR1lpdfRuQtjB0EEFAtMleBlp718
 YYCJXhm6JiHqbr6GvaotzCyXvnVGIw==
X-Proofpoint-ORIG-GUID: PhFrvzIzMt2Q_GTSonXKT9oM6ut_cOoX
X-Proofpoint-GUID: PhFrvzIzMt2Q_GTSonXKT9oM6ut_cOoX

* Mike Rapoport <rppt@kernel.org> [251125 13:39]:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> userfaultfd notifications about minor page faults used for live migration
> and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
> mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: add
> minor fault registration mode").
> 
> To use the same mechanism for VMs that use guest_memfd to map their memory,
> guest_memfd should support userfaultfd minor mode.
> 
> Extend ->fault() method of guest_memfd with ability to notify core page
> fault handler that a page fault requires handle_userfault(VM_UFFD_MINOR) to
> complete and add implementation of ->get_shared_folio() to guest_memfd
> vm_ops.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  virt/kvm/guest_memfd.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ffadc5ee8e04..2a2b076293f9 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/userfaultfd_k.h>
>  
>  #include "kvm_mm.h"
>  
> @@ -369,6 +370,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  		return vmf_error(err);
>  	}
>  
> +	if (userfaultfd_minor(vmf->vma)) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		return VM_FAULT_UFFD_MINOR;
> +	}
> +
>  	if (WARN_ON_ONCE(folio_test_large(folio))) {
>  		ret = VM_FAULT_SIGBUS;
>  		goto out_folio;
> @@ -390,8 +397,29 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_USERFAULTFD
> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)
> +{
> +	struct folio *folio;
> +
> +	folio = kvm_gmem_get_folio(inode, pgoff);
> +	if (IS_ERR_OR_NULL(folio))
> +		return folio;
> +
> +	if (!folio_test_uptodate(folio)) {
> +		clear_highpage(folio_page(folio, 0));
> +		kvm_gmem_mark_prepared(folio);
> +	}
> +
> +	return folio;
> +}
> +#endif
> +
>  static const struct vm_operations_struct kvm_gmem_vm_ops = {
>  	.fault = kvm_gmem_fault_user_mapping,
> +#ifdef CONFIG_USERFAULTFD
> +	.get_folio	= kvm_gmem_get_folio,
> +#endif
>  };
>  
>  static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> -- 
> 2.50.1
> 

