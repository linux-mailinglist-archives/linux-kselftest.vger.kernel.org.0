Return-Path: <linux-kselftest+bounces-9772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F78C0C14
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B44EB211DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78A149C53;
	Thu,  9 May 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXR0QiX2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908A149C4E;
	Thu,  9 May 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240714; cv=none; b=D9gvyYEp3iq9D07q24MtmxYRYXOM9X6j80o74OdpgUyL1mtxo0wIILhXOc9E6BP++V7SVMrv3XDVlY/Zz0UXRZn3+kFmS0aT244xy/xVcjrOHEyEDOPnux3Q+2ffxOqX/dC8aKasJ+h2aJtY7aT+/0taTaDucbhNjmyisnxI+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240714; c=relaxed/simple;
	bh=ofkwrzFtb6ZpRq3UIrAJijVaDQes2mgoEii7GdsNITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urgG4gZ/eUrh3Qn6vy78rsMQiKPrGWLZO1+DQaXTj6P/Cu2r5dvrgzQXly+YWZUXgfmd7nddQy1NbqS8SrxFf7km4FsxCBnYmIz69IquV4zkWlaGnvP1CRv3XYMv/c/azRUgPkTw83yVjCg8ErbtK1LVpBobfhdvtFbjxNrrBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXR0QiX2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715240710; x=1746776710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ofkwrzFtb6ZpRq3UIrAJijVaDQes2mgoEii7GdsNITE=;
  b=bXR0QiX2KlndHaFS725EG4lJ7nBshx1EhHOF89FT9zmGQykGuL/Qhmoz
   q1jiJY7kkF750xuHUDd3f7dT9xCJPuyzUn5tF7EImuF4BGep29tyPGP1L
   4HyHCy5Bb1HLqHcrbnsHndaJzUSoBwxff58sJx4fQihrpHlYNcq6aZim/
   d8HXHJE/A69rxFEADHTXsFmwt0fyconVglzhqjfdl4Jb7nTRbfxkzq9Mk
   fm2jKJI8l+uJIE0PGUtIcBnT6m/95tUzJWHRuQ6H+hcc4sLJ+jgGyq9Lr
   UWQg0sNDJIm8+HGANjsC17/AaUrwWBiV1rH9b8I2axLU01ZPgatdlDz0f
   w==;
X-CSE-ConnectionGUID: Vvy9hHklRwyww/z1BYYD/A==
X-CSE-MsgGUID: dhw52DoMTG+YmdCBXX5Ayw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21815361"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21815361"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 00:45:09 -0700
X-CSE-ConnectionGUID: M3oxqwrFTJKB+sjIs7W9oQ==
X-CSE-MsgGUID: kB9DGFscRHKWvaht3Yiu5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="52352272"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 May 2024 00:45:07 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4ySe-0004ak-2Y;
	Thu, 09 May 2024 07:45:04 +0000
