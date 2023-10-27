Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBD7D9083
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 10:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjJ0IB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0IB5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 04:01:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1E111;
        Fri, 27 Oct 2023 01:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/hy8vMJs5px5acSLHd67iBg9byiQwk2a4a36XYJqkJQAosFLZCgleg2vBSw/IoledKZBbbZNLE66UWV6BMeB2SK7j8BX6KMCo4IXlqwyo5lCXELBHUOUEMZrgbZeJ+WC56NBJaWwZNrVQQZA4kX/ZY44jC1CwZ2FY/LO1HgQXOEmoME389rqUT6ZJTV4KwNCwmh+R9T6i5sGvjsFLxczu+9wSfxnOys2LrtPryVZVM0k51XI+tcwiNri4OYc8MdUUob/zslDoIB410UEePJrJALaUpE2Q4KHKZYPloIs0AovQ/PwuBR6rqLPbqdlbNEJNnYu5k4rO3juU+QheUK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6rMfTEXMY0XFp7wYldg/N2Nj3YSs9RWCXJjR7YlXfw=;
 b=P7XgDU1wzZXh9nD5XzWM1QIZQb52iSYHYKNzquEJ1u26d0jjFoJ3nyb0ji3nsdesaTXFid1lfBgEhz3towTSX6bCJizvH+MxpPiVoUQliweIBZXuLdZq2qAS8XXTce4iyDBfn6vmGEG256IjvVAkajTnAxL0RVKc9MBKi0aHmtk2G/VjvDOsuAQUG/2Kuci5mlEwDThRdApzYeg3dTJzvWmpOQQxn6eTj0r7dPCzmXLtZ2ISisFPq5QSmraVAfP0gxkc3UNv0ZyBrS0JQ5YZMEraXkmuQ4x8nSd3fz2aE8cenrcUqyG9i99j4eCu4yQCjR1tlWxFGAWeOsU5ooD+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6rMfTEXMY0XFp7wYldg/N2Nj3YSs9RWCXJjR7YlXfw=;
 b=kgCASnC+V2Lq1CdrnuZOih+Hx5Mtpeo48KQhhED8jMG5MJxHuW3P9a6y7hK9WgwW4WgTUt7H24eQOulWu0+nvg5VhVzjm2XYzr8vTWgmpve226BTDQzmAnyT9sxhCjFck4FDn1ZD0VcNgp0pDRaYTJJBz/g2enMcQidt9/xv8tV8OQP0mizbgDwR0L/Q71SgNSgMmDqCYk9/7cDmyQ6dRHyCL+OLSrTAzIb+1DT0tmdhGCMxeokG65FSLrTssiE1xacBhTwlo/MGoaOwMRJ8EmJBsiS4DvxDMLyAebQJZ1RGHXQLlM2dFCqOVgJKHqcMycBsX8SAEHXYdA6BKpwkHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB9127.eurprd04.prod.outlook.com (2603:10a6:20b:44a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 08:01:51 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 08:01:51 +0000
Date:   Fri, 27 Oct 2023 16:01:43 +0800
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
Message-ID: <ZTtuZ1dMAN9_63Xk@u94a>
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
 <20231026-fix-check-stack-write-v1-1-6b325ef3ce7e@gmail.com>
 <ZTtjQlqRQWCWwmHx@u94a>
 <ZTtqSnKmaQ4ma98g@u94a>
 <CACkBjsZM8pYj6Y7vazw_Rp3ZYDnpTiCSO0bNYdt36MxFEvqZZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsZM8pYj6Y7vazw_Rp3ZYDnpTiCSO0bNYdt36MxFEvqZZw@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 999a8ba8-1a51-4867-d04c-08dbd6c2fa09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DL1zSaH9WOI/fDSBsIgGAbHeu3WgPqCWKOd0HwJPTwdsX4Qe3RBnBKC8e9hO9sBT7o1UOHA/tH7V5SoEpoJpLK+oOr7gloDGHzB7/zyo4BfnIBBcViQPx3KJn32JH5sdAHQEvM9TI3W2lcA+giszchIzP5rj7LSjg5/oFAzKysz9jFlq5F7xr+OKdh0kAn4uNaAO1kHRZyD5BnmJC6tfJuyQd2i+U+8K75OOBpEnxy8tMN3rb6ea7mujGv4MyJF/0UvtbxuZKez2A5Nj1aWWnrLoIEuxC654/UrrDUn4uigyWvMe0uap8F1FH588zHqFxqkCctLOYOJRa9Jc1uNKP3yY5fFCzgbYZ3vQzAmu/FnHBbiTBAaXd45jRGDhiZgtgaxbA9ljhtathzpuwP4/yx8xElO4KwPch+u9d6z0I+G9/YFwDhIxwZQlsp5K7/EyaoWq/v08QPob5qUbpbz3HALVZcJzyUxkEINa5DNhGXXQ9kmzpuWZGwRHIL4D9lG42eIjRsDoHolr6W0G+DW7Fm3fWiW41IwRj0Ld6hIlmbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(53546011)(66899024)(6666004)(6506007)(33716001)(38100700002)(86362001)(83380400001)(9686003)(6512007)(26005)(7416002)(316002)(66946007)(54906003)(6916009)(66556008)(66476007)(41300700001)(5660300002)(6486002)(2906002)(966005)(478600001)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpMQkNkeENlemM5Y2dWVG14Q1J2MldVK09INXZDUTFEVzBUWC9mcytlSUo5?=
 =?utf-8?B?Z0tTRDFMRHVkTlo0dzRyNnRVRDZXQVloZHppdXUxWlJIVm9hc1JZWU1pUGxv?=
 =?utf-8?B?S2tJbm5rdVljZkhzWFI5Lzh2d3g5UTF0bDY5czdPS1dRc2drTTNsK3NOaXRD?=
 =?utf-8?B?ejMvOEpXbVFKWWVEZjNpby9HUHF4UnNvbmhlS2FoM0NVV1BBY0xiRlJxZndq?=
 =?utf-8?B?ZVh1ckhEdFFZTng3ejVnTHVuUUw4c2RrVjVhSXNNYTBpVFRVdzYydENCWWNC?=
 =?utf-8?B?OFdHWngrckd0R3BVaVg0RDh3WnZrU2FVd3hMNW1pZm9hSlFPSFZLSENFQk43?=
 =?utf-8?B?N2tyUnNxR1k5N05rRDN1aFZkYWRpN0pTNzQ1bkFLckx4WUMycXA0dkN5RFhF?=
 =?utf-8?B?aDJHVzk4RmRzYWkwcGNEcjlYY0p6ZXppQTgzNHhhYUwwTm84bi9UZFdiem9a?=
 =?utf-8?B?MnVVWk4yM0ZFRjJSWTJUQms4NnBweXdURGVxZklmL09Ea1J6MWpzdE8zNkdv?=
 =?utf-8?B?a3pCK1U4OU1kN0hpdlhmTTNTQ0l6YWFRazAyQ2VFVE40Z0pFK3hPMmZUb2Nq?=
 =?utf-8?B?NlQxajczeExVQTRqbjFOL3oxV1F3a1lwU1dKVHpxblZFMkRvd2l2cXFoVkh0?=
 =?utf-8?B?UWR6cWFuZFBkNFNlN1ZtbXQxM3RkcDNMQ1V0SWtZekVEbk9Obi9vbXVMM1BG?=
 =?utf-8?B?MnczZTlCSVZaNWJ0OXF1dlRxMlA4K1hUNnUyeUIzZk4vdlBPQ0xOUHV4SzhD?=
 =?utf-8?B?NTF4OEtsVHQ5TDFoUFRXNUg4UmpiWThmcmg3SFllY205WmdtcUx1VXRVUlhS?=
 =?utf-8?B?S3hrUlNrbi9PTWZVZi8rUm51V3REbHRRdDBCcHJVOGhVb0oyNFRvSys3ZTVK?=
 =?utf-8?B?QWZ1R2tOUS9FN1Jjamh1R1BGa0t6QTFqWVNKVk13WGJDMHdNU2hIYzN4QU5h?=
 =?utf-8?B?eHRQWThoRUg1SEprQXNJWVJJUStZSzBPMnBoVVNpVlNYbTgrT0pRS2dNWjBv?=
 =?utf-8?B?WVd0S2k5d3RZVUo0ME9Lcjh0S2RyWmNuTnZIdVViZlNWTnMyQXZ3OEZUditD?=
 =?utf-8?B?L3FZK0VGVkpLOGV5YVpidVlrV3NWdDI4UjNQbWFmWUxac0h5TDJINktxVmlS?=
 =?utf-8?B?QnZHTG5SYVZ2S0VBNjhMc3V5VktNcnNlUWFRb2hrb2hOdEljVlJNdUlBajMz?=
 =?utf-8?B?ZDBuMTh2SUdwaVY2WCtRZTMxcEtGd25QMEM2VnhZRXVwV1ZOTGNDSUZMOVpU?=
 =?utf-8?B?d2lsZHZMaG9kc01XV0pZc05XMHNCRUdiUkRPZ09TY3QrY1RDTlpodVU1NnQz?=
 =?utf-8?B?YVJLa2lnRDBhVUdRNHVpblE5VlFyRXpIbzZZRnBGV2ZFT2ZzUktMdjhGQWVL?=
 =?utf-8?B?eGJTcnVpWTN1Y0VJNDlWK0hGTnJBMmE2RVp1WWJreXJmcmlkdmhHTnJPRmxZ?=
 =?utf-8?B?blFNaHN0WGUxWE5OR1d3MGhWRmd3QVVnL3hrV3RuNmJNOVV4TC95QmpxWCtl?=
 =?utf-8?B?OFI2NDZlYVJTeG9lWkthUnY4SEpnMnNJOHFzaWtFbGtFVC9OOE1vY3pMT0VL?=
 =?utf-8?B?WTdrclRMY0dNNStVdFE5WDRxUTVrVkZxSkU3Q0ttaHR2RC9uUUxWMzd3WTRE?=
 =?utf-8?B?ck1aampJL2xuWjVsNUpESjI2dmdNczhVdTNicWVwYTJjZlB5UjV3MjhYMlBv?=
 =?utf-8?B?N0MwYmtVbGpQKzd4TEpEeXBPZ1NQR1E1YnEyaW5YcnBNRnJsUDM4SUd0a0Zr?=
 =?utf-8?B?b1lrQkRVdFpma1FMenU3OHI3TStsYTh3Y2E5U0V6dUJ5anlJenQ0MEhmUGdo?=
 =?utf-8?B?anZUWWJRMFBzWmRTdlA1OW1IZUVqbjg1K3pPU0pBbVFhVEIxSDFKRHAzeUkr?=
 =?utf-8?B?ZGRoSnJFRVFkRHpYM2YwRXNWL0grbVpOekwrMDNkS1Z6a1ZEYVA1OGdJUXBT?=
 =?utf-8?B?ckNWci9tWURSTnRiUXY0VWRxbUlKL1lUaC9rQnVsVmovZllqYkhuSmlNUGtu?=
 =?utf-8?B?V25rRmxaaVpjdHdxMlo3KzBiK29DK1BFNFcvcnpKKzVsWXhuK3hGbkhGMjNO?=
 =?utf-8?B?bWFBcjBZRTRXUldGSTdzWmhpYitIeUZuRUZHYWJIdWpZUXJaQ1RXZkpMOFh5?=
 =?utf-8?Q?w2ZALvX82j7skMq53nckT5moq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999a8ba8-1a51-4867-d04c-08dbd6c2fa09
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:01:51.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcBkzEm61QGACDgK6M14H2FhGHkaBAyNiUf5Rwqv5a8FU9C75OgwdwiBGo3WsT1ZD/4mDktO7MxTVrtJXZfASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 09:51:58AM +0200, Hao Sun wrote:
> On Fri, Oct 27, 2023 at 9:44 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 03:14:10PM +0800, Shung-Hsi Yu wrote:
> > > On Thu, Oct 26, 2023 at 05:13:10PM +0200, Hao Sun wrote:
> > > > In check_stack_write_fixed_off(), imm value is cast to u32 before being
> > > > spilled to the stack. Therefore, the sign information is lost, and the
> > > > range information is incorrect when load from the stack again.
> > > >
> > > > For the following prog:
> > > > 0: r2 = r10
> > > > 1: *(u64*)(r2 -40) = -44
> > > > 2: r0 = *(u64*)(r2 - 40)
> > > > 3: if r0 s<= 0xa goto +2
> > > > 4: r0 = 1
> > > > 5: exit
> > > > 6: r0  = 0
> > > > 7: exit
> > > >
> > > > The verifier gives:
> > > > func#0 @0
> > > > 0: R1=ctx(off=0,imm=0) R10=fp0
> > > > 0: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
> > > > 1: (7a) *(u64 *)(r2 -40) = -44        ; R2_w=fp0 fp-40_w=4294967252
> > > > 2: (79) r0 = *(u64 *)(r2 -40)         ; R0_w=4294967252 R2_w=fp0
> > > > fp-40_w=4294967252
> > > > 3: (c5) if r0 s< 0xa goto pc+2
> > > > mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
> > > > mark_precise: frame0: regs=r0 stack= before 2: (79) r0 = *(u64 *)(r2 -40)
> > > > 3: R0_w=4294967252
> > > > 4: (b7) r0 = 1                        ; R0_w=1
> > > > 5: (95) exit
> > > > verification time 7971 usec
> > > > stack depth 40
> > > > processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > > > peak_states 0 mark_read 0
> > > >
> > > > So remove the incorrect cast, since imm field is declared as s32, and
> > > > __mark_reg_known() takes u64, so imm would be correctly sign extended
> > > > by compiler.
> > > >
> > > > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > >
> > > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > >
> > > The acked-by applies to future version of the patchset as well.
> 
> (BPF_ALU | BPF_MOV | BPF_K) is handled correctly in the current
> code, i.e., no cast in BPF_ALU64 so that the sign is extended, and
> the cast in BPF_ALU correctly zero extend the reg.

My mistake, you're right. Thank you for the explanation.

> > Oh and since this is a fix it would be great to have the fixes tag[1] to
> > specify when the bug was introduced
> >
> > Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> Noted, thanks.
> 
> > Add Cc tag for stable[2] so stable kernels pick up the fix as well
> >
> > Cc: stable@vger.kernel.org
> >
> > And ideally specify that the patch should be applied to the bpf tree rather
> > than bpf-next[3] (though the BPF maintainers has the final say on which tree
> > this patch should be applied).
> >
> > I'd owe you a big thank as well since this helps with our internal process
> > at my company. So thank you in advance!
> >
> > 1: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > 3: https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-the-changes-make-their-way-into-linux
> >
> > > FWIW I think we'd also need the same treatment for the (BPF_ALU | BPF_MOV |
> > > BPF_K) case in check_alu_op().

^ This statement is incorrect as Hao has explained above.

> > > > ---
> > > >  kernel/bpf/verifier.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 857d76694517..44af69ce1301 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> > > >                insn->imm != 0 && env->bpf_capable) {
> > > >             struct bpf_reg_state fake_reg = {};
> > > >
> > > > -           __mark_reg_known(&fake_reg, (u32)insn->imm);
> > > > +           __mark_reg_known(&fake_reg, insn->imm);
> > > >             fake_reg.type = SCALAR_VALUE;
> > > >             save_register_state(state, spi, &fake_reg, size);
> > > >     } else if (reg && is_spillable_regtype(reg->type)) {
> > > >
> > > > --
> > > > 2.34.1
> > > >
