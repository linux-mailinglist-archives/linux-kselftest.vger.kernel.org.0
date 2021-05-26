Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD73921DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhEZVTR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 17:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233241AbhEZVTR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 17:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BFE8613D2;
        Wed, 26 May 2021 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622063865;
        bh=P8I/YSnIlGt0BecmLDEFgrVyKPCt/3KOKGdpFJImRSo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ECcljrMQj9CmfendnYYEjB9+3XmW9zg3xP7pHdHcDjBL3NOx+eUCJWyBQ/yYBKr70
         AgVdYkyi71Y+fMO3cFm2L66APQyx5r6ukepipimExoGtt01ffeVcoLt1piZfrX3/Sa
         iyCgIOlT4r/ZcSQw56+3jiudmZ8LDPp07js21fHPawoqRiAqSkyU+7Cnube4o2AvNx
         EnDiGGT2AKYIEjLMNFMeHv4VXl5tLxcPQIElqVTSkoq9hNDeXOVWUvouV/md++DDEI
         8cntPWjxC5rQ4meVrMmgZYVazWGDv/ubPJaW1bQUinwZkQ3uM7EUlk6zjdzCQC+5rD
         S6E3MklTGNXPQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3DD0B27C0054;
        Wed, 26 May 2021 17:17:41 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Wed, 26 May 2021 17:17:41 -0400
X-ME-Sender: <xms:7rquYO-SH0HOUnC7lfQAyQcvg4EoWe0eT38R8QpIK60YiNJWYPIxlQ>
    <xme:7rquYOtlvhaWHWWklDvvDuyRn2eE5P2udWZl8GI61Sgughl-6rxQi9BD8LteyFwUT
    WQhL59w1nN5CLPezGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:7rquYEDfpnTpA70BK5JKmBNvpV6ttbto7T06k_SD_O2DxWU5S6GlRQ>
    <xmx:7rquYGf6gysCpAiEDSESp2cBRFpY4HRBzW1yi7Y33v4qbFSI9eMckg>
    <xmx:7rquYDPsYX97FMY3XJi6vIznxRtrLy9CFs2UqJcgNfYl25LKzQkMSA>
    <xmx:9bquYBxzmBsprux5alvXTTLx0aJcn9Gd4CVArdJskl5WyfqUf7lL7YwmADBTeuTJ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4AC9D51C0060; Wed, 26 May 2021 17:17:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <6bc401e7-6e34-4fbc-8ce3-a99be7966528@www.fastmail.com>
In-Reply-To: <718755e9-065e-c427-8821-228cdf8dd581@amd.com>
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
 <a08f2575-af91-8b08-6286-be5ac80c67e5@kernel.org>
 <718755e9-065e-c427-8821-228cdf8dd581@amd.com>
Date:   Wed, 26 May 2021 14:17:13 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Babu Moger" <babu.moger@amd.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, dave.hansen@linux.intel.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, shuah@kernel.org,
        jroedel@suse.de, "Uros Bizjak" <ubizjak@gmail.com>,
        viro@zeniv.linux.org.uk, "Petteri Aimonen" <jpa@git.mail.kapsi.fi>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Fan Yang" <Fan_Yang@sjtu.edu.cn>, anshuman.khandual@arm.com,
        "Benjamin Thiel" <b.thiel@posteo.de>,
        "Juergen Gross" <jgross@suse.com>, keescook@chromium.org,
        "Sean Christopherson" <seanjc@google.com>, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>, 0x7f454c46@gmail.com,
        jhubbard@nvidia.com, sandipan@linux.ibm.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, suxingxing@loongson.cn,
        harish@linux.ibm.com, rong.a.chen@intel.com, linuxram@us.ibm.com,
        bauerman@linux.ibm.com, dave.kleikamp@oracle.com
Subject: Re: x86/fpu/xsave: protection key test failures
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On Wed, May 26, 2021, at 2:14 PM, Babu Moger wrote:
>=20
>=20
> On 5/25/21 7:36 PM, Andy Lutomirski wrote:
> > On 5/25/21 2:37 PM, Babu Moger wrote:
> >=20
> >> Investigation so far.
> >> 1. The test fails on AMD(Milan) systems. Test appears to pass on In=
tel
> >> systems. Tested on old Intel system available here.
> >=20
> > Ten cents says that you have discovered that AMD returns a synthesiz=
ed
> > value for XINUSE[PKRU] and that write_pkru() is buggy.
> >=20
> > Any volunteers to fix the if (!pk) case in write_pkru() and see if t=
he
> > problem goes away?  (Or at least to print something for the if (!pk)=

> > case and seee if it gets printed?)
>=20
> I inserted this patch to test this path.
>=20
>=20
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgt=
able.h
> index b1099f2d9800..a0bca917f864 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -151,6 +160,8 @@ static inline void write_pkru(u32 pkru)
>         fpregs_lock();
>         if (pk)
>                 pk->pkru =3D pkru;
> +       else
> +               printk_once("%s read_pkru 0x%x\n",__FUNCTION__, read_p=
kru());
>         __write_pkru(pkru);
>         fpregs_unlock();
>  }
>=20
>=20
> Yes. The pk value is sometimes NULL and the value in the pkru register=
 is
> 0 at that time. Here is the dmesg output.
>=20
> [    1.700889] write_pkru read_pkru 0x0
>=20

Sweet, maybe I get my hypothetical dime back!   Both bugs are real.

Dave and I (mostly Dave =E2=80=94 I=E2=80=99m supplying the snark) are w=
orking on an omnibus patch to fix this whole mess.

Thanks,
Andy
