Return-Path: <linux-kselftest+bounces-21731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ED19C2F56
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 20:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B281C20B61
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB319F127;
	Sat,  9 Nov 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bW+S6Maq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED011537C9;
	Sat,  9 Nov 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731180925; cv=none; b=aU5xZZ/vcaJyLgxifcurLJhbp3KwrAGMdC5hvGEv8dY2Enhy36FZS/yM949M7Wlqeyy6mGA/lb2HmAQkTd3kZ6whb6/mUoSmVUaH+4/KxIsNq2xFmMkWwt2zm1EjG6y5Cx5tsg/shlVykuMJki4GJy266hG7CYg/92bKcbCLjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731180925; c=relaxed/simple;
	bh=RzyOIa5uO/9Z4Esf27fE4VCb7817oqLZGv2jNjc3Il0=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=GVohpeRLFEgCMjmynvGDnqORb4cbRIsnofwMA+bVM3cKF1Lvsi3wdw6i0KYxK7GlqW3zCkpYWRR/sb+amVsaaravROEI4iXYoOD6EueoJOqLo98+yiapdd+fl2sCPTuBdXfRrQ+l554nk555yL1CApydcREofe0RLPuu+PZOwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bW+S6Maq; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731180910; bh=yqhfUJ3/dfhZv7c8wagZAZ6oyLkqp1Y0Z8WxK6uEpk4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=bW+S6MaqZuZu1nZd80plcYkjMN/Y0z3mckqupY0YLK7V2iz7WOqB0XZqfXMWsx+g/
	 DyCk1NI6U9R9ub9AWuSFcbxFSvV6JfUoC/lyXPSDBzsLaD4lm5Y3wBoHCUP4U5UGIN
	 eIXrduYCWyqSUUUO+ozDWVlonHeUiuUyjWH41SlQ=
Received: from smtpclient.apple ([2408:8207:18a1:fd20:75f7:4ab1:fc76:cbf3])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 8C4B3A57; Sun, 10 Nov 2024 03:35:04 +0800
X-QQ-mid: xmsmtpt1731180904t8up4sgn3
Message-ID: <tencent_2EF88DF37C4B82B2DA0B8E49B85C312E2108@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJ92jmdY2jgaF/Dia5ccEFwUtzYNeNRNnWUT7g8BXEToBO+g7PMZ
	 gd8SXFgRIOMDVib1kUgxYUnnidAMn4L3tWcmVJtGzSLSg7enLsAlE4j1LNQ2hRwQYOpjCmEz1ksJ
	 Etd8HtBLG5V/YdYB2Q2rUw9yZRkd3fFgPChUyajz2fsT7BbSA94bN3GC+PqdN5WQ0FFrpehnMFSa
	 gBIG+jxrUw01Ap/6qxy773WIJhPUXCMgoyrBgikwntuo+g/LpEHU0pGX/47gMeHJuFXxiFYbNe6P
	 WrkSXCH/hFjF5y3VSkE8xjDpL+5zm/C3UeDbW3CoRMgrye+3Cr4ph7bJqv7mUBBnIddUPPuvR7fF
	 wCpwBWbwwC3znj9Ko96Dy8aExJP/SpbYoBU0yPN83hJZTWPf9c3cp6TDwfPdlYha39N4m8yNiOhC
	 skZJthlPZqX1KxCtr86iM+pVgpt55Kq96Od7qRMm8yOY4QkY3lWUsaVlRPffnCPL12fL4szpCdWO
	 iJXlGx+anN6VQCP3sGiJpHJDpVHT5UrwwvUnxHWJYDwwtolr64JmxkWN6MNvb1ygYUIqvkfjW3St
	 Sa3wsb/VWvUPW7+SqkmH3FOfmfcd2QVmltWgpPYAeQssruJuWphxR0nDwJkIHnCgMuckgryXubKo
	 En9J8jPxlTxRfquPbVbuoWs82f2E3qtigBycGfBcf9tyiSzKSFUt/0kVOTlO5vc8YjsoLGLefBsd
	 g7BiXPkqRN6bKFAf9mrYNYNlrs5Ep4wT9/TAZV0qfiWE3sLhu1N3TmzNn2f/tydnlwIg42dfs5UB
	 ph8RoKxexZPVEmMSynMkEQlaShp6cXL8PwkG5XSxJ+TD1X7ctYDwzRt3wJRZME03ns6wsYiIO1GR
	 LI2vD2HZq79T/WptKJ8WpW1lexQvjbdmvOKON7Z8aCJRS0AJMajwQnRD8bwvI70I6uHGwPPDrQlp
	 FfLKUjcpbsAD6hLnxZW2jUKGcb89bNLdWn2cUqr//AAcPVFeQvUYoMWbaIWwmhnXmUWpUSpCfQjG
	 qp/z64gQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v10 05/14] riscv: vector: Use vlenb from DT for thead
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
Date: Sun, 10 Nov 2024 03:34:54 +0800
Cc: linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev,
 linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <9F32D251-63F5-42DA-99FA-B02B1C8A4900@cyyself.name>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>,
 Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Evan Green <evan@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: Apple Mail (2.3826.200.121)

