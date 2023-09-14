Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37A7A00E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjINJw7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbjINJw6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:52:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF708CCD;
        Thu, 14 Sep 2023 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694685174; x=1726221174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zsiz6QuHidta1MZIjKdX2IK5RrYiU1OXGZGUU7TjwBM=;
  b=UUAUK2MCMYTCIWfGqR91kF7hPczvS6zwvGys9kh9WxzFse1w6/nxcGNH
   m4H3I8XbYjL+4JkOVqurO8h9l30GBllpXC7Qf8txlARlwYY+6Vk0+Zu39
   /uH7SWstSRj89LWrnvh81tZyPtkp25CwgAxtqFJ0HyZYWFBRiait541Za
   lUER8RLJuIXmiHh92AUQWPLBqmSsob7QkJxL/4cSk3hQkZbwzo157Ys+I
   6hHNIOcADQlZlGNdFXKhEbL0nzW11R7YEeGQrqC0x50PuuopQaF+WCUra
   U74a3hntGjlRiO391fpg5YZYSHk+zfSP8IULJVoyc5Xz3k9Ty/uOUT8uM
   w==;
X-CSE-ConnectionGUID: jCeTh2jUTiuWpEOHIgZ08A==
X-CSE-MsgGUID: UY8Fpe7jT9qj55hJGpC4ZQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="asc'?scan'208";a="4801598"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 02:52:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 02:52:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 02:52:31 -0700
Date:   Thu, 14 Sep 2023 10:52:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Haibo Xu <haibo1.xu@intel.com>, <xiaobo55x@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <kvm-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20230914-reflector-preshow-786425ad7ae2@wendy>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-ee133dd5e804282ce28833d6@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QNGDKlO9qNzaNQl+"
Content-Disposition: inline
In-Reply-To: <20230914-ee133dd5e804282ce28833d6@orel>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--QNGDKlO9qNzaNQl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 11:36:01AM +0200, Andrew Jones wrote:
> > +static inline void cpu_relax(void)
> > +{
> > +#ifdef __riscv_zihintpause
> > +	asm volatile("pause" ::: "memory");
> > +#else
> > +	/* Encoding of the pause instruction */
> > +	asm volatile(".4byte 0x100000F" ::: "memory");
> > +#endif
> > +}
>=20
> cpu_relax() should go to include/riscv/processor.h

Can the one from asm/vdso/processor.h be reused, or are there special
considerations preventing that?

--QNGDKlO9qNzaNQl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQLXzgAKCRB4tDGHoIJi
0jRlAP0UeFru9d2hDB+V95CsBHvHieORe8d/jeHJTK7NMGIDgwD8Dqdge5VTTSyn
ljeYudKmUM0GDQOhOOq8DQG3G+sO5gM=
=uzJX
-----END PGP SIGNATURE-----

--QNGDKlO9qNzaNQl+--
