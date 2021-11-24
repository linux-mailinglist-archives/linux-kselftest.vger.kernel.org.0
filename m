Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23745B2B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 04:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhKXDqK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 22:46:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59056 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240538AbhKXDqK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 22:46:10 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2ZETD021500;
        Wed, 24 Nov 2021 03:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qc7F+knlSBRlQSrIFKsRDFjJ9IKad/t8+8zy2boyE0Y=;
 b=ANoJfbTjS51T5wV8aWEQIfe3H7UYvpaE0k+aYd6Af3UfpILCp3NWwon6ukSepHj0vVQw
 NvkVckyuVHiSggL12k9XkDafiKNT3NK6H6Cdd1PVpxW8f1f2pn14sxgfKRv0GckQtXPv
 iCV9XyGQTSnn2iYIP9+0t6aAkiIvQdJEDXECEmmU1WqyA0tTUQFKzAjeNtRYJ94ZPS3W
 bR/4hFV07vlnoEyxeBdPzUepYviW1PVVIujfvZPvcBx5OksjFlaY2CLf6VsgyZYI27w2
 vb9talYC5SC5TymBpZ1S/Vtl0Fy2YEW/p01a76ODh+W03h9y8aPMWX+mpuYFDGlT79UV 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69mpajy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 03:42:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO3acDF017593;
        Wed, 24 Nov 2021 03:42:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 3cep50pvh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 03:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKePBESbPKnwAbJFIxSJ6wPhaCMKc/7Yntr4s5ZWgi4mdJVbdcTmQRuoi5yyyvR6hHurkPog1+1A7FsfaFlniEkMA3OQuGiEtteA758ZK3s5aiMUfiLd0mfvbHr56ayEjmH4mrUMc7k/zvagIuhdAS3RLN1rHP4pCF3sZf5ieIrdZjoL0HRHvmHlsmKLLrxQxOdYCd9e9P8x4dfYE7dOVvPb6P7MmdOd/blUqIf6ioTcj9XuqVOP6T6ZpO0yeKaH4WuNSiLFfq445g9SxRzV12tAbU6nzOlKiuMQkm+3q6GjnHPJXc9IB+ZeNXOlgveVa9l26gr8sHHVAO/5fVwMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc7F+knlSBRlQSrIFKsRDFjJ9IKad/t8+8zy2boyE0Y=;
 b=ZpceUO+V52CWxVOGKKJfbRhcuDlfb1MvzB1pbHEfdavNr72W7NIrpwEI8TftOohs+hL2D29mP0CA1ytc0q5Z2RPBvU7b4wdqaIRu0Zqat7NcHdD8U2rYVnOWc2Tc7R+nce2UH/jluFN1fMJNa2wXZaAgLcrKFr+wKyZzLr/je1fJkbbESAcMzwL2CKJg2zu6X+mKeE/UlWxOh//95IwgK15TwlnCW/G6UAcb6btc8fZ+PI5wN5WlcaXv0QbJBOkoN16ZUSJz/ZpBdL8I65kHfcyd+RZCyqsn/M9Da3xmtzixNb0tJzR6Ljp3ZLr7Uej9Nh7Pk7mGhrYx4KsfijmFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc7F+knlSBRlQSrIFKsRDFjJ9IKad/t8+8zy2boyE0Y=;
 b=VsG9CA4m1dkua/QByCchC2tq1SnVG3+zT0LX9SFF+xKtByiHtBShVUAcoWm0te8f+veZ6efmWgdP4ML37Eduxh90emrSy/WdjvSfbF0FbVhJPlh9P90RJQcgwlUB+HZoiINgqBaTyNIg2kXeFlnYt2XLmt8YOaz8x+r9yR1irmw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2549.namprd10.prod.outlook.com (2603:10b6:a02:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 03:42:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 03:42:52 +0000
Message-ID: <a87c5768-9bd3-a2f5-7eb5-d2813b958514@oracle.com>
Date:   Tue, 23 Nov 2021 19:42:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>
References: <20211123204644.3458700-1-yosryahmed@google.com>
 <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com>
 <CAJD7tkYZY1g_b9E4ZP3yqHhT36nF57c4bzKRQM-SLftDCYNQ9A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAJD7tkYZY1g_b9E4ZP3yqHhT36nF57c4bzKRQM-SLftDCYNQ9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 03:42:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86012930-7f22-4413-e4a0-08d9aefc7e0f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2549:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2549D2BA237B62A1D58A36C2E2619@BYAPR10MB2549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ebdvy9/x8JJb70CtYTIavNGbbeEWan5Db1il3VOPoknnMNyqpPIuceGuMiMEsp01C9tUQ21P8ZBz9rTA4zKqWbyYhJe3si6Ub0Wfk1RtOK8gmWtnN2+YwbNEaeL0HzEIwm7eVZ8nFAiKgA0jyiq4Ehrwr2qVngfh5XeqI0oTqEveIAlJVtgcJUw07BxyJ62XAF6GdOprXgIcRgGCY51O8OT0WdSCR5lBjp9SWtolu7sR2nTujYOrfgRvytgwxnh1VluqElRnpJeIipaySzVtY+x//a4/I/EWVKmRtzbFIxHR3A/9h7HUioJ9W7jM2Mt414mEf53b4mZj4kVeKBOCrFxteYrou4FcU6kWotoLHi7B+ECpx49rjDRoZ9TGzc1diMFi4RnoxRxWpy5em6yvhbpM9B0ti/JIgCiqUkqHNXjyiaoGe70K6YOAynUh9WfRLMHAFX4XNDQNBQa2vLegvDcYBzAH7GOAjJcetvWyj1y0YutQ8NhE8jaIY5dsrrBYC++QYFOSRnkXeqGPD/bVjaBbASQQkI6lOI5bUX9QRVVm+QZZGYLqWind3Kk5rwtGsj5LOaBVHyEJMqKM9URP2WoswBsnKAALill3u9WOOjSviblKPXRPNlpWdJhwvj6dMY42JjdcXmcdSOfmNEgsXq2jrXmQfNhgzrlxo0QARH7bgbaOACL85ypI8MU95A+1ui02FfzJb0KLJdJRf/mf038t4hclpBytq9814A8Q+8jMRN0nYzAXzjOYS4tHTlnkFKnDKGaYu08SVSggQOqUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(66556008)(86362001)(66946007)(31696002)(83380400001)(6486002)(36756003)(6916009)(66476007)(53546011)(316002)(186003)(956004)(6666004)(508600001)(4326008)(8936002)(31686004)(26005)(52116002)(5660300002)(2616005)(44832011)(8676002)(54906003)(38350700002)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1FRVlDL3RJcXFnNGxWWGdHYUhKK245cFJETmN5ZUE5OXByTVlta1ZsSXFm?=
 =?utf-8?B?ZTF4YnhrQ0REd1dkaWpvdVJmYTI4OVpHT1dVT3g5dlFrZU1yOUZ2bERSQXpM?=
 =?utf-8?B?RnhOMEgwK2RCTjRGaHNTNXkvc0NuOFhHNUlUU0pxakJXaUZsRnNvZDZBampO?=
 =?utf-8?B?Zk40eUFzbmpYL3QzR0dSSGRiZTZtS3FlZHoyQnVmS0dQNUJnTDhGUnZRbTZr?=
 =?utf-8?B?cy9JY2t0NC92RmlvT3p4ODFUT2o3N1RXVGg1U05mTkhYV1NON0lxOXBRUWNt?=
 =?utf-8?B?d2JSMlY3UUw0YVJuMFg3UlJGejJhV2pGenlSZDR1WTlGSlVFR0UxaFhQM08w?=
 =?utf-8?B?bG1CdVpsSjJmb0h0eTc0Y015MGREMTUxQkNlYzkxN0RPUC9JOWQzbXY0d3Mw?=
 =?utf-8?B?WjFzb3V5ZXl3ZE1PZXhWUGR6d1UxSitwSTljU1lGWWo3VG56V3d1ODlVZ2Jl?=
 =?utf-8?B?ZCtEZVpvWk00ZTI0TnNPU0dJQmliZ0ppMkZteGx0Wm9aS3Vqcms2a2FWV3h6?=
 =?utf-8?B?UGx2U1RnbHp0QXBlWmlPOFNNdjh0NFNBZ1Vxb0M1cXBrTHpJdGg4Wmh0MWdY?=
 =?utf-8?B?R0tzTTVNMEJlQkd0MWNnck1DTmcvOXhYT2lBK240cWFsSDJlQzRVV25KbzNM?=
 =?utf-8?B?VklrRjF4ZFRXWTU2V1l4S3cyN1UyM0tUbDRsUnNnQUZuS0ZmV1lHYWx2YWRU?=
 =?utf-8?B?cG5iSmI0NkE5VkxycTQwVk8yNzdGbHlIb1YySWxGNmpKY0RLazNEU3dRNWxY?=
 =?utf-8?B?NXJPd0l5aUVvUmNlWGR1b1RrK2FsWmJ4THpWUWp5M2FIYkJRZHoyOW5iK3ZY?=
 =?utf-8?B?L0lSQm9qS3ZWVWZIb3pMdDRSL3Vmd3VsWUFjTGVQYVIyeWloZncrcUk1ekpE?=
 =?utf-8?B?SnEyM2JEd240QWxRdEovWFR0TmlxMys2am01WWJubmpzdThsem85bXFNdTRI?=
 =?utf-8?B?cGk5STJDUGozQkErZ2tscWdDNGtPeDh4SkUra0IzZmxod0ZDVVBKMGdJQy9B?=
 =?utf-8?B?V3pOUVczQ2I4YkdKemg2c2hNS0RaMWxCRDN5amUwaGtOZndYbDQzK09lMnJF?=
 =?utf-8?B?WXExbDBtZ0JjWklPaGNUdFhtL0lZSTk4ZjlOeFFyQ05rcU9hM1gyR2lzN1kz?=
 =?utf-8?B?M1k1Q2FURUZTbzRrQUZEd0dnUlpWS2UxRWV6YWdubUhUU1Y5Z2F4OTNtdDBi?=
 =?utf-8?B?S1RDK2hrdmNzRFc3MXluOGhUbUhFYnZRVHRCSUY3ZTlnTWlWcUJlNk5xNVdB?=
 =?utf-8?B?T0FmcXNueFV2cUZJSEl6TjdpNEp2YkhmM1p1cGJZS3lrMVl6VWxKK1M3NVB5?=
 =?utf-8?B?eVdHZ1kybFRHWUh5T2Z0WWhsVm9ZRDd4ZlRMc3FsOW5nNHUxaXdFQUlvVUtB?=
 =?utf-8?B?dmFvUVBhYkprVmMrbEs1VU5oeFBmMmNEL1BXc09pbVFEUjl2Rks4NVpWcjBh?=
 =?utf-8?B?bWRCYjd3S0QyaTg3K29IdGJNY3NqY0cvZU1iaHFYVFVwelNmUXZMYjhDY1Ro?=
 =?utf-8?B?WEpIRjQ3T2RXcXk4b3FjQ0NMdWMyMUFMWlBrVkhvRC9XOWlGY2ZnVElTaWU0?=
 =?utf-8?B?dStvaTY3WGhBclEzOTd3QkVacVJiZ0hHSWdyejdQTDBNdjBEN0FSRytxS2NS?=
 =?utf-8?B?bTFSM3pyMzFtSDhSV21xeWJCOFd3b1dCUGFyRGloMlFsdmg0MjlucExYNlRN?=
 =?utf-8?B?YkNqMkl2MDZIZ2VEU0xHd25wbFJSSzI2dGRXejNJcmllTXFVbXJKTStQdlM2?=
 =?utf-8?B?dkFCUXRTalh1dit6bXIxdFgrSERQeUFSNjNab28xT212cVYvUWFENTNDUDI1?=
 =?utf-8?B?MlVycEx3OU1MdnA1QVMwbk9Sc0FUVFBlZ3JoZmk0Smx5eFhqZTZLazJEaEth?=
 =?utf-8?B?RWpYOTgrL3lOaHJYMmYvUHJkbmUreHozcFVLcldFdzZaS0x4NEhkMmNhQ2cy?=
 =?utf-8?B?cWkraHR4LzJOWW1wMkRXQlRwTXJHQ0JUU1l2bEMzYlc1STd0dGdlTVB1VnlV?=
 =?utf-8?B?UzJEeXFlb000L0kwekloakgyWWJmSE13TFA4b0dlRExSWFpUZURwVU4rRWZ4?=
 =?utf-8?B?Q0J4bTZkS1duWGtXNzNNNURBU2JuRG0yQVV0UGZhWS8vQjV5UGVyeXA1MEdX?=
 =?utf-8?B?VDhPT1UrMTJ6NU5vWVY0dlM2dkQ2eFpQSHBOdGNoVWU1UU41MCs4cVlRb093?=
 =?utf-8?Q?H2gbRvpSHljwMYYORvguCjo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86012930-7f22-4413-e4a0-08d9aefc7e0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 03:42:52.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3z5TYnyWBdKowGtOy1CwTBJ2Hsgb2Ms1pcS5gMI+NVc7hxzBLKDZvl+gn4CRiELGHcOlybl1roEAGc3REz/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2549
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240019
X-Proofpoint-GUID: jNU8csw4h2sFCZn4K2Jnn6prrtyRYPP1
X-Proofpoint-ORIG-GUID: jNU8csw4h2sFCZn4K2Jnn6prrtyRYPP1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/21 18:19, Yosry Ahmed wrote:
> On Tue, Nov 23, 2021 at 5:08 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 11/23/21 12:46, Yosry Ahmed wrote:
>>> The hugetlb vma mremap() test mentions in the header comment that it
>>> uses 10MB worth of huge pages, when it actually uses 1GB. This causes
>>> the test to fail on devices with smaller memories.
>>>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>> ---
>>>  tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> I'll let Mina comment, but I think I know what happened.
> 
> Thanks for taking the time to review this and explain what happened.
> 
>>
>>
>> The original version of the test did indeed use 10MB.  However, the mremap
>> code must 'unshare' and shared pmd mappings before remapping.  Since sharing
>> requires mappings of at least 1GB, the size was changed to make sure unsharing
>> worked.
>>
>> In the end, I believe I suggested adding hugepage-mremap to run_vmtests.sh.
>> The script does not try to configure a GB worth of huge pages.  And, I think
>> it is somewhat unreasonable to suggest users gave a spare GB to run the test.
> 
> Alternatively, we can pass an optional argument to the test that makes it use
> 1GB instead of 10MB. This way, if the test is run with run_vmtests.sh the
> default behavior would be to use 10MB, making sure users do not run out of
> memory. Otherwise, an interested user could run the test without run_vmtest.sh
> and provide the extra argument to make the test use 1GB and make sure that
> unsharing works correctly. Thoughts?
> 

Passing a 'mapping size' argument as you suggest would be best.  That way
run_vmtest.sh can pass in a size such as 10MB, but the test could be used
independently with arbitrary size mappings.

If you have the time to do this, go for it!
-- 
Mike Kravetz
