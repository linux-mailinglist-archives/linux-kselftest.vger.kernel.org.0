Return-Path: <linux-kselftest+bounces-35607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6BAE3955
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1303B8B6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8705235073;
	Mon, 23 Jun 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zztm03ZJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xT8tt85y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190FF23371A;
	Mon, 23 Jun 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669306; cv=fail; b=o+HHI5d2LKDF3vMOc8EcBz+D0zUL8rWBViWqlG/+aJ9Mv5FYScF1s2Wk74MAk2JnAnUzf6djnDf5DG9WnMOJ9Psv7JBKiOo+4bkJ948ctYTTl1ls0lYQUj3nSmzRy92M27vE7di6Zv1M66IECNBvYbQCD9MR/iCryPzeRTDYTTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669306; c=relaxed/simple;
	bh=WqIn4Owr2KJq4badXKvLHVdu1DlCkqbdj1OxQOLGYxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G0U52IxJ3Gw+ctj+ivsAApIIK6Fm661ffzmK9pGF1oZonkE8QNnlWF/LzEgEB4FNpbL7Qp4TxvW3Jpg5br+82HZUa4lJDHOJSl5SkaYdVBjH04ru1R5/bc+O8GJX4MzCgOhn/wX2njF3cqURrmfFxJCnKQkdyK1Q9vKtrJoTobg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zztm03ZJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xT8tt85y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8pMSb000778;
	Mon, 23 Jun 2025 09:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LA4x6pxU17xnJR6DKN
	ZoS2HslwgYJdT3q6Y7xeZNDe4=; b=Zztm03ZJDULIjkTjMZ57dMRU7HcXRNp7RM
	W6EhzCi4OlK1rJ6iaTy+LCwFTUhol20L7f1za9qbz4FDSLWu/esJBW32RyeHH1Zr
	diqr7pjezdo4/27/e/p3qnr5nelOLypP7UAXctP6nnocr6LJDJpvw1eD1VR1N7/i
	HDBFgoXkNEUpd6+YlBLHSRGksdrKAyFeFGzIIHvzpUqlQQBBYO2GsVwnMVfB2DEf
	9SWRTUD2/HFeBe5jAeEICnQLMq24XaFN13++i50jne3rJOguMkLDy6weUZ3h62ms
	ymdwdFdW8WyJ9xpJx02RP0Kqys2FD5JQ+cVedqgF/3SGYfEmSUYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt795jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:01:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N75DSL005652;
	Mon, 23 Jun 2025 09:01:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq23d47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce2ljTph7Cm6lCXvZyqcHtfrkODWcNxj3TGBDHWn1mDWW6EJJ1YESjNAYzyWZvyIWEGbE+jLmNqsX3aGFjKH/2eV9geTlooVScBpGUU8Et5H/exKiym0sLKDdySB06liZRjrp6639vRUljDiWIdwzXHHpVd678xC8/m6x8sHC2HdvU9TF79MexTg+u5ViTnyqQASLjiLpw5WMY9zm0G9trIkkojllOcq6XEJE2aBuxfePlyCV4Gl+XBj5IgPLdwu9xhMao+CACFB5hCk+zIOa/YnLE7hT4Y6dr3geimR3SUUDFzBVW779MvuDfiYbFrXGrGi9nFVuYpkr/GWCWzX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA4x6pxU17xnJR6DKNZoS2HslwgYJdT3q6Y7xeZNDe4=;
 b=nAbeBGfaitCyk4aPqMPxlIj8XfNpHiyocEarsQ8fvA1H99Q5mwpy4MFqINlWumG6CkQO3nDKhrZcsJ8qeoo3ynUtaxzpL7/uJWU3h1rV6BPEzExOAR/tNE7UNYMDO5W41ojKW9YkT5NTDGKV1Yf5QEtgGGIUUMPahR0GTXAbxAqUIE3h3Pt7LGGbsD9TSItlCWH3wNPHlJkq6GtrsLnfVJti3FQboSephniJ55xIc7ATyIpOUFYRZPJxB3SpWoOjaDtHW9TliAP5yTfukvQLmnxkzCfux1eyGMQySHWdBJ3QxfXzqUpoMYqg9HkRwpoyvBrNcMFAaE+vC23Hu/82IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA4x6pxU17xnJR6DKNZoS2HslwgYJdT3q6Y7xeZNDe4=;
 b=xT8tt85yjFH/25udlZdu+KEhSVaqgnLHqso67lpAZZlBrbRi3vKzBjtYVIS5mUDgmmMRR8HyaxlwMxoyBXrcpJO0R15E1TUNjmWaFiEaFldvtVXxX1EelZDY71tlNFXthSOxr1vFoypt25bF7WU9y1rteFUHbHzwqbeTbqQTdtY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFB6A054FAC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 09:01:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 09:01:12 +0000
