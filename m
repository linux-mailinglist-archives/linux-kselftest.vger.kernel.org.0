Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD1E79DF8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 07:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjIMFxn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 01:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIMFxn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 01:53:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA9172D;
        Tue, 12 Sep 2023 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694584419; x=1726120419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FfUA0UJfdB5sO+CbLAWUBiXpBV0138FnSY1bREzj/FU=;
  b=QV8jGdSjLEz5e8Rs40VJFqPJokTyfYRb5bBS6zollkQie6chUQq0llmP
   K2bcMRKuf5cilPQAV0G2lD8CkNbsWIbfET6XYPueghB2ns9XyHiDezx0U
   WvmzVm79eCcOkQR1aSkg/IOAOQn1fdnPUKX2OfoezwG1Ws22hJA16BS6o
   0LTEsuyIyxhMI/b5GRICyJacAPU+w5rxJLcZfRCFhbu/bBbPneg16CPUp
   BpjUzXWC/1pZeGrGbxfPXspj8j35QKEOvXpPWdC2ng2zrGmjb2NhNnBW6
   WBVtH9gG5gnMAy8d1F+6eBAyDlVQPISuYePCUZ3+KBSQuTjJ39b2RULCh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464941613"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464941613"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 22:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990784456"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="990784456"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.177])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 22:53:31 -0700
Message-ID: <592b8fd2-bfe3-0f8d-2814-d8340bbc75ee@intel.com>
Date:   Wed, 13 Sep 2023 08:53:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v2 5/7] tools/perf: fix Python string escapes
To:     Benjamin Gray <bgray@linux.ibm.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        llvm@lists.linux.dev, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
 <20230912060801.95533-6-bgray@linux.ibm.com>
 <340eae90-d270-5e52-4982-a67459bc46dd@intel.com>
 <d603d3b3-7563-d1c9-5086-c5bb78ea2e52@linux.ibm.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <d603d3b3-7563-d1c9-5086-c5bb78ea2e52@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/09/23 03:26, Benjamin Gray wrote:
> On 12/9/23 8:56 pm, Adrian Hunter wrote:
>> On 12/09/23 09:07, Benjamin Gray wrote:
>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>> index a7e88332276d..980f080a5a2c 100755
>>> --- a/tools/perf/pmu-events/jevents.py
>>> +++ b/tools/perf/pmu-events/jevents.py
>>> @@ -83,7 +83,7 @@ def c_len(s: str) -> int:
>>>     """Return the length of s a C string
>>>       This doesn't handle all escape characters properly. It first assumes
>>> -  all \ are for escaping, it then adjusts as it will have over counted
>>> +  all \\ are for escaping, it then adjusts as it will have over counted
>>
>> It looks like the whole string should be a raw string
>>
> ...
>>> -                s = value.replace("%", "\%")
>>> -                s = s.replace("_", "\_")
>>> +                s = value.replace("%", "\\%")
>>> +                s = s.replace("_", "\\_")
>>
>> Raw strings seem more readable, so could be
>> used here too
> 
> Yeah, sounds good. I normally use r strings only for regex, but there shouldn't be any ambiguity here (it might have been misleading if the search argument to replace looked like a regex).
> 
> Having the docstring be an r string is a good catch. There's probably a few like that in the kernel, but finding them is a little more complicated because they might be 'valid' syntax (e.g., the '\000' just becomes a null byte. This series is focused on the syntax errors though, so I'll just leave it be.
> 
> How is the following?
> ---
> Subject: [PATCH] tools/perf: fix Python string escapes
> 
> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> be a syntax error.
> 
> Fix these now to get ahead of it before it's an error.
> 
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/pmu-events/jevents.py                 | 2 +-
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
>  tools/perf/scripts/python/compaction-times.py    | 2 +-
>  tools/perf/scripts/python/exported-sql-viewer.py | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index a7e88332276d..1b4519333a28 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -80,7 +80,7 @@ def file_name_to_table_name(prefix: str, parents: Sequence[str],
> 
> 
>  def c_len(s: str) -> int:
> -  """Return the length of s a C string
> +  r"""Return the length of s a C string
> 
>    This doesn't handle all escape characters properly. It first assumes
>    all \ are for escaping, it then adjusts as it will have over counted
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d59ff53f1d94..de58991c78bb 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -45,8 +45,8 @@ parser = OptionParser(option_list=option_list)
>  # Initialize global dicts and regular expression
>  disasm_cache = dict()
>  cpu_data = dict()
> -disasm_re = re.compile("^\s*([0-9a-fA-F]+):")
> -disasm_func_re = re.compile("^\s*([0-9a-fA-F]+)\s.*:")
> +disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
> +disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
>  cache_size = 64*1024
> 
>  glb_source_file_name    = None
> diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
> index 2560a042dc6f..9401f7c14747 100644
> --- a/tools/perf/scripts/python/compaction-times.py
> +++ b/tools/perf/scripts/python/compaction-times.py
> @@ -260,7 +260,7 @@ def pr_help():
> 
>  comm_re = None
>  pid_re = None
> -pid_regex = "^(\d*)-(\d*)$|^(\d*)$"
> +pid_regex = r"^(\d*)-(\d*)$|^(\d*)$"
> 
>  opt_proc = popt.DISP_DFL
>  opt_disp = topt.DISP_ALL
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 13f2d8a81610..78763531fe5a 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -677,8 +677,8 @@ class CallGraphModelBase(TreeModel):
>              #   sqlite supports GLOB (text only) which uses * and ? and is case sensitive
>              if not self.glb.dbref.is_sqlite3:
>                  # Escape % and _
> -                s = value.replace("%", "\%")
> -                s = s.replace("_", "\_")
> +                s = value.replace("%", r"\%")
> +                s = s.replace("_", r"\_")
>                  # Translate * and ? into SQL LIKE pattern characters % and _
>                  trans = string.maketrans("*?", "%_")
>                  match = " LIKE '" + str(s).translate(trans) + "'"

