Return-Path: <linux-kselftest+bounces-8939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285E8B4056
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48991F2112C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37818C19;
	Fri, 26 Apr 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIvvgFLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F552C859
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160839; cv=none; b=tS4+q+GQCh+d0OcVZ+d1omsfGAeKmzCQMpGUuDnmyLu8MfQij1pdzoDAj67zJ+Ls6sLykzgoLVsgqKVCEL4WVzeKBVDsDqoUleMlvE0jKtQHnYsklmhrOxMXoGXVVGMPmvI7sfYHrGgt8bmsrdw1RCf95KQ4TSoh0PqXEf/XUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160839; c=relaxed/simple;
	bh=/FUsKXplFS5G+mv1I9uRwhnH2LAGbeIziLvbqUJgnn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apj8j0RzBrX56FrMjWg+jSsHMn4XLs/RpAiSKhEIsIMjJRWkgv0iEA2aI08i4atyWrAnabSXm619boASIVN+0TINnbouK/5yBQ76CRmlZdoq/HOBCBURrspRvkpheaquYyz6VIOph1mfRJEnbYCad+J9IvYYaqyDQZz417R6PWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kIvvgFLe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e51398cc4eso23696595ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714160837; x=1714765637; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y1PXJEglPxUxkKUKfy/PB/vy8kF4Fex+GErBWeL36ZQ=;
        b=kIvvgFLeeT2wohSa/Mp3J9rcU5HWPFLCJ/hiaahgDtxeVI22Owj86do+hzrbbT6kkv
         vWsdKmh+yaimxmH+EH1eynkciOJMX8fbaP2ih37UC661v4iXaMxTEVM7m7EHXKCEwoUP
         TtsCEnlYQF79+1TOxJQKUeL/MahDkyra3S8W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160837; x=1714765637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1PXJEglPxUxkKUKfy/PB/vy8kF4Fex+GErBWeL36ZQ=;
        b=bJi1pmethyXN2eL42kG98TCUdl8p7aWDvkSUgUISXoTYXkO/jrs4/cK0fyzQXOXIXC
         8h9LAjR/9o4agIhWrxKl0eViWgc83JiFlBcYFRQrSU50C7fT8DW4wFf5lBzyFs1TPieI
         Vmy/gifQSZJ8FaRCA6aC9nuMYE16SiaCObYb+1GLQeeWiSEEDDLgQxrguuD6pWPn+hkD
         W5CK6Dw8M7vDr1fvFLk4pt/q98yeW6S0JZBuPqXDIahKnRhJAanxRIwSJR1vhqO6L2U2
         UHANaAIXsujHBqfeEiNyUPczni0kxvuKdysXgzq+X9dIhdq2648dDRGgcmrTEZhaTMwC
         b7fA==
X-Forwarded-Encrypted: i=1; AJvYcCUTWBx97T4b7/i7BY88pvur0wmKXcrDFsWi8WrIJqkzprwW2XZ4LH9lkhcGbz6LDgTyRSBPFRQ/tfXU6nW8SNWkbiiE3NaJoJe3UagVz4wn
X-Gm-Message-State: AOJu0YztbQz/6LUo+yEWGf9LP/75IGypbWsSwAnMiL+7ZV6FqmwO/d91
	j9+Y8ZVRQ/UuyE6Bb9LIW3bKGbwD314oyvI7Rz08OvgzPW7/f7WvpSg0ZqwM8g==
X-Google-Smtp-Source: AGHT+IF6lSJvrbDQz6rgfKFLfRsKY4KRFFqD1YgE/QSVUbTJHDVBsJx2DrgUL0N0+atnGo1r5FGDdw==
X-Received: by 2002:a17:902:a518:b0:1e4:51ab:fffb with SMTP id s24-20020a170902a51800b001e451abfffbmr4214061plq.25.1714160837225;
        Fri, 26 Apr 2024 12:47:17 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001d8f111804asm16127066plb.113.2024.04.26.12.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:47:16 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:47:16 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 5/5] selftests/harness: Fix vfork() side effects and
 uncaught errors
Message-ID: <202404261245.DC9A268FF@keescook>
References: <20240426172252.1862930-1-mic@digikod.net>
 <20240426172252.1862930-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426172252.1862930-6-mic@digikod.net>

