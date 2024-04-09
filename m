Return-Path: <linux-kselftest+bounces-7447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA389CF88
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 02:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2360FB23DA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D812572;
	Tue,  9 Apr 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZxInGCFm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uG8vNyLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1498460;
	Tue,  9 Apr 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623416; cv=fail; b=NLx4rIOCV1gmfm80Ek0g9ZAkFksGKSW+rRaw1jX/QxuZ9v9lhyyLsG6LPouqnXxeLZvWbWlBzv/wC1l3Sb8KYYP8cr5FczhehtoEK8upf4dSBnGp/mzqWqgQ7V/S/J1FOKrK+gqKyMBS+qIJWK6hnhiEgRTvoQMVIVeYb12jVEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623416; c=relaxed/simple;
	bh=IeWLMRW4hbxdOZ2JkubwCPwhg4rqaEvRJNWggtW4Mpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8OvPO3nnFJZ/gIer5n1am9jJQqjW58KWJTW0liZ89JBoV8pXkwmTrmQayNX9bICW/Ax3YA9LjD8c+FTni592+FbVjAPTKg85yRgCDBOfPvLvrvUsXH6B3oPt/ftEiXvtlR5g654B0zDp37wSVfXSAliNsDf6ZY8q6v2S6XBsEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZxInGCFm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uG8vNyLS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Ln97Z010204;
	Tue, 9 Apr 2024 00:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xJGQvLY+VfaD8EtueQi4HJac4FQX+NRIzB/7Wjjh/D4=;
 b=ZxInGCFm14evKLRSoMMJQJWrp0eH393a3YjL6gq9xZc3j2vpkLUX2UzBDpYd25tsekyW
 imUT+FvCT6WlPFj1DOq93CF0JIu8NCG4t8NA+l+ZYden0qS8M2XdU5tIY6LXx0a4pQcQ
 3NJHm0hrx/vTIKhPLuosgYzCyXIPXT/aEJWlwZZwWPwyYlFHPTRlYVea8rfjgnv0L0+e
 M4eRMi//9fyVzKRHAO1x0jzb4/LOoP8r5L9I0G4LIN7Ysd6HcMHy20RQn4kma+T18obG
 SuZyLZvM7PRR7vGWEmQFMcT/1vP5OdfVbwO4RL64qHPXfKp4OMmT1L3HzrGe6iQ+XbD/ xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b3yhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 00:43:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438MvHbr007989;
	Tue, 9 Apr 2024 00:43:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu66j5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 00:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXaUX1n5GQIEV4OptFYMj4qgQz62fRtnXiyNYwFCH9hYTf6bI18Q6SE/rZ1gkvOtI/Ya16CVbF/c6cfyo34Q8C8rpRhGU5ajT1/3ZODEetpeYGWdRLzvWuAyOF5W0jvCQJ/spSNiOjXo/C+7zlWYieU4kVw+5ebN1NjeD0xPgk2GXQ7bIH68DGjNAcjAQuK/7F3MKjMJi4CWHtwI3xF/fD9t3OMH8dizUxJSWUCq9/qsqMikpnnJiBH6oQlUOdbKpNHZfj84vvKVbdWyBkw1Oc3P2k9Awk1LLrWbCWQzdLOKe6JLK9ub3I1usFRlPMPnR/vv4ibIIf8aBUMHNHZfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJGQvLY+VfaD8EtueQi4HJac4FQX+NRIzB/7Wjjh/D4=;
 b=g506ozP7x0WB3i8aC+2AhMDBC06MwsysS+HHkv3ju+vMLHW4A9K4K9wNfQORYhJoFeTBHSenMr5UZdnyGMPvoPP7G1sNyD7aPUmLGympOCjijXT0OnLFgS0d0KtJ+VDyVG0OKPnp796EMAdMWY4dQNAGw4aMW5PdDOJ3hPfwkE6gpxhSUMAGfh/O3GUt4lorXulXXTXhxZj81nPAOaY9tSIiUEtNMgO/Zgccy6mEMK15HaMXjEwRQgdRo4K14FV2mbiCCG4RSd0Ch9JwcL1639Lc6bOY/MNjNpx6xEEkEn/bLRLPQsKePYuI6zpCjqLvE9j9LqkHKdg0BVApSF7vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJGQvLY+VfaD8EtueQi4HJac4FQX+NRIzB/7Wjjh/D4=;
 b=uG8vNyLSW/fnrqMWZhjEZC4X5iXM0SPlp5ac5mQhWx7kAmVJrHby1QgCHwq1e7KOqEfECnhL/zmArlPqGjLeP6E9O2SBFAjKniJUCOzb20A37ItEqrHmge6ZxjSNRflQg1WbPFb0v4KON8YoEa5F0rsazhYvFwah6jMP4JcLrJU=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 00:43:08 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:43:08 +0000
