Return-Path: <linux-kselftest+bounces-36352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702BBAF5F73
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B41C271E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B92D94BB;
	Wed,  2 Jul 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TkReoI78";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tFAbfqEp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191C2F508D;
	Wed,  2 Jul 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476019; cv=fail; b=nyBmUxssQ7FdRAnMuhNavFZ8vp5Znofz6oo5adnlYxYUcepeJk/1z6EcOLEqsj8O1m/mjwY5jK/joVAojeDSKS36ZdN9Gwgzo/dINLZCtiSNGxEdPiGFnQEx81/jXz/Diq7DFZUrnyMDz4Imbn6AHi5vpuuKPO3yOrDxzK+CEC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476019; c=relaxed/simple;
	bh=CMq9y9zF1aD9+sDk4Nqy7UzoXv5C6FTo8z20KCIE85k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ut6crg4Xg4tKX8gNkt8dz2u1ogMp/SvHnE4ph5u4Waao9HQ5zb5kRkKv5nXHah/39cOlRbNyUpAqRDXKtC+nIbd7pRTDd1NQY5jaD/PuynAf7KjDHQvw+eQqpoycaTiO/uU+fLev80OqzTvp9lZc4jXsAXTSWCWXtWGTq8VF/6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TkReoI78; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tFAbfqEp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562GBw0v010238;
	Wed, 2 Jul 2025 17:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i4LQD5dK+aOmeMhs/eMwYPLQVnoVqWDUsj/UBQ5cE/Y=; b=
	TkReoI78Fg1rIKDLx1RhamEicX9JXfUWqj9b1CHjHEPyDPzDbODlAKHJOcibX8rV
	82xl/gFe6mpWLecsvYEo9hOezrErvyVqClJy96UtggC75UYqRgaFe2lPdtYed9IK
	Qq8Yob4UBvt4uvLg+h2iH1UD8xAfWTGIeB3AQ+wgG2RtHytBR3/p8EdHr/dCe66l
	eU4tNsyL9ZbU9SNhaN27RZWGMxldD/siaeMnOUH9sy08B64iAxD/q7ynNkKDawke
	vhC3qb9a0MoT+tpWqabNcZVaXhtgHngMEUK8lPgi0sqpz+OpoUvt9uSJe27rnwGi
	0imMvG46BiYvL7cIyagFyA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w7cj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 17:06:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562GFJBm019568;
	Wed, 2 Jul 2025 17:06:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ub8bwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 17:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuEwbLwS6pnek6B6XRfII030NUjbYTMjTaj63X6cCL6MPIRfZOidLaqjjLJ3G/8yEZaiJtlVkaWkyUZH3xybALQs2GbYTmwTo7WOKcdX+feOyK1c2DVZb9Ih19DhilY8lxsarQsszD89WCAFT3gT5uEVf65HhFArOVl+e2cWTlFxCTpeuulwPW6wy0tXZibZyJUJuASSCFtnbXtrrzw5uABK7PV7otpdLRKwXAaCKoyP0lBV/sdcGPWjMJf86VVejHfnTd1G8Bp2TKzRaKwjqEY1K2tl6ERfzkUfiJJrMiqcl0dglKlN5L6TuA90z1NsPYU8yS0yzO+fmeHtwFHkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4LQD5dK+aOmeMhs/eMwYPLQVnoVqWDUsj/UBQ5cE/Y=;
 b=SdL62cZnI0T1T9yHEcG+Dr+qEH9zbcDkZlF2/uwcpYyWlViB2fnYgR2rbptUHQdDQk66zCOrj0hrVYfclw+nTz22S//c7K2tNmCMbYzV0uNb1YDw05pLiT9OVysnxpcWM7nlkS21mRvaIN9iuOwlGJN0PxJABBX57ECjL1UeRSAm88c0zWbuj0yrcOaoTIy87wDk55QUJJzFkx770dS9SrMKm6Lm6C4AljjkNQeSvYY0UqzTKiOG58yjXgfCX0E7sAwPzP+I9FpYPjSzWlGAIfclNc1HhaupDB/2dCMpnKDgMVcdp24T+lZsvS8nXp9prLhV+wP4AOwkGkO8VEAODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4LQD5dK+aOmeMhs/eMwYPLQVnoVqWDUsj/UBQ5cE/Y=;
 b=tFAbfqEpDeNsbaNAmxqq45ZiWE9Dab7vKWnFmiF9Ng206op8Uo1ibzI4B4n1pgKRQP8B9t0rhga2wcstO2PwPwFaPQ5IvGo1CPrr6jHdHCSaIdlIcNbrtaSglecu7kQ2seziv3bhvlKc6Q3Q6aWf6rsJrZ0fzJ25Q62taR0BNGU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Wed, 2 Jul
 2025 17:06:32 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 17:06:25 +0000
