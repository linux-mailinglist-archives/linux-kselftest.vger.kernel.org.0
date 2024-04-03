Return-Path: <linux-kselftest+bounces-7015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B7896080
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BA82838EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B37EF;
	Wed,  3 Apr 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DSUzGqBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DE36C
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102948; cv=none; b=kFluTRo8Scwfuh0juFUrJIdQHKjeU0Y44jJBPCvXBv46DgwucTIDv6DYJaxUbbHUNydK6eUNnQkcePAL2UtsUeZ9VMdtqpPE7qkKA2o+Qu4s31QIeNeCsyyZqD/b6u8ZBJhfXR93mdOcZH7WPQlSB23Pn/g/k0KkuRiM0MEcXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102948; c=relaxed/simple;
	bh=7AQb9E7tIyeR5THwZTMYND1RtsI0Xy8x3rHSNWDGSrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2NVFh8xWCd7rSoAkXmfBh/kcrFkcYrAB5RDU6hWXN+ZZsnBuwAClRus9YOGwygAnraV9xWtRqCKfz7eM6tVP0jYDQ3AcIC/6dpKs7wJv3Ri5M9n5e+2LlGwUIicfsNdRGA0Rp9cmkzdt7DqhDv0YofIJJkHpGc70s3s+JfTFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DSUzGqBo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e267238375so3018745ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 17:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712102945; x=1712707745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ma+9jmpPIrI0CqMynx6TWxGcB1iPmbIgWEOC5eOGVm4=;
        b=DSUzGqBooTmKFVwMQ+4Y3lcPJbOdGlweKbHrRtuV1xHe5AtM03/sckLnLPGUQw2iLm
         0t5sjTl9DAEMx1lj3y4DdpJUyDx/DzInYWpw10XviJ6sqXQCRKQG36HS0q/xn6UE6hAu
         kDY3PoXg1rkDoSnvSnl3vKV7gyDeIWvusibcA7rVeP4jluhI1LAb2AqSQVdU2wyt7Z/Z
         /uxxgRcVfkzicVTsXqy679ipqesZnyAos0WRGx1Da2V+w3xWREuBfpvWUf1PG0D8c+6g
         3rl4FzVKIivghrpAQ3ThKj12Fw4b5huY7Yprr1MYEteV+urk3pg39ffmY/VQWwsjwr1E
         NjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712102945; x=1712707745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+9jmpPIrI0CqMynx6TWxGcB1iPmbIgWEOC5eOGVm4=;
        b=Ce77gtj0YtUPgPvzs9ZKN31Fh8lXk2GzmtNeQl2+U1MtxOdhcjpFDgGie5t7+9YLiA
         fEc/l75IPZhk7Q6MStavUVohGDUaIjkHRTHxEWX5xeRDgHbJdFR3YxMj1E+KLhkSnwwz
         n7+zKIWs7uAIqAB7hl+2eeNgjxnm+OozndVEBGfbUs3ZoEYIcmmjXvQi0Uia7Xzpcxvy
         Wrp2SJHgP5PaWZZVhjWPtel9Bxznv8jHpFurOk6R2Qm/dEK+lBnia/WGnppyQm1+N/Tr
         xE0PqXSgum2JmvakCtmkH7nTkk2A+RL94v1X+4mJWOwChKhXhuH85AY3bUXKROLyOkvQ
         mxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHJM4zMEQFN3gFBSDjLLuNpq0QKFwNfP9VpRhIjN5Uf5PkH84ybKwCPf2LHZyBh1v1cH//2CAqa31lSZ1LqNStP5TWRjTDQrRpzyWnLdPT
X-Gm-Message-State: AOJu0YzrKRJYE5oVo+5Q8d28CfBpm+MEV6KLjY3gCmECGOBdQfi7Tdeq
	QddAtTh6Vopv0nouS7vJJ/WB9grYafpH3Ygxxi545Xnvm7dUzAxEMa1rRQVn6VI=
X-Google-Smtp-Source: AGHT+IFSzOAmaO/x8qtYXp1l0zpsM42EVF0i6EanFn32Y69wkvpRozXUsGTfzlAS98chD2JFGkmWrg==
X-Received: by 2002:a17:903:32c8:b0:1e0:b628:a752 with SMTP id i8-20020a17090332c800b001e0b628a752mr1349035plr.7.1712102945308;
        Tue, 02 Apr 2024 17:09:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::7:f97b])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b001e2616fb7a9sm2875474pls.231.2024.04.02.17.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 17:09:05 -0700 (PDT)
