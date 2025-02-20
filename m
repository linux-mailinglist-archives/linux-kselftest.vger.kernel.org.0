Return-Path: <linux-kselftest+bounces-27090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F7A3E0C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BEA3B5CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C820F068;
	Thu, 20 Feb 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NB6taFx2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOaiZq0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8B204F94;
	Thu, 20 Feb 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068655; cv=fail; b=UECG9Ve7O0JHajylpY4aYGnKt6DM4kp0NUceYBaKSrpPjphawxt1yH+KxovjEj8Ue6Oi23SBxYjzOTnyc6vWzj7rgmS6qGGH07CmWj8ih84zq4IzU2D6SPJAMFpIw1YqO3HnJn8Di88qWayJIA997hwgW+j0+TnwuWMIvtBnWwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068655; c=relaxed/simple;
	bh=8qso2sqsvb3M5UdYJ3+iZPMzhkR7RIJU0DuFh5jQxOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jxWH5ungk9NVk+U+MaKDuI8icImOrOSAG4ut0PBQ646TMgxSwgRs6upb3ly+DH8j8DmtcguAezzDaV4EnmSG/36AhF89XJN79kC0hRWYfMdPtG485opIK4bOIqkFx9KkvhWGsMRRUUTW/GEAI0nnb4Pl0J21wDOfhKvt7zOmv+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NB6taFx2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOaiZq0h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMdGd012647;
	Thu, 20 Feb 2025 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RQJpfSY0AkPyxaFyCqqbyyDAv6ShNIB56JkSIuaQMds=; b=
	NB6taFx2CnH4koMezQex3SgmLkEweqrZMQoUB4k/lsQqo4xXZtV9Zc79q6j/MrDl
	gZOftQmYi85tZGAsdgHHl/ptzCLTimtapvAC8PJX4VVswyybqoUAOfDzNHdxtrFp
	gIIJ/s9/mzDpCAn6kjJWRHUqKf+QWjNdjz0Sa2uNbNra8VpsyNMERcU/JeEZHKvR
	fQUxiqqZZCNe+KJHFuuQ6cNh7stId+lcQCM/hNzvUxO5+uEEmGU97fA5LytV62eb
	NpmUR1GRloTG4A7O+BQNiFivlW26w1LhEYd3Qz18fOpP+u55yEEQAlhE5lauCVu6
	GYJ8mZ/B29R7vsT1PyTheA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nmfmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:24:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFmW0Q002371;
	Thu, 20 Feb 2025 16:24:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tncvgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efGhRysu/Qc0LN/NEXxzA9+k7vEim44vP8shiInYL7YyUa32WhrixlE4l8N/66KD+VyjbD48wF7EM6tqUMSPstgWVjDRIVf0DDOI3VeChRkzx2aBNUU93Talg5Q13IxEGFgxqiDFKqCa+EWFClpBjHaAk1MPRygHLuVxh79IbBsodgPGXYiGErGftKWRs96YYXMpB7bX8SFCaQR+5MStl4zW5tXgNdMoCy0bcuvWLKKmx0UcRj7AJms0+H/ers8GZZAbzX+0vCSvV/0gnaXNwDw4z5pNTyuho8sDddQYw/HRoLAZqpcOxL1XygNi4VnEp8ElybyL1N5UtfNtH0ej+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQJpfSY0AkPyxaFyCqqbyyDAv6ShNIB56JkSIuaQMds=;
 b=iMEVIEnddX56A4zpl8OpXaUfMUiwuVgU5nz8IrhEGCJ8NpsvNvZHECg46hUASil//obaiiJBhCoWSMBT4+W8Zuvw+mqSYw3ci5m4OGw3gD37EgASu7zCPDl4uN1YKZeBwkesgUCnZTne+tQbUPGuOp8CXf+Fu4hGbZz02frfEr4HhR/uVireSibOthcDLgAFAgbG+4UoLZfsntXGiW0zWwVhxtzQe+cTLll0YdCBrFy062OJa9hCZmfC3G63NN+cOK0P1dWC1gBxM17CvoLIQaqtGutEoiYGrdydjolOl0mO/ZLXp50aCADi8INPAE/QDGj+cTDhM1aeEIVuLvacQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQJpfSY0AkPyxaFyCqqbyyDAv6ShNIB56JkSIuaQMds=;
 b=bOaiZq0hmUoDcvi09bnLee1hiJG8joIOqK07l2K3dUIN0xQgGBzc9EdnPTC/MaqIE5Bs5aiyiqLM13Q+FGawG2GpBiP8Lb/8MXdMjl7JrM34FBb5KMft02CPiBRNcxdj3Mf3z/Na5n1QND9FuMptg23SPrO6K3NvlwTCH7YAaf4=
