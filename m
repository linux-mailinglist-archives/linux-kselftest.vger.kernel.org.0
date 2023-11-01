Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2AD7DDDD1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 09:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjKAImh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjKAImg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 04:42:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC155DF;
        Wed,  1 Nov 2023 01:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLp2UiolR6FlzHKYe9qfCPZ0rHbI+K3w3FjcfYwlo3iM6aQXB+fira43SRMY0BjpCN041BvKMyfcJm4rmt01DIZ8DgwulA46pG9rliqGzth3CIBI1YynFMAiLwxVPR9IoNzuN+Y6qjzqJCmCZmeQF28N2CCjLo/x+j4eQQEZKegSSwAhPJk5nizrbbENpFXfKYpmRfNnYvcYTR3DgQ68+e03epBzL1gR51Y84ItmS+qT28KPoAluFQbxjNAHZzOywn2Yh92QhbXLCY5zEJMEU44YExb2PD07KVk2/rs4F72tdzrLHNxo1lgSlW7FcgiH+uTud/LhbQR1Gurisy2tPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw/m2iCs82UZYlRaxjVXHafx1TbCDCBzdKiKdoQ0lkg=;
 b=XftckWqLE8vnbuaxHkNuVfecRuDLOend3qGoCZmLBlD4+/cGBR4pt/tLi5IZIMbw6ZLeX8N0lFyFKUYYd3CZtNyEgOe5Hoi8BGqdDlnQFfoUKvPPYk/1HO08pXWzIljrMUCNGxLXZCrWHa5dvoG0tawHkpTClgeD3JudFmVoVR/QUbFm90u/dU7riwZKOhqzkwXULeuSHqiv++jPuXy36CeZUlAnKv3LULe2eVtS2uqiDFbKUKPeKto/siirqskf21y4ZjMcKv8fRAmfbwi1eCLn+fOxOaQPzJiaUmUQcUE0HjVv2zYj6G2mQpPIWJ9lzJscX9POCLYmsNWj1jUQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw/m2iCs82UZYlRaxjVXHafx1TbCDCBzdKiKdoQ0lkg=;
 b=aw7VhG37+bASX1uupw7g4sENPpvz7F/plr8m8RoQfdAjGdhLWJklDrpZFwumsaxxHPGGMEcGM2Ur9OAj2zlp8JTfZk616DFmeWd4ZvCJoXrZp0pOWdrUdUJ8t44Hl7AJQ9j6iAxrj3uL3bH5LT5O/+SByb9e4271j1H2m3DPBh5xOw6KR5Ih0+qswO7ZTm7OUKsxKAF1++cv1ZL0zLTD9wiEwb79IqqchEuCy0HyEE2aDBfYSwNuexKkAkywvQGqXIQwWuUN4kmBSs6OHvMckIvAW9RJPapbl+Mnu+9ZZzJOipZYtjE8FNRz3IU6vd4b5cfg6pt23gFmYW71p/Xz5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM9PR04MB8258.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Wed, 1 Nov
 2023 08:42:28 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 08:42:27 +0000
Date:   Wed, 1 Nov 2023 16:42:10 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
Message-ID: <ZUIPYkuuKe6sEv66@u94a>
References: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
 <20231101-fix-check-stack-write-v2-1-cb7c17b869b0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-fix-check-stack-write-v2-1-cb7c17b869b0@gmail.com>
