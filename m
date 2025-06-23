Return-Path: <linux-kselftest+bounces-35628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0EAE470A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5277A4461
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697C2673B9;
	Mon, 23 Jun 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Idh4r5nq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cy2aVCeu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE4266581;
	Mon, 23 Jun 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689596; cv=fail; b=OPjZZWQIoeTaHlLG3Ch+5UAxNrhVrv+eTLHd6ZEymnQslzeKtfzz6VI7am8oT6qUnMxxq48+vRVMOp7RqnaAvctTXO1c3Gi/GW4DSqxIE2CNohR1/0yNSV+/6f1bWmDSUBaR70BijAaI9Qy2lwhJ38rWUGaaHX1bkxR4JWn3hhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689596; c=relaxed/simple;
	bh=qCHUm/o0h9cBFXIdpR2rImnEPji5oZtFAF8Rc7whiFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kd9vpHMP+40DxV2utH9yg/Il8tmaQVka9usBscpfzNqwnlS3vVzKkpE32FSSkM90jWyr8gpI/Sihr7Eyz5QX7WG4ICPf7P2ebnTSjs4FyKVhRK4PBCU18WdbduqrfNcji8PxmT+OlGuAbeC4Mh0lkdj5wnYQ0asTjpnV7TtnvL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Idh4r5nq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cy2aVCeu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCivPf018291;
	Mon, 23 Jun 2025 14:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qCHUm/o0h9cBFXIdpR
	2rImnEPji5oZtFAF8Rc7whiFk=; b=Idh4r5nqBa38a3WMkaj+Od0kjIIlg/lfoY
	TSEhlHM2rK2HfAUwi+eMgzmj9kkhqBNaeKLmxQp1MzgyED3U0SP/d3Wqls3Rutfu
	gHGOf4/hE4z9K//dikHC0JRp8qodkTsNDJG/7fc6+jnjx0LZN+HtHG0bxSInUkKc
	lmcR0a9RIIEeqnqvP7PVwCAhJzTvH8X2VdQB0W37l5JexrTefmXTwOLEIfwJzpne
	77oyPEBK82MCZHafOSbRW3FiUX8x++kXRjw/i8RQPopE+BMfGtdYos2pRwehrv7k
	63EAxdcFN39p1x8qx3ESP/0cmGGVA0FaO0YWU+Wrokpk3EwkAUHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5hrwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 14:39:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDpjNK031965;
	Mon, 23 Jun 2025 14:39:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnx0wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 14:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9jM96BEuDQivwyAc290D3We2HYq8CpSykKGQ7LArdlMcFkvo6n0VfSP1TLc1BaflE3+rXE7LLTcpBgNNqKSbPQW3q2rwPD1MoNDPwRXaAdbVe3svPqk2qg4P1bXrnB/aQZmeaFLGQqCywKDY7tr43wwrdd6FJCmW9pfS0SrLqy6A10ju1kXTIBK8ggzsakaukVFka1aYrxLmYr3bX/SvgY+omCGv2pe7EMg9j4OjZUeS7TgTLR5zBs7WlSuqP/52uR2ovojQTL3R6XApOkGabXNiji56+7pGhm3Q2XLWqGR+QGrjgBAQdxX+ZPpLt9kWc/RMzPDKS0SKU1bYjsabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCHUm/o0h9cBFXIdpR2rImnEPji5oZtFAF8Rc7whiFk=;
 b=yFI2sjoM116MSTDoSksCGQNghy5kZ5sQJRtZODo64+m+szEFNNaEIg3EDRxNyVdDB6IAZek6bNwGE5ia8hIgL9eQkemz0EmzmCmsU19+l89NcLYu8QOdYc5aAfMEmm0XajbiuDTHgEwYWaDGuxf9KdwIaJ+YlRJz7jUIMVzjkWZ/7j4iksDmOdmi5gmHhr5dmmWR9AtNiOMNvmWCaXmkUlcWnJqdEjYZfTuC644VT0SXNm5W9zHRW12RCWSMD2YN+WLVJboSlb0+9W6Ap5x6uottaT4R0NP65K1sqnkkRqdTDEk9NlGBQnQkPDHgAIZ/+4A5PgEyAovEg0EjR4WGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCHUm/o0h9cBFXIdpR2rImnEPji5oZtFAF8Rc7whiFk=;
 b=Cy2aVCeuxtUdjqTKJVoQR2xtrgQ+DFoKWqOVXyHm/YkH7flAemdJJF5tcPC4npAkfOFvn58N3kLBBcS7GRyECnTA3VZ+XC8E8OrmYtQlDpP5ZcLZCdXrBweMeDJw1vZuuS1vtRf8PglyVoww6uANvivTid1JNCgJcAN84w1FAhY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 14:39:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:39:33 +0000
