Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F19500BE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiDNLQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbiDNLQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:16:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBE7E088;
        Thu, 14 Apr 2022 04:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A66E0B82929;
        Thu, 14 Apr 2022 11:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C6C385A1;
        Thu, 14 Apr 2022 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649934846;
        bh=ARnKmsLb/FeMb+3q8jlM7sCoXZOPbhPetPD+tJfanP4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L6oG0egpWFGlYtJdzaduqSGhHMP3oZpBH9XaKbeXQF0kYjqiEpuKaiREQMpSLdXer
         0+5ljY5UJITCrDJeG2xEIO01kUM+0a51j612tNf8QlmgTNS6Cyh825wtT7YP7kE2VV
         zCz6BFF+CoHr1jq3a1wVfL86txiEXuzdX+i9IfzuhC4jhpLXfbbC1srQo4qzcpEyPw
         RjHNjuifO2GA3aZpa2Zy3UzFk1BiaFtGDn6VaNuOeiQXJAiwnKNB/CxCMRRhAM0DDD
         RFRez74yF52RGF03Qnta5BxNW5rT1xGuDf3wHk8wvx2LLTN/KiUCvnmKv+Z/J1mKHO
         VtN0LxfXbQgbw==
Message-ID: <7a24b43f4d3d568ccd61117df4a3f6ec25ae1941.camel@kernel.org>
Subject: Re: [PATCH V4 11/31] x86/sgx: Keep record of SGX page type
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 14:12:57 +0300
In-Reply-To: <9978af37f51fa45c8878a3c05ceaf44f35806bb8.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <9978af37f51fa45c8878a3c05ceaf44f35806bb8.1649878359.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
> SGX2 functions are not allowed on all page types. For example,
> ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
> ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
> functions are attempted on another type of page the hardware would
> trigger a fault.
>=20
> Keep a record of the SGX page type so that there is more
> certainty whether an SGX2 instruction can succeed and faults
> can be treated as real failures.
>=20
> The page type is a property of struct sgx_encl_page
> and thus does not cover the VA page type. VA pages are maintained
> in separate structures and their type can be determined in
> a different way. The SGX2 instructions needing the page type do not
> operate on VA pages and this is thus not a scenario needing to
> be covered at this time.
>=20
> struct sgx_encl_page hosting this information is maintained for each
> enclave page so the space consumed by the struct is important.
> The existing sgx_encl_page->vm_max_prot_bits is already unsigned long
> while only using three bits. Transition to a bitfield for the two
> members to support the additional information without increasing
> the space consumed by the struct.
>=20
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Nit: reviewed-by overrides acked-by so you can remove acked-by and
keep reviewed-by.

> ---
> Changes since V3:
> - Add Jarkko's Reviewed-by tag.
>=20
> Changes since V2:
> - Update changelog to motivate transition to bitfield that
> =C2=A0 was previously done when (now removed) vm_run_prot_bits was
> =C2=A0 added.
>=20
> Changes since V1:
> - Add Acked-by from Jarkko.
>=20
> =C2=A0arch/x86/include/asm/sgx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0arch/x86/kernel/cpu/sgx/encl.h=C2=A0 | 3 ++-
> =C2=A0arch/x86/kernel/cpu/sgx/ioctl.c | 2 ++
> =C2=A03 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index d67810b50a81..eae20fa52b93 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -239,6 +239,9 @@ struct sgx_pageinfo {
> =C2=A0 * %SGX_PAGE_TYPE_REG:=C2=A0a regular page
> =C2=A0 * %SGX_PAGE_TYPE_VA:=C2=A0=C2=A0a VA page
> =C2=A0 * %SGX_PAGE_TYPE_TRIM:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0a page in trimmed state
> + *
> + * Make sure when making changes to this enum that its values can still =
fit
> + * in the bitfield within &struct sgx_encl_page
> =C2=A0 */
> =C2=A0enum sgx_page_type {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SGX_PAGE_TYPE_SECS,
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index 1b15d22f6757..07abfc70c8e3 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -27,7 +27,8 @@
> =C2=A0
> =C2=A0struct sgx_encl_page {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long desc;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long vm_max_prot_bits=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long vm_max_prot_bits=
:8;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum sgx_page_type type:16;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_epc_page *epc_=
page;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_encl *encl;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_va_page *va_pa=
ge;
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index a66795e0b685..21078c6643f7 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -107,6 +107,7 @@ static int sgx_encl_create(struct sgx_encl *encl, str=
uct sgx_secs *secs)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0set_bit(SGX_ENCL_DEBUG, &encl->flags);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->secs.encl =3D encl;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->secs.type =3D SGX_PAGE_T=
YPE_SECS;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->base =3D secs->base=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->size =3D secs->size=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->attributes =3D secs=
->attributes;
> @@ -344,6 +345,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, u=
nsigned long src,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->encl =3D encl;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->epc_page =3D e=
pc_page;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->type =3D (secinfo->=
flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->secs_child_cnt++;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & SGX_PAGE_MEAS=
URE) {

BR, Jarkko
