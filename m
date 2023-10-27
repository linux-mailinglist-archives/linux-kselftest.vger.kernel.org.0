Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BF7D901B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0HoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjJ0HoY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 03:44:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7F116;
        Fri, 27 Oct 2023 00:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgZQ7FvWCAgK0mIjPi+/f3Fqt9TV6h3/AYFPGusFbcYku+csq4XiUzvx2loLoGcqlYso1kl+khSpfRBfzrsCaVFkzPdZlxsU6duJdPbupctkX9iH/it+R8m3EFrhhHOsA3cTzV9VcocmCiuf3dEPuRzuVVgxBFNVBf9eHx6PryjeKV1g9iFHcovgfuMvyQpuw+TjpFCuD1TuVdA9eLOyISNaG/6+gWi/bolzV2HanVuBHXCjQrAzh7HS/SH7X/5Iw8uWeoQmWyLGGT2WVs3gVd2+DFA/pzQGah8mjTf6vc1InuRMPLkIo1wWks9sHVH0Vk6VUnbiA3jkvTrBjds4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6qQJocOAD1mJVvhk6SaX4dA99MhMjx8FjOHPwpj+XQ=;
 b=lKCbJ1t4ac1IgPLSSgmWQlZVXnh7Ymiu0ydQH0IEmfxOE23iJi1mKP26vCJTtYZxuTy82dVSml6f73YPPIOR5EEfSh1QYsEcCs6acM7pn/c38eXrpsZWU6hM+Z2MBeeB2AOdodqt8P+rcJC6fgRNiGH7elkKJVRLyQ9OWRD9r/1rQKbPuC+6Dl9j1q1bXspxZSgEC94epF3hp5l1uFE6IA2fF76bt5O8h0aekHPqeeNvRfOcOdqlfETVZPxsQn/sS/F4/BhYjE0QCjy6wzz31CCBD8GT0n0APL3wujsdKO18dAk+DghnPWMtOX3cAxYJ4bQSUArEfl6i56DBuAVUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6qQJocOAD1mJVvhk6SaX4dA99MhMjx8FjOHPwpj+XQ=;
 b=3bDJTZgEpXGCSwog1R5CEu/4lTQ2VPagPdUdnHK6Vl8FuJ2sh8TiqypZ/rG8/ApMhN1LqOAT9r/OWkx3WtGWd2P4oaj5Ei8AkdI1O6bB0dA0D0VecJ5THsmw/CI0+fRygs5SYKWjUuqh4OM/ORnFhg+JL405KXfHYeetSq9Ks63MM21B9bXaoKCQ/4kVDXe+sMFGfGaQ/31W40pQ275dRCqAO7GAAXjpFNChy51KC2Qmzah6xkYYZQ+qLKpk+tjC6P9FRMXdvdSvRKfgOIQn2NEG1jH5mUvo+0f4ZS4qpvDW4AoWRLPZ3L96FsDj+rgdA8nwOwWwIpLByo1Ix66MFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 07:44:18 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 07:44:18 +0000
