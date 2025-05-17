Return-Path: <linux-kselftest+bounces-33252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F828ABAB33
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 18:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA97ADE5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16C202C21;
	Sat, 17 May 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xe9gaygN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K+3AEHFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB302110E;
	Sat, 17 May 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747500402; cv=fail; b=FinjI3XQhh4giPDJGNJAwn7mgg3cK7BMzm+BhNarcE4MTTF/mG8uZDWHQKM6EIGNQ2HhlpdY44BbBw2fhyl+a+EbEs09powtYUfdvXv8lIdL7qoYWTe8yU9wIEStMANucQdQfKaGeIoasFWwJlNgcq33KuUEtNiP6fw2g5uu+yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747500402; c=relaxed/simple;
	bh=RfkWPS5kN5xVcTzkHz/XG0vgC49uCGUvo97+Tjvwvho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hum6F57kpMeaq7cX5W7mqhm7hOE2FmcEJiIFpiwJteFJ5GNVrRNiVBHmLhzH4qujB+UFz4Gl60nU6nlOoBk1qTNgjPMM4golrINMSW8x4mjJuXrflqE1j3bh999hOpSLrLT/kWgMW3k/rCbKr+VB8HYOa4z+AV46GGC8+sB3CMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xe9gaygN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K+3AEHFo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54H3wKPs028669;
	Sat, 17 May 2025 16:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qyHkUi8AFrLiR9l6Ary9YtqwUQhxffhGt1EVTYHSUmM=; b=
	Xe9gaygNxxg4H0SgwyCCVfIf9lLOxCDMVc1agweIkGXb10NOK8Pg6eeNrPMfqbI4
	DAYOn5hE3N9wB5IETvfi6FSQgmcMP9c0cRMTSZ2DheACW16X3+p8AOxwGDrx8W82
	RVG2YosFY2C08LdXFCrGHBw/RUZQlf7b2mGidbmG//Xy+yeLdVIHdc0v1ddsLoZa
	6JjbuLASCkpV1v0CEx0hqodhNv31W47PTG0RfK3b4zMZOOtgXz+4dwW6Cclrae8L
	TFwQ0Oon2Kzx1lI0D+27Zy4EqSFQGYKvgGs3PQ3KsQW4TYY2Qltceir67COn4djF
	sUokTuuIFqL8q7KSamfQYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vrden-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 May 2025 16:46:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54HAn7X6035057;
	Sat, 17 May 2025 16:46:18 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw5bw1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 May 2025 16:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmBTx0pW9UDOpIxf752XRgL2iylsy656//IKP2KpH3wNWXwNr8ciwbJnovuRSF1cgRFDe1C8S3FmBnubO5lJMci1OBnkFgcAEpR7NMGyvR1Aq1gNnETzXY54zicjbBTWdpRONZOTOHMOC9EQBn5A0lSMvaAeZIwq5PyDV+09a5hPzs9rctlg5D0JQcbJiFqVMyf7Y5+wc2HMwsYzwdDkjzHxuXKwX6BW2zR2DomzC9jCrF/rHg9fzes9hxcQduiqKn3eFfZZoSkn5mk8yOVRVXDqLvFaQ3MDbJAxmMfprVj2wEo7B9wJA6P0xrQzMFjd6nNHkRmXhwazs/GO00VN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyHkUi8AFrLiR9l6Ary9YtqwUQhxffhGt1EVTYHSUmM=;
 b=HM+9d8XBkK3iUShZQTas/ELBhyJsalM/CTeZkHYjWLk7dgDEgXuG+0lL3Q7paAmqjWIT9WpNEEtJrE8lBnS9yHkQpmNyyi5sUEUXO/NsTMlnd0U8ELyimNTyF6td16XTLzCKFDnCT2RIx93MeX/uqH4mrS6ysyol11OIu6dWg3FwHgQbi7kyTbgde3qx2Jp0nI/ZzCdmhbqAgZf3gjycdB+MS8YyQmxof5d/6Q2XxAD5Jr46JqzNE1//zwvY7YoeaJNr4CjncK/fEDBaFmmavyQE3xzMbZfr7VC/1bHYLxHoQsSmPAYRQwvaMmESH1HyDCkxxha0WZWfCpfuhFIL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyHkUi8AFrLiR9l6Ary9YtqwUQhxffhGt1EVTYHSUmM=;
 b=K+3AEHFod16AN3o2XOygqy+59VU3EhcT05en611eoZGp2TG6lzIb29BJZ9Th6GnnuyxaP7MS4LGcJ5r/jMwH+xB/0qdTYWxIq29H0QyqNnYeSEAHwixi5d8G/djFdbdQTj7fdBEhh9m88gV39G889hGS9B7w6VDb92z3+RgqgIE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Sat, 17 May
 2025 16:46:15 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Sat, 17 May 2025
 16:46:15 +0000
