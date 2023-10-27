Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD27D8F61
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 09:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjJ0HO3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HO2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 03:14:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6AD40;
        Fri, 27 Oct 2023 00:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hICSTo7jNMsGE+SaanM3xC9lCqAbdxmMJekh5KHC5+gR704/EiUB5DlUAw35VCGtDtMguhoDMyD//HQyO9Smti3AhL5+LQgId6kahDO2MegP7imIcfSq+gpx0Y0VoNJtzOWc1LedXM2a/oIZE/ujWdK4d0fGrHXp90oNltOWa8JE8tdQuLCmGs/NKK6NNHbcR+T/ixe9l6K0oaFfNU3a7+0mSabuKlIikBwD6IlSY7ezrJip79Dv3qQGF+8UBjtziq9v76YMavb01+h0bz1gUUqKeLVybnBlae/O4DoZmAsr1BCfVPHH3shQqMZpIzzvkCx/dJtBWFXRIrFnFpGn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9Db+43y38xWAC0XJGLnR0RRLbmc/igu04EO36lgYT8=;
 b=jml8MbQIkb7JGdaNeZsvtGTEBrL+GaYYLJz6Qk6Y8SWOv/824yZQvWMVusJPI0xA55rE7l8Oo6N0wNijm1N+1aIfGivfBunCBMcYbXpoqJwdkFqIxrhHLWUar9rYyHlpoWiIpgAxWXLi5DaCqAy6ua0VV18rCkPguP42J186N5OGw9R57Pa4Gg2dNzM/BAqJo4Ufv0WLvWfrud5qU6e/WXlfR1xa/iT5S68zA2ivt1GUA/oyhB4LNDW8vutQqLf8Fi49yNo//9hr7gWmpOdZ21gS0ioy9+12sTaQU/7S3d5BbYE7XgF8PWkdKWngTDl3qy5Xmo+YghwCbypTNL4jMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9Db+43y38xWAC0XJGLnR0RRLbmc/igu04EO36lgYT8=;
 b=0xDJGdeT6BxTLkjpnAuX7tlJGSnho0+8MvOvzIosVDWx/phXhWP7EpTSghq0qw+IcPcZdx4I6zTcCBTHGbAgnSEGM+G9ssVwHP5ZO6o/SU/BkeNROOeUt9ea5UiL1BS9d0J4JFrmY5ygMGAMWXRbO8hrHWYVH2l8KORKhcEQy5mQayqaZkpMXRMWfTv6Q2cFcD+t3IVm751DBAORciyKE8A7bGBRSqAq+IzmWEZ8e24vzupTA4JEiGAbOKQpFxtaSH5jZu20h286fuMEaJ9VFrWfSb7mz8yKcHWYa7E5+gWWByNfESPrQE82hfxpMOQZLds52BdxVFAka9eEphWzVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU0PR04MB9493.eurprd04.prod.outlook.com (2603:10a6:10:350::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 07:14:21 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 07:14:21 +0000
Date:   Fri, 27 Oct 2023 15:14:10 +0800
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
Message-ID: <ZTtjQlqRQWCWwmHx@u94a>
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
 <20231026-fix-check-stack-write-v1-1-6b325ef3ce7e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026-fix-check-stack-write-v1-1-6b325ef3ce7e@gmail.com>
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU0PR04MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f9c4f1-2098-4e52-5162-08dbd6bc57ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSnqQoYNSBRD9WYehCGCblBlEqhqARxZrhUl/E9h2JPEeZqOQvNs+VYGKTmQQ/XpEp6RnHUyyTsQA24iDCurTJHJvBuHaUzI+P7uUdvW/pvgNTxJuUrbH7AwUBeUMHJ2QYWtBZqK0minBKZItcl02MMyH9L0dCxksOJP7tIbIf2qd6kxvSbW63aO8pycUQvQG7Wl/VX7bZTf6NJJ6lYJWhNBWF0eTq0RWJWHc6e+C8spy9nvbLmlBp9ts+Yq4BckHY4lFPdOe7NeH+S2ZGybWmZGWCkk2OnbIK6LNOdpf4Kd5Aab9+Bjcg4l0F3MUZeB3/ODsMDFF7BDx10h1JzJLAXx21EjI1uKgl9gpsblJA9uthfkHbAduA1Tkg4p2i8DtGgcKdDQuzj2MqFtGqkdacLX43H3VMfZxCaCtVENML5UBgfanhJhJ0UFBAYNmXwZ71lgnfeLLPGyf7bdgQ5BltPNUvGk7V19KB/i6V3BzQUK1lSSzEYCPNrRa1ZPy/TDWpcIn2lFfsQ5A4unQBaPwnwAwitdBCxz/4j4cRKgGheBkC1oYY9hXCtHGG84FmEd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(5660300002)(66946007)(7416002)(2906002)(316002)(6916009)(8936002)(8676002)(4326008)(6506007)(54906003)(6486002)(478600001)(33716001)(6666004)(9686003)(66476007)(26005)(83380400001)(66556008)(38100700002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2pFS01QZkxZVkhhRWVva3VKSHNQV21Kbm1yc0lpejZjZS9xdTdnRG9DTVg2?=
 =?utf-8?B?Skg0bXJGYnlTbkt1R3VldFUzUUFzeE1NV1c2dFR2aFBva0d4Sm83NUtEbUtw?=
 =?utf-8?B?WGJPNCtrUytpTC9vODVyRXBHSlZiVVF4dXI5RE1YRmZudWs3TnI5NXRVei9K?=
 =?utf-8?B?UW1WT1JnajVpbGtrRjJodlRtZDhUTUovVzlSNTlNNCtMdHJ3VTkzL2FkazBS?=
 =?utf-8?B?NXhUUEE4ak1mNURSL0RoSTFaMkJjcVViM1ZDVnJjSGQ0NGpFWFI4Z2t1a2RH?=
 =?utf-8?B?V2pGcm41TGJSRFp5eFVCeTRsQ1BGRnROcUVJTzR0WlJQNisxTEtDNXhGRXZi?=
 =?utf-8?B?eGNBQk1ibEtJTjFwK2JXd3h6a0c0VlFwWDJsbUhDRXd2V0pKbjhveVdlVkRC?=
 =?utf-8?B?bkZVbVcvMXROZlN6QlpRWjdoc1hFR0ZZamY1YTRsZVloR0pZUlIzTzN5YkVB?=
 =?utf-8?B?d2lFMVltcnJhak9zMVF6cGhyTHg5Tm1XSzJHOTlHN0hEN1BHdmNMN3JSbHRS?=
 =?utf-8?B?VHZvNDg3dmdwNmlqemZudmlXcnkveHcvcXRVNEwxL0RmZW1wNzNkMi9IR2tP?=
 =?utf-8?B?ZVVDNnU2cHZpRjRGM2VWS3ZjdlpoSWNVY1JqTlJzT0VzVTcwblBELzVXRGMz?=
 =?utf-8?B?c2RZYUQ0djN6bWpOUmhxQVBVNkR4U1VheGdYVm9VN2ROTG93QWU1RUpHQmRh?=
 =?utf-8?B?UnNEN0VaTVZ4ZVJkMndxUG5zQlBBeEgxNldkYko5VWsvQVZsdWxlVHA2NkpR?=
 =?utf-8?B?dS9tMnFyYmdubm5QNnl1KzdmRk5qSmNpV3dyR3VmUVdEZ3dHaUhUdytqZEk4?=
 =?utf-8?B?RW5qUkRBakdWT05FYWRNc1ZXNUs0ZFRHNHYzYUY4Ym1mT3ZQbk5uMVpwMTh5?=
 =?utf-8?B?djU3cWZvK09uN3RvaG9aVStjenNFdUYzU3p2TU9LSHREcHJSMzJnRlQrdFNB?=
 =?utf-8?B?U1U0T3g5bGw3NVQ1RWllelIxNUhhalRjUTNiSzdVMnlsQUcwOTlSeFlYNzlp?=
 =?utf-8?B?aHRJNnArT2EvUm1pOThpekZsZnNuOTFhQ3Q3TmdlN1VDQ0I0WGNWNnVYdmV3?=
 =?utf-8?B?T1dmK1BXYTJRS3VSaUVCZ3UwSTRRN0xuMTNPakc0WUdaZ1FveWExK0gwbk83?=
 =?utf-8?B?ZUJLdmtJZkxOWWFnUTJqVkJucXBBNFhJQVUvQ0hmMjVELzBVRmlqL0NFdkdx?=
 =?utf-8?B?b0Qyc2VGeEpPYmFyR0kyZkN2ZEFiNGNVclZYWjdpUDlobE5WeTZVakFLczJr?=
 =?utf-8?B?aXdYT2hBSmRRMlFpayszMzdJVkpVWjk3Wk9oUlBTNHE3dHNWN3VNU3UraUZN?=
 =?utf-8?B?N0RPc0Vaamo0cUNycG5obTFVdnFMc2lWZ0FXcTUyaW5nZjZVS3grRGtXWGRR?=
 =?utf-8?B?d3BQaHdjRmxiWmZuU0tIVHo1dm4zL2V1bnlrVlo2b3o1bkNFQmtQQnRQcE5i?=
 =?utf-8?B?OXFFckt2QzdjdDEyVitnbHZtUW9tb1JHMTRHSEh2ZldOZXAwMXFYTzZ5eHJ2?=
 =?utf-8?B?aXV6NFF3V1RNTG9ERFhCUXlncFhPMmpwR1QxcUlMdDlxaWtXUkJlVUxmbnNT?=
 =?utf-8?B?cnlncDkyY2NMZlBDZlRFendQRDZwN0VXa0hwYXAzV0pKaXJVTXVrTVlRdXFp?=
 =?utf-8?B?L01Oc3R5TkgxdHRmMFkzNFMreE8xT2JNeWxUNjZqOEhadjRMdnpPck5DTEF0?=
 =?utf-8?B?WFQzVkl5UGRyRzlCVWZPNU9iSkxjTjBWN0JES1RZd1ZrbkZvY0ZranRrS2cz?=
 =?utf-8?B?SFZwQ1RrREpHMHd5Y3M4L1o2TmU3QXhPRG1qWVVZbHpDMU8yUkowNnpHNWJj?=
 =?utf-8?B?NG1OOGZVWCtsYzNWazJGQUFydkwzNEdmZzBUWm9EVHY0aGM4WE9ObnJRQzdC?=
 =?utf-8?B?eWVDWHdaS3FHMXBwQ3I5ZU1wMVN6dVlWVU5VQVhEZFFuWU9rM2NJQjdyT2Fq?=
 =?utf-8?B?MXgzSWNhNFZMeHRlM2JYU1RmaU5Fa08xeFYzcWtlWXBKTGh5RUd5MDRKZlVJ?=
 =?utf-8?B?MWVNc2lraU1ja2htNHEwaWdRZVcrNkNBeWJMTjBHU2lQSm5EODZWQlRoOXk4?=
 =?utf-8?B?a3NSb045Z3NHc21SU2l0aHphdERlTFAySCtmRVovS1RNS29IMC9oUWNwUEpT?=
 =?utf-8?Q?dwargCUkgTxDrvuxGT/6KNLzG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f9c4f1-2098-4e52-5162-08dbd6bc57ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:14:21.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5w6HomUJ8PXCcSWAR4112oK9y6I+WFXdQdwngbgYYKWDJGH8OtO5SPSEsbrOsSarYJiF7WQni0ZxbfV1NEgJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 26, 2023 at 05:13:10PM +0200, Hao Sun wrote:
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
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

The acked-by applies to future version of the patchset as well.

FWIW I think we'd also need the same treatment for the (BPF_ALU | BPF_MOV |
BPF_K) case in check_alu_op().

> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 857d76694517..44af69ce1301 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>  		   insn->imm != 0 && env->bpf_capable) {
>  		struct bpf_reg_state fake_reg = {};
>  
> -		__mark_reg_known(&fake_reg, (u32)insn->imm);
> +		__mark_reg_known(&fake_reg, insn->imm);
>  		fake_reg.type = SCALAR_VALUE;
>  		save_register_state(state, spi, &fake_reg, size);
>  	} else if (reg && is_spillable_regtype(reg->type)) {
> 
> -- 
> 2.34.1
> 
