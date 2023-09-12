Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93179CE41
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 12:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjILK2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 06:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjILK1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 06:27:43 -0400
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 03:27:12 PDT
Received: from smtp69.iad3b.emailsrvr.com (smtp69.iad3b.emailsrvr.com [146.20.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047CF10F8
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694513899;
        bh=FH3C6DGeGqxyT5D0x1WZDEUoGXKaA0SlVyvXD/E86uk=;
        h=Date:Subject:To:From:From;
        b=Tq6xJ2+piqPbhOIJE69N/bFxHEol/tmPY3c/hCTgDQpjfzcL1PHLR0dKjZfF714V7
         Vl/6zaEzVFXQTpS59Oc3i3RhW8WqIwPdHyjcxiin/hSqOtSelQtRrdQ5MMJLWJtYqR
         D98zi0KdjdUX1nH+1iIJQBq7/UhFQ72R5qHGEl7g=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C837BA00C7;
        Tue, 12 Sep 2023 06:18:15 -0400 (EDT)
Message-ID: <44acdea6-271f-4e71-a0b3-d74a92034a9a@mev.co.uk>
Date:   Tue, 12 Sep 2023 11:18:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drivers/comedi: fix Python string escapes
To:     Benjamin Gray <bgray@linux.ibm.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        llvm@lists.linux.dev, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
 <20230912060801.95533-4-bgray@linux.ibm.com>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20230912060801.95533-4-bgray@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 263f4c94-c5b5-4040-bf22-1f7e4ea60010-1-1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/09/2023 07:07, Benjamin Gray wrote:
> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> be a syntax error.
> 
> Fix these now to get ahead of it before it's an error.
> 
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>   drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
> index 90378fb50580..d19101fc2a94 100755
> --- a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
> +++ b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
> @@ -44,7 +44,7 @@ def routedict_to_structinit_single(name, D, return_name=False):
>   
>       lines.append('\t\t[B({})] = {{'.format(D0_sig))
>       for D1_sig, value in D1:
> -      if not re.match('[VIU]\([^)]*\)', value):
> +      if not re.match(r'[VIU]\([^)]*\)', value):
>           sys.stderr.write('Invalid register format: {}\n'.format(repr(value)))
>           sys.stderr.write(
>             'Register values should be formatted with V(),I(),or U()\n')

Looks good thanks!  I ran the modified script using 'make everything' in 
the directory (after setting up a python venv to install ctypesgen) and 
it didn't break anything. (There were some harmless errors output by 
ctypesgen due to failing to parse some GCC extensions, but those are 
nothing to do with this patch and the generated C files are OK.)

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