Message-ID: <f56dfbab-0500-4e17-beba-78c3846f153f@oracle.com>
Date: Sat, 17 May 2025 22:16:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] KVM: SVM: Add support for
 KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
To: Manali Shukla <manali.shukla@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "nikunj@amd.com"
 <nikunj@amd.com>, "bp@alien8.de" <bp@alien8.de>
References: <20250502050346.14274-1-manali.shukla@amd.com>
 <20250502050346.14274-5-manali.shukla@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250502050346.14274-5-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 85487ee6-af3d-4fa1-09ce-08dd956256ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2wxSUZGZVh1V1pIRm5ReUtwMlcraWVpZjZmbnZ3NUdGWUV3R1NuOTZkWmxx?=
 =?utf-8?B?OThUdThDdU9wM010NXBiRTVBMjIwK1NoTDlnejRDbnpLS3N4VjRvQ01PZVBx?=
 =?utf-8?B?TkJKeHNjN0R1N2ZZMUhHTGdkczJNQ0pSWE5QR1lNbkd2RmhrcXFwblJMTFd2?=
 =?utf-8?B?U2tiT2l4Ujg3WkkzMTlMakNpeGV0dndaaVh5c3ZLMFNDT0c5NEFaaDRhYzJn?=
 =?utf-8?B?RisxcGlERXFxTWs1LzhQb2pXd0FURFU0M2VETlR1ci9JS01aRWtqT1dubUp6?=
 =?utf-8?B?VTJocG8zOXRQWG5oL2M1Wkpua1lNdWIxZTg5dy96b0cwUnRhelpodEF6NkFR?=
 =?utf-8?B?azhLdUFnK29ZbjI1aUZEaXh1UFRuZEJ1dUUyT0E3TUVDS3UwcUpFQmZvaTRt?=
 =?utf-8?B?eVBlcUFUUWR1RS81WEV3RDRISWEyaTlMdG9meTRIWHBXODF0VkgzampnK0hX?=
 =?utf-8?B?QytFQ0hYS0t2T0JHa1lGOWc1VlovYlNiekRJbVBkTHU2Q0Q2OWZlSHlVK2ZR?=
 =?utf-8?B?blVuYU0yZWZ6VzBXQUh6dk1hVC9mL0I2UGg4OTZqLzVEUTZTQ0JqVVBVajdW?=
 =?utf-8?B?UjEvaWE2STNXak9wNDJKRGd1TVF3Vy9LUnM0ZEF5c2pqL1I2ZEFaZzRlTkh1?=
 =?utf-8?B?YVhiZFpwem9RRDVnL2x5MDIwSkhsOHA2SkFid05pR2p1TWQycEE0NzJtVEdX?=
 =?utf-8?B?QzRQcnVTRVVJS0x3TUxmME1tc1VJT0ZnT05PNmZqU3JacDNLYlFjQnJPbmo5?=
 =?utf-8?B?SGpyWUZuSmpKVkxhRXlIUTBUTEovc2xNUlErdUNqYSszc3AwWUpsbHkweWdB?=
 =?utf-8?B?aVhFY3VGVjFYSWJ2TzdmVFZjZDAxemtZOFFxZHh3SmtvaVgyQTRaa3RwWkZy?=
 =?utf-8?B?RnI3WURnZ3lITjM4K1FRZ3pqek53ckhITStlOEFBTGJuV2JIYmNIaERuWFlv?=
 =?utf-8?B?d0p2eUVNL3Q4Uzd1UHhLSldUZ3hXaVBwUm41d0pwdTYySjRBdkMvd3o4TE1o?=
 =?utf-8?B?SzFQQmRrTnRKR3I0QnlhbjVYVmVjb0FRc0VhVS95TUdXNnZ3SGUzMW40K1Vn?=
 =?utf-8?B?TlVsOWQrelovbWlGVGkrZVdySXRKWnFydW9za1Y2bnI3emNNWXRJU1FJUUpQ?=
 =?utf-8?B?aG1aSTJuWVAzcHAyQi90bjRFeU1LQjJHQURHWFJ3VDVuL2xaQU04UDM5NTJu?=
 =?utf-8?B?VE11L0Z5Ymt4Q1BYdVk4SzdjMFdhN3JseFpwWnFSanBoUUJ0MTRXRWJaZ2k2?=
 =?utf-8?B?Qk0vQlJLQXprcEJFTHhYbWhGb2ZzQXVwelhmblQvdEdBcmIzaEhmVzQ2QytT?=
 =?utf-8?B?NThEK3JRdGlUbm1wdGk4L2JDT254LytGZTByY2w2K2NvSXEwK1B6cWRSOEg2?=
 =?utf-8?B?QzdpWjVYbUJMa0NZdnJmRjZLRzk3Tyt4YmgzRHNvRzVlV3RGWmlaMUlSVTdV?=
 =?utf-8?B?Yk9lN0w2SHcvU1h6U3I0WEVDWXA1RXRWREtJNlhGbHdCWVJDa29OQWxPUmZl?=
 =?utf-8?B?OFJrMkNXa1lVMkRXaThKZ0pENzBBNlBEZDAwZkkxeUx3a0x3bmcwRDZOUnlG?=
 =?utf-8?B?a3FFUUE0Y0ppUkgxZmNBc3pxQ2N6S1c1OHRQK2NpSlZXZlY1Qi9CNUpwMkQ3?=
 =?utf-8?B?REhRZ3JzU3dFekk5N0N4Y3pnRGY1bjNtcHBFWmovcldsOStFaU4xemRqT2Jp?=
 =?utf-8?B?c25TWFVocC9YRlR4NERPVkJGM3ZYTlV4REVkWGg5ODVVbTBFTGJCd3hVeWtj?=
 =?utf-8?B?V0RsbVpUQXUybkc2aU4zQ0g4c0FoRFFNNXdWSStlYi92cXVtYnducDBqUUFi?=
 =?utf-8?B?QjZwY2N3Tmt3OTh6KzhhMityQ2dPaHRtdno4NkN5UlVkLy93aXgzd2hDT1J4?=
 =?utf-8?B?dmNTbWV6bjRVRHF2SEJ0a0Y3Vm1YSDNmQUhMemdpTnBKc2w0WCtCSW1YUjZI?=
 =?utf-8?Q?2eTHtFtDlBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0UzQXNyU3RsRDdaRHkvcXVFclZIa0I0Z0RkNGpNOGhuS3dnMDVTQzlSckFE?=
 =?utf-8?B?YXNUVElta05xK2pIeUJmYmFwMWhhTEpWWHVuTmpzWm1IZ0NValNOak5LRGxl?=
 =?utf-8?B?d2F3YmlQaHArSEVyYlFrYkJTQlcxOUpyRUZ0bTN2a0RBdElJYm5idzVacUF5?=
 =?utf-8?B?VVNjNGZaSURKT25mQ2xpME90N1UyUGNGRGZDcXcrTEY2bHRPaytpaWdRWElX?=
 =?utf-8?B?ak0wcUpsY0hrMHpjUncxQ3d6bCs4eitkeXFGL2hkY2ZTUTNPdXRqTXJMNXI2?=
 =?utf-8?B?YWhwWkRKd1FDZ1QxUnhPSzY0SmhnR29IdzBCTEE2TUlyQXpEWTltZEdLSUxt?=
 =?utf-8?B?Q05ZWW0xMlZobTBDRjBCaDZJMWVkb2lIMWd1bzhmNk5nWmNWdEt1cUYxS3lo?=
 =?utf-8?B?b0NHVGpNeFdsZEpXSURSSU5KUmNpaVl5RGthUnZiOWJ3K1VYQVQ5MjVINU1x?=
 =?utf-8?B?RURqdS8zaS81ZWY4QjRkdTdRaHdaUU82V0lYby9pTjBBTVBINFlLTFl5WExu?=
 =?utf-8?B?UFM0V0FkOUFULzEvaTZuVkNGa3JNRm40Ni9EeStMWmQ5WFc4a0txZ2RBRU95?=
 =?utf-8?B?VVp2NE9TWDMxNGZTenVodG5DbDFPOEM5OHhtVDlKM3g2OWNhV0lrakg3RUJE?=
 =?utf-8?B?MU5rb1lLWnhGZXhSVTNkeDhpYTFCN0lUZHkvOURMc1VqaUVkK1RjVW9MYzhN?=
 =?utf-8?B?eVRuaHdablF0d0IvZXdNMlNFUkYvbHJUMEUyTG5TL3hNUEcyWmFMeGRoWlBJ?=
 =?utf-8?B?N2F4OTlxT3FNOGFDUmQwcDhyMDdkTzFwMTRPbjU3VHgrS2xvL1F6WXgvTm1p?=
 =?utf-8?B?TkltMkZOL0IxeHY0NFV1ZEFhWS9zaTJMTG9KTkdxVHo1czdXbVVIZnBiWHRM?=
 =?utf-8?B?WE51UU50Tnk2WFlCaTFoT25nMGYzRndVYzNveDhCY2xsbG5VRHVKWlU3ejI0?=
 =?utf-8?B?b2VpemJDTkRhZ1hnZWhaWS81OUlRQ3dpQW9VRWhtWEFab0dCMENtaXp1S2lW?=
 =?utf-8?B?L0hjWnZwaU9xeCtTblEycTg1cDhkZktWU1lQVHphaUg5aHNsVUp3R2dCZ3ZN?=
 =?utf-8?B?SlEyTzIyd01Ic2M4a2tlcDg3QmRCUXRsZXVZbEZucVgrdFhqek9PZ3ByYnU1?=
 =?utf-8?B?cEp1ZWxaTEg4b3hLaWZCNWJSRXhOYkhPckd2bjdYKzI4L3RHNjN4NEJuT280?=
 =?utf-8?B?Ry9ieUdGNU55THh0TXY4UnpyT0pXanZBK2JDQXg3Y0ZkWkIrdGFUVHEvT1N0?=
 =?utf-8?B?aXA0SURXTHNCV2kzMkZKRkdJMXAzNGY5eUtYc0ZTRlF6OVdhMERNalllRGpt?=
 =?utf-8?B?ZUlWVzNudGZWWERLNWRQSGJBTmRlZmxNWTZZWUlhZUNGcVVmOGNRc3ZmSUtJ?=
 =?utf-8?B?dDlSbklqOUszZzlINDdieVdIbUFtQ3B2eUFYZU4xdCtOQWlWS09UcXkwNnFK?=
 =?utf-8?B?WjNpTC92WlNaWXNPMXJhSEJPWGVyaUtybXV2ZUpNdE9IVXh6RE5iYU9FZUh4?=
 =?utf-8?B?TS9CUng4NmQvOTM1aDNqL3dISTlZTDRYbFFqSENKb0N1elZiL21lYkRPTk1R?=
 =?utf-8?B?TFRpOWxsY1M5aDdZMzlOSlE5d2FJVU4rVElCUnJiME4xNWx2ZU8wWTA5eW80?=
 =?utf-8?B?cFVnK1VUanNQZ0VjSlJPZnBsVG9hSVpiRHpuVngyRnpnSUxIZ0xOY2RGa0Nv?=
 =?utf-8?B?djlhUjhkUEhhbWg2M0RSVnorYWZXSm9Rc1Q0WHdCcHdzZnhUZTZ0ZXRDN0FO?=
 =?utf-8?B?VFo0YXhnd1ZYTHVBQzF4SFRQaVhSd1RaU241U2w0SklRUG1kWXViS3Rha21m?=
 =?utf-8?B?Z0R4ZVRxdUZaNFZzM1NZdmZ2c0IzVC92YURGSU9zMWU1RjNJZzFWVlZBbmVR?=
 =?utf-8?B?VDZtRXpSY1ZEZXB2K3krUHU0cTc3WHpRb1AzRFdScVZpT3VaOHdzZHZsQk9U?=
 =?utf-8?B?ck9XQm1QYVZsN2NqTXd5b1BBelBIUTVxcDZsYjVSQUVyL1JHOEtZYWFDRzZY?=
 =?utf-8?B?ZkRWSFJkc1kwWk45ZlpMT1hXak5XSUp4K1d3eDNDQmFOSkZVREJQd1JaV0hh?=
 =?utf-8?B?NUx2K0llY09WblZLdUlIQVVHcExwNlV2YzFpRVdyZEQrUmY3QTFVMWE3SXdS?=
 =?utf-8?B?SXdJVTl4TUtEcW9kQkVZUHllVFdFdWRsSHVJUDBmZVpFaE1iVGc4VjJXTmh1?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KtWPzLTi8Ween/M9DiKTwpCiGoj7tEyao0BL6dQV8M3GFdOyRFYNM6CQp6a0Gn+0OstcCkoqX4leAmcERwxW40XbJT6HifJfaNJ41HMR7/UY3btGz6rognWM0r7gPAaYQl2jQxYWJiNGG3WvkH0WB3ANv0Ssb8iC6k2VD7hvJf3rYzareYsaL6ajHqr22qdyURGSZ/BXKq/DYJZ276vMS4pG28kQdU0u9ZFAbujURmG6Y1J7QSlRaDUtNezBCwo7AWHRzEFcB887YFVeqzG7Fbbx3ztXI8v+30QqyGGNaTiC3Zxun/V6zpgvKsilfTRoNC8zBB21gAdODjB8kkCXrff9jCM8sicEsU4FC5kl1Pp4s9ouL4joDyLJwolR45TyOWsn3TFSuctUHfBr+8OfyKt9AEfZG44gSNZYTqqU051s+7sEo33V0nKFHrTLRBZTznmGAMnv3O1+pxGixNbcAJ3VnQoUXpUTfIvKTEP/PaDKvobKc3v1lY/6q+dwjvogUQP7+uW6dnR5zMXpP5t/GGXiqgAVKWifzzp/9MBGywSVIUMqatk1n4Qs0TGeChUkf50Qh1eKaD4fARKL7OKf78+DlBN8PTNnJ94YwEv7Zuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85487ee6-af3d-4fa1-09ce-08dd956256ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 16:46:15.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZIPJjVTH3HWIBYcfd7bxwtde2BAeMNIVE+A/hzHtkp5uhuwEKxE57e4My5hoVBF/P4jBys3l8xFGPQ0dAe/2isd+M5agksZ1uqVqnYvhQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-17_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505170164
