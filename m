Return-Path: <linux-kselftest+bounces-28029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4EA4BF96
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58303B58E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8220B81B;
	Mon,  3 Mar 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TAsV+efQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nbo6nsxn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C91F426F;
	Mon,  3 Mar 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002856; cv=fail; b=qom9ZhWY1KQ1rprq4BLl2KS6w/8B6zFVcRzr76QoXSbMEjKR42/luRJIQllYU/q+P7Hk9pEbPt4ajJojh8Ir9d0Vb2UuQq7IZDbRAJIVPnLNpdAIr6+Tz3FzAUaYUTTqeaQPiuXr09N9b0GtVKIWZFVWBPqVNA79cJji8wjnWjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002856; c=relaxed/simple;
	bh=8Q+6msHcTpkVLk0irQshhK1MNyVKfkBmFnKX6IYGQeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N4V0Ogso0Ar0mBBf1sVMc+P1Swu0wr7ro8OdLxAa8GFbY7YFK//UvfikqzPVxT1SfDqpXkiO1NNQYAg70Ghwm8MniItHnNezo43prh6Hworti5d5X2yIIMRA6UR4K3QGQx3BX2fm+WoGpLpoL52d6CL5EeEmp5565YPcxk2R/rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TAsV+efQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nbo6nsxn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237thm9015522;
	Mon, 3 Mar 2025 11:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JbIeAg0KsWK7VZc1Hs
	iFXNm8XRYp6tor4t+a2OitPDg=; b=TAsV+efQrSXx3/0KTdy2sym76EY/OwCvxj
	uCOvwX46EcO73tXUynXU2wq9lz88VIUhq23p/rBMu/WLY+0MaRjIbQ8L9c9oKGuJ
	BYP8r3AJP+SAgZeSJk7MU9j1pSIM5GqiK1rWToFs3UpubkOtDkbaUGHakWuxjtf2
	WGLy8H/q8RkUCDIr/qnCKZndV02PbipAE9l4FEotB4uzox2tPWU/cfZySCMsrBKT
	KwrDplbiOD8l3aurOzmknLVY/pF14SiwO+PjxgingsdWQ6rwRMwpn4SaZITQdNyT
	nvNLwkjhUv1hq5eWFa8sJl4uFqJh/bMoTk+3Pr+Pla+LW8qpnfxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavtedr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:53:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523AWKrO011033;
	Mon, 3 Mar 2025 11:53:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8w70a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRbiJzOFjxeR15yG3AIwDVZknFqhYIneyU9zy2/1XI7TVK+fxADK6kq1/zRY2o2Gl5rSMcJglNvAFOwfWwVNcjcyY8zO/XGfg6vbPPXZ5izoHf8llFE6DnBLkxPEFjWQH1NPF3Sv08pxxn4ojZvKv0pp9PCRR0+uY1fI0KTKpk0GcLkOmSVU6sa/XqcHIz8d3D0qX8iHU5dmNsNpdQ8R2ff3fUV+ZCJrJ27qJrzf2neAYydDTUsq+UPaxKWzc5GrybX/Np11OJFyxgz7VFxYHOgfl+2Dfw9+jfNsPICaEMPQ+w1bYMcm8DtsG03NSpknNGyzacZzbO9/7+Rr6gHPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbIeAg0KsWK7VZc1HsiFXNm8XRYp6tor4t+a2OitPDg=;
 b=kVPcQTGjVeHfO+k/s65f+qWwM+3sgTXzQv7B6NGfQ4LRWo0+V+9Xsjm4nnMtPY7fOBHY5M8jG4/zJF4UzZST5mRZyKyoGkdsfyXRqnyIF4LfdMJCpdOsqjLayysHbJiZ1hS1/XOzhYxXKeTzoB0MjzW06SzpPG6hgXRML5Rbpe+V3xAhd/xXaThPYg08a1HruRgDMs8X+6cvtFn2WDjDtVSzZTgtrHYOReVjjs9RwCwcSpYyAB9inSNaEls4UiGgNim0Wfrr0c0C7IpLCuLLxmys9JZ+qI0FBMm9BNP4KEPFcOHjyW9wchDfAC/+ptuU4ou93mRXOGCaattUVc/zAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbIeAg0KsWK7VZc1HsiFXNm8XRYp6tor4t+a2OitPDg=;
 b=Nbo6nsxnSAkas06sywgkrVJmt/gl5Q7oCxzMpbl2aCKA8jRS6hGrBBhxV97Ghi109SodNaX9H9i4WLEiJE0KS5gMxKmopWv0HL+S2S6CxhtPzQbeMq8mLG3XfwzP34bNZ0V0/TIv3SEhg9co8xCvxrnfmuOZLc93yTbmfynybkw=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Mon, 3 Mar
 2025 11:53:11 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:53:09 +0000
