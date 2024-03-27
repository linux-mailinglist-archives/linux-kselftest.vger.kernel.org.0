Return-Path: <linux-kselftest+bounces-6727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC4588EE54
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1321C32512
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE10150995;
	Wed, 27 Mar 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dWfE17pw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zEdCDWX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7615098A;
	Wed, 27 Mar 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564476; cv=fail; b=PfQI5+x1FwTLJzXwsteyP6sUXyEt53prDapGw5zBl4dK/PDb3NoHhiak59Zmru6mlVv3/jLBzq6nvhoVHHAfyJyb5eLIAZtuLyc+Hi26cQwl9IOnl1sD0K0zhLsah7WdQgQin5wk/CTj19fnM4u8YuP9z5ITq9N9IyvmMweZ6Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564476; c=relaxed/simple;
	bh=KBpXI/kFU5mt0mkJx/e0SqeYZvC6cgmiTVeiB3aHPgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pZ3JSZ+Jbd5UML0/CFsYDmsvY2zI57PAZAIRTxalNvrnF059sJhlTJQb6b6nU+SJ+cBmXwdJpnTuG39GcQb9A06paOwE9fsz2JqSs3XUxq/PbNHcC2bD9PAiXInewh9F/7OemMBrJo1TOUkqNaky+6BkA1hrP1Dn6C3GnKDCkIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dWfE17pw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zEdCDWX0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RHx3pd007556;
	Wed, 27 Mar 2024 18:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oBPndkfjXS+txjvCCAZfOTifckIagv0VDnMKaCxO5MQ=;
 b=dWfE17pw+X3G2OoJHNrNxt6m6cCLZ9Yi8tfy6glxAE4E+TSX/cin4f4b6cV+QDbEdEdD
 CWExpWP9iyTKaeIdA4Lirp8L12BWPr6L0H2I5+hmcA5fiBOGxHWtS9L1glr7uxfiTso3
 4M1dDG+Lvx9fY1aSOaj0k+LgJ0Yw3RDOZSFle7Krd1NPmt+wGZmalC6bg4Ui0sGQvmCg
 7eaKgY4YokU4o7leq5ZyJEy5MMIVo02SSZMYOiJLEljmajrvoxY+TAShOMdoRYMbz6ol
 iYwxxpDU9cUncLhOHGR+Inizc4E3ui7HVNQkGPiz0jhbXb4+gSo5itdfnRci9wFHTtMY 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h6y7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 18:34:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RH0fZt018131;
	Wed, 27 Mar 2024 18:34:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh958yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 18:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKdd8EA8xkEaoXjYq07ovPa9d6GEiCuBT5OlYREDNl9umO6yj1zXJ2bgpMBvavoNWl2XP4/7ibmSgE3nS2bHf3bXJyZlaSQg80/Pm+i9PdfaFK2xYKmVL896iYeUqSCQ77znwZHShSrgQ8380z+GYhG+JTdwCoOEB4O9KOGWX8Pb3CisRA1yydO0qPJUAl9bTHeOqnWTAtUvebtEIfUZuSM0PsM0YJRl2+KEcRXIVON+sbkfuLir3vpiKGFCH0ZoXnk5HPnFfatMSLzHBKIDdzevTDmM6/expIUhuM5EZz2IqKplSYvHZQd+wMOQbtt7SkkCctW1jGXBS4HWRYgB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBPndkfjXS+txjvCCAZfOTifckIagv0VDnMKaCxO5MQ=;
 b=gTIVF8A7o4YhTmvPRLZ9KTi108wYOeRf6U1rFgBEzkqyNZiKS7BZPG1R1+LLn4xXVpOe+WZCEXAv/x536ckwJv6WIuQuKxO92DJYuAD8iRkjH09dAZ3mgASdZIPy8vSz5NdgTixqjGqAHFetRY3mi4G4NX17ovs0xf35jjs3OUnSnJhzK+jgBg33WkULZSCT/TMsz1HGIo4AJt1VlnqDM3Y14fRlW2amW0i7mqelNXkoJQyQS5FGfwpTXxOSEGSu7eC6f0Ie9RT77DSPwpTT20Jq+5oC3E9TBwe59HqseYKRpAGRyZ25o6xpfEdMW9gMvqcT2PtEQaCozyPM8deCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBPndkfjXS+txjvCCAZfOTifckIagv0VDnMKaCxO5MQ=;
 b=zEdCDWX0S0V7y6vb5AXu9FvmwuSvvvFSSzpxSokX9JyUr3Rxo3RkSI2zginULLwkwkJ2p4g3KajaOkDmrUjivzXoAx3uKHIyBULwMOM2aa2Fop8ESA+yHukxr95t9VDktS+3XrT0s/2DtZP1Hz5kuykszxnqWaivocfT5cPuMmM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 18:34:21 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 18:34:21 +0000
