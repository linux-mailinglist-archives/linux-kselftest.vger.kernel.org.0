Return-Path: <linux-kselftest+bounces-14391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5C93FD33
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4673B1C21D2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8515ECC3;
	Mon, 29 Jul 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GblYVGEw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xR196eTX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023C158D63;
	Mon, 29 Jul 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276944; cv=fail; b=Yz8MAozUtxlQX4Ah+rm030OEkcgGI12E2xdvR0TCoJWmAxH8ZgAP49rJS7931FGfTlwx0jDsX1IhbtV0f+xYtihJqrcDquN2opNmuXt+b221Gc0iH1XbRaLu08imV6ROHUW12NTTRklBHZA8etWzAeL0iOZJDPHt0rX0Hl0H9ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276944; c=relaxed/simple;
	bh=LM6ThTtEvszqrlAzWosjDaQ9+UKWNxHlzsyx7basjRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUdoooBiel1QS+vZRaq12k3pe5UJQRVnPfEH8OF4zLKDyKh+Dh82pi+81z6BJaI54NFAzo/rNctEQauQNSP4zWDWcKPC0zXFUQzROy9GkSfgUAv5GNdpc71E/j1wWrxUc4RXeY6Serjv06WaCdyDG3m9lyJAwF6Tw5bguvtEyI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GblYVGEw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xR196eTX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMYpL011614;
	Mon, 29 Jul 2024 18:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=/kpJ5AoioEEOZ/Ft1/YjDgF9L91V5zf6IHtB7goQv+k=; b=
	GblYVGEwDGq/E+IUzdu2yyuUHITRJ19Rv8uHKb/irCT0HIOl0Tx+Q2GmjH1HU1kQ
	9AWwiGB1j/FkJVU5cyjhsOKMuHVujaZAhYx/Wg+ErToPIUiLeLSC/hFy79IAf5cb
	vI59IKgAFw6Al31YotCxXdW+VPe4ciNx/SaQ6Gp16yFcg/6Bt7CnfM19869eV+4y
	Ypl+QKQ/tZ8f6mbbdqBvANI2/P80P1p03kfoqRIQRxQyghdO7oJuY9guBLwZMVFU
	VEtOfCNV85NUsRDX20cw0e7TEYP+eGywhCtYMgw8zVOQMQj3YB+tkm6w9qleCCRV
	akCXzG4GXTwGnasQ6JEebA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesk9kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 18:15:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TH3G7U009220;
	Mon, 29 Jul 2024 18:15:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn666v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 18:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLw9MqRkfaMH77ktabYvYxUdGIhHdcYhl+jDQ65urpIb//ZoNkH+rwsGT7HrQaS970D7+/whJdaJkqVyzBvGMo64vtr3AY1hsBswyeo9JjOmOdnPcViN5p2vbZKxW/+wEHkZdb9pQJmoBPjcw6yau2zzvsfQ1ws2LZrtTeuMnY7rlkBxUJpjWZaefdgufwAfy5M84NJFMW7zt4hq311WH+eBbirK2t3caI0k/TQYku6X+tYPGo/uSx9MTRfPZ0lhrsVuufvsgzttbIAZiRJEQ0vMWe3tBtHRQYGGQR/qa9+Y1YJeSBRmFdAj/lyrYnr1jmMCz05lA4ZWRwuy/mu2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kpJ5AoioEEOZ/Ft1/YjDgF9L91V5zf6IHtB7goQv+k=;
 b=qjl2qEKT6EUycAdNNaBJnOlMqHACQ9yp3a09XJId+xXl733Xsga4/2SmLHLjOpiHW6gcUtxHvaF8chp1Hwk+2M+8ZKQ5xQSwp4M91wPnZUZiEM1mSe2mQZYn1epAFYEjd9dgg3DFbX3hyq1sdqhZOzNlVvCZyxoHTWjaf6BAJ/541WrmTTcaFcKy54DChxQysPtITpWLv0Hum+Y0cVtZR26LbuKM53L0AyvGaP0gS0cF4F2xaK0vTIR3UagtzhIZDnYlxkdYMwz78bunMGksDtidwQwG6obMql/XVkYfQPM4179C9Hd7e+XYLC8EpzMzGJvJQxq0WddR+XKAsEym2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kpJ5AoioEEOZ/Ft1/YjDgF9L91V5zf6IHtB7goQv+k=;
 b=xR196eTXTA2u2I6tGc+MA3DZfVVqH3JC61HwBawAQppfenYRVapG64s+nE9PsojNeAMDgIvLnkKRKDw7ZfcdF3S2ZwNfi4uA/8dRVnWJ1JJ8iYOFCx3DI6lQreCiwXF5aNgAsjJKSYbcq+q8ab+ScuKDIvqe1pCizjPsnbGYCy8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 18:15:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:15:12 +0000
