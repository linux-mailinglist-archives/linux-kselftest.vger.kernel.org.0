Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7C3FEACD
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbhIBIq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 04:46:29 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:38790 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244583AbhIBIq2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 04:46:28 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1828YXVq014846;
        Thu, 2 Sep 2021 08:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=tDT7QODcYftcwv72yY5qZYi9G9lfrmUn6QJ1iBFlmZg=;
 b=puWTFKRkdoLlAMlWf52kUNEDkM6w7ujAmmP1OSV4WmLzWOPt/Jf1N0u8sr1xFUsmQ6AH
 bI4s3uXCn9uln+VUH1iTNZ7OiqCHdaZRGaapMIf4LUPtfjTVYBbRYPvC8MQvwoA0c4lE
 +6E0Y/X+gxYk8y8T2APDVE7RdkCGO7YOi6IhFJFTtdf9TtNBW5183rVqIyyS4W+9cdTz
 rrbHXur5wKf2PEtOelRWBcGaiYXxTiooA/J+0fQmH20A2RBhCaJAAItjM/efcRDpdmVD
 rzIhfnaT0WIj7DPjr9pMAy+DH8fzJpyqufAeHrf2Y41zvhxBcV+Lsl+Sb0te5AoxxLbn dw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0064b401.pphosted.com with ESMTP id 3atdx48gjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 08:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYyNFfH+dqIDoZj+Ccg8TKEhcPEgK4SAoMA3Ai49taDfcEW3A65nFVOJ/1JLQCvlFTnbd/Kzo+H5yIQwq05uzaFMXWMfhoCLuMYhPCqqIrtfEzG8pDTbz6WwlsChswrEv6n8g/cLIAdZdX8N1LwdHYS6EkJ5CwdRXCZBTGrBEr75UXdkeNkjhKSsBYgaIrPSd21LAlCSfrbQ8nyxDUjOs27sW6H+aQqHOptcRWUsZG4KpQSp0JxYfJ5U6eYBbG2/1KqFgkJf+VPVi/kBh4q6wMPn5UO3W8zu8Ct9W0otuQ2WnvZue2lZEIcsUA+Ag7yJH+WtonGi2PScixr2mLqVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tDT7QODcYftcwv72yY5qZYi9G9lfrmUn6QJ1iBFlmZg=;
 b=hdSasr11rY5VAGBxvlbiSToAIoFP7KhZWVzePRh09O5raAyPWxwWBRBHB9U5OpAeLhlbraxjxG9ncBL3hdb4nkmZu2QR9I/aUH/JvmPd2o9mz0pHSe0NtLt/23UhLPe9UOWfQFymvC8utUJUlqrPbqOTZYGRIloOoj05fRCNU28xJG8YQvIGbXzqghbs3P1F0VtVzzwqOejBql2D+gZkxMHFs1h249l3ttAeyHRVnLhqvDPgyrZtKdy+y+KMmPwNcP/8168PuHA1R59M9o6RRZtqNx4NaoRgj6xRWJx3WC2QTCyxwIDhff4997w+cwo9Ds7I74iNkOwthzRlpxsjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM4PR11MB5408.namprd11.prod.outlook.com (2603:10b6:5:397::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.20; Thu, 2 Sep 2021 08:45:19 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::b866:141c:8869:a813]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::b866:141c:8869:a813%6]) with mapi id 15.20.4457.017; Thu, 2 Sep 2021
 08:45:19 +0000
Subject: Re: [V3][PATCH] selftests/x86: Fix error: variably modified
 'altstack_data' at file scope