Message-ID: <85b023d3-1522-4f82-86d2-8728c71b120c@oracle.com>
Date: Wed, 27 Mar 2024 18:34:15 +0000
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nicolin Chen <nicolinc@nvidia.com>, kernel@collabora.com,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
 <20240327182050.GA1363414@ziepe.ca>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240327182050.GA1363414@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0011.eurprd03.prod.outlook.com
 (2603:10a6:205:2::24) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 33457d0e-70a6-4fbb-ec48-08dc4e8c849f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YBoQmK/ASPJy/eSiE9V3PkpxGDwKOhL/WUCK9aiHCKm/6cJsqmHAoGvQW+h0HDLG4yyCBtfLD0VRoUchYhOdZuzWqVq6gpG3ajZPv7UEct/ksMizam8FFdX7ReNtl6PCcCaa2tCj+efYkrVj+eMco7W3+1T5/IOIQTL1pGZT2luqoQo70xtNwOmf53VfEXRoEZex26E7yYXNP0by3P1fdJaeWjtQrCvU0Ap1yf1WGC3UOCgHZhbgPPXU91nVahRGLiRJIECJevQAeo2RulA3LiX0xB9XYAMU2fSR6bnrUz7w4YEi/lU3SCIcbDHl4IO9vRtxAZe2JJ6EPf3nHSGg3tXyH3XK5iMpVlP2IbbHw3fZ3q6XyIm27tR8D8OyVr8F+rPNeQESoa7v0iZtUKIes+mW7IQVNp6gYOF1NenExH1gWwxyOsBsZ+Gu/ypXLl3o+qTIeYc2CTCvsSjmwFXtKEYoeqd4z0Gw1FPq+zYR/TjpfQ+ZcHeGxOUAeIN9bJoh3DU1N0xp3DjggvtLWy23VeXBkuRYNUByC2V+9AJ4gatI2WVHpbvzXZCpQFONqN9PTLnmRpdLozomcP+TfhZMXUfRPKtNViG7jnDLJr+RjSAxbFm82Jnm/wu4VGL3coK0nvJ6UrvviwYioHZ3Vdt17EmEpcVRUBq/CvEpCvYrISk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zi9HRGRRNFpRTExvNiswbHFJZHo2M1djSHdNeEFzNFI3VzhpWmZBd3ZqdEZz?=
 =?utf-8?B?WDMxUVludmEzRC9NQ3JULy91TUx4cmxXZjhSWkdSUG9jVTU1cHprOThTdks0?=
 =?utf-8?B?N2wzUnZVOHRPbStrdVovZld5aVJCazRMYVhMQ0ZzR04ra1VsV2tKY2V1Tmxm?=
 =?utf-8?B?anNpand5ZnpDdzZacnZFVE10eFNQelFuSzFkVzcxZ2xEOC8zNFJWd1Zwcjhh?=
 =?utf-8?B?djh5L2J0VWZod1ZuNDZ3Qjdrb2NLMmZZWlhnSDVBTlFHSTRDVzUwclZobEJ2?=
 =?utf-8?B?M0REMXFWRk0wbFVtK1E1ajZoT0syNU56eVZESlMyTlJnUWpTd2xpakRTbXVI?=
 =?utf-8?B?WWhaUk5qWS9PbkVvdm9mWWNWbG5oUys3TG5oQ2J0Qmp1ZVdrcUF2VElRbjVo?=
 =?utf-8?B?c29QWC92TmFDZkdVN1ZvNTVMaExOVmRVamdXV05BUXNpNGZweWppayt0d0Rv?=
 =?utf-8?B?K1djSDhUeSsrazNXMnhzL0xJZ0x6Z3JNcURPeTQwQmpIYkYwQTZZYUtUZWNB?=
 =?utf-8?B?NGN3ZEdoTXFUUmROZ0k4djZqd1MxR2YzcHJQU2tSMHZCUGRBWVd3aVk4dmtP?=
 =?utf-8?B?c09sc1d5Q2d0R3AvcUFPaU9VRmx2ZTQwRVBmaFlqaEdvSnFXWHZpTERuenZH?=
 =?utf-8?B?enZxT0k5ZnNYTXM2T0hnaE5tSHFjVmtDSVU4RWRCVU5WditSNVUrTXdQRG5O?=
 =?utf-8?B?OHZyTEpOMUZGeGt3cHczdGw1VVZpTnJBZHlLL0lQUG1ZUjdHVGJweFNUV01I?=
 =?utf-8?B?a3JiM3VWU09DSG5YQldsMFYyWlZLS3ZiUzQ3b21GR0g1dlM4TUZTZnFTaEh2?=
 =?utf-8?B?eVhQSy9jekdocnFJY3hKRlFlWm52YjQ4SDFwL0ZNdlVsYldqVXJ4b0NhSk9T?=
 =?utf-8?B?K3ZHTHNWUWNLQStaUVYrMmZObjZ4N1dUcnNJOXBXNEpCRU5WbDMyNGdLV2w1?=
 =?utf-8?B?SlhUSHkraGtWckZRNVVZVTVjam5wS3BwbkdIekUzbzQ4S1NZZnZaK3ZrRU9y?=
 =?utf-8?B?OXZRYUxwTnJ0NVlUa1FSSlBoTVFRVThWUENOZklBcXlUaUJNWStab01NYUti?=
 =?utf-8?B?ckwrVi85dHN0VjY3MFBpM1hJNjRtSGhvbTdReis2NGRlTDgwM2lMZDJRSEp6?=
 =?utf-8?B?MUhLTzhIZHpCTlRkbjRwRHU4eDFZb0dOT1FmUXJ4Um9uWnNuZEJZMnV1TEdO?=
 =?utf-8?B?aFpHYnQ4d042TEJMcWIyMFg1Zm4rK21PRTIvSDFRQ2d6WHJjU2xNWGhZS1lZ?=
 =?utf-8?B?ZVpiUnl0YlNta0JLM0x4NDBJaFdWZXFDL3hXcWxlYXVhOUF4ems2VysrLyt3?=
 =?utf-8?B?NTRIaWlRakl3RlcrbWx1N3Y2K3dYRHNZSG9pY1RWYTVadDV2Wjl0bWpjRnVz?=
 =?utf-8?B?SnNjN0hUUVl2RWdmZFVzMThIWXpTdXJZNG5NcXd0aTJBalIxVHlsSGVwN1li?=
 =?utf-8?B?SVJiOWFROElDZXJNUmdSTnVaVEdIZ2dmRE1qVElTYVVFOTNXcDMyL294eGZC?=
 =?utf-8?B?bUlGdzBaSml6b0ZGbC9kbHI5dU5aUzFXNXRTNzRjMithWXphMXBRb0U4YUhO?=
 =?utf-8?B?aEovVlNvRkdIU1ZxZmFnU1Z5YWEzOS9JZEhFNE55TUk0VWVvSkxSMjArZDZj?=
 =?utf-8?B?RnhHOUZiUStVRm1pejQrQmpQaGcwNzZNM2tvZjRmVDJJM2o0aFc3TEd5K2tS?=
 =?utf-8?B?RmJ1eEQ3OTVIOHNoc2p2di9xSTQ3c1RoSy83QWFiSVhkWDZYaE5kY2xVSVMy?=
 =?utf-8?B?a0R4cVUyTTU0YllVU0xhRlkzQVFHR3hKd0pDd2krR3JuNldxVGViejR2TTkv?=
 =?utf-8?B?ZEhQMmYxZGxTejgxVThKc3ZiRUZ6dklXNVBUMEtiSGxGZ1l1T1l0UGxBblpt?=
 =?utf-8?B?YndUcCtPQVR2ems1NW8vUTZjalVXeGowWUlQN1pKbFRmdllDT0Q1cC81elRa?=
 =?utf-8?B?czZtVUtBZHQ2aURrTmdjbThNL2NnMnZiVHpIblJxMXF1VUZjN3dXK3l1alpn?=
 =?utf-8?B?dHJiVzZGNWYxbkQ5NWpqbDBRR2g2dDFIa0FUV05xb0pZV1BKRWNnYnkrN1dp?=
 =?utf-8?B?a1ZUT3NhbThmWEZYWER0U0NjR3dYSHhuNjFZbnl5eDAwNmxWOE84Q3crQTNK?=
 =?utf-8?B?ZmV5dWpVU2lwT2VTWDNFNjhJd1lWaXJlVFV3bjV0aWU5M3Q1Y2t0VEZFK0Qx?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZuE7jUJN/sprYe7t+GKZpkGlT7WYne8v/NH1iNiv2IFyg4aL2xWqJE+aqNj8l4mIDr6mWuTk3v52ZGq13L0f5+NQSy/CaZKgkB3gmgKdZBkxUHIDHHfjvUIN7RGgeOTypGwo1S27zklAVoML4D2NoS2/K2ltKa8fSBZ4Xfc5kdYCXdBj+oKNl6V+t1GxCNE5D9FTb4CM4kSgSwosZlOnHMGBEH41aiRD0X5b1wiHiNQWRryWGzfzfcmrhsmqizxY/gMZkjtmqbf8/CbzuvzRPxW3APY6HpngLYUpSvA25Fu5JL7JKK7TGBX/48vtOgPFeE/ifh5AEb8F/t5YSZoFxrQn7T0AFBFxa8Y8UbzaGeSLLiyLraFCVrpugxjMOvxQD4y5HRUrUgf+TyCfILhTEJB+htHMqWYduVBxJXXmLDVDiyWcMxPF7jQ2ZWbzZrniip2cWGxXZciU5AwMHdsoS2ZvYXYF+w2k5G2+pyiyMktZR9XARqC31MDPUhrQqzn7Ti15Ia9w2TiFtGdt/ChPoixWuZrK0QJ8iQJHY4KyxRoq6IQJE8RN97BhOmp0io+Y7IHUmaYaqBZM3Pr+OCp5PenZm/mM177bpl53ZF+09W4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33457d0e-70a6-4fbb-ec48-08dc4e8c849f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:34:20.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: revGfU3uh5AAb3inOIdpq9VVbHHPE6ScdWnyT3hV3A0MeQAPwMy2QWLddEeyc6SQlzKasnfuqzy2fA9qJVkFTX8LZXUEkdY6GfBVYVgqsHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=872 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270130