Message-ID: <178ff26a-7068-41f1-a0db-dbd0749aa82f@oracle.com>
Date: Mon, 29 Jul 2024 19:15:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
 <20240729-convert_dev_cgroup-v2-2-4c1fc0520545@bootlin.com>
 <30ef4e63-02be-4691-b85b-e98c18d59e57@oracle.com>
 <87d70267-0305-4f4d-a7e2-7d1f8855e14c@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <87d70267-0305-4f4d-a7e2-7d1f8855e14c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0647.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0140a2db-7af1-478f-97b5-08dcaffa6343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2t3SmY2WkM4Z3plYSt2eDdYV3BPSDFyNFgrbTNUZms3Zm0wUW52dmxnOWZG?=
 =?utf-8?B?WGo3WEV1V21aajM3aEtpazlDdHR0UVVhbXVuUFhadlUyNGdCVlhoUklDa25Q?=
 =?utf-8?B?VnpPclllc1lRSjd0SXhNSXpRdldRaFluYWNuQzB0NC91VFZuWDhDNmpJR1F1?=
 =?utf-8?B?Tld4WENjRzd2VnRodFpob1dqUnk4c3hmYjN3em1oazFMWXNYeTlYZGFkNmhQ?=
 =?utf-8?B?WEcvSnEwekVMZ3ZRd0E1RHJUYTlEQjNOdWJnUytJc2RTS2kwQmFhaHdEOGhu?=
 =?utf-8?B?S0VCVVFLejEydlg2R1owZTV4dWRhSzJyZEVKbWFqUzRKSHcrT2Npd2kyaWkz?=
 =?utf-8?B?K0dCZ3NSMjhJRTRaSnNhRkI4UWROWXU1d1VBWGV0bzFjVmdDcGdsUXgrNDFi?=
 =?utf-8?B?TS9YaUluWk51YlJTT3ZvRG1GTW5sbm5tTWx2UUFvNGtBNGVLRU5lUThsZ09j?=
 =?utf-8?B?RjBmSEtwSnZXUlBVZjVtSStleExXVkMyYmw3YVhNalVyVm5zL3VveWY5czNN?=
 =?utf-8?B?Z1M1dzdmQXVlVGx1RHB1YUJrcFpoVngwUW05SlhHUlRlVWRIQXdncmdvbVll?=
 =?utf-8?B?NFp4V2xxN1oxdU4ySDRSSHNYUXFGZUNuaXlnUWdtNlFqZ1FwNXloZE4vNHdu?=
 =?utf-8?B?VFdYYlJLWXpzb0JTYlpBcUoxT3Bnc0J1ZlN3dDBETm1OSnlYb1UzMmVNRHAw?=
 =?utf-8?B?TUxnOUpUaWVSNElnbGUrdmF2bnBHeE9GN3lOVVZ4c0kzdU9Qb2VFb0RzNG9E?=
 =?utf-8?B?eXppa1pyNUIrWExMUDdTeEFXQXBmZUVMaE5yQk51bzhPam5SSU14SzNndHFu?=
 =?utf-8?B?NmdvdEpTYkN5b25QTmxWL002dmZIcWtTalR3cW9FdDVTV2NUdHMyWlpnZ2hF?=
 =?utf-8?B?M2ZBUHFvUzVFQVkyYWtkSzYvTnNMbHhIdWVjRmdlbGIwN0Z1MlN1R1dveFNa?=
 =?utf-8?B?ZFhSUzFnd05xWTJ3MnJHZG1jdGRtQkxtTWUwcEIzWEx6OGcvc0U0Mnd1bHox?=
 =?utf-8?B?NkRVNk1sTG9Ob0ZINFp2VTdsQmR2Nmc1WFlpbVl6a1RCemNLVkgzbEpNK0Uv?=
 =?utf-8?B?TG1STlVVMnNVajFaazZCYzg1dHRwc240amRSRi95RE4rVlo4SGdxb2xMeDJ3?=
 =?utf-8?B?TjVySysyenUzNGcrOXlVbDN3S2xDdVVyQk1NcGUrdVFLcWZ3dGJZSkNOMmxx?=
 =?utf-8?B?c0p3NzZpbzNFd0VzZCtnVndhOGJMNm92OXg2cDRwektOZkd0b1gwRzhpSm9U?=
 =?utf-8?B?TnNxb3JmUmtweFgwNndPN0JuQ2hOYThRY01WZVZlRnFIMWgzdXB1bHhPR0dk?=
 =?utf-8?B?S2pnaXMwUVdid05kRzhMMVNVWXdqaXdNU3hkT090RFUyNFAvWlk3eC9EcjNI?=
 =?utf-8?B?U2kzSlpEUG41cjhZWDNjalVGRWxmZWU3ZTJ2Nis2NnJCa3ZQc2VlWlBNckR2?=
 =?utf-8?B?YUFEVis0N3g0cVZSaVAxTjdsWkpzcUdkVVJTdDdCeHR5RVJqY21oNE9nYUE3?=
 =?utf-8?B?cjNONVd2THNDSDljNW5jWEdURlZXY2VZQ2VhWnptaXZBZHJsdE1uQzBDMGJB?=
 =?utf-8?B?bUNscjMvRUpjZVNWRTlxZ1lCcUk2UVppTnhCOVBRckJvZXVEall2L1FtRmZS?=
 =?utf-8?B?SEZFRkcwSzBUUUxNci92bXd0MmlmZnNHbVVvMXp6bkVDTUsyNEFaSUR4WXJV?=
 =?utf-8?B?NjhSVGNVMHY0RVdZKzQrbkNoWXN1L0RGc1VyaGF1bjRibDhWa0RwY0ppQzZ1?=
 =?utf-8?B?cVhjV0RvdG1nZTcvd20yTWhmM2tFU0Z1Y3NZTTArdXovUFM5citKeDMyNC9q?=
 =?utf-8?B?WE9kbkhXeExDKzZEeTFGNEo2UUdCcFRTc3dnYXM4NVlDMjUxMkFvaXNHME54?=
 =?utf-8?Q?0kEPoW0LhfXnJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXFDcDVRbERoNlBNS1duSk1SYWtZSWhGcEZqSW1kTWx5cGxyeHF6WDJqRVFW?=
 =?utf-8?B?SXBRdUdCdXBZaUtUeTVsck1ySFdlT2M5WW9RUW9UTkZXY2p5VDNNWFovR1dj?=
 =?utf-8?B?RXViY2VyRXk2Z1g2T3hlbDlESTBJL2tEciswQ2YwYmZlSnRSZHNqOERpU0Qy?=
 =?utf-8?B?aFNaczVFT1BIU0FIb2wza2MwZGdWUE9DTE1OdW40U1RKZFYxbUY3dkYvRklz?=
 =?utf-8?B?eWJ0RTdsUjRreCtVTVNwTnpRMXdQY1dyRXU5VEhCMDU2S1NpcDhzMlRqVWND?=
 =?utf-8?B?ZU0zZTNIZ2ZiT3BSMmZvNWhScndwaVN4YW1VZkNVNWRpSVlmU2Y1Ty9DU0c1?=
 =?utf-8?B?dFl6amVMdzY5MWV6aFhNSlYrMjhFa2U0UDBueDJHQTd3alZXSkxRUm1SZjk0?=
 =?utf-8?B?VkVaZzArOG4yWTBHcXgwVDI4bkQrQlNySnV5L0NpbmJnTTVPK294K1lqREZI?=
 =?utf-8?B?NjhMVG53Nnh5R1FXYy9BK2xGR3RzMkFFbTZOQU0xSHN5YzA4NHFDVHdjamNp?=
 =?utf-8?B?RWNpYlpDMlhQOUszQkZKUUNBandQUHRBYWU5UUxXbExINVJtUmlmTjdRLzh5?=
 =?utf-8?B?clo3U1NXRjhBS1h1Tks2N2owK2xFejduZW1NeW9TTkFhc2Vvdlo2LzdadzA4?=
 =?utf-8?B?akVzYldzcGpLVmxaYU1sZ2t2NmRKbWhZVVJlemg2aGhvdEZ3RVVvNEs0bjh2?=
 =?utf-8?B?SUFSdlBrR3ZadXA2R2lUZ2MzWk13cWxvOCtMd0REQkFjU0pnYktyN2lxdW1O?=
 =?utf-8?B?RytqN1ExV2ttcXpLeGZEVjAyKzFqTnVFREFMU1RlNHpNYnpRVC9hQ1VTNmY3?=
 =?utf-8?B?R24wd0laL0dnTkh2bVV2T2VkOEFDK2h3d21Ma2RGV3pHYmRhdzV1UmNWcEx0?=
 =?utf-8?B?NklHVWJueXNxV0hJS0FpTGFjWVdjVWRUbG9mNUNxejFPYmxhT2R5RUkvcHNG?=
 =?utf-8?B?UGE5alNOTzVONER1aVpLbWdBdkVhZDlabThDdk9HQzNURkV5V1Nvckw4ZTdL?=
 =?utf-8?B?NVF5WFBBMmxhbFVHTi9kYWE1bzMxOW5YQm5QS21TanY3VGwyZXZRdnJjakhj?=
 =?utf-8?B?SWZrQ25PL01XNnNlTzFNaWV6Z01WWmVZUkZhNW1iODBWTUVLSkNEMWkyaVdh?=
 =?utf-8?B?N05vRW5hVWdMcnQ4RmRhZTZwZHFqNWRGWmJlNTRuUWZ6dW9sL2E3YS9xcTc0?=
 =?utf-8?B?R3RvNGcxa1k0Y2ZSem5UY0FkUXdYSmN6UGhnNEZPWThtUzh5SkhzL0dUeTBs?=
 =?utf-8?B?M2o0aUltZHk3eWdMcjJiQzFTdkpDSTQyMEx5cHR6SXU4RjFSUUszTEZXMDZL?=
 =?utf-8?B?S004RzZTMmlYOVBicG1BdUZ5SzViNkFvR0NWV3E0ZVQwbGp3WDY5b2JjZk15?=
 =?utf-8?B?RHlacUZ5ZHVteFRrUHUrbW1YZ0NWbHRoQWt5OXFPNUZrMVliRXhESU1Mc0hk?=
 =?utf-8?B?SVZFV3ljeGFVcTkwcWtLejRxTUVMU0pMY25iRkYrblltVEhiVVB3akU3b0JN?=
 =?utf-8?B?QzExamY5YUwvcDlTaUl0aTljREh2ck43M1BCbVplVzVYSDIvV3JSOExhL0NB?=
 =?utf-8?B?dmRiNmxUV2JqTWY3NGRxbXVMbzQ4Z2JubUIzaXdoT0VuU0t3ckJXYWVoOXpu?=
 =?utf-8?B?S0dCWVhxWXQzc2UvemdKNVZyZU1OM0hkSjVwVjlmeUI2cG9EKzNwMkxBV1FH?=
 =?utf-8?B?SHNyQ2ZmakVVM3RNT2VodHE4MFNJR3o2bmVra0F2dlZtd0F0eU1MR0VScDdY?=
 =?utf-8?B?VFhiTXR4Z2I2S0plY2VvZnIxa2EyM1JkOUsxOWRzR2hVUnovTjQySjJwbVVz?=
 =?utf-8?B?Ny8yUlFwWnArblExam1aZWhYeFBTQm51WFRRTjFKc1E5ZzUxOC9NQXpVMWpB?=
 =?utf-8?B?QVJqZDNrZTJacU16bEpMZGg5bWhsdVlzM21jZU1Hd3BQQjNXdFgwOEpqeDg0?=
 =?utf-8?B?WjBEU0F1enpYNjB2VS9JWDFjeDdOUEMzUUtjbXBROUl4ZE8xbnF4UUs3QWto?=
 =?utf-8?B?SVpPRFdIb1NxbWR6Wnlvd3BCMlk2VFBzd1Q3VHFacnR2eWRuYmliUUlWcGxh?=
 =?utf-8?B?RzAvZlBCcGxpNW9iaUc5a0F5MTNCaTg2V2luZUpJMEtSTnpJMVFSMy9rMHFu?=
 =?utf-8?B?S0EzNTJlMzJFT0dDamt4SjNBZkxoNzd2cE4yWDlIUkFLbmpGT1ZyUUIvWjND?=
 =?utf-8?Q?2uwRBMYpx4yky4ku0QUA0eE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qNL6QRbrhS6Nw0I3kumyMRxpI5HIcqhs6J5YWnbw24jx9KocOcbzNiOcJ2IlAvwy8rQXOymStOPkgQk2GSDfe7cAUEYfPgx/b0mumG8UE3ty2RgBOBwEdK3N+gh7WQjBWWjiUzA7FUP6OGOFlwwORb0BI070Kv5cgE/hll0r5Zc2zQxwMzzuA3y3h9HyHvXSAHp1mM/WTCuFUdU+MEuRCsHtAdVtxd0q34/fUAgWoK9CTliQ+XGeqgBGGCqKvG/NflwnYBuWP7DZ/0DgHigdVNcLFCmuaWmAlaAjOqt9/MJJvTqoQ+zdJlwIBl0HkSXzsUpiuMo9jmpcYK4lK1/hhG0Vk/2JBkvf44fgBCAIvTrCWx+Kw2oAhwLy8VFEAIDTSKA0ytUvfcIUk5mfZR7qYCdlAEB4wGKuG+rB2a8gI+oYzJIiPC9dhsqU8Tel0w4/a+u6VYchGsF/sijgZ8eNn1Mycgt8q2kTZ+LehomSNr44Rr5L8mDtjqmAv8ngiUUXT4SFJAVK/gE8GFtT2CZwiApPgPry/otof07E0E7h9x1LxPB8l1tHD3E26MeZBUFFnjvqOJWL5dkic22+Rw4YygFnKKa32+Oz8cLdWgdP+tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0140a2db-7af1-478f-97b5-08dcaffa6343
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:15:12.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7TrXanJcrfVbLaV5cEcxR7P47pNFOjkWHQ5milpF/OeoRFcVbu/7skUPYH6CZLKjsz2zMDVNUPEd9s0Rb5u8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_16,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290123
X-Proofpoint-ORIG-GUID: 77SmT7QPkDBf2q-GCtcEDY6K9uXvtHYz
X-Proofpoint-GUID: 77SmT7QPkDBf2q-GCtcEDY6K9uXvtHYz

