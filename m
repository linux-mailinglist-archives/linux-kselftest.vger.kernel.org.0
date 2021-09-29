Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFAF41CC33
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 20:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbhI2S63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 14:58:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36512 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244766AbhI2S62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 14:58:28 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TIHnhl017415;
        Wed, 29 Sep 2021 18:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r4gJvpDSTaJw64YtuLUBOnVpFMZXXBFQOPnxHhrOHQg=;
 b=i5R7POxvkwFB9i1DNU0ar8vThaWxmGRof+eyBCWu2kb2wgH+7WMl4HXeQpH3gnD3uL3y
 bTegNVza/O/ykgx4CvatCO6ZVssQXuOOnJ6fTQifGi8C3uyz77HydFvZf8R4e0fp2DBd
 Ex92nNp35K0wQmQvq8HdtvqNVRWk0rqhwUHXyM7GvMyg4gvSNogkBJvpby/GhqJISPQn
 9YmWMe4V4km76Iu29n8rr0m/+qJy7bkHu6mDiGUTx+bVQGVTE/65Jv8tCbNPnViAyzU6
 i5S29jRMaQ6AHQvTK4gcx72YbRuzr1R+rNmCjg0ul5uFbaH7VzNUkYgXxcTXulxO5ZSg ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hqj0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 18:56:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TIoUTk020441;
        Wed, 29 Sep 2021 18:54:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3bc3bke4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 18:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqyGwAdAKjYwWNp+sbK5GoJe6SzVJ9rRI77nDxPa2TtIa3eqyxB2sUnkuxm15SgPycv2MmMcIY22svf9AfQzA8qGhZn/7Ug33xVuIjZ/utEPmQPfvH63ED2V9S9BVb1iLJp7eeEDxJgZYtxwLSy++Z0Il38NZDaj4SBl+l08pFZshnd+KkDunNtfFJsm905I9dU8W9BvWbPRZomgGltQHOSE5lh2zNem8WJXSVz4NdLOkDw154dd1ytoCU6h2X2ymmLaV0FCkkQ5bbC4eS04JpdKbJj6a0xIchvtHciMXWsEFf4eyChBYnjjYOxXLTd+eTt0594XMV8zEqGZLaZexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r4gJvpDSTaJw64YtuLUBOnVpFMZXXBFQOPnxHhrOHQg=;
 b=UdKYb5lVtdSpGc96Lbm+B6YPy6iDaWpF1PagZC23y0zLOV15EQrFVVdK0CpjEqshj/0kF1noQc4Zto1BiQwpJmS57Ft1Cy7k4onDqDEHLVinY5Kv+Lca4buEWGkGXKW1HBGj97FXD7FiA3fi2TfypMxyn3qmbFYvU9fGTuqvX3eHZyvlL2tm5mfiyk2tLB7E+2alT8jur5hxI3LOxiv4SUufp6WceEB3ONPajtSgrSKVIIuRw0sBsN9zxgYBI2YAT/ANs50YUvy3exKVir9f5mAtPrPd5v2/XPrSr4xCGTvCyPkv+jwJwrTAyBQZYLba0JoQWar6+Us0sh2IjVOt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4gJvpDSTaJw64YtuLUBOnVpFMZXXBFQOPnxHhrOHQg=;
 b=I/fTK+ElOHbAmQ4H+KQZkwpK2hjFbQX7IYzJoi2PzCGZBQIafBS+EO09m4QTwKeva/aH6kka7NiCtN82oVRCqy54Tfx+iPZ58jZgLfZ5VFZtjocOtBPdynTUCLQVoeB4owktsxrXpbHVPnYBQPmSv9b5gjNQPIDefJDL9c2ehj4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB3000.namprd10.prod.outlook.com (2603:10b6:a03:92::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.21; Wed, 29 Sep
 2021 18:54:55 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::39ae:71d3:1f4d:b4d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::39ae:71d3:1f4d:b4d%4]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 18:54:55 +0000
Subject: Re: [PATCH 1/1] selftests: KVM: set affinity of VM to right CPUs
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
References: <20210924233037.4329-1-dongli.zhang@oracle.com>
 <YVIZ/67cfjk18mbe@google.com>
 <5b0a16a9-e98e-368f-4ecd-359c58ae34c4@oracle.com>
 <YVSoQD+yuQzlKLoM@google.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <5b9629fe-0026-d693-fd76-94649fdd1ac9@oracle.com>