Message-ID: <c9362778-6bf7-43ea-8730-b9399349e4d6@davidwei.uk>
Date: Tue, 2 Apr 2024 17:09:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] selftests: net: add scaffolding for Netlink
 tests in Python
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-4-kuba@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240402010520.1209517-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-01 18:05, Jakub Kicinski wrote:
> Add glue code for accessing the YNL library which lives under
> tools/net and YAML spec files from under Documentation/.
> Automatically figure out if tests are run in tree or not.
> Since we'll want to use this library both from net and
> drivers/net test targets make the library a target as well,
> and automatically include it when net or drivers/net are
> included. Making net/lib a target ensures that we end up
> with only one copy of it, and saves us some path guessing.
> 
> Add a tiny bit of formatting support to be able to output KTAP
> from the start.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/Makefile              |  7 ++
>  tools/testing/selftests/net/lib/Makefile      |  8 ++
>  .../testing/selftests/net/lib/py/__init__.py  |  6 ++
>  tools/testing/selftests/net/lib/py/consts.py  |  9 ++
>  tools/testing/selftests/net/lib/py/ksft.py    | 96 +++++++++++++++++++
>  tools/testing/selftests/net/lib/py/utils.py   | 47 +++++++++
>  tools/testing/selftests/net/lib/py/ynl.py     | 49 ++++++++++
>  7 files changed, 222 insertions(+)
>  create mode 100644 tools/testing/selftests/net/lib/Makefile
>  create mode 100644 tools/testing/selftests/net/lib/py/__init__.py
>  create mode 100644 tools/testing/selftests/net/lib/py/consts.py
>  create mode 100644 tools/testing/selftests/net/lib/py/ksft.py
>  create mode 100644 tools/testing/selftests/net/lib/py/utils.py
>  create mode 100644 tools/testing/selftests/net/lib/py/ynl.py
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e1504833654d..0cffdfb4b116 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -116,6 +116,13 @@ TARGETS += zram
>  TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
> +# Networking tests want the net/lib target, include it automatically
> +ifneq ($(filter net ,$(TARGETS)),)
> +ifeq ($(filter net/lib,$(TARGETS)),)

style nit: consistency in spacing

