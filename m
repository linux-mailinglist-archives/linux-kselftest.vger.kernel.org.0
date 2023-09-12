Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756BF79CEFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjILK5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjILK5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 06:57:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9ABE;
        Tue, 12 Sep 2023 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694516230; x=1726052230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gmV0KiwKba1PSNl2UVCdi3U5WkDZQcsXPrzZ4xrOoOg=;
  b=MUD7owgCZQplNWfJz3SfzqVxNsAdEQVXqBBa5T/p5rMRDNekD++JlCGg
   fmrmRKM1hLL+3JZ2SttH3PPmdjoFZkQ2n/35ziEpNed1sQf/x4pWPKmzH
   x3cCrHzlNm0qk3efDaSt/5qDpgcFN5wq8fU7uAsdGkwS+lNsxV4h5NtbQ
   lsMxJjWBE4sLEL6/E3El7xWKYdGIqVch4Z6fwah4DGmHcpX8COz7G58iD
   /zmsAvVBmmZqeW/SjJBfuOPSm6ZvpaKhjZkasVSYduKTmbqnJcNFqDS+T
   ebWXzmb2Ypo9s1YML0s2/I3Ga4bvm1A5/G/qgoNLuQOcCru+AJbOuUxgt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378251081"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378251081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="1074510354"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074510354"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.152])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:57:01 -0700
Message-ID: <340eae90-d270-5e52-4982-a67459bc46dd@intel.com>
Date:   Tue, 12 Sep 2023 13:56:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v2 5/7] tools/perf: fix Python string escapes
Content-Language: en-US
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230912060801.95533-6-bgray@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/09/23 09:07, Benjamin Gray wrote:
> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> be a syntax error.
> 
> Fix these now to get ahead of it before it's an error.
> 
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.py                 | 2 +-
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
>  tools/perf/scripts/python/compaction-times.py    | 2 +-
>  tools/perf/scripts/python/exported-sql-viewer.py | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index a7e88332276d..980f080a5a2c 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -83,7 +83,7 @@ def c_len(s: str) -> int:
>    """Return the length of s a C string
>  
>    This doesn't handle all escape characters properly. It first assumes
> -  all \ are for escaping, it then adjusts as it will have over counted
> +  all \\ are for escaping, it then adjusts as it will have over counted

It looks like the whole string should be a raw string

>    \\. The code uses \000 rather than \0 as a terminator as an adjacent
>    number would be folded into a string of \0 (ie. "\0" + "5" doesn't
>    equal a terminator followed by the number 5 but the escape of
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d59ff53f1d94..de58991c78bb 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -45,8 +45,8 @@ parser = OptionParser(option_list=option_list)
>  # Initialize global dicts and regular expression
>  disasm_cache = dict()
>  cpu_data = dict()
> -disasm_re = re.compile("^\s*([0-9a-fA-F]+):")
> -disasm_func_re = re.compile("^\s*([0-9a-fA-F]+)\s.*:")
> +disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
> +disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
>  cache_size = 64*1024
>  
>  glb_source_file_name	= None
> diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
> index 2560a042dc6f..9401f7c14747 100644
> --- a/tools/perf/scripts/python/compaction-times.py
> +++ b/tools/perf/scripts/python/compaction-times.py
> @@ -260,7 +260,7 @@ def pr_help():
>  
>  comm_re = None
>  pid_re = None
> -pid_regex = "^(\d*)-(\d*)$|^(\d*)$"
> +pid_regex = r"^(\d*)-(\d*)$|^(\d*)$"
>  
>  opt_proc = popt.DISP_DFL
>  opt_disp = topt.DISP_ALL
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 13f2d8a81610..121cf61ba1b3 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -677,8 +677,8 @@ class CallGraphModelBase(TreeModel):
>  			#   sqlite supports GLOB (text only) which uses * and ? and is case sensitive
>  			if not self.glb.dbref.is_sqlite3:
>  				# Escape % and _
> -				s = value.replace("%", "\%")
> -				s = s.replace("_", "\_")
> +				s = value.replace("%", "\\%")
> +				s = s.replace("_", "\\_")

Raw strings seem more readable, so could be
used here too

>  				# Translate * and ? into SQL LIKE pattern characters % and _
>  				trans = string.maketrans("*?", "%_")
>  				match = " LIKE '" + str(s).translate(trans) + "'"

