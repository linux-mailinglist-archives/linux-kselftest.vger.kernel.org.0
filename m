Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7429C52BCE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiERNxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiERNxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 09:53:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC731C72E0;
        Wed, 18 May 2022 06:53:48 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3DvC4DgTz1JC8C;
        Wed, 18 May 2022 21:52:23 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 21:53:44 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Brown <broonie@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v5 0/6] bpf trampoline for arm64
Date:   Wed, 18 May 2022 09:16:32 -0400
Message-ID: <20220518131638.3401509-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add bpf trampoline support for arm64. Most of the logic is the same as
x86.

Tested on raspberry pi 4b and qemu with KASLR disabled (avoid long jump),
result:
 #9  /1     bpf_cookie/kprobe:OK
 #9  /2     bpf_cookie/multi_kprobe_link_api:FAIL
 #9  /3     bpf_cookie/multi_kprobe_attach_api:FAIL
 #9  /4     bpf_cookie/uprobe:OK
 #9  /5     bpf_cookie/tracepoint:OK
 #9  /6     bpf_cookie/perf_event:OK
 #9  /7     bpf_cookie/trampoline:OK
 #9  /8     bpf_cookie/lsm:OK
 #9         bpf_cookie:FAIL
 #18 /1     bpf_tcp_ca/dctcp:OK
 #18 /2     bpf_tcp_ca/cubic:OK
 #18 /3     bpf_tcp_ca/invalid_license:OK
 #18 /4     bpf_tcp_ca/dctcp_fallback:OK
 #18 /5     bpf_tcp_ca/rel_setsockopt:OK
 #18        bpf_tcp_ca:OK
 #51 /1     dummy_st_ops/dummy_st_ops_attach:OK
 #51 /2     dummy_st_ops/dummy_init_ret_value:OK
 #51 /3     dummy_st_ops/dummy_init_ptr_arg:OK
 #51 /4     dummy_st_ops/dummy_multiple_args:OK
 #51        dummy_st_ops:OK
 #55        fentry_fexit:OK
 #56        fentry_test:OK
 #57 /1     fexit_bpf2bpf/target_no_callees:OK
 #57 /2     fexit_bpf2bpf/target_yes_callees:OK
 #57 /3     fexit_bpf2bpf/func_replace:OK
 #57 /4     fexit_bpf2bpf/func_replace_verify:OK
 #57 /5     fexit_bpf2bpf/func_sockmap_update:OK
 #57 /6     fexit_bpf2bpf/func_replace_return_code:OK
 #57 /7     fexit_bpf2bpf/func_map_prog_compatibility:OK
 #57 /8     fexit_bpf2bpf/func_replace_multi:OK
 #57 /9     fexit_bpf2bpf/fmod_ret_freplace:OK
 #57        fexit_bpf2bpf:OK
 #58        fexit_sleep:OK
 #59        fexit_stress:OK
 #60        fexit_test:OK
 #67        get_func_args_test:OK
 #68        get_func_ip_test:OK
 #104       modify_return:OK
 #237       xdp_bpf2bpf:OK

bpf_cookie/multi_kprobe_link_api and bpf_cookie/multi_kprobe_attach_api
failed due to lack of multi_kprobe on arm64.

v5:
- As Alexei suggested, remove is_valid_bpf_tramp_flags()

v4: https://lore.kernel.org/bpf/20220517071838.3366093-1-xukuohai@huawei.com/
- Run the test cases on raspberry pi 4b
- Rebase and add cookie to trampoline
- As Steve suggested, move trace_direct_tramp() back to entry-ftrace.S to
  avoid messing up generic code with architecture specific code
- As Jakub suggested, merge patch 4 and patch 5 of v3 to provide full function
  in one patch
- As Mark suggested, add a comment for the use of aarch64_insn_patch_text_nosync()
- Do not generate trampoline for long jump to avoid triggering ftrace_bug
- Round stack size to multiples of 16B to avoid SPAlignmentFault
- Use callee saved register x20 to reduce the use of mov_i64
- Add missing BTI J instructions
- Trivial spelling and code style fixes

v3: https://lore.kernel.org/bpf/20220424154028.1698685-1-xukuohai@huawei.com/
- Append test results for bpf_tcp_ca, dummy_st_ops, fexit_bpf2bpf,
  xdp_bpf2bpf
- Support to poke bpf progs
- Fix return value of arch_prepare_bpf_trampoline() to the total number
  of bytes instead of number of instructions 
- Do not check whether CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled in
  arch_prepare_bpf_trampoline, since the trampoline may be hooked to a bpf
  prog
- Restrict bpf_arch_text_poke() to poke bpf text only, as kernel functions
  are poked by ftrace
- Rewrite trace_direct_tramp() in inline assembly in trace_selftest.c
  to avoid messing entry-ftrace.S
- isolate arch_ftrace_set_direct_caller() with macro
  CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS to avoid compile error
  when this macro is disabled
- Some trivial code sytle fixes

v2: https://lore.kernel.org/bpf/20220414162220.1985095-1-xukuohai@huawei.com/
- Add Song's ACK
- Change the multi-line comment in is_valid_bpf_tramp_flags() into net
  style (patch 3)
- Fix a deadloop issue in ftrace selftest (patch 2)
- Replace pt_regs->x0 with pt_regs->orig_x0 in patch 1 commit message 
- Replace "bpf trampoline" with "custom trampoline" in patch 1, as
  ftrace direct call is not only used by bpf trampoline.

v1: https://lore.kernel.org/bpf/20220413054959.1053668-1-xukuohai@huawei.com/

Xu Kuohai (6):
  arm64: ftrace: Add ftrace direct call support
  ftrace: Fix deadloop caused by direct call in ftrace selftest
  bpf: Remove is_valid_bpf_tramp_flags()
  bpf, arm64: Impelment bpf_arch_text_poke() for arm64
  bpf, arm64: bpf trampoline for arm64
  selftests/bpf: Fix trivial typo in fentry_fexit.c

 arch/arm64/Kconfig                            |   2 +
 arch/arm64/include/asm/ftrace.h               |  22 +
 arch/arm64/kernel/asm-offsets.c               |   1 +
 arch/arm64/kernel/entry-ftrace.S              |  28 +-
 arch/arm64/net/bpf_jit.h                      |   1 +
 arch/arm64/net/bpf_jit_comp.c                 | 523 +++++++++++++++++-
 arch/x86/net/bpf_jit_comp.c                   |  20 -
 kernel/bpf/bpf_struct_ops.c                   |   3 +
 kernel/bpf/trampoline.c                       |   3 +
 kernel/trace/trace_selftest.c                 |   2 +
 .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
 11 files changed, 570 insertions(+), 39 deletions(-)

-- 
2.30.2

