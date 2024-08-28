Return-Path: <linux-kselftest+bounces-16554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027E962AFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 17:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FEF284FDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979D8187854;
	Wed, 28 Aug 2024 15:01:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FE1DFCF;
	Wed, 28 Aug 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857268; cv=none; b=DwtYRfKMocJ0lsHlMd7HGQ9Jk4ayQ0mGXLvb2T9+IwozWQtV20eaksOx3LwpFmggzLkP/DMu6oGB/ka+IPahZokaw9Z9rNrb95jWv2pzig61OtpJhbir/rSHVIuVOrgybwA3r6JiEGsVYCugL2jVGlHh68tgt09UsXailEFdShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857268; c=relaxed/simple;
	bh=kvTnfwbFcVYhgjb43qUgVocpt20fPREGtLA+Nw/HJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fryUrqJ/+p8qtak6QedkpDS4XZz9jl81tO/vUxv/t0plh3JZ5C5WhzLU5cKpAUd707IuzAAP3mjlEzepWyJ9kDmFPydCwkcfoknzQZI+wHUaIsh0G0mGpk+a3N7MZXFFthzgc+7rNTFP9w7Wy/76yHfuK8OrNaTDSxRVcno/cCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2023dd9b86aso54456135ad.1;
        Wed, 28 Aug 2024 08:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857266; x=1725462066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D63aBFm/ec4YC7NVLplUfaX+TiG3d1K7llWnJbc0KwE=;
        b=hRB4hWr2dKrkQQdRKnEwKcirwAINPiiQf2IkL5hJdH55t+Vhav752pO7V7SZQVM8yP
         A6lpGbmOprw/v/b7pXmHaSOkRCvWMNqMxJHOwSZmyN6XDgstcR21qV4hEF1M8QY1jCSW
         mZ4UGpDHlqr6sJkqSJXhXsENVhaisq3tUPlO2G/2LOw109lU5ub8ohRws1wkgpIpKq+H
         t3AMFxzGduAG/Dt6Jxpp7XT8ZFsexOhktw7YDyXeaTClnInGFEAUscTZcrLP67A1LkIH
         sCnZx3BsHbJ7xeHYM14r8U7JA9LJWBte3NOAfgYuMMmoPQ2npuKfegOnYFtbWHzA1Vpt
         qMFA==
X-Forwarded-Encrypted: i=1; AJvYcCVNN9BqKKzFQHR7CJywwM8N6apWEj5mw0+e/VaW5CCr8qszYX1BDcdxzNX9mD8flp8a8mgtBnbJ7kYW6MHBK34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVPk6zdJJhgZ3N6E6PnU6XsQQQ6HVIrKN5PGAzvJF1MFLCHja
	r/ZhIhpz8b1QYhf1KWu3Kc7LpUCLUFMxT3xzpeK0O7R+gR6PmfI=
X-Google-Smtp-Source: AGHT+IGevCgxxB4jl5QbM8gi+8rq4ssbS3kXFtURkut1orK3flHzn263mXyvDttRLgi2hYSWbEE3Xw==
X-Received: by 2002:a17:903:2288:b0:202:4666:f02a with SMTP id d9443c01a7336-2039e50d2c0mr165740745ad.43.1724857263835;
        Wed, 28 Aug 2024 08:01:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae7b1bsm99382585ad.262.2024.08.28.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:01:03 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:01:02 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, ncardwell@google.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <Zs87rhH9e_Lw-icJ@mini-arch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>

