Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4699D5657FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiGDN6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiGDN6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:58:47 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3914C65CA
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:58:46 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t127so9070278vsb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztA+AcW0Z5yxncYBDtWD6STNULe14Sk0EXcXnPOw+f4=;
        b=fydK2EY08GUj6bqmi53Jl6xaXTvB65A9lj5bRNFxZeapv/tUcE4QN7t8PznT4jlW+e
         0rDG6bJ0fMViPwfaDZiR/WIecntHzLs+ddCh3VrBeb4zitUcdM4x9plNiNeRTVIh0TvV
         TCkTeM70nq5ZST24ywg8pMnTQH5Nr32Q5LoEisV+hSJlt5MkxVO1wZMYxq90Nc/hOK+Q
         ZOfpFu0DI6+kpXPe2V9WmbXwON5GNop+xAneuw6eQB/d6b2Q8kRPFp0roAy+/AEX7cPj
         PER7yvGdPFy4Zj+r4qgMqMHWyIRWibEKlqXWQwU+rttUX3ngf2alEHE/VenxQKdvwEGh
         uU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztA+AcW0Z5yxncYBDtWD6STNULe14Sk0EXcXnPOw+f4=;
        b=SsIAYWAaFC6pm1B/CWPaq3MKF6AzxzN0OCFaBvdGMk2h4YsiUd9PeorBGxTAlm488A
         0GPaLLGg4U6ECNPufEP+93/JL1oGYtLUcFCLQ9tbDuwBbwuo14kVyYd2m1K1NXMC34t+
         /npTWwXFI+ZREPcaQB85JMDVqw26Rbnjzd7cqBZlQKMzcj1xWASS4IdjMfkUF8QnObFh
         LzCwUPrk9kr5DNrnGrKBNOs9kcjE9wq4Ocmo6fwDLenFTS3QUCFh2y/8iy+2AR2Em54i
         tI+EhTtiC63wPE7NVG4DLHOfI32SpsBlc83tmq+4+Y8NXk99SqMBjYC1YMjSx4QO/ASk
         1QSA==
X-Gm-Message-State: AJIora/Rr1qdlWYQ0KIRkiSCWEjQtkZCn3UJMH1UAPVrObg+J2VsWH69
        dLYQ4O9mjqkZrTtusMr++xeMpg==
X-Google-Smtp-Source: AGRyM1sE6X+ncoLXgmaxZR7/g+iA8gyRtqST2d07S2Z+ia/JWZThIFFbyNf15t/vtifF0SiuZRjkgg==
X-Received: by 2002:a05:6102:1504:b0:354:397f:51c5 with SMTP id f4-20020a056102150400b00354397f51c5mr17054790vsv.63.1656943125320;
        Mon, 04 Jul 2022 06:58:45 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id bi44-20020a05612218ac00b0036bff0dc94esm4494942vkb.34.2022.07.04.06.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:58:45 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v9 0/9] x86: Show in sysfs if a memory node is able to do encryption
Date:   Mon,  4 Jul 2022 10:58:24 -0300
Message-Id: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Show for each node if every memory descriptor in that node has the
EFI_MEMORY_CPU_CRYPTO attribute.

fwupd project plans to use it as part of a check to see if the users
have properly configured memory hardware encryption
capabilities. fwupd's people have seen cases where it seems like there
is memory encryption because all the hardware is capable of doing it,
but on a closer look there is not, either because of system firmware
or because some component requires updating to enable the feature.

The MKTME/TME spec says that it will only encrypt those memory regions
which are flagged with the EFI_MEMORY_CPU_CRYPTO attribute.

If all nodes are capable of encryption and if the system have tme/sme
on we can pretty confidently say that the device is actively
encrypting all its memory.

It's planned to make this check part of an specification that can be
passed to people purchasing hardware

These checks will run at every boot. The specification is called Host
Security ID: https://fwupd.github.io/libfwupdplugin/hsi.html.

We choosed to do it a per-node basis because although an ABI that
shows that the whole system memory is capable of encryption would be
useful for the fwupd use case, doing it in a per-node basis would make
the path easier to give the capability to the user to target
allocations from applications to NUMA nodes which have encryption
capabilities in the future.


Changes since v8:

Add unit tests to e820_range_* functions


Changes since v7:

Less kerneldocs

Less verbosity in the e820 code


Changes since v6:

Fixes in __e820__handle_range_update

Const correctness in e820.c

Correct alignment in memblock.h

Rework memblock_overlaps_region


Changes since v5:

Refactor e820__range_{update, remove, set_crypto_capable} in order to
avoid code duplication.

Warn the user when a node has both encryptable and non-encryptable
regions.

Check that e820_table has enough size to store both current e820_table
and EFI memmap.


Changes since v4:

Add enum to represent the cryptographic capabilities in e820:
e820_crypto_capabilities.

Revert __e820__range_update, only adding the new argument for
__e820__range_add about crypto capabilities.

Add a function __e820__range_update_crypto similar to
__e820__range_update but to only update this new field.


Changes since v3:

Update date in Doc/ABI file.

More information about the fwupd usecase and the rationale behind
doing it in a per-NUMA-node.


Changes since v2:

e820__range_mark_crypto -> e820__range_mark_crypto_capable.

In e820__range_remove: Create a region with crypto capabilities
instead of creating one without it and then mark it.


Changes since v1:

Modify __e820__range_update to update the crypto capabilities of a
range; now this function will change the crypto capability of a range
if it's called with the same old_type and new_type. Rework
efi_mark_e820_regions_as_crypto_capable based on this.

Update do_add_efi_memmap to mark the regions as it creates them.

Change the type of crypto_capable in e820_entry from bool to u8.

Fix e820__update_table changes.

Remove memblock_add_crypto_capable. Now you have to add the region and
mark it then.

Better place for crypto_capable in pglist_data.

Martin Fernandez (9):
  mm/memblock: Tag memblocks with crypto capabilities
  mm/mmzone: Tag pg_data_t with crypto capabilities
  x86/e820: Add infrastructure to refactor e820__range_{update,remove}
  x86/e820: Refactor __e820__range_update
  x86/e820: Refactor e820__range_remove
  x86/e820: Tag e820_entry with crypto capabilities
  x86/e820: Add unit tests for e820_range_* functions
  x86/efi: Mark e820_entries as crypto capable from EFI memmap
  drivers/node: Show in sysfs node's crypto capabilities

 Documentation/ABI/testing/sysfs-devices-node |  10 +
 arch/x86/Kconfig.debug                       |  10 +
 arch/x86/include/asm/e820/api.h              |   1 +
 arch/x86/include/asm/e820/types.h            |  12 +-
 arch/x86/kernel/e820.c                       | 393 ++++++++++++++-----
 arch/x86/kernel/e820_test.c                  | 249 ++++++++++++
 arch/x86/platform/efi/efi.c                  |  37 ++
 drivers/base/node.c                          |  10 +
 include/linux/memblock.h                     |   5 +
 include/linux/mmzone.h                       |   3 +
 mm/memblock.c                                |  62 +++
 mm/page_alloc.c                              |   1 +
 12 files changed, 695 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node
 create mode 100644 arch/x86/kernel/e820_test.c

-- 
2.30.2