Message-ID: <9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com>
Date: Mon, 8 Apr 2024 17:43:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
Content-Language: en-US
To: Jack Allister <jalliste@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240408220705.7637-1-jalliste@amazon.com>
 <20240408220705.7637-3-jalliste@amazon.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20240408220705.7637-3-jalliste@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|MW4PR10MB6632:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JKvYvCdSMZI11NB1ef637alUvy83vGkiswwG+OpqrfuKprP//xtndqGjpdpJVeUdtaEd6XsByrMAHy5DaEj2Ze8tEIQ//mcgphSFDBr8sAG07+7UocF0uFyuDV64N9pXhml+G4a1EmL38HsLb/v3rTK1BjhHL6ovuuYmF8Uvv4CtJgWT+KDjF66hS/XECehXHjLqgd07uGmslpB+LGjWqy8KC0+zUZc831UTdTB4CwC6AdWMBd2DH7LmJeoYg/iLIbDF1qEzgcyawstqKzAk/wZq+3sFFvSULTejHDQk8xOqVfTxbvOklJBr5DssKnYVLieccwAIkQ8+ZbTTkYdJDObVl3fhmhAfvtXKhC+k2NevKxt3+8abUVGM1tgMQM5hNYoxW18witDMDvD2yrEozIk5TfFI25BPf1Z9UKW/izwTf6FnGjgBxQv4LCfKqBvGB5yfRFU2Sb8nbWa21D0MPetZgXssB7Y+79V350f3jdJlOP+BGF8RUIE5BSF+8xTaqJZzz8OnmSnUCOTLuo3QjwyYdV5g+hHygDhnJWffnomQuxSXbp5I4tQR4z1bNDU+6QEKRZRYc5yiqBIGK4hN8JF3pwWcDvWZwAbJ8Qy/9BRSsMiHsAFKHc9cFnsNG5NgKdp+z/2nvxrTWn5Dtmjdl3MmH5mr2B89sPGZvsbgggU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWR5cmhoWVZQVUlFajBZajkwV3FhRVdxRUlNRjlEMFZ1SEM3aGl5NzNFcnNU?=
 =?utf-8?B?Q3FKQ09hNDhWZ1JHRk9DSlVoeFBsMVRVY1BoU011VU5laHN6cytiSlc1WE8x?=
 =?utf-8?B?bzFrOXJpdVcydkFHeWZqeXpIYXJmUnR6M3ZQZHJnRnRLR0pvckpHYVhPU0ZJ?=
 =?utf-8?B?TjFNNkhFUWN2RDRIbk85elNTRXFSdENiVktXbXR4WmEySjVrRytzeUovZFhP?=
 =?utf-8?B?Mk9QWHN4ajQvRmNOQmlINlZ0RmJPSm1IQVhuOVd6VG8ybE45NXVzZEJYa1BE?=
 =?utf-8?B?WUhVdExHTk1qdDJpY09KN3d1UXRLTGR5bVpVNmcrUHVWNlF3VmR1cU1sRmpr?=
 =?utf-8?B?R1pWSW9ELzdoNkhNcUxUWTdFNU1rRnltWDlRbEhYWUpZeU1hVVZQS0lpNEdW?=
 =?utf-8?B?eVl1MUpJN1hJZFpGamw2cldmam82QWtXdnNxTGRaOUhNMGJrbk1jM3V0ZGx2?=
 =?utf-8?B?NVVLYnhoWnpHcHhPVXI2L1JRSXBTQWVoQk0zcXdiWGZGK2x0UjB2dDNHZFZN?=
 =?utf-8?B?dkVGR3MrS0cvYXpSL2tvUURYTmFrdjRkU3dEL0RzRjE2YVNMcm5sZGdDWFZj?=
 =?utf-8?B?a3dZNEV6QjlybzB1RlNncXdkQlAvV1FBOWdhSFdKclFHNTdqb2grd1dsRnl2?=
 =?utf-8?B?WG8xNG5CVVcyZmY4RFBFRFBncXJVY0JkSlZYLzBydUZmYUFPbGt2ZGtkN3gr?=
 =?utf-8?B?NWVTYzc1QlluektZcEE0clU0WTdKUStvaDZITXZXR2FxQTlteGwwamM3di85?=
 =?utf-8?B?VUZZUnI1N0wxNU1ScTlPdFRCbVlJSHpiMUV5ekl4MFY0aGROYnBtL0Jwams1?=
 =?utf-8?B?ZFNtVnpiamhJWC9nUHhadUZtK3pQMTZwcDRRN2YzbWdBQm8vL2NNMTZPYWov?=
 =?utf-8?B?MzdRbko5STdVdmtDRGppbWUxUExSK3J6elZUUW5EcGlPd3ViQVE1YjRKOHFI?=
 =?utf-8?B?dThndDBLYnllbktwVXdJTmtIMzhvMWRaUDZtWFU2NnlQemM1bGN0MEZvYVlT?=
 =?utf-8?B?Mmw0MEdXTGN0MlVublRBcGJmTi92TXhVVnI4YnNmNkRMQ3pFMkJlRm9FYjkz?=
 =?utf-8?B?clV2S3VTRFpQYmRhbUhGeTFNUG1tVEN1cGYxYkdNb0V1UmJzYVpWanpaVUFE?=
 =?utf-8?B?ZHNiRmY3Snd3Z1A5T01UVEZpNytRSy96ZTR4ZzRMbE5iWXppejNaSmVma2FZ?=
 =?utf-8?B?TGNuUWF4SHJEYVZqVnBPSXVWMGVJRE16UUZBbFNlYllIQWh1UlQ1dmNSdkxM?=
 =?utf-8?B?TlA5Y1pvdGlNSGdmcWQxRktjVXB1ZnJiY0diampnZ3BjbFNwRUMxa0pFNFhk?=
 =?utf-8?B?SmRmWmNwT3hpWVlONDJWNG01OTNqUmhMd0V2OVZvS3RtcU9GMGprRVNlSHlD?=
 =?utf-8?B?M3dyaTB4VmtMd1ZLL0J2cGJDbWczNERXZnVqWmNNcm9DWnhUWU5WUFN6UjBT?=
 =?utf-8?B?RGl0QVllMk90b0hFb1RDdUlMWExDRi9yTHpKWVp3L0V2QlJxb2FlZHk3bVRZ?=
 =?utf-8?B?ckwrUU50M0JjNUtlQitGOHBWbVFVQ0xIbStNZnJtZDA2elk1UVYyd2JGQlFM?=
 =?utf-8?B?Snhid3dwK29pVzhoOW84dFBrYkVyaXp6TzAzVC8wOWNkcVA3eEVUSWtOVkRl?=
 =?utf-8?B?NVZqaVM3NTZWeWtUR1hGQ3A2UllJdDUzU1dSQVZEMitsVDZKMEM2NHJJUGJH?=
 =?utf-8?B?cU1RczNsZlhsWStpdTZua05aQkttRGllYnVJMkEvUllpOHh0L0xQbjJoanBT?=
 =?utf-8?B?ekkrK3pJNEFUQ0pRUTJDKzA5bWUxZlB3WkUvVE5hQ0k0MG0zVkZTc0JEYTFx?=
 =?utf-8?B?ZUtxaHZLY3VKRzgwSmUyYVExWkEvYlhLQnAxRFQvNDRySjVjckd5R1UvVWVC?=
 =?utf-8?B?Ym01eFRNSys1WkxVYUdXejVadzR1ZHpDdVBHbWsxTFdkY1l6aUhGN3Fwdys5?=
 =?utf-8?B?OFNiTUZqMlc3U0FOSll1Ryt6WWtHQjdndi9MZFYxT01iSkFRL0c1dWlmZHAw?=
 =?utf-8?B?WjBhUS9mUHoydjdvcmN0SnZ1dEt6dFd6d2FXQnVuMlNJVzZXNitWVU5XWEhX?=
 =?utf-8?B?VWVYbE1qcXF4M0xzN3JPZUJRWloyRFVwNFp0TVBEUWdqa2lHTVV2MnZtem1s?=
 =?utf-8?Q?UpWdDCvaOkioVeMiuT5Tc+vqf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xn4T1rCy1javkpMIUsAzm/VIb03mqdnWDU8lhEY8Trau2vLuzjAkjmHG82EZMnWmRuLln2TquDr50HbxQpOWS2j1gIzT4qDcmQiwfQstCnCeTQCk7KoU0O6Gm/Do4pac1fkDDXpvMP1vVQZYkFcBE/+D+5O88edcug68H/td7DmkYzLg6YH1ywi1X3gDrthDanQFsz5D7CuIlRt0VsucVtj0fVUXgf6mrsRZjsSeoJFYjYw7YLRDjw29+VAqQ92x815j4aG6r/36hOc7+B5JApuTNpLABKm+TW3nmLXZ0kzj7ef2HA5J7j3Uw6fj/ADcngd0VQUjvi25Y9UrhZrwzNeIjGk4Zti1ZaMcvL9EvOs8El9LHw17v40KFkizvEKXF+tQqu+U+a54FkO6t1ZlTgPYHpMnTkN80jKDyuYhUqpFvV9Bo6wWR3/WrYpDa2UmhD8bGphj7AtKv+4srAlZ9ND4uGwL6/sBv5an+By9tDOPlWRPItIg6FzbhniEhLUwCsZVU8WckiNan7y966dw+EHxA66SSJZSWv7ddvfy/L+8KdhtL8H6Y5MW6/x9n5PZSV2ssW9Fpc1fxv8OvGDj19DyzbXjjQiDHACAVytWxTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e32ecaa-0449-45cd-e97e-08dc582e066c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 00:43:08.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or61+ylNoxQhVcmJHouMiGwyP8NEIZtDJ1CTJUZj8p/6iVxvRIR1yQBwjelnSgsmNQmSebuIz6rWlmcGrdQjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_18,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090000
