Return-Path: <linux-kselftest+bounces-15430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBE953897
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD9B21802
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5B1BA87B;
	Thu, 15 Aug 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QJrW4vgJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w5SPtayR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D1B9B5A;
	Thu, 15 Aug 2024 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740628; cv=fail; b=mff/Muo1DbUDSZ9bCcLb6BGR9ao1DCbG7ho89eszHSCDYc+ycbuluSlIANAFLEtEWlJx3TOp1F/hm4XeCS5hgDQEyC9oDUQdQHyXO6lIAeWNohblSpzCG/v+x4/Np0dPi0lKCCYengNB5kwInEfHGWpnICqwIbzuoIDgrX6XF2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740628; c=relaxed/simple;
	bh=Dnyw3rrnysSXJt9c9vGf6REqw+vfgrOsV6lw6nghiPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nBU5YU4Okr+iX56SM8EpIREA13cgEBj2qtshFbDIpr0QEb050I8qvOQNHxksegj4MqLUtGZj+onY+2QonwwT/wpBOIjLhbBErwJVAQjrwj013uChGVulj4XE6QqB/Exusz/bnBbmaDwBPX7CZ3+6uykNlTDECXpOWkymfJT1d8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QJrW4vgJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w5SPtayR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtXWG012779;
	Thu, 15 Aug 2024 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=XlS9sUHAv712wclSs93heemn0zytY55iGfxyNeihpiU=; b=
	QJrW4vgJzS/iB8L8OctyS5eFdpzgWG3hhYMc6T7RhRgxEIRb2+28M5kEm24oKzfy
	Kek64z/HshJYpfk1FAJDG8s2sEo2HLdJBUMj7mZtMWTq+8O5O74qcVzCAfDeL3DA
	0Dg8pnodCICVQqyb4TI8JGxAx8Tx3BnBQVVmJo5d5/jQl+YsR8l1fyzAb4jdM1iA
	XRj1KaXnHadiB6hNJDP++qKo725BAzRnh2L9t1KiuNQw/BCliMc37Z8BFFRTSWH3
	NVBlVGgrsahyUxKZKWRNNUbjgJr01WEiXNSPqp47T1D8eSQpAerihHfBl+tETpZ+
	n44V5e6Ul68zhpqZA8D5/w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bk0t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:49:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FFRaC6006085;
	Thu, 15 Aug 2024 16:49:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxncc14y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:49:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paNjTVR9KZY8TAgW+t9jWgtOaguxmACe7zkAODS9MSHXz8FBia/Ti5QDSNNzqJWiuRlJSwtr8JgkaDQma9gIsVQPqwElVka9qEOguligC6ubLddaG6JRc6lhkqAgf9/eCCZrt6dTzl/ngcmne3WxW//9Mp1AYM48pccuFaX++W96m7ghzAoPRuJYNNASne9hc0IuXODuCOSD3LjE3kMkBy2I6D/Hin3hFYn8Nvhj7LSlVrslYVhSSamiQF68tAmMLJpDnRn8BIqbUv2RVUWcdc2zFDzkrktBOBNlOy+Zj4yTaX8qkxRccCAlRWeld+q81bNb2KC1edMYxcimaysDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlS9sUHAv712wclSs93heemn0zytY55iGfxyNeihpiU=;
 b=lyuQ+HN+sfHiDWsgIiyeltJRiTuC0w6V3yE8idF6e5MV32+AQMRQ3wKf0tW85ZZPfHybjBdbEW85oYvXcGZsIwSzc4Ixjw+LcFHnIhO6uBOxxP8DHv55XTvYPUNl/pbdXLZ9GAuHGT9nNTQjUmthw1dFSIi8t86T/0eqVblhFkg4NqgrUyMrdZx33AXGpM439H3LAvd3c5Nj9vPfQcb2Voci5gwFMJlf0iW2rC9CjZaZeaaNGcPhQHhZq1TymZHlSiBQ/B8qCkhSCCTYzQVd/pIb/xYZhKXUFxfPLSNLSLwVCMFzE61aoLRedDpIgaGSK5wxQd2A2XYziZrGAMYg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlS9sUHAv712wclSs93heemn0zytY55iGfxyNeihpiU=;
 b=w5SPtayRLijkr26LgBcKXyChfilngzPfpq77Sxnj/pE6x2K2uzDpIGETBI2PzFB0s/MJgThM3e6XMck/gxAcL62AJUsKzDKiSmJaG+9IlQBWcwbH30GhGm8Np6ssbns2Y7TtSf6gyaCtwd0bs2PjrutBjG8opQJgcqM3I/xnhNg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 16:49:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 16:49:52 +0000
