Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9772500BF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiDNLVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiDNLVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B271007;
        Thu, 14 Apr 2022 04:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940A7615B5;
        Thu, 14 Apr 2022 11:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E6C385A9;
        Thu, 14 Apr 2022 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649935161;
        bh=uonZmGj6UwVaNb2sM+LihxzgT+rXNF6cANN7BJHZV9c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n1vqKXgwsn5BfVgyQom8fQVlCI6EwgTk2SCqLA/GpmsMRE2MYXYzErkvOwG4Ov9Gt
         VewI5yn8FToHtJjAdre9mIAgINYrNDDqF+bH6doF5sC7ymZ52x+G61mdmsBckpwd9l
         8P8LEAkzc1cAfLaxoJmodKwyibqjqlal8+/QEm8wNGo4P7CX5a8F5AGf7FrS+4/YRy
         TKb0PBNrBy3k0gtqRxlJAyRUPmYsVafwIXgU86L0m1pZVNzvitOb74jyJAB7qCJxkx
         gRhY2y7eUpsWWhMYrQLoTFQRiGFqpsWItQNm352aOn+U0H2SU/iJ+NYk3brEPHoW6C
         fseNGg2QcTCUg==
Message-ID: <bf2fcc93babdbf541fffc6cc5f5756f391773a75.camel@kernel.org>
Subject: Re: [PATCH V4 14/31] x86/sgx: Support VA page allocation without
 reclaiming
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 14:18:12 +0300
In-Reply-To: <0ab32196f5056b25c34fb89fcc4dc28a5d875d2e.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <0ab32196f5056b25c34fb89fcc4dc28a5d875d2e.1649878359.git.reinette.chatre@intel.com>
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
> struct sgx_encl should be protected with the mutex
> sgx_encl->lock. One exception is sgx_encl->page_cnt that
> is incremented (in sgx_encl_grow()) when an enclave page
> is added to the enclave. The reason the mutex is not held
> is to allow the reclaimer to be called directly if there are
> no EPC pages (in support of a new VA page) available at the time.
>=20
> Incrementing sgx_encl->page_cnt without sgc_encl->lock held
> is currently (before SGX2) safe from concurrent updates because
> all paths in which sgx_encl_grow() is called occur before
> enclave initialization and are protected with an atomic
> operation on SGX_ENCL_IOCTL.
>=20
> SGX2 includes support for dynamically adding pages after
> enclave initialization where the protection of SGX_ENCL_IOCTL
> is not available.
>=20
> Make direct reclaim of EPC pages optional when new VA pages
> are added to the enclave. Essentially the existing "reclaim"
> flag used when regular EPC pages are added to an enclave
> becomes available to the caller when used to allocate VA pages
> instead of always being "true".
>=20
> When adding pages without invoking the reclaimer it is possible
> to do so with sgx_encl->lock held, gaining its protection against
> concurrent updates to sgx_encl->page_cnt after enclave
> initialization.
>=20
> No functional change.
>=20
> Reported-by: Haitao Huang <haitao.huang@intel.com>
> Tested-by: Haitao Huang <haitao.huang@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Nit: I don't think tested-by is in the right patch here. Maybe
Haitao's tested-by should be moved into patch that actually adds
support for EAUG? Not something I would NAK this patch, just
wondering...

> ---
> Changes since V3:
> - New patch prompted by Haitao encountering the
> =C2=A0 WARN_ON_ONCE(encl->page_cnt % SGX_VA_SLOT_COUNT)
> =C2=A0 within sgx_encl_grow() during his SGX2 multi-threaded
> =C2=A0 unit tests.
>=20
> =C2=A0arch/x86/kernel/cpu/sgx/encl.c=C2=A0 | 6 ++++--
> =C2=A0arch/x86/kernel/cpu/sgx/encl.h=C2=A0 | 4 ++--
> =C2=A0arch/x86/kernel/cpu/sgx/ioctl.c | 8 ++++----
> =C2=A03 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 546423753e4c..92516aeca405 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -869,6 +869,8 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsi=
gned long addr)
> =C2=A0
> =C2=A0/**
> =C2=A0 * sgx_alloc_va_page() - Allocate a Version Array (VA) page
> + * @reclaim: Reclaim EPC pages directly if none available. Enclave
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex sho=
uld not be held if this is set.
> =C2=A0 *
> =C2=A0 * Allocate a free EPC page and convert it to a Version Array (VA) =
page.
> =C2=A0 *
> @@ -876,12 +878,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, un=
signed long addr)
> =C2=A0 *=C2=A0=C2=A0 a VA page,
> =C2=A0 *=C2=A0=C2=A0 -errno otherwise
> =C2=A0 */
> -struct sgx_epc_page *sgx_alloc_va_page(void)
> +struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_epc_page *epc_=
page;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0epc_page =3D sgx_alloc_epc_pag=
e(NULL, true);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0epc_page =3D sgx_alloc_epc_pag=
e(NULL, reclaim);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(epc_page))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ERR_CAST(epc_page);
> =C2=A0
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index 253ebdd1c5be..66adb8faec45 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -116,14 +116,14 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sg=
x_encl *encl,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u64 secinfo_flags);
> =C2=A0void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr=
);
> -struct sgx_epc_page *sgx_alloc_va_page(void);
> +struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
> =C2=A0unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
> =C2=A0void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int off=
set);
> =C2=A0bool sgx_va_page_full(struct sgx_va_page *va_page);
> =C2=A0void sgx_encl_free_epc_page(struct sgx_epc_page *page);
> =C2=A0struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned long addr);
> -struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
> =C2=A0void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_=
page);
> =C2=A0
> =C2=A0#endif /* _X86_ENCL_H */
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index bb8cdb2ad0d1..5d41aa204761 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -17,7 +17,7 @@
> =C2=A0#include "encl.h"
> =C2=A0#include "encls.h"
> =C2=A0
> -struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_va_page *va_pa=
ge =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *err;
> @@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (!va_page)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn ERR_PTR(-ENOMEM);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0va_page->epc_page =3D sgx_alloc_va_page();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0va_page->epc_page =3D sgx_alloc_va_page(reclaim);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(va_page->epc_page)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err=
 =3D ERR_CAST(va_page->epc_page);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfr=
ee(va_page);
> @@ -64,7 +64,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struc=
t sgx_secs *secs)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct file *backing;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0long ret;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_page =3D sgx_encl_grow(encl=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_page =3D sgx_encl_grow(encl=
, true);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(va_page))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(va_page);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (va_page)
> @@ -275,7 +275,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, u=
nsigned long src,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(epc_page);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_page =3D sgx_encl_grow(encl=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_page =3D sgx_encl_grow(encl=
, true);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(va_page)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR(va_page);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err_out_free;


BR, Jarkko
