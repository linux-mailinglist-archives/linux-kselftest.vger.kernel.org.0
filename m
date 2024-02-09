Return-Path: <linux-kselftest+bounces-4406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D284F38B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396DF1F28D4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F901EA95;
	Fri,  9 Feb 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FjRINCT0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fb3kIIfB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E41DA52;
	Fri,  9 Feb 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475013; cv=fail; b=shs1Bhc9XjDMBzbt3jDGUCKobhQ39pnUNH5NdCEFvOl48ZaB85dnUeik+ALWUjSaLZFlMtzKiW34VwGCsonktyRo/F2bZOcARa3weozgLQnzNAbwpmJVfaE99JdXfGq9aI8XX/mJQofuZLtEzNnSb9gOfTAjtZGOf9YSGNuUt9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475013; c=relaxed/simple;
	bh=BmJhKW2GtcwS+olqjny9CYaNSOfV+CULL3bmQWg4ir8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDfCNXEkdpBSODdUupNM+MK5ozsfbVzIp1CkJgJSyFw/kWuXggAa1pJr/QnKJD+qnZf+KFZuERGw3+Jn50iAB8sYJZ8yR2YBo2aMk1qgzQK545bQestShzMy9g/OJd7SbZDaqdhZbm3782tsgkA30RXfU7NE5RPKj2tFwWINFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FjRINCT0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fb3kIIfB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194wmtR019295;
	Fri, 9 Feb 2024 10:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Rr2zq3Vj0lyZGKt6twW0N8axTeJ5BUwcrkdf35cogAw=;
 b=FjRINCT0LrGgcDv0xSInDWFsQibx0Xcy/liTTilbReMl4nmfqrN/GPHgNCugpBL0SpyW
 l8sDVXCaaKdGRpbnNoZ9tZHw4WNkbfmg4hjjv8uWmMyzd0WoXCS2M5q/7V67K0AAC4Bg
 hTBkX6uxfV2lwYorzM5wd4AAuwjDyKMEHOUsspzPyITBxU3c4C19cNbdNHN93qnrE5JZ
 nfcOJoMY+6BgGwa4kE1vIL3w0a1WB4uHLfM2RkZqRv0T7/ViVnF/fkIGFo5fyLGWb9o/
 aVuL1wOcXvYC8sWb3gei25wA7juc3IHLYqje4GvOdbKUIGpv4scZ0sYfWVMiTRxPbl7S jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c9476hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 10:36:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4199A0xO038306;
	Fri, 9 Feb 2024 10:36:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxby5sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 10:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRXLENSUOr2+pNtzowm4ccR5lIwk/vXkRj72MubRb/7et9++qhHT6n1FBza3J7MfGtk+gzUIGHuQ/ZFYJlBVDrYIPMXiJKCwjTVz3up4+xE6hzdpMM0fDt/8W0RH9Tz8uCKy68eYaKR9V9OtXoGn9Rog7FxSMN/On4EU4nKgCDE8j6b4fYr++PHo8zuE7ACq8kvI/l1bzxaqBocwA+eXmGD+RJ3O5X01KTi8vKzOpbXgwa/3upifUHH4t89N0Ci7sn+wz7nVcZMRTTYv5yt/I7g7DvEYrYhWzCWLqxXKe2y5KiVwZ6lfmby6eYi1NXTYhXt174i4uQmNqvHuqbrrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr2zq3Vj0lyZGKt6twW0N8axTeJ5BUwcrkdf35cogAw=;
 b=QlPSl94rnco0+OV/2+uexR1/bSs66xdHSVWKVGItIMm+Dra1ImUjMygkNh5opQ0tamzq2OAS8wYkdScKr0gMEOuqiuqaqxuxqZGzeYcWozlDEa/IUvpLCsKzn/XabcVCEmZxlIgFLbE2asGo5l9ftjvsQJ8bvCG/CN4XGJVQMYTPLUos68NU968+oFndKqJ5WGDXNCRYatm6/ecRq7QWMfnE3yCr0195z952ajl6FrGPuTe6WpXkAhrhsj9tCSt+xNdqa/vpx9KtGHddZZrFUMoLVOHW3MoyV6/Hdz1g9kkLzd30x/UzilB+sp1mKeDK8W8pdVj4LhcvU4WjPxlkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr2zq3Vj0lyZGKt6twW0N8axTeJ5BUwcrkdf35cogAw=;
 b=fb3kIIfBhIW9m1cEF19C7W2g05GzHk84kLGVDnKw+L9JNm2mfUfyFLlBAHHxqTjqs9GTc+7OjY6nx/m1hEkUBhnL3JG7VXonMGmIi4MejK6oRyOJvRGCoig14rqCbwiwt4ApZT47jSbLCLoPqMldFj7+qcXN6899mKhte3oba5g=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 10:36:31 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7249.041; Fri, 9 Feb 2024
 10:36:31 +0000
