Return-Path: <linux-kselftest+bounces-379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442A57F2E18
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 14:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750121C218A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3084A99B;
	Tue, 21 Nov 2023 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDpQK5zo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546348CD2;
	Tue, 21 Nov 2023 13:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7789EC433C8;
	Tue, 21 Nov 2023 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700572481;
	bh=sde8UH1s+S4ZJXYAO43tWVBaZyVwRo176bP2DijjLOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDpQK5zo9UpeD6GkT0WYJk0auFna8sxeBC4CdhCQMBp49+MoYKwjHAGpgOvsAEPNg
	 fCqE40vgBm7by3wYeVxKARR21bCTugAiNX2my51TLcaJ8QbOzU3jgIXvfLmsa57jYm
	 v+BfyGsD59pQoFcD2opzjY5rtDJlYlFmfJ9VdHeeVNi5QaXEh0d1+ZLsp7ovuPxjXs
	 staHh5fbiivWv9bHPX3P1x1e2LwXdkAyWW4yLs6UymSS/rvQcqPvPoBaeW4dxD9OOc
	 bY5HZ9TPwh3nbaDJ7/umMYtNYjbvzP9hWLeM0duhJiie4u33DwomW9AATV9/TQLV/7
	 3GZuKf/TNC4Iw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0C86440094; Tue, 21 Nov 2023 10:14:39 -0300 (-03)
Date: Tue, 21 Nov 2023 10:14:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Gray <bgray@linux.ibm.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	llvm@lists.linux.dev, linux-pm@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 5/7] tools/perf: fix Python string escapes
Message-ID: <ZVytPl1AjNw3IzSu@kernel.org>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
 <20230912060801.95533-6-bgray@linux.ibm.com>
 <340eae90-d270-5e52-4982-a67459bc46dd@intel.com>
 <d603d3b3-7563-d1c9-5086-c5bb78ea2e52@linux.ibm.com>
 <592b8fd2-bfe3-0f8d-2814-d8340bbc75ee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <592b8fd2-bfe3-0f8d-2814-d8340bbc75ee@intel.com>
X-Url: http://acmel.wordpress.com

Em Wed, Sep 13, 2023 at 08:53:26AM +0300, Adrian Hunter escreveu:
> On 13/09/23 03:26, Benjamin Gray wrote:
> > On 12/9/23 8:56 pm, Adrian Hunter wrote:
> >> On 12/09/23 09:07, Benjamin Gray wrote:
> >>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> >>> index a7e88332276d..980f080a5a2c 100755
> >>> --- a/tools/perf/pmu-events/jevents.py
> >>> +++ b/tools/perf/pmu-events/jevents.py
> >>> @@ -83,7 +83,7 @@ def c_len(s: str) -> int:
> >>>     """Return the length of s a C string
> >>>       This doesn't handle all escape characters properly. It first assumes
> >>> -  all \ are for escaping, it then adjusts as it will have over counted
> >>> +  all \\ are for escaping, it then adjusts as it will have over counted
> >>
> >> It looks like the whole string should be a raw string
> >>
> > ...
> >>> -                s = value.replace("%", "\%")
> >>> -                s = s.replace("_", "\_")
> >>> +                s = value.replace("%", "\\%")
> >>> +                s = s.replace("_", "\\_")
> >>
> >> Raw strings seem more readable, so could be
> >> used here too
> > 
> > Yeah, sounds good. I normally use r strings only for regex, but there shouldn't be any ambiguity here (it might have been misleading if the search argument to replace looked like a regex).
> > 
> > Having the docstring be an r string is a good catch. There's probably a few like that in the kernel, but finding them is a little more complicated because they might be 'valid' syntax (e.g., the '\000' just becomes a null byte. This series is focused on the syntax errors though, so I'll just leave it be.
> > 
> > How is the following?
> > ---
> > Subject: [PATCH] tools/perf: fix Python string escapes
> > 
> > Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> > This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> > be a syntax error.
> > 
> > Fix these now to get ahead of it before it's an error.
> > 
> > Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

applied the tools/perf one.

- Arnaldo
 
> > ---
> >  tools/perf/pmu-events/jevents.py                 | 2 +-
> >  tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
> >  tools/perf/scripts/python/compaction-times.py    | 2 +-
> >  tools/perf/scripts/python/exported-sql-viewer.py | 4 ++--
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index a7e88332276d..1b4519333a28 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -80,7 +80,7 @@ def file_name_to_table_name(prefix: str, parents: Sequence[str],
> > 
> > 
> >  def c_len(s: str) -> int:
> > -  """Return the length of s a C string
> > +  r"""Return the length of s a C string
> > 
> >    This doesn't handle all escape characters properly. It first assumes
> >    all \ are for escaping, it then adjusts as it will have over counted
> > diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > index d59ff53f1d94..de58991c78bb 100755
> > --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > @@ -45,8 +45,8 @@ parser = OptionParser(option_list=option_list)
> >  # Initialize global dicts and regular expression
> >  disasm_cache = dict()
> >  cpu_data = dict()
> > -disasm_re = re.compile("^\s*([0-9a-fA-F]+):")
> > -disasm_func_re = re.compile("^\s*([0-9a-fA-F]+)\s.*:")
> > +disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
> > +disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
> >  cache_size = 64*1024
> > 
> >  glb_source_file_name    = None
> > diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
> > index 2560a042dc6f..9401f7c14747 100644
> > --- a/tools/perf/scripts/python/compaction-times.py
> > +++ b/tools/perf/scripts/python/compaction-times.py
> > @@ -260,7 +260,7 @@ def pr_help():
> > 
> >  comm_re = None
> >  pid_re = None
> > -pid_regex = "^(\d*)-(\d*)$|^(\d*)$"
> > +pid_regex = r"^(\d*)-(\d*)$|^(\d*)$"
> > 
> >  opt_proc = popt.DISP_DFL
> >  opt_disp = topt.DISP_ALL
> > diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> > index 13f2d8a81610..78763531fe5a 100755
> > --- a/tools/perf/scripts/python/exported-sql-viewer.py
> > +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> > @@ -677,8 +677,8 @@ class CallGraphModelBase(TreeModel):
> >              #   sqlite supports GLOB (text only) which uses * and ? and is case sensitive
> >              if not self.glb.dbref.is_sqlite3:
> >                  # Escape % and _
> > -                s = value.replace("%", "\%")
> > -                s = s.replace("_", "\_")
> > +                s = value.replace("%", r"\%")
> > +                s = s.replace("_", r"\_")
> >                  # Translate * and ? into SQL LIKE pattern characters % and _
> >                  trans = string.maketrans("*?", "%_")
> >                  match = " LIKE '" + str(s).translate(trans) + "'"
> 

-- 

- Arnaldo