Date: Mon, 3 Mar 2025 11:53:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 3/7] mseal sysmap: enable x86-64
Message-ID: <1dd30d47-e538-4d61-ab90-2fbe62d9ce3c@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-4-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-4-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0363.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8b9b24-cf4e-4976-b236-08dd5a49f7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?97No3xnuwBtHfoHo8QXYyPDPPwej8rf4uRYMf3E0WHgN+Nhiuf26FvSnGndi?=
 =?us-ascii?Q?OdCPZkB6mx60MeTgG3Z+ksYp6WJlIwewzWL2wes1p8aJT+dAckDxcg+7DN3O?=
 =?us-ascii?Q?QNkYWyDggeajmkSygRalHLPju6XTCr7hKljxpEGc1nhHqBELlUjKA4pwUmLf?=
 =?us-ascii?Q?dShUYeHRS2IkNopKuHm9hl87yDPEgQyvqq9hSkyTSiznvbnEdfwMOWtm1xpK?=
 =?us-ascii?Q?W0sXNQpn2qO2EFa7d7y1fmxhN6UP3+XUip3sRrfGMRV0kHGLP0ugzaarv+5C?=
 =?us-ascii?Q?7AMLTVmEOfEgSmGRgO1fZk9w/im4v5R9O3xGPcwxtnvGkn/EZTPot86Cz9/9?=
 =?us-ascii?Q?wlY3txnhbk6BhqUovr9gNhbdfgzyA4uYo2ZwSWxd+NspFyG6rcMAbF/u7x2F?=
 =?us-ascii?Q?nK61u98ykGLLwxqgRYUw/lx395ptuqt4VH4iEf1RLEmirlAUx48QMfSutp2W?=
 =?us-ascii?Q?JZHzowIzSW44k+I3bZbZbsZCzFKEuZaiPNtWxUM+u6xCsar5GnM8zfmPa0O2?=
 =?us-ascii?Q?7cO2XXak8CB8hUcMtZtyhGh3D59eCgx8mxvc2V0uyyVaITx9mgIpmOdtEfFo?=
 =?us-ascii?Q?eaaLddsdi1/h/ykl/mgrq3hSESKN1hsEtGizGqOXLrYBvJK/339oBcfD1mHN?=
 =?us-ascii?Q?kBXLVSeafVOSBNogg7YCbeYrg4rK3Fm6gAS1Fc4F+WXGBXw4OJ8i8wTTNzb3?=
 =?us-ascii?Q?x3+UFvl/6/09+MYdDsGoV9FS2WEMS6pPtHCSBYdRoW/CpfCBDgglYnMQdfV5?=
 =?us-ascii?Q?3k4+sf1QCklQnnc+38khylo8iSz0WwFhJSk0rFVajnyX+QhSAj2Vs5bXxLLF?=
 =?us-ascii?Q?XVjvjbYYK2JePDLTPUZU+i9tZlZCyjI2ihh8ivBgAPE84rbXSZ8+gOTesXZ5?=
 =?us-ascii?Q?tfA1VqeQKG0GFVZfz1u4weqghZW1fgSbarD+K7oMZ9aQYZQJkA9WUcqSe2WB?=
 =?us-ascii?Q?splk7LGOKbZQJZ8BqepCQqBegOzEdOt4OKPG1CjG3EQmmGaigICS/PcJl3+d?=
 =?us-ascii?Q?OjqGB8d7EoCN+20RBsu1QVMWP80TAqlYxutWJQZo1TkYb2aA1yNkmVbNYsWO?=
 =?us-ascii?Q?u7VJvjyvk5mcIURlh5J+eSaAcAOw/YBHP5G4UczUNPsQ+aR7RBUjIhpeRpv0?=
 =?us-ascii?Q?LjiDRxLkKwxCOzdaDXymJHzWaIZ5wV6KEU6e0v5VXk37ENj3aBslck29ZAVC?=
 =?us-ascii?Q?k0XTixldlW8m1d5XCGe5obnTRkDL2kZOzzl+Wgtp0W0OfDjvHAw/QRp3rPef?=
 =?us-ascii?Q?+cOlhzxoFerYZmP757rIcJ0x36fJsKf4vUTf/fV1C9KXo2CA7g1eMnFToYoz?=
 =?us-ascii?Q?EGKj1tCQdHKhugKJ9B25FabLkYlxwSoLrBf3z56uWWZyjuJObRATfPUQGibO?=
 =?us-ascii?Q?luZHEkaZ+NcJD+QXva1mWEWNpzNS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwp1DczuN1uKkjmlV6TTwjUiWtiHpajxEcyUni4CqjqsZ+oB8vB6WsdQfvvL?=
 =?us-ascii?Q?aqRUvjl5bBl4ftLuRpqeBW42otTRnQen6yHHdxi2py2qfiGhHyPIF8SI3KVu?=
 =?us-ascii?Q?/Xi3/yQEFnv4TZhX2Rdm7hQ7rG8N393Y4GZIco4gMbIpieZEF9i5bAfzlHOF?=
 =?us-ascii?Q?r1/QLCZF/yI8hFYmqb7+uwCVuUgK7XPSqXQLn9jkNbA+KJsiOQJ0TqbmLtLn?=
 =?us-ascii?Q?6tNsmBisrHB5Jzf/Dz3GVYYDtOV7U6ei7KJla6ZUHGUtupwlpjEBLTkTDbI7?=
 =?us-ascii?Q?KDT/e8Wz73Jfo/Mqm2N70vT8B/CwuZChFLzEd1e/PQ8T7sGSGkAcjhec/f3S?=
 =?us-ascii?Q?DN1d3OHxQpjAva8btSJW5k5aDvUokyHTKYUJAJQBStkoI1WZ2PzFT25D3U10?=
 =?us-ascii?Q?ygeE7YIWZCygVfmaRnMgqcTMUo36foIBkKTDgwKW9qfScY0E8podP74q+gKs?=
 =?us-ascii?Q?gSib5D1x31OO27ql9SLiZ41DwMV+FcLIclN9hWnjH+Gr0h6M/6cwjzovZ0bA?=
 =?us-ascii?Q?Q2VD1sfsqfuGFoBZYAglowNlFgioxa02RDul5jaw8V49ZQRJLX+l9lFDq665?=
 =?us-ascii?Q?Zkyy5+aydGTYAbKwMIkwTjvKPb3b02dkE+R08BJha6xba8j0yggArGDnW46D?=
 =?us-ascii?Q?GpirMRaDIxD2rZxkaaRGP4txMccWjwVJkMWjhE0s+ijicD/uJ7wgs6GusXYl?=
 =?us-ascii?Q?QxUY/LICZ1m5fpUUhL683Uy/hGGB699+cWs4UA5nyfxKcYsECkLHgckON7Xw?=
 =?us-ascii?Q?TTfrJQHsO872mxcBFVKLoWXpvrpnHLcNOL8yjuXdZXIeluJ2iiqJENNeFMVH?=
 =?us-ascii?Q?QpoqIW/fyu4iWhjnwzc1heHvspadfyD1/FthkNkqWizTpaxbcbKBjDx6bFFl?=
 =?us-ascii?Q?LapyH7aNAkBVMnpK6ARdMzeYZU4Cm3BOvQcVlzxqLqeiLpyNUBsqWw6EJGR7?=
 =?us-ascii?Q?lq+k01qghnlBmXYD6ylKPnHoz8REnd722hdpibx+Mhk6nX66rQVglBKOa1Ie?=
 =?us-ascii?Q?L9CYVvFiv7cF3rSl+rGL3R4CxxRaPzs0ACa9BE2Mm0Y3AOHA41yFPqbrnose?=
 =?us-ascii?Q?/5lSghI9RJKjfCdeoViS6I7WG9VZrIP6phTZhI3r9G+RJVs15kwYW5Q9A2rU?=
 =?us-ascii?Q?oKb523WxSHe5nMyfnSEML6wJvWRAWJ0P6v1+IALle39abE8OFIoGeFtUrteV?=
 =?us-ascii?Q?ew3h0PpTVllKa4qhwMmYccvfEtT3Zyde90May+I8KmebFsIpPG1fxc+97mDO?=
 =?us-ascii?Q?/loYfI9V0iaKazaQ8GzSISSxmtCifaseP89xxe2DOkBvKD2l7wZqZD//s0/M?=
 =?us-ascii?Q?iNsIHMjjdQZZ+R2L8D0/0UZ0SkPL4P97MmSRzrX9UHbrkDDS78EmW6/IZ5n+?=
 =?us-ascii?Q?U/mZDVpSNVGAR88IwXB2tBEw2jFgClqB9vXUSzqt/ZG0wbqnC0kSCTb9Gmks?=
 =?us-ascii?Q?mu/s0ww8MwL/OUmpbrGxD7jFY42LRxYCkgwaGIQl2CgDf8W4XiA+eBQn98hg?=
 =?us-ascii?Q?HeLX/iehnNAXH5RNT+jq7UhsojHpmup1EA4x49UR7K8qQhWD5E+PqSxWzAgx?=
 =?us-ascii?Q?PSXWxy2tLF9oEusuG3OZI5sgJMSn4YL4WwG4TAYljEnNih6yZbiNY842VgSQ?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0bwT+69r0af6cnYJVa402sOYrV/7JHsZ+LYH0Fs62+LykARYj7ATVBUsjkL8hItKBXZlwuDnhvpTMuwj2B2QnCOIifQX1XvBKPAHNQUyh8Fiq3D/rL6tkSZMwDs13G4Os/xYfJyCrQBtiqMKyK78fGPWMUP0mrC+ZLCC4/fhm/qv8QamqfR6pq6t4w6FDFSR80VYaGW5iEvE73ylH5028YUfJapVADCHZa9fwPQUosVcbO1jtXMjQtAh7o75LNZhKazgRVuwABk8Xw2956TC83N1eY/ShJLuX3NOeEDI6VW93/TbS99JpX0Nvjs0HpKrZwck7ns/WoRhazD1hsaaTsxr6mCqrtTWeVw+f83OBqCtZ4f40HSc+zS3Iag1xRCkjg5lV5s3xZpD7gMri6rTs4BrmJ9A3Tz0mzBxlzPhoUDIeh+0xBVBND0Wb9k0Aq78+rawheoIiSMnFSzSm+4986bklLWBIgIDJx0kAJ3Y16erKzdciPwoWTVA7mXuwXX0GHA7ymjlgGqIWOVfyq4NFsCJz+8n3owUOEx18Vh8xgKARvH8I+dNmJvoIg83kbJ67zlsTbXWSG2NQepfG6YEh2ztS9onefZhjQHZmdCBhZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8b9b24-cf4e-4976-b236-08dd5a49f7f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:53:09.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtwkXCCElArKM7iRyprNH3RAarrZXGpaKJf0Wc7ZPkAGSkE72ZM1NhB6QuQUfefhp6cSP1tQeP2GWaxvLHeKm400bwgheD8RHWbu8b8n9gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030091
X-Proofpoint-GUID: MU0vEYdp33FCZoqxRJmJi3efJHcKCSfw
X-Proofpoint-ORIG-GUID: MU0vEYdp33FCZoqxRJmJi3efJHcKCSfw

On Mon, Mar 03, 2025 at 05:09:17AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> covering the vdso, vvar, vvar_vclock.
>
> Production release testing passes on Android and Chrome OS.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/x86/Kconfig          | 1 +
>  arch/x86/entry/vdso/vma.c | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118..c6f9ebcbe009 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 39e6efc1a9ca..a4f312495de1 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       text_start,
>  				       image->size,
>  				       VM_READ|VM_EXEC|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +				       VM_SEALED_SYSMAP,
>  				       &vdso_mapping);
>
>  	if (IS_ERR(vma)) {
> @@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       addr,
>  				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       VM_PFNMAP|VM_SEALED_SYSMAP,
>  				       &vvar_mapping);
>
>  	if (IS_ERR(vma)) {
> @@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       VM_PFNMAP|VM_SEALED_SYSMAP,
>  				       &vvar_vclock_mapping);
>
>  	if (IS_ERR(vma)) {
> --
> 2.48.1.711.g2feabab25a-goog
>

