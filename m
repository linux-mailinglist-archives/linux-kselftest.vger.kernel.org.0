Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38A500C22
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiDNL3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiDNL3J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:29:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503B3AA77;
        Thu, 14 Apr 2022 04:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B7F9B82929;
        Thu, 14 Apr 2022 11:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD16CC385A1;
        Thu, 14 Apr 2022 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649935601;
        bh=pAuDOG2g2ZvIZtiRsIpGyfeLDboUilru+2BThranzDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eQ9FLRa1vq+JEyrcOYZQc5T8gd5JBmvVx/1mC961yu1kPQ2FBPL1HnFtFeiWuVjjZ
         iPUOLpgE1bDhgH2jJ9SeDDKc6D5Ff3S1eDGSJdnO6QFnu/q94XOefRXwVpxtb56nLd
         YYCGeeeVpKihbzc42MdUisUSrBAqmJ1nX1InH/EJwbkW8ohc4nTIYFu3yiVVmLSAnF
         JpJQNjWQhXo4wqbB8ROqmBntERLhWzJp5yEf6fqiyeuns8EfiSDlMjMln2zzWNWzlK
         hhcsjk6EzwDVioHcVoI/JKjtdVAXi4YFiHGc6eF9zAP951OScF/7+ve5NBAi3lGG/s
         Ii6KKjTd68hag==
Message-ID: <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 14:25:32 +0300
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
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
> Now that the discussions surrounding the support for SGX2 is settling,
> the kselftest audience is added to the discussion for the first time
> to consider the testing of the new features.
>=20
> V3: https://lore.kernel.org/lkml/cover.1648847675.git.reinette.chatre@int=
el.com/
>=20
> Changes since V3 that directly impact user space:
> - SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()'s struct
> =C2=A0 sgx_enclave_restrict_permissions no longer provides entire secinfo=
,
> =C2=A0 just the new permissions in new "permissions" struct member. (Jark=
ko)
> - Rename SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl() to
> =C2=A0 SGX_IOC_ENCLAVE_MODIFY_TYPES. (Jarkko)
> - SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()'s struct sgx_enclave_modify_type
> =C2=A0 no longer provides entire secinfo, just the new page type in new
> =C2=A0 "page_type" struct member. (Jarkko)
>=20
> Details about changes since V3 that do not directly impact user space:
> - Add new patch to enable VA pages to be added without invoking reclaimer
> =C2=A0 directly if no EPC pages are available, failing instead. This enab=
les
> =C2=A0 VA pages to be added with enclave's mutex held. Fixes an issue
> =C2=A0 encountered by Haitao. More details in new patch "x86/sgx: Support=
 VA page
> =C2=A0 allocation without reclaiming".
> - While refactoring, change existing code to consistently use
> =C2=A0 IS_ALIGNED(). (Jarkko)
> - Many patches received a tag from Jarkko.
> - Many smaller changes, please refer to individual patches.
>=20
> V2: https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@int=
el.com/
>=20
> Changes since V2 that directly impact user space:
> - Maximum allowed permissions of dynamically added pages is RWX,
> =C2=A0 previously limited to RW. (Jarkko)
> =C2=A0 Dynamically added pages are initially created with architecturally
> =C2=A0 limited EPCM permissions of RW. mmap() and mprotect() of these pag=
es
> =C2=A0 with RWX permissions would no longer be blocked by SGX driver. PRO=
T_EXEC
> =C2=A0 on dynamically added pages will be possible after running ENCLU[EM=
ODPE]
> =C2=A0 from within the enclave with appropriate VMA permissions.
>=20
> - The kernel no longer attempts to track the EPCM runtime permissions. (J=
arkko)
> =C2=A0 Consequences are:
> =C2=A0 - Kernel does not modify PTEs to follow EPCM permissions. User spa=
ce
> =C2=A0=C2=A0=C2=A0 will receive #PF with SGX error code in cases where th=
e V2
> =C2=A0=C2=A0=C2=A0 implementation would have resulted in regular (non-SGX=
) page fault
> =C2=A0=C2=A0=C2=A0 error code.
> =C2=A0 - SGX_IOC_ENCLAVE_RELAX_PERMISSIONS is removed. This ioctl() was u=
sed
> =C2=A0=C2=A0=C2=A0 to clear PTEs after permissions were modified from wit=
hin the enclave
> =C2=A0=C2=A0=C2=A0 and ensure correct PTEs are installed. Since PTEs no l=
onger track
> =C2=A0=C2=A0=C2=A0 EPCM permissions the changes in EPCM permissions would=
 not impact PTEs.
