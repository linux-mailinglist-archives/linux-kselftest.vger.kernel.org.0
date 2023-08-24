Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA17787855
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 21:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbjHXTC1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243140AbjHXTCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 15:02:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F21BD1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 12:02:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d4ddbcbbaacso193072276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692903733; x=1693508533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx340rzR37N/8Iu1QfEC/CKLJa2u6uPAvzthd3iK7gY=;
        b=ETT46jZfx//Q4RZ6+TogOhGETRUnbJeiCFNaGaFwpFBWEr0all6ICVjf6fe+F6Coa0
         ZmxIWviGUn06gdaCsUIROnN/NRbUQYmpXQCXQkCk4aSDK6Sq3473mIoKZjq8YyqBq/xB
         MdM0s+z9p7Kun01mYxqoWUCvefDudsTymBnWE8te7lW1TSztYyoQqb8gElvUTCbfhaJE
         +Bwg5nlE1i5ltGO/CihkUs0fzOqvPy0ph69PGypVOQVv+5sLZyueNPiVfcAkJRFFXs5/
         dvQ9uX5/2yy4L6B1OIE5RrZxE+mz7wKpAye1UX3W5jiFxtrV9hD37cPE5fuPqvontodZ
         /pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903733; x=1693508533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx340rzR37N/8Iu1QfEC/CKLJa2u6uPAvzthd3iK7gY=;
        b=DHHcc24uXknctrjCf/eh02MaLbMpnwTEqOvYpimxxoDjt9LEicUE09V9RhZShoqeAO
         FMTSHBz5zk7yb4z6GpkxxHM2/iWStckRCHpxaoQHpcUTXnQagVYXchN707od6WgqlBLj
         Hz5adMckyB/yQ6HHAp5pyV+FS4vTxp8zBgUcdWo+5xrgkhXOBp/ymizzmUYaA9dTu/gn
         oPs1XwXuio6M3h3tr/TGY2oL1a0ot7gxXBdeFxuGAx9IWjUdhHdkNUlZ+APcBSphaGRJ
         GfGZd0YH/VmsfteFVu2bQlQDSTjdDeVniaghslGVfODIqpi0kKZGUNn/mIvmh+As8+0b
         I03Q==
X-Gm-Message-State: AOJu0Yy0BL+/xsWQx8OtNpcCSy2I2Ip3E/e3l2R9vR2qlh+gcHjiLqC3
        MZGtDOb4uNarsU5P8blaA3OSn8gTbec=
X-Google-Smtp-Source: AGHT+IFnc3+Uw7Y/mEmSjnh//QQ+uJNXMFI26MM38yZFZIYgYIi25gtvpn6ANL4VuIIhCAvnCwR8LQexzfQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:290:b0:d48:c04:f256 with SMTP id
 v16-20020a056902029000b00d480c04f256mr239786ybh.11.1692903733416; Thu, 24 Aug
 2023 12:02:13 -0700 (PDT)
Date:   Thu, 24 Aug 2023 12:02:11 -0700
In-Reply-To: <20230821194411.2165757-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230821194411.2165757-1-ackerleytng@google.com>
Message-ID: <ZOepM0jZooyCppUs@google.com>
Subject: Re: [PATCH] KVM: selftests: Add tests - invalid inputs for KVM_CREATE_GUEST_MEMFD
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, shuah@kernel.org,
        andrew.jones@linux.dev, ricarkol@google.com,
        chao.p.peng@linux.intel.com, tabba@google.com, jarkko@kernel.org,
        yu.c.zhang@linux.intel.com, vannapurve@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 21, 2023, Ackerley Tng wrote:
> Test that invalid inputs for KVM_CREATE_GUEST_MEMFD, such as
> non-page-aligned page size and invalid flags, are rejected by the
> KVM_CREATE_GUEST_MEMFD with EINVAL
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 33 +++++++++++++++++++
>  .../selftests/kvm/include/kvm_util_base.h     | 11 +++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index eb93c608a7e0..a8e37f001297 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -90,6 +90,37 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
>  	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
>  }
>  
> +static void test_create_guest_memfd_invalid(struct kvm_vm *vm, size_t page_size)
> +{
> +	int fd;
> +	uint64_t size;

This should be size_t.

> +	uint64_t flags;
> +	uint64_t valid_flags = 0;

Revert fir/xmas-tree please.

> +
> +	for (size = 1; size < page_size; size++) {
> +		fd = __vm_create_guest_memfd(vm, size, 0);
> +		TEST_ASSERT(

No, bad Google3, bad.  Never immediately wrap after an opening parenthesis.

> +			fd == -1,
> +			"Creating guest memfds with non-page-aligned page sizes should fail");
> +		TEST_ASSERT(errno == EINVAL, "... and errno should be set to EINVAL");

Don't split/delay "errno" checks, it's all too easy for errno to get clobbered.
And there's absolutely zero reason to split these, the ret+errno get printed so
the odds of what went wrong not being super duper obvious are very low.  What
_is_ worth printing is the size.

> +	}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	valid_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
> +#endif

Ugh, this is annoying.  But HPAGE_PMD_SIZE wrapping with CONFIG_TRANSPARENT_HUGEPAGE
and so guest_memfd() can't (easily) enforce the alignment check if THP is disabled,
i.e. always letting userspace specify KVM_GUEST_MEMFD_ALLOW_HUGEPAGE would be
messy.

Oh!  And we should also test for unaligned huge pages, i.e. multiples of page_size
that aren't PMD-aligned.  At that point, I would say don't pass in @page_size to
this particular testcase, e.g. have main() be something like this:

	vm = vm_create_barebones();

	test_create_guest_memfd_invalid(vm);

	page_size = getpagesize();
	total_size = page_size * 4;
	fd = vm_create_guest_memfd(vm, total_size, 0);

	test_file_read_write(fd);
	test_mmap(fd, page_size);
	test_file_size(fd, page_size, total_size);
	test_fallocate(fd, page_size, total_size);

And then in here, use get_trans_hugepagesz() to do negative testing of
KVM_GUEST_MEMFD_ALLOW_HUGEPAGE.

> +
> +	for (flags = 1; flags; flags <<= 1) {
> +		if (flags & valid_flags)

This only ever tests one flag in isolation, e.g. if it would detect if KVM did
something ridiculous like

	if (flags && !(flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE))
		return -EINVAL;

Iterating over all possible values doesn't make sense, and giving "lower" flags
preference is likewise a bit silly, so what if we do (note the s/flags/flag)

	for (flag = 1; flag; flag <<= 1) {
		if (flag & valid_flags)
			continue;

		fd = __vm_create_guest_memfd(vm, page_size, flag);
		TEST_ASSERT(fd == -1 && errno == EINVAL,
			    "guest_memfd() with flags '0x%llx' should fail with EINVAL", flag);

		for_each_set_bit(bit, &valid_flags, 64) {
			fd = __vm_create_guest_memfd(vm, page_size, flag | BIT_ULL(bit));
			TEST_ASSERT(fd == -1 && errno == EINVAL,
				    "guest_memfd() with flags '0x%llx' should fail with EINVAL",
			    	    flag | BIT_ULL(bit));
		}
	}

i.e. test the invalid flag in isolation, and then also test it in combination with
each valid flag.  It's from from exhaustive, but it'll at least ensure we have *some*
coverage if/when new flags come along.