Message-ID: <324a1c52-359c-44c4-9872-0ad712d9f610@oracle.com>
Date: Fri, 9 Feb 2024 10:36:24 +0000
Subject: Re: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with
 dirty tracking
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: alex.williamson@redhat.com, robin.murphy@arm.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, jgg@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, baolu.lu@linux.intel.com
References: <20240208091414.28133-1-yi.l.liu@intel.com>
 <a945cd6c-7737-4d66-a319-613e1dbc3798@oracle.com>
In-Reply-To: <a945cd6c-7737-4d66-a319-613e1dbc3798@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: dd81f68f-0284-4fd2-eb7c-08dc295afaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YI2WuWUBKH6SONuAbtYAUod3UBsbotLven9pK2j+n2BCxQNJAW9KVMq5XF2v5sThlj5+QMc3iJUKPGP8PoQ7tZbl+floxlndMRGzcNvHmrAUYpBwpf1LdFs8BdriTte7AAumoLQIN21BNamzxV0f9qhQhaiqObLo/WBULtF91giC/6aM4Wr5ZQssyKYeIU7TZws1v257cVDC7NfQb2+gsZFpVU5Fnm7EjfyuwojKqfJ8boXmwKT0o+Iuf6TX+nq+PAGrbC7kS7PRloshQGJWeInI0E/KoxEOLpAgvMjTW/T5wyVDyjiR9g+G18GVWE/C1T8DgB8SZ+ftWDvmXQoXji44mAMOiyKcbgFFLA6x2CoJruy12TMCsyjkF72YgMTTxnrBMY0mbrluuqryRNhwMAPq1IsmLB1fdaAi6jWXxbvEtqkRKZzPzKcbbLV1HDQrH9bPXBABWdNND8SLjKmoGvmR+hjsDkas9IfS5PdgJ84K1EljHQjQovRx8WlJivzxH56i2plfNe0HbmFhr8ATsXZ89I7s7jZmY58pKYq4Nt4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(966005)(6512007)(6486002)(478600001)(31686004)(41300700001)(2906002)(8936002)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(53546011)(6666004)(316002)(6916009)(66476007)(2616005)(83380400001)(6506007)(31696002)(86362001)(38100700002)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0h1aUx6TUx6a1o3SVJsOS9mY1h2OTAwdHV5LzAwZWxLNk9EOTV6OGNQbDNm?=
 =?utf-8?B?d3dSbk52TlpxV1AwcXVhTTZFazhmNE5aeTB3bUpRRmxrZlVmOWNaUUhQS0JJ?=
 =?utf-8?B?STBnT3hhS3ZqWnNLVmxIb0ZhL09yeUlJdDI5U01Jdjd4T2FoRkVxQ05PTXA3?=
 =?utf-8?B?eSs4T3FwYWcvVGJsWUV1dHVObU5uTkZpU0JKeU1JbmRIam9keHVnNTd5ZU53?=
 =?utf-8?B?YnZTMmp4L2RlV0RHV0Q5NnZtNCt4M3dVb1lOc1Zkc29NZ1BKVGtMY3dnVUFi?=
 =?utf-8?B?UVhVNlFKMTlDY2psbitPVjdrMDFwdUp1SHlINEdlKzNhYVFML1V5MTM4NVVk?=
 =?utf-8?B?azE0dks2d2Zwc2VHYk10VnRqSWVPODJhUXZUZTBaRTkvT0xOR2VrL3Y4TkZ2?=
 =?utf-8?B?bkw4aG1UVjlraVpzZXhTVndQNnpLOWhSWTU5UE1vczhJajNXa3FLOTBZSGVK?=
 =?utf-8?B?ajNtT1NoVEVQaURKMjFZNHk4RjlPc0FKRFBqME1Yem9Ua014aUdrTmd6bVNE?=
 =?utf-8?B?RElvbHV3Mm50ZEtBb3Yyd0NGLzBzalhxUXlpQ3F6ZWh5Y0FxWWlxNmdYQTgy?=
 =?utf-8?B?V2Y3OVBxOE04M3hTZUJWMU9mY0o0YllLQTFzWlFaSklNdU9jOWV6eS9nUlRH?=
 =?utf-8?B?ZEVmOTZQY0JOTmlaOEYvMklQNU5UVUgwL3A5Tmx0SUJ3WFhGM3BudjMwbmtM?=
 =?utf-8?B?UDk1QmZId05wL0RkSmRBYlQydUdtTjNsdXYvVUk1QWJRVUs0TmVYazBhK3cv?=
 =?utf-8?B?K3ZYK3NwdlJWdlIvTzhMSGU1VEw2NnJWOEJMVjJhODEvOWo1MFRjTE11NUx0?=
 =?utf-8?B?QnhrTjQ1b29Nc2NnTWdSL0dkMHAreGtPY29INHRjTVlZRVJnSENsaHdndGp1?=
 =?utf-8?B?VENXMWhNN2pTeml4Z0N0Q3FhZ2pyZnZkMTZaanAzYU9ybVBCdi95dWZ1ajNR?=
 =?utf-8?B?TFNSM1dtWU1iNmJ4VkdJeG93QlJNVVZWMFNlMU9sQmk0Nld0TkxKRDhiRE1H?=
 =?utf-8?B?ODlycUVJdHdXeFZqUGtPSERneDIvTkkrY1d0bWRNVWJOSlRHYXV2OWhXcUtG?=
 =?utf-8?B?a2UrT1ZRNjRYOVg0eXZRWThsb09YL1ByODBmTjlpOEx6WDZjbHZTdUZKVS8y?=
 =?utf-8?B?em5walBGbTAzblVCTnhXSHBFVGF2Ri9HRjhkRmVKcFN3UURwQUxKLzZVdzVB?=
 =?utf-8?B?bjZXY2hlUHRXaGp3c2hYanFKUjZHVHlpbGFjK2ZYRjJrWlV0U2FzeVR5Q05J?=
 =?utf-8?B?NHlyTDNVdmJ0elFNbWN6WGJQNmJDaEJLcVVWcEp3cEZtanVGWjQ5aDJPTjMv?=
 =?utf-8?B?TnVzclQ5SDU5MVYxM1lxQkVUVzRGdkZrUHIrM2QwWTI5R2tWdHowbnBOZTNK?=
 =?utf-8?B?ckozWEhRK1dqSWN5N0ZGTjU3bWxmNTB1SXFtVnErWUd5STBQQmErSE5XOHI4?=
 =?utf-8?B?M1lCVStqNE8yY3ZHdnNIOEIxbCt2Wloyd0pYaW56SWFtMDBUS2ZFU2tzTzBi?=
 =?utf-8?B?TmxNMGdLdkRYSDg1MkJQeVZGZkhWZU9vMnNnUTFsTUF4aUpCNkxjc0k0bDUw?=
 =?utf-8?B?a290T08vS3RmVCt4eGFOdkdqbk5EbTNKRVZPYmp3ZkZtMTJXNVF3QjZTcTVy?=
 =?utf-8?B?WUJUeVUrUkx3NnA5dFBUc3I0cU1NbDUyd1RnV2QvakZxM3ZhVVhNZWswSjk0?=
 =?utf-8?B?T2g2ZGVSNldtakJDLzh1YVZSN0NYUmlMSkk5R1BnTTlrR3Q0S1ZFTm9pbDZU?=
 =?utf-8?B?SzluSCtyOW1SLzVVSlI2UnQwWWdQR3F1d3hDek5SQkFPRTk4U3ZGNmlmZzdS?=
 =?utf-8?B?NWlOVnp6ay9BUmRIZ1lHUXI0Mmw5eVJLN1hKNEtzY2wrVHkvNFgva1ZETGsy?=
 =?utf-8?B?YWcxMnVZZGVEQWUwdmZkYUIwVC9tMDRMRzVHeFRuVGYvU0xnMEJiamtvVHVE?=
 =?utf-8?B?MDVVUmVWU0xCejJOS3g2b1luQ28rTEZrN3FKdC8wUzA5TWZweC9WWjNlaTJP?=
 =?utf-8?B?cWpqTzZNZEwwekVpZDdGR3krYWtMUVYyWVdOalVPYWtpWWF0cERlaWZwc3Rw?=
 =?utf-8?B?NGczOG9hMU43c3JUZWNOTmI2ejRKdjhaeDJFQTJFeWQ0ZE83MzVhM05vUXFC?=
 =?utf-8?B?aHJVVUptS1hHTk53YTA2WFlKNUV4WGFVZ0lBSTRlaFRtLytCV25oZjFkSjF4?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Po+/+PO4MylqpFCKw6Ag/cu5h6d1IGUTjO0TP65uUwreH3EsSrQwXrUMtzwZKLs0HFVb48gtu+qEZlehN6hsXDhfZ4jjmRm1Ig+xPN9H+bVWib8PGFkO9B0J7W/0RJB33RSLrwCWSiS2nS+BqL86KHoQQN7j5Z0dyEvWlp9hGX9SEIuKeYGUKip+9ETJmUhBK2WAiBRS1Kn8lgkQfRq6o364nQ9hdDFBCOOoT5hybTsC/cCZ7y/yhsIP7MsbdN3SRl7NVRVKEfZuoLM40K+rALyMRXfcAS1EXIbdOPVLuBr0kj3aaJdQ7m010GEi5aV1kUgmEJuotBoLxAWPaeSiehNBnLVTIoaDYZuDdYpEQA4cZwFl5EU1sxLsf31umBp4pQzRiAKN6Gx5EfDMBEWfd4Z1h2tw2E5Vx5QPUHksIng6WAxRH4ns2rSXGA+FUKhVHe7hxc+XuxGs/U2TYPDURAt+GF9oDy2j5UOnR8H275v5ziAWu3/2qqV3d+Y0HKXzfI7NHo7qZouI7K/ib+8LgdfGzoeV3XNqBMPxf/bg9Wim+JDI2xTNq5Rq8hciMcxTdD3ytRQ/Zv+BhiVoHO6FNJPdYZo2OKby2Ee/h0UCn1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd81f68f-0284-4fd2-eb7c-08dc295afaf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 10:36:31.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC5qc2FhL7U7N2ZyI38/yFWNQEClQfq9/xfiSQ73eIwpI3pZ3Wuaenhdy1nEOH61RgUd+4w7l2Um8jr1F6etdnUZpUjGYStxqzqr2j73XCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090076
