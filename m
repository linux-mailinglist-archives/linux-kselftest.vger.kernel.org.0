Return-Path: <linux-kselftest+bounces-26563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD4A34AB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278AD18963A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E853365;
	Thu, 13 Feb 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H/g+Z0mS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12628A2C0;
	Thu, 13 Feb 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464936; cv=none; b=O3FMX8kyaqtk9TdzbXuhzafld07dug6h30hzfq9S4/IrEJ1z+NeqLLsPD8IqSo7BL7aLYuEfEE9RJA4Kppb6ZGx35YWNIvi4U7XwIfmFmWh6kHtnqHfpusokbyeDnIK5H+ZZ7fPeZGfCTuh4Y+ekXrBOai1LdZtbtKkeSocrqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464936; c=relaxed/simple;
	bh=GkO9HmjvOTJ0ZPDlsu+YTrBtFVic8WD0JxwiQXrnw0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXYgYjfmya26JGSYICchoIztlmPe7HOa+iWEJuce06UkDQJGRIdtbUxUc0VEpONzySprwnW6wSzpnT0BjKQuQmgUYytVwIYltjff34a3u/S12fewik/f+28Eiw8kh17L1h7S/SCRnBriDzeU2ltjpLz7vE0FT+c0Hajg3c0g990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H/g+Z0mS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=kJYJ4WQmevIeooYV/M12sRbQvWoP2EVopPPIaXE8IPQ=;
	b=H/g+Z0mSAYjIhcHr5Q3mUv3lnPYvlMEJhot30gjQA0Ycjc997U4W1AEnhG/hCD
	k7XRN6tt1IXQEw9Dusp5EVU/eLkbbfWKtBq5vysLE1NIk4DaQROV4oyaXx8XhGF7
	9iiFmTnFgVuIRZ0L0IEQiHCWuBiJKeV8j4/zP3x6RTff4=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAn2wauIK5nAC5IMA--.18613S2;
	Fri, 14 Feb 2025 00:41:21 +0800 (CST)
Date: Fri, 14 Feb 2025 00:41:18 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for may_goto
Message-ID: <tlpmq4lu7e26jz7q6ry4gfws7mebviff3k75hk7aqzwcqndjgp@7y6es4u4uha6>
References: <20250213131214.164982-1-mrpre@163.com>
 <20250213131214.164982-4-mrpre@163.com>
 <CAADnVQKRKD1hxZ+rXQk5Af2my8vK_2OvQ7x6Xn58edYVkOpDxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKRKD1hxZ+rXQk5Af2my8vK_2OvQ7x6Xn58edYVkOpDxA@mail.gmail.com>
X-CM-TRANSID:_____wAn2wauIK5nAC5IMA--.18613S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUuF4rCFW3Jr1rur13twb_yoW5CFy8pa
	s7WasakF1kX3W7K3WxXFsruFyrJan7Jr1rCr1Iqr1rCF1DKr97WF42kFy5Kr4Syr4kZw1a
	vFWIv3sxGw4kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiVysUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWwXyp2euGxvBbAAAsv

On Thu, Feb 13, 2025 at 08:04:05AM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 5:13 AM Jiayuan Chen <mrpre@163.com> wrote:
> >
> > Add test cases to ensure the maximum stack size can be properly limited to
> > 512.
> >
> > Test result:
> > echo "0" > /proc/sys/net/core/bpf_jit_enable
> > ./test_progs -t verifier_stack_ptr
> > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit:SKIP
> > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without jit:OK
> >
> > echo "1" > /proc/sys/net/core/bpf_jit_enable
> > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit:OK
> > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without jit:SKIP
> 
> echo '0|1' is not longer necessary ?
> The commit log seems obsolete?
> 
> pw-bot: cr

It looks like the problem only arises when CONFIG_BPF_JIT_ALWAYS_ON is
turned off, and we're only restricting the stack size when
prog->jit_requested is false. To test this, I simulated different
scenarios by echoing '0' or '1' to see how the program would behave when
jit_requested is enabled or disabled.

As expected, when I echoed '0', the program failed verification, and when
I echoed '1', it ran smoothly.

Thanks
> 
> > Signed-off-by: Jiayuan Chen <mrpre@163.com>
> > ---
> >  .../selftests/bpf/progs/verifier_stack_ptr.c  | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> > index 417c61cd4b19..8ffe5a01d140 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> > @@ -481,4 +481,54 @@ l1_%=:     r0 = 42;                                        \
> >         : __clobber_all);
> >  }
> >
> > +SEC("socket")
> > +__description("PTR_TO_STACK stack size > 512")
> > +__failure __msg("invalid write to stack R1 off=-520 size=8")
> > +__naked void stack_check_size_gt_512(void)
> > +{
> > +       asm volatile (
> > +       "r1 = r10;"
> > +       "r1 += -520;"
> > +       "r0 = 42;"
> > +       "*(u64*)(r1 + 0) = r0;"
> > +       "exit;"
> > +       ::: __clobber_all);
> > +}
> > +
> > +#ifdef __BPF_FEATURE_MAY_GOTO
> > +SEC("socket")
> > +__description("PTR_TO_STACK stack size 512 with may_goto with jit")
> > +__use_jit()
> > +__success __retval(42)
> > +__naked void stack_check_size_512_with_may_goto_jit(void)
> > +{
> > +       asm volatile (
> > +       "r1 = r10;"
> > +       "r1 += -512;"
> > +       "r0 = 42;"
> > +       "*(u32*)(r1 + 0) = r0;"
> > +       "may_goto l0_%=;"
> > +       "r2 = 100;"
> > +"l0_%=:        exit;"
> > +       ::: __clobber_all);
> > +}
> > +
> > +SEC("socket")
> > +__description("PTR_TO_STACK stack size 512 with may_goto without jit")
> > +__use_interp()
> > +__failure __msg("stack size 520(extra 8) is too large")
> > +__naked void stack_check_size_512_with_may_goto(void)
> > +{
> > +       asm volatile (
> > +       "r1 = r10;"
> > +       "r1 += -512;"
> > +       "r0 = 42;"
> > +       "*(u32*)(r1 + 0) = r0;"
> > +       "may_goto l0_%=;"
> > +       "r2 = 100;"
> > +"l0_%=:        exit;"
> > +       ::: __clobber_all);
> > +}
> > +#endif
> > +
> >  char _license[] SEC("license") = "GPL";
> > --
> > 2.47.1
> >


