Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2605D1E88FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgE2UhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 16:37:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2UhK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 16:37:10 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jelkZ-0004kh-Vh
        for linux-kselftest@vger.kernel.org; Fri, 29 May 2020 20:37:08 +0000
Received: by mail-il1-f199.google.com with SMTP id x20so3199596ilj.22
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5Cje8enJHccYExZgxsG4qWoyTyd0dqBTrkvQHopa8A=;
        b=FdVH4Hz4OOcS8A+L/+valzoJEfNj5bz72+qGvfEsz2mgrI4r6+uqLTOan9onjkabEE
         qk44fkPm+ArhUxW+aOWwwJj5wBYXeqQPA27uCEpmS/ATwdcbF1v7TOzzsZecUIfskl54
         mL2fjiCGssGC6rCTzwPhNBaDB8GYqSKrGL8p+yYozd0fYLpHeFnX3kHfMKpfGgHmEGDy
         3V+/zWXv31PcrnejutdJAnBAIq1YNH3LOkeADChEU3YsmmFk2VabGHgJ1bWhmhk+WU9M
         M0/ZaPHrgy1shRSABHvtJDM/xb1gJYeOL1z1KcmF/b74a8NDmHH0v6d9DVvlwJb/TDQ+
         92KA==
X-Gm-Message-State: AOAM5302jUBCrhZ4lh7tS8yNhN2BjR45EKYZIp/SBve9ZwKLj4OM8VwK
        nkyy7k+0hYAM9BPlf+4+M3DpmO735uFbShU6/TrsvOEHKqRhxZVYzUmX1xUmsUTmR/BWBWAZF9e
        H9bgzjI8JQQTKJ6pK8uHtTe2jGc5c0iSNy+MeJs4/WIOy+g==
X-Received: by 2002:a92:8752:: with SMTP id d18mr9552164ilm.224.1590784626943;
        Fri, 29 May 2020 13:37:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynB9hPXKwUhGIEurQjzDbw+wTXaTe4XHhQxUXV3Za6iqVJm6b+iQ6ywueffW0euC84TrEkiw==
X-Received: by 2002:a92:8752:: with SMTP id d18mr9552132ilm.224.1590784626596;
        Fri, 29 May 2020 13:37:06 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:3a:9575:4d23:d28e])
        by smtp.gmail.com with ESMTPSA id y12sm5655695ilk.16.2020.05.29.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:37:05 -0700 (PDT)
Date:   Fri, 29 May 2020 15:37:04 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Use printf instead of echo in
 kprobe syntax error tests
Message-ID: <20200529203704.GA57013@ubuntu-x1>
References: <20200304222009.34663-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304222009.34663-1-seth.forshee@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 04, 2020 at 04:20:09PM -0600, Seth Forshee wrote:
> Test cases which use echo to write strings containing backslashes
> fail with some shells, as echo's treatment of backslashes in
> strings varies between shell implementations. Use printf instead,
> as it should behave consistently across different shells. This
> requires adjustments to the strings to escape \ and % characters.
> ftrace_errlog_check() must also re-escape these characters after
> processing them to remove ^ characters.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Ping. Someone just asked me about this patch, and I noticed that it
hasn't been applied or received any feedback.

> ---
> Changes in v2:
>  - Escape backslashes for a couple of additional tests
> 
>  .../testing/selftests/ftrace/test.d/functions |  6 +++---
>  .../test.d/kprobe/kprobe_syntax_errors.tc     | 20 +++++++++----------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 5d4550591ff9..b38c6eb029e8 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -114,11 +114,11 @@ yield() {
>  }
>  
>  ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
> -    pos=$(echo -n "${2%^*}" | wc -c) # error position
> -    command=$(echo "$2" | tr -d ^)
> +    pos=$(printf "${2%^*}" | wc -c) # error position
> +    command=$(printf "$2" | sed -e 's/\^//g' -e 's/%/%%/g' -e 's/\\/\\\\/g')
>      echo "Test command: $command"
>      echo > error_log
> -    (! echo "$command" >> "$3" ) 2> /dev/null
> +    (! printf "$command" >> "$3" ) 2> /dev/null
>      grep "$1: error:" -A 3 error_log
>      N=$(tail -n 1 error_log | wc -c)
>      # "  Command: " and "^\n" => 13
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index ef1e9bafb098..039c03d230b9 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -37,14 +37,14 @@ fi
>  
>  check_error 'p vfs_read ^$none_var'	# BAD_VAR
>  
> -check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
> +check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
>  check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
>  check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
>  
>  grep -q "imm-value" README && \
> -check_error 'p vfs_read arg1=\^x'	# BAD_IMM
> +check_error 'p vfs_read arg1=\\^x'	# BAD_IMM
>  grep -q "imm-string" README && \
> -check_error 'p vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
> +check_error 'p vfs_read arg1=\\"abcd^'	# IMMSTR_NO_CLOSE
>  
>  check_error 'p vfs_read ^+0@0)'		# DEREF_NEED_BRACE
>  check_error 'p vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
> @@ -80,7 +80,7 @@ check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
>  # instruction boundary check is valid on x86 (at this moment)
>  case $(uname -m) in
>    x86_64|i[3456]86)
> -    echo 'p vfs_read' > kprobe_events
> +    printf 'p vfs_read' > kprobe_events
>      if grep -q FTRACE ../kprobes/list ; then
>  	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
>      fi
> @@ -89,13 +89,13 @@ esac
>  
>  # multiprobe errors
>  if grep -q "Create/append/" README && grep -q "imm-value" README; then
> -echo 'p:kprobes/testevent _do_fork' > kprobe_events
> +printf 'p:kprobes/testevent _do_fork' > kprobe_events
>  check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
> -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
> -check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
> -check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
> -check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> -check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
> +printf 'p:kprobes/testevent _do_fork abcd=\\1' > kprobe_events
> +check_error 'p:kprobes/testevent _do_fork ^bcd=\\1'	# DIFF_ARG_TYPE
> +check_error 'p:kprobes/testevent _do_fork ^abcd=\\1:u8'	# DIFF_ARG_TYPE
> +check_error 'p:kprobes/testevent _do_fork ^abcd=\\"foo"'# DIFF_ARG_TYPE
> +check_error '^p:kprobes/testevent _do_fork abcd=\\1'	# SAME_PROBE
>  fi
>  
>  exit 0
> -- 
> 2.25.0
> 