Date:   Fri, 27 Oct 2023 15:44:10 +0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
Message-ID: <ZTtqSnKmaQ4ma98g@u94a>
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
 <20231026-fix-check-stack-write-v1-1-6b325ef3ce7e@gmail.com>
 <ZTtjQlqRQWCWwmHx@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTtjQlqRQWCWwmHx@u94a>
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: cf795705-2e3c-4c43-a5b2-08dbd6c086de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k545lQk01G3g0Fl3E/eZIXWaoCNg0GmOdZ6prqFL5obZdQvJnEnnt3aAavtKlfh7IVrZaBuNPWjKqi6ahiN01lO9xqDLzOej+6L7xWdY8uD/bmNCxujyJiDzMABCz1vHC8ypK9sUIDhulukhdGo2HBSg20plH+oSuYBUqLwM9+N+CE3VQaIT6D0AFAEL5WkdLywxyDRqj3hKSnawGOyhGSTuVwuva62vOfo4Pay1Vz3t7YbOH4OwNlhmwkg7pUQQVtaBpn3SwyPcAOzsna0+YMweexTT9XY1m/gKmCeWhdBDeDomBRMocRqAs8OXuTZmZK/1iv95OMiCMyly+gdCOKDF1O+kyjOys1GpdWHzejSRu7xxsa8DRXVqFpUB8onoMAjC5NlY4Wbyowthccdu497kPwH70AAArCB9nGBKBBbpHcCFxD1Z1LlB+ygXicuNBeoccy1Lp6eAnklU7lZK1YFjTLIM3NnoZIaU2aS+dEfKNaz6LuAVe/X54EEQbzAltf84ATwGabOcgWXExmwVtV9NI/DzuhhwogZLbNsKiDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38100700002)(83380400001)(6506007)(9686003)(6666004)(6512007)(33716001)(66946007)(54906003)(966005)(6486002)(26005)(478600001)(6916009)(316002)(66556008)(66476007)(8936002)(4326008)(5660300002)(41300700001)(7416002)(2906002)(86362001)(66899024)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElKQlJzMkt1cGNsMHh4cWVBWnRjWE9jamd0NnJsS2NMM2FEd2dxV0Nuc1ZQ?=
 =?utf-8?B?Z291cndLYnBCODJPY1NWRjBYaFJCVDlqRVo2bFpvS0drNkJ1dTdHSEREeW93?=
 =?utf-8?B?czQrWWUrWmpHYzhIUG9rVFA5QVhsdHgxdmNRakhqbTVwcTJuWXprNXhNUHRo?=
 =?utf-8?B?bGFrL3R1cGFyZkk5VnZUM2NqZ2JMd3B2UzhJaTNGR2htMkhlUTMwa1lFN3Zs?=
 =?utf-8?B?OXlmdXdGM1dEV2NuT0RkR29LZ25WSlpBbHk0UjZTTTZMeEZTWHlURzkyc0s4?=
 =?utf-8?B?VzBwV2R4UENqWTd3VDYzRS84K1ZlcGk1NzNUY1VDTEdaejQxUjBxM3RFRFpT?=
 =?utf-8?B?T0MxNGpWT0xBK2RKZG9DbHZLRXdCbFVRK1JmOEdhd01Yd2tNMDdQRDc5alJM?=
 =?utf-8?B?L2N6MHh5em1OL05RL3hVZDBTdUszVTFCejFPVzBsYWxHZDY3eGQ5bTRPcFhU?=
 =?utf-8?B?eVErU1NhcnNSTDJseFRQUTJxNHF3UEI5Rms2RFh2RVc3aTQzQ0VkK0VMYzFu?=
 =?utf-8?B?R0I2THZOcmJPNUU1UDZ1M1NIZzV3b2ZqU3pvZm5DRldDMmNjREFTdERKd1lx?=
 =?utf-8?B?UE54WktDTFNMK2EzUlFuV2ZEcDZHcU4zSDBFeWh2cWpQcUFlZEtUcjZ2S1Bl?=
 =?utf-8?B?MjMxdzFuNWJ2TFRZY2o2eXpEWDFzMDZVNkJjT2Z0QXgyT1NGVy96V3l1bXcw?=
 =?utf-8?B?Zndva2tJSU4rcnFPS1VLcXZ3R0o1Y0huVnMwMEptbzlKTm1RRG41YTgxeE5S?=
 =?utf-8?B?TFp1UmoxZVZ2Nm5ldnFoVHFzZG5PZDdkaTlvYUJoaGNzaEYwWVo5L0NySW9l?=
 =?utf-8?B?OUZsK25tQTFMU3pTbDB2dElBZnl4Z1NXTGVCempvOFdBN3lEb3duUExSL25s?=
 =?utf-8?B?b1lFUTV3YmNsaTdmVWlIaWtGOXhFWXpkSHpNK0RtWFpyZm9nUjZ1MU9wb2d2?=
 =?utf-8?B?eE16TlErMGlFODZldytiZDBaajhHMnRGRUw4LzR3T0ZjOUlOTzltaHRxN3NW?=
 =?utf-8?B?VnQ3QTJsUGpYNE56bEhjcklyeTlBbjVwQ3BDbzFBZndKTTdiQzV4dktlMGVw?=
 =?utf-8?B?ODNZN0YzbW1Jd040RzFrMmh6Z1hodFhFcmg1UUg4N0wxSkRyY09jODJ6SDh3?=
 =?utf-8?B?WUhXYmhOeUdGcXdnRUR6RnNrZlNacHlGNU8yMmw5b2RmcmxlK0k0cTMzMXJQ?=
 =?utf-8?B?N3gxcFRCN3ZiVXd4MjNTbGFlVVVxbTJIUHNvZFM5L2JLR3Q4Y0MvTnRMVnU5?=
 =?utf-8?B?R3F1NEhUeGxLdkpjcW9PamFlUkw2OUIwSjNRR2YwRlZWVllOTy9zZlNqeWx6?=
 =?utf-8?B?ZzdoMVNtWUcxYW9ZR1VXWkMzMm1ybzFFQ3NaWTBsWFpva0dQcUlNN1ZVVWxv?=
 =?utf-8?B?NUtXQkg3dGVBdUxLNFM1dWM4TWNPRWdObmxvaHhiTGtBTmsyZnF4MU1lM0tp?=
 =?utf-8?B?SkEyODZCanFYWHRyWlNsVmtLUzBlSlpRRlgrR0hTbENVbWQvNnY2bTFOb1Z0?=
 =?utf-8?B?bUZOUkZuUlBSVzY1NWppNlFuOUpjWG84MDhCbGxmS2dQSGFvT1A4NFF4L1Zl?=
 =?utf-8?B?bUZRL0dKOGxpVzhldHhrbXFwSXR1QStuWXVsZnhNbHNmN29wTkVnMTlXMFJ6?=
 =?utf-8?B?TGkwVXQ0S1M5Z2JKNmljRmxFeUFmVlJ2aUZNZzl3ckI2aURJb0h2Y2VmdlJo?=
 =?utf-8?B?WXc3aEhBSEpuTmVzZ2xSRE11WWt6L3lJM1FkRWRPb3pwNkx1ZHlNUG1Ja2dM?=
 =?utf-8?B?Z2xmWDZFR1N0T0RXeFVlMXoxRWt5Y0hFQXNhRDRmTVlIQ1k3eGtUWm90WmQ4?=
 =?utf-8?B?MDBjc2xRM0NKQWZhQ3lTcHhXSmRGYVJaM1drQ3pCMVBXMGVDeU1PaGtVT0dt?=
 =?utf-8?B?elVKZTBIN0RseDN6TUZ0MlZBODA4b0pRMElYelo3Wi9FTFN4OEJOU1VFVmJi?=
 =?utf-8?B?Z3dFVXl4WW0rRW1sYjNTNlFEUURWQ2ZTckd1a0tHdWJDL0Vpd2NyWU1kNExK?=
 =?utf-8?B?bkRaZnZVaXhMQU1tUFgyR1BiTHc4RDB3YXZMS0JaYkJicWUyU2NaSzZySVY2?=
 =?utf-8?B?TVlybkZzTEZyN3NsRkI0SW91bU1Ic0NCMGk2NFh2Zk9yTmVQSmZRQXMvZG9p?=
 =?utf-8?Q?1ftjTNze83HDLkMbHZu2uachE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf795705-2e3c-4c43-a5b2-08dbd6c086de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:44:18.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KgMMq8ComNhgllEF23zWdTumemrN6tpUusMjtMc6AARpbgnmGxvIG/Wv9s4JZd6Ctfot5GuOAdOLhiEPHpREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 03:14:10PM +0800, Shung-Hsi Yu wrote:
> On Thu, Oct 26, 2023 at 05:13:10PM +0200, Hao Sun wrote:
> > In check_stack_write_fixed_off(), imm value is cast to u32 before being
> > spilled to the stack. Therefore, the sign information is lost, and the
> > range information is incorrect when load from the stack again.
> > 
> > For the following prog:
> > 0: r2 = r10
> > 1: *(u64*)(r2 -40) = -44
> > 2: r0 = *(u64*)(r2 - 40)
> > 3: if r0 s<= 0xa goto +2
> > 4: r0 = 1
> > 5: exit
> > 6: r0  = 0
> > 7: exit
> > 
> > The verifier gives:
> > func#0 @0
> > 0: R1=ctx(off=0,imm=0) R10=fp0
> > 0: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
> > 1: (7a) *(u64 *)(r2 -40) = -44        ; R2_w=fp0 fp-40_w=4294967252
> > 2: (79) r0 = *(u64 *)(r2 -40)         ; R0_w=4294967252 R2_w=fp0
> > fp-40_w=4294967252
> > 3: (c5) if r0 s< 0xa goto pc+2
> > mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
> > mark_precise: frame0: regs=r0 stack= before 2: (79) r0 = *(u64 *)(r2 -40)
> > 3: R0_w=4294967252
> > 4: (b7) r0 = 1                        ; R0_w=1
> > 5: (95) exit
> > verification time 7971 usec
> > stack depth 40
> > processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > 
> > So remove the incorrect cast, since imm field is declared as s32, and
> > __mark_reg_known() takes u64, so imm would be correctly sign extended
> > by compiler.
> > 
> > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> 
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> The acked-by applies to future version of the patchset as well.

Oh and since this is a fix it would be great to have the fixes tag[1] to
specify when the bug was introduced

Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")

Add Cc tag for stable[2] so stable kernels pick up the fix as well

Cc: stable@vger.kernel.org

And ideally specify that the patch should be applied to the bpf tree rather
than bpf-next[3] (though the BPF maintainers has the final say on which tree
this patch should be applied).

I'd owe you a big thank as well since this helps with our internal process
at my company. So thank you in advance!

1: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
3: https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-the-changes-make-their-way-into-linux

> FWIW I think we'd also need the same treatment for the (BPF_ALU | BPF_MOV |
> BPF_K) case in check_alu_op().
> 
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 857d76694517..44af69ce1301 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >  		   insn->imm != 0 && env->bpf_capable) {
> >  		struct bpf_reg_state fake_reg = {};
> >  
> > -		__mark_reg_known(&fake_reg, (u32)insn->imm);
> > +		__mark_reg_known(&fake_reg, insn->imm);
> >  		fake_reg.type = SCALAR_VALUE;
> >  		save_register_state(state, spi, &fake_reg, size);
> >  	} else if (reg && is_spillable_regtype(reg->type)) {
> > 
> > -- 
> > 2.34.1
> > 
