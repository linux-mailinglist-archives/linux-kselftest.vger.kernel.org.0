Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C32D54B7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 07:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfJMFyg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Oct 2019 01:54:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39454 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJMFyg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Oct 2019 01:54:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so13638308wml.4;
        Sat, 12 Oct 2019 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x7JY6xrCHUh7LlmLoH9Isp9XiPlwVlZPf9oGFQJZmCY=;
        b=YSPZ8XN9jSTDZd2v1JtJb4lWMZH+2Vl0rX3jArIiHYxJJXIjtAX5RRC5QdXZJtsNgW
         E9rqQNsRzdLWKxRZVNndmhXIi1SQn67s4/hvEgWR3uj0SWgQ3pb3ymqFZ1Pb58awFVRF
         Gl8RzEy4KgtqYPHS9TQSvahud1ke90VfKKcBZhNbT9q3PxGST8zMy3DBwHeCRPOr22gm
         UAYrffyLF2pNC+RSrkpw5P5nz28I43vvE1j62fVJytOaRxp4uHRA6pG9EApy4LjyLatF
         DBgI8ynwVE6rvsSVwjdZpSYn6j/nvVHGFaHIMNcof2oBT8SluR1uJ883qdNvyLf/43h3
         2lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x7JY6xrCHUh7LlmLoH9Isp9XiPlwVlZPf9oGFQJZmCY=;
        b=i7tm5oAEdulJzCUyOVTCirqvteJ+C3WTe9GKJxTZNqhpqDUoW3/U4ONbhlWuVphDuF
         66GEMKRjDiu6Zc2kuXUQnEWAO2mDr5ZgyAX2mf7zFuCDtKO2SV9BODj0U0msGLc0XWEQ
         vo7rYgVnN1660MnZAsVCotAs2NfUoiNYomYWgzgJmJMe9eWRRSJcnwcVYGzTfDRz1Xwc
         JzH2ucPm4/g7aT7iNm+z4W+kvIdnsx2ayupwTKMEIc+K5pSpVC0IAEGIkR0zWx4PYiqC
         gUqk/wMz8oq2lQHmX5RaWBBsbrGI0UhlXNp04UVnNQJhb/w/AkmWZQRmNDow6Z6OOgT1
         rcfg==
X-Gm-Message-State: APjAAAW95WBAroBg1Ewa7TRZDjOGzDsua834f1AIiWAeIgsiiFV/MEGZ
        UTJtxm2yJ8qEPHG7LLlUCrOMsVJodBE=
X-Google-Smtp-Source: APXvYqzbYwyFDAnRBpYXWTuBg5Vj/8B6o8KWMZyQtw5AHgk7lXA8k1c/3huvBT4ukzzAjzJD6CwGug==
X-Received: by 2002:a7b:cb95:: with SMTP id m21mr1988089wmi.36.1570946064538;
        Sat, 12 Oct 2019 22:54:24 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id e3sm13847839wme.39.2019.10.12.22.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 22:54:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] kernel-doc: rename the kernel-doc directive 'functions' to 'specific'
Date:   Sun, 13 Oct 2019 13:53:59 +0800
Message-Id: <20191013055359.23312-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 'functions' directive is not only for functions, but also works for
structs/unions. So the name is misleading. This patch renames it to
'specific', so now we have export/internal/specific directives to limit
the functions/types to be included in documentation. Meanwhile we improved
the warning message.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/PCI/pci.rst                     |   4 +-
 Documentation/core-api/boot-time-mm.rst       |   2 +-
 Documentation/core-api/debug-objects.rst      |  14 +-
 Documentation/core-api/genalloc.rst           |  34 +--
 Documentation/core-api/generic-radix-tree.rst |   2 +-
 .../core-api/gfp_mask-from-fs-io.rst          |   4 +-
 Documentation/core-api/idr.rst                |   4 +-
 Documentation/core-api/kernel-api.rst         |  12 +-
 Documentation/core-api/mm-api.rst             |   4 +-
 Documentation/crypto/api-aead.rst             |   6 +-
 Documentation/crypto/api-akcipher.rst         |   6 +-
 Documentation/crypto/api-digest.rst           |   8 +-
 Documentation/crypto/api-kpp.rst              |  10 +-
 Documentation/crypto/api-rng.rst              |   4 +-
 Documentation/crypto/api-skcipher.rst         |  14 +-
 Documentation/dev-tools/kselftest.rst         |   4 +-
 Documentation/doc-guide/kernel-doc.rst        |  26 +--
 Documentation/driver-api/80211/cfg80211.rst   | 200 +++++++++---------
 .../driver-api/80211/mac80211-advanced.rst    |  88 ++++----
 Documentation/driver-api/80211/mac80211.rst   |  80 +++----
 .../driver-api/device_connection.rst          |   2 +-
 Documentation/driver-api/device_link.rst      |   4 +-
 .../firmware/fallback-mechanisms.rst          |   2 +-
 .../driver-api/firmware/other_interfaces.rst  |  10 +-
 .../driver-api/firmware/request_firmware.rst  |  12 +-
 Documentation/driver-api/fpga/fpga-bridge.rst |  10 +-
 Documentation/driver-api/fpga/fpga-mgr.rst    |  12 +-
 .../driver-api/fpga/fpga-programming.rst      |   8 +-
 Documentation/driver-api/fpga/fpga-region.rst |  20 +-
 Documentation/driver-api/i2c.rst              |   2 +-
 Documentation/driver-api/mei/hdcp.rst         |   2 +-
 Documentation/driver-api/spi.rst              |   2 +-
 Documentation/driver-api/usb/typec.rst        |  26 +--
 Documentation/driver-api/usb/typec_bus.rst    |  10 +-
 Documentation/gpu/amdgpu-dc.rst               |   6 +-
 Documentation/gpu/drm-kms-helpers.rst         |   2 +-
 Documentation/gpu/i915.rst                    |  70 +++---
 Documentation/gpu/vga-switcheroo.rst          |  14 +-
 Documentation/security/tpm/tpm_vtpm_proxy.rst |   2 +-
 Documentation/sphinx/kerneldoc.py             |  10 +-
 .../it_IT/doc-guide/kernel-doc.rst            |   2 +-
 Documentation/vm/ksm.rst                      |   2 +-
 scripts/kernel-doc                            |   9 +-
 43 files changed, 385 insertions(+), 380 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 6864f9a70f5f..6f310807f74c 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -79,13 +79,13 @@ initialization with a pointer to a structure describing the driver
 (``struct pci_driver``):
 
 .. kernel-doc:: include/linux/pci.h
-   :functions: pci_driver
+   :specific: pci_driver
 
 The ID table is an array of ``struct pci_device_id`` entries ending with an
 all-zero entry.  Definitions with static const are generally preferred.
 
 .. kernel-doc:: include/linux/mod_devicetable.h
-   :functions: pci_device_id
+   :specific: pci_device_id
 
 Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set up
 a pci_device_id table.
diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
index e5ec9f1a563d..54824740d010 100644
--- a/Documentation/core-api/boot-time-mm.rst
+++ b/Documentation/core-api/boot-time-mm.rst
@@ -38,4 +38,4 @@ really happens under the hood.
 
 .. kernel-doc:: include/linux/memblock.h
 .. kernel-doc:: mm/memblock.c
-   :functions:
+   :specific:
diff --git a/Documentation/core-api/debug-objects.rst b/Documentation/core-api/debug-objects.rst
index ac926fd55a64..352fc2d8abbd 100644
--- a/Documentation/core-api/debug-objects.rst
+++ b/Documentation/core-api/debug-objects.rst
@@ -65,7 +65,7 @@ Debug functions
 ===============
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_init
+   :specific: debug_object_init
 
 This function is called whenever the initialization function of a real
 object is called.
@@ -88,7 +88,7 @@ calling code must use debug_object_init_on_stack() and remove the
 object before leaving the function which allocated it. See next section.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_init_on_stack
+   :specific: debug_object_init_on_stack
 
 This function is called whenever the initialization function of a real
 object which resides on the stack is called.
@@ -112,7 +112,7 @@ calling debug_object_free() before the function which allocates the
 object returns. Otherwise we keep track of stale objects.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_activate
+   :specific: debug_object_activate
 
 This function is called whenever the activation function of a real
 object is called.
@@ -137,7 +137,7 @@ tracker object is set to ODEBUG_STATE_ACTIVE.
 
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_deactivate
+   :specific: debug_object_deactivate
 
 This function is called whenever the deactivation function of a real
 object is called.
@@ -150,7 +150,7 @@ When the deactivation is legitimate, then the state of the associated
 tracker object is set to ODEBUG_STATE_INACTIVE.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_destroy
+   :specific: debug_object_destroy
 
 This function is called to mark an object destroyed. This is useful to
 prevent the usage of invalid objects, which are still available in
@@ -169,7 +169,7 @@ When the destruction is legitimate, then the state of the associated
 tracker object is set to ODEBUG_STATE_DESTROYED.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_free
+   :specific: debug_object_free
 
 This function is called before an object is freed.
 
