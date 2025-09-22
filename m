Return-Path: <linux-kselftest+bounces-42068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72CB91C98
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 16:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63302A115F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3361D63D3;
	Mon, 22 Sep 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkW8qqC4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bZEKb7dU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F61F0E26;
	Mon, 22 Sep 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552381; cv=fail; b=RTON0U7Ng2Owmow8YsBnYZHlOHLDeC79QS+Q2UahMS1BGkwqTreXJkUDKBvilFr9PqutmvALHncRax/uMfQOivAabwZwjH0D6B4Qr4pORf1t3AOt0Btbt/vy3FkmLIe5AromRX75L5JaxLKudstQXtA92g9y411VY0GS+IM4BEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552381; c=relaxed/simple;
	bh=dR8trmJG1swzSXugQtwjUxoIccPfjpHVrjvCILda1Ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fdbg0ja2JeCVSvhxCLUo55/VLsnTZoT/8PB6Eiq2/jOJMt+66Tabixn0vYOSodrS8nPRGEjKqw1fJMxvHQsQH16dpdKNbgZzgogjcnEMrLMC8aiM0kQOgGj/SpSXQ8yT1ehkQAgjzgaEgzQvhpKCpxFYxasa0HatxSipZbWvHyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mkW8qqC4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bZEKb7dU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NTrf031988;
	Mon, 22 Sep 2025 14:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3yYPfhTAXbnLLe02xopB1z2qydPihEXAiXZxGfwDNnI=; b=
	mkW8qqC4VSJLdz7IKpfmmtl3heT8CL3IQUHCfn1C0R1M2SuVC4HSjadRcbNUrgzL
	2kg/iPsdfaPyzNYLVWP7zVJPQyT9QrL6qRqK4+Agmt9ADRgABW04hSXGVyIVpJ+T
	gBvwJNbBoa0EZdCJ19WkSnddoY3ne1D88XKhDJTlS2WjS0ArcsUZVfE+3bMLBA9I
	h9IYFKNCpXHCRiLZOLGhvh3/m8/aRoKvKzAY4tzePjIwrCz8fXPaRlEkdUvtxVR/
	XB0WXpbVuozyD1ZYiEbQxH3S4+yx2SZzsiIKMmIdaYfpO5iFZYW0V4wzRNwfHC19
	U0HpqP4PB8FyOa/5US2XYg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv12mns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 14:46:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58MDWhOm028371;
	Mon, 22 Sep 2025 14:46:01 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq76g79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 14:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs+6RLM+7V1DQCp96M/tKJ0KMU/72gxp09AH2CPZVR2oFeG7UmQbZtCCG6mqpYN+2xPpzdkuBYPfuO6CjjsDb2lh5bkHEQyPU/pioYC+bZ66OgkPudTblvrvGxRj0Gf8yc0S5+mf0VqvGoqHO2eMO1mh14B5Mr7X1hqeQLvI+h2C5o+VCnwq/U0pzZdQBLsoe+i1OdJgLyTndhN5R6fvfxL7QuRW8HSlDRfdw9etU5ZDf+KX9LZThX8q7VnS8A1XpG3EMC5vW7MBJuPLHRNfoobx3ZxCcOhLy+Z45QnB9X8GA0OoAHEOTWapTQdBOWkLe+Ybd79/Ir39zWQG0sFE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yYPfhTAXbnLLe02xopB1z2qydPihEXAiXZxGfwDNnI=;
 b=dzY/zmKo+mOtamC95lIZV/OsMu99dPTjxB7MoJ3Zx5055yfmWmFfQTuLartNqfKU1zstWLB0wz0RPyM8L5gVapfdkebXWfveeNbYRBhCWqXzVTef8zC23Co64+TL7nhpxpP/y2FVqlfOsiWznEe1VM9No2mZWW0Y94FRNaunUfX8EOZ/Vkh72rNrEi1kHIc0KeuzS3XKN2ra+NGnViWieDmdipSS4XhfPx+c729AbcaUv9r2xusiidwibXoOSQBlsJdcm86iB1oKRRel0A0L5usefSr2ARmyP3zvo/8JxuOOzlOF9kY8jDnvaVg5GBEzNUTqXM5IVKNn/l39rXCEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yYPfhTAXbnLLe02xopB1z2qydPihEXAiXZxGfwDNnI=;
 b=bZEKb7dUZx6eX9mZpMO3E1tPnHWy3Yer8Jrp2VPpXfI5fZ6XB/4uuyq/o7CRoPQwnIWN6h1FJKL74bzp96C8QVlMGGpq3CYBAwpU+toyigIJeUNK6QslS4KQpyR0w4sxHuAFVIhTvhfBMUMZUQed8wt41Iv4sUT9AW4VRNYYtVc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 14:45:57 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 14:45:57 +0000
