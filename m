Return-Path: <linux-kselftest+bounces-16890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C49670BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A657A1C21540
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CFE17C21C;
	Sat, 31 Aug 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5QK82eX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NSgCUilf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE3176AD0;
	Sat, 31 Aug 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099289; cv=fail; b=R0gOpBK6CDQJyMvkvh9MGGGims/DHfQy9aCnY2Q2GCLPzExgoUb/qcZJcuR4ZBEF7TIY40kT0YdxLZgMT7gDX7mTd3iqGu3uD9lZZkVXqw+VYVLW8kxWmlLuPmH6cjAqJmnSbTytj1OdRtIQHfrzAE+sIFY/9P2ycmRl34AASBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099289; c=relaxed/simple;
	bh=MYPVNZ/UTaj8K7reN0FHes59+7TNJe65OOh4+CxUgGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rsMYvv5dh1tZjVn6F85P+fnudNKAQpESnjhoXnFpXugn38tpeVk3UCUbALlxbq0oHJR52PXUU+LugzC/WmciFX9qNefuiVStpwgvm0cf/4twn2w5zFO/jpvufl5di3BIyFQvaYSZdCWvUcBCk86i9bsgP5inUHs4yakMBa1MS4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R5QK82eX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NSgCUilf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47V9nxu8008425;
	Sat, 31 Aug 2024 10:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=MYPVNZ/UTaj8K7r
	eN0FHes59+7TNJe65OOh4+CxUgGo=; b=R5QK82eXU0cKuvMlVSehLskrPibBv8p
	90iDWAKJyBR3t3M1wMB7WlOFiIaKkotaMm7mSfZdvBv/f39U01EdbSqApiDBXDAd
	dluVwKj3jiZG341fJFfU+UV/YtnuHAQ7X29K4w+4nFU7i/v3CIrJr4xqJahzU8i1
	9spLVRUBmrQVqELd12/013CvVPrdLByv2I+q6AxSuEgZYYhDp2xfRI2d2e0pA50a
	Hsq92fUs6ofmDEg+LTTwNvFSB6lkbFDpLQR43dJaA1PpH6iN2P4GqJw1kz81ksS+
	OwvX/6fbJlyKSseH68daBV5H6NYRMDQeUHqq0/SIg35n2I39t0kYO1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41c0e30139-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Aug 2024 10:14:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47V8nCYQ035400;
	Sat, 31 Aug 2024 10:14:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmcfb7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Aug 2024 10:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmZ06LWvq6EpcfyH4qiR4pfQGvsCYqKD8E8f3qrhqlc4fHvTNFxHdIzge5U4olkO9WNIkP8TRqNwYIf000A8QdGmTDtZ3nJIuZ6FRJrWN+ckLB8cIjUUoYp0yu8dVF8RMBUFLp3SlB5BDoxUPlbl+QRuH/m2D1I5wqYuJUY+fbdpZWNBr4xN5M8c8ASVSYd+JEJL0zMDUXhC/Z8F1Qtir/oKLekgS6yCKv0y9fKFb6CUrHHP9JRSqrgAEJGG2wwjsxVOHRWW/EyyqdVRU7fdeDtNuPLFKssTqZwpEp3MLxJTxyDvKZWkfHPzd99qbhjccYdPcaImKBPHYhyVfMlplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYPVNZ/UTaj8K7reN0FHes59+7TNJe65OOh4+CxUgGo=;
 b=nd6l1b0PgHJJdtOLhrniKnEx2L9TXUkW6Hp0r8Q9p2le/CrKTxYOR8Lt1phrgRYw92IVMkciASJT2u7XEXv5D6LR/68IFlivkxhHHTTuffxopK5DDBAX7P9/P1jX+oh1oTcQvjNzxBn064/bMTjjJESxA5yXd9SMsIeA2r0COSb18/ExoBNPVEZk4mYM3YL16Hq3TwYmwT86Qmlzn3aIEFNLF2Lnw77ct95dspm8Q+LZ2lEq+k4qFbfdRWvvg0L2l4GBbf3+cLxTU4vQT0oZI0jAWVhPtS3oHdiRvHRCQ2IvOgLbBdaUgWXQ6InreoDBi8F2XPQQov7unGXq9nPxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYPVNZ/UTaj8K7reN0FHes59+7TNJe65OOh4+CxUgGo=;
 b=NSgCUilfuWYaKkX3sNdhoF/5mQ9+YStUEgmm3Yiiz+3aJ0ECax4oyotSSBtLHW/nk/03sRbHLOG7WvHwUVQodfoRd/1RA2qA5OtCE6EzH48GVySItUHzaHr3qOsXs8uR2GSYKEyUwJHwFeSrNk9ovVkDe8qX4l82rPHn+BSGJI0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB7025.namprd10.prod.outlook.com (2603:10b6:510:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sat, 31 Aug
 2024 10:14:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 10:14:29 +0000
Date: Sat, 31 Aug 2024 11:14:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeffxu@chromium.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, pedro.falcato@gmail.com,
        rientjes@google.com, keescook@chromium.org,
        Liam Howlett <liam.howlett@oracle.com>, vbabka@suse.cz
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
Message-ID: <73baacb2-78c5-4bba-88e7-bdc587297a9a@lucifer.local>
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
 <20240830181546.43ed8e62c9f28d6f77dfd1e3@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830181546.43ed8e62c9f28d6f77dfd1e3@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f7af0e-d92f-43bb-d265-08dcc9a5b301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7wrYszHMhlLYiu0jClGB6KaKrgVugVPBWKj0i+HCvP8aupO/MrjEuImA1VPK?=
 =?us-ascii?Q?Cc/5qDw9w1tTdtDYb9si7rk3Ldi6UGeJeRKq0NPAXcPx02+P40AKQo3iqpGP?=
 =?us-ascii?Q?kHs6GlmcsR+PdY/QHlli5bQ41shUde5RyxdjeGgNwzG8n4qVE8V8U7jEIvTi?=
 =?us-ascii?Q?gaE7Ci1b/rm1Vmcbb0GmOSeYAD21nFYhRSjVa+Zg9bJusn3qQU1MgvTxmxms?=
 =?us-ascii?Q?+8UhLLM4FLThVt/Ci9QSYL55Vc3m5jazEhtS9203f/eT+TnSNHlYtl5Nneft?=
 =?us-ascii?Q?V+aDS8DjadzDPPvN8jSKwWteC0vEO6YkeRkDwiXWDoUOCB5J2jlDUV9V/m0g?=
 =?us-ascii?Q?K91xcv63o9JozKAuctxQWT3VWZ8uaR0YjgnvCsMuKpwTr756ZZfXmqmcedLu?=
 =?us-ascii?Q?GBLY86W1S1p1ul+LYyPEy2w517pXSbiBT9SB3Ne5b774vhUFJ+j42RRatsL5?=
 =?us-ascii?Q?+OBfKsPkRMe0rWbW4Qo9HnGiT1ov8EYhH17uEWqfOWbJcPcUILJLRZEQauEb?=
 =?us-ascii?Q?pMas2e34aWT6aQSgnbdi0Ax4mT4BEuF+YzkJWy1SKbPlX8aXaiavXAK8J1Vb?=
 =?us-ascii?Q?JwxZceZ64AyuW5eo8amDOVKF1Wylj2L7c1W/CYluneBybziqS9UuDEfTtWM6?=
 =?us-ascii?Q?LYE++iqc4c6Kh2/+skUymkw7DQI8lWfYYOczAwF3y1+HZgbDp7SikK5Teq7X?=
 =?us-ascii?Q?Ejm1emYBP9QuXu1vrpTtNUCcm8/mkCvz9Y6qc3OSDr2K8EV8mWGJVIUAkvkS?=
 =?us-ascii?Q?H2vYj+kAtbVl0wav5P8ZhaiihiyJMIKwLS43/hJHB4/hfDXLI92o8n4rxytx?=
 =?us-ascii?Q?oHtfGcI9abF88W5eoFlFp+iw2v2Xo/jeFDLO4+DcxVmUIsg3v9W5octLyiGp?=
 =?us-ascii?Q?3bFCOjs20oRpY581Yq6c+FFrfNpuNHWfLTkt3LirzQVnGklMOlpev5kPzyYy?=
 =?us-ascii?Q?Js5lAmdVo/NxKFbp95metVRJbBUJLllz12+PP6zJxOY6ZAJRv0D/vg0w/dnO?=
 =?us-ascii?Q?7huyTSnIwN+ZyKpTHf9/jZ1z8x9wUcOp5urvTkNVRN5Om3jGRO+O++3vUtk8?=
 =?us-ascii?Q?cb/4SrF34zl/weHmtJtduuRQ7M48ay0HLklXxltuvDuD0rQPYbU7sM+g6s8u?=
 =?us-ascii?Q?oTHngtQ/3+j6UhuS6vBOS2qJxgM7Dviyv+0QyTEaCKFgotb+mdz6Ene8zqKd?=
 =?us-ascii?Q?y7eOLUH0tTtYkDVVL1ObqbsKrLIuBB3kSlZi7RQ8UPH6P9YS+NMVKjyyPmJO?=
 =?us-ascii?Q?+a6dmqdcqbjOKIAfWIyNFa8tMkxwbI4PTLA2FWEOShAOpnHChc668V320N+n?=
 =?us-ascii?Q?Ubta2s7Pa8C9oPvRHCsSuFAEkqep9peVTXgQGJU35qijSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9Hk7PWzQMkLX20ZQyJ0jPPQga4f3EKhFmS7Y2svfens1AAP4irDT7MZLobH?=
 =?us-ascii?Q?SGZLyH8V688m8Rsp10dbifC65iqD3PHiQ2XqIY8go66zbeiChqJDqyloTbdj?=
 =?us-ascii?Q?GSxkzzCbPaJJZAxfJ6jY6tmtX5yxUTaqZ89mtXnoOZeIFdc0MmBNx+OuVnbi?=
 =?us-ascii?Q?LCWX8xeoppwMaGRQEqwBM+M6lsb8Faap4IRtYo+pjOZYfWMAjKppoEEHVVom?=
 =?us-ascii?Q?3xZnD2tLeMHKnIQaIOuc+qeUCZi7xbBGCBrqXV4mPvx9ZGSZx+ICJjqfcqzT?=
 =?us-ascii?Q?iDgSvVShzM28sYSv0DalJeFSk67na+sNmtvp/lvufTMK1500L1EVArJ3Y5Za?=
 =?us-ascii?Q?ZRAkNhuD66EtYan9WVj/hRv0rZ/EbqXh0XuTTnOT5xEYM+Ai64s8OyvVGs6P?=
 =?us-ascii?Q?JR9tCyVWMBPbxqvA99PYchDaxq0+2Zolb5eM2Yg429FJkH8YJlbafAw1V2vn?=
 =?us-ascii?Q?0P5XuD8Yv3Y7AWXdkWEP1kpR6hRWgJMQk7LKe78WJDzjtcL5wR7juS7cwzl2?=
 =?us-ascii?Q?xkO7hNop5Y+JVrLRIg8oYnkq4K7paYgELzkDR8b8jBaq0GhxdlutgOXr/0v3?=
 =?us-ascii?Q?r2cJKTGjCtxIMA+6uHcDkNyu2sNwiGeNBPszRd7YTB8825IGqFzue+ta8Zi/?=
 =?us-ascii?Q?jnMyfZPFIJeZHhOTkKDZ+sVGUfubZSgnXYM4Tk4yK9eEl+l8RThNVfSxhcfn?=
 =?us-ascii?Q?TPwEw87BqLc+Vp0OlI3Sy81fC6Japi+mr938o+YadZl5xlsi72i1jHxrkhGJ?=
 =?us-ascii?Q?9k0Zdj82Q1/ixsDuELKn5bS43evE8imWoLhBpKuRwOM8qzjmqDu4J7BridtY?=
 =?us-ascii?Q?cvr+MIW6MEa76nKwOu1hnNSPCG22SCHHlV6ybWO3Zauon9cfxJC8NahvaoC1?=
 =?us-ascii?Q?7Swgkd++/kw7mix3vtvCklWDwzOHbG3Q00nKp581IZjLfV6V+7OutORft0lw?=
 =?us-ascii?Q?ouqrJEC/PutB91j78ARux55bK5lZGzCa/8rWtY/sV39+h/Z/bEdrQGHXpE1j?=
 =?us-ascii?Q?SxPEQBoxuCzisxp6ObbO912fC+xMbP8eILLNBa1A1KnS/wwbu1/J2UIWr8LW?=
 =?us-ascii?Q?VwiP49yvKvHXp2RAQ2l4nyWceUFWDUaydemeToZOVfXSAjjmx92k9m3Abvqm?=
 =?us-ascii?Q?yPfFT8YkbxtT2vuYw6yFza6f9UEFMsgr15OrHrX1mMbkhYwVbuPC2+qEr81k?=
 =?us-ascii?Q?bPGTcBpwNW8lk1Ykv4Mnln7UDIj4CKIBf2r90ToCwtMXmCg1QxK8Vf65aCZL?=
 =?us-ascii?Q?3zbW061GkkT/zUZBB+AwnR7lq1XfHRKPDi4MmFEmmctRWozn2IeMZ93JqyRn?=
 =?us-ascii?Q?7j730MhyJKoOn8zj8ejgSt7ugaF3RP4ei0VIMdKYih+SBK8YxkHCqzMQsBe4?=
 =?us-ascii?Q?soVe1eeu9F7Y5vUWyRI914pBsJeOEND9sd3iSipu2hAuna/G99yoyKDA7r3v?=
 =?us-ascii?Q?StVQ1jenNPZpvBWLLy/5xLlN3A0LOdOXp/eXfds5WUfNipBwDdPGYXEno5Fx?=
 =?us-ascii?Q?p7jzNDu7VnERCwD7FckhG5EjiSmTZhlxhl58DQcYvaGEe/RQdHgoho/5rsZE?=
 =?us-ascii?Q?D1J+EIyARmniTe/EpvG5LBeU+IeDNT2V9npP+F+WyzfIZAAZxjov4ii2JFpg?=
 =?us-ascii?Q?Em11D+u8rVwdfzgkL4NZA+sMD1w8M6qwJcNNzJ4yAyJgRDkn4bhQyaN8Qm21?=
 =?us-ascii?Q?o0gUpA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oEoKJnrF4EVdncBMnnap2ruDz2wfEh6WDdYhhrb7l+AmD9QkWwSCLuQiwrycgIwNo+QwuWmAtGZl17GXlJQko+ghg07YOCuE4vXo1J8Revgs/KnzS3iJUr2q/A18GlpKFirAZWYff8qBfTTxIvZ95aDouJGA3q3JixmXNh7TOWQx/fZ8B8ndZaXbSIbHEvukTCLKH0MTHgZK6yeRMy3qdeIQbEqwWesUX8ydVBYEMlNYC49udwKT25e/p+jgWSTG5FH/Q2LaqD9W39XtO8mWShhbo5DEztQltYU6xvU4ZVHvSqJT+BaRSGWymqu7DfWZwWZKyYTUop+yH2vdpGdMoyQkGN1nXd0mK7imbTywGbFueTHNnLXQLiOCbCvFKGkmpE2dLjzUdacikp4SM9Vium1AEZg65MaYXyXLTZ9VMZOKFMNxsA3kJzxKKWQwuEFsmxLn+zlGwhwAPH24STVHgv7Om4rKG6QIwOSBRfyiypofYIDqmVSH56qZ7KkicN7rfSZgT91YoCndI1d0pbQ8zEQMmXH3eEVgrrb8kLCw0VglRlFcSATJRLoLnPAVquqHMeCOA9pdSgjCdMmQdy3VhNHjuwzKGj+lT2nc/GJyhcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f7af0e-d92f-43bb-d265-08dcc9a5b301
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 10:14:29.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68QkzI6PVhhwp2hUZxdK+nTqr8LsJ06nCb/i+g6rFhXbAr329KGOiFsEewkpxN0XJOYK0suuTfZHGtEEHwk2ZX8mF44yGpI/QHslQj18vDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_02,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=849 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408310083
X-Proofpoint-GUID: ortFeMbJ73XTs278dzct7V_EC_aLEAtd
X-Proofpoint-ORIG-GUID: ortFeMbJ73XTs278dzct7V_EC_aLEAtd

On Fri, Aug 30, 2024 at 06:15:46PM GMT, Andrew Morton wrote:
> On Thu, 29 Aug 2024 13:09:41 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Relevant section from MAINTAINERS:
> >
> > MEMORY MAPPING
>
> I always thought it meant "memory management" ;)

Ha ha no, I leave the managing to you, we just map and pray! ;)