X-Proofpoint-ORIG-GUID: HmaVy2bId7EfIvdvCFqZatUuvqWqXjX9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE3MDE2NCBTYWx0ZWRfXyoS8qNzxexUi wC8NizrgXoUeXgIKDlPPFaZi4cHSIC7mRqmBv02336dE2CkNGsu9LF6YU6+zigir4wRys9QooG8 jr0nYK1aPq3KVbnTT5CIJ7sRYHapF43MPBeVnRl6unKsD1sXcRAHgTxawqHvm59P/SM1xbutH2R
 2Muqo6SeeM8b+lLzxDvFjqwLYeKRAzI/vtVbDPena3o+/rxsbYBJYVHgp93MbhK490K8180lTn0 TgYG+sfUi+FwernW99nob/sIZG0A98K7PTDVCsSv8Sn5YF9liAHB+GHdaQ1WSA1r2RbE1/GU5cY HMKyeI+P8IB/Dp7S2kQwqNSiimGY7TA2uZerWQTIKVZA42Jwji/RzueR/Y9LutCc0/dEtdH6ZQi
 tDCu/h+qojXHNaZDcO7t4GkDEdr8ETSks45dRKjYY8q3w1P9NzamNKD7+og1NYDdZ/v4u20j
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=6828bd5b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=IU0a7c_XJaUAr-6_VsUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HmaVy2bId7EfIvdvCFqZatUuvqWqXjX9