Message-ID: <11743f88-7cc0-416f-acb5-807c9b9aa1db@oracle.com>
Date: Mon, 22 Sep 2025 20:15:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v5 01/15] genpt: Generic Page Table base API
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Justin Stitt <justinstitt@google.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: cb32c50d-d20c-4aa7-eebc-08ddf9e6bd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2dyeEtycExJRXdKRDZKZ2lzK3BydnE3aHhsWVUzS05hQnNjelo2aWJtNi9P?=
 =?utf-8?B?dDJqM21IU3ZVckR3d3BUejJNRUZBeXNRY0pkSzVxT2FUV245emRBUjV6Nkp1?=
 =?utf-8?B?ZWU4RnNBeFkxdjVuVzFOWEpwVVh4dVBNdEpxdXhVdE83eEdEb2I0cFlaRjZj?=
 =?utf-8?B?VmhMdjNlMlhiUkh5eXp3R1dYa1ZCTTNCR0dzL0FnWHJwVjJrRjNwdXJYRTBX?=
 =?utf-8?B?d3Vicm9iNytiRkwxa0NNV2ZyZGpxWGl5VUdrdnlIZkxUOUNrR2NibWxucGxO?=
 =?utf-8?B?ZHF0QVhKT0I0ZVJQWHU1a2FJWVdTNnVscmZMVFpKbFpEK1d0ZnF1MnN4ZFZZ?=
 =?utf-8?B?czRxV3BmWmhZNTNlUGZuL2FCU0FmQnoxd2ZWVU5qdXNGTXhpQTZHVjBBZXpp?=
 =?utf-8?B?Mzl0WDlqTWQ2VWt1WnhQdVdzU0VRa0V2bzNnWmpLRGhxM2szQmtnSXphc3Nj?=
 =?utf-8?B?Q2VNWTNZVm5nbmxEeTJEdWg5d1AzQWJKSUVoTnlEUlRVTWR5ekE2UnJ4K2cr?=
 =?utf-8?B?OGJxSEdBV2lZK1JHeVdUR0V6anpxZWNtdks5RURBdzJkam9qR2JJY01SV3hU?=
 =?utf-8?B?WjRHUnYzSVpuWU40MkwrVjV2SkpaM2hZSG5GUmprV1ZUemU5VXQvZU5ZcDBR?=
 =?utf-8?B?NmVQaXVDcWtxRkpiRVNEeHQvUHhXSW5UbVpzZ0J3SGF1ZXJVaGlCVUM5V1Z3?=
 =?utf-8?B?TEZuY2FtTE1JcDdNTlVwaVMwazhkTHVlcDFWbHUveWRic2pZeUNiVUxKUm9z?=
 =?utf-8?B?aFZ0QnBnQVZ5RitscGE2OGxRZXdFZXRFWVFZeTNJZEJKZStDeER1c3g2UEZo?=
 =?utf-8?B?TEdkZFRmQlJXMWk0NzF0TFFrNXlkTzhsZ0owMjY4b3VtdnNCd3ZoL3hYbWtZ?=
 =?utf-8?B?dy9VdFl5UEFqTHRjVUJHdndZVy90YXJESGJaeEFtdThNQTFPYXBtQnNMNWxj?=
 =?utf-8?B?NGo4bDdFMEk5OXMyVG9JVUFFK1lJNXlROGtZZkJZbFVWOWpoMHljemlIdWti?=
 =?utf-8?B?RktNbWpOTmVBN3lXbExIQjV1Y3FjeTVTV1k4UkFOQldoOWY3bHVISXVCUThF?=
 =?utf-8?B?VUNVekxCM0VFeUVTcCtiVmc0bmJiM3Q1alZDc2xzMlJSYzRpQ2k2dXNHNVhC?=
 =?utf-8?B?dUVDbUFHRkhHK0ozcUZHelZ1REFCN25KM3FMSlVmRkZLRjRVbGxvamlhMXJ3?=
 =?utf-8?B?bms2S2VzQVF1SEVlV2E2UmEzbG8reGJnWTNaNzhRalpwR1cyZm5YTkNsTG5h?=
 =?utf-8?B?ZnBFSHh2ajBYdHZZVmpwMGhsNDZnWFFvTjJ1aHhFV1ZJNCtUNE1aNEowUUpw?=
 =?utf-8?B?bFRKQVRFeDcrbGV1N1lQcTY3ejY0OVJUNlkrdkozcHdwNDF3YVV4bEJxTDFv?=
 =?utf-8?B?aFpjVmcxa1d5Z3FvVkFwV2pQNk4zb3d3blprWXNkOFZUakozaEtycENldmxn?=
 =?utf-8?B?dXE4MnBoWFB0WmxJaGZKUmRFWGhESklNbkJOSmFCR25jRGFudlpsbUhsL3I3?=
 =?utf-8?B?Tm1RQXBtV01RQmc1TU9SY0lJTG1mNWFvazJEd0diZjBiRkpjSFZ6enZVYUJZ?=
 =?utf-8?B?N3BsUks1R2hmb1FQZ0dmSnFXS2xjVkliYWpPVThWSDVsSTY2eFU1eGloS2Yr?=
 =?utf-8?B?ckR1Z3ZqRnhuVFJ2cVZnUUxEQjVBbVlkckx5QlczR3k4ZGR3cHZiK0JURmhK?=
 =?utf-8?B?WDRqL2x2dERtc0lVVDVYU0FoMzRUNlRRTUVUUWxqT3dIWXQrTW5zY3lPdjlH?=
 =?utf-8?B?TE1pWGN2b2p6S1lreFdYM2llTGJSZlVTQUFOU0FQR0hwZEJYYmtqdlllN290?=
 =?utf-8?B?cGVtWWRDd1FsNHdOcWdHRG8xcFFJWWZiRVF6QmFnbHd5MGw5NTB2K1RiSElj?=
 =?utf-8?B?ZFdEdTJHenkvY0l0YUpMNEJTeUg3MTJXNmN1S3o4RlVFZFl1ZWxuUStFK2Mw?=
 =?utf-8?Q?sWv9tk6vzrc87a/+rQoQny4HfnhVKKOy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUdaT3ZUWkxsdTN1VXYxZ1FmemtZV2VldEpNVXZseWRtU0dCVmNDakVJMnBS?=
 =?utf-8?B?czRxUVNoK09WYkwzMzlFTUlNeVZjN1U1ZUI0MjVoMkVwQnNjSEhnc3hwSytu?=
 =?utf-8?B?UUdKMVhJR29TWVpYVUtWUURld1Rudmg5R1VYSC85ODhxNTdocU5XQ2IvN1Zi?=
 =?utf-8?B?SjdxMDBKODl0RjRPNDRqamFrcHpaYkdYaHVlRnZ1QjlFVG5TZklvU0NOUE5k?=
 =?utf-8?B?V1A4NFRSSEIyR0tzOWRpQVZCNFJDdUxYaE52ZkU2SUJQb3VrRWVGazhuRkx1?=
 =?utf-8?B?dUNoTE1QVDdYdVhiNEZzek5ZTytMenFjYW1SY3NwU2hOUEt3VTZVMGozREhj?=
 =?utf-8?B?R3R5VmFFSlpkTjgzcldFQ1dzS2p4NkpGN2VQZFFYaTBGZHhxSVd1L2FLczR1?=
 =?utf-8?B?TkxpZU45RSsyTTB4RlFCdmR3QjZCaWRTUXZkaGJGOVVFV0cyRFBCNnpPbGkw?=
 =?utf-8?B?b0JaT3lGSXRLazhaSm9qRzVRb2tOZnN2R3U4bEJLMVdCWlljcW5POGlZcDlE?=
 =?utf-8?B?U3VOMjZwNENDOFAxVVpUQ0dCNWwvbTM5SkhXS1dDV0V4cXJlVmZGbndxTWJ2?=
 =?utf-8?B?SGoyMzY4UHJQaDRZcGdnZDVoK29rZnFETU85b3UvQUVibzFqOFJuYmVnQVBZ?=
 =?utf-8?B?YzBwODVxLzkwUlkxVDFUb01neVdmQ211aUZVemFoOE8rZTZ0cVNJYW5QSHFi?=
 =?utf-8?B?dDlIWVp3QWZFWmhjNlcvd0JhNDFQVXdSMWJ3WEphRVVOSzlRckVGdmx2LzVJ?=
 =?utf-8?B?RFpBMGlkYXptbWpOMXJka2pBMENGRkVMY29CbkRFWm1jbFNBc0hZZnlteDEr?=
 =?utf-8?B?NkJZQmt1a2ZQbWZ0UGQxbE1uaWgxLzBQODRzZGp3UjQ1WldYMWV1aHVqRHMx?=
 =?utf-8?B?RWlXSVlEc2hQSzlrOC9RcXBMMGpOMmJaL2hWMlEyUHpYRll6WU41QUhrVXIr?=
 =?utf-8?B?Wjg0RnlUaFY0N3l1dUtjK2YvTTdJNWxqNVBidDV4clowRXdBeUttRFRMNnpM?=
 =?utf-8?B?N3BDcXUvaFVua2dmaWJ1VitXZDZZa1VVV0F4aHFMZkpmVW03Z1p5UHh6cEpM?=
 =?utf-8?B?Y1UzaEloZWNLOHM0NzljUlQvSmNxNnFTVzNUYnVydUtJZGs4NldDVEFCVElK?=
 =?utf-8?B?U3JaNTU2clA5ZHExNDM4dHk3dlAva0preGtwMU9YK3NlWDVINVFLTDliZHR0?=
 =?utf-8?B?ajVjdjhtcEM5ekNsREhqL2t5aktNVjBFRU5KYU9pUEJRTmpRdHM2SGN5MjdW?=
 =?utf-8?B?MUE1YXJkOUpZM04wNGVqaG1tWWxXamg2UTFiejFkM0JHd0h3aVRCRE5sOXFC?=
 =?utf-8?B?bThpb2hvTnlWczlrajdua2JnRW5za29sdzRYUjZoVSttWVUzR3JYeGU1MThv?=
 =?utf-8?B?N2taMHYrWjN1bXBkT1V2d20zbnV0Unk3aVBodDhLeDdiQWNjdlNxVjBiZVR2?=
 =?utf-8?B?NmFxeUwxaDRiYmx2bkVnNXd6YTJucFp5TTg3Q3pIdHBPM0d6dDlpbW1ZcjVs?=
 =?utf-8?B?ZkhlYWpYanIzSHRlMW5hMDVrM2U0eDFFUklJZmJURFk3RU1wK2RDODErZDlF?=
 =?utf-8?B?QjFlaklsQXkwMHRKTUxZVUppa2VDWDJGaGdXc05ucU5CMVVZZjZGNmdxNTE2?=
 =?utf-8?B?YlJaQ01pV29DY1dlRWY3UmpVczlwSTgrMld1MUFVU0Rwb3hZL21YZ3JXc0VX?=
 =?utf-8?B?eitLK1F3WFFmVGhLaENYN081aGN0M2NSVEpSQ0dvUEsvMFpIck44cFh0Zy9x?=
 =?utf-8?B?TzVvSW84clRZM09aRFhOSDJhY0RLWk5mT0ZKS0FpRklwOEwybWRSVkQreDJw?=
 =?utf-8?B?T1Z3MFdJN0RaK1RlTzM5ajZTQjBMVk9SVWtmK2FDOGllZlVyaFhvWndBVGxr?=
 =?utf-8?B?MXBQcDRQTVltekV1eitPL1ByLzFDRnV4a1lYcjJWQ2VBek85T0tWdUtaUDVR?=
 =?utf-8?B?VXJXSUwydDQ1UnlFcGZqRXg3N0JEU1dzRVRZeE1KZ1NrZXNGdnBYcXYvRXFW?=
 =?utf-8?B?c0kvei9lL0pHSXNnaVZoT2V1THk5dllRUGhmTFpnZmUySkt6eHJiWEVsazEz?=
 =?utf-8?B?dTdoL1lXZDkxeERRS0RsNGtFdEw2RFBMNHBiQmR5N1pYajNCM3M2d0pTSUZ5?=
 =?utf-8?B?UThDUTdIV0hLV3RiQTdNZi9MTWk2MWdoL1NaOVNDSWkzbTh4d2hva05vRGFx?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zUcyQ58s5hYZrALmnIoaQtpJdCJhWigQJZhtb3CWycGf2IhzT/AygO2oG9nf2eMdOtAIZ+mbKD0j1vMpmL+2hfwgHBvFWRX3XeuOOdS004Y5LnuYgFNJSePViSKXoa/AT3+sQYQUbcxgz6hTrKMTtKTxNjd70tH+i4cUSSHvRVFKvpy4f9B1p7SWioGeklVr6N3ieam2sR1dWLwgDaLvLKKUBHuZ6UJvgt3vBlSdNIi/FmKmcQuehHOW2kEThro8KjCKCPQ9TbwFzQDQENkNFqSiV+hk8yEElORWSsXeHNFB9pOs5sMHperFnYBGpSnuqzC2ri9U0Tmn9d9QcScmtpbvLFE7uI591QtOhML4EJ9t/u5HTd4M5UL7Onla2B1sFrVCQWtBY5CaOjhEd3RW1GhtrXxo6DHdfhCV5RYTs96nQXJXcGtx1WX/HDxCAwn3+W5bRMtACsaUnjSu3el++3+UA9vCBL7m2E9D810ct6KwRvtpBPEKoP0IT21N9PusQDlhcYxCbNnQFDUrnIVQ8vuIvaeBcNojC+lToYH6ykbAmgwgJfrwVlDbFMGQYlltefXesgSosyf/GNbcMbzT/PCpi0nMbzwyeBfrYpEUaUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb32c50d-d20c-4aa7-eebc-08ddf9e6bd7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:45:57.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArrRN7vf/i80QFmXOdVjBoOyznOnVnbh8m3yNLQQbaRIbQmqNwbGt30Nt3GWqLI+iKNvlOjyhJKqSdEpIMUCepnRvleya0tq2xzoJ4L4WoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX3cUvNoQq9ojb
 kgBnD6kfN+nKQtgU9vwfEAeWo01/PdhWdSx/+kvYuGr+lqEGO2T566N/MN53UG3kM1bMmYjR2yP
 Tl4FKrdp1FRFLNdvT9TDJRg5hdZAP3CzcchN13TkJBRN+GertY1j7HUDUi8B4SfN+9rVLZ8pcVF
 9VudiX2r3jWIPkhO9CleqoZvfE/xGLZ4yolLjIKCVTKaIy7U6k8LNKDXfNeeCB+J+UzeVmkWueA
 PugMB/MF2eteRnWuNNcHx8C3SP5fWAtVrHtAP4P4DzPT2gjosr60bxnWJHPy/u6iIScMD7seatM
 rhLQFG99eMHDVtcTXJrnVI06KPnbmjpLiW9FN4UlzBQ1zT+3FwMEoQt0qKPqtGy/lRXD2DEUew3
 +ApzUW/D
