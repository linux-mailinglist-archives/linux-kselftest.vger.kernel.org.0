Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD46C3839
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCURdQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCURdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 13:33:15 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB1166E7;
        Tue, 21 Mar 2023 10:33:05 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id f5-20020a4ad805000000b005399cfd276bso1876773oov.6;
        Tue, 21 Mar 2023 10:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CnL7hgvPnni7trOuk9467gN9OsVhQvyHsDFM8C85TE=;
        b=erKzFFARO+2sBeW5xA3ifXL+hbLFsauWD0I612nh3ZqpFHQUn5hcazqIm2ZVoC8rpd
         HUPwe4tllkl7H5QiTeuAalMF2g7HGCrjN5H8KSwOh9QaHH4lpsdnvQRSB7MLiGVCmpiQ
         zDRhtAtmtr0prA07NurpdNtx49i8Zw0vU1btnd7UnoVUMSmkIXsL8eRu5UpH9jWzLOtZ
         Fp0e6YxxGygI4B4pIAWC/vErJwGVsQZFgP53grEsUFnlrSsKiyGRlawN3tk5UFLxmOcx
         rxlKPPDwaIEqlf87HBAkFvdgRtC/vPGEGKcSs452u4JrEkxHhXSwjtQvgHv+zOGBNX2H
         NIYQ==
X-Gm-Message-State: AO0yUKVAc8qcTsk/aU9HY9GidmD8da4UIg/gaohpGG3SltfY4DMY0X6E
        +kKHxafOGrP75IlOyMdypw==
X-Google-Smtp-Source: AK7set94YgcKGUBqS/jmcEyCGuFJ245hmQff358C8dqQKs6OobLo4j5MwstfAkhefwZM+zU1beaMRw==
X-Received: by 2002:a4a:3307:0:b0:53b:68bf:ada3 with SMTP id q7-20020a4a3307000000b0053b68bfada3mr704104ooq.3.1679419984314;
        Tue, 21 Mar 2023 10:33:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y13-20020a4ad64d000000b0053b5271f030sm1204741oos.39.2023.03.21.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:33:04 -0700 (PDT)
Received: (nullmailer pid 990808 invoked by uid 1000);
        Tue, 21 Mar 2023 17:33:03 -0000
Date:   Tue, 21 Mar 2023 12:33:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 01/11] of: Load KUnit DTB from of_core_init()
Message-ID: <20230321173303.GA950598-robh@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
 <20230315183729.2376178-2-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315183729.2376178-2-sboyd@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 15, 2023 at 11:37:18AM -0700, Stephen Boyd wrote:
> Load a small DTB for KUnit from of_core_init() as long as CONFIG_OF=y
> and CONFIG_KUNIT=y/m. This allows KUnit tests to load overlays into the
> running system. It also allows KUnit tests to run on any architecture
> that supports it so that devicetree can be used while unit testing
> architecture specific code.
> 
> Overlays need a target node to apply their overlays to, so make a fake
> bus called 'kunit-bus' in the root node to allow this. Make the node a
> simple-bus so that platform devices are automatically created for nodes
> added as children of this node. Unit test overlays can target this node
> via the label 'kunit_bus'.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/.kunitconfig |   3 +
>  drivers/of/Kconfig      |  13 +++
>  drivers/of/Makefile     |   4 +
>  drivers/of/base.c       | 182 ++++++++++++++++++++++++++++++++++++++++
>  drivers/of/kunit.dtso   |  10 +++
>  drivers/of/of_private.h |   6 ++
>  drivers/of/of_test.c    |  43 ++++++++++
>  drivers/of/unittest.c   | 101 +---------------------
>  8 files changed, 262 insertions(+), 100 deletions(-)
>  create mode 100644 drivers/of/.kunitconfig
>  create mode 100644 drivers/of/kunit.dtso
>  create mode 100644 drivers/of/of_test.c
> 
> diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
> new file mode 100644
> index 000000000000..5a8fee11978c
> --- /dev/null
> +++ b/drivers/of/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_OF=y
> +CONFIG_OF_KUNIT_TEST=y
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 644386833a7b..f6739b9560c5 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -37,6 +37,19 @@ config OF_UNITTEST
>  
>  	  If unsure, say N here. This option is not safe to enable.
>  
> +config OF_KUNIT
> +	def_bool KUNIT
> +	select OF_RESOLVE
> +
> +config OF_KUNIT_TEST
> +	tristate "Devicetree KUnit DTB Test" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option builds KUnit unit tests for device tree infrastructure.
> +
> +	  If unsure, say N here, but this option is safe to enable.
> +
>  config OF_ALL_DTBS
>  	bool "Build all Device Tree Blobs"
>  	depends on COMPILE_TEST
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..cf6ee7ba6350 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -19,4 +19,8 @@ obj-y	+= kexec.o
>  endif
>  endif
>  
> +DTC_FLAGS_kunit += -@
> +obj-$(CONFIG_OF_KUNIT) += kunit.dtbo.o
> +obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
> +
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ac6fde53342f..090c5d7925e4 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -16,13 +16,16 @@
>  
>  #define pr_fmt(fmt)	"OF: " fmt
>  
> +#include <linux/align.h>
>  #include <linux/console.h>
>  #include <linux/ctype.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_fdt.h>

