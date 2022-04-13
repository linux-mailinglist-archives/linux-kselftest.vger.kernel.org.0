Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A045000CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiDMVNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiDMVND (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FB3A5C1;
        Wed, 13 Apr 2022 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884240; x=1681420240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KXY7XaVG2HCXvK8hK6uFseA1UCoFpDTv6+rYQnFG5+Q=;
  b=Q9PIYLflbRadf5yZcyCYwmZ5JYlPblDq4LFW8NHljwgZZeUWUld2pcLR
   Rtcyz/+0mxZg3qdd0xPxrOJRYgl35LrXhdQx0v54ytOqmOaUM/brTp9uX
   h+Ma7TObwuOTc498BPOF3RtHpiw4vQSrD45YYOYNwyH8yFTgEFsBglO1J
   v72Hqlco0eQMrIKma84FoYa4pXhShrIh3JtP4JCazEiApgTO3cgGcWRXX
   LinW3uWtTPMWrAzN2XWP7qCsDTDjBrXO0laxDNyUI87/m02EshlMxXbBh
   T2zloQ6mJgDSGzWjXwcBU/1MoNWAEADJ/eoBZoHqPyUvmTnRwIVIAWgNM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323218989"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323218989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054231"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:39 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Date:   Wed, 13 Apr 2022 14:10:00 -0700
Message-Id: <cover.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that the discussions surrounding the support for SGX2 is settling,
the kselftest audience is added to the discussion for the first time
to consider the testing of the new features.

V3: https://lore.kernel.org/lkml/cover.1648847675.git.reinette.chatre@intel.com/

Changes since V3 that directly impact user space:
- SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()'s struct
  sgx_enclave_restrict_permissions no longer provides entire secinfo,
  just the new permissions in new "permissions" struct member. (Jarkko)
- Rename SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl() to
  SGX_IOC_ENCLAVE_MODIFY_TYPES. (Jarkko)
- SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()'s struct sgx_enclave_modify_type
  no longer provides entire secinfo, just the new page type in new
  "page_type" struct member. (Jarkko)

Details about changes since V3 that do not directly impact user space:
- Add new patch to enable VA pages to be added without invoking reclaimer
  directly if no EPC pages are available, failing instead. This enables
  VA pages to be added with enclave's mutex held. Fixes an issue
  encountered by Haitao. More details in new patch "x86/sgx: Support VA page
  allocation without reclaiming".
- While refactoring, change existing code to consistently use
  IS_ALIGNED(). (Jarkko)
- Many patches received a tag from Jarkko.
- Many smaller changes, please refer to individual patches.

V2: https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/

Changes since V2 that directly impact user space:
- Maximum allowed permissions of dynamically added pages is RWX,
  previously limited to RW. (Jarkko)
  Dynamically added pages are initially created with architecturally
  limited EPCM permissions of RW. mmap() and mprotect() of these pages
  with RWX permissions would no longer be blocked by SGX driver. PROT_EXEC
  on dynamically added pages will be possible after running ENCLU[EMODPE]
  from within the enclave with appropriate VMA permissions.

- The kernel no longer attempts to track the EPCM runtime permissions. (Jarkko)
  Consequences are:
  - Kernel does not modify PTEs to follow EPCM permissions. User space
    will receive #PF with SGX error code in cases where the V2
    implementation would have resulted in regular (non-SGX) page fault
    error code.
  - SGX_IOC_ENCLAVE_RELAX_PERMISSIONS is removed. This ioctl() was used
    to clear PTEs after permissions were modified from within the enclave
    and ensure correct PTEs are installed. Since PTEs no longer track
    EPCM permissions the changes in EPCM permissions would not impact PTEs.
    As long as new permissions are within the maximum vetted permissions
    (vm_max_prot_bits) only ENCLU[EMODPE] from within enclave is needed,
    as accompanied by appropriate VMA permissions.

- struct sgx_enclave_restrict_perm renamed to
     sgx_enclave_restrict_permissions (Jarkko)

- struct sgx_enclave_modt renamed to struct sgx_enclave_modify_type
  to be consistent with the verbose naming of other SGX uapi structs.

Details about changes since V2 that do not directly impact user space:
- Kernel no longer tracks the runtime EPCM permissions with the aim of
  installing accurate PTEs. (Jarkko)
  - In support of this change the following patches were removed:
    Documentation/x86: Document SGX permission details
    x86/sgx: Support VMA permissions more relaxed than enclave permissions
    x86/sgx: Add pfn_mkwrite() handler for present PTEs
    x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic permission changes
    x86/sgx: Support relaxing of enclave page permissions
  - No more handling of scenarios where VMA permissions may be more
    relaxed than what the EPCM allows. Enclaves are not prevented
    from accessing such pages and the EPCM permissions are entrusted
    to control access as supported by the SGX error code in page faults.
  - No more explicit setting of protection bits in page fault handler.
    Protection bits are inherited from VMA similar to SGX1 support.

- Selftest patches are moved to the end of the series. (Jarkko)

- New patch contributed by Jarkko to avoid duplicated code:
   x86/sgx: Export sgx_encl_page_alloc()

- New patch separating changes from existing patch. (Jarkko)
   x86/sgx: Export sgx_encl_{grow,shrink}()

- New patch to keep one required benefit from the (now removed) kernel
  EPCM permission tracking:
   x86/sgx: Support loading enclave page without VMA permissions check

- Updated cover letter to reflect architecture changes.

- Many smaller changes, please refer to individual patches.

V1: https://lore.kernel.org/linux-sgx/cover.1638381245.git.reinette.chatre@intel.com/

Changes since V1 that directly impact user space:
- SGX2 permission changes changed from a single ioctl() named
  SGX_IOC_PAGE_MODP to two new ioctl()s:
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, supported by two different
  parameter structures (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS does
  not support a result output parameter) (Jarkko).

  User space flow impact: After user space runs ENCLU[EMODPE] it
  needs to call SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to have PTEs
  updated. Previously running SGX_IOC_PAGE_MODP in this scenario
  resulted in EPCM.PR being set but calling
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS will not result in EPCM.PR
  being set anymore and thus no need for an additional
  ENCLU[EACCEPT].

- SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
  obtain new permissions from secinfo as parameter instead of
  the permissions directly (Jarkko).

- ioctl() supporting SGX2 page type change is renamed from
  SGX_IOC_PAGE_MODT to SGX_IOC_ENCLAVE_MODIFY_TYPE (Jarkko).

- SGX_IOC_ENCLAVE_MODIFY_TYPE obtains new page type from secinfo
  as parameter instead of the page type directly (Jarkko).

- ioctl() supporting SGX2 page removal is renamed from
  SGX_IOC_PAGE_REMOVE to SGX_IOC_ENCLAVE_REMOVE_PAGES (Jarkko).

- All ioctl() parameter structures have been renamed as a result of the
  ioctl() renaming:
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS => struct sgx_enclave_relax_perm
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS => struct sgx_enclave_restrict_perm
  SGX_IOC_ENCLAVE_MODIFY_TYPE => struct sgx_enclave_modt
  SGX_IOC_ENCLAVE_REMOVE_PAGES => struct sgx_enclave_remove_pages

Changes since V1 that do not directly impact user space:
- Number of patches in series increased from 25 to 32 primarily because
  of splitting the original submission:
  - Wrappers for the new SGX2 functions are introduced in three separate
    patches replacing the original "x86/sgx: Add wrappers for SGX2
    functions"
    (Jarkko).
  - Moving and renaming sgx_encl_ewb_cpumask() is done with two patches
    replacing the original "x86/sgx: Use more generic name for enclave
    cpumask function" (Jarkko).
  - Support for SGX2 EPCM permission changes is split into two ioctls(),
    one for relaxing and one for restricting permissions, each introduced
    by a new patch replacing the original "x86/sgx: Support enclave page
    permission changes" (Jarkko).
  - Extracted code used by existing ioctls() for usage by new ioctl()s
    into a new utility in new patch "x86/sgx: Create utility to validate
    user provided offset and length" (Dave did not specifically ask for
    this but it addresses his review feedback).
  - Two new Documentation patches to support the SGX2 work
    ("Documentation/x86: Introduce enclave runtime management") and
    a dedicated section on the enclave permission management
    ("Documentation/x86: Document SGX permission details") (Andy).
