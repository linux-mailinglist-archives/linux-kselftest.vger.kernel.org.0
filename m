Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFC54E10D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiFPMrx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMrw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 08:47:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED51114C;
        Thu, 16 Jun 2022 05:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59000B823A2;
        Thu, 16 Jun 2022 12:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E68C34114;
        Thu, 16 Jun 2022 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655383667;
        bh=mJJreglfsq/eInk2uZxJOkVl6NKRtBddILNxwJFwCJc=;
        h=From:To:Cc:Subject:Date:From;
        b=pmrUP0fiYCoJ/nxsLqMoXDdinbjHwvnY3pgdMGhnqtd35JLltImWxPyoDu24XKmA0
         kiTNRpbVBSf4OJ7nCvAFBWfxSWRM2/m9jDgxAweVr6I6st72nFeUYKJwmpSVLk8xyK
         qt4X83xbqPQg5LVq9aLRM6youjAfJieDpv9Dhtd0rSM8HDghAqSTAIVcLS6p28uUeH
         wfetsRVURBNtWL1MHN+mOAwVRTVd1CEF5vEztNbAbZ12hkFaGB2wU2sZqWxLOfE4pT
         BaiaVAJm1z2DWmiPGvbS6OXU20kXSLHq0lEkdft2AE5S9qQ6GJ2QoOdAwjEi8GO4WN
         XTdfGhpQi8p/g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/2] efi: get rid of deprecated sysfs varstore interface
Date:   Thu, 16 Jun 2022 14:47:38 +0200
Message-Id: <20220616124740.580708-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=mJJreglfsq/eInk2uZxJOkVl6NKRtBddILNxwJFwCJc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiqyZnPA5pZvI6IIBxs1t527DYNp4QCuHwsySNN1iL GHFf08uJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqsmZwAKCRDDTyI5ktmPJCvSC/ 0Zk573HY0jo00PuecMNMiY/UAHGnFN5JkvkfE57PxSoe5bm5WFYgsfoG4E/ME0dhlTYhSRu9rnH4T/ /CMJ7A6kPa8TxXw/qZoeifAOEGeyiIlHcHzwlxd4Ppc2c3PpYNhkvq8mhONOqtgoBHldsFWIOxGTPM c/o0/B0EAyVywfAqcAizACmKSqbtRvs+216uAsemq/Oee+suaWlW1XRLde5BDYgyHhgyF7w5q1L9fn 40JFt6J1Bz1XYUBI3Zy6G91cglMiW5gWhNm6Tng0jR5moGCPl9Df7TU03IavMjPEQIzvOUI3hvfwbl 57h6BhGqod0IOtpT4IcNhAIEIfGjJ5OwfqB0vcQ5kbEr6OE+IY6caRh67vyOput/o64naFrQLTNC8o c7b7UEA/DmSzwUEC/pSX8g898Xq91MJvZ9eGhcYthHFvtGe3QonOOni9mgLJyU3OUCMFVJZUK1+2X9 UBK334QTZ/brfhGMclFAQ9yz7ThXfCQi8W7Uq0AEqtF0A=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

EFI still has two ways of exposing EFI variable to user space: the
original sysfs interface and the efivarfs pseudo-filesystem that
supersedes it, and which was introduced almost 10 years ago.

As a preparatory step towards refactoring the underlying infrastructure
shared between efivarfs and efi-pstore, I would like to finally get rid
of the sysfs interface which also uses that, but which is only enabled
on x86 and Itanium.

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org

Ard Biesheuvel (2):
  selftests/kexec: remove broken EFI_VARS secure boot fallback check
  efi: remove deprecated 'efivars' sysfs interface

 Documentation/x86/x86_64/uefi.rst                 |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig          |   1 -
 arch/ia64/configs/bigsur_defconfig                |   1 -
 arch/ia64/configs/generic_defconfig               |   1 -
 arch/ia64/configs/gensparse_defconfig             |   1 -
 arch/ia64/configs/tiger_defconfig                 |   1 -
 arch/ia64/configs/zx1_defconfig                   |   1 -
 arch/x86/configs/i386_defconfig                   |   1 -
 arch/x86/configs/x86_64_defconfig                 |   1 -
 drivers/firmware/efi/Kconfig                      |  12 -
 drivers/firmware/efi/Makefile                     |   1 -
 drivers/firmware/efi/efivars.c                    | 671 --------------------
 tools/testing/selftests/kexec/kexec_common_lib.sh |  36 +-
 13 files changed, 3 insertions(+), 727 deletions(-)
 delete mode 100644 drivers/firmware/efi/efivars.c

-- 
2.35.1