X-Proofpoint-GUID: cz39ALRNhKoAHK0EpRbkGBs-nuhwEgyz
X-Proofpoint-ORIG-GUID: cz39ALRNhKoAHK0EpRbkGBs-nuhwEgyz

On 27/03/2024 18:20, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2024 at 06:09:37PM +0000, Joao Martins wrote:
>> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
>>> On 3/27/24 7:59 PM, Joao Martins wrote:
>>>> On 27/03/2024 11:49, Jason Gunthorpe wrote:
>>>>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
>>>>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
>>>>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
>>>>>>>> Even after applying this config patch and following snippet (which doesn't
>>>>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
>>>>>>>> finding failed tests.
>>>>>>>>
>>>>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>>>>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>>>>>>>>                    mmap_flags, -1, 0);
>>>>>>>> -       assert(vrc == self->buffer);
>>>>>>>> +       assert(vrc == self->buffer);// ???
>>>>>>>>
>>>>>>>> On x86:
>>>>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>>>>>> On ARM64:
>>>>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
>>>>>>>>
>>>>>>>> The log files are attached.
>>>>>>>
>>>>>>> You probably don't have enough transparent huge pages available to the process
>>>>>>>
>>>>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
>>>>>> After making huge pages available, the iommufd test always passed on x86.
>>>>>> But there are still failures on arm64. I'm looking into the failures.
>>>>>
>>>>> Oh that is really strange. Joao? Nicolin?
>>>>>
>>>> Definitely strange, I'll have a look.
>>>>
>>>> So it set the expected number of dirty bits as that assert doesn't fail, but it
>>>> is failing when we check that even bits are set but not odd ones. Like it's
>>>> hasn't set those bits.
>>>>
>>>> For mock tests there should be no difference between x86 and ARM assuming the
>>>> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
>>>> that I can think of that affected mock domain.
>>> The config is attached. The defaults are being used i.e., 4k page.
>>
>> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
>>
>> Thus no bits are being set.
> 
> Oh! 
> 
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -37,6 +37,7 @@ config IOMMUFD_TEST
>         depends on DEBUG_KERNEL
>         depends on FAULT_INJECTION
>         depends on RUNTIME_TESTING_MENU
> +       select IOMMUFD_DRIVER
>         default n
>         help
>           This is dangerous, do not enable unless running
> 
> 
> ???

Yeap. It probably needs a:

Fixes: a9af47e382a ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")


