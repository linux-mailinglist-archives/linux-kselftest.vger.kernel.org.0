Return-Path: <linux-kselftest+bounces-30492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA455A84C65
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE11B62075
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DB20127B;
	Thu, 10 Apr 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PMmIVP+W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mq6NflcH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C11372;
	Thu, 10 Apr 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310977; cv=fail; b=dn1bM990Q+kX4Lpko+y7nu291oMLMOl85NJaU5dUGr5x4OjOWJVoephdqlGNuU4rSMIiESpt6BQl7dg3gj6ylo0c2TlcM2sLllKvSd+2jj9hYDAGajy2VeFSiHBjVjoNqvdTfh4bQkCufzx6Pscf4j5GxkgADfZq0QM/wIPcVs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310977; c=relaxed/simple;
	bh=7lp7LGijEyfGQWyASnS882OqyVG+YjDvDPXSEX5fRBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hm/OP2y35ERLnbOf9wg4MPT47AyQrCKH1FoOKagwGQPBPc1x2oDwpMln0nlqTge28bU6ruVJtx9q6mCv1mnjGYYmUJJrhRiCTvMNt+sehgZ2XW8Xw5Vsitkf2JvJyRmDqVNd65v3nPnactIEOWculAdesH6Bg7KSIuMEhuebJok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PMmIVP+W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mq6NflcH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AIhTSL021963;
	Thu, 10 Apr 2025 18:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DvOu+iEBQwPMlGry8HR+I6RHR1+HtEmi+vokLH3G7wA=; b=
	PMmIVP+WbUsObwAxrXyWs2w+RHWkbUOHG/YUKTEYlqT/2d4z77+z3/u8RqH5cbJq
	Cq+et9W3o0AldPw08PPaN9KOsIdiB0Our0sjHD00/LGLR1SGdtGFBeDAyeLH/1PU
	FVEykpcXr+sMlug15C+EWN2+AZDn5ZE7JqqdUCLB+AsntpdMTGp+exaM9tu4UGlw
	TOWBnHF2IC4T0CByxN+qGWKRzkSQFAF+McekfgHnCRb/3xBR2XT5ziCU72JaF00o
	SQllNPZ+V5a8veZ1aLFX9WYTHBeK92CAI1H6ZErcoKCzxAtF+dV5yCH/1d1eT7zE
	8NKi24nQj5O75Eej0Wx4tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xkg7r0p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:49:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHTEAQ023844;
	Thu, 10 Apr 2025 18:49:24 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010020.outbound.protection.outlook.com [40.93.12.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyk0jn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0KN0fwoitmqncTpN4WE82UQSw+vzL2Y2ETyuE+1Ds8LGt5G5/cNLXLmrCIK+VsxFggwevChadrBM/lHxRT4ZEub0l05fidEyOJDeQ8B7kHROYDo2mmWqWZrz7cRlTEsPxbEFtsDUcYoCv50Qd/QWbVYosM48qyI9M/oAVn5OJtREJAiEXg7wlCrNqOvoNN+5B1R8aqtAFcIVP7SywOxnJ5PcxnoX9ywnck6ev6Y+rQ+UN8lEarTRRjUGWRkTm+ttyNoslkBuhM0aPmynPORtc8JNClTpr7JgYWrUHg1/6JXAmbSSooEoDMa0QY1lFZ9rHXHmoboqwIFG44MFqtRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvOu+iEBQwPMlGry8HR+I6RHR1+HtEmi+vokLH3G7wA=;
 b=dBxXN8KE7CdW58+xRcOxoTQK4ET3rVT0Am6bncok8XHTstYTlrdUutigIdiGPBpaqpU+VDuDjXzVMVGLjRpPQiopIGJQ98c5WLdJUh+AwFAaKhkn/erRdb0rQgnT239RSM1ShX33Z2ChAVQ2OQiIi/yYwLuGVc7iHssQfOmNTgS4+M+TmD/255Gy6rpFZK3Lq81sICOzDK2uSLEn7YYC4GFf930vaMq3f8xTna8JyyODUaUjdpOYEy8K9eWf9C1Tp4+FK49MShUQPDVQ2uyiJxj02UsR5FbuxomgOAVFsjGNZfKeY6hrEaje+OHPZ6JrTH0X2q3AZoYdAWXJuGnSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvOu+iEBQwPMlGry8HR+I6RHR1+HtEmi+vokLH3G7wA=;
 b=mq6NflcHbkyNVQuxv2AqTD/FxNNoMf4qSoPbbhd3e+DTi2zde6iph3XytYC2RbX3S9PravRlpPP879pFTy1g5n67wQj7T0Sz43QoY4Wke4cEG/IvRxU+XV1QUPAhsddA4NqBXTmpL/PnLPc97vIYW4l8p9wvP/sYzSmV8T1P+6c=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB6797.namprd10.prod.outlook.com (2603:10b6:8:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.37; Thu, 10 Apr
 2025 18:49:22 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 18:49:22 +0000
Message-ID: <8f5a7d1e-4f8c-4f20-b225-de79f5d23bfa@oracle.com>
Date: Fri, 11 Apr 2025 00:19:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 05/23] ovpn: introduce the ovpn_peer object
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
        sd@queasysnail.net, ryazanov.s.a@gmail.com,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-5-a04eae86e016@openvpn.net>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250407-b4-ovpn-v25-5-a04eae86e016@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: d7de94d7-a27a-4648-b4bf-08dd7860685f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1ZoNjB3V1BsWmFwdXdJeDJEdVMxTTJMdzBhQXZuOFFXUDA4V2tWVUN3R0Rp?=
 =?utf-8?B?WFBDWjVyOU4ya1lrMEV2bmRwL0VGNlF4M0RQdXV2dWZlUXUzdHBpUG1SM0c1?=
 =?utf-8?B?SXNRelNSS09MdHhrWjNEMlNxckFOc3hIM1EzejdnRWZncGMvYVZDWE1vUUdM?=
 =?utf-8?B?TGJTRVYxYnI3OFZKY01hbXhkcm5Yeks1Tm15N2ZNL0VIQ0VOY200Z1FRZWk5?=
 =?utf-8?B?ZWRIZDBzZUpIQ1F3ZmRyOEVVS1FqSU02UmJ5SUJWZHMrS1ZVcUc3WDV2OFAy?=
 =?utf-8?B?cFdKLzNqbHRiQ1RYU2Q3ajJGVitCVG5rWEFlL3hsVVdHZ3VMbEtJc2prS3V3?=
 =?utf-8?B?ajk5SjI1bEhlbXdHYlJZOEszckNGUkpnR3ZtN2d3dDQzeGJoR1RsZ2NrNFpE?=
 =?utf-8?B?TWZjL0xYdGVJbTl0U295SXFOZzFrZWlpNHd0NmQrUW5TS0ZaUk5WWllwdmpB?=
 =?utf-8?B?cFRZOUhGVHRLalNXdmVKZU9SaEVWSk1VSFpKSlM2bFlVcVZIOTU1VDhLSksz?=
 =?utf-8?B?S0xaTHI5ZS85a2tZK0hQNXhlQThRZWNVM0ZUSWdCY0hYaThNVVhVaEtSQW9r?=
 =?utf-8?B?UUh0T2FqZEhCN2Z5Vks0WEJqRERwOTVDQkRyTWFYNlFVTG9FcThsVU9iT1Fz?=
 =?utf-8?B?UlJrMEFiZkQ4ckNmaFJLVW9PVjRLR1gyYmRiQnBDdWREMDFsRmozQUdna21r?=
 =?utf-8?B?bnYwOWVVYURoS2xzY3VGRVFTR0FtczVmSE5DaWg1YzEvU1d0S3ltQXhBYzZP?=
 =?utf-8?B?OEFuVzhuSDh6MnJSbFF4Q0I3cXpvUmE5b0dwR2dCNlV6V0VOVC80Y3hLTzJY?=
 =?utf-8?B?dmN6STcraVVMZm42M0ZBNW16cVhIOTI0RnFWQXJpNmJTV05uYnNua1hLVzZ2?=
 =?utf-8?B?cFZmOU9ReVpHOTRJSWp4NDlnWnRPTTFiSFZDNFMwdmNRU1JLMEorTGFXaXBs?=
 =?utf-8?B?OUNWc2pGc3hBUFRmMmloTkxGVVdpWC80Zkg4UlMwSHh3d2tPVEJ3a002N3Nl?=
 =?utf-8?B?ZUVoQU5RUHB6ZEgzZHY3RmtqQ3JjdnQ0bE5IcW1tWThtK1o0ci9vZENkR09p?=
 =?utf-8?B?emxWRk5sa2ZXL1l5VUVIcHBIK1Eya29yKzd2UFByQk9Sd25yZlQzbHEvb2gv?=
 =?utf-8?B?OGRwbU5pelhEZ25CUUdJQ1J5bUVOMlpQOXBVNTRiZThuaW0rK3lMK0o2UGVo?=
 =?utf-8?B?U0k1WEk1RkExdytIQ29jVERCS3dGTG94NDRRYVFMVUlUOXM2WXFnK250M1NR?=
 =?utf-8?B?UnVKUHNEMmYvMk8xZXBXWDRnUGZPS3VEY0FPems5dmhmTldTczZIdnBRTlRZ?=
 =?utf-8?B?SGhuZXYySjY0QmdaSEwrN0ZpM3RPVEpiYURTcEtOTzl2SVZDem9uNFVtbEdJ?=
 =?utf-8?B?SEsrc3B0RG1ZMVc1U1Q0K3RDTjFuUEdnVEFERWY2K29JbTFBOFJ2T0oxZng4?=
 =?utf-8?B?cjJxUEhCczhaaWxvSlhkR2VJNnZUSU0vZnlrN21uMWVCeTdzRm5EYWF2Rjh5?=
 =?utf-8?B?RUx1NW5JUTRPN01CK0dxbFVvZkxkUEo5LzBhYUI0c2VkM25PT2w4WGxzYkZL?=
 =?utf-8?B?M1N4aWNodk9FR2RjelI0RDIyOFlYZWRKS3FUYi9PQ2IvZlZpdStCejZKZnBo?=
 =?utf-8?B?UllZenNxODdPM0hqQTloL25wbjZ3clNCVjZ2WmNJd3Y3YlkrNWtuL3pTV3pY?=
 =?utf-8?B?SUxCUjQ2TW9DaWI2WkhJUThBVm5yN0UvZ09mT1lZWEplNlFHa0tGNnNlV0Uz?=
 =?utf-8?B?NHZKdzcxRDRwMWtKaCtzMVp5V1lHdTB4emFIWVk5SjlZV1RyWS9WQlJXemhq?=
 =?utf-8?B?VEtTQ0QyT0VzalFiY0dLZjFRZkZZT3RCMiswaHM2eGlzTHpGcHI4TlFzWVFZ?=
 =?utf-8?B?c0pGLytUZEdvcWd1V3UzRHV3Mm9aYk10YzMrbjI3ZGphSHRtemRYSENLbGFn?=
 =?utf-8?B?SjZWZmhHTksrd2JBMUZhUGtreENuYk5rWjVyQVo3bjFEWEkyVGp5L2NVdWNo?=
 =?utf-8?B?VEY1bTZiUnhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHcvUFhnVVYrN0w1U0w5eFdmZnNXU3BUa2JpTEZrbXpRUi9oMElQTFQwSWgx?=
 =?utf-8?B?dnBobU1ZUHByblpNL0FSelRWVFRsRkxsK0llQncvNEpMMjl1TGhZaVJ3TGd2?=
 =?utf-8?B?b1lFdzRaYmJvR2ovdW8va21EWkdvRVF1THZtUWJkV0svZSt1dUJvdDhmbHd1?=
 =?utf-8?B?QkgvSDJsZTFnODJveWVrNjhTQU8xdnRPOWpleGVIVjAvejVHZnA0cm1zU3gr?=
 =?utf-8?B?RFVzbW1CUS82Q3FUR2FXY3gwVm1hbDlUUDMzcGV0NlZvRG81ME4vcHF5dEJW?=
 =?utf-8?B?cGFlWWRHekhaZXFUNGJWa0ZVRWs4RzAxWW43ek1oUm1hZU12bUhsUnhNNUxz?=
 =?utf-8?B?RjNkSDU5Wnpkb3lGViswOGRGQWdxejlyTHpqbGRLYUlkQUZabW02Qk0rVU42?=
 =?utf-8?B?Yk1FbFVIUldGR1pGWWxOMHZ2RkYzV3QrYThtUFBiTUoyVkF3MXpTMnp4MEhh?=
 =?utf-8?B?cGFySEx4c1pNT0JLcHc4YnN5b2c4aWFNb0JSRS84Y2dsSnRvb1B0LzFNbEth?=
 =?utf-8?B?YVJTVkhzd0lJbGFjb3MwRTN1c0VYSXk2c1d4aHkxZ0tLeGNvSmZIN3UvczI4?=
 =?utf-8?B?WThveUhXTGpCdmFZZ09XaUxMamNRdjVXTThaUXBDSnZuQ2tDc3Q3dldrZENj?=
 =?utf-8?B?enVkbTNHTUU3Qng1dFVCVkovbEVqUzdUVHBsV2crZEdYZTFRTml4TnJvdEFj?=
 =?utf-8?B?UnF1OENwbkxrSjBvOWovcjJnR2tnKzNUT2xJaGNHVDc4b2swY01Hc3doZVNp?=
 =?utf-8?B?ZUhrYW54Z25LZnJNc21RSXJhRWpiMS9NektGOFNDcXJhYlVjVTRtTzg4ZGty?=
 =?utf-8?B?YXNqSjNreGRSZ1FyK2hvaUVlaVNDcWRhdDRHNTVuNzQrc3N6NWQ2akUyWW1Z?=
 =?utf-8?B?NVFMSVBMbW5kZG1SQVJLVzY3N0xvNmdKMGNqeUkyemZtbHA0NFdzNGNYVXM4?=
 =?utf-8?B?T1AvRGtmN1BKNzdqNDVIMkhWcHF5T1Jzb0d1L2llcWdEV2oxY291bTRrNUty?=
 =?utf-8?B?a1FyakJqc1lHekhFV1p3VEJDalg1WXB5U0hiVklpcVpnWUV4VUhWMXkwZ3NB?=
 =?utf-8?B?blV3NEljc0RkY2s2Tll4d3dEaldReTVmS05HY2xidEp3ZVVXclV5K1hLQzVw?=
 =?utf-8?B?Skd5dlBFczkraE9rdndEbFJZbW1sRmVGQ3RKZXd4OXFJNHlpNmI2U2hkZk1K?=
 =?utf-8?B?RkR6azhCYi9wTFIydGxVajFYcVF0NjlSSDV3SFBnajhaV1ZsanJlRG85SGtq?=
 =?utf-8?B?YzJ2cDB6Rk5DclhnSnEyd2xzaCtDd2szSllJQkQ3Zk5SK1dBOFhtbWtORTJj?=
 =?utf-8?B?Qm9Id3N0MWlFb3JTaUVVQUd6WUt2Yzc1RmlXNTlxZE9tVElsRU1ZTUg1SDFp?=
 =?utf-8?B?Q0tja0llbllFdVBDSGlSUExRcTczR2xPMlNwT3R0SDMyVDRkeFh0dHYyeUJq?=
 =?utf-8?B?QmQxVEJkTml0R1BsWnVRVkd5aW5rTUV1SW9wMi9oTytxUW9WbjI4aytYazQy?=
 =?utf-8?B?NFlJYjNyUGNVMFRhTWo2SzNyQjlwZjBhN0kxV0oxanhaZnN3Tk5VczcxZGlj?=
 =?utf-8?B?eDNoWm9LYklxaDdVa3laWHBocUNmL0JhSjBjWU9RekVQWFVXZnpTYlYwNkdV?=
 =?utf-8?B?RVFNTWpkdVhmU08wOXppTHdlTGxQdlRVK2h2VkprZHlQdkx6Uk9pN2l4azho?=
 =?utf-8?B?S1B4L255SExFRktjUCtHZnB2cmVLUE5uaXJmRnBQUDBjVHMzdWJLaHJQalk3?=
 =?utf-8?B?WngyVzVzSzlFbHJTNkVRTk5qc0cvekZMcCtyc0k4a29zQnRNSHh6S0k5dHBk?=
 =?utf-8?B?d0o2Z3YvMTFDMUdQenhGZ3lDUFFESHdJVk8zRmk0SWtuT3UwaE5NZkQyUEpr?=
 =?utf-8?B?VUNxUlNRS1pLaENBQy9saVdWTDQyL0xUUlVXR3piRnFwWnlCREk3KzQ0RjM0?=
 =?utf-8?B?c1VlVm9aOGllVGhranFKeXByRUlTcEU3VDNJeHhYRm5KVENiUmc4UWVMcDl3?=
 =?utf-8?B?K3BtdW1oOFlrUFJhVDZQRDVHbnR5Y1NyWXdHR3lCcFBSWktVSnJ4VVlTa3B6?=
 =?utf-8?B?Q3BoRXlXczNQZ1RIcEQ4YkxpcU55Uk1reUlzVUJOMzdubUExU2Y3cHlIZXdW?=
 =?utf-8?B?andMQVNraG1VekUzQzkxdWtaY1duQVN4WUZWbTM0Mm5mNlM0MkNxUkRib0hR?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nmzDHXWthkVS3+vd/qtLrlVS3ycvN/45IJg7e5rLtnJKo8xArK3lV3II2x4q3KSvP4wqphL+DAM3GHpt2jAJl8cvAb8CNWm5alsL/vsAU4r55p9Q+upxBrwtzJKgheaD2j/nhwsdZLP+asS9sSdPoMwQ9tkIorrrK0BImAoJS8veLz1JG4O+jWuinZqPSLtmpGdFwcY6Kt+ZS1RlXnSpeTfoJfCtE3kH9NxTuBzbGxWQVQcYQlM1jrwzl41lICpShuaO9su8dRe4K1+qsKNuu76pjy+0cVddxNisViUh5vaJwsO3PSBeBfGV7qT2m++UUZkCE5UjYWjK0Ce8liBmdZzlo9JttS58Ftz5a8XaFEl6sDoWw5in+kBvBcKIUMo1Uii0/kAIlv/kMjJJWbtN3cqYcOHu56ymsN4GlrwcBW5I1VduZoLtDUDT+v48V3gWl3hFkeCQgi7atDN8tQUubfasj1tis6YLyZ8poBc6wQoCdrxHufCj5cSAH1clpkbj/VrJV8gL5DcdvtuswgZYyfNXr2+65o/EXX0ZjiPqNc2X7hOSFSBWPS4La6U85MRirj1ozsutrhD6iB/VKYylSalaJY/eeocXrgvcqJIsRGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7de94d7-a27a-4648-b4bf-08dd7860685f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:49:22.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iN9DcA8/nx1RT9ddBU+0yp2coIPtCQbZN4ZHQhrENzCHh+V1CiS7f9Rg8v4OHjBi3tIg+53eQPRkCZyW3HUkTXHTIhhnf8EioPvn9ZleeIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100136
X-Proofpoint-ORIG-GUID: VtrjFkysVy6Qpo6aZ5BqqW7pZAzmzZR1
X-Proofpoint-GUID: VtrjFkysVy6Qpo6aZ5BqqW7pZAzmzZR1



On 08-04-2025 01:16, Antonio Quartulli wrote:
> An ovpn_peer object holds the whole status of a remote peer
> (regardless whether it is a server or a client).
> 
> This includes status for crypto, tx/rx buffers, napi, etc.
> 
> Only support for one peer is introduced (P2P mode).
> Multi peer support is introduced with a later patch.
> 
> Along with the ovpn_peer, also the ovpn_bind object is introcued

typo introcued ->introduced


> as the two are strictly related.
> An ovpn_bind object wraps a sockaddr representing the local
> coordinates being used to talk to a specific peer.

Thanks,
Alok