Message-ID: <536f5e7a-ece3-465d-a01d-168cadbb90b5@oracle.com>
Date: Wed, 2 Jul 2025 13:06:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] iommu/amd: Remove AMD io_pgtable support
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
Cc: Alexey Kardashevskiy <aik@amd.com>, James Gowans <jgowans@amazon.com>,
        Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <14-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <14-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA2PR10MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4df97a-4d40-4f9a-c309-08ddb98ac701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHNoT3I0b1F1VlFUd2VsOE5sNHNsVElOWmxuSmdGQTIwQTVvTjQyRzNrdEFD?=
 =?utf-8?B?dVdOeUp2RHRIMUdLcFhZVHo3M1lNSVFrQmE5SDBjc0FEUEgrc3BORDJBSVRI?=
 =?utf-8?B?elUrSUpMdW90Q3VzR29SZkpLa2d4QjBCZ0ZPOGQ2TjVMOUcvM2NTYWlvYUlN?=
 =?utf-8?B?VnlNNzVBalFteFBBTC9aeEJTOWtIc3EycG1zZGVObE8vSjhlcmJ6alZjRTlw?=
 =?utf-8?B?NHJhWDNIMnRCZzhNQTlBZnJhOWt2Mm9CSkZVaDZnM0F4a1ErcWV1VW4xMjdW?=
 =?utf-8?B?WWl5MEUyVUk1L2R4WjV1My9uYUg2bU1OMmlEOWNhaWpBa2JzTjhxcmdQVzRn?=
 =?utf-8?B?cVBsbUovOGw5eGVFUTIwcCtvN3JkSDNhbWY4Uk96RktmYk5kTnBxVCt5MGVt?=
 =?utf-8?B?N1VkS0JWY2VrZmNaRkZsaGFXMGdYdHlvanRTclFWblcrRDBLU3h1TFF0dWNT?=
 =?utf-8?B?TjRMS25sQU1oZWpJUmM3RzI3a0xXY3lSbWRRMEpVK0NYbENXMzRJWDAwL29u?=
 =?utf-8?B?aU95WUdYYURnNkpZRkgrOThLWGVNNEowNUU3YnAvYVQvQnBwNDhzQWZDbjlP?=
 =?utf-8?B?OS95YmgwbzZLSEc4TUJkWUxiK2dYVHUwMTV0LzVGU0w2VlNpSG9oaUI5L0RW?=
 =?utf-8?B?TlRsMnViNi9IZFZGaU5BZ1NtRjR6cGZ0SytKdVFhb0w5OE5nVDNLMVd5clI4?=
 =?utf-8?B?T21MVTNpZStFTjF5Mnh0Um53cDh6TDFPZXhZQWhOQWI4Tk9QcXlNYklWRDFX?=
 =?utf-8?B?Nis4dHhISXdXc3d6ZHlTMUxsUjVpY2F3SEhNZWlPeWpVSTVIeVVLTlJxb00z?=
 =?utf-8?B?Q05DdnE0TjkvR0l1YU1tTzBsYS80a1luU010Q0dVd1VrcVE1cGpiNVYzZFFO?=
 =?utf-8?B?ZTVsOHZ4dHhhU2MvT1l6bVM2bEpPZUlIYXIzWm9PckVGWlkrTDRnd0tKbVNQ?=
 =?utf-8?B?SFR4d1I2NzQ1aXMveWczSFJDbU1HSjdJb2ZqdW5aVzh5YWgyd2RQMm0rUkcw?=
 =?utf-8?B?cnZ0TXBDTnhmZmhNNEZmMWQyMjV5b2pLUGpTcTJRcko5dnJVcFBKYUpaellI?=
 =?utf-8?B?a3BRWFYybHVoK2t0ZWVaSkZkODNFeGg3R3ZEbmIwYkk5ak1sQjhLM2VmSGgz?=
 =?utf-8?B?bVZtOXQzWDFGNFErd21CL3hDV1Q0MEdzUlptSnFwWUNjME40amg3Z2d2RCtF?=
 =?utf-8?B?RFEwNUNDc2owa3VMQ3QzRGRibXN6QXR2TWdmSTRrT1JkbTBiMVZqN0l5bUJ0?=
 =?utf-8?B?MmJVdFVXbVF1VjI5S2dpdDZ5NmU1YXJJd2plckRHcVNnWGNPTzFNOFpqTUd5?=
 =?utf-8?B?cGptT0Z0a2tFaVh3cmtGbDA5UXBCR2Fia1J6ZVBya2R1WWVVdU82M2RVdHFt?=
 =?utf-8?B?S2lUcE1sM2ZSNFFsM3RQd1c2QytPcXJXWk1qb2UwVHBUbzdvSHFXT3RZc0do?=
 =?utf-8?B?anNXQy8rRFRtTW1jbHFvdHQxc3dtcUt3YWpCN3VOVWRRSEZXTDhMeTZPa3J5?=
 =?utf-8?B?eU9wemdoZnA1bzdKM1ZUclh2Zlc2ZFcrdkk0dHM1UEl0UExtVFpGbm4zUnF3?=
 =?utf-8?B?QVdtd0hJWWFrdGQydlJwSHJUbTNmLzdVTHNoYXd2Rk9DYnVkWkEvaWpUUXJQ?=
 =?utf-8?B?M1VoM0FVeDUySDlyQnBWa3ZEWTk4OGpOQzFwZGJMai9naGlDVzQ2QlNGRmRO?=
 =?utf-8?B?UUhyRlVrdWNsS244QnU1WGxwemRWaG5vMXJnQndINWNka0c5VzI1anZacmls?=
 =?utf-8?B?WmRwMWdYYXlHUDZRSzM1bmlabXA2RE92VWMvYmJUVmNESXd0T3NaQ2tWREp6?=
 =?utf-8?B?ZE1RWkdyQ2k0K3FJZlMxYU4xZVBDK3d4M0t3akxyUVhXWGllVExDT3JLS1R1?=
 =?utf-8?B?OURyUWloeWswWmorWkpveFZpTCtpZW1tTEJOc2Z5SFlMRnNtU2M2M0I0WkR3?=
 =?utf-8?B?dDR4NjVnTTJOVXFjZWx4MjRQWXViV0w5cUlYc05yc2s0ZllvUit1MTYrR2VK?=
 =?utf-8?B?WDR4WFBlUEVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5041.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTRlZFFNUE1YYU5JT0hyc0pHT1p1empYK3FucEVRSWMyNjlaSmIxVUdlMXlP?=
 =?utf-8?B?Y3EwakxBdWd4YWlBRHBkYklpYk5yeWg4ZkN1c3VGMjU5TElGelA3V2hlbzNR?=
 =?utf-8?B?UUl6VTZ1YWdUM083WUdUUktGYUYwbU5WczBRcmpjbHcwUnZVZGpYWE9jUHBj?=
 =?utf-8?B?K0c2ZTRGVHc2c3d3QkdRODF3TEpheUZ5WmEyYlQ2b1pNWlJRRWd1Q3pMbTBu?=
 =?utf-8?B?QVpKbmlMQ1VEVXRqVTdGYU5YdTgya2VqYnVOQnpPQ29PKzFxekRhVEpwNjhE?=
 =?utf-8?B?T015NzQ5Rlo1YUNyeUNZVW1xMWZoWGtPeGJ4QUx3YkNuZW50SUp3V3ZuU1NI?=
 =?utf-8?B?WE02MXhyL0lYSmx1Y3N5aEdRWkNCeFNuU0hSUmNOWW5SV1QwSUJYa2g5RmNz?=
 =?utf-8?B?MmhzMEVzc043L2lwQlZTVmRaeGJIU1FiOEhoYTJWU0lzaXNkUVpPQkg1b3dw?=
 =?utf-8?B?d3g3MjNselFpaXZ3MXJmOEdhaUlBQUd2VlpDUDlZWEc2eG50U0xabHhHdDk4?=
 =?utf-8?B?VHFVUHhZWjVvWlJjb3BZSXh4eXFvbjBnMDlUT253TDBjeWxGZGVJd0tCa0w4?=
 =?utf-8?B?MmN6VkZiSGNhQ1RHVTNuekcwT2cxZ20yTmsxOWExZVhreHBpNjZlWFdiMGxz?=
 =?utf-8?B?TEJkOWZ2ckZZdXZ2bmZKSm11bHVCMkdrTGtqZUJ0MWlOR1h2Y1hvdS9FL1Nr?=
 =?utf-8?B?NGlzRFlFanBqbUdrVWpoL1lqWTlXVEtiVjZWcUl5K3NJd041ZXdhS25VT281?=
 =?utf-8?B?WnZpNnBTWWtMYlR0NlY5NllIeHFNOW1wbXExYlN1RFQvc1VjUXZXSVBJVGpy?=
 =?utf-8?B?Si8zR0ZpVzRJbExnRng0S09HSGdURlh0UGRNalZFRnlEbnllYXp4aWhZNXRC?=
 =?utf-8?B?dVZlMUw4cXJTOGRJazRIZkQwK1dKdnl1bzdmOUszVStzZ2Vha3V2SlphcUhI?=
 =?utf-8?B?Vms1L0RKMVdqakpXNVQyQUY1UWgwSTZTaEN2d0VJaTJYcU5OZlE2c0doNzFl?=
 =?utf-8?B?NCszREdjSzBoYzFlRmx4VG81VmRaL2lFS3RlL0lSNTRKbWsvdUQ5aWx0cWkw?=
 =?utf-8?B?RW1KVDBjL1pPdlJIYmtwc2l3VE9vRmZKOE9jVTdqUVVSNm9oOVM3MFBudVJ0?=
 =?utf-8?B?N3Q2UXFUcWJlaFN0ZGFPTUllUmxQUTVWYnZOc29IS29ZZVBOUys2Q0tWZnFj?=
 =?utf-8?B?ZUE0YjBxdmNzMWxmTGdJRjlESkhlTWs2LzhzOUxzaWxYTkxTV1M2Nm5ubFFr?=
 =?utf-8?B?WC9wWmtFV3dIVDJpYmRzUjdZcitMS0djUU9meTExUHovUjY1UlA0Ynd4L0Jn?=
 =?utf-8?B?RWx3RmE1MzU4NDJZcHkzVXRXZjZuOGJRQThmQmU4eUFqOFVTcWZzNlFWNHV4?=
 =?utf-8?B?VlI3dUpXRklUeDdVd0JWdzJpbEpGTUpFT2R4Qi84d3VNU2pvY0hNUEU0Vkti?=
 =?utf-8?B?VUxkWm1WamZobnEySk5TTng1alBPdlJVODRNYlNyZXJIT2kyRWFGbTdHVy9M?=
 =?utf-8?B?QWtnZlhxWFdveGs1RmtrdnY1QUN6cFp1eThQaEJQcHJIeXp1NWtRTHlUOGl2?=
 =?utf-8?B?bXl6VjJOcVQ4MGtyalZTQUlKeFhxd3RGSEVvRU85UUtFOE5PY3pHZVNhUUYv?=
 =?utf-8?B?dkE4UWlxaWY3VHpiSjkwVDJUSjhsOUttTUE1R0l0dGMrTWRGMXorMHNld1FT?=
 =?utf-8?B?SEtjM1RuUGkwYXc1bnZKWFZoY0l4ZXBobW4xVytJTmwxWWViREoxU2ZKcmJF?=
 =?utf-8?B?ZHkydUs5bWFEUHZ0M0Q2SkZLVkd1VHh0UVR6Q3dSQnFKZWNjYkRRQXpqbGJt?=
 =?utf-8?B?RFFWbUhtV2kxRHRmYm40T0FrcU1NSE40bHdQV0FrazlwaklXQmcxZjk1Qll0?=
 =?utf-8?B?ZmNRaVdXYjBBc2dacHpRUFBVbWcrQllhRDVrQS9XSkZoMGZHSWkvVlhtczZr?=
 =?utf-8?B?MFJHL0VaRmU2d3FHTHZKRGoxNGRKcmY5WEhlMzRkWmJ4djJlU2FmOU1lek9t?=
 =?utf-8?B?bUFsTjFpQkhTS3BTbFEzcDllUjVhUlNqc0lpSnVud2ZMVXd3Q1RuSGtqYjZi?=
 =?utf-8?B?SWg1dmNKT2F6ZE03M1EvQ09HYXZaakdEVnFsZHJhakV3WU5RT2twN3BEay8x?=
 =?utf-8?B?bHBYTzJNQ2cwT3ZSWXZENWJVcnQzN1BDY0M1U3YvNmNDKzRpRkRCRnFnM0V1?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IVmR1YqecSvOviIpvKCBZSFxFjssGiSc5+W4/l8K4Lkr0zIlYXh3kRPFaffP3MR/vI3kxLOzFjiU14izQA6SnuVofS0ez/CHDcWp9A8tm1Xt6wwOU4EfUsWau6SnBcKT1mg2mESCqO+Vdio/2e0ppCaM00a1aVY0XRpVC6hr35tqSHTFT6+sfJUdFzEa8V67bN0WfOnXhModGHvUb7/2fC0HOI916dUp5CCmV32T9XZmwnDYA0HxfhFqZceb2pVBBJDB2/9PozNKlAbt9mwHU8b8aG80ViO01vB7O0EB0p43mfkb8Rf/H75ZOi089BnjE24e/DK0yhKqQk7rIldflNo979vK1OHnWDE/MNhViD5FW6BIQoe4ZPP+1SmckKoRt7GdGgKhW5mMBbDFLNHIQN9ASaBG9veRcg0xsN9cnHp9UyLtQDMqh9LseIzS7/RkxjSSezXcTZ7hwV3+JiT0oCSbzRgHVHRyrwVobiGnWqfNwq4DdmeQFHqt5oRv5NArG7vZDuNqF5ZBgKbKzPtWXNNTYerubWPJpU+bSnHY7zrkC6U3jUTiECfpV24nlD4KBwNY8BtpqMYpGPhNErdzTiDLkbgAOqxwRHU0dHB9t/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4df97a-4d40-4f9a-c309-08ddb98ac701
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:06:25.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYDGrLzicSpJdHVO5qAtgvfuo1Lq8oPl2JIyCEejfy9/9+chl9B3zv3VRcrGExl9vge7iCofvQCiS6U4X6GgNM+Mn6Xj1Lr3R6t2xgu7+aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020140
X-Proofpoint-GUID: 7avO4_9FvRHfWSIJX4LcJvUdmBdIRhv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MSBTYWx0ZWRfX92glTUxCmtgB rUdn8qKZD4nVzVPJJxjCYfIO/Z/5jSrj70HWhis1j/Dc4MzggFmuJQU0W3dnTc/AJfXCZJqHzI4 bt/+CUDej+jx9tZW6u03OSkhaDmicNbL5SgizSOiPVwyTNVQvskc5533eXRG2q5mSu/I0EY0ahL
 r6sn0dmIPdXcPy68H//ZMKrposBvvf0/nLgCJEzVCvoq9zAa3998zdF0rmQFV54TwPt35+xEa/R f5mkhoWEXKovrsCUxZAVKcGmUuGkiHG0QaKSYDSugY0xrJrvikmQme4VoEDY24wphf5w8duw3g3 D+HLQfM+ACjwQilXwNvCPh+HtseEqGwupqcZnBiK+Zw1GPdE4tde1wjVPsOBa9ovqS/020Hr2+N
 qLIU0AyFkaqK4twZkGEgGCZqLw6hHbXQNSZ5VchF4LlJq+Xzo48m1uYysey91pP9JNUTzzUP
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6865671d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=U0Mfkbg15J2HysuElq8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7avO4_9FvRHfWSIJX4LcJvUdmBdIRhv2



On 6/16/25 2:06 PM, Jason Gunthorpe wrote:
> None of this is used anymore, delete it.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
>   drivers/iommu/amd/Makefile          |   2 +-
>   drivers/iommu/amd/amd_iommu_types.h |  97 -----
>   drivers/iommu/amd/io_pgtable.c      | 559 ----------------------------
>   drivers/iommu/amd/io_pgtable_v2.c   | 370 ------------------
>   drivers/iommu/io-pgtable.c          |   4 -
>   include/linux/io-pgtable.h          |   2 -
>   6 files changed, 1 insertion(+), 1033 deletions(-)
>   delete mode 100644 drivers/iommu/amd/io_pgtable.c
>   delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c
> 