> =C2=A0=C2=A0=C2=A0 As long as new permissions are within the maximum vett=
ed permissions
> =C2=A0=C2=A0=C2=A0 (vm_max_prot_bits) only ENCLU[EMODPE] from within encl=
ave is needed,
> =C2=A0=C2=A0=C2=A0 as accompanied by appropriate VMA permissions.
>=20
> - struct sgx_enclave_restrict_perm renamed to
> =C2=A0=C2=A0=C2=A0=C2=A0 sgx_enclave_restrict_permissions (Jarkko)
>=20
> - struct sgx_enclave_modt renamed to struct sgx_enclave_modify_type
> =C2=A0 to be consistent with the verbose naming of other SGX uapi structs=
.
>=20
> Details about changes since V2 that do not directly impact user space:
> - Kernel no longer tracks the runtime EPCM permissions with the aim of
> =C2=A0 installing accurate PTEs. (Jarkko)
> =C2=A0 - In support of this change the following patches were removed:
> =C2=A0=C2=A0=C2=A0 Documentation/x86: Document SGX permission details
> =C2=A0=C2=A0=C2=A0 x86/sgx: Support VMA permissions more relaxed than enc=
lave permissions
> =C2=A0=C2=A0=C2=A0 x86/sgx: Add pfn_mkwrite() handler for present PTEs
> =C2=A0=C2=A0=C2=A0 x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynam=
ic permission changes
> =C2=A0=C2=A0=C2=A0 x86/sgx: Support relaxing of enclave page permissions
> =C2=A0 - No more handling of scenarios where VMA permissions may be more
> =C2=A0=C2=A0=C2=A0 relaxed than what the EPCM allows. Enclaves are not pr=
evented
> =C2=A0=C2=A0=C2=A0 from accessing such pages and the EPCM permissions are=
 entrusted
> =C2=A0=C2=A0=C2=A0 to control access as supported by the SGX error code i=
n page faults.
> =C2=A0 - No more explicit setting of protection bits in page fault handle=
r.
> =C2=A0=C2=A0=C2=A0 Protection bits are inherited from VMA similar to SGX1=
 support.