base.c deals with unflattened trees. There shouldn't be anything FDT 
related in it.

>  #include <linux/of_graph.h>
> +#include <linux/printk.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -163,10 +166,90 @@ void __of_phandle_cache_inv_entry(phandle handle)
>  		phandle_cache[handle_hash] = NULL;
>  }
>  
> +#ifdef CONFIG_OF_KUNIT

base.c is already quite big. This should probably be its own file. 
Perhaps in kunit code because that's what we do for everything else 
(e.g. DT clock code goes in drivers/clk/). (My goal is to eliminate 
drivers/of/. That's easier than finding maintainers. ;) )

> +static int __init of_kunit_add_data(void)
> +{
> +	void *kunit_fdt;
> +	void *kunit_fdt_align;
> +	struct device_node *kunit_node = NULL, *np;
> +	/*
> +	 * __dtbo_kunit_begin[] and __dtbo_kunit_end[] are magically
> +	 * created by cmd_dt_S_dtbo in scripts/Makefile.lib
> +	 */
> +	extern uint8_t __dtbo_kunit_begin[];
> +	extern uint8_t __dtbo_kunit_end[];
> +	const int size = __dtbo_kunit_end - __dtbo_kunit_begin;
> +	int rc;
> +	void *ret;
> +
> +	if (!size) {
> +		pr_warn("kunit.dtbo is empty\n");
> +		return -ENODATA;
> +	}
> +
> +	kunit_fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
> +	if (!kunit_fdt)
> +		return -ENOMEM;
> +
> +	kunit_fdt_align = PTR_ALIGN(kunit_fdt, FDT_ALIGN_SIZE);
> +	memcpy(kunit_fdt_align, __dtbo_kunit_begin, size);
> +
> +	ret = of_fdt_unflatten_tree(kunit_fdt_align, NULL, &kunit_node);

I don't understand why this doesn't use of_overlay_fdt_apply(). Your 
test(s) shouldn't be any different than any other overlay user (granted, 
there aren't many). You apply the overlay, run your test, then remove 
the overlay.

> +	if (!ret) {
> +		pr_warn("unflatten KUnit tree failed\n");
> +		kfree(kunit_fdt);
> +		return -ENODATA;
> +	}
> +	if (!kunit_node) {
> +		pr_warn("KUnit tree is empty\n");
> +		kfree(kunit_fdt);
> +		return -ENODATA;
> +	}
> +
> +	of_overlay_mutex_lock();
> +	rc = of_resolve_phandles(kunit_node);
> +	if (rc) {
> +		pr_err("Failed to resolve KUnit phandles (rc=%i)\n", rc);
> +		of_overlay_mutex_unlock();
> +		return -EINVAL;
> +	}
> +
> +	if (!of_root) {

There's patches from Frank and others under review which will always 
create and empty DT if the bootloader/arch didn't provide one. This 
series should rely on that. (Or just assume that when that happens, your 
tests will run in more environments)

> +		of_root = kunit_node;
> +		of_chosen = of_find_node_by_path("/chosen");
> +	} else {
> +		/* attach the sub-tree to live tree */
> +		np = kunit_node->child;
> +		while (np) {
> +			struct device_node *next = np->sibling;
> +
> +			np->parent = of_root;
> +			of_test_attach_node_and_children(np);
> +			np = next;
> +		}
> +	}
> +
> +	if (!of_aliases)
> +		of_aliases = of_find_node_by_path("/aliases");
> +
> +	of_overlay_mutex_unlock();
> +
> +	return 0;
> +}
> +#else
> +static inline int __init of_kunit_add_data(void) { return 0; }
> +#endif
> +
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
> +	int ret;
>  
> +	ret = of_kunit_add_data();
> +	if (ret) {
> +		pr_err("failed to add kunit test data\n");
> +		return;
> +	}
>  
>  	/* Create the kset, and register existing nodes */
>  	mutex_lock(&of_mutex);
> @@ -1879,6 +1962,105 @@ int of_update_property(struct device_node *np, struct property *newprop)
>  	return rc;
>  }
>  
> +#if defined(CONFIG_OF_UNITTEST) || defined (CONFIG_KUNIT)
> +/**
> + * update_node_properties - adds the properties of np into dup node (present in
> + * live tree) and updates parent of children of np to dup.
> + *
> + * @np: node whose properties are being added to the live tree
> + * @dup: node present in live tree to be updated
> + */
> +static void __init update_node_properties(struct device_node *np,
> +					struct device_node *dup)

Please split any moving of code to separate patches.