X-Proofpoint-GUID: EBdqpFpaAlReNZaz0hlufIWK1uxwlHMv
X-Proofpoint-ORIG-GUID: EBdqpFpaAlReNZaz0hlufIWK1uxwlHMv

Hi Jack,

On 4/8/24 15:07, Jack Allister wrote:
> This test proves that there is an inherent KVM/PV clock drift away from the
> guest TSC when KVM decides to update the PV time information structure due
> to a KVM_REQ_MASTERCLOCK_UPDATE. This drift is exascerbated when a guest is

Typo: exacerbated

> using TSC scaling and running at a different frequency to the host TSC [1].
> It also proves that KVM_[GS]ET_CLOCK_GUEST API is working to mitigate the
> drift from TSC to within ±1ns.
> 
> The test simply records the PVTI (PV time information) at time of guest
> creation, after KVM has updated it's mapped PVTI structure and once the
> correction has taken place.
> 
> A singular point in time is then recorded via the guest TSC and is used to
> calculate the a PV clock value using each of the 3 PVTI structures.

Typo: "the a"

> 
> As seen below a drift of ~3500ns is observed if no correction has taken
> place after KVM has updated the PVTI via master clock update. However,
> after the correction a delta of at most 1ns can be seen.
> 
> * selftests: kvm: pvclock_test
> * scaling tsc from 2999999KHz to 1499999KHz
> * before=5038374946 uncorrected=5038371437 corrected=5038374945
> * delta_uncorrected=3509 delta_corrected=1
> 
> Clocksource check code has been borrowed from [2].
> 
> [1]: https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=451a707813ae__;!!ACWV5N9M2RV99hQ!JWCFSSEPaZUer553HE44W0OhktMh3-Iyz4aZNE4pcjc94q_bs4QBIrVS8ciYEzj1NigrVCamkHgpvwqP1XrV$ 
> [2]: https://urldefense.com/v3/__https://lore.kernel.org/kvm/20240106083346.29180-1-dongli.zhang@oracle.com/__;!!ACWV5N9M2RV99hQ!JWCFSSEPaZUer553HE44W0OhktMh3-Iyz4aZNE4pcjc94q_bs4QBIrVS8ciYEzj1NigrVCamkHgpv7jfLpy7$ 
> 
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> CC: David Woodhouse <dwmw2@infradead.org>
> CC: Paul Durrant <paul@xen.org>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/pvclock_test.c       | 223 ++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/pvclock_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 741c7dc16afc..02ee1205bbed 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -87,6 +87,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/pmu_counters_test
>  TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
>  TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
>  TEST_GEN_PROGS_x86_64 += x86_64/private_mem_kvm_exits_test
> +TEST_GEN_PROGS_x86_64 += x86_64/pvclock_test
>  TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
>  TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
> diff --git a/tools/testing/selftests/kvm/x86_64/pvclock_test.c b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
> new file mode 100644
> index 000000000000..172ef4d19c60
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright © 2024, Amazon.com, Inc. or its affiliates.
> + *
> + * Tests for pvclock API
> + * KVM_SET_CLOCK_GUEST/KVM_GET_CLOCK_GUEST
> + */
> +#include <asm/pvclock.h>
> +#include <asm/pvclock-abi.h>
> +#include <sys/stat.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +enum {
> +	STAGE_FIRST_BOOT,
> +	STAGE_UNCORRECTED,
> +	STAGE_CORRECTED,
> +	NUM_STAGES
> +};
> +
> +#define KVMCLOCK_GPA 0xc0000000ull
> +#define KVMCLOCK_SIZE sizeof(struct pvclock_vcpu_time_info)
> +
> +static void trigger_pvti_update(vm_paddr_t pvti_pa)
> +{
> +	/*
> +	 * We need a way to trigger KVM to update the fields
> +	 * in the PV time info. The easiest way to do this is
> +	 * to temporarily switch to the old KVM system time
> +	 * method and then switch back to the new one.
> +	 */
> +	wrmsr(MSR_KVM_SYSTEM_TIME, pvti_pa | KVM_MSR_ENABLED);
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
> +}
> +
> +static void guest_code(vm_paddr_t pvti_pa)
> +{
> +	struct pvclock_vcpu_time_info *pvti_va =
> +		(struct pvclock_vcpu_time_info *)pvti_pa;
> +
> +	struct pvclock_vcpu_time_info pvti_boot;
> +	struct pvclock_vcpu_time_info pvti_uncorrected;
> +	struct pvclock_vcpu_time_info pvti_corrected;
> +	uint64_t cycles_boot;
> +	uint64_t cycles_uncorrected;
> +	uint64_t cycles_corrected;
> +	uint64_t tsc_guest;
> +
> +	/*
> +	 * Setup the KVMCLOCK in the guest & store the original
> +	 * PV time structure that is used.
> +	 */
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
> +	pvti_boot = *pvti_va;
> +	GUEST_SYNC(STAGE_FIRST_BOOT);
> +
> +	/*
> +	 * Trigger an update of the PVTI, if we calculate
> +	 * the KVM clock using this structure we'll see
> +	 * a drift from the TSC.
> +	 */
> +	trigger_pvti_update(pvti_pa);
> +	pvti_uncorrected = *pvti_va;
> +	GUEST_SYNC(STAGE_UNCORRECTED);
> +
> +	/*
> +	 * The test should have triggered the correction by this
> +	 * point in time. We have a copy of each of the PVTI structs
> +	 * at each stage now.
> +	 *
> +	 * Let's sample the timestamp at a SINGLE point in time and
> +	 * then calculate what the KVM clock would be using the PVTI
> +	 * from each stage.
> +	 *
> +	 * Then return each of these values to the tester.
> +	 */
> +	pvti_corrected = *pvti_va;
> +	tsc_guest = rdtsc();
> +
> +	cycles_boot = __pvclock_read_cycles(&pvti_boot, tsc_guest);
> +	cycles_uncorrected = __pvclock_read_cycles(&pvti_uncorrected, tsc_guest);
> +	cycles_corrected = __pvclock_read_cycles(&pvti_corrected, tsc_guest);
> +
> +	GUEST_SYNC_ARGS(STAGE_CORRECTED, cycles_boot, cycles_uncorrected,
> +			cycles_corrected, 0);
> +}
> +
> +static void run_test(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +	uint64_t ucall_reason;
> +	struct pvclock_vcpu_time_info pvti_before;
> +	uint64_t before, uncorrected, corrected;
> +	int64_t delta_uncorrected, delta_corrected;
> +
> +	/* Loop through each stage of the test. */
> +	while (true) {
> +
> +		/* Start/restart the running vCPU code. */
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		/* Retrieve and verify our stage. */
> +		ucall_reason = get_ucall(vcpu, &uc);
> +		TEST_ASSERT(ucall_reason == UCALL_SYNC,
> +			    "Unhandled ucall reason=%lu",
> +			    ucall_reason);
> +
> +		/* Run host specific code relating to stage. */
> +		switch (uc.args[1]) {
> +		case STAGE_FIRST_BOOT:
> +			/* Store the KVM clock values before an update. */
> +			vm_ioctl(vm, KVM_GET_CLOCK_GUEST, &pvti_before);
> +
> +			/* Sleep for a set amount of time to induce drift. */
> +			sleep(5);
> +			break;
> +
> +		case STAGE_UNCORRECTED:
> +			/* Restore the KVM clock values. */
> +			vm_ioctl(vm, KVM_SET_CLOCK_GUEST, &pvti_before);
> +			break;
> +
> +		case STAGE_CORRECTED:
> +			/* Query the clock information and verify delta. */
> +			before = uc.args[2];
> +			uncorrected = uc.args[3];
> +			corrected = uc.args[4];
> +
> +			delta_uncorrected = before - uncorrected;
> +			delta_corrected = before - corrected;
> +
> +			pr_info("before=%lu uncorrected=%lu corrected=%lu\n",
> +				before, uncorrected, corrected);
> +
> +			pr_info("delta_uncorrected=%ld delta_corrected=%ld\n",
> +				delta_uncorrected, delta_corrected);
> +
> +			TEST_ASSERT((delta_corrected <= 1) && (delta_corrected >= -1),
> +				    "larger than expected delta detected = %ld", delta_corrected);
> +			return;
> +		}
> +	}
> +}
> +
> +#define CLOCKSOURCE_PATH "/sys/devices/system/clocksource/clocksource0/current_clocksource"
> +
> +static void check_clocksource(void)
> +{

AFAIR, I copied check_clocksource() from existing code during that time.

The commit e440c5f2e ("KVM: selftests: Generalize check_clocksource() from
kvm_clock_test") has introduced sys_clocksource_is_tsc(). Later it is renamed to
sys_clocksource_is_based_on_tsc().

Any chance to re-use sys_clocksource_is_based_on_tsc()?

> +	char *clk_name;
> +	struct stat st;
> +	FILE *fp;
> +
> +	fp = fopen(CLOCKSOURCE_PATH, "r");
> +	if (!fp) {
> +		pr_info("failed to open clocksource file: %d; assuming TSC.\n",
> +			errno);
> +		return;
> +	}
> +
> +	if (fstat(fileno(fp), &st)) {
> +		pr_info("failed to stat clocksource file: %d; assuming TSC.\n",
> +			errno);
> +		goto out;
> +	}
> +
> +	clk_name = malloc(st.st_size);
> +	TEST_ASSERT(clk_name, "failed to allocate buffer to read file\n");
> +
> +	if (!fgets(clk_name, st.st_size, fp)) {
> +		pr_info("failed to read clocksource file: %d; assuming TSC.\n",
> +			ferror(fp));
> +		goto out;
> +	}
> +
> +	TEST_ASSERT(!strncmp(clk_name, "tsc\n", st.st_size),
> +		    "clocksource not supported: %s", clk_name);
> +out:
> +	fclose(fp);
> +}
> +
> +static void configure_pvclock(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	unsigned int gpages;
> +
> +	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, KVMCLOCK_SIZE);
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    KVMCLOCK_GPA, 1, gpages, 0);
> +	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, gpages);
> +
> +	vcpu_args_set(vcpu, 1, KVMCLOCK_GPA);
> +}
> +
> +static void configure_scaled_tsc(struct kvm_vcpu *vcpu)
> +{
> +	uint64_t tsc_khz;
> +
> +	tsc_khz =  __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> +	pr_info("scaling tsc from %ldKHz to %ldKHz\n", tsc_khz, tsc_khz / 2);
> +	tsc_khz /= 2;
> +	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)tsc_khz);
> +}

Is configure_scaled_tsc() anecessary? Or how about to make it an option/arg?
Then I will be able to test it on a VM/server without TSC scaling.

Thank you very much!

Dongli Zhang

> +
> +int main(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	check_clocksource();
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	configure_pvclock(vm, vcpu);
> +	configure_scaled_tsc(vcpu);
> +
> +	run_test(vm, vcpu);
> +
> +	return 0;
> +}