Date: Mon, 23 Jun 2025 10:01:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Joey Gouly <joey.gouly@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Keith Lucas <keith.lucas@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] ksm_tests: Skip hugepage test when Transparent Hugepages
 are disabled
Message-ID: <f76adc25-470b-47f6-b662-22583dc8cb06@lucifer.local>
References: <20250621004808.368878-1-liwang@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621004808.368878-1-liwang@redhat.com>
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFB6A054FAC:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aaf8d4-61f1-41b1-b752-08ddb2348058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73d6hjfFJISvtup50WzMfEeuPWAMn9W0PtZVDhOJrsIQ+38Gj2gXLO8rQ6JB?=
 =?us-ascii?Q?/XViIAh2ifzIf8WSCqsSikCL1omLHIQDOn62PISCSdkqP+Rm/Bl8fe5QJSjg?=
 =?us-ascii?Q?GGGpDyaSt3eqIIO7eTdN8CfUMhaoYf7J1eFOXAiDjUDcP5yxcZruZSi6JjCQ?=
 =?us-ascii?Q?MzhXWxQUT0P+yu0HcIRfrElivkGWFJ1uCfx3mQeiqzmAgyDJtS9vI8fMxJ2T?=
 =?us-ascii?Q?GpWE4dafnPnRpPWGNs/XXOydXtLfm40zqdltf1juM122VGGq1R00zgjwPTP+?=
 =?us-ascii?Q?3cHP1Im9lzbVfPSf9cjOpgIkInEcHPg4ditkGwpXWYYcgjIQ1ZZmMkeZOZOs?=
 =?us-ascii?Q?nMUNoncttO4/c53SVyp72DAitQYdsV/i/Ejo2UPHAtiJg5miphOoHkAll4mG?=
 =?us-ascii?Q?CfdPRn7GZtP72yKLKhd8LRd7hnvFxzFPiV2SlU/uwvt62zcMbSSRooXVBLJT?=
 =?us-ascii?Q?N5maNLWC055xXaSPOkx9wvOx4SRN7IjsHFDHGC3gnZaevl86Ls1zoaI7uWql?=
 =?us-ascii?Q?45s9hBjfMZtcMuNNMtxbdlhlILFoPmcluyvzVnnZCoUzZE9bfOavcvIIs24U?=
 =?us-ascii?Q?vBsod8bNj61yCxcTd+IuJVKiPvZag3UkNg7IfhOxF8kXmsiVFBxA8OX3ozOm?=
 =?us-ascii?Q?VMQgX+CtvD3u1CR5paBPBuRObh0MVxk8HBiQNUuvRRPo1j6q36cffuXFxYmo?=
 =?us-ascii?Q?XmB5hVT59Jk3+71lGG+bu1seiB2R6PdJFeGOeH5PjQXuwvJ7qn9cuRL2CrL6?=
 =?us-ascii?Q?Z9P8cGlXrGu8UBj0qfFrAMrPgkd7puxnNro/Tts2TXMpvTBoUlyJ49jrpIU8?=
 =?us-ascii?Q?J31jDQNETCbtWDCqctYpHQ/rHiLmbhB6IuQOrFywAH2ya86rx2NURKKGQNmi?=
 =?us-ascii?Q?Pscu6d8IlD7WYCn+0AUGQqJBPDfuocbQlWJb5JiCFeymMSum56QG851wpJiE?=
 =?us-ascii?Q?OBSblONy4W9hlhc0Iyl7SbI5sD0gQTIrvObfB1QCXz88sqg45ODJQJXUKwIe?=
 =?us-ascii?Q?3v/AgKx+kRhx8vstzIfvd1KiggHQFNjSVyNdinbISTRanNyWas8O7nDMU2LE?=
 =?us-ascii?Q?x8I1vei6ZtKI3h/n7Bdqd311chFo4qEzgb1gGOonT6VVdPs6zFCusyUdoDT8?=
 =?us-ascii?Q?uCQS4d+oIP8/xlHqjrUCscuSjFCX0ibQbs5WrMH7H409EelpKp4q7+e4xXP/?=
 =?us-ascii?Q?Xl2fGS2tqlXQU2OqfW5cQ12yHEgXY6liDguyCyj1J2mduYKf7N4kToTBe4tp?=
 =?us-ascii?Q?Vw+LhmbF7U8B3t8IJkRRtq6jZZAq85bI9IXtrLgSGE808VxVPBLF0cQsSaOM?=
 =?us-ascii?Q?3FNDWlVcn9Hc7QEVIfBinkf++Nu2KbRTqi59VFOmU8YxqcNn5+0hU/QfqNwr?=
 =?us-ascii?Q?4IwUtNS8k6bJiy2AOzVpy44Hjydd1lwXvWgQ4+TlmQGeDg1e0UB/99XUZ4MF?=
 =?us-ascii?Q?Ebg7ccbqzUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1AsXjYU9B6Z42y1N7tnLHTfmPfevR2L/cxhfkkrSgxmY0GeTU+3xnLZFlmm?=
 =?us-ascii?Q?6+4cZrchYRSF0mDYjyeL3yybgtb4TjgbSPV7MD6BOlKlBciFHJB8EKYExbVa?=
 =?us-ascii?Q?fxhrY091LgmLbzj+IDOzvC25xyLQeqfCKeyXwql3UVQvAR9yw2bOrylNHxPa?=
 =?us-ascii?Q?3R7GmdtBdCaIS5RaYiez6xzN/Anw9/XRXd8cdc3r4mGBZ2UHOKAl9iZl+bdV?=
 =?us-ascii?Q?Lqy+eqBsG06hgcdHFBthkfM9XM1Qs91hloishF9fQCqAAcpDAuOXNJVInDp+?=
 =?us-ascii?Q?LOnedZqDbCNDl/vd+iLn6bqGNraf5CxZaowR41vfTLXE7Ic6idMGb37TqjXB?=
 =?us-ascii?Q?RxtA4fvpBmHOVpdCWI/qVpZ/r/0poknflYqbv/XRL7Jg/IbPiuoM13gx7vvU?=
 =?us-ascii?Q?u9vlllN+CAA2kQcFxz6gIuB4dUnLSsOPScKOAy0rHjD87X9k31iReXVa8elg?=
 =?us-ascii?Q?mOWNaKo0E/nbsAgXA3KLJOW0eox2a4Y9EG8in/OuHDxzAg0+OsYZzSM+6RUO?=
 =?us-ascii?Q?cOvRfY2nCSb76WLQRSKziUC6xqeeu+Y6y8x/uMInUz/ANdDBgZsn64jlxHNI?=
 =?us-ascii?Q?S8FW0RQEtBAa//kJcCwT3JHJ7vGvqB/xb+orLjWO6sB9exLTAgtF0cgUqyUB?=
 =?us-ascii?Q?3Kh5QQJNvx9dV+Z6XvDSRncfWc/nEXnwmuyk8q5oIU1rznXeDS2QIJ0iiUWP?=
 =?us-ascii?Q?Qa/oW4orr1wffkaVPjSD5Dgq52Gk4F/8L0wj+3WYNE7JR+gF61SaPi9ty9nE?=
 =?us-ascii?Q?Kv5s2f8epC7grCsBMmWTzCifFXhya3DOFMZ6xAu3j/WEdTMDk051W/fjoX19?=
 =?us-ascii?Q?w83ro2gv4HyC/dQs+KDscT/dNQK+NWv0jU/Ol8u6HnNxV64MF6OqEPXa+NFR?=
 =?us-ascii?Q?BjbxuZ1oBJaq3fYmPK+Y3CcitA0OPk756zTepYSUOBZLPrYWFE96kOnnDVRm?=
 =?us-ascii?Q?tVXQ75uY0mANNzvZQLfDj/CT6rm+lCMfYcVoZatXXypicqdQfziXvbs95Xxw?=
 =?us-ascii?Q?BsHGqjtJ8UqrJ0RssSYw+rF99nsUeVHDS0M6ixZVhJOKOlW68TQ7/5Se/i7d?=
 =?us-ascii?Q?qungIoMBetbtkhC6M271hfKSoVxda2zUJTgiSbFzUG1j0ktHeUS452W1PfU0?=
 =?us-ascii?Q?LtbHQ2dwVNL5qMVc1G/4lv5AV1Thz6XOCPvpiT3F0cUn7hwlupLc735r9jzb?=
 =?us-ascii?Q?5mLEi3jv3fzCpwEuoIU9ASDjEAzWrpgwfCmvYtdtxH09LfJ/llAUzir4NlQ3?=
 =?us-ascii?Q?Fgq+iTTfALAFJbJYSqydvyIRexZgWVF+WV+zPfmrHpNGiBDnOafddzQ4Htdt?=
 =?us-ascii?Q?31tW2yz8TPIMiiI0jYqDxLz/BGBDHtMvNrNooTBQfzfBzMl5U7jz6ZbP1CNN?=
 =?us-ascii?Q?DqchWfSHTfO5v+IFZCH3dH8JrgsS8vBA4AdcdbCpeXj0ytw5Eh+Gz+6KiMZ4?=
 =?us-ascii?Q?fAJqdR5TohyUyIaiOxGNWOhAIs+d39pEhuMoghnqbeyMlzQu/vAJTHnWuggv?=
 =?us-ascii?Q?L0jcjJGnSlfrgc3qO0TAT26JSEi641WmJTY+8Ldhch5yfNKuKWOs1Ll5lndr?=
 =?us-ascii?Q?lZbFqzjZTmVbSjsDMXjyApNJrGIMP4/nHjlbiDAqRuV3ZUNVIhQpVDZrnCkQ?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HLguL4mRu9o90IJ4xafD3IjCYvrJFY1PJt3t2SKBN88k2h4aGWgRBbVj3mcG0d+lxPFEd5HtYJIpECzbznq8mRON9Th4SPrEszA+iDSMSIgouE7geUIVK3CHF6UCz5iiwpfEUX5Cp33dr6pFPFmnqnhec5RncTVyI+5AbN6C9hygFx0YxmxM6+9TX+Q8FXI1AojEz5W14EZEsBAYZARJXxScumS5AVfbhHJxDrWwCNuNaHXlqll4IR8+/eIzyHe6VCnXOMMx86njsq+mpl7I2QG5G9IYvuv6BnW+r0haYoU1ML0X/OH5oRQMXlIEBuojnsOeiccRXRaOib8DctPWbVkrdV079/xAZstRrRZ56mXlA/T/5lvKXBVGiAvIKJnhIZEqDHOlZqq1uTqpFaMxvNEjAzGNVURvUUEwJEsnUfqeUaOQUlPj5OcehhfFaCaFhFhcKh3m+sy9YgnjtgNMaNGagNznkmbhPsKQNCqWAVabia/4pcJ5NtZCZbyP+dwGF5h3Q784c+FN9lOpR1M7ANZuf1NKKhhDH3BjhQi4YrkEQ7qPE94TM/f9WLZ62ZP6AmS0YUVAcohVnIoqG8QuKTDhaqQZAr2yyTfZTGrlUoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aaf8d4-61f1-41b1-b752-08ddb2348058
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:01:12.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eC7Amu0146n9EUPVstszI16pl7vWvcfnMXWTCuZuMFrJxvKg/obumw7ENVA4XTQODWd22XYBL0/1DwwRZE1f1+gsWRGZs7W0HGEHNQMnY7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB6A054FAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230053
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1MiBTYWx0ZWRfX5g+Kv9+pFrg8 rhJxQbfjilMde8/uJu+OXq3vLZDjJLnNi95zyAwBsJKctE9zIGf3KUBi9WYOcG5ioDyDc4JkdiY eRefOxlULo4a5XxZfrHnWtigHBdbG5sYqQ27gWiG6MWmbXzas/eQsqzqhNVn5GUfan6Y7iDKVop
 kTVE5Kc5myJ5f+8dsPKStSA7lV3R2PGqygsEtWAPX5ebwgm+JTzT+cqujk7/mGu+yx3Aol1G8/C CxvxEi4y+jjU4LisBN+C2mo/83oYWtTPu89mJISOArt8aUFCzxp66V/uazD3rTrx4xbfcvUxNKM 3GpsxZDAKFJuTyWY4mtnskhRuJB5SYjsaIWU4tMhHPyikKiRjoJ5ujK/hXSIJKsb+/nSO6XeNX5
 +xffCnorMM/iPsIky4IQRq8eMogfNqgTtM5QSI/2BUA2mqX8YyZtttlYMXD17l6zRa9QwnV6