>=20
> - Selftest patches are moved to the end of the series. (Jarkko)
>=20
> - New patch contributed by Jarkko to avoid duplicated code:
> =C2=A0=C2=A0 x86/sgx: Export sgx_encl_page_alloc()
>=20
> - New patch separating changes from existing patch. (Jarkko)
> =C2=A0=C2=A0 x86/sgx: Export sgx_encl_{grow,shrink}()
>=20
> - New patch to keep one required benefit from the (now removed) kernel
> =C2=A0 EPCM permission tracking:
> =C2=A0=C2=A0 x86/sgx: Support loading enclave page without VMA permission=
s check
>=20
> - Updated cover letter to reflect architecture changes.
>=20
> - Many smaller changes, please refer to individual patches.
>=20
> V1: https://lore.kernel.org/linux-sgx/cover.1638381245.git.reinette.chatr=
e@intel.com/
>=20
> Changes since V1 that directly impact user space:
> - SGX2 permission changes changed from a single ioctl() named
> =C2=A0 SGX_IOC_PAGE_MODP to two new ioctl()s:
> =C2=A0 SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
> =C2=A0 SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, supported by two different
> =C2=A0 parameter structures (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS does
> =C2=A0 not support a result output parameter) (Jarkko).
>=20
> =C2=A0 User space flow impact: After user space runs ENCLU[EMODPE] it
> =C2=A0 needs to call SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to have PTEs
> =C2=A0 updated. Previously running SGX_IOC_PAGE_MODP in this scenario
> =C2=A0 resulted in EPCM.PR being set but calling
> =C2=A0 SGX_IOC_ENCLAVE_RELAX_PERMISSIONS will not result in EPCM.PR
> =C2=A0 being set anymore and thus no need for an additional
> =C2=A0 ENCLU[EACCEPT].
>=20
> - SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
> =C2=A0 SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> =C2=A0 obtain new permissions from secinfo as parameter instead of
> =C2=A0 the permissions directly (Jarkko).
>=20
> - ioctl() supporting SGX2 page type change is renamed from
> =C2=A0 SGX_IOC_PAGE_MODT to SGX_IOC_ENCLAVE_MODIFY_TYPE (Jarkko).
>=20
> - SGX_IOC_ENCLAVE_MODIFY_TYPE obtains new page type from secinfo
> =C2=A0 as parameter instead of the page type directly (Jarkko).
>=20
> - ioctl() supporting SGX2 page removal is renamed from
> =C2=A0 SGX_IOC_PAGE_REMOVE to SGX_IOC_ENCLAVE_REMOVE_PAGES (Jarkko).
>=20
> - All ioctl() parameter structures have been renamed as a result of the
> =C2=A0 ioctl() renaming:
> =C2=A0 SGX_IOC_ENCLAVE_RELAX_PERMISSIONS =3D> struct sgx_enclave_relax_pe=
rm
> =C2=A0 SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS =3D> struct sgx_enclave_restr=
ict_perm
> =C2=A0 SGX_IOC_ENCLAVE_MODIFY_TYPE =3D> struct sgx_enclave_modt
> =C2=A0 SGX_IOC_ENCLAVE_REMOVE_PAGES =3D> struct sgx_enclave_remove_pages
>=20
> Changes since V1 that do not directly impact user space:
> - Number of patches in series increased from 25 to 32 primarily because
> =C2=A0 of splitting the original submission:
> =C2=A0 - Wrappers for the new SGX2 functions are introduced in three sepa=
rate
> =C2=A0=C2=A0=C2=A0 patches replacing the original "x86/sgx: Add wrappers =
for SGX2
> =C2=A0=C2=A0=C2=A0 functions"
> =C2=A0=C2=A0=C2=A0 (Jarkko).
> =C2=A0 - Moving and renaming sgx_encl_ewb_cpumask() is done with two patc=
hes
> =C2=A0=C2=A0=C2=A0 replacing the original "x86/sgx: Use more generic name=
 for enclave