Hi Charlie,

I have tested this patchset with ghostwrite rebased to linux commit =
da4373fbcf ("Merge tag 'thermal-6.12-rc7' of =
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") [1] on =
my D1 Nezha board, with defconfig + CONFIG_ERRATA_THEAD_GHOSTWRITE=3Dn, =
I got this message during boot:

[    0.027584] Kernel panic - not syncing: __kmem_cache_create_args: =
Failed to create slab 'riscv_vector_ctx'. Error -22
[    0.038057] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted =
6.12.0-rc6-00310-gb276cf69df24-dirty #11
[    0.047240] Hardware name: Allwinner D1 Nezha (DT)
[    0.052007] Call Trace:
[    0.054434] [<ffffffff80007172>] dump_backtrace+0x1c/0x24
[    0.059806] [<ffffffff809f6834>] show_stack+0x2c/0x38
[    0.064833] [<ffffffff80a040f0>] dump_stack_lvl+0x52/0x74
[    0.070206] [<ffffffff80a04126>] dump_stack+0x14/0x1c
[    0.075233] [<ffffffff809f6db6>] panic+0x10c/0x300
[    0.080000] [<ffffffff8017b5a0>] __kmem_cache_create_args+0x24a/0x2b6
[    0.086413] [<ffffffff80c04c68>] riscv_v_setup_ctx_cache+0x56/0x84
[    0.092566] [<ffffffff80c04288>] arch_task_cache_init+0x10/0x1c
[    0.098460] [<ffffffff80c07d02>] fork_init+0x68/0x1a8
[    0.103486] [<ffffffff80c00ed2>] start_kernel+0x77e/0x822
[    0.108870] ---[ end Kernel panic - not syncing: =
__kmem_cache_create_args: Failed to create slab 'riscv_vector_ctx'. =
Error -22 ]---

[1] https://github.com/cyyself/linux/tree/xtheadvector_20241110

On 9/12/24 13:55, Charlie Jenkins wrote:
>  diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 682b3feee451..9775d6a9c8ee 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
>  {
>  	unsigned long this_vsize;
>  -	/* There are 32 vector registers with vlenb length. */
> +	/*
> +	 * There are 32 vector registers with vlenb length.
> +	 *
> +	 * If the thead,vlenb property was provided by the firmware, use =
that
> +	 * instead of probing the CSRs.
> +	 */
> +	if (thead_vlenb_of) {
> +		this_vsize =3D thead_vlenb_of * 32;

Then, I patched here which replaces "this_vsize" with "riscv_v_vsize". =
The kernel boots normally and I can see =E2=80=9Cxtheadvector" in =
/proc/cpuinfo.

However, when I try to run the "v_exec_initval_nolibc" test, the kernel =
panics with these outputs:

[  978.788878] Oops - illegal instruction [#1]
[  978.788897] Modules linked in:
[  978.788908] CPU: 0 UID: 1000 PID: 461 Comm: v_exec_initval_ Not =
tainted 6.12.0-rc6-00310-gb276cf69df24-dirty #12
[  978.788924] Hardware name: Allwinner D1 Nezha (DT)
[  978.788929] epc : do_trap_ecall_u+0x56/0x20a
[  978.788956]  ra : _new_vmalloc_restore_context_a0+0xc2/0xce
[  978.788974] epc : ffffffff80a04afe ra : ffffffff80a0e742 sp : =
ffffffc6003fbeb0
[  978.788983]  gp : ffffffff81717080 tp : ffffffd60723b300 t0 : =
ffffffff81001268
[  978.788991]  t1 : ffffffff80a04aa8 t2 : ffffffff810012a8 s0 : =
ffffffc6003fbee0
[  978.789000]  s1 : ffffffc6003fbee0 a0 : ffffffc6003fbee0 a1 : =
000000000000005d
[  978.789007]  a2 : 0000000000000000 a3 : ffffffffffffffda a4 : =
0000000000000003
[  978.789015]  a5 : 0000000000000000 a6 : 0000000002adb5fe a7 : =
000000000000005d
[  978.789022]  s2 : 00000000000108a8 s3 : 0000000000000000 s4 : =
0000000000000008
[  978.789030]  s5 : 0000003fb42ab780 s6 : 0000002adb5fe420 s7 : =
0000002adb5fb9e0
[  978.789038]  s8 : 0000002adb5fe440 s9 : 0000002adb5fe420 s10: =
0000002adb572ad4
[  978.789046]  s11: 0000002adb572ad0 t3 : 0000003fb43c5e3c t4 : =
622f7273752f3d5f
[  978.789053]  t5 : 0000002adb5fd5a1 t6 : 0000000002adb5ff
[  978.789060] status: 8000000201800100 badaddr: 000000005e0fb057 cause: =
0000000000000002
[  978.789069] [<ffffffff80a04afe>] do_trap_ecall_u+0x56/0x20a
[  978.789086] [<ffffffff80a0e742>] =
_new_vmalloc_restore_context_a0+0xc2/0xce
[  978.789113] Code: a073 1007 006f 1a60 7057 0c30 57fd 17fe 77d7 0c30 =
(b057) 5e0f
[  978.789123] ---[ end trace 0000000000000000 ]---
[  978.789131] Kernel panic - not syncing: Fatal exception in interrupt
[  978.937158] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt ]---

Is something wrong with my setup?

Thanks,
Yangyu Chen

> +		return 0;
> +	}
> +
>  	riscv_v_enable();
>  	this_vsize =3D csr_read(CSR_VLENB) * 32;
>  	riscv_v_disable();
> diff --git a/arch/riscv/kernel/vendor_extensions/thead.c =
b/arch/riscv/kernel/vendor_extensions/thead.c
> index 0f27baf8d245..519dbf70710a 100644
> --- a/arch/riscv/kernel/vendor_extensions/thead.c
> +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> @@ -5,6 +5,7 @@
>  #include <asm/vendor_extensions/thead.h>
>    #include <linux/array_size.h>
> +#include <linux/cpumask.h>
>  #include <linux/types.h>
>    /* All T-Head vendor extensions supported in Linux */
> @@ -16,3 +17,13 @@ struct riscv_isa_vendor_ext_data_list =
riscv_isa_vendor_ext_list_thead =3D {
>  	.ext_data_count =3D ARRAY_SIZE(riscv_isa_vendor_ext_thead),
>  	.ext_data =3D riscv_isa_vendor_ext_thead,
>  };
> +
> +void disable_xtheadvector(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, =
riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu].isa);
> +
> +	clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, =
riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap.isa);
> +}