On 02-05-2025 10:33, Manali Shukla wrote:
> +	/*
> +	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
> +	 * instrution; otherwise, reset the counter to '0'.

typo instrution -> instruction

> +	 *
> +	 * In order to detect if L2 has made forward progress or not, track the
> +	 * RIP at which a bus lock has occurred on a per-vmcb12 basis.  If RIP
> +	 * is changed, guest has clearly made forward progress, bus_lock_counter
> +	 * still remained '1', so reset bus_lock_counter to '0'. Eg. In the
> +	 * scenario, where a buslock happened in L1 before VMRUN, the bus lock
> +	 * firmly happened on an instruction in the past. Even if vmcb01's
> +	 * counter is still '1', (because the guilty instruction got patched),
> +	 * the vCPU has clearly made forward progress and so KVM should reset
> +	 * vmcb02's counter to '0'.
> +	 *
> +	 * If the RIP hasn't changed, stash the bus lock counter at nested VMRUN
> +	 * to prevent the same guilty instruction from triggering a VM-Exit. Eg.
> +	 * if userspace rate-limits the vCPU, then it's entirely possible that
> +	 * L1's tick interrupt is pending by the time userspace re-runs the
> +	 * vCPU.  If KVM unconditionally clears the counter on VMRUN, then when
> +	 * L1 re-enters L2, the same instruction will trigger a VM-Exit and the
> +	 * entire cycle start over.
> +	 */


Thanks,
Alok