To:     shuah@kernel.org, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210824024358.4183342-1-jun.miao@windriver.com>
From:   Jun Miao <jun.miao@windriver.com>
Message-ID: <09fb52ee-3041-991a-0277-ff01eef2643f@windriver.com>
Date:   Thu, 2 Sep 2021 16:45:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210824024358.4183342-1-jun.miao@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.214] (60.247.85.82) by HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 08:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2d1212-c0fa-4a0e-e798-08d96dedfe26
X-MS-TrafficTypeDiagnostic: DM4PR11MB5408:
X-Microsoft-Antispam-PRVS: <DM4PR11MB5408D1791B86B9C907ACED7C8ECE9@DM4PR11MB5408.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DTnFGpIkwVWrCZjy5lJHzT/rou1Eg6Nle00qvxEm+TxMX2iR+zdd88fnFaBe19stl7wCQUfdp9j6oAX8cpUReulEWs17wga/86W0HCBd4BF5VgL5dwF44jUiHwymnmOcY+Cb77FgQb70Mjom6XXmlSEUTy+E13K3luFwISUXBMGJkWIV3U8PYhbddSQQqhXZo63wINRo9f543JAR6l9ncyeJMEpjhteOM0BnClWkAw2N42HWIUPk1IP/D/5U7RORypwEXwl84V6dETU6X8vuUH7wPBG1FKVBydofDB5wWRbeYNy5iTP/AN5yxo7nwDPHgi4uejJHvwbrW8TTkVn6pP3MZNrk5yY5J6vd/yVXTChuOMutrBs3awRDu6bLKrlv8UT3bINGrL12PhZB34Ax+ZUCx+cFs6QPg418aQIfd3p0aQKfh4fqDSTq9p6V0aJ0gzkZ5hJhuZa7TQaP8YL3ZCEOv//5iqD7r6WfayjGE9MG8Y0s0y5lSoSDbdEdZ3hId3xgURa3SGsFSFeza8thojvqTY9ZEyUt9A4iDpDbbIojBqJS1waaXDHYqRT6BjVlFJHf6qtMEWb/9C5a+6Lz9eWflIxkzB/xwJgXg4o/mBOWjfTtWqXpwWgUNDvHTivxL8uFsYHjWuhTqnPxpN7DwKXGaqI999zxZAR7iMBxlUR1gPC2OIKeo3UfjB1idTvGEFKBUhEbfghVhwk086YhZClvkmenYX0YCdDo7CPq3HjsDBroag7GCxHL0FaWkkySqrhMHgoge2n8vXVVbmuyF1bhsuUp1Outxtwru3WoXif5Km4Npj2i1L7OwIK5eW7c74/O35vU4m1tv7NSVh0HsGC4/RfMVA5MIoxLyth4NLT9/o2UtTMnAvVD+Im300c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39850400004)(346002)(26005)(4326008)(6666004)(53546011)(66476007)(66556008)(31696002)(52116002)(38100700002)(38350700002)(186003)(8676002)(36756003)(956004)(966005)(478600001)(5660300002)(2906002)(6706004)(6486002)(83380400001)(8936002)(66946007)(316002)(86362001)(31686004)(16576012)(44832011)(2616005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxLUTY1VnBmMW5xYUh6QlNFMHBQblRlS3NoNUpXSEdwYnhpKzZUUnkwVXdM?=
 =?utf-8?B?bnM3M3AwVTFqMXhZU09UVlR1VkhHRzlvUjdLVWY3bm11UnNDVExxdEFWczUy?=
 =?utf-8?B?bFNCcHVtY3E3WGZ5YkdsOHhjMm53M2pjcXMrVHliM0JmaW1ySVU3dTJCVXc2?=
 =?utf-8?B?anU3NnhoQ1pLR3A2N3g2V0VxZjc2cEZNcE9TQTNHWnFUeGEyY2NKbVNhdUkv?=
 =?utf-8?B?OXc5dDkyd1JtS0cvcDdhVndqS094U01mTnFXNnppbGo3Wk9yNVJSMlBXRS9s?=
 =?utf-8?B?VmN4WjRtR3ozWDY1aXV3NUN3bUllVUZndVVPZ1FzY1RhM2JSeHhKMERSQUUv?=
 =?utf-8?B?YmRDYmlFRlhjbVVtakM4djJvYkhySmxPbDV3YVZPclV4c3N4YWNNajZDWDdx?=
 =?utf-8?B?NWhzcVZpWmd6TjNtOXR6RGNVYk94Nk8yZWhUWm11TWhneFlNYUJrelBSS3pD?=
 =?utf-8?B?WFhod3llM3JkZUpyL0FMNU5vQ3FHajAvTWNiOEY2SzZoNlRlVkNZdmJ0c2t5?=
 =?utf-8?B?VXFKWVVFZFZMTkJRTlUva0FJK2ZSM2c3UGRMTHhBNjRlMDV4Y3FVTkhvZmU1?=
 =?utf-8?B?V3ZBN0FkSjBoR3ZYbW1DRVVYNjFHeHlJK1NOZjdTQnVURHY3d0VDdG9mNWVi?=
 =?utf-8?B?WDIxSjZJcEpTWGtta0t6cEFrRXFBUzJ1SUUvVzhLT05sR3JlRmFBTmY5Zm5B?=
 =?utf-8?B?eHZIY05xMHQ1dDBOMGtYbTJIMStxYVZrbHR5ZkppKzRJMHh2WmhpdW00WWg3?=
 =?utf-8?B?bmIrYnlOd3JpK3laUGtuUjZiVDhJWDhYWUxFbk1oTDErbkh5eE5DZzUyRnNU?=
 =?utf-8?B?M245MWgyZ2tSN2dISTFnVVZyamYwL0ZlYnhlcldiNGpxMmRMczZ3TGFBMGhW?=
 =?utf-8?B?aUtteXVKcjl3Wk1HbjRDbHlOVVVXUWR0UmlWZ3FlcncrV1BzVGxidlEyMDk4?=
 =?utf-8?B?cm5LUDJDRFMybFkwMmdob0NQbXMvWU85Zi9kNUpaeHdrZGtOR0QzdXNMS0Nt?=
 =?utf-8?B?MkROK1FGRmhyS213RU9SRTRJRVduOGhKNzV5aDlUT3A3Umt3dTRTaUZuYklR?=
 =?utf-8?B?aTBnb0tTbUswYWpJWDJJT2NmcmI4VU5mWUErMCtJTHVxZ1k3M1UvckJtOVRs?=
 =?utf-8?B?d2I1RnU1bHByMmRldDVYR25kTXprQXRlQVVmRkV3N0ZVT2ROVklZT3Q1bGNE?=
 =?utf-8?B?cG9sUTkrd1Bkc0RDY1dFUUNNZTg4VUIrTkRJa0hhWU1FUXUrR29yc3pVcEtF?=
 =?utf-8?B?U25hSnV4dzV6eWJvTmYwdk8wVWgrclc2VVl5VkdpK3hBdW9QTUEvc0VnLzZ4?=
 =?utf-8?B?TkQ3R1psRjU5dGE4UGRTNXNVN2ZPMWVCUkQwQWJSZGdEclRxbnFqU1VlZjlP?=
 =?utf-8?B?OWlyYkIwT3FjUkNHb1VDOEcxMG9yRWdUM2NYMnRlcmdBOC83dXprRDR0NGk1?=
 =?utf-8?B?R095dEQvZkVLN0VmSEtlS0Jjc3NyamszYkxWVnJDMmlHeCswVXJGYWVGc3U0?=
 =?utf-8?B?WTUwc01kMFBOVmVmTnN0RVpHS1kxMlNZS2thNlVnai84NDBkY0RHS3AwYk1P?=
 =?utf-8?B?bDl6NDhpUDdCaGpvaCsrM09FUTJHSVMyNGU5SS9Ta0lPYXk5MFQrblBUanBU?=
 =?utf-8?B?dTdVM2VjTTJPUUk4Y3VINGZRUVVyMDcvQlA0ZFBaQzlpeGtZQnl5V1pVckQw?=
 =?utf-8?B?Ri9nbXdJL2tWYklKWUs3cmVSNDdPUTdTVXNobzdLaEl3RzVEL3VmeGVvb2RP?=
 =?utf-8?Q?+0M+0/l1pgKRCRk1s31NWqiH3NP+9nMEevJ0I3y?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2d1212-c0fa-4a0e-e798-08d96dedfe26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 08:45:19.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr2XRB4OTwMCmaWTfk/YDiDnvYv+QKhJGn9TLDiuuJ2OJzgxs4PiERCukz5mXM67kOzUeVxn5tLUWORR/l3Lrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5408
