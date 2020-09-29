Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5D27DD1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Sep 2020 01:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgI2Xx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 19:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgI2XxX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 19:53:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98DCC0613D2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 16:53:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so59310ejb.12
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1rtshaSfQyMQT+kzX63bayjFTAmMlt0jI9IFlUPylY=;
        b=Reg+DZTyVyvCf3PKzlSNKgWpuXbvt3T6g81qJpZzJTaAOok0wMUXtAheoN8eBysMIb
         x4FfD41wAmIR6HazZQNbvU1nmTGhhF8kxvarhPEJYAZUAXdbWujfcDbpPiUzlGIYffT1
         f/5Ahus+rAZQT23f32gFg8WHnJrHsGNG6LTIicdrSoP5PqMhFeC+ydE+B9IfJ8qxgBKA
         yt1VVGKSE39oq01hPgGCO44yL4jY0xSiGU4VLymSDRKctb/rx6jxLepQA6q2em80/5CW
         DBpKlOGkFi1MuWpIhCIXxau0U3ekBXoERqWCHh9AvKGz9cGcfUtAQIHZG+W/R4GU37TB
         ky3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1rtshaSfQyMQT+kzX63bayjFTAmMlt0jI9IFlUPylY=;
        b=kGqsnQ+yRpxe7187ndw0HYx7t23YCym3LFXV8sSs+BDqzLcWr4rYRoKve4hZtKRk8N
         LgZpWF2Lz0h0kcIOtljzJwlmw9pkdL2fPR2MFc1p1DSkLkceryEUinBaIRqb21zjS4YT
         CoNch2OJS0Z/Z8DSVAx4GgH4iwkV12uH23N9FRixvs4abGfsnLMK8IwRVdEQyXb+P3jo
         hwOcXkTCI9ra0/p85et+09emDqYg5yOYIKBsrWANr9uALFQvkzyPcms+oFw+KKOky54c
         wDnSiJwBhhpEM9plzKgEkLBSxuGWerkrYfvzohkjTnOF7miXOoFDBr2ggHmp4XbxLHDV
         otkw==
X-Gm-Message-State: AOAM531iJodCbnBD/YOStRROmIjmr3J3nOGzjRFvOiBoYI14iSvedx4G
        tTcAvE4CqZCkhlfLTwnp5/eFhpEHSprqm0vB+mwSMA==
X-Google-Smtp-Source: ABdhPJwX1i8ss2VyW9+uCkdkh3uG4vD+jbxETbbqRBwCd0k3VuxCQE93UdhgF9pmN4t5dbOYxZ0ZecQJc7jg4A2uAxI=
X-Received: by 2002:a17:907:110f:: with SMTP id qu15mr82909ejb.359.1601423600125;
 Tue, 29 Sep 2020 16:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200916223512.2885524-5-haoluo@google.com> <202009170943.rYEs5XMN%lkp@intel.com>
 <CA+khW7iDK+g_W30doEtjse1BSHmB62GcrtmkH3pMk7shymw=XA@mail.gmail.com> <CAEf4BzbBQ6E_ARewNvrevFBsxoey=oK6irAObfHTzYD_UQnWSA@mail.gmail.com>
In-Reply-To: <CAEf4BzbBQ6E_ARewNvrevFBsxoey=oK6irAObfHTzYD_UQnWSA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Sep 2020 16:53:09 -0700
Message-ID: <CA+khW7jA+BCgXANxd=nqm8waaWcH1-K=trWu+OQaO-a+Q_k=dA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Introduce bpf_per_cpu_ptr()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kbuild-all@lists.01.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 21, 2020 at 11:11 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 17, 2020 at 12:14 PM Hao Luo <haoluo@google.com> wrote:
> >
> > I need to cast the pointer to "const void __percpu *" before passing
> > into per_cpu_ptr. I will update and resend.
>
> You can try just declaring it as __percpu in BPF_CALL_2 macro. That
> might work, or not, depending on how exactly BPF_CALL macros are
> implemented (I haven't checked).
>

ACK. IMO it's probably better cast inside, rather than depending on
BPF_CALL macros. The parameters are not true percpu pointers anyway
and potential changes on BPF_CALL may break this, I'm afraid.


> >
> > On Wed, Sep 16, 2020 at 6:14 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Hao,
> > >
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on bpf-next/master]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Hao-Luo/bpf-BTF-support-for-ksyms/20200917-064052
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > > config: powerpc-randconfig-s032-20200916 (attached as .config)
> > > compiler: powerpc64-linux-gcc (GCC) 9.3.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.2-201-g24bdaac6-dirty
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > sparse warnings: (new ones prefixed by >>)
> > >
> > > >> kernel/bpf/helpers.c:631:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void const * @@
> > > >> kernel/bpf/helpers.c:631:31: sparse:     expected void const [noderef] __percpu *__vpp_verify
> > > >> kernel/bpf/helpers.c:631:31: sparse:     got void const *
> > >
> > > # https://github.com/0day-ci/linux/commit/3f6ea3c1c73efe466a96ff7499219fe3b03b8f48
> > > git remote add linux-review https://github.com/0day-ci/linux
> > > git fetch --no-tags linux-review Hao-Luo/bpf-BTF-support-for-ksyms/20200917-064052
> > > git checkout 3f6ea3c1c73efe466a96ff7499219fe3b03b8f48
> > > vim +631 kernel/bpf/helpers.c
> > >
> > >    625
> > >    626  BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
> > >    627  {
> > >    628          if (cpu >= nr_cpu_ids)
> > >    629                  return (unsigned long)NULL;
> > >    630
> > >  > 631          return (unsigned long)per_cpu_ptr(ptr, cpu);
> > >    632  }
> > >    633
> > >    634  const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
> > >    635          .func           = bpf_per_cpu_ptr,
> > >    636          .gpl_only       = false,
> > >    637          .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL,
> > >    638          .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> > >    639          .arg2_type      = ARG_ANYTHING,
> > >    640  };
> > >    641
> > >  > 642  const struct bpf_func_proto bpf_get_current_task_proto __weak;
> > >    643  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> > >    644  const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
> > >    645  const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
> > >    646  const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
> > >    647
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