Date: Thu, 9 May 2024 15:43:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com
Cc: oe-kbuild-all@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] kunit: Cover 'assert.c' with tests
Message-ID: <202405091540.XkfmDsAL-lkp@intel.com>
References: <20240508132557.599213-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508132557.599213-1-ivan.orlov0322@gmail.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/kunit]
[also build test WARNING on shuah-kselftest/kunit-fixes linus/master v6.9-rc7 next-20240508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/kunit-Cover-assert-c-with-tests/20240508-212654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20240508132557.599213-1-ivan.orlov0322%40gmail.com
patch subject: [PATCH v2] kunit: Cover 'assert.c' with tests
config: i386-randconfig-004-20240509 (https://download.01.org/0day-ci/archive/20240509/202405091540.XkfmDsAL-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405091540.XkfmDsAL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405091540.XkfmDsAL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/assert.c:35:6: warning: no previous prototype for 'kunit_assert_print_msg' [-Wmissing-prototypes]
      35 | void kunit_assert_print_msg(const struct va_format *message,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> lib/kunit/assert.c:95:23: warning: no previous prototype for 'is_literal' [-Wmissing-prototypes]
      95 | VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
         |                       ^~~~~~~~~~
>> lib/kunit/assert.c:173:23: warning: no previous prototype for 'is_str_literal' [-Wmissing-prototypes]
     173 | VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
         |                       ^~~~~~~~~~~~~~
>> lib/kunit/assert.c:217:6: warning: no previous prototype for 'kunit_assert_hexdump' [-Wmissing-prototypes]
     217 | void kunit_assert_hexdump(struct string_stream *stream,
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/kunit_assert_print_msg +35 lib/kunit/assert.c

    33	
    34	VISIBLE_IF_KUNIT
  > 35	void kunit_assert_print_msg(const struct va_format *message,
    36				    struct string_stream *stream)
    37	{
    38		if (message->fmt)
    39			string_stream_add(stream, "\n%pV", message);
    40	}
    41	EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
    42	
    43	void kunit_fail_assert_format(const struct kunit_assert *assert,
    44				      const struct va_format *message,
    45				      struct string_stream *stream)
    46	{
    47		string_stream_add(stream, "%pV", message);
    48	}
    49	EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
    50	
    51	void kunit_unary_assert_format(const struct kunit_assert *assert,
    52				       const struct va_format *message,
    53				       struct string_stream *stream)
    54	{
    55		struct kunit_unary_assert *unary_assert;
    56	
    57		unary_assert = container_of(assert, struct kunit_unary_assert, assert);
    58	
    59		if (unary_assert->expected_true)
    60			string_stream_add(stream,
    61					  KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
    62					  unary_assert->condition);
    63		else
    64			string_stream_add(stream,
    65					  KUNIT_SUBTEST_INDENT "Expected %s to be false, but is true\n",
    66					  unary_assert->condition);
    67		kunit_assert_print_msg(message, stream);
    68	}
    69	EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
    70	
    71	void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
    72					     const struct va_format *message,
    73					     struct string_stream *stream)
    74	{
    75		struct kunit_ptr_not_err_assert *ptr_assert;
    76	
    77		ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
    78					  assert);
    79	
    80		if (!ptr_assert->value) {
    81			string_stream_add(stream,
    82					  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
    83					  ptr_assert->text);
    84		} else if (IS_ERR(ptr_assert->value)) {
    85			string_stream_add(stream,
    86					  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is: %ld\n",
    87					  ptr_assert->text,
    88					  PTR_ERR(ptr_assert->value));
    89		}
    90		kunit_assert_print_msg(message, stream);
    91	}
    92	EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
    93	
    94	/* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
  > 95	VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
    96	{
    97		char *buffer;
    98		int len;
    99		bool ret;
   100	
   101		len = snprintf(NULL, 0, "%lld", value);
   102		if (strlen(text) != len)
   103			return false;
   104	
   105		buffer = kmalloc(len+1, GFP_KERNEL);
   106		if (!buffer)
   107			return false;
   108	
   109		snprintf(buffer, len+1, "%lld", value);
   110		ret = strncmp(buffer, text, len) == 0;
   111	
   112		kfree(buffer);
   113	
   114		return ret;
   115	}
   116	EXPORT_SYMBOL_IF_KUNIT(is_literal);
   117	
   118	void kunit_binary_assert_format(const struct kunit_assert *assert,
   119					const struct va_format *message,
   120					struct string_stream *stream)
   121	{
   122		struct kunit_binary_assert *binary_assert;
   123	
   124		binary_assert = container_of(assert, struct kunit_binary_assert,
   125					     assert);
   126	
   127		string_stream_add(stream,
   128				  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
   129				  binary_assert->text->left_text,
   130				  binary_assert->text->operation,
   131				  binary_assert->text->right_text);
   132		if (!is_literal(binary_assert->text->left_text, binary_assert->left_value))
   133			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
   134					  binary_assert->text->left_text,
   135					  binary_assert->left_value,
   136					  binary_assert->left_value);
   137		if (!is_literal(binary_assert->text->right_text, binary_assert->right_value))
   138			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
   139					  binary_assert->text->right_text,
   140					  binary_assert->right_value,
   141					  binary_assert->right_value);
   142		kunit_assert_print_msg(message, stream);
   143	}
   144	EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
   145	
   146	void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
   147					    const struct va_format *message,
   148					    struct string_stream *stream)
   149	{
   150		struct kunit_binary_ptr_assert *binary_assert;
   151	
   152		binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
   153					     assert);
   154	
   155		string_stream_add(stream,
   156				  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
   157				  binary_assert->text->left_text,
   158				  binary_assert->text->operation,
   159				  binary_assert->text->right_text);
   160		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
   161				  binary_assert->text->left_text,
   162				  binary_assert->left_value);
   163		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
   164				  binary_assert->text->right_text,
   165				  binary_assert->right_value);
   166		kunit_assert_print_msg(message, stream);
   167	}
   168	EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
   169	
   170	/* Checks if KUNIT_EXPECT_STREQ() args were string literals.
   171	 * Note: `text` will have ""s where as `value` will not.
   172	 */
 > 173	VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
   174	{
   175		int len;
   176	
   177		len = strlen(text);
   178		if (len < 2)
   179			return false;
   180		if (text[0] != '\"' || text[len - 1] != '\"')
   181			return false;
   182	
   183		return strncmp(text + 1, value, len - 2) == 0;
   184	}
   185	EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
   186	
   187	void kunit_binary_str_assert_format(const struct kunit_assert *assert,
   188					    const struct va_format *message,
   189					    struct string_stream *stream)
   190	{
   191		struct kunit_binary_str_assert *binary_assert;
   192	
   193		binary_assert = container_of(assert, struct kunit_binary_str_assert,
   194					     assert);
   195	
   196		string_stream_add(stream,
   197				  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
   198				  binary_assert->text->left_text,
   199				  binary_assert->text->operation,
   200				  binary_assert->text->right_text);
   201		if (!is_str_literal(binary_assert->text->left_text, binary_assert->left_value))
   202			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
   203					  binary_assert->text->left_text,
   204					  binary_assert->left_value);
   205		if (!is_str_literal(binary_assert->text->right_text, binary_assert->right_value))
   206			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
   207					  binary_assert->text->right_text,
   208					  binary_assert->right_value);
   209		kunit_assert_print_msg(message, stream);
   210	}
   211	EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
   212	
   213	/* Adds a hexdump of a buffer to a string_stream comparing it with
   214	 * a second buffer. The different bytes are marked with <>.
   215	 */
   216	VISIBLE_IF_KUNIT
 > 217	void kunit_assert_hexdump(struct string_stream *stream,
   218				  const void *buf,
   219				  const void *compared_buf,
   220				  const size_t len)
   221	{
   222		size_t i;
   223		const u8 *buf1 = buf;
   224		const u8 *buf2 = compared_buf;
   225	
   226		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT);
   227	
   228		for (i = 0; i < len; ++i) {
   229			if (!(i % 16) && i)
   230				string_stream_add(stream, "\n" KUNIT_SUBSUBTEST_INDENT);
   231	
   232			if (buf1[i] != buf2[i])
   233				string_stream_add(stream, "<%02x>", buf1[i]);
   234			else
   235				string_stream_add(stream, " %02x ", buf1[i]);
   236		}
   237	}
   238	EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

