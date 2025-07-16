Return-Path: <linux-kselftest+bounces-37451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6AB08085
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 00:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F63F7A1CA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F28291C35;
	Wed, 16 Jul 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diKb9C16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9426A0DF
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704933; cv=none; b=qG9Y8bcKId/N/c0zUSU+YLg84n1vBEDpbPLXbtcMtyBFN8WB0lOAZEifVtf/xk1z7mS5MTPgS88GN87RWHGE8fIeXyR85uSRgX8eOG2Fq2i0U+oj0DrnqYRWZNtMb568N/vvGcpND+3Tu3bWnsCvKh3sViHnxCZbQtSgkTh5MkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704933; c=relaxed/simple;
	bh=ykOgo4+A9qk5wgoO8dpUtvcXviSdygtbrOBUfEIyyGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TWjmRkptdl/aqkh3XbZ82J/rblKVh1uWN5Gqmh0nHIwqtpjeY9ZSTSDtH3/EE5D3K2+QKBBwXeqUfywSlEDLhNXnKlr7kBxn/bmb0mej2XqGlI03JH4OM/H/pcyH1oETUr6ne3hHICqf3iHQO1xzahX0hAEggB/IIAkGlpys1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diKb9C16; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so284948a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752704931; x=1753309731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=15czGDWr7Av2AvYISrTaYu5BE5KphOq8Xz2cmMY6+AI=;
        b=diKb9C16a1LLfKia8x+8v/w2d9eZkgP0btuV64jVfHM49X3YE8FJBiaYoxKmsbN99z
         0XYXk27D+MNwStQFDMa58z7iNID5G7DPckWxRdmskDzXRZLldG67+4GxbEDIKMThes/v
         gzUJn2ovum3xnxPcpAmjnHzOwef9mzFR6VYmgXHUkg2x4rSd2O4lm379jOCVOrGXEU01
         R8M5S91e7zI266+EYEXKdjGBmHRwh5UEhAJNtSVdjSV37gmK6U0EyH3rGHn10K6RtC4z
         QBE70eCq0OqtGI+EunJ7xM5CCi6wHbAce7kXBJOXel7Ngw6o24VNm4jiGzGk9Jtvz0Qt
         WNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752704931; x=1753309731;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15czGDWr7Av2AvYISrTaYu5BE5KphOq8Xz2cmMY6+AI=;
        b=jMrAYRGy2jGJwXbU4L7MPzIaMhn1B/8DI3NwamKLfjOMDRUV50h4Gfiyv9vvN4qf6H
         5gbkFa4S2X+hnk3Yo91EUuAbV7xVOBp54nFPQ4CAC43mFQkTCWQNjD8fGT8ujp6K+ceW
         3SivfgKvR0SLSF8DJmfck2+dMN+2pwn+uQBVVbWoBMgDy6dSDsj7cVFUY7ck/wBuaMuu
         pNJLBMRpRf+vOfN4KoQcqFaCn9YDCeCdZljWrD2ke1KJC5Hd+ezz6Dn3V7/njgJrbyMh
         1HoUldXggAGE9WjGNPXxO0gK+rJnJfgo9qIfdl0HCjZbOxKJJCvfo61edVcGaYrp9O5P
         Ulhg==
X-Forwarded-Encrypted: i=1; AJvYcCVIgE+3EemNFwCNDoKSxhR6+fXem/V1ylt8NGk/hC66MqS2D+XqoyglPNyAL2X4cc5Sq2sLlU1tzppM8CIz/AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEguz2k7y/lgDu3XmvH0WSTeDu2R6V4GSgsGpN0ZcWEniMJj2k
	/mNv4OpN65NR4UYOI8ksDRWnkty2hzZyls1TSjIjY3qQ9QODUaaX8qTmXNuOQMEX5nAyUqAzTwg
	fbQehb6toWg==
X-Google-Smtp-Source: AGHT+IGlaI9dHBfTHBGYmlQ9O6eaSEOflYyGrE07FMmFWZU0MYHYTEDRhkfEO4kx9V4K+hW05Pm4fRgwkPtF
X-Received: from pja3.prod.google.com ([2002:a17:90b:5483:b0:312:1af5:98c9])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c83:b0:315:9cae:bd8
 with SMTP id 98e67ed59e1d1-31c9e76b79dmr6302352a91.23.1752704930917; Wed, 16
 Jul 2025 15:28:50 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:28:49 -0700
