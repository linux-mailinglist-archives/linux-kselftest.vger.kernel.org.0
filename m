Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E781B8DC2
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Apr 2020 10:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDZIEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Apr 2020 04:04:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:37112 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZIEi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Apr 2020 04:04:38 -0400
IronPort-SDR: Fo3FTXABWhGe2lrmIzl3FP18/tcA9WfMCfGl9VGWG0oFZ2JlO8A5EYqEfDoKb24vaIHSqO4IS9
 DLdLxVpX3m3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 01:04:37 -0700
IronPort-SDR: H3n2EkWkPA5gtJvj5niFn+Ok+eMk2mgvnsl6ZbbsyQxeRho7Cd0H4wsYYuAHW0xKvmgNEAXEdV
 WPzMyTQzJE6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,319,1583222400"; 
   d="scan'208";a="431357712"
Received: from ypeng2-mobl1.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga005.jf.intel.com with ESMTP; 26 Apr 2020 01:04:35 -0700
Subject: Re: bpf: test_sysctl run failed on Debian9
To:     Andrey Ignatov <rdna@fb.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Philip Li <philip.li@intel.com>, ast@kernel.org,
        daniel@iogearbox.net
References: <cc5c7dcb-02ab-3ea5-2330-7678abeb43b4@intel.com>
 <079fd1a6-fd66-e997-9c03-6529489aad54@intel.com>
 <20200423213158.GA37107@rdna-mbp>