@@ -186,7 +186,7 @@ usage of the object is detected by the other debug checks.
 
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_assert_init
+   :specific: debug_object_assert_init
 
 This function is called to assert that an object has been initialized.
 
diff --git a/Documentation/core-api/genalloc.rst b/Documentation/core-api/genalloc.rst
index 6b38a39fab24..28a665c28852 100644
--- a/Documentation/core-api/genalloc.rst
+++ b/Documentation/core-api/genalloc.rst
@@ -18,10 +18,10 @@ Code using this allocator should include <linux/genalloc.h>.  The action
 begins with the creation of a pool using one of:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_create		
+   :specific: gen_pool_create
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: devm_gen_pool_create
+   :specific: devm_gen_pool_create
 
 A call to :c:func:`gen_pool_create` will create a pool.  The granularity of
 allocations is set with min_alloc_order; it is a log-base-2 number like
@@ -39,7 +39,7 @@ pool when the given device is destroyed.
 A pool is shut down with:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_destroy
+   :specific: gen_pool_destroy
 
 It's worth noting that, if there are still allocations outstanding from the
 given pool, this function will take the rather extreme step of invoking
@@ -50,10 +50,10 @@ that state, so one of the first orders of business is usually to add memory
 to the pool.  That can be done with one of:
 
 .. kernel-doc:: include/linux/genalloc.h
