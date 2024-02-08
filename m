Return-Path: <linux-kselftest+bounces-4341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A562184DE5B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4C81C21212
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ACB219F0;
	Thu,  8 Feb 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqN368Hd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rQV9pDhF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193622065;
	Thu,  8 Feb 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388322; cv=fail; b=hAHBlqRbi01Wb7MilQC823t0wTbdJXumyH7+Ammjz8qq5AHFMSeRoXa5cZG0Bv1r0o0wNMjgjx3ICwbcjflIa9MSbU8hGCQHPuxvZ/zz5sZeVV+YoTwmDYUbC7FXFNfpVzVFUi0FSDO2iW9zxXfpga3CszQCbri1s+wZvQWte5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388322; c=relaxed/simple;
	bh=KoraZBImvaoZlRLyD5dm91HVZjWIm3YwpDufi1QlU1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aKEMHbCc/VGtMj93kbpDMWukbLx0UvMfWgG74tfDThmZJ4R66x2D7KTrsUKobFXzyQJoXxxEyJWHyqihfQ++AUYY2v79gqiktC9sJ7qBK1t2s8hZLqtoM8BAJPpV0gT5mqSj46P20m0X6Wi66Cu5iG2U1DjjlOXbIm/iDnMqZ38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IqN368Hd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rQV9pDhF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418902cs015815;
	Thu, 8 Feb 2024 10:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Queo14fUxe37U3lv5nX05inNTiE2dumyFnHoifRgqbg=;
 b=IqN368HdHSGLfkjHvfioVvlYzVSSbHinXBd4oLBztwtPCDazNRgOcK6V5QlOArPSBA+9
 uK1QEeUwPY1DNl/U2x7rU7NjdbIf2VHseJiiijHSM6N76oRVuxdcsCQinRXDCGw+zkTa
 vNGvVEAxX50se4ZtaDW3BI9mVXYXYT0AJpamSs53P3SatHbCMdfTWcAuTqj0KT2rOBgc
 BN7c1NzBx/95WpoYAFBeH8aQcCzJNQ2L6F0Ch9OKocl7mGcvxb398fomqlJXcPeGF+gn
 kkYEbPukR+Vg3b1bfFdpf1H2/LqWP4IuPQeFSumOUNQOdf1hi0//FDxodkLSrIe2gdHn zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbm276-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:31:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4188siIq039473;
	Thu, 8 Feb 2024 10:31:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxa633b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRF/H8Vvj4ZyRjhg4pgzrGqQecKtTO7MRVzRnYxnMrugkHP22ejYNvi7xRTR87l7wFX23KJwBgrcDRSO24CQ4aftxcgLQX2mM1/l2y3HpH/lfluTgw/s93QsRGgTCH5x83if2a6tejs31G3hDglthx0vnQ3QK5onzlQ8lp0KJVi4lF9rpZDnySLjO7t5XxPuhI58fPdDjo7xajYH96fphFfdx8IcpWNLakjp+/zVv0W/mxdoeMotizPRnTsYdlSVHv646pPKCl7FiaYQmeXoKnn+/ex1Hd0YU28wIE/CqeBNna72S4DuppVa8NqfZI6hlxBkBkEd5LAN/9XZ3/6xiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Queo14fUxe37U3lv5nX05inNTiE2dumyFnHoifRgqbg=;
 b=FqkvzturQjkOefy4kYu4LydYj9d/ZPZOucOfYCfr9nsuaZpDFm9co0Zuq7zsJ44QhvRN5uGUahLu/r7PcyM0CEF2Y0y/bYxqhRcmhu67WDuTeJLv/KtuDugIkVQHuzr3barGv+0KXhxzB0fFU3D3NiI0i0YLofSuWW18047J6O7XAfnox5VooCvvuiaHyPZQLMz2PPeMdr/prJ5VfZFEqJsu1a+yjmiKiBHSUdmNS1ULbMUsJag8XleQrHxoNDrRNdILERsanYtH1mvUs+QaBTMQZuJeLkZnTg7ZVIZ07dzIqdiwQxnu4HiFwCnYQzbEcgOrL4E+5bD1TGXmKOTang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Queo14fUxe37U3lv5nX05inNTiE2dumyFnHoifRgqbg=;
 b=rQV9pDhFZ8Ig7iiBJFSVGG6QxUhC/7KXziet4RW5MYkfLm9Qi9wtDTnVWhfBtF7KgDUYFGlbkGZymgWNiquo1ha5Gl2d6FJmZ1HYIjzp1GLQDxnnaC++rEuFdWJU3lAO1eNNB2I3INpVOU8OYZ8NpylHG2dZ1OJggi489JpjEs4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 10:31:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7249.041; Thu, 8 Feb 2024
 10:31:44 +0000
