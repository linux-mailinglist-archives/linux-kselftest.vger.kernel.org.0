Return-Path: <linux-kselftest+bounces-47210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8061CA936F
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F40E3124893
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97FF76026;
	Fri,  5 Dec 2025 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xu2MSdFF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bs/stRuJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDB3B8D74;
	Fri,  5 Dec 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965335; cv=fail; b=hgBjoMfXDV7ORWRtgNpNDkLS/RtT6W8XPDGAwoF3bE+HgnfWMOeMmSgZYiucUUkTQ9kkGvsBLGfa9C74/do8TKPNfxE0EobbLXZVs9QH9cufNOGiRZAnUDilGuyGgna1UNjlhMIHOboJmOtfR+Og3Hecr3jA3c/H8wk6KhbmbWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965335; c=relaxed/simple;
	bh=t27QdekrkyTDKfOSmuWiLMCfUknOUGDSd+Ph+N5URw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tYWiuvc3zsl1HJPRiatbjhA0yLSCNKXHbc0lCnlRucNi0hErG0uoZTfKx/eF/4KR+VQu05z2PtMewrvmCFHgrcTOaZs+/AiKKNOeBbpNq7ET3XlFA9rFBcdfStpBBIcdo9/HTGPxTJ+rIaM9NTg5TrAJYUEI4c4sQ2+XeHN08D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xu2MSdFF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bs/stRuJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5Jsv0b409005;
	Fri, 5 Dec 2025 20:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=innQq4we6hJh6AXff+oyypiOGsoTs+ci5wn4HBziEPo=; b=
	Xu2MSdFFYCOYOfeIlQNl9WqS+ecVVv0i4tAR9VJyu7lTAey1bczKxuR6mx1DFVzE
	6AgrYAVHwDSBQzoTTZWw4POxPUAzn8V0q/oYDBkLEOtBUMsRPrmeh/FJbZg7hwSi
	FDmdS7sRfcHvvMezZnpKd5I7tOEE9nED2gI0BtJxp0kPp6SZxuOy1vrW04Txk6nI
	ifvJya1uR/WOjqX3DrfQAOtScKbAKcRAhyGg57Z+L2apPvyozkh0Tow1S7L1lHsy
	SK+G2stZ34K1IuLYO177sOwTOuIaWexQ3S+qoF2mgmb6C/GVIJJq7iZijU5fsYux
	7qmzdwzfzbbQkm8ak07DqA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4av5yer0t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 20:08:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5JgbfQ037986;
	Fri, 5 Dec 2025 20:08:16 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9dn9ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 20:08:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8Q9nc70tTc7ud+fm0Ih/NoIuyIJsIbv/7PQ0jQa+DGXYihkD2nBsRlJXr4fH2Gd1L4fC36Z3ld2ES+eqJ8rvR/wVG9u2KuIpEoqJVvJk16pAFgdUy7Tkw6d4nE/HfBdtdZiILAq/Wsb6nVsOetXksyp6/DDBGjzKon1Soik7CI4Ds3bI79tQny+YqfPic9MdQv5p/mNcyWyftv6tsZTzhuY2OYEtYrXZokRAl6PCKWamC/7qZLroe4Lz7jN02CA0QEayBqiKJ20tGYkKrtZbOUiyyzqqyhioPD9ql9GL5K7W0MH93J2MT6rOBcljsjNVqsiJ5hTLHCHqfsl9OvXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=innQq4we6hJh6AXff+oyypiOGsoTs+ci5wn4HBziEPo=;
 b=mhpQmVA6WMs/HldUJURr05XlSJ9NZ5u5RglU4PHKlz1vAcratUZI69K2ZklBarixCdTUjUaE4FCR+NmreGSrEptsT1vAni6JFpK+dZLvML1P5iTqWMRX+CdtqnmaNxmgXdUXf4DUeL7fVlWQ0roiUGz33NhFsU4SLOzp4rDoTsEk3Y6F2YdpaWNHxEgpgkcI5UGNFH45j3u524hnTmGGnliuyuI+PLpmtjRXqKqrD8uTrdLyRdbD4nqOW9DBh+wD/6/3VFubzMyMGO6QFa/BulexjUJTBFw69QI1D+bqPnaqk69WotOdYjp/PqkGgDogfjbM112lsirT84mcq6aEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=innQq4we6hJh6AXff+oyypiOGsoTs+ci5wn4HBziEPo=;
 b=Bs/stRuJyGRGFCALq39IdsT+oZV7wJr228KDTyB1nw4jrluxpxnYP+8cVMz7pGGvY9U8Chtw7SUVj9ROfoKiO+XAZU8ieyUCM2Avd4XTTIx4H5hahoedb8GVOFrZyxSNtanQ8U8fijTWp28OkncRvQYYnmX5wh0upwFj2/WPLnc=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DS4PPF415C917DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 20:07:49 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 20:07:49 +0000