Received: from CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 16:24:05 +0000
Received: from CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e]) by CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e%5]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 16:24:05 +0000
Message-ID: <0d22f89a-d896-44ed-b4a9-c860c63450fa@oracle.com>
Date: Thu, 20 Feb 2025 21:53:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
To: Chris Hyser <chris.hyser@oracle.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
 <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
 <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
 <CO1PR10MB4705883FED10DAE126DEC9D59BC42@CO1PR10MB4705.namprd10.prod.outlook.com>
Content-Language: en-US
From: Shan <sinadin.shan@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CO1PR10MB4705883FED10DAE126DEC9D59BC42@CO1PR10MB4705.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0083.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::7) To CH3PR10MB7211.namprd10.prod.outlook.com
 (2603:10b6:610:125::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7211:EE_|SA2PR10MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cf6b10-f3ea-4d98-c898-08dd51cafe64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzVhQUZ0cHVmK2YraU9vVFVEcS9vMEJEeXYrYjdETHR1cVpmNVROVGFKajZk?=
 =?utf-8?B?OHNTRmpyc0Z6a2J4SVZXT0RpWm4rOEk0eVNuYkRGR1h3YTN0K1NkcHJMTzlp?=
 =?utf-8?B?SUdDdHMyUVRvZ2FjamZVV1FzZ2dSZTVtc0E4WUhnalMyMkowRlZrOGppK0hQ?=
 =?utf-8?B?RVBOdDRhZWQ4Wm93b2puWHcyYlhJM3BGVjFDL1ZQSWxUSEIrRVVGV0FqRXZS?=
 =?utf-8?B?aU9IcnhUYnBITnpCKzVHOG94NmRGd0dMV1lqdmpudTZFc3dJSGRqbmEwTE12?=
 =?utf-8?B?c3V5UWRrRmdEeWZYQVBjUEEzNGEyT2xuMDV1a2ZtR1ZkMkI4SzduZWlMSWJ0?=
 =?utf-8?B?WlRMSTdGdnJCdHc1ZHIwbGZFcVAwcnNDWnRMOXcxdGU4Z1l3SVphVitGYzgy?=
 =?utf-8?B?WFRoMWw3QVdVaHE0WDZlUmNDd0hZT3BDbFB0cW1lODhQZGhHVXZ4bE5hNkpv?=
 =?utf-8?B?ODlBR1duRW9jU1A0eEZkSFpiQjlPbmZuclh4MitFWUNmQ3p1TVBJODVud1RB?=
 =?utf-8?B?V05nbnh2VlExaVJlZ1k3TWlnL2QwYTcyK3ZtVTRlUWwybWRIemZuRzhQY3Vv?=
 =?utf-8?B?QUdnRTNrUWlVNnZaSW9qeXZBcXFJVzMwLzVna3p1dEJ0TEZYVFVKQnVpWHU2?=
 =?utf-8?B?OUVuZzVmSmg3VThRbXprUDRDZy80aHVmMkRkNGRWUjI3K1ZwVnJqZHZDK0VU?=
 =?utf-8?B?c2pOWVBCR2cwMTNtZ20zTUVxc29XR0FYSG1IUHgxdVBna3l1NHVFL2tmMC83?=
 =?utf-8?B?RDlnenNjd2xTTmRnb2dFdkd3UkVkRXoxVVV6VXcxVVFIWTNvRmFmMDhzNmpu?=
 =?utf-8?B?aXVyVHVWVGhGbmpsV3U4WU42RzhLbnRVV1lCN094VHJHMWtPcVhQTVhBMTNG?=
 =?utf-8?B?eE5sL0J5Q01MNDlPdk8vY3VXR3pZdGFZYXh0UmM1Sk1Rc09lV3BRRFoxblBi?=
 =?utf-8?B?ZDBnSXkzNDVhMEZnUERtclk1bmFxZlpxdjRkbEpNVEhxdDBnRGczajUxQzFk?=
 =?utf-8?B?YW9XRXhxNWtNYVF1VkdUL25qMUFQVWo1TDd6UUlpWlc1d29yQkZRb1Z1MTlU?=
 =?utf-8?B?VzgxUDk2T3FaK0pGbURDNi9VUUlUVlhIN2VITGFqZ1FiZmRSVUk1RVNQbE8x?=
 =?utf-8?B?QkRxQW8vY1RLbDFCREVseWlRa2owNjJDSkF3WDhmVVgzYmdEdVNlSm8wY3Ex?=
 =?utf-8?B?YmFBTGlKTWdtVHVKRSt5T1NXOFNseHk1UjU4bmZVVXRBaDBIOTMwK0pNTTMx?=
 =?utf-8?B?a1JwV3J3L2kyOUhXT1NCOXYraGxoUUhCY1paRXFhOWsxb2RoLzBhQ2Y2bVN1?=
 =?utf-8?B?c1VESG8zallObkhxVWg3Qmxqc2p0RXkrWlFPUW4rNUxpcHhYQ2JGVndVVHFG?=
 =?utf-8?B?YWhBQ1hMUFd6VmM5d2ZESUJMc0VBeGVna2ozejR1bVdUOE03Ym5GM2F2Ukox?=
 =?utf-8?B?K01xKy9zRjAyOWk2eEFSbHhIaW9lN1JuRmVjdEJHa2oxU21vcnZFbDdFOXA4?=
 =?utf-8?B?Vk43OFZoNGhBY2YzWGRCdDE0ek16TE9EZGZKY1BOb3hyWFFSN2lOdmdsODJu?=
 =?utf-8?B?UUFOYlRVQ2RkbUppUGFQSS9Cb1RnVVZ5R0FORkdWWVNmWXAwL0dLbzlZRHZn?=
 =?utf-8?B?S1FvQXJmYzZPdElVbUlxQ2JzdEFNK2pCYW5ySUlvZmh5NE8ycTY4WFNEc0xt?=
 =?utf-8?B?N0t3RXR6cmd0SHQ3Wk0rbUxWTjFVazUwc1ZCN1lWZjJLS3FLMFFiejJhczdt?=
 =?utf-8?B?T0FyV0lBSmZUWW1qQmgyV2h1RFdYMjRjbXV2OFA1VDBBdU16NmRmZjBZOGdh?=
 =?utf-8?B?OVhrM1VzeXBubjJheG9iNHJobHgrZWxobDIyWkkvbWwxT3Y4Z0ZsSjBjZUdr?=
 =?utf-8?Q?4oPWtxjC4oNOV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUxGMVI5L25leWR6aXBhTmc0WU1Pd2tZcFVuQko0OVdHRk10T1lFWVBLN1dr?=
 =?utf-8?B?UnZaT0hzQnZubWt6bS84d01IR0hVOU9jRGdabHF1ck9leDhJZUd1QmhyN2Rl?=
 =?utf-8?B?VzRMVTEwWGc5ZzVGYVV5SFUvN29keU1tNWxwckFsRkFtRWVjZjRvZ3FDVmRZ?=
 =?utf-8?B?NmhMdlJNWFAyMXV0akpiZ2tpbTN4SnpZbitwVXJUVGl1TzB3bDJJMWV1WUhu?=
 =?utf-8?B?ME1hZUNrd0J0VTdkTENmank2M2p5ZGNEYXRNZ0pVWTVSSk5iVm5zemxHVWtF?=
 =?utf-8?B?a3MzWmtEUWpMN0RNcGlvRnBwektUQlFDd053NVhUam1JUldKTmZ2OEpBZytD?=
 =?utf-8?B?TGQ2eW42WjA5TVkvZVN5SS9yTjhwV2ZHZ1gxeFZ4b1FHaHZVU0tjREFESnhj?=
 =?utf-8?B?MzJmeDVkTy9vek5nRUxJWkhpcy9WSDBja1ZDZnpPN1BydmZ0Ym1DRm56K2FQ?=
 =?utf-8?B?ellONzFkZ2Q1OXE0R2VrdVdHYWhEbXUrTHpKQ2phWHcxUTBnaVkyU2RDYmpB?=
 =?utf-8?B?Q0c5eU9xLzJhSFRleHBhU09LMm8yZmNubGxEeTE5WUJneG5ueENkQ0tTS3Uy?=
 =?utf-8?B?Rk5qdGVObkpobWdxOEkxVU1nNGdVUk56VTRuSWVtdFdyWUZGdDR0QWZSNDVy?=
 =?utf-8?B?K1FxUlVlTlI5MEtaVTRSSHdQZmRUQlR4UlJJdzZaZFk3NkEzTzZJZGUwS043?=
 =?utf-8?B?SVIxcTRoSEFrMjhiaTl6ZVBsUGNUUUVCUTRHTXBmWWZEQVp0dWQ4U3pFSEJL?=
 =?utf-8?B?S0x0TXpEZkVGNGVrMlF6VnJCSDJ0RWlySHVqY3JLc2pZb1IvMEtGZWFFcjJo?=
 =?utf-8?B?NERsUXJqZUlObFh4RUdORi84S09UZWpjcDZ3cTBBbE04YnhCcXdTT0tDQ3pU?=
 =?utf-8?B?QnltbTk1b1BiSXB4UjhrdSt4cGplUW9HM1JpMm90eklLQnB3RDMxbjJ3RzVn?=
 =?utf-8?B?QzdqQXhpTzlVYml5YkxTVFpBVE9ZNFRreGc3WjZ4UW95Rzkwb1ltNDV6Qlhr?=
 =?utf-8?B?NUs1L0R1bU1PcFIyblJndGlZN1c0cDBOOHhkR1lsS2lnbmU1M0I1TmFmSVJs?=
 =?utf-8?B?dXlWbjdJdjVOVHhqUmM5ZzdDMzRmdCtvRlFSWFArK0pRZFdhTkhXT0UrV3A3?=
 =?utf-8?B?QllLdXFaV0xOREZxb3pYOUZmRnFBRGNHUStJK2VWNE9ycHFUUGtpdzJ6U2xw?=
 =?utf-8?B?RXlBOUZtVlBjU0VnbVJQdHZVVzRDQy96STBYZTBMVVlISS9XOWlLZG9uMmxI?=
 =?utf-8?B?T1g1YmIrcWQvYWliRjRCOGQzQ1VHelA0UGNZeWVGSm82SEhTSFVTWG56eXFt?=
 =?utf-8?B?cjJpNUZVcUZFbnArMmdPeW45MVp6ajdxTS9uMS8rZ0hpSmxXMnN4K3ZJdkFE?=
 =?utf-8?B?OEJoa1gwaUxkQndwREtBQTdyalp2OHExOFkyekhHS0ZlSjZzTkhEVEViRUIy?=
 =?utf-8?B?TmM3YUJ1MVFzdWlKZGk2UzhJYUxvQmNLWTBPdzQwb05hdGs3c1FQL1orVVNz?=
 =?utf-8?B?aWtSU0IzNXJzUWh4TEh1ZHRQOTRKaGRDaURnYTFNaHkwZ3JacUxCOEY5ZFdL?=
 =?utf-8?B?cUxSbkJFamozblZYTW5oWEJVV2tFU1pmSlJkdnk1VkwxTmFVb3BBT2tSTWIz?=
 =?utf-8?B?eXhaRVJjWWh5OEpnRW9HN2xYejR0Ni9lcWpHQUtaamliYkRDbGtObjRNZEtt?=
 =?utf-8?B?bThhOE5SYlJTd0R1ZkF1ejE2eGNpbXIrYkFocXFyTngrdWw4ZEwyRlI0cTgy?=
 =?utf-8?B?T0w1cXZSQW01aytGYlk0bksxUFpkU29aN0NPOWl3Y2VyMUo0WW80Ri9OVWNU?=
 =?utf-8?B?Q0NJWjNZUWtTdjE3NldqNjJTMEZZNGN0N1RhVUdsclljWEFhVG9qL1gvNVM2?=
 =?utf-8?B?SFdhVFlhRWFOQVh0OGFpOWFWWGY5aGdSSitwV3g1ZmE3UGFMOVNFOTQ2aW9u?=
 =?utf-8?B?dDJpRFY3RHZBSDNRcnR5dEt1b3FJRkF6cStPY0JUcTA4Y3NMOWwwUjlsdXR0?=
 =?utf-8?B?TTczUkNkL05icEdpQUNucGlUdXF0LzR6UldIc05rRmcwaTY0ajVyT2JBcVdo?=
 =?utf-8?B?MU8xbTlnMjhmRktsNVhUVHYzWFdEYWd5aVo1c2NGT2pPbjE1MVpjelpxeGJW?=
 =?utf-8?B?L01SL29oYllndVlKZk1nVEwvanJ4Ynk0RmlFT1NlMWQ4TGZ6ZDEwQlpBNk1P?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xf4r4PGSHko4p6nyDWOUrLUv7m7xlOnzId4MkbBgnYUr0Kd9SfvSRhZC1EcEYo3UxjB/EShoRn2oyxVjLoIw6Nx61NRHI4xd3811/0d4H6YF2hdTYjqn5ojw32+yMybeBKPAigSsQo7T5RAptuH8F8HANZp3GiG05CgSg32mXFq58suLcZRr4ux0P89LsK9qYGjQAxLHg0bkyhIIFwOs2BfCI4lkXjNmJESJFuFEybRd818Uy9D09BzMlavuZC6Dhrl+XJKZeMKmhT1+mrZSjwfdNyD8xXeBtvRlea/Q07l9+v0X498rasTyud+wMNPCqgYmdIt3jHnryaJGpKBCWyip3oK9f6j9krRwyB8VmkuODvcz4NWYICKTEh+YGjJD5wwHyOkU9H2wBFTUH4I4yL2ciB0O5U3VsgLUnQsZJRsau3rUu9hcW/c22Dd7KjwN/wLdJQFjr5nXi2FjfH3CjpV8q5o95aXAYwIrc6IYJ6lnz7aXQch9rpMJM7KE5CEAy9TgfPi9Hf8sDKDPtKd8NjT7bJcQr+S2Zl/XonNmTVHns/IHOH3wHp1aiOMXQVT+DjxUWKZ7Le0jY+jN0SMkYjfXRnTOeEQoH9EIiYkb7Qo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf6b10-f3ea-4d98-c898-08dd51cafe64
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:24:05.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNpLlWDgkmYEX3GncGTE8UeH+1dwvHb6tGRNvqglD3vkh0ugnWnKjG5w8O38MdMoLX5/wwBbYFTIhnwOkX71nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200115
X-Proofpoint-ORIG-GUID: e9XhGxBxPBiXjXNlqnGn1CVUBTtib3fy
X-Proofpoint-GUID: e9XhGxBxPBiXjXNlqnGn1CVUBTtib3fy


On 20-02-2025 09:26 pm, Chris Hyser wrote:
> From: Sinadin Shan <sinadin.shan@oracle.com>
> Sent: Thursday, February 20, 2025 9:52 AM
> To: Shrikanth Hegde; Chris Hyser
> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@kernel.org
> Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
> 
>> On 20-02-2025 01:15 pm, Shrikanth Hegde wrote:
>>
>>> If CONFIG_SCHED_CORE=n, the test fails. So you might end up seeing
>>> default selftests failing on such systems? or this is only compiling?>
>>
>> Yes, this patch would enable the test to be compiled and run by default.
>>
>>> Likely the selftests/sched needs to modified for CONFIG_SCHED_CORE=n
>>
>> Agree. Chris, I suppose then a graceful skip would be a more right
>> option for kernels with core scheduling disabled?
> 
> By graceful skip, do you mean a 0 return code and not printing failure? I confess,
> I originally wrote the test as stand-alone for me to get the prctl code right and it
> got shoved in here.

By graceful skip, I meant printing that SCHED_CORE is disabled for the 
kernel and exiting with a return code 4 on such kernels. This would also 
make the kselftest framework pick up the skip, say when compiled tests 
are run through run_kselftest.sh

> 
> I guess my question is what if SCHED_CORE was supposed to be configed into
> the test kernel?  Silently burying the error might be bad. I'm not strongly tied to
> that, just looking for opinions. At the same time, if you put the orig change in,
> people w/o SCHED_CORE on will start seeing "failures" they didn't see before,
> yes? and that seems bad.

Yes, that seems bad as rightly pointed out by Shrikant. I have a patch 
that does the above mentioned skip, and if skipping is a right option to 
take here I can send it in the next version.

Regards,
Shan
> 
> I'm happy to make this better behaved. I'm the reason it is the way it is.
> 
> -chrish
> 
> 