X-Proofpoint-GUID: _iJybUiJHk0F1GQ3khiK1awiH65fUWPA
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d16129 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=lWL9ESTFkFUYojysxysA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _iJybUiJHk0F1GQ3khiK1awiH65fUWPA


> diff --git a/drivers/iommu/generic_pt/pt_fmt_defaults.h b/drivers/iommu/generic_pt/pt_fmt_defaults.h
> new file mode 100644
> index 00000000000000..19e8f820c1dccf
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_fmt_defaults.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * Default definitions for formats that don't define these functions.
> + */
> +#ifndef __GENERIC_PT_PT_FMT_DEFAULTS_H
> +#define __GENERIC_PT_PT_FMT_DEFAULTS_H
> +
> +#include "pt_defs.h"
> +#include <linux/log2.h>
> +
> +/* Header self-compile default defines */
> +#ifndef pt_load_entry_raw
> +#include "fmt/amdv1.h"
> +#endif
> +
> +/*
> + * The format must provide PT_GRANULE_LG2SZ, PT_TABLEMEM_LG2SZ, and
> + * PT_ITEM_WORD_SIZE. They must be the same at every level excluding the top.
> + */
> +#ifndef pt_table_item_lg2sz
> +static inline unsigned int pt_table_item_lg2sz(const struct pt_state *pts)
> +{
> +	return PT_GRANULE_LG2SZ +
> +	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE)) * pts->level;
> +}
> +#endif
> +
> +#ifndef pt_pgsz_lg2_to_level
> +static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common,
> +						unsigned int pgsize_lg2)
> +{
> +	return (pgsize_lg2 - PT_GRANULE_LG2SZ) /
> +	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE));
> +	return 0;

