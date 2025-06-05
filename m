Return-Path: <linux-kselftest+bounces-34400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454BACF773
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72E5188AFCA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52027A102;
	Thu,  5 Jun 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Cni07byl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94220330;
	Thu,  5 Jun 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149229; cv=none; b=AyMTeB+0N+l0Wf3NrdpV6y073WS3VjpJaJ6MQzSGwyezr54m3WM+kwRBlB2fCR91Uu9EIEwIrTJEXC9WdjdBh1RYHT44eOeBezPFgirfA7FjaoZtIPgY77DnMXhWAoRqkyZFsQWFe+goTAnEuOKHs/claqZqPs76KDJawHmWtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149229; c=relaxed/simple;
	bh=fnxx2k4mdjwEbNfY0DSZkV4kipioOk34TMHhRZYO4NY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TzOTMxplMdTKJYXwMl0QbOQAzQJXwcRmvll5C6oWMWFYetT9yA/NBNlZKm56RBObU9U7fciKZLuwNofz7PgXxNEy8u5TPKeN7lj4+bAe4d+PSNLJtW3bt24P2Gjmk8z4GTLW1S2MxQCXfDpXM/nL+9BP6IDGZZSHvMaWeABJGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Cni07byl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 555Ikeve604253
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 5 Jun 2025 11:46:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 555Ikeve604253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749149201;
	bh=ummgK17N+T78IC1ngyES2l/GZWAHPP3RbwaZSXrfpPg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Cni07bylTd0mZM1nSuZsc0W1lRqVQRIayXiR9EdNLPN2cqTajrfiqa+vi8Q9cDR0E
	 eAoJep/LDkFmfWlSSdNZTyBG6+sAUIAG5XpDTjobqL9MKkJvNvc9iNqa7csOs9ZUSL
	 fw3epwvrek/127JOLhxRpL7E+O001K5A0FYlPcIvGn9a3ziZsJN3TsJ1yZnawkHu3K
	 //wkQqIfuvMIaT8PguTL4Z/oeEQPFV597aTvhbx9uQhADpNW4EQpSYlG0n+It819Lc
	 HQk1QB4cnif/MzqzgIE2Db5Dw2bpJZh/O+9fTgkNSa21PhYAWDt/0oeKK7Osrbo3Pq
	 yYopw7eN6kXKQ==
Date: Thu, 05 Jun 2025 11:46:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, shuah@kernel.org,
        andrew.cooper3@citrix.com, sohil.mehta@intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/2=5D_x86/fred/signal=3A_Pr?=
 =?US-ASCII?Q?event_single-step_upon_ERETU_completion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250605181020.590459-2-xin@zytor.com>