Message-ID: <a945cd6c-7737-4d66-a319-613e1dbc3798@oracle.com>
Date: Thu, 8 Feb 2024 10:31:36 +0000
Subject: Re: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with
 dirty tracking
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>
Cc: alex.williamson@redhat.com, robin.murphy@arm.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, jgg@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, baolu.lu@linux.intel.com
References: <20240208091414.28133-1-yi.l.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240208091414.28133-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0583.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3e97bd-6a0e-4824-3427-08dc2891259d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q5J+40DMlcRaqxh1zlyMQFCl/G8+pl9Vv+awd9aAV1iB19yKz4ng2A+EytpHbYn9NyFJk4mbrx0g1Yyi7/+FZLEZBRF8NQPtjIGIDULi6/aJxGhcNPvgfblDZJIg8GJanmOmkHKufzuTMUzjogwIiQSIo5ANhHLHlL98y/4AWTEZUS8eJEAmFQSAyHdy4Rs0WE+mlLpnfDIlnJ3N8CAL0oZ0kLwuz5ujx6qjipTKOoCk03T+PmEkAokgZp3qctR+kH9zVBECb8eKaB5ErOe1RBV9Pm69VcdQW0IL4iSqYDEGH/wd99uMQcGTT9yCgP8X1915Hpv0+uPe+y0zmsSoUI+ReYPgYATzkDmQZiqqHkI+/16s/pCSutK255D9AC505piaVxJdFljqnlUl8URnoAnu8CNZ42gMbQfPFtEo2GfZQMSApEA59yGkBbur5WYxC0AcXY7jADANvBHjq/BHDLT/woiAgEsxSLBYXAsg00OaUg5zYAG13xvDCt0w4xQyLXYDO71OXo0WTfyg43u8OPZq6g0zl5qKmPj2MAWnawZSqdaECLnna51VvMUaIVuY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(31696002)(86362001)(31686004)(41300700001)(2906002)(7416002)(83380400001)(38100700002)(5660300002)(2616005)(6486002)(6512007)(26005)(478600001)(6666004)(53546011)(6506007)(8936002)(66476007)(6916009)(66946007)(66556008)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVdxRUNGK3I3bDEreWVlaldlR0JkbVh6SFdPa29ublp6N0hOUWhUNXlUaEFE?=
 =?utf-8?B?WGEzTXJOcTdHbGFtNlF3SVYyNzFTY1dFNHdraGFDSXE5YWhYL3ZqV3F5VDJG?=
 =?utf-8?B?OGMxSWFnTXczNVNtWVRuYndnSVN0QkxFV1BCMlNtMmFMeGdNNmhpUitsWjdo?=
 =?utf-8?B?b0RLdUJOcjVqNDBhSGJoaEFPaS8zeVdHbFdNNDNzTWtOVWpXZ0dmcmJXMjZn?=
 =?utf-8?B?YWJOV2xUUW1ZK09nTjQwdTE5aEFrd0Q1MkNveUV1TlRCem8yVWw5d3ErWUR1?=
 =?utf-8?B?aUZhL0FkUjZaZDVJdjgwT1hKdXZvellmcWU5SE1jc1g2UEtxS3RSNUozNWhK?=
 =?utf-8?B?bUZlcnFybm9MVmFicmN1SXdGak1KSVZMd2tVWWFqTWU5RWtWUUQ4V0I2RjFJ?=
 =?utf-8?B?QVNtYmExVlV6RXQ3S1ZnYkFzSDdFN003b2VsYjJLYWFlQXp2K29EOUV3eXBW?=
 =?utf-8?B?d3JRM2ZqcWxONXBFQnRFbTBjZzU3OGE1R0thY0xtSGFWV3R3QVZpcXhZYWVC?=
 =?utf-8?B?SzVYSmhBN2lXUFN2L0ZUZmZ6eldkbVZsQlRnZHoybFVnOEwwWElMaXBxM3R2?=
 =?utf-8?B?YjBScTZXYVJrVDFiNXFhaTFpamhOM1Z5Vkptbm02R2FIdFYzVlpJYStPYlkv?=
 =?utf-8?B?MWlpLzJ2UEVidjVxRENJVDMyWkNjR3hyclljQWtEK1VZM09vVVZwY0M5eFVS?=
 =?utf-8?B?aDg3SFErdFJNakJVQmcra1lIWFAyRnZRWkUzNFNVSGx5Uk55aVlNUkdhbUQz?=
 =?utf-8?B?NSsvQlNZb3RHWkpRRmthOG5RajV6ZG5pUFdKL3RzN1pDQ2tubHdMQlFqam5w?=
 =?utf-8?B?OHpxWW5qMXpvL0xGZkMrL1NmQmxob3R4a2NSVU9lSFVrRWgzMmNudmVLdUp2?=
 =?utf-8?B?TzFuVS8yWllkcnB1L0NQVDZBaWFZZHRDTi9YdDUvT2Z5cWhsY0V1UC94RUhs?=
 =?utf-8?B?MDZoSHp3UjFzNk1odHRYOVZmbFNnOGNFdmJVYThHcWZiSFIzRHl1L0dQQktI?=
 =?utf-8?B?S2NOWkQzQ0wzekFSVGRmaHVNQTNRTnhXOUxPc1FlTGFvYTEzRGFKaDZJVHZx?=
 =?utf-8?B?N2NSMkwwRmc4ZkxDSng3RHE4NjMzNTV3cmh2Q2RIU0RNYTFPeWZJZzZpWCs5?=
 =?utf-8?B?dzFSaDFJdEtjUDA0SUJha1ZBNlVydmhWU25IanFkSjhsdko1aGMxaHJMNHY2?=
 =?utf-8?B?RnBFRTZ1Wnc3bXpabHJQdGY1ald5VzNFS3Q4U1hvZ1pFZGVmNXFtdWw3QWZv?=
 =?utf-8?B?YVpUaWt5Q0YxMnVWNjQxTGxxUytobzFTbkg0RU9OaVk3ZlJ5SzY0bStsNlNN?=
 =?utf-8?B?Z25XSVB6dVBMOU1LNSsxNElGcGY3NWNMUEZQYWl6NDR3TlZnTnA5ODI0STRz?=
 =?utf-8?B?d3ltdEdocDBLODZVU2lycWpKZjExY2prOU1LN1oxSTR1d2RHdEpmUVVCd01w?=
 =?utf-8?B?WlNtQ2pEeHp3Sk1kRVpkVFBEZHJHWG42WlJDT0pXQlhNbnlaTFJXTWRvZ1lX?=
 =?utf-8?B?WGZ6d0Y4aTBBb280TXppYllxbU9wTnF5dm15SVRVemhBNWtnaHJqdmlJMnVD?=
 =?utf-8?B?ZUxMSzlDekJNL2hMZGxIRVRpYSs1UzhxS0FxYXZRZnJrcmY1NlBvOGNVeVV1?=
 =?utf-8?B?cERQTXh1S3h4c3JNMzNGV1NTbTJKQ0pGSlhBay9RcGJLWWl1ZEdtOEtXMlZ1?=
 =?utf-8?B?MkI2SDhsOUNNdis4SGRNbUplME1oRXV1RGJVSGF0ZDdUSUJQcld3ci9UYmxZ?=
 =?utf-8?B?RjJFcW1SWFBxSlVGZ1crRE43SFY2dEp1dHNnakVqclJCQVdwK3grTXdFWlBC?=
 =?utf-8?B?QVZTQXhFSEVMZ3BqVFpKcFFJbk5iS0kvS0hXV3o2OUNGNnpSOUhydXpZVVY3?=
 =?utf-8?B?TWhGWFJNNnhJMWdvazdIS2dmS1h0ODI0WGg2LzNYNmVSbkV1ZXhLbWlGR2Fo?=
 =?utf-8?B?WmJuc0s5alNPQThuNEMyQTJXaWRKY080OUxWSzNyT3BEaXRraktMc2lhQlN4?=
 =?utf-8?B?L05XVy9nRlZXN1M2S2kzUTgwbkM3TTZVYjdHdGVOTXVScWE5a0VVc0I2WmJ3?=
 =?utf-8?B?UkZic0JXdDNZUW1xSllpNFdkQnd1WlhkcEpTYWw2UDc2OFhEVXRuOHFIeDZK?=
 =?utf-8?B?TkltUEllOXI1dktXNXdhbW8xM1RvQmxlY2tla1lYRmR2aHdxTGFuMWJyZzMy?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iqTgV2v83L0tlHJBReuCNTYrTT/M21Q398rILog9RMMXI7ZI8Cmvd4PIiscYKcZlZ7D3iAM9yEuRon1bwbftBXuX8/6cLp8cvTS6i0jgv5xWk9Gg5sAoa4v6ueCqxi7fiuJDoFExER+AyJIVHyrq6P/SM14+KENLpx+5upN2RqJwUZiAKET/mpQhrFcSpM9Q2Y4ZG78MjLgOdrYGSoLSwKY733wvmo/wAoroa3sZsStvyHp7a0mxtEUzdWhdy051I8vW4f8F0h1DB7fi8hIyxx3x9vQ6nI1lly3BzK0wMiztQPCpVHrjVAXrZOtuSlLvC8IOOLyzov7Q3jCj92EpuI1vCZg44+gUP23Ddtvq6PTJEoLNAS72Bl9vD9FV1ty5MDcyot9lFVHzZ+B1DMYyXTaTa2PyrbhXWuduCpZgvvLLgmXUxK4nCaX4LupG/DQYLNiA93WWgXDeLo8MEm3R2roUSX+Scifz5m1maFoMKI/9H5JW7US6jnAM3r0hL8bIR3j2rPaFnXy3Suk/caK96wufY24svnCkJuioCO5Y53O+dUnAnabxCjgYDPRqeQxVzo/FwYZkal3aFgCLyK5YXy9L0yuhcZT74UlDFwBlu1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3e97bd-6a0e-4824-3427-08dc2891259d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:31:44.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Kw9Dxj+Wxui4Cgzx0XRRw7rr5KFIC1MtpBIAFBBhqFyjsBHrDJGSz/PiFHuj74cSi4VYJLtG8ZVfIKtL5LKsoeupigMxm8YoV/LlYV9k8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080054
X-Proofpoint-GUID: _zbO5R9M7lwNemlD30IFPeUFET5VufSW
X-Proofpoint-ORIG-GUID: _zbO5R9M7lwNemlD30IFPeUFET5VufSW

On 08/02/2024 09:14, Yi Liu wrote:
> Should set the SSADE (Second Stage Access/Dirty bit Enable) bit of the
> pasid entry when attaching a device to a nested domain if its parent
> has already enabled dirty tracking.
> 
> Fixes: 111bf85c68f6 ("iommu/vt-d: Add helper to setup pasid nested translation")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
> base commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
> ---
>  drivers/iommu/intel/pasid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3239cefa4c33..9be24bb762cf 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -658,6 +658,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
>  	pasid_set_domain_id(pte, did);
>  	pasid_set_address_width(pte, s2_domain->agaw);
>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +	if (s2_domain->dirty_tracking)
> +		pasid_set_ssade(pte);
>  	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>  	pasid_set_present(pte);
>  	spin_unlock(&iommu->lock);


