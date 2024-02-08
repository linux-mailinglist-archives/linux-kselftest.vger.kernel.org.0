Return-Path: <linux-kselftest+bounces-4340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB084DE51
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F1C1C27BBB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EF6EB67;
	Thu,  8 Feb 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwSbIhri";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pz/beHU5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8D6BFC2;
	Thu,  8 Feb 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388175; cv=fail; b=l2kipa4+/8d5yzan0Wg0V7pXgBGgkdnFJOL99vxMri+DjCwI4Pt+fjMaNBFuCQsrny/Yd15NbQ9d9rp1Mp6rc5soNq03gZ/e0BVjFOVh9oCoXbg/cpjTXysJlbGszhyrJWSLGQZaC0oyodbKoatRKmB/jc/fwS32oBJwXlGzpZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388175; c=relaxed/simple;
	bh=jFG64Pp9DGA3oxLZEQXtMVDsS+rVLOJyvjFt2QnOSgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6jYDLdfclCz0oKas+QX2k+m0wh/C3/+s6X6vye+0YiHLY6fJCxO85o6o5DSdMR2UbK1IIk6Na7iaCemdBI4J2nrYDXVdQmx41YkNLD/5rwPxCC2S4P99i7ZcnhhHNY3ddGvCZ2Ip0zwUHTYig0jar+LOMBoKtrSpVTR5VxopHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DwSbIhri; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pz/beHU5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188wwDH017764;
	Thu, 8 Feb 2024 10:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kFDFR/ZF4H6RFhBJ3wL74+dok5MtlxdaeuZnsXTcAbY=;
 b=DwSbIhriZsFTVCHraZe6DzBYEEVaRqTxLr7HSeXDTNrkIAL5pEcnUTBAfnJaL9/2hCTE
 log/2J8/TR2k0/7hb7vZHpj5FQJa6e5RC88QXAezqsn7f5tKchGA6Va3IpRf90t7wPyz
 IdesGFfCUMllSz+attlrzIbHSCnQHMMcQ875W2JMDteVdycjGHbPGhMb5i6i4WOZh/P3
 IpeKG6kHz2s/EAEG1MfF4gj22x9vQ2Y6QaA8K3aIH5L16HsxxbViD0NBRePcbZYAQY2i
 VlV1ddJvGS+OAqN9UvgeBjCUs7c7Pn9XgDQB51cW7jweXO+jIccbQ0IvtO7ufouxCaa9 1g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c944c7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:29:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4189cwXS039463;
	Thu, 8 Feb 2024 10:29:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxa5y9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNZopOKDjCS84FjA3tSsYl/uvQBAaTYBEPtJXQ6fyKn0BGBMEGuo7vAaOB7cL0hwYbIbZno8piLtIQkHpSHXdhmk5j4YWCEKI52D9FEj0SIr3uC6jtQem377xDyQgQw7tjK4735iU4hnoxO+ADp8Qm32530FqEeWsBNIxOuDRWcDEDXeYuxPw9Vx7L44LrE+DcaEtDaNyzyD14NFuiYqZ8fx5Qmm3PxWtn6tCtMEsMsII7a9qkEVx659Yc0ZzgWDTmkbjRmLr75SIcD/sshu49jmGW/IqgDV1iAdZ0kGrOP5dvOPcwdh93KidH/jl3KE7HvWnvPrkqzo5YPgcP1+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFDFR/ZF4H6RFhBJ3wL74+dok5MtlxdaeuZnsXTcAbY=;
 b=oQAoZXQ7zdNqoRec1PRCfq4b2mbB6vY9RI+XyfIClFRdDJISaiQJFoHGhFTuU6NjFB2AQGWAe6pd0uOGcWwPGqiZYBygsEvQ/XelL3QbUQfj9x1YjfuW6bEpidfhCQIqPS2TnaoFaa8VbQ1CNeIgh/9TwJE01ZjKBnp3sHs/n5PHXHxOroamxfF27nuBNIL06hxvMT83rL3w0gNl8YA1sY+5QHwhJMdmYumu7mLNvuO96lEjM4A2YTst/7T1QgrKUdnfv75w/edbJh/TsYL+v7Dvj5uZK5PsYx/XG+t04Lvz8U/zQGhBpN05JCIcpYQ0NGZj4tqgWHVBVPIqeY7WJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFDFR/ZF4H6RFhBJ3wL74+dok5MtlxdaeuZnsXTcAbY=;
 b=pz/beHU5Js1e+GksxHhRnhay3Nvg50EV8OPhmamjea1KwleHfFnsmjy/XvjXCVeGO4dHmT44EaZpDRl8TZsgu7voK0+M9u9eArbfy6RFdb3WjqVQd3txu27lxL5X485RpN8Qc5evgYPfhKnkpg+zylQRIqumI05dB0fAmWzP1os=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4260.namprd10.prod.outlook.com (2603:10b6:a03:202::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 10:29:16 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7249.041; Thu, 8 Feb 2024
 10:29:16 +0000
Message-ID: <63070cc2-3dee-4da8-a76d-0e4a54eafff5@oracle.com>
Date: Thu, 8 Feb 2024 10:29:09 +0000
Subject: Re: [PATCH rc 7/8] iommu/vt-d: Wrap the dirty tracking loop to be a
 helper
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com, robin.murphy@arm.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-8-yi.l.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240208082307.15759-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee1e054-8af2-4fdb-60b3-08dc2890ccee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IXF1WjV2IzTf/NgKUQduiMBZ7590Dn0zur8DgiiOH5VL7st4eMRAUOV69ejd0kYEpXEK0Kb6zlrJb05mtePhwEhKHUB0WNm44VnJzS8kt1yTzLNGoy6F/r7pGvsvC6eU1gGrEdKbwe95LHBNYJm4L7FhcM+XL+vsakKOnSfRxpvrNnzWMPKFwV/IGkPMwX2rl9kS9nDeLNp/PLDEwyRuAR8ZoEtKf/be8n7M9KNwLeQXEanK6Qu4aTekSXtS8jtcNz5sDa5SvCakk6DH7ksD/mqdHE9NhortFlaTHQbwZ/A3RxWiOd1InkSlwF8f6FweU8cuxMmIbzmoK+TVPjnHfZQhh+wl23p/3E8ep0/CXoYnCMu0B8pDcWxuHYa8LxkPWsaBIg4h8P5Evjbla92y75nCSXzfyKtnY4GLc1yAmdnTA8fXJeXRVYyptyDOSq1f1O7XgLpo8gLv2ywSma3xlox3Xr2BYAyo2wD41W68ppQJCJx0FpiDZ/QSxmRTxkSz3ghf1kY6L4vlA6E4GtjHEyrM3oVdvXhucY/26im+1iXP0OqG5XecEDM8/bHiNEAf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(7416002)(31686004)(83380400001)(31696002)(26005)(2616005)(38100700002)(86362001)(6506007)(6512007)(53546011)(8936002)(478600001)(316002)(6666004)(36756003)(41300700001)(6486002)(66556008)(66946007)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHBnV2JPa3FwT3RiMTB3NmZURFBiSDdyTFQ5Z3ZJTTlaZEZTMndIMjQrRGpR?=
 =?utf-8?B?dkNHRnpXU3dvOCt3L0pJOWo0dmVVNUovQ21jUWJqOGFLSkVMeTIwNFdkTWVF?=
 =?utf-8?B?NnBBRFVDenhoSXYrWng4YjZZRjlzclcvUDVtZUl5UmtIbUw4bnVYT2NWZmli?=
 =?utf-8?B?eW5RL1RVOTg2emN2V2tMS0lQeGtBUk9VcVU4dkw0V3hCM1FQWkZKQVQ1Ulp4?=
 =?utf-8?B?WGJmcVNkYUFxSnZtbkp0aDJOKzQ5N284bFRCbWJ5YXVreTRlSWwvblJaQXFR?=
 =?utf-8?B?SGtzTkNtb1BKdkFxUll4bGJnWndtVmE5Y2hFU0ExRkxwTmhNYU5YdEh1Rlho?=
 =?utf-8?B?ck1lU3c4R0pwSlBmdVVmRUMyUXFMWVMyYmRRR1RmeTJmL1g3c2p4SElBQk9p?=
 =?utf-8?B?dUpUWXF4SFZDNDFQSXVQaFduR3BHL2YwaFR2aVRYMGt0akMrczhhSzBBMEk0?=
 =?utf-8?B?VWRlZXlKcnZZNzR0ZVhiYS9iRUxkZnVPVm9ta1V3VE1HTk4zbkFEUmdRbTFV?=
 =?utf-8?B?cE1CTWtZM211NTVybk8rYzU5UENSMlpwaVcvWDZ5clQ0Y1BBOEtadXdxZVdp?=
 =?utf-8?B?VFNkYUZtRk1HbW51ZC9Ka1Fyb00ycG9hWkUxT0dIR0lGZ1NTa09kYmVyWHJt?=
 =?utf-8?B?U2JEakdMY3FRVkJ1WVJPRFZWWkNQeEZCai9RVWNVWUl4dlB3TFhmRktTUzJN?=
 =?utf-8?B?dEZyNXpqa21JU3VWM0NOTmxhdHd3YzRxT3BDa1R4L0N4T2UyV1V3a0lEUHVl?=
 =?utf-8?B?cnViRWI3cjV2ZlJwYW1GL0swRW5WN3JYbDBzU0V5ZVoyYUN2VUhkVS9PWkJB?=
 =?utf-8?B?eDU2cU9jK3lnZ1dOUTBBTkFLMGpjVkxDNnlKZ2tIbUwxUWpiYXlxQm4wbDM5?=
 =?utf-8?B?U2ZQZVQyRjFrcXF4aVYrRVlXSHU1ZkNnemE5aHRvcDliQkxkTlVJbk44R2wr?=
 =?utf-8?B?MG1HSGpXODAyb2o2QTIvNkpTUkVaS1BlQkFkWFFlSnV3eTkrbkJOanNQSzJk?=
 =?utf-8?B?K0p2bDYxNVhLQUlzdHVrenJnenk1MlhYb2x1aS9kU2dhWmRqdFNPS3BsVEl1?=
 =?utf-8?B?UVpwU2ZNaDJ3dnhKU1h3Z243R0J5WUxWYTBNMzZoQkJHMHdrQ1pWRGRHQmxj?=
 =?utf-8?B?QmlWT2RuMThabjRzZkdQY1RIRXhUVXlieDk5SWk5azRvZXBWR05qQTdyOGNM?=
 =?utf-8?B?dzJXVVJtekNqaGVtaWNDYXdkeVJ2WktuU2g4eU91eFk2clI4YXhXSHh2SGNL?=
 =?utf-8?B?VzRXZ0hodTRRZEVleWg3SElpLzNlNXYyVGFmS09iWVRIcTJiejUrelBsRDNr?=
 =?utf-8?B?dGUzWnBsSE9CRUNLTE02MnhZZVFzcHM4WWd4WU1VTmxEa1IvNjAxekJlU2lu?=
 =?utf-8?B?Y0FVWUtVOFNPbmo5TEhaQjViMjdrUjAxVXk5NG1rdktIcjRVaXVXNWFlOFY5?=
 =?utf-8?B?WSs2QUxlamdlZjRqb2Q2dlEydmZOQXVKRm8rRWhOVVJsbTZFODJmY2p0TEVu?=
 =?utf-8?B?Wk4vY3hUbEZuZ01qcDFwZWdOdW1JRmp5dUFkOEFadHY3Y0JQLzhkMS9GNjNr?=
 =?utf-8?B?RDV5TmNtcC9pY0xKVTlwbXhoTHBSaktwa1M2M1hrT3NGb3FsRmxyQ2FtY1pw?=
 =?utf-8?B?SFhhcVZoL0NnU0VCa3AvLzZXQ2s2blFUSS9scERjdE53U251V3RNOWRienFw?=
 =?utf-8?B?TEZPT2RBSUJwTVU5M3RHWEFNTTFrK05DMklNaE1DY2pnZGRMK0xraUNVbGZl?=
 =?utf-8?B?K3Z0Vy83aCtjWmFDME1oT0NtNHoycjN5RTJqUWRXQ2tJSlZlc0I5VDl3Q2t5?=
 =?utf-8?B?Q2JmUG84NDJVMWtUNURPT3pxcmQrWEwwd0NxdSs4ZjZaN0V2Y202SFVENUtD?=
 =?utf-8?B?OWd6WWZoUENmSjJTS1BYZEFENlYwc3dHR3cxbjNsV21WT0xxMTExdUdVdG9q?=
 =?utf-8?B?dzFqWWlTUjdOelBVSUNacEhTcTdoOGxQdGhrUEVjM3RNMU9LWFFvMWs5SFMv?=
 =?utf-8?B?K3BMY0NPVk81NytMenh3akdjdzF6SzBNSmJaYloyZjdnN2pRdmhmQ3dxd3lQ?=
 =?utf-8?B?MDhONXlvZTJ6WHpaRW8rNEhjR1VFc0sxSDNjY2hCVGZZUlB4dGxQTHJRdTgz?=
 =?utf-8?B?Ni9zSTV6NWxGYzFVU05lcWo5cEJzTFYxeVJxT0VVaHNUQVBYQnFJMnZHZFBL?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9nf9LO0iU4jjsZ11XJ0itv+rvx3dTl1ZL3lQN3gEyWJEdeCrvAC2/PYzn6WgN4uyKR8h0VzdBr2MrpcxDji0T48638uJwYj3fpY8WEhWn5UjpM77M8L7eXtNLZm0GvmefhpAL3Oacn/xPMmSy5s3i4V6fUdjFSW4EnFiJQT+wEbWYYOqQ6ieiwAhZ9cqpU9GIRp1AGxUOv6OBRmZmk/j7QALqikyFypDOe/tmsjsU5wVeHY7q7t3IJ58ZjrAcn7caBrkNdwme6H1pPTFwuw1Jjqp51huSQZlu3X+LMfaVnB2+skeSqkRjV2xkkZAOANkrlz9Ekw5gzK14kTmmsJXerbCnrzBRpCjo9d+bMYr4psRxYMECNYK1H0v7ty5QWvGdaPTkFNsss5WqFou2+tDpHaifIHunDJkfZ2+qsLiGDvEYajrYDrspLC241/aiUpSqjmpoLjwxM7NEfYOZLlCM76TXSC2f215oveZs5SGJlysH4Is3o1ARciyD07HPj7ZDkSSp2dHf+GygQ09sW0KAWlwPfu0vWxJf2LtkHwWCWm7R2MKjc7/zJU1RH5K+Tr8y1jOp6nmavmyHr1eyI0YBPoAtWn66WBiBGWvPQAZSm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee1e054-8af2-4fdb-60b3-08dc2890ccee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:29:16.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgeEQXMqjJ2HavtxDZet2EVexlBVy5DJXXNVO2xxk1m73jdWOyfo1V5OErbnWFeVX0PQUf53ky/uwI6EOmguUyAnnWVZtM4oeGrK82Z3b7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080054
X-Proofpoint-ORIG-GUID: 7-Rs0bO3VnMPvCEbltbpOIgj11KfNs4e
X-Proofpoint-GUID: 7-Rs0bO3VnMPvCEbltbpOIgj11KfNs4e

On 08/02/2024 08:23, Yi Liu wrote:
> Add device_set_dirty_tracking() to loop all the devices and set the dirty
> tracking per the @enable parameter.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Nice cleanup,

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  drivers/iommu/intel/iommu.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index dae20991e036..7636d3f03905 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4730,23 +4730,35 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
>  	return vtd;
>  }
>  
> +static int
> +device_set_dirty_tracking(struct list_head *devices, bool enable)
> +{
> +	struct device_domain_info *info;
> +	int ret = 0;
> +
> +	list_for_each_entry(info, devices, link) {
> +		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
> +						       IOMMU_NO_PASID, enable);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
>  					  bool enable)
>  {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> -	struct device_domain_info *info;
>  	int ret;
>  
>  	spin_lock(&dmar_domain->lock);
>  	if (dmar_domain->dirty_tracking == enable)
>  		goto out_unlock;
>  
> -	list_for_each_entry(info, &dmar_domain->devices, link) {
> -		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
> -						       IOMMU_NO_PASID, enable);
> -		if (ret)
> -			goto err_unwind;
> -	}
> +	ret = device_set_dirty_tracking(&dmar_domain->devices, enable);
> +	if (ret)
> +		goto err_unwind;
>  
>  	dmar_domain->dirty_tracking = enable;
>  out_unlock:
> @@ -4755,10 +4767,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
>  	return 0;
>  
>  err_unwind:
> -	list_for_each_entry(info, &dmar_domain->devices, link)
> -		intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
> -						 IOMMU_NO_PASID,
> -						 dmar_domain->dirty_tracking);
> +	device_set_dirty_tracking(&dmar_domain->devices,
> +				  dmar_domain->dirty_tracking);
>  	spin_unlock(&dmar_domain->lock);
>  	return ret;
>  }