On 08/27, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
> 
> Florian recently added support for packetdrill tests in nf_conntrack,
> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> conntrack tests").
> 
> This patch takes a slightly different implementation and reuses the
> ksft python library for its KTAP, ksft, NetNS and other such tooling.
> 
> It also anticipates the large number of testcases, by creating a
> separate kselftest for each feature (directory). It does this by
> copying the template script packetdrill_ksft.py for each directory,
> and putting those in TEST_CUSTOM_PROGS so that kselftests runs each.
> 
> To demonstrate the code with minimal patch size, initially import only
> two features/directories from github. One with a single script, and
> one with two. This was the only reason to pick tcp/inq and tcp/md5.
> 
> Any future imports of packetdrill tests should require no additional
> coding. Just add the tcp/$FEATURE directory with *.pkt files.
> 
> Implementation notes:
> - restore alphabetical order when adding the new directory to
>   tools/testing/selftests/Makefile
> - copied *.pkt files and support verbatim from the github project,
>   except for
>     - update common/defaults.sh path (there are two paths on github)
>     - add SPDX headers
>     - remove one author statement
>     - Acknowledgment: drop an e (checkpatch)
> 
> Tested:
> 	make -C tools/testing/selftests/ \
> 	  TARGETS=net/packetdrill \
> 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> 
> 	# in virtme-ng
> 	sudo ./run_kselftest.sh -c net/packetdrill
> 	sudo ./run_kselftest.sh -t net/packetdrill:tcp_inq.py
> 
> Result:
> 	kselftest: Running tests in net/packetdrill
> 	TAP version 13
> 	1..2
> 	# timeout set to 45
> 	# selftests: net/packetdrill: tcp_inq.py
> 	# KTAP version 1
> 	# 1..4
> 	# ok 1 tcp_inq.client-v4
> 	# ok 2 tcp_inq.client-v6
> 	# ok 3 tcp_inq.server-v4
> 	# ok 4 tcp_inq.server-v6
> 	# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	ok 1 selftests: net/packetdrill: tcp_inq.py
> 	# timeout set to 45
> 	# selftests: net/packetdrill: tcp_md5.py
> 	# KTAP version 1
> 	# 1..2
> 	# ok 1 tcp_md5.md5-only-on-client-ack-v4
> 	# ok 2 tcp_md5.md5-only-on-client-ack-v6
> 	# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	ok 2 selftests: net/packetdrill: tcp_md5.py
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> RFC points for discussion
> 
> ksft: the choice for this python framework introduces a dependency on
> the YNL scripts, and some non-obvious code:
> - to include the net/lib dep in tools/testing/selftests/Makefile
> - a boilerplate lib/py/__init__.py that each user of ksft will need
> It seems preferable to me to use ksft.py over reinventing the wheel,
> e.g., to print KTAP output. But perhaps we can make it more obvious
> for future ksft users, and make the dependency on YNL optional.
> 
> kselftest-per-directory: copying packetdrill_ksft.py to create a
> separate script per dir is a bit of a hack. A single script is much
> simpler, optionally with nested KTAP (not supported yet by ksft). But,
> I'm afraid that running time without intermediate output will be very
> long when we integrate all packetdrill scripts.
> 
> nf_conntrack: we can dedup the common.sh.
> 
> *pkt files: which of the 150+ scripts on github are candidates for
> kselftests, all or a subset? To avoid change detector tests. And what
> is the best way to eventually send up to 150 files, 7K LoC.
> ---
>  tools/testing/selftests/Makefile              |  7 +-
>  .../selftests/net/packetdrill/.gitignore      |  1 +
>  .../selftests/net/packetdrill/Makefile        | 28 ++++++
>  .../net/packetdrill/lib/py/__init__.py        | 15 ++++
>  .../net/packetdrill/packetdrill_ksft.py       | 90 +++++++++++++++++++
>  .../net/packetdrill/tcp/common/defaults.sh    | 63 +++++++++++++
>  .../net/packetdrill/tcp/common/set_sysctls.py | 38 ++++++++
>  .../net/packetdrill/tcp/inq/client.pkt        | 51 +++++++++++
>  .../net/packetdrill/tcp/inq/server.pkt        | 51 +++++++++++
>  .../tcp/md5/md5-only-on-client-ack.pkt        | 28 ++++++
>  10 files changed, 369 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/net/packetdrill/.gitignore
>  create mode 100644 tools/testing/selftests/net/packetdrill/Makefile
>  create mode 100644 tools/testing/selftests/net/packetdrill/lib/py/__init__.py
>  create mode 100755 tools/testing/selftests/net/packetdrill/packetdrill_ksft.py
>  create mode 100755 tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh
>  create mode 100755 tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp/inq/client.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp/inq/server.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp/md5/md5-only-on-client-ack.pkt
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index a5f1c0c27dff9..f03d6fee7ac54 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -65,10 +65,11 @@ TARGETS += net/af_unix
>  TARGETS += net/forwarding
>  TARGETS += net/hsr
>  TARGETS += net/mptcp
> -TARGETS += net/openvswitch
> -TARGETS += net/tcp_ao
>  TARGETS += net/netfilter
> +TARGETS += net/openvswitch
> +TARGETS += net/packetdrill
>  TARGETS += net/rds
> +TARGETS += net/tcp_ao
>  TARGETS += nsfs
>  TARGETS += perf_events
>  TARGETS += pidfd
> @@ -122,7 +123,7 @@ TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
>  # Networking tests want the net/lib target, include it automatically
> -ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> +ifneq ($(filter net net/packetdrill drivers/net drivers/net/hw,$(TARGETS)),)
>  ifeq ($(filter net/lib,$(TARGETS)),)
>  	INSTALL_DEP_TARGETS := net/lib
>  endif
> diff --git a/tools/testing/selftests/net/packetdrill/.gitignore b/tools/testing/selftests/net/packetdrill/.gitignore
> new file mode 100644
> index 0000000000000..a40f1a600eb94
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/.gitignore
> @@ -0,0 +1 @@
> +tcp*sh
> diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
> new file mode 100644
> index 0000000000000..d94c51098d1f0
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/Makefile
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# KSFT includes
> +TEST_INCLUDES := $(wildcard lib/py/*.py ../lib/py/*.py)
> +
> +# Packetdrill support file(s)
> +TEST_INCLUDES += tcp/common/defaults.sh
> +TEST_INCLUDES += tcp/common/set_sysctls.py
> +
> +# Packetdrill scripts: all .pkt in subdirectories
> +TEST_INCLUDES += $(wildcard tcp/**/*.pkt)
> +
> +# Create a separate ksft test for each subdirectory
> +# Running all packetdrill tests in one go will take too long
> +#
> +# For each tcp/$subdir, create a test script tcp_$subdir.py
> +# Exclude tcp/common, which is a helper directory
> +TEST_DIRS := $(wildcard tcp/*)
> +TEST_DIRS := $(filter-out tcp/common, $(TEST_DIRS))
> +TEST_CUSTOM_PROGS := $(foreach dir,$(TEST_DIRS),$(subst /,_,$(dir)).py)
> +
> +$(TEST_CUSTOM_PROGS) : packetdrill_ksft.py
> +	cp $< $@
> +
> +# Needed to generate all TEST_CUSTOM_PROGS
> +all: $(TEST_CUSTOM_PROGS)
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/net/packetdrill/lib/py/__init__.py b/tools/testing/selftests/net/packetdrill/lib/py/__init__.py
> new file mode 100644
> index 0000000000000..51bb6dda43d65
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/lib/py/__init__.py
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import pathlib
> +import sys
> +
> +KSFT_DIR = (pathlib.Path(__file__).parent / "../../../..").resolve()
> +
> +try:
> +    sys.path.append(KSFT_DIR.as_posix())
> +    from net.lib.py import *
> +except ModuleNotFoundError as e:
> +    ksft_pr("Failed importing `net` library from kernel sources")
> +    ksft_pr(str(e))
> +    ktap_result(True, comment="SKIP")
> +    sys.exit(4)
> diff --git a/tools/testing/selftests/net/packetdrill/packetdrill_ksft.py b/tools/testing/selftests/net/packetdrill/packetdrill_ksft.py
> new file mode 100755
> index 0000000000000..62572a5b8331c
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/packetdrill_ksft.py
> @@ -0,0 +1,90 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Run packetdrill tests in the ksft harness.
> +
> +   Run all packetdrill tests in a subdirectory.
> +   Detect the relevant subdirectory from this script name.
> +   (Because the script cannot be given arguments.)
> +
> +   Run each test, for both IPv4 and IPv6.
> +   Return a separate ksft result for each test case.
> +"""
> +
> +import glob
> +import os
> +import pathlib
> +import shutil
> +
> +from lib.py import cmd, ksft_exit, ksft_run, KsftSkipEx, NetNS
> +
> +
> +def test_func_builder(pktfile_path, ipv4):
> +    """Create a function that can be passed to ksft_run."""
> +
> +    def f():
> +        if ipv4:
> +            args = ("--ip_version=ipv4 "
> +                    "--local_ip=192.168.0.1 "
> +                    "--gateway_ip=192.168.0.1 "
> +                    "--netmask_ip=255.255.0.0 "
> +                    "--remote_ip=192.0.2.1 "
> +                    "-D CMSG_LEVEL_IP=SOL_IP "
> +                    "-D CMSG_TYPE_RECVERR=IP_RECVERR "
> +                    )
> +        else:
> +            args = ("--ip_version=ipv6 --mtu=1520 "
> +                    "--local_ip=fd3d:0a0b:17d6::1 "
> +                    "--gateway_ip=fd3d:0a0b:17d6:8888::1 "
> +                    "--remote_ip=fd3d:fa7b:d17d::1 "
> +                    "-D CMSG_LEVEL_IP=SOL_IPV6 "
> +                    "-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
> +                    )
> +
> +        if not shutil.which("packetdrill"):
> +            raise KsftSkipEx("Cannot find packetdrill")

I don't see anything about building the binary itself. Am I missing
something or should we also have some makefile magic to do it?
I'm not sure packetdrill is packaged by the distros... Presumably
we want the existing NIPA runners to run those tests as well?

> +
> +        netns = NetNS()
> +
> +        # Call packetdrill from the directory hosting the .pkt script,
> +        # because scripts can have relative includes.
> +        savedir = os.getcwd()
> +        os.chdir(os.path.dirname(pktfile_path))
> +        basename = os.path.basename(pktfile_path)
> +        cmd(f"packetdrill {args} {basename}", ns=netns)
> +        os.chdir(savedir)
> +
> +    if ipv4:
> +        f.__name__ = pathlib.Path(pktfile_path).stem + "-v4"
> +    else:
> +        f.__name__ = pathlib.Path(pktfile_path).stem + "-v6"

What about dualstack v4-over-v6 mode? Do we want to support that as
well?