I'm not remembering why we need these test functions vs. just applying 
overlays. Frank? Perhaps because it's trying to test the overlay code 
itself. But you should just be a user of the overlay API and not need to 
do anything special.

> +{
> +	struct property *prop;
> +	struct property *save_next;
> +	struct device_node *child;
> +	int ret;
> +
> +	for_each_child_of_node(np, child)
> +		child->parent = dup;
> +
> +	/*
> +	 * "unittest internal error: unable to add testdata property"
> +	 *
> +	 *    If this message reports a property in node '/__symbols__' then
> +	 *    the respective unittest overlay contains a label that has the
> +	 *    same name as a label in the live devicetree.  The label will
> +	 *    be in the live devicetree only if the devicetree source was
> +	 *    compiled with the '-@' option.  If you encounter this error,
> +	 *    please consider renaming __all__ of the labels in the unittest
> +	 *    overlay dts files with an odd prefix that is unlikely to be
> +	 *    used in a real devicetree.
> +	 */
> +
> +	/*
> +	 * open code for_each_property_of_node() because of_add_property()
> +	 * sets prop->next to NULL
> +	 */
> +	for (prop = np->properties; prop != NULL; prop = save_next) {
> +		save_next = prop->next;
> +		ret = of_add_property(dup, prop);
> +		if (ret) {
> +			if (ret == -EEXIST && !strcmp(prop->name, "name"))
> +				continue;
> +			pr_err("unittest internal error: unable to add testdata property %pOF/%s",
> +			       np, prop->name);
> +		}
> +	}
> +}
> +
> +/**
> + * of_test_attach_node_and_children - attaches nodes and its children to live tree.
> + * @np:	Node to attach to live tree
> + *
> + * CAUTION: misleading function name - if node @np already exists in
> + * the live tree then children of @np are *not* attached to the live
> + * tree.  This works for the current test devicetree nodes because such
> + * nodes do not have child nodes.
> + */
> +void __init of_test_attach_node_and_children(struct device_node *np)
> +{
> +	struct device_node *next, *dup, *child;
> +	unsigned long flags;
> +	const char *full_name;
> +
> +	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
> +
> +	if (!strcmp(full_name, "/__local_fixups__") ||
> +	    !strcmp(full_name, "/__fixups__")) {
> +		kfree(full_name);
> +		return;
> +	}
> +
> +	dup = of_find_node_by_path(full_name);
> +	kfree(full_name);
> +	if (dup) {
> +		update_node_properties(np, dup);
> +		return;
> +	}
> +
> +	child = np->child;
> +	np->child = NULL;
> +
> +	mutex_lock(&of_mutex);
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	np->sibling = np->parent->child;
> +	np->parent->child = np;
> +	of_node_clear_flag(np, OF_DETACHED);
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +	__of_attach_node_sysfs(np);
> +	mutex_unlock(&of_mutex);
> +
> +	while (child) {
> +		next = child->sibling;
> +		of_test_attach_node_and_children(child);
> +		child = next;
> +	}
> +}
> +#endif
> +
>  static void of_alias_add(struct alias_prop *ap, struct device_node *np,
>  			 int id, const char *stem, int stem_len)
>  {
> diff --git a/drivers/of/kunit.dtso b/drivers/of/kunit.dtso
> new file mode 100644
> index 000000000000..d512057df98d
> --- /dev/null
> +++ b/drivers/of/kunit.dtso
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	/* Container node where KUnit tests can load overlays */
> +	kunit_bus: kunit-bus {
> +		compatible = "simple-bus";
> +	};
> +};

Why do we need an overlay to apply overlays to? 


> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index fb6792d381a6..2151a28ca234 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -96,6 +96,12 @@ static inline void of_overlay_mutex_lock(void) {};
>  static inline void of_overlay_mutex_unlock(void) {};
>  #endif
>  
> +#if defined(CONFIG_OF_UNITTEST) || defined (CONFIG_KUNIT)
> +void __init of_test_attach_node_and_children(struct device_node *np);
> +#else
> +static inline void __init of_test_attach_node_and_children(struct device_node *np) {}
> +#endif
> +
>  #if defined(CONFIG_OF_UNITTEST) && defined(CONFIG_OF_OVERLAY)
>  extern void __init unittest_unflatten_overlay_base(void);
>  #else
> diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
> new file mode 100644
> index 000000000000..a4d70ac344ad
> --- /dev/null
> +++ b/drivers/of/of_test.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for OF APIs
> + */
> +#include <linux/kconfig.h>
> +#include <linux/of.h>
> +
> +#include <kunit/test.h>
> +
> +/*
> + * Test that the root node / exists.
> + */
> +static void dtb_root_node_exists(struct kunit *test)
> +{
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/"));
> +}
> +
> +/*
> + * Test that the /__symbols__ node exists.
> + */
> +static void dtb_symbols_node_exists(struct kunit *test)
> +{
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/__symbols__"));
> +}

Many base DTs will not have this. And the kunit tests themselves 
shouldn't need it because they should be independent of the base tree.

Rob