X-ClientProxiedBy: TYAPR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:404:14::13) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM9PR04MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b37faa-0e76-44a0-6c74-08dbdab67a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHMAex3GSbdWmZ0e+BOKVRbR9+pozDlKQhuj8n7+34s0osPXjU1YlFYAre/goaqzI0D+NYXFL9uFAMoLfrs4l0huZqnusjs9WhbRDndyWMOs7KAixSdHgWP0m4KFwGKs2M1U3KXPelsqUZZ1leeFeX44mhS2PMF7OgkHktrvGyt6XYIhpCp2eKza6OOhB5cC/oxUpq95gWisz/B5pWzEouxX92OQf/NzGnhzmdrSNzHAZ6OPnqKJLGEGiRL9lGCMvA1XvmSYvevZlZ9bZK0zi1t+PdFbTRwzhK2BkTmf/tgO3YTeSLPStm9dT8m1gCSn8pgTcrTlY7x7EoieLNbyZvga2x/4p5cCgz5zqgE0h15GZ5H8uvo+z2N+MWXZBIFJ2N2nQnucV4zpD+16Mh4kuBS3Xu6MjwjV8+r64NU4cVRucF06cO/ejK/R/P+ALUYcdHKlvWmoJwfX4DHdUCfi3lYdMOH1zQs2qmCFJdd2A/eKHrQio5JDgf64aflUGs383Ga1zvE/vrfzu+ZmBe1Fos93kgwOoCBTe2cw/zsRnMdiY3P7lGdv1+o2Gvwy3I3z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(33716001)(66556008)(8936002)(66476007)(4326008)(83380400001)(8676002)(6916009)(54906003)(316002)(26005)(66946007)(7416002)(5660300002)(2906002)(41300700001)(478600001)(6486002)(6506007)(6666004)(6512007)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1NQ2F6aTc3bFh5bTltcDRBUnVxZHNkNkhxWUxhOEJlcE0yQ0oybXpNekti?=
 =?utf-8?B?TUhQeVQvbm8zSDBFOWlaRmZIMjFvbXdRc0tmZ0VQOE5sT1hPbFZFampaaDVH?=
 =?utf-8?B?MUlNeW1tdDFnWHFVSWNNcklmd3h5eTZrTW5zNHZpb0IzQjRvTE1PQTFWQ1pm?=
 =?utf-8?B?UGhaNmJ0V0RBRkZKN21penpyKzNTSmJkVmVJNHJqUFpjcE5VMU5PT0FNY3RV?=
 =?utf-8?B?S2IzZHVSaEJyQ3BhVFd6R3A4QitvNkRPVnFVdXc3SlJPSWdpcVJZczZlTjVX?=
 =?utf-8?B?VXk5UlFSc2lPS2RkN1N6S2pIZ3owZ0ZjQVo5UmZEd2tBc2ZQZ0p2TmJ6OGJW?=
 =?utf-8?B?a3dkOWZaSFJ2a091K1hndFVoWDdCVWM5VTVFdEg3L1RFQW8yTWxyZGk2c0R6?=
 =?utf-8?B?QlI1ZnBNL1VBTndaZlJyOWRNMFZ2NHRXbW5kMGlTY3I1NWh5UXVFQldOd0ZP?=
 =?utf-8?B?WXVRaHVodWtVOTBYWWhCem40OHhlM252V0xRNTkvc3hPOExQWlRxWk1UQzY5?=
 =?utf-8?B?cXVDbmlmRnZaZmVmbUt0R0kwUVBsRkloRmNHbXcxSTlscDRBMFpDMk5uNEx4?=
 =?utf-8?B?amF3TGtFTi82NjYxRmh6WHpTeVZmSzIwYUhsUDRUUmRuM2gvQ1BWU3JVaHFo?=
 =?utf-8?B?Z0ozdFJLMEg5NDA4UHVwTnhxV3VoWXFkVDNBTVYvVmlKeHE0MG53cDR0UEFx?=
 =?utf-8?B?aE5qRkgzUER6bVN5MERPSWJ1SjdRLzBvYVNwR25MczR1RWs1NWNvdmJ5U0lM?=
 =?utf-8?B?WEF6NnBmaTRZWWpDNmFKdjFrRWtnZHN0b0dDUGUrMVRBUVBLLzd5dEk5by9W?=
 =?utf-8?B?bG43UEpJWVh4ZU9HK0dLYU9kTDNudDVYL0dzaGQ4anEyNlJmbyt1Ui84YUdG?=
 =?utf-8?B?bjUvMFlyS3J6bldZaVlQSzVlektLeWlUTnlYRzBhYjZ3NTNjMnRJWTkzOUN3?=
 =?utf-8?B?QU1Rc1o4VlFTOGpsNnVjdWJjLzZ5Q2N0V2V2azlnSmlPZzRNN05RbUsydTZj?=
 =?utf-8?B?VzdsNWgwSTgrSnhNVnFoMDZPM05sL3RLajluWEM5Vm5jLytiWEYzTUVBdHQ5?=
 =?utf-8?B?OE5adlBBZzlWZk1iWVZ4R1BoL29GbmRqeVFqUEVXc3dDU09neTEyQ0NaNStO?=
 =?utf-8?B?ZTM2NnFIZWFBLzBMdFcySXMwY1VFYmsxNXF6SStYRGRoSXJnVVYyQWY4Ti9U?=
 =?utf-8?B?R294N2wza2xDZGMvK1hEUU1ZODB4MnZJeEJmLzhOdmlScDE4encvbCtrbkdJ?=
 =?utf-8?B?Vnd5dGNQYlRlZnlFUmd5d0ZBTkkzT3l3TEl0aUY3dkRBQWE0dnZMNXRVemM3?=
 =?utf-8?B?TUFDaHBNaExqTEtuOWFKNkNpRnR6dy9LcXpLZjU5Q2paMUMxWjZaYmQxYStN?=
 =?utf-8?B?d25jSFFxY2hpakd4dGNQcm51SDNDOGcyZS9ERTByUWZkejhibjNObHJvT1Va?=
 =?utf-8?B?cjFWRktSa3l4VGx0VHpUS2pOVFR0VHloaGI1ZnZhTXdnQVpBenlGMVJNUmFG?=
 =?utf-8?B?MG1zNnlLamtyWHowUXh3QmV4UnFJYUh6UDZvbUwvbHNnSk9vck9nQ096Z2ZJ?=
 =?utf-8?B?aUlSNmJXZFJGQUNXUTFvdnE5bkxxSzJnVk1uZUtGam5sdTk1c2tyK2hxa2VN?=
 =?utf-8?B?TmNSRXhVeGJIM3RUWU5jUTZCeE5rRjJrOXVwQUlrRXBzTHBIZ3hCNGRNVHF1?=
 =?utf-8?B?bTFJTlRncGtHRnhQQyttbnFYM1N3U0hOV2JyOE1sUUFiTllKR1YrMmhkV3Z6?=
 =?utf-8?B?WDVueHFyRjBPbDlHZnkrWUFWMktSY0F0aG5ESVBYdzY3KytNSjhScTFxbUgx?=
 =?utf-8?B?YlVOU3hueDN0ZmRPYmsybW0rZkVueTdmMzBBWStWK2o5WXJjb0w4V0RKdkpj?=
 =?utf-8?B?UFdHQXNTVHc0dnNSSUdUYjhFc3J0WG1UQTQ3Z04velk2eWFqcytiT3MvUlJY?=
 =?utf-8?B?YnlLU0pEVjJYRENJOXpRUi9jQ2JQemN5aTVuY3BDeXJkMGxsdnFYWVpIZGlS?=
 =?utf-8?B?SE9kL3JHbWlPRDJJNGpXbG5pMEZYVnlNTkEvNENoWDFEVDhNWjk1UFhBbVY0?=
 =?utf-8?B?eWllVWQwSlJOYUxNNDBNV2RkZDl5bUkyTTlTN0dIcDRGN1dVZG5FTEtWTDVl?=
 =?utf-8?B?bGxpYXhrSlJaajAzTXBrTDh6ckJ3NFplVW4rM1hNWTNFdk1RT2lZeUJldHBn?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b37faa-0e76-44a0-6c74-08dbdab67a86
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 08:42:27.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz3a8WpR409+niVHZUFxg9BPOylZgNaRuSqal5SO1bcAfIBsRjzHEhFdV7o6bxPV2ug3g+OjbJfpljABksDz8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 01, 2023 at 08:33:22AM +0100, Hao Sun wrote:
> In check_stack_write_fixed_off(), imm value is cast to u32 before being
> spilled to the stack. Therefore, the sign information is lost, and the
> range information is incorrect when load from the stack again.
> 
> For the following prog:
> 0: r2 = r10
> 1: *(u64*)(r2 -40) = -44
> 2: r0 = *(u64*)(r2 - 40)
> 3: if r0 s<= 0xa goto +2
> 4: r0 = 1
> 5: exit
> 6: r0  = 0
> 7: exit
> 
> The verifier gives:
> func#0 @0
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
> 1: (7a) *(u64 *)(r2 -40) = -44        ; R2_w=fp0 fp-40_w=4294967252
> 2: (79) r0 = *(u64 *)(r2 -40)         ; R0_w=4294967252 R2_w=fp0
> fp-40_w=4294967252
> 3: (c5) if r0 s< 0xa goto pc+2
> mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r0 stack= before 2: (79) r0 = *(u64 *)(r2 -40)
> 3: R0_w=4294967252
> 4: (b7) r0 = 1                        ; R0_w=1
> 5: (95) exit
> verification time 7971 usec
> stack depth 40
> processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> 
> So remove the incorrect cast, since imm field is declared as s32, and
> __mark_reg_known() takes u64, so imm would be correctly sign extended
> by compiler.
> 
> Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