Date: Mon, 23 Jun 2025 15:39:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
        david@redhat.com, gkwang@linx-info.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, p1ucky0923@gmail.com, ryncsn@gmail.com,
        shuah@kernel.org, sj@kernel.org, vbabka@suse.cz,
        zijing.zhang@proton.me
Subject: Re: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
Message-ID: <4af59ef8-bbea-48f7-a207-8a92284fc34d@lucifer.local>
References: <6CC829BF-E6B3-4115-9256-11248BB39F51@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CC829BF-E6B3-4115-9256-11248BB39F51@gmail.com>
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9cca21-a8b5-43d6-deb2-08ddb263c501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vb5UWhek0KNHykJwobwQvCpiuymEyY+fAc3TPLS6uuT4dwCPk8AA7soVNe+J?=
 =?us-ascii?Q?0nYBCb1nGRSB+0oEif087FlwNPenZ1Q5tswcJSi3oo6g4GErxbp64fHHjAUC?=
 =?us-ascii?Q?j9sWEZ1oPAytOXod0DYpZvs20MRlzp53X4K60ZJ/K4EFuFzUgXs8WjzrFDsY?=
 =?us-ascii?Q?XSoX0A9Pb3ZTdBU/0ZQS/zvAP3//ZFiAMErkwOCyLOszlPvJGwlJ/ZFs10Nu?=
 =?us-ascii?Q?64gqQX8F8UPTM5ROffXERHMZ9na0SSg9dzVaicBDoesDjUpCrtO7V5Gr5hDY?=
 =?us-ascii?Q?QzYA5Q1rYhMjfKWGsEOY+n4omp1u8UGJnBmd2iUni1j81+ZIiwWmlSQRGpaE?=
 =?us-ascii?Q?niQ9DA0zbpbbYQ0G+fXz2cw+nZPkK9zX5TYQPdoLVjeWuWgkGQXBlp2ElDgQ?=
 =?us-ascii?Q?HbOj6PLYH9CmGz/rprvcbQEkV0HvOVIN5ASpr5nOtqNeucWI1SEIhpJvPJ5C?=
 =?us-ascii?Q?Q4YYrw2aV02YPijFHoL2H1WZ9Q2mANuJK/agz7/K6I5nGlWfbfzsa6KPBDPx?=
 =?us-ascii?Q?FTMUJEwpXxWWTP/FITH4zFrpw6Nqz3D+QZZfjOxHK4Ysnk6Y5XWAgqSbZs0j?=
 =?us-ascii?Q?bjjZbOSefHzHjdB43+0yDow84Iz+Wl2B5FpsmEIC5V7kbM86LnTu+rvKe2AL?=
 =?us-ascii?Q?GuYSEcpUcKgGcGVm21qt5YxF7tI6mpBKor6xC1ZKKv1qPwb2D5sIamktXK6S?=
 =?us-ascii?Q?/8RRPf5KZXLb8nrDWitRj+71Z/Vf9lJvHHPl4G4HwEGwiqjIbSUXzT22VFwl?=
 =?us-ascii?Q?HNPRisVvyKIzTUn3BEz0uk+NbdkzJyAVovSOyYFUJKwvvb0kDnaiaVFhw+73?=
 =?us-ascii?Q?lPXwVa+OlS4LQ7azcXEzZbrWUOL/Q3yXVdvoobaHwqKhGJnitdW7ujvrVFMS?=
 =?us-ascii?Q?crlxGjWWzW6BNLL7a8ZEwbANVz5kAoaIrwhLbXXRQJsQbTO1hmnaLeJQHXiL?=
 =?us-ascii?Q?sv+9C/7gxTABYzgVfKTElQI6HdySTznyRGGrnjyE3bRu3QtCs/vWZn0KIIZ3?=
 =?us-ascii?Q?oSBmJpv4J+UdTwtXiFPqvB9IDZxJk7t7j6w2Z9uVoVDJbOB+unOUoMTYTWIM?=
 =?us-ascii?Q?ypQ0kuU4Bf46slAFz0hFjRUaJ7jadJCbARMi+lBSVZvz7uyMrC4AcD5hvflO?=
 =?us-ascii?Q?67LS4rK4kZehkZ8e5dAip9hCCbvricDyuLBz78HIrbv4o7TFeEwz6+YaUC7v?=
 =?us-ascii?Q?HErmy0pLJ3rb7PaKQgUQ8QMDMcDLrUvs10VGxfvafGNosm+/Gzavg8Txr7vR?=
 =?us-ascii?Q?nnRccxnahaCSorXjME2SFz8wDXFrvka8BeystcreO2fuOG6W3A94pMI98rX6?=
 =?us-ascii?Q?L0YUaOtlHiqHot2F73f0kBeDBALDT4eQ2WvxKg1t+ySmTrEGZn4WmGaPjjil?=
 =?us-ascii?Q?6x/oNzrLKICpYQxPGn7re4yTJH5mnsKFEMRruRmVBl096XLwdwzRLjCCmCk5?=
 =?us-ascii?Q?Q6VYg9UUwZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEf4EIuMRg+bI19/eV9Pip4lgeOX+CyFWkkLsYAfpcOFb3uR2nBI91tEJRmy?=
 =?us-ascii?Q?Nrs3uc7KLisKuhmpEAj8+EP1tlogxPMWw/inFz78ZhjJGzwGPp0UeWYW7A6x?=
 =?us-ascii?Q?WFWI/4HlutVcmAHf35f8NJXFfuaajNn2Ep4NLOA1h7AyM/W72g/gDgmrFcd0?=
 =?us-ascii?Q?zteYoTG8GRM/9rDKX9fly+FiQTQzlHcy4OCz0U2v+D3HfaR3r9n3Bfu/pzFJ?=
 =?us-ascii?Q?/FOW31nJm+ZYZrpcCnmKDmr2jvknSLHRG6JDIFZNfus7VIx+iXTbCA2nLlOD?=
 =?us-ascii?Q?cDT64Pu/jHL1ovlqy/KWCYX2L7FvanyJuiesFwX7k5pZVBtjEa42NwW86i8d?=
 =?us-ascii?Q?zdxw4Ht69oGinJ9riIZ7gpcFjork0povddF0G85weB7edWg2DGP9h/rt/JyX?=
 =?us-ascii?Q?KL+SmqnCF39JY2L1WJBtdzT579uRkXp7PN2BGUF+UzHUhW9BuQi9+VCBIb3C?=
 =?us-ascii?Q?tFxB+RfBs2A1xfOQVseTVLmHJZbMaKqtlwquAdO+X5aV29BoXmRmsPUIwCpG?=
 =?us-ascii?Q?UGWDPABy69OoKxViZ+LoVRSP9tvXJi7poIcSCZCgg2emfC3l902Jl0mLRqjK?=
 =?us-ascii?Q?ha4JxUIoyDjbHVQPBpRovzjejn/lnBa8Ty4DDeonUCglUkhz5olVFmVl1oQU?=
 =?us-ascii?Q?pnu5zU5RsflWAqa/T2gUzF4ql9pFlnSmLdTpTQ3/ggVpyloGXXhlRe/n9Ty5?=
 =?us-ascii?Q?oPN4nS9+t/MvFRqRcju6FZHje0g74IEU3UB7Q67rrWcIUzngyBPmgC+YmOhn?=
 =?us-ascii?Q?3NLIBu6PM8mSnP+3i088Ezk6zjVUuvtagVT7E7cUmSGEPp9//pCq3Bhirr4u?=
 =?us-ascii?Q?32kerY7GjMYClF8LPjr3Cx6HM6RNverncahDVQT4VErRtBDbWdHmzRA6i97C?=
 =?us-ascii?Q?iI3DIBPLbmTUMyhGT6g1SHbxpXYJUJm4A0IkN3IsHhT5Hyao7bc5bFfCaC4w?=
 =?us-ascii?Q?glm8nv53i4NFTMpVOG1KCB2hoI7iA+nV3pO0JZeJj7emLdAiYku5+gNLWt5j?=
 =?us-ascii?Q?eXLZRvUF/7iCs6MxRrNGtPDXGXPY4Bg976soddC9Mak+9ka+dXO2H1W820hA?=
 =?us-ascii?Q?vHeVOcUEIEKiiQlPW9upjT2E7aVSNbs9kQ8qdf7fWjCJiwrfdZO7gBa9RPwO?=
 =?us-ascii?Q?QjJwkKkoxbGn9SnZ0Ck5FGGyH1D75KrZtzueiGrJk/u40LgYUNn+7blqTBQ+?=
 =?us-ascii?Q?rU8pqzSVRs9otL6PConSQEjlNOY92pCbbDSQP1ZmQTq6zNJ7f6yN+CGb2Sr0?=
 =?us-ascii?Q?EtzDHfs3d1QYFY1gndhGcI/7hhFFxVspaIxqupZ8na5IsGxyI0mupLRkCgoZ?=
 =?us-ascii?Q?2DDhRjtF37jvHAha6oIPSI4ycdw6JMcIs8kZ3893Nj8UmUre0JaR/sh2nx2Q?=
 =?us-ascii?Q?hEDB6XFYB2rJHBUaq/K+rvK/Cu3E48cFFiH91cHvyekX8EYpxspuX1wu7FZB?=
 =?us-ascii?Q?Ot95/c0h1IedNo8MCLePV87p0OEDBkiE4T3ny2pK7tIu0HYiR7cCGcotfqm9?=
 =?us-ascii?Q?577z7JwK3FKPc/jiccG31qymf7CW6NcEhuWUJFGTjAun8hByorzKfRHqyCVt?=
 =?us-ascii?Q?0QyhDpcieSOqZSyCXbEIAEKBDySzKdFO33aLQwfZxBKQWfo1nwP9flGQHUd9?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tHFxPqLCUIhwW9QG5UUn8bm7B+DAV+EknAdxxi9+IknA/tp2u9QOIQOt/Od8ZU7+bb13q/TxGpaz7+4Uwxyk26J6Py8C4VdTdTiI/sxTcEjRwHpNTd1Fi0ffjfPVWa79G0gkPE2naR+0wXRkUcgWLE4/v4miPm3ZPF+EuYIVCz7jqjA3G62CDxzQW5mh0+I1pdY4nLOrs52PRhx8q69SHwvFkfgIjFoobaaHKt9ZB5SYZfXfZVr6gh6dJpft2RGMaf5YbmcYr23rIKwEVOa6m3R76mMUDe5I8ZNay6Ycw6xZZXTkM9pMdsoQ+PZlEquadUG7DAxXCG2zC3wgy3LesXB7x1ptzw2K00Sl9dAYWkybSV157S1XZVyHXyTSErGKI2Br9OcF10BsxFheyLhPKO8kER7dgH2kDAmHNfMqMvwZ4q9FbqGgEnLm/ieoOVCrhumCJdhyvvhamTTTG0H0r9nzmMBpNSHnWip8M2iygmSfKUWj/Vqydh88Y4IBvXX0hOEkfGSwS5SjgdSI+VdkeRZ2pIZoCJr9WnamzXGKoz31zTe++enVIiT5oxZ1RkPO7PPl9moSAfpGGse36opferTMwZiqiL+yO4rLmmJ6c0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9cca21-a8b5-43d6-deb2-08ddb263c501
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:39:33.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXiX0095T4lfnOckK0mFJeROg4FIRwrExuohCgXVUbiJAwUMoLj1di+FJfS8Hn8frl1DbqM9I8KOzF/5CwIPZv2RwB2sJzgGEPWtpjc9TlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=871
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230086
X-Proofpoint-GUID: YMNq8DMDHRm2HZDCwk8KIDpN9wKfU2z5
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=6859672a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=iJHxxCPDpdUA_kwTHNAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4NyBTYWx0ZWRfX+1jpnQ8/RWiK 7b4GFUd/5m6dXutk0uDOMBek2CO6rNHau3cVsRq2nHR/47ZiXLz+VJGm1fdzCnHfmuVx7nItOGn JSOZwHjt0rcrz0oSE9IKpYAYKurpEiuqljAQ5vaXLkrpwuVT9BXrDLLtfYEcI5XSdbBbTj+4NwT
 hA0zs4BQJWh086vuk2c4iphHuOICnxEGDv7VmUkOCIDZ8rAX3dbWZSBnn8tHWHa6V6tKgTWiZwZ kRkX4rBqjMJ4R0EIMChgtyuVsbAHRqTQcEXYxSMev3jk2MwgjnQKt6yMfVOlkg5KlkySFvsA20Y FYhKbCNcUerJr6qmAlAMiBGcLHfx3MQtDLjZrFQRQC2Z90n7zDFr18AsghrWXDDe8MibS/D+Xta
 1SZ9j4Wlz8AdopaY9RnNB81eAT8Y1kLz0pu/5c9wSeXO8kpAnRj/YT/GNbe/78Q5EYGOtQkI
X-Proofpoint-ORIG-GUID: YMNq8DMDHRm2HZDCwk8KIDpN9wKfU2z5

On Mon, Jun 23, 2025 at 10:36:48PM +0800, wang lian wrote:
> I deeply appreciate for your criticism. This is my first patch and I will improve it based on what we have discussed so far.

Sorry if it seemed harsh, I appreciate the first patch can be difficult (I
still remember mine!) but hopefully it's clear the focus is on getting
things right technically and this is all :)

Overall I think something more like a generalised test of process_madvise()
behaviour would be most valuable, as David suggested?

Thanks, Lorenzo