- Most patches were reworked to improve the language by:
  * aiming to refer to exact item instead of English rephrasing (Jarkko).
  * use ioctl() instead of ioctl throughout (Dave).
  * Use "relaxed" instead of "exceed" when referring to permissions
    (Dave).
- Improved documentation with several additions to
  Documentation/x86/sgx.rst.
- Many smaller changes, please refer to individual patches.

Hi Everybody,

The current Linux kernel support for SGX includes support for SGX1 that
requires that an enclave be created with properties that accommodate all
usages over its (the enclave's) lifetime. This includes properties such
as permissions of enclave pages, the number of enclave pages, and the
number of threads supported by the enclave.

Consequences of this requirement to have the enclave be created to
accommodate all usages include:
* pages needing to support relocated code are required to have RWX
  permissions for their entire lifetime,
* an enclave needs to be created with the maximum stack and heap
  projected to be needed during the enclave's entire lifetime which
  can be longer than the processes running within it,
* an enclave needs to be created with support for the maximum number
  of threads projected to run in the enclave.

Since SGX1 a few more functions were introduced, collectively called
SGX2, that support modifications to an initialized enclave. Hardware
supporting these functions are already available as listed on
https://github.com/ayeks/SGX-hardware

This series adds support for SGX2, also referred to as Enclave Dynamic
Memory Management (EDMM). This includes:

* Support modifying EPCM permissions of regular enclave pages belonging
  to an initialized enclave. Only permission restriction is supported
  via a new ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS. Relaxing of
  EPCM permissions can only be done from within the enclave with the
  SGX instruction ENCLU[EMODPE].

* Support dynamic addition of regular enclave pages to an initialized
  enclave. At creation new pages are architecturally limited to RW EPCM
  permissions but will be accessible with PROT_EXEC after the enclave
  runs ENCLU[EMODPE] to relax EPCM permissions to RWX.
  Pages are dynamically added to an initialized enclave from the SGX
  page fault handler.

* Support expanding an initialized enclave to accommodate more threads.
  More threads can be accommodated by an enclave with the addition of
  Thread Control Structure (TCS) pages that is done by changing the
  type of regular enclave pages to TCS pages using a new ioctl()
  SGX_IOC_ENCLAVE_MODIFY_TYPES.

* Support removing regular and TCS pages from an initialized enclave.
  Removing pages is accomplished in two stages as supported by two new
  ioctl()s SGX_IOC_ENCLAVE_MODIFY_TYPES (same ioctl() as mentioned in
  previous bullet) and SGX_IOC_ENCLAVE_REMOVE_PAGES.

* Tests covering all the new flows, some edge cases, and one
  comprehensive stress scenario.

No additional work is needed to support SGX2 in a virtualized
environment. All tests included in this series passed when run from
a guest as tested with the recent QEMU release based on 6.2.0
that supports SGX.

Patches 1 through 14 prepare the existing code for SGX2 support by
introducing the SGX2 functions, refactoring code, and tracking enclave
page types.

Patches 15 through 21 enable the SGX2 features and include a
Documentation patch.

Patches 22 through 31 test several scenarios of all the enabled
SGX2 features.

This series is based on v5.18-rc2.

Your feedback will be greatly appreciated.

Regards,

Reinette

Jarkko Sakkinen (1):
  x86/sgx: Export sgx_encl_page_alloc()

Reinette Chatre (30):
  x86/sgx: Add short descriptions to ENCLS wrappers
  x86/sgx: Add wrapper for SGX2 EMODPR function
  x86/sgx: Add wrapper for SGX2 EMODT function
  x86/sgx: Add wrapper for SGX2 EAUG function
  x86/sgx: Support loading enclave page without VMA permissions check
  x86/sgx: Export sgx_encl_ewb_cpumask()
  x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
  x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
  x86/sgx: Make sgx_ipi_cb() available internally
  x86/sgx: Create utility to validate user provided offset and length
  x86/sgx: Keep record of SGX page type
  x86/sgx: Export sgx_encl_{grow,shrink}()
  x86/sgx: Support VA page allocation without reclaiming
  x86/sgx: Support restricting of enclave page permissions
  x86/sgx: Support adding of pages to an initialized enclave
  x86/sgx: Tighten accessible memory range after enclave initialization
  x86/sgx: Support modifying SGX page type
  x86/sgx: Support complete page removal
  x86/sgx: Free up EPC pages directly to support large page ranges
  Documentation/x86: Introduce enclave runtime management section
  selftests/sgx: Add test for EPCM permission changes
  selftests/sgx: Add test for TCS page permission changes
  selftests/sgx: Test two different SGX2 EAUG flows
  selftests/sgx: Introduce dynamic entry point
  selftests/sgx: Introduce TCS initialization enclave operation
  selftests/sgx: Test complete changing of page type flow
  selftests/sgx: Test faulty enclave behavior
  selftests/sgx: Test invalid access to removed enclave page
  selftests/sgx: Test reclaiming of untouched page
  selftests/sgx: Page removal stress test

 Documentation/x86/sgx.rst                     |   15 +
 arch/x86/include/asm/sgx.h                    |    8 +
 arch/x86/include/uapi/asm/sgx.h               |   61 +
 arch/x86/kernel/cpu/sgx/encl.c                |  329 +++-
 arch/x86/kernel/cpu/sgx/encl.h                |   15 +-
 arch/x86/kernel/cpu/sgx/encls.h               |   33 +
 arch/x86/kernel/cpu/sgx/ioctl.c               |  640 +++++++-
 arch/x86/kernel/cpu/sgx/main.c                |   75 +-
 arch/x86/kernel/cpu/sgx/sgx.h                 |    3 +
 tools/testing/selftests/sgx/defines.h         |   23 +
 tools/testing/selftests/sgx/load.c            |   41 +
 tools/testing/selftests/sgx/main.c            | 1435 +++++++++++++++++
 tools/testing/selftests/sgx/main.h            |    1 +
 tools/testing/selftests/sgx/test_encl.c       |   68 +
 .../selftests/sgx/test_encl_bootstrap.S       |    6 +
 15 files changed, 2625 insertions(+), 128 deletions(-)


base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
-- 
2.25.1