X-Proofpoint-ORIG-GUID: UVcMK95bZWIc8VQu4e1QK8P8edw3aTc8
X-Proofpoint-GUID: UVcMK95bZWIc8VQu4e1QK8P8edw3aTc8

On 08/02/2024 10:31, Joao Martins wrote:
> On 08/02/2024 09:14, Yi Liu wrote:
>> Should set the SSADE (Second Stage Access/Dirty bit Enable) bit of the
>> pasid entry when attaching a device to a nested domain if its parent
>> has already enabled dirty tracking.
>>
>> Fixes: 111bf85c68f6 ("iommu/vt-d: Add helper to setup pasid nested translation")
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 
On a second thought, while the patch looks fine if this is what we wanna do,
just a quick clarification on the why (that's also applicable to the last patch
of your other series[0]). I am sure I am missing something :)

Shouldn't the nested domain be subdued to whatever features guest idea of
ecap/cap instead of host's view? Or is this because guest first-stage page table
on Intel is supposed to be always-enabled dirty tracking (per SDM) ? If it's the
latter, it probably should be sprinkled in the commit message(s).

[0] https://lore.kernel.org/linux-iommu/20240208082307.15759-9-yi.l.liu@intel.com/

>> ---
>> base commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
>> ---
>>  drivers/iommu/intel/pasid.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 3239cefa4c33..9be24bb762cf 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -658,6 +658,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
>>  	pasid_set_domain_id(pte, did);
>>  	pasid_set_address_width(pte, s2_domain->agaw);
>>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>> +	if (s2_domain->dirty_tracking)
>> +		pasid_set_ssade(pte);
>>  	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>>  	pasid_set_present(pte);
>>  	spin_unlock(&iommu->lock);
> 


