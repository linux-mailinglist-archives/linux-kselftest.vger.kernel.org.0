Return-Path: <linux-kselftest+bounces-26884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73682A3A44D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714B4167C66
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53026FA71;
	Tue, 18 Feb 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PwlKjAkB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TC5ue4+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA62286A1;
	Tue, 18 Feb 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899742; cv=fail; b=by+oCavajNLS2Ujb6YeAxPSuCHI2vMjaQjG0I80EZBVYaXfJHp695o74FvEx/UnvwjGh6KDz7Dwf2d8yLaDZSjh7AFPW3Z1oCNvKSmZQT4tgCxkg3jSVwjed2eTiJdKLwfwA9UPbaCiFteNp9ubokdKMiRxuKIbW3+20CLEBDY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899742; c=relaxed/simple;
	bh=qjSToW+xFsa+bNLvGxNCdXI1+E8ZdiqVlT7pF0ElT5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AgP4qftx6DQReJUNRumH3E1ier/3TpNll5TCOGX4zhIrm2EijohAOKfKKGCH8+xKb6V88aNATS1pFe/sZHMpH2yrQsdYUF98LCI770PgLbHksSWBOQIkh5ve2Hrkwf0VFN1JOoWT+OcZ6HcS9a3VEErWJc1G66UtypLgd/9bISo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PwlKjAkB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TC5ue4+F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMW73021250;
	Tue, 18 Feb 2025 17:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lOvtTAZI3LJGA8E66+
	yvfK+ag5J73iLUmr2Ni4S757k=; b=PwlKjAkB4vBvgt1uLVMOejwNISASPIXoBe
	Se5U685N9bp8jOHCKnuGcWWnw5kAakCSY9dUq/9LT5clAvfjNFnkRzKfRCe3PK4f
	gvRY32U4/aP7KQOvdh+ubBp0LEDZ9SHJbvzr6BWCxfKJ4muJlqhbAQbj84V4vZFp
	O88cYd8V5gXp7q2aKo6DOnuZA6QbyKX7WgCbRtCoi+ZsdxeAYAlcE2hW2k8MYVy/
	f1km1lzT+TAXYQDo/G8W3C16CyNPdN/3As/Xx0kuml0Rk0DNoVqI1zIi1awV/MwG
	fI4BM7l8k+NF0aa4ZoxTXCL7sFEFT8nX3hZXw5w9u7mbSTg04+gw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44vw5ag9e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:28:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IHH0w7024955;
	Tue, 18 Feb 2025 17:28:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc9b7dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dksgk/hyAU1gB+oexiHqDRGkshxB2z5uRfanRXy1/oP7nYhMmCihQK0PqMKhh0ISFW3Y7/3KD/izL2lx6sTBMK6xz8mnh4LL+JMZYveBtCTQeND1BvtwnCQJuFi+vjpzjbPfNmCH6bvmFxD1SoY/c9F83x92InXxPbci/FfndYv2AHy15fUcmpSC0YTSHdQl6R73fCEE0HeZcUKi0ltVdPWALp6k3PSaXQExO5EdQq8T8HP4y8uLVl1Nc6TmYcAn2i4F0KORCEjquJiSdZuHRhKM+ip3qSJUPuaevRnEmTLQGlfhMmmdzxoVg+HvEizBxdIWXG0Xi3ojxuq+ocirbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOvtTAZI3LJGA8E66+yvfK+ag5J73iLUmr2Ni4S757k=;
 b=gf2p3XdWoNWTdxBZQds+xM6Yig1LhZ5s1nIWBpqDFUQStE83LYrLLgtQiyzE50k770oZRcFxQlgyMTdOGwBO8Xtdu8LufrrX4d+A51b415Vi+xFMHOVI+YXNUOaexRb60zxYpNcFO+lbYMTRtgNy+VMgbdYsQxXmBOth8wc6lbcnjENCZ8EnqT/+xUgQfPNqfYbgsnEErenDPi/NIq9SACj3+IiJ8ujuMNg7glJVXjRYYXxbHutJk58iNm77y2GoRh2ik+jWXzucXPLEJMzSlhwjATsM5fmTQzgDbNQfVwybCIUmfjqp4sYn5KpqndSOoJ8cnvT43y0r0OXN1VAR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOvtTAZI3LJGA8E66+yvfK+ag5J73iLUmr2Ni4S757k=;
 b=TC5ue4+FfTj9UBCUWCvtLxmBjB6wkKs9pzWtzgQpi99OVLOgMy1sIUupbormwsFim4OdptemWZA9mG3eMp1+pAZtNCqkEn7xl6cZD3doyPfCHgWAvlY6FrI1TGWj+2ozA5CESogSEYNLLaxeHNiqgX+Kgs/CghgN4TQRVZWKXh0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6129.namprd10.prod.outlook.com (2603:10b6:510:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 17:28:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:28:40 +0000
Date: Tue, 18 Feb 2025 17:28:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5eb176-d767-400b-8a8f-08dd5041af70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XziIvM9u4IEuv3sBQZu+OmuQ8T0J6M1m5uHqQHFuy1/4fH43vaYbr6rSAfQG?=
 =?us-ascii?Q?haZjpFjKwuJdSc5SGivjsNq1lrnl1mCwWxwdJl7fHaW64nVR4vycS/hKsdB+?=
 =?us-ascii?Q?a8dxTHvFAxwHatbTCiY9Tuhj50fzQ7Dpoffc3Ckcf0MGcqk5eHNk2SSZ3iRq?=
 =?us-ascii?Q?xOsFF3bFEaUcog4XiZm1PxoFFN4I+m7BR2jlJXKxs2pf+9RRUs5hcq8WkyGf?=
 =?us-ascii?Q?YboRmFoMhzwdYMUYJQkvfVjC+ju9K/YRvNxFObgpCh3oplFMM0UpJw5sM+sq?=
 =?us-ascii?Q?tgEViEtoLuDNTLFzPPnOL5K8B0r1QjE40SHgsGTuXSVqLwRvXSHC+vsW+nXV?=
 =?us-ascii?Q?yhTVJBJxKMueftBlSlltJfIlW0UnfxUST+X0vatF9vtrvCnizp5abQEO/Ant?=
 =?us-ascii?Q?7dkyrWGlmJl1iOxn4iufD4dO58M1edDxIvhNPaQFjKlaAxS7YzGWiofqG8dw?=
 =?us-ascii?Q?KlDQobfDK24OCuAODP+BXkhwiXln2PZPlLs4Ph6qVx4ucwxzbWkosazC3joH?=
 =?us-ascii?Q?Qfl7XrujOBSRXYWmomVyAExlYWVRLkkZ5xGFj0Tv+IojWQrIuacQ1WSd2Y/3?=
 =?us-ascii?Q?6ck3RVLbkWcJdvKaiDwg5a+EftqVzX8czCuOtjOFihW9TUaStzNFuXf024p3?=
 =?us-ascii?Q?uAfXMOA6+2A/2S0KKjlxNA9puUyuj4fEtXYvqsNvBiCn4wqz4MKrhnlxC7mB?=
 =?us-ascii?Q?JSrMrR8BHObp18rMoTTWcIn/PQF95ZycE8miV8JvLiQhoUuwjHLZDlF39m0t?=
 =?us-ascii?Q?Uo56eKLXcF+TlDxJP6WzkJwtR0blHpLE91EZtZGf/27Y1CPWjYoK5Y/ZKRtI?=
 =?us-ascii?Q?eHbMEe2xqGZBacRWZlXh9wJWNdbiaUOLjrLE+PywjXTYnHYNhv08xt8GGLBG?=
 =?us-ascii?Q?rCl1QdzilMB5vooklf2qtt/Ksm8wxxebJCm6lvNCLTXCXecgrpZd2q6CwhAv?=
 =?us-ascii?Q?DSpsYyVkV2HaCZRg0FPsOjMunrFt33g8IYRIca/pub8Ms4hwguRZb8ScxjnE?=
 =?us-ascii?Q?jOyzG64wRPZRgbzwltLrdU2/SCk8NMUNbFwrA2k9QB2OBgC7YJpVHiAuFqmH?=
 =?us-ascii?Q?P/8ilN3eqKw/nNicA33vsikUUEgukVNLfSvydEaQv0o+wgMRZJGMvi/Td8U3?=
 =?us-ascii?Q?v4OZlelb1SnfrIo79ziroVL3rGfPOXuLhwE0vGHIs2uy4HW/tWaE/qUZPyMQ?=
 =?us-ascii?Q?NSz/sABHpeU++9k2X5kMZeAUk3NRaLJDKzPH1MLkXk6xqhobsaEoGqzQYC0J?=
 =?us-ascii?Q?5OfaRyWfj02OXwSaP4HiXWkTLI7GppBPBWdhgCvsC0/DSiIEXYhYBGdyFg+b?=
 =?us-ascii?Q?9+jJXzrIbB5rN4hxYv01ghJjEG/ndUW8PZKoliZmkjOdc6O1UFuBl9gKo7u9?=
 =?us-ascii?Q?hQqgyorACc/AeRhto0MWBQpKmZ2B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIZEn0bMr29MEMPAR+Xh2uEdoIvHi/riJag7q/smqX9STICIHovJkr/BTnRl?=
 =?us-ascii?Q?w/ZK0z+E/shfXfvrFqrGHZvhr51w0uwgmTzkZD0Lve6TeIhSiuq2M76Wl5bp?=
 =?us-ascii?Q?dAERMeZyekeqdoSi6lXD3hFDyoFZtckVbzs3tpowSaep/yj15mlQ22WyvYuM?=
 =?us-ascii?Q?Kz5a7FbZvZ7kSXE5GLq99CSunvuC01/YasttdrgOipjYiV9UArc3VabYt7ry?=
 =?us-ascii?Q?wAqgPHJlMK9x0O30FdtZL1/BqGzakd3I9mO0fwN1SehxEbLDqJ7/JgiiwU2y?=
 =?us-ascii?Q?Hq2/rxlVHDpL+BtEEajEQ7BNvLDwYpjxAZltpxSLZWYspTQjOG65mKuI+9RG?=
 =?us-ascii?Q?Sr5kyI6t+uvNO0WbP/RAbuRP4OL78E7OEdADZZwjFi1cClmEVoG2tkpDrkZA?=
 =?us-ascii?Q?6kJV2mVXBuaaYEkm+N4B6T6s6OHTqo7vLldWHpTY+wMPOY7PGYoQLpiAAuFu?=
 =?us-ascii?Q?6kjriZoDveRYVAKKxmT2XEelItMfK7L5h5Al2oGVGzfp3+sGAZRbmrbZMunw?=
 =?us-ascii?Q?HbM2wjnNu9fZBdSaJRi6Ta4vrbIWXxq688dnR/WUtbElvrR6uyV+AsiRakmy?=
 =?us-ascii?Q?VXJ9+C7r20LkDxVfqPWwW80AGjd96c5GvNjmSY+PsIwSd8C6xDai3tndcrJU?=
 =?us-ascii?Q?aJPbOEHI0ZTVNnt+YH+6zNErKh/vVKRpqtdrAnVEcw7ZZ0B/9Kgx2waVJ00t?=
 =?us-ascii?Q?1ROJjmlI4MMpjxvgod22ZqQHhZSMdRADahvReBtvx4D+HtWTGSO5zehXAapz?=
 =?us-ascii?Q?Qv8VnrXVUcbY3GZtxjs8MEkmOBPI78Jqg/f4cbB1xxdlB6XprKFd1y7pB1JT?=
 =?us-ascii?Q?JyEkVd12FSCIRbmfaMfehQJ7K0bOB30SqbI8Wh9EXrArB8JbZnKOods7bvez?=
 =?us-ascii?Q?BbrHfOz+U0bjNHFopYE0G5CmuxoGqMPx1XNPFHt1bEZGtayQB93sqU6/ICsk?=
 =?us-ascii?Q?6q7WWWIak8W40C9pELXz+hCA4RtFDNxbi1SuRMhGTSx9TNFUPKbgXe6hm6BD?=
 =?us-ascii?Q?QtqJZtusVNFd44CX+Xz6J2Y5+TA+JtZMTYQCSBJiFlnGmKBIjgW4lTfbC5rB?=
 =?us-ascii?Q?lBgFsKpC8p5rga935u8BLgHJHQ9WaiX3bE+D4qLyZlmtQDaoplh7MCkrWa8A?=
 =?us-ascii?Q?UaW8re+eaZyUgoEhILx/AQ8AIvxKyub0r7Vuhd47ChoPfhXJ4A5xAHctq2RB?=
 =?us-ascii?Q?mmlBgAXDzPwdPGOTjEKcx4kZmsmlimLH9ZvQYtw7ULSX2swylu8XSNF6B2Uq?=
 =?us-ascii?Q?0dxTSGfSUdsLuqqDw+NIYPJ5fycSYTcSn3HnLw1IAX7D0x4MorOTUz1wRmLB?=
 =?us-ascii?Q?p9Bye6KLcgwri13y8ZtVCIkAuWIj8YYfbBiCoQsvIff/TaYT/shCw8LqUNvJ?=
 =?us-ascii?Q?Fj1eXMxqcwAxGqefvpQDXNQpvM41eNaCQOqse8iw/QvvcBZDrsiCk0behuy8?=
 =?us-ascii?Q?yow5QOSyyARIhBzr8xlV6D13MCKDYPj1Cr0cBrm8igJB+rIWHtWqNXhn6Vr2?=
 =?us-ascii?Q?qKZrFkOQGleldI+4d9BX3eGS5SYR4CsVLvKqx1g1kdCMUbc6/EHXIR8SYxRh?=
 =?us-ascii?Q?jP+tdqz2UGtbttW+5ZK0wQhjiZxmGHXev6SagUY8KEi+cTeLHWbG2IyCimBm?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	auJfkAykcRbDlU/RwWZJ7TYxjIHofy6WxQAXIAfotdIlKYAmu5U+iDz3ed3YUJrmv7sAFAN4mpsJP8vhgS6z644n/7NwvTDE9UrqcoweIM/4hjpGFi7AsnKaIBVt5sk3mL8yIF78QuDygWjy5Sn+hyOwZGrc/oIZY5rz3mooGU90OtmWjySQNFP1erjyLXs/58hqJbrrbXqg8AZ0Lfv6+f87tsUxZ3Pam5CsSTnFS7hxqTpSPtF7vFdZhJie1ocB5BjP/B42pTWduUMB9baA304lJg1Y/HjOKPq8qQei6WD2R3OU1B73AQvRnsQmZiIv9JXHak1EEPjcB4nb+6TTNjGncCAi9EUiVnlRIkW6uaLMnHBsHe2eyafsq7ZXuutdwIEkzJO/ggzfSs7V5DA/pC+JcPKJuK+5QOhWSzN/k0NM9zd4z0B2937Us4XVTEj6v0Ru9JbGpfbEp6aQucjw5e3iXGq0gkIsslvTb7AyZi0bYHUT5Rv1dCJ6q4X79FSETh+S92f3eJP7YNKJCosyjFHITbd9j4zRSuhU91Ol0MmJgsN79VqrP0SoQ2KwDBdIDpw1Ljd/B+hTeRFBBN4hjhXo3K53aBvTAl3h1t4un+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5eb176-d767-400b-8a8f-08dd5041af70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:28:40.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFPMo7a8B4jRXPB9mcpXOe4KkQGQcgn77lrv3tNWOjvPYgjGK3Ock0NuJOvmrlT9p7FhjK1O/vzzuwjTO9jYfATrnWkyHVFnKEZF26Wzb94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180123
X-Proofpoint-ORIG-GUID: u1_t7O8FgG8kT4w_GhcFmmtr9PVa9CRc
X-Proofpoint-GUID: u1_t7O8FgG8kT4w_GhcFmmtr9PVa9CRc

On Tue, Feb 18, 2025 at 06:25:35PM +0100, David Hildenbrand wrote:
> > >
> > > QEMU, for example, will issue an mlockall(MCL_CURRENT | MCL_FUTURE); when
> > > requested to then exit(); if it fails.
> >
> > Hm under what circumstances? I use qemu extensively to test this stuff with
> > no issues. Unless you mean it's using it in the 'host' code somehow.
>
>
> -overcommit mem-lock=on
>
> or (legacy)
>
> -realtime mlock=on
>
> I think.
>
> [...]

Thanks

>
> > > >
> > > > It fails because it tries to 'touch' the memory, but 'touching' guard
> > > > region memory causes a segfault. This kind of breaks the idea of
> > > > mlock()'ing guard regions.
> > > >
> > > > I think adding workarounds to make this possible in any way is not really
> > > > worth it (and would probably be pretty gross).
> > > >
> > > > We already document that 'mlock()ing lightweight guard regions will fail'
> > > > as per man page so this is all in line with that.
> > >
> > > Right, and I claim that supporting VM_LOCKONFAULT might likely be as easy as
> > > allowing install/remove of guard regions when that flag is set.
> >
> > We already allow this flag! VM_LOCKED and VM_HUGETLB are the only flags we
> > disallow.
>
>
> See mlock2();
>
> SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
> {
> 	vm_flags_t vm_flags = VM_LOCKED;
>
> 	if (flags & ~MLOCK_ONFAULT)
> 		return -EINVAL;
>
> 	if (flags & MLOCK_ONFAULT)
> 		vm_flags |= VM_LOCKONFAULT;
>
> 	return do_mlock(start, len, vm_flags);
> }
>
>
> VM_LOCKONFAULT always as VM_LOCKED set as well.

OK cool, that makes sense.

As with much kernel stuff, I knew this in the past. Then I forgot. Then I knew
again, then... :P if only somebody would write it down in a book...

Yeah then that makes sense to check explicitly for (VM_LOCKED | VM_LOCKONFAULT)
in any MADV_GUARD_INSTALL_LOCKED variant as obviously this would be passively
excluded right now.

>
> --
> Cheers,
>
> David / dhildenb
>