Message-ID: <54e20bd9-2a22-47bf-9757-173025351551@oracle.com>
Date: Fri, 5 Dec 2025 15:07:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/15] iommu/amd: Use the generic iommu page table
To: Jason Gunthorpe <jgg@nvidia.com>, "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
        James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
        Samiullah Khawaja <skhawaja@google.com>,
        Vasant Hegde
 <vasant.hegde@amd.com>, yi1.lai@intel.com,
        syzkaller-bugs@googlegroups.com
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <13-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <aTJGMaqwQK0ASj0G@ly-workstation> <20251205194630.GC1219718@nvidia.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251205194630.GC1219718@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DS4PPF415C917DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 5808339e-7b56-477e-dfd8-08de3439f6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEphNXZCWit5aEY4UWxPQXVnMVoxNGxXMnRxQ2VoRHoxclUybWMvdkw0NVVs?=
 =?utf-8?B?dno2amFabFNId09BV3NQRlYwTGU2eXhyVlNTTllJMXVUbXZCSUpUSXB0TXdt?=
 =?utf-8?B?UWh4NlNFK2dsWkc0ak9xSWFpMmNObkdKVGtaWW80TmUra3ZWSG9FL2UvcndY?=
 =?utf-8?B?OEMwTWRXSkNvR041ZjZWTFVGdUFmeHN0MUNoejdvVHAxaS9PeitDekhIZnQ4?=
 =?utf-8?B?ZnJPeEE4cVdXbFJEeDBPZXpic25COS8xeEcxTlB0aVJFVmFWZlNrNWpGS1Zl?=
 =?utf-8?B?dTRNNTFpbGtYUURLQm5hejBYZU5wSEx3YyszbEtoSDlIeTcwRmY5TWQzRGta?=
 =?utf-8?B?eWI2WjN3bmoranFXTVJ5YU4ydWdHekpBUVN2OENFbzMrRXNiNDRzcTB1d3pS?=
 =?utf-8?B?V0tjVW56WmV6Z0JoRFRxWG1nNWxzakhXREdnY2lPUjZ0Ty9BS0FzV25FUlpK?=
 =?utf-8?B?ai9iamZ4RHF3SkJRYTN6U1pvazZOeVA2NlY5OEFrY3NubE5rVExUT1RqdTJW?=
 =?utf-8?B?c0FjaWRWZ1EwaHVVcDVrcTI4V3NoMzZaQWRjbmcvQW5rWHJZTDZvQVVpUHZa?=
 =?utf-8?B?WTA0eGFyQVFKK25nQW5DRTI3MGs1UlVHY1RFZ083TldENG1tTTFVOWQyYzV2?=
 =?utf-8?B?TzlTOGo2UXBIbWZYZUxYeWtReEZwYVkvdWIwZFJ2R0RKdXorTWQwYmN6T1h6?=
 =?utf-8?B?MFQrQTNTSGFVY21ETXRHazhUSFZHUThXTlM2Nnl4Q3dHcEJaSExpTi9ZUUhy?=
 =?utf-8?B?djZPM3EydjAxNWFMWjIxSGNYcnpQekxnc3dvOTdsTUdxc2dIYVZPdE16ZWdJ?=
 =?utf-8?B?NVgxSTI0MzZmL1Q3bUM1SERqZFcwQzlONVhTQnJQRUZlYmlMN2QwWXIrUUpF?=
 =?utf-8?B?V2NKQ3dJVzZRZmY0aGVLMFZKSTcyLzRrSGE4WE0zWStQRDZWcXBVcXgvOWFQ?=
 =?utf-8?B?aXhMTHRIclhvd3RZSS9nY3YyWWYvQ01HNitNRlJiQTBoZCtzdDRVclRQTHpO?=
 =?utf-8?B?aVNodFRyWEtUd2JZQVVmckhlOTZkYkJzREtmMFJGMUFTR21EQnpHbGR2Y0h6?=
 =?utf-8?B?Tno5K1JXY1VKckxQREJUcTdKR0c5VEhpN08vNVdyZ2ZxU0lvUFNLSXVqbGFh?=
 =?utf-8?B?RHZhaXFnd28zTi9xTE5md2FmbGFPNHA1M0U2bXpFVVJ4Q29RRDVidndMVnYw?=
 =?utf-8?B?Y3ZYMWNVdERydThKQVMyM3JqMGJ1cUhCd0lOK0syYi9Mcm1yMTFyZkVuMHMr?=
 =?utf-8?B?ditIa2lPY3pVT1FoeEJKekI0ZDBPVm4xVzlESzlVVThXMDlxYlpLblp1N3Fa?=
 =?utf-8?B?Yi9Gb09MMnBxU1ljTDViV3NrVzZ2cTdJWktnK2lUV0NkbGl2RXV2WVdrcXZT?=
 =?utf-8?B?MmZ0UXB0WkRITWR2RXJTR3phenpOamg0a2tVUDJRRk85aTV2bmRYSktaYTZi?=
 =?utf-8?B?anlwdERLaU1pM1hYZzlGNXJUSTRCaG5RU0FFbmlTY04vbndtcDBYMnhuSXZ3?=
 =?utf-8?B?Mlk3anh4WGxSNldkNVhRQmNJQyszRStsRVFWNzZjbS8xQXM5OW9vT1BucENo?=
 =?utf-8?B?bUlZRGFxZ29wLzNJWFJFbjM2eHNkWkRISkUxZzVPajZjN3RDdUhRK1hpdDhu?=
 =?utf-8?B?N2JGMDNRbis2a25aZVQxaEwvTEoyTlNOTkJYQUduUENhQjMyUzc4YWUrWnNm?=
 =?utf-8?B?cU1pVnNWalBPR01EMnZJWDBCT1l2S0FaUzA0MlozRTJaNzllTkJ5NFRvZHJt?=
 =?utf-8?B?R3BHbldxSFluY2FMTUpUMlpiMWVjVU42eFZMT1NCTitsbDBtT0FYU2NDR2tX?=
 =?utf-8?B?Z1RKbU44YWlEbTJUeS8vdmhtNGJWT3dSdzVCMHpHaUozNWZDbW1MY1pKUDRC?=
 =?utf-8?B?QlFvczdmS2htWTRwZm00emQyRDBLRDZJRm9vWlFJNHNDUHJBdzJuYTlwdUFN?=
 =?utf-8?Q?7/oNqPiY7iNFfpgDLdQp4nFtqUughMZ8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5041.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGVLMkczdTQvSVF3b2VHY3Bza1BQV0wyQXdPckpPUkEyTS9NYzl6WERSS0ZC?=
 =?utf-8?B?c2tzTjNXRkdPMXhUNmdTc2VOSVVZdVR0QkNZZkJtYmFYdnk3YnRUODVmdndx?=
 =?utf-8?B?VzNKUUdKN29lRmRtMlVaeVRNSC9vc0ZPTHpib3VLN0U1MVAwMzQ1OENjSWU2?=
 =?utf-8?B?eGpQNUVtcTVHR2ovZWdXUlFJUTN4enBNL04rME1WcXE5dUc2bDY3V0UwMUJu?=
 =?utf-8?B?Z1lkSWdwVnBSTldDME43SHVsb1dGdElwSTAyNCtYMnV4WHJlU0JzRDh0eDc0?=
 =?utf-8?B?SC9jK2lFS0RCMjFjWGVFSUZsQmJzcXVNN2VrMEtoYW5XcmlZdnpOR0xUZVEv?=
 =?utf-8?B?UmhoRkZJbDZjbHc1ZEtod01IVU1abjA4ZWFmeFVhN1o5eGhOVjkvYWR6MTc5?=
 =?utf-8?B?V1kydmROQVZPSjNvSTFZZzQxdUJET29jWVNQYWpSWTVXOUZVMXBZMW1ZaEp5?=
 =?utf-8?B?enMvR2V1WExnQjNQcWY1N2JSazc5WFFzUGNYSCtJTzJ0K2E5YnhNYjA4TEdS?=
 =?utf-8?B?cndXZXhYVVFzZVFkNU05Mk9Td0M3Vm5qUUQ4WjdaRS9iMHFTOVhPb2EyTTZS?=
 =?utf-8?B?REZYeWNVY2Rtalg1eUhzZUxLZHhsK1E2TEdGRVhsQW9VdGdTOU9oUFAyZ3pW?=
 =?utf-8?B?SVcvajhYcmkvQ1VNVEd2N1VKeUlOdmF6Q3hmUmIrQ0trMW85Ym8yUVBtNklD?=
 =?utf-8?B?UnJHNUJLdkhFTlhXRW9HR0VBL01lbk1uUUNsYkxtSExyU28yaFp1T2tROC9U?=
 =?utf-8?B?eUVPK1FVU211bDRWNU1YVjViT2lra0lURHJBRGx6OVZQR1JlS0tsNUU2dGsr?=
 =?utf-8?B?NXBoZU5Fam0xUkt3aVFyajdqT0Q5SFZKd3UxNEF0YjNVYVpCVUlOVkFNWjNl?=
 =?utf-8?B?aVZNcTVNTkNIbEdWUms3RXBRRVZ5SnNiaHRabW1sU1dmZmZLZFNyamNIQnNt?=
 =?utf-8?B?LzZGVzNpeEhscGVTdVRrTmoxMllXcUZTZ2FWc2kxd1dLZHdTamo2ZzJXL3h3?=
 =?utf-8?B?L0RBTWRlRW1NKzBmQzN4WkxmOFAwZXROZ00yTHRRdmQxbmhxOHAvVWsxdlVh?=
 =?utf-8?B?VEZLKzQyMENhK09ndXl5QlNJcVh3ejF4VlZydTFlc2dpQ2hXUnlMdDJkT3Zi?=
 =?utf-8?B?WlF4VmRFZUU5OGtjK2VZaWZUTkRnUExLMXhtaWlJUE5iV2R6TE1nM1o2UXZH?=
 =?utf-8?B?dHFhTTFtQndicHVzTWtVK1U0MGQvZjZnU0toMzlBZnRWYmNwQ2FqLzFqSjFl?=
 =?utf-8?B?dm84ZnNsZkxZaVZ6MzRRczhIK2I2QWswVVF5d2IrWHY3Z0pRcE1MYUpYTzYz?=
 =?utf-8?B?VUllTHpGcDB0RnBId0VWQzhtbGt6dUlnZDNvM0ZwcmNSM0NLaE8rSDBJTHYv?=
 =?utf-8?B?VUhEVEttaERBa3pVOEQ0K3NlL1p0d08vTElBZjl3QmdMOXVFYTFaSndWbmJr?=
 =?utf-8?B?ZVk4VU9KS0hkVmkzdmQ2US91c1BaRU9nYndVQ1RQcy9kNWFxanoxbUM3RmJr?=
 =?utf-8?B?RGdaOUk0c210NXdDVUg5cytBVzVPbVVqTS9UUWVObXY1eG55dDUxTjNaWjBO?=
 =?utf-8?B?cEVmWEtVenY4WWI1bDdyRnlzWGhsYWs2Qk9aUlhtNnRnM0d0dnVWNEhaZDE2?=
 =?utf-8?B?cG95WU9ITkRVblQwd1FnMlpHQ2FmenJKeExZQ0hVanVYb3JSdkdBdEsyTDlk?=
 =?utf-8?B?aElQbVpISWh0cWtKU0RVVXIxUWZtZmNrWkZCV3BKWi9HOEFDNlpuTCtqZmUr?=
 =?utf-8?B?SFdRWWxiOXA2aENWYjUzVHk3b09kMno3bWxVemFwYnoyMVBsVzVsMmtEVXRx?=
 =?utf-8?B?K2VaV3R2Qm9mbGx5YU8yQlJSYlYyZXhQYzhGdTFnd0M5T1lBaTUzc2R3bU1G?=
 =?utf-8?B?d1g0UkxObHRoWHcvM3pMRTFEbkZQdU5iam9IN1pOYm8weXZuY0JybTBJc1dC?=
 =?utf-8?B?eHk2TmxxLzIzRVN1NEZwMXdScFVnK2hyd3J3d1RWWDZweUMxMTVjUlJVUUk3?=
 =?utf-8?B?SFExdWpES1l2KzJYTFF6RG96NDdrRlZLN0wwcC9WZjlqWDZ1MElXcVFmZVVV?=
 =?utf-8?B?ZHE0VVkybEtlTzRYZEFId2tHVTFSVFZkMWx3NmI2dXNCc3ZjOVNubk85dVEy?=
 =?utf-8?B?SWFWbHBKNkVncnRVUEZ5cm9YZmlmNmVFWnZ1Q1I5UU1vQlNocWd0dlJvSVZ5?=
 =?utf-8?Q?q8rhYJSCfiY+U8jIKWnKtHk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9CmDug/5MMsJIS6WKXEjNpH9gWMawyM12Rai+LO7guD4e+8l9YCmZY7LT4TODxleatLbUh5kKTCaTYLCMRzix+d9tEJewgpz1SkhQ05wFdDQnlpifj8vAA/qNm6EsG2uUq3U/H6KjN3ZBmkYqDfWrmMEscHxhnjVflhQcCTl2OA4+eBe5VkLs+Yb0paZb8/t2otQ859HgKEpP7qszDMRRjmR7pXDKVV1nnqaYz4Vj3w9rxZ+yCLxvVw+ri9jXZceZBWVbgn3j/JfPwWfvfi00QD6AFVs7Yb072x3XtjoOrsfvyN4gUMlVFiW1zKZLwDJ5wmKkTJN/Nm5gt7AjScosWvT0H2dxALsDcjPxG3zwZpBsR3v6XhH9G09+pK3QrMnCQ5lmqN2zACGDmCgl2h5N0r0RlwJtfjdpMhWRIDli7m/CI6YfU4Ok7UA4mWwSXwxjmsJvtAWY2EZFoD2X+ZsoeJy/eR+Zp+nuJUy2EbgDShNZLzJ5tYPdWNm96WGuHHNjPid1e1E7mokYC/9fw/Z6gk+KnNIal5JDICwMrL9jaXyUBldcZy6oEJQ4US4M04flN6qO1LWHMMu/FmR8hR7yC6fjBgKNIqe4Z/E3D0CTs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5808339e-7b56-477e-dfd8-08de3439f6f6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 20:07:49.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eVnSl4wdKj/Qp36qUX61hvjFbk+kRZJCrTs8s+0ugBNV5+xwbqKT7q1trCL45sBcqpHzsuJu1nVn1EN+Jd0plD8FcDanzJWNGgf8cUBYco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF415C917DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512050150