On 29/07/2024 18:47, Alexis Lothoré wrote:
> Hello Alan, thanks for the review
> 
> On 7/29/24 19:29, Alan Maguire wrote:
>> On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
>>> test_dev_cgroup is defined as a standalone test program, and so is not
>>> executed in CI.
>>>
>>> Convert it to test_progs framework so it is tested automatically in CI, and
>>> remove the old test. In order to be able to run it in test_progs, /dev/null
>>> must remain usable, so change the new test to test operations on devices
>>> 1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.
>>>
>>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>
>> A few small suggestions but looks great!
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]
> 
>>> +	unlink(path);
>>> +	ret = mknod(path, mode, makedev(dev_major, dev_minor));
>>> +	ASSERT_EQ(ret, expected_ret, "mknod");
>> no need to unlink unless "if (!ret)"
> 
> Indeed, you are right.
> 
> [...]
> 
>>> +	skel = dev_cgroup__open_and_load();
>>> +	if (!ASSERT_OK_PTR(skel, "load program"))
>>> +		goto cleanup_cgroup;
>>> +
>>> +	if (!ASSERT_OK(bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1),
>>> +				       cgroup_fd, BPF_CGROUP_DEVICE, 0),
>>> +		       "attach_program"))
>>
>> I'd suggest using bpf_program__attach_cgroup() here as you can assign
>> the link in the skeleton; see prog_tests/cgroup_v1v2.c.
> 
> Ah yes, thanks for the hint !
> 
> 
>>> +		goto cleanup_progs;
>>> +
>>> +	if (test__start_subtest("deny-mknod"))
>>> +		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, -EPERM);
>>> +
>>
>> nit: group with other deny subtests.
> 
> ACK
> 
>>> +	if (test__start_subtest("allow-mknod"))
>>> +		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
>>> +
>>> +	if (test__start_subtest("allow-read"))
>>> +		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE, TEST_BUFFER_SIZE);
>>> +
>>
>> Nit: should we have a separate garbage buffer for the successful
>> /dev/urandom read? We're not validating buffer contents anywhere but we
>> will overwrite our test string I think and it'll end up non-null terminated.
> 
> True, but since the tests aren't performing any string operation on it, is it
> really a big deal ? I can even switch the string to a byte array, if it can
> prevent any mistake.
>

There's no need, don't worry. As long as the size limits ensure we don't
overrun the buffer, we're good.

> If that's ok for you, I can bring all the suggestions discussed here in a new
> revision and keep your review tag.
> 

Sounds great, thanks!

Alan

