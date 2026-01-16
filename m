Return-Path: <linux-kselftest+bounces-49138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D8D2F5DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0BA3004189
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DEE35EDA5;
	Fri, 16 Jan 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IABzaiMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85899311C11;
	Fri, 16 Jan 2026 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558236; cv=none; b=XJ9wf/QiWa7MTgNa8FEKQ1aYevKtO/0daVDxj+SWyFE7jmf6yaa8lwRruYHibEl0IRYMcqXHZUowkVN7BF0rdWSsn/eeLmgu/VyMp/atmBRi4uowd/AJTg5mL68xLOXe0wjrfOdrRtktcQf4DZ3FH6HWm0EU6eisgPSQXZ08nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558236; c=relaxed/simple;
	bh=05WX0l4EcWLSR9uMw5We8NGGF32lwCRK3+YdoNd0/p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yr7KOEPPQzTVcNTlTmaUayR8Kmah6L1/jbB/hdU0oSTBu8VoaEnlgUT+QIWMiOouuHDpXG5u5/43eMKVph9r5Zw9072GzTXO1YPN1TPdEkdf4UCf8LmAajrLM86qJk+50f1MC/RodN1YPin1OMEeI4vLjs5HVSby5Cy0FhSECKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IABzaiMX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768558234; x=1800094234;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=05WX0l4EcWLSR9uMw5We8NGGF32lwCRK3+YdoNd0/p0=;
  b=IABzaiMXiJObNGFY7x7unzpgyozJkYyJ2COpKMS/KXzTv45+dPIi3fu5
   h6fhVBwZ3XcizYurOVaZtYq74u8mF9nyKs+LAI4TIjl9IarAPzgcBZeF1
   6+vxcWjfAheGtOlQp6egIvJh9mQXFSSnhXzUI/pGg72ylmYfoe1zxiyj2
   K+uJIFqe5W/K1S2ml3hhi+WTlmv1vN1VBCG0sp6JBJgOn1Jq6FNNHBPT+
   fuzx2ij66h1ITMQLg49GcH8FBAJDoXHwJY1zaCrW2laZQmDYL067H2+x+
   HVImcByJtpTsnug4sYfTgrmkuMKyaElbZwFcpIGRAFIyNNH6U7gKmOf3u
   g==;
X-CSE-ConnectionGUID: 4HyQXYSPTjKsRkB7XyD9JQ==
X-CSE-MsgGUID: FQI2/WcvS0+gMYaifRQcpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73725015"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="73725015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 02:10:34 -0800
X-CSE-ConnectionGUID: 4teDkaGMTf6EdJRFaAGQtQ==
X-CSE-MsgGUID: Pxt2ojLQSSKKQijYrLvRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="205103117"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.205])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 02:10:30 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Ryota Sakamoto <sakamo.ryota@gmail.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar
 <raemoar63@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
Subject: Re: [PATCH] kunit: add bash completion
In-Reply-To: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
Date: Fri, 16 Jan 2026 12:10:27 +0200
Message-ID: <44b770121202e9f41648da5abaf9a87d5b8811c6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 15 Jan 2026, Ryota Sakamoto <sakamo.ryota@gmail.com> wrote:
> Currently, kunit.py has many subcommands and options, making it difficult
> to remember them without checking the help message.
>
> Add --list-cmds and --list-opts to kunit.py to get available commands and
> options, use those outputs in kunit-completion.sh to show completion.
>
> This implementation is similar to perf and tools/perf/perf-completion.sh.
>
> Example output:
>   $ source tools/testing/kunit/kunit-completion.sh
>   $ ./tools/testing/kunit/kunit.py [TAB][TAB]
>   build   config  exec    parse   run
>   $ ./tools/testing/kunit/kunit.py run --k[TAB][TAB]
>   --kconfig_add  --kernel_args  --kunitconfig
>

The alternative would be to make the tool more friendly to existing
completion tools such as shtab [1]. Since the kernel as a project is
really averse to adding external dependencies, you could take shtab's
CLI approach, and commit the completion script in the repo. Only
whoever's updating the completions would have to install and run shtab.

And the whole thing could be taken a step further, adding, say,
tools/completions/{bash,zsh,tcsh,...} directories for all the kernel
tool completions instead of spreading them around.

Anyway, just a thought to consider before doing another kernel homebrew
NIH approach.


BR,
Jani.



[1] https://github.com/iterative/shtab


> Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst |  9 ++++++++
>  tools/testing/kunit/kunit-completion.sh       | 33 +++++++++++++++++++++++++++
>  tools/testing/kunit/kunit.py                  | 30 ++++++++++++++++++++++++
>  tools/testing/kunit/kunit_tool_test.py        | 21 +++++++++++++++++
>  4 files changed, 93 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index 6697c71ee8ca020b8ac7e91b46e29ab082d9dea0..3c0b585dcfffbd3929d0eef1ab9376fa4f380872 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -335,3 +335,12 @@ command line arguments:
>  
>  - ``--list_tests_attr``: If set, lists all tests that will be run and all of their
>    attributes.
> +
> +Command-line completion
> +==============================
> +
> +The kunit_tool comes with a bash completion script:
> +
> +.. code-block:: bash
> +
> +	source tools/testing/kunit/kunit-completion.sh
> diff --git a/tools/testing/kunit/kunit-completion.sh b/tools/testing/kunit/kunit-completion.sh
> new file mode 100644
> index 0000000000000000000000000000000000000000..3b9b68e3bc384c026f10f74b8a1df2129cb2cd50
> --- /dev/null
> +++ b/tools/testing/kunit/kunit-completion.sh
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# bash completion support for KUnit
> +
> +_kunit_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
> +
> +_kunit()
> +{
> +	local cur prev words cword
> +	_init_completion || return
> +
> +	local script="${_kunit_dir}/kunit.py"
> +
> +	if [[ $cword -eq 1 && "$cur" != -* ]]; then
> +		local cmds=$(${script} --list-cmds 2>/dev/null)
> +		COMPREPLY=($(compgen -W "${cmds}" -- "$cur"))
> +		return 0
> +	fi
> +
> +	if [[ "$cur" == -* ]]; then
> +		if [[ -n "${words[1]}" && "${words[1]}" != -* ]]; then
> +			local opts=$(${script} ${words[1]} --list-opts 2>/dev/null)
> +			COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
> +			return 0
> +		else
> +			local opts=$(${script} --list-opts 2>/dev/null)
> +			COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
> +			return 0
> +		fi
> +	fi
> +}
> +
> +complete -o default -F _kunit kunit.py
> +complete -o default -F _kunit kunit
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index cd99c1956331dbbfb06cf4ddf130db3dcf2a7c31..a5aee1eb88e65fa2387b2623642d2ee9a66db600 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -323,6 +323,17 @@ def get_default_jobs() -> int:
>  		return ncpu
>  	raise RuntimeError("os.cpu_count() returned None")
>  
> +def add_completion_opts(parser: argparse.ArgumentParser) -> None:
> +	parser.add_argument('--list-opts',
> +			    help=argparse.SUPPRESS,
> +			    action='store_true')
> +
> +def add_root_opts(parser: argparse.ArgumentParser) -> None:
> +	parser.add_argument('--list-cmds',
> +			    help=argparse.SUPPRESS,
> +			    action='store_true')
> +	add_completion_opts(parser)
> +
>  def add_common_opts(parser: argparse.ArgumentParser) -> None:
>  	parser.add_argument('--build_dir',
>  			    help='As in the make command, it specifies the build '
> @@ -374,6 +385,8 @@ def add_common_opts(parser: argparse.ArgumentParser) -> None:
>  			    help='Additional QEMU arguments, e.g. "-smp 8"',
>  			    action='append', metavar='')
>  
> +	add_completion_opts(parser)
> +
>  def add_build_opts(parser: argparse.ArgumentParser) -> None:
>  	parser.add_argument('--jobs',
>  			    help='As in the make command, "Specifies  the number of '
> @@ -569,6 +582,7 @@ subcommand_handlers_map = {
>  def main(argv: Sequence[str]) -> None:
>  	parser = argparse.ArgumentParser(
>  			description='Helps writing and running KUnit tests.')
> +	add_root_opts(parser)
>  	subparser = parser.add_subparsers(dest='subcommand')
>  
>  	# The 'run' command will config, build, exec, and parse in one go.
> @@ -603,12 +617,28 @@ def main(argv: Sequence[str]) -> None:
>  	parse_parser.add_argument('file',
>  				  help='Specifies the file to read results from.',
>  				  type=str, nargs='?', metavar='input_file')
> +	add_completion_opts(parse_parser)
>  
>  	cli_args = parser.parse_args(massage_argv(argv))
>  
>  	if get_kernel_root_path():
>  		os.chdir(get_kernel_root_path())
>  
> +	if cli_args.list_cmds:
> +		print(" ".join(subparser.choices.keys()))
> +		return
> +
> +	if cli_args.list_opts:
> +		target_parser = subparser.choices.get(cli_args.subcommand)
> +		if not target_parser:
> +			target_parser = parser
> +
> +		# Accessing private attribute _option_string_actions to get
> +		# the list of options. This is not a public API, but argparse
> +		# does not provide a way to inspect options programmatically.
> +		print(' '.join(target_parser._option_string_actions.keys()))
> +		return
> +
>  	subcomand_handler = subcommand_handlers_map.get(cli_args.subcommand, None)
>  
>  	if subcomand_handler is None:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bbba921e0eacb18663abfcabb2bccf330d8666f5..a7f09a6c97a473ff85e087d17c2f5faf7755b994 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -11,11 +11,13 @@ from unittest import mock
>  
>  import tempfile, shutil # Handling test_tmpdir
>  
> +import io
>  import itertools
>  import json
>  import os
>  import signal
>  import subprocess
> +import sys
>  from typing import Iterable
>  
>  import kunit_config
> @@ -855,5 +857,24 @@ class KUnitMainTest(unittest.TestCase):
>  			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', filter='', filter_action=None, timeout=300),
>  		])
>  
> +	@mock.patch.object(sys, 'stdout', new_callable=io.StringIO)
> +	def test_list_cmds(self, mock_stdout):
> +		kunit.main(['--list-cmds'])
> +		output = mock_stdout.getvalue()
> +		output_cmds = sorted(output.split())
> +		expected_cmds = sorted(['build', 'config', 'exec', 'parse', 'run'])
> +		self.assertEqual(output_cmds, expected_cmds)
> +
> +	@mock.patch.object(sys, 'stdout', new_callable=io.StringIO)
> +	def test_run_list_opts(self, mock_stdout):
> +		kunit.main(['run', '--list-opts'])
> +		output = mock_stdout.getvalue()
> +		output_cmds = set(output.split())
> +		self.assertIn('--help', output_cmds)
> +		self.assertIn('--kunitconfig', output_cmds)
> +		self.assertIn('--jobs', output_cmds)
> +		self.assertIn('--kernel_args', output_cmds)
> +		self.assertIn('--raw_output', output_cmds)
> +
>  if __name__ == '__main__':
>  	unittest.main()
>
> ---
> base-commit: b71e635feefc852405b14620a7fc58c4c80c0f73
> change-id: 20260114-kunit-completion-265889f59c52
>
> Best regards,

-- 
Jani Nikula, Intel