X-Proofpoint-GUID: B0m1ObTMQQuRAQdl2RWG07n73NUSESC4
X-Proofpoint-ORIG-GUID: B0m1ObTMQQuRAQdl2RWG07n73NUSESC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-02_03,2021-09-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020054
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

What about this patch?

Thanks
Jun


On 8/24/21 10:43 AM, Jun Miao wrote:
> Based on glibc 2.33 -> 2.34, there is one new feature:
>
> NEWS for version 2.34
> =====================
> Major new features:
>   * Add _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.  When _DYNAMIC_STACK_SIZE_SOURCE
>     or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ are no longer
>     constant on Linux.  MINSIGSTKSZ is redefined to sysconf(_SC_MINSIGSTKSZ)
>     and SIGSTKSZ is redefined to sysconf (_SC_SIGSTKSZ).  This supports
>     dynamic sized register sets for modern architectural features like
>     Arm SVE.
> =====================
>
> If _SC_SIGSTKSZ_SOURCE or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ
> are redefined as:
>
> /* Default stack size for a signal handler: sysconf (SC_SIGSTKSZ).  */
>   # undef SIGSTKSZ
>   # define SIGSTKSZ sysconf (_SC_SIGSTKSZ)
>
> /* Minimum stack size for a signal handler: SIGSTKSZ.  */
>   # undef MINSIGSTKSZ
>   # define MINSIGSTKSZ SIGSTKSZ
>
> Compilation will fail if the source assumes constant MINSIGSTKSZ or
> SIGSTKSZ.
>
> Build error with the GNU C Library 2.34:
> DEBUG:	| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
> | sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
> DEBUG:	|   150 | static char altstack_data[SIGSTKSZ];
> |   150 | static char altstack_data[SIGSTKSZ];
> DEBUG:	|       |             ^~~~~~~~~~~~~
>
> DEBUG:  | single_step_syscall.c:60:22: error: variably modified 'altstack_data' at file scope
> DEBUG:  |   60 | static unsigned char altstack_data[SIGSTKSZ];
> DEBUG:  |      |                      ^~~~~~~~~~~~~
>
> Link: https://sourceware.org/pipermail/libc-alpha/2021-January/121996.html
> Link: https://sourceware.org/pipermail/libc-alpha/2021-August/129718.html
> Suggested-by: Jianwei Hu <jianwei.hu@windriver.com>
> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> ---
>   tools/testing/selftests/x86/mov_ss_trap.c         | 4 ++--
>   tools/testing/selftests/x86/sigreturn.c           | 7 +++----
>   tools/testing/selftests/x86/single_step_syscall.c | 4 ++--
>   tools/testing/selftests/x86/syscall_arg_fault.c   | 7 +++----
>   4 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
> index 6da0ac3f0135..cc3de6ff9fba 100644
> --- a/tools/testing/selftests/x86/mov_ss_trap.c
> +++ b/tools/testing/selftests/x86/mov_ss_trap.c
> @@ -47,7 +47,6 @@
>   unsigned short ss;
>   extern unsigned char breakpoint_insn[];
>   sigjmp_buf jmpbuf;
> -static unsigned char altstack_data[SIGSTKSZ];
>   
>   static void enable_watchpoint(void)
>   {
> @@ -250,13 +249,14 @@ int main()
>   	if (sigsetjmp(jmpbuf, 1) == 0) {
>   		printf("[RUN]\tMOV SS; SYSENTER\n");
>   		stack_t stack = {
> -			.ss_sp = altstack_data,
> +			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
>   			.ss_size = SIGSTKSZ,
>   		};
>   		if (sigaltstack(&stack, NULL) != 0)
>   			err(1, "sigaltstack");
>   		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
>   		nr = SYS_getpid;
> +		free(stack.ss_sp);
>   		/* Clear EBP first to make sure we segfault cleanly. */
>   		asm volatile ("xorl %%ebp, %%ebp; mov %[ss], %%ss; SYSENTER" : "+a" (nr)
>   			      : [ss] "m" (ss) : "flags", "rcx"
> diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
> index 57c4f67f16ef..5d7961a5f7f6 100644
> --- a/tools/testing/selftests/x86/sigreturn.c
> +++ b/tools/testing/selftests/x86/sigreturn.c
> @@ -138,9 +138,6 @@ static unsigned short LDT3(int idx)
>   	return (idx << 3) | 7;
>   }
>   
> -/* Our sigaltstack scratch space. */
> -static char altstack_data[SIGSTKSZ];
> -
>   static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
>   		       int flags)
>   {
> @@ -771,7 +768,8 @@ int main()
>   	setup_ldt();
>   
>   	stack_t stack = {
> -		.ss_sp = altstack_data,
> +		/* Our sigaltstack scratch space. */
> +		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
>   		.ss_size = SIGSTKSZ,
>   	};
>   	if (sigaltstack(&stack, NULL) != 0)
> @@ -872,5 +870,6 @@ int main()
>   	total_nerrs += test_nonstrict_ss();
>   #endif
>   
> +	free(stack.ss_sp);
>   	return total_nerrs ? 1 : 0;
>   }
> diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
> index 120ac741fe44..9a30f443e928 100644
> --- a/tools/testing/selftests/x86/single_step_syscall.c
> +++ b/tools/testing/selftests/x86/single_step_syscall.c
> @@ -57,7 +57,6 @@ static void clearhandler(int sig)
>   
>   static volatile sig_atomic_t sig_traps, sig_eflags;
>   sigjmp_buf jmpbuf;
> -static unsigned char altstack_data[SIGSTKSZ];
>   
>   #ifdef __x86_64__
>   # define REG_IP REG_RIP
> @@ -210,7 +209,7 @@ int main()
>   		unsigned long nr = SYS_getpid;
>   		printf("[RUN]\tSet TF and check SYSENTER\n");
>   		stack_t stack = {
> -			.ss_sp = altstack_data,
> +			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
>   			.ss_size = SIGSTKSZ,
>   		};
>   		if (sigaltstack(&stack, NULL) != 0)
> @@ -219,6 +218,7 @@ int main()
>   			   SA_RESETHAND | SA_ONSTACK);
>   		sethandler(SIGILL, print_and_longjmp, SA_RESETHAND);
>   		set_eflags(get_eflags() | X86_EFLAGS_TF);
> +		free(stack.ss_sp);
>   		/* Clear EBP first to make sure we segfault cleanly. */
>   		asm volatile ("xorl %%ebp, %%ebp; SYSENTER" : "+a" (nr) :: "flags", "rcx"
>   #ifdef __x86_64__
> diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
> index bff474b5efc6..461fa41a4d02 100644
> --- a/tools/testing/selftests/x86/syscall_arg_fault.c
> +++ b/tools/testing/selftests/x86/syscall_arg_fault.c
> @@ -17,9 +17,6 @@
>   
>   #include "helpers.h"
>   
> -/* Our sigaltstack scratch space. */
> -static unsigned char altstack_data[SIGSTKSZ];
> -
>   static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
>   		       int flags)
>   {
> @@ -104,7 +101,8 @@ static void sigill(int sig, siginfo_t *info, void *ctx_void)
>   int main()
>   {
>   	stack_t stack = {
> -		.ss_sp = altstack_data,
> +		/* Our sigaltstack scratch space. */
> +		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
>   		.ss_size = SIGSTKSZ,
>   	};
>   	if (sigaltstack(&stack, NULL) != 0)
> @@ -233,5 +231,6 @@ int main()
>   	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
>   #endif
>   
> +	free(stack.ss_sp);
>   	return 0;
>   }