this return is dead code.

> +}
> +#endif
> +
[snip]
> +/**
> + * pt_compute_best_pgsize() - Determine the best page size for leaf entries
> + * @pgsz_bitmap: Permitted page sizes
> + * @va: Starting virtual address for the leaf entry
> + * @last_va: Last virtual address for the leaf entry, sets the max page size
> + * @oa: Starting output address for the leaf entry
> + *
> + * Compute the largest page size for va, last_va, and oa together and return it
> + * in lg2. The largest page size depends on the format's supported page sizes at
> + * this level, and the relative alignment of the VA and OA addresses. 0 means
> + * the OA cannot be stored with the provided pgsz_bitmap.
> + */
> +static inline unsigned int pt_compute_best_pgsize(pt_vaddr_t pgsz_bitmap,
> +						  pt_vaddr_t va,
> +						  pt_vaddr_t last_va,
> +						  pt_oaddr_t oa)
> +{
> +	unsigned int best_pgsz_lg2;
> +	unsigned int pgsz_lg2;
> +	pt_vaddr_t len = last_va - va + 1;
> +	pt_vaddr_t mask;
> +
> +	if (PT_WARN_ON(va >= last_va))
> +		return 0;
> +
> +	/*
> +	 * Given a VA/OA pair the best page size is the largest page side

largest page side or largest page size

> +	 * where:
> +	 *
> +	 * 1) VA and OA start at the page. Bitwise this is the count of least
> +	 *    significant 0 bits.
> +	 *    This also implies that last_va/oa has the same prefix as va/oa.
> +	 */
> +	mask = va | oa;
> +
> +	/*
> +	 * 2) The page size is not larger than the last_va (length). Since page
> +	 *    sizes are always power of two this can't be larger than the
> +	 *    largest power of two factor of the length.
> +	 */
> +	mask |= log2_to_int(log2_fls(len) - 1);
> +
> +	best_pgsz_lg2 = log2_ffs(mask);
> +
> +	/* Choose the higest bit <= best_pgsz_lg2 */

higest -> highest

> +	if (best_pgsz_lg2 < PT_VADDR_MAX_LG2 - 1)
> +		pgsz_bitmap = log2_mod(pgsz_bitmap, best_pgsz_lg2 + 1);
> +
> +	pgsz_lg2 = log2_fls(pgsz_bitmap);
> +	if (!pgsz_lg2)
> +		return 0;
> +
> +	pgsz_lg2--;
> +
> +	PT_WARN_ON(log2_mod(va, pgsz_lg2) != 0);
> +	PT_WARN_ON(oalog2_mod(oa, pgsz_lg2) != 0);
> +	PT_WARN_ON(va + log2_to_int(pgsz_lg2) - 1 > last_va);
> +	PT_WARN_ON(!log2_div_eq(va, va + log2_to_int(pgsz_lg2) - 1, pgsz_lg2));
> +	PT_WARN_ON(
> +		!oalog2_div_eq(oa, oa + log2_to_int(pgsz_lg2) - 1, pgsz_lg2));
> +	return pgsz_lg2;
> +}


Thanks,
Alok