On Fri, Apr 26, 2024 at 07:22:52PM +0200, Micka�l Sala�n wrote:
> Setting the time namespace with CLONE_NEWTIME returns -EUSERS if the
> calling thread shares memory with another thread (because of the shared
> vDSO), which is the case when it is created with vfork().
> 
> Fix pidfd_setns_test by replacing test harness's vfork() call with a
> clone3() call with CLONE_VFORK, and an explicit sharing of the
> __test_metadata and self objects.
> 
> Replace _metadata->teardown_parent with a new FIXTURE_TEARDOWN_PARENT()
> helper that can replace FIXTURE_TEARDOWN().  This is a cleaner approach
> and it enables to selectively share the fixture data between the child
> process running tests and the parent process running the fixture
> teardown.  This also avoids updating several tests to not rely on the
> self object's copy-on-write property (e.g. storing the returned value of
> a fork() call).
> 
> In the Landlock filesystem tests, don't allocate self->dir_path in the
> test process because this would not be visible in the
> FIXTURE_TEARDOWN_PARENT() process when not sharing the memory mapping.
> 
> Unconditionally share _metadata between all forked processes, which
> enables to actually catch errors (which were previously ignored).
> 
> Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
> which is now actually tested on the parent and child sides.
> 
> FIXTURE_VARIANT_ADD() doesn't need to be MAP_SHARED because it should
> not be modified: it is already passed as const pointers to
> FIXTURE_TEARDOWN().  Make that explicit by constifying the variants
> declarations.

This patch makes at least(?) 3 different logical changes. Can you split
these up a bit; I think it would make review a bit easier.

I don't quite understand why the need for the explicit shared memory
setup for the fixture metadata? Is this to deal with the vfork?

-Kees

> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: G�nther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com
> Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> Signed-off-by: Micka�l Sala�n <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240426172252.1862930-6-mic@digikod.net
> ---
>  tools/testing/selftests/kselftest_harness.h   | 88 +++++++++++++------
>  tools/testing/selftests/landlock/fs_test.c    | 73 ++++++++-------
>  .../selftests/pidfd/pidfd_setns_test.c        |  2 +-
>  3 files changed, 103 insertions(+), 60 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index d2dd246a3843..a19d01c0b7a7 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -295,6 +295,32 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
>   * A bare "return;" statement may be used to return early.
>   */
>  #define FIXTURE_TEARDOWN(fixture_name) \
> +	static const bool fixture_name##_teardown_parent = false; \
> +	__FIXTURE_TEARDOWN(fixture_name)
> +
> +/**
> + * FIXTURE_TEARDOWN_PARENT()
> + * *_metadata* is included so that EXPECT_*, ASSERT_* etc. work correctly.
> + *
> + * @fixture_name: fixture name
> + *
> + * .. code-block:: c
> + *
> + *     FIXTURE_TEARDOWN_PARENT(fixture_name) { implementation }
> + *
> + * Same as FIXTURE_TEARDOWN() but run this code in a parent process.  This
> + * enables the test process to drop its privileges without impacting the
> + * related FIXTURE_TEARDOWN_PARENT() (e.g. to remove files from a directory
> + * where write access was dropped).
> + *
> + * To make it possible for the parent process to use *self*, share (MAP_SHARED)
> + * the fixture data between all forked processes.
> + */
> +#define FIXTURE_TEARDOWN_PARENT(fixture_name) \
> +	static const bool fixture_name##_teardown_parent = true; \
> +	__FIXTURE_TEARDOWN(fixture_name)
> +
> +#define __FIXTURE_TEARDOWN(fixture_name) \
>  	void fixture_name##_teardown( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
>  		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
> @@ -339,7 +365,7 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
>   * variant.
>   */
>  #define FIXTURE_VARIANT_ADD(fixture_name, variant_name) \
> -	extern FIXTURE_VARIANT(fixture_name) \
> +	extern const FIXTURE_VARIANT(fixture_name) \
>  		_##fixture_name##_##variant_name##_variant; \
>  	static struct __fixture_variant_metadata \
>  		_##fixture_name##_##variant_name##_object = \
> @@ -351,7 +377,7 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
>  		__register_fixture_variant(&_##fixture_name##_fixture_object, \
>  			&_##fixture_name##_##variant_name##_object);	\
>  	} \
> -	FIXTURE_VARIANT(fixture_name) \
> +	const FIXTURE_VARIANT(fixture_name) \
>  		_##fixture_name##_##variant_name##_variant =
>  
>  /**
> @@ -369,10 +395,11 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
>   * Very similar to TEST() except that *self* is the setup instance of fixture's
>   * datatype exposed for use by the implementation.
>   *
> - * The @test_name code is run in a separate process sharing the same memory
> - * (i.e. vfork), which means that the test process can update its privileges
> - * without impacting the related FIXTURE_TEARDOWN() (e.g. to remove files from
> - * a directory where write access was dropped).
> + * The __test_metadata object is shared (MAP_SHARED) with all the potential
> + * forked processes, which enables them to use EXCEPT_*() and ASSERT_*().
> + *
> + * The *self* object is only shared with the potential forked processes if
> + * FIXTURE_TEARDOWN_PARENT() is used instead of FIXTURE_TEARDOWN().
>   */
>  #define TEST_F(fixture_name, test_name) \
>  	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
> @@ -393,57 +420,65 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
>  		struct __fixture_variant_metadata *variant) \
>  	{ \
>  		/* fixture data is alloced, setup, and torn down per call. */ \
> -		FIXTURE_DATA(fixture_name) self; \
> +		FIXTURE_DATA(fixture_name) self_private, *self = NULL; \
>  		pid_t child = 1; \
>  		int status = 0; \
>  		/* Makes sure there is only one teardown, even when child forks again. */ \
>  		bool *teardown = mmap(NULL, sizeof(*teardown), \
>  			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
>  		*teardown = false; \
> -		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
> +		if (sizeof(*self) > 0) { \
> +			if (fixture_name##_teardown_parent) { \
> +				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
> +					MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
> +			} else { \
> +				memset(&self_private, 0, sizeof(self_private)); \
> +				self = &self_private; \
> +			} \
> +		} \
>  		if (setjmp(_metadata->env) == 0) { \
> -			/* Use the same _metadata. */ \
> -			child = vfork(); \
> +			/* _metadata and potentially self are shared with all forks. */ \
> +			child = clone3_vfork(); \
>  			if (child == 0) { \
> -				fixture_name##_setup(_metadata, &self, variant->data); \
> +				fixture_name##_setup(_metadata, self, variant->data); \
>  				/* Let setup failure terminate early. */ \
>  				if (_metadata->exit_code) \
>  					_exit(0); \
>  				_metadata->setup_completed = true; \
> -				fixture_name##_##test_name(_metadata, &self, variant->data); \
> +				fixture_name##_##test_name(_metadata, self, variant->data); \
>  			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
>  				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
>  				_metadata->exit_code = KSFT_FAIL; \
>  			} \
>  		} \
>  		if (child == 0) { \
> -			if (_metadata->setup_completed && !_metadata->teardown_parent && \
> +			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
>  					__sync_bool_compare_and_swap(teardown, false, true)) \
> -				fixture_name##_teardown(_metadata, &self, variant->data); \
> +				fixture_name##_teardown(_metadata, self, variant->data); \
>  			_exit(0); \
>  		} \
> -		if (_metadata->setup_completed && _metadata->teardown_parent && \
> +		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
>  				__sync_bool_compare_and_swap(teardown, false, true)) \
> -			fixture_name##_teardown(_metadata, &self, variant->data); \
> +			fixture_name##_teardown(_metadata, self, variant->data); \
>  		munmap(teardown, sizeof(*teardown)); \
> +		if (self && fixture_name##_teardown_parent) \
> +			munmap(self, sizeof(*self)); \
>  		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
>  			/* Forward signal to __wait_for_test(). */ \
>  			kill(getpid(), WTERMSIG(status)); \
>  		__test_check_assert(_metadata); \
>  	} \
> -	static struct __test_metadata \
> -		      _##fixture_name##_##test_name##_object = { \
> -		.name = #test_name, \
> -		.fn = &wrapper_##fixture_name##_##test_name, \
> -		.fixture = &_##fixture_name##_fixture_object, \
> -		.termsig = signal, \
> -		.timeout = tmout, \
> -		.teardown_parent = false, \
> -	 }; \
>  	static void __attribute__((constructor)) \
>  			_register_##fixture_name##_##test_name(void) \
>  	{ \
> -		__register_test(&_##fixture_name##_##test_name##_object); \
> +		struct __test_metadata *object = mmap(NULL, sizeof(*object), \
> +			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
> +		object->name = #test_name; \
> +		object->fn = &wrapper_##fixture_name##_##test_name; \
> +		object->fixture = &_##fixture_name##_fixture_object; \
> +		object->termsig = signal; \
> +		object->timeout = tmout; \
> +		__register_test(object); \
>  	} \
>  	static void fixture_name##_##test_name( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
> @@ -898,7 +933,6 @@ struct __test_metadata {
>  	bool timed_out;	/* did this test timeout instead of exiting? */
>  	bool aborted;	/* stopped test due to failed ASSERT */
>  	bool setup_completed; /* did setup finish? */
> -	bool teardown_parent; /* run teardown in a parent process */
>  	jmp_buf env;	/* for exiting out of test early */
>  	struct __test_results *results;
>  	struct __test_metadata *prev, *next;
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 46b9effd53e4..27744524df51 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -9,6 +9,7 @@
>  
>  #define _GNU_SOURCE
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
>  #include <sched.h>
> @@ -285,8 +286,6 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
>  
>  static void prepare_layout(struct __test_metadata *const _metadata)
>  {
> -	_metadata->teardown_parent = true;
> -
>  	prepare_layout_opt(_metadata, &mnt_tmp);
>  }
>  
> @@ -315,7 +314,7 @@ FIXTURE_SETUP(layout0)
>  	prepare_layout(_metadata);
>  }
>  
> -FIXTURE_TEARDOWN(layout0)
> +FIXTURE_TEARDOWN_PARENT(layout0)
>  {
>  	cleanup_layout(_metadata);
>  }
> @@ -378,7 +377,7 @@ FIXTURE_SETUP(layout1)
>  	create_layout1(_metadata);
>  }
>  
> -FIXTURE_TEARDOWN(layout1)
> +FIXTURE_TEARDOWN_PARENT(layout1)
>  {
>  	remove_layout1(_metadata);
>  
> @@ -3691,7 +3690,7 @@ FIXTURE_SETUP(ftruncate)
>  	create_file(_metadata, file1_s1d1);
>  }
>  
> -FIXTURE_TEARDOWN(ftruncate)
> +FIXTURE_TEARDOWN_PARENT(ftruncate)
>  {
>  	EXPECT_EQ(0, remove_path(file1_s1d1));
>  	cleanup_layout(_metadata);
> @@ -3869,7 +3868,7 @@ FIXTURE_SETUP(layout1_bind)
>  	clear_cap(_metadata, CAP_SYS_ADMIN);
>  }
>  
> -FIXTURE_TEARDOWN(layout1_bind)
> +FIXTURE_TEARDOWN_PARENT(layout1_bind)
>  {
>  	/* umount(dir_s2d2)) is handled by namespace lifetime. */
>  
> @@ -4274,7 +4273,7 @@ FIXTURE_SETUP(layout2_overlay)
>  	clear_cap(_metadata, CAP_SYS_ADMIN);
>  }
>  
> -FIXTURE_TEARDOWN(layout2_overlay)
> +FIXTURE_TEARDOWN_PARENT(layout2_overlay)
>  {
>  	if (self->skip_test)
>  		SKIP(return, "overlayfs is not supported (teardown)");
> @@ -4624,7 +4623,6 @@ FIXTURE(layout3_fs)
>  {
>  	bool has_created_dir;
>  	bool has_created_file;
> -	char *dir_path;
>  	bool skip_test;
>  };
>  
> @@ -4683,11 +4681,24 @@ FIXTURE_VARIANT_ADD(layout3_fs, hostfs) {
>  	.cwd_fs_magic = HOSTFS_SUPER_MAGIC,
>  };
>  
> +static char *dirname_alloc(const char *path)
> +{
> +	char *dup;
> +
> +	if (!path)
> +		return NULL;
> +
> +	dup = strdup(path);
> +	if (!dup)
> +		return NULL;
> +
> +	return dirname(dup);
> +}
> +
>  FIXTURE_SETUP(layout3_fs)
>  {
>  	struct stat statbuf;
> -	const char *slash;
> -	size_t dir_len;
> +	char *dir_path = dirname_alloc(variant->file_path);
>  
>  	if (!supports_filesystem(variant->mnt.type) ||
>  	    !cwd_matches_fs(variant->cwd_fs_magic)) {
> @@ -4695,27 +4706,15 @@ FIXTURE_SETUP(layout3_fs)
>  		SKIP(return, "this filesystem is not supported (setup)");
>  	}
>  
> -	_metadata->teardown_parent = true;
> -
> -	slash = strrchr(variant->file_path, '/');
> -	ASSERT_NE(slash, NULL);
> -	dir_len = (size_t)slash - (size_t)variant->file_path;
> -	ASSERT_LT(0, dir_len);
> -	self->dir_path = malloc(dir_len + 1);
> -	self->dir_path[dir_len] = '\0';
> -	strncpy(self->dir_path, variant->file_path, dir_len);
> -
>  	prepare_layout_opt(_metadata, &variant->mnt);
>  
>  	/* Creates directory when required. */
> -	if (stat(self->dir_path, &statbuf)) {
> +	if (stat(dir_path, &statbuf)) {
>  		set_cap(_metadata, CAP_DAC_OVERRIDE);
> -		EXPECT_EQ(0, mkdir(self->dir_path, 0700))
> +		EXPECT_EQ(0, mkdir(dir_path, 0700))
>  		{
>  			TH_LOG("Failed to create directory \"%s\": %s",
> -			       self->dir_path, strerror(errno));
> -			free(self->dir_path);
> -			self->dir_path = NULL;
> +			       dir_path, strerror(errno));
>  		}
>  		self->has_created_dir = true;
>  		clear_cap(_metadata, CAP_DAC_OVERRIDE);
> @@ -4736,9 +4735,11 @@ FIXTURE_SETUP(layout3_fs)
>  		self->has_created_file = true;
>  		clear_cap(_metadata, CAP_DAC_OVERRIDE);
>  	}
> +
> +	free(dir_path);
>  }
>  
> -FIXTURE_TEARDOWN(layout3_fs)
> +FIXTURE_TEARDOWN_PARENT(layout3_fs)
>  {
>  	if (self->skip_test)
>  		SKIP(return, "this filesystem is not supported (teardown)");
> @@ -4754,16 +4755,17 @@ FIXTURE_TEARDOWN(layout3_fs)
>  	}
>  
>  	if (self->has_created_dir) {
> +		char *dir_path = dirname_alloc(variant->file_path);
> +
>  		set_cap(_metadata, CAP_DAC_OVERRIDE);
>  		/*
>  		 * Don't check for error because the directory might already
>  		 * have been removed (cf. release_inode test).
>  		 */
> -		rmdir(self->dir_path);
> +		rmdir(dir_path);
>  		clear_cap(_metadata, CAP_DAC_OVERRIDE);
> +		free(dir_path);
>  	}
> -	free(self->dir_path);
> -	self->dir_path = NULL;
>  
>  	cleanup_layout(_metadata);
>  }
> @@ -4830,7 +4832,10 @@ TEST_F_FORK(layout3_fs, tag_inode_dir_mnt)
>  
>  TEST_F_FORK(layout3_fs, tag_inode_dir_child)
>  {
> -	layer3_fs_tag_inode(_metadata, self, variant, self->dir_path);
> +	char *dir_path = dirname_alloc(variant->file_path);
> +
> +	layer3_fs_tag_inode(_metadata, self, variant, dir_path);
> +	free(dir_path);
>  }
>  
>  TEST_F_FORK(layout3_fs, tag_inode_file)
> @@ -4857,9 +4862,13 @@ TEST_F_FORK(layout3_fs, release_inodes)
>  	if (self->has_created_file)
>  		EXPECT_EQ(0, remove_path(variant->file_path));
>  
> -	if (self->has_created_dir)
> +	if (self->has_created_dir) {
> +		char *dir_path = dirname_alloc(variant->file_path);
> +
>  		/* Don't check for error because of cgroup specificities. */
> -		remove_path(self->dir_path);
> +		remove_path(dir_path);
> +		free(dir_path);
> +	}
>  
>  	ruleset_fd =
>  		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, layer1);
> diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> index 6e2f2cd400ca..47746b0c6acd 100644
> --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> @@ -158,7 +158,7 @@ FIXTURE_SETUP(current_nsset)
>  	/* Create task that exits right away. */
>  	self->child_pid_exited = create_child(&self->child_pidfd_exited,
>  					      CLONE_NEWUSER | CLONE_NEWNET);
> -	EXPECT_GT(self->child_pid_exited, 0);
> +	EXPECT_GE(self->child_pid_exited, 0);
>  
>  	if (self->child_pid_exited == 0)
>  		_exit(EXIT_SUCCESS);
> -- 
> 2.44.0
> 

-- 
Kees Cook