References: <20250605181020.590459-1-xin@zytor.com> <20250605181020.590459-2-xin@zytor.com>
Message-ID: <B6762FE6-87DD-4B2D-B177-A574044C1513@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 5, 2025 11:10:19 AM PDT, "Xin Li (Intel)" <xin@zytor=2Ecom> wrote:
>Clear the software event flag in the augmented SS to prevent infinite
>SIGTRAP handler loop if the trap flag (TF) is set without an external
>debugger attached=2E
>
>Following is a typical single-stepping flow for a user process:
>
>1) The user process is prepared for single-stepping by setting
>   RFLAGS=2ETF =3D 1=2E
>2) When any instruction in user space completes, a #DB is triggered=2E
>3) The kernel handles the #DB and returns to user space, invoking the
>   SIGTRAP handler with RFLAGS=2ETF =3D 0=2E
>4) After the SIGTRAP handler finishes, the user process performs a
>   sigreturn syscall, restoring the original state, including
>   RFLAGS=2ETF =3D 1=2E
>5) Goto step 2=2E
>
>According to the FRED specification:
>
>A) Bit 17 in the augmented SS is designated as the software event
>   flag, which is set to 1 for FRED event delivery of SYSCALL,
>   SYSENTER, or INT n=2E
>B) If bit 17 of the augmented SS is 1 and ERETU would result in
>   RFLAGS=2ETF =3D 1, a single-step trap will be pending upon completion
>   of ERETU=2E
>
>In step 4) above, the software event flag is set upon the sigreturn
>syscall, and its corresponding ERETU would restore RFLAGS=2ETF =3D 1=2E
>This combination causes a pending single-step trap upon completion of
>ERETU=2E  Therefore, another #DB is triggered before any user space
>instruction is executed, which leads to an infinite loop in which the
>SIGTRAP handler keeps being invoked on the same user space IP=2E
>
>Suggested-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>Cc: stable@vger=2Ekernel=2Eorg
>---
>
>Change in v3:
>*) Use "#ifdef CONFIG_X86_FRED" instead of IS_ENABLED(CONFIG_X86_FRED)
>   (Intel LKP)=2E
>
>Change in v2:
>*) Remove the check cpu_feature_enabled(X86_FEATURE_FRED), because
>   regs->fred_ss=2Eswevent will always be 0 otherwise (H=2E Peter Anvin)=
=2E
>---
> arch/x86/include/asm/sighandling=2Eh | 22 ++++++++++++++++++++++
> arch/x86/kernel/signal_32=2Ec        |  4 ++++
> arch/x86/kernel/signal_64=2Ec        |  4 ++++
> 3 files changed, 30 insertions(+)
>
>diff --git a/arch/x86/include/asm/sighandling=2Eh b/arch/x86/include/asm/=
sighandling=2Eh
>index e770c4fc47f4=2E=2Eb8481d33ba8e 100644
>--- a/arch/x86/include/asm/sighandling=2Eh
>+++ b/arch/x86/include/asm/sighandling=2Eh
>@@ -24,4 +24,26 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct p=
t_regs *regs);
> int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>=20
>+/*
>+ * To prevent infinite SIGTRAP handler loop if the trap flag (TF) is set
>+ * without an external debugger attached, clear the software event flag =
in
>+ * the augmented SS, ensuring no single-step trap is pending upon ERETU
>+ * completion=2E
>+ *
>+ * Note, this function should be called in sigreturn() before the origin=
al
>+ * state is restored to make sure the TF is read from the entry frame=2E
>+ */
>+static __always_inline void prevent_single_step_upon_eretu(struct pt_reg=
s *regs)
>+{
>+	/*
>+	 * If the trap flag (TF) is set, i=2Ee=2E, the sigreturn() SYSCALL inst=
ruction
>+	 * is being single-stepped, do not clear the software event flag in the
>+	 * augmented SS, thus a debugger won't skip over the following instruct=
ion=2E
>+	 */
>+#ifdef CONFIG_X86_FRED
>+	if (!(regs->flags & X86_EFLAGS_TF))
>+		regs->fred_ss=2Eswevent =3D 0;
>+#endif
>+}
>+
> #endif /* _ASM_X86_SIGHANDLING_H */
>diff --git a/arch/x86/kernel/signal_32=2Ec b/arch/x86/kernel/signal_32=2E=
c
>index 98123ff10506=2E=2E42bbc42bd350 100644
>--- a/arch/x86/kernel/signal_32=2Ec
>+++ b/arch/x86/kernel/signal_32=2Ec
>@@ -152,6 +152,8 @@ SYSCALL32_DEFINE0(sigreturn)
> 	struct sigframe_ia32 __user *frame =3D (struct sigframe_ia32 __user *)(=
regs->sp-8);
> 	sigset_t set;
>=20
>+	prevent_single_step_upon_eretu(regs);
>+
> 	if (!access_ok(frame, sizeof(*frame)))
> 		goto badframe;
> 	if (__get_user(set=2Esig[0], &frame->sc=2Eoldmask)
>@@ -175,6 +177,8 @@ SYSCALL32_DEFINE0(rt_sigreturn)
> 	struct rt_sigframe_ia32 __user *frame;
> 	sigset_t set;
>=20
>+	prevent_single_step_upon_eretu(regs);
>+
> 	frame =3D (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
>=20
> 	if (!access_ok(frame, sizeof(*frame)))
>diff --git a/arch/x86/kernel/signal_64=2Ec b/arch/x86/kernel/signal_64=2E=
c
>index ee9453891901=2E=2Ed483b585c6c6 100644
>--- a/arch/x86/kernel/signal_64=2Ec
>+++ b/arch/x86/kernel/signal_64=2Ec
>@@ -250,6 +250,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
> 	sigset_t set;
> 	unsigned long uc_flags;
>=20
>+	prevent_single_step_upon_eretu(regs);
>+
> 	frame =3D (struct rt_sigframe __user *)(regs->sp - sizeof(long));
> 	if (!access_ok(frame, sizeof(*frame)))
> 		goto badframe;
>@@ -366,6 +368,8 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
> 	sigset_t set;
> 	unsigned long uc_flags;
>=20
>+	prevent_single_step_upon_eretu(regs);
>+
> 	frame =3D (struct rt_sigframe_x32 __user *)(regs->sp - 8);
>=20
> 	if (!access_ok(frame, sizeof(*frame)))

Nitpick: "Prevent immediate repeat of single step trap on return from SIGT=
RAP handler"