Date: Thu, 15 Aug 2024 12:49:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, willy@infradead.org,
        torvalds@linux-foundation.org, pedro.falcato@gmail.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com,
        lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com,
        vbabka@suse.cz, keescook@chromium.org
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	jeffxu@google.com, lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, 
	oliver.sang@intel.com, vbabka@suse.cz, keescook@chromium.org
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
 <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
 <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a9884c-71ad-4f0f-4f12-08dcbd4a4864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9nMTB5VWIxVFFrZjZTOGVJSUUvNUlXa0hOZHdhaFAvWllxWHBqL3p6SmZ0?=
 =?utf-8?B?cElhcFhVQmJoMzUySEd2SXFkRXl6TjRDV25TUG5HZE4wNk9ld0U1T3RhRHBV?=
 =?utf-8?B?T2pEZkhnQ0o2dzlRTHlSVFZuRHJuamdjRHlrTzJqa1BFN0ZqSTFHRGZaQ1ly?=
 =?utf-8?B?L1lBZ0pNZWpwV1kzOG1sbXdqQ0IyMkp1YzJhVkRhSzhTUUJHZ3pKamh1SXZ5?=
 =?utf-8?B?ZnY1YmJPdFRIaDJEQUNCaElwcHFmdmU1V1daYkhzOXVyS3g2SzFjaS9OWGdG?=
 =?utf-8?B?SHFwaHZIMXcyTFFlai9yc0xOZlBSb2llZklsN0I2aXVDdHQ2ZDJxQjhXcWlY?=
 =?utf-8?B?RSt5aXRwdEZqTW4yb2lGRFE4T3BUc0ZtS0hXYzZEWXpHaUJwV1NkVVlhT1kr?=
 =?utf-8?B?cFZyTENxY3RieU8vQXVnSU5kckd6VnUzQnc3ZVF6a2R3UDlIaHVIQWE3VnNY?=
 =?utf-8?B?RWZBZUo4V1dyejhqbFRCUk9FSTZSRC91SkRpVFUxNnRHOU9YTXJ5aHcxbkVY?=
 =?utf-8?B?UWNZRld5czFIVUVST3VNSVkvSllHZVBiZFk0VzBiUkI1NUpEZTd4SXd4Qkpn?=
 =?utf-8?B?dDVLR3BsTUl2d2dDYk1aVXgwUklXNTJRYzcwbVd1UnFyaHpRZlhsYzNWSE4r?=
 =?utf-8?B?QitzU2UrWExiQWFIVnhxbkJQTFZkV2VVU05lOHFOdVhpTi9zVnBhanhmcjJE?=
 =?utf-8?B?d05XZFYyTDU5VkFGSURqRkF5M2RlT25JcG1tUG9VZHNPQ1duQ2xHeC9waG9J?=
 =?utf-8?B?SDVSMk1hdEt4ejFYbUk3eHlxNVlpd2doWFhXTHM5YjV6VFFhRitZYkhoZ2FS?=
 =?utf-8?B?M2ZmTm1BZ2M0cy84YWtBMmRIcVBWZGhZVGY3MFIyVElVaXEvaU9jS1BMTFkw?=
 =?utf-8?B?cXQ5WlhGL2grMnRucHBIK0lSRWlLbE1YRkFxTUpsVTBQVW9JcG5kN1ZoTmQ3?=
 =?utf-8?B?NWJ0cXpXVkR1cTVKYkNrdjFuYVpnTGNyUUxLZTUvQ2ZUYjdTYUtPd0pBaHN6?=
 =?utf-8?B?K2Q3T1NsTXFMLzErTWlwNjFQcTZvSEpjeW55dXJSNTBMd0ZDUG1LT0hFcHJQ?=
 =?utf-8?B?c1YxMkpyM3lHeERtZHptZmNCODI0dDZBemM5ODViam8vam9zeWhURUJ5MVc1?=
 =?utf-8?B?M3MwL0tLN01idTl2bHFVRTVzZEdWdHljbWRmRkxFNFlRR3lhekRyc2cvOXF5?=
 =?utf-8?B?VUlZY0Y2ZEJ1RGh5ZFErbUROZ05hWVhjbGxMc2xNMEFnNE9oWEdhWTRsTWNJ?=
 =?utf-8?B?UEM4QitaNFlwTExqb3BNWGZPdy8zL0RYR1RvR0RndTc5V0I1QThIcGJoQklM?=
 =?utf-8?B?SWNZUHhWUVRaTGQ0aUtHaFI2WiszNHY2V0lPWnJXS0xFR0dtMTdKNVpQRzJL?=
 =?utf-8?B?dU4wVWxTMkVvbVAyaHZCZVA5cHpWcU1POC9rSEMvL2xuWHQ5cmFsSFAxZmd2?=
 =?utf-8?B?QmM0SmtGajQ1QWp1VXEyeTNjTlpaaU5uY3F4ZGJ5N25VZjZscEZqKzlUdFBv?=
 =?utf-8?B?ZlhyVit5a0N2R2UxeFVpNVVnT1lrdUtyYTVSQkhkaU5pVVNzOWh6b2tvY1lr?=
 =?utf-8?B?Q0tTbm9kU3lLVjNuL1hCeHk3eXpNU3N2SThkalYzcVQzYlJKVUIzaG5Ed21Q?=
 =?utf-8?B?YUQ2VWVKZXYwZHMzdlg1MnU3RlpYVVYvNkVmVFFta05GV0ZyQUhEc1M2Q0Ju?=
 =?utf-8?B?cjhLMDhCT0pBalR4OXp1ems0U296clMzQjRRTGtxTDVIWjlDbkdldWdPWHF4?=
 =?utf-8?Q?59jkIEqzLOQi3IjY0qR18YwIoC0AZsZSAGXBUOS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdKSUFGWGtTeERDNzZlbEtNY2h5YmtiTG0xZmd0MmdjZmNoQkdCeW5Db3FL?=
 =?utf-8?B?WE1wQm5wWVFVZ2ZkTXZucW9VZlJXdmpSZEN4VDlkRGU0SC9ZYjdwWmJPeTht?=
 =?utf-8?B?OUxxQlJJd3pJaTdMM0pndVNOdkRrTENRaEFzWU9uQ3dGNFZwMUlxdEdKOHdi?=
 =?utf-8?B?WTcvalc1TjVWMStBcXcrWTY1cHY2V0FaS1RTZm5VTVJpeHROUWFTM2dLR1F6?=
 =?utf-8?B?VEFpRS9VcGtsdWJUZTlONzloUnJpcjR0cEtZazNCRUlEWE05OVYzTzB5amJn?=
 =?utf-8?B?R01IN2JuZ2tsaGVRdEdIeW1KMVAvYnlrOUw2dFJRcnZFRTVRZXRSSUF2UXNY?=
 =?utf-8?B?K1o3ZmV2Wlg5SHpYT2tWeFNuZjlpUG5NSStwbDZXc254THBkTHN0NXNRUkta?=
 =?utf-8?B?cWhHejFoakRlYWVsWmtDeGwxNDdLMVBCeTN0NjVubE9iT3NHOXo1QW5TNXg5?=
 =?utf-8?B?Y0ZSQXI4NXErM1NpMjRFb09kRHRDVDU4TjR5eFVaQmRBbDhRbkNBa21OL0pZ?=
 =?utf-8?B?MEExL295ZU5LcWIzT0NQM1RXbjlENno0YUtwSVVIV0xwUWlOVWFvT1M0OW9q?=
 =?utf-8?B?ejZQVkc0Nm5qRHdBakFoekQxdjNVVGoycVdJWFhTbm1vVTAvTTJwVUIzMGZK?=
 =?utf-8?B?VXgvS3o4cldNdGxFalFSWFc3Q0Fram04UDdER1czaGVyWk5CRTJzRHRPT3Zj?=
 =?utf-8?B?ZW9aV0tNWVNCZTVFSlEwUzdFcC9TQ1ZpMmE0aklvM2F5SE9ldCtkRTE2QVNV?=
 =?utf-8?B?QmtHV1FrNE1QSkRzLzc4dmZrSkdERi9hWXNkd1FIbWdMUnRONG1XQzVISUU4?=
 =?utf-8?B?d1BjaWovYnY2MzdUekNROEtuMmlmSXgzamdQRytXNG9MU2JVOEdWYVVDNStY?=
 =?utf-8?B?SXV6Yy9nemU2RmpwYzNBOFhkWVArKzJpbFRKbXZZcUEvbEZQaGNQNGxXbkNs?=
 =?utf-8?B?TEtwTlRhb2MwNHoya3g0VUx2bXJmQ1NsY2Q4RHFxc3ArQVk5QlBiQTZ6VGVv?=
 =?utf-8?B?TWJkYUVOTnBrWXVHRjNZamF1eUZjRlU5bzAvV2RDelZkdTlLTkdvbHRxQW9k?=
 =?utf-8?B?N2o4NDhRKy9uTEczZlF2U0FwU0FmbDhWYVJUSDlONnpKU01MRS9mS3p2b1ly?=
 =?utf-8?B?VUdXTjVuL243bEd2Q2VDYmJEMGFsSU5IZytrRjVsdEp3ZmZlVTQ1Rmt5b3hs?=
 =?utf-8?B?OFl6VzhGRkh3UVBEMzhEN2dHNGRjSTU2cE1OaGRlODgwUFdJdndsc29Gb3lq?=
 =?utf-8?B?d3Z0bHNKMXdoUHorR0dvbGZBaWNWTTgyQ1dkQWNvVkZuSEwveFFrNnEvdExD?=
 =?utf-8?B?S3JaNXRBT0JsM1RyTUsvNWpCVGZmYjlZaHpKMVpmc0NyTUNxWjZQaWZOaFdT?=
 =?utf-8?B?UklzS2llYjA4aXRoWVE2UThKTERqQWR6QXpNYkxNNUZjNEhyNnlyeTFDUlZ3?=
 =?utf-8?B?S0ZXSW1RY1ZRRXZYR2kxS2xaYS9VamVEaU1rZ25yM0dWcXJSN3lUeWd5Wnd4?=
 =?utf-8?B?NTRLUlN1aFBiZUtjUkVIV01IeHYwRlVRN2pBeks4TVZhMFFlbE5MeWtQaE9h?=
 =?utf-8?B?TzFkdTdZQm9vZ241Mjc3TWxqQVFkVlg5cmZVQkdkMzVBT0pTUnF2U2J1RHhX?=
 =?utf-8?B?ZkFPd1Z5b1Vib0JmbFpTdFhsTlBWU0taclpwWTdiZDRaQjNmQmxEQ2Jnb2Va?=
 =?utf-8?B?ZEZPdGxQMDcyMUNOakJRWUtkOXNuSTgyUkVFcnRJcXVYT0RHVVdReEl6OWND?=
 =?utf-8?B?RU9GUWtON044bWg0MTVGMzA2aGQyZmcxUVQ0WnkyMDZWVFZkNXVJR2swWFU2?=
 =?utf-8?B?U2dwdmkvb2k0aGdTdXF3bWtqanhZS2NTUkNUTXo5VXVtM1ZId1BTbEZkQVgr?=
 =?utf-8?B?YldzditXc3Q3Q2FGc2g0Q1FEaThRSmVCT1hjbnRTajRwNmJnVkFIV1Awc09V?=
 =?utf-8?B?Rks2Q2hJMkZpd3VyckM3Q0taYVhCVVlSSytRQUFwSDJuc2w0MTFOMEJEemEx?=
 =?utf-8?B?SDJ5dEsyZWlnWGs3SDNVY1cyUUVMeHl1MVFLUmxOM3B3VlRCUDRweDdKNjR1?=
 =?utf-8?B?MmJGTEZ4WWhyVkR5cEl6aE4wL2JWc2t2TXgvQWtXQmpXeG1QUUFaYkp5R3NQ?=
 =?utf-8?Q?q7f2iCWRi2ZsXwFtS4/SkdBIE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	45EUv6ZWi3/DnHf2H2TiuAho6smjuQkDP7sJGuNEgMAxfPQnKOlUM6JjAap0SKW29HwU5K+AqXK9ytAqL7zWIpnVxC5BLVCJ28XQ1nFkWNjwNPMFXSy3gv6fZJvij9tuxVcQT2/qf1+EnoncRo5+ooQ7rbtd0nd9VkdvsnhmwGI4IXm8SGaTQjw63BRPdx34jTRsmn2i/5XlHNIOBUuAMG4Z4Vmft4QWSuuTYeRIjOoeXBtdpVL4Wk0q32rADpx3KXNkgj2dVS/jqM1+CURpwigOnkMCyrRMxKEU07XswnO2ietthd2CkrghknLBd+N02t5siK6q1qfX6hp+HFF3JR3QjQs931pY715kQWsOjZHnLMqqdeVxH5AGPyC/Pq1gcMbwiYIXi8C0Vqgy90iNws3Yj37oh/TqagwxbOU5f7Fy4IOtER4QoYyOHF8Bj0bIelyAdyQb0Ed6vdTDFfMYwkCzlB57BAKStcRQ4YalG6Xj6FHc7egwysfNBFNx9tHYtHxOFyXNHboDBPE+kGdS1EJNnwyd4IqjnCYUj9hr8Ue7ws95RRg6/w7Lb7jlwVScC4dkR4sUs1G/wh/P0nB7K26hCzWh70wO/AKp/HCfWmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a9884c-71ad-4f0f-4f12-08dcbd4a4864
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:49:52.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wybTIiIugNwT4LCdDfK+VnSIo3PeO1jDgwXFPDM6mX0EM4ZBB2SMOn0fi7rLQvdvzucPDqYSP11igAQRnaSCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_09,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150122
X-Proofpoint-GUID: PZLonz7dwJbEpQgxlD4-k9wtIuX5FzaW
X-Proofpoint-ORIG-GUID: PZLonz7dwJbEpQgxlD4-k9wtIuX5FzaW

* Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> > The majority of the comments to V2 are mine, you only told us that
> > splitting a sealed vma is wrong (after I asked you directly to answer)
> > and then you made a comment about testing of the patch set. Besides the
> > direct responses to me, your comment was "wait for me to test".
> >
> Please share this link for  " Besides the direct responses to me, your
> comment was "wait for me to test".
> Or  pop up that email by responding to it, to remind me.  Thanks.

[1].

>=20
> > You are holding us hostage by asking for more testing but not sharing
> > what is and is not valid for mseal() - or even answering questions on
> > tests you run.
> https://docs.kernel.org/process/submitting-patches.html#don-t-get-discour=
aged-or-impatient

If you are implying that I'm impatient, I can assure you that is not
the feeling driving these emails.

You are just trying to push a patch through that changes the exact code
that you said you would test but didn't say how, and you said the
testing of another patch was insufficient but didn't say why.  Then you
send out this fix.

>=20
> > These patches should be rejected in favour of fixing the feature like i=
t
> > should have been written in the first place.
> This is not ture.

Yes, it is.

>=20
> Without removing arch_unmap, it is impossible to implement in-loop.

arch_unmap() is going away, besides..

arch_unmap() could fail today and leave the ppc vdso pointing to NULL,
mseal() would introduce a even less likely case of this happening.  I
asked you about this in v10 [2].  I elaborated in my response, but I
doubt you got that far in the email.

> And I have mentioned this during initial discussion of mseal patch, as
> well as when Pedro expressed the interest on in-loop approach.  If you
> like reference, I can find the links for you.

So the main concern is that ppc is going to mseal the vdso, then fail to
unmap it?

It would have been better to put a check in the arch_unmap() code in ppc
to avoid that - but it will never happen.

>=20
> I'm glad that arch_unmap is removed now and resulting in much cleaner
> code,=20

If you care at all about cleaner code, please move the mseal check to
where it should be - or stop getting in the way of others moving it.

> it has always been a question/mysterial to me ever since I read
> that code.

You could have also looked into what arch_unmap() did, or why it was
where it is today.  If you had, you would have found that arch_unmap()
could be moved lower in the function and allowed in-loop approach - but
you didn't bother to find out what it was about.

Liam

...

[1]. https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo=
+-8MuRJ-g@mail.gmail.com/
[2]. https://lore.kernel.org/lkml/3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5=
ntgk5a2rx@jkccjg5mbqqh/

