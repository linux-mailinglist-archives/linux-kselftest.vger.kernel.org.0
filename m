Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3E6F2A31
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Apr 2023 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjD3SPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Apr 2023 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3SPF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Apr 2023 14:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4210EF;
        Sun, 30 Apr 2023 11:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692DE60DBE;
        Sun, 30 Apr 2023 18:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE4C433EF;
        Sun, 30 Apr 2023 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682878502;
        bh=O4JBBRUic0uivPVdWP2D/uJkT2Quy0op12TFRtFXla4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fvrpiz/HH/oL2MWvJoSpWw9QIW9Y8BQBNqPqAtAVPmBkJOw6t1ORio+Bq8srlODJ8
         c2EGSeevVh1+/YmVIy714jlRnvPTVPJ8Y/1kJ5QJGKl572Yf77jjOOKMqtC/A+xHbu
         FKnKYmoIaHDPHEF665qs56Zm9K1YgWmH7ti/ZUTMSfyPo812sY+XcmhTkdno7sY23j
         KwpNP4gg2wcIs1FxG/J7jJprM0cZRqIg8UU+MxiCowV93iSoLN037lX7wO20Y/H40K
         /NTR6X9y6lU6K4ls/wIHgab3oPV0QbQyz2g3QY5TKQ8uNofGAb2uILko9qsVYpmBPk
         m7d/wroH8F4tg==
From:   SeongJae Park <sj@kernel.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net, Johannes Berg <johannes.berg@intel.com>,
        regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/3] kunit: tool: add subscripts for type annotations where appropriate
Date:   Sun, 30 Apr 2023 18:15:00 +0000
Message-Id: <20230430181500.122664-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316220638.983743-1-dlatypov@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Daniel,

On Thu, 16 Mar 2023 15:06:36 -0700 Daniel Latypov <dlatypov@google.com> wrote:

> E.g. for subprocess.Popen, it can be opened in `text=True` mode where it
> returns strings, or `text=False` where it returns bytes.
> To differentiate, you can annotate types as `Popen[str]` or
> `Popen[bytes]`.
> 
> This patch should add subscripts in all the places we were missing them.

I just found this patch is in the latest mainline tree, and it causes kunit
failure on my test machine like below.

    $ python3 --version
    Python 3.8.10
    $
    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    Traceback (most recent call last):
      File "./tools/testing/kunit/kunit.py", line 24, in <module>
        import kunit_kernel
      File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 42, in <module>
        class LinuxSourceTreeOperations:
      File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 95, in LinuxSourceTreeOperations
        def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
    TypeError: 'type' object is not subscriptable
    $

I further confirmed reverting this patch makes it run again.  Do you have any
idea?


Thanks,
SJ

> 
> Reported-by: Johannes Berg <johannes.berg@intel.com>
> Link: https://lore.kernel.org/linux-kselftest/20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid/
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> Note: this is unchanged, just added a 3rd patch to this series.
> ---
>  tools/testing/kunit/kunit_kernel.py  | 6 +++---
>  tools/testing/kunit/kunit_printer.py | 2 +-
>  tools/testing/kunit/run_checks.py    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 53e90c335834..e6fc8fcb071a 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -92,7 +92,7 @@ class LinuxSourceTreeOperations:
>  		if stderr:  # likely only due to build warnings
>  			print(stderr.decode())
>  
> -	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
>  		raise RuntimeError('not implemented!')
>  
>  
> @@ -112,7 +112,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>  		kconfig.merge_in_entries(base_kunitconfig)
>  		return kconfig
>  
> -	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
>  		kernel_path = os.path.join(build_dir, self._kernel_path)
>  		qemu_command = ['qemu-system-' + self._qemu_arch,
>  				'-nodefaults',
> @@ -141,7 +141,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>  		kconfig.merge_in_entries(base_kunitconfig)
>  		return kconfig
>  
> -	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> +	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
>  		"""Runs the Linux UML binary. Must be named 'linux'."""
>  		linux_bin = os.path.join(build_dir, 'linux')
>  		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
> diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
> index 5f1cc55ecdf5..015adf87dc2c 100644
> --- a/tools/testing/kunit/kunit_printer.py
> +++ b/tools/testing/kunit/kunit_printer.py
> @@ -15,7 +15,7 @@ _RESET = '\033[0;0m'
>  class Printer:
>  	"""Wraps a file object, providing utilities for coloring output, etc."""
>  
> -	def __init__(self, output: typing.IO):
> +	def __init__(self, output: typing.IO[str]):
>  		self._output = output
>  		self._use_color = output.isatty()
>  
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> index 066e6f938f6d..61cece1684df 100755
> --- a/tools/testing/kunit/run_checks.py
> +++ b/tools/testing/kunit/run_checks.py
> @@ -37,7 +37,7 @@ def main(argv: Sequence[str]) -> None:
>  	if argv:
>  		raise RuntimeError('This script takes no arguments')
>  
> -	future_to_name: Dict[futures.Future, str] = {}
> +	future_to_name: Dict[futures.Future[None], str] = {}
>  	executor = futures.ThreadPoolExecutor(max_workers=len(commands))
>  	for name, argv in commands.items():
>  		if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
> 
> base-commit: 2c6a96dad5797e57b4cf04101d6c8d5c7a571603
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