> =C2=A0=C2=A0=C2=A0 cpumask function" (Jarkko).
> =C2=A0 - Support for SGX2 EPCM permission changes is split into two ioctl=
s(),
> =C2=A0=C2=A0=C2=A0 one for relaxing and one for restricting permissions, =
each introduced
> =C2=A0=C2=A0=C2=A0 by a new patch replacing the original "x86/sgx: Suppor=
t enclave page
> =C2=A0=C2=A0=C2=A0 permission changes" (Jarkko).
> =C2=A0 - Extracted code used by existing ioctls() for usage by new ioctl(=
)s
> =C2=A0=C2=A0=C2=A0 into a new utility in new patch "x86/sgx: Create utili=
ty to validate
> =C2=A0=C2=A0=C2=A0 user provided offset and length" (Dave did not specifi=
cally ask for
> =C2=A0=C2=A0=C2=A0 this but it addresses his review feedback).
> =C2=A0 - Two new Documentation patches to support the SGX2 work
> =C2=A0=C2=A0=C2=A0 ("Documentation/x86: Introduce enclave runtime managem=
ent") and
> =C2=A0=C2=A0=C2=A0 a dedicated section on the enclave permission manageme=
nt
> =C2=A0=C2=A0=C2=A0 ("Documentation/x86: Document SGX permission details")=
 (Andy).
> - Most patches were reworked to improve the language by:
> =C2=A0 * aiming to refer to exact item instead of English rephrasing (Jar=
kko).
> =C2=A0 * use ioctl() instead of ioctl throughout (Dave).
> =C2=A0 * Use "relaxed" instead of "exceed" when referring to permissions
> =C2=A0=C2=A0=C2=A0 (Dave).
> - Improved documentation with several additions to
> =C2=A0 Documentation/x86/sgx.rst.
> - Many smaller changes, please refer to individual patches.
>=20
> Hi Everybody,
>=20
> The current Linux kernel support for SGX includes support for SGX1 that
> requires that an enclave be created with properties that accommodate all
> usages over its (the enclave's) lifetime. This includes properties such
> as permissions of enclave pages, the number of enclave pages, and the
> number of threads supported by the enclave.
>=20
> Consequences of this requirement to have the enclave be created to
> accommodate all usages include:
> * pages needing to support relocated code are required to have RWX
> =C2=A0 permissions for their entire lifetime,
> * an enclave needs to be created with the maximum stack and heap
> =C2=A0 projected to be needed during the enclave's entire lifetime which
> =C2=A0 can be longer than the processes running within it,
> * an enclave needs to be created with support for the maximum number
> =C2=A0 of threads projected to run in the enclave.
>=20
> Since SGX1 a few more functions were introduced, collectively called
> SGX2, that support modifications to an initialized enclave. Hardware
> supporting these functions are already available as listed on
> https://github.com/ayeks/SGX-hardware
>=20
> This series adds support for SGX2, also referred to as Enclave Dynamic
> Memory Management (EDMM). This includes:
>=20
> * Support modifying EPCM permissions of regular enclave pages belonging
> =C2=A0 to an initialized enclave. Only permission restriction is supporte=
d
> =C2=A0 via a new ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS. Relaxing o=
f
> =C2=A0 EPCM permissions can only be done from within the enclave with the
> =C2=A0 SGX instruction ENCLU[EMODPE].
>=20
> * Support dynamic addition of regular enclave pages to an initialized
> =C2=A0 enclave. At creation new pages are architecturally limited to RW E=
PCM
> =C2=A0 permissions but will be accessible with PROT_EXEC after the enclav=
e
> =C2=A0 runs ENCLU[EMODPE] to relax EPCM permissions to RWX.
> =C2=A0 Pages are dynamically added to an initialized enclave from the SGX
> =C2=A0 page fault handler.
>=20
> * Support expanding an initialized enclave to accommodate more threads.
> =C2=A0 More threads can be accommodated by an enclave with the addition o=
f
> =C2=A0 Thread Control Structure (TCS) pages that is done by changing the
> =C2=A0 type of regular enclave pages to TCS pages using a new ioctl()
> =C2=A0 SGX_IOC_ENCLAVE_MODIFY_TYPES.
>=20
> * Support removing regular and TCS pages from an initialized enclave.
> =C2=A0 Removing pages is accomplished in two stages as supported by two n=
ew
> =C2=A0 ioctl()s SGX_IOC_ENCLAVE_MODIFY_TYPES (same ioctl() as mentioned i=
n
> =C2=A0 previous bullet) and SGX_IOC_ENCLAVE_REMOVE_PAGES.
>=20
> * Tests covering all the new flows, some edge cases, and one
> =C2=A0 comprehensive stress scenario.
>=20
> No additional work is needed to support SGX2 in a virtualized
> environment. All tests included in this series passed when run from
> a guest as tested with the recent QEMU release based on 6.2.0
> that supports SGX.
>=20
> Patches 1 through 14 prepare the existing code for SGX2 support by
> introducing the SGX2 functions, refactoring code, and tracking enclave
> page types.
>=20
> Patches 15 through 21 enable the SGX2 features and include a
> Documentation patch.
>=20
> Patches 22 through 31 test several scenarios of all the enabled
> SGX2 features.
>=20
> This series is based on v5.18-rc2.
>=20
> Your feedback will be greatly appreciated.
>=20
> Regards,
>=20
> Reinette
>=20
> Jarkko Sakkinen (1):
> =C2=A0 x86/sgx: Export sgx_encl_page_alloc()
>=20
> Reinette Chatre (30):
> =C2=A0 x86/sgx: Add short descriptions to ENCLS wrappers
> =C2=A0 x86/sgx: Add wrapper for SGX2 EMODPR function
> =C2=A0 x86/sgx: Add wrapper for SGX2 EMODT function
> =C2=A0 x86/sgx: Add wrapper for SGX2 EAUG function
> =C2=A0 x86/sgx: Support loading enclave page without VMA permissions chec=
k
> =C2=A0 x86/sgx: Export sgx_encl_ewb_cpumask()
> =C2=A0 x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
> =C2=A0 x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
> =C2=A0 x86/sgx: Make sgx_ipi_cb() available internally
> =C2=A0 x86/sgx: Create utility to validate user provided offset and lengt=
h
> =C2=A0 x86/sgx: Keep record of SGX page type
> =C2=A0 x86/sgx: Export sgx_encl_{grow,shrink}()
> =C2=A0 x86/sgx: Support VA page allocation without reclaiming
> =C2=A0 x86/sgx: Support restricting of enclave page permissions
> =C2=A0 x86/sgx: Support adding of pages to an initialized enclave
> =C2=A0 x86/sgx: Tighten accessible memory range after enclave initializat=
ion
> =C2=A0 x86/sgx: Support modifying SGX page type
> =C2=A0 x86/sgx: Support complete page removal
> =C2=A0 x86/sgx: Free up EPC pages directly to support large page ranges
> =C2=A0 Documentation/x86: Introduce enclave runtime management section
> =C2=A0 selftests/sgx: Add test for EPCM permission changes
> =C2=A0 selftests/sgx: Add test for TCS page permission changes
> =C2=A0 selftests/sgx: Test two different SGX2 EAUG flows
> =C2=A0 selftests/sgx: Introduce dynamic entry point
> =C2=A0 selftests/sgx: Introduce TCS initialization enclave operation
> =C2=A0 selftests/sgx: Test complete changing of page type flow
> =C2=A0 selftests/sgx: Test faulty enclave behavior
> =C2=A0 selftests/sgx: Test invalid access to removed enclave page
> =C2=A0 selftests/sgx: Test reclaiming of untouched page
> =C2=A0 selftests/sgx: Page removal stress test
>=20
> =C2=A0Documentation/x86/sgx.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 15 +
> =C2=A0arch/x86/include/asm/sgx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 8 +
> =C2=A0arch/x86/include/uapi/asm/sgx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 61 +
> =C2=A0arch/x86/kernel/cpu/sgx/encl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 329 +++-
> =C2=A0arch/x86/kernel/cpu/sgx/encl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15 +-
> =C2=A0arch/x86/kernel/cpu/sgx/encls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 33 +
> =C2=A0arch/x86/kernel/cpu/sgx/ioctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 640 +++++++-
> =C2=A0arch/x86/kernel/cpu/sgx/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 75 +-
> =C2=A0arch/x86/kernel/cpu/sgx/sgx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 3 +
> =C2=A0tools/testing/selftests/sgx/defines.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 23 +
> =C2=A0tools/testing/selftests/sgx/load.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 41 +
> =C2=A0tools/testing/selftests/sgx/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1435 +++++++++++++++++
> =C2=A0tools/testing/selftests/sgx/main.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0tools/testing/selftests/sgx/test_encl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 68 +
> =C2=A0.../selftests/sgx/test_encl_bootstrap.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> =C2=A015 files changed, 2625 insertions(+), 128 deletions(-)
>=20
>=20
> base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e

IMHO, we can pull this after +1 version. I think I had only one nit
(one character to a struct name it was), and I've been testing this
series *extensively* with real-world code (wasm run-time that we are
developing), so I'm confident that  it is *good enough*.

Reinette, for the EMODT patch, as long as you fix the struct name
you can add my reviewed-by and also tested-by to that patch before
you send it! It's so narrow change.

BR, Jarkko