X-Proofpoint-GUID: dfnV0nr236ZeAREOlybIznMYeT3tzqY2
X-Proofpoint-ORIG-GUID: dfnV0nr236ZeAREOlybIznMYeT3tzqY2
X-Authority-Analysis: v=2.4 cv=LvOfC3dc c=1 sm=1 tr=0 ts=69333bb1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4f2jUl2I66YTYAXfDYwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDE1MCBTYWx0ZWRfX3PnLNqnWPe67
 3D1TWYJf6RQMLDYaeAe0+VSQvXfD2tJ8KgfV4aHJI9NXLWBaOYZJaYMcPJ9w1GZElzHGQm/aH5C
 czC4Uv0yRx32mszb8ej35U0IA/Ddn+U8fnVYIBDotng8UPkbKFimgAyNHNWo+Q1PNYePdN4zWG9
 ZHgBz4E1TLAi3Tibvz64MsFffMeFcv9SPiG4MfqrK9u2DdNwjHe5fWoHgDCT2iOQQPraZe9uZXQ
 tPK4vNPTVlPdmDD2IeMwWOOd5OAvlsEKkgH8Mk1HPxJv3JB0/2CZbO7keQ0L3S7UfUuqWp0/dnz
 hmACo5nzSpAyERP+BBYcGTrVsdMA4v9fmfAWYX0lgq+ujNKEnjerBUfj7XMEieuI9DeUecChke2
 Rrs8StvRIcoigxXzuvYyjf4G0x9SWA==