-   :functions: gen_pool_add
+   :specific: gen_pool_add
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_add_virt
+   :specific: gen_pool_add_virt
 
 A call to :c:func:`gen_pool_add` will place the size bytes of memory
 starting at addr (in the kernel's virtual address space) into the given
@@ -66,13 +66,13 @@ The functions for allocating memory from the pool (and putting it back)
 are:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_alloc
+   :specific: gen_pool_alloc
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_dma_alloc
+   :specific: gen_pool_dma_alloc
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_free
+   :specific: gen_pool_free
 
 As one would expect, :c:func:`gen_pool_alloc` will allocate size< bytes
 from the given pool.  The :c:func:`gen_pool_dma_alloc` variant allocates
@@ -89,10 +89,10 @@ return.  If that sort of control is needed, the following functions will be
 of interest:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_alloc_algo
+   :specific: gen_pool_alloc_algo
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_set_algo
+   :specific: gen_pool_set_algo
 
 Allocations with :c:func:`gen_pool_alloc_algo` specify an algorithm to be
 used to choose the memory to be allocated; the default algorithm can be set
@@ -123,22 +123,22 @@ above.  With luck, wider awareness of this module will help to prevent the
 writing of special-purpose memory allocators in the future.
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_virt_to_phys
+   :specific: gen_pool_virt_to_phys
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_for_each_chunk
+   :specific: gen_pool_for_each_chunk
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: addr_in_gen_pool
+   :specific: addr_in_gen_pool
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_avail
+   :specific: gen_pool_avail
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_size
+   :specific: gen_pool_size
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_get
+   :specific: gen_pool_get
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: of_gen_pool_get
+   :specific: of_gen_pool_get
diff --git a/Documentation/core-api/generic-radix-tree.rst b/Documentation/core-api/generic-radix-tree.rst
index ed42839ae42f..373380f6c037 100644
--- a/Documentation/core-api/generic-radix-tree.rst
+++ b/Documentation/core-api/generic-radix-tree.rst
@@ -9,4 +9,4 @@ generic radix tree functions
 ----------------------------
 
 .. kernel-doc:: include/linux/generic-radix-tree.h
-   :functions:
+   :specific:
diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index e7c32a8de126..b6eff1c8b3b7 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -36,9 +36,9 @@ scope will inherently drop __GFP_FS respectively __GFP_IO from the given
 mask so no memory allocation can recurse back in the FS/IO.
 
 .. kernel-doc:: include/linux/sched/mm.h
-   :functions: memalloc_nofs_save memalloc_nofs_restore
+   :specific: memalloc_nofs_save memalloc_nofs_restore
 .. kernel-doc:: include/linux/sched/mm.h
-   :functions: memalloc_noio_save memalloc_noio_restore
+   :specific: memalloc_noio_save memalloc_noio_restore
 
 FS/IO code then simply calls the appropriate save function before
 any critical section with respect to the reclaim is started - e.g.
diff --git a/Documentation/core-api/idr.rst b/Documentation/core-api/idr.rst
index a2738050c4f0..d54425605a8f 100644
--- a/Documentation/core-api/idr.rst
+++ b/Documentation/core-api/idr.rst
@@ -76,6 +76,6 @@ Functions and structures
 ========================
 
 .. kernel-doc:: include/linux/idr.h
-   :functions:
+   :specific:
 .. kernel-doc:: lib/idr.c
-   :functions:
+   :specific:
diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index f77de49b1d51..8cec422f0d8e 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -25,10 +25,10 @@ String Conversions
    :export:
 
 .. kernel-doc:: include/linux/kernel.h
-   :functions: kstrtol
+   :specific: kstrtol
 
 .. kernel-doc:: include/linux/kernel.h
-   :functions: kstrtoul
+   :specific: kstrtoul
 
 .. kernel-doc:: lib/kstrtox.c
    :export:
@@ -46,7 +46,7 @@ String Manipulation
    :internal:
 
 .. kernel-doc:: mm/util.c
-   :functions: kstrdup kstrdup_const kstrndup kmemdup kmemdup_nul memdup_user
+   :specific: kstrdup kstrdup_const kstrndup kmemdup kmemdup_nul memdup_user
                vmemdup_user strndup_user memdup_user_nul
 
 Basic Kernel Library Functions
@@ -109,7 +109,7 @@ Text Searching
    :export:
 
 .. kernel-doc:: include/linux/textsearch.h
-   :functions: textsearch_find textsearch_next \
+   :specific: textsearch_find textsearch_next \
                textsearch_get_pattern textsearch_get_pattern_len
 
 CRC and Math Functions in Linux
@@ -157,13 +157,13 @@ Division Functions
 ------------------
 
 .. kernel-doc:: include/asm-generic/div64.h
-   :functions: do_div
+   :specific: do_div
 
 .. kernel-doc:: include/linux/math64.h
    :internal:
 
 .. kernel-doc:: lib/math/div64.c
-   :functions: div_s64_rem div64_u64_rem div64_u64 div64_s64
+   :specific: div_s64_rem div64_u64_rem div64_u64 div64_s64
 
 .. kernel-doc:: lib/math/gcd.c
    :export:
diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 128e8a721c1e..12579eaca4d6 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -12,7 +12,7 @@ User Space Memory Access
    :export:
 
 .. kernel-doc:: mm/util.c
-   :functions: get_user_pages_fast
+   :specific: get_user_pages_fast
 
 .. _mm-api-gfp-flags:
 
@@ -50,7 +50,7 @@ The Slab Cache
    :export:
 
 .. kernel-doc:: mm/util.c
-   :functions: kfree_const kvmalloc_node kvfree
+   :specific: kfree_const kvmalloc_node kvfree
 
 Virtually Contiguous Mappings
 =============================
diff --git a/Documentation/crypto/api-aead.rst b/Documentation/crypto/api-aead.rst
index d15256f1ae36..c195acca0ca3 100644
--- a/Documentation/crypto/api-aead.rst
+++ b/Documentation/crypto/api-aead.rst
@@ -5,13 +5,13 @@ Authenticated Encryption With Associated Data (AEAD) Algorithm Definitions
    :doc: Authenticated Encryption With Associated Data (AEAD) Cipher API
 
 .. kernel-doc:: include/crypto/aead.h
-   :functions: aead_request aead_alg
+   :specific: aead_request aead_alg
 
 Authenticated Encryption With Associated Data (AEAD) Cipher API
 ---------------------------------------------------------------
 
 .. kernel-doc:: include/crypto/aead.h
-   :functions: crypto_alloc_aead crypto_free_aead crypto_aead_ivsize crypto_aead_authsize crypto_aead_blocksize crypto_aead_setkey crypto_aead_setauthsize crypto_aead_encrypt crypto_aead_decrypt
+   :specific: crypto_alloc_aead crypto_free_aead crypto_aead_ivsize crypto_aead_authsize crypto_aead_blocksize crypto_aead_setkey crypto_aead_setauthsize crypto_aead_encrypt crypto_aead_decrypt
 
 Asynchronous AEAD Request Handle
 --------------------------------
@@ -20,4 +20,4 @@ Asynchronous AEAD Request Handle
    :doc: Asynchronous AEAD Request Handle
 
 .. kernel-doc:: include/crypto/aead.h
-   :functions: crypto_aead_reqsize aead_request_set_tfm aead_request_alloc aead_request_free aead_request_set_callback aead_request_set_crypt aead_request_set_ad
+   :specific: crypto_aead_reqsize aead_request_set_tfm aead_request_alloc aead_request_free aead_request_set_callback aead_request_set_crypt aead_request_set_ad
diff --git a/Documentation/crypto/api-akcipher.rst b/Documentation/crypto/api-akcipher.rst
index 40aa8746e2a1..db4d16b5920e 100644
--- a/Documentation/crypto/api-akcipher.rst
+++ b/Documentation/crypto/api-akcipher.rst
@@ -2,7 +2,7 @@ Asymmetric Cipher Algorithm Definitions
 ---------------------------------------
 
 .. kernel-doc:: include/crypto/akcipher.h
-   :functions: akcipher_alg akcipher_request
+   :specific: akcipher_alg akcipher_request
 
 Asymmetric Cipher API
 ---------------------
@@ -11,10 +11,10 @@ Asymmetric Cipher API
    :doc: Generic Public Key API
 
 .. kernel-doc:: include/crypto/akcipher.h
-   :functions: crypto_alloc_akcipher crypto_free_akcipher crypto_akcipher_set_pub_key crypto_akcipher_set_priv_key crypto_akcipher_maxsize crypto_akcipher_encrypt crypto_akcipher_decrypt crypto_akcipher_sign crypto_akcipher_verify
+   :specific: crypto_alloc_akcipher crypto_free_akcipher crypto_akcipher_set_pub_key crypto_akcipher_set_priv_key crypto_akcipher_maxsize crypto_akcipher_encrypt crypto_akcipher_decrypt crypto_akcipher_sign crypto_akcipher_verify
 
 Asymmetric Cipher Request Handle
 --------------------------------
 
 .. kernel-doc:: include/crypto/akcipher.h
-   :functions: akcipher_request_alloc akcipher_request_free akcipher_request_set_callback akcipher_request_set_crypt
+   :specific: akcipher_request_alloc akcipher_request_free akcipher_request_set_callback akcipher_request_set_crypt
diff --git a/Documentation/crypto/api-digest.rst b/Documentation/crypto/api-digest.rst
index 7a1e670d6ce1..5ac8e2db0410 100644
--- a/Documentation/crypto/api-digest.rst
+++ b/Documentation/crypto/api-digest.rst
@@ -5,7 +5,7 @@ Message Digest Algorithm Definitions
    :doc: Message Digest Algorithm Definitions
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: hash_alg_common ahash_alg shash_alg
+   :specific: hash_alg_common ahash_alg shash_alg
 
 Asynchronous Message Digest API
 -------------------------------
@@ -14,7 +14,7 @@ Asynchronous Message Digest API
    :doc: Asynchronous Message Digest API
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: crypto_alloc_ahash crypto_free_ahash crypto_ahash_init crypto_ahash_digestsize crypto_ahash_reqtfm crypto_ahash_reqsize crypto_ahash_statesize crypto_ahash_setkey crypto_ahash_finup crypto_ahash_final crypto_ahash_digest crypto_ahash_export crypto_ahash_import
+   :specific: crypto_alloc_ahash crypto_free_ahash crypto_ahash_init crypto_ahash_digestsize crypto_ahash_reqtfm crypto_ahash_reqsize crypto_ahash_statesize crypto_ahash_setkey crypto_ahash_finup crypto_ahash_final crypto_ahash_digest crypto_ahash_export crypto_ahash_import
 
 Asynchronous Hash Request Handle
 --------------------------------
@@ -23,7 +23,7 @@ Asynchronous Hash Request Handle
    :doc: Asynchronous Hash Request Handle
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: ahash_request_set_tfm ahash_request_alloc ahash_request_free ahash_request_set_callback ahash_request_set_crypt
+   :specific: ahash_request_set_tfm ahash_request_alloc ahash_request_free ahash_request_set_callback ahash_request_set_crypt
 
 Synchronous Message Digest API
 ------------------------------
@@ -32,4 +32,4 @@ Synchronous Message Digest API
    :doc: Synchronous Message Digest API
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: crypto_alloc_shash crypto_free_shash crypto_shash_blocksize crypto_shash_digestsize crypto_shash_descsize crypto_shash_setkey crypto_shash_digest crypto_shash_export crypto_shash_import crypto_shash_init crypto_shash_update crypto_shash_final crypto_shash_finup
+   :specific: crypto_alloc_shash crypto_free_shash crypto_shash_blocksize crypto_shash_digestsize crypto_shash_descsize crypto_shash_setkey crypto_shash_digest crypto_shash_export crypto_shash_import crypto_shash_init crypto_shash_update crypto_shash_final crypto_shash_finup
diff --git a/Documentation/crypto/api-kpp.rst b/Documentation/crypto/api-kpp.rst
index 7d86ab906bdf..eff06d515a10 100644
--- a/Documentation/crypto/api-kpp.rst
+++ b/Documentation/crypto/api-kpp.rst
@@ -2,7 +2,7 @@ Key-agreement Protocol Primitives (KPP) Cipher Algorithm Definitions
 --------------------------------------------------------------------
 
 .. kernel-doc:: include/crypto/kpp.h
-   :functions: kpp_request crypto_kpp kpp_alg kpp_secret
+   :specific: kpp_request crypto_kpp kpp_alg kpp_secret
 
 Key-agreement Protocol Primitives (KPP) Cipher API
 --------------------------------------------------
@@ -11,13 +11,13 @@ Key-agreement Protocol Primitives (KPP) Cipher API
    :doc: Generic Key-agreement Protocol Primitives API
 
 .. kernel-doc:: include/crypto/kpp.h
-   :functions: crypto_alloc_kpp crypto_free_kpp crypto_kpp_set_secret crypto_kpp_generate_public_key crypto_kpp_compute_shared_secret crypto_kpp_maxsize
+   :specific: crypto_alloc_kpp crypto_free_kpp crypto_kpp_set_secret crypto_kpp_generate_public_key crypto_kpp_compute_shared_secret crypto_kpp_maxsize
 
 Key-agreement Protocol Primitives (KPP) Cipher Request Handle
 -------------------------------------------------------------
 
 .. kernel-doc:: include/crypto/kpp.h
-   :functions: kpp_request_alloc kpp_request_free kpp_request_set_callback kpp_request_set_input kpp_request_set_output
+   :specific: kpp_request_alloc kpp_request_free kpp_request_set_callback kpp_request_set_input kpp_request_set_output
 
 ECDH Helper Functions
 ---------------------
@@ -26,7 +26,7 @@ ECDH Helper Functions
    :doc: ECDH Helper Functions
 
 .. kernel-doc:: include/crypto/ecdh.h
-   :functions: ecdh crypto_ecdh_key_len crypto_ecdh_encode_key crypto_ecdh_decode_key
+   :specific: ecdh crypto_ecdh_key_len crypto_ecdh_encode_key crypto_ecdh_decode_key
 
 DH Helper Functions
 -------------------
@@ -35,4 +35,4 @@ DH Helper Functions
    :doc: DH Helper Functions
 
 .. kernel-doc:: include/crypto/dh.h
-   :functions: dh crypto_dh_key_len crypto_dh_encode_key crypto_dh_decode_key
+   :specific: dh crypto_dh_key_len crypto_dh_encode_key crypto_dh_decode_key
diff --git a/Documentation/crypto/api-rng.rst b/Documentation/crypto/api-rng.rst
index 10ba7436cee4..2359a161efd5 100644
--- a/Documentation/crypto/api-rng.rst
+++ b/Documentation/crypto/api-rng.rst
@@ -2,7 +2,7 @@ Random Number Algorithm Definitions
 -----------------------------------
 
 .. kernel-doc:: include/crypto/rng.h
-   :functions: rng_alg
+   :specific: rng_alg
 
 Crypto API Random Number API
 ----------------------------
@@ -11,4 +11,4 @@ Crypto API Random Number API
    :doc: Random number generator API
 
 .. kernel-doc:: include/crypto/rng.h
-   :functions: crypto_alloc_rng crypto_rng_alg crypto_free_rng crypto_rng_generate crypto_rng_get_bytes crypto_rng_reset crypto_rng_seedsize
+   :specific: crypto_alloc_rng crypto_rng_alg crypto_free_rng crypto_rng_generate crypto_rng_get_bytes crypto_rng_reset crypto_rng_seedsize
diff --git a/Documentation/crypto/api-skcipher.rst b/Documentation/crypto/api-skcipher.rst
index 20ba08dddf2e..7934edd73932 100644
--- a/Documentation/crypto/api-skcipher.rst
+++ b/Documentation/crypto/api-skcipher.rst
@@ -5,7 +5,7 @@ Block Cipher Algorithm Definitions
    :doc: Block Cipher Algorithm Definitions
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_alg ablkcipher_alg blkcipher_alg cipher_alg compress_alg
+   :specific: crypto_alg ablkcipher_alg blkcipher_alg cipher_alg compress_alg
 
 Symmetric Key Cipher API
 ------------------------
@@ -14,7 +14,7 @@ Symmetric Key Cipher API
    :doc: Symmetric Key Cipher API
 
 .. kernel-doc:: include/crypto/skcipher.h
-   :functions: crypto_alloc_skcipher crypto_free_skcipher crypto_has_skcipher crypto_skcipher_ivsize crypto_skcipher_blocksize crypto_skcipher_setkey crypto_skcipher_reqtfm crypto_skcipher_encrypt crypto_skcipher_decrypt
+   :specific: crypto_alloc_skcipher crypto_free_skcipher crypto_has_skcipher crypto_skcipher_ivsize crypto_skcipher_blocksize crypto_skcipher_setkey crypto_skcipher_reqtfm crypto_skcipher_encrypt crypto_skcipher_decrypt
 
 Symmetric Key Cipher Request Handle
 -----------------------------------
@@ -23,7 +23,7 @@ Symmetric Key Cipher Request Handle
    :doc: Symmetric Key Cipher Request Handle
 
 .. kernel-doc:: include/crypto/skcipher.h
-   :functions: crypto_skcipher_reqsize skcipher_request_set_tfm skcipher_request_alloc skcipher_request_free skcipher_request_set_callback skcipher_request_set_crypt
+   :specific: crypto_skcipher_reqsize skcipher_request_set_tfm skcipher_request_alloc skcipher_request_free skcipher_request_set_callback skcipher_request_set_crypt
 
 Single Block Cipher API
 -----------------------
@@ -32,7 +32,7 @@ Single Block Cipher API
    :doc: Single Block Cipher API
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_alloc_cipher crypto_free_cipher crypto_has_cipher crypto_cipher_blocksize crypto_cipher_setkey crypto_cipher_encrypt_one crypto_cipher_decrypt_one
+   :specific: crypto_alloc_cipher crypto_free_cipher crypto_has_cipher crypto_cipher_blocksize crypto_cipher_setkey crypto_cipher_encrypt_one crypto_cipher_decrypt_one
 
 Asynchronous Block Cipher API - Deprecated
 ------------------------------------------
@@ -41,7 +41,7 @@ Asynchronous Block Cipher API - Deprecated
    :doc: Asynchronous Block Cipher API
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_free_ablkcipher crypto_has_ablkcipher crypto_ablkcipher_ivsize crypto_ablkcipher_blocksize crypto_ablkcipher_setkey crypto_ablkcipher_reqtfm crypto_ablkcipher_encrypt crypto_ablkcipher_decrypt
+   :specific: crypto_free_ablkcipher crypto_has_ablkcipher crypto_ablkcipher_ivsize crypto_ablkcipher_blocksize crypto_ablkcipher_setkey crypto_ablkcipher_reqtfm crypto_ablkcipher_encrypt crypto_ablkcipher_decrypt
 
 Asynchronous Cipher Request Handle - Deprecated
 -----------------------------------------------
@@ -50,7 +50,7 @@ Asynchronous Cipher Request Handle - Deprecated
    :doc: Asynchronous Cipher Request Handle
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_ablkcipher_reqsize ablkcipher_request_set_tfm ablkcipher_request_alloc ablkcipher_request_free ablkcipher_request_set_callback ablkcipher_request_set_crypt
+   :specific: crypto_ablkcipher_reqsize ablkcipher_request_set_tfm ablkcipher_request_alloc ablkcipher_request_free ablkcipher_request_set_callback ablkcipher_request_set_crypt
 
 Synchronous Block Cipher API - Deprecated
 -----------------------------------------
@@ -59,4 +59,4 @@ Synchronous Block Cipher API - Deprecated
    :doc: Synchronous Block Cipher API
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_alloc_blkcipher crypto_free_blkcipher crypto_has_blkcipher crypto_blkcipher_name crypto_blkcipher_ivsize crypto_blkcipher_blocksize crypto_blkcipher_setkey crypto_blkcipher_encrypt crypto_blkcipher_encrypt_iv crypto_blkcipher_decrypt crypto_blkcipher_decrypt_iv crypto_blkcipher_set_iv crypto_blkcipher_get_iv
+   :specific: crypto_alloc_blkcipher crypto_free_blkcipher crypto_has_blkcipher crypto_blkcipher_name crypto_blkcipher_ivsize crypto_blkcipher_blocksize crypto_blkcipher_setkey crypto_blkcipher_encrypt crypto_blkcipher_encrypt_iv crypto_blkcipher_decrypt crypto_blkcipher_decrypt_iv crypto_blkcipher_set_iv crypto_blkcipher_get_iv
diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ecdfdc9d4b03..da60a749eb10 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -300,7 +300,7 @@ Helpers
 -------
 
 .. kernel-doc:: tools/testing/selftests/kselftest_harness.h
-    :functions: TH_LOG TEST TEST_SIGNAL FIXTURE FIXTURE_DATA FIXTURE_SETUP
+    :specific: TH_LOG TEST TEST_SIGNAL FIXTURE FIXTURE_DATA FIXTURE_SETUP
                 FIXTURE_TEARDOWN TEST_F TEST_HARNESS_MAIN
 
 Operators
@@ -310,7 +310,7 @@ Operators
     :doc: operators
 
 .. kernel-doc:: tools/testing/selftests/kselftest_harness.h
-    :functions: ASSERT_EQ ASSERT_NE ASSERT_LT ASSERT_LE ASSERT_GT ASSERT_GE
+    :specific: ASSERT_EQ ASSERT_NE ASSERT_LT ASSERT_LE ASSERT_GT ASSERT_GE
                 ASSERT_NULL ASSERT_TRUE ASSERT_NULL ASSERT_TRUE ASSERT_FALSE
                 ASSERT_STREQ ASSERT_STRNE EXPECT_EQ EXPECT_NE EXPECT_LT
                 EXPECT_LE EXPECT_GT EXPECT_GE EXPECT_NULL EXPECT_TRUE
diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 192c36af39e2..c287c5edaa5c 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -476,6 +476,19 @@ internal: *[source-pattern ...]*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :internal:
 
+specific: *[ function/type ...]*
+  Include documentation for each *function* and *type* in *source*.
+  If no *function* is specified, the documentation for all functions
+  and types in the *source* will be included.
+
+  Examples::
+
+    .. kernel-doc:: lib/bitmap.c
+       :specific: bitmap_parselist bitmap_parselist_user
+
+    .. kernel-doc:: lib/idr.c
+       :specific:
+
 doc: *title*
   Include documentation for the ``DOC:`` paragraph identified by *title* in
   *source*. Spaces are allowed in *title*; do not quote the *title*. The *title*
@@ -488,19 +501,6 @@ doc: *title*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :doc: High Definition Audio over HDMI and Display Port
 
-functions: *[ function ...]*
-  Include documentation for each *function* in *source*.
-  If no *function* is specified, the documentation for all functions
-  and types in the *source* will be included.
-
-  Examples::
-
-    .. kernel-doc:: lib/bitmap.c
-       :functions: bitmap_parselist bitmap_parselist_user
-
-    .. kernel-doc:: lib/idr.c
-       :functions:
-
 Without options, the kernel-doc directive includes all documentation comments
 from the source file.
 
diff --git a/Documentation/driver-api/80211/cfg80211.rst b/Documentation/driver-api/80211/cfg80211.rst
index eeab91b59457..aeecafeaa0b7 100644
--- a/Documentation/driver-api/80211/cfg80211.rst
+++ b/Documentation/driver-api/80211/cfg80211.rst
@@ -12,79 +12,79 @@ Device registration
    :doc: Device registration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_channel_flags
+   :specific: ieee80211_channel_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_channel
+   :specific: ieee80211_channel
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_rate_flags
+   :specific: ieee80211_rate_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_rate
+   :specific: ieee80211_rate
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_sta_ht_cap
+   :specific: ieee80211_sta_ht_cap
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_supported_band
+   :specific: ieee80211_supported_band
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_signal_type
+   :specific: cfg80211_signal_type
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_params_flags
+   :specific: wiphy_params_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_flags
+   :specific: wiphy_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy
+   :specific: wiphy
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wireless_dev
+   :specific: wireless_dev
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_new
+   :specific: wiphy_new
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_read_of_freq_limits
+   :specific: wiphy_read_of_freq_limits
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_register
+   :specific: wiphy_register
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_unregister
+   :specific: wiphy_unregister
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_free
+   :specific: wiphy_free
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_name
+   :specific: wiphy_name
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_dev
+   :specific: wiphy_dev
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_priv
+   :specific: wiphy_priv
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: priv_to_wiphy
+   :specific: priv_to_wiphy
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: set_wiphy_dev
+   :specific: set_wiphy_dev
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wdev_priv
+   :specific: wdev_priv
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_iface_limit
+   :specific: ieee80211_iface_limit
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_iface_combination
+   :specific: ieee80211_iface_combination
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_check_combinations
+   :specific: cfg80211_check_combinations
 
 Actions and configuration
 =========================
@@ -93,139 +93,139 @@ Actions and configuration
    :doc: Actions and configuration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ops
+   :specific: cfg80211_ops
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: vif_params
+   :specific: vif_params
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: key_params
+   :specific: key_params
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: survey_info_flags
+   :specific: survey_info_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: survey_info
+   :specific: survey_info
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_beacon_data
+   :specific: cfg80211_beacon_data
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ap_settings
+   :specific: cfg80211_ap_settings
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: station_parameters
+   :specific: station_parameters
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: rate_info_flags
+   :specific: rate_info_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: rate_info
+   :specific: rate_info
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: station_info
+   :specific: station_info
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: monitor_flags
+   :specific: monitor_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: mpath_info_flags
+   :specific: mpath_info_flags
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: mpath_info
+   :specific: mpath_info
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: bss_parameters
+   :specific: bss_parameters
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_txq_params
+   :specific: ieee80211_txq_params
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_crypto_settings
+   :specific: cfg80211_crypto_settings
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_auth_request
+   :specific: cfg80211_auth_request
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_assoc_request
+   :specific: cfg80211_assoc_request
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_deauth_request
+   :specific: cfg80211_deauth_request
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_disassoc_request
+   :specific: cfg80211_disassoc_request
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ibss_params
+   :specific: cfg80211_ibss_params
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_params
+   :specific: cfg80211_connect_params
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_pmksa
+   :specific: cfg80211_pmksa
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_rx_mlme_mgmt
+   :specific: cfg80211_rx_mlme_mgmt
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_auth_timeout
+   :specific: cfg80211_auth_timeout
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_rx_assoc_resp
+   :specific: cfg80211_rx_assoc_resp
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_assoc_timeout
+   :specific: cfg80211_assoc_timeout
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_tx_mlme_mgmt
+   :specific: cfg80211_tx_mlme_mgmt
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ibss_joined
+   :specific: cfg80211_ibss_joined
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_resp_params
+   :specific: cfg80211_connect_resp_params
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_done
+   :specific: cfg80211_connect_done
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_result
+   :specific: cfg80211_connect_result
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_bss
+   :specific: cfg80211_connect_bss
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_timeout
+   :specific: cfg80211_connect_timeout
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_roamed
+   :specific: cfg80211_roamed
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_disconnected
+   :specific: cfg80211_disconnected
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ready_on_channel
+   :specific: cfg80211_ready_on_channel
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_remain_on_channel_expired
+   :specific: cfg80211_remain_on_channel_expired
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_new_sta
+   :specific: cfg80211_new_sta
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_rx_mgmt
+   :specific: cfg80211_rx_mgmt
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_mgmt_tx_status
+   :specific: cfg80211_mgmt_tx_status
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_cqm_rssi_notify
+   :specific: cfg80211_cqm_rssi_notify
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_cqm_pktloss_notify
+   :specific: cfg80211_cqm_pktloss_notify
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_michael_mic_failure
+   :specific: cfg80211_michael_mic_failure
 
 Scanning and BSS list handling
 ==============================
@@ -234,34 +234,34 @@ Scanning and BSS list handling
    :doc: Scanning and BSS list handling
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ssid
+   :specific: cfg80211_ssid
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_scan_request
+   :specific: cfg80211_scan_request
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_scan_done
+   :specific: cfg80211_scan_done
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_bss
+   :specific: cfg80211_bss
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_inform_bss
+   :specific: cfg80211_inform_bss
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_inform_bss_frame_data
+   :specific: cfg80211_inform_bss_frame_data
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_inform_bss_data
+   :specific: cfg80211_inform_bss_data
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_unlink_bss
+   :specific: cfg80211_unlink_bss
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_find_ie
+   :specific: cfg80211_find_ie
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_bss_get_ie
+   :specific: ieee80211_bss_get_ie
 
 Utility functions
 =================
@@ -270,25 +270,25 @@ Utility functions
    :doc: Utility functions
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_channel_to_frequency
+   :specific: ieee80211_channel_to_frequency
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_frequency_to_channel
+   :specific: ieee80211_frequency_to_channel
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_get_channel
+   :specific: ieee80211_get_channel
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_get_response_rate
+   :specific: ieee80211_get_response_rate
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_hdrlen
+   :specific: ieee80211_hdrlen
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_get_hdrlen_from_skb
+   :specific: ieee80211_get_hdrlen_from_skb
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_radiotap_iterator
+   :specific: ieee80211_radiotap_iterator
 
 Data path helpers
 =================
@@ -297,13 +297,13 @@ Data path helpers
    :doc: Data path helpers
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_data_to_8023
+   :specific: ieee80211_data_to_8023
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_amsdu_to_8023s
+   :specific: ieee80211_amsdu_to_8023s
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_classify8021d
+   :specific: cfg80211_classify8021d
 
 Regulatory enforcement infrastructure
 =====================================
@@ -312,13 +312,13 @@ Regulatory enforcement infrastructure
    :doc: Regulatory enforcement infrastructure
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: regulatory_hint
+   :specific: regulatory_hint
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_apply_custom_regulatory
+   :specific: wiphy_apply_custom_regulatory
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: freq_reg_info
+   :specific: freq_reg_info
 
 RFkill integration
 ==================
@@ -327,13 +327,13 @@ RFkill integration
    :doc: RFkill integration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_rfkill_set_hw_state
+   :specific: wiphy_rfkill_set_hw_state
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_rfkill_start_polling
+   :specific: wiphy_rfkill_start_polling
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_rfkill_stop_polling
+   :specific: wiphy_rfkill_stop_polling
 
 Test mode
 =========
@@ -342,13 +342,13 @@ Test mode
    :doc: Test mode
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_alloc_reply_skb
+   :specific: cfg80211_testmode_alloc_reply_skb
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_reply
+   :specific: cfg80211_testmode_reply
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_alloc_event_skb
+   :specific: cfg80211_testmode_alloc_event_skb
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_event
+   :specific: cfg80211_testmode_event
diff --git a/Documentation/driver-api/80211/mac80211-advanced.rst b/Documentation/driver-api/80211/mac80211-advanced.rst
index 9f1c5bb7ac35..9eeff622a192 100644
--- a/Documentation/driver-api/80211/mac80211-advanced.rst
+++ b/Documentation/driver-api/80211/mac80211-advanced.rst
@@ -15,25 +15,25 @@ appropriate trigger, which will then be triggered appropriately by
 mac80211.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tx_led_name
+   :specific: ieee80211_get_tx_led_name
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_rx_led_name
+   :specific: ieee80211_get_rx_led_name
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_assoc_led_name
+   :specific: ieee80211_get_assoc_led_name
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_radio_led_name
+   :specific: ieee80211_get_radio_led_name
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tpt_blink
+   :specific: ieee80211_tpt_blink
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tpt_led_trigger_flags
+   :specific: ieee80211_tpt_led_trigger_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_create_tpt_led_trigger
+   :specific: ieee80211_create_tpt_led_trigger
 
 Hardware crypto acceleration
 ============================
@@ -42,22 +42,22 @@ Hardware crypto acceleration
    :doc: Hardware crypto acceleration
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: set_key_cmd
+   :specific: set_key_cmd
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_key_conf
+   :specific: ieee80211_key_conf
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_key_flags
+   :specific: ieee80211_key_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tkip_p1k
+   :specific: ieee80211_get_tkip_p1k
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tkip_p1k_iv
+   :specific: ieee80211_get_tkip_p1k_iv
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tkip_p2k
+   :specific: ieee80211_get_tkip_p2k
 
 Powersave support
 =================
@@ -72,7 +72,7 @@ Beacon filter support
    :doc: Beacon filter support
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_beacon_loss
+   :specific: ieee80211_beacon_loss
 
 Multiple queues and QoS support
 ===============================
@@ -80,7 +80,7 @@ Multiple queues and QoS support
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_queue_params
+   :specific: ieee80211_tx_queue_params
 
 Access point mode support
 =========================
@@ -99,28 +99,28 @@ support for powersaving clients
    :doc: AP support for powersaving clients
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_buffered_bc
+   :specific: ieee80211_get_buffered_bc
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_beacon_get
+   :specific: ieee80211_beacon_get
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_eosp
+   :specific: ieee80211_sta_eosp
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_frame_release_type
+   :specific: ieee80211_frame_release_type
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_ps_transition
+   :specific: ieee80211_sta_ps_transition
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_ps_transition_ni
+   :specific: ieee80211_sta_ps_transition_ni
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_set_buffered
+   :specific: ieee80211_sta_set_buffered
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_block_awake
+   :specific: ieee80211_sta_block_awake
 
 Supporting multiple virtual interfaces
 ======================================
@@ -134,10 +134,10 @@ addresses here, note which configurations are supported by mac80211, add
 notes about supporting hw crypto with it.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_iterate_active_interfaces
+   :specific: ieee80211_iterate_active_interfaces
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_iterate_active_interfaces_atomic
+   :specific: ieee80211_iterate_active_interfaces_atomic
 
 Station handling
 ================
@@ -145,16 +145,16 @@ Station handling
 TODO
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta
+   :specific: ieee80211_sta
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: sta_notify_cmd
+   :specific: sta_notify_cmd
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_find_sta
+   :specific: ieee80211_find_sta
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_find_sta_by_ifaddr
+   :specific: ieee80211_find_sta_by_ifaddr
 
 Hardware scan offload
 =====================
@@ -162,7 +162,7 @@ Hardware scan offload
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_scan_completed
+   :specific: ieee80211_scan_completed
 
 Aggregation
 ===========
@@ -184,7 +184,7 @@ RX A-MPDU aggregation
 .. WARNING: DOCPROC directive not supported: !Cnet/mac80211/agg-rx.c
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ampdu_mlme_action
+   :specific: ieee80211_ampdu_mlme_action
 
 Spatial Multiplexing Powersave (SMPS)
 =====================================
@@ -193,10 +193,10 @@ Spatial Multiplexing Powersave (SMPS)
    :doc: Spatial multiplexing power save
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_request_smps
+   :specific: ieee80211_request_smps
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_smps_mode
+   :specific: ieee80211_smps_mode
 
 TBD
 
@@ -209,22 +209,22 @@ Rate Control API
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_start_tx_ba_session
+   :specific: ieee80211_start_tx_ba_session
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_start_tx_ba_cb_irqsafe
+   :specific: ieee80211_start_tx_ba_cb_irqsafe
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_tx_ba_session
+   :specific: ieee80211_stop_tx_ba_session
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_tx_ba_cb_irqsafe
+   :specific: ieee80211_stop_tx_ba_cb_irqsafe
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rate_control_changed
+   :specific: ieee80211_rate_control_changed
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_rate_control
+   :specific: ieee80211_tx_rate_control
 
 TBD
 
@@ -261,10 +261,10 @@ Programming information
 -----------------------
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: sta_info
+   :specific: sta_info
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: ieee80211_sta_info_flags
+   :specific: ieee80211_sta_info_flags
 
 STA information lifetime rules
 ------------------------------
@@ -276,13 +276,13 @@ Aggregation
 ===========
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: sta_ampdu_mlme
+   :specific: sta_ampdu_mlme
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: tid_ampdu_tx
+   :specific: tid_ampdu_tx
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: tid_ampdu_rx
+   :specific: tid_ampdu_rx
 
 Synchronisation
 ===============
diff --git a/Documentation/driver-api/80211/mac80211.rst b/Documentation/driver-api/80211/mac80211.rst
index eab40bcf3987..6ac0fa665532 100644
--- a/Documentation/driver-api/80211/mac80211.rst
+++ b/Documentation/driver-api/80211/mac80211.rst
@@ -30,31 +30,31 @@ Finally, a discussion of hardware capabilities should be done with
 references to other parts of the book.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_hw
+   :specific: ieee80211_hw
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_hw_flags
+   :specific: ieee80211_hw_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: SET_IEEE80211_DEV
+   :specific: SET_IEEE80211_DEV
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: SET_IEEE80211_PERM_ADDR
+   :specific: SET_IEEE80211_PERM_ADDR
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ops
+   :specific: ieee80211_ops
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_alloc_hw
+   :specific: ieee80211_alloc_hw
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_register_hw
+   :specific: ieee80211_register_hw
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_unregister_hw
+   :specific: ieee80211_unregister_hw
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_free_hw
+   :specific: ieee80211_free_hw
 
 PHY configuration
 =================
@@ -65,10 +65,10 @@ This chapter should describe PHY handling including start/stop callbacks
 and the various structures used.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_conf
+   :specific: ieee80211_conf
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_conf_flags
+   :specific: ieee80211_conf_flags
 
 Virtual interfaces
 ==================
@@ -88,7 +88,7 @@ the recommendation to allow only a single interface in STA mode at
 first!
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_vif
+   :specific: ieee80211_vif
 
 Receive and transmit processing
 ===============================
@@ -123,79 +123,79 @@ functions/definitions
 ---------------------
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx_status
+   :specific: ieee80211_rx_status
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_rx_encoding_flags
+   :specific: mac80211_rx_encoding_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_rx_flags
+   :specific: mac80211_rx_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_tx_info_flags
+   :specific: mac80211_tx_info_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_tx_control_flags
+   :specific: mac80211_tx_control_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_rate_control_flags
+   :specific: mac80211_rate_control_flags
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_rate
+   :specific: ieee80211_tx_rate
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_info
+   :specific: ieee80211_tx_info
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_info_clear_status
+   :specific: ieee80211_tx_info_clear_status
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx
+   :specific: ieee80211_rx
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx_ni
+   :specific: ieee80211_rx_ni
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx_irqsafe
+   :specific: ieee80211_rx_irqsafe
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_status
+   :specific: ieee80211_tx_status
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_status_ni
+   :specific: ieee80211_tx_status_ni
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_status_irqsafe
+   :specific: ieee80211_tx_status_irqsafe
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rts_get
+   :specific: ieee80211_rts_get
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rts_duration
+   :specific: ieee80211_rts_duration
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ctstoself_get
+   :specific: ieee80211_ctstoself_get
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ctstoself_duration
+   :specific: ieee80211_ctstoself_duration
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_generic_frame_duration
+   :specific: ieee80211_generic_frame_duration
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_wake_queue
+   :specific: ieee80211_wake_queue
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_queue
+   :specific: ieee80211_stop_queue
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_wake_queues
+   :specific: ieee80211_wake_queues
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_queues
+   :specific: ieee80211_stop_queues
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_queue_stopped
+   :specific: ieee80211_queue_stopped
 
 Frame filtering
 ===============
@@ -204,7 +204,7 @@ Frame filtering
    :doc: Frame filtering
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_filter_flags
+   :specific: ieee80211_filter_flags
 
 The mac80211 workqueue
 ======================
@@ -213,7 +213,7 @@ The mac80211 workqueue
    :doc: mac80211 workqueue
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_queue_work
+   :specific: ieee80211_queue_work
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_queue_delayed_work
+   :specific: ieee80211_queue_delayed_work
diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
index ba364224c349..0feaf7146dd6 100644
--- a/Documentation/driver-api/device_connection.rst
+++ b/Documentation/driver-api/device_connection.rst
@@ -40,4 +40,4 @@ API
 ---
 
 .. kernel-doc:: drivers/base/devcon.c
-   :functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
+   :specific: device_connection_find_match device_connection_find device_connection_add device_connection_remove
diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index 1b5020ec6517..6e79007d41cd 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -258,7 +258,7 @@ State machine
 =============
 
 .. kernel-doc:: include/linux/device.h
-   :functions: device_link_state
+   :specific: device_link_state
 
 ::
 
@@ -321,4 +321,4 @@ API
 ===
 
 .. kernel-doc:: drivers/base/core.c
-   :functions: device_link_add device_link_del device_link_remove
+   :specific: device_link_add device_link_del device_link_remove
diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index 8b041d0ab426..08d60ae4e138 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -111,7 +111,7 @@ expected to be used regularly by userspace.
 firmware_fallback_sysfs
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/fallback.c
-   :functions: firmware_fallback_sysfs
+   :specific: firmware_fallback_sysfs
 
 Firmware kobject uevent fallback mechanism
 ==========================================
diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index b81794e0cfbb..da948488a4c4 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -27,19 +27,19 @@ and processed one by one. ARM’s SMCCC is used to pass the execution
 of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_command_code
+   :specific: stratix10_svc_command_code
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_client_msg
+   :specific: stratix10_svc_client_msg
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_command_config_type
+   :specific: stratix10_svc_command_config_type
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_cb_data
+   :specific: stratix10_svc_cb_data
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_client
+   :specific: stratix10_svc_client
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index f62bdcbfed5b..5d3cee760735 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -18,22 +18,22 @@ an error is returned.
 request_firmware
 ----------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware
+   :specific: request_firmware
 
 firmware_request_nowarn
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_nowarn
+   :specific: firmware_request_nowarn
 
 request_firmware_direct
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware_direct
+   :specific: request_firmware_direct
 
 request_firmware_into_buf
 -------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware_into_buf
+   :specific: request_firmware_into_buf
 
 Asynchronous firmware requests
 ==============================
@@ -47,7 +47,7 @@ in atomic contexts.
 request_firmware_nowait
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware_nowait
+   :specific: request_firmware_nowait
 
 Special optimizations on reboot
 ===============================
@@ -61,7 +61,7 @@ firmware to be loaded.
 firmware_request_cache()
 ------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_cache
+   :specific: firmware_request_cache
 
 request firmware API expected driver use
 ========================================
diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 71c5a40da320..3aaecbffcf97 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -11,16 +11,16 @@ API to implement a new FPGA bridge
 * :c:func:`fpga_bridge_unregister()` — Unregister a bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
-   :functions: fpga_bridge
+   :specific: fpga_bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
-   :functions: fpga_bridge_ops
+   :specific: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: devm_fpga_bridge_create
+   :specific: devm_fpga_bridge_create
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :specific: fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_unregister
+   :specific: fpga_bridge_unregister
diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 576f1945eacd..5445f66910ca 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -109,19 +109,19 @@ API for implementing a new FPGA Manager driver
 * :c:func:`fpga_mgr_unregister` —  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_mgr_states
+   :specific: fpga_mgr_states
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_manager
+   :specific: fpga_manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_manager_ops
+   :specific: fpga_manager_ops
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_create
+   :specific: devm_fpga_mgr_create
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :specific: fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_unregister
+   :specific: fpga_mgr_unregister
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
index b5484df6ff0f..4abf868898e9 100644
--- a/Documentation/driver-api/fpga/fpga-programming.rst
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -90,7 +90,7 @@ API for programming an FPGA
 * :c:func:`fpga_image_info_free()` —  Free an FPGA image info struct
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_program_fpga
+   :specific: fpga_region_program_fpga
 
 FPGA Manager flags
 
@@ -98,10 +98,10 @@ FPGA Manager flags
    :doc: FPGA Manager flags
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_image_info
+   :specific: fpga_image_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_image_info_alloc
+   :specific: fpga_image_info_alloc
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_image_info_free
+   :specific: fpga_image_info_free
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 0529b2d2231a..94344f1a4d0c 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -73,31 +73,31 @@ following APIs to handle building or tearing down that list.
 * :c:func:`fpga_bridges_put` — Given a list of bridges, put them
 
 .. kernel-doc:: include/linux/fpga/fpga-region.h
-   :functions: fpga_region
+   :specific: fpga_region
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: devm_fpga_region_create
+   :specific: devm_fpga_region_create
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register
+   :specific: fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_unregister
+   :specific: fpga_region_unregister
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_get
+   :specific: fpga_mgr_get
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: of_fpga_mgr_get
+   :specific: of_fpga_mgr_get
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_put
+   :specific: fpga_mgr_put
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_get_to_list
+   :specific: fpga_bridge_get_to_list
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: of_fpga_bridge_get_to_list
+   :specific: of_fpga_bridge_get_to_list
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridges_put
+   :specific: fpga_bridges_put
diff --git a/Documentation/driver-api/i2c.rst b/Documentation/driver-api/i2c.rst
index 7582c079d747..8f585d9adf62 100644
--- a/Documentation/driver-api/i2c.rst
+++ b/Documentation/driver-api/i2c.rst
@@ -39,7 +39,7 @@ i2c_adapter devices which don't support those I2C operations.
    :internal:
 
 .. kernel-doc:: drivers/i2c/i2c-boardinfo.c
-   :functions: i2c_register_board_info
+   :specific: i2c_register_board_info
 
 .. kernel-doc:: drivers/i2c/i2c-core-base.c
    :export:
diff --git a/Documentation/driver-api/mei/hdcp.rst b/Documentation/driver-api/mei/hdcp.rst
index e85a065b1cdc..aebfc3378cab 100644
--- a/Documentation/driver-api/mei/hdcp.rst
+++ b/Documentation/driver-api/mei/hdcp.rst
@@ -28,5 +28,5 @@ mei_hdcp api
 ------------
 
 .. kernel-doc:: drivers/misc/mei/hdcp/mei_hdcp.c
-    :functions:
+    :specific:
 
diff --git a/Documentation/driver-api/spi.rst b/Documentation/driver-api/spi.rst
index f64cb666498a..288d0b315931 100644
--- a/Documentation/driver-api/spi.rst
+++ b/Documentation/driver-api/spi.rst
@@ -47,7 +47,7 @@ policies for how they use the bits transferred with SPI.
    :internal:
 
 .. kernel-doc:: drivers/spi/spi.c
-   :functions: spi_register_board_info
+   :specific: spi_register_board_info
 
 .. kernel-doc:: drivers/spi/spi.c
    :export:
diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index 201163d8c13e..a3782833b6ea 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -63,7 +63,7 @@ The port drivers will describe every Type-C port they control with struct
 typec_capability data structure, and register them with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_register_port typec_unregister_port
+   :specific: typec_register_port typec_unregister_port
 
 When registering the ports, the prefer_role member in struct typec_capability
 deserves special notice. If the port that is being registered does not have
@@ -82,7 +82,7 @@ registration. The class offers the following API for registering/unregistering
 partners.
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_register_partner typec_unregister_partner
+   :specific: typec_register_partner typec_unregister_partner
 
 The class will provide a handle to struct typec_partner if the registration was
 successful, or NULL.
@@ -94,7 +94,7 @@ create a sysfs directory for the identity under the partner device. The result
 of Discover Identity command can then be reported with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_partner_set_identity
+   :specific: typec_partner_set_identity
 
 Registering Cables
 ~~~~~~~~~~~~~~~~~~
@@ -115,7 +115,7 @@ the details during registration. The class offers the following API for
 registering/unregistering cables and their plugs:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_register_cable typec_unregister_cable typec_register_plug typec_unregister_plug
+   :specific: typec_register_cable typec_unregister_cable typec_register_plug typec_unregister_plug
 
 The class will provide a handle to struct typec_cable and struct typec_plug if
 the registration is successful, or NULL if it isn't.
@@ -127,7 +127,7 @@ sysfs directory for the identity under the cable device. The result of Discover
 Identity command can then be reported with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_cable_set_identity
+   :specific: typec_cable_set_identity
 
 Notifications
 ~~~~~~~~~~~~~
@@ -137,7 +137,7 @@ during connection of a partner or cable, the port driver must use the following
 APIs to report it to the class:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_set_data_role typec_set_pwr_role typec_set_vconn_role typec_set_pwr_opmode
+   :specific: typec_set_data_role typec_set_pwr_role typec_set_vconn_role typec_set_pwr_opmode
 
 Alternate Modes
 ~~~~~~~~~~~~~~~
@@ -152,7 +152,7 @@ Ports that support Alternate Modes need to register each SVID they support with
 the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_port_register_altmode
+   :specific: typec_port_register_altmode
 
 If a partner or cable plug provides a list of SVIDs as response to USB Power
 Delivery Structured VDM Discover SVIDs message, each SVID needs to be
@@ -161,12 +161,12 @@ registered.
 API for the partners:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_partner_register_altmode
+   :specific: typec_partner_register_altmode
 
 API for the Cable Plugs:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_plug_register_altmode
+   :specific: typec_plug_register_altmode
 
 So ports, partners and cable plugs will register the alternate modes with their
 own functions, but the registration will always return a handle to struct
@@ -174,13 +174,13 @@ typec_altmode on success, or NULL. The unregistration will happen with the same
 function:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_unregister_altmode
+   :specific: typec_unregister_altmode
 
 If a partner or cable plug enters or exits a mode, the port driver needs to
 notify the class with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_altmode_update_active
+   :specific: typec_altmode_update_active
 
 Multiplexer/DeMultiplexer Switches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -193,7 +193,7 @@ route the pins on the connector to some other component besides USB. USB Type-C
 Connector Class supplies an API for registering those switches.
 
 .. kernel-doc:: drivers/usb/typec/mux.c
-   :functions: typec_switch_register typec_switch_unregister typec_mux_register typec_mux_unregister
+   :specific: typec_switch_register typec_switch_unregister typec_mux_register typec_mux_unregister
 
 In most cases the same physical mux will handle both the orientation and mode.
 However, as the port drivers will be responsible for the orientation, and the
@@ -205,7 +205,7 @@ the switch for the port. The drivers can then use the following API for
 controlling them:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_set_orientation typec_set_mode
+   :specific: typec_set_orientation typec_set_mode
 
 If the connector is dual-role capable, there may also be a switch for the data
 role. USB Type-C Connector Class does not supply separate API for them. The
diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
index f47a69bff498..762e53b66665 100644
--- a/Documentation/driver-api/usb/typec_bus.rst
+++ b/Documentation/driver-api/usb/typec_bus.rst
@@ -110,27 +110,27 @@ Alternate mode driver registering/unregistering
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_altmode_register_driver typec_altmode_unregister_driver
+   :specific: typec_altmode_register_driver typec_altmode_unregister_driver
 
 Alternate mode driver operations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
+   :specific: typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
 
 API for the port drivers
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_match_altmode
+   :specific: typec_match_altmode
 
 Cable Plug operations
 ~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_altmode_get_plug typec_altmode_put_plug
+   :specific: typec_altmode_get_plug typec_altmode_put_plug
 
 Notifications
 ~~~~~~~~~~~~~
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_altmode_register_notifier typec_altmode_unregister_notifier
+   :specific: typec_altmode_register_notifier typec_altmode_unregister_notifier
diff --git a/Documentation/gpu/amdgpu-dc.rst b/Documentation/gpu/amdgpu-dc.rst
index cc89b0fc11df..ec95a5a0aea4 100644
--- a/Documentation/gpu/amdgpu-dc.rst
+++ b/Documentation/gpu/amdgpu-dc.rst
@@ -39,7 +39,7 @@ Lifecycle
    :doc: DM Lifecycle
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
-   :functions: dm_hw_init dm_hw_fini
+   :specific: dm_hw_init dm_hw_fini
 
 Interrupts
 ----------
@@ -51,7 +51,7 @@ Interrupts
    :internal:
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
-   :functions: register_hpd_handlers dm_crtc_high_irq dm_pflip_high_irq
+   :specific: register_hpd_handlers dm_crtc_high_irq dm_pflip_high_irq
 
 Atomic Implementation
 ---------------------
@@ -60,7 +60,7 @@ Atomic Implementation
    :doc: atomic
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
-   :functions: amdgpu_dm_atomic_check amdgpu_dm_atomic_commit_tail
+   :specific: amdgpu_dm_atomic_check amdgpu_dm_atomic_commit_tail
 
 Display Core
 ============
diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 3868008db8a9..78a0457a9434 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -257,7 +257,7 @@ These functions aren't exported to drivers, but are documented here to help make
 the MST topology helpers easier to understand
 
 .. kernel-doc:: drivers/gpu/drm/drm_dp_mst_topology.c
-   :functions: drm_dp_mst_topology_try_get_mstb drm_dp_mst_topology_get_mstb
+   :specific: drm_dp_mst_topology_try_get_mstb drm_dp_mst_topology_get_mstb
                drm_dp_mst_topology_put_mstb
                drm_dp_mst_topology_try_get_port drm_dp_mst_topology_get_port
                drm_dp_mst_topology_put_port
diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 3415255ad3dc..c0c6d5e4a35c 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -32,13 +32,13 @@ Interrupt Handling
    :doc: interrupt handling
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_irq_init intel_irq_init_hw intel_hpd_init
+   :specific: intel_irq_init intel_irq_init_hw intel_hpd_init
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_runtime_pm_disable_interrupts
+   :specific: intel_runtime_pm_disable_interrupts
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_runtime_pm_enable_interrupts
+   :specific: intel_runtime_pm_enable_interrupts
 
 Intel GVT-g Guest Support(vGPU)
 -------------------------------
@@ -181,22 +181,22 @@ Display Refresh Rate Switching (DRRS)
    :doc: Display Refresh Rate Switching (DRRS)
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
-   :functions: intel_dp_set_drrs_state
+   :specific: intel_dp_set_drrs_state
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
-   :functions: intel_edp_drrs_enable
+   :specific: intel_edp_drrs_enable
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
-   :functions: intel_edp_drrs_disable
+   :specific: intel_edp_drrs_disable
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
-   :functions: intel_edp_drrs_invalidate
+   :specific: intel_edp_drrs_invalidate
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
-   :functions: intel_edp_drrs_flush
+   :specific: intel_edp_drrs_flush
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
-   :functions: intel_dp_drrs_init
+   :specific: intel_dp_drrs_init
 
 DPIO
 ----
@@ -492,21 +492,21 @@ This section covers the entrypoints exported outside of i915_perf.c to
 integrate with drm/i915 and to handle the `DRM_I915_PERF_OPEN` ioctl.
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_init
+   :specific: i915_perf_init
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_fini
+   :specific: i915_perf_fini
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_register
+   :specific: i915_perf_register
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_unregister
+   :specific: i915_perf_unregister
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_open_ioctl
+   :specific: i915_perf_open_ioctl
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_release
+   :specific: i915_perf_release
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_add_config_ioctl
+   :specific: i915_perf_add_config_ioctl
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_remove_config_ioctl
+   :specific: i915_perf_remove_config_ioctl
 
 i915 Perf Stream
 ----------------
@@ -515,47 +515,47 @@ This section covers the stream-semantics-agnostic structures and functions
 for representing an i915 perf stream FD and associated file operations.
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_drv.h
-   :functions: i915_perf_stream
+   :specific: i915_perf_stream
 .. kernel-doc:: drivers/gpu/drm/i915/i915_drv.h
-   :functions: i915_perf_stream_ops
+   :specific: i915_perf_stream_ops
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: read_properties_unlocked
+   :specific: read_properties_unlocked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_open_ioctl_locked
+   :specific: i915_perf_open_ioctl_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_destroy_locked
+   :specific: i915_perf_destroy_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_read
+   :specific: i915_perf_read
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_ioctl
+   :specific: i915_perf_ioctl
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_enable_locked
+   :specific: i915_perf_enable_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_disable_locked
+   :specific: i915_perf_disable_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_poll
+   :specific: i915_perf_poll
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_poll_locked
+   :specific: i915_perf_poll_locked
 
 i915 Perf Observation Architecture Stream
 -----------------------------------------
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_drv.h
-   :functions: i915_oa_ops
+   :specific: i915_oa_ops
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_stream_init
+   :specific: i915_oa_stream_init
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_read
+   :specific: i915_oa_read
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_stream_enable
+   :specific: i915_oa_stream_enable
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_stream_disable
+   :specific: i915_oa_stream_disable
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_wait_unlocked
+   :specific: i915_oa_wait_unlocked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_poll_wait
+   :specific: i915_oa_poll_wait
 
 All i915 Perf Internals
 -----------------------
diff --git a/Documentation/gpu/vga-switcheroo.rst b/Documentation/gpu/vga-switcheroo.rst
index cbbdb994f1dd..d490b01919fd 100644
--- a/Documentation/gpu/vga-switcheroo.rst
+++ b/Documentation/gpu/vga-switcheroo.rst
@@ -35,31 +35,31 @@ Public structures
 -----------------
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_handler
+   :specific: vga_switcheroo_handler
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_client_ops
+   :specific: vga_switcheroo_client_ops
 
 Public constants
 ----------------
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_handler_flags_t
+   :specific: vga_switcheroo_handler_flags_t
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_client_id
+   :specific: vga_switcheroo_client_id
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_state
+   :specific: vga_switcheroo_state
 
 Private structures
 ------------------
 
 .. kernel-doc:: drivers/gpu/vga/vga_switcheroo.c
-   :functions: vgasr_priv
+   :specific: vgasr_priv
 
 .. kernel-doc:: drivers/gpu/vga/vga_switcheroo.c
-   :functions: vga_switcheroo_client
+   :specific: vga_switcheroo_client
 
 Handlers
 ========
diff --git a/Documentation/security/tpm/tpm_vtpm_proxy.rst b/Documentation/security/tpm/tpm_vtpm_proxy.rst
index ea08e76b17f5..8583cd970393 100644
--- a/Documentation/security/tpm/tpm_vtpm_proxy.rst
+++ b/Documentation/security/tpm/tpm_vtpm_proxy.rst
@@ -47,4 +47,4 @@ UAPI
 .. kernel-doc:: include/uapi/linux/vtpm_proxy.h
 
 .. kernel-doc:: drivers/char/tpm/tpm_vtpm_proxy.c
-   :functions: vtpmx_ioc_new_dev
+   :specific: vtpmx_ioc_new_dev
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 1159405cb920..1232d0324927 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -59,7 +59,7 @@ class KernelDocDirective(Directive):
     optional_arguments = 4
     option_spec = {
         'doc': directives.unchanged_required,
-        'functions': directives.unchanged,
+        'specific': directives.unchanged,
         'export': directives.unchanged,
         'internal': directives.unchanged,
     }
@@ -84,15 +84,15 @@ class KernelDocDirective(Directive):
         elif 'internal' in self.options:
             cmd += ['-internal']
             export_file_patterns = str(self.options.get('internal')).split()
-        elif 'doc' in self.options:
-            cmd += ['-function', str(self.options.get('doc'))]
-        elif 'functions' in self.options:
-            functions = self.options.get('functions').split()
+        elif 'specific' in self.options:
+            functions = self.options.get('specific').split()
             if functions:
                 for f in functions:
                     cmd += ['-function', f]
             else:
                 cmd += ['-no-doc-sections']
+        elif 'doc' in self.options:
+            cmd += ['-function', str(self.options.get('doc'))]
 
         for pattern in export_file_patterns:
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index a4ecd8f27631..1a4a3c3774e9 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -535,7 +535,7 @@ functions: *function* *[...]*
   Esempio::
 
     .. kernel-doc:: lib/bitmap.c
-       :functions: bitmap_parselist bitmap_parselist_user
+       :specific: bitmap_parselist bitmap_parselist_user
 
 Senza alcuna opzione, la direttiva kernel-doc include tutti i commenti di
 documentazione presenti nel file sorgente (*source*).
diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index d32016d9be2c..c518a7985ce1 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -80,7 +80,7 @@ The frequency of such scans is defined by
 Reference
 ---------
 .. kernel-doc:: mm/ksm.c
-   :functions: mm_slot ksm_scan stable_node rmap_item
+   :specific: mm_slot ksm_scan stable_node rmap_item
 
 --
 Izik Eidus,
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 81dc91760b23..cd3d2ca52c34 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1475,8 +1475,13 @@ sub push_parameter($$$$) {
 		$parameterdescs{$param} = $undescribed;
 
 	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
-			print STDERR
-			      "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
+			if ($decl_type eq "struct" or $decl_type eq 'union') {
+				print STDERR
+					"${file}:$.: warning: $decl_type member '$param' not described in '$declaration_name'\n";
+			} else {
+				print STDERR
+					"${file}:$.: warning: $decl_type parameter '$param' not described in '$declaration_name'\n";
+			}
 			++$warnings;
 		}
 	}
-- 
2.20.1