Date:   Wed, 29 Sep 2021 11:54:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YVSoQD+yuQzlKLoM@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0032.namprd07.prod.outlook.com
 (2603:10b6:803:2d::12) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7446:8000::1eb] (2606:b400:8301:1010::16aa) by SN4PR0701CA0032.namprd07.prod.outlook.com (2603:10b6:803:2d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 18:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54730550-d448-40ee-4083-08d9837aa057
X-MS-TrafficTypeDiagnostic: BYAPR10MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR10MB30003E447F0E6A447EB8013FF0A99@BYAPR10MB3000.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcLx+ofQy1Mihf/iJ34NolDuP6RRWE5Og+ad8QF4q50k4jVJOsVvokLteC04b2g1JYHrTnRSwtna3gw/X55sil3cusUvy5UUHeb3aZY5KnGnMmS96/epClVzhzni5rqJvik5D5bTaYH+xpaCTgKnxGEPgE7vHk2wLBVSbj3TXpS9ikKgXd7pgxHMw40MXz3kG8AXsx2BJJBKrodirHTGrL8UUqHcbX4tHUCMZjOETajJxhYHMyTGfPWionFQjRC/Bh6q6O8A7bC3J79N4UczxECZhrWv79BAi4JpiHilJPXF5KPOi6xQHQajmWNCfw7MyXvQtSfB9TGoL6Hb0idkKqmLjTCij5WrX7LRFYbOTeGtcijB5tlkG1kMoGAZAiRBPdRqG48Q703pxK+JOiTe+hQLnxlGTsmKWI44k23SbproGCNQqXKONQM5zMZyiuHphtTD8tFwL5NrsrfA6B6HwIGB0aBBRuhIK6TcnBnRa77rGlLvkbIuSlzHy8P3ShD5uleAzg4ZbmMefSA4q2yu5OHdKWsKtqmslTcpjBdyh9HX2myuc7cEKnxFFo6BzIQgliiI/hNwVP2nECxmTwdPhK4M2xa9qPsW2x9agbJdCMBc0NxQc93k4fcgyqyMUV6N07oLzF+CkvFcLLDkgimxk+zMZ+JysriEn1VkEiqvbPuHMDScrFMcWkSbprwd2KDN5b8UonkSuO/DtbICOI/GCux/JiykT7obt86xGN/MhJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(66476007)(38100700002)(2906002)(44832011)(186003)(2616005)(6486002)(4744005)(6916009)(53546011)(8676002)(8936002)(5660300002)(6666004)(508600001)(4326008)(86362001)(31686004)(36756003)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RuelE1TUZXSE9HTzcvbDNiU1NBU05hc2VVY1VKY05aUHlHc3kzMHBzeWdQ?=
 =?utf-8?B?b0loWUtWcWtqUXB5QkRVbTVYZENqMmFjcjVNYWZCc0dGbUd0SkNvTGk5dS9k?=
 =?utf-8?B?cDB0d1R1eHB2RG1KR2k4Y0M3ZG5ZcGlxYTU3SXYyTW9OV1Z5U3hNMHZvY1Zp?=
 =?utf-8?B?YUFKamh1Nm9NckU1dXR2Uk94Q3JlYjI1aDQrSWsxaVkzWUkxTS9FaEc5NjdG?=
 =?utf-8?B?SHdmOVVRNEY1TmIrZnpGb1BzZCtySi92Rmt0MStMRnpWK2tkcEZOS2NBc01u?=
 =?utf-8?B?T2VIQ3QxOHR4YnBhaDMzZTdrMk92VUtKcXdHMHdNb0V5L0FrV0RpSDNJZWtq?=
 =?utf-8?B?NmZLeWxvTTdva3RBc1VmRmwzR3V1MHc4QzBydzBZQVAxbGpwSFJ4QWZ2aUw3?=
 =?utf-8?B?azZZc3lpelhuUzBqRVFFdTNKQkYxSU5vU2hqQ25TaGw4Wko1VlVMSmR6enhM?=
 =?utf-8?B?RkpxT1ZkRzVWeXMxUWRIM0ViRWRDOVFOQmpETVhPSUphQ0hqaWJ5SDVkNTNv?=
 =?utf-8?B?UTB5K3U5TzV1YnJyaW9vNDYxWVFnSXMvM205SnhQaWhoUndKbmVybGN4K1I4?=
 =?utf-8?B?bXRqR29MQ0FKNFVJTlZZOERjbFV4S3ExNWVLN2czZ1U3R0UwQ0xSUDlCR0lU?=
 =?utf-8?B?RGlHc3F4eDUvWkd4cmwwUFZGSUphTll4SnR5c2ZXZjNON0p3NklRUVhTNnky?=
 =?utf-8?B?RCtCcDVWeS8zMnBHUUhsM3BRbUZ3eEVaSVdzUTRXSEZaS2wxSVRnUjBoWmtn?=
 =?utf-8?B?TU54R1NPVExLY3F6ZXlOR1lueC9pVUR1N0R3QTV2UjErUEVpRytnSW5OeWFV?=
 =?utf-8?B?Nyt1cVU5Rmw2UjhJRXpQZnZOdHBXU3ozNHZoVFVsOXgwQy9PcEVaYzRLVzRx?=
 =?utf-8?B?VFQzYm9Hb2FCdUNZSGJrdTBaejc4dHFYSFpldmo1R0lraDlxNU8zN1Q0bURH?=
 =?utf-8?B?WkNMQVBhTlgwMzlCaGVzMUh5L01lSkhGQ296NXgyT0dsQnFWQUVFVmRNZUM3?=
 =?utf-8?B?L0lXc3VISVR5cG40YVRENnNsOTB5czFsTE9zT2lUaWRXSmE5UkpxVCtOZU16?=
 =?utf-8?B?emZLbTRTQk1tQU1ZQ1BNcGN1aklMQmtTUE91NkxDOVhYd3dKOGpITGZIby9m?=
 =?utf-8?B?TThzNkplT0g5T1I0MXhSejNRZUNIS3FYTU5NNCtGUHVpazBNQVZMWTdCRVlC?=
 =?utf-8?B?NXVJeFQvZEFjZEVuZldkbU9FOVJqWW03ZG9RK3dUc0NtOEkwMGtwQ1Q1R3Z6?=
 =?utf-8?B?OS92T0VlSU02QlZiZjJlRVBBNXlqY3lRYjUwQUZCVUxhd09iOVpEekpPM0F5?=
 =?utf-8?B?dHB3cW5ITi9LcWsrOVBKdlN5UUtVbitSQ0w0cGtDN2pmWENrdzhCdzFOYWkv?=
 =?utf-8?B?U1NIeHhCQWptd3NNaWk2YUpSTVZlV1RJNCtuU2ZQVzljOFRGN2svUm90RFJt?=
 =?utf-8?B?VGJZUHJ3ejdoZHl5RThQVWVuQ2dFUUpDOGNCaEEzN2IxZTFyOXNranY1SXpm?=
 =?utf-8?B?ZTVhclI2NGZVNk9xL3RWbnNGLy9GeDRFRWhybjcxQzhaN0hMdHAwc2lFaTcv?=
 =?utf-8?B?MEtIN0g5Vms0amhjbzlFNy94OHBFbzRLR2VLekRURmVGVThQT1NxamN1d2RB?=
 =?utf-8?B?dWRTT05aL3lnalI5RXlUUUk2VXkxTzlialVnOHdEVmJySmw1K2xlM09KY1d4?=
 =?utf-8?B?NlEyTDVWUXc1Z285U01KMVhTa2FSRGhhU01RNEhlMnRyOFRiUHJXVXRqb2Rm?=
 =?utf-8?B?YTI5NGh3VjVpTkx1NVR3azRzU21rVXQzL25xbSs1MHFaUmRHN1F3V1UvRjdy?=
 =?utf-8?B?a3VXSDZrUkJRNFV2bUdsQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54730550-d448-40ee-4083-08d9837aa057
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 18:54:55.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okP/W7i8Ge/1toRy3n0gL6batfGrNx98C1zLURtX7ViMKb5sx7pLpTUP5glekpel4OnZeDAJlHd4ePnH9La7YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3000
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290109
X-Proofpoint-GUID: 2NVwd6lKnOThbeHaJpdd5ncc9ETstjRH
X-Proofpoint-ORIG-GUID: 2NVwd6lKnOThbeHaJpdd5ncc9ETstjRH
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/29/21 10:54 AM, Sean Christopherson wrote:
> On Tue, Sep 28, 2021, Dongli Zhang wrote:
>>
>> On 9/27/21 12:22 PM, Sean Christopherson wrote:
>> Perhaps a linked list is more suitable to here (when there are 1024 cpus and the
>> task is bound to both 1 and 1022) ... to pre-save the possible cpus in a list
>> and to only move to next cpu in the list for each iteration.
>>
>> However, I think min_cpu/max_cpu is good enough for selttests case.
> 
> Yeah, it's annoying that there's no CPU_SET_FOR_EACH so that x86 could optimize
> it to use BSF :-/
> 
>> Would you please let me know if you would like to send above with my
>> Reported-by, or if you would like me to send with your Suggested-by.
> 
> If you don't mind, I'll send a patch, I want to fiddle with the migration loop to
> see if I can make it less magical/ugly.
> 

I do not mind. Feel free to send the patch with my "Reported-by: Dongli Zhang
<dongli.zhang@oracle.com>".

Thank you very much!

Dongli Zhang