On 12/5/25 2:46 PM, Jason Gunthorpe wrote:
> On Fri, Dec 05, 2025 at 10:40:49AM +0800, Lai, Yi wrote:
>> Hi Alejandro Jimenez,
>>
>> Greetings!
>>
>> I used Syzkaller and found that there is WARNING in iommufd_fops_release in linux-next next-20251203.
>>
>> After bisection and the first bad commit is:
>> "
>> 789a5913b29c iommu/amd: Use the generic iommu page table
>> "
> 
> This bisect didn't work out, it is close, but the commit is
> 

Thank you Jason for debugging this. I was wondering what could be the 
possible relation with the AMD changes, since the commit doesn't touch 
iommufd/main.c, and the syskaller logs show Intel HW so the AMD driver 
code is not involved.

Thank you,
Alejandro

> e93d5945ed5b ("iommufd: Change the selftest to use iommupt instead of xarray")
> 
> It is a refcount leak:
> 
> @@ -1215,8 +1215,10 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
>          page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
>          if (iova % page_size || length % page_size ||
>              (uintptr_t)uptr % page_size ||
> -           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
> -               return -EINVAL;
> +           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end)) {
> +               rc = -EINVAL;
> +               goto out_put;
> +       }
> 
> I'll send a patch, thanks
> 
> Jason