In-Reply-To: <202507160735.C76466BB@keescook> (Kees Cook's message of "Wed, 16
 Jul 2025 07:37:51 -0700")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-5-ynaffit@google.com>
 <202507160735.C76466BB@keescook>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8seiv4voe.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v3 4/6] binder: Scaffolding for binder_alloc KUnit tests
From: Tiffany Yang <ynaffit@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXY=?= =?utf-8?B?w6Vn?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Kees Cook <kees@kernel.org> writes:

>> ...

> I'm used to the "#ifdef CONFIG_..." idiom, but looking at the tree, I
> see that "#if IS_ENANLED(CONFIG...)" is relatively common too. I don't
> think there is a function difference, so I leave the style choice up to
> you! ;)


IIRC, I had tried using the #ifdef to inject test-specific code in some
places, but that created issues when we were loading KUnit as a module
because it causes the built-in code to be built as though the
"CONFIG_..." is undefined. Consequently, I started using IS_ENABLED by
default, but I'm not sure if it's strictly necessary for exposing
functions with a header file since I'd assume "CONFIG_..." will be
defined when we're building the module?

>> +
>>   #endif /* _LINUX_BINDER_INTERNAL_H */
>> diff --git a/drivers/android/tests/.kunitconfig  
>> b/drivers/android/tests/.kunitconfig
>> new file mode 100644
>> index 000000000000..a73601231049
>> --- /dev/null
>> +++ b/drivers/android/tests/.kunitconfig
>> @@ -0,0 +1,3 @@
>> +CONFIG_KUNIT=y
>> +CONFIG_ANDROID_BINDER_IPC=y
>> +CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=y
>> diff --git a/drivers/android/tests/Makefile  
>> b/drivers/android/tests/Makefile
>> new file mode 100644
>> index 000000000000..6780967e573b
>> --- /dev/null
>> +++ b/drivers/android/tests/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= binder_alloc_kunit.o
>> diff --git a/drivers/android/tests/binder_alloc_kunit.c  
>> b/drivers/android/tests/binder_alloc_kunit.c
>> new file mode 100644
>> index 000000000000..4b68b5687d33
>> --- /dev/null
>> +++ b/drivers/android/tests/binder_alloc_kunit.c
>> @@ -0,0 +1,166 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Test cases for binder allocator code
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <kunit/test.h>
>> +#include <linux/anon_inodes.h>
>> +#include <linux/err.h>
>> +#include <linux/file.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/mman.h>
>> +#include <linux/sizes.h>
>> +
>> +#include "../binder_alloc.h"
>> +#include "../binder_internal.h"
>> +
>> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>> +
>> +#define BINDER_MMAP_SIZE SZ_128K
>> +
>> +struct binder_alloc_test {
>> +	struct binder_alloc alloc;
>> +	struct list_lru binder_test_freelist;
>> +	struct file *filp;
>> +	unsigned long mmap_uaddr;
>> +};
>> +
>> +static void binder_alloc_test_init_freelist(struct kunit *test)
>> +{
>> +	struct binder_alloc_test *priv = test->priv;
>> +
>> +	KUNIT_EXPECT_PTR_EQ(test, priv->alloc.freelist,
>> +			    &priv->binder_test_freelist);
>> +}
>> +
>> +static void binder_alloc_test_mmap(struct kunit *test)
>> +{
>> +	struct binder_alloc_test *priv = test->priv;
>> +	struct binder_alloc *alloc = &priv->alloc;
>> +	struct binder_buffer *buf;
>> +	struct rb_node *n;
>> +
>> +	KUNIT_EXPECT_EQ(test, alloc->mapped, true);
>> +	KUNIT_EXPECT_EQ(test, alloc->buffer_size, BINDER_MMAP_SIZE);
>> +
>> +	n = rb_first(&alloc->allocated_buffers);
>> +	KUNIT_EXPECT_PTR_EQ(test, n, NULL);
>> +
>> +	n = rb_first(&alloc->free_buffers);
>> +	buf = rb_entry(n, struct binder_buffer, rb_node);
>> +	KUNIT_EXPECT_EQ(test, binder_alloc_buffer_size(alloc, buf),
>> +			BINDER_MMAP_SIZE);
>> +	KUNIT_EXPECT_TRUE(test, list_is_last(&buf->entry, &alloc->buffers));
>> +}
>> +
>> +/* ===== End test cases ===== */
>> +
>> +static void binder_alloc_test_vma_close(struct vm_area_struct *vma)
>> +{
>> +	struct binder_alloc *alloc = vma->vm_private_data;
>> +
>> +	binder_alloc_vma_close(alloc);
>> +}
>> +
>> +static const struct vm_operations_struct binder_alloc_test_vm_ops = {
>> +	.close = binder_alloc_test_vma_close,
>> +	.fault = binder_vm_fault,
>> +};
>> +
>> +static int binder_alloc_test_mmap_handler(struct file *filp,
>> +					  struct vm_area_struct *vma)
>> +{
>> +	struct binder_alloc *alloc = filp->private_data;
>> +
>> +	vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP, VM_MAYWRITE);
>> +
>> +	vma->vm_ops = &binder_alloc_test_vm_ops;
>> +	vma->vm_private_data = alloc;
>> +
>> +	return binder_alloc_mmap_handler(alloc, vma);
>> +}
>> +
>> +static const struct file_operations binder_alloc_test_fops = {
>> +	.mmap = binder_alloc_test_mmap_handler,
>> +};
>> +
>> +static int binder_alloc_test_init(struct kunit *test)
>> +{
>> +	struct binder_alloc_test *priv;
>> +	int ret;
>> +
>> +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +	test->priv = priv;
>> +
>> +	ret = list_lru_init(&priv->binder_test_freelist);
>> +	if (ret) {
>> +		kunit_err(test, "Failed to initialize test freelist\n");
>> +		return ret;
>> +	}
>> +
>> +	/* __binder_alloc_init requires mm to be attached */
>> +	ret = kunit_attach_mm();
>> +	if (ret) {
>> +		kunit_err(test, "Failed to attach mm\n");
>> +		return ret;
>> +	}
>> +	__binder_alloc_init(&priv->alloc, &priv->binder_test_freelist);
>> +
>> +	priv->filp = anon_inode_getfile("binder_alloc_kunit",
>> +					&binder_alloc_test_fops, &priv->alloc,
>> +					O_RDWR | O_CLOEXEC);
>> +	if (IS_ERR_OR_NULL(priv->filp)) {
>> +		kunit_err(test, "Failed to open binder alloc test driver file\n");
>> +		return priv->filp ? PTR_ERR(priv->filp) : -ENOMEM;
>> +	}
>> +
>> +	priv->mmap_uaddr = kunit_vm_mmap(test, priv->filp, 0, BINDER_MMAP_SIZE,
>> +					 PROT_READ, MAP_PRIVATE | MAP_NORESERVE,
>> +					 0);
>> +	if (!priv->mmap_uaddr) {
>> +		kunit_err(test, "Could not map the test's transaction memory\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void binder_alloc_test_exit(struct kunit *test)
>> +{
>> +	struct binder_alloc_test *priv = test->priv;
>> +
>> +	/* Close the backing file to make sure binder_alloc_vma_close runs */
>> +	if (!IS_ERR_OR_NULL(priv->filp))
>> +		fput(priv->filp);
>> +
>> +	if (priv->alloc.mm)
>> +		binder_alloc_deferred_release(&priv->alloc);
>> +
>> +	/* Make sure freelist is empty */
>> +	KUNIT_EXPECT_EQ(test, list_lru_count(&priv->binder_test_freelist), 0);
>> +	list_lru_destroy(&priv->binder_test_freelist);
>> +}
>> +
>> +static struct kunit_case binder_alloc_test_cases[] = {
>> +	KUNIT_CASE(binder_alloc_test_init_freelist),
>> +	KUNIT_CASE(binder_alloc_test_mmap),
>> +	{}
>> +};
>> +
>> +static struct kunit_suite binder_alloc_test_suite = {
>> +	.name = "binder_alloc",
>> +	.test_cases = binder_alloc_test_cases,
>> +	.init = binder_alloc_test_init,
>> +	.exit = binder_alloc_test_exit,
>> +};
>> +
>> +kunit_test_suite(binder_alloc_test_suite);
>> +
>> +MODULE_AUTHOR("Tiffany Yang <ynaffit@google.com>");
>> +MODULE_DESCRIPTION("Binder Alloc KUnit tests");
>> +MODULE_LICENSE("GPL");

> Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Tiffany Y. Yang