> +	override TARGETS := $(TARGETS) net/lib
> +endif
> +endif
> +
>  # User can optionally provide a TARGETS skiplist.  By default we skip
>  # BPF since it has cutting edge build time dependencies which require
>  # more effort to install.
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> new file mode 100644
> index 000000000000..5730682aeffb
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_FILES := ../../../../../Documentation/netlink/s*
> +TEST_FILES += ../../../../net/*
> +
> +TEST_INCLUDES := $(wildcard py/*.py)
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> new file mode 100644
> index 000000000000..81a8d14b68f0
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from .ksft import *
> +from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
> +from .consts import KSRC
> +from .utils import *

style nit: sort alphabetically

> diff --git a/tools/testing/selftests/net/lib/py/consts.py b/tools/testing/selftests/net/lib/py/consts.py
> new file mode 100644
> index 000000000000..f518ce79d82c
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/consts.py
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import sys
> +from pathlib import Path
> +
> +KSFT_DIR = (Path(__file__).parent / "../../..").resolve()
> +KSRC = (Path(__file__).parent / "../../../../../..").resolve()
> +
> +KSFT_MAIN_NAME = Path(sys.argv[0]).with_suffix("").name
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> new file mode 100644
> index 000000000000..7c296fe5e438
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import builtins
> +from .consts import KSFT_MAIN_NAME
> +
> +KSFT_RESULT = None
> +
> +
> +class KsftSkipEx(Exception):
> +    pass
> +
> +
> +class KsftXfailEx(Exception):
> +    pass
> +
> +
> +def ksft_pr(*objs, **kwargs):
> +    print("#", *objs, **kwargs)
> +
> +
> +def ksft_eq(a, b, comment=""):
> +    global KSFT_RESULT
> +    if a != b:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "!=", b, comment)
> +
> +
> +def ksft_true(a, comment=""):
> +    global KSFT_RESULT
> +    if not a:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "does not eval to True", comment)
> +
> +
> +def ksft_in(a, b, comment=""):
> +    global KSFT_RESULT
> +    if a not in b:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "not in", b, comment)
> +
> +
> +def ksft_ge(a, b, comment=""):
> +    global KSFT_RESULT
> +    if a < b:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "<", b, comment)
> +
> +
> +def ktap_result(ok, cnt=1, case="", comment=""):
> +    res = ""
> +    if not ok:
> +        res += "not "
> +    res += "ok "
> +    res += str(cnt) + " "
> +    res += KSFT_MAIN_NAME
> +    if case:
> +        res += "." + str(case.__name__)
> +    if comment:
> +        res += " # " + comment
> +    print(res)
> +
> +
> +def ksft_run(cases):
> +    totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
> +
> +    print("KTAP version 1")
> +    print("1.." + str(len(cases)))
> +
> +    global KSFT_RESULT
> +    cnt = 0
> +    for case in cases:
> +        KSFT_RESULT = True
> +        cnt += 1
> +        try:
> +            case()
> +        except KsftSkipEx as e:
> +            ktap_result(True, cnt, case, comment="SKIP " + str(e))
> +            totals['skip'] += 1
> +            continue
> +        except KsftXfailEx as e:
> +            ktap_result(True, cnt, case, comment="XFAIL " + str(e))
> +            totals['xfail'] += 1
> +            continue
> +        except Exception as e:
> +            for line in str(e).split('\n'):
> +                ksft_pr("Exception|", line)
> +            ktap_result(False, cnt, case)
> +            totals['fail'] += 1
> +            continue
> +
> +        ktap_result(KSFT_RESULT, cnt, case)
> +        totals['pass'] += 1
> +
> +    print(
> +        f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
> +    )
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> new file mode 100644
> index 000000000000..f0d425731fd4
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json as _json
> +import subprocess
> +
> +class cmd:
> +    def __init__(self, comm, shell=True, fail=True, ns=None, background=False):
> +        if ns:
> +            if isinstance(ns, NetNS):
> +                ns = ns.name
> +            comm = f'ip netns exec {ns} ' + comm
> +
> +        self.stdout = None
> +        self.stderr = None
> +        self.ret = None
> +
> +        self.comm = comm
> +        self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
> +                                     stderr=subprocess.PIPE)
> +        if not background:
> +            self.process(terminate=False, fail=fail)
> +
> +    def process(self, terminate=True, fail=None):
> +        if terminate:
> +            self.proc.terminate()
> +        stdout, stderr = self.proc.communicate()
> +        self.stdout = stdout.decode("utf-8")
> +        self.stderr = stderr.decode("utf-8")
> +        self.proc.stdout.close()
> +        self.proc.stderr.close()
> +        self.ret = self.proc.returncode
> +
> +        if self.proc.returncode != 0 and fail:
> +            if len(stderr) > 0 and stderr[-1] == "\n":
> +                stderr = stderr[:-1]
> +            raise Exception("Command failed: %s\n%s" % (self.proc.args, stderr))
> +
> +
> +def ip(args, json=None, ns=None):
> +    cmd_str = "ip "
> +    if json:
> +        cmd_str += '-j '
> +    cmd_str += args
> +    cmd_obj = cmd(cmd_str, ns=ns)
> +    if json:
> +        return _json.loads(cmd_obj.stdout)
> +    return cmd_obj
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> new file mode 100644
> index 000000000000..298bbc6b93c5
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import sys
> +from pathlib import Path
> +from .consts import KSRC, KSFT_DIR
> +from .ksft import ksft_pr, ktap_result
> +
> +# Resolve paths
> +try:
> +    if (KSFT_DIR / "kselftest-list.txt").exists():
> +        # Running in "installed" selftests
> +        tools_full_path = KSFT_DIR
> +        SPEC_PATH = KSFT_DIR / "net/lib/specs"
> +
> +        sys.path.append(tools_full_path.as_posix())
> +        from net.lib.ynl.lib import YnlFamily, NlError
> +    else:
> +        # Running in tree
> +        tools_full_path = Path(KSRC) / "tools"
> +        SPEC_PATH = Path(KSRC) / "Documentation/netlink/specs"
> +
> +        sys.path.append(tools_full_path.as_posix())
> +        from net.ynl.lib import YnlFamily, NlError
> +except ModuleNotFoundError as e:
> +    ksft_pr("Failed importing `ynl` library from kernel sources")
> +    ksft_pr(str(e))
> +    ktap_result(True, comment="SKIP")
> +    sys.exit(4)
> +
> +#
> +# Wrapper classes, loading the right specs
> +# Set schema='' to avoid jsonschema validation, it's slow
> +#
> +class EthtoolFamily(YnlFamily):
> +    def __init__(self):
> +        super().__init__((SPEC_PATH / Path('ethtool.yaml')).as_posix(),
> +                         schema='')
> +
> +
> +class RtnlFamily(YnlFamily):
> +    def __init__(self):
> +        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
> +                         schema='')
> +
> +
> +class NetdevFamily(YnlFamily):
> +    def __init__(self):
> +        super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
> +                         schema='')