From:   Ma Xinjian <max.xinjian@intel.com>
Message-ID: <677201be-41f4-445b-0198-56e03758bf18@intel.com>
Date:   Sun, 26 Apr 2020 16:04:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200423213158.GA37107@rdna-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/24/20 5:31 AM, Andrey Ignatov wrote:
> Ma Xinjian <max.xinjian@intel.com> [Thu, 2020-04-23 02:12 -0700]:
>> Hi,  Andrey.
>>
>> I noticed you add test_sysctl to tools/bpf, so drop this problem to you.
>>
>> When I run selftests: bpf: test_sysctl, failed with "(test_sysctl.c:1490:
>> errno: Permission denied) >>> Loading program (./test_sysctl_prog.o) error."
>>
>>
>> Testing env: "Debian GNU/Linux 9 (stretch)"
>>
>> kernel: 5.7.0-rc2    5.7.0-rc1  5.6  both failed
>>
>>
>> Whole run log and kconfig please see the attatchment.
>>
>> Error info
>>
>> ```
>>
>> root@vm-snb-42 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-ae83d0b416db002fe95601e7f97f64b59514d936/tools/testing/selftests/bpf#
>> ./test_sysctl
>>
>> Test case: sysctl wrong attach_type .. [PASS]
>> Test case: sysctl:read allow all .. [PASS]
>> Test case: sysctl:read deny all .. [PASS]
>>
>> [snip]
>>
>> libbpf: -- END LOG --
>> libbpf: failed to load program 'cgroup/sysctl'
>> libbpf: failed to load object './test_sysctl_prog.o'
>> (test_sysctl.c:1490: errno: Permission denied) >>> Loading program
>> (./test_sysctl_prog.o) error.
>>
>> Test case: C prog: read tcp_mem .. [FAIL]
>> Summary: 37 PASSED, 3 FAILED
> Hi Ma,
>
> I can not reproduce it. I built 5.7.0-rc2 with your config (with minor
> changes to just make it work with my qemu-setup, specifically
> CONFIG_EXT4_FS=y), built tests and run it, no failures:
>
> 	root@arch-fb-vm1:/home/rdna/bpf-next/tools/testing/selftests/bpf uname -srm
> 	Linux 5.7.0-rc2 x86_64
> 	root@arch-fb-vm1:/home/rdna/bpf-next/tools/testing/selftests/bpf ./test_sysctl
> 	...
> 	Test case: C prog: deny all writes .. [PASS]
> 	Test case: C prog: deny access by name .. [PASS]
> 	Test case: C prog: read tcp_mem .. [PASS]
> 	Summary: 40 PASSED, 0 FAILED
>
> Thouhg I see that test_sysctl_prog.o program I have differs from what
> you have. I attach test_sysctl_prog_xlated.gz with my program.
>
> Specifically the difference starts after the first call to bpf_strtoul.
>
> The code from my prog looks like this (from the first call to
> bpf_strtoul to the second call to bpf_strtoul):
>
> 	  71: (85) call bpf_strtoul#110448
> 	  72: (bc) w7 = w0
> 	; if (ret <= 0 || ret > MAX_ULONG_STR_LEN)
> 	  73: (bc) w1 = w7
> 	  74: (04) w1 += -1
> 	  75: (26) if w1 > 0xe goto pc-21
> 	; off += ret & MAX_ULONG_STR_LEN;
> 	  76: (54) w7 &= 15
> 	  77: (bf) r1 = r10
> 	  78: (07) r1 += -64
> 	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
> 	  79: (0f) r1 += r7
> 	; tcp_mem + i);
> 	  80: (bf) r4 = r10
> 	  81: (07) r4 += -80
> 	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
> 	  82: (b7) r2 = 15
> 	  83: (b7) r3 = 0
> 	  84: (85) call bpf_strtoul#110448
>
> It can be seen that r1 points to stack-64 + r7 that is known to be <15.
>
> This is basically `value + (ret & MAX_ULONG_STR_LEN)` from the C code.
>
> The code from your version of program looks like this:
>
> 	  70: (85) call bpf_strtoul#106
> 	last_idx 70 first_idx 63
> 	regs=4 stack=0 before 69: (b7) r3 = 0
> 	regs=4 stack=0 before 68: (b7) r2 = 15
> 	  71: (bc) w7 = w0
> 	; if (ret <= 0 || ret > MAX_ULONG_STR_LEN)
> 	  72: (bc) w1 = w7
> 	  73: (04) w1 += -1
> 	  74: (26) if w1 > 0xe goto pc+14
> 	 R0=inv(id=0) R1_w=inv(id=0,umax_value=14,var_off=(0x0; 0xf)) R6=inv0 R7_w=inv(id=0,smax_value=2147483647,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=00000000 fp-80=00000000 fp-88=mmmmmmmm
> 	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
> 	  75: (bc) w2 = w7
> 	  76: (67) r2 <<= 32
> 	  77: (77) r2 >>= 32
> 	  78: (bf) r1 = r10
> 	;
> 	  79: (07) r1 += -64
> 	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
> 	  80: (0f) r1 += r2
> 	last_idx 80 first_idx 71
> 	regs=4 stack=0 before 79: (07) r1 += -64
> 	regs=4 stack=0 before 78: (bf) r1 = r10
> 	regs=4 stack=0 before 77: (77) r2 >>= 32
> 	regs=4 stack=0 before 76: (67) r2 <<= 32
> 	regs=4 stack=0 before 75: (bc) w2 = w7
> 	regs=80 stack=0 before 74: (26) if w1 > 0xe goto pc+14
> 	regs=80 stack=0 before 73: (04) w1 += -1
> 	regs=80 stack=0 before 72: (bc) w1 = w7
> 	regs=80 stack=0 before 71: (bc) w7 = w0
> 	 R0_rw=invP(id=0) R6=inv0 R7=ctx(id=0,off=0,imm=0) R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=00000000 fp-80=00000000 fp-88=mmmmmmmm
> 	parent didn't have regs=1 stack=0 marks
> 	last_idx 70 first_idx 63
> 	regs=1 stack=0 before 70: (85) call bpf_strtoul#106
> 	; tcp_mem + i);
> 	  81: (bf) r4 = r10
> 	  82: (07) r4 += -80
> 	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
> 	  83: (b7) r2 = 15
> 	  84: (b7) r3 = 0
> 	  85: (85) call bpf_strtoul#106
> 	R1 unbounded indirect variable offset stack access
> 	processed 88 insns (limit 1000000) max_states_per_insn 0 total_states 7 peak_states 7 mark_read 6
>
> In this case r1 points to stack-64 + r2 and it seems to me that the
> state of r2 is the problem, but I don't undesrtand why.
>
> 32LSB of r2 seems to be known because:
> 	  71: (bc) w7 = w0
> 	  72: (bc) w1 = w7
> 	  73: (04) w1 += -1
> 	  74: (26) if w1 > 0xe goto pc+14
> 	  75: (bc) w2 = w7
>
> and 32MSB of r2 are cleared because:
> 	  76: (67) r2 <<= 32
> 	  77: (77) r2 >>= 32
>
> So it seems to me that r2 has to be known and in (0x0; 0xf) range.
>
> To summarize:
>
> * I see that your program differs what may mean you have different
>    environemnt where you build BPF proga (e.g. different clang/llvm
>    version), FWIW I have clang version 9.0.20190721 (though it's heavily
>    patched facebook version).

Hi, Andrey.

Thank you very much for your quick reply.

I have tried build with 9.0.* clang, but failed with

```

libbpf: failed to find BTF for extern 'CONFIG_BPF_SYSCALL': -2
Error: failed to open BPF object file: 0
Makefile:361: recipe for target 
'/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-8f3d9f354286745c751374f5f1fcafee6b3f3136/tools/testing/selftests/bpf/test_skeleton.skel.h' 
failed
```
This error was tracked in:
https://www.spinics.net/lists/netdev/msg646956.html

So I have rebuild with clang 10.0.0. Still the same error.

>
> * I'm not quite sure why verifier rejects your version of the program --
>    here we would need more eyes. I'm cc'ing Alexei and Daniel.
>
>
