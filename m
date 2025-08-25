Return-Path: <linux-kselftest+bounces-39851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9529B344F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD18D5E1328
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001C2FCBF9;
	Mon, 25 Aug 2025 14:59:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E342FC008;
	Mon, 25 Aug 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133973; cv=none; b=Owq5M70uK831PGEs99iJhxBjgoT2Bq7tWYUGHqUkebghvtLfECbpK5JeeObItZ94RPOdJK/MuTAlXr4T2/wZJIKxIqm4Z5L58EbQLqPNagpOGBH0Ww3M2stnvjkBi4GWTBJZEdJojPQiIlOkQWWxW/nCgS246ljJdh7C8/J+IaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133973; c=relaxed/simple;
	bh=Ph3JfDSVa7q/qwjjJkCRoufp4rbUldY1HsHR/5oOvEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiuuKGxfyTNJkmgq6w8W5Nt+TQ01n4bnxomfh6Lv5UlVSDsy1t3knI8fEnigAnOgzyOH16bA0+uUTWhjORZjCyWsdHeFXt7M+PRhn/KZ+KfasDmXqedlAJIUlmclzFSpG7u0VmPwyRQaQkKTBpxyPE50GW0cCyqUNOfY0yW6oLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG (unknown [118.251.178.216])
	by APP-05 (Coremail) with SMTP id zQCowABX6lopeqxooi0eDw--.61332S2;
	Mon, 25 Aug 2025 22:58:51 +0800 (CST)
From: <pincheng.plct@isrc.iscas.ac.cn>
To: <inochiama@gmail.com>
Cc: <ajones@ventanamicro.com>,
	<alex@ghiti.fr>,
	<anup@brainfault.org>,
	<aou@eecs.berkeley.edu>,
	<charlie@rivosinc.com>,
	<cleger@rivosinc.com>,
	<conor+dt@kernel.org>,
	<cuiyunhui@bytedance.com>,
	<cyan.yang@sifive.com>,
	<devicetree@vger.kernel.org>,
	<jesse@rivosinc.com>,
	<krzk+dt@kernel.org>,
	<kvm-riscv@lists.infradead.org>,
	<kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>,
	<mikisabate@gmail.com>,
	<namcao@linutronix.de>,
	<palmer@dabbelt.com>,
	<parri.andrea@gmail.com>,
	<paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>,
	<pincheng.plct@isrc.iscas.ac.cn>,
	<robh@kernel.org>,
	<samuel.holland@sifive.com>,
	<shuah@kernel.org>,
	<thomas.weissschuh@linutronix.de>,
	<yikming2222@gmail.com>,
	<yongxuan.wang@sifive.com>
Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd extension descriptions
Date: Mon, 25 Aug 2025 22:58:49 +0800
Message-ID: <001e01dc15d0$c4842e10$4d8c8a30$@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwV0HURyytbkCJFT0CWNFw9272t/g==
Content-Language: zh-cn
X-CM-TRANSID:zQCowABX6lopeqxooi0eDw--.61332S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4Uur48KryUtFWxWFW8Crg_yoW5Kry8pa
	97GF4UGF98XryfW3s7Kw48uay5Ga1kGr1fCFsrt34xKFW5Ar10qFW2y3WYqw18Jr4IkF4j
	vr42gr1vq3sxArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREb4S5UUUUU==
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

> -----Original Message-----
> From: Inochi Amaoto <inochiama@gmail.com>
> Sent: Saturday, August 23, 2025 6:35 AM
> To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>;
> paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> alex@ghiti.fr; robh@kernel.org; krzk+dt@kernel.org; =
conor+dt@kernel.org;
> anup@brainfault.org; pbonzini@redhat.com; shuah@kernel.org;
> cyan.yang@sifive.com; cleger@rivosinc.com; charlie@rivosinc.com;
> cuiyunhui@bytedance.com; samuel.holland@sifive.com;
> namcao@linutronix.de; jesse@rivosinc.com; inochiama@gmail.com;
> yongxuan.wang@sifive.com; ajones@ventanamicro.com;
> parri.andrea@gmail.com; mikisabate@gmail.com; yikming2222@gmail.com;
> thomas.weissschuh@linutronix.de
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org; devicetree@vger.kernel.org; =
kvm@vger.kernel.org;
> kvm-riscv@lists.infradead.org; linux-kselftest@vger.kernel.org
> Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and =
Zclsd
> extension descriptions
>=20
> On Thu, Aug 21, 2025 at 10:01:27PM +0800, Pincheng Wang wrote:
> > Add descriptions for the Zilsd (Load/Store pair instructions) and
> > Zclsd (Compressed Load/Store pair instructions) ISA extensions which
> > were ratified in commit f88abf1 ("Integrating load/store pair for =
RV32
> > with the main manual") of the riscv-isa-manual.
> >
> > Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml | 39
> > +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > index ede6a58ccf53..d72ffe8f6fa7 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -366,6 +366,20 @@ properties:
> >              guarantee on LR/SC sequences, as ratified in commit
> b1d806605f87
> >              ("Updated to ratified state.") of the riscv profiles
> specification.
> >
> > +        - const: zilsd
> > +          description:
> > +            The standard Zilsd extension which provides support for
> aligned
> > +            register-pair load and store operations in 32-bit =
instruction
> > +            encodings, as ratified in commit f88abf1 ("Integrating
> > +            load/store pair for RV32 with the main manual") of
> riscv-isa-manual.
> > +
> > +        - const: zclsd
> > +          description:
> > +            The Zclsd extension implements the compressed (16-bit)
> version of the
> > +            Load/Store Pair for RV32. As with Zilsd, this extension =
was
> ratified
> > +            in commit f88abf1 ("Integrating load/store pair for =
RV32 with
> the
> > +            main manual") of riscv-isa-manual.
> > +
> >          - const: zk
> >            description:
> >              The standard Zk Standard Scalar cryptography extension =
as
> > ratified @@ -847,6 +861,16 @@ properties:
> >              anyOf:
> >                - const: v
> >                - const: zve32x
>=20
> > +      # Zclsd depends on Zilsd and Zca
> > +      - if:
> > +          contains:
> > +            anyOf:
> > +              - const: zclsd
> > +        then:
> > +          contains:
> > +            anyOf:
> > +              - const: zilsd
> > +              - const: zca
> >
>=20
> Should be allOf? I see the comment says "Zclsd" requires both "Zilsd"
> and "Zca".
>=20
> Regards,
> Inochi

You're absolutely right, thank you for catching this. Since Zclsd =
depends on both Zilsd and Zca, the condition should use allOf to =
correctly enforce the conjunction. I'll fix this in next revision.

Best regards,
Pincheng Wang