X-Proofpoint-GUID: Mt4Lo1loEpswgXVnSTRb_oAjKMRo9Vlr
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685917db cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=g-BRlrsfQ4kvXa414eoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Mt4Lo1loEpswgXVnSTRb_oAjKMRo9Vlr

Hi Li,

This is breaking the mm-new mm selftest test build, did you have some local
changes you didn't submit by mistake?

You seem to be returning KSFT_SKIP from a void function.

I enclose a simple fix-patch that fixes the issue, but obviously you should
check to see if this is still doing what you want :)

Cheers, Lorenzo

On Sat, Jun 21, 2025 at 08:48:08AM +0800, Li Wang wrote:
[snip]
> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index 8e1462ce0532..72d8ded87756 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -6,8 +6,10 @@
>  #include <stdint.h>
>  #include <malloc.h>
>  #include <sys/mman.h>
> +
>  #include "../kselftest.h"
>  #include "vm_util.h"
> +#include "thp_settings.h"
>
>  #define PAGEMAP_FILE_PATH "/proc/self/pagemap"
>  #define TEST_ITERATIONS 10000
> @@ -78,8 +80,13 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>  {
>  	char *map;
>  	int i, ret;
> -	size_t hpage_len = read_pmd_pagesize();
>
> +	if (!thp_is_enabled()) {
> +		printf("Skipping test: Transparent Hugepages not available\n");
> +		return KSFT_SKIP;

		^---- Returning a value in a void function?

----8<----
From cf6643f4232da4a7014082363896a2cf56eaa88e Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 23 Jun 2025 09:59:28 +0100
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/soft-dirty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 72d8ded87756..c0b34cf75205 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -82,8 +82,8 @@ static void test_hugepage(int pagemap_fd, int pagesize)
 	int i, ret;

 	if (!thp_is_enabled()) {
-		printf("Skipping test: Transparent Hugepages not available\n");
-		return KSFT_SKIP;
+		ksft_test_result_skip("Skipping test: Transparent Hugepages not available\n");
+		return;
 	}

 	size_t hpage_len = read_pmd_pagesize();
--
2.50.0

