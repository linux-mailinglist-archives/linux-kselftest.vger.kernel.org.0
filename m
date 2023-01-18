Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229106712EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 06:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjARFCq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 00:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjARFCp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 00:02:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF04FAE5;
        Tue, 17 Jan 2023 21:02:44 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I4L2Dm013459;
        Tue, 17 Jan 2023 21:02:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=GD+nEboGMciznCCY0u2bu8vfHZKXg17tBMRWGmBD0mw=;
 b=c6VsP7l69U3la0xIgrj4Y5mzHi5ZbSetU4I+ZuBGIT+FVgoSlBy8OcwlvfTFbbjam3jq
 y8buKsWs3cnUFxuWKv+uofLpLISObT7hUqRR1d9nim3aYM44iHkhzhA/tp8CzmfYaaAs
 JAfEXQ4ztX9pmueldbZ7B0T9MH3hpwl6rCJAY2mF85s4ay1DoCOPgWWeHSYAu9tw8DVm
 lZwNGYbuhhncllZtE3bhDYcEo3EddlnnG2W0VxL9hDLPQQ4JfBeJhVjWQByFSOiGnAsR
 6X5Gx/VE384Y/SOMMMZ5kDbI/CxxJumdsXokx03vRgYO8VKhxL1KYjXiH4NRrqMAEEEu Mw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5ufen60g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:02:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmvyNeUPxMxImPBvbIr5P2cbvD05rTm34RU5kSJv6i1xbwl/XQWSEEMROFCeq/Ce7WpfqCW2xFPf/DsvVYUEdZYHZ7PQ4VylF5cE+Sw45ua2Yhy84y1AbdwGgmmJW5vfwqGuj4o+smZJX0nKDOgP9qQAeYMy1DENhn92ScYkSqyrebBQAPwirUHvmUJFE7BNsa4E6asNUkhK76Js3YgoLzzXLTfEDJsD2f7/n91n21LLp2k8VkgNsMDFu17LQxk+FKlldj6mmlVXLAk//TFHwaaSZpKp/rFqMaCcU0yJf8zu/jwMRTRz0q3Qv4Vd8OqVBzWk+bKAkW/S1h9yWvj8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD+nEboGMciznCCY0u2bu8vfHZKXg17tBMRWGmBD0mw=;
 b=ElV1BsB3Lagx+BHFeGOLu0gjHfqKEvb9fkLJqsKoQrpzgQGxG9HC1CFyNPNmFkyuRl9RqOu9we6UoiQ+JTAVW2BT7BBGtu60SdjYgxQkzjqDivr5LdsyOfHGZqOiz75SQv+tVjfRu/u9UoqhXET4GkkNyA7hsxRp3o69CNW8zQ63rSJZUqy4/DRJmABURGl/RKDuXexzK+S8kN4XZ/g4Zm3v5MeNyWIt9CwaCu1tUGRXAKpREMMvxQ0ElC2dqFWxXcG/wq/gqlYC7E4QaKUbs10OwtxDgUEl2DKpJ3kHtUajisT6IOC7hPi/8KPwA+M8y1D0bhCuMH1BbVHoCK89lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4868.namprd15.prod.outlook.com (2603:10b6:a03:3c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 05:02:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 05:02:23 +0000
Message-ID: <bc5beea9-0613-640b-b0dd-e54221c2fc06@meta.com>
Date:   Tue, 17 Jan 2023 21:02:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] selftests/bpf: align kbuild messages to standard
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20230118-kbuild-alignment-v1-0-eb5e9fd55c92@weissschuh.net>
 <20230118-kbuild-alignment-v1-1-eb5e9fd55c92@weissschuh.net>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230118-kbuild-alignment-v1-1-eb5e9fd55c92@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: c4aaaf65-18b7-48d5-2ea4-08daf9112f22
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvfzWejsZELrlPOLLhgsAMTz3VK5tqI9wTXXO9TBD6MhakemXyfY2nW/SSpBoBFN/AnGXxfOLAjEW3uQErEnoUxT0Lo572Xw9RBpGIH4T42FLCr7wDOqyfoHoTRYsbhABz5oRe+s+5esBIuJMazbVEJxOcv/ShJwFcDK3jwhz01Br50Jn3EKK5+odJgOapP9kSSWlsy4yBtnGc7RJGJs2AeMLecUzqQm0RkUTbVGq94b+kmYLpG5vWW+1oDXZQeB96oTTVbPFGfD7IgmYqu/1mBtaxtKcXKKHDa0FDgDJP9pSNRN5IUExuyBsvzb9wjQ9XwRVfl9MKdplFGhq/v38uUc1W5r0CXcn6M0csBqxiYLAwpSnD5sTsmrpaHbja453yvQ6FJSibPb9RlM2D3xVgT2NVDY7He6RClGUaztOq5PMAuG3rlFUOBlf/ct6ojZeMsqha1AoqZQCUdv54xU6uCX8v175l9Y6BE0KtKmHaET8QSzaPHEt/pUxChy7ESST+kgj44fP2ERipuGY3R9xTKy2BsmEQXMtT0YJbIKnDnJcv5yY6lCHbZfmK1guY4h7XB/+r5BWoisTIQsjRFaLg2F7d/nlMumlV2pGPynnC/VoYbtxYhlZhcDdk8UurTQpszJLh4r9nH1uXlaLAmAU8ke03NlOyWlgTxqQqg17R8ptFNFhAtdlzkQ44AJsalTMcyTMOOPNFNh1ECUk6WwGkUkYAKpI3/zCaUE6vjRYEUlcbguAVsq0iirhsSISK78
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(83380400001)(38100700002)(5660300002)(86362001)(921005)(2906002)(4326008)(7416002)(31696002)(8676002)(8936002)(66556008)(15650500001)(66476007)(66946007)(478600001)(66574015)(2616005)(6506007)(53546011)(186003)(6512007)(316002)(6486002)(110136005)(41300700001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRxZ1ZiMWlrWWtNdDBiR3pOS0wzTzRCV0hpVnFaSGs4WU1RN29SNndrTXRC?=
 =?utf-8?B?VytyRC93NFREVVZkV21ZalhORnM3N1V1bFBEbm0vWU9LOGprYzkxV0dQZnFT?=
 =?utf-8?B?T3NxdnNWOHQvc0FNa0l6OEdiTkR0U3c5MUcxZWJCMTljeHgrdEY5Zjg4TDJs?=
 =?utf-8?B?QXYxelFmeFdaQTBIc2FvWFgxb2ZFV1hsYUJ1RkRhK0ZYU2dtdS9yUlIzTFVa?=
 =?utf-8?B?Q2ZoYk5XMGFLWXNuZEZaVTJpUVhRdGEySTN4Y3A1Q2tJTGdYUVVRbzE0aTl0?=
 =?utf-8?B?dDdmUEJlQWRPVGxrRkV4d2xZU1IyVUV0dEgweWdneUY5MmRLN0I0Y29Zb1Bu?=
 =?utf-8?B?ZHV4Umw5SjNaZ3g3N0l5MWk3VGpMSzMwVytMNXRuWnNNWmtRdzJ3QjJzeXYv?=
 =?utf-8?B?U3E5U0F1WmhlOUZhQkVTQVQ4ZUFlOE1xdlhQM1hLK2c3UUNQYm1YR0Y1ZzBU?=
 =?utf-8?B?YnlSNThOWVh0VWZVZ0IyUTlUcUlHYlhtbWZFOVNwTmRjQkJUZytkeVlmam5F?=
 =?utf-8?B?WlBPTXdHNFIybGlsL24zNndMR0lQZlZrWkVQVFovWHVwamZnR3VjamgvcHlv?=
 =?utf-8?B?ekgxT0xsY2dramlyQmtIS1dJaUY3MDB0ZFBacENaMTA2T0RWQWVyQll1UllY?=
 =?utf-8?B?THlJdy9hUHFFRm8yWDFlK2YrRW9IWVVUajFwblVvZ2dMZzhvVFRUOXFob0RX?=
 =?utf-8?B?WE1pR09lUjgvSDJtZkJEMnoyOTlmWWZwbnFMMHdGb1dOWXMwczVWZFg2bk8r?=
 =?utf-8?B?a0pybjdsSWpYM204WkxQSHZMRHkxVUM2YUtRVDEvTWpJL1QvOHpGWjJpZ29r?=
 =?utf-8?B?dzBYbitjN3grSUZ1V1Z6WUQ4dXBqUm1MOFlNQnc4VUxEdnBQd0xmYXRLVHo2?=
 =?utf-8?B?VHk1NkFicjhINFlINTAycDQxZ0NBd2I1aW9MMGVsSnN2MlJud2dpWWpXV3Uy?=
 =?utf-8?B?TXY2a1g5cm9aWmk5cEJhRGRhVzl5MHJwcC9lZmdNTlZxZWJXU2lwRFB3dGV6?=
 =?utf-8?B?OWpqejBvV2pBZks1OHh0UnJ3UWRZN2RGc0h0czJ3WEJuajBTT3dpejhtTmRo?=
 =?utf-8?B?MGFyMDlsc01ZcDJiOUdpNUJKc0V6U3RmcWk2MTlKT1RlY0dIK3l4SWprclVR?=
 =?utf-8?B?K09hZ0dPT2hLVnhsYm9sV1ZWcXNJbnFnS1FjdDJoVUl5VVRMUy9rblArazY4?=
 =?utf-8?B?WXRldVpXWmNtNkpVdWtNNnpQWTJjZ2gvQ2tBWEs0VzJ3a1poem5mbEFHaWFr?=
 =?utf-8?B?QUJQWEkwQ3N6V0tJdGpNTzY5MVNSNHdRUm45N1FLcnE1WWdDTUlhZVN6RjJv?=
 =?utf-8?B?S2R4V3BIUzBLSHNJSUxlTHlMcjlQUFFVOXFFQkowUEZyclI4WmkzZmlxUXIr?=
 =?utf-8?B?OUZpb25senVpNDJsT2haMGlMMGZvYVdaQzRzYk13MjVPSGF1MXF3bFJqRDVO?=
 =?utf-8?B?SGhpR3NWTi9neDF1UFR3M1FIZUdwS0xlaG1KRnNGbzV1c29qeXFGQ0tDcTRV?=
 =?utf-8?B?b2dNR2NWS1ZlRnVyZ25GVk8vWEIwbjFJVW5ZUmRscU1yZDJxNldGcmg2b2Nt?=
 =?utf-8?B?ZUphRHM0OHVxNm5VMnZ1QUxzTDlkZFBSZFJTWlpUOEl1YThvd3p4bWtIUHc5?=
 =?utf-8?B?dmNRVWFzZUh5K0pZbC9sTmpweGxnbWhmYmYwbjZaVWZQY00vVnJoWFpwQmRE?=
 =?utf-8?B?RXhsdlJsTHhtSEVSSTFVbjE2RFlBdkRpQ3NKL29kSjZWQUFHRDhqVmtNaXhz?=
 =?utf-8?B?ZmoyOUU0ZTZ5ZEVGWTRmUERmdGRKTys5bFhkTVViWHdDTmVaRDlHRHNJOFUy?=
 =?utf-8?B?eXhtci9DUkNUclJjcDJNYnoyVGFBREFLL3k2T3FTdk5qNDMySWlxeW5jODZi?=
 =?utf-8?B?ZkZjdjU5N1lKSVhVMEExYVpWUFlCOExIbXJjSy9BNVJ6dzUvV3hEdk5pK1Fk?=
 =?utf-8?B?Z05jUnMybFMvcXZJQkdIZytwNWgwNkNlVU1pdU9HZjlzOTR6MUpxTU5BeGxP?=
 =?utf-8?B?Zit2RUoyZTA1ZXpTUG5qSi8ySXZpSVRYUWk3ZkxCbWpqZWJrNlNhQ1RhNjZB?=
 =?utf-8?B?dmlZSG1aVmNmeFJiVzZCSXkvRHN0RmltN29QUm5vVzh3cVVFdmMwSFJIWndR?=
 =?utf-8?B?ci80TUdIckhJL0N2RW5NT2QrMC90dXFlMTZrWE5RNWhsMU0xcVB4WS82bjhW?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aaaf65-18b7-48d5-2ea4-08daf9112f22
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 05:02:22.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wCafTl5SUurTyNc9KeAZSsEBp/oWdmfd+OoAO9VaeBTw2l16OTtdStshajjlL0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4868
X-Proofpoint-GUID: cnx_Rd1zpZm2BBK8oyoD15xc1uXSm2o7
X-Proofpoint-ORIG-GUID: cnx_Rd1zpZm2BBK8oyoD15xc1uXSm2o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/17/23 7:52 PM, Thomas Weißschuh wrote:
> The common layout for kbuild messages is as follows:
> 
> - 2 spaces
> - 7 or more characters for the action
> - 1 space
> - name of the file being built/generated
> 
> The custom message formatting included an additional space in the action
> part, which leads to misalignments with the rest of kbuild.

Could you give an example to show the output before/after the patch, and
how it leads to mis-alignment and why it is a problem?

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c22c43bbee19..5190c19295d4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -98,7 +98,7 @@ Q =
>   msg =
>   else
>   Q = @
> -msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
> +msg = @printf '  %-7s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
>   MAKEFLAGS += --no-print-directory
>   submake_extras := feature_display=0
>   endif
> 
